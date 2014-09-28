# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
# Before `./Build install' is performed this script should be runnable with
# `./Build test --test_files test.t'. After `./Build install' it should work as `perl test.t'

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Phylo]Raxml');
    test_begin(
        -tests => 9,
    );
    use_ok('Bio::Root::IO');
    use_ok('Bio::Tools::Run::Phylo::Raxml');
    use_ok('Bio::AlignIO');
}

END { unlink glob "RAxML_*.*"; }

ok(my $raxml = Bio::Tools::Run::Phylo::Raxml->new(-p => 100, -quiet => 1), "Make the object");
isa_ok( $raxml, 'Bio::Tools::Run::Phylo::Raxml');

SKIP: {
    test_skip(
        -requires_executable => $raxml,
        -tests               => 4
    );

    # The input could be an alignment file in phylip format
    my $alignfile = test_input_file("testaln.phylip");
    my $tree = $raxml->run($alignfile);
    ok( defined($tree), "Tree is defined" );

    # The input could be a SimpleAlign object
    my $alignio = Bio::AlignIO->new(
        -format => 'phylip',
        -file   => test_input_file('testaln.phylip')
    );
    my $alnobj = $alignio->next_aln;

    $raxml = Bio::Tools::Run::Phylo::Raxml->new(-p => 100, -quiet => 1);
    $tree = $raxml->run($alnobj);
    ok( defined($tree), "Tree is defined" );
    my @nodes = $tree->get_nodes;
    is($#nodes,5, "Number of nodes is correct");

    # Input is protein sequence alignment
    $alignio = Bio::AlignIO->new(
        -format => 'msf',
        -file   => test_input_file('cysprot.msf')
    );
    $alnobj = $alignio->next_aln;

    $raxml = Bio::Tools::Run::Phylo::Raxml->new(-quiet => 1, -p => 100);
    my $ptree = $raxml->run($alnobj);
    ok( defined($ptree), "Tree is defined" );
}
