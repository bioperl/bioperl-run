#!/usr/bin/perl -w
#
#   A client showing how to use Bio::Tools::Run::Analysis module,
#   a module for executing and controlling local or remote analysis tools.
#   It also calls methods from Bio::Tools::Run::AnalysisFactory module.
#
#   It has many options in order to cover as many methods as
#   possible.  Because of that, it can be also used as a fully
#   functional command-line client for accessing various analysis
#   tools.
#
#   Usage: ./analysis -h
#   or: perldoc analysis.pl
#
#   senger@ebi.ac.uk
#   July 2002
#
#   $Id: panalysis.PLS,v 1.6 2004-11-16 18:33:26 jason Exp $
#-----------------------------------------------------------------------------

use strict;

sub get_usage {
    return <<"END_OF_USAGE";
Usage:
   analysis.pl [options] [input-data]

where 'options' are:
   -A <access>    access method (default 'soap')
   -l <location>  where are the analyses
   -n <name>      name of an analysis
   -j <job-id>    ID of a previously created job

   -L             list all available analyses
   -c             list all available categories
   -C <category>  show all analyses in given category

   -i, -I         show specification of data inputs
   -o, -O         show specification of results
   -a             show specification of the analysis
   -d             show analysis metadata (XML)

   -b             create job from [input-data]
                  (default: create a job also without -b option
                   if there is no -j option and if there are some
                   'input-data' on the command-line)
   -x             create job from [input-data] and run it
   -w             create job from [input-data], run it and wait for it
   -x -j <job-id> run a previously created job
   -w -j <job-id> run a previously created job and wait for it
   -k -j <job-id> kill a previously created job


   -s             show job status
   -t             show all job times
   -T <acbfe>     show some job times (all, created, begun, finished, elapsed)
   -e             show job last event (XML)

   -r             retrieve all results
   -R <list>      retrieve named results; comma-separated list, each item:
                    <result-name>
                    <result-name>=<filename>
                    <result-name>=@[filename-template]
                    <result-name>=?[filename-template]
                  where 'filename-template' can contain:
                    *         ... will be replaced by a unique number
                    \$ANALYSIS ... will be replaced by an analysis name
                    \$RESULT   ... will be replaced by a result name
                    any other characters (suitable for filenames)

   -z             at the end remove job and all its results

   -h             this help
   -v, -V         show version(s)
   -q             be less verbose

where 'input-data' are:
   <input-data-name>=<value>... 
   <input-data-name>=@<filename-with-value>...

Environment variables:
   HTTPPROXY                 HTTP proxy server
   HTTPTIMEOUT               HTTP timeout (0 means no timeout at all)
   RESULT_FILENAME_TEMPLATE  template for inventing filenames for results

For more details type:  perldoc analysis.pl

END_OF_USAGE
}

BEGIN {
    # add path to the directory with this script
    my $mylib;
    ($mylib = $0) =~ s|/[^/]+$||;
    unshift @INC, $mylib;

    # be prepare for command-line options/arguments
    use Getopt::Std;

    # general options
    use vars qw/ $opt_h $opt_v $opt_V $opt_q /;
    # specialized options
    use vars qw/ $opt_A $opt_l $opt_n $opt_j /;                 # service
    use vars qw/ $opt_L $opt_c $opt_C /;                        # factory
    use vars qw/ $opt_d $opt_i $opt_I $opt_o $opt_O $opt_a /;   # metadata
    use vars qw/ $opt_x $opt_w $opt_k $opt_s $opt_e $opt_t $opt_T $opt_b /; # job
    use vars qw/ $opt_r $opt_R /;                               # results
    use vars qw/ $opt_z /;                                      # cleaning
    my $switches = 'ACjlnRT';   # switches taking an argument (a value)
    getopt ($switches);

    use vars qw($VERSION $Revision);

    # set the version for version checking
    $VERSION = do { my @r = (q[$Revision: 1.6 $] =~ /\d+/g); sprintf "%d.%-02d", @r };
    $Revision = q[$Id: panalysis.PLS,v 1.6 2004-11-16 18:33:26 jason Exp $];


    # help wanted?
    if ($opt_h) {
	print get_usage;
	exit 0;
    }

    # print version of this script and exit
    if ($opt_v) {
	print "$0 $VERSION\n";
	exit 0;
    }
}

use Bio::Tools::Run::Analysis;        # to access analysis tools directly
use Bio::Tools::Run::AnalysisFactory; # to access list/factory of analysis tools

# --- create a factory object;
#     the new() method understands the following parameters:
#        -location  (taken from '-l' option if given)
#        -access    (taken from '-A' option, default is 'soap')
#
#      Additionally, it uses env. variable HTTPPROXY to create parameter
#      '-httpproxy', and env. variable HTTPTIMEOUT to set max HTTP timeout.
#
my @access    = ('-access', $opt_A) if defined $opt_A;
my @location  = ('-location', $opt_l) if defined $opt_l;
my @httpproxy = ('-httpproxy', $ENV{'HTTPPROXY'}) if defined $ENV{'HTTPPROXY'};
my @timeout   = ('-timeout', $ENV{'HTTPTIMEOUT'}) if defined $ENV{'HTTPTIMEOUT'};
my $factory = new Bio::Tools::Run::AnalysisFactory (@location, @httpproxy, @timeout);

# --- create an analysis (service) object;
#     the new() method understands the following parameters:
#        -location  (taken from '-l' option if given)
#        -access    (taken from '-A' option, default is 'soap')
#        -name      (taken from '-n' option; mandatory!, no default value)
#        -destroy_on_exit (set to true if '-z' option given)
#        -httpproxy (taken from an env.variable)
#        -timeout   (taken from an env.variable)
#
my @name      = ('-name', $opt_n) if defined $opt_n;
my @destroy   = ('-destroy_on_exit', 0) unless $opt_z;
my $service = new Bio::Tools::Run::Analysis (@name, @location, @httpproxy, @timeout, @destroy);

die "Stopped. No success in accessing analysis factory.\n" unless $factory;
die "Stopped. No success in accessing analysis tools.\n" unless $service;

# --- print class and version of "real-workers" and exit
if ($opt_V) {
    print ref $factory, " ", $factory->VERSION . "\n";
    print ref $service, " ", $service->VERSION . "\n";
    exit 0;
}

#
# --- here are methods of the "directory service" (factory)
#

# what categories are available?
if ($opt_c) {
    my $msg = "Available categories";
    &msg ("$msg\n" . '-' x length ($msg) . "\n");
    print join ("\n", sort @{ $factory->available_categories }), "\n";
}

# what analyses are available?
if ($opt_L) {
    my $msg = "Available analyses";
    &msg ("$msg\n" . '-' x length ($msg) . "\n");
    print join ("\n", sort @{ $factory->available_analyses }), "\n";
}

# what analyses are available in a particular category?
if ($opt_C) {
    my $msg = "Available analyses in category '$opt_C':";
    &msg ("$msg\n" . '-' x length ($msg) . "\n");
    print join ("\n", sort @{ $factory->available_analyses ($opt_C) }), "\n";
}

#
# --- here are methods describing one analysis
#

# print full analysis metadata in XML
# ('$service->describe' returns an XML string)
print $service->describe . "\n" if $opt_d;

# print major characteristics of an analysis
# ('$service->analysis_spec' returns a hash reference)
if ($opt_a) {
    my $rh_spec = $service->analysis_spec;
    my $msg = "Specification of analysis";
    &msg ("$msg\n" . '-' x length ($msg) . "\n");
    my ($key, $value);
    print "Analysis '$opt_n':\n";
    while (($key, $value) = each %{ $rh_spec }) {
	print "\t$key => $value\n";
    }
}

# print input specification (either full, or just input data names)
# ('$service->input_spec' returns a reference to an array of hashes)
if ($opt_i or $opt_I) {
    my $ra_spec = $service->input_spec;
    my $msg = "Specification of inputs";
    &msg ("$msg\n" . '-' x length ($msg) . "\n");
    my ($key, $value);
    foreach (sort { $$a{'name'} cmp $$b{'name'} } @$ra_spec) {
	print $$_{'name'},"\n";
	if ($opt_I) {
	    while (($key, $value) = each %{ $_ }) {
		unless ($key eq 'name') {
		    if (ref $value eq 'ARRAY') {  # for 'allowed values'
			print "\t$key => " . join (", ", @$value) . "\n";
		    } else {
			print "\t$key => $value\n";
		    }
		}
	    }
	}
    }
}

# print result specification (either full, or just names of results)
# ('$service->result_spec' returns a reference to an array of hashes)
if ($opt_o or $opt_O) {
    my $ra_spec = $service->result_spec;
    my $msg = "Specification of results";
    &msg ("$msg\n" . '-' x length ($msg) . "\n");
    my ($key, $value);
    foreach (sort { $$a{'name'} cmp $$b{'name'} } @$ra_spec) {
	print $$_{'name'},"\n";
	if ($opt_O) {
	    while (($key, $value) = each %{ $_ }) {
		print "\t$key => $value\n" unless ($key eq 'name');
	    }
	}
    }
}

#
# --- let's create a job
#
my $job;
if ($opt_j) {
    # ... either by re-creating a previous job
    $job = $service->create_job ($opt_j);

    if ($opt_x) {
	$job->run;
    } elsif ($opt_w) {
	$job->wait_for;
    } elsif ($opt_k) {
	$job->terminate;
    }

} else {
    # ... or creating a new job using given input data
    if ($opt_x) {
	$job = $service->run (\@ARGV);
    } elsif ($opt_w) {
	$job = $service->wait_for (\@ARGV);
    } elsif ($opt_b or @ARGV > 0) {
	$job = $service->create_job (\@ARGV);
    }

    # often you need to know the JOB's ID to be able to come back
    # later and ask for results, status, events etc. - so I print it
    # here even in quiet mode (option -q) - but to STDERR in order not
    # to intervene with redirected real results
    print STDERR "JOB ID: " , $job->id . "\n" if $job;
}

#
# --- having a job, ask it for something
#
if ($job) {
    print "JOB STATUS: " . $job->status . "\n" if $opt_s;
    print "LAST EVENT: " . $job->last_event . "\n" if $opt_e;

    # ...get job times (all of them in one go, formatted)
    if ($opt_t) {
	my $rh_times = $job->times (1);  # '1' means 'formatted'
	print "TIMES:\n";
	print "\tCreated: " . $$rh_times{'created'} . "\n" if $$rh_times{'created'};
	print "\tStarted: " . $$rh_times{'started'} . "\n" if $$rh_times{'started'};
	print "\tEnded:   " . $$rh_times{'ended'}   . "\n" if $$rh_times{'ended'};
	print "\tElapsed: " . $$rh_times{'elapsed'} . "\n" if defined $$rh_times{'elapsed'};
    }

    # ...get individual job characteristics (both formatted and raw)
    if ($opt_T) {
	print "CREATED: " . $job->created (1) . " (" . $job->created . ")\n" if $opt_T =~ /a|c/;
	print "STARTED: " . $job->started (1) . " (" . $job->started . ")\n" if $opt_T =~ /a|b/;
	print "ENDED:   " . $job->ended (1)   . " (" . $job->ended   . ")\n" if $opt_T =~ /a|f/;
	print "ELAPSED: " . $job->elapsed . "\n"                             if $opt_T =~ /a|e/;
    }

    # retrieve results
    my $rh_results;
    if ($opt_R) {
	$rh_results = $job->results (split /\s*,\s*/, $opt_R);
    } elsif ($opt_r) {
	$rh_results = $job->results ('?');
    }
    if ($rh_results) {
	foreach my $name (sort keys %$rh_results) {
	    my $msg = "RESULT: $name";
	    &msg ("$msg\n" . '-' x length ($msg) . "\n");

	    if (ref $$rh_results{$name}) {
		# ... this is probably what you do not want (binary on terminal);
		#     unless you wisely used: -R result_name=filename
		print join ("\n", @{ $$rh_results{$name} }) . "\n";
	    } else {
		print $$rh_results{$name} . "\n";
	    }
	}
    }
}

sub msg {
    print shift unless $opt_q;
}

__END__

=head1 NAME

analysis.pl - An example/tutorial script how to access analysis tools

=head1 SYNOPSIS

 # run an analysis with your sequence in a local file
   ./analysis.pl -n 'edit::seqret'-w -r \
                 sequence_direct_data=@/home/testdata/my.seq

 See more examples in the text below.

=head1 DESCRIPTION

A client showing how to use C<Bio::Tools::Run::Analysis> module, a module for
executing and controlling local or remote analysis tools.  It also
calls methods from the C<Bio::Tools::Run::AnalysisFactory> module, a module
providing lists of available analyses.

Primarily, this client is meant as an example how to use analysis
modules, and also to test them. However, because it has a lot of
options in order to cover as many methods as possible, it can be also
used as a fully functional command-line client for accessing various
analysis tools.

=head2 Defining location and access method

C<analysis.pl> is independent on the access method to the remote
analyses (the analyses running on a different machines). The method
used to communicate with the analyses is defined by the C<-A> option,
with the default value I<soap>. The other possible values (not yet
supported, but coming soon) are I<corba> and I<local>.

Each access method may have different meaning for parameter C<-l>
defining a location of services giving access to the analysis
tools. For example, the I<soap> access expects a URL of a Web Service
in the C<-l> option, while the I<corba> access may find here a
stringified Interoperable Object Reference (IOR).

A default location for the I<soap> access is
C<http://industry.ebi.ac.uk/soap/soaplab> which represents an
experimental service running at European Bioinformatics Institute on
top of over hundred EMBOSS analyses.

=head2 Available analyses

C<analysis.pl> can show a list of available analyses (from the given
location using given access method). The C<-L> option shows all
analyses, the C<-c> option lists all available categories (a category
is a group of analyses with similar functionality or processing
similar type of data), and finally the C<-C> option shows only
analyses available within the given category.

Note, that all these functions are provided by module
C<Bio::Tools::Run::AnalysisFactory> (respectively, by one of its
access-dependent sub-classes). The module has also a I<factory> method
C<create_analysis> which is not used by this script.

=head2 Service

A C<service> is a higher level of abstraction of an analysis tool. It
understands a well defined interface (module C<Bio::AnalysisI>, a fact
which allows this script to be independent on the access protocol to
various services.

The service name must be given by the C<-n> option. This option can be
omitted only if you invoked just the C<factory> methods (described
above).

Each service (representing an analysis tool, a program, or an
application) has its description, available by using options C<-a>
(analysis name, type, etc.), C<-i>, C<-I> (specification of analysis
input data, most important are their names), and C<-o>, C<-O> (result
names and their types). The option C<-d> gives the most detailed
description in the XML format.

The service description is nice but the most important is to use the
service for invoking an underlying analysis tool. For each invocation,
the service creates a C<job> and feeds it with input data. There are
three stages: (a) create a job, (b) run the job, and (c) wait for its
completion. Correspondingly. there are three options: the C<-b> which
just creates (builds) a job, the C<-x> which creates a job and
executes it, and finally C<-w> which creates a job, runs it and blocks
the client until the job is finished. Always only one of these options
is used (so it does not make sense to use more of them, the
C<analysis.pl> priorities them in the order C<-x>, C<-w>, and
C<-b>).

All of these options take input data from the command-line (see next
section about it) and all of them return (internally) an object
representing a job. There are many methods (options) dealing with the
job objects (see one after next section about them).

Last note in this section: the C<-b> option is actually optional - a
job is created even without this option when there are some input data
found on the command-line. You I<have> to use it, however, if you do
not pass any data to an analysis tool (an example would be the famous
C<Classic::HelloWorld> service).

=head2 Input data

Input data are given as name/value pairs, put on the command-line with
equal sign between name and value. If the I<value> part starts with
an un-escaped character C<@>, it is used as a local file name and the
C<analysis.pl> reads the file and uses its contents instead. Examples:

   analysis.pl -n edit::seqret -w -r
               sequence_direct_data='tatatctcccc' osformat=embl

   analysis.pl ...
               sequence_direct_data=@/my/data/my.seq

The names of input data come from the C<input specification> that can
be shown by the C<-i> or C<-I> options. The input specification (when
using option C<-I>) shows also - for some inputs - a list of allowed
values.  The specification, however, does not tell what input data are
mutually exclusive, or what other constrains apply. If there is a
conflict, an error message is produced later (before the job starts).

Input data are used when any of the options C<-b>, C<-x>, or C<-w> is
present, but option C<-j> is not present (see next section about this
job option).

=head2 Job

Each service (defined by a name given in the C<-n> option) can be
executed one or more times, with the same, but usually with different
input data. Each execution creates a I<job object>. Actually, the job
is created even before execution (remember that option C<-b> builds a
job but does not execute it yet).

Any job, executed or not, is persistent and can be used again later
from another invocation of the C<analysis.pl> script. Unless you
explicitly destroy the job using option C<-z>.

A job created by options C<-b>, C<-x> and C<-w> (and by input data)
can be accessed in the same C<analysis.pl> invocation using various
job-related options, the most important are C<-r> and C<-R> for
retrieving results from the finished job.

However, you can also re-create a job created by a previous
invocation. Assuming that you know the job ID (the C<analysis.pl>
prints it always on the standard error when a new job is created), use
option C<-j> to re-create the job.

Example:

   ./analysis.pl -n 'edit::seqret'
                 sequence_direct_data=@/home/testdata/my.seq

It prints:

   JOB ID: edit::seqret/bb494b:ef55e47c99:-8000

Next invocation (asking to run the job, to wait for its completion and
to show job status) can be:

   ./analysis.pl -n 'edit::seqret'
                 -j edit::seqret/bb494b:ef55e47c99:-800
                 -w -s

And again later another invocation can ask for results:

   ./analysis.pl -n 'edit::seqret'
                 -j edit::seqret/bb494b:ef55e47c99:-800
                 -r

Here is a list of all job options (except for results, they are in the
next section):

=over 4

=item Job execution and termination

There are the same options C<-x> and C<-w> for executing a job and for
executing it and waiting for its completion, as they were described
above. But now, the options act on a job given by the C<-j> option,
now they do not use any input data from the command-line (the input
data had to be used when the job was created).

Additionally, there is a C<-k> option to kill a running job.

=item Job characteristics

Other options tell about the job status (C<-s>, about the job
execution times (C<-t> and C<-T>, and about the last available event
what happened with the job (C<-e>). Note that the event notification is
not yet fully implemented, so this option will change in the future to
reflect more notification capabilities.

=back

=head2 Results

Of course, the most important on the analysis tools are their
results. The results are named (in the similar way as the input data)
and they can be retrieved all in one go using option C<-r> (so you do
not need to know their names actually), or by specifying (all or some)
result names using the C<-R> option.

If a result does not exist (either not yet, or the name is wrong) an
undef value is returned (no error message produced).

Some results are better to save directly into files instead to show
them in the terminal window (this applies to the I<binary> results,
mostly containing images). The C<analysis.pl> helps to deal with
binary results by saving them automatically to local files (actually
it is the module C<Bio::Tools::Run::Analysis> and its submodules
who do help with the binary data).

So why not to use a traditional shell re-direction to a file? There are
two reasons. First, a job can produce more than one result, so they
would be mixed together. But mainly, because each result can consist
of several parts whose number is not known in advance and which cannot
be mixed together in one file. Again, this is typical for the binary
data returning images - an invocation can produce many images.

The C<-r> option retrieves all available results and treat them as
described by the C<'?'> format below.

The C<-R> option has a comma-separated list of result names, each of
the names can be either a simple name (as specified by the C<result
specification> obtainable using the C<-o> or C<-O> options), or a
equal-sign-separated name/format construct suggesting what to do with
the result. The possibilities are:

=over 4

=item result-name

It prints given result on the standard output.

=item result-name=filename

It saves the given result into given file.

=item result-name=@

It saves the given result into a file whose name is automatically
invented, and it guarantees that the same name will not be used in
the next invocation.

=item result=name=@template

It saves the given result into a file whose name is given by the
C<template>. The template can contain several strings which are
substituted before using it as the filename:

=over 4

=item Any '*'

Will be replaced by a unique number

=item $ANALYSIS or ${ANALYSIS}

Will be replaced by the current analysis name

=item $RESULT or ${RESULT}

Will be replaced by the current result name

How to tell what to do with results? Each result name

=back

Additionally, a template can be given as an environment variable
C<RESULT_FILENAME_TEMPLATE>. Such variable is used for any result
having in its format a simple C<?> or C<@> character.

=item result-name=?

It first decides whether the given result is binary or not. Then, the
binary results are saved into local files whose names are
automatically invented, the other results are sent to the standard
output.

=item result-name=?template

The same as above but the filenames for binary files are deduced from
the given template (using the same rules as described above).

=back

Examples:

   -r
   -R report
   -R report,outseq
   -R Graphics_in_PNG=@
   -R Graphics_in_PNG=@$ANALYSIS-*-$RESULT

Note that the result formatting will be enriched in the future by
using existing data type parsers in bioperl.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

=head1 AUTHOR

Martin Senger (senger@ebi.ac.uk)

=head1 COPYRIGHT

Copyright (c) 2003, Martin Senger and EMBL-EBI.
All Rights Reserved.

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 BUGS AND LIMITATIONS

None known at the time of writing this.

=cut
