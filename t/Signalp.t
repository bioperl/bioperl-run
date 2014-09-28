#!/usr/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   use Bio::Root::Test;
   use Bio::Tools::Run::Build::Test;
   skipall_unless_feature('Signalp');
   test_begin(-tests => 7);
   use_ok('Bio::Tools::Run::Signalp');
   use_ok('Bio::SeqIO');
   use_ok('Bio::Seq');
}

my  $factory = Bio::Tools::Run::Signalp->new();
isa_ok $factory,'Bio::Tools::Run::Signalp';

my $prot_file = test_input_file("signalp_input_protein");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file =>$prot_file, -fmt =>'Fasta');
$seq1 = $seqstream->next_seq();

SKIP: {
   test_skip(-requires_executable => $factory,
          -tests => 3);
   my @feat = $factory->predict_protein_features($seq1);
   
   isa_ok $feat[0],'Bio::SeqFeatureI';
   is ($feat[0]->start,1);
   is ($feat[0]->end,29);
}
