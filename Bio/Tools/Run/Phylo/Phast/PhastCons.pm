# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Phast::PhastCons
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
  @params = ();
  $factory = Bio::Tools::Run::Phylo::Phast::PhastCons->new(@params);

  # Pass the factory an alignment and the corresponding species tree
  $align_filename = 't/data/apes.multi_fasta';
  $species_tree_filename = 't/data/apes_tree.newick';
  $result = $factory->run($align_filename, $species_tree_filename);

  # or get a Bio::Align::AlignI (SimpleAlign) object from somewhere, and
  # generate the species tree automatically using a Bio::DB::Taxonomy database
  $db = Bio::DB::Taxonomy->new(-source => 'entrez');
  $result = $factory->run($aln_obj, $db);

=head1 DESCRIPTION

This is a wrapper for running the phastCons application by Adam Siepel. You
can get details here: http://compgen.bscb.cornell.edu/~acs/software.html

Currently the interface is extremely simplified, allowing only one analysis
method and only two options to be changed. The focus here is on ease of use,
allowing phastCons to estimate as many parameters as possible and having it
output just the 'most conserved' blocks it detects.

You will need to enable this phastCons wrapper to find the phast programs (at
least phastCons and phyloFit).
This can be done in (at least) three ways:

 1. Make sure the phastCons and phyloFit executables are in your path.
 2. Define an environmental variable PHASTDIR which is a 
    directory which contains the 'phastCons and phyloFit' applications:
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

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Sendu Bala

Email bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phylo::Phast::PhastCons;
use strict;

use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tree::Tree;

use base qw(Bio::Tools::Run::WrapperBase);

our $PROGRAM_NAME = 'phastCons';
our $PROGRAM_DIR = $ENV{'PHASTDIR'};

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
 Function: returns the program directory, obtiained from ENV variable.
 Returns : string
 Args    : None

=cut

sub program_dir {
    return $PROGRAM_DIR;
}

=head2 new

 Title   : new
 Usage   : $factory = Bio::Tools::Run::Phylo::Phast::PhastCons->new(@params)
 Function: creates a new PhastCons factory
 Returns : Bio::Tools::Run::Phylo::Phast::PhastCons
 Args    : Optionally, provide any of the following (defaults are not to use):
           -target_coverage  => number # 
           -expected_length  => int # 

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
    
    my ($coverage, $length) = $self->_rearrange([qw(TARGET_COVERAGE
                                                    EXPECTED_LENGTH)], %args);
    
    $self->target_coverage($coverage) if $coverage;
    $self->expected_length($length) if $length;
    
    return $self;
}

=head2 target_coverage

 Title   : target_coverage
 Usage   : $factory->target_coverage(0.25);
 Function: 
 Returns : number (default undef)
 Args    : None to get, number to set.

=cut

sub target_coverage {
    my ($self, $num) = @_;
    if (defined ($num)) {
        $self->{coverage} = $num;
    }
    return $self->{coverage} || return;
}

=head2 expected_length

 Title   : expected_length
 Usage   : $factory->expected_length(5);
 Function: 
 Returns : int (default undef)
 Args    : None to get, int to set.

=cut

sub expected_length {
    my ($self, $int) = @_;
    if (defined ($int)) {
        $self->{exp_length} = $int;
    }
    return $self->{exp_length} || 0;
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
 Returns : ? object
 Args    : The first arguement represents an alignment, the second arguement
           a species tree.
           The alignment can be provided as a multi-fasta format alignment
           file name, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).
           The species tree can be provided as a newick format tree filename
           or a Bio::Tree::TreeI complient object. Alternatively a
           Bio::DB::Taxonomy object can be supplied, in which case the species
           tree will be generated by using the alignment sequence names as
           species names and looking for those in the supplied database.
           
           In all cases, the alignment sequence names must correspond to node
           ids in the species tree.

=cut

sub run {
    my ($self, $aln, $tree) = @_;

    if (ref $aln && $aln->isa("Bio::Align::AlignI")) {
        $aln = $self->_writeAlignFile($aln);
    }
    elsif (! -e $aln) {
        $self->throw("When not supplying a Bio::Align::AlignI object, you must supply a readable filename");
    }
    $self->{_align_file} = $aln;
    
    if (ref $tree && ($tree->isa("Bio::Tree::TreeI") || $tree->isa('Bio::DB::Taxonomy'))) {
        $tree = $self->_writeTreeFile($tree);
    }
    elsif (! -e $tree) {
        $self->throw("When not supplying a Bio::Tree::TreeI or Bio::DB::Taxonomy object, you must supply a readable filename");
    }
    $self->{_tree_file} = $tree;
    
    return $self->_run; 
}

sub _run {
    my $self = shift;
    
    my $exe = $self->executable || return;
    
    # cd to a temp dir
    #...
    
    # use phyloFit to generate tree model using species tree and alignment
    #...
    
    # do training for parameter estimation
    my $command = $exe.$self->_setparams(1);
    $self->debug("phastCons training command = $command");
    system($command) && $self->throw("phastCons training call ($command) crashed: $?");
    
    # do the final analysis
    $command = $exe.$self->_setparams(0);
    $self->debug("phastCons command = $command");
    system($command) && $self->throw("phastCons call ($command) crashed: $?");
    
    # read in most_cons.gff as the result, possibly convert to something nicer
    #...
    
    # cd back to orig dir
    #...
    
    $self->throw("Not yet implemented");
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : false for result production, true to estimate trees 

=cut

sub _setparams {
    my ($self, $estimate) = @_;
    my $param_string = '';
    
    $param_string .= ' --target-coverage '.$self->target_coverage if $self->target_coverage;
    $param_string .= ' --expected-length '.$self->expected_length if $self->expected_length;
    
    my $input = '--msa-format FASTA '.$self->{_align_file};
    if ($estimate) {
        $param_string .= ' --estimate-trees mytrees '.$input.' init.mod';
    }
    else {
        $param_string .= $input.' --most_conserved most_cons.gff mytrees.cons.mod,mytrees.noncons.mod';
    }
    $input .= ' --no-post-probs';
    
    return $param_string;
}

=head2 _writeAlignFile

 Title   : _writeAlignFile
 Usage   : obj->_writeAlignFile($aln)
 Function: Internal(not to be used directly)
 Returns : filename
 Args    : Bio::Align::AlignI

=cut

sub _writeAlignFile {
    my ($self, $align) = @_;
    
    my ($tfh, $tempfile) = $self->io->tempfile(-dir=>$self->tempdir);
    
    my $out = Bio::AlignIO->new('-fh'     => $tfh, 
				'-format' => 'fasta');
    $out->write_aln($align);
    
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    return $tempfile;
}

=head2 _writeTreeFile

 Title   : _writeTreeFile
 Usage   : obj->_writeTreeFile($tree)
 Function: Internal(not to be used directly)
 Returns : filename
 Args    : Bio::Tree::TreeI OR Bio::DB::Taxonomy
           AND alignment filename

=cut

sub _writeTreeFile {
    my ($self, $thing) = @_;
    
    my $tree;
    if ($thing->isa('Bio::Tree::TreeI')) {
        $tree = $thing;
    }
    else {
        # get all the alignment sequence names
        my @species_names = $self->_get_seq_names;
        
        # the full lineages of the species are merged into a single tree
        foreach my $name (@species_names) {
            my $ncbi_id = $thing->get_taxonid($name);
            if ($ncbi_id) {
                my $node = $thing->get_taxon(-taxonid => $ncbi_id);
                
                if ($tree) {
                    $tree->merge_lineage($node);
                }
                else {
                    $tree = new Bio::Tree::Tree(-node => $node);
                }
            }
            else {
                $self->throw("no taxonomy database node for species ".$name);
            }
        }
        
        # simple paths are contracted by removing degree one nodes
        $tree->contract_linear_paths;
        
        # convert node ids to their names for correct output with TreeIO
        foreach my $node ($tree->get_nodes) {
            $node->id($node->node_name);
        }
    }
    
    my ($tfh, $tempfile) = $self->io->tempfile(-dir=>$self->tempdir);
    
    my $out = Bio::TreeIO->new('-fh'     => $tfh, 
			       '-format' => 'newick');
    $out->write_tree($tree);
    
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    return $tempfile;
}

# subs for checking the tree and alignment ids match
sub _get_seq_names {
    my $self = shift;
    my $file = $self->{_align_file};
    
    my $align_in = Bio::AlignIO->new(-file => $file, -format => 'fasta');
    my $aln = $align_in->next_aln || $self->throw("Alignment file '$file' had no alignment!");
    
    my @names;
    foreach my $seq ($aln->each_seq) {
        push(@names, $seq->id);
    }
    
    return @names;
}
sub _get_node_names {
    my $self = shift;
    my $file = $self->{_tree_file};
    
    my $tree_in = Bio::TreeIO->new(-file => $file, -format => 'newick');
    my $tree = $tree_in->next_tree || $self-throw("Tree file '$file' had no tree!");
    
    my @names;
    foreach my $node ($tree->get_leaf_nodes) {
        
    }
    
    return;
}
sub _check_names {
    my $self = shift;
    
    my @seq_names = $self->_get_seq_names;
    my %node_names = map { $_ => 1 } $self->_get_node_names;
    
    foreach my $name (@seq_names) {
        $self->{_unmapped}{$name} = 1 unless defined $node_names{$name};
    }
    
    if (defined($self->{_unmapped})) {
        my $count = scalar(keys %{$self->{_unmapped}});
        my $unmapped = join(",", keys %{$self->{_unmapped}});
        $self->throw("$count unmapped ids between the aln and the tree: $unmapped");
    }
}

1;
