# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 25);
    use_ok('Bio::Tools::Run::Meme');
}

# setup input files
my $seq1_file = test_input_file('fasta.fa');
my $seq2_file = test_input_file('lagan_dna.fa');
my $seq3_file = test_input_file('new_dna.fa');

# object setup and testing
my $factory = Bio::Tools::Run::Meme->new(-verbose => -1,
                                         -quiet => 1,
                                         -mod => 'oops',
                                         -dna => 1);

isa_ok($factory, 'Bio::Tools::Run::Meme');
ok $factory->can('nmotifs'), 'has a created method not in args';
is $factory->mod, 'oops', 'mod param was set';
ok $factory->dna, 'dna switch was set';

is ($factory->program_dir, $ENV{'MEME_BIN'}, 'program_dir returned correct default');
is ($factory->program_name(), 'meme', 'Correct exe default name');

# test the program itself
SKIP: {
    test_skip(-tests => 18,
              -requires_executable => $factory);
    
    use_ok('Bio::SeqIO');
    my $si = Bio::SeqIO->new(-file => $seq1_file, -format => 'fasta');
    ok my $seq1 = $si->next_seq;
    $si = Bio::SeqIO->new(-file => $seq2_file, -format => 'fasta');
    ok my $seq2 = $si->next_seq;
    $si = Bio::SeqIO->new(-file => $seq3_file, -format => 'fasta');
    ok my $seq3 = $si->next_seq;
    
    # get an alignio given seq objects
    ok my $alignio = $factory->run($seq1, $seq2, $seq3);
    my $aligns = 0;
    while (my $align = $alignio->next_aln) {
        $aligns++;
        
        is $align->score, '1.3e+002';
        is $align->length, 20;
        
        my @expected = (['sequence_10', 738], ['Scaffold_2042.1', 787], ['SINFRUT00000067802', 941]);
        
        my $seqs = 0;
        foreach my $seq ($align->each_seq) {
            $seqs++;
            
            my @answers = @{shift @expected};
            is $seq->id, shift @answers;
            is $seq->start, shift @answers;
            is $seq->strand, 1;
        }
        is $seqs, 3;
    }
    is $aligns, 1;
    
    # get a Bio::Map::Prediction
    # ...
}
