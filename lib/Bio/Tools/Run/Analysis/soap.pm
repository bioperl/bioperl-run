# $Id$
#
# BioPerl module Bio::Tools::Run::Analysis::soap.pm
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Martin Senger <martin.senger@gmail.com>
# For copyright and disclaimer see below.

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Analysis::soap - A SOAP-based access to the analysis tools

=head1 SYNOPSIS

Do not use this object directly, it is recommended to access it and use
it through the C<Bio::Tools::Run::Analysis> module:

  use Bio::Tools::Run::Analysis;
  my $tool = Bio::Tools::Run::Analysis->new(-access => 'soap',
                                            -name   => 'seqret');

=head1 DESCRIPTION

This object allows to execute and to control a remote analysis tool
(an application, a program) using the SOAP middleware,

All its public methods are documented in the interface module
C<Bio::AnalysisI> and explained in tutorial available in the
C<analysis.pl> script.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR

Martin Senger (martin.senger@gmail.com)

=head1 COPYRIGHT

Copyright (c) 2003, Martin Senger and EMBL-EBI.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over 4

=item *

http://www.ebi.ac.uk/soaplab/Perl_Client.html

=back

=head1 BUGS AND LIMITATIONS

None known at the time of writing this.

=head1 APPENDIX

Here is the rest of the object methods.  Internal methods are preceded
with an underscore _.

=cut


# Let the code begin...


package Bio::Tools::Run::Analysis::soap;
use vars qw(@ISA $Revision $DEFAULT_LOCATION);
use strict;

use Bio::Tools::Run::Analysis;
use SOAP::Lite
    on_fault => sub {
	my $soap = shift;
	my $res = shift;
	my $msg =
	    ref $res ?
		"--- SOAP FAULT ---\n" .
		'faultcode:   ' . $res->faultcode . "\n" .
		'faultstring: ' . Bio::Tools::Run::Analysis::soap::_clean_msg ($res->faultstring)
	      : "--- TRANSPORT ERROR ---\n" . $soap->transport->status . "\n$res\n";
        Bio::Tools::Run::Analysis::soap->throw ($msg);
    }
;

@ISA = qw(Bio::Tools::Run::Analysis);

BEGIN { 
    $Revision = q[$Id$];

    # where to go
    $DEFAULT_LOCATION = 'http://www.ebi.ac.uk/soaplab/services';
}

# -----------------------------------------------------------------------------

=head2 _initialize

 Usage   : my $tool = Bio::Tools::Run::Analysis->new(-access => 'soap',
                                                     -name => 'seqret',
                                                     ...);
           (_initialize is internally called from the 'new()' method)
 Returns : nothing interesting
 Args    : This module recognises and uses following arguments:
             -location
             -name
             -httpproxy
             -timeout
	   Additionally, the main module Bio::Tools::Run::Analysis
           recognises also:
             -access

It populates calling object with the given arguments, and then - for
some attributes and only if they are not yet populated - it assigns
some default values.

This is an actual new() method (except for the real object creation
and its blessing which is done in the parent class Bio::Root::Root in
method _create_object).

Note that this method is called always as an I<object> method (never
as a I<class> method) - and that the object who calls this method may
already be partly initiated (from Bio::Tools::Run::Analysis::new method);
so if you need to do some tricks with the 'class invocation' you need to
change Bio::Analysis I<new> method, not this one.

=over 4

=item -location

A URL (also called an I<endpoint>) defining where is located a Web Service
representing this analysis tool.

Default is C<http://www.ebi.ac.uk/soaplab/services> (services running
at European Bioinformatics Institute on top of most of EMBOSS
analyses, and few others).

For example, if you run your own Web Service using Java(TM) Apache Axis
toolkit, the location might be something like
C<http://localhost:8080/axis/services>.

=item -name

A name of a Web Service (also called a I<urn> or a I<namespace>).
There is no default value (which usually means that this parameter is
mandatory unless your I<-location> parameter includes also a Web
Service name).

=item -destroy_on_exit =E<gt> '0'

Default value is '1' which means that all Bio::Tools::Run::Analysis::Job
objects - when being finalised - will send a request
to the remote Web Service to forget the results of these jobs.

If you change it to '0' make sure that you know the job identification
- otherwise you will not be able to re-established connection with it
(later, when you use your script again). This can be done by calling
method C<id> on the job object (such object is returned by any of
these methods: C<create_job>, C<run>, C<wait_for>).

=item -httpproxy

In addition to the I<location> parameter, you may need
to specify also a location/URL of an HTTP proxy server
(if your site requires one). The expected format is C<http://server:port>.
There is no default value.

=item -timeout

For long(er) running jobs the HTTP connection may be time-outed. In
order to avoid it (or, vice-versa, to call timeout sooner) you may
specify C<timeout> with the number of seconds the connection will be
kept alive. Zero means to keep it alive forever. The default value is
two minutes.

=back

=cut

sub _initialize {
    my ($self, @args) = @_;
    
    # make a hashtable from @args
    my %param = @args;
    @param { map { lc $_ } keys %param } = values %param; # lowercase keys

    # copy all @args into this object (overwriting what may already be
    # there) - changing '-key' into '_key'
    my $new_key;
    foreach my $key (keys %param) {
	($new_key = $key) =~ s/^-/_/;
	$self->{ $new_key } = $param { $key };
    }

    # finally add default values for those keys who have default value
    # and who are not yet in the object
    $self->{'_location'} = $DEFAULT_LOCATION unless $self->{'_location'};

    # create a SOAP::Lite object, the main worker
    if (defined $self->{'_httpproxy'}) {
	$self->{'_soap'} = SOAP::Lite
	    -> proxy ($self->{'_location'},
		      timeout => (defined $self->{'_timeout'} ? $self->{'_timeout'} : 120),
		      proxy => ['http' => $self->{'_httpproxy'}]);
    } else {
	$self->{'_soap'} = SOAP::Lite
	    -> proxy ($self->{'_location'},
		      timeout => (defined $self->{'_timeout'} ? $self->{'_timeout'} : 120),
		      );
    }
    $self->{'_soap'}->uri ($self->{'_name'}) if $self->{'_name'};

    # forget cached things which should not be cloned into new
    # instances (because they may represent a completely different
    # analysis
    delete $self->{'_analysis_spec'};
    delete $self->{'_input_spec'};
    delete $self->{'_result_spec'};
}

#
# Create a hash with named inputs, all extracted 
# from the given data.
#
# The main job is done in the SUPER class - here we do
# only the SOAP-specific stuff.
#
sub _prepare_inputs {
    my $self = shift;
    my $rh_inputs = $self->SUPER::_prepare_inputs (@_);

    foreach my $name (keys %{$rh_inputs}) {
	my $value = $$rh_inputs{$name};

	# value of type ref ARRAY is send as byte[][]
	if (ref $value eq 'ARRAY') {
	    my @bytes =
		map { SOAP::Data->new (type  => 'base64',
				       value => $_) } @$value;
	    $$rh_inputs{$name} = \@bytes;
	    next;
	}
    }

    return $rh_inputs;
}

# ---------------------------------------------------------------------
#
#   Here are the methods implementing Bio::AnalysisI interface
#   (documentation is in Bio::AnalysisI)
#
# ---------------------------------------------------------------------

sub analysis_name {
    my $self = shift;
    ${ $self->analysis_spec }{'name'};
}

# Map getAnalysisType()
sub analysis_spec {
   my ($self) = @_;
   return $self->{'_analysis_spec'} if $self->{'_analysis_spec'};
   my $soap = $self->{'_soap'};
   $self->{'_analysis_spec'} = $soap->getAnalysisType->result;
}

# String describe()
sub describe {
   my ($self) = @_;
   my $soap = $self->{'_soap'};
   $soap->describe->result;
}

# Map[] getInputSpec()
sub input_spec {
   my ($self) = @_;
   return $self->{'_input_spec'} if $self->{'_input_spec'};
   my $soap = $self->{'_soap'};
   $self->{'_input_spec'} = $soap->getInputSpec->result;
}

# Map[] getResultSpec()
sub result_spec {
   my ($self) = @_;
   return $self->{'_result_spec'} if $self->{'_result_spec'};
   my $soap = $self->{'_soap'};
   $self->{'_result_spec'} = $soap->getResultSpec->result;
}

# String createJob (Map inputs)
# String createJob (String id)
# String createJob ()
sub create_job {
   my ($self, $params) = @_;
   my $job_id;
   my $force_to_live;

   # if $params is a reference then it contains *all* input data
   # (see details in '_prepare_inputs' how they can be coded) -
   # send it to the server to get a unique job ID
   if (ref $params) {
       my $rh_inputs = $self->_prepare_inputs ($params);
       my $soap = $self->{'_soap'};
       $job_id = $soap->createJob (SOAP::Data->type (map => $rh_inputs))->result;

   # if $params is a defined scalar it represents a job ID obtained in
   # some previous invocation - such job already exists on the server
   # side, just re-create it here using the same job ID
   # (in this case, such job will *not* be implicitly destroyed on exit)
   } elsif (defined $params) {
       $job_id = $params;
       $force_to_live = 1;

   # finally, if $params is undef, ask server to create an empty job
   # (and give me its unique job ID), the input data may be added
   # later using 'set_data' method(s) - see scripts/applmaker.pl
   } else {
       my $soap = $self->{'_soap'};
       $job_id = $soap->createEmptyJob->result;   # this method may not exist on server (TBD)
   }

   if ($force_to_live) {
       return new Bio::Tools::Run::Analysis::Job (-analysis => $self,
						  -id => $job_id,
						  -destroy_on_exit => 0,
						  );
   } elsif (defined $self->{'_destroy_on_exit'}) {
       return new Bio::Tools::Run::Analysis::Job (-analysis => $self,
						  -id => $job_id,
						  -destroy_on_exit => $self->{'_destroy_on_exit'},
						  );
   } else {
       return new Bio::Tools::Run::Analysis::Job (-analysis => $self,
						  -id => $job_id,
						  );
   }
}

# String createAndRun (Map inputs)
sub run {
   my $self = shift;
   return $self->create_job (@_)->run;
}

# Map runAndWaitFor (Map inputs)
sub wait_for {
   my $self = shift;
   return $self->run (@_)->wait_for;
}

# ---------------------------------------------------------------------
#
#   Here are internal methods fo Bio::Tools::Run::Analysis::soap...
#
# ---------------------------------------------------------------------

# Do something (or nothing) with $rh_resuls (coming from the server)
# depending on rules defined in $rh_rules.
#
# $rh_results: keys are result names, values are results themselves
# (either scalars or array references - if one result is split into
# more parts).
#
# $rh_rules: keys are result names, values say what to do with
# results: undef       ... do nothing, return unchanged result
#          -           ... send it to STDOUT, return nothing
#          @[template] ... put it into file (invent its name,
#                          perhaps based on template), return filename
#          ?[template] ... ask server for result type, then decide:
#                          put a binary result into file (invent its name)
#                          and return the filename, for other result type
#                          do nothing and return result unchanged
#  Special cases: if $rh_rules is scalar '@[template]', do with ALL results
#                 as described above for @[template], or
#                 if $rh_rules is scalar '?[template]', do with ALL results
#                 as described above for ?[template].

sub _process_results {
    my ($self, $rh_results, $rh_rules) = @_;

    my $default_rule = $rh_rules if defined $rh_rules && $rh_rules =~ /^[\?@]/;
    foreach my $name (keys %$rh_results) {
	my $rule = $default_rule ? $default_rule : $$rh_rules{$name};
	next unless $rule;
	next if $rule =~ /^\?/ && ! $self->is_binary ($name);

	my ($prefix, $template) = $rule =~ /^([\?@])(.*)/;
	$template = $ENV{'RESULT_FILENAME_TEMPLATE'} unless $template;
	my $filename = $rule unless $template || $prefix;

	my $stdout = ($rule eq '-');

	if (ref $$rh_results{$name}) {
	    # --- result value is an array reference
	    my $seq = 1;
	    foreach my $part (@{ $$rh_results{$name} }) {
		print STDOUT $part && next if $stdout;
		$part = $self->_save_result (-value    => $part,
					     -name     => $name,
					     -filename => $filename,
					     -template => $template,
					     -seq      => $seq++);
	    }
	    
	} else {
	    # --- result value is a scalar
	    print STDOUT $$rh_results{$name} && next if $stdout;
	    $$rh_results{$name} =
		$self->_save_result (-value    => $$rh_results{$name},
				     -name     => $name,
				     -filename => $filename,
				     -template => $template);
	}
	delete $$rh_results{$name} if $stdout;
    }
    $rh_results;
}

# ---------------------------------------------------------------------

#
# is the given result $name binary?
#

=head2 is_binary

  Usage   : if ($service->is_binary ('graph_result')) { ... }
  Returns : 1 or 0
  Args    : $name is a result name we are interested in

=cut

sub is_binary {
    my ($self, $name) = @_;
    foreach my $result (@{ $self->result_spec }) {
	if ($result->{'name'} eq $name) {
	    return ($result->{'type'} =~ /^byte\[/);
	}
    }
    return 0;
}

# ---------------------------------------------------------------------
#
#   Here are internal subroutines (NOT methods)
#   for Bio::Tools::Run::Analysis::soap
#
# ---------------------------------------------------------------------

sub _clean_msg {
    my ($msg) = @_;
    $msg =~ s/^org\.embl\.ebi\.SoaplabShare\.SoaplabException\:\s*//;
    $msg;
}

# ---------------------------------------------------------------------
#
#   Here is the rest of Bio::Analysis::soap
#
# ---------------------------------------------------------------------

=head2 VERSION and Revision

 Usage   : print $Bio::Tools::Run::Analysis::soap::VERSION;
           print $Bio::Tools::Run::Analysis::soap::Revision;

=cut

=head2 Defaults

 Usage   : print $Bio::Tools::Run::Analysis::soap::DEFAULT_LOCATION;

=cut


# ---------------------------------------------------------------------
#
#               Bio::Tools::Run::Analysis::Job::soap
#               ------------------------------------
#   A module representing a job (an invocation, an execution)
#   of an analysis (the analysis itself is represented by
#   a Bio::Tools::Run::Analysis::soap object)
#
#   Documentation is in Bio::AnalysisI::JobI.
#
# ---------------------------------------------------------------------

package Bio::Tools::Run::Analysis::Job::soap;

use vars qw(@ISA);
use strict;

@ISA = qw(Bio::Tools::Run::Analysis::Job);

sub _initialize {
    my ($self, @args) = @_;
    
    # make a hashtable from @args
    my %param = @args;
    @param { map { lc $_ } keys %param } = values %param; # lowercase keys

    # copy all @args into this object (overwriting what may already be
    # there) - changing '-key' into '_key'
    my $new_key;
    foreach my $key (keys %param) {
	($new_key = $key) =~ s/^-/_/;
	$self->{ $new_key } = $param { $key };
    }

    # finally add default values for those keys who have default value
    # and who are not yet in the object
    $self->{'_destroy_on_exit'} = 1 unless defined $self->{'_destroy_on_exit'};
}

# ---------------------------------------------------------------------
#
#   Here are the methods implementing Bio::AnalysisI::JobI interface
#   (documentation is in Bio::AnalysisI)
#
# ---------------------------------------------------------------------

# void run (String jobID)
sub run {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    $soap->run (SOAP::Data->type (string => $self->{'_id'}));
    return $self;
}

# void waitFor (String jobID)
sub wait_for {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    $soap->waitFor (SOAP::Data->type (string => $self->{'_id'}));
    return $self;
}


# void terminate (String jobID)
sub terminate {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    $soap->terminate (SOAP::Data->type (string => $self->{'_id'}));
    return $self;
}

# String getLastEvent (String jobID)
sub last_event {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    $soap->getLastEvent (SOAP::Data->type (string => $self->{'_id'}))->result;
}

# String getStatus (String jobID)
sub status {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    $soap->getStatus (SOAP::Data->type (string => $self->{'_id'}))->result;
}

# long getCreated (String jobID)
sub created {
    my ($self, $formatted) = @_;
    my $soap = $self->{'_analysis'}->{'_soap'};
    my $time = $soap->getCreated (SOAP::Data->type (string => $self->{'_id'}))->result;
    $formatted ? Bio::Tools::Run::Analysis::Utils::format_time ($time) : $time;
}

# long getStarted (String jobID)
sub started {
    my ($self, $formatted) = @_;
    my $soap = $self->{'_analysis'}->{'_soap'};
    my $time = $soap->getStarted (SOAP::Data->type (string => $self->{'_id'}))->result;
    $formatted ? Bio::Tools::Run::Analysis::Utils::format_time ($time) : $time;
}

# long getEnded (String jobID)
sub ended {
    my ($self, $formatted) = @_;
    my $soap = $self->{'_analysis'}->{'_soap'};
    my $time = $soap->getEnded (SOAP::Data->type (string => $self->{'_id'}))->result;
    $formatted ? Bio::Tools::Run::Analysis::Utils::format_time ($time) : $time;
}

# long getElapsed (String jobID)
sub elapsed {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    $soap->getElapsed (SOAP::Data->type (string => $self->{'_id'}))->result;
}

# Map getCharacterictics (String jobID)
sub times {
    my ($self, $formatted) = @_;
    my $soap = $self->{'_analysis'}->{'_soap'};
    my $rh_times = $soap->getCharacteristics (SOAP::Data->type (string => $self->{'_id'}))->result;
    map { $_ = Bio::Tools::Run::Analysis::Utils::format_time ($_) } values %$rh_times
	if $formatted;
    return $rh_times;
}

# Map getResults (String jobID)
# Map getResults (String jobID, String[] resultNames)

# Retrieving NAMED results:
# -------------------------
#  results ('name1', ...)   => return results as they are, no storing into files
#
#  results ( { 'name1' => 'filename', ... } )  => store into 'filename', return 'filename'
#  results ( 'name1=filename', ...)            => ditto
#
#  results ( { 'name1' => '-', ... } )         => send result to the STDOUT, do not return anything
#  results ( 'name1=-', ...)                   => ditto
#
#  results ( { 'name1' => '@', ... } )  => store into file whose name is invented by
#                                          this method, perhaps using RESULT_NAME_TEMPLATE env
#  results ( 'name1=@', ...)            => ditto
#
#  results ( { 'name1' => '?', ... } )  => find of what type is this result and then use
#                                          {'name1'=>'@' for binary files, and a regular
#                                          return for non-binary files
#  results ( 'name=?', ...)             => ditto
#
# Retrieving ALL results:
# -----------------------
#  results()     => return all results as they are, no storing into files
#
#  results ('@') => return all results, as if each of them given
#                   as {'name' => '@'} (see above)
#
#  results ('?') => return all results, as if each of them given
#                   as {'name' => '?'} (see above)
#
# Misc:
# -----
# * results(...) equals to result(...)
# * any result can be returned as a scalar value, or as an array reference
#   (the latter is used for results consisting of more parts, such images);
#   this applies regardless whether the returned result is the result itself
#   or a filename created for the result

sub results {
    my $self = shift;
    my $rh_names = Bio::Tools::Run::Analysis::Utils::normalize_names (@_);
    my $soap = $self->{'_analysis'}->{'_soap'};

    if (ref $rh_names) {
	# retrieve only named results
	return
	    $self->{'_analysis'}->_process_results
	        ($soap->getSomeResults (SOAP::Data->type (string => $self->{'_id'}),
					[ keys %$rh_names ])->result,
		 $rh_names);
    } else {
	# no result names given: take all
	return
	    $self->{'_analysis'}->_process_results
	        ($soap->getResults (SOAP::Data->type (string => $self->{'_id'}))->result,
		 $rh_names);
    }
}

sub result {
    my $self = shift;
    my $rh_results = $self->results (@_);
    (values %$rh_results)[0];
}

sub remove {
    shift->{'_destroy_on_exit'} = 1;
}

#
# job objects are being destroyed if they have attribute
# '_destroy_on_exit' set to true - which is a default value
# (void destroy (String jobID)
#
sub DESTROY {
    my $self = shift;
    my $soap = $self->{'_analysis'}->{'_soap'};
    return unless $self->{'_destroy_on_exit'} && $self->{'_id'};

    # ignore all errors here
    eval {
	$soap->destroy (SOAP::Data->type (string => $self->{'_id'}));
    }
}

1;
__END__
