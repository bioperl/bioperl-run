#!/usr/bin/perl
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
       skip('Unable to run SignalP tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Signalp;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::Seq;

my  $factory = Bio::Tools::Run::Signalp->new();
ok $factory->isa('Bio::Tools::Run::Signalp');


my $prot_file = Bio::Root::IO->catfile("t","data","signalp_input_protein");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file =>$prot_file, -fmt =>'Fasta');
$seq1 = $seqstream->next_seq();

my $signalp_present = $factory->executable();

unless ($signalp_present) {
       warn("signalp program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my @feat = $factory->predict_protein_features($seq1);

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->start,1);
ok ($feat[0]->end,29);
   

