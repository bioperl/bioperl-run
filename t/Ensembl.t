# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('Ensembl');
    test_begin(-tests => 7,
               -requires_networking => 1);
    use_ok('Bio::Tools::Run::Ensembl');
}

my $setup_ok = Bio::Tools::Run::Ensembl->registry_setup();

# test database access
SKIP: {
    test_skip(-tests => 6, -requires_module => 'Bio::EnsEMBL::Registry');
    skip("There was some problem contacting the EnsEMBL database?", 6) unless $setup_ok;
    
    # get an adaptor
    ok my $adaptor = Bio::Tools::Run::Ensembl->get_adaptor('human', 'Exon');
    isa_ok $adaptor, 'Bio::EnsEMBL::DBSQL::ExonAdaptor';
    if ($adaptor->can('species_id')) {
        is $adaptor->species_id, 1;
    }
    else {
        ok 1;
    }
    
    # get an 'easy' gene - one that is in Ensembl
    ok my $gene = Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
                                                             -name => 'BRCA2');
    isa_ok $gene, 'Bio::EnsEMBL::Gene';
    is $gene->external_name, 'BRCA2';
    
    
    #*** don't know suitable gene names to test the following, to be completed...
    
    # get one that isn't in human, but is in an orthologue
    my $orth_only = '??';
    #ok ! Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
    #                                                -name => $orth_only);
    #ok $gene = Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
    #                                                      -use_orthologues => 'Mus musculus',
    #                                                      -name => $orth_only);
    #is $gene->external_name, $orth_only;
    
    # get one that isn't in Ensembl but is in Swissprot
    my $swiss_only = '??';
    #ok ! Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
    #                                                -use_orthologues => 'Mus musculus',
    #                                                -name => $swiss_only);
    #ok $gene = Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
    #                                                      -use_orthologues => 'Mus musculus',
    #                                                      -use_swiss_lookup => 1,
    #                                                      -name => $swiss_only);
    #is $gene->external_name, $swiss_only;
    
    # get one that isn't in Swissprot either, but is in NCBI
    my $ncbi_only = '??';
    #ok ! Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
    #                                                -use_orthologues => 'Mus musculus',
    #                                                -use_swiss_lookup => 1,
    #                                                -name => $ncbi_only);
    #ok $gene = Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
    #                                                      -use_orthologues => 'Mus musculus',
    #                                                      -use_swiss_lookup => 1,
    #                                                      -use_entrez_lookup => 1,
    #                                                      -name => $ncbi_only);
    #is $gene->external_name,  $ncbi_only;
}
