# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = $ENV{'BIOPERLDEBUG'} || -1;

BEGIN {
    eval { require Test; };
    if( $@ ) { 
	use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 7;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::Phylo::Phylip::Consense;
use Bio::AlignIO;

END {     
    for ( $Test::ntest..$NTESTS ) {
    	skip("consense not found. Skipping.",1);
    }
}

ok(1);
my $verbose = $DEBUG;
my $sb_factory = new Bio::Tools::Run::Phylo::Phylip::Consense
    (-verbose => $verbose);
unless($sb_factory->executable){
    warn("Consense program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

ok $sb_factory->isa('Bio::Tools::Run::Phylo::Phylip::Consense');

$sb_factory->rooted(1);

ok $sb_factory->rooted, 1, "coludn't set rooted option";


my $bequiet = $verbose > 0 ? 0 : 1;
$sb_factory->quiet($bequiet);  # Suppress protpars messages to terminal 

my $inputfilename = Bio::Root::IO->catfile("t","data","consense.treefile");
my $tree = $sb_factory->run($inputfilename);

ok $tree->number_nodes, 12;

my $node = $tree->find_node('CATH_RAT');
ok $node->branch_length, "10.0";
ok $node->id, 'CATH_RAT';

my @nodes = $tree->get_nodes;

ok scalar(@nodes),13;


