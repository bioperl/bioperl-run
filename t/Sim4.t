# -*-Perl-*-
## Bioperl Test Harness Script for Modules


use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 20;
    plan tests => $NTESTS;
}
use Bio::Tools::Run::Alignment::Sim4;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::Root::IO;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("sim4 program not found. Skipping. (Be sure you have the wise package > 2.2.0)",1);
    }
}

ok(1);
my $verbose = -1;

my $cdna = Bio::Root::IO->catfile("t","data","sim4_cdna.fa");
my $genomic = Bio::Root::IO->catfile("t","data","sim4_genomic.fa");
my @params = (W=>15,K=>17,D=>10,N=>10,cdna_seq=>$cdna,genomic_seq=>$genomic);
my  $factory = Bio::Tools::Run::Alignment::Sim4->new(@params);

unless (defined $factory->executable) {
    warn("Sim4 program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

ok $factory->isa('Bio::Tools::Run::Alignment::Sim4');
my $bequiet = 1;
$factory->quiet($bequiet);  # Suppress clustal messages to terminal

#test by having inputs in constructor
my @exon_set = $factory->align;

my @exons = $exon_set[0]->sub_SeqFeature;
ok $exons[0]->start, 26;
ok $exons[0]->end, 268;
ok $exons[0]->strand, 1;


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
ok $exons[0]->start, 26;
ok $exons[0]->end, 268;
ok $exons[0]->strand, 1;

#test with cdna database as file

my $db =  Bio::Root::IO->catfile("t","data","sim4_database.fa");
@params = (W=>15,K=>17,D=>10,N=>10,cdna_seq=>$db,genomic_seq=>$genomic);
$factory = Bio::Tools::Run::Alignment::Sim4->new(@params);

@exon_set = $factory->align();
@exons = $exon_set[0]->sub_SeqFeature;
ok $exons[0]->start, 26;
ok $exons[0]->end, 268;
ok $exons[0]->strand, 1;

@exons = $exon_set[1]->sub_SeqFeature;
ok $exons[0]->start, 26;
ok $exons[0]->end, 268;
ok $exons[0]->strand, 1;


#test with cdna database as object

$sio = Bio::SeqIO->new(-file=>$db,-format=>"fasta");
@cdna_seq=();
while(my $seq = $sio->next_seq){
    push @cdna_seq,$seq;
}
    
$factory->align(\@cdna_seq,$genomic);

@exon_set = $factory->align();
@exons = $exon_set[0]->sub_SeqFeature;
ok $exons[0]->start, 26;
ok $exons[0]->end, 268;
ok $exons[0]->strand, 1;

@exons = $exon_set[1]->sub_SeqFeature;
ok $exons[0]->start, 26;
ok $exons[0]->end, 268;
ok $exons[0]->strand, 1;

