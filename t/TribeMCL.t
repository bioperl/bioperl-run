# -*-Perl-*-
## Bioperl Test Harness Script for Modules


use strict;
BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('TribeMCL');
    test_begin(-tests => 24,
               -requires_module => 'Algorithm::Diff');
    use_ok('Bio::Tools::Run::TribeMCL');
    use_ok('Bio::SearchIO');
}

my $blast_out = test_input_file("TribeMCL.bls");

#do from raw blast output
my @params=('inputtype'=>'blastfile',I=>'3.0');
my $fact = Bio::Tools::Run::TribeMCL->new(@params);

SKIP : {
    unless ($fact){
        skip("Couldn't create a TribeMCL wrapper",22);
    }
    my $desc = test_input_file("TribeMCL.desc");
    $fact->description_file($desc);
    
    isa_ok $fact,'Bio::Tools::Run::TribeMCL';
    unless ($fact->matrix_executable){
        skip("Tribe Matrix program not found. Skipping tests...", 21);
    }
    unless ($fact->mcl_executable){
        skip("Markov Clustering program not found. Skipping tests...",21);
    }
    
    my $bequiet = 1 ;
    $fact->quiet($bequiet);
    
    my ($fam) = $fact->run($blast_out);
    my @members = $fam->get_members;
    isa_ok $fam,"Bio::Cluster::SequenceFamily";
    isa_ok $members[0],"Bio::Seq";
    is ($members[0]->id, 'ENSANGP00000008485');
    is ($members[1]->id, 'ENSDRMP3263');
    is ($members[2]->id, 'ENSMUSP00000026170');
    is ($fam->description,'ubiquitin');
    is ($fam->annotation_score,45.0549450549451);
    is ($fam->size,91);
    
    #do from searchio
    
    my $sio = Bio::SearchIO->new(-format=>'blast',
                                 -file=>$blast_out);
    
    @params=('inputtype'=>'searchio',I=>'3.0');
    $fact = Bio::Tools::Run::TribeMCL->new(@params);
    $fact->description_file($desc);
    
    isa_ok $fact,'Bio::Tools::Run::TribeMCL';
    $bequiet =1 ;
    $fact->quiet($bequiet);
    
    ($fam) = $fact->run($sio);
    isa_ok $fam,"Bio::Cluster::SequenceFamily";
    isa_ok $members[0],"Bio::Seq";
    is ($members[0]->id, 'ENSANGP00000008485');
    is ($members[1]->id, 'ENSDRMP3263');
    is ($members[2]->id, 'ENSMUSP00000026170');
    is ($fam->description,'ubiquitin');
    is ($fam->annotation_score,45.0549450549451);
    is ($fam->size,91);
    
    @params=('inputtype'=>'pairs',I=>'3.0');
    $fact = Bio::Tools::Run::TribeMCL->new(@params);
    isa_ok $fact,'Bio::Tools::Run::TribeMCL';
    $bequiet =1 ;
    $fact->quiet($bequiet);
    
    ($fam) = $fact->run( [[qw(ENSP00000257547 ENSP00000261659 1 50)],
                [qw(O42187 ENSP00000257547 1 119)]]);
    @members = $fam->get_members;
    is ($members[0]->id, 'ENSP00000257547');
    is ($members[1]->id, 'ENSP00000261659');
    is ($members[2]->id, 'O42187');
}
