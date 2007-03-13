#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
BEGIN {
    eval { require Test::More; };
    if( $@ ) {
        use lib 't/lib';
    }
    use Test::More;
    use vars qw($NTESTS);
    $NTESTS = 98;
    plan tests => $NTESTS;
    use_ok('Bio::Tools::Run::Genemark');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $verbose   = 1 if $ENV{'BIOPERLDEBUG'};
my $model_dir = $ENV{'GENEMARK_MODELS'} if $ENV{'GENEMARK_MODELS'};

SKIP: {
    unless ($model_dir) {
        skip("genemark models not found. Skipping tests 4 to $NTESTS.", 95);
    }
    
    my $fasta_file = Bio::Root::IO->catfile('t','data','H_pylori_J99.fasta');
    my $model_file = Bio::Root::IO->catfile($model_dir, 'Helicobacter_pylori.mod');
    
    my $factory    = Bio::Tools::Run::Genemark->new(
                                                    -program => 'gmhmmp',
                                                    -m       => $model_file,
                                                    -file    => $fasta_file,
                                                );
    isa_ok $factory, 'Bio::Tools::Run::Genemark';
    
    my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
    my $seq = $seqstream->next_seq();
    
    my $genemark_present = $factory->executable();
    
    unless ($genemark_present) {
        skip("genemark program not found. Skipping tests 5 to $NTESTS.", 94);
    }
    
    my $gmhmmp = $factory->run($seq);
    isa_ok $gmhmmp,'Bio::Tools::Genemark';
    
    while (my $gene = $gmhmmp->next_prediction()) {
        isa_ok $gene, 'Bio::Tools::Prediction::Gene';
    }
}

1; 
