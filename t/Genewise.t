#!/usr/local/bin/perl
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
    $NTESTS = 13;
    plan tests => $NTESTS;
}
use Bio::Tools::Run::Genewise;
use Bio::Root::IO;
use Bio::Seq;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("genewise program not found. Skipping. (Be sure you have the wise package > 2.2.0)",1);
    }
}

ok(1);
my $verbose = -1;
my @params = ('dymem'=> 'linear','kbyte'=>'5000','erroroffstd'=>1);
my  $factory = Bio::Tools::Run::Genewise->new(@params);
ok $factory->isa('Bio::Tools::Run::Genewise');

unless ($factory->executable) {
   warn("Genewise program not found. Skipping tests $Test::ntest to $NTESTS.\n");
   exit 0;
}

my $bequiet = 1;
$factory->quiet($bequiet);  # Suppress pseudowise messages to terminal



#test with one file with 2 sequences
my $inputfilename = Bio::Root::IO->catfile("t/data","new_pep.fa");
my $seqstream1 = Bio::SeqIO->new(-file => $inputfilename, -fmt => 'Fasta');
my $seq1 = Bio::Seq->new();
$seq1 = $seqstream1->next_seq();

$inputfilename = Bio::Root::IO->catfile("t/data","new_dna.fa");
my $seqstream2 = Bio::SeqIO->new(-file => $inputfilename, -fmt => 'Fasta');
my $seq2 = Bio::Seq->new();
$seq2 = $seqstream2->next_seq();

my ($genes) = $factory->predict_genes($seq1, $seq2);

my @transcripts = $genes->transcripts;
my @feat = $transcripts[0]->exons;
my $seqname = $feat[0]->seqname;
my $start = $feat[0]->start;
ok($start, 865);#ok3
my $end = $feat[0]->end;
ok($end, 897);#ok4
my $strand = $feat[0]->strand;
ok($strand, 1);#ok5


my ($featpair)= $feat[0]->each_tag_value('supporting_feature');
ok($featpair->feature1->start,865);
ok($featpair->feature1->end,897);
ok($featpair->feature1->strand,1);
ok($featpair->feature1->score,17.01);
ok($featpair->feature2->start,120);
ok($featpair->feature2->end,130);
ok($featpair->feature2->strand,1);
ok($featpair->feature2->score,17.01);







