#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
use Bio::AlignIO;
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
       skip('Unable to run Lagan tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Alignment::Lagan;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::Seq;

my $seq1 =  Bio::Root::IO->catfile("t","data","lagan_dna.fa");
my $sio = Bio::SeqIO->new(-file=>$seq1,-format=>'fasta');

my $seq = $sio->next_seq;
$seq->id("first_seq");
my $seq2= Bio::Seq->new(-id=>"second_seq",-seq=>$seq->seq);
my $seq3= Bio::Seq->new(-id=>"third_seq",-seq=>$seq->seq);


my @params =
             (
              'order' => "\"-gs -7 -gc -2 -mt 2 -ms -1\"",
              'tree' => "\"(first_seq (second_seq third_seq))\"",
              'match' => 12,
              'mismatch' => -8,
              'gapstart' => -50,
              'gapend' => -50,
              'gapcont' => -2,
         );
  
my  $factory = Bio::Tools::Run::Alignment::Lagan->new(@params);
$factory->quiet(1);
ok $factory->isa('Bio::Tools::Run::Alignment::Lagan');

my $lagan_present = $factory->executable();

unless ($lagan_present) {
       warn("lagan program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

my $simple_align= $factory->lagan($seq,$seq2);

ok $simple_align->isa('Bio::SimpleAlign');


ok $simple_align->percentage_identity, 100;

my $multi = $factory->mlagan([$seq,$seq2,$seq3]);
ok $multi->percentage_identity, 100;

1;
