# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = test_debug() || -1;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 14);
	use_ok('Bio::Tools::Run::Phylo::Phylip::ProtDist');
	use_ok('Bio::Tools::Run::Alignment::Clustalw');
}

my $verbose = $DEBUG;
my @params = (
	      'idlength'  =>30,
	      'model'     =>'pam',
	      'gencode'   =>'U',
	      'category'  =>'H',
	      'probchange'=>'0.4',
	      'trans'     =>'5',
	      'freq'      =>'0.25,0.5,0.125,0.125');

my $dist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);

SKIP: {
	test_skip(-requires_executable => $dist_factory,
		  -tests => 12);

	isa_ok $dist_factory,'Bio::Tools::Run::Phylo::Phylip::ProtDist';
	
	my $model = 'KIMURA';
	$dist_factory->model($model);
	
	my $new_model= $dist_factory->model();
	is $new_model , 'KIMURA', "set factory parameter";
	
	my $gencode = 'M';
	$dist_factory->gencode($gencode);
	
	my $new_gencode= $dist_factory->gencode();
	is $new_gencode, 'M', "set factory parameter";
	
	my $category= "H";
	$dist_factory->category($category);
	
	my $new_category= $dist_factory->category();
	is $new_category, "H", "set factory parameter";
	
	my $probchange= 0.4;
	$dist_factory->probchange($probchange);
	
	my $new_probchange= $dist_factory->probchange();
	is $new_probchange, 0.4, "set factory parameter";
	
	my $trans= 5;
	$dist_factory->trans($trans);
	
	my $new_trans= $dist_factory->trans();
	is $new_trans, 5, "set factory parameter";
	
	my $freq= "0.25,0.5,0.125,0.125";
	$dist_factory->freq($freq);
	
	my $new_freq= $dist_factory->freq();
	is $new_freq, "0.25,0.5,0.125,0.125", "set factory parameter";
	
	my $bequiet = 1;
	$dist_factory->quiet($bequiet);  # Suppress protpars messages to terminal 
	
	my $inputfilename = test_input_file("protpars.phy");
	my $matrix;
	
	$dist_factory->verbose($verbose);
	($matrix) = $dist_factory->create_distance_matrix($inputfilename);
	
	is(sprintf("%.3f", $matrix->get_entry('ENSP000003','SINFRUP001')),0.277);
	
	$inputfilename = test_input_file("cysprot.fa");
	@params = ('ktuple' => 2, 'matrix' => 'BLOSUM', 
		   -verbose => $verbose);
	my  $align_factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);

	SKIP: {
		test_skip(-requires_executable => $align_factory,
				  -tests => 4);
	
		my $aln = $align_factory->align($inputfilename);
		($matrix) = $dist_factory->create_distance_matrix($aln);
	
		is (int($matrix->get_entry('ALEU_HORVU','ALEU_HORVU')),0,
			"creating distance matrix");
		ok(sprintf("%.2f",$matrix->get_entry('CATL_HUMAN','CYS1_DICDI'),'1.30', "creating distance matrix"));
		
		# Test name preservation and restoration:
		$inputfilename = test_input_file("longnames.aln");
		$aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>'clustalw')->next_aln;
		my ($aln_safe, $ref_name) =$aln->set_displayname_safe(3);
		($matrix) = $dist_factory->create_distance_matrix($aln_safe);
		is (int($matrix->get_entry('S03','S03')),0, "failed creating matrix on safe names");
		ok(sprintf("%.4f",$matrix->get_entry('S01','S02'),'0.0205', "failed creating distance matrix"));
	}
}

