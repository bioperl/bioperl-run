# -*-Perl-*-
## Bioperl Test Harness Script for Modules


use strict;
BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Alignment]Sim4');
    test_begin(-tests => 23);
    use_ok('Bio::Tools::Run::Alignment::Sim4');
    use_ok('Bio::SimpleAlign');
    use_ok('Bio::AlignIO');
    use_ok('Bio::SeqIO');
}

my $verbose = -1;

my $cdna = test_input_file("sim4_cdna.fa");
my $genomic = test_input_file("sim4_genomic.fa");
my @params = (W=>15,K=>17,D=>10,N=>10,cdna_seq=>$cdna,genomic_seq=>$genomic);
my  $factory = Bio::Tools::Run::Alignment::Sim4->new(@params);

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 19);
    isa_ok $factory,'Bio::Tools::Run::Alignment::Sim4';
    my $bequiet = 1;
    $factory->quiet($bequiet);  # Suppress clustal messages to terminal
    
    #test by having inputs in constructor
    my @exon_set = $factory->align;
    
    my @exons = $exon_set[0]->sub_SeqFeature;
    is $exons[0]->start, 26;
    is $exons[0]->end, 268;
    is $exons[0]->strand, 1;
    
    
    my $sio = Bio::SeqIO->new(-file=>$cdna,-format=>"fasta");
    my $sio2 = Bio::SeqIO->new(-file=>$genomic,-format=>"fasta");
    
    #test with 2 seq objs
    my @cdna_seq;
    while(my $seq = $sio->next_seq){
        push @cdna_seq,$seq;
    }
    my @genomic_seq;
    while(my $seq = $sio2->next_seq){
        push @genomic_seq,$seq;
    }
    
    @exon_set = $factory->align($cdna_seq[0],$genomic_seq[0]);
    
    @exons = $exon_set[0]->sub_SeqFeature;
    is $exons[0]->start, 26;
    is $exons[0]->end, 268;
    is $exons[0]->strand, 1;
    
    #test with cdna database as file
    
    my $db =  test_input_file("sim4_database.fa");
    @params = (W=>15,K=>17,D=>10,N=>10,cdna_seq=>$db,genomic_seq=>$genomic);
    $factory = Bio::Tools::Run::Alignment::Sim4->new(@params);
    
    @exon_set = $factory->align();
    @exons = $exon_set[0]->sub_SeqFeature;
    is $exons[0]->start, 26;
    is $exons[0]->end, 268;
    is $exons[0]->strand, 1;
    
    @exons = $exon_set[1]->sub_SeqFeature;
    is $exons[0]->start, 26;
    is $exons[0]->end, 268;
    is $exons[0]->strand, 1;
    
    
    #test with cdna database as object
    
    $sio = Bio::SeqIO->new(-file=>$db,-format=>"fasta");
    @cdna_seq=();
    while(my $seq = $sio->next_seq){
        push @cdna_seq,$seq;
    }
        
    $factory->align(\@cdna_seq,$genomic);
    
    @exon_set = $factory->align();
    @exons = $exon_set[0]->sub_SeqFeature;
    is $exons[0]->start, 26;
    is $exons[0]->end, 268;
    is $exons[0]->strand, 1;
    
    @exons = $exon_set[1]->sub_SeqFeature;
    is $exons[0]->start, 26;
    is $exons[0]->end, 268;
    is $exons[0]->strand, 1;
}
