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
   $NTESTS = 20;
   plan tests => $NTESTS;
}

use Bio::Tools::Run::Hmmer;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Seq;

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Hmmer tests, exe may not be installed',1);
   }
   unlink Bio::Root::IO->catfile(qw(t data hmmer.hmm));
}
ok(1);

my $verbose = 1 if $ENV{'BIOPERLDEBUG'};

my $db =  Bio::Root::IO->catfile("t","data","pfam_sample_R11");
my @params = ('DB'=>$db,'E'=>5,'program'=>'hmmpfam','A'=>2,'-verbose' => $verbose);

#test HMMPFAM
my  $factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
ok $factory->E, 5;
my $prot_file=  Bio::Root::IO->catfile("t","data","hmmpfam_protein_input");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file   => $prot_file, 
				-format => 'fasta');
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
@params = ('HMM'=>$db,'E'=>5,'program'=>'hmmsearch','-verbose' => $verbose);
$factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
ok $factory->E, 5;
$prot_file=  Bio::Root::IO->catfile("t","data","hmmpfam_protein_input");

$seq1 = Bio::Seq->new();
$seqstream = Bio::SeqIO->new(-file   => $prot_file, 
			     -format => 'fasta');
$seq1 = $seqstream->next_seq();

my $hmmsearch = $factory->executable();

unless ($hmmsearch) {
       warn("hmmsearch program not found. Skipping tests $Test::ntest to $NTESTS.\n");
       exit 0;
}
$searchio = $factory->run($seq1);
@feat= ();
while (my $result = $searchio->next_result){
  while(my $hit = $result->next_hit){
    while (my $hsp = $hit->next_hsp){
      push @feat, $hsp;
    }
  }
}

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->feature1->start,1);
ok ($feat[0]->feature1->end,124);
ok ($feat[0]->feature2->start,25);
ok ($feat[0]->feature2->end,92);

#test HMMBUILD
my $hmmout=  Bio::Root::IO->catfile("t","data","hmmer.hmm");
@params = ('HMM'=>$hmmout,'program'=>'hmmbuild');
$factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
my $aln_file=  Bio::Root::IO->catfile("t","data","cysprot.msf");
my $aio = Bio::AlignIO->new(-file=>$aln_file,-format=>'msf');
my $aln = $aio->next_aln;
$factory->run($aln);
ok -e $hmmout;



#test HMMALIGN
$hmmout=  Bio::Root::IO->catfile("t","data","hmmer.hmm");
@params = ('HMM'=>$hmmout,'program'=>'hmmalign');
$factory = Bio::Tools::Run::Hmmer->new(@params);
ok $factory->isa('Bio::Tools::Run::Hmmer');
my $seqfile=  Bio::Root::IO->catfile("t","data","cysprot1a.fa");
my $seqio = Bio::SeqIO->new(-file  => $seqfile,
			    -format=> 'fasta');
my @seqs;
while( my $seq = $seqio->next_seq ) {
    push @seqs, $seq;
}
$aio = $factory->run(@seqs);
$aln = $aio->next_aln;
ok($aln);
#$aio = Bio::AlignIO->new(-format => 'clustalw');
#$aio->write_aln($aln);
ok($aln->each_seq, 3);

1; 

