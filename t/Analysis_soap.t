# -*-Perl-*-
# $id$
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;

    test_begin(-tests => 17);
    use_ok('Bio::Tools::Run::Analysis');
    use_ok('File::Spec');
}



 SKIP: {
     test_skip(-tests => 15, -requires_module => 'SOAP::Lite');
     use_ok('SOAP::Lite');

     my $seqret = Bio::Tools::Run::Analysis->new(-name=>'edit.seqret');
     my $seq = 'tatacga';

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
	 
	 
       }
       
     }


}
