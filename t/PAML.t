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

    $NUMTESTS = 9;
    plan tests => $NUMTESTS;
}

if( $error ==  1 ) {
    exit(0);
}
END { 
    foreach ( $Test::ntest .. $NUMTESTS ) {
	skip("unable to run all of the PAML tests",1);
    }
}
my $testnum;
my $verbose = 0;

## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run. 

use Bio::Tools::Phylo::PAML; # PAML parser

my $inpaml = new Bio::Tools::Phylo::PAML(-file => 't/data/codeml.mlc');
ok($inpaml);

use Bio::Tools::Run::Phylo::PAML::Codeml;
use Bio::AlignIO;
my $codeml = new Bio::Tools::Run::Phylo::PAML::Codeml(-verbose => -1);
exit(0) unless( $codeml->executable );

my $in = new Bio::AlignIO(-format => 'phylip',
			  -file   => 't/data/gf-s85.phylip');
my $aln = $in->next_aln;
$codeml->alignment($aln);
my ($rc,$results) = $codeml->run();
ok($rc,1);
my $result = $results->next_result;
my $MLmatrix = $result->get_MLmatrix;
ok($MLmatrix->[0]->[1]->{'dN'}, 0.0693);
ok($MLmatrix->[0]->[1]->{'dS'},1.1459);
ok($MLmatrix->[0]->[1]->{'omega'}, 0.0605);
ok($MLmatrix->[0]->[1]->{'S'}, 273.5);
ok($MLmatrix->[0]->[1]->{'N'}, 728.5);
ok($MLmatrix->[0]->[1]->{'t'}, 1.0895);

ok($codeml->error_string !~ /Error/); # we don't expect any errors;
