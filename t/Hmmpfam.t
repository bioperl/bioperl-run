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
   $NTESTS = 8;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Prints tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Hmmpfam;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::Seq;

my $db =  Bio::Root::IO->catfile("t","data","pfam_sample_R11");
my @params = ('DB'=>$db,'E'=>5);


my  $factory = Bio::Tools::Run::Hmmpfam->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmpfam');
ok $factory->E, 5;
my $prot_file=  Bio::Root::IO->catfile("t","data","hmmpfam_protein_input");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
$seq1 = $seqstream->next_seq();

my $hmmpfam_present = $factory->executable();

unless ($hmmpfam_present) {
       warn("hmmpfam  program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my $searchio = $factory->predict_protein_features($seq1);

my @feat;
while (my $result = $searchio->next_result){
  while(my $hit = $result->next_hit){
    while (my $hsp = $hit->next_hsp){
      push @feat, $hsp;
    }
  }
}

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->feature1->start,25);
ok ($feat[0]->feature1->end,92);
ok ($feat[0]->feature2->start,1);
ok ($feat[0]->feature2->end,124);
 
1; 

