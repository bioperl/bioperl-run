#-*-Perl-*-
# $id$
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
   $NTESTS = 8;
   plan tests => $NTESTS;
}

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip('Unable to run Tmhmm tests, exe may not be installed',1);
   }
}

use Bio::Tools::Run::Tmhmm;
use Bio::Root::IO;
use Bio::SeqIO;

ok(1);

# AHEM - Fugu guys, can you make sure this is genericized?

my $factory = Bio::Tools::Run::Tmhmm->new();
ok $factory->isa('Bio::Tools::Run::Tmhmm');
my $tmhmm_present = $factory->executable();
unless ($tmhmm_present) {
  warn("TMHMM program not found. Skipping tests $Test::ntest to $NTESTS.\n");
  exit 0;
}	      

my $prot_file=  Bio::Root::IO->catfile("t","data","test_prot.FastA");
ok(-e $prot_file);

my $seqstream = Bio::SeqIO->new(-file => $prot_file, -fmt => 'Fasta');
my $seq1 = $seqstream->next_seq();
ok( $seq1->isa('Bio::Seq') );
my @feat = $factory->run($seq1);
ok @feat, 5;

ok $feat[0]->isa('Bio::SeqFeatureI');
ok ($feat[0]->start,121);
ok ($feat[0]->end,143);

   

