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
   $NTESTS = 3;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Genscan tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Tmhmm;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::BioToEns::Beacon;

my $paramfile = Bio::Root::IO->catfile("","usr","users","pipeline","programs","TMHMM2.0b","bin","tmhmm");
my @params = ('PROGRAM',$paramfile);

my  $factory = Bio::Tools::Run::Tmhmm->new(@params);
ok $factory->isa('Bio::Tools::Run::Tmhmm');

my $prot_file=  Bio::Root::IO->catfile("data","test_prot.FastA");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
$seq1 = $seqstream->next_seq();
my $tmhmm_present = $factory->executable();

unless ($tmhmm_present) {
       warn("tmhmm program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my @feat = $factory->predict_protein_features($seq1);

ok $feat[0]->isa('Bio::SeqFeatureI');


   

