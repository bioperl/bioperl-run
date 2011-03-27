# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::Result
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

Bio::DB::SoapEUtilities::Result - Accessor object for SoapEUtilities results

=head1 SYNOPSIS

 $fac = Bio::DB::SoapEUtilities->new();
 $result = $fac->esearch( -db => 'gene', -term => 'hedgehog')->run;
 $count = $result->count; # case important; $result->Count could be arrayref
 @ids = $result->ids;

=head1 DESCRIPTION

This module attempts to make Entrez Utilities SOAP responses as
user-friendly and intuitive as possible. These responses can be
complex structures with much useful data; but users will generally
desire the values of some key fields. The L<Result> object provides
access to all response values via systematically named accessor
methods, and commonly used values as convenience methods. The 'raw'
SOAP message (a L<SOAP::SOM> object as returned by L<SOAP::Lite>) is
also provided.

=over

=item Convenience accessors

If a list of record ids is returned by the call, C<ids()> will return these as
an array reference:

 @seq_ids = $result->ids;

The total count of returned records is provided by C<count()>:

 $num_recs = $result->count;

If C<usehistory> was specified in the SOAP call, the NCBI-assigned web
environment (that can be used in future calls) is available in
C<webenv>, and the query key assigned to the result in C<query_key>:

 $next_result = $fac->efetch( -WebEnv => $result->webenv, 
                              -QueryKey => $result->query_key );

=item Walking the response

This module uses C<AUTOLOAD> to provide accessor methods for all response data.
Here is an example of a SOAP response as returned by a C<method()> call off the L<SOAP::SOM> object:

    DB<5> x $result->som->method
 0  HASH(0x2eac9a4)
    'Count' => 148
    'IdList' => HASH(0x4139578)
      'Id' => 100136227
    'QueryKey' => 1
    'QueryTranslation' => 'sonic[All Fields] AND hedgehog[All Fields]'
    'RetMax' => 20
    'RetStart' => 0
    'TranslationSet' => ''
    'TranslationStack' => HASH(0x4237b4c)
       'OP' => 'GROUP'
       'TermSet' => HASH(0x42c43bc)
          'Count' => 2157
          'Explode' => 'Y'
          'Field' => 'All Fields'
          'Term' => 'hedgehog[All Fields]'
    'WebEnv' => 'NCID_1_150423569_130.14.22.101_9001_1262703782'

Some of the data values here (at the tips of the data structure) are
actually arrays of values ( e.g., the tip C<IdList => Id> ), other
tips are simple scalars. With this in mind, C<Result> accessor methods work as
follows:

Data values (at the tips of the response structure) are acquired by calling a method with the structure keys separated by underscores (if necessary):

 $query_key = $result->QueryKey; # $query_key == 1
 $ids = $result->IdList_Id;      # @$ids is an array of record ids

Data I<sets> below a particular node in the response structure can
also be obtained with similarly constructed method names. These
'internal node accessors' return a hashref, containing all data leaves
below the node, keyed by the accessor names:

    $data_hash = $result->TranslationStack
 
    DB<3> x $data_hash
 0  HASH(0x43569d4)
    'TranslationStack_OP' => ARRAY(0x42d9988)
       0  'AND'
       1  'GROUP'
    'TranslationStack_TermSet_Count' => ARRAY(0x4369c64)
       0  148
       1  148
       2  2157
    'TranslationStack_TermSet_Explode' => ARRAY(0x4368998)
       0  'Y'
       1  'Y'
    'TranslationStack_TermSet_Field' => ARRAY(0x4368260)
       0  'All Fields'
       1  'All Fields'
    'TranslationStack_TermSet_Term' => ARRAY(0x436c97c)
       0  'sonic[All Fields]'
       1  'hedgehog[All Fields]'

Similarly, the call C< $result->TranslationStack_TermSet > would
return a similar hash containing the last 4 elements of the example
hash above.

Creating accessors is somewhat costly, especially for fetch responses
which can be deep and complex (not unlike BioPerl
developers). Portions of the response tree can be ignored by setting
C<-prune_at_node> to a arrayref of nodes to skip. Nodes should be
specified in L<SOAP::SOM> format, e.g.

 ...::Result->new( -prune_at_nodes => ['//GBSeq_references'] );

Accessor creation can be skipped altogether by passing C<-no_parse =>
1> to the C<Result> constructor. This is recommended if a result is
being passed to a
L<Bio::DB::SoapEUtilities::FetchAdaptor>. The original SOAP
message with all data is always available in C<$result->som>.

=back

=over

Other methods

=item accessors()

An array of available data accessor names. This
contains only the data "tips". The internal node accessors are
autoloaded.

=item ok()

True if no SOAP fault.

=item errstr()

Returns the SOAP fault error string.

=item som()

The original C<SOAP::SOM> message.

=item util()

The EUtility associated with the result.

=back

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

package Bio::DB::SoapEUtilities::Result;
use strict;
use warnings;

use Bio::Root::Root;

use base qw(Bio::Root::Root );

our $AUTOLOAD;
our %ID_LIST_ELT = (
    esearch => 'IdList_Id',
    esummary => 'DocSum_Id',
    elink => 'LinkSet_IdList_Id'
    );

# an object of accessors

sub new {
    my $class = shift;
    my @args = @_;
    my $self = $class->SUPER::new(@args);
    my $eutil_obj = shift @args;
    my ($alias_hash, $prune_at_nodes, $no_parse, $make_index) = $self->_rearrange( [qw( ALIAS_HASH PRUNE_AT_NODES NO_PARSE INDEX_ACCESSORS ) ], @args);
    $self->throw("Result constructor requires Bio::DB::SoapEUtilities ".
		 "argument") 
	unless ($eutil_obj and 
		ref($eutil_obj) eq 'Bio::DB::SoapEUtilities');

    $alias_hash ||= {};
    $$alias_hash{ 'ids' } = ($ID_LIST_ELT{$eutil_obj->_caller_util} || 'IdList_Id');
    if ($prune_at_nodes) {
	$prune_at_nodes = [$prune_at_nodes] unless ref $prune_at_nodes;
    }

    $self->{'_util'} = $eutil_obj->_caller_util;
    my $som = $self->{'_som'} = $eutil_obj->last_result;

    return unless ( $som and ref($som) eq 'SOAP::SOM' );
    return $self unless $self->ok; # SOAP fault

    $self->{'_result_type'} = $eutil_obj->_soap_facs($self->util)->_result_elt_name;
    $self->{'_accessors'} = [];
    $self->{'_WebEnv'} = $som->valueof("//WebEnv");
    $self->{'_QueryKey'} = $som->valueof("//QueryKey");
    $self->{'_fetch_type'} = $eutil_obj->_soap_facs($self->util)->_wsdl->db;
    $self->{'_fetch_db'} = ($self->util eq 'efetch' ? 
			    $eutil_obj->_soap_facs($self->util)->db :
			    undef);

    return ($no_parse ? $self : $self->parse_methods($alias_hash,
						     $prune_at_nodes));
}

=head2 parse_methods()

 Title   : parse_methods
 Usage   : 
 Function: parse out the accessor methods
 Returns : self (Result object)
 Args    : $alias_hash (hashref), $prune_at_nodes (scalar or arrayref)

=cut

sub parse_methods {
    my $self = shift;
    # parse message into accessors
    my ($alias_hash, $prune_at_nodes) = @_;

    my @methods = keys %{$self->som->method};
    my %methods;
    foreach my $m (@methods) {
	_traverse_methods($m, '/', '', $self->som, \%methods, $self->{'_accessors'}, $prune_at_nodes);
    }
    # convenience aliases...
    if ($alias_hash && ref($alias_hash) eq 'HASH') {
	for (keys %$alias_hash) {
	    if ($methods{ $$alias_hash{$_} }) { # avoid undef'd accessors
		$methods{$_} = $methods{ $$alias_hash{$_} };
		push @{$self->{_accessors}}, $_;
	    }
	}
    }
    # specials...
    if ($methods{Count}) {
	push @{$self->{'_accessors'}}, 'count';
	for (ref $methods{Count}) {
	    /^$/ && do {
		$methods{count} = $methods{Count};
		last;
	    };
	    /ARRAY/ && do {
		$methods{count} = $methods{Count}->[0];
		last;
	    };
	}
    }
    else { #work harder
	my @toplev = keys %{$self->som->method};
	my ($set) = grep /^.*?S(et|um)$/, @toplev;
	if ($set) {
	    $methods{count} = 0;
	    # kludge out NCBI inconsistencies
	    my $stem = ($set =~ /(?:DocSum|LinkSet)/ ? "//Body/".$self->result_type."/*" :
			"//$set/*");
	    foreach ($self->som->valueof($stem)) {
		$methods{count}++;
	    }
	}
	push @{$self->{'_accessors'}}, 'count';
    }
    $self->_set_from_args( \%methods, 
			   -methods => $self->{'_accessors'}, 
			   -case_sensitive => 1,
			   -create => 1 );
    return $self;
    
}

=head2 util()

 Title   : util
 Usage   : 
 Function: Name of the utility producing this result object.
 Returns : scalar string
 Args    : 

=cut

sub util { shift->{'_util'} }

=head2 som()

 Title   : som
 Usage   : 
 Function: get the original SOAP::SOM object
 Returns : a SOAP::SOM object
 Args    : none

=cut

sub som { shift->{'_som'} }

=head2 ok()

 Title   : ok
 Usage   : 
 Function: 
 Returns : true if no SOAP fault
 Args    : 

=cut

sub ok { !(shift->som->fault) }

=head2 errstr()

 Title   : errstr
 Usage   : 
 Function: 
 Returns : fault string of SOAP object
 Args    : none

=cut

sub errstr { shift->som->faultstring }

=head2 accessors()

 Title   : accessors
 Usage   : 
 Function: get the list of created accessors for this
           result
 Returns : array of scalar strings
 Args    : none
 Note    : does not include valid AUTOLOADed accessors; see
           DESCRIPTION

=cut

sub accessors { my $a = shift->{'_accessors'} ; @$a if $a }

=head2 webenv()

 Title   : webenv
 Usage   : 
 Function: contains WebEnv key referencing this
           result's session
 Returns : scalar
 Args    : none

=cut

sub webenv { shift->{'_WebEnv'} }

=head2 query_key()()

 Title   : query_key()
 Usage   : 
 Function: contains the web query key assigned
           to this result
 Returns : scalar
 Args    : 

=cut

sub query_key { shift->{'_QueryKey'} }

=head2 fetch_type()

 Title   : fetch_type
 Usage   : 
 Function: Get the efetch database name according to WSDL
 Returns : scalar string (db name) or undef if N/A
 Args    : none

=cut

sub fetch_type { shift->{'_fetch_type'} }

sub fetch_db { shift->{'_fetch_db'} }

sub result_type { shift->{'_result_type'} }

sub _traverse_methods {
    my ($m, $skey, $key, $som, $hash, $acc, $prune) = @_;
    if ($prune) {
	foreach (@$prune) {
	    return if "$skey\/$m" =~ /^$_/;
	}
    }
    my $val = $som->valueof("$skey\/$m");
    for (ref $val) {
	/^$/ && do {
	    my @a = $som->valueof("$skey\/$m");
	    my $M = $m;
	    # camelcase it
	    $M =~ s/([-_])([a-zA-Z0-9])/\u$2/g;
	    my $k = ($key ? "$key\_" : "").$M;
	    push @{$acc}, $k;
	    if (@a == 1) {
		$$hash{$k} = $a[0];
	    }
	    else {
		$$hash{$k} = \@a;
	    }
	    return;
	};
	/HASH/ && do {
	    foreach my $k (keys %$val) {
	    my $M = $m;
	    # camelcase it
	    $M =~ s/([-_])([a-zA-Z0-9])/\u$2/g;
	    _traverse_methods( $k, "$skey\/$m",
			       ($key ? "$key\_" : "").$M,
				   $som, $hash, $acc, $prune );
	    }
	    return;
	};
	do { #else, huh?
	    Bio::Root::Root->throw("SOAP::SOM parse error : please contact the mailing list"); 
	};
    }
}

sub AUTOLOAD {
    my $self = shift;
    my $accessor = $AUTOLOAD;
    $accessor =~ s/.*:://;
    my @list = grep /^${accessor}_/, @{$self->{'_accessors'}};
    unless (@list) {
	$self->debug("Accessor '$accessor' not present in this result");
	return;
    }
    my %ret;
    foreach (@list) {
	$ret{$_} = $self->$_;
    }
    return \%ret;
}
    
1;
