# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 7,
               -requires_modules => ['Config::Any']);
}

# setup input files etc
my $seq_file = test_input_file('fasta.fa');
my $mxlib = test_input_file('transfac.dat');

SKIP: {
    test_skip(-tests => 7,
              -requires_module => 'Bio::FeatureIO');
    
    use_ok('Bio::Tools::Run::Match');
    my $factory = Bio::Tools::Run::Match->new(-quiet => 1,
                                          -mxlib => $mxlib);

    isa_ok($factory, 'Bio::Tools::Run::Match');
    is $factory->mxlib, $mxlib, 'mxlib parameter was set';
    
    # test default factory values
    is ($factory->program_dir, $ENV{'MATCHDIR'}, 'program_dir returned correct default');
    is ($factory->program_name(), 'match', 'Correct exe default name');

    # test the program itself
    SKIP: {
        test_skip(-tests => 2,
                  -requires_module => 'Bio::FeatureIO',
                  -requires_executable => $factory);
        
    
        use_ok('Bio::SeqIO');
        my $si = Bio::SeqIO->new(-file => $seq_file, -format => 'fasta');
        my $seq = $si->next_seq;
    
        my @results = $factory->run($seq);
        is @results, 246;
    }

}