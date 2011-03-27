# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities
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

Bio::DB::SoapEUtilities - Interface to the NCBI Entrez web service *BETA*

=head1 SYNOPSIS

 use Bio::DB::SoapEUtilities;

 # factory construction

 my $fac = Bio::DB::SoapEUtilities->new()

 # executing a utility call

 #get an iteratable adaptor
 my $links = $fac->elink( 
               -dbfrom => 'protein',
               -db => 'taxonomy',
               -id => \@protein_ids )->run(-auto_adapt => 1);

 # get a Bio::DB::SoapEUtilities::Result object
 my $result = $fac->esearch(
               -db => 'gene',
               -term => 'sonic and human')->run;

 # get the raw XML message
 my $xml = $fac->efetch(
             -db => 'gene',
             -id => \@gids )->run( -raw_xml => 1 );

 # change parameters 
 my $new_result = $fac->efetch(
                   -db => 'gene',
                   -id => \@more_gids)->run;
 # reset parameters
 $fac->efetch->reset_parameters( -db => 'nucleotide',
                                 -id => $nucid );
 $result = $fac->efetch->run;
                
 # parsing and iterating the results

 $count = $result->count;
 @ids = $result->ids;
 
 while ( my $linkset = $links->next_link ) {
    $submitted = $linkset->submitted_id;
 }
 
 ($taxid) = $links->id_map($submitted_prot_id);
 $species_io = $fac->efetch( -db => 'taxonomy',
                             -id => $taxid )->run( -auto_adapt => 1);
 $species = $species_io->next_species;
 $linnaeus = $species->binomial;

=head1 DESCRIPTION

This module allows the user to query the NCBI Entrez database via its
SOAP (Simple Object Access Protocol) web service (described at
L<http://eutils.ncbi.nlm.nih.gov/entrez/eutils/soap/v2.0/DOC/esoap_help.html>).
The basic tools (C<einfo, esearch, elink, efetch, espell, epost>) are
available as methods off a C<SoapEUtilities> factory
object. Parameters for each tool can be queried, set and reset for
each method through the L<Bio::ParameterBaseI> standard calls
(C<available_parameters(), set_parameters(), get_parameters(),
reset_parameters()>). Returned data can be retrieved, accessed and
parsed in several ways, according to user preference. Adaptors and
object iterators are available for C<efetch>, C<egquery>, C<elink>,
and C<esummary> results.

=head1 USAGE

The C<SoapEU> system has been designed to be as easy (few includes,
available parameter facilities, reasonable defaults, intuitive
aliases, built-in pipelines) or as complex (accessors for underlying
low-level objects, all parameters accessible, custom hooks for builder
objects, facilities for providing local copies of WSDLs) as the user
requires or desires. (To the extent that it does not succeed in either
direction, it is up to the user to report to the mailing list
(L</FEEDBACK>)!)

=head2 Factory

To begin, make a factory:

 my $fac = Bio::DB::SoapEUtilities->new();

From the factory, utilities are called, parameters are set, and
results or adaptors are retrieved.

If you have your own copy of the wsdl, use

 my $fac = Bio::Db::SoapEUtilities->new( -wsdl_file => $my_wsdl );

otherwise, the correct one will be obtained over the network (by
L<Bio::DB::ESoap> and friends).

=head2 Utilities and parameters

To run any of the standard NCBI EUtilities (C<einfo, esearch, esummary, 
elink, egquery, epost, espell>), call the desired utility from the factory.
To use a utility, you must set its parameters and run it to get a result. 
TMTOWTDI:

 # verbose
 my $fetch = $fac->efetch();
 $fetch->set_parameters( -db => 'gene', -id => [828392, 790]);
 my $result = $fetch->run;

 # compact
 my $result = $fac->efetch(-db =>'gene',-id => [828392,790])->run;

 # change ids
 $fac->efetch->set_parameters( -id => 470338 );
 $result = $fac->run;

 # another util
 $result = $fac->esearch(-db => 'protein', -term => 'BRCA and human')->run;
 
 # the utilities are kept separate
 %search_params = $fac->esearch->get_parameters;
 %fetch_params = $fac->efetch->get_parameters;
 $search_param{db}; # is 'protein'
 $fetch_params{db}; # is 'gene'
 
The factory is L<Bio::ParameterBaseI> compliant: that means you can
find out what you can set with
 
 @available_search = $fac->esearch->available_parameters;
 @available_egquery = $fac->egquery->available_parameters;

For more information on parameters, see
L<http://www.ncbi.nlm.nih.gov/entrez/query/static/eutils_help.html>.

=head2 Results

The "intermediate" object for C<SoapEU> query results is the
L<Bio::DB::SoapEUtilities::Result>. This is a BioPerly parsing of the
SOAP message sent by NCBI when a query is C<run()>. This can be very
useful on it's own, but most users will likely want to proceed
directly to L</Adaptors>, which take a C<Result> and turn it into more
intuitive/familiar BioPerl objects. Go there if the following details
are too gory.

Results can be highly- or lowly-parsed, depending on the parameters
passed to the factory C<run()> method. To get the raw XML message with
no parsing, do

 my $xml = $fac->$util->run(-raw_xml => 1); # $xml is a scalar string

To retrieve a L<Bio::DB::SoapEUtilities::Result> object with limited
parsing, but with accessors to the L<SOAP::SOM> message (provided by
L<SOAP::Lite>), do

 my $result = $fac->$util->run(-no_parse => 1);
 my $som = $result->som;
 my $method_hash = $som->method; # etc...

To retrieve a C<Result> object with message elements parsed into
accessors, including C<count()> and C<ids()>, run without arguments:

 my $result = $fac->esearch->run()
 my $count = $result->count;
 my @Count = $result->Count; # counts for each member of 
                             # the translation stack
 my @ids = $result->IdList_Id; # from automatic message parsing
 @ids = $result->ids; # a convenient alias

See L<Bio::DB::SoapEUtilities::Result> for more, even gorier details.

=head2 Adaptors

Adaptors convert EUtility C<Result>s into convenient objects, via a
handle that usually provides an iterator, in the spirit of
L<Bio::SeqIO>. These are probably more useful than the C<Result> to
the typical user, and so you can retrieve them automatically by
setting the C<run()> parameter C<-auto_adapt => 1>. 

In general, retrieve an adaptor like so:

 $adp = $fac->$util->run( -auto_adapt => 1 );
 # iterate...
 while ( my $obj = $adp->next_obj ) {
    # do stuff with $obj
 }

The adaptor itself occasionally possesses useful methods besides the
iterator. The method C<next_obj> always works, but a natural alias is
also always available:

 $seqio = $fac->esearch->run( -auto_adapt => 1 );
 while ( my $seq = $seqio->next_seq ) {
    # do stuff with $seq
 }

In the above example, C<-auto_adapt => 1> also instructs the factory
to perform an C<efetch> based on the ids returned by the C<esearch>
(if any), so that the adaptor returned iterates over L<Bio::SeqI>
objects.

Here is a rundown of the different adaptor flavors:

=over

=item * C<efetch>, Fetch Adaptors, and BioPerl object iterators

The C<FetchAdaptor> creates bona fide BioPerl objects. Currently,
there are FetchAdaptor subclasses for sequence data (both Genbank and
FASTA rettypes) and taxonomy data. The choice of FetchAdaptor is based
on information in the result message, and should be transparent to the
user.

 $seqio = $fac->efetch( -db =>'nucleotide',
                        -id => \@ids,
                        -rettype => 'gb' )->run( -auto_adapt => 1 );
 while (my $seq = $seqio->next_seq) {
    my $taxio = $fac->efetch( 
	-db => 'taxonomy', 
	-id => $seq->species->ncbi_taxid )->run(-auto_adapt => 1);
    my $tax = $taxio->next_species;
    unless ( $tax->TaxId == $seq->species->ncbi_taxid ) {
      print "more work for MAJ"
    }
 }

See the pod for the FetchAdaptor subclasses (e.g.,
L<Bio::DB::SoapEUtilities::FetchAdaptor::seq>) for more detail.

=item * C<elink>, the Link adaptor, and the C<linkset> iterator

The C<LinkAdaptor> manages LinkSets. In C<SoapEU>, an C<elink> call
B<always> preserves the correspondence between submitted and retrieved
ids. The mapping between these can be accessed from the adaptor object
directly as C<id_map()>

 my $links = $fac->elink( -db => 'protein', 
                          -dbfrom => 'nucleotide',
                          -id => \@nucids )->run( -auto_adapt => 1 );

 # maybe more than one associated id...
 my @prot_0 = $links->id_map( $nucids[0] ); 
 
Or iterate over the linksets:
 
 while ( my $ls = $links->next_linkset ) {
    @ids = $ls->ids;
    @submitted_ids = $ls->submitted_ids;
    # etc.
 }

=item * C<esummary>, the DocSum adaptor, and the C<docsum> iterator

The C<DocSumAdaptor> manages docsums, the C<esummary> return type.
The objects returned by iterating with a C<DocSumAdaptor> have
accessors that let you obtain field information directly. Docsums
contain lots of easy-to-forget fields; use C<item_names()> to remind yourself.

 my $docs = $fac->esummary( -db => 'taxonomy',
                            -id => 527031 )->run(-auto_adapt=>1);
 # iterate over docsums
 while (my $d = $docs->next_docsum) {
    @available_items = $docsum->item_names;
    # any available item can be called as an accessor
    # from the docsum object...watch your case...
    $sci_name = $d->ScientificName;
    $taxid = $d->TaxId;
 }

=item * C<egquery>, the GQuery adaptor, and the C<query> iterator

The C<GQueryAdaptor> manages global query items returned by calls to
C<egquery>, which identifies all NCBI databases containing hits for
your query term. The databases actually containing hits can be
retrieved directly from the adaptor with C<found_in_dbs>:

 my $queries = $fac->egquery( 
     -term => 'BRCA and human'
    )->run(-auto_adapt=>1);
 my @dbs = $queries->found_in_dbs;

Retrieve the global query info returned for B<any> database with C<query_by_db>:
 
 my $prot_q = $queries->query_by_db('protein');
 if ($prot_q->count) {
    #do something
 }

Or iterate as usual:

 while ( my $q = $queries->next_query ) {
    if ($q->status eq 'Ok') {
      # do sth
    }
 }

=back

=head2 Web environments and query keys

To make large or complex requests for data, or to share queries, it
may be helpful to use the NCBI WebEnv system to manage your
queries. Each EUtility accepts the following parameters:

 -usehistory
 -WebEnv
 -QueryKey

for this purpose. These store the details of your queries serverside.

C<SoapEU> attempts to make using these relatively straightforward. Use
C<Result> objects to obtain the correct parameters, and don't forget
C<-usehistory>:

 my $result1 = $fac->esearch( 
     -term => 'BRCA and human', 
     -db => 'nucleotide',
     -usehistory => 1 )->run( -no_parse=>1 );

 my $result = $fac->esearch( 
     -term => 'AND early onset', 
     -QueryKey => $result1->query_key,
     -WebEnv => $result1->webenv )->run( -no_parse => 1 );

 my $result = $fac->esearch(
    -db => 'protein',
    -term => 'sonic', 
    -usehistory => 1 )->run( -no_parse => 1 );

 # later (but not more than 8 hours later) that day...

 $result = $fac->esearch(
    -WebEnv => $result->webenv,
    -QueryKey => $result->query_key,
    -RetMax => 800 # get 'em all
    )->run; # note we're parsing the result...
 @all_ids = $result->ids;

=head2 Error checking

Two kinds of errors can ensue on an Entrez SOAP run. One is a SOAP
fault, and the other is an error sent in non-faulted SOAP message from
the server. The distinction is probably systematic, and I would
welcome an explanation of it. To check for result errors, try something like:

 unless ( $result = $fac->$util->run ) {
    die $fac->errstr; # this will catch a SOAP fault
 }
 # a valid result object was returned, but it may carry an error
 if ($result->count == 0) {
    warn "No hits returned";
    if ($result->ERROR) {
      warn "Entrez error : ".$result->ERROR;
    }
 }

Error handling will be improved in the package eventually.

=head1 SEE ALSO

L<Bio::DB::EUtilities>, L<Bio::DB::SoapEUtilities::Result>,
L<Bio::DB::ESoap>.

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

package Bio::DB::SoapEUtilities;
use strict;

use Bio::Root::Root;
use Bio::DB::ESoap;
use Bio::DB::SoapEUtilities::DocSumAdaptor;
use Bio::DB::SoapEUtilities::FetchAdaptor;
use Bio::DB::SoapEUtilities::GQueryAdaptor;
use Bio::DB::SoapEUtilities::LinkAdaptor;
use Bio::DB::SoapEUtilities::Result;

use base qw(Bio::Root::Root Bio::ParameterBaseI );

our $AUTOLOAD;

=head2 new

 Title   : new
 Usage   : my $eutil = new Bio::DB::SoapEUtilities();
 Function: Builds a new Bio::DB::SoapEUtilities object
 Returns : an instance of Bio::DB::SoapEUtilities
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($db, $wsdl) = $self->_rearrange( [qw( DB WSDL_FILE )], @args );
    $self->{db} = $db;
    $self->{'_wsdl_file'} = $wsdl;

    return $self;
}

=head2 run()

 Title   : run
 Usage   : $fac->$eutility->run(@args)
 Function: Execute the EUtility
 Returns : true on success, false on fault or error
           (reason in errstr(), for more detail check the SOAP message
            in last_result() )
 Args    : named params appropriate to utility
           -auto_adapt => boolean ( return an iterator over results as 
                                    appropriate to util if true)
           -raw_xml => boolean ( return raw xml result; no processing )
           Bio::DB::SoapEUtilities::Result constructor parms

=cut

sub run {
    my $self = shift;
    my @args = @_;
    $self->throw("run method requires named arguments") if @args % 2;
    $self->throw("call run method like '\$fac->\$eutility->run(\@args)") unless
	$self->_caller_util;
    my ($autofetch, $raw_xml) = $self->_rearrange( [qw( AUTO_ADAPT RAW_XML)],
						   @args );
    my ($adaptor);
    my %args = @args;
    # add tool argument for NCBI records
    $args{tool} = "BioPerl";
    my %params = $self->get_parameters;
    $self->warn("No -email parameter set : be advised that NCBI requires a valid email to accompany all requests") unless $params{email};
    my $util = $self->_caller_util;
    # pass util args to run only to a downstream utility (i.e., efetch
    # on autofetch..
    # $self->set_parameters(%args) if %args;
    # kludge for elink : make sure to-ids and from-ids are associated
    if ( $util eq 'elink' ) {
	my $es = $self->_soap_facs($util);
	my $ids = $es->id;
	if (ref $ids eq 'ARRAY') {
	    my %ids;
	    @ids{@$ids} = (1) x scalar @$ids;
	    $es->id(\%ids);
	}
    }
    $self->_soap_facs($util)->_client->outputxml($raw_xml);
    my $som = $self->{'_response_message'} = $self->_soap_facs($util)->run;
    # raw xml only...
    if ($raw_xml) {
	return $som; 
    }
    # SOAP::SOM parsing...
    # check response status
    if ($som->fault) {
	$self->{'errstr'} = $som->faultstring;
	return 0;
    }
    # elsif non-fault error
    if (my $err = $som->valueof("//ErrorList")) {
	while ( my ($key, $val) = each %$err ) {
	    $self->{'errstr'} .= join( " : ", $key, $val )."\n";
	};
	$self->{'errstr'} =~ s/\n$//;
	return 0;
    }
    # attach some key properties to the factory
    $self->{'_WebEnv'} = $som->valueof("//WebEnv");
    # create convenient aliases off result for different utils
    my @alias_hash;
    for ($util) {
	/einfo/ && do {
	    my %args = $self->get_parameters;
	    if ($args{db}) {
		push @alias_hash, (
		    '-alias_hash' => {
			'record_count' => 'DbInfo_Count',
			'last_update' => 'DbInfo_LastUpdate',
			'db' => 'DbInfo_DbName',
			'description' => 'DbInfo_Description'
		    } );
	    }
	    else {
		push @alias_hash, ('-alias_hash' => {'dbs' => 'DbList_DbName'} );
	    }
	    last;
	};
	# put others here as nec
    }
    my $result = Bio::DB::SoapEUtilities::Result->new($self, @args,
	@alias_hash);

    # success, parse it out
    if ($autofetch) {
	for ($self->_caller_util) {
	    $_ eq 'esearch' && do {
		# do an efetch with the same db and a returned list of ids...
		# reentering here!
		my $ids = $result->ids;
		if (!$result->count) {
		    $self->warn("Can't fetch; no records returned");
		    return $result;
		}
		if (!$result->ids) {
		    $self->warn("Can't fetch; no id list returned");
		    return $result;
		}
		if ( !$self->db ) {
		    my %h = $self->get_parameters;
		    $self->{db} = $h{db} || $h{DB};
		}
		# pass run() args to the downstream utility here
		# (so can specify -rettype, basically)
		# note @args will contain -auto_adapt => 1 here.

		# keep the email arg
		my %parms = $self->get_parameters;
	        $adaptor = $self->efetch( -db => $self->db,
					  -id => $ids,
					  -email => $parms{email},
					  -tool => $parms{tool},
					     @args )->run(-no_parse => 1, @args);
		last;
	    };
	    $_ eq 'elink' && do {
		$adaptor = Bio::DB::SoapEUtilities::LinkAdaptor->new(
		    -result => $result
		    );
		last;
	    };
	    $_ eq 'esummary' && do {
		$adaptor = Bio::DB::SoapEUtilities::DocSumAdaptor->new(
		    -result => $result
		    );
		last;
	    };
	    $_ eq 'egquery' && do {
		$adaptor = Bio::DB::SoapEUtilities::GQueryAdaptor->new(
		    -result => $result
		    );
		last;
	    };
	    $_ eq 'efetch' && do {
		$adaptor = Bio::DB::SoapEUtilities::FetchAdaptor->new(
		    -result => $result
		    );
		last;
	    };
	    # else, ignore
	}
	return ($adaptor || $result);
    }
    else {
	return $result;
	1;
    }
}

=head2 Useful Accessors

=head2 response_message()

 Title   : response_message
 Aliases : last_response, last_result
 Usage   : $som = $fac->response_message
 Function: get the last response message
 Returns : a SOAP::SOM object
 Args    : none

=cut

sub response_message { shift->{'_response_message'} }
sub last_response { shift->{'_response_message'} }
sub last_result { shift->{'_response_message'} }

=head2 webenv()

 Title   : webenv
 Usage   : 
 Function: contains WebEnv key referencing the session
           (set after run() )
 Returns : scalar
 Args    : none

=cut

sub webenv { shift->{'_WebEnv'} }

=head2 errstr()

 Title   : errstr
 Usage   : $fac->errstr
 Function: get the last error, if any
 Example : 
 Returns : value of errstr (a scalar)
 Args    : none

=cut

sub errstr { shift->{'errstr'} }

sub _wsdl_file { shift->{'_wsdl_file'} }

=head2 Bio::ParameterBaseI compliance

=head2 available_parameters()

 Title   : available_parameters
 Usage   : 
 Function: get available request parameters for calling
           utility
 Returns : 
 Args    : -util => $desired_utility [optional, default is
           caller utility]

=cut

sub available_parameters {
    my $self = shift;
    my @args = @_;
    my %args = @args;
    my $util = $args{'-util'} || $args{'-UTIL'} || $self->_caller_util;
    return unless $self->_soap_facs($util);
    delete $args{'-util'};
    delete $args{'-UTIL'};
    $self->_soap_facs($util)->available_parameters(%args);
}

=head2 set_parameters()

 Title   : set_parameters
 Usage   : 
 Function: 
 Returns : none
 Args    : -util => $desired_utility [optional, default is 
            caller utility],
           named utility arguments

=cut

sub set_parameters {
    my $self = shift;
    my @args = @_;
    my %args = @args;
    my $util = $args{'-util'} || $args{'-UTIL'} || $self->_caller_util;
    return unless $self->_soap_facs($util);
    delete $args{'-util'};
    delete $args{'-UTIL'};
    $self->_soap_facs($util)->set_parameters(%args);
}

=head2 get_parameters()

 Title   : get_parameters
 Usage   : 
 Function: 
 Returns : array of named parameters
 Args    : utility (scalar string) [optional]
           (default is caller utility)

=cut

sub get_parameters {
    my $self = shift;
    my @args = @_;
    my %args = @args;
    my $util = $args{'-util'} || $args{'-UTIL'} || $self->_caller_util;
    return unless $self->_soap_facs($util);
    return $self->_soap_facs($util)->get_parameters;
}

=head2 reset_parameters()

 Title   : reset_parameters
 Usage   : 
 Function: 
 Returns : none
 Args    : -util => $desired_utility [optional, default is 
            caller utility],
           named utility arguments

=cut

sub reset_parameters {
    my $self = shift;
    my @args = @_;
    my %args = @args;
    my $util = $args{'-util'} || $args{'-UTIL'} || $self->_caller_util;
    return unless $self->_soap_facs($util);
    delete $args{'-util'};
    delete $args{'-UTIL'};
    $self->_soap_facs($util)->reset_parameters(%args);
}

=head2 parameters_changed()

 Title   : parameters_changed
 Usage   : 
 Function: 
 Returns : boolean
 Args    : utility (scalar string) [optional]
           (default is caller utility)

=cut

sub parameters_changed {
    my $self = shift;
    my @args = @_;
    my %args = @args;
    my $util = $args{'-util'} || $args{'-UTIL'} || $self->_caller_util;
    return unless $self->_soap_facs($util);
    return $self->_soap_facs($util)->parameters_changed;
}

# idea behind using autoload: attempt to buffer the module
# against additions of new eutilities, and (of course) to 
# reduce work (laziness, not Laziness)

sub AUTOLOAD {
    my $self = shift;
    my $util = $AUTOLOAD;
    my @args = @_;
    $util =~ s/.*:://;

    if ( $util =~ /^e/ ) { # this will bite me someday
	# create an ESoap factory for this utility
	my $fac = $self->_soap_facs($util); # check cache
	my @pms = ( -util => $util );
	if ($self->_wsdl_file) {
	    push @pms, ( -wsdl_file => $self->_wsdl_file );
	}
	eval {
	    $fac ||= Bio::DB::ESoap->new( @pms );
	};
	for ($@) {
	    /^$/ && do {
		$self->_soap_facs($util,$fac); # put in cache
		last;
	    };
	    /Utility .* not recognized/ && do {
		my $err = (ref $@ ? $@->text : $@);
		$self->throw($err);
	    };
	    do { #else 
		my $err = (ref $@ ? $@->text : $@);
		die $err;
		$self->throw("Problem creating ESoap client : $err");
	    };
	}
	# arg setting 
	$self->throw("Named arguments required") if @args % 2;
	$fac->set_parameters(@args) if @args;
	$self->_caller_util($util);
	return $self; # now, can do $obj->esearch()->run, etc, with methods in 
	# this package, with an appropriate low-level factory 
	# set up in the background.
    }
    elsif ($self->_caller_util) {
	# delegate to the appropriate soap factory
	my $method = $util;
	$util = $self->_caller_util;
	my $soapfac = $self->_soap_facs($util);
	if ( $soapfac && $soapfac->can($method) ) {
	    return $soapfac->$method(@args);
	}
    }
    else {
	$self->throw("Can't locate method '$util' in module ".
		     __PACKAGE__);
    }
    1;
}

=head2 _soap_facs()

 Title   : _soap_facs
 Usage   : $self->_soap_facs($util, $fac)
 Function: caches Bio::DB::ESoap factories for the 
           eutils in use by this instance
 Example : 
 Returns : Bio::DB::ESoap object
 Args    : $eutility, [optional on set] $esoap_factory_object

=cut

sub _soap_facs {
    my $self = shift;
    my ($util, $fac) = @_;
    $self->throw("Utility must be specified") unless $util;
    $self->{'_soap_facs'} ||= {};
    if ($fac) {
	return $self->{'_soap_facs'}->{$util} = $fac;
    }
    return $self->{'_soap_facs'}->{$util};
}

=head2 _caller_util()

 Title   : _caller_util
 Usage   : $self->_caller_util($newval)
 Function: the utility requested off the main SoapEUtilities 
           object
 Example : 
 Returns : value of _caller_util (a scalar string, a valid eutility)
 Args    : on set, new value (a scalar string [optional])

=cut

sub _caller_util {
    my $self = shift;
    return $self->{'_caller_util'} = shift if @_;
    return $self->{'_caller_util'};
}
1;

