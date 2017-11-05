# -*-Perl-*-
## Bioperl Test Harness Script for Modules
#

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 6);
	use_ok('Bio::Tools::Run::Phylo::Phylip::DrawGram');
	use_ok('Bio::TreeIO');	
}

SKIP: {
	my @params = ('-verbose' => test_debug(),
			  'quiet'    => 1);
	my $treedraw = Bio::Tools::Run::Phylo::Phylip::DrawGram->new(@params);
	test_skip(-requires_executable => $treedraw,
              -tests => 4);

	$treedraw->fontfile(test_input_file('fontfile'));
	
	my $file = $treedraw->draw_tree(test_input_file('treefile.example'));
	ok($file);
	ok(-e $file);
	
	if( test_debug() ) {
		`gs $file`;
	}
	unlink($file);

	my $intree = Bio::TreeIO->new(-file => test_input_file('treefile.example'));
	
	$treedraw->HORIZMARGINS(['2.00','2.5']);
	$treedraw->ANCESTRALNODES('C');
	$treedraw->TREESTYLE('PHEN');
	$treedraw->USEBRANCHLENS('N');
	
	$file = $treedraw->draw_tree(test_input_file('treefile.example'));
	
	ok($file);
	ok(-e $file);
	
	if( test_debug() ) {
		`gs $file`;
	}
	unlink($file);
}
