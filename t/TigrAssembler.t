use strict;
  
BEGIN {
    use lib 't/lib';
    use BioperlTest;
    test_begin(-tests => 49,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::TigrAssembler)]);
    use_ok('Bio::SeqIO');
}

my $assembler = Bio::Tools::Run::TigrAssembler->new();
isa_ok($assembler, 'Bio::Tools::Run::TigrAssembler');

ok($assembler->program('aaaa'));
is($assembler->program, 'aaaa');

ok($assembler->program_name('asdf'));
is($assembler->program_name, 'asdf');

ok($assembler->program_dir('/dir'));
is($assembler->program_dir, '/dir');

ok($assembler->max_nof_seqs(120));
is($assembler->max_nof_seqs, 120);

ok($assembler->minimum_percent(99));
is($assembler->minimum_percent, 99);

ok($assembler->minimum_length(50));
is($assembler->minimum_length, 50);

ok($assembler->include_singlets(1));
is($assembler->include_singlets, 1);

ok($assembler->max_err_32(123));
is($assembler->max_err_32, 123);

ok($assembler->consider_low_scores(1));
is($assembler->consider_low_scores, 1);

ok($assembler->maximum_end(10));
is($assembler->maximum_end, 10);

ok($assembler->ignore_tandem_32mers(1));
is($assembler->ignore_tandem_32mers, 1);

ok($assembler->use_tandem_32mers(1));
is($assembler->use_tandem_32mers, 1);

ok($assembler->safe_merging_stop(1));
is($assembler->safe_merging_stop, 1);

ok($assembler->resort_after(100));
is($assembler->resort_after, 100);

my $fasta_file = test_input_file('sample_dataset_1.fa');
my $io = Bio::SeqIO->new( -file => $fasta_file );
my @seq_arr;
while (my $seq = $io->next_seq) {
  push @seq_arr, $seq;
}

ok($assembler = Bio::Tools::Run::TigrAssembler->new());
ok(my $asms = $assembler->run(\@seq_arr));
for my $asm (@$asms) {
  isa_ok($asm, 'Bio::Assembly::Scaffold');
  is($asm->get_nof_singlets, 0);
  is($asm->get_nof_contigs, 3);
}
ok($assembler->include_singlets(1));
ok($asms = $assembler->run(\@seq_arr));
for my $asm (@$asms) {
  is($asm->get_nof_singlets, 191);
  is($asm->get_nof_contigs, 3);
}
ok($assembler->minimum_length(1000));
ok($asms = $assembler->run(\@seq_arr));
for my $asm (@$asms) {
  is($asm->get_nof_singlets, 198);
  is($asm->get_nof_contigs, 0);
}
ok($assembler->minimum_length(1));
ok($assembler->minimum_percent(100));
ok($asms = $assembler->run(\@seq_arr));
for my $asm (@$asms) {
  is($asm->get_nof_singlets, 198);
  is($asm->get_nof_contigs, 0);
}
