#-*-Perl-*-
## $Id$

# test for Bio::Tools::Run::Primer3
# written by Rob Edwards

use strict;

use vars qw($ERROR);
use constant NUMTESTS => 8;

BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't','..';
    }
    use Test;
    
    eval {  require Clone; };
    if ( $@ ) {
        warn("Clone not installed. This means that the module is not usable. Skipping tests\n");
        $ERROR = 1;
    }
    
    plan tests => NUMTESTS;
}

END {
    for ( $Test::ntest..NUMTESTS ) {
        skip("primer3 program not found, or missing dependencies. Skipping. You can get this from http://www-genome.wi.mit.edu/genome_software/other/primer3.html",1);
    }
}

exit 0 if $ERROR;

require Bio::Tools::Run::Primer3;
use Bio::SeqIO;
ok(1);
my ($seqio, $seq, $primer3, $args, $results, $num_results);
$seqio=Bio::SeqIO->new(-file=>'t/data/Primer3.fa');
$seq=$seqio->next_seq;
ok ref($seq) eq "Bio::Seq", 1, "Couldn't read the sequence in t/data/dna1.fa";
ok $primer3 = Bio::Tools::Run::Primer3->new(-seq=>$seq);

if( ! $primer3->executable ) {
    $primer3->program_name('primer3_core');
}

unless ($primer3->executable) {
    warn("Primer3 program not found. Skipping tests $Test::ntest to NUMTESTS.\n");
   exit 0;
}


$args = $primer3->arguments;
ok($$args{'PRIMER_SEQUENCE_ID'}, "(string, optional) an id. Optional. Note must be present if PRIMER_FILE_FLAG is set");
ok $primer3->add_targets('PRIMER_SEQUENCE_ID'=>'test seq');
ok $results = $primer3->run;
ok( $num_results = $results->number_of_results,5);
ok( $results->{input_options}->{PRIMER_SEQUENCE_ID} eq 'test seq');
