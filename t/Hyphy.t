# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
use vars qw($NUMTESTS);

BEGIN {
    $NUMTESTS = 15;
	
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
	use_ok('Bio::Tools::Run::Phylo::Hyphy::SLAC');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::FEL');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::REL');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::Modeltest');
	use_ok('Bio::AlignIO');
	use_ok('Bio::TreeIO');
}

ok my $slac = Bio::Tools::Run::Phylo::Hyphy::SLAC->new();
ok my $rel = Bio::Tools::Run::Phylo::Hyphy::REL->new();
ok my $fel = Bio::Tools::Run::Phylo::Hyphy::FEL->new();
ok my $modeltest = Bio::Tools::Run::Phylo::Hyphy::Modeltest->new();

SKIP: {
	my $present = $slac->executable();
    
    unless ($present) {
        skip("Hyphy program not found. Skipping tests", ($NUMTESTS - 11));
    }
	
	my $alignio = Bio::AlignIO->new(-format => 'fasta',
						 -file   => 't/data/hyphy1.fasta');
	
	my $treeio = Bio::TreeIO->new(-format => 'newick',
						 -file   => 't/data/hyphy1.tree');
	
	my $aln = $alignio->next_aln;
	my $tree = $treeio->next_tree;
	
	$slac->alignment($aln);
	$slac->tree($tree);
	my ($rc,$results) = $slac->run();
	ok defined($results);
	
	$rel->alignment($aln);
	$rel->tree($tree);
	($rc,$results) = $rel->run();
	ok defined($results);
	
	$fel->alignment($aln);
	$fel->tree($tree);
	($rc,$results) = $fel->run();
	ok defined($results);
	
	$modeltest->alignment($aln);
	$modeltest->tree($tree);
	($rc,$results) = $modeltest->run();
	ok defined($results);
	
	#*** where are the tests?!
}
