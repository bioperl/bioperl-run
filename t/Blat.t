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
   $NTESTS = 7;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Blat  tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Blat;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::Seq;

my $db =  Bio::Root::IO->catfile("t","data","blat_dna.fa");

my $query = Bio::Root::IO->catfile("t","data","blat_dna.fa");    

my  $factory = Bio::Tools::Run::Blat->new();
ok $factory->isa('Bio::Tools::Run::Blat');

my $blat_present = $factory->executable();

unless ($blat_present) {
       warn("blat  program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my @feat = $factory->align($db,$query);

ok $feat[0]->isa('Bio::SeqFeatureI');
my @sub_feat = $feat[0]->get_SeqFeatures;

ok ($sub_feat[0]->feature1->start,1);
ok ($sub_feat[0]->feature1->end,1775);
ok ($sub_feat[0]->feature2->start,1);
ok ($sub_feat[0]->feature2->end,1775);
 
1; 

