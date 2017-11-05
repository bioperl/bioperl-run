#-*-perl-*-

#testing SoapEUtilities with network queries
# idea: reproduce the examples at
# http://www.bioperl.org/wiki/HOWTO:EUtilities_Cookbook

use strict;
use warnings;
our $home;
BEGIN {
    use Bio::Root::Test;
    use lib '.';
    $home = '.'; # set to '.' for Build use,
                      # '..' for debugging from .t file
    unshift @INC, $home;
    test_begin(-tests => 119,
               -requires_modules => [qw(Bio::DB::ESoap
                                        Bio::DB::ESoap::WSDL
                                        Bio::DB::SoapEUtilities
                                        Bio::DB::SoapEUtilities::Result
                                        Bio::DB::SoapEUtilities::FetchAdaptor
                                        Bio::DB::SoapEUtilities::LinkAdaptor
                                        Bio::DB::SoapEUtilities::DocSumAdaptor
                                        SOAP::Lite
                                        XML::Twig
                                        )],
           -requires_email      => 1);
}

my $dep_msg = "NCBI SOAP EUtilities API no longer supported as of 2015, modules are deprecated and will be removed in a future release";

diag($dep_msg);

SKIP: {
    skip($dep_msg, 119);

    my $email = test_email();

    diag("Using $email for tests") if test_debug();

    my ($fac, $result, $seqio, $seq, $i);
    my @prot_ids = qw(1621261 89318838 68536103 20807972 730439);
    my @prot_ids_2 = qw(828392 790 470338);
    my @accns = qw(CAB02640 EAS10332 YP_250808 NP_623143 P41007);
    my $lg_contig = 27479347;
    my $sciname_id = 527031;
    my @gene_ids = qw(828392 790 470338);
    my $nbr_test_id = 1621261;
    my @linkout_test_ids = qw(28864546 53828898 14523048 14336674 1817575);

    SKIP : {
        test_skip(-tests => 119,
                  -requires_networking => 1);
    ok $fac = Bio::DB::SoapEUtilities->new(-verbose => test_debug), "SoapEUtilities factory";

    diag("Retrieve raw data records from GenBank, save raw data to file, then parse via Bio::SeqIO");

    ok $result = $fac->efetch(-email =>$email, -db => 'protein', -id => \@prot_ids_2 )->run(-no_parse=>1), "run efetch, no parse methods";

    ok $seqio = Bio::DB::SoapEUtilities::FetchAdaptor->new(-result=>$result), "create adaptor";
    for ($i=0; $seq = $seqio->next_seq; $i++) {
         isa_ok($seq, 'Bio::Seq::RichSeq');
         ok $seq->id, "primary_id present";
    1;}
    is $i, 3, "iterated all seq objs";
    ok $result = $fac->efetch( -rettype => 'fasta' )->run(-no_parse=>1), "run efetch, fasta return, no parse methods";
    ok $seqio = Bio::DB::SoapEUtilities::FetchAdaptor->new(-result=>$result), "create adaptor";
    for ($i=0; $seq = $seqio->next_seq; $i++) {
         isa_ok($seq, 'Bio::Seq');
         ok $seq->id, "primary_id present";
    1;}

    diag("Get accessions (actually accession.versions) for a list of GenBank IDs (GIs)");
    # SOAP server doesn't seem to like 'acc' as a rettype, get in fasta format
    # and use the result accessors
    ok $fac->efetch->set_parameters(-db=>'protein',
                                    -id=>\@prot_ids,
                                    -rettype => 'fasta' ), "set rettype = fasta";
    ok $result = $fac->efetch->run, "run query with methods parsing";
    is scalar @{$result->TSeqSet_TSeq_TSeqAccver}, 5, "retrieved all accns via \$result->TSeqSet_TSeq_TSeqAccver";
    diag("Get GIs for a list of accessions");
    ok $fac->efetch->set_parameters( -id=>\@accns ), "set -id to accn list";
    ok $result = $fac->efetch->run, "run query with methods parsing";
    is scalar @{$result->TSeqSet_TSeq_TSeqGi}, 5, "retrieved all GIs via \$result->TSeqSet_TSeq_TSeqGi";

    diag("Downloading a large contig");
    ok $fac->efetch->reset_parameters( -db => 'nucleotide',
                                       -email =>$email,
                                       -id => $lg_contig), "set parms for lg contig example";
    ok $seqio = $fac->efetch->run( -auto_adapt => 1 ), "run with auto_adapt";

    ok $seq = $seqio->next_seq, "iterate adaptor";
    ok !$seq->seq, "no sequence present (contig only)";
    TODO: {
        local $TODO = "why not work with gbwithparts?";
        ok $fac->efetch->set_parameters( -rettype=>'gbwithparts' ), "rettype = gbwithparts";
        dies_ok { $seqio = $fac->efetch->run( -auto_adapt => 1 ) };
        diag("run with auto_adapt (dies not really ok...)");

        ok $seq = $seqio->next_seq, "iterate adaptor";
        if ($seq) { ok $seq->seq, "sequence now present"; } else {ok 1;}
    }

    diag("Get the scientific name for an organism");
    ok $fac->efetch->reset_parameters( -email =>$email,
                                      -db=>'taxonomy',
                                      -id=>[$sciname_id, $sciname_id+1] ), "set params for sciname test";
    ok my $spio = $fac->efetch->run(-auto_adapt => 1), "run with autoadapt";
    ok my $sp = $spio->next_species;
    like $sp->scientific_name, qr/Bacillus thuringiensis/, "sciname";
    is ($sciname_id, $sp->ncbi_taxid, "taxid retrieved and correct");

    ok $fac->esummary( -email =>$email, -db => 'taxonomy', -id => $sciname_id ), "set esummary parms";
    ok my $docs = $fac->run(-auto_adapt=>1), "run with autoadapt";
    ok my $doc = $docs->next_docsum, "iterate adaptor";
    like $doc->ScientificName, qr/Bacillus thuringiensis/, "sciname";
    is ($sciname_id, $doc->TaxId, "taxid retrieved and correct");

    diag("Simple database query");
    ok $fac->esearch( -email =>$email, -db=>'protein', -term=> 'BRCA and human', -usehistory=>1 );
    ok $result = $fac->run, "run with method parsing";
    is $result->QueryTranslation,
       'BRCA[All Fields] AND ("Homo sapiens"[Organism] OR human[All Fields])',
    "query translation";
    cmp_ok $result->count, ">=", 73, "result count";
    ok $fac->esearch->reset_parameters(-email =>$email,
                                       -WebEnv => $result->webenv,
                                       -QueryKey => $result->query_key,
                                       -RetMax => 100 );
    ok my $wresult = $fac->esearch->run, "run web environment query with retmax set";
    cmp_ok $wresult->count, ">=", 73, "all ids retrieved";

    diag("What databases are available for querying via eUtils?");
    ok $result = $fac->einfo(-email =>$email)->run, "run einfo general query";
    cmp_ok scalar(@{$result->dbs}), ">=", 42, "bunch o' dbs";

    diag("What information is available for database 'x'?");
    ok $result = $fac->einfo(-email =>$email,-db=>'pubmed')->run, "run pubmed info";
    is $result->db, 'pubmed', "dbname";
    cmp_ok $result->record_count, ">=", 19000000, "record count";

    diag("How do I run a global query against all Entrez databases?");

    ok my $queries = $fac->egquery(-email =>$email, -term => 'BRCA and human' )->run(-auto_adapt=>1), "run fac for eGQuery, autoadapt";

    ok my $query = $queries->query_by_db('protein'), "query by db (protein)";
    is $query->term, 'BRCA and human', "term accessor correct";
    ok !$queries->query_by_db('bllog'), "no query by db (bllog)";
    for ( $i=0; my $q = $queries->next_query; $i++ ) {
        ok $q->db, "db (query $i)";
    }
    cmp_ok scalar($queries->found_in_dbs), ">=", 11, "found in enuf dbs";
    cmp_ok scalar($queries->found_in_dbs), "<=", $i, "but not in too many";

    diag("I want the document summaries for a list of IDs from database 'x'.");
    ok  $docs = $fac->esummary(-email =>$email, -db=>'gene', -id=>\@prot_ids_2 )->run(-auto_adapt=>1), "run esummary, autoadapt";
    my @tax = (3702, 9606, 9598);
    my @acc = qw( NC_003075.7 NC_000002.11 NC_006469.3 );
    for ($i=0; my $doc = $docs->next_docsum; $i++) {
        is $doc->id, $prot_ids_2[$i], " id retrieved";
        is $doc->TaxID, $tax[$i], " taxid retrieved correctly";
        is $doc->GenomicInfo->{ChrAccVer}, $acc[$i], "chrom acc/ver retrieved correctly";
        cmp_ok scalar ($doc->item_names), ">", 5, "bunch o' items";
    }
    is $i, 3, "got all docsums";

    diag("I want a list of database 'x' UIDs that are linked from a list of database 'y' UIDs");

    ok my $links =$fac->elink(-email =>$email,
                              -db => 'nucleotide',
                              -dbfrom => 'protein',
                              -id => \@prot_ids )->run( -auto_adapt => 1),
    "run elink protein->nucleotide, auto adapt";
    my %h;
    for ($i=0; my $linkset = $links->next_linkset; $i++) {
        my @ids = $linkset->ids;
        my @submitted_ids = $linkset->submitted_ids;
        $h{$submitted_ids[0]} = @ids == 1 ? $ids[0] : [@ids];
    }
    for (keys %h) {
        is_deeply( $links->id_map($_) || [], $h{$_}, "id_map correct ($_)");
        1;
    }
    is $i, 5, "got all linksets";

    1;

    }
}

# remove later
#sub test_input_file { "data/".shift };
