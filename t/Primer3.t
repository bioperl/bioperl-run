#-*-Perl-*-
## $Id$

# test for Bio::Tools::Run::Primer3
# written by Rob Edwards

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('Primer3');
    test_begin(-tests => 9,
               -requires_module => 'Clone');
    use_ok('Bio::Tools::Run::Primer3');
    use_ok('Bio::SeqIO');
}

my ($seqio, $seq, $primer3, $args, $results, $num_results);
$seqio=Bio::SeqIO->new(-file => test_input_file('Primer3.fa'));
$seq=$seqio->next_seq;

ok $primer3 = Bio::Tools::Run::Primer3->new(-seq=>$seq);

SKIP: {
    test_skip(-requires_executable => $primer3,
              -tests => 6);
    my $v = $primer3->version;
    skip("Primer3 wrapper only supports Primer3 v1", 6) if
        !defined $v || $v ge '1.2';
    $args = $primer3->arguments;
    is($$args{'PRIMER_SEQUENCE_ID'}, "(string, optional) an id. Optional. Note must be present if PRIMER_FILE_FLAG is set");
    ok $primer3->add_targets('PRIMER_SEQUENCE_ID'=>'test seq');
    ok $results = $primer3->run;
    is( $num_results = $results->number_of_results,5);
    is( $results->{input_options}->{PRIMER_SEQUENCE_ID},'test seq');
    like( $primer3->program_name, qr/primer3/, 'program_name');
}
