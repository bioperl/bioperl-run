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
    $NTESTS = 110;
    plan tests => $NTESTS;
    use_ok('Bio::Tools::Run::Glimmer');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $verbose = 1 if $ENV{'BIOPERLDEBUG'};

my $fasta_file = Bio::Root::IO->catfile('t','data','H_pylori_J99.fasta');
my $icm_file   = Bio::Root::IO->catfile('t','data','H_pylori_J99.glimmer3.icm');

my $factory    = Bio::Tools::Run::Glimmer->new(-program => 'glimmer3',
                                               -model => $icm_file);
isa_ok $factory, 'Bio::Tools::Run::Glimmer';

my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
my $seq = $seqstream->next_seq();

SKIP: {
    my $glimmer_present = $factory->executable();
    
    unless ($glimmer_present) {
        skip("glimmer3 program not found. Skipping tests 5 to $NTESTS",106);
    }
    
    my $glimmer3 = $factory->run($seq);
    isa_ok $glimmer3, 'Bio::Tools::Glimmer';
    
    while (my $gene = $glimmer3->next_prediction()) {
        isa_ok $gene, 'Bio::Tools::Prediction::Gene';
    }
}

1; 
