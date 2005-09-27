# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($NUMTESTS);
BEGIN { 
    eval { require Test; };
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 22; 
    plan tests => $NUMTESTS; 
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

use Bio::Tools::Run::Alignment::TCoffee;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::Root::IO;

END {     
    for ( $Test::ntest..$NUMTESTS ) {
	skip("TCoffee program not found. Skipping.\n",1);
    }
    unlink("t_coffee.log");
}

ok(1);

my @params;
my  $factory = Bio::Tools::Run::Alignment::TCoffee->new(@params);

ok ($factory =~ /Bio::Tools::Run::Alignment::TCoffee/);

my $ktuple = 3;
$factory->ktuple($ktuple);

my $new_ktuple = $factory->ktuple();
ok $new_ktuple, 3, " couldn't set factory parameter";

my $what_matrix = $factory->matrix();
ok $what_matrix, qr/BLOSUM/i, "couldn't get factory parameter";

my $bequiet = 1;
$factory->quiet($bequiet);  # Suppress tcoffee messages to terminal

my $inputfilename = Bio::Root::IO->catfile("t","data","cysprot.fa");
my $aln;


my $coffee_present = $factory->executable();
unless ($coffee_present) {
    warn "tcoffee program not found. Skipping tests $Test::ntest to $NUMTESTS.\n";
    exit(0);
}
my $version = $factory->version;
ok ($version >= 1.22, 1, "Code tested only on t_coffee versions > 1.22" );
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


my $profile1 = Bio::Root::IO->catfile("t","data","cysprot1a.msf");
my $profile2 = Bio::Root::IO->catfile("t","data","cysprot1b.msf");
$aln = $factory->profile_align($profile1,$profile2);
ok $aln->no_sequences, 7;

my $str1 = Bio::AlignIO->new(-file=> Bio::Root::IO->catfile("t","data","cysprot1a.msf"));
my $aln1 = $str1->next_aln();
ok $aln1->no_sequences, 3;

my $str2 = Bio::AlignIO->new(-file=> Bio::Root::IO->catfile("t","data","cysprot1b.msf"));
my $aln2 = $str2->next_aln();
ok $aln2->no_sequences, 4;

$aln = $factory->profile_align($aln1,$aln2);
ok $aln->no_sequences, 7;


$str1 = Bio::AlignIO->new(-file=> Bio::Root::IO->catfile("t","data","cysprot1a.msf"));
$aln1 = $str1->next_aln();
$str2 = Bio::SeqIO->new(-file=> Bio::Root::IO->catfile("t","data","cysprot1b.fa"));
my $seq = $str2->next_seq();

ok $aln1->no_sequences, 3;
ok( int($aln1->average_percentage_identity), 39);
$aln = $factory->profile_align($aln1,$seq);
ok( $aln->no_sequences, 4);
if( $version <= 1.22 ) {
    ok( $aln->overall_percentage_identity > 18);    
    ok( int($aln->average_percentage_identity), 44);
} else {
    my $overall = int($aln->overall_percentage_identity);
    ok( $overall >=21 && $overall <= 23, 1, 'expect 21 >= val >= 23');
    my $avg = int($aln->average_percentage_identity);
    ok( $avg == 47 || $avg ==48, 1, 'expect 47 or 48');    
}

# test new 'run' generic running of factory

$aln = $factory->run('-type' => 'profile',
		     '-profile' => $aln1,
		     '-seq'  => Bio::Root::IO->catfile("t","data","cysprot1b.fa"));

ok( $aln->no_sequences, 7);
if( $version <= 1.22 ) {
    ok( $aln->overall_percentage_identity > 18);    
    ok( int($aln->average_percentage_identity), 44);
} else {
    my $overall = int $aln->overall_percentage_identity;
    ok($overall == 14 || $overall == 13,1,'expect 13 or 14');
    my $avg = int($aln->average_percentage_identity);
    ok($avg == 41 || $avg == 42, 1, 'expect 41 or 42');    
}

$aln = $factory->run('-type' => 'align',
		     '-seq'  => Bio::Root::IO->catfile("t","data","cysprot.fa"));
ok ($aln->no_sequences, 7);
ok ($aln->percentage_identity,$s1_perid); #calculated before
