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
       skip('Unable to run Prints tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Prints;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::BioToEns::Beacon;

my $paramfile = Bio::Root::IO->catfile("","usr","users","pipeline","programs","FingerPRINTScan");
#my $db =  Bio::Root::IO->catfile("","data0","prints35_0.pval_blos62");
my $db =  Bio::Root::IO->catfile("t","data","prints.dat");
my @params = ('DB',$db,'PROGRAM',$paramfile);

my  $factory = Bio::Tools::Run::Prints->new(@params);
ok $factory->isa('Bio::Tools::Run::Prints');
my $prot_file=  Bio::Root::IO->catfile("t","data","Prints_prot.FastA");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
$seq1 = $seqstream->next_seq();



my $prints_present = $factory->executable();

unless ($prints_present) {
       warn("prints program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my @feat = $factory->predict_protein_features($seq1);

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->start,29);
ok ($feat[0]->end,53);

   

