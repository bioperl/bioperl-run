# $Id: Semphy.pm,v 1.3 2007/05/25 10:14:55 sendu Exp $
#
# BioPerl module for Bio::Tools::Run::Phylo::Semphy
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

Bio::Tools::Run::Phylo::Semphy - Wrapper for Semphy

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Semphy;

  # Make a Semphy factory
  $factory = Bio::Tools::Run::Phylo::Semphy->new();

  # Run Semphy with an alignment
  my $tree = $factory->run($alignfilename);

  # or with alignment object
  $tree = $factory->run($bio_simplalign);

  # you can supply an initial tree as well, which can be a newick tree file,
  # Bio::Tree::Tree object...
  $tree = $factory->run($bio_simplalign, $tree_obj);

  # ... or Bio::DB::Taxonomy object
  $tree = $factory->run($bio_simplalign, $bio_db_taxonomy);

  # (mixtures of all the above are possible)

  # $tree isa Bio::Tree::Tree

=head1 DESCRIPTION

This is a wrapper for running the Semphy application by N. Friedman et a.. You
can get details here: http://compbio.cs.huji.ac.il/semphy/. Semphy is used for
phylogenetic reconstruction (making a tree with branch lengths from an aligned
set of input sequences).

You can try supplying normal Semphy command-line arguments to new(), eg.
new(-hky => 1) or calling arg-named methods (excluding the initial hyphen(s),
eg. $factory->hky(1) to set the --hky switch to true).
Note that Semphy args are case-sensitive. To distinguish between Bioperl's
-verbose and the Semphy's --verbose, you must set Semphy's verbosity with
-semphy_verbose or the semphy_verbose() method.


You will need to enable this Semphy wrapper to find the Semphy program.
This can be done in (at least) three ways:

 1. Make sure the Semphy executable is in your path.
 2. Define an environmental variable SEMPHYDIR which is a 
    directory which contains the Semphy application:
    In bash:

    export SEMPHYDIR=/home/username/semphy/

    In csh/tcsh:

    setenv SEMPHYDIR /home/username/semphy

 3. Include a definition of an environmental variable SEMPHYDIR in
    every script that will use this Semphy wrapper module, e.g.:

    BEGIN { $ENV{SEMPHYDIR} = '/home/username/semphy/' }
    use Bio::Tools::Run::Phylo::Semphy;

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

package Bio::Tools::Run::Phylo::Semphy;
use strict;

use File::Spec;
use Bio::AlignIO;
use Bio::TreeIO;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'semphy';
our $PROGRAM_DIR = $ENV{'SEMPHYDIR'};

# methods for the semphy args we support
our %PARAMS   = (outputfile => 'o',
                 treeoutputfile => 'T',
                 constraint => 'c',
                 gaps => 'g',
                 seed => 'r',
                 Logfile => 'l',
                 alphabet => 'a',
                 ratio => 'z',
                 ACGprob => 'p',
                 BPrepeats => 'BPrepeats',
                 BPconsensus => 'BPconsensus',
                 SEMPHY => 'S',
                 modelfile => 'modelfile',
                 alpha => 'A',
                 categories => 'C',
                 semphy_verbose => 'semphy_verbose');
our %SWITCHES = (homogeneousRatesDTME => 'homogeneousRatesDTME',
                 NJ => 'J',
                 pairwiseGammaDTME => 'pairwiseGammaDTME',
                 commonAlphaDTME => 'commonAlphaDTME',
                 rate4siteDTME => 'rate4siteDTME',
                 posteriorDTME => 'posteriorDTME',
                 BPonUserTree => 'BPonUserTree',
                 nucjc => 'nucjc',
                 aaJC => 'aaJC',
                 k2p => 'k2p',
                 hky => 'hky',
                 day => 'day',
                 jtt => 'jtt',
                 rev => 'rev',
                 wag => 'wag',
                 cprev => 'cprev',
                 homogeneous => 'H',
                 optimizeAlpha => 'O',
                 bbl => 'n',
                 likelihood => 'L',
                 PerPosLike => 'P',
                 PerPosPosterior => 'B',
                 rate => 'R');

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(h help full-help s sequence t tree);


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
 Usage   : $factory = Bio::Tools::Run::Phylo::Semphy->new()
 Function: creates a new Semphy factory
 Returns : Bio::Tools::Run::Phylo::Semphy
 Args    : Most options understood by Semphy can be supplied as key =>
           value pairs, with a true value for switches.

           These options can NOT be used with this wrapper (they are handled
           internally or don't make sense in this context):
           -h | --help | --fill-help
           -s | --sequence
           -t | --tree

           To distinguish between Bioperl's -verbose and the Semphy's --verbose,
           you must set Semphy's verbosity with -semphy_verbose

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => {(map { $_ => $PARAMS{$_} } keys %PARAMS),
                                               (map { $_ => $SWITCHES{$_} } keys %SWITCHES),
                                               quiet => 'quiet'},
                                  -create => 1,
                                  -case_sensitive => 1);
    
    return $self;
}

=head2 run

 Title   : run
 Usage   : $result = $factory->run($fasta_align_file);
           -or-
           $result = $factory->run($align_object);
           -or-
           $result = $factory->run($fasta_align_file, $newick_tree_file);
           -or-
           $result = $factory->run($align_object, $tree_object);
           -or-
           $result = $factory->run($align_object, $db_taxonomy_object);
 Function: Runs Semphy on an alignment.
 Returns : Bio::Tree::Tree
 Args    : The first argument represents an alignment, the second (optional)
           argument a species tree (to set an initial tree: normally the -t
           option to Semphy).
           The alignment can be provided as a multi-fasta format alignment
           filename, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).
           The species tree can be provided as a newick format tree filename
           or a Bio::Tree::TreeI complient object. Alternatively a
           Bio::DB::Taxonomy object can be supplied, in which case the species
           tree will be generated by using the alignment sequence names as
           species names and looking for those in the supplied database.
           
           In all cases where an initial tree was supplied, the alignment
           sequence names must correspond to node ids in the species tree.

=cut

sub run {
    my ($self, $aln, $tree) = @_;
    
    $aln || $self->throw("alignment must be supplied");
    $self->_alignment($aln);
    
    if ($tree) {
        $self->_tree($tree);
        
        # check node and seq names match
        $self->_check_names;
    }
    
    return $self->_run; 
}

sub _run {
    my $self = shift;
    
    my $exe = $self->executable || return;
    
    my $aln_file = $self->_write_alignment;
    
    # generate a semphy-friendly tree file
    my $tree = $self->_tree;
    my $tree_file = '';
    if ($tree) {
        $tree = $self->_write_tree;
    }
    
    unless ($self->T) {
        my ($tfh, $tempfile) = $self->io->tempfile(-dir => $self->tempdir);
        $self->T($tempfile);
        close($tfh);
    }
    
    my $command = $exe.$self->_setparams($aln_file, $tree_file);
    $self->debug("semphy command = $command\n");
    
    open(my $pipe, "$command |") || $self->throw("semphy call ($command) failed to start: $? | $!");
    my $error = '';
    while (<$pipe>) {
        print unless $self->quiet;
        $error .= $_;
    }
    close($pipe) || ($error ? $self->warn("semphy call ($command) failed: $error") : $self->throw("semphy call ($command) crashed: $?"));
    
    my $result_file = $self->T();
    my $tio = Bio::TreeIO->new(-format => 'newick', -file => $result_file);
    my $result_tree = $tio->next_tree;
    
    return $result_tree;
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : alignment and tree file names

=cut

sub _setparams {
    my ($self, $aln_file, $tree_file) = @_;
    
    my $param_string = ' -s '.$aln_file;
    $param_string .= ' -t '.$tree_file if $tree_file;
    
    my %methods = map { $_ => $_ } keys %PARAMS;
    $methods{'semphy_verbose'} = 'verbose';
    $param_string .= $self->SUPER::_setparams(-params => \%methods,
                                              -switches => [keys %SWITCHES],
                                              -double_dash => 1);
    
    $param_string .= ' 2>&1';
    $param_string .= ' 1>/dev/null' if $self->quiet;
    
    return $param_string;
}

1;
