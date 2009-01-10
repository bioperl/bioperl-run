#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
use vars qw($NTESTS);

BEGIN {
    use Bio::Root::Test;
    $NTESTS = 111;
    test_begin(-tests => $NTESTS,
	       -requires_modules => [qw(IPC::Run)]);
    use_ok('Bio::Tools::Run::Glimmer');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $fasta_file = test_input_file('H_pylori_J99.fasta');
my $icm_file   = test_input_file('H_pylori_J99.glimmer3.icm');

my $factory    = Bio::Tools::Run::Glimmer->new(-program => 'glimmer3',
                                               -model => $icm_file);
isa_ok $factory, 'Bio::Tools::Run::Glimmer';

my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
my $seq = $seqstream->next_seq();

SKIP: {
    test_skip(-requires_executable => $factory, -tests => 107);
    
    my $glimmer3 = $factory->run($seq);
    isa_ok $glimmer3, 'Bio::Tools::Glimmer';
    
    while (my $gene = $glimmer3->next_prediction()) {
        isa_ok $gene, 'Bio::SeqFeature::Generic';
    }
}

1; 
