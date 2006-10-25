# -*-Perl-*-
# $id$
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
  # Things to do ASAP once the script is run
  # even before anything else in the file is parsed
  #use vars qw($NUMTESTS $DEBUG $error);
  #$DEBUG = $ENV{'BIOIPERLDEBUG'} || 0;
  
  # Use installed Test module, otherwise fall back
  # to copy of Test.pm located in the t dir
  eval { require Test::More; };
  if ( $@ ) {
    use lib 't/lib';
  }

  # Currently no errors
  #$error = 0;

  # Setup Test::More and plan the number of tests
  use Test::More tests=>12;
  
  # Use modules that are needed in this test that are from
  # any of the Bioperl packages: Bioperl-core, Bioperl-run ... etc
  # use_ok('<module::to::use>');
  use_ok('Bio::Tools::Run::AnalysisFactory');
  #use_ok('File::Spec');
}

END {
  # Things to do right at the very end, just
  # when the  interpreter finishes/exits
  # E.g. deleting intermediate files produced during the test
  
  #foreach my $file ( qw(cysprot.dnd cysprot1a.dnd) ) {
  #  unlink $file;
  #  # check it was deleted
  #  ok( ! -e $file, 'Expected temp file deleted' );
  #}
}

# setup input files etc
# none in this test

# setup output files etc
# none in this test

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
SKIP: {
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


