# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Phast::PhastCons
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

Bio::Tools::Run::Phylo::Phast::PhastCons - Wrapper for footprinting using
                                           phastCons

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Phast::PhastCons;

  # Make a PhastCons factory
  $factory = Bio::Tools::Run::Phylo::Phast::PhastCons->new();

  # Pass the factory an alignment and the corresponding species tree
  $align_filename = 't/data/apes.multi_fasta';
  $species_tree_filename = 't/data/apes.newick';
  @features = $factory->run($align_filename, $species_tree_filename);

  # or get a Bio::Align::AlignI (SimpleAlign) object from somewhere, and
  # generate the species tree automatically using a Bio::DB::Taxonomy database
  $tdb = Bio::DB::Taxonomy->new(-source => 'entrez');
  @features = $factory->run($aln_obj, $tdb);

  # @features is an array of Bio::SeqFeature::Annotated, one feature per
  # alignment sequence and prediction

=head1 DESCRIPTION

This is a wrapper for running the phastCons application by Adam Siepel. You
can get details here: http://compgen.bscb.cornell.edu/~acs/software.html 
phastCons is used for phylogenetic footprinting/ shadowing.

Currently the interface is extremely simplified, allowing only one
analysis method. The focus here is on ease of use, allowing phastCons
to estimate as many parameters as possible and having it output just
the 'most conserved' blocks it detects. You can, however, try
supplying normal phastCons arguments to new(), or calling arg-named
methods (excluding initial hyphens and converting others to
underscores, eg. $factory-E<gt>indels_only(1) to set the --indels-only
arg).

The particular analysis carried out here is to:

 1. Use phyloFit to generate a tree model for initialization of the nonconserved
    model from the supplied alignment (all data) and species tree
 2. Run phastCons in 'training' mode for parameter estimation using all the
    alignment data and the model from step 1
 3. Run phastCons with the trees from step 2 to discover the most conserved
    regions

See the 'HowTo' at http://compgen.bscb.cornell.edu/~acs/phastCons-HOWTO.html 
for details on how to improve results.

WARNING: the API is likely to change in the future to allow for alternative
analysis types.

You will need to enable this phastCons wrapper to find the phast programs (at
least phastCons and phyloFit).
This can be done in (at least) three ways:

 1. Make sure the phastCons and phyloFit executables are in your path.
 2. Define an environmental variable PHASTDIR which is a 
    directory which contains the phastCons and phyloFit applications:
    In bash:

    export PHASTDIR=/home/username/phast/bin

    In csh/tcsh:

    setenv PHASTDIR /home/username/phast/bin

 3. Include a definition of an environmental variable PHASTDIR in
    every script that will use this PhastCons wrapper module, e.g.:

    BEGIN { $ENV{PHASTDIR} = '/home/username/phast/bin' }
    use Bio::Tools::Run::Phylo::Phast::PhastCons;

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

package Bio::Tools::Run::Phylo::Phast::PhastCons;
use strict;

use Cwd;
use File::Basename;
use Clone qw(clone);
use Bio::AlignIO;
use Bio::Tools::Run::Phylo::Phast::PhyloFit;
use Bio::FeatureIO;
use Bio::Annotation::SimpleValue;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'phastCons';
our $PROGRAM_DIR = $ENV{'PHASTDIR'};

# methods and their synonyms from the phastCons args we support
our %PARAMS   = (rho => 'R',
                 nrates => 'k',
                 transitions => 't',
                 target_coverage => 'C',
                 expected_length => ['E', 'expected_lengths'],
                 lnl => 'L',
                 log => 'g',
                 max_micro_indel => 'Y',
                 indel_params => 'D',
                 lambda => 'l',
                 extrapolate => 'e',
                 hmm => 'H',
                 catmap => 'c',
                 states => 'S',
                 reflect_strand => 'U',
                 require_informative => 'M',
                 not_informative => 'F');

our %SWITCHES = (quiet => 'q',
                 indels => 'I',
                 indels_only => 'J',
                 FC => 'X',
                 coding_potential => 'p',
                 ignore_missing => 'z');

# just to be explicit, args we don't support (yet) or we handle ourselves
our %UNSUPPORTED = (estimate_trees => 'T',
                    estimate_rho => 'O',
                    gc => 'G',
                    msa_format => 'i',
                    score => 's',
                    no_post_probs => 'n',
                    seqname => 'N',
                    refidx => 'r',
                    idpref => 'P',
                    help => 'h',
                    alias => 'A',
                    most_conserved => ['V', 'viterbi']);


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
 Usage   : $factory = Bio::Tools::Run::Phylo::Phast::PhastCons->new(@params)
 Function: Creates a new PhastCons factory
 Returns : Bio::Tools::Run::Phylo::Phast::PhastCons
 Args    : Optionally, provide any of the following (defaults are not to use,
           see the same-named methods for information on what each option does):
           {
            -target_coverage  => number between 0 and 1
            AND
            -expected_length  => int
           }
           -rho => number between 0 and 1
           -quiet => boolean (turn on or off program output to console)

           Most other options understood by phastCons can be supplied as key =>
           value pairs in this way. Options that don't normally take a value
           should be given a value of 1. You can type the keys as you would on
           the command line (eg. '--indels-only' => 1) or with only a single
           hyphen to start and internal hyphens converted to underscores (eg.
           -indels_only => 1) to avoid having to quote the key.

           These options can NOT be used with this wrapper currently:
           estimate_trees / T
           estimate_rho / O
           gc / G
           msa_format / i
           score / s
           no_post_probs / n
           seqname / N
           idpref / P
           help / h
           alias / A
           most_conserved / V / viterbi
           refidx / r

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => {(map { $_ => $PARAMS{$_} } keys %PARAMS),
                                               (map { $_ => $SWITCHES{$_} } keys %SWITCHES)},
                                  -create => 1);
    
    return $self;
}

=head2 target_coverage

 Title   : target_coverage
 Usage   : $factory->target_coverage(0.25);
 Function: Constrain transition parameters such that the expected fraction of
           sites in conserved elements is the supplied value.
 Returns : number (default undef)
 Args    : None to get, number (between 0 and 1) to set

=cut

sub target_coverage {
    my ($self, $num) = @_;
    if (defined ($num)) {
        ($num > 0 && $num < 1) || $self->throw("target_coverage value must be between 0 and 1, exclusive");
        $self->{coverage} = $num;
    }
    return $self->{coverage} || return;
}

=head2 expected_length

 Title   : expected_length
 Usage   : $factory->expected_length(5);
 Function: Set transition probabilities such that the expected length of a
           conserved element is the supplied value. target_coverage() must also
           be set.
 Returns : int (default undef)
 Args    : None to get, int to set

=cut

# created automatically

=head2 rho

 Title   : rho
 Usage   : $factory->rho(0.3);
 Function: Set the *scale* (overall evolutionary rate) of the model for the
           conserved state to be the supplied number times that of the model for
           the non-conserved state (default 0.3).
 Returns : number (default undef)
 Args    : None to get, number (between 0 and 1) to set

=cut

sub rho {
    my ($self, $num) = @_;
    if (defined ($num)) {
        ($num > 0 && $num < 1) || $self->throw("rho value must be between 0 and 1, exclusive");
        $self->{rho} = $num;
    }
    return $self->{rho} || return;
}

=head2 run

 Title   : run
 Usage   : $result = $factory->run($fasta_align_file, $newick_tree_file);
           -or-
           $result = $factory->run($align_object, $tree_object);
           -or-
           $result = $factory->run($align_object, $db_taxonomy_object);
 Function: Runs phastCons on an alignment to find the most conserved regions
           ('footprinting').
 Returns : array of Bio::SeqFeature::Annotated (one feature per alignment
           sequence and prediction)
 Args    : The first arguement represents an alignment, the second arguement
           a species tree.
           The alignment can be provided as a multi-fasta format alignment
           filename, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).
           The species tree can be provided as a newick format tree filename
           or a Bio::Tree::TreeI complient object. Alternatively a
           Bio::DB::Taxonomy object can be supplied, in which case the species
           tree will be generated by using the alignment sequence names as
           species names and looking for those in the supplied database.

           In all cases, the alignment sequence names must correspond to node
           ids in the species tree. Multi-word species names should be joined
           with underscores to form the sequence names, eg. Homo_sapiens

=cut

sub run {
    my ($self, $aln, $tree) = @_;
    
    ($aln && $tree) || $self->throw("alignment and tree must be supplied");
    my $aln_obj = $self->_alignment($aln);
    $tree = $self->_tree($tree);
    
    # if aln was a file, set the alignment id to match file name
    if (-e $aln) {
        my $aln_id = basename($aln);
        ($aln_id) = $aln_id =~ /^([^\.]+)/;
        $aln_obj->id($aln_id);
    }
    
    return $self->_run; 
}

sub _run {
    my $self = shift;
    
    my $exe = $self->executable || return;
    
    # use phyloFit to generate tree model initialization (?) using species tree
    # and alignment
    my $pf = Bio::Tools::Run::Phylo::Phast::PhyloFit->new(-verbose => $self->verbose, -quiet => $self->quiet);
    my $init_mod = $pf->run($self->_alignment, $self->_tree) || $self->throw("phyloFit failed to work as expected, is it installed?");
    
    # cd to a temp dir
    my $temp_dir = $self->tempdir;
    my $cwd = Cwd->cwd();
    chdir($temp_dir) || $self->throw("Couldn't change to temp dir '$temp_dir'");
    
    my $aln_file = $self->_write_alignment;
    
    # do training for parameter estimation
    my $command = $exe.$self->_setparams($aln_file, $init_mod);
    $self->debug("phastCons training command = $command\n");
    system($command) && $self->throw("phastCons training call ($command) crashed: $?");
    
    # do the final analysis
    $command = $exe.$self->_setparams($aln_file);
    $self->debug("phastCons command = $command\n");
    system($command) && $self->throw("phastCons call ($command) crashed: $?");
    
    # read in most_cons.bed as the result
    my $bedin = Bio::FeatureIO->new(-format => 'bed', -file => 'most_cons.bed');
    
    # cd back to orig dir
    chdir($cwd) || $self->throw("Couldn't change back to working directory '$cwd'");
    
    my @feats = ();
    my $aln = $self->_alignment;
    while (my $feat = $bedin->next_feature) {
        $feat->source_tag('phastCons');
        my $sv = Bio::Annotation::SimpleValue->new(-tagname => 'predicted', -value => 1);
        $feat->annotation->add_Annotation($sv);
        # $feat->type('TF_binding_site'); causes seg fault in subsequent clone()
        
        # features are in zero-based alignment coords; make a feature for each
        # alignment sequence
        foreach my $seq ($aln->each_seq) {
            my $clone = clone($feat);
            # $clone->type('TF_binding_site'); causes massive slowdown if you later store/retrieve these features from Bio::DB::SeqFeature database
            
            # give it the correct id
            $clone->seq_id($seq->id);
            
            # check and correct the coords (sequence may not have the feature)
            my $sloc = $seq->location_from_column($feat->start + 1) || next;
            my $eloc = $seq->location_from_column($feat->end + 1) || next;
            $clone->start($sloc->start - 1);
            $clone->end($eloc->end - 1);
            
            push(@feats, $clone);
        }
    }
    return @feats;
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : alignment file name for result production, AND filename of phyloFit
           generated init.mod file to estimate trees

=cut

sub _setparams {
    my ($self, $aln_file, $init_mod) = @_;
    
    my $param_string = $self->SUPER::_setparams(-params => [keys %PARAMS],
                                                -switches => [keys %SWITCHES],
                                                -double_dash => 1,
                                                -underscore_to_dash => 1);
    
    $param_string .= ' --no-post-probs';
    my $aln_id = $self->_alignment->id;
    $param_string .= " --seqname $aln_id --idpref $aln_id" if $aln_id;
    $param_string .= ' --refidx 0';
    
    my $input = ' --msa-format FASTA '.$aln_file;
    if ($init_mod) {
        $param_string .= ' --estimate-trees mytrees '.$input.' '.$init_mod;
    }
    else {
        $param_string .= $input.' --most-conserved most_cons.bed --score mytrees.cons.mod,mytrees.noncons.mod';
    }
    
    return $param_string;
}

1;
