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
  use Test::More tests=>17;
  
  # Use modules that are needed in this test that are from
  # any of the Bioperl packages: Bioperl-core, Bioperl-run ... etc
  # use_ok('<module::to::use>');
  use_ok('Bio::Tools::Run::Analysis');
  use_ok('File::Spec');
  use_ok('Data::Dumper');
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
# none in the test

# setup output files etc
# none in this test

# setup global objects that are to be used in more than one test
# Also test they were initialised correctly
# check new with default access
my $seqret = Bio::Tools::Run::Analysis->new(-name=>'edit.seqret');
my $seq = 'tatacga';

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
  skip("Failed to create the analysis object", 1)
    unless isa_ok( $seqret, 'Bio::Tools::Run::Analysis::soap');
  
  # test seqret service with some testing data
  # TODO: use BIOPERLDEBUG to skip these tests
  my %input = (
    'sequence_direct_data' => $seq,
    'osformat'             => 'raw',
  );
  is( $seqret->analysis_name, 'seqret',                    'analysis_name returned seqret' );
  isa_ok( $seqret->analysis_spec, 'HASH');
  
  my $input_spec = $seqret->input_spec;
  isa_ok( $input_spec, 'ARRAY' );
  ok( @$input_spec > 0,                                          'input_spec returned an array with something in it' );
  isa_ok( $input_spec->[0], 'HASH' );
  my $result_spec = $seqret->result_spec;
  isa_ok( $result_spec, 'ARRAY' );
  ok( @$result_spec > 0,                                          'result_spec returned an array with something in it' );
  like( $seqret->describe, '/^<\?xml /',                          'describe seems to have returned the correct thing' );
  my $job = $seqret->create_job (\%input);

  SKIP: {
    skip("Object not created correctly", 6)
      unless isa_ok( $job, 'Bio::Tools::Run::Analysis::Job' );

    is( $job->status, 'CREATED',                                  'Job status correct' );
    # TODO: not goot to use private methods
    my $cloned_job = $seqret->create_job ($job->{'_id'});
    
    SKIP: {
      skip( "Couldn't clone the job", 2 )
        unless isa_ok( $cloned_job, 'Bio::Tools::Run::Analysis::Job',   'Job cloned successfully' );
      
      like( $cloned_job->last_event, '/^<\?xml /',                      'last_event seems to have returned the correct thing' );
      $cloned_job->remove;
      # TODO: not good to use private methods
      is( $cloned_job->{'_destroy_on_exit'}, 1,                         'Cloned job removed successfully' );
    }
    
    # TODO: Not sure what this is doing/testing:
    #print sprintf ($format, 'checking "detailed_status" ');
    #skip ($serror, eval { ${ $job->results ('detailed_status') }{'detailed_status'} == 0 });
    #&print_error;
    #
    #print sprintf ($format, 'checking "report" ');
    #skip ($serror, eval { ${ $job->results ('report') }{'report'} =~ /successfully/i });
    #&print_error;
    #
    #print sprintf ($format, 'checking "outseq" ');
    #skip ($serror, eval { ${ $job->results ('outseq') }{'outseq'} =~ /^$seq$/ });
    #&print_error;
    
  }
  
}


