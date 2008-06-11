# -*-Perl-*-
# $id$
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use lib 't/lib';
    use BioperlTest;

    test_begin(-tests => 12);
    use_ok('Bio::Tools::Run::AnalysisFactory');
}


 SKIP: {
     test_skip(-tests => 11, -requires_module => 'SOAP::Lite');
     use_ok('SAOP::Lite');


     # setup global objects that are to be used in more than one test
     # Also test they were initialised correctly
     # test new with default access
     my $factory = Bio::Tools::Run::AnalysisFactory->new();
     isa_ok( $factory, 'Bio::Tools::Run::AnalysisFactory');

     # test new with explicit access
     $factory = Bio::Tools::Run::AnalysisFactory->new(-access=>'soap');
     isa_ok( $factory, 'Bio::Tools::Run::AnalysisFactory');

     # test new with non-existing access
     eval {
	 $factory = Bio::Tools::Run::AnalysisFactory->new(-access=>'non_existing');
     };
     ok( $@, 'Non existant access method threw an error' );

     # test default factory values

     # Now onto the nitty gritty tests of the modules methods

     # block of tests to skip if you know the tests will fail
     # under some condition. E.g.:
     #   Need network access,
     #   Wont work on particular OS,
     #   Cant find the exectuable
     # DO NOT just skip tests that seem to fail for an unknown reason

     # condition used to skip this block of tests
     #skip($why, $how_many_in_block);
     skip("SOAP::Lite not installed, wanted to check real service(s)", 7)
	 unless use_ok('SOAP::Lite');
     
     my $array_ref = $factory->available_categories;
     isa_ok( $array_ref, 'ARRAY' );
     ok( grep(/protein/i, @$array_ref), 'available_categories returned category with protein' );
     
     $array_ref = $factory->available_analyses;
     isa_ok( $array_ref, 'ARRAY' );
     ok( grep(/seqret/i, @$array_ref), 'available_analyses returned category with seqret' );
     
     $array_ref = $factory->available_analyses('edit');
     isa_ok( $array_ref, 'ARRAY' );
     ok( grep(/seqret/i, @$array_ref), 'available_analyses("edit") returned something' );
     
     my $service = $factory->create_analysis('edit.seqret');
     isa_ok( $service, 'Bio::Tools::Run::Analysis::soap' );

}
