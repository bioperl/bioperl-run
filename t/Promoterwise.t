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
    $NTESTS = 8;
    plan tests => $NTESTS;
}
use Bio::Tools::Run::Promoterwise;
use Bio::Root::IO;
use Bio::Seq;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("genewise program not found. Skipping. (Be sure you have the wise package > 2.2.0)",1);
    }
}

ok(1);
my $verbose = -1;
my @params = ('-verbose' => $verbose, 'silent' => 1, 'quiet' => 1);
my  $factory = Bio::Tools::Run::Promoterwise->new(@params);
ok $factory->isa('Bio::Tools::Run::Promoterwise');
unless ($factory->executable) {
   warn("Genewise program not found. Skipping tests $Test::ntest to $NTESTS.\n");
   exit 0;
}

my $bequiet = 1;
$factory->quiet($bequiet);  # Suppress pseudowise messages to terminal

#test with one file with 2 sequences
my $inputfilename = Bio::Root::IO->catfile(qw(t data sim4_cdna.fa));
my $seqstream1 = Bio::SeqIO->new(-file => $inputfilename, 
				 -format => 'fasta');
my $seq1 = Bio::Seq->new();
$seq1 = $seqstream1->next_seq();

$inputfilename = Bio::Root::IO->catfile(qw(t data sim4_genomic.fa));
my $seqstream2 = Bio::SeqIO->new(-file => $inputfilename, 
				 -format => 'fasta');
my $seq2 = Bio::Seq->new();
$seq2 = $seqstream2->next_seq();

my @fp = $factory->run($seq1, $seq2);


ok $fp[0]->feature1->start,4;
ok $fp[0]->feature2->start,29;
ok $fp[0]->feature1->end,18;
ok $fp[0]->feature2->end,43;
ok $fp[0]->feature1->seq->seq,'GTTGTGCTGGGGGGG',
ok $fp[0]->score,1596.49






