#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   use Bio::Root::Test;
   test_begin(-tests => 12);
   use_ok('Bio::AlignIO');
   use_ok('Bio::Tools::Run::Alignment::Lagan');
   use_ok('Bio::Root::IO');
   use_ok('Bio::SeqIO');
   use_ok('Bio::Seq');
   use_ok('Bio::Matrix::Mlagan');   
}

my $seq1 =  test_input_file("lagan_dna.fa");
my $sio = Bio::SeqIO->new(-file=>$seq1,-format=>'fasta');

my $seq = $sio->next_seq;
$seq->id("first_seq");
my $seq2= Bio::Seq->new(-id=>"second_seq",-seq=>$seq->seq);
my $seq3= Bio::Seq->new(-id=>"third_seq",-seq=>$seq->seq);

my @params =
             (
              'order' => "\"-gs -7 -gc -2 -mt 2 -ms -1\"",
              'tree' => "\"(first_seq (second_seq third_seq))\"",
              'match' => 12,
              'mismatch' => -8,
              'gapstart' => -50,
              'gapend' => -50,
              'gapcont' => -2,
         );

SKIP: {
   my  $factory = Bio::Tools::Run::Alignment::Lagan->new(@params,
                                                         -verbose => -1);
   $factory->quiet(1);
   isa_ok $factory,'Bio::Tools::Run::Alignment::Lagan';   
   test_skip(-requires_executable => $factory,
             -tests => 5,
             -requires_env => 'LAGAN_DIR');
   
   my $simple_align= $factory->lagan($seq,$seq2);
   
   isa_ok $simple_align, 'Bio::SimpleAlign';
   
   is $simple_align->percentage_identity, 100;
   
   my $multi = $factory->mlagan([$seq,$seq2,$seq3]);
   is $multi->percentage_identity, 100;
   
   my $matrix = Bio::Matrix::Mlagan->new(-values => [[qw(115 -161 -81 -161 0 -72)],
                                                     [qw(-161 115 -161 -81 0 -72)],
                                                     [qw(-81 -161 115 -161 0 -72)],
                                                     [qw(-161 -81 -161 115 0 -72)],
                                                     [qw(0 0 0 0 0 0)],
                                                     [qw(-72 -72 -72 -72 0 -72)]],
                                         -gap_open => -470,
                                         -gap_continue => -25);
   
   is $factory->nuc_matrix($matrix), $matrix;
   #*** weak test; doesn't show the supplied matrix had any effect on results...
   $multi = $factory->mlagan([$seq,$seq2,$seq3]);
   is $multi->percentage_identity, 100;
}
