## Bioperl Test Harness Script for Modules

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
use vars qw($NUMTESTS);

my $error;

BEGIN { 
    # to handle systems with no installed Test module
    # we include the t dir (where a copy of Test.pm is located)
    # as a fallback
    eval { require Test; };
    $error = 0;
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 6;
    plan tests => $NUMTESTS;
}

if( $error ==  1 ) {
    exit(0);
}
END { 
    foreach ( $Test::ntest .. $NUMTESTS ) {
	skip("unable to run all of the primate tests",1);
    }
}
my $testnum;
my $verbose = 0;

## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run. 

use Bio::Tools::Run::Primate; # PAML parser

use Bio::SeqIO;

my $query = "t/data/primate_query.fa";
my $target= "t/data/primate_target.fa";

my @params = ("query" => $query,"target" => $target,"m"=>0,"b"=>"TRUE");
my $fact = Bio::Tools::Run::Primate->new(@params);
ok($fact->isa("Bio::Tools::Run::Primate"));
my @feat = $fact->search;

ok ($feat[0]->isa("Bio::SeqFeature::Generic"));

ok ($feat[2]->start,11);
ok ($feat[5]->end,33);
ok ($feat[6]->seq->seq,"TATTTCTAC");
ok ($feat[12]->strand,-1);

