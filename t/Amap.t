# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
use vars qw($NUMTESTS);
BEGIN { 
    eval { require Test; };
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 6; 
    plan tests => $NUMTESTS; 
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

use Bio::Tools::Run::Alignment::Amap;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::Root::IO;

END {     
    for ( $Test::ntest..$NUMTESTS ) {
	skip("Amap program not found. Skipping.\n",1);
    }
}

ok(1);

my @params = ();
my $factory = Bio::Tools::Run::Alignment::Amap->new(@params);
my $inputfilename = Bio::Root::IO->catfile("t","data","cysprot.fa");
my $aln;

my $present = $factory->executable();
unless ($present && -e $present	) {
    warn "amap program not found. Skipping tests $Test::ntest to $NUMTESTS.\n";
    exit(0);
}
my $version = $factory->version;
ok ($version >= 2.0, 1, "Code tested only on amap versions >= 2.0" );
$aln = $factory->align($inputfilename);
ok($aln);
ok( $aln->no_sequences, 7);

my $str = Bio::SeqIO->new('-file' => 
			  Bio::Root::IO->catfile("t","data","cysprot.fa"), 
			  '-format' => 'Fasta');
my @seq_array =();

while ( my $seq = $str->next_seq() ) {
    push (@seq_array, $seq) ;
}

my $seq_array_ref = \@seq_array;

$aln = $factory->align($seq_array_ref);
ok $aln->no_sequences, 7;
my $s1_perid = $aln->average_percentage_identity;
ok(int($s1_perid), 45);
