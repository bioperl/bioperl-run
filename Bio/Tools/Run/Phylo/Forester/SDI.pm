
package Bio::Tools::Run::Phylo::Forester::SDI;
use strict;

use Bio::Tools::Run::JavaRunner;
our @ISA=qw(Bio::Tools::Run::JavaRunner);

use Bio::Root::AccessorMaker (
    '$'=>[qw(species_tree_file gene_tree_file species_tree gene_tree unrooted)]);


sub new {
    my ($class, @args)=@_;
    my $self = $class->SUPER::new(@args);
    $self->_initialize(@args);
    return $self;
}

sub _initialize {
    my ($self, @args)=@_;
    $self->SUPER::_initialize(@args);
    my ($unrooted)= $self->_rearrange(
        [qw(unrooted)], @args);
    defined $unrooted and $self->unrooted($unrooted);
}

sub class {
    shift->unrooted ? 'forester.tools.SDIunrooted':'forester.tools.SDI';
}

sub final_param {
    my $self=shift;
    my $param = $self->species_tree_file .' '. $self->gene_tree_file;
    $param .= ' '.  $self->output_file unless $self->unrooted;
    return $param;
}

sub run_file {
    my $self=shift;
    my $infile=shift;
    if(defined $infile){
        ref($infile) eq 'ARRAY' or $self->throw(
            'SDI requires two arguments in an array ref');
        $self->species_tree_file($infile->[0]);
        $self->gene_tree_file($infile->[1]);
    }
    defined $self->species_tree_file or $self->throw('No species tree file');
    defined $self->gene_tree_file or $self->throw('No gene tree file');
    defined $self->output_file or $self->throw('No output file');
    $self->_run_java;
}

sub _find_files {
    my $self=shift;
    my $in=shift;
    if(defined $in){
        ref($in) eq 'ARRAY' or $self->throw(
            'SDI requires two arguments in an array ref');
        $self->species_tree($in->[0]);
        $self->gene_tree($in->[1]);
    }
    unless(defined $self->species_tree_file){
        $self->species_tree_file($self->temptdir . "/sdi_species_tree_file");
    }
    unless(defined $self->gene_tree_file){
        $self->gene_tree_file($self->tempdir ."/sdi_gene_tree_file");
    }
    unless(defined $self->output_file){
        $self->output_file($self->tempdir ."/sdi_output_file");
    }

    my $species_tree_file = $self->temptdir . "/sdi_species_tree_file";
    my $gene_tree_file = $self->tempdir ."/sdi_gene_tree_file";
}

sub _create_input_files {
    my $self=shift;
    # Create input files
    my $treeio = Bio::TreeIO->new(
        -format => 'nhx', -file => ">". $self->species_tree_file
    );
    $treeio->write_tree($self->species_tree);
    $treeio = Bio::TreeIO->new(
        -format => 'nhx', -file => ">". $self->gene_tree_file
    );
    $treeio->write_tree($self->gene_tree);
}    
    
sub _parse_output_files {
    my $self=shift;
    my $treeio = Bio::TreeIO->new(
        -format => 'nhx', -file => $self->output_file
    );
    my @trees;
    while(my $tree=$treeio->next_tree){
        push @trees, $tree;
    }
    return \@trees;
}

sub run_sdi {
    my $self=shift;
}

1;

__END__

=pod

=head1 NAME

Bio::Tools::Run::Phylo::Forester::SDI

=head1 SYNOPSIS

    my $runner = Bio::Tools::Run::Phylo::Forester::SDI->new();

    # run with file
    $runner->species_tree_file('tree_of_life_bin_1-4.nhx');
    $runner->gene_tree_file('input_tree.nhx') ;
    $runner->output_file('out.tree');
    $runner->run_file;

=head1 DESCRIPTION

This wrapper is for SDI in Forester package. 
For more details on Forester, please see 

http://www.genetics.wustl.edu/eddy/forester/


=head2 NOTE

You have to do something before running this module, since SDI will popup a GUI
window to visualize the structure of the result treee, which is not expected 
by someone who only want the result file.

You need to comment out the source code to popup the window on the main method
of class forester.tools.SDI .
Then recompile it and make it accessible in CLASSPATH

=head1 AUTHOR

Juguang Xiao, juguang at tll.org.sg

=head1 COPYRIGHT

This module is a free software. 
You may copy or redistribute it under the same terms as Perl itself.

=cut

