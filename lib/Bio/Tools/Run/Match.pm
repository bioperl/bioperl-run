# $Id: Match.pm,v 1.3 2007/05/25 10:14:55 sendu Exp $
#
# BioPerl module for Bio::Tools::Run::Match
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

Bio::Tools::Run::Match - Wrapper for Transfac's match(TM)

=head1 SYNOPSIS

  use Bio::Tools::Run::Match;

  # Make a Match factory
  $factory = Bio::Tools::Run::Match->new(-mxlib => '/path/to/matrix.dat');

  # Run Match on an sequence object
  my @results = $factory->run($bio_seq);

  # look at the results
  foreach my $feat (@results) {
    my $seq_id = $feat->seq_id;
    my $start = $feat->start;
    my $end = $feat->end;
    my $score = $feat->score;
    my ($pvalue) = $feat->get_tag_values('pvalue');
  }

=head1 DESCRIPTION

This is a wrapper for running the match(TM) program supplied with Transfac Pro
distributions.

You can try supplying normal match command-line arguments to new(), eg.
new(-b => 1) or calling arg-named methods (excluding the initial
hyphens, eg. $factory->b(1) to set the -b option to true).

Histogram output isn't supported. -p is supported by using -mxprf, see the
docs of new() for details.

You will need to enable this match wrapper to find the match executable.
This can be done in (at least) three ways:

 1. Make sure match is in your path.
 2. Define an environmental variable MATCHDIR which is a 
    directory which contains the match executable:
    In bash:

    export MATCHDIR=/home/username/match/

    In csh/tcsh:

    setenv MATCHDIR /home/username/match

 3. Include a definition of an environmental variable MATCHDIR in
    every script that will use this match wrapper module, e.g.:

    BEGIN { $ENV{MATCHDIR} = '/home/username/match/' }
    use Bio::Tools::Run::Match;

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

package Bio::Tools::Run::Match;
use strict;

use Cwd;
use File::Spec;
use Bio::SeqIO;
use Bio::FeatureIO;
use Bio::Annotation::SimpleValue;
use Bio::Tools::Match;

use base qw(Bio::Tools::Run::WrapperBase);

our $PROGRAM_NAME = 'match';
our $PROGRAM_DIR = $ENV{'MATCHDIR'};

# methods for the match args we support
our @PARAMS   = qw(mxlib mxprf imcut); # these aren't actually match args, but
                                       # are methods we use internally
our @SWITCHES = qw(b u);

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(H HH pp ppg pn png pr jkn i p);


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
 Usage   : $factory = Bio::Tools::Run::Match->new()
 Function: creates a new MCS factory
 Returns : Bio::Tools::Run::MCS
 Args    : The following args can either be supplied here or set by calling
           arg-named methods (eg. $factory->imcut(2) ).

           -mxlib  => path to the matrix.dat file containing Transfac matricies
           -mxprf  => path to a profile file | [core_thresh, [matrix_thresh]]
                      (defaults to a standard one based on the mxlib provided if
                      file not supplied, using core_thresh and matrix_thresh
                      values if those are supplied instead)
           -imcut  => floating point number, the importance cutoff
           -b | -u => boolean, mutually exclusive

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
 Usage   : $result = $factory->run($bio_seqi_object);
 Function: Runs match on a sequence.
 Returns : list of Bio::SeqFeatureI feature objects
 Args    : Bio::SeqI compliant object

           NB: mxlib has to have been set prior to calling run(), either as an
           argument to new() or by calling mxlib().

=cut

sub run {
    my ($self, $seq) = @_;
    $self->mxlib || $self->throw("mxlib has to have been set first");
    
    return $self->_run($seq);
}

sub _run {
    my ($self, $seq) = @_;
    
    my $exe = $self->executable || return;
    
    my $mxlib = File::Spec->rel2abs($self->mxlib());
    my $mxprf_file = $self->mxprf();
    if ($mxprf_file && -e $mxprf_file) {
        $mxprf_file = File::Spec->rel2abs($mxprf_file);
    }
    
    # cd to a temp dir
    my $temp_dir = $self->tempdir;
    my $cwd = Cwd->cwd();
    chdir($temp_dir) || $self->throw("Couldn't change to temp dir '$temp_dir'");
    
    # make the profile file if necessary
    if (! $mxprf_file || ! -e $mxprf_file) {
        my @thresh;
        if ($mxprf_file && ref($mxprf_file) eq 'ARRAY') {
            @thresh = @{$mxprf_file};
        }
        
        $mxprf_file = 'mxprf';
        system("$exe $mxlib ignored ignored $mxprf_file -p @thresh") && $self->throw("Something went wrong whist creating profile: $! | $?");
    }
    
    # output the sequence to a fasta file
    my $seq_file = 'sequence.fa';
    my $so = Bio::SeqIO->new(-file => ">$seq_file", -format => 'fasta');
    $so->write_seq($seq);
    $so->close();
    
    # run match
    my $result_file = 'out';
    my $param_str = $self->_setparams();
    my $cmd_line = "$exe $mxlib $seq_file $result_file $mxprf_file".$param_str;
    
    system($cmd_line) && $self->throw("Something went wrong whist running '$cmd_line': $! | $?");
    
    # parse the results
    my $parser = Bio::Tools::Match->new(-file => $result_file);
    
    # correct the coords
    my @feats;
    while (my $feat = $parser->next_result) {
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
    
    my $param_string = $self->SUPER::_setparams(-switches => \@SWITCHES,
                                                -dash => 1);
    
    $param_string .= ' 1>/dev/null' if $self->quiet;
    
    return $param_string;
}

1;
