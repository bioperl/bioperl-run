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
   $NTESTS = 6;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Seg tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Seg;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::BioToEns::Beacon;

my $paramfile = Bio::Root::IO->catfile("","usr","users","pipeline","programs","seg_dir","seg");
my @params = ('PROGRAM',$paramfile);

my  $factory = Bio::Tools::Run::Seg->new(@params);
ok $factory->isa('Bio::Tools::Run::Seg');
my $prot_file=  Bio::Root::IO->catfile("t","data","test_prot.FastA");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file =>$prot_file, -fmt =>'Fasta');
$seq1 = $seqstream->next_seq();



my $seg_present = $factory->executable();

unless ($seg_present) {
       warn("seg  program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my @feat = $factory->predict_protein_features($seq1);

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->start, 214);
ok ($feat[0]->end, 226);
ok ($feat[0]->score, 2.26);
   

