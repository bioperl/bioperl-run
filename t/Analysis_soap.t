# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Analysis_soap.t'

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
    $NUMTESTS = 19;
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

# check 'use ...'
eval { require Bio::Tools::Run::Analysis };
print sprintf ($format, 'use Bio::Tools::Run::Analysis '); ok (%Bio::Tools::Run::Analysis::);
&print_error;

# TBD:
# Here I should add some tests for the various methods doing just
# data conversions...

# the rest makes sense only with SOAP::Lite installed
unless (eval "require SOAP::Lite; 1;") {
    print STDERR "SOAP::Lite not installed. Skipping some tests.\n";
    $serror = 1;
}
if ($serror) {
    foreach ( $Test::ntest..$NUMTESTS) { 
	skip (1,1);
    }
    exit (0);
}

# check 'new with a default access...'
my $seqret;
eval { $seqret = new Bio::Tools::Run::Analysis (-name => 'edit::seqret'); };
print sprintf ($format, 'new ...Analysis (-name=>seqret) '); skip ($serror, defined $seqret);
&print_error;

# the rest makes sense only if an Analysis object was created
unless ($seqret) {
    foreach ($Test::ntest..$NUMTESTS) { 
	skip (1,1);
    }
    exit (0);
}


# check if the remote service is accessible
print sprintf ($format, 'checking service availability ');
eval { $seqret->analysis_name };
if ($@) {
    print STDERR "Warning: Couldn't connect to $$seqret{'_location'}.\n" . $@;
    foreach ( $Test::ntest..$NUMTESTS) { 
	skip ('skip (probably) because of no network access',1);
    }
    exit(0);
} else {
    ok (1);
}

# some testing data (for seqret)
my $seq = 'tatacga';
my %inputs = ('sequence_direct_data' => $seq,
	      'osformat'             => 'raw',
	      );

# check using a real service
print sprintf ($format, 'calling "analysis_name" ');
skip ($serror, eval { 'seqret' eq $seqret->analysis_name });
&print_error;

print sprintf ($format, 'calling "analysis_spec" ');
skip ($serror, eval { ref ($seqret->analysis_spec) eq 'HASH' });
&print_error;

my $spec;
print sprintf ($format, 'calling "input_spec" ');
eval { $spec = $seqret->input_spec };
skip ($serror, ref ($spec) eq 'ARRAY' && @$spec > 0 && ref ($$spec[0]) eq 'HASH');
&print_error;

print sprintf ($format, 'calling "result_spec" ');
skip ($serror, eval { ref ($seqret->result_spec) eq 'HASH' });
&print_error;

print sprintf ($format, 'calling "describe" ');
skip ($serror, eval { $seqret->describe =~ /^<\?xml / });
&print_error;

my $job;
print sprintf ($format, 'calling "create_job" ');
eval { $job = $seqret->create_job (\%inputs) };
skip ($serror, ref ($job) =~ /^Bio::Tools::Run::Analysis::Job/);
&print_error;

my $next_dependent_tests = 4;
if ($job) {
    print sprintf ($format, 'calling "job->status" ');
    skip ($serror, eval { $job->status eq 'CREATED' });
    &print_error;

    my $clone_job;
    eval { $clone_job = $seqret->create_job ($job->{'_id'}) };
    print sprintf ($format, 'cloning job ');
    skip ($serror, ref ($clone_job) =~ /^Bio::Tools::Run::Analysis::Job/);
    &print_error;

    $next_dependent_tests = 2;
    if ($clone_job) {
	print sprintf ($format, 'calling "new_job->last_event" ');
	skip ($serror, eval { $clone_job->last_event =~ /^<\?xml / });
	&print_error;

	print sprintf ($format, 'calling "new_job->remove" ');
	eval { $clone_job->remove };
	skip ($serror, $clone_job->{'_destroy_on_exit'} == 1);
	&print_error;
    } else {
	&skip_tests ($next_dependent_tests);
    }
} else {
    &skip_tests ($next_dependent_tests);
}

my $empty_job;
eval { $empty_job = $seqret->create_job() };
print sprintf ($format, 'creating an empty job ');
skip ($serror, ref ($empty_job) =~ /^Bio::Tools::Run::Analysis::Job/);
&print_error;

$next_dependent_tests = 1;
if ($empty_job) {

#    TBD (should be mentioned in TODO)
#    print sprintf ($format, 'calling "empty_job->status" ');
#    skip ($serror, eval { $empty_job->status eq 'CREATED' });
#    &print_error;

    print sprintf ($format, 'calling "empty_job->remove" ');
    eval { $empty_job->remove };
    skip ($serror, $empty_job->{'_destroy_on_exit'} == 1);
    &print_error;
} else {
    &skip_tests ($next_dependent_tests);
}

print sprintf ($format, 'calling "wait_for" ');
eval { $job = $seqret->wait_for (\%inputs) };
skip ($serror, ref ($job) =~ /^Bio::Tools::Run::Analysis::Job/);
&print_error;

$next_dependent_tests = 3;
if ($job) {
    print sprintf ($format, 'checking "detailed_status" ');
    skip ($serror, eval { ${ $job->results ('detailed_status') }{'detailed_status'} == 0 });
    &print_error;

    print sprintf ($format, 'checking "report" ');
    skip ($serror, eval { ${ $job->results ('report') }{'report'} =~ /successfully/i });
    &print_error;

    print sprintf ($format, 'checking "outseq" ');
    skip ($serror, eval { ${ $job->results ('outseq') }{'outseq'} =~ /^$seq$/ });
    &print_error;

} else {
    &skip_tests ($next_dependent_tests);
}



# skip the next $count tests
sub skip_tests {
    my ($count) = @_;
    my $msg = "skip because of failure in test " . ($Test::ntest - 1);
    foreach ( $Test::ntest..($Test::ntest + $count - 1)) { 
	skip ($msg,1);
    }
}

# print an error on stderr if there is an error and TEST_DETAILS is on
sub print_error {
    print STDERR $@ if $@ && $ENV{'TEST_DETAILS'};
}

__END__
