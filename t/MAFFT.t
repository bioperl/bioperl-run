# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($NUMTESTS $DEBUG);
$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;
BEGIN { 
    eval { require Test; };
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 15; 
    plan tests => $NUMTESTS; 
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

use Bio::Tools::Run::Alignment::MAFFT;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::Root::IO;

END {     
    for ( $Test::ntest..$NUMTESTS ) {
	skip("TCoffee program not found. Skipping.\n",1);
    }
}

ok(1);

my @params = (-verbose => $DEBUG, 'QUIET' => 1);
my  $factory = Bio::Tools::Run::Alignment::MAFFT->new(@params);

ok ($factory =~ /Bio::Tools::Run::Alignment::MAFFT/);


my $inputfilename = Bio::Root::IO->catfile("t","data","cysprot.fa");
my $aln;


my $mafft_present = $factory->executable();
unless ($mafft_present) {
    warn "mafft program not found. Skipping tests $Test::ntest to $NUMTESTS.\n";
    exit(0);
}

$mafft_present = $factory->executable($factory->method);
unless ($mafft_present) {
    warn "mafft program ", $factory->method, " not found. Skipping tests $Test::ntest to $NUMTESTS.\n";
    exit(0);
}

my $version = $factory->version;
ok ($version >= 3.89, 1, "Code tested only on t_coffee versions > 3.89" );
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
ok(int($s1_perid), 42);

for my $method ( grep { !/rough/ } $factory->methods ) {
    $factory->method($method);
    $aln = $factory->align($inputfilename);
    ok $aln->no_sequences, 7;
    my $s1_perid = $aln->average_percentage_identity;
    ok($s1_perid);
    
}
