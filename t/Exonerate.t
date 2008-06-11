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
    $NTESTS = 89;
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
my $verbose = $ENV{BIOPERLDEBUG} || -1;

my $query= Bio::Root::IO->catfile("t","data","exonerate_cdna.fa");
my $target= Bio::Root::IO->catfile("t","data","exonerate_genomic.fa");
my $targetrev= Bio::Root::IO->catfile("t","data","exonerate_genomic_rev.fa");

my $run = Bio::Tools::Run::Alignment::Exonerate->new(-verbose  => $verbose,
						     arguments=>'--model est2genome --bestn 1');
exit(0) unless( $run->executable );

ok $run->isa('Bio::Tools::Run::Alignment::Exonerate');
ok $run->version;

my $searchio= $run->run($query,$target);
ok $searchio->isa("Bio::SearchIO");
my @expect = ( [qw(29   268     4 242)],# target-start t-end query-start q-end
	       [qw(526  646   243 363)],
	       [qw(964 1056   364 456)],
	       [qw(1770 1923  457 610)],
	       [qw(2250 2479  611 840 )],
	       [qw(2565 2687  841 963)],
	       [qw(2769 3074  964 1279)] );
RESULT: while(my $result = $searchio->next_result){
  while( my $hit = $result->next_hit ) {
#      ok($hit->start('hit'), 29);
#      ok($hit->end('hit'), 3074);
      my $i = 0;
    while( my $hsp = $hit->next_hsp ) {	
	ok ($hsp->hit->strand, 1);
	ok ($hsp->query->strand, 1);
	ok ($hsp->hit->start,$expect[$i]->[0]);
	ok ($hsp->hit->end,$expect[$i]->[1]);
	ok ($hsp->query->start,$expect[$i]->[2]);
	ok ($hsp->query->end,$expect[$i]->[3]);	
	$i++;
	if( $verbose > 0 ) {
	    warn("TARGET:", $hsp->hit->location->to_FTstring, "\n");
	    warn("QUERY: ",$hsp->query->location->to_FTstring, "\n");
	}
    }
      last; # only show a single HIT
  }
  last;
}


$searchio= $run->run($query,$targetrev);
ok $searchio->isa("Bio::SearchIO");
my @expectrev;
if ($run->version >= 2 ) { # latest 2.0.0 version
    @expectrev = ( # target-start t-end query-start q-end
		   [qw(2834 3073  4 242)],
		   [qw(2456 2576  243 363)],
		   [qw(2046 2138  364 456)],
		   [qw(1179 1332  457 610)],
		   [qw(623 852    611 840)],
		   [qw(415  537   841 963)],
		   [qw(28   333   964 1279)]
	);
} else { # version 1.4.0 presumably
    @expectrev = ( # target-start t-end query-start q-end
		   [qw(28   333   964 1279)],
		   [qw(415  537   841 963)],
		   [qw(623 852    611 840)],
		   [qw(1179 1332  457 610)],
		   [qw(2046 2138  364  456)],
		   [qw(2456 2576  243 363)],
		   [qw(2834 3073  4 242)]
	);

}
RESULT: while(my $result = $searchio->next_result){
    while( my $hit = $result->next_hit ) {
      my $i = 0;
    while( my $hsp = $hit->next_hsp ) {	
	ok ($hsp->hit->strand, -1);
	ok ($hsp->query->strand, 1);
	ok ($hsp->hit->start,$expectrev[$i]->[0]);
	ok ($hsp->hit->end,$expectrev[$i]->[1]);
	ok ($hsp->query->start,$expectrev[$i]->[2]);
	ok ($hsp->query->end,$expectrev[$i]->[3]);	
	$i++;
	if( $verbose > 0 ) {
	    warn("TARGET:", $hsp->hit->location->to_FTstring, "\n");
	    warn("QUERY: ",$hsp->query->location->to_FTstring, "\n");
	}
    }
      last; # only show a single HIT
  }
  last;
}

