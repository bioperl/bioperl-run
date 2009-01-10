#-*-Perl-*-
# ## Bioperl Test Harness Script for Modules
# #
use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 98,
	       -requires_modules => [qw(IPC::Run)]);

    use_ok('Bio::Tools::Run::Genemark');
    use_ok('Bio::Root::IO');
    use_ok('Bio::Seq');
}

my $verbose   = test_debug();
my $model_dir = $ENV{'GENEMARK_MODELS'} if $ENV{'GENEMARK_MODELS'};

SKIP: {
    my $fasta_file = test_input_file('H_pylori_J99.fasta');
    test_skip(-tests => 95,
			  -requires_env => 'GENEMARK_MODELS');
    my $model_file = Bio::Root::IO->catfile($model_dir, 'Helicobacter_pylori_26695.mod');
	
    my $factory    = Bio::Tools::Run::Genemark->new( -m => $model_file,
			-program => 'gmhmmp');
    test_skip(-tests => 95,
			  -requires_executable => $factory);
	
    isa_ok $factory, 'Bio::Tools::Run::Genemark';
    
    my $seqstream = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
    my $seq = $seqstream->next_seq();
    
    my $gmhmmp = $factory->run($seq);
    isa_ok $gmhmmp,'Bio::Tools::Genemark';

    my $first_gene = $gmhmmp->next_prediction();
    isa_ok $first_gene, 'Bio::Tools::Prediction::Gene';
    is $first_gene->seq_id(), 'gi|15611071|ref|NC_000921.1|';
    
	my $ct = 0;
	# may fluctuate based on the model, stop after 91 checks
    while (my $gene = $gmhmmp->next_prediction()) {
        isa_ok $gene, 'Bio::Tools::Prediction::Gene';
		last if $ct++ == 90;
    }
}

1; 
