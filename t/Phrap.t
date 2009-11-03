#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
my $DEBUG = test_debug();
BEGIN {
   use Bio::Root::Test;
   test_begin(-tests => 108);
   use_ok('Bio::Tools::Run::Phrap');
   use_ok('Bio::SeqIO');
   use_ok('Bio::AlignIO');
   use_ok('Bio::Seq');
}

my $assembler;
ok $assembler = Bio::Tools::Run::Phrap->new();
isa_ok $assembler,'Bio::Tools::Run::Phrap';

ok($assembler->program_name('aaa'));
is($assembler->program_name, 'aaa');

ok($assembler->program_dir('/dir'));
is($assembler->program_dir, '/dir');

my @params = @Bio::Tools::Run::Phrap::phrap_params;
for my $param (@params) {
  ok($assembler->$param(321));
  is($assembler->$param(), 321);
}

my @switches = @Bio::Tools::Run::Phrap::phrap_switches;
for my $switch (@switches) {
  ok($assembler->$switch(1));
  is($assembler->$switch(), 1);
}

my $fasta_file =  test_input_file('Phrap.fa');
ok $assembler = Bio::Tools::Run::Phrap->new(
  -verbose  => $DEBUG,
  -penalty  => -3,
  -minmatch => 15
);
is $assembler->penalty(), -3;
is $assembler->minmatch(), 15;

ok $assembler = Bio::Tools::Run::Phrap->new();
$assembler->program_name('phrap');
SKIP: {
   test_skip(-requires_executable => $assembler,
             -tests => 14);
   my $asm;
   ok $asm = $assembler->run($fasta_file);
   is $asm->get_nof_singlets, 0;
   is $asm->get_nof_contigs, 1;

   foreach my $contig($asm->all_contigs){
      my $collection = $contig->get_features_collection;
      my @sf = $collection->get_all_features;
      is $sf[1]->start, 601;
      is $sf[1]->end,   963;
   }

   my $io = Bio::SeqIO->new( -file => $fasta_file );
   my @seq_arr;
   while (my $seq = $io->next_seq) {
     push @seq_arr, $seq;
   }
   ok $asm = $assembler->run(\@seq_arr);
   is $asm->get_nof_contigs, 1;

   my $result_file = 'results.phrap';
   ok($asm = $assembler->run(\@seq_arr, $result_file));
   ok($asm eq $result_file);
   is((-f $asm), 1);
   unlink $result_file;
   ok($asm = $assembler->run(\@seq_arr, 'Bio::Assembly::IO'));
   isa_ok($asm, 'Bio::Assembly::IO');
   ok($asm = $assembler->run(\@seq_arr, 'Bio::Assembly::ScaffoldI'));
   isa_ok($asm, 'Bio::Assembly::ScaffoldI');
}