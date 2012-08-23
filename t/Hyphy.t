# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 8, -requires_module =>'IO::String');

	use_ok('Bio::Tools::Run::Phylo::Hyphy::SLAC');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::FEL');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::REL');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::Modeltest');
}

	my $slac = Bio::Tools::Run::Phylo::Hyphy::SLAC->new();

SKIP: {
	test_skip(-requires_executable => $slac, -tests => 4);

	my $alignio = Bio::AlignIO->new(-format => 'fasta',
						 -file   => 't/data/hyphy1.fasta');

	my $treeio = Bio::TreeIO->new(-format => 'newick',
						 -file   => 't/data/hyphy1.tree');

	my $aln = $alignio->next_aln;
	my $tree = $treeio->next_tree;

	$slac->alignment($aln);
	$slac->tree($tree);
	my ($rc,$results) = $slac->run();
	if ($rc == 0) {
		self->warn("ERROR in SLAC module $rc:" . $slac->error_string() . "\n");
	}
	ok ($rc != 0, "SLAC module");

	my $rel = Bio::Tools::Run::Phylo::Hyphy::REL->new();
	$rel->alignment($aln);
	$rel->tree($tree);
	($rc,$results) = $rel->run();
	if ($rc == 0) {
		self->warn(print "ERROR in REL module $rc:" . $rel->error_string() . "\n");
	}
	ok ($rc != 0, "REL module");

	my $fel = Bio::Tools::Run::Phylo::Hyphy::FEL->new();
	$fel->alignment($aln);
	$fel->tree($tree);
	($rc,$results) = $fel->run();
	if ($rc == 0) {
		self->warn("ERROR in FEL module $rc:" . $fel->error_string() . "\n");
	}
	ok ($rc != 0, "FEL module");

	my $modeltest = Bio::Tools::Run::Phylo::Hyphy::Modeltest->new();
	$modeltest->alignment($aln);
	$modeltest->tree($tree);
	($rc,$results) = $modeltest->run();
	if ($rc == 0) {
		self->warn("ERROR in Modeltest module $rc:" . print $modeltest->error_string() . "\n");
	}
	ok ($rc != 0, "Modeltest module");

	#*** where are the tests?!
}
