# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;
BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 21,
			   -requires_modules => [qw(XML::Twig Bio::Factory::EMBOSS)]);
	use_ok('Bio::Root::IO');
	use_ok('Bio::SeqIO');
	use_ok('Bio::AlignIO');
}

my $compseqoutfile = test_output_file();
my $wateroutfile   = test_output_file();
my $consoutfile    = test_output_file();
my $verbose = test_debug();

## End of black magic.
##
## Insert additional test code below but remember to change
## the print "1..x\n" in the BEGIN block to reflect the
## total number of tests that will be run.

my $factory = Bio::Factory::EMBOSS->new(-verbose => $verbose);
ok($factory);

SKIP: {
	my $compseqapp = $factory->program('compseq');
	
	skip('EMBOSS not installed',17) if !$compseqapp;
	
	my $version = $factory->version;
	
	my %input = ( '-word' => 4,
			  '-sequence' => test_input_file('dna1.fa'),
			  '-outfile' => $compseqoutfile);
	$compseqapp->run(\%input);
	ok(-e $compseqoutfile);
	
	my $water = $factory->program('water');
	
	ok ($water);
	
	# testing in-memory use of 
	my $in = Bio::SeqIO->new(-format => 'fasta',
				-file =>  test_input_file('cysprot1a.fa'));
	my $seq = $in->next_seq();
	ok($seq);
	my @amino;
	$in = Bio::SeqIO->new(-format => 'fasta',
				 -file =>  test_input_file('amino.fa'));
	while( my $s = $in->next_seq) {
		push @amino, $s;
	}
	
	my %expected;
	if( $version ge '2.8.0' ) {
		$water->run({ '-asequence' => $seq,
			  '-bsequence'    => \@amino,
			  '-gapopen'   => '10.0',
			  '-gapextend' => '0.5',
			  '-outfile'   => $wateroutfile});
		%expected = ( 'alnlen' => 394,
			  'opid'    => '30.71',
			  'apid'    => '40.20');
			  
	} else {
		$water->run({ '-sequencea' => $seq,
			  '-seqall'    => \@amino,
			  '-gapopen'   => '10.0',
			  '-gapextend' => '0.5',
			  '-outfile'   => $wateroutfile});
		%expected = ( 'alnlen' => 339,
			  'opid'    => '33.04',
			  'apid'    => '40.58');
	
	}
	ok(-e $wateroutfile);
	
	my $alnin = Bio::AlignIO->new(-format => 'emboss',
					-file   => $wateroutfile);
	
	ok( $alnin);
	my $aln = $alnin->next_aln;
	ok($aln);
	is($aln->length, 43);
	is($aln->overall_percentage_identity, 100);
	is($aln->average_percentage_identity, 100);
	
	my ($first) = $aln->each_seq();
	ok($first->seq(), 'SCWSFSTTGNVEGQHFISQNKLVSLSEQNLVDCDHECMEYEGE');
	$aln = $alnin->next_aln;
	ok($aln);
	
	is($aln->length, $expected{'alnlen'});
	is(sprintf("%.2f",$aln->overall_percentage_identity), $expected{'opid'});
	is(sprintf("%.2f",$aln->average_percentage_identity), $expected{'apid'});
	
	
	my $cons = $factory->program('cons');
	$cons->verbose(0);
	$in = Bio::AlignIO->new(-format => 'msf',
				   -file   => Bio::Root::IO->catfile('t',
								 'data',
								 'cysprot.msf'));
	my $aln2 = $in->next_aln;
	if( $version ge '2.8.0' ) {
		$cons->run({ '-sequence' => $aln2,
			 '-outseq'   => $consoutfile});
	} else {
		$cons->run({ '-msf'   => $aln2,
			 '-outseq'=> $consoutfile});
	}
	ok(-e $consoutfile);
	
	
	# testing acd parsing and EMBOSSacd methods
	
	$compseqapp = $factory->program('compseq');
	
	exit unless $compseqapp->acd;
	ok my $acd = $compseqapp->acd;
	is $compseqapp->acd->name, 'compseq';
	ok my $compseq_mand_acd = $compseqapp->acd->mandatory;
	ok $compseq_mand_acd->mandatory->qualifier('-word');
	is $compseq_mand_acd->mandatory->qualifier('-supper1'), 0;
	is $acd->qualifier('-ppppppp'), 0;
	ok $acd->qualifier('-reverse');
	is $acd->category('-reverse'), 'optional';
	like $acd->values('-reverse'), qr/Yes\/No/;
	is $acd->descr('-reverse'), 'Set this to be true if you also wish to also count words in the reverse complement of a nucleic sequence.';
	is $acd->unnamed('-reverse'), 0;
	is $acd->default('-reverse'), 'No';
}

	__END__
	
	## comparing input and ACD qualifiers
	## commented out because verbose > 1 prints error messages
	## that would confuse users running tests
	
	$compseqapp->verbose(1);
	%input = ( '-word' => 4,
		   '-outfile' => $compseqoutfile);
	eval {
		my $a = $compseqapp->run(\%input);
	};
	ok 1 if $@; # '-sequence' missing
	
	 %input = ( '-word' => 4,
		   '-incorrect_option' => 'no value',
		   '-sequence' => Bio::Root::IO->catfile('t',
							 'data',
							 'dna1.fa'),
		   '-outfile' => $compseqoutfile);
	eval {
		$compseqapp->run(\%input);
	};
	ok 1 if $@; # -incorrect_option is incorrect	
