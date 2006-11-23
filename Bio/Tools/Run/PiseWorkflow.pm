# $Id$
#
# Cared for by  S. Thoraval <s.thoraval@imb.uq.edu.au>
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseWorkflow

=head1 SYNOPSIS

  # First, create a Bio::Tools::Run::AnalysisFactory::Pise object:
  my $factory = new Bio::Tools::Run::AnalysisFactory::Pise();
  # Then create the application objects (Pise::Run::Tools::PiseApplication):
  my $clustalw = $factory->program('clustalw');
  $clustalw->infile($my_alignment_file);
  my $protpars = $factory->program('protpars');

  # You can specify different servers for different applications :
  my $protdist = $factory->program('protpars'
				   -remote => 'http://kun.homelinux.com/cgi-bin/Pise/5.a//protpars.pl',
				   -email => 'your_email');

  # Create a new workflow object : 
  my $workflow = Bio::Tools::Run::PiseWorkflow->new(); 

  # Define the workflow's methods using the application objects:
  # the application method $protpars will receive the output of 
  # type 'readseq_ok_alig' from the application method $clustalw.
  $workflow->addpipe(-method => $clustalw,
		     -tomethod => $protpars,
		     -pipetype => 'readseq_ok_alig');

  # The application method $clustalw will be piped to a second 
  # application method ($protdist) using the output of type 'readseq_ok_alig'.
  $workflow->addpipe(-method => $clustalw,
		     -tomethod => $protdist,
		     -pipetype => 'readseq_ok_alig');

  # The application method $protpars will be piped to the application 
  # method $consense using the output of type 'phylip_tree'.
  my $consense = $factory->program('consense');
  $workflow->addpipe(-method => $protpars,
		     -tomethod => $consense,
		     -pipetype => 'phylip_tree');

  # Run the workflow.
  $workflow->run();


=head1 DESCRIPTION

A class to create a Pise workflow using Pise application objects as methods.
A workflow is defined by a set of methods which all instanciate the
class PiseApplication.  

Create the workflow object :

  my $workflow = Bio::Tools::Run::PiseWorkflow->new();

You can specify which application will be used as the first method at
creation of the workflow object: (by default, this first
method will be the one specified by the option -method at the
First call of the function addpipe(). 

  my $workflow = Bio::Tools::Run::PiseWorkflow->new($clustalw);

Use the function addpipe to define the workflow :

  $workflow->addpipe(-method => $clustalw,
		     -tomethod => $protpars,
		     -pipetype => 'readseq_ok_alig');

One method may be piped to different methods in the workflow:

  $workflow->addpipe(-method => $clustalw,
		     -tomethod => $protdist,
		     -pipetype => 'readseq_ok_alig');

To run the workflow (processes will be forked when possible):

  $workflow->run();

An html temporary file summarising the jobs status will be created in
the working directory. 	The html output file can also be specified:

  $workflow->run(-html => 'jobs.html');



=cut

# Let the code begin...

package Bio::Tools::Run::PiseWorkflow;

use vars qw(@ISA);
use strict;
use Bio::Root::Root;
use Bio::Tools::Run::PiseApplication;
use Bio::Tools::Run::PiseJob;
use Data::Dumper;
use CGI;
use File::Temp qw/ tempfile /;
use Fcntl qw(:DEFAULT :flock);
use Bio::Root::Version;

@ISA = qw(Bio::Root::Root);
my %pids;

our $VERSION = ${Bio::Root::Version::VERSION};

=head2 new

 Title   : new()
 Usage   : my $workflow = Bio::Tools::Run::PiseWorkflow->new();
 Function: Creates a Bio::Tools::Run::PiseWorkflow object.
 Example : my $workflow = Bio::Tools::Run::PiseWorkflow->new();
 Returns : An instance of Bio::Tools::Run::PiseWorkflow.

=cut

sub new {
 my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($method, $verbose) = $self->_rearrange([qw(METHOD VERBOSE)], @args);
    if (defined $verbose) {
	$self->{VERBOSE} = $verbose;
    } else {
	$self->{VERBOSE} = 0;
    }
    if (defined $method) {
	$self->{'PIPEDEF'}[0]{'method'} = $method;
    }
    return $self;
}

=head2 addpipe

 Title   : addpipe()
 Usage   : $workflow = Bio::Tools::Run::PiseWorkflow->addpipe(
                             -method => $clustalw,
                             -tomethod => $protpars,
                             -pipetype => 'readseq_ok_alig');
 Function: Pipe two methods of class PiseApplication in the workflow object.
 Example : $workflow = Bio::Tools::Run::PiseWorkflow->addpipe($clustalw, $protpars, 'readseq_ok_alig');
 Returns :

=cut

sub addpipe {
 my ($self, @args) = @_;
 my ($method, $tomethod, $pipetype) = $self->_rearrange([qw(METHOD TOMETHOD PIPETYPE)], @args);
 my $index = (defined $self->{'PIPEDEF'})? scalar @{$self->{'PIPEDEF'}} : undef;
 my $h = $self->_method($method);
 if (defined $method && defined $tomethod) {
	if (defined $h) {
		if (defined $pipetype) {
			$self->{'PIPEDEF'}[$index] = {'method' => $tomethod,
							'methodid' => $index,
							'from' => $h->{'methodid'},
							'pipetype' => $pipetype,
							};
			push @{$h->{'tomethod'}}, $index;
		} else {$self->throw("Argument pipetype missing");}
	} elsif ($index >= 1) {
		$self->throw("Method $method does not exist in the workflow");
	} else {
		$self->{'PIPEDEF'}[0]{'method'} = $method;
		$self->{'PIPEDEF'}[0]{'methodid'} = 0;
		$self->addpipe($method, $tomethod, $pipetype);
	}
 } else { $self->throw("Argument missing"); }
}


=head2 run

 Title   : run()
 Usage   : $workflow = Bio::Tools::Run::PiseWorkflow->run();
 Function: Run the defined workflow. You may provide an
           interval for jobs' completion checking and a file for html output.
 Examples : $workflow = Bio::Tools::Run::PiseWorkflow->run();
	$workflow = Bio::Tools::Run::PiseWorkflow->run(-interval => '200', -html => 'jobs.html');
 Returns :

=cut

sub run {
 my ($self, @args) = @_;
 my ($interval) = $self->_rearrange([qw(INTERVAL )], @args);
 if (! defined $self->{'INTERVAL'}) {
 	$self->{'INTERVAL'} = 100;
 } else {
 	$self->{'INTERVAL'} = $interval;
 }
 my ($jobs_html) = $self->_rearrange([qw(HTML )], @args);
 if (defined $jobs_html) {
 	$self->{'HTML'} = $jobs_html;
	open HTML,">$jobs_html";
	close HTML;
 } else {
 	my $fh1;
 	($fh1, $self->{'HTML'}) = tempfile("jobs_XXXXX", SUFFIX => '.html');
	close $fh1;
 }
 print STDERR "PiseWorkflow: Jobs\' informations will be written and updated in file ", $self->{'HTML'}, "\n";
 my $fh2;
 ($fh2, $self->{'DUMP'}) = tempfile("XXXXX", SUFFIX => '.dump');
 print $fh2 "\$VAR1 = {};";
 close $fh2;
 $self->_init(0);
}


sub _init {
 my $self = shift;
 my @methods = @_;
 my $children = 0;
 foreach my $in (@methods) {
	$| = 1;
	my $pid = fork();
	$pids{$pid} = $in;
	if ($pid) {
		# parent
		$children++;
	} elsif (defined $pid) {
		# children
		if ($self->_submit($in)) {
			exit 0;
		} else {exit 1;}

	} else {
		$self->throw("Enable to fork.");
	}
 }
 while ($children) {
	my $dead_child = wait;
	$children--;
	my $in = $pids{$dead_child};
	my $fh = $self->_wopen($self->{'DUMP'});
	my %jobs = $self->_eval($fh);
 if ($jobs{$in}{'STATUS'} eq "ERROR") {
		$jobs{$in}{'STATUS'} =  "ERROR";
		if ($self->{'PIPEDEF'}[$in]{'tomethod'}) {
			my @methods =  @{$self->{'PIPEDEF'}[$in]{'tomethod'}};
			foreach my $piped (@methods) {
				$jobs{$piped}{'STATUS'} = "ERROR";
				$jobs{$piped}{'ERROR'} = "broken pipe !";
			}
			$self->_write(\%jobs, $fh);
			close $fh;	# can't forget to close the file handle !
			next;
		} else {
			$self->_write(\%jobs, $fh);
			close $fh;
		}
	} elsif ($self->{'PIPEDEF'}[$in]{'tomethod'}) {
		close $fh;
		my @methods =  @{$self->{'PIPEDEF'}[$in]{'tomethod'}};
		if (@methods) {
			foreach my $piped (@methods) {
				$self->_pipe($in, $piped);
			}
			$self->_init(@methods);
		}
	} else { close $fh; }
 }
}


sub _submit {
 my $self = shift;
 my $key = shift;
 my $appli = $self->{'PIPEDEF'}[$key]{'method'};
 my $fh1 = $self->_wopen($self->{'DUMP'});
 my %jobs1 = $self->_eval($fh1);

 # run the method
 $jobs1{$key}{'STATUS'} = "SUBMITTED";
 $self->_write(\%jobs1, $fh1);
 close $fh1;

 my $job = $appli->submit();
 my $jobid;
 my $fh2 = $self->_wopen($self->{'DUMP'});
 my %jobs2 = $self->_eval($fh2);
 if (! defined $job) {
	$jobs2{$key}{'STATUS'} = "ERROR";
	$jobs2{$key}{'ERROR'} = "No job created !";
	$self->_write(\%jobs2, $fh2);
 	close $fh2;
	return -1;
 } else {
	$jobid = $job->jobid;
	$jobs2{$key}{'JOB'} = $jobid;
	$jobs2{$key}{'STATUS'} = "RUNNING";
 }
 if (! defined $jobid) {
	$jobs2{$key}{'STATUS'} = "ERROR";
	$jobs2{$key}{'ERROR'} = "No job id !";
	$self->_write(\%jobs2, $fh2);
 	close $fh2;
	return -1;
 }

 if ($job->error) {
	$jobs2{$key}{'STATUS'} = "ERROR";
	$jobs2{$key}{'ERROR'} = $job->error_message;
	$self->_write(\%jobs2, $fh2);
 	close $fh2;
	return -1;
 } else {
	$self->_write(\%jobs2, $fh2);
 	close $fh2;
 }

 if (! $job->terminated($jobid)) {
	$job->results_type("url");
	while (! $job->terminated($jobid)) {
		sleep $self->{'INTERVAL'};
	}
 }

 my $fh3 = $self->_wopen($self->{'DUMP'});
 my %jobs3 = $self->_eval($fh3);
 $jobs3{$key}{'STATUS'}  = "DONE";
 $self->_write(\%jobs3, $fh3);
 close $fh3;
}


sub _pipe {
 my $self = shift;
 my $in = shift;
 my $piped = shift;
 my $jobid;
 my $in_job;
 my $fh = $self->_wopen($self->{'DUMP'});
 my %jobs = $self->_eval($fh);
 if ($jobid = $jobs{$in}{'JOB'}) {
	$in_job = Bio::Tools::Run::PiseJob->job($jobid);
 } else {
	$jobs{$piped}{'STATUS'} = "ERROR";
	$jobs{$piped}{'ERROR'} = "broken pipe: fromJob not found !";
	$self->_write(\%jobs, $fh);
 	close $fh;
	return -1;
 }

 # fetch the piped method's input from the first method
 my $piped_appli = $self->{'PIPEDEF'}[$piped]{'method'};
 my $pipetype = $self->{'PIPEDEF'}[$piped]{'pipetype'};
 my $param;
 my %pipein = $piped_appli->pipein;
 foreach (keys %pipein) {
	if (defined $piped_appli->pipein($_, $pipetype)) {
		$param = $_;
		last;
	}
 }
 if ($param) {
 	$piped_appli->$param($in_job->fh($in_job->lookup_piped_file("$pipetype")));
 	close $fh;
 } else {
	$jobs{$piped}{'STATUS'} = "ERROR";
	$jobs{$piped}{'ERROR'} = "wrong pipe $pipetype";
	$self->_write(\%jobs, $fh);
 	close $fh;
	return -1;
 }
}


sub _method {
 my $self = shift;
 my $method = shift;
 if (defined @{$self->{'PIPEDEF'}}) {
	foreach (@{$self->{'PIPEDEF'}}) {
		if ($_->{'method'} == $method) {
			return $_;
		}
	}
	return undef;
 } else { return undef; }
}


sub _wopen {
 my $self = shift;
 my $file = shift;
 sysopen(FH, "$file", O_RDWR) || die "can\'t open $file: $!";
 $| =1;
 while (! flock(FH,LOCK_EX)) {
	#$| =1;
	sleep 1;
 }
 return \*FH;
}


sub _write {
 my $self = shift;
 my $jobs = shift;
 my $fh = shift;
 truncate($fh, 0) or die "cannot truncate filename: $!";
 print $fh Dumper($jobs);
 my $html = $self->_wopen($self->{'HTML'});
 $self->_print_html($html,$jobs);
 close $html;
}


sub _eval {
 my $self = shift;
 my $fh = shift;
 my $jobs;
 while (<$fh>) {$jobs .= $_;}
 $jobs =~ s/^.*\$VAR1/\$VAR1/;
 my $VAR1;
 eval $jobs || die "cannot eval : $!\n";
 return %{$VAR1};
}


sub _print_html {
 my $self = $_[0];
 my $fh = $_[1];
 my %jobs = %{$_[2]};
 truncate($fh, 0) or die "cannot truncate filename: $!";
 my $output = new CGI;
 print $fh $output->start_html(-title => 'Jobs Informations',
 				-head=>$output->meta(
                                     {-http_equiv=>'expires',-content=>'0'}
                                    ),
				); # {-http_equiv=>'Refresh',-content=>'30'}{-http_equiv=>'expires',-content=>'0'}
 print $fh "<script language=\"JavaScript\">
	var sURL = unescape(document.location.pathname);
	function refresh()
	{ document.location.href = sURL; }
	</script>\n";
 print $fh $output->h2('Jobs Informations');
 print $fh "<strong>Click</strong> on \'Jobs\' or <strong>bookmark</strong> to display this page later again...<BR><BR>\n";
 print $fh "\n<table border=\"1\" cellpadding=\"3\">\n";
 print $fh "\n<tr align=\"center\"><td>METHOD</td><td>JOB</td><td>STATUS</td><td>From METHOD</td><td>RESULTS</td></tr>\n";
 foreach (@{$self->{'PIPEDEF'}}) {
 	my $method = $_->{'method'}->command();
	my $id = $_->{'methodid'};
	my $display_id = $id + 1;
	my $jobid = ($jobs{$id}{'JOB'})? $jobs{$id}{'JOB'} : "";
	my $jobnum = ($jobid =~ m/\/([A-Z][0-9]+)\/?/)? $1 : "";
	my $fromid = ($id != 0)? $_->{'from'}: undef;
	my $frommethod = "";
	if (defined $fromid) {
		$frommethod = $self->{'PIPEDEF'}[$fromid]{'method'}->command();
		$fromid++;
	} elsif ($id == 0) {$frommethod = "-";}
	my $status = ($jobs{$id}{'STATUS'})? $jobs{$id}{'STATUS'} : "";
	print $fh "\n<tr align=\"center\">\n";
	print $fh "<td>$method ($display_id)</td>\n";
	print $fh "<td>$jobnum</td>\n";
	if ($status eq "ERROR" && $jobs{$id}{'ERROR'}) {
		print $fh "<td>$status : $jobs{$id}{'ERROR'}</td>\n";
	} else {
		print $fh "<td>$status</td>\n";
	}
	##print HTML "<td>$fromjobnum</td>\n";
	if ($fromid) {
		print $fh "<td>$frommethod ($fromid)</td>\n";
	} else {
		print $fh "<td>$frommethod</td>\n";
	}
	if ($jobnum) {
		print $fh "<td><a href=\"$jobid\" target=\"_blank\">results for $method</a></td></tr>\n";
	}
	else {
		print $fh "<td></td></tr>\n";
	}
 }
 print $fh "\n</table>\n";
 print $fh "<br><br><a href=\"javascript:refresh()\">Refresh Jobs Informations</a>\n";
 #print $fh "<BR><BR>An <strong>email</strong> will be sent upon completion of all jobs.<BR>\n";
 print $fh $output->end_html();
}


1;
