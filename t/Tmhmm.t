#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
   eval { require Test; };
   if( $@ ) {
      use lib 't';
   }
   use Test;
   use vars qw($NTESTS);
   $NTESTS = 5;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Tmhmm tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Tmhmm;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::Seq;

# AHEM - Fugu guys, can you make sure this is genericized?

my  $factory = Bio::Tools::Run::Tmhmm->new();
ok $factory->isa('Bio::Tools::Run::Tmhmm');
exit(0) unless $factory->executable();

my $prot_file=  Bio::Root::IO->catfile("t","data","test_prot.FastA");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
$seq1 = $seqstream->next_seq();

my @feat = $factory->predict_protein_features($seq1);

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->start,121);
ok ($feat[0]->end,143);

   

