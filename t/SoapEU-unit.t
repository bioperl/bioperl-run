#-*-perl-*-
#$Id$
#testing SoapEUtilities and components
use strict;
use warnings;
our $home;
BEGIN {
    use Bio::Root::Test;
    use lib '.';
    $home = '.'; # set to '.' for Build use, 
                      # '..' for debugging from .t file
    unshift @INC, $home;
    test_begin(-tests => 139,
	       -requires_modules => [qw(Bio::DB::ESoap
                                        Bio::DB::ESoap::WSDL
                                        Bio::DB::SoapEUtilities
                                        Bio::DB::SoapEUtilities::Result
                                        Bio::DB::SoapEUtilities::FetchAdaptor
                                        Bio::DB::SoapEUtilities::LinkAdaptor
                                        Bio::DB::SoapEUtilities::DocSumAdaptor
                                        SOAP::Lite
                                        XML::Twig
                                        )]);
}

# use data files for most unit testing
# see skip section for network tests

# ESoap::WSDL
my $NCBI_SOAP_SVC = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/soap/v2.0/soap_adapter_2_0.cgi";
my @EUTILS = qw( einfo esearch elink egquery epost espell esummary);

diag("NOTE: No network access required for these tests; all are local file-based.");

ok my $wsdl = Bio::DB::ESoap::WSDL->new(-wsdl => test_input_file('eutils.wsdl')), "wsdl parse from file";

is_deeply ( [sort values %{$wsdl->operations}], [sort @EUTILS ], "available operations (as of 1/9/10)" );
is $wsdl->service, $NCBI_SOAP_SVC, "correct soap svc url (as of 1/9/10)";

is_deeply( $wsdl->request_parameters('einfo'), 
	   { 'eInfoRequest' => [
		 { 'db' => 1 },
		 { 'tool' => 1 },
		 { 'email' => 1 }
		 ] } , 'einfo request parameters');
is_deeply( $wsdl->response_parameters('einfo'), 
	   {'eInfoResult' =>
		[ {'ERROR' => 1},
		  {'DbList' => [{'DbName|' => 1 }]},
		  {'DbInfo' => [ 
		       {'DbName' => 1 }, 
		       {'MenuName' => 1},
		       {'Description' => 1},
		       {'Count' => 1},
		       {'LastUpdate' => 1},
		       {'FieldList' => [
			    {'Field' => [
				 {'Name' => 1},
				 {'FullName' => 1},
				 {'Description' => 1},
				 {'TermCount' => 1},
				 {'IsDate' => 1},
				 {'IsNumerical' => 1},
				 {'SingleToken' => 1},
				 {'Hierarchy' => 1},
				 {'IsHidden' => 1}
				 ]}
			    ]},
		       {'LinkList' => [
			    {'Link' => [
				 {'Name' => 1},
				 {'Menu' => 1},
				 {'Description' => 1},
				 {'DbTo' => 1}
				 ]}
			    ]}
		       ]}
	     ]}, 'einfo response parameters');
is_deeply( $wsdl->request_parameters('egquery'),
	   { 'eGqueryRequest' => [
		 { 'term' => 1 },
		 { 'tool' => 1 },
		 { 'email' => 1 }
		 ] } , 'egquery request parameters');
is_deeply( $wsdl->response_parameters('egquery'),
	   { 'Result' => [
		 { 'Term' => 1 },
		 { 'eGQueryResult' => [
		       {'ERROR' => 1},
		       {'ResultItem' => [
			    {'DbName' => 1},
			    {'MenuName' => 1},
			    {'Count' => 1},
			    {'Status' => 1}
			    ]}
		       ]}
		 ]} , 'egquery response parameters');

# ESoap

ok my $dumfac = Bio::DB::ESoap->new( -util => 'run_eLink',
				     -wsdl_file => test_input_file('eutils.wsdl') ), "dummy ESoap factory";

is $dumfac->util, 'run_eLink', 'operation accessor';
ok $dumfac = Bio::DB::ESoap->new( -util => 'elink',
				     -wsdl_file => test_input_file('eutils.wsdl') ), "dummy ESoap factory";
is $dumfac->util, 'run_eLink', 'operation name converted';
require File::Spec;
is( (File::Spec->splitpath($dumfac->wsdl_file))[-1], 'eutils.wsdl', 'wsdl filename accessor' );
is $dumfac->_request_elt_name, 'eLinkRequest', 'request element name';
is $dumfac->_result_elt_name, 'eLinkResult', 'result element name';
is_deeply( [sort $dumfac->available_parameters], [sort qw( db id reldate mindate maxdate datetype term dbfrom linkname WebEnv query_key cmd tool email )], 'elink available parameters via Bio::ParameterBaseI');
ok $dumfac->set_parameters( -db => 'gene', -id => 12345, -tool => 'ESoapTest' ), 'set_parameters';
ok $dumfac->parameters_changed, "parameters_changed flag set";
is_deeply( [$dumfac->get_parameters], [qw( db gene id 12345 tool ESoapTest )],
	   'get_parameters' );
ok !$dumfac->parameters_changed, "parameters_changed flag cleared";
is $dumfac->db, 'gene', 'parameter as accessor';
is $dumfac->tool, 'ESoapTest', 'parameter as accessor (2)';
ok $dumfac->reset_parameters, "reset_parameters";
ok $dumfac->parameters_changed, "parameters_changed flipped";

# SoapEUtilities

ok $dumfac = Bio::DB::SoapEUtilities->new( -wsdl_file => test_input_file('eutils.wsdl') ), "make SoapEU factory";

ok $dumfac->esearch( -db => 'gene', -term => 'bat guano' ), "esearch instance";
ok $dumfac->elink( -dbfrom => 'protein', -db => 'taxonomy', -id => [1234,5678] ),
    "elink instance";
is_deeply( [$dumfac->esearch->get_parameters],
	   [qw( db gene term ), "bat guano"], "esearch get_parameters");
is_deeply( [$dumfac->elink->get_parameters], 
	   [qw(db taxonomy dbfrom protein id ), [1234, 5678]],
	   "elink get_parameters" );
is $dumfac->esearch->db, 'gene', "esearch delegation";
is $dumfac->elink->db, 'taxonomy', "elink delegation";
ok $dumfac->esearch->db('protein'), "esearch set parameter by accessor";
ok $dumfac->esearch->parameters_changed, "esearch parameters_changed";
is $dumfac->esearch->db, 'protein', "was set";
ok !$dumfac->elink->parameters_changed, "elink not parameters_changed";

# work over SoapEUtilities::Result

$dumfac->esummary();
open my $xmlsumf, test_input_file('esum_result.xml');
{ local $/ = undef;
  $dumfac->{'_response_message'} = SOAP::Deserializer->deserialize(<$xmlsumf>);
}

ok my $result = Bio::DB::SoapEUtilities::Result->new($dumfac), "create Result object (esummary)";
is $result->util, 'esummary', 'util accessor';
is $result->count, 3, "count";
is_deeply( $result->ids, [828392, 790, 470338], "ids" );

$dumfac->esearch;
open my $xmlf, test_input_file('esearch_result.xml');
{ local $/ = undef;
  $dumfac->{'_response_message'} = SOAP::Deserializer->deserialize(<$xmlf>);
}
ok $result = Bio::DB::SoapEUtilities::Result->new($dumfac), "create Result object (esearch)";
is $result->util, 'esearch', 'util accessor';
is $result->count, 777, "count";
is_deeply $result->ids, [qw(
           4212556
	   7103559
	   7036330
	   7005509
	   6515581
	   6333573
	   6067533
	   5849183
	   5625162
	   5613996
	   5451592
	   5188376
	   5182770
	   5174340
	   5132346
	   5079123
	   4625535
	   4233539
	   4227906
           4171988)], "ids";


$dumfac->elink;
open $xmlf, test_input_file('elink_result.xml');
{ local $/ = undef;
  $dumfac->{'_response_message'} = SOAP::Deserializer->deserialize(<$xmlf>);
}
ok $result = Bio::DB::SoapEUtilities::Result->new($dumfac, -no_parse=>1), "create Result object (elink, don't parse)";
ok !$result->count, "as requested, did not parse accessors";
ok $result->parse_methods( { 'ids' => 'LinkSet_IdList_Id' } ), "parse_methods on object";
is $result->util, 'elink', 'util accessor';
is $result->count, 3, "count";
is_deeply( [sort @{$result->ids}], [sort qw(828392 790 470338)], "ids" );

# check accessors; one for each xml tree tip below <eLinkResult>
is_deeply( [sort $result->accessors], [ sort qw(
                                     count ids
                                     LinkSet_DbFrom LinkSet_IdList_Id
                                     LinkSet_LinkSetDb_DbTo
                                     LinkSet_LinkSetDb_LinkName
                                     LinkSet_LinkSetDb_Link_Id) ],
	   "accessors for each response tip" );

is ( ref $result->LinkSet, 'HASH', "autoload higher level accessor returns hashref");
is( ref $result->LinkSet_LinkSetDb_DbTo, 'ARRAY', "created accessor return arrayref" );
is ( $result->count, scalar @{$result->LinkSet_LinkSetDb_DbTo}, "count same as number of records same as number elts returned by accessor");
is_deeply( [sort keys %{$result->LinkSet_LinkSetDb}], [sort qw(
                                     LinkSet_LinkSetDb_DbTo
                                     LinkSet_LinkSetDb_LinkName
                                     LinkSet_LinkSetDb_Link_Id) ],
	   "autoload higher level accessor, return list");
ok $result->LinkSet_LinkSetDb_LinkName, "LinkName is present";
ok $result = Bio::DB::SoapEUtilities::Result->new($dumfac, 
						  -alias_hash =>
						  { 'gefilte_fish' =>
							'LinkSet_DbFrom' },
						  -prune_at_nodes =>
						      '//LinkSet/LinkSetDb/LinkName'
    ), "result, parse but prune at single node //LinkSet/LinkSetDb/LinkName";
is ($result->LinkSet_DbFrom->[0], 'gene', "DbFrom");
is ($result->gefilte_fish->[0], 'gene', "alias correct");
ok $result->LinkSet_LinkSetDb_DbTo, "DbTo present, but..";
ok !$result->LinkSet_LinkSetDb_LinkName, "LinkName is not";
ok $result = Bio::DB::SoapEUtilities::Result->new($dumfac, 
						  -prune_at_nodes =>
						  ['//LinkSet/LinkSetDb', 
						   '//LinkSet/DbFrom']
    ), " prune at multiple nodes: //LinkSet/LinkSetDb, //LinkSet/";

ok grep(/LinkSet_IdList_Id/, $result->accessors), "IdList_Id present";
ok !grep(/LinkSet_LinkSetDb/, $result->accessors), "LinkSet_LinkSetDb not present";

# Adaptors

# linkset
my $i;

my %testdata = (
    'db_from' => 'gene',
    'db_to' => 'taxonomy',
    'link_name' => 'gene_taxonomy',
    'submitted_ids' => [ [790], [828392], [470338] ],
    'ids' => [ [9606], [3702], [9598] ],
    'submitted_ids_flat' => [790, 828392, 470338 ],
    'ids_flat' => [ 9606, 3702, 9598 ]
    );

ok my $links = Bio::DB::SoapEUtilities::LinkAdaptor->new(
    -result => $result
    ), "get linkset adapator";

for ($i = 0; my $linkset = $links->next_linkset; $i++) {
    for ( keys %testdata ) {
	next if /flat/;
	if (/ids/) {
	    is_deeply( [$linkset->$_], $testdata{$_}->[$i], "linkset accessor ($_)");
	}
	else {
	    is $linkset->$_, $testdata{$_}, "linkset accessor ($_)";
	}
    }
    is ($links->id_map($testdata{'submitted_ids_flat'}->[$i]),
	$testdata{'ids_flat'}->[$i], 'id_map correct correspondence');
    
}

is ($i, 3, "all linksets accessed");
$links->rewind;
ok $links->next_linkset, "rewind works";



# docsum
$dumfac->esummary;
open $xmlf, test_input_file('esum_result.xml');
{local $/=undef;
$dumfac->{'_response_message'} = SOAP::Deserializer->deserialize(<$xmlf>);
}
$result = Bio::DB::SoapEUtilities::Result->new($dumfac, -no_parse=>1);

ok my $docsums = Bio::DB::SoapEUtilities::DocSumAdaptor->new(
    -result => $result
    ), "get docsum adaptor";


%testdata = (
    'id' => [828392, 790, 470338],
    'Name' => [qw(PYR4 CAD CAD)],
    'Orgname' => [qw(Arabidopsis Homo Pan)],
    'TaxID' => [3702, 9606, 9598],
    'ChrAccVer' => [qw( NC_003075.7 NC_000002.11 NC_006469.2 )]
    );

for ( $i=0; my $docsum = $docsums->next_docsum; $i++ ) {
    foreach (keys %testdata) {
	if (!/Chr/) {
	    my $t =  $testdata{$_}->[$i];
	    like $docsum->$_, qr/$t/, "docsum accessor ($_)";
	}
	else {
	    is ($docsum->GenomicInfo->{$_}, $testdata{$_}->[$i], "docsum hash accessor (GenomicInfo/$_)");
	}
    }
}
is ($i, 3, "all docsums accessed");
$docsums->rewind;
ok $docsums->next_docsum, "rewind works";

my @item_names = qw(
                    Name
                    Description
                    Orgname
                    Status
                    CurrentID
                    Chromosome
                    GeneticSource
                    MapLocation
                    OtherDesignations
                    NomenclatureSymbol
                    NomenclatureName
                    NomenclatureStatus
                    TaxID
                    Mim
                    GenomicInfo
                    GeneWeight
                    Summary
                    ChrSort
                    ChrStart
                   );
is_deeply( [$docsums->next_docsum->item_names], [@item_names], "docsum item list" );


### test FetchAdaptors : add test set with local wsdls and xml result data
### for each new subclass...
### create local wsdls by including and importing types/schemas by hand into
### the local copy (to avoid network hits in this .t)
###

# fetch genbank

#my ($dumfac, $xmlf,$result,%testdata,$i);
# change wsdls
ok $dumfac = Bio::DB::SoapEUtilities->new( -wsdl_file => test_input_file('efetch_seq.wsdl') ), "change wsdl";
$dumfac->efetch();
open $xmlf, test_input_file('gb_result.xml');
{ local $/ = undef;
  $dumfac->{'_response_message'} = SOAP::Deserializer->deserialize(<$xmlf>);
}
ok $result = Bio::DB::SoapEUtilities::Result->new($dumfac, -no_parse=>1), "create Result object (efetch protein (GenBank), don't parse methods)";

ok my $seqio = Bio::DB::SoapEUtilities::FetchAdaptor->new( -result => $result ),
    "create FetchAdaptor";

isa_ok $seqio, 'Bio::DB::SoapEUtilities::FetchAdaptor::seq';

%testdata = (
    'id' => [qw( CAB02640 EAS10332 )],
    'seq' => [qw( mgaagdaaigres mgapdqsgsdrelmsa )],
    'alphabet' => [qw( protein protein )],
    'molecule' => [qw( AA AA )],
    'seq_version' => [ 1, 1 ],
    'feats' => [{ 'Region' => { 'start' => [11,11],
				'end' => [193, 186],
				'tags' => {
				    'region_name' => [qw( Pribosyltran Pribosyltran )]
				}
		  },
		  'CDS' => {
		      'start' => [1, 1],
		      'end'   => [193, 193],
		      'tags'  => {
			  'coded_by' => [qw( BX842576.1:169611..170192
                                             AAPA01000007.1:178491..179072)]
		      }
		  }
			  
		}],
    'annotation' => [{ 
	'reference' => { 
	    'title' => ['Deciphering the biology',
                       'Sequencing of the draft'],
	    'consortium' => [ undef, 'JGI-PGF' ],
	    'pubmed' => [9634230, undef]
	}
		     }],
    'species' => { 
	'genus' => [qw( Mycobacterium Mycobacterium )],
	'binomial' => [qw( tuberculosis gilvum ) ]
    }
    );

	             
for ( $i=0; my $seq = $seqio->next_seq; $i++ ) {
    is( $seq->id, $testdata{id}->[$i], 'id' );
    like $seq->seq, qr/${$testdata{seq}}[$i]/, 'seq';
    is $seq->alphabet, $testdata{alphabet}->[$i], 'alphabet';
    is $seq->molecule, $testdata{molecule}->[$i], 'molecule';
    is $seq->version, 1, 'seq_version';
    like $seq->species->genus, qr/${$testdata{species}}{genus}[$i]/, 'species/genus';
    like $seq->species->binomial, qr/${$testdata{species}}{binomial}[$i]/, 
    'species/binomial';
    my @feats = $seq->get_SeqFeatures;
    foreach my $testf (@{$testdata{feats}}) {
	foreach my $pt (keys %$testf) {
	    my ($feat) = grep { $_->primary_tag eq $pt } @feats;
	    is $feat->start, $testf->{$pt}{'start'}[$i], "$pt/start";
	    is $feat->end, $testf->{$pt}{'end'}[$i], "$pt/end";
	    foreach my $tag (keys %{$testf->{$pt}{tags}}) {
		my $tdata = $testf->{$pt}{tags}{$tag}[$i];
		is (($feat->get_tag_values($tag))[0], $tdata, "$pt/$tag");
	    }
	}
    }

    foreach my $testa (@{$testdata{annotation}}) {
	foreach (keys %$testa) {
	    my ($ann) = $seq->annotation->get_Annotations($_);
	    foreach my $key (keys %{$testa->{$_}}) {
		my $tdata = $testa->{$_}{$key}[$i];
		if (!defined $tdata && !defined $ann->$key) {
		    ok 1;
		}
		else {
		    like $ann->$key, qr/$tdata/, "$_/$key";
		}
	    }
	}
    }
}
is ($i, 2, "got all seqs");
1;

# remove later
#sub test_input_file { "data/".shift };
