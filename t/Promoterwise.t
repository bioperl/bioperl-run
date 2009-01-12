#!/usr/local/bin/perl
# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 9);
	use_ok('Bio::Tools::Run::Promoterwise');
	use_ok('Bio::Seq');
}

my $verbose = -1;
my @params = ('-verbose' => test_debug(), 'silent' => 1, 'quiet' => 1);
my  $factory = Bio::Tools::Run::Promoterwise->new(@params);
isa_ok $factory,'Bio::Tools::Run::Promoterwise';

SKIP: {
	test_skip(-requires_executable => $factory,
		  -tests => 6);

	my $bequiet = 1;
	$factory->quiet($bequiet);  # Suppress pseudowise messages to terminal
	
	#test with one file with 2 sequences
	my $inputfilename = test_input_file('sim4_cdna.fa');
	my $seqstream1 = Bio::SeqIO->new(-file => $inputfilename, 
					 -format => 'fasta');
	my $seq1 = Bio::Seq->new();
	$seq1 = $seqstream1->next_seq();
	
	$inputfilename = test_input_file('sim4_genomic.fa');
	my $seqstream2 = Bio::SeqIO->new(-file => $inputfilename, 
					 -format => 'fasta');
	my $seq2 = Bio::Seq->new();
	$seq2 = $seqstream2->next_seq();
	
	my @fp = $factory->run($seq1, $seq2);
	my $first = $fp[0]->feature1;
	my $second = $fp[0]->feature2;
	
	my @sub = $first->sub_SeqFeature;
	my @sub2 = $second->sub_SeqFeature;
	
	is $sub[0]->start,4;
	is $sub2[0]->start,29;
	is $sub[0]->end,18;
	is $sub2[0]->end,43;
	is $sub[0]->seq->seq,'GTTGTGCTGGGGGGG';
	is $sub[0]->score,1596.49;
}