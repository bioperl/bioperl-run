# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$
#

use strict;
use constant NUMTESTS => 15;
BEGIN { 
    eval { require Test; };
    if( $@ ) {
	use lib 't';
    }
    use Test;
    plan tests => NUMTESTS; 
}

END { 
    foreach( $Test::ntest..NUMTESTS) {
	skip('Blast or env variables not installed correctly',1);
    }
    unlink('blastreport.out');
}

use Bio::Tools::Run::Alignment::StandAloneFasta;
use Bio::SeqIO;

ok(1);
my $verbose = -1;

my @params = ( 'b' =>'15', 'O' =>'resultfile', 'm'=>'1',"program"=>'fasta33');
my  $factory = Bio::Tools::Run::Alignment::StandAloneFasta->new('-verbose' => $verbose,
						     @params);
ok $factory;
my $inputfilename = Bio::Root::IO->catfile("t","data","fasta.fa");

my $fasta_present = $factory->executable();
if( ! $fasta_present ) {
    skip('Fasta  not installed',1);
    exit;
} else { 
    ok($fasta_present);
}
my $lib = Bio::Root::IO->catfile("t","data","fastalib.fa");
$factory->library($lib);
my ($fastareport) = $factory->run($inputfilename);
my $result = $fastareport->next_result;
my $hit    = $result->next_hit();
my $hsp    = $hit->next_hsp();
ok $hsp->algorithm, 'FASTN';
ok $hsp->num_identical, 2982;
ok $hsp->length, 2982;

$factory->program('ssearch34');
($fastareport) = $factory->run($inputfilename);
$result = $fastareport->next_result;
$hit    = $result->next_hit();
$hsp    = $hit->next_hsp();
ok $hsp->algorithm, 'SMITH-WATERMAN';
ok $hsp->num_identical, 2982;
ok $hsp->length, 2982;

$factory->program('fastx34');
$factory->library(Bio::Root::IO->catfile("t","data","fastaprot.fa"));
($fastareport) = $factory->run($inputfilename);
$result = $fastareport->next_result;
$hit    = $result->next_hit();
$hsp    = $hit->next_hsp();
ok $hsp->algorithm, 'FASTX';
ok $hsp->num_identical, 994;
ok $hsp->length, 994;

my $sio = Bio::SeqIO->new(-file=>$inputfilename,-format=>"fasta");
my $seq = $sio->next_seq;

#test with objects
($fastareport) = $factory->run($seq);
$result = $fastareport->next_result;
$hit    = $result->next_hit();
$hsp    = $hit->next_hsp();
ok $hsp->algorithm, 'FASTX';
ok $hsp->num_identical, 994;
ok $hsp->length, 994;
