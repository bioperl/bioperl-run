# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = $ENV{'BIOPERLDEBUG'} || -1;

BEGIN {
    eval { require Test; };
    if( $@ ) { 
	use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 11;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::Phylo::Phylip::ProtDist;
use Bio::Tools::Run::Alignment::Clustalw; 

END {     
    for ( $Test::ntest..$NTESTS ) {
	skip("ProtDist not found. Skipping.",1);
    }
}

ok(1);
my $verbose = $DEBUG;
my @params = (
	      'idlength'  =>30,
	      'model'     =>'pam',
	      'gencode'   =>'U',
	      'category'  =>'H',
	      'probchange'=>'0.4',
	      'trans'     =>'5',
	      'freq'      =>'0.25,0.5,0.125,0.125');

my $dist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
unless($dist_factory->executable){
    warn("Protdist program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

ok $dist_factory->isa('Bio::Tools::Run::Phylo::Phylip::ProtDist');

my $model = 'KIMURA';
$dist_factory->model($model);

my $new_model= $dist_factory->model();
ok $new_model , 'KIMURA', " couldn't set factory parameter";

my $gencode = 'M';
$dist_factory->gencode($gencode);

my $new_gencode= $dist_factory->gencode();
ok $new_gencode, 'M', " couldn't set factory parameter";


my $category= "H";
$dist_factory->category($category);

my $new_category= $dist_factory->category();
ok $new_category, "H", " couldn't set factory parameter";

my $probchange= 0.4;
$dist_factory->probchange($probchange);

my $new_probchange= $dist_factory->probchange();
ok $new_probchange, 0.4, " couldn't set factory parameter";

my $trans= 5;
$dist_factory->trans($trans);

my $new_trans= $dist_factory->trans();
ok $new_trans, 5, " couldn't set factory parameter";

my $freq= "0.25,0.5,0.125,0.125";
$dist_factory->freq($freq);

my $new_freq= $dist_factory->freq();
ok $new_freq, "0.25,0.5,0.125,0.125", " couldn't set factory parameter";

my $bequiet = 1;
$dist_factory->quiet($bequiet);  # Suppress protpars messages to terminal 

my $inputfilename = Bio::Root::IO->catfile("t","data","protpars.phy");
my $matrix;
my $protdist_present = $dist_factory->executable();
unless ($protdist_present) {
    warn("protdist program not found. Skipping tests $Test::ntest to $NTESTS.\n") if($DEBUG);    
    exit 0;
}
$dist_factory->verbose($verbose);
$matrix = $dist_factory->create_distance_matrix($inputfilename);

ok($matrix->get_entry('ENSP000003','SINFRUP001'),0.27708);

$inputfilename = Bio::Root::IO->catfile("t","data","cysprot.fa");
@params = ('ktuple' => 2, 'matrix' => 'BLOSUM', 
	   -verbose => $verbose);
my  $align_factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);

exit(0) unless $align_factory->executable();

my $aln = $align_factory->align($inputfilename);
$matrix = $dist_factory->create_distance_matrix($aln);

ok (int($matrix->get_entry('ALEU_HORVU','ALEU_HORVU')),0,
    "failed creating distance matrix");
ok(sprintf("%.2f",$matrix->get_entry('CATL_HUMAN','CYS1_DICDI'),'1.30', "failed creating distance matrix"));
