# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::PhyloBase
#
# Cared for by Sendu Bala <bix@sendu.me.uk>
#
# Copyright Sendu Bala
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::PhyloBase- base module for phylo wrappers

=head1 SYNOPSIS

  use base qw(Bio::Tools::Run::Phylo::PhyloBase);

=head1 DESCRIPTION

For use by Bio::Tools::Run::Phylo modules as a base in place of
Bio::Tools::Run::WrapperBase.

This is based on WrapperBase but provides additional phylo-related private
helper subs.

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

package Bio::Tools::Run::Phylo::PhyloBase;
use strict;

use Cwd;
use File::Spec;
use Bio::AlignIO;
use Bio::TreeIO;

use base qw(Bio::Tools::Run::WrapperBase);

=head2 _writeAlignFile

 Title   : _writeAlignFile
 Usage   : $obj->_writeAlignFile($aln)
 Function: Writes the supplied alignment object out in the desired format to
           a temp file.
 Returns : n/a (sets _alignment_file())
 Args    : Bio::Align::AlignI AND format (default 'fasta');

=cut

sub _writeAlignFile {
    my ($self, $align, $format) = @_;
    $format ||= 'fasta';
    
    my ($tfh, $tempfile) = $self->io->tempfile(-dir=>$self->tempdir);
    
    my $out = Bio::AlignIO->new(-verbose => $self->verbose, '-fh' => $tfh, '-format' => $format);
    $align->set_displayname_flat;
    $self->_alignment_id($align->id || $tempfile);
    $out->write_aln($align);
    
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    $self->_alignment_file($tempfile);
}

=head2 _writeTreeFile

 Title   : _writeTreeFile
 Usage   : obj->_writeTreeFile($tree)
 Function: Writes the supplied tree object out in the desired format to a temp
           file.
 Returns : n/a (sets _tree_file())
 Args    : Bio::Tree::TreeI OR Bio::DB::Taxonomy (_alignment_file() must be
           set in the latter case, where the corresponding alignment file has
           sequences with ids matching species in the taxonomy database)

           Optionally, any of these key => value pairs:
           format => string # desired output format, default 'newick'
           binary => 1      # force the tree that is output to be binary
           unquoted => 1    # do not allow the output tree to have quoted
                              strings; converts spaces in ids to underscores

=cut

sub _writeTreeFile {
    my ($self, $thing, @args) = @_;
    
    my ($format, $binary, $unquoted) = $self->_rearrange([qw(FORMAT
                                                             BINARY
                                                             UNQUOTED)], @args);
    $format ||= 'newick';
    
    my $tree;
    if (-e $thing) {
        # read the tree in so we can later spit it out in desired format
        my $in = Bio::TreeIO->new(-verbose => $self->verbose, -file => $thing, -format => $format);
        $tree = $in->next_tree;
    }
    elsif ($thing->isa('Bio::Tree::TreeI')) {
        $tree = $thing;
    }
    elsif ($thing->isa('Bio::DB::Taxonomy')) {
        $self->throw("When supplying a Bio::DB::Taxonomy, _alignment_file() must first be set") unless $self->_alignment_file;
        
        # get all the alignment sequence names
        my @species_names = $self->_get_seq_names;
        
        # the full lineages of the species are merged into a single tree
        foreach my $name (@species_names) {
            my $ncbi_id = $thing->get_taxonid($name);
            if ($ncbi_id) {
                my $node = $thing->get_taxon(-taxonid => $ncbi_id);
                $node->name('seq_id', $name);
                
                if ($tree) {
                    $tree->merge_lineage($node);
                }
                else {
                    $tree = new Bio::Tree::Tree(-verbose => $self->verbose, -node => $node);
                }
            }
            else {
                $self->throw("No taxonomy database node for species ".$name);
            }
        }
        
        # convert node ids to their seq_ids for correct output with TreeIO
        foreach my $node ($tree->get_nodes) {
            my $seq_id = $node->name('seq_id');
            $seq_id = $seq_id ? shift @{$seq_id} : ($node->node_name ? $node->node_name : $node->id);
            
            $node->id($seq_id);
        }
    }
    else {
        $self->throw("Unknown input type [$thing]");
    }
    
    # force the tree to be binary
    $tree->force_binary if $binary;
    
    # get rid of spaces in ids to prevent quoted strings
    if ($unquoted) {
        foreach my $node ($tree->get_nodes) {
            my $id = $node->id;
            $id =~ s/ /_/g;
            $node->id($id);
        }
    }
    
    my ($tfh, $tempfile) = $self->io->tempfile(-dir => $self->tempdir);
    
    my $out = Bio::TreeIO->new(-verbose => $self->verbose, -fh => $tfh, -format => $format);
    $out->write_tree($tree);
    
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    $self->_tree_file($tempfile);
}

=head2 _alignment_file

 Title   : _alignment_file
 Usage   : $obj->_alignment_file($str)
 Function: Get/set location of alignment file program being wrapped will operate
           on. When getting, the location is the absolute path to the file.
 Returns : string (file path, absolute)
 Args    : string (file path, can be relative)

=cut

sub _alignment_file {
    my $self = shift;
    if (@_) { $self->{_align_file} = Cwd::abs_path(shift) }
    return $self->{_align_file} || '';
}

=head2 _alignment_id

 Title   : _alignment_id
 Usage   : $obj->_alignment_id($str)
 Function: Get/set alignment id. Typically set by _writeAlignFile().
 Returns : string
 Args    : none to get, string to set

=cut

sub _alignment_id {
    my $self = shift;
    if (@_) { $self->{_alignment_id} = shift }
    return $self->{_alignment_id} || '';
}

=head2 _tree_file

 Title   : _tree_file
 Usage   : $obj->_tree_file($str)
 Function: Get/set location of tree file program being wrapped will operate on
           When getting, the location is the absolute path to the file.
 Returns : string (file path, absolute)
 Args    : string (file path, can be relative)

=cut

sub _tree_file {
    my $self = shift;
    if (@_) { $self->{_tree_file} = Cwd::abs_path(shift) }
    return $self->{_tree_file} || '';
}

=head2 _get_seq_names

 Title   : _get_seq_names
 Usage   : @names = $obj->_get_seq_names()
 Function: Get all the sequence names (from id()) of the sequenes in the
           alignment. _alignment_file() must be set prior to calling this.
 Returns : list of strings (seq ids)
 Args    : input format of the alignment file (defaults to guess)

=cut

sub _get_seq_names {
    my $self = shift;
    my $file = $self->_alignment_file || $self->throw("Alignment filename hasn't been set with _alignment_file");
    my $format = shift;
    
    my $align_in = Bio::AlignIO->new(-verbose => $self->verbose, -file => $file, $format ? (-format => $format) : ());
    my $aln = $align_in->next_aln || $self->throw("Alignment file '$file' had no alignment!");
    
    my @names;
    foreach my $seq ($aln->each_seq) {
        push(@names, $seq->id);
    }
    
    return @names;
}

=head2 _get_node_names

 Title   : _get_node_names
 Usage   : @names = $obj->_get_node_names()
 Function: Get all the node names (from id()) of the nodes in the tree.
           _tree_file() must be set prior to calling this.
 Returns : list of strings (node ids)
 Args    : input format of the tree file (defaults to guess)

=cut

sub _get_node_names {
    my $self = shift;
    my $file = $self->_tree_file || $self->throw("Tree filename hasn't been set");
    my $format = shift;
    
    my $tree_in = Bio::TreeIO->new(-verbose => $self->verbose, -file => $file, $format ? (-format => $format) : ());
    my $tree = $tree_in->next_tree || $self->throw("Tree file '$file' had no tree!");
    
    my @names;
    foreach my $node ($tree->get_leaf_nodes) {
        push(@names, $node->id);
    }
    
    return @names;
}

=head2 _check_names

 Title   : _check_names
 Usage   : if ($obj->_check_names) { ... }
 Function: Determine if all sequences in the alignment file have a corresponding
           node in the tree file. _alignment_file() and _tree_file() must be set
           prior to calling this.
 Returns : boolean (will also warn about the specific problems when returning
           false)
 Args    : input format of the alignment and tree files (both default to guess)

=cut

sub _check_names {
    my ($self, $aformat, $tformat) = @_;
    
    my @seq_names = $self->_get_seq_names($aformat);
    my %node_names = map { $_ => 1 } $self->_get_node_names($tformat);
    
    # (not interested in tree nodes that don't map to sequence, since we
    #  expect the tree to have internal nodes not represented by sequence)
    foreach my $name (@seq_names) {
        $self->{_unmapped}{$name} = 1 unless defined $node_names{$name};
    }
    
    if (defined($self->{_unmapped})) {
        my $count = scalar(keys %{$self->{_unmapped}});
        my $unmapped = join(", ", keys %{$self->{_unmapped}});
        $self->warn("$count unmapped ids between the supplied alignment and tree: $unmapped");
        return 0;
    }
    return 1;
}

1;
