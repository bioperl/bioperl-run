# $Id$
#
# BioPerl module for Bio::DB::ESoap
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Mark A. Jensen <maj -at- fortinbras -dot- us>
#
# Copyright Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::DB::ESoap - Client for the NCBI Entrez EUtilities SOAP server

=head1 SYNOPSIS

 $fac = Bio::DB::ESoap->new( -util => 'esearch' );
 $som = $fac->run( -db => 'prot', -term => 'HIV and gp120' );
 $fac->set_parameters( -term => 'HIV2 and gp160' );
 # accessors corresponding to valid parameters are also created:
 $fac->db('nuccore');
 $som = $fac->run;

 # more later.
 
=head1 DESCRIPTION

C<ESoap> provides a basic SOAP interface to the NCBI Entrez Utilities
Web Service
(L<http://eutils.ncbi.nlm.nih.gov/entrez/eutils/soap/v2.0/DOC/esoap_help.html>).
L<SOAP::Lite> handles the SOAP calls. Higher level access, pipelines,
BioPerl object I/O and such are provided by
L<Bio::DB::SoapEUtilities>.

C<ESoap> complies with L<Bio::ParameterBaseI>. It depends explicitly
on NCBI web service description language files to inform the
C<available_parameters()> method. WSDLs are parsed by a relative
lightweight, Entrez-specific module L<Bio::DB::ESoap::WSDL>.

The C<run()> method returns L<SOAP::SOM> (SOAP Message) objects. No
fault checking or other parsing is performed in this module.

=head1 SEE ALSO

L<Bio::DB::EUtilities>, L<Bio::DB::SoapEUtilities>,
L<Bio::DB::ESoap::WSDL>

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Mark A. Jensen

Email maj -at- fortinbras -dot- us

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::DB::ESoap;
use strict;
use warnings;

use Bio::Root::Root;
use Bio::DB::ESoap::WSDL;
use SOAP::Lite;

use base qw(Bio::Root::Root Bio::ParameterBaseI);

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::DB::ESoap();
 Function: Builds a new Bio::DB::ESoap factory
 Returns : an instance of Bio::DB::ESoap
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($util, $fetch_db, $wsdl) = $self->_rearrange( [qw( UTIL FETCH_DB WSDL_FILE )], @args );
    $self->throw("Argument -util must be specified") unless $util;
    my @wsdl_pms;
    if ($wsdl) {
	@wsdl_pms = ( '-wsdl' => $wsdl );
    }
    else {
	$fetch_db ||= 'seq';
	my $url = ($util =~ /fetch/ ? 'f_'.$fetch_db : 'eutils');
	$url = $NCBI_BASEURL.$WSDL{$url};
	@wsdl_pms = ( '-url' => $url );
    }
    $self->_wsdl(Bio::DB::ESoap::WSDL->new(@wsdl_pms));
    $self->_operation($util);
    $self->_init_parameters;
    $self->_client( SOAP::Lite->new( proxy => $self->_wsdl->service ) );
    
    return $self;
}

=head2 _wsdl()

 Title   : _wsdl
 Usage   : $obj->_wsdl($newval)
 Function: Bio::DB::ESoap::WSDL object associated with 
           this factory
 Example : 
 Returns : value of _wsdl (object)
 Args    : on set, new value (object or undef, optional)

=cut

sub _wsdl {
    my $self = shift;
    
    return $self->{'_wsdl'} = shift if @_;
    return $self->{'_wsdl'};
}

=head2 _client()

 Title   : _client
 Usage   : $obj->_client($newval)
 Function: holds a SOAP::Lite object
 Example : 
 Returns : value of _client (a SOAP::Lite object)
 Args    : on set, new value (a SOAP::Lite object or undef, optional)

=cut

sub _client {
    my $self = shift;
    return $self->{'_client'} = shift if @_;
    return $self->{'_client'};
}

=head2 _operation()

 Title   : _operation
 Alias   : util
 Usage   : 
 Function: check and convert the requested operation based on the wsdl
 Returns : 
 Args    : operation (scalar string)

=cut

sub _operation {
    my $self = shift;
    my $util = shift;
    return $self->{'_operation'} unless $util;
    $self->throw("WSDL not yet initialized") unless $self->_wsdl;
    my $opn = $self->_wsdl->operations;
    if ( grep /^$util$/, keys %$opn ) {
	return $self->{'_operation'} = $util;
    }
    elsif ( grep /^$util$/, values %$opn ) {
	my @a = grep { $$opn{$_} eq $util } keys %$opn;
	return $self->{'_operation'} = $a[0];
    }
    else {
	$self->throw("Utility '$util' is not recognized");
    }
}

sub util { shift->_operation(@_) }

=head2 action()

 Title   : action
 Usage   : 
 Function: return the soapAction associated with the factory's utility
 Returns : scalar string
 Args    : none

=cut

sub action {
    my $self = shift;
    return $self->{_action} if $self->{_action};
    return $self->{_action} = ${$self->_wsdl->operations}{$self->util};
}



=head2 wsdl_file()

 Title   : wsdl_file
 Usage   : 
 Function: get filename of the local WSDL XML copy
 Returns : filename (scalar string)
 Args    : none

=cut

sub wsdl_file { 
    my $self = shift;
    if (ref ($self->_wsdl->wsdl) eq 'File::Temp') {
	return $self->_wsdl->wsdl->filename;
    }
    return $self->_wsdl->wsdl;
}

=head2 run()

 Title   : _run
 Usage   : $som = $self->_run(@optional_setting_args)
 Function: Call the SOAP service with the factory-associated utility
           and parameters
 Returns : SOAP::SOM (SOAP Message) object
 Args    : named parameters appropriate for the utility
 Note    : no fault checking here

=cut

sub run {
    my $self = shift;
    my @args = @_;
    $self->throw("SOAP::Lite client not initialized") unless 
	$self->_client;
    $self->throw("run requires named args") if @args % 2;
    $self->set_parameters(@args) if scalar @args;
    my %args = $self->get_parameters;
    my @soap_data;
    for my $k (keys %args) {
	## kludges for NCBI inconsistencies:
	my $k_ncbi;
	for ($k) {
	    /QueryKey/ && do {
		$k_ncbi = 'query_key';
		last;
	    };
	    /RetMax/ && do {
		$k_ncbi = 'retmax';
		last;
	    };
	    $k_ncbi = $k;
	}
	my $data = $args{$k};
	next unless defined $data;
	for (ref $data) {
	    /^$/ && do {
		push @soap_data, SOAP::Data->name($k_ncbi)->value($data);
		last;
	    };
	    /ARRAY/ && do {
		push @soap_data, SOAP::Data->name($k_ncbi)->value(join(',',@$data));
		last;
	    };
	    /HASH/ && do {
		# for adding multiple data items with the same message 
		# key (id lists for elink, e.g.)
		# see ...::SoapEUtilities, c. line 151
		push @soap_data, map { 
		    SOAP::Data->name($k_ncbi)->value($_)
		} keys %$data;
	    };
	}
    }
    $self->_client->on_action( sub { $self->action } );
    my $som = $self->_client->call( $self->util, 
				    @soap_data );
    
    return $som;
}

sub _result_elt_name { my $s=shift; (keys %{$s->_wsdl->response_parameters($s->util)})[0] };
sub _response_elt_name { shift->_result_elt_name }
sub _request_elt_name { my $s=shift; (keys %{$s->_wsdl->request_parameters($s->util)})[0] };

=head2 Bio::ParameterBaseI compliance

=cut 

sub available_parameters {
    my $self = shift;
    my @args = @_;
    return @{$self->_init_parameters};
}

sub set_parameters {
    my $self = shift;
    my @args = @_;
    $self->throw("set_parameters requires named args") if @args % 2;
    ($_%2 ? 1 : $args[$_] =~ s/^-//) for (0..$#args);
    my %args = @args;

    # special translations :
    if ( defined $args{'usehistory'} ) {
	$args{'usehistory'} = ($args{'usehistory'} ? 'y' : undef);
    }

    $self->_set_from_args(\%args, -methods=>$self->_init_parameters);
    return $self->parameters_changed(1);

}

sub get_parameters {
    my $self = shift;
    my @ret;
    foreach (@{$self->_init_parameters}) {
	next unless defined $self->$_();
	push @ret, ($_, $self->$_());
    }
    return @ret;
}

sub reset_parameters {
    my $self = shift;
    my @args = @_;
    $self->throw("reset_parameters requires named args") if @args % 2;
    ($_%2 ? 1 : $args[$_] =~ s/^-//) for (0..$#args);
    my %args = @args;
    my %reset;
    @reset{@{$self->_init_parameters}} = (undef) x @{$self->_init_parameters};
    $reset{$_} = $args{$_} for keys %args;
    $self->_set_from_args( \%reset, -methods => $self->_init_parameters );
    $self->parameters_changed(1);
    return 1;
}

=head2 parameters_changed()

 Title   : parameters_changed
 Usage   : $obj->parameters_changed($newval)
 Function: flag to indicate, well, you know
 Example : 
 Returns : value of parameters_changed (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub parameters_changed {
    my $self = shift;
    return $self->{'parameters_changed'} = shift if @_;
    return $self->{'parameters_changed'};
}

=head2 _init_parameters()

 Title   : _init_parameters
 Usage   : $fac->_init_parameters
 Function: identify the available input parameters
           using the wsdl object
 Returns : arrayref of parameter names (scalar strings)
 Args    : none

=cut

sub _init_parameters {
    my $self = shift;
    return $self->{_params} if $self->{_params};
    $self->throw("WSDL not yet initialized") unless $self->_wsdl;
    my $phash = {};
    my $val = (values %{$self->_wsdl->request_parameters($self->util)})[0];
    $$phash{$_} = undef for map { keys %$_ } @{$val};
    my $params =$self->{_params} = [sort keys %$phash];
    # create parm accessors
    $self->_set_from_args( $phash, 
			   -methods => $params,
			   -create => 1,
			   -code => 
			   'my $self = shift; 
                            if (@_) {
                              $self->parameters_changed(1);
                              return $self->{\'_\'.$method} = shift;
                            }
                            $self->parameters_changed(0);
                            return $self->{\'_\'.$method};' );
    $self->parameters_changed(1);
    return $self->{_params};
}

1;
