# -*-Perl-*- Test Harness script for Bioperl
# $Id$

use strict;

BEGIN {
   use Bio::Root::Test;
   
   test_begin(-tests => 28);
   
   use_ok('Bio::Tools::Run::Hmmer');
   use_ok('Bio::SeqIO');
   use_ok('Bio::AlignIO');
}

my $verbose = test_debug();
my $quiet = $verbose > 0 ? 0 : 1;

my $db = test_input_file('pfam_sample_R11');
my @params = ('DB'=>$db,'E'=>5,'program'=>'hmmpfam','A'=>2,'-verbose' => $verbose, -quiet => $quiet);

#test HMMPFAM
my $factory = Bio::Tools::Run::Hmmer->new(@params);
isa_ok($factory, 'Bio::Tools::Run::Hmmer');
is $factory->E, 5;
is $factory->DB, $db;
is $factory->hmm, $db;
my $prot_file = test_input_file('hmmpfam_protein_input');

my $seqstream = Bio::SeqIO->new(-file => $prot_file, 
				-format => 'fasta');
my $seq1 = $seqstream->next_seq();

my $hmmpfam_present = $factory->executable();
SKIP: {
   skip "hmmpfam program not found", 5 unless $hmmpfam_present;

   my $searchio = $factory->run($seq1);
   
   my @feat;
   while (my $result = $searchio->next_result){
     while(my $hit = $result->next_hit){
       while (my $hsp = $hit->next_hsp){
         push @feat, $hsp;
       }
     }
   }
   
   isa_ok $feat[0], 'Bio::SeqFeatureI';
   is ($feat[0]->feature1->start,25);
   is ($feat[0]->feature1->end,92);
   is ($feat[0]->feature2->start,1);
   is ($feat[0]->feature2->end,124);
}

#test HMMSEARCH
@params = ('HMM'=>$db,'E'=>5,'program'=>'hmmsearch','-verbose' => $verbose, -quiet => $quiet);
$factory = Bio::Tools::Run::Hmmer->new(@params);
isa_ok $factory, 'Bio::Tools::Run::Hmmer';
is $factory->E, 5;

my $hmmsearch = $factory->executable();
SKIP: {
   skip "hmmsearch program not found", 5 unless $hmmsearch;
   
   my $searchio = $factory->run($seq1);
   my @feat;
   while (my $result = $searchio->next_result){
     while(my $hit = $result->next_hit){
       while (my $hsp = $hit->next_hsp){
         push @feat, $hsp;
       }
     }
   }
   
   isa_ok $feat[0], 'Bio::SeqFeatureI';
   is ($feat[0]->feature1->start,1);
   is ($feat[0]->feature1->end,124);
   is ($feat[0]->feature2->start,25);
   is ($feat[0]->feature2->end,92);
}

#test HMMBUILD
my $hmmout = test_output_file();
unlink($hmmout);
ok ! -e $hmmout;
@params = ('HMM'=>$hmmout,'program'=>'hmmbuild', -verbose => $verbose, -quiet => $quiet);
$factory = Bio::Tools::Run::Hmmer->new(@params);
isa_ok $factory, 'Bio::Tools::Run::Hmmer';
is $factory->quiet, 1;
my $aln_file = test_input_file('cysprot.msf');
my $aio = Bio::AlignIO->new(-file=>$aln_file,-format=>'msf');
my $aln = $aio->next_aln;

my $hmmbuild = $factory->executable();
SKIP: {
   skip "hmmbuild program not found", 2 unless $hmmbuild;
   ok $factory->run($aln);
   ok -s $hmmout;
}

#test HMMCALIBRATE, and from now on, alternate (preferred) run method calling,
#though we need to check the executables are present in the normal way first
$factory->program_name('hmmcalibrate');
my $hmmcalibrate = $factory->executable();
$factory->program_name('hmmalign');
my $hmmalign = $factory->executable();
$factory->program_name('hmmemit');
my $hmmemit = $factory->executable();

SKIP: {
   skip "hmmcalibrate program not found", 1 unless $hmmcalibrate;
   ok $factory->hmmcalibrate();
}

#test HMMALIGN
my $seqfile = test_input_file('cysprot1a.fa');
my $seqio = Bio::SeqIO->new(-file  => $seqfile,
			    -format=> 'fasta');
my @seqs;
while( my $seq = $seqio->next_seq ) {
   push @seqs, $seq;
}

SKIP: {
   skip "hmmalign program not found", 2 unless $hmmalign;
   $aio = $factory->hmmalign(@seqs);
   ok $aln = $aio->next_aln;
   is($aln->each_seq, 3);
}

#test HMMEMIT
SKIP: {
   skip "hmmemit program not found", 1 unless $hmmemit;
   my $seqio = $factory->hmmemit();
   my @seqs;
   while (my $seq = $seqio->next_seq) {
      push(@seqs, $seq);
   }
   is @seqs, 10; # emits 10 seqs by default
}
