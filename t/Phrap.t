use strict;

# These tests will return similar warnings because of the incomplete status of
# the Phrap parser:
# --------------------- WARNING ---------------------
# MSG: Adding non-nucleotidic sequence RFPERU_003_E10.x01.phd.1
# ---------------------------------------------------  

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 127,
	       -requires_modules => [qw(Bio::Tools::Run::Phrap)]);
    use_ok('Bio::SeqIO');
}

my $assembler;
ok($assembler = Bio::Tools::Run::Phrap->new());
isa_ok($assembler, 'Bio::Tools::Run::Phrap');

ok($assembler->program_name('aaa'));
is($assembler->program_name, 'aaa');

ok($assembler->program_dir('/dir'));
is($assembler->program_dir, '/dir');

my @params = @Bio::Tools::Run::Phrap::program_params;
for my $param (@params) {
  ok($assembler->$param(321));
  is($assembler->$param(), 321);
}

my @switches = @Bio::Tools::Run::Phrap::program_switches;
for my $switch (@switches) {
  ok($assembler->$switch(1));
  is($assembler->$switch(), 1);
}

# test the program itself
my $program_name = $Bio::Tools::Run::Phrap::program_name;
ok($assembler->program_name($program_name));
SKIP: {
    test_skip(-requires_executable => $assembler,
              -tests => 39);

   # Input data
   my $result_file = 'results.phrap';
   my $fasta_file = test_input_file('sample_dataset_1.fa');
   my $qual_file  = test_input_file('sample_dataset_1.qual');
   my $io = Bio::SeqIO->new( -file => $fasta_file, -format => 'fasta' );
   my @seq_arr;
   while (my $seq = $io->next_seq) {
      push @seq_arr, $seq;
   }
   $io = Bio::SeqIO->new( -file => $qual_file, -format => 'qual' );
   my @qual_arr;
   while (my $qual = $io->next_seq) {
      push @qual_arr, $qual;
   }

   my $asm;
   ok($assembler = Bio::Tools::Run::Phrap->new());

   # Try FASTA or sequence object input
   ok($asm = $assembler->run($fasta_file));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 191);
   is($asm->get_nof_contigs, 3);

   ok($asm = $assembler->run(\@seq_arr));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 191);
   is($asm->get_nof_contigs, 3);

   # Try optional quality score input as a QUAL file or bioperl objects
   ok($asm = $assembler->run($fasta_file, $qual_file));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 191);
   is($asm->get_nof_contigs, 3);

   ok($asm = $assembler->run(\@seq_arr, \@qual_arr));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 191);
   is($asm->get_nof_contigs, 3);

   # Try the different output types
   ok($assembler->out_type($result_file));
   ok($asm = $assembler->run(\@seq_arr));
   ok($asm eq $result_file);
   is((-f $asm), 1);
   unlink $result_file;

   ok($assembler->out_type('Bio::Assembly::IO'));
   ok($asm = $assembler->run(\@seq_arr));
   isa_ok($asm, 'Bio::Assembly::IO');
   ok($asm->next_assembly);

   ok($assembler->out_type('Bio::Assembly::ScaffoldI'));
   ok($asm = $assembler->run(\@seq_arr));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 191);
   is($asm->get_nof_contigs, 3);

   # Try some Phrap specific parameters
   ok($assembler->minmatch(1000));
   ok($asm = $assembler->run(\@seq_arr));
   is($asm->get_nof_singlets, 194);
   is($asm->get_nof_contigs, 2);

   ok($assembler->minmatch(1000));
   ok($assembler->minscore(100));
   ok($asm = $assembler->run(\@seq_arr));
   is($asm->get_nof_singlets, 194);
   is($asm->get_nof_contigs, 2);

}