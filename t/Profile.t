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
       skip('Unable to run Profile tests, exe may not be installed',1);
   }
}
ok(1);
use Bio::Tools::Run::Profile;
use Bio::Root::IO;
use Bio::SeqIO;
use Bio::Seq;

my $paramfile = Bio::Root::IO->catfile("","usr","users","pipeline","programs","pfscan");
my @params;
if( -e $paramfile ) { # leave this in until Fugu guys fix 
    push @params, 'PROGRAM',$paramfile
}
my $db =  Bio::Root::IO->catfile("t","data","prosite.dat");
push @params, ('DB',$db);
my  $factory = Bio::Tools::Run::Profile->new(@params);
ok $factory->isa('Bio::Tools::Run::Profile');
my $prot_file=  Bio::Root::IO->catfile("t","data","profile_prot.FastA");

my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file =>$prot_file, -fmt =>'Fasta');
$seq1 = $seqstream->next_seq();

my $profile_present = $factory->executable();

unless ($profile_present) {
    warn(" profile program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

my @feat = $factory->predict_protein_features($seq1);

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->start, 15);
ok ($feat[0]->end, 340);
   
