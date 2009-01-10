# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 19);
    use_ok('Bio::Tools::Run::Phylo::Semphy');
}

# setup input files
my $alignfilename = test_input_file('semphy.seq');
my $treefilename = test_input_file('semphy.tree');

# object setup and testing
my $factory = Bio::Tools::Run::Phylo::Semphy->new(-quiet => 1, -z => '2.0', -H => 1, -jtt => 1, -S => 1);

isa_ok($factory, 'Bio::Tools::Run::Phylo::Semphy');
ok $factory->can('alphabet'), 'has a created method not in args';
is $factory->ratio, '2.0', 'ratio param was set via -z';
ok $factory->jtt, 'jtt switch was set';

is ($factory->program_dir, $ENV{'SEMPHYDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'semphy', 'Correct exe default name');

# test the program itself
SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 12);
    use_ok('Bio::TreeIO');
    my $tree_out_file = test_output_file();
    my $to = Bio::TreeIO->new(-format => 'newick', 
                              -file => ">$tree_out_file");
    
    # run Semphy with an alignment
    ok my $tree1 = $factory->run($alignfilename);
    $to->write_tree($tree1);
    
    # or with alignment object
    use_ok('Bio::AlignIO');
    my $ai = Bio::AlignIO->new(-file => $alignfilename);
    my $bio_simplalign = $ai->next_aln;
    ok my $tree2 = $factory->run($bio_simplalign);
    $to->write_tree($tree2);
    
    # you can supply an initial tree as well, which can be a newick tree file,
    # Bio::Tree::Tree object...
    my $ti = Bio::TreeIO->new(-file => $treefilename);
    my $tree_obj = $ti->next_tree;
    ok my $tree3 = $factory->run($bio_simplalign, $tree_obj);
    $to->write_tree($tree3);
    
    # ... or Bio::DB::Taxonomy object
    my $expected_count = 3;
    SKIP: {
        test_skip(-tests => 2, -requires_networking => 1);
        
        use_ok('Bio::DB::Taxonomy');
        my $bio_db_taxonomy = Bio::DB::Taxonomy->new(-source => 'entrez');
        ok my $tree4 = $factory->run($bio_simplalign, $bio_db_taxonomy);
        $to->write_tree($tree4);
        $expected_count++;
    }
    
    $to->close;
    
    my $expected_result = '(Cow:0.280119,((Baboon:0.035422,Human:0.080635):0.000213,(Rat:0.198658,Horse:0.642019):0.120910):0.074791,Semnopithecus_entellus:0.016396);';
    
    open(my $res_fh, $tree_out_file);
    my $count = 0;
    while (<$res_fh>) {
        chomp;
        /\S/ || last;
        $count++;
        is $_, $expected_result;
    }
    close($res_fh);
    
    is $count, $expected_count;
    if ($expected_count == 3) {
        ok 1;
    }
}
