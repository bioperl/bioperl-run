
=head1 NAME

Bio::Tools::Run::PiseApplication::seqgen

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::seqgen

      Bioperl class for:

	SeqGen	Sequence-Generator (A. Rambaut, N. C. Grassly)

	References:

		Rambaut, A. and Grassly, N. C. (1996) Seq-Gen: An application for the Monte Carlo simulation of DNA sequence evolution along phylogenetic trees. Comput. Appl. Biosci.


      Parameters:


		seqgen (String)


		tree (InFile)
			Tree File
			pipe: phylip_tree

		control (Paragraph)
			Control parameters

		model (Excl)
			model of nucleotide substitution

		length (Integer)
			sequence length (-l)

		datasets (Integer)
			number of simulated datasets per tree (-n)

		scale_branch (Integer)
			Scale branch lengths  (a decimal number greater > 0) (-s)

		scale_tree (Integer)
			total tree scale  (a decimal number greater > 0) [default = use branch lengths] (-d)

		rate1 (Integer)
			rates for codon position heterogeneity, first position (enter a decimal number) (-c)

		rate2 (Integer)
			rates for codon position heterogeneity, second position (enter a decimal number)

		rate3 (Integer)
			rates for codon position heterogeneity, third position (enter a decimal number)

		shape (Integer)
			shape of the gamma distribution to use  with  gamma rate heterogeneity (a decimal  number) (-a)

		categories (Integer)
			number of categories  for  the  discrete gamma  rate  heterogeneity model (>2 and < 32) (-g)

		freqA (Integer)
			relative frequencies of the A nucleotide (a decimal number) (-f)

		freqC (Integer)
			relative frequencies of the C nucleotide (a decimal number)

		freqG (Integer)
			relative frequencies of the G nucleotide (a decimal number)

		freqT (Integer)
			relative frequencies of the T nucleotide (a decimal number)

		transratio (Integer)
			transition transversion ratio (TS/TV) (this is only valid when either the HKY or F84 model has been selected) (-t)

		matrix (String)
			6 values  for  the general reversable  model's rate matrix (ACTG x ACTG) (REV model), separated by commas (-r)

		outfile (Results)

			pipe: readseq_ok_alig

		output (Paragraph)
			Output parameters

		phylip (Switch)
			Relaxed PHYLIP output [default : standard PHYLIP output] (-p)

		quiet (Switch)
			non verbose output (-q)

		input (Paragraph)
			Input parameters

		input_seq (Integer)
			Ancestral Sequence number (-k)

=cut

#'
package Bio::Tools::Run::PiseApplication::seqgen;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $seqgen = Bio::Tools::Run::PiseApplication::seqgen->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::seqgen object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $seqgen = $factory->program('seqgen');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::seqgen.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqgen.pm

    $self->{COMMAND}   = "seqgen";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SeqGen";

    $self->{DESCRIPTION}   = "Sequence-Generator";

    $self->{AUTHORS}   = "A. Rambaut, N. C. Grassly";

    $self->{REFERENCE}   = [

         "Rambaut, A. and Grassly, N. C. (1996) Seq-Gen: An application for the Monte Carlo simulation of DNA sequence evolution along phylogenetic trees. Comput. Appl. Biosci.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"seqgen",
	"tree",
	"control",
	"outfile",
	"output",
	"input",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"seqgen",
	"tree", 	# Tree File
	"control", 	# Control parameters
	"model", 	# model of nucleotide substitution
	"length", 	# sequence length (-l)
	"datasets", 	# number of simulated datasets per tree (-n)
	"scale_branch", 	# Scale branch lengths  (a decimal number greater > 0) (-s)
	"scale_tree", 	# total tree scale  (a decimal number greater > 0) [default = use branch lengths] (-d)
	"rate1", 	# rates for codon position heterogeneity, first position (enter a decimal number) (-c)
	"rate2", 	# rates for codon position heterogeneity, second position (enter a decimal number)
	"rate3", 	# rates for codon position heterogeneity, third position (enter a decimal number)
	"shape", 	# shape of the gamma distribution to use  with  gamma rate heterogeneity (a decimal  number) (-a)
	"categories", 	# number of categories  for  the  discrete gamma  rate  heterogeneity model (>2 and < 32) (-g)
	"freqA", 	# relative frequencies of the A nucleotide (a decimal number) (-f)
	"freqC", 	# relative frequencies of the C nucleotide (a decimal number)
	"freqG", 	# relative frequencies of the G nucleotide (a decimal number)
	"freqT", 	# relative frequencies of the T nucleotide (a decimal number)
	"transratio", 	# transition transversion ratio (TS/TV) (this is only valid when either the HKY or F84 model has been selected) (-t)
	"matrix", 	# 6 values  for  the general reversable  model's rate matrix (ACTG x ACTG) (REV model), separated by commas (-r)
	"outfile",
	"output", 	# Output parameters
	"phylip", 	# Relaxed PHYLIP output [default : standard PHYLIP output] (-p)
	"quiet", 	# non verbose output (-q)
	"input", 	# Input parameters
	"input_seq", 	# Ancestral Sequence number (-k)

    ];

    $self->{TYPE}  = {
	"seqgen" => 'String',
	"tree" => 'InFile',
	"control" => 'Paragraph',
	"model" => 'Excl',
	"length" => 'Integer',
	"datasets" => 'Integer',
	"scale_branch" => 'Integer',
	"scale_tree" => 'Integer',
	"rate1" => 'Integer',
	"rate2" => 'Integer',
	"rate3" => 'Integer',
	"shape" => 'Integer',
	"categories" => 'Integer',
	"freqA" => 'Integer',
	"freqC" => 'Integer',
	"freqG" => 'Integer',
	"freqT" => 'Integer',
	"transratio" => 'Integer',
	"matrix" => 'String',
	"outfile" => 'Results',
	"output" => 'Paragraph',
	"phylip" => 'Switch',
	"quiet" => 'Switch',
	"input" => 'Paragraph',
	"input_seq" => 'Integer',

    };

    $self->{FORMAT}  = {
	"seqgen" => {
		"perl" => '"seq-gen"',
	},
	"tree" => {
		"perl" => '" < $value"',
	},
	"control" => {
	},
	"model" => {
		"perl" => ' ($value && $value ne $vdef )? " -m $value" : "" ',
	},
	"length" => {
		"perl" => '(defined $value && $value ne $vdef)? " -l $value":""',
	},
	"datasets" => {
		"perl" => '(defined $value && $value ne $vdef)? " -n $value":""',
	},
	"scale_branch" => {
		"perl" => '(defined $value)? " -s $value":""',
	},
	"scale_tree" => {
		"perl" => '(defined $value)? " -d $value":""',
	},
	"rate1" => {
		"perl" => '(defined $value)? " -c $rate1 $rate2 $rate3":""',
	},
	"rate2" => {
		"perl" => '""',
	},
	"rate3" => {
		"perl" => '""',
	},
	"shape" => {
		"perl" => '(defined $value)? " -a $value":""',
	},
	"categories" => {
		"perl" => '(defined $value)? " -g $value":""',
	},
	"freqA" => {
		"perl" => '(defined $value)? " -f $freqA,$freqC,$freqG,$freqT":""',
	},
	"freqC" => {
		"perl" => '""',
	},
	"freqG" => {
		"perl" => '""',
	},
	"freqT" => {
		"perl" => '""',
	},
	"transratio" => {
		"perl" => '(defined $value)? " -t $value":""',
	},
	"matrix" => {
		"perl" => '($value)? " -r $value":""',
	},
	"outfile" => {
	},
	"output" => {
	},
	"phylip" => {
		"perl" => '($value)? " -p":""',
	},
	"quiet" => {
		"perl" => '($value)? " -q":""',
	},
	"input" => {
	},
	"input_seq" => {
		"perl" => '(defined $value)? " -k $value":""',
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'seqgen.out',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"seqgen" => 0,
	"tree" => 20,
	"model" => 1,
	"length" => 1,
	"datasets" => 1,
	"scale_branch" => 1,
	"scale_tree" => 1,
	"rate1" => 1,
	"rate2" => 1,
	"rate3" => 1,
	"shape" => 1,
	"categories" => 1,
	"freqA" => 1,
	"freqC" => 1,
	"freqG" => 1,
	"freqT" => 1,
	"transratio" => 1,
	"matrix" => 1,
	"phylip" => 1,
	"quiet" => 1,
	"input" => 1,
	"input_seq" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"seqgen",
	"outfile",
	"control",
	"output",
	"length",
	"datasets",
	"scale_branch",
	"scale_tree",
	"rate1",
	"rate2",
	"rate3",
	"shape",
	"categories",
	"freqA",
	"freqC",
	"freqG",
	"freqT",
	"transratio",
	"matrix",
	"model",
	"phylip",
	"quiet",
	"input",
	"input_seq",
	"tree",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"seqgen" => 1,
	"tree" => 0,
	"control" => 0,
	"model" => 0,
	"length" => 0,
	"datasets" => 0,
	"scale_branch" => 0,
	"scale_tree" => 0,
	"rate1" => 0,
	"rate2" => 0,
	"rate3" => 0,
	"shape" => 0,
	"categories" => 0,
	"freqA" => 0,
	"freqC" => 0,
	"freqG" => 0,
	"freqT" => 0,
	"transratio" => 0,
	"matrix" => 0,
	"outfile" => 0,
	"output" => 0,
	"phylip" => 0,
	"quiet" => 0,
	"input" => 0,
	"input_seq" => 0,

    };

    $self->{ISCOMMAND}  = {
	"seqgen" => 1,
	"tree" => 0,
	"control" => 0,
	"model" => 0,
	"length" => 0,
	"datasets" => 0,
	"scale_branch" => 0,
	"scale_tree" => 0,
	"rate1" => 0,
	"rate2" => 0,
	"rate3" => 0,
	"shape" => 0,
	"categories" => 0,
	"freqA" => 0,
	"freqC" => 0,
	"freqG" => 0,
	"freqT" => 0,
	"transratio" => 0,
	"matrix" => 0,
	"outfile" => 0,
	"output" => 0,
	"phylip" => 0,
	"quiet" => 0,
	"input" => 0,
	"input_seq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"seqgen" => 0,
	"tree" => 1,
	"control" => 0,
	"model" => 0,
	"length" => 0,
	"datasets" => 0,
	"scale_branch" => 0,
	"scale_tree" => 0,
	"rate1" => 0,
	"rate2" => 0,
	"rate3" => 0,
	"shape" => 0,
	"categories" => 0,
	"freqA" => 0,
	"freqC" => 0,
	"freqG" => 0,
	"freqT" => 0,
	"transratio" => 0,
	"matrix" => 0,
	"outfile" => 0,
	"output" => 0,
	"phylip" => 0,
	"quiet" => 0,
	"input" => 0,
	"input_seq" => 0,

    };

    $self->{PROMPT}  = {
	"seqgen" => "",
	"tree" => "Tree File",
	"control" => "Control parameters",
	"model" => "model of nucleotide substitution",
	"length" => "sequence length (-l)",
	"datasets" => "number of simulated datasets per tree (-n)",
	"scale_branch" => "Scale branch lengths  (a decimal number greater > 0) (-s)",
	"scale_tree" => "total tree scale  (a decimal number greater > 0) [default = use branch lengths] (-d)",
	"rate1" => "rates for codon position heterogeneity, first position (enter a decimal number) (-c)",
	"rate2" => "rates for codon position heterogeneity, second position (enter a decimal number)",
	"rate3" => "rates for codon position heterogeneity, third position (enter a decimal number)",
	"shape" => "shape of the gamma distribution to use  with  gamma rate heterogeneity (a decimal  number) (-a)",
	"categories" => "number of categories  for  the  discrete gamma  rate  heterogeneity model (>2 and < 32) (-g)",
	"freqA" => "relative frequencies of the A nucleotide (a decimal number) (-f)",
	"freqC" => "relative frequencies of the C nucleotide (a decimal number)",
	"freqG" => "relative frequencies of the G nucleotide (a decimal number)",
	"freqT" => "relative frequencies of the T nucleotide (a decimal number)",
	"transratio" => "transition transversion ratio (TS/TV) (this is only valid when either the HKY or F84 model has been selected) (-t)",
	"matrix" => "6 values  for  the general reversable  model's rate matrix (ACTG x ACTG) (REV model), separated by commas (-r)",
	"outfile" => "",
	"output" => "Output parameters",
	"phylip" => "Relaxed PHYLIP output [default : standard PHYLIP output] (-p)",
	"quiet" => "non verbose output (-q)",
	"input" => "Input parameters",
	"input_seq" => "Ancestral Sequence number (-k)",

    };

    $self->{ISSTANDOUT}  = {
	"seqgen" => 0,
	"tree" => 0,
	"control" => 0,
	"model" => 0,
	"length" => 0,
	"datasets" => 0,
	"scale_branch" => 0,
	"scale_tree" => 0,
	"rate1" => 0,
	"rate2" => 0,
	"rate3" => 0,
	"shape" => 0,
	"categories" => 0,
	"freqA" => 0,
	"freqC" => 0,
	"freqG" => 0,
	"freqT" => 0,
	"transratio" => 0,
	"matrix" => 0,
	"outfile" => 0,
	"output" => 0,
	"phylip" => 0,
	"quiet" => 0,
	"input" => 0,
	"input_seq" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['model','length','datasets','scale_branch','scale_tree','rate1','rate2','rate3','shape','categories','freqA','freqC','freqG','freqT','transratio','matrix',],
	"model" => ['F84','F84','HKY','HKY','REV','REV',],
	"output" => ['phylip','quiet',],
	"input" => ['input_seq',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"model" => 'F84',
	"length" => '1000',
	"datasets" => '1',

    };

    $self->{PRECOND}  = {
	"seqgen" => { "perl" => '1' },
	"tree" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"model" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"datasets" => { "perl" => '1' },
	"scale_branch" => { "perl" => '1' },
	"scale_tree" => { "perl" => '1' },
	"rate1" => { "perl" => '1' },
	"rate2" => { "perl" => '1' },
	"rate3" => { "perl" => '1' },
	"shape" => { "perl" => '1' },
	"categories" => { "perl" => '1' },
	"freqA" => { "perl" => '1' },
	"freqC" => { "perl" => '1' },
	"freqG" => { "perl" => '1' },
	"freqT" => { "perl" => '1' },
	"transratio" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"phylip" => { "perl" => '1' },
	"quiet" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"input_seq" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"rate1" => {
		"perl" => {
			'((defined $rate2 || defined $rate3) && ! (defined $rate1))' => "you must give the 3 rates",
		},
	},
	"rate2" => {
		"perl" => {
			'((defined $rate1 || defined $rate3) && ! (defined $rate2))' => "you must give the 3 rates",
		},
	},
	"rate3" => {
		"perl" => {
			'((defined $rate1 || defined $rate2) && ! (defined $rate3))' => "you must give the 3 rates",
		},
	},
	"categories" => {
		"perl" => {
			'defined $categories && ($categories < 2 || $$categories > 32)' => "enter an integer number between 2 and 32",
		},
	},
	"freqA" => {
		"perl" => {
			'((defined $freqC || defined $freqG || defined $freqT) && ! (defined $freqA))' => "you must give the frequencies for the 4 nucleotides",
		},
	},
	"freqC" => {
		"perl" => {
			'((defined $freqA || defined $freqG || defined $freqT) && ! (defined $freqC))' => "you must give the frequencies for the 4 nucleotides",
		},
	},
	"freqG" => {
		"perl" => {
			'((defined $freqA || defined $freqC || defined $freqT) && ! (defined $freqG))' => "you must give the frequencies for the 4 nucleotides",
		},
	},
	"freqT" => {
		"perl" => {
			'((defined $freqA || defined $freqC || defined $freqG) && ! (defined $freqT))' => "you must give the frequencies for the 4 nucleotides",
		},
	},
	"matrix" => {
		"perl" => {
			'($matrix =~ s/,/ /g ) && 0' => "",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"tree" => {
		 "phylip_tree" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"seqgen" => 0,
	"tree" => 0,
	"control" => 0,
	"model" => 0,
	"length" => 0,
	"datasets" => 0,
	"scale_branch" => 0,
	"scale_tree" => 0,
	"rate1" => 0,
	"rate2" => 0,
	"rate3" => 0,
	"shape" => 0,
	"categories" => 0,
	"freqA" => 0,
	"freqC" => 0,
	"freqG" => 0,
	"freqT" => 0,
	"transratio" => 0,
	"matrix" => 0,
	"outfile" => 0,
	"output" => 0,
	"phylip" => 0,
	"quiet" => 0,
	"input" => 0,
	"input_seq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"seqgen" => 0,
	"tree" => 1,
	"control" => 0,
	"model" => 0,
	"length" => 0,
	"datasets" => 0,
	"scale_branch" => 0,
	"scale_tree" => 0,
	"rate1" => 0,
	"rate2" => 0,
	"rate3" => 0,
	"shape" => 0,
	"categories" => 0,
	"freqA" => 0,
	"freqC" => 0,
	"freqG" => 0,
	"freqT" => 0,
	"transratio" => 0,
	"matrix" => 0,
	"outfile" => 0,
	"output" => 0,
	"phylip" => 0,
	"quiet" => 0,
	"input" => 0,
	"input_seq" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"tree" => [
		"The tree file must contain one or more trees.",
		"The tree format is the same as used by PHYLIP (also called the \'Newick\' format). This is a nested set of bifurcations defined by brackets and commas. Here are two examples:",
		" (((Taxon1:0.2,Taxon2:0.2):0.1,Taxon3:0.3):0.1,Taxon4:0.4);",
		" ((Taxon1:0.1,Taxon2:0.2):0.05,Taxon3:0.3,Taxon4:0.4);",
	],
	"model" => [
		"This option sets the model of nucleotide substitution with a choice of either F84, HKY (also known as HKY85) or REV (markov general reversable model). The first two models are quite similar but not identical. They both require a transition transversion ratio and relative base frequencies as parameters. Other models such as K2P, F81 and JC69 are special cases of HKY and can be obtained by setting the nucleotide frequencies equal (for K2P) or the transition transversion ratio to 1.0 (for F81) or both (for JC69). ",
		" If no model is specified, the default is F84 which is computationally simpler.",
	],
	"length" => [
		"This option allows the user to set the length in nucleotides that each simulated sequence should be.",
	],
	"datasets" => [
		"This option specifies how many separate datasets should be simulated for each tree in the tree file.",
	],
	"scale_branch" => [
		"This option allows the user to set a value with which to scale the branch lengths in order to make them equal the expected number of substitutions per site for each branch. Basically Seq-Gen multiplies each branch length by this value.",
		"For example if you give an value of 0.5 then each branch length would be halved before using it to simulate the sequences.",
	],
	"scale_tree" => [
		"This option allows the user to set a value which is the desired length of each tree in units of subsitutions per site. The term \'tree length\' here is the distance from the root to any one of the tips in units of mean number of subsitutions per site. This option can only be used when the input trees are rooted and ultrametric (no difference in rate amongst the lineages). This has the effect of making all the trees in the input file of the same length before simulating data.",
		" The option multiplies each branch length by a value equal to SCALE divided by the actual length of the tree.",
	],
	"rate1" => [
		"Using this option the user may specify the relative rates for each codon position. This allows codon-specific rate heterogeneity to be simulated. The default is no site-specific rate heterogeneity.",
	],
	"shape" => [
		"Using this option the user may specify a shape for the gamma rate heterogeneity. The default is no site-specific rate heterogeneity.",
	],
	"categories" => [
		"Using this option the user may specify the number of categories for the discrete gamma rate heterogeneity model. The default is no site-specific rate heterogeneity (or the continuous model if only the -a option is specified.",
	],
	"freqA" => [
		"This option is used to specify the relative frequencies of the four nucleotides. By default, Seq-Gen will assume these to be equal. If the given values don\'t sum to 1.0 then they will be scaled so that they do.",
	],
	"transratio" => [
		"This option allows the user to set a value for the transition transversion ratio (TS/TV). This is only valid when either the HKY or F84 model has been selected.",
	],
	"matrix" => [
		"This option allows the user to set 6 values for the general reversable model\'s rate matrix. This is only valid when either the REV model has been selected.",
		"The values are six decimal numbers for the rates of transition from A to C, A to G, A to T, C to G, C to T and G to T respectively, separated by spaces or commas. The matrix is symmetrical so the reverse transitions equal the ones set (e.g. C to A equals A to C) and therefore only six values need be set. These values will be scaled such that the last value (G to T) is 1.0 and the others are set relative to this.",
	],
	"input_seq" => [
		"This option allows the user to use a supplied sequence as the ancestral sequence at the root (otherwise a random sequence is used). The value is an integer number greater than zero which refers to one of the sequences supplied as input with the tree.",
		"Method: The user can supply a sequence alignment as input, as well as the trees. This should be in relaxed PHYLIP format. The trees can then be placed in this file at the end, after a line stating how many trees there are.The file may look like this: ",
		"4 50",
		"Taxon1 ATCTTTGTAGTCATCGCCGTATTAGCATTCTTAGATCTAA",
		"Taxon2 ATCCTAGTAGTCGCTTGCGCACTAGCCTTCCGAAATCTAG",
		"Taxon3 ACTTCTGTGTTTACTGAGCTACTAGCTTCCCTAAATCTAG",
		"Taxon4 ATTCCTATATTCGCTAATTTCTTAGCTTTCCTGAATCTGG",
		"1",
		"(((Taxon1:0.2,Taxon2:0.2):0.1,Taxon3:0.3):0.1,Taxon4:0.4);",
		"Note that the labels in the alignment do not have to match those in the tree (the ones in the tree will be used for output)   there doesn t even have to be the same number of taxa in the alignment as in the trees. The sequence length supplied by the alignment will be used to obtain the simulated sequence length (unless the  l option is set). The  k option also refers to one of the sequences to specify the ancestral sequence. (see Appendix A)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqgen.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

