# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl AnalysisFactory_soap.t'

use strict;
use vars qw($NUMTESTS);
use lib '..','./blib/lib';

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
    $NUMTESTS = 8;
    plan tests => $NUMTESTS;
}

my $testnum;
my $verbose = 0;

## End of black magic.
##
## Insert additional test code below but remember to change
## the 'plan tests =>...' in the BEGIN block to reflect the
## total number of tests that will be run. 

my $serror = 0;

my $format = ($ENV{'TEST_DETAILS'} ? '%-40s' : '');

unless (eval "require SOAP::Lite; 1;") {
    print STDERR "SOAP::Lite not installed. Skipping some tests.\n";
    $serror = 1;
}

# check 'use ...'
eval { require Bio::Tools::Run::AnalysisFactory };
print sprintf ($format, 'use Bio::Tools::Run::AnalysisFactory '); ok (%Bio::Tools::Run::AnalysisFactory::);
&print_error;

# check 'new with a default access...'
my $factory;
eval { $factory = new Bio::Tools::Run::AnalysisFactory (-verbose => '0'); };
print sprintf ($format, 'new Bio::Tools::Run::AnalysisFactory '); skip ($serror, defined $factory);
&print_error;

# check 'new with an explicit access...'
my $factory_tmp;
eval { $factory_tmp = new Bio::Tools::Run::AnalysisFactory (-access => 'soap'); };
print sprintf ($format, 'new with an explicit access '); skip ($serror, defined $factory_tmp);
&print_error;

# check 'new with a non-existing access...'
my $factory_tmp2;
eval { $factory_tmp2 = new Bio::Tools::Run::AnalysisFactory (-access => 'not_exist'); };
print sprintf ($format, 'new with a non-existing access '); skip ($serror, !defined $factory_tmp2);

# the rest makes sense only with SOAP::Lite installed
if ($serror) {
    foreach ( $Test::ntest..$NUMTESTS) { 
	skip (1,1);
    }
    exit (0);
}

# check using a real service
eval {
    print sprintf ($format, 'calling "available_categories" ');
    skip ($serror, grep (/protein/i, @{ $factory->available_categories }));

    print sprintf ($format, 'calling "available_analyses" ');
    skip ($serror, grep (/seqret/i, @{ $factory->available_analyses }));

    print sprintf ($format, 'calling "available_analyses(category)" ');
    skip ($serror, grep (/seqret/i, @{ $factory->available_analyses ('edit') }));

    print sprintf ($format, 'calling "create_analysis" ');
    skip ($serror, defined $factory->create_analysis ('edit::seqret'));
};

if ($@) {
    print STDERR "Warning: (Probably) couldn't connect to $$factory{'_location'}.\n" . $@;
    foreach ( $Test::ntest..$NUMTESTS) { 
	skip ('(Probably) because of no network access',1);
    }
    exit(0);
}


sub print_error {
    print STDERR $@ if $@ && $ENV{'TEST_DETAILS'};
}

__END__
