# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::QuickTree
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

Bio::Tools::Run::Phylo::QuickTree - Wrapper for rapid reconstruction of
                                    phylogenies using QuickTree

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::QuickTree;

  #  Make a QuickTree factory
  @params = ();
  $factory = Bio::Tools::Run::Phylo::QuickTree->new(@params);

  #  Pass the factory an alignment	
  $inputfilename = 't/data/cysprot.stockholm';
  $tree = $factory->run($inputfilename); # $tree is a Bio::Tree::Tree object.
  # or get a Bio::Align::AlignI (SimpleAlign) object from somewhere
  $tree = $factory->run($aln);

=head1 DESCRIPTION

This is a wrapper for running the QuickTree application by Kevin Howe. You
can download it here: http://www.sanger.ac.uk/Software/analysis/quicktree/

Currently only input with alignments and output of trees is supported. (Ie.
no support for distance matrix in/out.)

You will need to enable this QuickTree wrapper to find the quicktree program.
This can be done in (at least) three ways:

 1. Make sure the QuickTree executable is in your path.
 2. Define an environmental variable QUICKTREEDIR which is a 
    directory which contains the 'quicktree' application:
    In bash:

    export QUICKTREEDIR=/home/username/quicktree_1.1/bin

    In csh/tcsh:

    setenv QUICKTREEDIR /home/username/quicktree_1.1/bin

 3. Include a definition of an environmental variable QUICKTREEDIR in
    every script that will use this QuickTree wrapper module, e.g.:

    BEGIN { $ENV{QUICKTREEDIR} = '/home/username/quicktree_1.1/bin' }
    use Bio::Tools::Run::Phylo::QuickTree;

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

package Bio::Tools::Run::Phylo::QuickTree;
use strict;

use Bio::AlignIO;
use Bio::TreeIO;

use base qw(Bio::Tools::Run::WrapperBase);

our $PROGRAM_NAME = 'quicktree';
our $PROGRAM_DIR = $ENV{'QUICKTREEDIR'};

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
 Usage   : $factory = Bio::Tools::Run::Phylo::QuickTree->new(@params)
 Function: creates a new QuickTree factory
 Returns : Bio::Tools::Run::Phylo::QuickTree
 Args    : Optionally, provide any of the following (default in []):
           -upgma  => boolean # Use the UPGMA method to construct the tree [0]
           -kimura => boolean # Use the kimura translation for pairwise
                              # distances [0]
           -boot   => int     # Calculate bootstrap values with n iterations [0]

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    # for consistency with other run modules, allow params to be dashless
    my %args = @args;
    while (my ($key, $val) = each %args) {
        if ($key !~ /^-/) {
            delete $args{$key};
            $args{'-'.$key} = $val;
        }
    }
    
    my ($upgma, $kimura, $boot) = $self->_rearrange([qw(UPGMA
                                                        KIMURA
                                                        BOOT)], %args);
    
    $self->upgma(1) if $upgma;
    $self->kimura(1) if $kimura;
    $self->boot($boot) if $boot;
    
    return $self;
}

=head2 upgma

 Title   : upgma
 Usage   : $factory->upgma(1);
 Function: Choose to use the UPGMA method to construct the tree.
 Returns : boolean (default 0)
 Args    : None to get, boolean to set.

=cut

sub upgma {
    my ($self, $bool) = @_;
    if (defined ($bool)) {
        $self->{upgma} = $bool;
    }
    return $self->{upgma} || 0;
}

=head2 kimura

 Title   : kimura
 Usage   : $factory->kimura(1);
 Function: Choose to use the kimura translation for pairwise distances.
 Returns : boolean (default 0)
 Args    : None to get, boolean to set.

=cut

sub kimura {
    my ($self, $bool) = @_;
    if (defined ($bool)) {
        $self->{kimura} = $bool;
    }
    return $self->{kimura} || 0;
}

=head2 boot

 Title   : boot
 Usage   : $factory->boot(100);
 Function: Choose to calculate bootstrap values with the supplied number of
           iterations.
 Returns : int (default 0)
 Args    : None to get, int to set.

=cut

sub boot {
    my ($self, $int) = @_;
    if (defined ($int)) {
        $self->{boot} = $int;
    }
    return $self->{boot} || 0;
}

=head2 run

 Title   : run
 Usage   : $factory->run($stockholm_file);
           $factory->run($align_object);
 Function: Runs QuickTree to generate a tree 
 Returns : Bio::Tree::Tree object
 Args    : file name for your input alignment in stockholm format, OR
           Bio::Align::AlignI complient object (eg. Bio::SimpleAlign).

=cut

sub run {
    my ($self, $in) = @_;

    if (ref $in && $in->isa("Bio::Align::AlignI")) {
        $in = $self->_writeAlignFile($in);
    }
    elsif (! -e $in) {
        $self->throw("When not supplying a Bio::Align::AlignI object, you must supply a readable filename");
    }
    
    return $self->_run($in); 
}

sub _run {
    my ($self, $file)= @_;
    
    my $exe = $self->executable || return;
    my $param_str = $self->arguments." ".$self->_setparams;
    my $command = $exe." $param_str ".$file;
    
    $self->debug("QuickTree command = $command");
    
    open(my $result, "$command |") || $self->throw("QuickTree call ($command) crashed: $?");
    my $treeio = Bio::TreeIO->new(-format => 'nhx', -fh => $result);
    my $tree = $treeio->next_tree;
    close($result);
    
    # if bootstraps were enabled, the bootstraps are the ids; convert to
    # bootstrap and no id
    if ($self->boot) {
        my @nodes = $tree->get_nodes;
        my %non_internal = map { $_ => 1 } ($tree->get_leaf_nodes, $tree->get_root_node);
        foreach my $node (@nodes) {
            next if exists $non_internal{$node};
            $node->bootstrap && next; # protect ourselves incase the parser improves
            $node->bootstrap($node->id);
            $node->id('');
        }
    }
    
    return $tree;
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
    my $param_string = '-in a -out t';
    
    $param_string .= ' -upgma' if $self->upgma;
    $param_string .= ' -kimura' if $self->kimura;
    $param_string .= ' -boot '.$self->boot if $self->boot;
    
    return $param_string;
}

=head2 _writeAlignFile

 Title   : _writeAlignFile
 Usage   : obj->_writeAlignFile($seq)
 Function: Internal(not to be used directly)
 Returns : filename
 Args    : Bio::Align::AlignI

=cut

sub _writeAlignFile{
    my ($self, $align) = @_;
    
    my ($tfh, $tempfile) = $self->io->tempfile(-dir=>$self->tempdir);
    
    my $out = Bio::AlignIO->new('-fh'     => $tfh, 
				'-format' => 'stockholm');
    $out->write_aln($align);
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    return $tempfile;
}

1;
