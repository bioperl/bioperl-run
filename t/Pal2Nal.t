# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 9);
    use_ok('Bio::Tools::Run::Alignment::Pal2Nal');
}

# setup input files etc
my $nucleotide_filename = test_input_file('pal2nal.nuc');
my $protein_alignfilename = test_input_file('pal2nal.aln');
my $mxlib = test_input_file('transfac.dat');

my $factory = Bio::Tools::Run::Alignment::Pal2Nal->new();

isa_ok($factory, 'Bio::Tools::Run::Alignment::Pal2Nal');

# test default factory values
is ($factory->program_dir, $ENV{'PAL2NALDIR'}, 'program_dir returned correct default');
is ($factory->program_name(), 'pal2nal.pl', 'Correct exe default name');

# test the program itself
SKIP: {
	test_skip(-requires_executable => $factory,
		  -tests => 5);
    
	# Run Pal2Nal with a protein alignment file and a multi-fasta nucleotide
	# file
	ok my $aln1 = $factory->run($protein_alignfilename, $nucleotide_filename);
	
	# or with Bioperl objects
	use_ok('Bio::AlignIO');
	use_ok('Bio::SeqIO');
	my $ai = Bio::AlignIO->new(-file => $protein_alignfilename);
	my $protein_bio_simplalign = $ai->next_aln;
	my $si = Bio::SeqIO->new(-file => $nucleotide_filename, -format => 'fasta');
	my $nucleotide_bio_seq1 = $si->next_seq;
	my $nucleotide_bio_seq2 = $si->next_seq;
	ok my $aln2 = $factory->run($protein_bio_simplalign,
								[$nucleotide_bio_seq1, $nucleotide_bio_seq2]);
	
	is_deeply($aln1, $aln2);
}
