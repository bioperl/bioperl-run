# -*-Perl-*-
# $Id$
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 7);
	use_ok('Bio::Tools::Run::Eponine');
	use_ok('Bio::SeqIO');
}

SKIP: {
	#Java and java version check
	my $v;
	if (-d "java") {
		diag("You must have java to run eponine");
		skip("Skipping because no java present to run eponine",5);
	}
	open(my $PIPE,"java -version 2>&1 |") || exit;

	while (<$PIPE>) { 
		if (/Java\sversion\:?\s+\"?(\d+\.\d+)\"?/i) {
		$v = $1;
			last;
		}
	}
	if ($v < 1.2) {
		diag("You need at least version 1.2 of JDK to run eponine");
		skip("Skipping due to old java version",5);
	}
	
	test_skip( -requires_env => 'EPONINEDIR', -tests => 5);
	my $inputfilename= test_input_file("eponine.fa");
	my $fact = Bio::Tools::Run::Eponine->new("threshold" => 0.999);

	is ($fact->threshold, 0.999);
	my @feats = $fact->run($inputfilename);
	is ($feats[0]->start, 69);
	is ($feats[0]->end, 69);
	is ($feats[0]->strand, 1);
	is ($feats[1]->start,178 );
}
