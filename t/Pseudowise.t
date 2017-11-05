
# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 18);
	use_ok('Bio::Tools::Run::Pseudowise');
	use_ok('Bio::Root::IO');
	use_ok('Bio::Seq');
}
my $DEBUG = test_debug();

#my @params = ('dymem', 'linear', 'kbyte', '5000','erroroffstd'=>1);
my @params = ('erroroffstd'=>1,'-verbose' => $DEBUG, 
	      quiet => $DEBUG);
my  $factory = Bio::Tools::Run::Pseudowise->new(@params);
ok($factory);

SKIP:{
	test_skip(-requires_executable => $factory,
			  -tests => 14);

	warn($factory->executable."\n") if $DEBUG; 
	isa_ok $factory, 'Bio::Tools::Run::Pseudowise';
	
	#test with one file with 3 sequences
	my $inputfilename = test_input_file("ps1.fa");
	my $seqstream = Bio::SeqIO->new(-file   => $inputfilename, 
					-format => 'fasta');
	my $seq1 = $seqstream->next_seq();
	my $seq2 = $seqstream->next_seq();
	my $seq3 = $seqstream->next_seq();

	my @feat = $factory->predict_genes($seq1, $seq2, $seq3);
	my $geneno = scalar(@feat);
	ok($geneno,1);
	my @subfeat = $feat[0]->sub_SeqFeature;
	my $exonno = scalar(@subfeat);

	is($geneno, 1);
	is($exonno, 2);
	isa_ok($feat[0],"Bio::SeqFeatureI");
	isa_ok($subfeat[0],"Bio::SeqFeatureI");
	is($feat[0]->primary_tag, 'pseudogene');
	is($subfeat[0]->primary_tag, 'exon');
	is($feat[0]->start, 163);
	is($subfeat[0]->start, 163);
	is($feat[0]->end, 626);
	is($subfeat[0]->end, 213);
	is($subfeat[1]->start,585);
	is($subfeat[1]->end, 626);
}
