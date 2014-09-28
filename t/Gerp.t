# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Phylo]Gerp');
    
    test_begin(-tests => 33);
    
    use_ok('Bio::Tools::Run::Phylo::Gerp');
    use_ok('Bio::AlignIO');
    use_ok('Bio::TreeIO');
    use_ok('Bio::Root::Utilities');
}

END {
    unlink(test_input_file('gerp', 'ENr111.mfa'));
}

# setup input files etc
my $alignfilename = test_input_file('gerp', 'ENr111.mfa.gz');
my $treefilename  = test_input_file('gerp', 'ENr111.gerp.tree');
ok (-e $alignfilename, 'Found input alignment file');
ok (-e $treefilename, 'Found input tree file');

my $factory = Bio::Tools::Run::Phylo::Gerp->new(-verbose => -1,
                                                -quiet => 1);
isa_ok($factory, 'Bio::Tools::Run::Phylo::Gerp');
ok $factory->can('e'), 'has a created method not in args supplied to new';
is $factory->quiet, 1, 'quiet was set';

# test default factory values
is ($factory->program_dir, $ENV{'GERPDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'gerpcol', 'Correct exe default name');

# test the program itself
SKIP: {
    test_skip(-requires_executable => $factory, -tests => 22);
    
    my $util = Bio::Root::Utilities->new();
    $alignfilename = $util->uncompress(-file => $alignfilename,
                                       -tmp  => 1);
    
    skip("Couldn't uncompress the alingment input file", 22) unless $alignfilename;
    
    # using filename input
    ok my $parser = $factory->run($alignfilename, $treefilename), 'got results using filename input';
    my @result1;
    while (my $result = $parser->next_result) {
        push(@result1, $result);
    }
    ok close_enough(scalar(@result1), 121, 20), 'reasonable number of results using filename input';
    
    # using SimpleAlign and Bio::Tree::Tree input
    my $alignio = Bio::AlignIO->new(-file => $alignfilename);
    my $aln = $alignio->next_aln;
    my $treeio = Bio::TreeIO->new(-verbose => -1, -file => $treefilename);
    my $tree = $treeio->next_tree;
    ok $parser = $factory->run($aln, $tree), 'got results using object input';
    my @result2;
    while (my $result = $parser->next_result) {
        push(@result2, $result);
    }
    ok close_enough(scalar(@result2), 121, 20), 'reasonable number of results using object input';
    
    # spot-test the results
    my @spot_results = ($result1[0], $result1[1], $result1[2]);
    
    foreach my $expected ([294576, 294688, 56.5, 1.76552e-57],
                          [337735, 337898, 50.9, 3.19063e-57],
                          [285430, 285608, 44.3, 1.41149e-54]) {
        my $feat = shift(@spot_results);
        isa_ok $feat, 'Bio::SeqFeature::Annotated';
        is $feat->source->value, 'GERP', 'correct source';
        ok close_enough($feat->start, shift(@{$expected}), 10), 'feature start close enough';
        ok close_enough($feat->end, shift(@{$expected}), 10), 'feature end close enough';
        ok close_enough($feat->score, shift(@{$expected}), 5), 'feature score close enough';
        my ($p_value) = $feat->get_Annotations('pvalue');
        ok close_enough(ref $p_value ? $p_value->value : $p_value, shift(@{$expected}), 100e-57), 'feature pvalue close enough';
    }
}

sub close_enough {
    my ($actual, $expected, $variance) = @_;
    return 1 if $actual == $expected;
    
    if ($actual >= ($expected - $variance) &&
        $actual <= ($expected + $variance)) {
        return 1;
    }
    return 0;
}
