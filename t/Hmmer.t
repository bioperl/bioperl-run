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
   $NTESTS = 17;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Prints tests, exe may not be installed',1);
   }
  unlink "t/data/hmmer.hmm";
}
ok(1);
use Bio::Tools::Run::Hmmer;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Seq;

my $db =  Bio::Root::IO->catfile("t","data","pfam_sample_R11");
my @params = ('DB'=>$db,'E'=>5,'program'=>'hmmpfam');

#test HMMPFAM
my  $factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
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

my $searchio = $factory->run($seq1);

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

#test HMMSEARCH
my @params = ('HMM'=>$db,'E'=>5,'program'=>'hmmsearch');
$factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
ok $factory->E, 5;
$prot_file=  Bio::Root::IO->catfile("t","data","hmmpfam_protein_input");

$seq1 = Bio::Seq->new();
$seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
$seq1 = $seqstream->next_seq();

my $hmmsearch = $factory->executable();

unless ($hmmsearch) {
       warn("hmmsearch program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}

$searchio = $factory->run($seq1);

@feat;
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

#test HMMBUILD
my $hmmout=  Bio::Root::IO->catfile("t","data","hmmer.hmm");
my @params = ('HMM'=>$hmmout,'program'=>'hmmbuild');
$factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
my $aln_file=  Bio::Root::IO->catfile("t","data","cysprot.msf");
my $aio = Bio::AlignIO->new(-file=>$aln_file,-format=>'msf');
my $aln = $aio->next_aln;
$factory->run($aln);
ok -e $hmmout;




1; 

