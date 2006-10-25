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
  use Test::More tests=>39;
  
  # Use modules that are needed in this test that are from
  # any of the Bioperl packages: Bioperl-core, Bioperl-run ... etc
  # use_ok('<module::to::use>');
  use_ok('Bio::Tools::Run::Alignment::Clustalw');
  use_ok('Bio::SimpleAlign');
  use_ok('Bio::AlignIO');
  use_ok('Bio::SeqIO');
  use_ok('File::Spec');
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
my $inputfilename = File::Spec->catfile("t","data","cysprot.fa");
ok( -e $inputfilename, 'Found input file' );
my $profile1 = File::Spec->catfile('t','data','cysprot1a.msf');
ok( -e $profile1, 'Found profile1 file' );
my $profile2 = File::Spec->catfile('t','data','cysprot1b.msf');
ok( -e $profile2, 'Found profile2 file' );

# setup output files etc
# none in this test

# setup global objects that are to be used in more than one test
# Also test they were initialised correctly
my @params = (
         'ktuple' => 3,
	 'quiet'  => 1,
	 #-verbose => $verbose,
);
my $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
isa_ok( $factory, 'Bio::Tools::Run::Alignment::Clustalw');

# test default factory values
is( $factory->program_dir, undef,                        'program_dir returned correct default' );
is( $factory->error_string, '',                          'error_string returned correct default' );
is( $factory->outfile_name, 'mlc',                       'outfile_name returned correct default' );
is( $factory->bootstrap, undef,                          'bootstrap returned correct default' );

# Now onto the nitty gritty tests of the modules methods
is( $factory->program_name(), 'clustalw',                'Correct exe default name' );

# block of tests to skip if you know the tests will fail
# under some condition. E.g.:
#   Need network access,
#   Wont work on particular OS,
#   Cant find the exectuable
# DO NOT just skip tests that seem to fail for an unknown reason
SKIP: {
  # condition used to skip this block of tests
  #skip($why, $how_many_in_block);
  skip("Couldn't find the executable", 13)
    unless defined $factory->executable();
  
  # test all factory methods dependent on finding the executable
  # TODO: isnt( $factory->program_dir, undef,               'Found program in an ENV variable' );
  ok( $factory->version >= 1.8,                             'Correct minimum program version' );
  
  # test execution using filename
  my $aln = $factory->align($inputfilename);
  
  # now test the factory error methods etc
  is( $factory->error_string, '',                          'No error occured' );
  isnt( $factory->outfile_name, undef,                     'outfile_name returned something' );
  
  # now test its output
  isa_ok( $aln, 'Bio::SimpleAlign');
  is( $aln->no_sequences, 7,                               'Correct number of seqs returned' );
  
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
  is( $aln->no_sequences, 7,                            'Correct number of seqs returned' );

  # Use this alignment to fully test the methods
  {
    my $i=1;
    for my $seq ( $aln->each_seq ) {
      last if( $seq->display_id =~ /CATH_HUMAN/ );
      $i++;
    }
    is( $aln->get_seq_by_pos($i)->get_nse, 'CATH_HUMAN/1-335',  'Got correct sequence by position' );
  }

  # test doing a bootstrap tree
  my $tree = $factory->tree($aln);
  isa_ok( $tree, 'Bio::Tree::Tree' );
  
  # now test doing profile alignments
  $aln = $factory->profile_align($profile1,$profile2);
  isa_ok( $aln, 'Bio::SimpleAlign' );
  is( $aln->no_sequences, 7,                            'Correct number of seqs returned' );
  
  SKIP: {
	# TODO: Is this needed, or should min version be bumped to > 1.82. Discuss with module author
    # keeping this to be compatible with older t/Clustalw.t
    skip("clustalw 1.81 & 1.82 contain a profile align bug", 2) unless $factory->version > 1.82;
	
	my $str1 = Bio::AlignIO->new(-file=> $profile1);
    my $aln1 = $str1->next_aln();
    my $str2 = Bio::AlignIO->new(-file=> $profile2);
    my $aln2 = $str2->next_aln();
      
    $aln = $factory->profile_align($aln1,$aln2);
    is($aln->get_seq_by_pos(2)->get_nse, 'CATH_HUMAN/1-335', 'Got correct sequence by position');
	
    $str2 = Bio::SeqIO->new(-file=> Bio::Root::IO->catfile("t","data","cysprot1b.fa"));
    my $seq = $str2->next_seq();
    $aln = $factory->profile_align($aln1,$seq);
    is($aln->get_seq_by_pos(2)->get_nse,  'CATH_HUMAN/1-335', 'Got correct sequence by position');
  }
}

# TODO: Test factory methods that change parameters
#TODO: {
#  local $TODO = "program_name setting not finished";
#  $factory->program_name('something_silly');
#  is( $factory->program_name, 'something_silly',         'Set and got program_name correctly' );
#}
$factory->ktuple(4);
is( $factory->ktuple, 4,                                 'Set and got ktuple correctly' );
$factory->topdiags(10);
is( $factory->topdiags, 10,                              'Set and got topdiags correctly' );
$factory->window(10);
is( $factory->window, 10,                                'Set and got window correctly' );
$factory->pairgap(10);
is( $factory->pairgap, 10,                               'Set and got pairgap correctly' );
$factory->fixedgap(20);
is( $factory->fixedgap, 20,                              'Set and got fixedgap correctly' );
$factory->floatgap(16);
is( $factory->floatgap, 16,                              'Set and got floatgap correctly' );
$factory->matrix('PAM250');
is( $factory->matrix, 'PAM250',                          'Set and got matrix correctly' );
$factory->type('protein');
is( $factory->type, 'protein',                           'Set and got type correctly' );
$factory->output('PIR');
is( $factory->output, 'PIR',                             'Set and got output correctly' );
$factory->outfile('odd_name.out');
is( $factory->outfile, 'odd_name.out',                   'Set and got outfile correctly' );
$factory->quiet(0);
is( $factory->quiet, 0,                                  'set and got quiet correctly' );
$factory->bootstrap(100);
is( $factory->bootstrap, 100,                            'set and got bootstrap correctly' );

