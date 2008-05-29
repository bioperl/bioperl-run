# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    eval {require Test::More;};
    if ($@) {
        use lib 't/lib';
    }
    use Test::More;
    
    plan tests => 40;
    
    use_ok('Bio::Tools::Run::Phylo::Phyml');
    use_ok('Bio::AlignIO');
}

# setup input files etc
my $inputfilename = Bio::Root::IO->catfile("t","data","protpars.phy");
ok (-e $inputfilename, 'Found protein input file');

my $factory = Bio::Tools::Run::Phylo::Phyml->new(-verbose => 0);
isa_ok($factory, 'Bio::Tools::Run::Phylo::Phyml');

# test default factory values
is ($factory->program_dir, $ENV{'PHYMLDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'phyml', 'Correct exe default name');


# test parameters
is ($factory->data_type, '1', 'data_type, default');
is ($factory->data_type('dna'), '0', 'data_type, dna');
#use Data::Dumper; print Dumper $factory;
is ($factory->data_type('protein'), '1', 'data_type, protein');

is ($factory->data_format, 'i', 'data_format, default');
is ($factory->data_format('s'), 's', 'data_format, sequential');
is ($factory->data_format('i'), 'i', 'data_format, interleaved');

is ($factory->dataset_count, 1, 'dataset_count, default');
is ($factory->dataset_count(2), 2, 'data_count, 2');

is ($factory->model, 'JTT', 'model, default');
is ($factory->model('WAG'), 'WAG', 'model');

is ($factory->kappa, 'e', 'kappa, default');
is ($factory->kappa(4), '4.0', 'kappa');

is ($factory->invar, 'e', 'invar, default');
is ($factory->invar(.5), '0.5', 'invar');

is ($factory->category_number, 1, 'category_number, default');
is ($factory->category_number(4), 4, 'category_number');

is ($factory->alpha, 'e', 'alpha, default');
is ($factory->alpha(1), '1.0', 'alpha');
is ($factory->alpha('e'), 'e', 'alpha');

is ($factory->tree, 'BIONJ', 'tree, default');
# not a valid tree for this MSA, jsut testing
my $mock_treefile = Bio::Root::IO->catfile("t","data","treefile.example");
is ($factory->tree($mock_treefile), $mock_treefile, 'tree');
is ($factory->tree('BIONJ'), 'BIONJ', 'tree');

is ($factory->opt_topology, 'y', 'opt_topology, default');
is ($factory->opt_topology('0'), 'n', 'opt_topology');
is ($factory->opt_topology('1'), 'y', 'opt_topology');

is ($factory->opt_lengths, 'y', 'opt_lengths, default');
is ($factory->opt_lengths('0'), 'n', 'opt_lengths');
is ($factory->opt_lengths('1'), 'y', 'opt_lengths');




# test the program itself
SKIP: {
    skip("Couldn't find the phyml executable", 7) unless defined $factory->executable();
    
    # using filename input
    my $tree = $factory->run($inputfilename);
    isa_ok($tree, 'Bio::Tree::Tree');
    my @leaves = $tree->get_leaf_nodes;
    is (@leaves, 3, 'Result tree from filename input had correct number of leaves');

    is substr($factory->stats, 0, 9), "\n- PHYML ", 'stats()';
    is substr($factory->tree_string, 0, 9), 'BIONJ(SIN', 'tree_string()';


    # using AlignIO on a DNA MSA
    my $inputfilename = Bio::Root::IO->catfile("t","data","dna_seqs1.phy");
    ok (-e $inputfilename, 'Found DNA input file');
    
    my $alignio = Bio::AlignIO->new(-file => $inputfilename);
    my $aln = $alignio->next_aln;

    #testing passing attributes to the constructor
    # all settable attibutes defined in this module are included
    my %args = (
	-data_type => 'dna',
	-model => 'HKY',
	-kappa => 4,
	-invar => 'e',
	-category_number => 4,
	-alpha => 'e',
	-tree => 'BIONJ',
	-opt_topology => '0',
	-opt_lengths => '1',
	-verbose => 0
	);

    $factory = Bio::Tools::Run::Phylo::Phyml->new(%args);
    $factory->save_tempfiles(1);
    $tree = $factory->run($aln);
    @leaves = $tree->get_leaf_nodes;
    is (@leaves, 5, 'Result tree from DNA SimpleAlign input had correct number of leaves');
    

}

