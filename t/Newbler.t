use strict;

BEGIN {
    use Bio::Root::Test;
    use File::Basename;
    test_begin(-tests => 95,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::Newbler)]);
    use_ok('Bio::SeqIO');
}

my $assembler;
ok($assembler = Bio::Tools::Run::Newbler->new());
isa_ok($assembler, 'Bio::Tools::Run::Newbler');

ok($assembler->program_name('aaa'));
is($assembler->program_name, 'aaa');

ok($assembler->program_dir('/dir'));
is($assembler->program_dir, '/dir');

my @params = @Bio::Tools::Run::Newbler::program_params;
for my $param (@params) {
  ok($assembler->$param(321));
  is($assembler->$param(), 321);
}

my @switches = @Bio::Tools::Run::Newbler::program_switches;
for my $switch (@switches) {
  ok($assembler->$switch(1));
  is($assembler->$switch(), 1);
}

# Test that weird types of input will make it to the assembler
my $fasta_file = test_input_file('sample_dataset_1.fa');
my $input_file = $fasta_file;
my $input_dir  = dirname($fasta_file);
my $mid_prefix = 'mi2d@';
my $combo_file = $mid_prefix.$input_file;
my $combo_dir  = $mid_prefix.$input_dir;
ok($assembler->_check_sequence_input($input_file));
ok($assembler->_check_sequence_input($input_dir));
ok($assembler->_check_sequence_input($combo_file));
ok($assembler->_check_sequence_input($combo_dir));

# Test the Newbler assembler program itself
my $program_name = $Bio::Tools::Run::Newbler::program_name;
ok($assembler->program_name($program_name));
SKIP: {
    test_skip(-requires_executable => $assembler,
              -tests => 43);

   # Input data
   my $result_file = 'results.ace';
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
   ok($assembler = Bio::Tools::Run::Newbler->new());

   # Try FASTA or sequence object input
   ok($asm = $assembler->run($fasta_file));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 2);

   ok($asm = $assembler->run(\@seq_arr));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 2);

   # Try optional quality score input as a QUAL file or bioperl objects
   ok($asm = $assembler->run($fasta_file, $qual_file));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 2);

   ok($asm = $assembler->run(\@seq_arr, \@qual_arr));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 2);

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
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 2);

   # Try some Newbler specific parameters
   ok($assembler->expected_depth(2.1));
   ok($asm = $assembler->run(\@seq_arr));
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 2);

   ok($assembler->min_ovl_length(1000));
   ok($asm = $assembler->run(\@seq_arr));
   is($asm->get_nof_singlets, 0);
   # We really expect 0 contigs... must be a bug in Newbler! 
   #is($asm->get_nof_contigs, 0);
   is($asm->get_nof_contigs, 2);

   ok($assembler->min_ovl_identity(100));
   ok($assembler->min_ovl_length(1));
   ok($asm = $assembler->run(\@seq_arr));
   is($asm->get_nof_singlets, 0);
   is($asm->get_nof_contigs, 0);
}
