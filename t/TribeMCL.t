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
    $NTESTS = 12;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::TribeMCL;
use Bio::SearchIO;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("TribeMCL program not found. Skipping. (Be sure you have the TribeMCL package",1);
    }
}

my $blast_out = Bio::Root::IO->catfile("t","data","TribeMCL.bls");

#do from raw blast output
my @params=('inputtype'=>'blastfile',I=>'3.0');
my $fact = Bio::Tools::Run::TribeMCL->new(@params);

ok $fact->isa('Bio::Tools::Run::TribeMCL');
unless ($fact->matrix_executable){
    warn("Tribe Matrix program not found. Skipping tests $Test::ntest to $NTESTS.\n");
                exit 0;
}
unless ($fact->mcl_executable){
    warn("Markov Clustering program not found. Skipping tests $Test::ntest to $NTESTS.\n");
                exit 0;
}

my $bequiet = 1 ;
$fact->quiet($bequiet);

my $fam = $fact->run($blast_out);
ok ($fam->[0]->[0], 'ENSANGP00000008485');
ok ($fam->[1]->[0], 'COE1_MOUSE');
ok ($fam->[2]->[0], 'ENSANGP00000019582');

#do from searchio

my $sio = Bio::SearchIO->new(-format=>'blast',
                             -file=>$blast_out);

@params=('inputtype'=>'searchio',I=>'3.0');
$fact = Bio::Tools::Run::TribeMCL->new(@params);

ok $fact->isa('Bio::Tools::Run::TribeMCL');
$bequiet =1 ;
$fact->quiet($bequiet);

$fam = $fact->run($sio);
ok ($fam->[0]->[0], 'ENSANGP00000008485');
ok ($fam->[1]->[0], 'COE1_MOUSE');
ok ($fam->[2]->[0], 'ENSANGP00000019582');

@params=('inputtype'=>'pairs',I=>'3.0');
$fact = Bio::Tools::Run::TribeMCL->new(@params);
ok $fact->isa('Bio::Tools::Run::TribeMCL');
$bequiet =1 ;
$fact->quiet($bequiet);

$fam = $fact->run( [[qw(ENSP00000257547 ENSP00000261659 1 50)],
		    [qw(O42187 ENSP00000257547 1 119)]]);
ok ($fam->[0]->[0], 'ENSP00000257547');
ok ($fam->[0]->[1], 'ENSP00000261659');
ok ($fam->[0]->[2], 'O42187');
