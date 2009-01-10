#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
my $DBEUG = test_debug();
BEGIN {
   use lib '.';
   use Bio::Root::Test;
   test_begin(-tests => 8);
   use_ok('Bio::Tools::Run::Phrap');
   use_ok('Bio::SeqIO');
   use_ok('Bio::AlignIO');
   use_ok('Bio::Seq');
}

my $input =  test_input_file('Phrap.fa');
my @params = (-verbose => $DBEUG,
	      arguments=>'-penalty -3 -minmatch 15');

my  $factory = Bio::Tools::Run::Phrap->new(@params);
isa_ok $factory,'Bio::Tools::Run::Phrap';
is $factory->arguments, '-penalty -3 -minmatch 15';

SKIP: {
   test_skip(-requires_executable => $factory,
             -tests => 2);   
   my $assembly = $factory->run($input);
   
   foreach my $contig($assembly->all_contigs){
      my $collection = $contig->get_features_collection;
      my @sf = $collection->get_all_features;
      
      is $sf[1]->start, 601;
      is $sf[1]->end,   963;
   }
}