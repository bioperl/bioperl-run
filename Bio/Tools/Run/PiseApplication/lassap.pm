
=head1 NAME

Bio::Tools::Run::PiseApplication::lassap

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::lassap

      Bioperl class for:

	LASSAP	LArge Scale Sequence compArison Package (Glemet, Codani)

      Parameters:


		lassap (String)
			

		method (Excl)
			Comparison method

		dna_comp (Switch)
			nucleic/nucleic comparison

		query1 (Sequence)
			First sequence

		query2 (Sequence)
			Second sequence

		dr1 (String)
			

		dr2 (String)
			

		control_options (Paragraph)
			Control options

		matrix (Excl)
			Scoring matrix

		gap_options (Paragraph)
			Gap and cutoff options

		gapo (Integer)
			Gap open penalty

		gape (Integer)
			Gap extension penalty

		cutoff (Integer)
			Cutoff

		blast_options (Paragraph)
			Blast options

		Expect (Integer)
			Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (E)

		E2 (Integer)
			E2 (expected number of HSPs that will be found when comparing two sequences that each have the same length)

		S2 (Integer)
			S2 (cutoff score which defines HSPs)

		W (Integer)
			W (length of words identified in the query sequence)

		T (Integer)
			T (neighborhood word score threshold)

		X (Integer)
			X (word hit extension drop-off score)

		fasta_options (Paragraph)
			FASTA options

		ktup (Integer)
			ktup : sensitivity and speed of the search

		init1 (Switch)
			sequences ranked by the z-score based on the init1 score

		noopt (Switch)
			no limited optimization

		linlen (Integer)
			output line length for sequence alignments (< 200)

		SWR_options (Paragraph)
			SWR (Smith-Waterman randomized) options

		ran (Integer)
			How many randomizations

		BM_options (Paragraph)
			BM (Boyer-Moore) options

		swap (Switch)
			Don't test for inclusion of query1 into query2

		KBEST_options (Paragraph)
			KBEST (K best alignments) options

		k (Integer)
			How many best alignments

		frames_options (Paragraph)
			Frames options

		frame_query1 (List)
			First sequence frames

		frame_query2 (List)
			Second sequence frames

		gc (Excl)
			Genetic Code

		output_options (Paragraph)
			Output options

		view_alignment (Switch)
			View alignment (not available for all methods)

		scut (Integer)
			Score cutoff

		pcut (Integer)
			Probability cutoff

		max (Integer)
			Maximum retained

		flag_algo_opt (String)
			

		flag_algo_opt2 (String)
			

		gc2 (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::lassap;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $lassap = Bio::Tools::Run::PiseApplication::lassap->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::lassap object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $lassap = $factory->program('lassap');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::lassap.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lassap.pm

    $self->{COMMAND}   = "lassap";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "LASSAP";

    $self->{DESCRIPTION}   = "LArge Scale Sequence compArison Package";

    $self->{AUTHORS}   = "Glemet, Codani";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"lassap",
	"method",
	"dna_comp",
	"query1",
	"query2",
	"dr1",
	"dr2",
	"control_options",
	"frames_options",
	"output_options",
	"flag_algo_opt",
	"flag_algo_opt2",
	"gc2",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"lassap",
	"method", 	# Comparison method
	"dna_comp", 	# nucleic/nucleic comparison
	"query1", 	# First sequence
	"query2", 	# Second sequence
	"dr1",
	"dr2",
	"control_options", 	# Control options
	"matrix", 	# Scoring matrix
	"gap_options", 	# Gap and cutoff options
	"gapo", 	# Gap open penalty
	"gape", 	# Gap extension penalty
	"cutoff", 	# Cutoff
	"blast_options", 	# Blast options
	"Expect", 	# Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (E)
	"E2", 	# E2 (expected number of HSPs that will be found when comparing two sequences that each have the same length)
	"S2", 	# S2 (cutoff score which defines HSPs)
	"W", 	# W (length of words identified in the query sequence)
	"T", 	# T (neighborhood word score threshold)
	"X", 	# X (word hit extension drop-off score)
	"fasta_options", 	# FASTA options
	"ktup", 	# ktup : sensitivity and speed of the search
	"init1", 	# sequences ranked by the z-score based on the init1 score
	"noopt", 	# no limited optimization
	"linlen", 	# output line length for sequence alignments (< 200)
	"SWR_options", 	# SWR (Smith-Waterman randomized) options
	"ran", 	# How many randomizations
	"BM_options", 	# BM (Boyer-Moore) options
	"swap", 	# Don't test for inclusion of query1 into query2
	"KBEST_options", 	# KBEST (K best alignments) options
	"k", 	# How many best alignments
	"frames_options", 	# Frames options
	"frame_query1", 	# First sequence frames
	"frame_query2", 	# Second sequence frames
	"gc", 	# Genetic Code
	"output_options", 	# Output options
	"view_alignment", 	# View alignment (not available for all methods)
	"scut", 	# Score cutoff
	"pcut", 	# Probability cutoff
	"max", 	# Maximum retained
	"flag_algo_opt",
	"flag_algo_opt2",
	"gc2",

    ];

    $self->{TYPE}  = {
	"lassap" => 'String',
	"method" => 'Excl',
	"dna_comp" => 'Switch',
	"query1" => 'Sequence',
	"query2" => 'Sequence',
	"dr1" => 'String',
	"dr2" => 'String',
	"control_options" => 'Paragraph',
	"matrix" => 'Excl',
	"gap_options" => 'Paragraph',
	"gapo" => 'Integer',
	"gape" => 'Integer',
	"cutoff" => 'Integer',
	"blast_options" => 'Paragraph',
	"Expect" => 'Integer',
	"E2" => 'Integer',
	"S2" => 'Integer',
	"W" => 'Integer',
	"T" => 'Integer',
	"X" => 'Integer',
	"fasta_options" => 'Paragraph',
	"ktup" => 'Integer',
	"init1" => 'Switch',
	"noopt" => 'Switch',
	"linlen" => 'Integer',
	"SWR_options" => 'Paragraph',
	"ran" => 'Integer',
	"BM_options" => 'Paragraph',
	"swap" => 'Switch',
	"KBEST_options" => 'Paragraph',
	"k" => 'Integer',
	"frames_options" => 'Paragraph',
	"frame_query1" => 'List',
	"frame_query2" => 'List',
	"gc" => 'Excl',
	"output_options" => 'Paragraph',
	"view_alignment" => 'Switch',
	"scut" => 'Integer',
	"pcut" => 'Integer',
	"max" => 'Integer',
	"flag_algo_opt" => 'String',
	"flag_algo_opt2" => 'String',
	"gc2" => 'String',

    };

    $self->{FORMAT}  = {
	"lassap" => {
		"perl" => '"lspcalc-1.0a"',
	},
	"method" => {
		"perl" => ' " -M $value" ',
	},
	"dna_comp" => {
	},
	"query1" => {
		"perl" => '" $query1" ',
	},
	"query2" => {
		"perl" => '" $query2" ',
	},
	"dr1" => {
		"perl" => '" -dr "',
	},
	"dr2" => {
		"perl" => '" -dr "',
	},
	"control_options" => {
	},
	"matrix" => {
	},
	"gap_options" => {
	},
	"gapo" => {
		"perl" => '(defined $value && $value ne $vdef)? " -gapo $value" : "" ',
	},
	"gape" => {
		"perl" => '(defined $value && $value ne $vdef)? " -gape $value" : "" ',
	},
	"cutoff" => {
		"perl" => '(defined $value && $value ne $vdef)? " -cutoff $value" : "" ',
	},
	"blast_options" => {
	},
	"Expect" => {
		"perl" => '(defined $value && $value != $vdef )? " -E $value":""',
	},
	"E2" => {
		"perl" => '(defined $E2)? " -E2 $value":""',
	},
	"S2" => {
		"perl" => '(defined $value)? " -S2 $value":""',
	},
	"W" => {
		"perl" => '(defined $value)? " -W $value":""',
	},
	"T" => {
		"perl" => '(defined $value )? " -T $value":""',
	},
	"X" => {
		"perl" => '(defined $value)? " -X $value":""',
	},
	"fasta_options" => {
	},
	"ktup" => {
		"perl" => '(defined $value && $value ne $vdef)? " -ktup $value":""',
	},
	"init1" => {
		"perl" => '($value)? " -1":""',
	},
	"noopt" => {
		"perl" => '($value)? " -o":""',
	},
	"linlen" => {
		"perl" => '(defined $value && $value ne $vdef)? " -w $value":""',
	},
	"SWR_options" => {
	},
	"ran" => {
		"perl" => '(defined $value && $value ne $vdef)? " -ran $value":""',
	},
	"BM_options" => {
	},
	"swap" => {
		"perl" => '($value)? " -swap":""',
	},
	"KBEST_options" => {
	},
	"k" => {
		"perl" => '($value && $value ne $vdef)? " -K $value":""',
	},
	"frames_options" => {
	},
	"frame_query1" => {
		"perl" => '($value && $value ne $vdef)? "-f $value" : ""',
	},
	"frame_query2" => {
		"perl" => '($value && $value ne $vdef)? "-f $value" : ""',
	},
	"gc" => {
		"perl" => ' ($value && $value ne $vdef)? " -gc $value" : "" ',
	},
	"output_options" => {
	},
	"view_alignment" => {
		"perl" => '($value)? " -a" : "" ',
	},
	"scut" => {
		"perl" => '(defined $value)? " -scut $value" : "" ',
	},
	"pcut" => {
		"perl" => '(defined $value)? " -pcut $value" : "" ',
	},
	"max" => {
		"perl" => '(defined $value)? " -max $value" : "" ',
	},
	"flag_algo_opt" => {
		"perl" => '($algo_opt)? " -O [ " : ""',
	},
	"flag_algo_opt2" => {
		"perl" => '($algo_opt)? " ] " : ""',
	},
	"gc2" => {
		"perl" => '" -gc $gc"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"query1" => [8],
	"query2" => [8],

    };

    $self->{GROUP}  = {
	"lassap" => 0,
	"method" => 1,
	"query1" => 10,
	"query2" => 15,
	"dr1" => 7,
	"dr2" => 12,
	"matrix" => 6,
	"gap_options" => 3,
	"gapo" => 3,
	"gape" => 3,
	"cutoff" => 3,
	"blast_options" => 3,
	"Expect" => 3,
	"E2" => 3,
	"S2" => 3,
	"W" => 3,
	"T" => 3,
	"X" => 3,
	"fasta_options" => 3,
	"ktup" => 3,
	"init1" => 3,
	"noopt" => 3,
	"linlen" => 3,
	"SWR_options" => 3,
	"ran" => 3,
	"BM_options" => 3,
	"swap" => 3,
	"KBEST_options" => 3,
	"k" => 3,
	"frame_query1" => 8,
	"frame_query2" => 13,
	"gc" => 9,
	"view_alignment" => 20,
	"scut" => 20,
	"pcut" => 20,
	"max" => 20,
	"flag_algo_opt" => 2,
	"flag_algo_opt2" => 4,
	"gc2" => 14,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"lassap",
	"output_options",
	"dna_comp",
	"control_options",
	"frames_options",
	"method",
	"flag_algo_opt",
	"KBEST_options",
	"k",
	"gap_options",
	"gapo",
	"gape",
	"cutoff",
	"blast_options",
	"Expect",
	"E2",
	"S2",
	"W",
	"T",
	"X",
	"fasta_options",
	"ktup",
	"init1",
	"noopt",
	"linlen",
	"SWR_options",
	"ran",
	"BM_options",
	"swap",
	"flag_algo_opt2",
	"matrix",
	"dr1",
	"frame_query1",
	"gc",
	"query1",
	"dr2",
	"frame_query2",
	"gc2",
	"query2",
	"view_alignment",
	"scut",
	"pcut",
	"max",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"lassap" => 1,
	"method" => 0,
	"dna_comp" => 0,
	"query1" => 0,
	"query2" => 0,
	"dr1" => 1,
	"dr2" => 1,
	"control_options" => 0,
	"matrix" => 0,
	"gap_options" => 0,
	"gapo" => 0,
	"gape" => 0,
	"cutoff" => 0,
	"blast_options" => 0,
	"Expect" => 0,
	"E2" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"X" => 0,
	"fasta_options" => 0,
	"ktup" => 0,
	"init1" => 0,
	"noopt" => 0,
	"linlen" => 0,
	"SWR_options" => 0,
	"ran" => 0,
	"BM_options" => 0,
	"swap" => 0,
	"KBEST_options" => 0,
	"k" => 0,
	"frames_options" => 0,
	"frame_query1" => 0,
	"frame_query2" => 0,
	"gc" => 0,
	"output_options" => 0,
	"view_alignment" => 0,
	"scut" => 0,
	"pcut" => 0,
	"max" => 0,
	"flag_algo_opt" => 1,
	"flag_algo_opt2" => 1,
	"gc2" => 1,

    };

    $self->{ISCOMMAND}  = {
	"lassap" => 1,
	"method" => 0,
	"dna_comp" => 0,
	"query1" => 0,
	"query2" => 0,
	"dr1" => 0,
	"dr2" => 0,
	"control_options" => 0,
	"matrix" => 0,
	"gap_options" => 0,
	"gapo" => 0,
	"gape" => 0,
	"cutoff" => 0,
	"blast_options" => 0,
	"Expect" => 0,
	"E2" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"X" => 0,
	"fasta_options" => 0,
	"ktup" => 0,
	"init1" => 0,
	"noopt" => 0,
	"linlen" => 0,
	"SWR_options" => 0,
	"ran" => 0,
	"BM_options" => 0,
	"swap" => 0,
	"KBEST_options" => 0,
	"k" => 0,
	"frames_options" => 0,
	"frame_query1" => 0,
	"frame_query2" => 0,
	"gc" => 0,
	"output_options" => 0,
	"view_alignment" => 0,
	"scut" => 0,
	"pcut" => 0,
	"max" => 0,
	"flag_algo_opt" => 0,
	"flag_algo_opt2" => 0,
	"gc2" => 0,

    };

    $self->{ISMANDATORY}  = {
	"lassap" => 0,
	"method" => 1,
	"dna_comp" => 0,
	"query1" => 1,
	"query2" => 1,
	"dr1" => 0,
	"dr2" => 0,
	"control_options" => 0,
	"matrix" => 1,
	"gap_options" => 0,
	"gapo" => 0,
	"gape" => 0,
	"cutoff" => 0,
	"blast_options" => 0,
	"Expect" => 0,
	"E2" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"X" => 0,
	"fasta_options" => 0,
	"ktup" => 0,
	"init1" => 0,
	"noopt" => 0,
	"linlen" => 0,
	"SWR_options" => 0,
	"ran" => 0,
	"BM_options" => 0,
	"swap" => 0,
	"KBEST_options" => 0,
	"k" => 0,
	"frames_options" => 0,
	"frame_query1" => 0,
	"frame_query2" => 0,
	"gc" => 0,
	"output_options" => 0,
	"view_alignment" => 0,
	"scut" => 0,
	"pcut" => 0,
	"max" => 0,
	"flag_algo_opt" => 0,
	"flag_algo_opt2" => 0,
	"gc2" => 0,

    };

    $self->{PROMPT}  = {
	"lassap" => "",
	"method" => "Comparison method",
	"dna_comp" => "nucleic/nucleic comparison",
	"query1" => "First sequence",
	"query2" => "Second sequence",
	"dr1" => "",
	"dr2" => "",
	"control_options" => "Control options",
	"matrix" => "Scoring matrix",
	"gap_options" => "Gap and cutoff options",
	"gapo" => "Gap open penalty",
	"gape" => "Gap extension penalty",
	"cutoff" => "Cutoff",
	"blast_options" => "Blast options",
	"Expect" => "Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (E)",
	"E2" => "E2 (expected number of HSPs that will be found when comparing two sequences that each have the same length)",
	"S2" => "S2 (cutoff score which defines HSPs)",
	"W" => "W (length of words identified in the query sequence)",
	"T" => "T (neighborhood word score threshold)",
	"X" => "X (word hit extension drop-off score)",
	"fasta_options" => "FASTA options",
	"ktup" => "ktup : sensitivity and speed of the search",
	"init1" => "sequences ranked by the z-score based on the init1 score",
	"noopt" => "no limited optimization",
	"linlen" => "output line length for sequence alignments (< 200)",
	"SWR_options" => "SWR (Smith-Waterman randomized) options",
	"ran" => "How many randomizations",
	"BM_options" => "BM (Boyer-Moore) options",
	"swap" => "Don't test for inclusion of query1 into query2",
	"KBEST_options" => "KBEST (K best alignments) options",
	"k" => "How many best alignments",
	"frames_options" => "Frames options",
	"frame_query1" => "First sequence frames",
	"frame_query2" => "Second sequence frames",
	"gc" => "Genetic Code",
	"output_options" => "Output options",
	"view_alignment" => "View alignment (not available for all methods)",
	"scut" => "Score cutoff",
	"pcut" => "Probability cutoff",
	"max" => "Maximum retained",
	"flag_algo_opt" => "",
	"flag_algo_opt2" => "",
	"gc2" => "",

    };

    $self->{ISSTANDOUT}  = {
	"lassap" => 0,
	"method" => 0,
	"dna_comp" => 0,
	"query1" => 0,
	"query2" => 0,
	"dr1" => 0,
	"dr2" => 0,
	"control_options" => 0,
	"matrix" => 0,
	"gap_options" => 0,
	"gapo" => 0,
	"gape" => 0,
	"cutoff" => 0,
	"blast_options" => 0,
	"Expect" => 0,
	"E2" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"X" => 0,
	"fasta_options" => 0,
	"ktup" => 0,
	"init1" => 0,
	"noopt" => 0,
	"linlen" => 0,
	"SWR_options" => 0,
	"ran" => 0,
	"BM_options" => 0,
	"swap" => 0,
	"KBEST_options" => 0,
	"k" => 0,
	"frames_options" => 0,
	"frame_query1" => 0,
	"frame_query2" => 0,
	"gc" => 0,
	"output_options" => 0,
	"view_alignment" => 0,
	"scut" => 0,
	"pcut" => 0,
	"max" => 0,
	"flag_algo_opt" => 0,
	"flag_algo_opt2" => 0,
	"gc2" => 0,

    };

    $self->{VLIST}  = {

	"method" => ['BLAST','BLAST: blast (1.4)','BLSW','BLSW: a mix of blast and smith/waterman','FASTA','FASTA: fasta (2.0)','BM','BM: boyer-moore fast substring searches algorithm','SW','SW: Smith/Waterman','NW','NW: Needelman/Wunsh','SWR','SWR: Randomized SW (shuffling)','KBEST','KBEST: K best local alignments',],
	"control_options" => ['matrix','gap_options','blast_options','fasta_options','SWR_options','BM_options','KBEST_options',],
	"matrix" => ['NUC.4.4','NUC.4.4 (nucleotides)','BLOSUM50','BLOSUM50 (proteins)','BLOSUM62','BLOSUM62 (proteins)','PAM120','PAM120 (proteins)','PAM250','PAM250 (proteins)',],
	"gap_options" => ['gapo','gape','cutoff',],
	"blast_options" => ['Expect','E2','S2','W','T','X',],
	"fasta_options" => ['ktup','init1','noopt','linlen',],
	"SWR_options" => ['ran',],
	"BM_options" => ['swap',],
	"KBEST_options" => ['k',],
	"frames_options" => ['frame_query1','frame_query2','gc',],
	"frame_query1" => ['r','reverse strand (if nucleic-nucleic alignemnt)','a','all (6 frames) (if nucleic-protein)','t,','top (1,2,3) ("")','b,','bottom (-1, -2, -3) ("")','1,','1: first frame ("")','2,','2: second frame ("")','3,','3: third frame ("")','-1,','-1: first frame on reverse strand ("")','-2,','-2: second frame on reverse strand ("")','-3,','-3: third frame on reverse strand ("")',],
	"frame_query2" => ['r','reverse strand (if nucleic-nucleic alignemnt)','a','all (6 frames) (if nucleic-protein)','t,','top (1,2,3) ("")','b,','bottom (-1, -2, -3) ("")','1,','1: first frame ("")','2,','2: second frame ("")','3,','3: third frame ("")','-1,','-1: first frame on reverse strand ("")','-2,','-2: second frame on reverse strand ("")','-3,','-3: third frame on reverse strand ("")',],
	"gc" => ['1','Standard','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear',],
	"output_options" => ['view_alignment','scut','pcut','max',],
    };

    $self->{FLIST}  = {

	"matrix" => {
		'NUC.4.4' => '" -mn NUC.4.4"',
		'BLOSUM50' => '" -mp Blosum/BLOSUM50"',
		'PAM120' => '" -mp Pam/PAM120"',
		'PAM250' => '" -mp Pam/PAM250"',
		'BLOSUM62' => '" -mp Blosum/BLOSUM62"',

	},
    };

    $self->{SEPARATOR}  = {
	"frame_query1" => "'",
	"frame_query2" => "'",

    };

    $self->{VDEF}  = {
	"method" => 'SW',
	"dna_comp" => '0',
	"matrix" => 'BLOSUM62',
	"gapo" => '10',
	"gape" => '1',
	"cutoff" => '0',
	"Expect" => '10',
	"ktup" => '1',
	"noopt" => '0',
	"linlen" => '32',
	"ran" => '10',
	"swap" => '0',
	"k" => '10',
	"frame_query1" => ['1',],
	"frame_query2" => ['1',],
	"gc" => '1',
	"view_alignment" => '1',

    };

    $self->{PRECOND}  = {
	"lassap" => { "perl" => '1' },
	"method" => { "perl" => '1' },
	"dna_comp" => { "perl" => '1' },
	"query1" => { "perl" => '1' },
	"query2" => { "perl" => '1' },
	"dr1" => { "perl" => '1' },
	"dr2" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"gap_options" => { "perl" => '1' },
	"gapo" => { "perl" => '1' },
	"gape" => { "perl" => '1' },
	"cutoff" => { "perl" => '1' },
	"blast_options" => {
		"perl" => '$method eq "BLAST"',
	},
	"Expect" => {
		"perl" => '$method eq "BLAST"',
	},
	"E2" => {
		"perl" => '$method eq "BLAST"',
	},
	"S2" => {
		"perl" => '$method eq "BLAST"',
	},
	"W" => {
		"perl" => '$method eq "BLAST"',
	},
	"T" => {
		"perl" => '$method eq "BLAST"',
	},
	"X" => {
		"perl" => '$method eq "BLAST"',
	},
	"fasta_options" => {
		"perl" => '$method eq "FASTA"',
	},
	"ktup" => {
		"perl" => '$method eq "FASTA"',
	},
	"init1" => {
		"perl" => '$method eq "FASTA"',
	},
	"noopt" => {
		"perl" => '$method eq "FASTA"',
	},
	"linlen" => {
		"perl" => '$method eq "FASTA"',
	},
	"SWR_options" => {
		"perl" => '$method eq "SWR"',
	},
	"ran" => {
		"perl" => '$method eq "SWR"',
	},
	"BM_options" => {
		"perl" => '$method eq "BM"',
	},
	"swap" => {
		"perl" => '$method eq "BM"',
	},
	"KBEST_options" => {
		"perl" => '$method eq "KBEST"',
	},
	"k" => {
		"perl" => '$method eq "KBEST"',
	},
	"frames_options" => { "perl" => '1' },
	"frame_query1" => { "perl" => '1' },
	"frame_query2" => { "perl" => '1' },
	"gc" => {
		"perl" => '$frame_query1 && $frame_query1 ne "r"',
	},
	"output_options" => { "perl" => '1' },
	"view_alignment" => { "perl" => '1' },
	"scut" => { "perl" => '1' },
	"pcut" => { "perl" => '1' },
	"max" => { "perl" => '1' },
	"flag_algo_opt" => { "perl" => '1' },
	"flag_algo_opt2" => { "perl" => '1' },
	"gc2" => {
		"perl" => '$frame_query2 && $frame_query2 ne "r" && $gc',
	},

    };

    $self->{CTRL}  = {
	"matrix" => {
		"perl" => {
			'$dna_comp && ($matrix = "NUC.4.4") && 0' => "no message",
		},
	},
	"gapo" => {
		"perl" => {
			'defined $value && $value ne $vdef && ($algo_opt=1) && 0' => "no message",
		},
	},
	"gape" => {
		"perl" => {
			'(defined $value && $value ne $vdef&& ($algo_opt=1) && 0)' => "no message",
		},
	},
	"cutoff" => {
		"perl" => {
			'(defined $value && $value ne $vdef&& ($algo_opt=1) && 0)' => "no message",
		},
	},
	"Expect" => {
		"perl" => {
			'(defined $value && $value != $vdef && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"E2" => {
		"perl" => {
			'(defined $E2 && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"S2" => {
		"perl" => {
			'(defined $value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"W" => {
		"perl" => {
			'(defined $value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"T" => {
		"perl" => {
			'(defined $value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"X" => {
		"perl" => {
			'(defined $value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"ktup" => {
		"perl" => {
			'(defined $value && $value ne $vdef && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"init1" => {
		"perl" => {
			'($value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"noopt" => {
		"perl" => {
			'($value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"linlen" => {
		"perl" => {
			'(defined $value && $value ne $vdef && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"ran" => {
		"perl" => {
			'(defined $value && $value ne $vdef && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"swap" => {
		"perl" => {
			'($value && ($algo_opt=1) && 0)' => "no message",
		},
	},
	"k" => {
		"perl" => {
			'($value && $value ne $vdef && ($algo_opt=1) && 0)' => "no message",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"lassap" => 0,
	"method" => 0,
	"dna_comp" => 0,
	"query1" => 0,
	"query2" => 0,
	"dr1" => 0,
	"dr2" => 0,
	"control_options" => 0,
	"matrix" => 0,
	"gap_options" => 0,
	"gapo" => 0,
	"gape" => 0,
	"cutoff" => 0,
	"blast_options" => 0,
	"Expect" => 0,
	"E2" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"X" => 0,
	"fasta_options" => 0,
	"ktup" => 0,
	"init1" => 0,
	"noopt" => 0,
	"linlen" => 0,
	"SWR_options" => 0,
	"ran" => 0,
	"BM_options" => 0,
	"swap" => 0,
	"KBEST_options" => 0,
	"k" => 0,
	"frames_options" => 0,
	"frame_query1" => 0,
	"frame_query2" => 0,
	"gc" => 0,
	"output_options" => 0,
	"view_alignment" => 0,
	"scut" => 0,
	"pcut" => 0,
	"max" => 0,
	"flag_algo_opt" => 0,
	"flag_algo_opt2" => 0,
	"gc2" => 0,

    };

    $self->{ISSIMPLE}  = {
	"lassap" => 0,
	"method" => 1,
	"dna_comp" => 1,
	"query1" => 1,
	"query2" => 1,
	"dr1" => 0,
	"dr2" => 0,
	"control_options" => 0,
	"matrix" => 0,
	"gap_options" => 0,
	"gapo" => 0,
	"gape" => 0,
	"cutoff" => 0,
	"blast_options" => 0,
	"Expect" => 0,
	"E2" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"X" => 0,
	"fasta_options" => 0,
	"ktup" => 0,
	"init1" => 0,
	"noopt" => 0,
	"linlen" => 0,
	"SWR_options" => 0,
	"ran" => 0,
	"BM_options" => 0,
	"swap" => 0,
	"KBEST_options" => 0,
	"k" => 0,
	"frames_options" => 0,
	"frame_query1" => 0,
	"frame_query2" => 0,
	"gc" => 0,
	"output_options" => 0,
	"view_alignment" => 1,
	"scut" => 0,
	"pcut" => 0,
	"max" => 0,
	"flag_algo_opt" => 0,
	"flag_algo_opt2" => 0,
	"gc2" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"Expect" => [
		"The parameter Expect (E) establishes a statistical significance threshold for reporting database sequence matches. E is interpreted as the upper bound on the expected frequency of chance occurrence of an HSP (or set of HSPs) within the context of the entire database search. Any database sequence whose matching satisfies E is subject to being reported in the program output. If the query sequence and database sequences follow the random sequence model of Karlin and Altschul (1990), and if sufficiently sensitive BLAST algorithm parameters are used, then E may be thought of as the number of matches one expects to observe by chance alone during the database search. The default value for E is 10, while the permitted range for this Real valued parameter is 0 < E <= 1000.",
	],
	"E2" => [
		"E2 is interpreted as the expected number of HSPs that will be found when comparing two sequences that each have the same length -- either 300 amino acids or 1000 nucleotides, whichever is appropriate for the particular program being used.",
		"The default value for E2 is typically about 0.15 but may vary from version to version of each program.",
	],
	"S2" => [
		"S2 may be thought of as the score expected for the MSP between two sequences that each have the same length -- either 300 amino acids or 1000 nucleotides, whichever is appropriate for the particular program being used.",
		"The default value for S2 will be calculated from E2 and, like the relationship between E and S, is dependent on the residue composition of the query sequence and the scoring system employed, as conveyed by the Karlin-Altschul K and Lambda statistics.",
	],
	"W" => [
		"The task of finding HSPs begins with identifying short words of length W in the query sequence that either match or satisfy some positive-valued threshold score T when aligned with a word of the same length in a database sequence. T is referred to as the neighborhood word score threshold (Altschul et al., 1990). These initial neighborhood word hits act as seeds for initiating searches to find longer HSPs containing them. The word hits are extended in both directions along each sequence for as far as the cumulative alignment score can be increased. Extension of the word hits in each direction are halted when: the cumulative alignment score falls off by the quantity X from its maximum achieved value; the cumulative score goes to zero or below, due to the accumulation of one or more negative-scoring residue alignments; or the end of either sequence is reached.",
	],
	"ktup" => [
		"ktup sets the sensitivity and speed of the search. If ktup=2, similar regions in the two sequences being compared are found by looking at pairs of aligned residues; if ktup=1, single aligned amino acids are examined. ktup can be set to 2 or 1 for protein sequences, or from 1 to 6 for DNA sequences. The default if ktup is not specified is 2 for proteins and 6 for DNA.",
	],
	"ran" => [
		"This is a method for calculating Z-score = (S - Smean) / (std-deviation(S))",
	],
	"frames_options" => [
		"If you compare 2 nucleic sequences, you can choose the reverse strand for one of them.",
		"When comparing a nucleic sequence with a proteic sequence, you can specify the frame to be translated.",
	],

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lassap.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

