# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 22;
    plan tests => $NTESTS;
}
use Bio::Tools::Run::FootPrinter;
use Bio::SeqIO;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("FootPrinter program not found. Skipping.",1);
    }
}
my $treefile =Bio::Root::IO->catfile("t", "data", "tree_of_life");

my @params = (
               'size'=>10,
              'sequence_type'=>'upstream',
              'subregion_size'=>30,
              'position_change_cost'=>5,
              'triplet_filtering'=>1,
              'pair_filtering'=>1,
              'post_filtering'=>1,
              'inversion_cost'=>1,
              'tree'   =>$treefile,
              'details'=>0,
              'verbose'=>0);

my $fact = Bio::Tools::Run::FootPrinter->new(@params);

if( ! $fact->executable ) { 
    warn("FootPrinter program not found. Skipping tests $Test::ntest to $NTESTS.\n");

    exit(0);
}

ok $fact->size, 10;
ok $fact->sequence_type, 'upstream';
ok $fact->subregion_size, 30;
ok $fact->position_change_cost, 5;
ok $fact->triplet_filtering,1;
ok $fact->pair_filtering,1;
ok $fact->post_filtering,1;
ok $fact->inversion_cost,1;
ok $fact->tree, $treefile;

my $input= Bio::Root::IO->catfile("t","data","FootPrinter.seq.fa");

my $in  = Bio::SeqIO->new(-file => "$input" , '-format' => 'fasta');
my @seq;
while (my $seq = $in->next_seq){
  push @seq, $seq; # 6 sequences
}
my @fp= $fact->run(@seq);
ok @fp, 6;

my $first = shift @fp;

my @motifs = $first->sub_SeqFeature;
if (@motifs == 2) {
    # older version of FootPrinter? or version 2.1 is buggy with its silly first
    # motif of 1 bp below
    ok $motifs[0]->seq_id,'TETRAODON-motif1';
    ok $motifs[0]->seq->seq, 'tacaggatgca';
    ok $motifs[0]->start, 352;
    ok $motifs[0]->end, 362;
    ok $motifs[1]->seq_id,'TETRAODON-motif2';
    ok $motifs[1]->seq->seq, 'ccatatttgga';
    ok $motifs[1]->start, 363;
    ok $motifs[1]->end, 373;
    ok 1;
    ok 1;
    ok 1;
    ok 1;
}
elsif (@motifs == 3) {
    ok $motifs[0]->seq_id,'TETRAODON-motif1';
    ok $motifs[0]->seq->seq, 't';
    ok $motifs[0]->start, 352;
    ok $motifs[0]->end, 352;
    ok $motifs[1]->seq_id,'TETRAODON-motif2';
    ok $motifs[1]->seq->seq, 'acaggatgca';
    ok $motifs[1]->start, 353;
    ok $motifs[1]->end, 362;
    ok $motifs[2]->seq_id,'TETRAODON-motif3';
    ok $motifs[2]->seq->seq, 'ccatatttgga';
    ok $motifs[2]->start, 363;
    ok $motifs[2]->end, 373;
}



