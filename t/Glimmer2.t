#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;
use vars qw($NTESTS);

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('Glimmer');
    $NTESTS = 217;
    test_begin(-tests => $NTESTS,
	       -requires_modules => [qw(IPC::Run)]);
    use_ok('Bio::Tools::Run::Glimmer');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $fasta_file = test_input_file('H_pylori_J99.fasta');
my $icm_file   = test_input_file('H_pylori_J99.glimmer2.icm');

my $factory    = Bio::Tools::Run::Glimmer->new(-program => 'glimmer2',
                                               -model => $icm_file);
isa_ok $factory, 'Bio::Tools::Run::Glimmer';

my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
my $seq = $seqstream->next_seq();

SKIP: {
    test_skip(-requires_executable => $factory, -tests => 213);

    my $glimmer2 = $factory->run($seq);
    isa_ok $glimmer2, 'Bio::Tools::Glimmer';
    
    my $first_gene = $glimmer2->next_prediction();
    isa_ok $first_gene, 'Bio::SeqFeature::Generic';
    is $first_gene->seq_id(), 'gi|15611071|ref|NC_000921.1|';
    
    while (my $gene = $glimmer2->next_prediction()) {
        isa_ok $gene, 'Bio::SeqFeature::Generic';
    }
}

1; 
