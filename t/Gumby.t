# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 124);
    
    use_ok('Bio::Tools::Run::Phylo::Gumby');
    use_ok('Bio::AlignIO');
    use_ok('Bio::TreeIO');
    use_ok('Bio::DB::Taxonomy');
    use_ok('Bio::Tools::GFF');
}

# setup input files etc
my $alignfilename = test_input_file('gumby', 'hmrd.mfa');
my $treefilename = test_input_file('gumby', 'hmrd.tree');
my $gfffilename = test_input_file('gumby', 'human.gff');
ok (-e $alignfilename, 'Found input alignment file');
ok (-e $treefilename, 'Found input tree file');
ok (-e $gfffilename, 'Found input gff file');

my $factory = Bio::Tools::Run::Phylo::Gumby->new(-verbose => -1,
                                                 -quiet => 1);
isa_ok($factory, 'Bio::Tools::Run::Phylo::Gumby');
ok $factory->can('ratio'), 'has a created method not in args';
is $factory->quiet, 1, 'quiet was set';

# test default factory values
is ($factory->program_dir, $ENV{'GUMBYDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'gumby', 'Correct exe default name');

# test the program itself
SKIP: {
    skip("Couldn't find the gumby executable", 111) unless defined $factory->executable();
    
    # using filename input
    ok my @result1 = $factory->run($alignfilename, $treefilename), 'got results using filename input';
    is @result1, 80, 'correct number of results';
    
    # using SimpleAlign and Bio::Tree::Tree input
    my $alignio = Bio::AlignIO->new(-file => $alignfilename);
    my $aln = $alignio->next_aln;
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
    
    # spot-test the results
    my @spot_results = ($result1[0], $result1[1], $result1[2], $result1[3], $result1[-4], $result1[-3], $result1[-2], $result1[-1]);
    foreach my $expected (['human', 5993, 6134, 7098, 1.6e-05], ['mouse', 4201, 4341], ['rat', 3563, 3702], ['dog', 4026, 4165],
                          ['human', 59767, 59825, 2486, 0.42], ['mouse', 46010, 46068], ['rat', 44848, 44906], ['dog', 48054, 48096]) {
        my $feat = shift(@spot_results);
        isa_ok $feat, 'Bio::SeqFeature::Annotated';
        is $feat->seq_id, shift(@{$expected}), 'correct seq_id';
        is $feat->source_tag, 'gumby', 'correct source';
        is $feat->start, shift(@{$expected}), 'correct feature start';
        is $feat->end, shift(@{$expected}), 'correct feature end';
        if (@{$expected}) {
            is $feat->score, shift(@{$expected}), 'correct feature score';
            is ${[$feat->get_tag_values('pvalue')]}[0], shift(@{$expected}), 'correct feature pvalue';
        }
        is ${[$feat->get_tag_values('kind')]}[0], 'all', 'correct feature kind';
    }
    
    # with gff input and econs
    $factory->annots($gfffilename);
    $factory->econs(1);
    ok my @result4 = $factory->run($alignfilename, $treefilename), 'got results using filename input with gff';
    is @result4, 104, 'correct number of results';
    
    # using feature object input
    my $gffin = Bio::Tools::GFF->new(-file => $gfffilename, -gff_version => 2);
    my @features;
    while(my $feature = $gffin->next_feature()) {
        push(@features, $feature);
    }
    $gffin->close();
    $factory->annots(@features);
    
    ok my @result5 = $factory->run($alignfilename, $treefilename), 'got results using filename input with feature objects';
    is @result5, 104, 'correct number of results';
    is_deeply \@result4, \@result5, 'results same for gff and object input';
    
    # spot-test the results
    @spot_results = ($result4[0], $result4[1], $result4[2], $result4[3], $result4[-4], $result4[-3], $result4[-2], $result4[-1]);
    foreach my $expected (['human', 20442, 20507, 'exon'], ['mouse', 16488, 16560, 'exon'], ['rat', 15927, 15999, 'exon'], ['dog', 17469, 17544, 'exon'],
                          ['human', 59992, 60040, 'nonexon'], ['mouse', 46257, 46294, 'nonexon'], ['rat', 45096, 45134, 'nonexon'], ['dog', 48297, 48344, 'nonexon']) {
        my $feat = shift(@spot_results);
        isa_ok $feat, 'Bio::SeqFeature::Annotated';
        is $feat->seq_id, shift(@{$expected}), 'correct seq_id';
        is $feat->source_tag, 'gumby', 'correct source';
        is $feat->start, shift(@{$expected}), 'correct feature start';
        is $feat->end, shift(@{$expected}), 'correct feature end';
        is ${[$feat->get_tag_values('kind')]}[0], shift(@{$expected}), 'correct feature kind';
    }
}
