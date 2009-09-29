# -*-Perl-*-
# $id$
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
  use Bio::Root::Test;
  test_begin(-tests => 45);
  
  use_ok('Bio::Tools::Run::Alignment::Clustalw');
  use_ok('Bio::SimpleAlign');
  use_ok('Bio::AlignIO');
  use_ok('Bio::SeqIO');
  use_ok('File::Spec');
}


# setup input files etc
my $inputfilename = test_input_file("cysprot.fa");
ok( -e $inputfilename, 'Found input file' );
my $profile1 = test_input_file('cysprot1a.msf');
ok( -e $profile1, 'Found profile1 file' );
my $profile2 = test_input_file('cysprot1b.msf');
ok( -e $profile2, 'Found profile2 file' );
my $outfile = test_output_file();

# setup global objects that are to be used in more than one test
# Also test they were initialised correctly
my @params = ('ktuple' => 3, 'quiet'  => 1);

my $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
isa_ok( $factory, 'Bio::Tools::Run::Alignment::Clustalw');
$factory->outfile($outfile);

# test default factory values
is( $factory->program_dir, $ENV{'CLUSTALDIR'}, 'program_dir returned correct default' );
is( $factory->error_string, '', 'error_string returned correct default' );
is( $factory->outfile_name, 'mlc', 'outfile_name returned correct default' );
is( $factory->bootstrap, undef, 'bootstrap returned correct default' );

# Now onto the nitty gritty tests of the modules methods
is( $factory->program_name(), 'clustalw',                'Correct exe default name' );

SKIP: {
  test_skip(-requires_executable => $factory,
            -tests => 19);  
  
  # test all factory methods dependent on finding the executable
  # TODO: isnt( $factory->program_dir, undef,               'Found program in an ENV variable' );
  my $ver = $factory->version || 0;
  
  # remove last bit 
  $ver =~ s{^(\d+\.\d+)\.\d+}{$1};
  
  # clustalw2 isn't supported yet.
  if ($ver < 1.8) {
    diag("ClustalW version $ver not supported");
    skip("ClustalW version $ver not supported", 19);
  }
  if ($ver >= 2.0) {
    diag("Warning: ClustalW version $ver not supported yet.");
    skip("ClustalW version $ver not supported yet", 19);
  }
  
  ok( $ver, "Supported program version $ver" );
  
  # test execution using filename
  my $aln = $factory->align($inputfilename);
  
  # now test the factory error methods etc
  is( $factory->error_string, '',                          'No error occured' );
  isnt( $factory->outfile_name, undef,                     'outfile_name returned something' );
  
  # now test its output
  isa_ok( $aln, 'Bio::SimpleAlign');
  is( $aln->no_sequences, 7,                               'Correct number of seqs returned' );
  is $aln->score, 16047, 'Score';
  
  # test execution using an array of Seq objects
  my $str = Bio::SeqIO->new('-file' => $inputfilename, '-format' => 'Fasta');
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
  
  # test the run method
  ($aln, $tree) = $factory->run(\@seq_array);
  isa_ok($aln, 'Bio::SimpleAlign');
  isa_ok($tree, 'Bio::Tree::Tree');
  
  ($aln, $tree) = $factory->run($inputfilename);
  isa_ok($aln, 'Bio::SimpleAlign');
  isa_ok($tree, 'Bio::Tree::Tree');  
  
  # test the footprint method
  my @seqs = (Bio::Seq->new(-seq => 'AACCTGGCCAATTGGCCAATTGGGCGTACGTACGT', -id => 'rabbit'),
	      Bio::Seq->new(-seq => 'ACCCTGGCCAATTGGCCAATTGTAAGTACGTACGT', -id => 'marmot'),
	      Bio::Seq->new(-seq => 'AAGCTGGCCAATTGGCCAATTAGACTTACGTACGT', -id => 'chimp'),
	      Bio::Seq->new(-seq => 'AACATGGCCAATTGGCCAATCGGACGTACGTCCGT', -id => 'human'),
	      Bio::Seq->new(-seq => 'AACCGGGCCAATTGGCCAAGTGGACGTACGTATGT', -id => 'cebus'),
	      Bio::Seq->new(-seq => 'AACCTAGCCAATTGGCCACTTGGACGTACGTACAT', -id => 'gorilla'),
	      Bio::Seq->new(-seq => 'AACCTGCCCAATTGGCCGATTGGACGTACGTACGC', -id => 'orangutan'),
	      Bio::Seq->new(-seq => 'AACCTGGGCAATTGGCAAATTGGACGTACGTACGT', -id => 'baboon'),
	      Bio::Seq->new(-seq => 'AACCTGGCTAATTGGTCAATTGGACGTACGTACGT', -id => 'rhesus'),
	      Bio::Seq->new(-seq => 'AACCTGGCCGATTGGCCAATTGGACGTACGTACGT', -id => 'squirrelmonkey'));
  my @results = $factory->footprint(\@seqs);
  @results = map { $_->consensus_string } @results;
  is_deeply(\@results, [qw(ATTGG TACGT)], 'footprinting worked');
  
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
	
    $str2 = Bio::SeqIO->new(-file=> test_input_file("cysprot1b.fa"));
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

