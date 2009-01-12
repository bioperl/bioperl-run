#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   use Bio::Root::Test;
   test_begin(-tests => 7);
   use_ok('Bio::Tools::Run::Prints');
   use_ok('Bio::SeqIO');
   use_ok('Bio::Seq');
}

my $db =  test_input_file("prints.dat");
my @params = ('DB' => $db);

my  $factory = Bio::Tools::Run::Prints->new(@params);
isa_ok $factory,'Bio::Tools::Run::Prints';
my $prot_file=  test_input_file('Prints_prot.FastA');

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
$seq1 = $seqstream->next_seq();

SKIP: {
   test_skip(-requires_executable => $factory,
              -tests => 3);
   my @feat = $factory->predict_protein_features($seq1);
   
   isa_ok $feat[0],'Bio::SeqFeatureI';
   is ($feat[0]->start,29);
   is ($feat[0]->end,53);
}

