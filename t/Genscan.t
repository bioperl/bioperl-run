#!/usr/local/bin/perl
#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
#
use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 4;
    plan tests => $NTESTS;
}

END {
  foreach ( $Test::ntest..$NTESTS ) {
	skip('Unable to run Genscan tests, exe may not be installed',1);
  }
}

use Bio::Tools::Run::Genscan;
use Bio::Root::IO;


if(! $ENV{'GENSCANDIR'}){
    warn("Need to define env variable GENSCANDIR to run test");
    exit(0);
}

my $paramfile = Bio::Root::IO->catfile($ENV{'GENSCANDIR'},"HumanIso.smat");
my @params = ('MATRIX',$paramfile);
my  $factory = Bio::Tools::Run::Genscan->new(@params);
ok $factory->isa('Bio::Tools::Run::Genscan');
ok $factory->matrix;

my $inputfilename = Bio::Root::IO->catfile("t","data","Genscan.FastA");
my $seq1 = Bio::Seq->new();
my $seqstream = Bio::SeqIO->new(-file => $inputfilename, -format => 'Fasta');
$seq1 = $seqstream->next_seq();

my $genscan_present = $factory->executable();

unless ($genscan_present) {
        warn("Genscan program not found. Skipping tests $Test::ntest to $NTESTS.\n");
            exit 0;
}
$factory->quiet(1);
my @feat = $factory->predict_genes($seq1);
    
my $protein = $feat[0]->predicted_protein();

ok $feat[0]->isa("Bio::SeqFeatureI");
ok $protein->isa("Bio::PrimarySeqI");

