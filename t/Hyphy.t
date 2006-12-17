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

    $NUMTESTS = 4;
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
	skip("unable to run all of the Njtree tests",1);
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
use Bio::Tools::Run::Phylo::Hyphy::SLAC;
use Bio::Tools::Run::Phylo::Hyphy::FEL;
use Bio::Tools::Run::Phylo::Hyphy::REL;
use Bio::Tools::Run::Phylo::Hyphy::Modeltest;
use Bio::AlignIO;
use Bio::TreeIO;

my $alignio = new Bio::AlignIO(-format => 'fasta',
			         -file   => 't/data/hyphy1.fasta');

my $treeio = new Bio::TreeIO(-format => 'newick',
			         -file   => 't/data/hyphy1.tree');

my $aln = $alignio->next_aln;
my $tree = $treeio->next_tree;

my $slac = new Bio::Tools::Run::Phylo::Hyphy::SLAC;
$slac->alignment($aln);
$slac->tree($tree);
my ($rc,$results) = $slac->run();
ok(defined($results), 1);

my $rel = new Bio::Tools::Run::Phylo::Hyphy::REL;
$rel->alignment($aln);
$rel->tree($tree);
my ($rc,$results) = $rel->run();
ok(defined($results), 1);

my $fel = new Bio::Tools::Run::Phylo::Hyphy::FEL;
$fel->alignment($aln);
$fel->tree($tree);
my ($rc,$results) = $fel->run();
ok(defined($results), 1);

my $modeltest = new Bio::Tools::Run::Phylo::Hyphy::Modeltest;
$modeltest->alignment($aln);
$modeltest->tree($tree);
my ($rc,$results) = $modeltest->run();
ok(defined($results), 1);

1;
