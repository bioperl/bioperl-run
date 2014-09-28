#-*-Perl-*-
# $id$
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   use Bio::Root::Test;
   use Bio::Tools::Run::Build::Test;
   skipall_unless_feature('Tmhmm');
   test_begin(-tests => 9);
   use_ok('Bio::Tools::Run::Tmhmm');
   use_ok('Bio::SeqIO');
}

# AHEM - Fugu guys, can you make sure this is genericized?

my $factory = Bio::Tools::Run::Tmhmm->new();
isa_ok $factory,'Bio::Tools::Run::Tmhmm';
SKIP:{
   test_skip(-requires_executable => $factory,
             -tests => 6);
   my $prot_file=  test_input_file("test_prot.FastA");
   ok(-e $prot_file);
   
   my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
   my $seq1 = $seqstream->next_seq();
   isa_ok( $seq1,'Bio::Seq');
   my @feat = $factory->run($seq1);
   is @feat, 5;
   
   isa_ok $feat[0],'Bio::SeqFeatureI';
   is ($feat[0]->start,121);
   is ($feat[0]->end,143);
}
