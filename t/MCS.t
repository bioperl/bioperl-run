use strict;

BEGIN {
    use Bio::Root::Test;

    test_begin(-tests => 24,
               -requires_modules => [qw(Config::Any)]);

    use_ok('Bio::Location::Atomic');
}

# setup input files etc
my $alignfilename = test_input_file('gumby', 'hmrd.mfa');
ok (-e $alignfilename, 'Found input alignment file');

SKIP: {
    test_skip(-requires_module => 'Bio::FeatureIO',
              -tests => 22);
    use_ok('Bio::Tools::Run::MCS');
    use_ok('Bio::SeqFeature::Annotated');
    my $factory = Bio::Tools::Run::MCS->new(-verbose => -1,
                                            -quiet => 1);
    isa_ok($factory, 'Bio::Tools::Run::MCS');
    ok $factory->can('neutral'), 'has a created method not in args supplied to new';
    is $factory->quiet, 1, 'quiet was set';
    
    # test default factory values
    is ($factory->program_dir, $ENV{'MCSDIR'}, 'program_dir returned correct default');
    is ($factory->program_name(), 'align2binomial.pl', 'Correct exe default name');
    
    # test the program itself
    SKIP: {
        test_skip(-requires_executable => $factory,
                  -tests => 15);
    
        my $alignio = Bio::AlignIO->new(-file => $alignfilename);
        my $align = $alignio->next_aln;
    
        my @cds_feats;
        foreach my $data ([47367820, 47367830], [47367850, 47367860], [47367870, 47367880]) {
            my $cds_feat = Bio::SeqFeature::Annotated->new(
                    -seq_id       => 'Homo_sapiens',
                    -start        => $data->[0],
                    -end          => $data->[1],
                    -frame        => 0,
                    -strand       => 1,
                    -primary      => 'CDS',
                    -type         => 'CDS',
                    -source       => 'UCSC');
            push(@cds_feats, $cds_feat);
        }
        my $location = Bio::Location::Atomic->new(-start => 47367748, -end => 47427851, -strand => 1, -seq_id => 'chr1');
    
        # run the program
        my @feats = $factory->run($align, $location, \@cds_feats);
    
        # spot-test the results
        my @spot_results = ($feats[0], $feats[1], $feats[2]);
        foreach my $expected ([47373765, 47373846, 1000],
                              [47373848, 47373883, 1000],
                              [47377883, 47377908, 1000]) {
            my $feat = shift(@spot_results);
            isa_ok $feat, 'Bio::SeqFeature::Annotated';
            is $feat->source->value, 'MCS', 'correct source';
            is $feat->start, shift(@{$expected}), 'feature start correct';
            is $feat->end, shift(@{$expected}), 'feature end correct';
            is $feat->score, shift(@{$expected}), 'feature score correct';
        }
    }

}