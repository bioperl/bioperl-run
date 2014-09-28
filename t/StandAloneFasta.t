# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$
#

use strict;
BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Alignment]StandAloneFasta');
    test_begin(-tests => 15);
	use_ok('Bio::Tools::Run::Alignment::StandAloneFasta');
	use_ok('Bio::SeqIO');
}

my $verbose = -1;

my $version = '35';
my @params = ( 'b' =>'15', 
	       'd' => 0,
	       'O' => test_output_file(),
	       'm'=>'9',
	       "program"=>"fasta$version");
my $factory = Bio::Tools::Run::Alignment::StandAloneFasta->new
    ('-verbose' => $verbose,
     @params);
ok $factory;
my $inputfilename = test_input_file("fasta.fa");

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 12);
	my $lib = test_input_file("fastalib.fa");
	$factory->library($lib);
	my ($fastareport) = $factory->run($inputfilename);
	my $result = $fastareport->next_result;
	my $hit    = $result->next_hit();
	my $hsp    = $hit->next_hsp();
	is $hsp->algorithm, 'FASTN';
	is $hsp->num_identical, 2982;
	is $hsp->length, 2982;
	
	$factory->program_name('ssearch'.$version);
	($fastareport) = $factory->run($inputfilename);
	$result = $fastareport->next_result;
	$hit    = $result->next_hit();
	$hsp    = $hit->next_hsp();
	like $hsp->algorithm, qr/SMITH-WATERMAN|SSEARCH/;
	is $hsp->num_identical, 2982;
	is $hsp->length, 2982;
	
	$factory->program_name('fastx'.$version);
	$factory->library(test_input_file("fastaprot.fa"));
	($fastareport) = $factory->run($inputfilename);
	$result = $fastareport->next_result;
	$hit    = $result->next_hit();
	$hsp    = $hit->next_hsp();
	is $hsp->algorithm, 'FASTX';
	is $hsp->num_identical, 994;
	is $hsp->length, 994;
	
	my $sio = Bio::SeqIO->new(-file=>$inputfilename,
				  -format=>"fasta");
	my $seq = $sio->next_seq;
	
	#test with objects
	($fastareport) = $factory->run($seq);
	$result = $fastareport->next_result;
	$hit    = $result->next_hit();
	$hsp    = $hit->next_hsp();
	is $hsp->algorithm, 'FASTX';
	is $hsp->num_identical, 994;
	is $hsp->length, 994;
}

