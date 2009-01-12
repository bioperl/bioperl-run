# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 7);

	use_ok('Bio::Tools::Run::Vista');
	use_ok('Bio::AlignIO');
}

SKIP: {
	#Java and java version check
	my $v;
	if (-d "java") {
		skip("Skipping because no java present to run vista",5);
	}
	my $output = `java -version 2>&1`;
	open(PIPE,"java -version 2>&1 |");
	
	while (<PIPE>) { 
		if (/Java\sVersion\:\s(\d+\.\d+)/) {
		$v = $1;
		last;
		}
		elsif (/java version\s.(\d+\.\d+)/) {
		$v = $1;
		last;
		}
		elsif (/java version\s\"(\d\.\d)"/) {
		 $v = $1;
			last;
		}
	}
	if ($v < 1.2) {
		skip("Skipping due to old java version",5);
	}   
	open (PIPE ,'java Vista 2>&1 |');
	while(<PIPE>){
	  if(/NoClassDefFoundError/){
		diag('Vista.jar is not in your class path');
		skip("Vista.jar is not in your class path",5);
	  }
	}
	my $inputfilename= test_input_file("vista.cls");
	my $gff_file = test_input_file("vista.gff");
	my $aio = Bio::AlignIO->new(-file=>$inputfilename,-format=>'clustalw');
	my $aln = $aio->next_aln;
	
	my $out= test_output_file();
	my $vis = Bio::Tools::Run::Vista->new('outfile'=>$out,
										  'title' => "My Vista Plot",
											'annotation'=>$gff_file,
											'annotation_format'=>'GFF',
											'min_perc_id'=>75,
											'min_length'=>100,
											'plotmin'   => 50,
											'tickdist' => 2000,
											'window'=>40,
											'numwindows'=>4,
											'start'=>50,
											'end'=>1500,
											'tickdist'=>100,
											'bases'=>1000,
											'color'=> {'EXON'=>'45 25 54','CNS'=>'0 0 100'},
											'quiet'=>1);
	isa_ok $vis,'Bio::Tools::Run::Vista';
	is $vis->plotmin, 50,
	is $vis->annotation, $gff_file;
	
	$vis->run($aln,1);
	ok -e $out;
	unlink $out;
	$vis->run($aln,'mouse');
	ok -e $out;

}
