# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = test_debug();
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 23);
    use_ok(' Bio::Tools::Run::Alignment::MAFFT');
    use_ok(' Bio::AlignIO');
    use_ok(' Bio::SeqIO');
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

my @params = (-verbose => $DEBUG,
              'quiet'  => 1);
my  $factory = Bio::Tools::Run::Alignment::MAFFT->new(@params);

isa_ok $factory,'Bio::Tools::Run::Alignment::MAFFT';

my $inputfilename = test_input_file("cysprot.fa");
my $aln;

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 19);

    $factory->executable($factory->method);

    my $version = $factory->version;
    ok($version);
    $aln = $factory->align($inputfilename);
    ok($aln);
    is( $aln->num_sequences, 7);

    my $str = Bio::SeqIO->new('-file'   => test_input_file("cysprot.fa"),
                              '-format' => 'Fasta');
    my @seq_array =();

    while ( my $seq = $str->next_seq() ) {
        push (@seq_array, $seq) ;
    }

    my $seq_array_ref = \@seq_array;

    $aln = $factory->align($seq_array_ref);
    is $aln->num_sequences, 7;
    my $s1_perid = $aln->average_percentage_identity;
    cmp_ok(int($s1_perid), '>=', 42, '42 or 43 expected');

    for my $method ( grep { !/rough/ } $factory->methods ) {
        $factory->method($method);
        $aln = $factory->align($inputfilename);
        is $aln->num_sequences, 7;
        my $s1_perid = $aln->average_percentage_identity;
        ok($s1_perid);
    }

    SKIP: {
        skip("Tests require version 6 of MAFFT", 6) unless $factory->_version6;
        $factory->localpair(1);
        $aln = $factory->align( $inputfilename );
        is $aln->num_sequences, 7;
        $s1_perid = $aln->average_percentage_identity;
        ok($s1_perid);

        $factory->globalpair(1);
        throws_ok { $aln = $factory->align( $inputfilename ) }
                  qr/You can't specify more than one of/,
                  'More than one alignment method throws';

        my @extra_params = qw/ localpair 1 maxiterate 10000 /;
        $factory = Bio::Tools::Run::Alignment::MAFFT->new(@params, @extra_params);
        isa_ok $factory,'Bio::Tools::Run::Alignment::MAFFT';
        $aln = $factory->align( $inputfilename );
        is $aln->num_sequences, 7;
        $s1_perid = $aln->average_percentage_identity;
        ok($s1_perid);
    }
}
