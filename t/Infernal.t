# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
our $NUMTESTS;
our %INFERNAL_TESTS;

BEGIN {
    $NUMTESTS = 3; # base number of tests (those not in blocks)

    # I have set up eutils tests to run in sections for easier test maintenance
    # and keeping track of problematic tests. The below hash is the list of
    # tests, with test number and coderef.
    
    # these now run very simple tests for connectivity and data sampling
    # main tests now with the parser

    %INFERNAL_TESTS = (
        'params'        => {'tests' => 13,
                            'sub'   => \&simple_param_tests},
        'cmalign'       => {'tests' => 6,
                            'sub'   => \&cmalign_norm},
        # need to add merge tests
        'cmsearch'      => {'tests' => 7,
                            'sub'   => \&cmsearch},
        'cmbuild'       => {'tests' => 4,
                            'sub'   => \&cmbuild},
        'cmstat'        => {'tests' => 2,
                            'sub'   => \&cmstat},
        # leave this one commented (may run for quite a while dep. on CPU)
        #'cmcalibrate'   => {'tests' => 2,
        #                    'sub'   => \&cmcalibrate},
        'cmscore'       => {'tests' => 2,
                            'sub'   => \&cmscore},
        'cmemit'        => {'tests' => 6,
                            'sub'   => \&cmemit},
        );
    $NUMTESTS += $INFERNAL_TESTS{$_}->{'tests'} for (keys %INFERNAL_TESTS);

    use Bio::Root::Test;
    
    test_begin(-tests   => $NUMTESTS );
    use_ok('Bio::Tools::Run::Infernal');
    use_ok('Bio::SeqIO');
    use_ok('Bio::AlignIO');
}

my $factory = Bio::Tools::Run::Infernal->new(-program     => 'cmsearch');

SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => $NUMTESTS - 3);
    for my $test (keys %INFERNAL_TESTS) {
        $INFERNAL_TESTS{$test}->{'sub'}->();
    }
}

# test out parameters and command string building
sub simple_param_tests {
    my %executable = (
        'cmsearch'   => {
            params => {
                outfile  => 'foo.txt', # this won't get set (not a valid param for cmsearch)
                o        => 'bar.infernal', # test multiple outfile designations
                dna      => 1,
                tabfile  => 'tab.txt', # param
                gcfile   => 'gc.txt',
                g        => 'glarg',
            },
            test1  => 'cmsearch --dna -g --gcfile gc.txt --tabfile tab.txt -o bar.infernal baz.cm seq1.txt',
            test2  => 'cmsearch --dna -g --gcfile gc.txt --tabfile tab.txt -o bar.infernal arg.cm seq1.txt',
            seq_files => ['seq1.txt'],
            align_files => [],
        },
        'cmemit'     => {
            params => {
                -n => 10,
                -a => 1,
                -l => 1,
                -rna => 1,
                -tfile => 'trees.txt',
                -outfile_name => 'seqs.stk'
            },
            test1  => 'cmemit -a -l --rna -n 10 --tfile trees.txt baz.cm seqs.stk',
            test2  => 'cmemit -a -l --rna -n 10 --tfile trees.txt arg.cm seqs.stk',
            seq_files => [],
            align_files => [],
        },
        'cmscore'    => {
            params => {
                n => 10,
                a => 1,
                l => 1,
                rna => 1,
                mxsize => 4096,
                outfile => 'seqs.fna', # note this is different from outfile_name
                -outfile_name => 'seqs.stk'                
                       },
            test1  => 'cmscore -a -l --mxsize 4096 -n 10 --outfile seqs.fna baz.cm > seqs.stk',
            test2  => 'cmscore -a -l --mxsize 4096 -n 10 --outfile seqs.fna arg.cm > seqs.stk',
            seq_files => [],
            align_files => [],
        },
        'cmalign'    => {
            params => {
                -tau => 1e-7,
                -l => 1,
                -cyk => 1,
                -o => 'aligns.stk'
                       },
            test1  => 'cmalign --cyk -l --tau 1e-07 -o aligns.stk baz.cm seq1.fas',
            test2  => 'cmalign --cyk -l --tau 1e-07 -o aligns.stk arg.cm seq1.fas',
            test3  => 'cmalign --cyk -l --merge --tau 1e-07 -o aligns.stk arg.cm alns1.stk alns2.stk',
            seq_files => ['seq1.fas'],
            align_files => ['alns1.stk', 'alns2.stk'],
         },
        'cmbuild'    => {
            params => {
                -binary => 1,
                -ehmmre => 12,
                       },
            test1  => 'cmbuild --binary --ehmmre 12 baz.cm alns1.stk',
            test2  => 'cmbuild --binary --ehmmre 12 arg.cm alns1.stk',
            seq_files => ['seq1.fas'],
            align_files => ['alns1.stk'],
                         },
        'cmcalibrate'=> {
            params => {
                -s => 12,
                '-exp-no-qdb'  => 1,  # note use of quotes
                       },
            test1  => 'cmcalibrate --exp-no-qdb -s 12 baz.cm',
            test2  => 'cmcalibrate --exp-no-qdb -s 12 arg.cm',
                        },
    );
    for my $exe (sort keys %executable) {
        my %p = %{$executable{$exe}{params}};
        $factory = Bio::Tools::Run::Infernal->new(-program     => $exe,
                                                  -model_file  => 'baz.cm',
                                                %p);
        like($factory->to_exe_string(-seq_files => $executable{$exe}{seq_files},
                                   -align_files => $executable{$exe}{align_files}),
            qr/$executable{$exe}{test1}/,"$exe parameter setting");
        $factory->model_file('arg.cm');
        like($factory->to_exe_string(-seq_files => $executable{$exe}{seq_files},
                                   -align_files => $executable{$exe}{align_files}),
            qr/$executable{$exe}{test2}/,"$exe parameter setting");
        if ($exe eq 'cmalign') {
            $factory->set_parameters(merge => 1);
            like($factory->to_exe_string(-seq_files => $executable{$exe}{seq_files},
                                   -align_files => $executable{$exe}{align_files}),
            qr/$executable{$exe}{test3}/,"$exe parameter setting");
        }
    }
}

sub cmsearch {
    my ($model, $input) = (test_input_file('purine.c.cm'), test_input_file('xprt.gb'));
    my $factory = Bio::Tools::Run::Infernal->new(-model_file  => $model,
                                                 -program     => 'cmsearch',  
                                                 -verbose     => test_debug());
    
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 7);
    
    # from a file
    my $searchio = $factory->cmsearch($input);
    isa_ok($searchio, 'Bio::SearchIO', 'cmsearch works for v1.0 with file name;');
    my $result = $searchio->next_result();
    isa_ok($result, 'Bio::Search::Result::ResultI');
    is($result->hits, 1);
    my $hit = $result->next_hit;
    is($hit->hsps, 4);
    
    # from a Bio::PrimarySeqI
    my $seq = Bio::SeqIO->new(-format => 'genbank',
                              -file   => $input)->next_seq;
    $searchio = $factory->cmsearch($seq);
    isa_ok($searchio, 'Bio::SearchIO', 'cmsearch works for v1.0 with PrimarySeq;');
    $result = $searchio->next_result();
    is($result->hits, 1);
    $hit = $result->next_hit;
    is($hit->hsps, 4);
    }
}

sub cmbuild {
    my ($aln, $outfile) = (test_input_file('purine.1.sto'), test_output_file());
    if (-e $outfile) {
        unlink $outfile;
    }
    my $factory = Bio::Tools::Run::Infernal->new(-model_file    => $outfile,
                                                 -quiet         => 1,
                                                 -program       => 'cmbuild',  
                                                 -verbose       => test_debug());
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 4);
    
    # from a file
    my $success = $factory->cmbuild($aln);
    ok($success, 'cmbuild works using alignment file');
    ok(-e $outfile, 'CM file created');
    
    my $outfile2 = test_output_file();
    if (-e $outfile2) {
        unlink $outfile2;
    }
    $factory->model_file($outfile2);    
    
    # from a Bio::Align::AlignI
    my $alnobj = Bio::AlignIO->new(-format => 'stockholm',
                              -file   => $aln)->next_aln;
    $success = $factory->cmbuild($alnobj);
    ok($success, 'cmbuild works using Bio::Align::AlignI');
    ok(-e $outfile2, 'CM file created');
    }
}

sub cmstat {
    my ($cm, $outfile) = (test_input_file('purine.c.cm'), test_output_file());
    my $factory = Bio::Tools::Run::Infernal->new(-model_file    => $cm,
                                                 -outfile_name  => $outfile,
                                                 -program       => 'cmstat',  
                                                 -verbose       => test_debug());
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 2);
    
    my $success = $factory->cmstat();
    ok($success, 'cmstat works');
    ok (-e $outfile, 'cmstat outfile created');
    }    
}

sub cmscore {
    my ($cm, $outfile) = (test_input_file('purine.c.cm'), test_output_file());
    my $factory = Bio::Tools::Run::Infernal->new(-model_file    => $cm,
                                                 -outfile_name  => $outfile,
                                                 -program       => 'cmscore',  
                                                 -verbose       => test_debug());
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 2);
    
    my $success = $factory->cmscore();
    ok($success, 'cmscore works');
    ok (-e $outfile, 'cmscore outfile created');
    }    
}

sub cmalign_norm {
    my ($cm, $seqfile) = (test_input_file('purine.c.cm'),
                          test_input_file('purine.added.fa'));
    my $factory = Bio::Tools::Run::Infernal->new(-model_file    => $cm,
                                                 -program       => 'cmalign');
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 6);
    
    my @seqs;
    
    my $stream = $factory->cmalign($seqfile);
    isa_ok($stream, 'Bio::AlignIO', 'cmalign works');
    my $aln = $stream->next_aln;
    isa_ok($aln, 'Bio::Align::AlignI');
    is($aln->num_sequences, 2);
    
    my $seqio = Bio::SeqIO->new(-format => 'fasta', -file => $seqfile);
    
    while (my $seq = $seqio->next_seq) {
        push @seqs, $seq;
    }
    
    $stream = $factory->cmalign(@seqs);
    isa_ok($stream, 'Bio::AlignIO', 'cmalign works');
    $aln = $stream->next_aln;
    isa_ok($aln, 'Bio::Align::AlignI');
    is($aln->num_sequences, 2);
    }        
}

sub cmemit {
    my ($cm, $outfile) = (test_input_file('purine.c.cm'), test_output_file());
    my $factory = Bio::Tools::Run::Infernal->new(-model_file    => $cm,
                                                 -program       => 'cmemit',
                                                 -outfile_name  => $outfile,
                                                 -quiet         => 1
                                                 );
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 6);
    
    # seqs (default)
    my $stream = $factory->cmemit();
    isa_ok($stream, 'Bio::SeqIO', 'cmemit works');
    my $seq = $stream->next_seq;
    isa_ok($seq, 'Bio::PrimarySeqI');
    is($seq->display_id, 'Purine-1');

    # alignment (-a flag)
    $factory->set_parameters(-a => 1);
    $stream = $factory->cmemit();
    isa_ok($stream, 'Bio::AlignIO', 'cmemit works');
    my $aln = $stream->next_aln;
    isa_ok($aln, 'Bio::Align::AlignI');
    is($aln->num_sequences, 10);
    }
}

sub cmcalibrate {
    my $cm = test_input_file('purine.cm');
    my $factory = Bio::Tools::Run::Infernal->new(-model_file    => $cm,
                                                 -program       => 'cmcalibrate');
    SKIP: {
    test_skip(-requires_executable => $factory,
             -tests => 2);
    
    # seqs (default)
    my $success = $factory->cmcalibrate();
    ok($success, 'cmcalibrate successful');
    cmp_ok(-M $cm, '<=' ,1);
    }
}

