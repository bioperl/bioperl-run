
=head1 NAME

Bio::Tools::Run::PiseApplication::consensus

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::consensus

      Bioperl class for:

	CONSENSUS	Identification of consensus patterns in unaligned DNA and protein sequences (Hertz, Stormo)

	References:

		G.Z. Hertz and G.D. Stormo.  Identification of consensus patterns in unaligned DNA and protein sequences: a large-deviation statistical basis for penalizing gaps. In: Proceedings of the Third International Conference on Bioinformatics and Genome Research (H.A. Lim, and C.R. Cantor, editors). World Scientific Publishing Co., Ltd. Singapore, 1995. pages 201--216.


      Parameters:


		consensus (Excl)
			Program to run

		sequence (Sequence)
			Sequences file (-f)
			pipe: seqsfile

		width (Integer)
			Width of pattern (consensus only) (-L)

		out (String)


		consensus_matrix (String)


		matrices (Results)

			pipe: consensus_matrix

		results_file (Results)

			pipe: consensus_results

		sequence_wcons (Results)


		input_options (Paragraph)
			Input options

		complement (Excl)
			Complement of nucleic acid sequences (-c)

		alphabet_options (Paragraph)
			Alphabet options

		ascii_alphabet (InFile)
			Alphabet and normalization information (if not DNA) (-a)

		prior (Switch)
			Use the designated prior probabilities of the letters to override the observed frequencies (-d)

		dna (Switch)
			Alphabet and normalization information for DNA

		protein (Switch)
			Alphabet and normalization information for protein

		algorithm_options (Paragraph)
			Algorithm options

		queue (Integer)
			Maximum number of matrices to save between cycles of the program -- ie: queue size (-q)

		standard_deviation (Float)
			Number of standard deviations to lower the information content at each position before identifying information peaks (mandatory for wconsensus) (-s)

		progeny (Excl)
			Save the top progeny matrices  (-pr1)

		linearly (Switch)
			Seed with the first sequence and proceed linearly through the list (-l)

		max_cycle_nb (Integer)
			Maximum repeat of the matrix building cycle (-n or -N)

		max_cycle (Excl)
			How many words per matrix for each sequence to contribute (-n or -N)

		distance (Integer)
			Minimum distance between the starting points of words within the same matrix pattern (-m)

		terminate (Integer)
			Terminate the program this number of cycles after the current most significant alignment is identified (-t)

		terminal_gap (Excl)
			Permit terminal gaps (-pg) (wconsensus only)

		output_options (Paragraph)
			Output options

		top_matrices (Integer)
			Number of top matrices to print (-pt)

		final_matrices (Integer)
			Number of final matrices to print (-pf)

=cut

#'
package Bio::Tools::Run::PiseApplication::consensus;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $consensus = Bio::Tools::Run::PiseApplication::consensus->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::consensus object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $consensus = $factory->program('consensus');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::consensus.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/consensus.pm

    $self->{COMMAND}   = "consensus";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CONSENSUS";

    $self->{DESCRIPTION}   = "Identification of consensus patterns in unaligned DNA and protein sequences";

    $self->{AUTHORS}   = "Hertz, Stormo";

    $self->{REFERENCE}   = [

         "G.Z. Hertz and G.D. Stormo.  Identification of consensus patterns in unaligned DNA and protein sequences: a large-deviation statistical basis for penalizing gaps. In: Proceedings of the Third International Conference on Bioinformatics and Genome Research (H.A. Lim, and C.R. Cantor, editors). World Scientific Publishing Co., Ltd. Singapore, 1995. pages 201--216.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"consensus",
	"sequence",
	"width",
	"out",
	"consensus_matrix",
	"matrices",
	"results_file",
	"sequence_wcons",
	"input_options",
	"dna",
	"protein",
	"algorithm_options",
	"output_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"consensus", 	# Program to run
	"sequence", 	# Sequences file (-f)
	"width", 	# Width of pattern (consensus only) (-L)
	"out",
	"consensus_matrix",
	"matrices",
	"results_file",
	"sequence_wcons",
	"input_options", 	# Input options
	"complement", 	# Complement of nucleic acid sequences (-c)
	"alphabet_options", 	# Alphabet options
	"ascii_alphabet", 	# Alphabet and normalization information (if not DNA) (-a)
	"prior", 	# Use the designated prior probabilities of the letters to override the observed frequencies (-d)
	"dna", 	# Alphabet and normalization information for DNA
	"protein", 	# Alphabet and normalization information for protein
	"algorithm_options", 	# Algorithm options
	"queue", 	# Maximum number of matrices to save between cycles of the program -- ie: queue size (-q)
	"standard_deviation", 	# Number of standard deviations to lower the information content at each position before identifying information peaks (mandatory for wconsensus) (-s)
	"progeny", 	# Save the top progeny matrices  (-pr1)
	"linearly", 	# Seed with the first sequence and proceed linearly through the list (-l)
	"max_cycle_nb", 	# Maximum repeat of the matrix building cycle (-n or -N)
	"max_cycle", 	# How many words per matrix for each sequence to contribute (-n or -N)
	"distance", 	# Minimum distance between the starting points of words within the same matrix pattern (-m)
	"terminate", 	# Terminate the program this number of cycles after the current most significant alignment is identified (-t)
	"terminal_gap", 	# Permit terminal gaps (-pg) (wconsensus only)
	"output_options", 	# Output options
	"top_matrices", 	# Number of top matrices to print (-pt)
	"final_matrices", 	# Number of final matrices to print (-pf)

    ];

    $self->{TYPE}  = {
	"consensus" => 'Excl',
	"sequence" => 'Sequence',
	"width" => 'Integer',
	"out" => 'String',
	"consensus_matrix" => 'String',
	"matrices" => 'Results',
	"results_file" => 'Results',
	"sequence_wcons" => 'Results',
	"input_options" => 'Paragraph',
	"complement" => 'Excl',
	"alphabet_options" => 'Paragraph',
	"ascii_alphabet" => 'InFile',
	"prior" => 'Switch',
	"dna" => 'Switch',
	"protein" => 'Switch',
	"algorithm_options" => 'Paragraph',
	"queue" => 'Integer',
	"standard_deviation" => 'Float',
	"progeny" => 'Excl',
	"linearly" => 'Switch',
	"max_cycle_nb" => 'Integer',
	"max_cycle" => 'Excl',
	"distance" => 'Integer',
	"terminate" => 'Integer',
	"terminal_gap" => 'Excl',
	"output_options" => 'Paragraph',
	"top_matrices" => 'Integer',
	"final_matrices" => 'Integer',

    };

    $self->{FORMAT}  = {
	"consensus" => {
		"perl" => '"fasta-consensus < $sequence > $sequence.wcons; $consensus "',
	},
	"sequence" => {
		"perl" => '" -f $sequence.wcons"',
	},
	"width" => {
		"perl" => '" -L$value"',
	},
	"out" => {
		"perl" => '" > $consensus.results"',
	},
	"consensus_matrix" => {
		"perl" => '" ;consensus-matrix $consensus.results"',
	},
	"matrices" => {
	},
	"results_file" => {
	},
	"sequence_wcons" => {
	},
	"input_options" => {
	},
	"complement" => {
		"perl" => '($value)? " -c$value" : "" ',
	},
	"alphabet_options" => {
	},
	"ascii_alphabet" => {
		"perl" => '($value)? " -a $value" : "" ',
	},
	"prior" => {
		"perl" => '($value)? " -d" : ""',
	},
	"dna" => {
		"perl" => '($value)? " -A a:t c:g" : ""',
	},
	"protein" => {
		"perl" => '($value)? " -a /local/gensoft/lib/consensus/prot-alphabet" : ""',
	},
	"algorithm_options" => {
	},
	"queue" => {
		"perl" => '(defined $value && $value != $vdef)? " -q$value" : ""',
	},
	"standard_deviation" => {
		"perl" => '" -s$value"',
	},
	"progeny" => {
		"perl" => '($value && $value ne $vdef)? " $value" : ""',
	},
	"linearly" => {
		"perl" => '($value)? " -l" : "" ',
	},
	"max_cycle_nb" => {
		"perl" => ' "" ',
	},
	"max_cycle" => {
		"perl" => '($value)? " $max_cycle$max_cycle_nb" : "" ',
	},
	"distance" => {
		"perl" => '(defined $value)? " -m$value " : "" ',
	},
	"terminate" => {
		"perl" => '(defined $value)? " -t$value " : "" ',
	},
	"terminal_gap" => {
		"perl" => '($value && $value ne $vdef) ? " $value" : ""',
	},
	"output_options" => {
	},
	"top_matrices" => {
		"perl" => '($value && $value != $vdef) ? " -pt$value" : ""',
	},
	"final_matrices" => {
		"perl" => '($value && $value != $vdef) ? " -pf$value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"matrices" => '$consensus.results.matrix.*',
	"results_file" => '$consensus.results',
	"sequence_wcons" => '*.wcons',

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"consensus" => 0,
	"sequence" => 1,
	"width" => 2,
	"out" => 50,
	"consensus_matrix" => 100,
	"input_options" => 2,
	"complement" => 2,
	"alphabet_options" => 2,
	"ascii_alphabet" => 2,
	"prior" => 2,
	"algorithm_options" => 2,
	"queue" => 2,
	"standard_deviation" => 2,
	"progeny" => 2,
	"linearly" => 2,
	"max_cycle_nb" => 2,
	"max_cycle" => 2,
	"distance" => 2,
	"terminate" => 2,
	"terminal_gap" => 2,
	"output_options" => 2,
	"top_matrices" => 2,
	"final_matrices" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"consensus",
	"results_file",
	"sequence_wcons",
	"protein",
	"dna",
	"matrices",
	"sequence",
	"width",
	"top_matrices",
	"final_matrices",
	"input_options",
	"complement",
	"alphabet_options",
	"ascii_alphabet",
	"prior",
	"algorithm_options",
	"queue",
	"standard_deviation",
	"progeny",
	"linearly",
	"max_cycle_nb",
	"max_cycle",
	"distance",
	"terminate",
	"terminal_gap",
	"output_options",
	"out",
	"consensus_matrix",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"consensus" => 0,
	"sequence" => 0,
	"width" => 0,
	"out" => 1,
	"consensus_matrix" => 1,
	"matrices" => 0,
	"results_file" => 0,
	"sequence_wcons" => 0,
	"input_options" => 0,
	"complement" => 0,
	"alphabet_options" => 0,
	"ascii_alphabet" => 0,
	"prior" => 0,
	"dna" => 0,
	"protein" => 0,
	"algorithm_options" => 0,
	"queue" => 0,
	"standard_deviation" => 0,
	"progeny" => 0,
	"linearly" => 0,
	"max_cycle_nb" => 0,
	"max_cycle" => 0,
	"distance" => 0,
	"terminate" => 0,
	"terminal_gap" => 0,
	"output_options" => 0,
	"top_matrices" => 0,
	"final_matrices" => 0,

    };

    $self->{ISCOMMAND}  = {
	"consensus" => 1,
	"sequence" => 0,
	"width" => 0,
	"out" => 0,
	"consensus_matrix" => 0,
	"matrices" => 0,
	"results_file" => 0,
	"sequence_wcons" => 0,
	"input_options" => 0,
	"complement" => 0,
	"alphabet_options" => 0,
	"ascii_alphabet" => 0,
	"prior" => 0,
	"dna" => 0,
	"protein" => 0,
	"algorithm_options" => 0,
	"queue" => 0,
	"standard_deviation" => 0,
	"progeny" => 0,
	"linearly" => 0,
	"max_cycle_nb" => 0,
	"max_cycle" => 0,
	"distance" => 0,
	"terminate" => 0,
	"terminal_gap" => 0,
	"output_options" => 0,
	"top_matrices" => 0,
	"final_matrices" => 0,

    };

    $self->{ISMANDATORY}  = {
	"consensus" => 1,
	"sequence" => 1,
	"width" => 1,
	"out" => 0,
	"consensus_matrix" => 0,
	"matrices" => 0,
	"results_file" => 0,
	"sequence_wcons" => 0,
	"input_options" => 0,
	"complement" => 0,
	"alphabet_options" => 0,
	"ascii_alphabet" => 0,
	"prior" => 0,
	"dna" => 0,
	"protein" => 0,
	"algorithm_options" => 0,
	"queue" => 0,
	"standard_deviation" => 1,
	"progeny" => 0,
	"linearly" => 0,
	"max_cycle_nb" => 0,
	"max_cycle" => 0,
	"distance" => 0,
	"terminate" => 0,
	"terminal_gap" => 0,
	"output_options" => 0,
	"top_matrices" => 0,
	"final_matrices" => 0,

    };

    $self->{PROMPT}  = {
	"consensus" => "Program to run",
	"sequence" => "Sequences file (-f)",
	"width" => "Width of pattern (consensus only) (-L)",
	"out" => "",
	"consensus_matrix" => "",
	"matrices" => "",
	"results_file" => "",
	"sequence_wcons" => "",
	"input_options" => "Input options",
	"complement" => "Complement of nucleic acid sequences (-c)",
	"alphabet_options" => "Alphabet options",
	"ascii_alphabet" => "Alphabet and normalization information (if not DNA) (-a)",
	"prior" => "Use the designated prior probabilities of the letters to override the observed frequencies (-d)",
	"dna" => "Alphabet and normalization information for DNA",
	"protein" => "Alphabet and normalization information for protein",
	"algorithm_options" => "Algorithm options",
	"queue" => "Maximum number of matrices to save between cycles of the program -- ie: queue size (-q)",
	"standard_deviation" => "Number of standard deviations to lower the information content at each position before identifying information peaks (mandatory for wconsensus) (-s)",
	"progeny" => "Save the top progeny matrices  (-pr1)",
	"linearly" => "Seed with the first sequence and proceed linearly through the list (-l)",
	"max_cycle_nb" => "Maximum repeat of the matrix building cycle (-n or -N)",
	"max_cycle" => "How many words per matrix for each sequence to contribute (-n or -N)",
	"distance" => "Minimum distance between the starting points of words within the same matrix pattern (-m)",
	"terminate" => "Terminate the program this number of cycles after the current most significant alignment is identified (-t)",
	"terminal_gap" => "Permit terminal gaps (-pg) (wconsensus only)",
	"output_options" => "Output options",
	"top_matrices" => "Number of top matrices to print (-pt)",
	"final_matrices" => "Number of final matrices to print (-pf)",

    };

    $self->{ISSTANDOUT}  = {
	"consensus" => 0,
	"sequence" => 0,
	"width" => 0,
	"out" => 0,
	"consensus_matrix" => 0,
	"matrices" => 0,
	"results_file" => 0,
	"sequence_wcons" => 0,
	"input_options" => 0,
	"complement" => 0,
	"alphabet_options" => 0,
	"ascii_alphabet" => 0,
	"prior" => 0,
	"dna" => 0,
	"protein" => 0,
	"algorithm_options" => 0,
	"queue" => 0,
	"standard_deviation" => 0,
	"progeny" => 0,
	"linearly" => 0,
	"max_cycle_nb" => 0,
	"max_cycle" => 0,
	"distance" => 0,
	"terminate" => 0,
	"terminal_gap" => 0,
	"output_options" => 0,
	"top_matrices" => 0,
	"final_matrices" => 0,

    };

    $self->{VLIST}  = {

	"consensus" => ['consensus','consensus: search for fixed width patterns','wconsensus','wconsensus: same as consensus, width not fixed',],
	"input_options" => ['complement','alphabet_options',],
	"complement" => ['0','0: ignore the complement','1','1: include both strands as separate sequences','2','2: include both strands as a single sequence','3','3: Assume that the pattern is symmetrical (consensus)',],
	"alphabet_options" => ['ascii_alphabet','prior',],
	"algorithm_options" => ['queue','standard_deviation','progeny','linearly','max_cycle_nb','max_cycle','distance','terminate','terminal_gap',],
	"progeny" => ['-pr1','-pr1: regardless of parentage','-pr2','-pr2: for each parental matrix',],
	"max_cycle" => ['-n','-n: allow each sequence to contribute zero or more words per matrix','-N','-N: allow each sequence to contribute one or more words per matrix',],
	"terminal_gap" => ['-pg0','-pg0: do NOT permit terminal gaps','-pg1','-pg1: permit penalized terminal gaps',],
	"output_options" => ['top_matrices','final_matrices',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"consensus" => 'consensus',
	"complement" => '0',
	"prior" => '0',
	"protein" => '1',
	"queue" => '200',
	"standard_deviation" => '1',
	"progeny" => '-pr2',
	"linearly" => '0',
	"terminal_gap" => '-pg0',
	"top_matrices" => '4',
	"final_matrices" => '4',

    };

    $self->{PRECOND}  = {
	"consensus" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"width" => {
		"perl" => '$consensus eq "consensus"',
	},
	"out" => { "perl" => '1' },
	"consensus_matrix" => { "perl" => '1' },
	"matrices" => { "perl" => '1' },
	"results_file" => { "perl" => '1' },
	"sequence_wcons" => { "perl" => '1' },
	"input_options" => { "perl" => '1' },
	"complement" => { "perl" => '1' },
	"alphabet_options" => { "perl" => '1' },
	"ascii_alphabet" => {
		"perl" => '! $dna',
	},
	"prior" => { "perl" => '1' },
	"dna" => { "perl" => '1' },
	"protein" => {
		"perl" => '! $dna',
	},
	"algorithm_options" => { "perl" => '1' },
	"queue" => { "perl" => '1' },
	"standard_deviation" => {
		"perl" => '$consensus eq "wconsensus"',
	},
	"progeny" => { "perl" => '1' },
	"linearly" => { "perl" => '1' },
	"max_cycle_nb" => { "perl" => '1' },
	"max_cycle" => {
		"perl" => 'defined $max_cycle_nb',
	},
	"distance" => {
		"perl" => '$max_cycle ne ""',
	},
	"terminate" => { "perl" => '1' },
	"terminal_gap" => {
		"perl" => '$consensus eq "wconsensus"',
	},
	"output_options" => { "perl" => '1' },
	"top_matrices" => { "perl" => '1' },
	"final_matrices" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"complement" => {
		"perl" => {
			'$value eq "3" && $consensus eq "wconsensus"' => "3: this choice is for the consensus program only",
		},
	},
	"distance" => {
		"perl" => {
			'$value <= 0' => "This number must be positive",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"matrices" => {
		 '1' => "consensus_matrix",
	},
	"results_file" => {
		 '1' => "consensus_results",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"consensus" => 0,
	"sequence" => 0,
	"width" => 0,
	"out" => 0,
	"consensus_matrix" => 0,
	"matrices" => 0,
	"results_file" => 0,
	"sequence_wcons" => 0,
	"input_options" => 0,
	"complement" => 0,
	"alphabet_options" => 0,
	"ascii_alphabet" => 0,
	"prior" => 0,
	"dna" => 0,
	"protein" => 0,
	"algorithm_options" => 0,
	"queue" => 0,
	"standard_deviation" => 0,
	"progeny" => 0,
	"linearly" => 0,
	"max_cycle_nb" => 0,
	"max_cycle" => 0,
	"distance" => 0,
	"terminate" => 0,
	"terminal_gap" => 0,
	"output_options" => 0,
	"top_matrices" => 0,
	"final_matrices" => 0,

    };

    $self->{ISSIMPLE}  = {
	"consensus" => 1,
	"sequence" => 1,
	"width" => 1,
	"out" => 0,
	"consensus_matrix" => 0,
	"matrices" => 0,
	"results_file" => 0,
	"sequence_wcons" => 0,
	"input_options" => 0,
	"complement" => 0,
	"alphabet_options" => 0,
	"ascii_alphabet" => 0,
	"prior" => 0,
	"dna" => 1,
	"protein" => 1,
	"algorithm_options" => 0,
	"queue" => 0,
	"standard_deviation" => 0,
	"progeny" => 0,
	"linearly" => 0,
	"max_cycle_nb" => 0,
	"max_cycle" => 0,
	"distance" => 0,
	"terminate" => 0,
	"terminal_gap" => 0,
	"output_options" => 0,
	"top_matrices" => 0,
	"final_matrices" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"ascii_alphabet" => [
		"Each line contains a letter (a symbol in the alphabet) followed by an optional normalization number (default: 1.0). The normalization is based on the relative prior probabilities of the letters. For nucleic acids, this might be be the genomic frequency of the bases; however, if the -d option is not used, the frequencies observed in your own sequence data are used. In nucleic acid alphabets, a letter and its complement appear on the same line, separated by a colon (a letter can be its own complement, e.g. when using a dimer alphabet).",
		"Complementary letters may use the same normalization number. Only the standard 26 letters are permissible; however, when the -CS option is used, the alphabet is case sensitive so that a total of 52 different characters are possible.",
		"POSSIBLE LINE FORMATS WITHOUT COMPLEMENTARY LETTERS:",
		"letter",
		"letter normalization",
		"POSSIBLE LINE FORMATS WITH COMPLEMENTARY LETTERS:",
		"letter:complement",
		"letter:complement normalization",
		"letter:complement normalization:complement\'s_normalization",
	],
	"prior" => [
		"By default, the program uses the frequencies observed in your own sequence data for the prior probabilities of the letters. However, if the -d option is set, the prior probabilities designated by the alphabet options. If the -d option is not set, they are still used to determine the sequence alphabet, but any prior probability information is ignored.",
	],
	"progeny" => [
		"-pr2 option prevents a strong pattern found in only a subset of the sequences from overwhelming the algorithm and eliminating other potential patterns. This undesirable situation can occur when a subset of the sequences share an evolutionary relationship not common to the majority of the sequences.",
	],
	"linearly" => [
		"This option results in a significant speed up in the program, but the algorithm becomes dependent on the order of the sequence-file names.",
	],
	"distance" => [
		"For wconsensus, the default value is 1.",
		"For consensus, this number is indicated by the width (-L).",
	],
	"terminate" => [
		"default: terminate only when the maximum number of matrix building cycles is completed.",
	],
	"top_matrices" => [
		"A negative value means print all the top matrices.",
	],
	"final_matrices" => [
		"Default when NOT using -n or -N option: print 4 matrices; default when using -n or -N option: print no matrices.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/consensus.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

