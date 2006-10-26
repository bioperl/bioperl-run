# -*-Perl-*- mode
use strict;

our $NTESTS;
our $error;

BEGIN {
    # to handle systems with no installed Test::More module
    # we include the t\lib dir (where a copy of Test::More is located)
    # as a fallback
    $error = 0;
    eval { require Test::More; };
    if( $@ ) {
		use lib 't/lib';
    }
    use Test::More;
    $NTESTS = 11;
    plan tests => $NTESTS;
}

my $actually_submit;
my $golden_outfile = 'golden.out';

END {
	if ($actually_submit) {
		unlink($golden_outfile);
	}
}

if( $error ==  1 ) {
    exit(0);
}

SKIP: {
	eval { require XML::Parser::PerlSAX;};
	skip("Need XML::Parser::PerlSAX to run test, skipping test\n",11) if $@;
	use_ok('Bio::Tools::Run::AnalysisFactory::Pise');
	use_ok('Bio::Tools::Genscan');
	use_ok('Bio::SeqIO');
	
	#exit(0);
	my $verbose = $ENV{'BIOPERLDEBUG'} || -1;
	
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
	
	$actually_submit = 1;
	
	if ($actually_submit) {
		my $job;
		eval { $job = $golden->run(); };
		skip("Problem with job submission: $@",3) if $@;
		
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
}
