# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;
BEGIN {
    eval { require Test; };
    if( $@ ) { 
	use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 15;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::Phylo::Phylip::ProtDist;
use Bio::Tools::Run::Phylo::Phylip::Neighbor;
END {     
    for ( $Test::ntest..$NTESTS ) {
	skip("Neighbor not found. Skipping.",1);
    }
}

my $verbose = -1;
my @params = ('type'    =>'UPGMA',
#	      'outgroup'=>2,
	      'lowtri'  =>1,
	      'upptri'  =>1,
	      'subrep'  =>1,
	      'jumble'  =>13);

my $tree_factory = Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);
unless ($tree_factory->executable) {
    warn("neighbor program not found. Skipping tests $Test::ntest to $NTESTS.\n") if( $DEBUG);    
    exit 0;
}
ok $tree_factory->isa('Bio::Tools::Run::Phylo::Phylip::Neighbor');

my $type= "NEIGHBOR";
$tree_factory->type($type);
my $new_type = $tree_factory->type();
ok $new_type, "NEIGHBOR", " couldn't set factory parameter";

my $outgroup= 1;
$tree_factory->outgroup($outgroup);
my $new_outgroup = $tree_factory->outgroup();
ok $new_outgroup, 1, " couldn't set factory parameter";

my $lowtri= 0;
$tree_factory->lowtri($lowtri);
my $new_lowtri = $tree_factory->lowtri();
ok $new_lowtri, 0, " couldn't set factory parameter";

my $upptri= 0;
$tree_factory->upptri($upptri);
my $new_upptri = $tree_factory->upptri();
ok $new_upptri, 0, " couldn't set factory parameter";

my $subrep= 0;
$tree_factory->subrep($subrep);
my $new_subrep = $tree_factory->subrep();
ok $new_subrep,0, " couldn't set factory parameter";

my $jumble= 1;
$tree_factory->jumble($jumble);
my $new_jumble = $tree_factory->jumble();
ok $new_jumble, 1, " couldn't set factory parameter";

my $bequiet = 1;
$tree_factory->quiet($bequiet);  # Suppress protpars messages to terminal 

my $inputfilename = Bio::Root::IO->catfile("t","data","neighbor.dist");
my $tree;

($tree) = $tree_factory->create_tree($inputfilename);

my ($tip1) = $tree->find_node('SINFRUP002');
ok($tip1);
ok($tip1->id, 'SINFRUP002');
# get the OTHER node
my ($other) = grep { $_->id ne $tip1->id } $tip1->ancestor->each_Descendent;
ok($other);
ok($other->id, 'ENSP000002');
ok($tip1->branch_length, '0.07854');
ok($other->branch_length,'0.20141');

my ($hum) = $tree->find_node('SINFRUP001');
ok($hum->branch_length,'0.08462');

$inputfilename = Bio::Root::IO->catfile("t","data","protpars.phy");
my  $protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new();
$protdist_factory->quiet(1);

my ($matrix) = $protdist_factory->create_distance_matrix($inputfilename);

$tree_factory->outgroup('ENSP000003');
($tree) = $tree_factory->create_tree($matrix);

my @nodes = sort { defined $a->id && 
		    defined $b->id &&
		    $a->id cmp $b->id } $tree->get_nodes();
ok ($nodes[1]->id, 'ENSP000003',"failed creating tree by neighbor");

# Test name preservation and restoration:
$inputfilename = Bio::Root::IO->catfile("t","data","longnames.aln");
my $aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>'clustalw')->next_aln;
my ($aln_safe, $ref_name) =$aln->set_displayname_safe(3);
$protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new();
($matrix) = $protdist_factory->create_distance_matrix($aln_safe);
$tree_factory->outgroup(undef);
($tree) = $tree_factory->create_tree($matrix);
@nodes = sort { defined $a->id && 
		    defined $b->id &&
		    $a->id cmp $b->id } $tree->get_nodes();
ok ($nodes[12]->id, 'S01',"failed to assign serial names");
foreach my $nd (@nodes){
  $nd->id($ref_name->{$nd->id_output}) if $nd->is_Leaf;
}
ok ($nodes[12]->id, 'Spar_21273',"failed to restore original names");



