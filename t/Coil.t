#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   use lib '.';
   use Bio::Root::Test;
   test_begin(-tests => 6);

   use_ok('Bio::Tools::Run::Coil');
   use_ok('Bio::SeqIO');
}

SKIP: {
   my  $factory = Bio::Tools::Run::Coil->new();
   test_skip(-requires_executable => $factory,
             -requires_env => 'COILSDIR',
             -tests => 4);
   ok $factory->isa('Bio::Tools::Run::Coil');

   my $prot_file=  Bio::Root::IO->catfile("t","data","coil_protein_input");

   my $seq1 = Bio::Seq->new();
   my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
   $seq1 = $seqstream->next_seq();

   my $coil_present = $factory->executable();
   unless ($coil_present) {
      skip("coil program not found", 3);
   }

   $factory->quiet(1);
   my @feat = $factory->predict_protein_features($seq1);
   
   ok $feat[0]->isa('Bio::SeqFeatureI');
   ok ($feat[0]->start,71);
   ok ($feat[0]->end,91);
}