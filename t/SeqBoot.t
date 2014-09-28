# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = test_debug();

BEGIN {
    use Bio::Root::Test;
  use Bio::Tools::Run::Build::Test;
  skipall_unless_feature('[Phylo]SeqBoot');
    test_begin(-tests => 9);
	use_ok('Bio::Tools::Run::Phylo::Phylip::SeqBoot');
	use_ok('Bio::AlignIO');
}
my $verbose = $DEBUG;
my @params = ('-verbose'  => $verbose,
	      'idlength'  =>30,
	      'datatype'  =>'GENEFREQ',
	      'REPLICATES'=>50);

my $sb_factory = Bio::Tools::Run::Phylo::Phylip::SeqBoot->new(@params);

SKIP: {
    test_skip(-requires_executable => $sb_factory,
              -tests => 7);
	isa_ok $sb_factory,'Bio::Tools::Run::Phylo::Phylip::SeqBoot';
	
	my $dt= 'SEQUENCE';
	$sb_factory->datatype($dt);
	
	is $sb_factory->datatype, "SEQUENCE", "couldn't set datatype parameter";
	
	$sb_factory->replicates(2);
	
	is $sb_factory->replicates, 2, "coludn't set number of replicates";
	
	
	my $bequiet = $verbose > 0 ? 0 : 1;
	
	$sb_factory->quiet($bequiet);  # Suppress protpars messages to terminal 
	
	my $inputfilename = test_input_file("protpars.phy");
	
	my $aln_ref = $sb_factory->run($inputfilename);
	
	is scalar(@{$aln_ref}), 2;
	
	my $aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>"phylip")->next_aln;
	
	$aln_ref = $sb_factory->run($aln);
	
	is scalar(@{$aln_ref}), 2;
	
	# Test name preservation and restoration:
	$inputfilename = test_input_file("longnames.aln");
	$aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>'clustalw')->next_aln;
	my ($aln_safe, $ref_name) =$aln->set_displayname_safe();
	$aln_ref = $sb_factory->run($aln_safe);
	my $first=shift @{$aln_ref};
	is $first->get_seq_by_pos(3)->id(), "S000000003", "ailed to  assign serial names";
	my $aln_restored=$first->restore_displayname($ref_name);
	is $aln_restored->get_seq_by_pos(3)->id(), "Smik_Contig1103.1", "fail to restore original names";

}
