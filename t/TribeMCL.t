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
    $NTESTS = 22;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::TribeMCL;
use Bio::SearchIO;

END {
    for ( $Test::ntest..$NTESTS ) {
        skip("TribeMCL program not found. Skipping. (Be sure you have the TribeMCL package",1);
    }
}

eval{
    require "Algorithm/Diff.pm";
};
if($@){
    warn("Need Algorithm::Diff to run TribeMCL");
    exit(0);
}

my $blast_out = Bio::Root::IO->catfile("t","data","TribeMCL.bls");

#do from raw blast output
my @params=('inputtype'=>'blastfile',I=>'3.0');
my $fact = Bio::Tools::Run::TribeMCL->new(@params);

unless ($fact){
        warn("Couldn't create a TribeMCL wrapper");
            exit(0);
}
my $desc = Bio::Root::IO->catfile("t","data","TribeMCL.desc");
$fact->description_file($desc);

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

my ($fam) = $fact->run($blast_out);
my @members = $fam->get_members;
ok $fam->isa("Bio::Cluster::SequenceFamily");
ok $members[0]->isa("Bio::Seq");
ok ($members[0]->id, 'ENSANGP00000008485');
ok ($members[1]->id, 'ENSDRMP3263');
ok ($members[2]->id, 'ENSMUSP00000026170');
ok ($fam->description,'ubiquitin');
ok ($fam->annotation_score,45.0549450549451);
ok ($fam->size,91);

#do from searchio

my $sio = Bio::SearchIO->new(-format=>'blast',
                             -file=>$blast_out);

@params=('inputtype'=>'searchio',I=>'3.0');
$fact = Bio::Tools::Run::TribeMCL->new(@params);
$fact->description_file($desc);

ok $fact->isa('Bio::Tools::Run::TribeMCL');
$bequiet =1 ;
$fact->quiet($bequiet);

($fam) = $fact->run($sio);
ok $fam->isa("Bio::Cluster::SequenceFamily");
ok $members[0]->isa("Bio::Seq");
ok ($members[0]->id, 'ENSANGP00000008485');
ok ($members[1]->id, 'ENSDRMP3263');
ok ($members[2]->id, 'ENSMUSP00000026170');
ok ($fam->description,'ubiquitin');
ok ($fam->annotation_score,45.0549450549451);
ok ($fam->size,91);

@params=('inputtype'=>'pairs',I=>'3.0');
$fact = Bio::Tools::Run::TribeMCL->new(@params);
ok $fact->isa('Bio::Tools::Run::TribeMCL');
$bequiet =1 ;
$fact->quiet($bequiet);

($fam) = $fact->run( [[qw(ENSP00000257547 ENSP00000261659 1 50)],
		    [qw(O42187 ENSP00000257547 1 119)]]);
@members = $fam->get_members;
ok ($members[0]->id, 'ENSP00000257547');
ok ($members[1]->id, 'ENSP00000261659');
ok ($members[2]->id, 'O42187');
