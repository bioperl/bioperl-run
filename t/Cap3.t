use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 22,
	       -requires_modules => [qw(Bio::Tools::Run::Cap3)]);
    use_ok('Bio::SeqIO');
}

my $assembler = Bio::Tools::Run::Cap3->new();
isa_ok($assembler, 'Bio::Tools::Run::Cap3');

ok($assembler->program_name('aaa'));
is($assembler->program_name, 'aaa');

ok($assembler->program_dir('/dir'));
is($assembler->program_dir, '/dir');

ok($assembler->y(150));
is($assembler->y, 150);

### there are more interfaces to test a..z

# test the program itself
$assembler->program_name('cap3');
SKIP: {
    test_skip(-requires_executable => $assembler,
              -tests => 14);

  ok($assembler = Bio::Tools::Run::Cap3->new());

  my $fasta_file = test_input_file('sample_dataset_1.fa');
  my $file_clean = test_input_file('sample_dataset_1_clean.fa');
  my $io = Bio::SeqIO->new( -file => $fasta_file );
  my @seq_arr;
  while (my $seq = $io->next_seq) {
    push @seq_arr, $seq;
  }

  my $asm;
  ok($asm = $assembler->run(\@seq_arr));

  my $result_file = 'results.ace';
  ok($asm = $assembler->run(\@seq_arr, $result_file));
  ok($asm eq $result_file);
  is((-f $asm), 1);

  ok($asm = $assembler->run(\@seq_arr, 'Bio::Assembly::IO'));
  isa_ok($asm, 'Bio::Assembly::IO');
  ok($asm = $assembler->run(\@seq_arr, 'Bio::Assembly::ScaffoldI'));
  isa_ok($asm, 'Bio::Assembly::ScaffoldI');

  ok($asm = $assembler->run(\@seq_arr));
  isa_ok($asm, 'Bio::Assembly::ScaffoldI');
  is($asm->get_nof_singlets, 0);
  is($asm->get_nof_contigs, 3);

  remove_linefeeds($fasta_file, $file_clean);
  ok($asm = $assembler->run($file_clean));
  unlink $file_clean;
}

sub remove_linefeeds {
  my ($infile, $outfile) = @_;
  open my $in,  '<', $infile or die "Could not read file $infile: $!\n";
  open my $out, '>', $outfile or die "Could not read file $$outfile: $!\n";
  while ( my $line = <$in> ) { $line =~ s/\r//g; print $out $line; };
  close $in;
  close $out;
  return 1;
}