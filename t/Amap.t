# -*-Perl-*-


use strict;

BEGIN { 
  use Bio::Root::Test;
  test_begin(-tests => 18);
  
  use_ok('Bio::Tools::Run::Alignment::Amap');
  use_ok('Bio::SeqIO');
  use_ok('File::Spec');
}

END {
  # Things to do right at the very end, just
  # when the  interpreter finishes/exits
  # E.g. deleting intermediate files produced during the test
  foreach my $file ( qw(cysprot.dnd cysprot1a.dnd mlc) ) {
    unlink $file;
  }
}

# if we got to here, thats OK!
# is this really needed?
#ok( 1, 'All the required modules are present');

# setup input files etc
my $inputfilename = test_input_file("cysprot.fa");
ok( -e $inputfilename, 'Found input file' );

# setup output files etc
# none in this test

# setup global objects that are to be used in more than one test
# Also test they were initialised correctly
my @params = ();
my $factory = Bio::Tools::Run::Alignment::Amap->new(@params);
isa_ok( $factory, 'Bio::Tools::Run::Alignment::Amap');

# test factory default values
is( $factory->program_dir, undef,                        'program_dir returned correct default' );
is( $factory->error_string, '',                          'error_string returned correct default' );
is( $factory->aformat, 'fasta',                          'aformat returned correct default' );
is( $factory->outfile_name, 'mlc',                       'outfile_name returned correct default' );

# Now onto the nitty gritty tests of the modules methods
is( $factory->program_name(), 'amap',                    'Correct exe default name' );

# block of tests to skip if you know the tests will fail
# under some condition. E.g.:
#   Need network access,
#   Wont work on particular OS,
#   Cant find the exectuable
# DO NOT just skip tests that seem to fail for an unknown reason

SKIP: {
  # condition used to skip this block of tests
  #skip($why, $how_many_in_block);
  test_skip(-requires_executable => $factory,
			-tests => 8);

  # test all factory methods that depend on the executable
  # TODO: isnt( $factory->program_dir, undef,              'program found in ENV variable' );
  ok( $factory->version >= 2.0,                            'Correct minimum program version' );
  
  # test execution using filename
  my $aln = $factory->align($inputfilename);
  
  # now test the factory error methods etc
  is( $factory->error_string, '',                          'No error occured' );
  isnt( $factory->outfile_name, undef,                     'outfile_name returned something' );
  
  # now test its output
  isa_ok( $aln, 'Bio::SimpleAlign');
  is( $aln->num_sequences, 7,                               'Correct number of seqs returned' );
  
  # test execution using an array of Seq objects
  my $str = Bio::SeqIO->new(
                        '-file' => $inputfilename,
			'-format' => 'Fasta',
  );
  my @seq_array =();
  while ( my $seq = $str->next_seq() ) {
    push (@seq_array, $seq) ;
  }
  $aln = $factory->align(\@seq_array);
  # now test its output
  isa_ok( $aln, 'Bio::SimpleAlign');
  is( $aln->num_sequences, 7,                            'Correct number of seqs returned' );

  # Use this alignment to fully test the methods
  is( int($aln->average_percentage_identity), 45,       'Got the correct ave % identity' );
  
}

# TODO: test factory methods that change parameters
#TODO: {
#  local $TODO = 'program_name setting is unfinished';
#  $factory->program_name('something_silly');
#  is( $factory->program_name, 'something_silly',        'Set and got program_name correctly') ;
#}

