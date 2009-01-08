# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 24);
    use_ok('Bio::Tools::Run::FootPrinter');
    use_ok('Bio::SeqIO');
}

SKIP: {
    my $treefile = test_input_file("tree_of_life");
    
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
    test_skip(-requires_executable => $fact, -tests => 22);
    
    is $fact->size, 10;
    is $fact->sequence_type, 'upstream';
    is $fact->subregion_size, 30;
    is $fact->position_change_cost, 5;
    is $fact->triplet_filtering,1;
    is $fact->pair_filtering,1;
    is $fact->post_filtering,1;
    is $fact->inversion_cost,1;
    is $fact->tree, $treefile;
    
    my $input= test_input_file("FootPrinter.seq.fa");
    
    my $in  = Bio::SeqIO->new(-file => "$input" , '-format' => 'fasta');
    my @seq;
    while (my $seq = $in->next_seq){
      push @seq, $seq; # 6 sequences
    }
    my @fp= $fact->run(@seq);
    is @fp, 6;
    
    my $first = shift @fp;
    
    my @motifs = $first->sub_SeqFeature;
    if (@motifs == 2) {
        # older version of FootPrinter? or version 2.1 is buggy with its silly first
        # motif of 1 bp below
        is $motifs[0]->seq_id,'TETRAODON-motif1';
        is $motifs[0]->seq->seq, 'tacaggatgca';
        is $motifs[0]->start, 352;
        is $motifs[0]->end, 362;
        is $motifs[1]->seq_id,'TETRAODON-motif2';
        is $motifs[1]->seq->seq, 'ccatatttgga';
        is $motifs[1]->start, 363;
        is $motifs[1]->end, 373;
        ok 1 for 1..4;
    }
    elsif (@motifs == 3) {
        is $motifs[0]->seq_id,'TETRAODON-motif1';
        is $motifs[0]->seq->seq, 't';
        is $motifs[0]->start, 352;
        is $motifs[0]->end, 352;
        is $motifs[1]->seq_id,'TETRAODON-motif2';
        is $motifs[1]->seq->seq, 'acaggatgca';
        is $motifs[1]->start, 353;
        is $motifs[1]->end, 362;
        is $motifs[2]->seq_id,'TETRAODON-motif3';
        is $motifs[2]->seq->seq, 'ccatatttgga';
        is $motifs[2]->start, 363;
        is $motifs[2]->end, 373;
    }
}
