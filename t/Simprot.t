# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

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

    $NUMTESTS = 1;
    plan tests => $NUMTESTS;

    unless (eval "require IO::String; 1;") {
        print STDERR "IO::String not installed. Skipping tests $Test::ntest to $NUMTESTS.\n";
        for ($Test::ntest..$NUMTESTS){
            skip(1,1);    
        }
        exit(0);
    }
}

if( $error ==  1 ) {
    exit(0);
}
END { 
    foreach ( $Test::ntest .. $NUMTESTS ) {
	skip("unable to run all of the Simprot tests",1);
    }
}
my $testnum;
my $verbose = 0;

## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run. 

use Bio::Root::IO;
use Bio::Tools::Run::Simprot;
use Bio::AlignIO;
use Bio::TreeIO;

my $treeio = Bio::TreeIO->new(
    -format => 'nhx', -file => 't/data/simprot_tree.nh');

my $tree = $treeio->next_tree;

my $simprot = new Bio::Tools::Run::Simprot();
$simprot->tree($tree);
$simprot->set_parameter("variablegamma",1);
$simprot->set_parameter("alpha",0.01);
$simprot->set_parameter("rootLength",1000);
$simprot->set_parameter("eFactor",15);
$simprot->set_parameter("indelFrequncy",0.99);
$simprot->set_parameter("maxIndel",999999);
$simprot->set_parameter("Benner",0);
$simprot->set_parameter("bennerk",-2);
$simprot->set_parameter("subModel",2);
$simprot->set_parameter("interleaved",1);
my @nodes = map { $_->id } $tree->get_leaf_nodes;
my ($rc,$alnio,$seq) = $simprot->run();
my $aln = $alnio->next_aln;
my @seqs = map { $_->display_name} $aln->each_seq;
ok(scalar(@seqs),scalar(@nodes));



1;
