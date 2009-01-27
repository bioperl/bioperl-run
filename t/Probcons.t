# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 11);
	use_ok(' Bio::Tools::Run::Alignment::Probcons');
	use_ok(' Bio::AlignIO');
	use_ok(' Bio::SeqIO');
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

my @params = ();
my $factory = Bio::Tools::Run::Alignment::Probcons->new(@params);
my $inputfilename = test_input_file('cysprot.fa');
my $aln;

SKIP: {
	test_skip(-requires_executable => $factory,
		  -tests => 8);
	my $version = $factory->version;
	cmp_ok ($version, '>=', 1.09, "Code tested only on probcons versions > 1.09" );
	$aln = $factory->align($inputfilename);
	ok($aln);
	is( $aln->no_sequences, 7);
	
	my $str = Bio::SeqIO->new('-file' => $inputfilename,
				  '-format' => 'Fasta');
	my @seq_array =();
	
	while ( my $seq = $str->next_seq() ) {
		push (@seq_array, $seq) ;
	}
	
	my $seq_array_ref = \@seq_array;
	
	$aln = $factory->align($seq_array_ref);
	is $aln->no_sequences, 7;
	my $s1_avg_perid = $aln->average_percentage_identity;
	is(int($s1_avg_perid), 43);
	my $s1_ovl_perid = $aln->overall_percentage_identity;
	is(int($s1_ovl_perid), 15);
	
	my ($paramsfilename) = test_output_file();
	my ($annotfilename) = test_output_file();
	my ($dummyfilename) = test_output_file();
	my $factory2 = Bio::Tools::Run::Alignment::Probcons->new
		(
		 'iterative-refinement'  => '1000',
		 'consistency'   => '5',
		 'emissions' => '',
		 'verbose' => '',
		 'train'   => $paramsfilename,
		);
	$factory2->outfile_name($dummyfilename);
	
	my $aln2 = $factory2->align($seq_array_ref);
	$aln2 = '';
	$factory2 = '';
	
	$factory2 = Bio::Tools::Run::Alignment::Probcons->new
		(
		 'iterative-refinement'  => '1000',
		 'consistency'   => '5',
		 'annot'   => $annotfilename,
		 'paramfile'   => $paramsfilename,
		);
	$factory->outfile_name($dummyfilename);
	$aln2 = $factory2->align($seq_array_ref);
	my $s2_avg_perid = $aln2->average_percentage_identity;
	my $s2_ovl_perid = $aln2->overall_percentage_identity;
	cmp_ok(int($s2_avg_perid), '>=', 42);
	cmp_ok(int($s2_ovl_perid), '>=', 15);
}

END {
	if (-e 'iterative-refinement') {
		unlink('iterative-refinement');
	}
}