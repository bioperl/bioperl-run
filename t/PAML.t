# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 28,
			   -requires_module => 'IO::String');
	use_ok('Bio::Tools::Phylo::PAML'); # PAML parser
	use_ok('Bio::Tools::Run::Phylo::PAML::Codeml');
	use_ok('Bio::Tools::Run::Phylo::PAML::Yn00');
	use_ok('Bio::AlignIO');
}

my $testnum;
my $verbose = 0;

## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run. 

my $inpaml = Bio::Tools::Phylo::PAML->new(-file => 
					 test_input_file('codeml.mlc'));

ok($inpaml);

my $codeml = Bio::Tools::Run::Phylo::PAML::Codeml->new
    (-params => {'runmode' => -2,
		 'seqtype' => 1,
		 'model'   => 0,
		 'alpha'   => '0',
		 'omega'   => 0.4,
		 'kappa'    => 2,		 
		 'CodonFreq'=> 2,
		 'NSsites'   => 0,
		 'model'    => 0,		 
	     },
     -verbose => $verbose);

SKIP: {
	test_skip(-requires_executable => $codeml,
		  -tests => 23);

	my $in = Bio::AlignIO->new(-format => 'phylip',
				  -file   => test_input_file('gf-s85.phylip'));
	my $aln = $in->next_aln;
	$codeml->alignment($aln);
	my ($rc,$results) = $codeml->run();
	
	is($rc,1); 
	
	if( ! defined $results ) { 
		skip('No results', 22);
	}
	
	my $result = $results->next_result;
	if( ! defined $result ) { 
		skip('No result', 22);
	}
	
	my $MLmatrix = $result->get_MLmatrix;
	
	my ($vnum) = ($result->version =~ /(\d+(\.\d+)?)/);
	# PAML 2.12 results
	if( $vnum == 3.12 ) {
		is($MLmatrix->[0]->[1]->{'dN'}, 0.0693);
		is($MLmatrix->[0]->[1]->{'dS'},1.1459);
		is($MLmatrix->[0]->[1]->{'omega'}, 0.0605);
		is($MLmatrix->[0]->[1]->{'S'}, 273.5);
		is($MLmatrix->[0]->[1]->{'N'}, 728.5);
		is($MLmatrix->[0]->[1]->{'t'}, 1.0895);
	 
		skip($MLmatrix->[0]->[1]->{'lnL'}, "I don't know what this should be, if you run this part, email the list so we can update the value");
		
	} elsif( $vnum >= 3.13  && $vnum < 4) {
	# PAML 2.13 results
		is($MLmatrix->[0]->[1]->{'dN'}, 0.0713);
		is($MLmatrix->[0]->[1]->{'dS'},1.2462);
		is(sprintf("%.4f",$MLmatrix->[0]->[1]->{'omega'}), 0.0572);
		is($MLmatrix->[0]->[1]->{'S'}, 278.8);
		is($MLmatrix->[0]->[1]->{'N'}, 723.2);
		is(sprintf("%.4f",$MLmatrix->[0]->[1]->{'t'}), 1.1946);
		skip($MLmatrix->[0]->[1]->{'lnL'}, "I don't know what this should be, if you run this part, email the list so we can update the value");
	
	} elsif( $vnum == 4 ) {
		is($MLmatrix->[0]->[1]->{'dN'}, 0.0713);
		is($MLmatrix->[0]->[1]->{'dS'},1.2462);
		is(sprintf("%.4f",$MLmatrix->[0]->[1]->{'omega'}), 0.0572);
		is($MLmatrix->[0]->[1]->{'S'}, 278.8);
		is($MLmatrix->[0]->[1]->{'N'}, 723.2);
		is(sprintf("%.4f",$MLmatrix->[0]->[1]->{'t'}), 1.1946);
		is($MLmatrix->[0]->[1]->{'lnL'}, -1929.935243);
	
	} else { 
		for( 1..7) { 
		skip("Can't test the result output, don't know about PAML version ".$result->version,1);
		}
	} 
	
	unlike($codeml->error_string, qr/Error/); # we don't expect any errors;
	
	my $yn00 = Bio::Tools::Run::Phylo::PAML::Yn00->new();
	$yn00->alignment($aln);
	($rc,$results) = $yn00->run();
	is($rc,1);
	if( ! defined $results ) { 
		exit(0);
	}
	$result = $results->next_result;
	$MLmatrix = $result->get_MLmatrix;
	
	is($MLmatrix->[0]->[1]->{'dN'}, 0.0846);
	is($MLmatrix->[0]->[1]->{'dS'}, 1.0926);
	is($MLmatrix->[0]->[1]->{'omega'}, 0.0774);
	is($MLmatrix->[0]->[1]->{'S'}, 278.4);
	is($MLmatrix->[0]->[1]->{'N'}, 723.6);
	is($MLmatrix->[0]->[1]->{'t'}, 1.0941);
	
	unlike($yn00->error_string, qr/Error/); # we don't expect any errors;
	
	$codeml = Bio::Tools::Run::Phylo::PAML::Codeml->new
		(-params => { 'alpha' => 1.53 },
		 -verbose => $verbose);
	
	ok($codeml);
	
	
	# AAML
	my $cysaln = Bio::AlignIO->new(-format => 'msf',
					   -file => test_input_file('cysprot.msf'))->next_aln;
	
	my $cystre = Bio::TreeIO->new(-format => 'newick',
					  -file  => test_input_file('cysprot.raxml.tre'))->next_tree;
	ok($cysaln);
	ok($cystre); 
	
	$codeml = Bio::Tools::Run::Phylo::PAML::Codeml->new
		(
		 -verbose => 0,     
		 -tree   => $cystre,
		 -params => { 'runmode' => 0, # provide a usertree
			  'seqtype' => 2, # AMINO ACIDS,
			  'model'   => 0, # one dN/dS rate
			  'NSsites' => 0, # one -- swap this with 1, 2, 3 etc
			  'clock'   => 0, # 0 = no clock
			  'getSE'   => 1, # get Standard Error
			  'fix_blength' => 0, # use initial BLengths
			  'ncatG' => 1, #increase approrpriately for NSsites,
		 },
		 -alignment => $cysaln,
		 -save_tempfiles => 1,
		);
    test_skip(-requires_executable => $codeml,
              -tests => 14);
	ok($codeml);
	
	($rc,$results) = $codeml->run();
	is($rc,1);
	

	unless( defined $results ) { 
		warn($codeml->error_string, "\n");
		skip('No results',1);
	}
	
	$result = $results->next_result;
	unless( defined $result ) { 
		skip('No result',1);
	}
	
	($vnum) = ($result->version =~ /(\d+(\.\d+)?)/);
	for my $tree ( $result->get_trees ) {
		my $node = $tree->find_node(-id => 'CATL_HUMAN');
		if( $vnum == 4 ) {
		is($node->branch_length, '0.216223');
		} else {	
		is($node->branch_length, '0.216223');
		}
	}
}
