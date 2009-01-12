#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   use Bio::Root::Test;
   test_begin(-tests => 8);
   use_ok('Bio::Tools::Run::Seg');
   use_ok('Bio::SeqIO');
   use_ok('Bio::Seq');
}

my  $factory = Bio::Tools::Run::Seg->new();
isa_ok $factory, 'Bio::Tools::Run::Seg';
my $prot_file=  test_input_file('test_prot.FastA');

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file =>$prot_file, -fmt =>'Fasta');
$seq1 = $seqstream->next_seq();

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 4);
   
   my @feat = $factory->predict_protein_features($seq1);
   
   isa_ok $feat[0],'Bio::SeqFeatureI';
   is ($feat[0]->start, 214);
   is ($feat[0]->end, 226);
   is ($feat[0]->score, 2.26);
   
}
