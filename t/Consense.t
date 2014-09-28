# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Phylo]Consense');
    test_begin(-tests => 8,
			   -requires_module => 'IO::String');
	use_ok('Bio::Tools::Run::Phylo::Phylip::Consense');
	use_ok('Bio::AlignIO');
}

my $verbose = test_debug();

my $sb_factory = Bio::Tools::Run::Phylo::Phylip::Consense->new(-verbose => $verbose);

SKIP: {
	test_skip(-requires_executable => $sb_factory,
             -tests => 6);

	isa_ok($sb_factory,'Bio::Tools::Run::Phylo::Phylip::Consense');
	
	$sb_factory->rooted(1);
	
	is $sb_factory->rooted, 1, "could not set rooted option";

	$sb_factory->quiet($verbose);  # Suppress protpars messages to terminal 
	
	my $inputfilename = test_input_file("consense.treefile");
	my $tree = $sb_factory->run($inputfilename);
	
	is $tree->number_nodes, 13;
	
	my $node = $tree->find_node('CATH_RAT');
	is $node->branch_length, "10.0";
	is $node->id, 'CATH_RAT';
	
	my @nodes = $tree->get_nodes;
	
	is scalar(@nodes),13;
}	
