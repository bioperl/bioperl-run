# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);

$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;
BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 6);
	use_ok('Bio::Tools::Run::Phylo::Phylip::DrawTree');
	use_ok('Bio::TreeIO');
}

SKIP: {
	my @params = ('-verbose' => 0,
			  'quiet'    => 1);
	my $treedraw = Bio::Tools::Run::Phylo::Phylip::DrawTree->new(@params);
	test_skip(-required_executable => $treedraw,
              -tests => 4);
	
	$treedraw->fontfile(test_input_file('fontfile'));
	my $file = $treedraw->draw_tree(test_input_file('treefile.example'));
	ok($file);
	ok(-e $file);
	
	if( $DEBUG ) {
		`gs $file`;
	} else { 
		unlink($file);
	}
	
	my $intree = Bio::TreeIO->new(-file => test_input_file('treefile.example'));
	
	$file = $treedraw->draw_tree(test_input_file('treefile.example'));
	ok($file);
	ok(-e $file);
	
	if( $DEBUG ) {
		`gs $file`;
	} else { 
		unlink($file);
	}
}