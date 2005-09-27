# $Id$
# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
my $DEBUG = $ENV{BIOPERLDEBUG};
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 15;
    plan tests => $NTESTS;
}

END {
    foreach ( $Test::ntest..$NTESTS ) {
        skip("pseudowise program not found. Skipping. (Be sure you have the wise package > 2.2.0)",1);
    }
}

use Bio::Tools::Run::Pseudowise;
use Bio::Root::IO;
use Bio::Seq;

my $verbose = -1;
#my @params = ('dymem', 'linear', 'kbyte', '5000','erroroffstd'=>1);
my @params = ('erroroffstd'=>1,'-verbose' => $DEBUG, 
	      quiet => $DEBUG);
my  $factory = Bio::Tools::Run::Pseudowise->new(@params);
ok($factory);
my $executable = $factory->executable;
if( ! $executable ) {
    warn("Pseudowise program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

warn("$executable\n") if $DEBUG; 
ok $factory->isa('Bio::Tools::Run::Pseudowise');

#test with one file with 3 sequences
my $inputfilename = Bio::Root::IO->catfile("t","data","ps1.fa");
my $seqstream = Bio::SeqIO->new(-file   => $inputfilename, 
				-format => 'fasta');
my $seq1 = $seqstream->next_seq();
my $seq2 = $seqstream->next_seq();
my $seq3 = $seqstream->next_seq();


my @feat = $factory->predict_genes($seq1, $seq2, $seq3);
my $geneno = scalar(@feat);
ok($geneno,1);
my @subfeat = $feat[0]->sub_SeqFeature;
my $exonno = scalar(@subfeat);

ok($geneno, 1);
ok($exonno, 2);
ok($feat[0]->isa("Bio::SeqFeatureI"));
ok($subfeat[0]->isa("Bio::SeqFeatureI"));
ok($feat[0]->primary_tag, 'pseudogene');
ok($subfeat[0]->primary_tag, 'exon');
ok($feat[0]->start, 163);
ok($subfeat[0]->start, 163);
ok($feat[0]->end, 626);
ok($subfeat[0]->end, 213);
ok($subfeat[1]->start,585);
ok($subfeat[1]->end, 626);
