#!/usr/local/bin/perl
# $Id$

use strict;

BEGIN { 
  use Bio::Root::Test;
  test_begin(-tests => 14);
  
  use_ok('Bio::Tools::Run::Alignment::Blat');
  use_ok('Bio::SeqIO');
  use_ok('Bio::Seq');
}

my $db =  test_input_file("blat_dna.fa");

my $query = test_input_file("blat_dna.fa");    

my $factory = Bio::Tools::Run::Alignment::Blat->new('quiet'  => 1,
						    "DB"     => $db);
ok $factory->isa('Bio::Tools::Run::Alignment::Blat');

my $blat_present = $factory->executable();

SKIP: {
   test_skip(-requires_executable => $factory,
             -tests => 10);
   
   my $searchio = $factory->align($query);
   my $result = $searchio->next_result;
   my $hit    = $result->next_hit;
   my $hsp    = $hit->next_hsp;
   ok $hsp->isa("Bio::Search::HSP::HSPI");
   ok ($hsp->query->start,1);
   ok ($hsp->query->end,1775);
   ok ($hsp->hit->start,1);
   ok ($hsp->hit->end,1775);
   my $sio = Bio::SeqIO->new(-file=>$query,-format=>'fasta');
   
   my $seq  = $sio->next_seq ;
   
   $searchio = $factory->align($seq);
   $result = $searchio->next_result;
   $hit    = $result->next_hit;
   $hsp    = $hit->next_hsp;
   ok $hsp->isa("Bio::Search::HSP::HSPI");
   ok ($hsp->query->start,1);
   ok ($hsp->query->end,1775);
   ok ($hsp->hit->start,1);
   ok ($hsp->hit->end,1775);
}
 
1; 

