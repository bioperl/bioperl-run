# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Alignment]MSAProbs');
    test_begin(-tests => 19);
	use_ok('Bio::Tools::Run::Alignment::MSAProbs');
	use_ok('Bio::Tools::GuessSeqFormat');	
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
my $factory = Bio::Tools::Run::Alignment::MSAProbs->new(@params);
is($factory->quiet, 1);
my $inputfilename = test_input_file("cysprot.fa");
my $aln;

SKIP: {
	test_skip(-requires_executable => $factory,
			  -tests => 12);
	my $version = $factory->version;
	unless ($version >= 0.94) {
		skip("Only muscle version 0.9.4 or higher is supported by these tests. Skipping tests", 7);
		exit(0);
	}
	cmp_ok ($version, '>=', 0.94, "Code tested only on msaprobs versions > 0.9.4" );
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
	is($s1_perid == 43, 1);
	
	my $annotfile = test_output_file();
	my $outfile = test_output_file();
	# add some more params
	@params = ('-quiet'           => 1,
		       '-verbose'         => 0,
	           '-outfile'         => $outfile,
		       '-iterations'      => 5,
		       '-clustalw'        => 1,
		       '-consistency'     => 2,
		       '-alignment_order' => 1,
		       '-annot_file'      => $annotfile,
	
		   );
	$factory = Bio::Tools::Run::Alignment::MSAProbs->new(@params);
	my @methods = qw(quiet verbose outfile iterations clustalw consistency
	                 alignment_order annot_file version num_threads);
	can_ok($factory, @methods);
	is($factory->annot_file, $annotfile,'annotation file');
	$aln = $factory->align($seq_array_ref);
	is $aln->num_sequences, 7;
	$s1_perid = POSIX::ceil($aln->average_percentage_identity);
	is($s1_perid == 43, 1 );
	
	my $guesser = Bio::Tools::GuessSeqFormat->new(-file => $outfile);
	my $type = $guesser->guess;
	is($type, 'clustalw', "Expected output is clustalw formatted");
	$inputfilename = test_input_file("cysprot1a.fa");
	$aln = $factory->align($inputfilename);
	is $aln->num_sequences, 3;
	$s1_perid = POSIX::ceil($aln->average_percentage_identity);
	
	is($s1_perid == 42, 1 );
}
