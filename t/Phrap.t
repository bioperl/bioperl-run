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
       skip('Unable to run Phrap tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Phrap;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Seq;

my $input =  Bio::Root::IO->catfile("t","data","Phrap.fa");
my @params = (arguments=>'-penalty -3 -minmatch 15');

my  $factory = Bio::Tools::Run::Phrap->new(@params);
ok $factory->isa('Bio::Tools::Run::Phrap');
ok $factory->arguments, '-penalty -3 -minmatch 15';

my $phrap_present = $factory->executable();

unless ($phrap_present) {
       warn("Phrap program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my $assembly = $factory->run($input);

foreach my $contig($assembly->all_contigs){
  my $collection = $contig->get_features_collection;
  my @sf = $collection->get_all_features;
  ok $sf[0]->start,601;
  ok $sf[0]->end,963;
}


1; 

