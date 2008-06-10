# $Id$
# BioPerl modules for Pise
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::AnalysisFactory::Pise - A class to create Pise
application objects.

=head1 SYNOPSIS

  use Bio::Tools::Run::AnalysisFactory::Pise;

  # Build a Pise factory
  my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();

  # Then create an application object (Pise::Run::Tools::PiseApplication):
  my $program = $factory->program('genscan');

  # Set parameters
  $program->seq($ARGV[0]);

  # Next, run the program
  # (notice that you can set some parameters at run time)
  my $job = $program->run(-parameter_file => "Arabidopsis.smat");

  # Test for submission errors:
  if ($job->error) {
     print "Job submission error (",$job->jobid,"):\n";
     print $job->error_message,"\n";
     exit;
  }

  # Get results
  print STDERR $job->content('genscan.out');
  # or:
  my $result_file = $job->save('genscan.out');

=head1 DESCRIPTION

Bio::Tools::Run::AnalysisFactory::Pise is a class to create Pise
application objects, that let you submit jobs on a Pise server.

  my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new(
                                              -email => 'me@myhome');

The email is optional (there is default one). It can be useful,
though.  Your program might enter infinite loops, or just run many
jobs: the Pise server maintainer needs a contact (s/he could of course
cancel any requests from your address...). And if you plan to run a
lot of heavy jobs, or to do a course with many students, please ask
the maintainer before.

The location parameter stands for the actual CGI location, except when
set at the factory creation step, where it is rather the root of all
CGI.  There are default values for most of Pise programs.

You can either set location at:

=over 3

=item 1 factory creation:

  my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new(
                                 -location => 'http://somewhere/Pise/cgi-bin',
				 -email => 'me@myhome');

=item 2 program creation:

  my $program = $factory->program('water', 
	  		   -location => 'http://somewhere/Pise/cgi-bin/water.pl'
				  );

=item 3 any time before running:

  $program->location('http://somewhere/Pise/cgi-bin/water.pl');
  $job = $program->run();

=item 4 when running:

  $job = $program->run(-location => 'http://somewhere/Pise/cgi-bin/water.pl');

=back

You can also retrieve a previous job results by providing its url:

  $job = $factory->job($url);

You get the url of a job by:

  $job->jobid;

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.open-bio.org/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

Bio::Tools::Run::PiseApplication
Bio::Tools::Run::PiseJob

=cut

# Let the code begin...

package Bio::Tools::Run::AnalysisFactory::Pise;

use vars qw($AUTOLOAD $DEFAULT_PISE_EMAIL @ISA %LOCATION);
use strict;

use Bio::Root::Root;
use Bio::Tools::Run::PiseApplication;
use Bio::Tools::Run::PiseJob;
use Bio::Factory::ApplicationFactoryI;

@ISA = qw(Bio::Root::Root Bio::Factory::ApplicationFactoryI );

%LOCATION = (
    'default' => 'http://bioweb.pasteur.fr/cgi-bin/seqanal',
    'clustalw' => 'http://bioweb.pasteur.fr/cgi-bin/seqanal/clustalw.pl',
    'coils2' => 'http://tofu.tamu.edu/cgi-bin/seqanal/coils2.pl'
);

$DEFAULT_PISE_EMAIL = 'pise-bioapi@pasteur.fr';

=head2 new

 Title   : new()
 Usage   : my $program = Bio::Tools::Run::AnalysisFactory::Pise->new(
                               -location => 'http://somewhere/cgi-bin/Pise', 
                               -email => $email);
 Function: Creates a Bio::Tools::Run::AnalysisFactory::Pise object, which 
           function is to create interface object 
           (Bio::Tools::Run::PiseApplication::program) for programs.
 Example :
 Returns : An instance of Bio::Tools::Run::AnalysisFactory::Pise.

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($location) =
	$self->_rearrange([qw(LOCATION )],
			  @args);
    my ($email) =
	$self->_rearrange([qw(EMAIL )],
			@args);
    
    my ($verbose) =
	$self->_rearrange([qw(VERBOSE )],
			  @args);
    
    if (defined $location) {
	$self->{LOCATION} = $location;
    }

    if (defined $email) {
	$self->{EMAIL} = $email;
    } else {
	$self->{EMAIL} = 'pise-bioapi@pasteur.fr';
    }
    if (defined $verbose) {
	$self->{VERBOSE} = $verbose;
    } else {
	$self->{VERBOSE} = 0;
    }
    return $self;
}

=head2 program()

 Title   : program()
 Usage   : my $program = Bio::Tools::Run::AnalysisFactory::Pise->program(
                             $program, 
                             -location => 'http://somewhere/cgi-bin/Pise',
                             -email => $email,
                             @params);
 Function: Creates a representation of a single Pise program.
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::$program.

=cut

sub program {
    my ($self, $program, @args) = @_;

    my ($location) =
      $self->_rearrange([qw(LOCATION )],
			@args);
    my ($email) =
	$self->_rearrange([qw(EMAIL )],
			  @args);

    my ($verbose) =
	$self->_rearrange([qw(VERBOSE )],
			  @args);
    if (! $location) {
	if (defined $self->{LOCATION}) {
	    if ($self->{LOCATION} =~ /$program/) {
		$location = $self->{LOCATION};
	    } else {
		$location = $self->{LOCATION} . "/$program.pl";
	    }
	} else {
	    if (defined $LOCATION{$program}) {
		$location = $LOCATION{$program};
	    } else {
		$location = $LOCATION{'default'} . "/$program.pl";
	    }
	}
    }
    if (! $email) {
	$email = $self->{EMAIL};
    }
    if (! $verbose) {
	$verbose= $self->{VERBOSE};
    }

    no strict "subs";

    my $package = "Bio::Tools::Run::PiseApplication::$program";  
    my $pise_program;

    eval ("use $package");
    $self->throw("Problem to load Bio::Tools::Run::PiseApplication::${program}\n\n$@")
	if $@;

    eval($pise_program = $package->new($location, $email) );
    use strict "subs";

    foreach my $param ($pise_program->parameters_order) {
	my $param_name = $param;
	$param_name =~ tr/a-z/A-Z/;
	#print STDERR "setting $param_name ...?\n";
	my ($value) =
	    $self->_rearrange([$param_name],
			      @args);
	if ($value) {
	    #print STDERR "setting $param to $value\n";
	    $pise_program->$param($value);
	}
    }

    #print STDERR "creation of $pise_program ", ref($pise_program), "\n"; 
    return $pise_program;

}

=head2 job

 Title   : job(url)
 Usage   : my $job = Bio::Tools::Run::AnalysisFactory::Pise->job(
              'http://somewhere/cgi-bin/Pise/tmp/dnapars/A3459687595869098');
 Function: Creates a previously run job by providing its jobid (url of 
           results).
 Example :
 Returns : An instance of Bio::Tools::Run::PiseJob.

=cut

sub job {
    my ($self, $jobid) = @_;
    my $job = Bio::Tools::Run::PiseJob->job($jobid);
    return $job;
}

1;
