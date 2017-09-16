# -*-Perl-*-
## Bioperl Test Harness Script for Modules
#

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 13);
	
	use_ok('Bio::Tools::Run::Alignment::Probalign');
	use_ok('Bio::AlignIO');
	use_ok('Bio::SeqIO');
	use_ok('Cwd', qw(cwd));
	use_ok('POSIX');
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

END {     
	unlink('probalign.log', 'probalign.out');
}

my @params = ();
my $factory = Bio::Tools::Run::Alignment::Probalign->new(@params);
my $inputfilename = test_input_file('cysprot.fa');
my $aln;

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 8);
	my $version = $factory->version;
	cmp_ok ($version, '>=', 3.3,"Code tested only on probalign versions > 3.3" );
	$aln = $factory->align($inputfilename);
	ok($aln);
	is( $aln->num_sequences, 7);
	
	my $str = Bio::SeqIO->new('-file' => $inputfilename,
				  '-format' => 'Fasta');
	my @seq_array =();
	
	while ( my $seq = $str->next_seq() ) {
		push (@seq_array, $seq) ;
	}
	
	my $seq_array_ref = \@seq_array;
	
	$aln = $factory->align($seq_array_ref);
	is $aln->num_sequences, 7;
	my $s1_perid = POSIX::ceil($aln->average_percentage_identity);
	is($s1_perid == 43 || $s1_perid == 44, 1,
	   'diff versions of PROBALIGN have different vals');
	
	my $outfile = test_output_file();
	# add some more params
	@params = ('-outfile_name'      => $outfile);
	$factory = Bio::Tools::Run::Alignment::Probalign->new(@params);
	$aln = $factory->align($seq_array_ref);
	is $aln->num_sequences, 7;
	$s1_perid = POSIX::ceil($aln->average_percentage_identity);
	is($s1_perid == 43 || $s1_perid == 44, 1,
	   'diff versions of PROBALIGN have different vals');
	
	
	$inputfilename = test_input_file("cysprot1a.fa");
	$aln = $factory->align($inputfilename);
	is $aln->num_sequences, 3;
	$s1_perid = POSIX::ceil($aln->average_percentage_identity);
	
	is($s1_perid == 41 || $s1_perid == 42, 1,
	   'diff versions of PROBALIGN have different vals');
}
