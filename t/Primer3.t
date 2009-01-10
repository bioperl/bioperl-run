#-*-Perl-*-
## $Id$

# test for Bio::Tools::Run::Primer3
# written by Rob Edwards

use strict;

BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 8,
               -requires_module => 'Clone');
    use_ok('Bio::Tools::Run::Primer3');
    use_ok('Bio::SeqIO');
}

my ($seqio, $seq, $primer3, $args, $results, $num_results);
$seqio=Bio::SeqIO->new(-file => test_input_file('Primer3.fa'));
$seq=$seqio->next_seq;

ok $primer3 = Bio::Tools::Run::Primer3->new(-seq=>$seq);

SKIP: {
    test_skip(-requires_executable => $primer3,,
              -tests => 5);
    
    $args = $primer3->arguments;
    is($$args{'PRIMER_SEQUENCE_ID'}, "(string, optional) an id. Optional. Note must be present if PRIMER_FILE_FLAG is set");
    ok $primer3->add_targets('PRIMER_SEQUENCE_ID'=>'test seq');
    ok $results = $primer3->run;
    is( $num_results = $results->number_of_results,5);
    is( $results->{input_options}->{PRIMER_SEQUENCE_ID},'test seq');
}
