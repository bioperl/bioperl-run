# $Id$
#
# BioPerl module Bio::Tools::Run::AnalysisFactory::soap.pm
#
# Cared for by Martin Senger <senger@ebi.ac.uk>
# For copyright and disclaimer see below.

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::AnalysisFactory::soap - A SOAP-based access to the list of analysis tools

=head1 SYNOPSIS

Do not use this object directly, it is recommended to access it and use
it through the I<Bio::Tools::Run::AnalysisFactory> module:

  use Bio::Tools::Run::AnalysisFactory;
  my $list = new Bio::Tools::Run::AnalysisFactory (-access => 'soap')
     ->available_analyses;

=head1 DESCRIPTION

All public methods are documented in the interface module
C<Bio::Factory::AnalysisI>.

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

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://industry.ebi.ac.uk/soaplab/Perl_Client.html

=back

=head1 BUGS AND LIMITATIONS

None known at the time of writing this.

=head1 APPENDIX

The main documentation details are in
C<Bio::Factory::AnalysisI>.

=cut

# Let the code begin...

package Bio::Tools::Run::AnalysisFactory::soap;
use vars qw(@ISA $VERSION $Revision $DEFAULT_LOCATION $DEFAULT_DIR_SERVICE);
use strict;

use Bio::Tools::Run::AnalysisFactory;
use Bio::Tools::Run::Analysis;
use SOAP::Lite
    on_fault => sub {
	my $soap = shift;
	my $res = shift;
	my $msg =
	    ref $res ?
		"--- SOAP FAULT ---\n" .
		'faultcode:   ' . $res->faultcode . "\n" .
		'faultstring: ' . Bio::Tools::Run::AnalysisFactory::soap::_clean_msg ($res->faultstring)
	      : "--- TRANSPORT ERROR ---\n" . $soap->transport->status;
        Bio::Tools::Run::AnalysisFactory::soap->throw ($msg);
    }
;

@ISA = qw(Bio::Tools::Run::AnalysisFactory);

BEGIN { 
    # set the version for version checking
    $VERSION = do { my @r = (q$Revision$ =~ /\d+/g); sprintf "%d.%-02d", @r };
    $Revision = q$Id$;

    # where to go...
    $DEFAULT_LOCATION = 'http://industry.ebi.ac.uk/soap/soaplab';

    # ...and what to find there
    $DEFAULT_DIR_SERVICE = 'AnalysisFactory';
}

# -----------------------------------------------------------------------------

=head2 _initialize

 Usage   : my $factory = new Bio::Tools::Run::AnalysisFactory (@args);
           (_initialize is internally called from the 'new()' method)
 Returns : nothing interesting
 Args    : This module recognises and uses following arguments:
             -location
             -dir
             -httpproxy
             -soap
	   Additionally, the main module Bio::Tools::Run::AnalysisFactory
           recognises also:
             -access

It populates calling object with the given arguments, and then - for
some attributes and only if they are not yet populated - it assigns
some default values.

This is an actual new() method (except for the real object creation
and its blessing which is done in the parent class Bio::Root::Root in
method _create_object).

Note that this method is called always as an I<object> method (never as
a I<class> method) - and that the object who calls this method may
already be partly initiated (from Bio::Tools::Run::AnalysisFactory::new method);
so if you need to do some tricks with the 'class invocation' you need to
change Bio::Tools::Run::AnalysisFactory I<new> method, not this one.

=over

=item -location

A URL (also called an I<endpoint>) defining where is located a Web Service
functioning for this object.

Default is C<http://industry.ebi.ac.uk/soap/soaplab> (an experimental
service running at European Bioinformatics Institute on top of most of
EMBOSS analyses).

For example, if you run your own Web Service using Java(TM) Apache Axis
toolkit, the location might be something like
C<http://localhost:8080/axis/services>.

=item -dir

A name of a Web Service (also called a I<urn> or a I<namespace>).

Default is I<AnalysisFactory> which corresponds well with the default
location.

=item -httpproxy

In addition to the I<location> parameter, you may need
to specify also a location/URL of an HTTP proxy server
(if your site requires one). The expected format is C<http://server:port>.
There is no default value.

=item -soap

Defines your own SOAP::Lite object. Useful if you need finer-grained
access to many features and attributes of the wonderful Paul Kulchenko's
module.

=back

=cut

# '

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
    $self->{'_dir'} = $DEFAULT_DIR_SERVICE unless $self->{'_dir'};

    # create a SOAP object which will do the main job
    unless ($self->{'_soap'}) {
	if (defined $self->{'_httpproxy'}) {
	    $self->{'_soap'} = SOAP::Lite
		-> proxy ($self->{'_location'},
			  proxy => ['http' => $self->{'_httpproxy'}]);
	} else {
	    $self->{'_soap'} = SOAP::Lite
		-> proxy ($self->{'_location'} . '/' . $self->{'_dir'});
	}
    }
}

sub _clean_msg {
    my ($msg) = @_;
    $msg =~ s/^org\.embl\.ebi\.SoaplabShare\.SoaplabException\:\s*//;
    $msg;
}

# String[] getAvailableCategories()
sub available_categories {
    my ($self) = @_;
    my $soap = $self->{'_soap'};
    $soap->getAvailableCategories->result;
}

# String[] getAvailableAnalyses()
# String[] getAvailableAnalyses (String categoryName)
sub available_analyses {
    my ($self, $category) = @_;
    my $soap = $self->{'_soap'};
    if (defined $category) {
	return
	    $soap->getAvailableAnalyses (SOAP::Data->type (string => $category))
	       ->result;
    } else {
	return
	    $soap->getAvailableAnalyses
	       ->result;
    }
}

# String getServiceLocation (String analysisName)
sub create_analysis {
    my ($self, $name) = @_;

    # service name
    my @name  = ('-name', $name) if $name;

    # ask for an endpoint
    my $soap = $self->{'_soap'};
    my $location =
	$soap->getServiceLocation (SOAP::Data->type (string => $name))
	   ->result;
    my @location  = ('-location', $location) if $location;

    # share some of my properties with the new Bio::Analysis object
    my @access  = ('-access', $self->{'_access'}) if $self->{'_access'};
    my @httpproxy = ('-httpproxy', $self->{'_httpproxy'}) if $self->{'_httpproxy'};

    new Bio::Tools::Run::Analysis (@name, @location, @httpproxy, @access);
}



=head2 VERSION and Revision

 Usage   : print $Bio::Tools::Run::AnalysisFactory::soap::VERSION;
           print $Bio::Tools::Run::AnalysisFactory::soap::Revision;

=cut

=head2 Defaults

 Usage   : print $Bio::Tools::Run::AnalysisFactory::soap::DEFAULT_LOCATION;
           print $Bio::Tools::Run::AnalysisFactory::soap::DEFAULT_DIR_SERVICE;

=cut


1;
__END__
