
=head1 NAME

Bio::Tools::Run::PiseApplication::bl2seq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::bl2seq

      Bioperl class for:

	BL2SEQ	Blast on 2 sequences (NCBI) (Altschul, Madden, Schaeffer, Zhang, Miller, Lipman)

      Parameters:


		bl2seq (Excl)
			Blast program

		first_sequence (Sequence)
			First sequence (-i)
			pipe: seqfile

		first_seq_loc (String)
			Location on first sequence (-I)

		second_sequence (Sequence)
			Second sequence (-j)

		second_seq_loc (String)
			Location on second sequence (-J)

		Expect (Float)
			Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)

		filter_opt (Paragraph)
			Filtering and masking options

		filter (Switch)
			Filter query sequence (DUST with blastn, SEG with others) (-F)

		other_filters (Excl)
			Filtering options (-F must be true)

		lower_case (Switch)
			Use lower case filtering (-U)

		selectivity_opt (Paragraph)
			Selectivity options

		word_size (Integer)
			Wordsize (-W) (zero invokes default behavior)

		gapped_alig (Switch)
			Perform gapped alignment (-g)

		dropoff (Integer)
			X dropoff value for gapped alignment (in bits) (-X)

		gap_open (Integer)
			Cost to open a gap (-G)

		gap_extend (Integer)
			Cost to extend a gap (-E)

		matrix (Excl)
			Matrix (-M)

		blastn_opt (Paragraph)
			BLASTN Options

		mismatch (Integer)
			Penalty for a nucleotide mismatch (-q)

		match (Integer)
			Reward for a nucleotide match (-r)

		strand (Excl)
			Query strands to search against database (-S)

		othersopt (Paragraph)
			Other Options

		dbsize (Integer)
			theor. db size (zero is real size) (-d)

		searchspacesize (Float)
			Effective length of the search space (use zero for the real size) (-Y)

		output_opt (Paragraph)
			Output options

		outformat (Excl)
			Output format (-D)

=cut

#'
package Bio::Tools::Run::PiseApplication::bl2seq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $bl2seq = Bio::Tools::Run::PiseApplication::bl2seq->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::bl2seq object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $bl2seq = $factory->program('bl2seq');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::bl2seq.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/bl2seq.pm

    $self->{COMMAND}   = "bl2seq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BL2SEQ";

    $self->{DESCRIPTION}   = "Blast on 2 sequences (NCBI)";

    $self->{AUTHORS}   = "Altschul, Madden, Schaeffer, Zhang, Miller, Lipman";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-algt.html#BLAST2";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"bl2seq",
	"first_sequence",
	"first_seq_loc",
	"second_sequence",
	"second_seq_loc",
	"Expect",
	"filter_opt",
	"selectivity_opt",
	"blastn_opt",
	"othersopt",
	"output_opt",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"bl2seq", 	# Blast program
	"first_sequence", 	# First sequence (-i)
	"first_seq_loc", 	# Location on first sequence (-I)
	"second_sequence", 	# Second sequence (-j)
	"second_seq_loc", 	# Location on second sequence (-J)
	"Expect", 	# Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)
	"filter_opt", 	# Filtering and masking options
	"filter", 	# Filter query sequence (DUST with blastn, SEG with others) (-F)
	"other_filters", 	# Filtering options (-F must be true)
	"lower_case", 	# Use lower case filtering (-U)
	"selectivity_opt", 	# Selectivity options
	"word_size", 	# Wordsize (-W) (zero invokes default behavior)
	"gapped_alig", 	# Perform gapped alignment (-g)
	"dropoff", 	# X dropoff value for gapped alignment (in bits) (-X)
	"gap_open", 	# Cost to open a gap (-G)
	"gap_extend", 	# Cost to extend a gap (-E)
	"matrix", 	# Matrix (-M)
	"blastn_opt", 	# BLASTN Options
	"mismatch", 	# Penalty for a nucleotide mismatch (-q)
	"match", 	# Reward for a nucleotide match (-r)
	"strand", 	# Query strands to search against database (-S)
	"othersopt", 	# Other Options
	"dbsize", 	# theor. db size (zero is real size) (-d)
	"searchspacesize", 	# Effective length of the search space (use zero for the real size) (-Y)
	"output_opt", 	# Output options
	"outformat", 	# Output format (-D)

    ];

    $self->{TYPE}  = {
	"bl2seq" => 'Excl',
	"first_sequence" => 'Sequence',
	"first_seq_loc" => 'String',
	"second_sequence" => 'Sequence',
	"second_seq_loc" => 'String',
	"Expect" => 'Float',
	"filter_opt" => 'Paragraph',
	"filter" => 'Switch',
	"other_filters" => 'Excl',
	"lower_case" => 'Switch',
	"selectivity_opt" => 'Paragraph',
	"word_size" => 'Integer',
	"gapped_alig" => 'Switch',
	"dropoff" => 'Integer',
	"gap_open" => 'Integer',
	"gap_extend" => 'Integer',
	"matrix" => 'Excl',
	"blastn_opt" => 'Paragraph',
	"mismatch" => 'Integer',
	"match" => 'Integer',
	"strand" => 'Excl',
	"othersopt" => 'Paragraph',
	"dbsize" => 'Integer',
	"searchspacesize" => 'Float',
	"output_opt" => 'Paragraph',
	"outformat" => 'Excl',

    };

    $self->{FORMAT}  = {
	"bl2seq" => {
		"perl" => '"bl2seq -p $value"',
	},
	"first_sequence" => {
		"perl" => '" -i $value" ',
	},
	"first_seq_loc" => {
		"perl" => '($value) ? " -I $value" : ""',
	},
	"second_sequence" => {
		"perl" => '" -j $value" ',
	},
	"second_seq_loc" => {
		"perl" => '($value) ? " -J $value" : "" ',
	},
	"Expect" => {
		"perl" => '(defined $value && $value != $vdef)? " -e $value":""',
	},
	"filter_opt" => {
	},
	"filter" => {
		"perl" => '($value) ? "" : " -F F"',
	},
	"other_filters" => {
	},
	"lower_case" => {
		"perl" => '($value)? " -U T" : ""',
	},
	"selectivity_opt" => {
	},
	"word_size" => {
		"perl" => '($value)? " -W $value":""',
	},
	"gapped_alig" => {
		"perl" => '($value)? "": " -g F"',
	},
	"dropoff" => {
		"perl" => '(defined $value)? " -X $value":""',
	},
	"gap_open" => {
		"perl" => '(defined $value)? " -G $value":""',
	},
	"gap_extend" => {
		"perl" => '(defined $value)? " -E $value":""',
	},
	"matrix" => {
		"perl" => '($value && $value ne $vdef)? " -M $value" : ""',
	},
	"blastn_opt" => {
	},
	"mismatch" => {
		"perl" => '(defined $value && $value != $vdef)? " -q $value":""',
	},
	"match" => {
		"perl" => '(defined $value && $value != $vdef)? " -r $value":""',
	},
	"strand" => {
		"perl" => '($value && $value ne $vdef)? " -S $value" : ""',
	},
	"othersopt" => {
	},
	"dbsize" => {
		"perl" => '($value)? " -d $value":""',
	},
	"searchspacesize" => {
		"perl" => '($value)? " -Y $value":""',
	},
	"output_opt" => {
	},
	"outformat" => {
		"perl" => '($value && $value != $vdef) ? " -D $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"first_sequence" => [8],
	"second_sequence" => [8],

    };

    $self->{GROUP}  = {
	"bl2seq" => 1,
	"first_sequence" => 2,
	"second_sequence" => 3,
	"Expect" => 5,
	"filter_opt" => 4,
	"filter" => 4,
	"other_filters" => 4,
	"lower_case" => 4,
	"selectivity_opt" => 5,
	"word_size" => 5,
	"gapped_alig" => 5,
	"dropoff" => 5,
	"gap_open" => 5,
	"gap_extend" => 5,
	"matrix" => 5,
	"blastn_opt" => 5,
	"mismatch" => 5,
	"match" => 5,
	"strand" => 5,
	"othersopt" => 5,
	"dbsize" => 5,
	"searchspacesize" => 5,
	"output_opt" => 10,
	"outformat" => 10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"first_seq_loc",
	"second_seq_loc",
	"bl2seq",
	"first_sequence",
	"second_sequence",
	"lower_case",
	"filter_opt",
	"filter",
	"other_filters",
	"Expect",
	"selectivity_opt",
	"word_size",
	"gapped_alig",
	"dropoff",
	"gap_open",
	"gap_extend",
	"matrix",
	"blastn_opt",
	"mismatch",
	"match",
	"strand",
	"othersopt",
	"dbsize",
	"searchspacesize",
	"output_opt",
	"outformat",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"bl2seq" => 0,
	"first_sequence" => 0,
	"first_seq_loc" => 0,
	"second_sequence" => 0,
	"second_seq_loc" => 0,
	"Expect" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"word_size" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"gap_open" => 0,
	"gap_extend" => 0,
	"matrix" => 0,
	"blastn_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"strand" => 0,
	"othersopt" => 0,
	"dbsize" => 0,
	"searchspacesize" => 0,
	"output_opt" => 0,
	"outformat" => 0,

    };

    $self->{ISCOMMAND}  = {
	"bl2seq" => 1,
	"first_sequence" => 0,
	"first_seq_loc" => 0,
	"second_sequence" => 0,
	"second_seq_loc" => 0,
	"Expect" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"word_size" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"gap_open" => 0,
	"gap_extend" => 0,
	"matrix" => 0,
	"blastn_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"strand" => 1,
	"othersopt" => 0,
	"dbsize" => 0,
	"searchspacesize" => 0,
	"output_opt" => 0,
	"outformat" => 0,

    };

    $self->{ISMANDATORY}  = {
	"bl2seq" => 1,
	"first_sequence" => 1,
	"first_seq_loc" => 0,
	"second_sequence" => 1,
	"second_seq_loc" => 0,
	"Expect" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"word_size" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"gap_open" => 0,
	"gap_extend" => 0,
	"matrix" => 0,
	"blastn_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"strand" => 1,
	"othersopt" => 0,
	"dbsize" => 0,
	"searchspacesize" => 0,
	"output_opt" => 0,
	"outformat" => 0,

    };

    $self->{PROMPT}  = {
	"bl2seq" => "Blast program",
	"first_sequence" => "First sequence (-i)",
	"first_seq_loc" => "Location on first sequence (-I)",
	"second_sequence" => "Second sequence (-j)",
	"second_seq_loc" => "Location on second sequence (-J)",
	"Expect" => "Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)",
	"filter_opt" => "Filtering and masking options",
	"filter" => "Filter query sequence (DUST with blastn, SEG with others) (-F)",
	"other_filters" => "Filtering options (-F must be true)",
	"lower_case" => "Use lower case filtering (-U)",
	"selectivity_opt" => "Selectivity options",
	"word_size" => "Wordsize (-W) (zero invokes default behavior)",
	"gapped_alig" => "Perform gapped alignment (-g)",
	"dropoff" => "X dropoff value for gapped alignment (in bits) (-X)",
	"gap_open" => "Cost to open a gap (-G)",
	"gap_extend" => "Cost to extend a gap (-E)",
	"matrix" => "Matrix (-M)",
	"blastn_opt" => "BLASTN Options",
	"mismatch" => "Penalty for a nucleotide mismatch (-q)",
	"match" => "Reward for a nucleotide match (-r)",
	"strand" => "Query strands to search against database (-S)",
	"othersopt" => "Other Options",
	"dbsize" => "theor. db size (zero is real size) (-d)",
	"searchspacesize" => "Effective length of the search space (use zero for the real size) (-Y)",
	"output_opt" => "Output options",
	"outformat" => "Output format (-D)",

    };

    $self->{ISSTANDOUT}  = {
	"bl2seq" => 0,
	"first_sequence" => 0,
	"first_seq_loc" => 0,
	"second_sequence" => 0,
	"second_seq_loc" => 0,
	"Expect" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"word_size" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"gap_open" => 0,
	"gap_extend" => 0,
	"matrix" => 0,
	"blastn_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"strand" => 0,
	"othersopt" => 0,
	"dbsize" => 0,
	"searchspacesize" => 0,
	"output_opt" => 0,
	"outformat" => 0,

    };

    $self->{VLIST}  = {

	"bl2seq" => ['blastp','blastp: protein / protein','blastn','blastn: nucleotide / nucleotide','blastx','blastx: nucleotide / protein','tblastn','tblastn : protein / nucleotide','tblastx','tblastx: nucleotide / nucleotide',],
	"filter_opt" => ['filter','other_filters','lower_case',],
	"other_filters" => ['v1','masking instead of filtering (with Seg)','v2','coiled-coiled filter','v3','both seg and coiled-coiled filters','v4','dust filter (DNA query)','v5','lower-case masking (-U must be true)',],
	"selectivity_opt" => ['word_size','gapped_alig','dropoff','gap_open','gap_extend','matrix',],
	"matrix" => ['PAM30','PAM30','PAM70','PAM70','BLOSUM80','BLOSUM80','BLOSUM62','BLOSUM62','BLOSUM45','BLOSUM45',],
	"blastn_opt" => ['mismatch','match','strand',],
	"strand" => ['1','1: top','2','2: bottom','3','3: both',],
	"othersopt" => ['dbsize','searchspacesize',],
	"output_opt" => ['outformat',],
	"outformat" => ['0','0: traditional','1','1: tabulated',],
    };

    $self->{FLIST}  = {

	"other_filters" => {
		'v1' => '" -F \"m S\""',
		'v2' => '" -F C"',
		'v3' => '" -F \"C;S\""',
		'v4' => '" -F D"',
		'v5' => '" -F m"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"bl2seq" => 'blastp',
	"Expect" => '10.0',
	"filter" => '1',
	"lower_case" => '0',
	"word_size" => '0',
	"gapped_alig" => '1',
	"matrix" => 'BLOSUM62',
	"mismatch" => '-3',
	"match" => '1',
	"strand" => '3',
	"dbsize" => '0',
	"searchspacesize" => '0',
	"outformat" => '0',

    };

    $self->{PRECOND}  = {
	"bl2seq" => { "perl" => '1' },
	"first_sequence" => { "perl" => '1' },
	"first_seq_loc" => { "perl" => '1' },
	"second_sequence" => { "perl" => '1' },
	"second_seq_loc" => { "perl" => '1' },
	"Expect" => { "perl" => '1' },
	"filter_opt" => { "perl" => '1' },
	"filter" => { "perl" => '1' },
	"other_filters" => { "perl" => '1' },
	"lower_case" => { "perl" => '1' },
	"selectivity_opt" => { "perl" => '1' },
	"word_size" => { "perl" => '1' },
	"gapped_alig" => { "perl" => '1' },
	"dropoff" => { "perl" => '1' },
	"gap_open" => { "perl" => '1' },
	"gap_extend" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"blastn_opt" => {
		"perl" => '$bl2seq eq "blastn"',
	},
	"mismatch" => {
		"perl" => '$bl2seq eq "blastn"',
	},
	"match" => {
		"perl" => '$bl2seq eq "blastn"',
	},
	"strand" => {
		"perl" => '$bl2seq eq "blastn"',
	},
	"othersopt" => { "perl" => '1' },
	"dbsize" => { "perl" => '1' },
	"searchspacesize" => { "perl" => '1' },
	"output_opt" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"first_sequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"bl2seq" => 0,
	"first_sequence" => 0,
	"first_seq_loc" => 0,
	"second_sequence" => 0,
	"second_seq_loc" => 0,
	"Expect" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"word_size" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"gap_open" => 0,
	"gap_extend" => 0,
	"matrix" => 0,
	"blastn_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"strand" => 0,
	"othersopt" => 0,
	"dbsize" => 0,
	"searchspacesize" => 0,
	"output_opt" => 0,
	"outformat" => 0,

    };

    $self->{ISSIMPLE}  = {
	"bl2seq" => 1,
	"first_sequence" => 1,
	"first_seq_loc" => 0,
	"second_sequence" => 1,
	"second_seq_loc" => 0,
	"Expect" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"word_size" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"gap_open" => 0,
	"gap_extend" => 0,
	"matrix" => 0,
	"blastn_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"strand" => 1,
	"othersopt" => 0,
	"dbsize" => 0,
	"searchspacesize" => 0,
	"output_opt" => 0,
	"outformat" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"bl2seq" => [
		"Program name: blastp, blastn, blastx, tblastn, tblastx. For blastx 1st sequence should be nucleotide, tblastn 2nd sequence nucleotide",
	],
	"Expect" => [
		"The statistical significance threshold for reporting matches against database sequences; the default value is 10, such that 10 matches are expected to be found merely by chance, according to the stochastic model of Karlin and Altschul (1990). If the statistical significance ascribed to a match is greater than the EXPECT threshold, the match will not be reported. Lower EXPECT thresholds are more stringent, leading to fewer chance matches being reported. Fractional values are acceptable. ",
	],
	"filter_opt" => [
		"Mask off segments of the query sequence that have low compositional complexity, as determined by the SEG program of Wootton & Federhen (Computers and Chemistry, 1993) or, for BLASTN, by the DUST program of Tatusov and Lipman (in preparation). Filtering can eliminate statistically significant but biologically uninteresting reports from the blast output (e.g., hits against common acidic-, basic- or proline-rich regions), leaving the more biologically interesting regions of the query sequence available for specific matching against database sequences.",
		"Filtering is only applied to the query sequence (or its translation products), not to database sequences. Default filtering is DUST for BLASTN, SEG for other programs. It is not unusual for nothing at all to be masked by SEG, when applied to sequences in SWISS-PROT, so filtering should not be expected to always yield an effect. Furthermore, in some cases, sequences are masked in their entirety, indicating that the statistical significance of any matches reported against the unfiltered query sequence should be suspect.",
	],
	"other_filters" => [
		"The -F argument can take a string as input specifying that seg should be run with certain values or that other non-standard filters should be used.",
		" A coiled-coiled filter, based on the work of Lupas et al. (Science, vol 252, pp. 1162-4 (1991)) written by John Kuzio (Wilson et al., J Gen Virol, vol. 76, pp. 2923-32 (1995)), may be invoked specifying: -F \'C\'",
		" One may also run both seg and coiled-coiled together by using a \';\': -F \'C;S\'",
		" Filtering by dust may also be specified by: -F \'D\'",
		" It is possible to specify that the masking should only be done during the process of building the initial words by starting the filtering command with \'m\', e.g.: -F \'m S\' which specifies that seg (with default arguments) should be used for masking, but that the masking should only be done when the words are being built.",
		" If the -U option (to mask any lower-case sequence in the input FASTA file) is used and one does not wish any other filtering, but does wish to mask when building the lookup tables then one should specify: -F \'m\'",
	],
	"lower_case" => [
		" This option specifies that any lower-case letters in the input FASTA file should be masked.",
	],
	"dropoff" => [
		"This is the value that control the path graph region explored by Blast during a gapped extension (Xg in the NAR paper) (default for blastp is 15).",
	],
	"gap_open" => [
		"default is 5 for blastn, 10 for blastp",
	],
	"gap_extend" => [
		"default is 2 for blastn, 1 for blastp",
		"Limited values for gap existence and extension are supported for these three programs. Some supported and suggested values are:",
		"Existence Extension",
		"10 1",
		"10 2",
		"11 1",
		"8 2",
		"9 2",
		"(source: NCBI Blast page)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/bl2seq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

