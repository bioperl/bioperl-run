#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules

use strict;

BEGIN { 
  use Bio::Root::Test;
  test_begin(-tests => 40);
  
  use_ok 'Bio::Tools::Run::Alignment::Blat';
  use_ok 'Bio::SeqIO';
  use_ok 'Bio::Seq';
}

my $db    = test_input_file('blat_dna.fa');
my $query = test_input_file('blat_dna.fa');

my $factory = Bio::Tools::Run::Alignment::Blat->new(-db => $db);
ok $factory->isa('Bio::Tools::Run::Alignment::Blat');

my $blat_present = $factory->executable();

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 24);
    
    my $searchio = $factory->align($query);
    isa_ok $searchio, 'Bio::SearchIO';

    my $result = $searchio->next_result;
    my $hit    = $result->next_hit;
    my $hsp    = $hit->next_hsp;
    isa_ok($hsp, "Bio::Search::HSP::HSPI");
    is $hsp->query->start, 1;
    is $hsp->query->end, 1775;
    is $hsp->hit->start, 1;
    is $hsp->hit->end, 1775;
    is $hsp->hsp_length, 1775;

    my $sio = Bio::SeqIO->new(-file => $query, -format => 'fasta');    
    my $seq = $sio->next_seq ;
    
    $searchio = $factory->align($seq);
    like $searchio, qr/psl/, 'PSL parser (default)';
    $result = $searchio->next_result;
    $hit    = $result->next_hit;
    $hsp    = $hit->next_hsp;
    isa_ok $hsp, 'Bio::Search::HSP::HSPI';
    is $hsp->query->start, 1;
    is $hsp->query->end, 1775;
    is $hsp->hit->start, 1;
    is $hsp->hit->end, 1775;
    
    # test alternate formats (not all of these work!)
    $factory->reset_parameters(#-quiet  => 1,
                               -db  => $db,
                               -out => 'blast');
    $searchio = $factory->align($query);
    
    like $searchio, qr/blast/, 'BLAST parser';
    
    $result = $searchio->next_result;
    $hit    = $result->next_hit;
    $hsp    = $hit->next_hsp;
    isa_ok $hsp, 'Bio::Search::HSP::HSPI';
    is $hsp->query->start, 1;
    is $hsp->query->end, 1775;
    is $hsp->hit->start, 1;
    is $hsp->hit->end, 1775;
    
    $factory->reset_parameters(#-quiet => 1,
                               -db  => $db,
                               -out => 'blast9');
    $searchio = $factory->align($query);
    
    like $searchio, qr/blasttable/, 'Tabular BLAST parser';
    
    $result = $searchio->next_result;
    $hit    = $result->next_hit;
    $hsp    = $hit->next_hsp;
    isa_ok $hsp, 'Bio::Search::HSP::HSPI';
    is $hsp->query->start, 1;
    is $hsp->query->end, 1775;
    is $hsp->hit->start, 1;
    is $hsp->hit->end, 1775;
}

# new wrapper; regions

$db = test_input_file('blat_dna.2bit');

$factory = Bio::Tools::Run::Alignment::Blat->new(
    -db       => $db,
    #-quiet   => 1,
    -qsegment => 'sequence_10:0-100',
    -tsegment => 'sequence_10:0-100',
    # 0-based, Blat-compatible coordinates (start, end]
    );
ok $factory->isa('Bio::Tools::Run::Alignment::Blat');

SKIP: {
    skip("tests that require file named blat_dna.2bit and executable", 10) if ! -e $db;

    test_skip(-requires_executable => $factory,
              -tests => 10);

    my $searchio = $factory->align($db);
    my $result = $searchio->next_result;
    my $hit    = $result->next_hit;
    my $hsp    = $hit->next_hsp;
    isa_ok $hsp, 'Bio::Search::HSP::HSPI';
    is $hsp->query->start, 1;
    is $hsp->query->end, 100;
    is $hsp->hit->start, 1;
    is $hsp->hit->end, 100;
    
    # No on-the-fly conversion of Bio::Seq yet
    my $sio = Bio::SeqIO->new(-file=>$query,-format=>'fasta');
    my $seq = $sio->next_seq ;
    
    $searchio = $factory->align($seq);
    $result = $searchio->next_result;
    $hit    = $result->next_hit;
    $hsp    = $hit->next_hsp;
    isa_ok $hsp, 'Bio::Search::HSP::HSPI';
    is $hsp->query->start, 1;
    is $hsp->query->end, 1775;
    is $hsp->hit->start, 1;
    is $hsp->hit->end, 1775;
}

1; 

