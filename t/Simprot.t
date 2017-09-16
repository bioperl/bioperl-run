# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##


# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 6,
			   -requires_module => 'IO::String');
	
	use_ok('Bio::Root::IO');
	use_ok('Bio::Tools::Run::Simprot');
	use_ok('Bio::AlignIO');
	use_ok('Bio::TreeIO');
}

ok my $simprot = Bio::Tools::Run::Simprot->new();

SKIP: {
    test_skip(-requires_executable => $simprot,
              -tests => 1);
	
	my $treeio = Bio::TreeIO->new(
		-format => 'nhx', -file => 't/data/simprot_tree.nh');
	
	my $tree = $treeio->next_tree;
	
	$simprot->tree($tree);
	$simprot->set_parameter("variablegamma",1);
	$simprot->set_parameter("alpha",0.01);
	$simprot->set_parameter("rootLength",1000);
	$simprot->set_parameter("eFactor",15);
	$simprot->set_parameter("indelFrequncy",0.99);
	$simprot->set_parameter("maxIndel",999999);
	$simprot->set_parameter("Benner",0);
	$simprot->set_parameter("bennerk",-2);
	$simprot->set_parameter("subModel",2);
	$simprot->set_parameter("interleaved",1);
	my @nodes = map { $_->id } $tree->get_leaf_nodes;
	
	my ($rc,$alnio,$seq) = $simprot->run();
	my $aln = $alnio->next_aln;
	my @seqs = map { $_->display_name} $aln->each_seq;
	is (scalar(@seqs),scalar(@nodes));
	
	#*** where are the tests?!
}
