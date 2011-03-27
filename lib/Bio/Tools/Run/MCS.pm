# $Id: MCS.pm,v 1.3 2007/05/25 10:14:55 sendu Exp $
#
# BioPerl module for Bio::Tools::Run::MCS
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Sendu Bala <bix@sendu.me.uk>
#
# Copyright Sendu Bala
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::MCS - Wrapper for MCS

=head1 SYNOPSIS

  use Bio::Tools::Run::MCS;

  # Make a MCS factory
  $factory = Bio::Tools::Run::MCS->new();

  # Run MCS on an alignment
  my @results = $factory->run($alignfilename);

  # or with alignment object
  @results = $factory->run($bio_simplalign);

  # look at the results
  foreach my $feat (@results) {
    my $seq_id = $feat->seq_id;
    my $start = $feat->start;
    my $end = $feat->end;
    my $score = $feat->score;
    my ($pvalue) = $feat->get_tag_values('pvalue');
    my ($kind) = $feat->get_tag_values('kind'); # 'all', 'exon' or 'nonexon'
  }

=head1 DESCRIPTION

This is a wrapper for running the MCS (binCons) scripts by Elliott H Margulies.
You can get details here: http://zoo.nhgri.nih.gov/elliott/mcs_doc/. MCS is used
for the prediciton of transcription factor binding sites and other regions of
the genome conserved amongst different species.

Note that this wrapper assumes you already have alignments, so only uses MCS
for the latter stages (the stages involving align2binomial.pl,
generate_phyloMAX_score.pl and generate_mcs_beta.pl).

You can try supplying normal MCS command-line arguments to new(), eg.

  $factory->new(-percentile => 95)

or calling arg-named methods (excluding the initial
hyphens, eg. 

  $factory->percentile(95)

 to set the --percentile arg).


You will need to enable this MCS wrapper to find the MCS scripts.
This can be done in (at least) three ways:

 1. Make sure the MCS scripts are in your path.
 2. Define an environmental variable MCSDIR which is a 
    directory which contains the MCS scripts:
    In bash:

    export MCSDIR=/home/username/mcs/

    In csh/tcsh:

    setenv MCSDIR /home/username/mcs

 3. Include a definition of an environmental variable MCSDIR in
    every script that will use this MCS wrapper module, e.g.:

    BEGIN { $ENV{MCSDIR} = '/home/username/mcs/' }
    use Bio::Tools::Run::MCS;

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Sendu Bala

Email bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::MCS;
use strict;

use Cwd;
use File::Spec;
use Bio::AlignIO;
use Bio::FeatureIO;
use Bio::Annotation::SimpleValue;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'align2binomial.pl';
our $PROGRAM_DIR;

# methods for the mcs args we support
our @PARAMS   = qw(neutral percentile mcs specificity sensitivity name);
our @SWITCHES = qw(neg-score);

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(ucsc gtf neutral-only fourd-align align-only ar);

BEGIN {
    # lets add all the mcs scripts to the path so that when we call
    # align2binomial.pl it can find its siblings
    $PROGRAM_DIR = $ENV{'MCSDIR'};
    $ENV{PATH} = "$PROGRAM_DIR:$ENV{PATH}" if $PROGRAM_DIR;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns : string
 Args    : None

=cut

sub program_name {
    return $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns : string
 Args    : None

=cut

sub program_dir {
    return $PROGRAM_DIR;
}

=head2 new

 Title   : new
 Usage   : $factory = Bio::Tools::Run::MCS->new()
 Function: creates a new MCS factory
 Returns : Bio::Tools::Run::MCS
 Args    : Many options understood by MCS can be supplied as key =>
           value pairs.

           These options can NOT be used with this wrapper:
           ucsc gtf neutral-only fourd-align align-only ar

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => [@PARAMS, @SWITCHES, 'quiet'],
                                  -create => 1);
    
    return $self;
}

=head2 run

 Title   : run
 Usage   : $result = $factory->run($align_file_or_object, Bio::Location::Atomic,
                                   [Bio::SeqFeatureI]);
 Function: Runs the MCS scripts on an alignment.
 Returns : list of Bio::SeqFeatureI feature objects (with coordinates corrected
           according to the supplied offset, if any)
 Args    : The first argument represents an alignment, the optional second
           argument represents the chromosome, stand and end and the optional
           third argument represents annotation of the exons in the alignment.

           The alignment can be provided as a multi-fasta format alignment
           filename, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).

           The position in the genome can be provided as a Bio::Location::Atomic
           with start, end and seq_id set.

           The annnotation can be provided as an array of Bio::SeqFeatureI
           objects.

=cut

sub run {
    my ($self, $aln, $offset, $exon_feats) = @_;
    $self->_alignment($aln || $self->alignment || $self->throw("An alignment must be supplied"));
    
    return $self->_run($offset, $exon_feats);
}

sub _run {
    my ($self, $atomic, $exon_feats) = @_;
    
    my $exe = $self->executable || return;
    
    # cd to a temp dir
    my $temp_dir = $self->tempdir;
    my $cwd = Cwd->cwd();
    chdir($temp_dir) || $self->throw("Couldn't change to temp dir '$temp_dir'");
    
    my $offset = '';
    my $start_adjust = 0;
    if ($atomic) {
        $start_adjust = $atomic->start;
        $offset = '--ucsc '.$atomic->seq_id.':'.$start_adjust.'-'.$atomic->end;
        $start_adjust--;
    }
    
    my $gtf_file = 'exons.gtf';
    if ($exon_feats) {
        my $fout = Bio::FeatureIO->new(-file => ">$gtf_file", -format => 'gtf');
        foreach my $feat (@{$exon_feats}) {
            $fout->write_feature($feat);
        }
    }
    my $gtf = $exon_feats ? "--gtf $gtf_file" : '';
    
    # step '2' (http://zoo.nhgri.nih.gov/elliott/mcs_doc/node1.html) of MCS:
    # run align2binomial.pl to calculate individual species binomial scores
    my $aln_file = $self->_write_alignment;
    my $error_file = 'stderr';
    my $binomial_file = 'align_name.binomial';
    my $cmd = "align2binomial.pl $offset $gtf $aln_file > $binomial_file 2> $error_file";
    #system("rm -fr $cwd/mcs_dir; cp -R $temp_dir $cwd/mcs_dir");
    my $throw = system($cmd);
    open(my $efh, "<", $error_file) || $self->throw("Could not open error file '$error_file'");
    my $error;
    while (<$efh>) {
        $error .= $_;
        $throw = 1 if /not divisible by 3/;
    }
    close($efh);
    $self->throw($error) if $throw;
    
    # step '3': run generate_phyloMAX_score.pl to combine the individual
    # binomial scores and generate the final Multi-species Conservation Score
    my $phylo_file = 'align_name.phylo';
    system("generate_phyloMAX_score.pl $binomial_file > $phylo_file") && $self->throw("generate_phyloMAX_score.pl call failed: $?, $!");
    
    # step '4': Generate MCSs from the conservation score using
    # generate_mcs_beta.pl
    my $mcs_file = 'mcs_result.stdout';
    my $bed_file = 'align_name.bed'; # hardcoded in generate_mcs_beta.pl
    system("generate_mcs_beta.pl $offset $gtf $phylo_file > $mcs_file") && $self->throw("generate_mcs_beta.pl failed: $?, $!");
    
    my @feats;
    my $fin = Bio::FeatureIO->new(-file => $bed_file, -format => 'bed');
    my $source = Bio::Annotation::SimpleValue->new(-value => 'MCS');
    while (my $feat = $fin->next_feature()) {
        # convert coords given offset
        if ($start_adjust) {
            $feat->start($feat->start + $start_adjust);
            $feat->end($feat->end + $start_adjust);
        }
        $feat->source($source);
        push(@feats, $feat);
    }
    
    # cd back again
    chdir($cwd) || $self->throw("Couldn't change back to working directory '$cwd'");
    
    return @feats;
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : none

=cut

sub _setparams {
    my $self = shift;
    
    my $param_string = $self->SUPER::_setparams(-params => \@PARAMS,
                                           -switches => \@SWITCHES,
                                           -dash => 1);
    
    $param_string .= ' 1>/dev/null' if $self->quiet;
    
    return $param_string;
}

1;
