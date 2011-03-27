# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Phast::PhyloFit
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

Bio::Tools::Run::Phylo::Phast::PhyloFit - Wrapper for phyloFit

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Phast::PhyloFit;

  # Make a PhyloFit factory
  $factory = Bio::Tools::Run::Phylo::Phast::PhastCons->new();

  # Generate an init.mod file for use by phastCons
  my $init_file = $factory->run($alignment, $tree);

=head1 DESCRIPTION

This is a wrapper for running the phyloFit application by Adam Siepel. You
can get details here: http://compgen.bscb.cornell.edu/~acs/software.html

Currently the interface is extremely simplified. Only the --tree form of usage
is allowed (not --init-model), which means a tree must be supplied with the
alignment (to run()). You can try supplying normal phyloFit arguments to new(),
or calling arg-named methods (excluding initial hyphens and converting others
to underscores, eg. $factory-E<gt>gaps_as_bases(1) to set the --gaps-as-bases arg).

WARNING: the API may change in the future to allow for greater flexability and
access to more phyloFit features.


You will need to enable this PhyloFit wrapper to find the phast programs (at
least phyloFit itself).
This can be done in (at least) three ways:

 1. Make sure the phyloFit executable is in your path.
 2. Define an environmental variable PHASTDIR which is a 
    directory which contains the phyloFit application:
    In bash:

    export PHASTDIR=/home/username/phast/bin

    In csh/tcsh:

    setenv PHASTDIR /home/username/phast/bin

 3. Include a definition of an environmental variable PHASTDIR in
    every script that will use this PhyloFit wrapper module, e.g.:

    BEGIN { $ENV{PHASTDIR} = '/home/username/phast/bin' }
    use Bio::Tools::Run::Phylo::Phast::PhyloFit;

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

package Bio::Tools::Run::Phylo::Phast::PhyloFit;
use strict;

use Cwd;
use File::Spec;
use Bio::AlignIO;
use Bio::TreeIO;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'phyloFit';
our $PROGRAM_DIR = $ENV{'PHASTDIR'};

# methods and their synonyms from the phastCons args we support
our %PARAMS   = (subst_mod => 's',
                 min_informative => 'I',
                 precision => 'p',
                 log => 'l',
                 ancestor => 'A',
                 nrates => 'k',
                 alpha => 'a',
                 rate_constants => 'K',
                 features => 'g',
                 catmap => 'c',
                 do_cats => 'C',
                 reverse_groups => 'R');

our %SWITCHES = (gaps_as_bases => 'G',
                 quiet => 'q',
                 EM => 'E',
                 init_random => 'r',
                 estimate_freqs => 'F',
                 markov => 'N',
                 non_overlapping => 'V');

# just to be explicit, args we don't support (yet) or we handle ourselves
our %UNSUPPORTED = (msa_format => 'i',
                    out_root => 'o',
                    tree => 't',
                    help => 'h',
                    lnl => 'L',
                    init_model => 'M',
                    scale_only => 'B',
                    scale_subtree => 'S',
                    no_freqs => 'f',
                    no_rates => 'n',
                    post_probs => 'P',
                    expected_subs => 'X',
                    expected_total_subs => 'Z',
                    column_probs => 'U',
                    windows => 'w',
                    windows_explicit => 'v');

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
 Usage   : $factory = Bio::Tools::Run::Phylo::Phast::PhyloFit->new()
 Function: creates a new PhyloFit factory
 Returns : Bio::Tools::Run::Phylo::Phast::PhyloFit
 Args    : Most options understood by phastCons can be supplied as key =>
           value pairs. Options that don't normally take a value
           should be given a value of 1. You can type the keys as you would on
           the command line (eg. '--gaps-as-bases' => 1) or with only a single
           hyphen to start and internal hyphens converted to underscores (eg.
           -gaps_as_bases => 1) to avoid having to quote the key.

           These options can NOT be used with this wrapper currently:
           msa_format / i
           out_root / o
           tree / t
           help / h
           lnl / L
           init_model / M
           scale_only / B
           scale_subtree / S
           no_freqs / f
           no_rates / n
           post_probs / P
           expected_subs / X
           expected_total_subs / Z
           column_probs / U
           windows / w
           windows_explicit / v

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => {(map { $_ => $PARAMS{$_} } keys %PARAMS),
                                               (map { $_ => $SWITCHES{$_} } keys %SWITCHES)},
                                  -create => 1);
    
    return $self;
}

=head2 run

 Title   : run
 Usage   : $result = $factory->run($fasta_align_file, $newick_tree_file);
           -or-
           $result = $factory->run($align_object, $tree_object);
           -or-
           $result = $factory->run($align_object, $db_taxonomy_object);
 Function: Runs phyloFit on an alignment.
 Returns : filename of init.mod file produced
 Args    : The first argument represents an alignment, the second argument
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
    $self->_alignment($aln);
    $tree = $self->_tree($tree);
    
    $tree->force_binary;
    
    # adjust tree node ids to convert spaces to underscores (eg. if tree
    # generated from taxonomy)
    foreach my $node ($tree->get_leaf_nodes) {
        my $id = $node->id;
        $id =~ s/ /_/g;
        $node->id($id);
    }
    
    # check node and seq names match
    $self->_check_names;
    
    return $self->_run; 
}

sub _run {
    my $self = shift;
    
    my $exe = $self->executable || return;
    
    # cd to a temp dir
    my $temp_dir = $self->tempdir;
    my $cwd = Cwd->cwd();
    chdir($temp_dir) || $self->throw("Couldn't change to temp dir '$temp_dir'");
    
    my $aln_file = $self->_write_alignment;
    my $tree_file = $self->_write_tree;
    
    #...phyloFit --tree "(human,(mouse,rat))" --msa-format FASTA --out-root init alignment.fa
    my $command = $exe.$self->_setparams($aln_file, $tree_file);
    $self->debug("phyloFit command = $command\n");
    system($command) && $self->throw("phyloFit call ($command) crashed: $?");
    
    # cd back again
    chdir($cwd) || $self->throw("Couldn't change back to working directory '$cwd'");
    
    return File::Spec->catfile($temp_dir, 'init.mod');
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
    
    my $param_string = ' --tree '.$tree_file;
    $param_string .= ' --msa-format FASTA';
    $param_string .= ' --out-root init';
    
    # --min-informative defaults to 50, but must not be greater than the number
    # of bases in the alignment
    my $aln = $self->_alignment;
    my $length = $aln->length;
    my $min_informative = $self->min_informative || 50;
    if ($length < $min_informative) {
        $self->min_informative($length);
    }
    
    $param_string .= $self->SUPER::_setparams(-params => [keys %PARAMS],
                                              -switches => [keys %SWITCHES],
                                              -double_dash => 1,
                                              -underscore_to_dash => 1);
    $param_string .= ' '.$aln_file;
    
    return $param_string;
}

1;
