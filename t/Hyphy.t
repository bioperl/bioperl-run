# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 10, -requires_module =>'IO::String');


	use_ok('Bio::Tools::Run::Phylo::Hyphy::SLAC');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::FEL');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::REL');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::Modeltest');
	use_ok('Bio::Tools::Run::Phylo::Hyphy::BatchFile');
}


SKIP: {
	my $rel = Bio::Tools::Run::Phylo::Hyphy::REL->new();

	test_skip(-requires_executable => $rel, -tests => 4);

	my $alignio = Bio::AlignIO->new(-format => 'fasta',
						 -file   => 't/data/hyphy1.fasta');

	my $treeio = Bio::TreeIO->new(-format => 'newick',
						 -file   => 't/data/hyphy1.tree');

	my $aln = $alignio->next_aln;
	my $tree = $treeio->next_tree;
	my $debug = test_debug();
	my ($rc,$results);

	my $rel = Bio::Tools::Run::Phylo::Hyphy::REL->new();
	$rel->alignment($aln);
	$rel->tree($tree);
	($rc,$results) = $rel->run();
	if (($rc == 0) && ($debug == 1)){
		warn("ERROR in REL module $rc:" . $rel->error_string() . "\n");
	}
	ok ($rc != 0, "REL module");

	my $fel = Bio::Tools::Run::Phylo::Hyphy::FEL->new();
	$fel->alignment($aln);
	$fel->tree($tree);
	($rc,$results) = $fel->run();
	if (($rc == 0) && ($debug == 1)){
		warn("ERROR in FEL module $rc:" . $fel->error_string() . "\n");
	}
	ok (defined($results->{'LRT'}), "FEL module");

	my $modeltest = Bio::Tools::Run::Phylo::Hyphy::Modeltest->new();
	$modeltest->alignment($aln);
	$modeltest->tree($tree);
	($rc,$results) = $modeltest->run();
	if (($rc == 0) && ($debug == 1)){
		warn("ERROR in Modeltest module $rc:" . $modeltest->error_string() . "\n");
	}
	ok (defined($results->{'AIC'}), "Modeltest module");

	my $bf_exec = Bio::Tools::Run::Phylo::Hyphy::BatchFile->new(-params => {'bf' => "ModelTest.bf", 'order' => [$aln, $tree, '4', 'AIC Test', ""]});
	$bf_exec->alignment($aln);
	$bf_exec->tree($tree);
	my ($tfh, $t) = $bf_exec->io->tempfile;
 	$bf_exec->set_parameter(5, $t);
 	$bf_exec->version();
 	($rc,$results) = $bf_exec->run();
	if (($rc == 0) && ($debug == 1)){
		warn("ERROR in Batchfile module $rc:" . $bf_exec->error_string() . "\n");
	}
 	ok ($rc != 0, "Batchfile module");

	my $slac = Bio::Tools::Run::Phylo::Hyphy::SLAC->new();
	$slac->alignment($aln);
	$slac->tree($tree);
	($rc,$results) = $slac->run();
	if (($rc == 0) && ($debug == 1)){
		warn("ERROR in SLAC module $rc:" . $slac->error_string() . "\n");
	}
	ok (defined($results->{'Observed NS Changes'}), "SLAC module");
}
