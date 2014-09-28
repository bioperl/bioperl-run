# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Phylo]Phyml');
    test_begin(-tests => 46);
    use_ok('Bio::Tools::Run::Phylo::Phyml');
    use_ok('Bio::AlignIO');
}

# setup input files etc
my $inputfilename = test_input_file("protpars.phy");
ok (-e $inputfilename, 'Found protein input file');

my $factory = Bio::Tools::Run::Phylo::Phyml->new(-verbose => test_debug());
isa_ok($factory, 'Bio::Tools::Run::Phylo::Phyml');

# test default factory values
is ($factory->program_dir, $ENV{'PHYMLDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'phyml', 'Correct exe default name');

is ($factory->data_format, 'i', 'data_format, default');
is ($factory->data_format('s'), 's', 'data_format, sequential');
is ($factory->data_format('i'), 'i', 'data_format, interleaved');

is ($factory->dataset_count, 1, 'dataset_count, default');
is ($factory->dataset_count(2), 2, 'data_count, 2');

is ($factory->kappa, 'e', 'kappa, default');
is ($factory->kappa(4), '4.0', 'kappa');

is ($factory->invar, 'e', 'invar, default');
is ($factory->invar(.5), '0.5', 'invar');

is ($factory->category_number, 1, 'category_number, default');
is ($factory->category_number(4), 4, 'category_number');

is ($factory->alpha, 'e', 'alpha, default');
is ($factory->alpha(1.0), '1.0', 'alpha');
is ($factory->alpha('e'), 'e', 'alpha');

is ($factory->tree, 'BIONJ', 'tree, default');
# not a valid tree for this MSA, just testing
my $mock_treefile = test_input_file("treefile.example");
is ($factory->tree($mock_treefile), $mock_treefile, 'tree');
is ($factory->tree('BIONJ'), 'BIONJ', 'tree');

# test the program itself
SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 23);

    cmp_ok $factory->version, '>', '2.4','version';
    # test version-specific parameters
    if ($factory->version >= 3 ) {
        is ($factory->data_type, 'aa', 'data_type, default');
        is ($factory->data_type('nt'), 'nt', 'data_type, dna');
        is ($factory->data_type('aa'), 'aa', 'data_type, aa');

        is ($factory->model, 'LG', 'model, default');

        is ($factory->opt, 'n', 'opt, default');
        is ($factory->opt('tl'), 'tl', 'opt_topology');

        is ($factory->freq, undef, 'freq, default');
        is ($factory->freq('d'), 'd', 'freq');

        is ($factory->search, 'NNI', 'search, default');
        is ($factory->search('SPR'), 'SPR', 'search');

        is ($factory->rand_start, 0, 'rand_start, default');
        is ($factory->rand_start(1), 1, 'rand_start');

        is ($factory->rand_starts, 1, 'rand_starts, default');
        is ($factory->rand_starts(10), 10, 'rand_starts');

        cmp_ok $factory->rand_seed, '>=', 1, 'rand_seed, default';
        is ($factory->rand_seed(10), 10, 'rand_seed');
        $factory->search('NNI'); #to take the fastest option for running

    } else { # version 2.4.4

        is ($factory->data_type, '1', 'data_type, default');
        is ($factory->data_type('dna'), '0', 'data_type, dna');
        is ($factory->data_type('protein'), '1', 'data_type, protein');

        is ($factory->model, 'JTT', 'model, default');

        is ($factory->opt_topology, 'y', 'opt_topology, default');
        is ($factory->opt_topology('0'), 'n', 'opt_topology');
        is ($factory->opt_topology('1'), 'y', 'opt_topology');

        is ($factory->opt_lengths, 'y', 'opt_lengths, default');
        is ($factory->opt_lengths('0'), 'n', 'opt_lengths');
        is ($factory->opt_lengths('1'), 'y', 'opt_lengths');

        for (1..6) {ok 1;} # to have same number of tests for all versions
    }
#    $factory->save_tempfiles(1);
#    my $workdir = '/tmp/phyml_test';
#    $factory->tempdir($workdir);

    # using filename input
    my $tree = $factory->run($inputfilename);
    isa_ok($tree, 'Bio::Tree::Tree');
    my @leaves = $tree->get_leaf_nodes;
    is (@leaves, 3, 'Result tree from filename input had correct number of leaves');

    if ($factory->version >= 3){
	is substr($factory->stats, 2, 9), "ooooooooo", 'stats()';
    } else { # PhyML v2
	is substr($factory->stats, 0, 9), "\n- PHYML ", 'stats()';
    }

    is substr($factory->tree_string, 0, 9), 'BIONJ(SIN', 'tree_string()';


    # using AlignIO on a DNA MSA
    $inputfilename = test_input_file("dna_seqs1.phy");
    ok (-e $inputfilename, 'Found DNA input file');

    my $alignio = Bio::AlignIO->new(-file => $inputfilename);
    my $aln = $alignio->next_aln;

    my $alphabet;
    if ($factory->version >= 3){
	$alphabet = 'nt';
    } else {
	$alphabet = 'dna';
    }

    #testing passing attributes to the constructor
    my %args = (
	-data_type => $alphabet,
	-model => 'JC69',
	-kappa => 4,
	-invar => 'e',
	-category_number => 4,
	-alpha => 'e',
	-tree => 'BIONJ',
	-verbose => 0
	);

    $factory = Bio::Tools::Run::Phylo::Phyml->new(%args);
    $factory->save_tempfiles(1);
    $tree = $factory->run($aln);
    @leaves = $tree->get_leaf_nodes;
    is (@leaves, 5, 'Result tree from DNA SimpleAlign input had correct number of leaves');
}
