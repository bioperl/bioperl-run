# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Alignment]TCoffee');
    test_begin(-tests => 27);
	use_ok('Bio::Tools::Run::Alignment::TCoffee');
	use_ok('Bio::SimpleAlign');
	use_ok('Bio::AlignIO');
	use_ok('Bio::SeqIO');
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

END {     
    unlink("t_coffee.log");
}

my @params;
my  $factory = Bio::Tools::Run::Alignment::TCoffee->new(@params);

isa_ok ($factory, 'Bio::Tools::Run::Alignment::TCoffee');

my $ktuple = 3;
$factory->ktuple($ktuple);

my $new_ktuple = $factory->ktuple();
is $new_ktuple, 3, "set factory parameter";

my $what_matrix = $factory->matrix();
like $what_matrix, qr/BLOSUM/i, "get factory parameter";

my $bequiet = 1;
$factory->quiet($bequiet);  # Suppress tcoffee messages to terminal

my $inputfilename = test_input_file('cysprot.fa');
my $aln;

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 20);
	my $version = $factory->version;
	cmp_ok ($version, '>=', 1.22, "Code tested only on t_coffee versions > 1.22" );
	$aln = $factory->align($inputfilename);
	ok($aln);
	is( $aln->num_sequences, 7);
	
	my $str = Bio::SeqIO->new('-file' => 
				  test_input_file("cysprot.fa"), 
				  '-format' => 'fasta');
	my @seq_array =();
	
	while ( my $seq = $str->next_seq() ) {
		push (@seq_array, $seq) ;
	}
	
	my $seq_array_ref = \@seq_array;
	
	$aln = $factory->align($seq_array_ref);
	is $aln->num_sequences, 7;
	my $s1_perid = $aln->average_percentage_identity;
	
	my $profile1 = test_input_file("cysprot1a.msf");
	my $profile2 = test_input_file("cysprot1b.msf");
	
	# convert any warnings about program to an actual exception
	$factory->verbose(2);
	lives_ok {$aln = $factory->profile_align($profile1,$profile2)};
	skip("T-COFFEE error, skipping tests", 15) if $@; 
	is $aln->num_sequences, 7;
	
	my $str1 = Bio::AlignIO->new(-file=> test_input_file("cysprot1a.msf"));
	my $aln1 = $str1->next_aln();
	is $aln1->num_sequences, 3;
	
	my $str2 = Bio::AlignIO->new(-file=> test_input_file("cysprot1b.msf"));
	my $aln2 = $str2->next_aln();
	is $aln2->num_sequences, 4;
	
	$aln = $factory->profile_align($aln1,$aln2);
	is $aln->num_sequences, 7;
		
	$str1 = Bio::AlignIO->new(-file=> test_input_file("cysprot1a.msf"));
	$aln1 = $str1->next_aln();
	$str2 = Bio::SeqIO->new(-file=> test_input_file("cysprot1b.fa"));
	my $seq = $str2->next_seq();
	
	is $aln1->num_sequences, 3;
	is( int($aln1->average_percentage_identity), 39);
	$aln = $factory->profile_align($aln1,$seq);
	is( $aln->num_sequences, 4);
	if( $version <= 1.22 ) {
		cmp_ok( $aln->overall_percentage_identity, '>', 18);    
		is( int($aln->average_percentage_identity), 44);
	} else {
		my $overall = int($aln->overall_percentage_identity);
		ok( $overall >=21 && $overall <= 23, 'expect 21 >= val >= 23');
		my $avg = int($aln->average_percentage_identity);
		ok( $avg == 47 || $avg ==48, 'expect 47 or 48');    
	}

	# test new 'run' generic running of factory

	$aln = $factory->run('-type' => 'align',
				 '-seq'  => test_input_file("cysprot.fa"));
	is ($aln->num_sequences, 7, 'simple generic run');
	is ($aln->percentage_identity,$s1_perid); #calculated before
		
	lives_ok{ $aln = $factory->run('-type' => 'profile',
				 '-profile' => $aln1,
				 '-seq'  => test_input_file("cysprot1b.fa"))} ;
	
	skip("T-COFFEE error, skipping tests",3) if $@;
	
	is( $aln->num_sequences, 7);
	if( $version <= 1.22 ) {
		cmp_ok( $aln->overall_percentage_identity, '>', 18);
		is( int($aln->average_percentage_identity), 44);
	} else {
		my $overall = int $aln->overall_percentage_identity;
		ok($overall == 14 || $overall == 13, 'expect 13 or 14');
		my $avg = int($aln->average_percentage_identity);
		ok($avg == 41 || $avg == 42, 'expect 41 or 42');    
	}
}

END {
	# warnings are already given above, no need to keep report
	if (-e 'error_report.T-COFFEE') {
		unlink('error_report.T-COFFEE');
	}
	if (my @dnds = glob('*.dnd')) {
		for my $file (@dnds) {
			unlink($file)
		}
	}
}
