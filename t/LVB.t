# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use vars qw($DEBUG );
$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;

use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) { 
	use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 20;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::Phylo::LVB;
use Bio::AlignIO;
END {     
    for ( $Test::ntest..$NTESTS ) {
	skip("LVB not found. Skipping.",1);
    }
}

ok(1);
my $tree_factory = Bio::Tools::Run::Phylo::LVB->new();
ok $tree_factory->isa('Bio::Tools::Run::Phylo::LVB');

unless($tree_factory->executable){
    warn("LVB program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

my $default_format = "interleaved";
my $format = $tree_factory->format;
ok $format, $default_format, "default is wrong for format parameter";
$format = "sequential";
$tree_factory->format($format);
my $new_format = $tree_factory->format();
ok $new_format, $format, "couldn't set format parameter";
$format = "interleaved";
$tree_factory->format($format);
$new_format = $tree_factory->format();
ok $new_format, $format, "couldn't reset format parameter";

my $default_gaps = "unknown";
my $gaps = $tree_factory->gaps;
ok $gaps, $default_gaps, "default is wrong for gaps parameter";
$gaps = "fifthstate";
$tree_factory->gaps($gaps);
my $new_gaps = $tree_factory->gaps();
ok $new_gaps, $gaps, "couldn't set gaps parameter";
$gaps = "unknown";
$tree_factory->gaps($gaps);
$new_gaps = $tree_factory->gaps();
ok $new_gaps, $gaps, "couldn't reset gaps parameter";

my $default_seed = "";
my $seed = $tree_factory->seed;
ok $seed, $default_seed, "default is wrong for seed parameter";
$seed = "96901";
$tree_factory->seed($seed);
my $new_seed = $tree_factory->seed();
ok $new_seed, $seed, "couldn't set seed parameter";

my $default_duration = "slow";
my $duration = $tree_factory->duration;
ok $duration, $default_duration, "default is wrong for duration parameter";
$duration = "fast";
$tree_factory->duration($duration);
my $new_duration = $tree_factory->duration();
ok $new_duration, $duration, "couldn't set duration parameter";
$duration = "slow";
$tree_factory->duration($duration);
$new_duration = $tree_factory->duration();
ok $new_duration, $duration, "couldn't reset duration parameter";

my $default_bootstraps = 0;
my $bootstraps = $tree_factory->bootstraps;
ok $bootstraps, $default_bootstraps, "default is wrong for bootstraps parameter";
$bootstraps = "10000";
$tree_factory->bootstraps($bootstraps);
my $new_bootstraps = $tree_factory->bootstraps();
ok $new_bootstraps, $bootstraps, "couldn't set bootstraps parameter";
$bootstraps = 0;
$tree_factory->bootstraps($bootstraps);
$new_bootstraps = $tree_factory->bootstraps();
$new_bootstraps = $tree_factory->bootstraps();
ok $new_bootstraps, $bootstraps, "couldn't reset seed parameter";

my $bequiet = 1;
$tree_factory->quiet($bequiet);  # Suppress LVB messages to terminal 

my @trees;

# TEST 17
$tree_factory->format("sequential");
my $inputfilename = Bio::Root::IO->catfile("t","data","lvb_sequential.phy");
@trees = $tree_factory->create_tree($inputfilename);
ok scalar(@trees), 3, "create_tree failed to create array of trees from file";

# TEST 18
$inputfilename = Bio::Root::IO->catfile("t","data","lvb.fa");
my $align_in = Bio::AlignIO->new(-file => $inputfilename, -format => "fasta");
my $align_obj = $align_in->next_aln;
@trees = $tree_factory->run($align_obj);
ok scalar(@trees), 3, "run failed to create array of trees from object";

$tree_factory->gaps("fifthstate");
@trees = $tree_factory->run($align_obj);
ok scalar(@trees), 1, "run failed to create tree with fifthstate on";

$tree_factory->bootstraps(7);
@trees = $tree_factory->run($align_obj);
my $enough_trees = "no";
$enough_trees = "yes" if scalar(@trees) >= 7;
ok $enough_trees, "yes", "run failed to create enough bootstrap trees";
