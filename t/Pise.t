# -*-Perl-*- mode
use strict;

our $NTESTS;

BEGIN {
    use Bio::Root::Test;
    $NTESTS = 15;
    test_begin(-tests => $NTESTS,
	       -requires_networking => 1);
    use_ok('Bio::Tools::Run::tRNAscanSE');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $actually_submit;
my $golden_outfile = 'golden.out';

END {
	if ($actually_submit) {
		unlink($golden_outfile);
	}
}

SKIP: {
	test_skip(-tests => 11, -requires_module => 'XML::Parser::PerlSAX');
    use_ok('XML::Parser::PerlSAX');
	use_ok('Bio::Tools::Run::AnalysisFactory::Pise');
	use_ok('Bio::Tools::Genscan');
	use_ok('Bio::SeqIO');
	
	my $email;
	if( -e "t/pise-email.test" ) {
		if( open(my $T, "t/pise-email.test") ) {
			chomp($email = <$T>);
			close $T;
		} else { 
			#email not mandatory anymore, uncomment if this changes
			#print "skipping tests, cannot run without read access to testfile data";
			#exit;
		}
	}
	
	my $factory;
	
	if ($email) {
		$factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);
	} else {
		$factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
	}
	
	isa_ok($factory,'Bio::Tools::Run::AnalysisFactory::Pise');
	
	my $golden = $factory->program('golden', 
					   -db => 'genbank', 
					   -query => 'HUMRASH');
	isa_ok($golden,'Bio::Tools::Run::PiseApplication::golden');
	
	my $job;
	eval { $job = $golden->run(); };
	skip("Problem with job submission: $@",6) if $@;
	
	isa_ok($job,'Bio::Tools::Run::PiseJob');

	if ($job->error) {
		print STDERR "Error: ", $job->error_message, "\n";
	}
	
	ok(! $job->error, 'No error');

	$job->save($golden_outfile);
	ok (-e $golden_outfile, 'Save data');

	my $in = Bio::SeqIO->new ( -file   => $golden_outfile,
				   -format => 'genbank');
	my $seq = $in->next_seq();
	my $genscan = $factory->program('genscan',
					-parameter_file => "HumanIso.smat",
					);
	isa_ok($genscan,'Bio::Tools::Run::PiseApplication::genscan');

	$genscan->seq($seq);

	eval{ $job = $genscan->run(); };
	skip("Problem with job submission: $@",2) if $@;

	isa_ok($job,'Bio::Tools::Run::PiseJob');

	my $parser = Bio::Tools::Genscan->new(-fh => $job->fh('genscan.out'));
	isa_ok($parser,'Bio::Tools::Genscan');
}
