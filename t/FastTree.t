# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
# Before `./Build install' is performed this script should be runnable with
# `./Build test --test_files test.t'. After `./Build install' it should work as `perl test.t'

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(
        -tests => 9,
    );
    use_ok('Bio::Root::IO');
    use_ok('Bio::Tools::Run::Phylo::FastTree');
    use_ok('Bio::AlignIO');
}

ok (my $ft = Bio::Tools::Run::Phylo::FastTree->new( -quiet => 1 ),"Make the object");

SKIP: {
    test_skip(
        -requires_executable => $ft,
        -tests               => 5
    );

    # The input could be a SimpleAlign object
    my $alignio = Bio::AlignIO->new(
        -format => 'fasta',
        -file   => test_input_file('219877.cdna.fasta')
    );
    my $alnobj = $alignio->next_aln;

    my $tree = $ft->run($alnobj);
    ok( defined($tree), "Tree is defined" );
    my @nodes = $tree->get_nodes;
    is($#nodes,3,"Number of nodes is correct");

    # The input could be an alignment file (fasta or phylip interleaved)
    my $alignfile = test_input_file("sample_dataset_1_aligned.fa");
    my $fastft = Bio::Tools::Run::Phylo::FastTree->new( -quiet => 1, -fastest => 1 );
    $tree = $fastft->run($alignfile);
    ok( defined($tree), "Tree is defined" );

    my $slowft = Bio::Tools::Run::Phylo::FastTree->new(
        -quiet   => 1,
        -mlacc   => 2,
        -slownni => 1,
        -spr     => 4
    );
    $tree = $slowft->run($alignfile);
    ok( defined($tree), "Tree is defined" );

    # Input is protein sequence alignment
    $alignio = Bio::AlignIO->new(
        -format => 'msf',
        -file   => test_input_file('cysprot.msf')
    );
    $alnobj = $alignio->next_aln;

    my $ptree = $ft->run($alnobj);
    ok( defined($tree), "Tree is defined" );
}
