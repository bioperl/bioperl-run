# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use vars qw($DEBUG );
$DEBUG = test_debug();

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 19);
	use_ok('Bio::Tools::Run::Phylo::LVB');
	use_ok('Bio::AlignIO');
}

my $tree_factory = Bio::Tools::Run::Phylo::LVB->new();
isa_ok $tree_factory, 'Bio::Tools::Run::Phylo::LVB';

SKIP: {
	test_skip(-requires_executable => $tree_factory,
			  -tests => 16);

	my $default_format = "interleaved";
	my $format = $tree_factory->format;
	is $format, $default_format, "default is wrong for format parameter";
	$format = "sequential";
	$tree_factory->format($format);
	my $new_format = $tree_factory->format();
	is $new_format, $format, "couldn't set format parameter";
	$format = "interleaved";
	$tree_factory->format($format);
	$new_format = $tree_factory->format();
	is $new_format, $format, "couldn't reset format parameter";
	
	my $default_gaps = "unknown";
	my $gaps = $tree_factory->gaps;
	is $gaps, $default_gaps, "default is wrong for gaps parameter";
	$gaps = "fifthstate";
	$tree_factory->gaps($gaps);
	my $new_gaps = $tree_factory->gaps();
	is $new_gaps, $gaps, "couldn't set gaps parameter";
	$gaps = "unknown";
	$tree_factory->gaps($gaps);
	$new_gaps = $tree_factory->gaps();
	is $new_gaps, $gaps, "couldn't reset gaps parameter";
	
	my $default_seed = "";
	my $seed = $tree_factory->seed;
	is $seed, $default_seed, "default is wrong for seed parameter";
	$seed = "96901";
	$tree_factory->seed($seed);
	my $new_seed = $tree_factory->seed();
	is $new_seed, $seed, "couldn't set seed parameter";
	
	my $default_duration = "slow";
	my $duration = $tree_factory->duration;
	is $duration, $default_duration, "default is wrong for duration parameter";
	$duration = "fast";
	$tree_factory->duration($duration);
	my $new_duration = $tree_factory->duration();
	is $new_duration, $duration, "couldn't set duration parameter";
	$duration = "slow";
	$tree_factory->duration($duration);
	$new_duration = $tree_factory->duration();
	is $new_duration, $duration, "couldn't reset duration parameter";
	
	my $default_bootstraps = 0;
	my $bootstraps = $tree_factory->bootstraps;
	is $bootstraps, $default_bootstraps, "default is wrong for bootstraps parameter";
	$bootstraps = "10000";
	$tree_factory->bootstraps($bootstraps);
	my $new_bootstraps = $tree_factory->bootstraps();
	is $new_bootstraps, $bootstraps, "couldn't set bootstraps parameter";
	$bootstraps = 0;
	$tree_factory->bootstraps($bootstraps);
	$new_bootstraps = $tree_factory->bootstraps();
	$new_bootstraps = $tree_factory->bootstraps();
	is $new_bootstraps, $bootstraps, "couldn't reset seed parameter";
	
	my $bequiet = 1;
	$tree_factory->quiet($bequiet);  # Suppress LVB messages to terminal 
	
	my @trees;
	
	# TEST 17
	$tree_factory->format("sequential");
	my $inputfilename = test_input_file("lvb_sequential.phy");
	@trees = $tree_factory->create_tree($inputfilename);
	is scalar(@trees), 3, "create_tree failed to create array of trees from file";
	
	# TEST 18
	$inputfilename = test_input_file("lvb.fa");
	my $align_in = Bio::AlignIO->new(-file => $inputfilename, -format => "fasta");
	my $align_obj = $align_in->next_aln;
	@trees = $tree_factory->run($align_obj);
	is scalar(@trees), 3, "run failed to create array of trees from object";
	
	$tree_factory->gaps("fifthstate");
	@trees = $tree_factory->run($align_obj);
	is scalar(@trees), 1, "run failed to create tree with fifthstate on";
	
	$tree_factory->bootstraps(7);
	@trees = $tree_factory->run($align_obj);
	my $enough_trees = "no";
	$enough_trees = "yes" if scalar(@trees) >= 7;
	is $enough_trees, "yes", "run failed to create enough bootstrap trees";
}