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
    # to handle systems with no installed Test module
    # we include the t dir (where a copy of Test.pm is located)
    # as a fallback
    eval { require Test; };
    if( $@ ) {
	use lib 't';
    }
    use Test;
    
    $NUMTESTS = 7;
    plan tests => $NUMTESTS;

    unless (eval "require IO::String; 1;") {
            print STDERR ("IO::String not installed. Skipping tests $Test::ntest to $NUMTESTS.\n");
            for ($Test::ntest..$NUMTESTS){
                skip(1,1);
            }
            exit(0);
    }
}

my $verbose = $ENV{'BIOPERLDEBUG'};

END { unlink('protml.eps'); }
## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run. 

use Bio::Tools::Phylo::Molphy; # PAML parser
use Bio::Tools::Run::Phylo::Molphy::ProtML;
use Bio::AlignIO;

END {     
    for ( $Test::ntest..$NTESTS ) {
        skip("Molphy not found. Skipping.",1);
    }
}

 
my %args = ( 'models' => 'jtt', 
	     'search' => 'quick', 
	     "other" => [ '-information', '-w']); 
my $protml = new Bio::Tools::Run::Phylo::Molphy::ProtML(-verbose => $verbose,
							-flags => \%args);
unless ($protml->executable){
  warn("Molphy package not installed. Skipping tests $Test::ntest to $NUMTESTS.\n");
exit(0) ;
}

my $in = new Bio::AlignIO(-format => 'clustalw',
			  -file   => Bio::Root::IO->catfile('t','data',
							    'cel-cbr-fam.aln'));
my $aln = $in->next_aln;
$protml->alignment($aln);

my ($rc,$results) = $protml->run();
ok($rc,1);
my $r = $results->next_result;
ok($r);
my @trees;
while( my $t = $r->next_tree ) { 
    push @trees, $t;
}
ok(@trees,1);
ok($r->model, 'JTT');
ok($r->search_space,50);
ok($trees[0]->score, -453.1);
ok($protml->error_string !~ /Error/); # we don't expect any errors;

