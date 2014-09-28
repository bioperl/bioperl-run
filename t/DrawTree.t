# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Phylo]DrawTree');
    test_begin(-tests => 6);
	use_ok('Bio::Tools::Run::Phylo::Phylip::DrawTree');
	use_ok('Bio::TreeIO');
}

SKIP: {
	my @params = ('-verbose' => 0,
			  'quiet'    => 1);
	my $treedraw = Bio::Tools::Run::Phylo::Phylip::DrawTree->new(@params);
	test_skip(-requires_executable => $treedraw,
              -tests => 4);
	
	$treedraw->fontfile(test_input_file('fontfile'));
	my $file = $treedraw->draw_tree(test_input_file('treefile.example'));
	ok($file);
	ok(-e $file);
	
	if( test_debug() ) {
		`gs $file`;
	} else { 
		unlink($file);
	}
	
	my $intree = Bio::TreeIO->new(-file => test_input_file('treefile.example'));
	
	$file = $treedraw->draw_tree(test_input_file('treefile.example'));
	ok($file);
	ok(-e $file);
	
	if( test_debug() ) {
		`gs $file`;
	} else { 
		unlink($file);
	}
}
