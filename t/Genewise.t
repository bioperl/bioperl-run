#!/usr/local/bin/perl
# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 20);
	use_ok('Bio::Tools::Run::Genewise');
	use_ok('Bio::Root::IO');
	use_ok('Bio::Seq');
}

my $verbose = test_debug() || -1;
my @params = ('-verbose' => $verbose, 
	      'silent' => 1, 
	      'quiet' => 1);

my $factory = Bio::Tools::Run::Genewise->new(@params);

SKIP:{
	test_skip(-requires_executable => $factory, -tests => 17);

	my $version = $factory->version;
	warn("version is $version\n") if $verbose > 0;
	isa_ok $factory,'Bio::Tools::Run::Genewise';
	
	my $bequiet = 1;
	$factory->quiet($bequiet);  # Suppress pseudowise messages to terminal
	
	#test with one file with 2 sequences
	my $inputfilename = test_input_file('road.pep');
	my $seqstream1 = Bio::SeqIO->new(-file => $inputfilename, 
					 -format => 'fasta');
	my $seq1 = Bio::Seq->new();
	$seq1 = $seqstream1->next_seq();
	
	$inputfilename = test_input_file('human.genomic');
	my $seqstream2 = Bio::SeqIO->new(-file => $inputfilename, 
					 -format => 'fasta');
	my $seq2 = Bio::Seq->new();
	$seq2 = $seqstream2->next_seq();
	
	my ($genes) = $factory->predict_genes($seq1, $seq2);
	
	my @transcripts = $genes->transcripts;
	my @feat = $transcripts[0]->exons;
	my $seqid = $feat[0]->seq_id;
	is($seqid, 'HSHNRNPA');
	my ($featpair)= $feat[0]->each_tag_value('supporting_feature');
	is($featpair->feature2->seq_id,'roa1_drome');
	is($featpair->feature1->seq_id,'HSHNRNPA');
	if( defined $version && $version eq 'wise2-2-0' ) {
		is($transcripts[0]->start, 1386);
		is($transcripts[0]->end, 3963);
		is($feat[0]->start, 1386);
		is($feat[0]->end, 1493);
		is($feat[0]->strand,1);
		is($featpair->feature2->start,26);
		is($featpair->feature2->end,61);
		is($featpair->feature2->strand,1);
		is($featpair->feature2->score,'253.10');
		is($featpair->feature1->start,1386);
		is($featpair->feature1->end,1493);
		is($featpair->feature1->strand,1);
		is($featpair->feature1->score,'253.10');
	} else {
		warn("These tests may fail because I'm not sure about your genewise version -- using wise 2.2.3-rc7 values\n");
		is($transcripts[0]->start, 1386);
		is($transcripts[0]->end, 4304);
	
		is($feat[0]->start, 1386);
		is($feat[0]->end, 1493);
		is($feat[0]->strand,1);
		is($featpair->feature2->start,26);
		is($featpair->feature2->end,61);
		is($featpair->feature2->strand,1);
		is($featpair->feature2->score,'319.10');
		is($featpair->feature1->start,1386);
		is($featpair->feature1->end,1493);
		is($featpair->feature1->strand,1);
		is($featpair->feature1->score,'319.10');
	
	}

}