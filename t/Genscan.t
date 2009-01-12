#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
#
use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 6);
	use_ok('Bio::Tools::Run::Genscan');
	use_ok('Bio::Root::IO');
}

SKIP: {
	test_skip(-requires_env => 'GENSCANDIR', -tests => 4);

	my $paramfile = Bio::Root::IO->catfile($ENV{'GENSCANDIR'},"HumanIso.smat");
	my @params = ('MATRIX',$paramfile);
	my  $factory = Bio::Tools::Run::Genscan->new(@params);
	isa_ok $factory, 'Bio::Tools::Run::Genscan';
	ok $factory->matrix;
	
	my $inputfilename = test_input_file("Genscan.FastA");
	my $seq1 = Bio::Seq->new();
	my $seqstream = Bio::SeqIO->new(-file => $inputfilename, -format => 'Fasta');
	$seq1 = $seqstream->next_seq();
	
	test_skip(-requires_executable => $factory,
			  -tests => 2);
	
	$factory->quiet(1);
	my @feat = $factory->predict_genes($seq1);
		
	my $protein = $feat[0]->predicted_protein();
	
	isa_ok $feat[0], "Bio::SeqFeatureI";
	isa_ok $protein, "Bio::PrimarySeqI";
}