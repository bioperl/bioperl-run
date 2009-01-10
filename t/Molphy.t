# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
use vars qw($NUMTESTS);

my $error;
my $serror;

BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 10,
			   -requires_module => 'IO::String');
	use_ok('Bio::Tools::Phylo::Molphy'); # PAML parser
	use_ok('Bio::Tools::Run::Phylo::Molphy::ProtML');
	use_ok('Bio::AlignIO');
}

my $verbose = test_debug();

END { unlink('protml.eps'); }
## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run. 

my %args = ( 'models' => 'jtt', 
	     'search' => 'quick', 
	     "other" => [ '-information', '-w']); 
my $protml = Bio::Tools::Run::Phylo::Molphy::ProtML->new(-verbose => $verbose,
							-flags => \%args);

SKIP: {
	test_skip(-requires_executable => $protml,
			  -tests => 7);

	my $in = Bio::AlignIO->new(-format => 'clustalw',
				-file   => test_input_file('cel-cbr-fam.aln'));
	my $aln = $in->next_aln;
	$protml->alignment($aln);
	
	my ($rc,$results) = $protml->run();
	is($rc,1);
	my $r = $results->next_result;
	ok($r);
	my @trees;
	while( my $t = $r->next_tree ) { 
		push @trees, $t;
	}
	is(@trees,1);
	is($r->model, 'JTT');
	is($r->search_space,50);
	is($trees[0]->score, -453.1);
	ok($protml->error_string !~ /Error/); # we don't expect any errors;

}