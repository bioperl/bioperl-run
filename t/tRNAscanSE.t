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
    $NTESTS = 12;
    plan tests => $NTESTS;
    use_ok('Bio::Tools::Run::tRNAscanSE');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $verbose = 1 if $ENV{'BIOPERLDEBUG'};

my $fasta_file = Bio::Root::IO->catfile('t','data','H_pylori_J99.fasta');

my $factory    = Bio::Tools::Run::tRNAscanSE->new(-program => 'tRNAscan-SE');
isa_ok $factory, 'Bio::Tools::Run::tRNAscanSE';

my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
my $seq = $seqstream->next_seq();

SKIP: {
    my $tRNAscanSE_present = $factory->executable();
    
    unless ($tRNAscanSE_present) {
        skip("tRNAscanSE program not found. Skipping tests 5 to $NTESTS",12);
    }
    
    my $tRNAscanSE = $factory->run($seq);
    isa_ok $tRNAscanSE, 'Bio::Tools::tRNAscanSE';
    
    while (my $gene = $tRNAscanSE->next_prediction()) {
        isa_ok $gene, 'Bio::SeqFeature::Generic';
    }
}

1; 
