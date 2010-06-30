# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 8);
	use_ok('Bio::Tools::Run::Alignment::Kalign');
	use_ok('Bio::AlignIO');
	use_ok('Bio::SeqIO');	
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

my @params = ();
my $factory = Bio::Tools::Run::Alignment::Kalign->new(@params);
my $inputfilename = test_input_file("cysprot.fa");
my $aln;

SKIP: {
	test_skip(-requires_executable => $factory, -tests => 5);
	my $version = $factory->version;
	is($version >= 2, 1, "Code tested only on kalign versions >= 2" );
	$aln = $factory->align($inputfilename);
	ok($aln);
	is( $aln->num_sequences, 7);
	
	my $str = Bio::SeqIO->new('-file' => test_input_file("cysprot.fa"), 
				  '-format' => 'Fasta');
	my @seq_array =();
	
	while ( my $seq = $str->next_seq() ) {
		push (@seq_array, $seq) ;
	}
	
	my $seq_array_ref = \@seq_array;
	
	$aln = $factory->align($seq_array_ref);
	is $aln->num_sequences, 7;
	my $s1_perid = $aln->average_percentage_identity;
	is(int($s1_perid), 42);
}

