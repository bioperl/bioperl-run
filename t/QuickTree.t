# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
   use Bio::Tools::Run::Build::Test;
   skipall_unless_feature('[Phylo]QuickTree');
    test_begin(-tests => 13);
    use_ok('Bio::Tools::Run::Phylo::QuickTree');
    use_ok('Bio::AlignIO');
}


# setup input files etc
my $inputfilename = test_input_file('cysprot.stockholm');
ok (-e $inputfilename, 'Found input file');

my $factory = Bio::Tools::Run::Phylo::QuickTree->new();
isa_ok($factory, 'Bio::Tools::Run::Phylo::QuickTree');

# test default factory values
is ($factory->program_dir, $ENV{'QUICKTREEDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'quicktree', 'Correct exe default name');

# test the program itself
SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 7);
    
    # using filename input
    my $tree = $factory->run($inputfilename);
    isa_ok($tree, 'Bio::Tree::Tree');
    my @leaves = $tree->get_leaf_nodes;
    is (@leaves, 7, 'Result tree from filename input had correct number of leaves');
    
    # using align input
    my $alignio = Bio::AlignIO->new(-file => $inputfilename);
    my $aln = $alignio->next_aln;
    $tree = $factory->run($aln);
    @leaves = $tree->get_leaf_nodes;
    is (@leaves, 7, 'Result tree from SimpleAlign input had correct number of leaves');
    
    # do simple checks on possible options
    is ($factory->upgma(1), 1, 'UPGMA could be set');
    is ($factory->kimura(1), 1, 'kimura could be set');
    is ($factory->boot(100), 100, 'boot could be set');
    $tree = $factory->run($inputfilename);
    
    my @nodes = $tree->get_nodes;
    my %non_internal = map { $_ => 1 } ($tree->get_leaf_nodes, $tree->get_root_node);
    my @bootstraps;
    foreach my $node (@nodes) {
        next if exists $non_internal{$node};
        push(@bootstraps, $node->bootstrap);
    }
    is_deeply([sort { $a <=> $b } @bootstraps], [qw(74 84 100 100 100)], 'bootstraps were correct');
}
