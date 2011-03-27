# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use vars qw($DEBUG );
$DEBUG = test_debug();

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 11);
	use_ok('Bio::Tools::Run::Phylo::Phylip::ProtPars');
	use_ok('Bio::Tools::Run::Alignment::Clustalw');
}

my @params = ('threshold'=>10,'jumble'=>'17,10',outgroup=>2,'idlength'=>10);
my $tree_factory = Bio::Tools::Run::Phylo::Phylip::ProtPars->new(@params);
isa_ok $tree_factory,'Bio::Tools::Run::Phylo::Phylip::ProtPars';

SKIP: {
	test_skip(-requires_executable => $tree_factory,
			  -tests => 8);
	
	my $threshold = 5;
	$tree_factory->threshold($threshold);
	
	my $new_threshold= $tree_factory->threshold();
	is $new_threshold, 5, "set factory parameter";
	
	my $outgroup = 3;
	$tree_factory->outgroup($outgroup);
	
	my $new_outgroup= $tree_factory->outgroup();
	is $new_outgroup, 3, "set factory parameter";
	
	
	my $jumble = "7,5";
	$tree_factory->jumble($jumble);
	
	my $new_jumble= $tree_factory->jumble();
	is $new_jumble, "7,5", "set factory parameter";
	
	my $bequiet = 1;
	$tree_factory->quiet($bequiet);  # Suppress protpars messages to terminal 
	
	my $inputfilename = test_input_file("protpars.phy");
	my $tree;
	
	$tree = $tree_factory->create_tree($inputfilename);
	
	# have to sort the since there is polytomy here.
	my @nodes = sort { $a->id cmp $b->id } grep { $_->id } $tree->get_nodes();
	is ($nodes[2]->id, 'SINFRUP002', 
		"creating tree by protpars");
	
	$inputfilename = test_input_file("cysprot1a.fa");
	@params = ('ktuple' => 2, 'matrix' => 'BLOSUM', 
		   -verbose => -1);
	my  $align_factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
	
	SKIP: {
		test_skip(-requires_executable => $align_factory,
				  -tests => 4);
		
		my $aln = $align_factory->align($inputfilename);
		
		$tree = $tree_factory->create_tree($aln);
		
		@nodes = sort { defined $a->id && defined $b->id && $a->id cmp $b->id } $tree->get_nodes();
		is (scalar(@nodes),5,
			"creating tree by protpars");
		
		# test name preservation and restoration:
		@params = ('threshold'=>10,'jumble'=>'7,5',outgroup=>2,'idlength'=>10);
		$tree_factory = Bio::Tools::Run::Phylo::Phylip::ProtPars->new(@params);
		$tree_factory->quiet($bequiet);  # Suppress protpars messages to terminal 
		$inputfilename = test_input_file("longnames.aln");
		$aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>'clustalw')->next_aln;
		my ($aln_safe, $ref_name) =$aln->set_displayname_safe(3);
		$tree = $tree_factory->create_tree($aln_safe);
		@nodes = sort { $a->id cmp $b->id } $tree->get_nodes();
		is (scalar(@nodes),27,
			"creating tree by protpars");
		is ($nodes[12]->id, 'S01',"assign serial names");
		foreach my $nd (@nodes){
		  $nd->id($ref_name->{$nd->id_output}) if $nd->is_Leaf;
		}
		is ($nodes[12]->id, 'Spar_21273',"restore original names");
	}
}
