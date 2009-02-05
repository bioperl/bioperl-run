# -*-Perl-*-
# $id$
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;

    test_begin(-tests => 13);
    use_ok('Bio::Tools::Run::AnalysisFactory');
}


# setup global objects that are to be used in more than one test
# Also test they were initialised correctly
# test new with default access
my $factory = Bio::Tools::Run::AnalysisFactory->new();
isa_ok( $factory, 'Bio::Tools::Run::AnalysisFactory');

# test new with explicit access
$factory = Bio::Tools::Run::AnalysisFactory->new(-access=>'soap');
isa_ok( $factory, 'Bio::Tools::Run::AnalysisFactory');

# test new with non-existing access
throws_ok { Bio::Tools::Run::AnalysisFactory->new(-access=>'non_existing') } qr/cannot be found or loaded/, 'Non existant access method threw an error';

# test default factory values

# Now onto the nitty gritty tests of the modules methods
SKIP: {
    test_skip(-tests => 9, -requires_module => 'SOAP::Lite');
	use_ok('SOAP::Lite');
	
	my $array_ref = $factory->available_categories;
	isa_ok( $array_ref, 'ARRAY' );
	ok( grep(/protein/i, @$array_ref), 'available_categories returned category with protein' );
	
	$array_ref = $factory->available_analyses;
	isa_ok( $array_ref, 'ARRAY' );
	ok( grep(/seqret/i, @$array_ref), 'available_analyses returned category with seqret' );
	
	$array_ref = $factory->available_analyses('edit');
	isa_ok( $array_ref, 'ARRAY' );
	ok( grep(/seqret/i, @$array_ref), 'available_analyses("edit") returned something' );
	
	my $service;
	lives_ok {$service = $factory->create_analysis('edit.seqret')};
	skip ("create_analysis failed :$@", 1) if $@;
	isa_ok( $service, 'Bio::Tools::Run::Analysis::soap' );
}
