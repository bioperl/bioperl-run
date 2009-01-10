# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;

BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 6,
			   -requires_module => 'IO::String');
	use_ok('Bio::Root::IO');
	use_ok('Bio::Tools::Run::Phylo::Njtree::Best');
	use_ok('Bio::AlignIO');
	use_ok('Bio::TreeIO');
}

ok my $njtree_best = Bio::Tools::Run::Phylo::Njtree::Best->new();

SKIP: {
	test_skip(-requires_executable => $njtree_best,
			  -tests => 1);
	
	my $alignio = Bio::AlignIO->new(-format => 'fasta',
									-file   => 't/data/njtree_aln2.nucl.mfa');
	
	my $aln = $alignio->next_aln;
	
	my $treeio = Bio::TreeIO->new(
		-format => 'nhx', -file => 't/data/species_tree_njtree.nh');
	
	my $tree = $treeio->next_tree;
	
	$njtree_best->alignment($aln);
	$njtree_best->tree($tree);
	$njtree_best->check_names();
	
	my ($rc,$nhx_tree) = $njtree_best->run();
	print $njtree_best->error_string, "\n";
	ok $nhx_tree;
	
	#*** where are the tests?!
}
