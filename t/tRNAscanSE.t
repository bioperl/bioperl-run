#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
use vars qw($NTESTS);

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('tRNAscanSE');
    $NTESTS = 12;
    test_begin(-tests => $NTESTS,
	       -requires_modules => [qw(IPC::Run)]);
    use_ok('Bio::Tools::Run::tRNAscanSE');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $verbose = test_debug();

my $fasta_file = test_input_file('H_pylori_J99.fasta');

my $factory    = Bio::Tools::Run::tRNAscanSE->new(-program => 'tRNAscan-SE');
isa_ok $factory, 'Bio::Tools::Run::tRNAscanSE';

my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
my $seq = $seqstream->next_seq();

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 8);
    
    my $tRNAscanSE = $factory->run($seq);
    isa_ok $tRNAscanSE, 'Bio::Tools::tRNAscanSE';
    
    while (my $gene = $tRNAscanSE->next_prediction()) {
        isa_ok $gene, 'Bio::SeqFeature::Generic';
    }
}

1; 
