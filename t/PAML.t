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

    $NUMTESTS = 18;
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
use Bio::Root::IO;

my $inpaml = new Bio::Tools::Phylo::PAML(-file => 
					 Bio::Root::IO->catfile(qw(t data 
								   codeml.mlc)));

ok($inpaml);

use Bio::Tools::Run::Phylo::PAML::Codeml;
use Bio::Tools::Run::Phylo::PAML::Yn00;
use Bio::AlignIO;
my $codeml = new Bio::Tools::Run::Phylo::PAML::Codeml(-verbose => $verbose);
unless ($codeml->executable) {
  warn("PAML not is installed. skipping tests $Test::ntest to $NUMTESTS\n");
  exit(0) ;
}

my $in = new Bio::AlignIO(-format => 'phylip',
			  -file   => Bio::Root::IO->catfile(qw(t data 
							       gf-s85.phylip)));
my $aln = $in->next_aln;
$codeml->alignment($aln);
my ($rc,$results) = $codeml->run();

ok($rc,1);
if( ! defined $results ) { 
    exit(0);
}

my $result = $results->next_result;
my $MLmatrix = $result->get_MLmatrix;

# PAML 2.12 results
if( $result->version =~ /3\.12/ ) {
    ok($MLmatrix->[0]->[1]->{'dN'}, 0.0693);
    ok($MLmatrix->[0]->[1]->{'dS'},1.1459);
    ok($MLmatrix->[0]->[1]->{'omega'}, 0.0605);
    ok($MLmatrix->[0]->[1]->{'S'}, 273.5);
    ok($MLmatrix->[0]->[1]->{'N'}, 728.5);
    ok($MLmatrix->[0]->[1]->{'t'}, 1.0895);
} elsif( $result->version =~ /3\.13/ ) {
# PAML 2.13 results
    ok($MLmatrix->[0]->[1]->{'dN'}, 0.0713);
    ok($MLmatrix->[0]->[1]->{'dS'},1.2462);
    ok(sprintf("%.4f",$MLmatrix->[0]->[1]->{'omega'}), 0.0572);
    ok($MLmatrix->[0]->[1]->{'S'}, 278.8);
    ok($MLmatrix->[0]->[1]->{'N'}, 723.2);
    ok(sprintf("%.4f",$MLmatrix->[0]->[1]->{'t'}), 1.1946);
} else { 
    for( 1..6) { 
	skip("Can't test the result output, don't know about PAML version ".$result->version,1);
    }
}

ok($codeml->error_string !~ /Error/); # we don't expect any errors;

my $yn00 = Bio::Tools::Run::Phylo::PAML::Yn00->new();
$yn00->alignment($aln);
($rc,$results) = $yn00->run();
ok($rc,1);
if( ! defined $results ) { 
    exit(0);
}
$result = $results->next_result;
$MLmatrix = $result->get_MLmatrix;

ok($MLmatrix->[0]->[1]->{'dN'}, 0.0846);
ok($MLmatrix->[0]->[1]->{'dS'}, 1.0926);
ok($MLmatrix->[0]->[1]->{'omega'}, 0.0774);
ok($MLmatrix->[0]->[1]->{'S'}, 278.4);
ok($MLmatrix->[0]->[1]->{'N'}, 723.6);
ok($MLmatrix->[0]->[1]->{'t'}, 1.0941);

ok($yn00->error_string !~ /Error/); # we don't expect any errors;


$codeml = new Bio::Tools::Run::Phylo::PAML::Codeml
    (-params => { 'alpha' => 1.53 },
     -verbose => $verbose);

ok($codeml);
