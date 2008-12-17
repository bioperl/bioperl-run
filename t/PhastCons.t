# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 181,
	       -requires_modules => [qw(Clone)]);
    use_ok('Bio::Tools::Run::Phylo::Phast::PhastCons');
    use_ok('Bio::AlignIO');
    use_ok('Bio::TreeIO');
    use_ok('Bio::DB::Taxonomy');

}

# setup input files etc
my $alignfilename = test_input_file("apes.multi_fasta");
my $treefilename = test_input_file("apes.newick");
ok (-e $alignfilename, 'Found input alignment file');
ok (-e $treefilename, 'Found input tree file');

my $factory = Bio::Tools::Run::Phylo::Phast::PhastCons->new(-verbose => -1,
                                                            -quiet => 1,
                                                            '-expected-length' => 3,
                                                            Target_coverage => 0.286,
                                                            '--rho' => 0.01);
isa_ok($factory, 'Bio::Tools::Run::Phylo::Phast::PhastCons');
ok $factory->can('ignore_missing'), 'has a created method not in args';
is $factory->expected_length, 3, 'dashed parameter with internal dash was set';
ok ! $factory->can('Target_coverage'), "wrong-case method wasn't created";
is $factory->target_coverage, 0.286, 'dashless wrong-case parameter was set';
is $factory->C, 0.286, 'synonym installed and accessed primary value';
is $factory->rho, 0.01, 'double-dashed parameter was set';

# test default factory values
is ($factory->program_dir, $ENV{'PHASTDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'phastCons', 'Correct exe default name');

# test the program itself
SKIP: {
    skip("Couldn't find the phastCons executable", 166) unless defined $factory->executable();
    
    # using filename input
    ok my @result1 = $factory->run($alignfilename, $treefilename), 'got results using filename input';
    
    # using SimpleAlign and Bio::Tree::Tree input
    my $alignio = Bio::AlignIO->new(-file => $alignfilename);
    my $aln = $alignio->next_aln;
    $aln->id('apes');
    my $treeio = Bio::TreeIO->new(-verbose => -1, -file => $treefilename);
    my $tree = $treeio->next_tree;
    ok my @result2 = $factory->run($aln, $tree), 'got results using object input';
    
    # using database to generate species tree
    my $tdb = Bio::DB::Taxonomy->new(-source => 'flatfile',
        -directory => test_output_dir(),
        -nodesfile => test_input_file('taxdump','nodes.dmp'),
        -namesfile => test_input_file('taxdump','names.dmp'));
    
    ok my @result3 = $factory->run($aln, $tdb), 'got results using db input';
    
    is_deeply \@result1, \@result2, 'results same for file and object input';
    is_deeply \@result1, \@result3, 'results same for file and db input';
    
    # test the results
    my @apes = qw(human chimpanzee Cross_river_gorilla orangutan common_gibbon crested_gibbon siamang mountain_gorilla Hoolock_gibbon silvery_gibbon);
    is @result1, 20, 'correct number of results';
    foreach my $expected (['apes.1', 10, 14], ['apes.2', 26, 30]) {
        foreach my $i (0..9) {
            my $feat = shift(@result1);
            isa_ok $feat, 'Bio::SeqFeature::Annotated';
            is $feat->seq_id, $apes[$i], 'correct seq_id';
            is $feat->source->value, 'phastCons', 'correct source';
            is ${[$feat->annotation->get_Annotations('Name')]}[0]->value, ${$expected}[0], 'correct feature name';
            is $feat->start, ${$expected}[1], 'correct feature start';
            is $feat->end, ${$expected}[2], 'correct feature end';
            is $feat->score, 6, 'correct feature score';
            is $feat->strand, 1, 'correct feature strand';
        }
    }
}
