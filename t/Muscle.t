# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 16);
	use_ok('Bio::Tools::Run::Alignment::Muscle');
	use_ok('Bio::AlignIO');
	use_ok('Bio::SeqIO');
	use_ok('Bio::Root::IO');
	use_ok('POSIX');	
}

END {     
	unlink('muscle.log', 'muscle.out');
	unlink qw(cysprot.dnd cysprot1a.dnd);
}

my @params = ('quiet' => 1);
my $factory = Bio::Tools::Run::Alignment::Muscle->new(@params);
is($factory->quiet, 1);
my $inputfilename = test_input_file("cysprot.fa");
my $aln;

SKIP: {
	test_skip(-requires_executable => $factory,
			  -tests => 10);
	my $version = $factory->version;
	unless ($version >= 3.6) {
		skip("Only muscle version 3.6 or higher is supported by these tests. Skipping tests", 7);
		exit(0);
	}
	cmp_ok ($version, '>=', 3.6, "Code tested only on muscle versions > 3.6" );
	$aln = $factory->align($inputfilename);
	ok($aln);
	is( $aln->num_sequences, 7);

	my $str = Bio::SeqIO->new('-file' => 
				  test_input_file("cysprot.fa"), 
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
	   'diff versions of MUSCLE have different vals');
	
	my $logfile = test_output_file();
	my $outfile = test_output_file();
	# add some more params
	@params = ('quiet'    => 1,
		   '-outfile_name'      => $outfile,
		   'diags'    => 1,
		   'stable'   => 1,
		   'maxmb'    => 50,
		   'maxhours' => 1,
		   'maxiters' => 20,
		   'log'      => $logfile,
	
		   );
	$factory = Bio::Tools::Run::Alignment::Muscle->new(@params);
	is($factory->log, $logfile,'log file');
	$aln = $factory->align($seq_array_ref);
	is $aln->num_sequences, 7;
	$s1_perid = POSIX::ceil($aln->average_percentage_identity);
	is($s1_perid == 43 || $s1_perid == 44, 1,
	   'diff versions of MUSCLE have different vals');
	
	$inputfilename = test_input_file("cysprot1a.fa");
	$aln = $factory->align($inputfilename);
	is $aln->num_sequences, 3;
	$s1_perid = POSIX::ceil($aln->average_percentage_identity);
	
	is($s1_perid == 41 || $s1_perid == 42, 1,
	   'diff versions of MUSCLE have different vals');
}
