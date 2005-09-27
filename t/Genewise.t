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
    $NTESTS = 18;
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
my @params = ('-verbose' => $verbose, 
	      'silent' => 1, 
	      'quiet' => 1);

my  $factory = Bio::Tools::Run::Genewise->new(@params);
my $version = $factory->version;

ok $factory->isa('Bio::Tools::Run::Genewise');
unless ($factory->executable) {
   warn("Genewise program not found. Skipping tests $Test::ntest to $NTESTS.\n");
   exit 0;
}

my $bequiet = 1;
$factory->quiet($bequiet);  # Suppress pseudowise messages to terminal

#test with one file with 2 sequences
my $inputfilename = Bio::Root::IO->catfile(qw(t data road.pep));
my $seqstream1 = Bio::SeqIO->new(-file => $inputfilename, 
				 -format => 'fasta');
my $seq1 = Bio::Seq->new();
$seq1 = $seqstream1->next_seq();

$inputfilename = Bio::Root::IO->catfile(qw(t data human.genomic));
my $seqstream2 = Bio::SeqIO->new(-file => $inputfilename, 
				 -format => 'fasta');
my $seq2 = Bio::Seq->new();
$seq2 = $seqstream2->next_seq();

my ($genes) = $factory->predict_genes($seq1, $seq2);

my @transcripts = $genes->transcripts;
my @feat = $transcripts[0]->exons;
my $seqid = $feat[0]->seq_id;
ok($seqid, 'HSHNRNPA');
my ($featpair)= $feat[0]->each_tag_value('supporting_feature');
ok($featpair->feature2->seq_id,'roa1_drome');
ok($featpair->feature1->seq_id,'HSHNRNPA');
if( defined $version && $version eq 'wise2-2-0' ) {
    ok($transcripts[0]->start, 1386);
    ok($transcripts[0]->end, 3963);
    ok($feat[0]->start, 1386);
    ok($feat[0]->end, 1493);
    ok($feat[0]->strand,1);
    ok($featpair->feature2->start,26);
    ok($featpair->feature2->end,61);
    ok($featpair->feature2->strand,1);
    ok($featpair->feature2->score,'253.10');
    ok($featpair->feature1->start,1386);
    ok($featpair->feature1->end,1493);
    ok($featpair->feature1->strand,1);
    ok($featpair->feature1->score,'253.10');
} else {
    warn("These tests may fail because I'm not sure about your genewise version -- using wise 2.2.3-rc7 values\n");
    ok($transcripts[0]->start, 1386);
    ok($transcripts[0]->end, 4304);

    ok($feat[0]->start, 1386);
    ok($feat[0]->end, 1497);
    ok($feat[0]->strand,1);
    ok($featpair->feature2->start,26);
    ok($featpair->feature2->end,62);
    ok($featpair->feature2->strand,1);
    ok($featpair->feature2->score,'271.50');
    ok($featpair->feature1->start,1386);
    ok($featpair->feature1->end,1496);
    ok($featpair->feature1->strand,1);
    ok($featpair->feature1->score,'271.50');

}






