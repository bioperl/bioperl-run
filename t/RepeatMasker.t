# -*-Perl-*-
## Bioperl Test Harness Script for Modules
# $Id$

use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 10;
    plan tests => $NTESTS;
}
use Bio::Tools::Run::RepeatMasker;
use Bio::SeqIO;

my $inputfilename= Bio::Root::IO->catfile(qw(t data repeatmasker.fa));
my $createdfile = Bio::Root::IO->catfile(qw(t data repeatmasker.fa.out));

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("RepeatMasker program not found or incorrectly configured. Skipping.",1);
    }
	unlink($createdfile);
}

my $verbose = $ENV{'BIOPERLDEBUG'} ? 1 : 0;
my @params=("species" => "mammal", 'noint' => 1, 'qq' => 1, '-verbose' => $verbose);
my $fact = Bio::Tools::Run::RepeatMasker->new(@params);
$fact->quiet(1);
if( ! $fact->executable ) { 
    warn("RepeatMasker program not found. Skipping tests $Test::ntest to $NTESTS.\n");

    exit(0);
}

ok ($fact->species, 'mammal');
ok ($fact->noint,1);

my $in  = Bio::SeqIO->new(-file => $inputfilename , '-format' => 'fasta');
my $seq = $in->next_seq();
my @feats = $fact->mask($seq);

my $version = $fact->version;

ok ($feats[0]->feature1->primary_tag, "Simple_repeat");
ok ($feats[0]->feature1->source_tag, "RepeatMasker");
ok ($feats[0]->feature2->seq_id, "(TTAGGG)n");

if( $version =~ /open-(\S+)/) {
    my $num = $1;
    if( $num ge '3.1.0' ) {
	ok ($feats[0]->feature1->start, 1337);
	ok ($feats[0]->feature1->end, 1411);
	ok ($feats[0]->feature1->strand, 1);
	ok ($feats[1]->feature1->start, 1710);
	ok ($feats[1]->feature1->end, 2052);
    } elsif( $num ge  '3.0.8' ) {
	ok ($feats[0]->feature1->start, 1337);
	ok ($feats[0]->feature1->end, 1407);
	ok ($feats[0]->feature1->strand, 1);
	ok ($feats[1]->feature1->start, 1712);
	ok ($feats[1]->feature1->end, 2225);    
    } else {
	skip("unknown RepeatMasker Version, cannot test",1) for ( 1..3);
    }
} else {
    ok ($feats[0]->feature1->start, 1337);
    ok ($feats[0]->feature1->end, 1407);
    ok ($feats[0]->feature1->strand, 1);
}




