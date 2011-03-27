# $Id$
#
# BioPerl module for Bio::DB::ESoap::WSDL
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

Bio::DB::ESoap::WSDL - WSDL parsing for Entrez SOAP EUtilities

=head1 SYNOPSIS

Used by L<Bio::DB::ESoap>
 
 # url
 $wsdl = Bio::DB::ESoap::WSDL->new(
    -url => "http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/v2.0/eutils.wsdl"
  );
 # local copy
 $wsdl = Bio::DB::ESoap::WSDL->new(
    -wsdl => "local/eutils.wsdl"
  );

  %opns = %{ $wsdl->operations };
  

=head1 DESCRIPTION

This module is a lightweight parser and container for WSDL XML files
associated with the NCBI EUtilities SOAP server. XML facilities are
provided by L<XML::Twig>.

The following accessors provide names and structures useful for
creating SOAP messages using L<SOAP::Lite> (e.g.):

 service()    : the URL of the SOAP service
 operations() : hashref of the form {.., $operation_name => $soapAction, ...}
 request_parameters($operation) : 
    request field names and namelists as an array of hashes
 result_parameters($operation)  : 
    result field names and namelists as an array of hashes

The following accessors provide L<XML::Twig::Elt> objects pointing at
key locations in the WSDL:

 root            : the root of the WSDL docment
 _types_elt      : the <types> element
 _portType_elt   : the <portType> element
 _binding_elt    : the <binding> element
 _service_elt    : the <service> element
 _message_elts   : an array of all top-level <message> elements
 _operation_elts : an array of all <operation> elements contained in <binding>
 
Parsing occurs lazily (on first read, not on construction); all
information is cached. To clear the cache and force re-parsing, run

 $wsdl->clear_cache;

The globals C<$NCBI_BASEURL>, C<$NCBI_ADAPTOR>, and C<%WSDL> are exported.

 $NCBI_ADAPTOR : the soap service cgi
 
To construct a URL for a WSDL:

 $wsdl_eutils = $NCBI_BASEURL.$WSDL{'eutils'}
 $wsdl_efetch_omim = $NCBI_BASEURL.$WSDL{'f_omim'}
 # etc.

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

package Bio::DB::ESoap::WSDL;
use strict;

use Bio::Root::Root;
use XML::Twig;
use Bio::WebAgent;
use File::Temp;

use base qw(Bio::Root::Root Exporter);

our @EXPORT = qw( $NCBI_BASEURL $NCBI_ADAPTOR %WSDL );

our $NCBI_BASEURL = "http://www.ncbi.nlm.nih.gov/entrez/eutils/soap/v2.0/";
our $NCBI_ADAPTOR = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/soap/v2.0/soap_adapter_2_0.cgi";

our %WSDL = (
    'eutils' => 'eutils.wsdl',
    'f_pubmed' => 'efetch_pubmed.wsdl',
    'f_pmc' => 'efetch_pmc.wsdl',
    'f_nlmc' => 'efetch_nlmc.wsdl',
    'f_journals' => 'efetch_journals.wsdl',
    'f_omim' => 'efetch_omim.wsdl',
    'f_taxon' => 'efetch_taxon.wsdl',
    'f_snp' => 'efetch_snp.wsdl',
    'f_gene' => 'efetch_gene.wsdl',
    'f_seq' => 'efetch_seq.wsdl'
    );

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::DB::ESoap::WSDL();
 Function: Builds a new Bio::DB::ESoap::WSDL object
 Returns : an instance of Bio::DB::ESoap::WSDL
 Args    : named args:
           -URL => $url_of_desired_wsdl -OR-
           -WSDL => $filename_of_local_wsdl_copy
           ( -WSDL will take precedence if both specified )

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($url, $wsdl) = $self->_rearrange( [qw( URL WSDL )], @args );
    my (%sections, %cache);
    my $doc = 'wsdl:definitions';
    $sections{'_message_elts'} = [];
    $sections{'_operation_elts'} = [];
    $self->_sections(\%sections);
    $self->_cache(\%cache);
    $self->_twig(
	XML::Twig->new(
	    twig_handlers => {
		$doc => sub { $self->root($_) },
		"$doc/binding" => sub { $self->_sections->{'_binding_elt'} = $_ },
		"$doc/binding/operation" => sub { push @{$self->_sections->{'_operation_elts'}},$_ },
		"$doc/message" => sub { push @{$self->_sections->{'_message_elts'}}, $_ },
		"$doc/portType" => sub { $self->_sections->{'_portType_elt'} = $_ },
		"$doc/service" => sub { $self->_sections->{'_service_elt'} = $_ },
		"$doc/types" => sub { $self->_sections->{'_types_elt'} = $_ },
	    }
	)
	);
    if ($url || $wsdl ) {
	$self->url($url);
	$self->wsdl($wsdl);
	$self->_parse;
    }
    return $self;
}

=head1 Getters

=head2 request_parameters()

 Title   : request_parameters
 Usage   : @params = $wsdl->request_parameters($operation_name)
 Function: get array of request (input) fields required by 
           specified operation, according to the WSDL
 Returns : hash of arrays of hashes...
 Args    : scalar string (operation or action name)

=cut

sub request_parameters {
    my $self = shift;
    my ($operation) = @_;
    my $is_action;
    $self->throw("Operation name must be specified") unless defined $operation;
    my $opn_hash = $self->operations;
    unless ( grep /^$operation$/, keys %$opn_hash ) {
	$is_action = grep /^$operation$/, values %$opn_hash;
	$self->throw("Operation name '$operation' is not recognized")
	    unless ($is_action);
    }
    
    #check the cache here....
    return $self->_cache("request_params_$operation") if
	$self->_cache("request_params_$operation");

    # find the input message type in the portType elt
    if ($is_action) { 
	my @a = grep {$$opn_hash{$_} eq $operation} keys %$opn_hash;
	# note this takes the first match
	$operation = $a[0];
	$self->throw("Whaaa??") unless defined $operation;
    }
    #check the cache once more after translation....
    return $self->_cache("request_params_$operation") if
	$self->_cache("request_params_$operation");

    my $bookmarks = $self->_operation_bookmarks($operation);

    my $imsg_elt = $bookmarks->{'i_msg_elt'};
    my $opn_schema = $bookmarks->{'schema'};
    my $ret = { $imsg_elt->att('name') => [] };
    
    # do a quick recursion:
    _get_types((values %$ret)[0], $imsg_elt, $opn_schema);
    return $self->_cache("request_params_$operation", $ret);

    1;
}

=head2 result_parameters()

 Title   : result_parameters
 Usage   : $result_hash = $wsdl->result_parameters
 Function: retrieve a hash structure describing the 
           result of running the specified operation
           according to the WSDL
 Returns : hash of arrays of hashes...
 Args    : operation (scalar string)

=cut

sub result_parameters {
    my $self = shift;
    my ($operation) = @_;
    my $is_action;
    $self->throw("Operation name must be specified") unless defined $operation;
    my $opn_hash = $self->operations;
    unless ( grep /^$operation$/, keys %$opn_hash ) {
	$is_action = grep /^$operation$/, values %$opn_hash;
	$self->throw("Operation name '$operation' is not recognized")
	    unless ($is_action);
    }
    
    #check the cache here....
    return $self->_cache("result_params_$operation") if
	$self->_cache("result_params_$operation");

    # find the input message type in the portType elt
    if ($is_action) { 
	my @a = grep {$$opn_hash{$_} eq $operation} keys %$opn_hash;
	# note this takes the first match
	$operation = $a[0];
	$self->throw("Whaaa??") unless defined $operation;
    }
    #check the cache once more after translation....
    return $self->_cache("result_params_$operation") if
	$self->_cache("result_params_$operation");

    # do work
    my $bookmarks = $self->_operation_bookmarks($operation);

    # eutilities results seem to be a mixture of xs:string element
    # and complex types which are just xs:seqs of xs:string elements
    # 
    # cast these as a hash of hashes...

    my $omsg_elt = $bookmarks->{'o_msg_elt'};
    my $opn_schema = $bookmarks->{'schema'};
    my $ret = { $omsg_elt->att('name') => [] };
    
    # do a quick recursion:
    _get_types((values %$ret)[0], $omsg_elt, $opn_schema);
    return $self->_cache("result_params_$operation", $ret);
}

sub response_parameters { shift->result_parameters( @_ ) }

=head2 operations()

 Title   : operations
 Usage   : @opns = $wsdl->operations;
 Function: get a hashref with elts ( $operation_name => $soapAction )
           for all operations defined by this WSDL 
 Returns : array of scalar strings
 Args    : none

=cut

sub operations {
    my $self = shift;
    return $self->_cache('operations') if $self->_cache('operations');
    my %opns;
    foreach (@{$self->_parse->_operation_elts}) {
	$opns{$_->att('name')} = 
	    ($_->descendants('soap:operation'))[0]->att('soapAction');
    }
    return $self->_cache('operations', \%opns);
}

=head2 service()

 Title   : service
 Usage   : $wsdl->service
 Function: gets the SOAP service url associated with this WSDL
 Returns : scalar string
 Args    : none

=cut

sub service {
    my $self = shift;
    return $self->_cache('service') || 
	$self->_cache('service', ($self->_parse->_service_elt->descendants('soap:address'))[0]->att('location'));
}

=head2 db()

 Title   : db
 Usage   : 
 Function: If this is an efetch WSDL, returns the db name
           associated with it
 Returns : scalar string or undef
 Args    : none

=cut

sub db {
    my $self = shift;
    $self->root->namespace('nsef') =~ /efetch_(.*?)$/;
    return $1;
}

=head1 Internals

=head2 _operation_bookmarks()

 Title   : _operation_bookmarks
 Usage   : 
 Function: find useful WSDL elements associated with the specified
           operation; return a hashref of the form
           { $key => $XML_Twig_Elt_obj, }
 Returns : hashref with keys:
            portType namespace schema
            i_msg_type i_msg_elt
            o_msg_type o_msg_elt
 Args    : operation name (scalar string)
 Note    : will import schema if necessary

=cut

sub _operation_bookmarks {
    my $self = shift;
    my $operation = shift;
    # check cache   
    return $self->_cache("bookmarks_$operation") if 
	$self->_cache("bookmarks_$operation");
    # do work
    my %bookmarks;
    my $pT_opn = $self->_portType_elt->first_child( 
	qq/ operation[\@name="$operation"] /
	);
    my $imsg_type = $pT_opn->first_child('input')->att('message');
    my $omsg_type = $pT_opn->first_child('output')->att('message');

    # now lookup the schema element name from among the message elts
    my ($imsg_elt, $omsg_elt);
    foreach ( @{$self->_message_elts} ) {
	my $msg_name = $_->att('name');
	if ( $imsg_type =~ qr/$msg_name/ ) {
	    $imsg_elt = $_->first_child('part[@element=~/[Rr]equest/]')->att('element');
	}
	if ( $omsg_type =~ qr/$msg_name/) {
	    $omsg_elt = $_->first_child('part[@element=~/[Rr]esult/]')->att('element');
	}
	last if ($imsg_elt && $omsg_elt);
    }
    $self->throw("Can't find request schema element corresponding to '$operation'") unless $imsg_elt;
    $self->throw("Can't find result schema element corresponding to '$operation'") unless $omsg_elt;

    # $imsg_elt has a namespace prefix, to lead us to the correct schema
    # as defined in the wsdl <types> element. Get that schema
    $imsg_elt =~ /(.*?):/;
    my $opn_ns = $self->root->namespace($1);
    my $opn_schema = $self->_types_elt->first_child("xs:schema[\@targetNamespace='$opn_ns']");
    $opn_schema ||= $self->_types_elt->first_child("xs:schema"); # only one
    $self->throw("Can't find types schema corresponding to '$operation'") unless defined $opn_schema;

    # need to import the schema? do it here.
    if ( my $import_elt = $opn_schema->first_child("xs:import") ) {
	my $import_url = $NCBI_BASEURL.$import_elt->att('schemaLocation');
	my $imported = XML::Twig->new();
	# better error checking here?
	eval {
	    $imported->parse(Bio::WebAgent->new()->get($import_url)->content);
	};
	$self->throw("Schema import failed (tried url '$import_url') : $@") if $@;
	my $imported_schema = $imported->root;
	# get included schemata
	my @included = $imported_schema->children("xs:include");
	foreach (@included) {

	    my $url = $NCBI_BASEURL.$_->att('schemaLocation');
	    my $incl = XML::Twig->new();
	    eval {
		$incl->parse( Bio::WebAgent->new()->get($url)->content );
	    };
	    $self->throw("Schema include failed (tried url '$url') : $@") if $@;
	    # cut-n-paste
	    my @incl = $incl->root->children;
	    $_->cut;
	    foreach my $child (@incl) {
		$child->cut;
		$child->paste( last_child => $_->former_parent );
	    }
	}
	
	# cut-n-paste
	$opn_schema->cut;
	$imported_schema->cut;
	$imported_schema->paste( first_child => $opn_schema->former_parent );
	$opn_schema = $imported_schema;
    }
	

    # find the definition of $imsg_elt in $opn_schema
    $imsg_elt =~ s/.*?://;
    $imsg_elt = $opn_schema->first_child("xs:element[\@name='$imsg_elt']");
    $self->throw("Can't find request element definition in schema corresponding to '$operation'") unless defined $imsg_elt;
    $omsg_elt =~ s/.*?://;
    $omsg_elt = $opn_schema->first_child("xs:element[\@name='$omsg_elt']");
    $self->throw("Can't find result element definition in schema corresponding to '$operation'") unless defined $omsg_elt;

    @bookmarks{qw(portType i_msg_type o_msg_type 
                  namespace schema i_msg_elt o_msg_elt ) } = 
	($pT_opn, $imsg_type, $omsg_type, $opn_ns, $opn_schema,
	 $imsg_elt, $omsg_elt);
    return $self->_cache("bookmarks_$operation", \%bookmarks);
    
}

=head2 _parse()

 Title   : _parse
 Usage   : $wsdl->_parse
 Function: parse the wsdl at url and create accessors for 
           section twig elts
 Returns : self
 Args    : 

=cut

sub _parse {
    my $self = shift;
    my @args = @_;
    return $self if $self->_parsed; # already done
    $self->throw("Neither URL nor WSDL set in object") unless $self->url || $self->wsdl;
    eval {
	if ($self->wsdl) {
	    $self->_twig->parsefile($self->wsdl);
	}
	else {
	    eval {
		my $tfh = File::Temp->new(-UNLINK=>1);
		Bio::WebAgent->new()->get($self->url, ':content_file' => $tfh->filename);
		$tfh->close;
		$self->_twig->parsefile($tfh->filename);
		$self->wsdl($tfh->filename);
	    };
	    $self->throw("URL parse failed : $@") if $@;
	}
    };
#    $self->throw("Parser issue : $@") if $@;
    die $@ if $@;
    $self->_set_from_args( $self->_sections, 
			  -methods => [qw(_types_elt _message_elts 
                                          _portType_elt _binding_elt
                                          _operation_elts _service_elt)],
			  -create => 1 );
    $self->_parsed(1);
    return $self;
}

=head2 root()

 Title   : root
 Usage   : $obj->root($newval)
 Function: holds the root Twig elt of the parsed WSDL
 Example : 
 Returns : value of root (an XML::Twig::Elt)
 Args    : on set, new value (an XML::Twig::Elt or undef, optional)

=cut

sub root {
    my $self = shift;
    
    return $self->{'root'} = shift if @_;
    return $self->{'root'};
}

=head2 url()

 Title   : url
 Usage   : $obj->url($newval)
 Function: get/set the WSDL url
 Example : 
 Returns : value of url (a scalar string)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub url {
    my $self = shift;
    
    return $self->{'url'} = shift if @_;
    return $self->{'url'};
}

=head2 wsdl()

 Title   : wsdl
 Usage   : $obj->wsdl($newval)
 Function: get/set wsdl XML filename
 Example : 
 Returns : value of wsdl (a scalar string)
 Args    : on set, new value (a scalar string or undef, optional)

=cut

sub wsdl {
    my $self = shift;
    my $file = shift;
    if (defined $file) {
	$self->throw("File not found") unless (-e $file) || (ref $file eq 'File::Temp');
	return $self->{'wsdl'} = $file;
    }
    return $self->{'wsdl'};
}

=head2 _twig()

 Title   : _twig
 Usage   : $obj->_twig($newval)
 Function: XML::Twig object for handling the wsdl
 Example : 
 Returns : value of _twig (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub _twig {
    my $self = shift;
    
    return $self->{'_twig'} = shift if @_;
    return $self->{'_twig'};
}

=head2 _sections()

 Title   : _sections
 Usage   : $obj->_sections($newval)
 Function: holds hashref of twigs corresponding to main wsdl 
           elements; filled by _parse()
 Example : 
 Returns : value of _sections (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub _sections {
    my $self = shift;
    
    return $self->{'_sections'} = shift if @_;
    return $self->{'_sections'};
}

=head2 _cache()

 Title   : _cache
 Usage   : $wsdl->_cache($newval)
 Function: holds the wsdl info cache
 Example : 
 Returns : value of _cache (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub _cache {
    my $self = shift;
    my ($name, $value) = @_;
    unless (@_) {
	return $self->{'_cache'} = {};
    }
    if (defined $value) {
	return $self->{'_cache'}->{$name} = $value;
    }
    return $self->{'_cache'}->{$name};
}

sub clear_cache { shift->_cache() }

=head2 _parsed()

 Title   : _parsed
 Usage   : $obj->_parsed($newval)
 Function: flag to indicate wsdl already parsed
 Example : 
 Returns : value of _parsed (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub _parsed {
    my $self = shift;
    
    return $self->{'_parsed'} = shift if @_;
    return $self->{'_parsed'};
}

# =head2 _get_types()

#  Title   : _get_types
#  Usage   : very internal
#  Function: recursively parse through custom types
#  Returns : 
#  Args    : arrayref, XML::Twig::Elt, XML::Twig::Elt
#            (return array, type element, schema root)

# =cut

sub _get_types {
    my ($res, $elt, $sch, $visited) = @_;
    my $is_choice;
    $visited ||= [];
    # assuming max 1 xs:sequence or xs:choice per element
    my $seq = ($elt->descendants('xs:sequence'))[0];
    $is_choice = ($seq ? '' : '|');
    $seq ||= ($elt->descendants('xs:choice'))[0];
    return 1 unless $seq;
    foreach ( $seq->descendants('xs:element') ) {
	for my $type ($_->att('type') || $_->att('ref')) {
	    !defined($type) && do {
		Bio::Root::Root->throw("neither type nor ref attributes defined; cannot proceed");
		last;
	    };
	    $type eq 'xs:string' && do {
		push @$res, { $_->att('name').$is_choice => 1};
		last;
	    };
	    do { # custom type
		# find the type def in schema
		$type =~ s/.*?://; # strip tns
		if (grep /^$type$/, @$visited) { # check for circularity
		    
		    push @$res, { $_->att('name').$is_choice => "$type(reused)"}if $_->att('name');
		    last;
		}
		push @$visited, $type;
		my $new_elt = $sch->first_child("xs:complexType[\@name='$type']");
		if (defined $new_elt) {
		    my $new_res = [];
		    push @$res, { $_->att('name').$is_choice => $new_res };
		    _get_types($new_res, $new_elt, $sch, $visited);
		}
		else { # a 'ref', make sure it's defined
		    $new_elt = $sch->first_child("xs:element[\@name='$type']");
		    $DB::single=1 unless $new_elt;
		    Bio::Root::Root->throw("type not defined in schema; cannot proceed") unless defined $new_elt;
		    push @$res, { $new_elt->att('name').$is_choice => 1 };
		}
		last;
	    }
	}
    }
    return 1;
}
	
sub DESTROY {
    my $self = shift;
    if (ref($self->wsdl) eq 'File::Temp') {
	unlink $self->wsdl->filename;
    }
}
1;
