# -*-Perl-*-
## Bioperl Test Harness Script for Modules


use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 5;
    plan tests => $NTESTS;
}
use Bio::Tools::Run::Alignment::Exonerate;
use Bio::Root::IO;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("exonerate program not found. Skipping. (Be sure you have installed Exonerate)",1);
    }
}

ok(1);
my $verbose = -1;

my $query= Bio::Root::IO->catfile("t","data","exonerate_cdna.fa");
my $target= Bio::Root::IO->catfile("t","data","exonerate_genomic.fa");
my $run = Bio::Tools::Run::Alignment::Exonerate->new(arguments=>'--model est2genome --bestn 10');
exit unless( $run->executable );

my $searchio= $run->run($query,$target);
ok $searchio->isa("Bio::SearchIO");
RESULT: while(my $result = $searchio->next_result){
  while( my $hit = $result->next_hit ) {
    while( my $hsp = $hit->next_hsp ) {
      ok $hsp->start,1143;
      ok $hsp->end,1168;
      last RESULT;
    }
  }
}
unless (defined $run->executable) {
    warn("Exonerate program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

ok $run->isa('Bio::Tools::Run::Alignment::Exonerate');
my $bequiet = 1;

