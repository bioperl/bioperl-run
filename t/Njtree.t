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
    # FIXME: delete this
    $ENV{NJTREEDIR} = '/home/avilella/9_opl/treesoft/treesoft/njtree';

    eval { require Test; };
    $error = 0;
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 2;
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
use Bio::Tools::Run::Phylo::Njtree::Best;
use Bio::AlignIO;
use Bio::TreeIO;

my $alignio = Bio::AlignIO->new(-format => 'fasta',
                               -file   => 't/data/njtree_aln2.nucl.mfa');

my $aln = $alignio->next_aln;

my $treeio = Bio::TreeIO->new(
    -format => 'nhx', -file => 't/data/species_tree_njtree.nh');

my $tree = $treeio->next_tree;

my $njtree_best = Bio::Tools::Run::Phylo::Njtree::Best->new();
$njtree_best->alignment($aln);
$njtree_best->tree($tree);
$njtree_best->check_names();
my ($rc,$nhx_tree) = $njtree_best->run();
print $njtree_best->error_string, "\n";
ok($nhx_tree, 1);
1;
