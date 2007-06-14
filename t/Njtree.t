# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
use vars qw($NUMTESTS);

BEGIN {
    $NUMTESTS = 6;
	
    eval {require Test::More;};
	if ($@) {
		use lib 't/lib';
	}
	use Test::More;
	
    eval {require IO::String };
	if ($@) {
		plan skip_all => 'IO::String not installed. This means that the module is not usable. Skipping tests';
	}
	else {
		plan tests => $NUMTESTS;
	}
	
	use_ok('Bio::Root::IO');
	use_ok('Bio::Tools::Run::Phylo::Njtree::Best');
	use_ok('Bio::AlignIO');
	use_ok('Bio::TreeIO');
}

ok my $njtree_best = Bio::Tools::Run::Phylo::Njtree::Best->new();

SKIP: {
	my $njtree_present = $njtree_best->executable();
    
    unless ($njtree_present) {
        skip("NJtree program not found. Skipping tests", ($NUMTESTS - 5));
    }
	
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
