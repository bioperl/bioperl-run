
=head1 NAME

Bio::Tools::Run::PiseApplication::Puzzle

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::Puzzle

      Bioperl class for:

	Puzzle	Tree reconstruction for sequences by quartet puzzling and maximum likelihood (Strimmer, von Haeseler)

	References:

		Strimmer, K., and A. von Haeseler. 1996. Quartet puzzling:A quartet maximum likelihood method for reconstructing tree topologies. Mol. Biol. Evol. 13: 964-969.


      Parameters:


		Puzzle (String)
			

		stdinput (String)
			

		confirm (String)
			

		outfile (Results)
			

		outtree (Results)
			
			pipe: phylip_tree

		outdist (Results)
			
			pipe: phylip_dist

		params (Results)
			

		infile (Sequence)
			Alignement File
			pipe: readseq_ok_alig

		seqtype (Excl)
			Is it a DNA or protein sequence

		control_options (Paragraph)
			Control options

		approximate (Switch)
			Approximate quartet likelihood (v)

		puzzling_step (Integer)
			Number of puzzling steps (n)

		protein_options (Paragraph)
			Protein options

		protein_model (Excl)
			Model of substitution for protein (if no automatic guess) (m)

		dna_options (Paragraph)
			DNA options

		ratio (Float)
			Transition/transversion ratio (t)

		nuc_freq (Paragraph)
			Nucleotids frequencies (in %) (f)

		use_specified (Switch)
			Use specified values

		a_freq (Float)
			pi(A)

		c_freq (Float)
			pi(C)

		g_freq (Float)
			pi(G)

		dna_model (Excl)
			Model of substitution for DNA (m)

		constrain_TN (Switch)
			Constrain TN model to F84 model (p)

		f84_ratio (Float)
			Expected F84 Transition/transversion ratio

		y_r (Float)
			Y/R transition parameter (r)

		symmetrize_frequencies (Switch)
			Symmetrize doublet frequencies (s)

		rate_options (Paragraph)
			Rate heterogeneity options

		rate_heterogeneity (Excl)
			Model of rate heterogeneity (w)

		alpha (Float)
			Gamma distribution parameter alpha (a)

		gamma_number (Integer)
			Number of Gamma rate categories (c)

		invariable (Float)
			Fraction of invariable sites (i)

		user_tree_options (Paragraph)
			User Tree options

		user_tree (Switch)
			Tree search procedure: User tree (k)

		tree_file (InFile)
			User Tree file

		no_tree (Switch)
			Pairwise distances only (no tree) (k)

		output_options (Paragraph)
			Output options

		outgroup (Integer)
			Display as outgroup (o)

		branch_length (Switch)
			Compute clocklike branch lengths (z)

		estimates (Excl)
			Parameter estimates (e)

		estimation_by (Excl)
			Parameter estimation by (x)

		list_unresolved (Switch)
			List unresolved quartets (u)

		list_trees (Switch)
			List puzzling step trees (j)

=cut

#'
package Bio::Tools::Run::PiseApplication::Puzzle;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $Puzzle = Bio::Tools::Run::PiseApplication::Puzzle->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::Puzzle object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $Puzzle = $factory->program('Puzzle');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::Puzzle.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/Puzzle.pm

    $self->{COMMAND}   = "Puzzle";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Puzzle";

    $self->{DESCRIPTION}   = "Tree reconstruction for sequences by quartet puzzling and maximum likelihood";

    $self->{AUTHORS}   = "Strimmer, von Haeseler";

    $self->{REFERENCE}   = [

         "Strimmer, K., and A. von Haeseler. 1996. Quartet puzzling:A quartet maximum likelihood method for reconstructing tree topologies. Mol. Biol. Evol. 13: 964-969.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"Puzzle",
	"stdinput",
	"confirm",
	"outfile",
	"outtree",
	"outdist",
	"params",
	"infile",
	"seqtype",
	"control_options",
	"dna_model",
	"constrain_TN",
	"f84_ratio",
	"y_r",
	"symmetrize_frequencies",
	"output_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"Puzzle",
	"stdinput",
	"confirm",
	"outfile",
	"outtree",
	"outdist",
	"params",
	"infile", 	# Alignement File
	"seqtype", 	# Is it a DNA or protein sequence
	"control_options", 	# Control options
	"approximate", 	# Approximate quartet likelihood (v)
	"puzzling_step", 	# Number of puzzling steps (n)
	"protein_options", 	# Protein options
	"protein_model", 	# Model of substitution for protein (if no automatic guess) (m)
	"dna_options", 	# DNA options
	"ratio", 	# Transition/transversion ratio (t)
	"nuc_freq", 	# Nucleotids frequencies (in %) (f)
	"use_specified", 	# Use specified values
	"a_freq", 	# pi(A)
	"c_freq", 	# pi(C)
	"g_freq", 	# pi(G)
	"dna_model", 	# Model of substitution for DNA (m)
	"constrain_TN", 	# Constrain TN model to F84 model (p)
	"f84_ratio", 	# Expected F84 Transition/transversion ratio
	"y_r", 	# Y/R transition parameter (r)
	"symmetrize_frequencies", 	# Symmetrize doublet frequencies (s)
	"rate_options", 	# Rate heterogeneity options
	"rate_heterogeneity", 	# Model of rate heterogeneity (w)
	"alpha", 	# Gamma distribution parameter alpha (a)
	"gamma_number", 	# Number of Gamma rate categories (c)
	"invariable", 	# Fraction of invariable sites (i)
	"user_tree_options", 	# User Tree options
	"user_tree", 	# Tree search procedure: User tree (k)
	"tree_file", 	# User Tree file
	"no_tree", 	# Pairwise distances only (no tree) (k)
	"output_options", 	# Output options
	"outgroup", 	# Display as outgroup (o)
	"branch_length", 	# Compute clocklike branch lengths (z)
	"estimates", 	# Parameter estimates (e)
	"estimation_by", 	# Parameter estimation by (x)
	"list_unresolved", 	# List unresolved quartets (u)
	"list_trees", 	# List puzzling step trees (j)

    ];

    $self->{TYPE}  = {
	"Puzzle" => 'String',
	"stdinput" => 'String',
	"confirm" => 'String',
	"outfile" => 'Results',
	"outtree" => 'Results',
	"outdist" => 'Results',
	"params" => 'Results',
	"infile" => 'Sequence',
	"seqtype" => 'Excl',
	"control_options" => 'Paragraph',
	"approximate" => 'Switch',
	"puzzling_step" => 'Integer',
	"protein_options" => 'Paragraph',
	"protein_model" => 'Excl',
	"dna_options" => 'Paragraph',
	"ratio" => 'Float',
	"nuc_freq" => 'Paragraph',
	"use_specified" => 'Switch',
	"a_freq" => 'Float',
	"c_freq" => 'Float',
	"g_freq" => 'Float',
	"dna_model" => 'Excl',
	"constrain_TN" => 'Switch',
	"f84_ratio" => 'Float',
	"y_r" => 'Float',
	"symmetrize_frequencies" => 'Switch',
	"rate_options" => 'Paragraph',
	"rate_heterogeneity" => 'Excl',
	"alpha" => 'Float',
	"gamma_number" => 'Integer',
	"invariable" => 'Float',
	"user_tree_options" => 'Paragraph',
	"user_tree" => 'Switch',
	"tree_file" => 'InFile',
	"no_tree" => 'Switch',
	"output_options" => 'Paragraph',
	"outgroup" => 'Integer',
	"branch_length" => 'Switch',
	"estimates" => 'Excl',
	"estimation_by" => 'Excl',
	"list_unresolved" => 'Switch',
	"list_trees" => 'Switch',

    };

    $self->{FORMAT}  = {
	"Puzzle" => {
		"perl" => ' "Puzzle" ',
	},
	"stdinput" => {
		"perl" => ' " < params" ',
	},
	"confirm" => {
		"perl" => '"y\\n"',
	},
	"outfile" => {
	},
	"outtree" => {
	},
	"outdist" => {
	},
	"params" => {
	},
	"infile" => {
		"perl" => '"ln -s $infile infile; "',
	},
	"seqtype" => {
		"perl" => '""',
	},
	"control_options" => {
	},
	"approximate" => {
		"perl" => '($value)? "" : "v\\n"',
	},
	"puzzling_step" => {
		"perl" => '(defined $value && $value != $vdef)? "n\\n$value\\n" : ""',
	},
	"protein_options" => {
	},
	"protein_model" => {
	},
	"dna_options" => {
	},
	"ratio" => {
		"perl" => '(defined $value)? "t\\n$value\\n" : ""',
	},
	"nuc_freq" => {
	},
	"use_specified" => {
		"perl" => '($value)? "f\\n" : "" ',
	},
	"a_freq" => {
		"perl" => '"$value\\n"',
	},
	"c_freq" => {
		"perl" => '"$value\\n"',
	},
	"g_freq" => {
		"perl" => '"$value\\n"',
	},
	"dna_model" => {
	},
	"constrain_TN" => {
		"perl" => '($value)? "p\\n" : ""',
	},
	"f84_ratio" => {
		"perl" => '(defined $value)? "$value\\n" : ""',
	},
	"y_r" => {
		"perl" => '(defined $value)? "r\\n$value\\n" : ""',
	},
	"symmetrize_frequencies" => {
		"perl" => '($value)? "s\\n" : ""',
	},
	"rate_options" => {
	},
	"rate_heterogeneity" => {
	},
	"alpha" => {
		"perl" => '(defined $value)? "a\\n$value\\n" : ""',
	},
	"gamma_number" => {
		"perl" => '(defined $value && $value != $vdef)? "c\\n$value\\n" : ""',
	},
	"invariable" => {
		"perl" => '(defined $value)? "i\\n$value\\n" : ""',
	},
	"user_tree_options" => {
	},
	"user_tree" => {
		"perl" => '($value)? "k\\n" : "" ',
	},
	"tree_file" => {
		"perl" => '($value)? "$tree_file\\n" : ""',
	},
	"no_tree" => {
		"perl" => '($value)? "k\\nk\\n" : "" ',
	},
	"output_options" => {
	},
	"outgroup" => {
		"perl" => '(defined $value)? "o\\n$value\\n" : ""',
	},
	"branch_length" => {
		"perl" => '($value)? "z\\n" : ""',
	},
	"estimates" => {
	},
	"estimation_by" => {
	},
	"list_unresolved" => {
		"perl" => '($value)? "u\\n" : ""',
	},
	"list_trees" => {
		"perl" => '($value)? "j\\n" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'outfile',
	"outtree" => 'outtree',
	"outdist" => 'outdist',
	"params" => 'params',

    };

    $self->{SEQFMT}  = {
	"infile" => [12],

    };

    $self->{GROUP}  = {
	"Puzzle" => 0,
	"stdinput" => 2,
	"confirm" => 1000,
	"infile" => -10,
	"seqtype" => -10,
	"approximate" => 1,
	"puzzling_step" => 1,
	"protein_model" => 1,
	"ratio" => 1,
	"use_specified" => 50,
	"a_freq" => 51,
	"c_freq" => 52,
	"g_freq" => 53,
	"dna_model" => 10,
	"constrain_TN" => 11,
	"f84_ratio" => 12,
	"y_r" => 13,
	"symmetrize_frequencies" => 11,
	"rate_heterogeneity" => 20,
	"alpha" => 21,
	"gamma_number" => 21,
	"invariable" => 21,
	"user_tree" => 1,
	"tree_file" => 2000,
	"no_tree" => 1,
	"outgroup" => 1,
	"branch_length" => 1,
	"estimates" => 1,
	"estimation_by" => 1,
	"list_unresolved" => 1,
	"list_trees" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"seqtype",
	"infile",
	"Puzzle",
	"nuc_freq",
	"rate_options",
	"outfile",
	"outtree",
	"outdist",
	"params",
	"control_options",
	"user_tree_options",
	"output_options",
	"protein_options",
	"dna_options",
	"list_trees",
	"approximate",
	"puzzling_step",
	"ratio",
	"user_tree",
	"no_tree",
	"protein_model",
	"outgroup",
	"branch_length",
	"estimates",
	"estimation_by",
	"list_unresolved",
	"stdinput",
	"dna_model",
	"symmetrize_frequencies",
	"constrain_TN",
	"f84_ratio",
	"y_r",
	"rate_heterogeneity",
	"invariable",
	"alpha",
	"gamma_number",
	"use_specified",
	"a_freq",
	"c_freq",
	"g_freq",
	"confirm",
	"tree_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"Puzzle" => 1,
	"stdinput" => 1,
	"confirm" => 1,
	"outfile" => 0,
	"outtree" => 0,
	"outdist" => 0,
	"params" => 0,
	"infile" => 0,
	"seqtype" => 0,
	"control_options" => 0,
	"approximate" => 0,
	"puzzling_step" => 0,
	"protein_options" => 0,
	"protein_model" => 0,
	"dna_options" => 0,
	"ratio" => 0,
	"nuc_freq" => 0,
	"use_specified" => 0,
	"a_freq" => 0,
	"c_freq" => 0,
	"g_freq" => 0,
	"dna_model" => 0,
	"constrain_TN" => 0,
	"f84_ratio" => 0,
	"y_r" => 0,
	"symmetrize_frequencies" => 0,
	"rate_options" => 0,
	"rate_heterogeneity" => 0,
	"alpha" => 0,
	"gamma_number" => 0,
	"invariable" => 0,
	"user_tree_options" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"no_tree" => 0,
	"output_options" => 0,
	"outgroup" => 0,
	"branch_length" => 0,
	"estimates" => 0,
	"estimation_by" => 0,
	"list_unresolved" => 0,
	"list_trees" => 0,

    };

    $self->{ISCOMMAND}  = {
	"Puzzle" => 1,
	"stdinput" => 0,
	"confirm" => 0,
	"outfile" => 0,
	"outtree" => 0,
	"outdist" => 0,
	"params" => 0,
	"infile" => 0,
	"seqtype" => 0,
	"control_options" => 0,
	"approximate" => 0,
	"puzzling_step" => 0,
	"protein_options" => 0,
	"protein_model" => 0,
	"dna_options" => 0,
	"ratio" => 0,
	"nuc_freq" => 0,
	"use_specified" => 0,
	"a_freq" => 0,
	"c_freq" => 0,
	"g_freq" => 0,
	"dna_model" => 0,
	"constrain_TN" => 0,
	"f84_ratio" => 0,
	"y_r" => 0,
	"symmetrize_frequencies" => 0,
	"rate_options" => 0,
	"rate_heterogeneity" => 0,
	"alpha" => 0,
	"gamma_number" => 0,
	"invariable" => 0,
	"user_tree_options" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"no_tree" => 0,
	"output_options" => 0,
	"outgroup" => 0,
	"branch_length" => 0,
	"estimates" => 0,
	"estimation_by" => 0,
	"list_unresolved" => 0,
	"list_trees" => 0,

    };

    $self->{ISMANDATORY}  = {
	"Puzzle" => 0,
	"stdinput" => 0,
	"confirm" => 0,
	"outfile" => 0,
	"outtree" => 0,
	"outdist" => 0,
	"params" => 0,
	"infile" => 1,
	"seqtype" => 1,
	"control_options" => 0,
	"approximate" => 0,
	"puzzling_step" => 0,
	"protein_options" => 0,
	"protein_model" => 0,
	"dna_options" => 0,
	"ratio" => 0,
	"nuc_freq" => 0,
	"use_specified" => 0,
	"a_freq" => 1,
	"c_freq" => 1,
	"g_freq" => 1,
	"dna_model" => 0,
	"constrain_TN" => 0,
	"f84_ratio" => 0,
	"y_r" => 0,
	"symmetrize_frequencies" => 0,
	"rate_options" => 0,
	"rate_heterogeneity" => 0,
	"alpha" => 0,
	"gamma_number" => 0,
	"invariable" => 0,
	"user_tree_options" => 0,
	"user_tree" => 0,
	"tree_file" => 1,
	"no_tree" => 0,
	"output_options" => 0,
	"outgroup" => 0,
	"branch_length" => 0,
	"estimates" => 0,
	"estimation_by" => 0,
	"list_unresolved" => 0,
	"list_trees" => 0,

    };

    $self->{PROMPT}  = {
	"Puzzle" => "",
	"stdinput" => "",
	"confirm" => "",
	"outfile" => "",
	"outtree" => "",
	"outdist" => "",
	"params" => "",
	"infile" => "Alignement File",
	"seqtype" => "Is it a DNA or protein sequence",
	"control_options" => "Control options",
	"approximate" => "Approximate quartet likelihood (v)",
	"puzzling_step" => "Number of puzzling steps (n)",
	"protein_options" => "Protein options",
	"protein_model" => "Model of substitution for protein (if no automatic guess) (m)",
	"dna_options" => "DNA options",
	"ratio" => "Transition/transversion ratio (t)",
	"nuc_freq" => "Nucleotids frequencies (in %) (f)",
	"use_specified" => "Use specified values",
	"a_freq" => "pi(A)",
	"c_freq" => "pi(C)",
	"g_freq" => "pi(G)",
	"dna_model" => "Model of substitution for DNA (m)",
	"constrain_TN" => "Constrain TN model to F84 model (p)",
	"f84_ratio" => "Expected F84 Transition/transversion ratio",
	"y_r" => "Y/R transition parameter (r)",
	"symmetrize_frequencies" => "Symmetrize doublet frequencies (s)",
	"rate_options" => "Rate heterogeneity options",
	"rate_heterogeneity" => "Model of rate heterogeneity (w)",
	"alpha" => "Gamma distribution parameter alpha (a)",
	"gamma_number" => "Number of Gamma rate categories (c)",
	"invariable" => "Fraction of invariable sites (i)",
	"user_tree_options" => "User Tree options",
	"user_tree" => "Tree search procedure: User tree (k)",
	"tree_file" => "User Tree file",
	"no_tree" => "Pairwise distances only (no tree) (k)",
	"output_options" => "Output options",
	"outgroup" => "Display as outgroup (o)",
	"branch_length" => "Compute clocklike branch lengths (z)",
	"estimates" => "Parameter estimates (e)",
	"estimation_by" => "Parameter estimation by (x)",
	"list_unresolved" => "List unresolved quartets (u)",
	"list_trees" => "List puzzling step trees (j)",

    };

    $self->{ISSTANDOUT}  = {
	"Puzzle" => 0,
	"stdinput" => 0,
	"confirm" => 0,
	"outfile" => 0,
	"outtree" => 0,
	"outdist" => 0,
	"params" => 0,
	"infile" => 0,
	"seqtype" => 0,
	"control_options" => 0,
	"approximate" => 0,
	"puzzling_step" => 0,
	"protein_options" => 0,
	"protein_model" => 0,
	"dna_options" => 0,
	"ratio" => 0,
	"nuc_freq" => 0,
	"use_specified" => 0,
	"a_freq" => 0,
	"c_freq" => 0,
	"g_freq" => 0,
	"dna_model" => 0,
	"constrain_TN" => 0,
	"f84_ratio" => 0,
	"y_r" => 0,
	"symmetrize_frequencies" => 0,
	"rate_options" => 0,
	"rate_heterogeneity" => 0,
	"alpha" => 0,
	"gamma_number" => 0,
	"invariable" => 0,
	"user_tree_options" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"no_tree" => 0,
	"output_options" => 0,
	"outgroup" => 0,
	"branch_length" => 0,
	"estimates" => 0,
	"estimation_by" => 0,
	"list_unresolved" => 0,
	"list_trees" => 0,

    };

    $self->{VLIST}  = {

	"seqtype" => ['DNA','DNA','protein','protein',],
	"control_options" => ['approximate','puzzling_step','protein_options','dna_options','rate_options','user_tree_options',],
	"protein_options" => ['protein_model',],
	"protein_model" => ['1','Dayhoff (Dayhoff et al. 1978)','2','JTT (Jones et al. 1992)','3','mtREV24 (Adachi-Hasegawa 1996)','4','BLOSUM 62 (Henikoff-Henikoff 1992)',],
	"dna_options" => ['ratio','nuc_freq',],
	"nuc_freq" => ['use_specified','a_freq','c_freq','g_freq',],
	"dna_model" => ['1','HKY (Hasegawa et al. 1985)','2','TN (Tamura-Nei 1993)','3','SH (Schoeniger-von Haeseler 1994)',],
	"rate_options" => ['rate_heterogeneity','alpha','gamma_number','invariable',],
	"rate_heterogeneity" => ['1','Uniform rate','2','Gamma distributed rates','3','Two rates (1 invariable + 1 variable)','4','Mixed (1 invariable + n Gamma rates)',],
	"user_tree_options" => ['user_tree','tree_file','no_tree',],
	"output_options" => ['outgroup','branch_length','estimates','estimation_by','list_unresolved','list_trees',],
	"estimates" => ['1','Approximate (faster)','2','Exact (slow)',],
	"estimation_by" => ['1','Neighbor-joining tree','2','Quartet sampling + NJ tree',],
    };

    $self->{FLIST}  = {

	"protein_model" => {
		'' => '""',
		'1' => '""',
		'2' => '"m\\n"',
		'3' => '"m\\nm\\n"',
		'4' => '"m\\nm\\nm\\n"',

	},
	"dna_model" => {
		'' => '""',
		'1' => '""',
		'2' => '"m\\n"',

	},
	"rate_heterogeneity" => {
		'1' => '""',
		'2' => '"w\\n"',
		'3' => '"w\\nw\\n"',
		'4' => '"w\\nw\\nw\\n"',

	},
	"estimates" => {
		'' => '""',
		'1' => '""',
		'2' => '"e\\n"',

	},
	"estimation_by" => {
		'' => '""',
		'1' => '""',
		'2' => '"x\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"approximate" => '1',
	"puzzling_step" => '1000',
	"protein_model" => '1',
	"use_specified" => '0',
	"dna_model" => '1',
	"constrain_TN" => '0',
	"symmetrize_frequencies" => '0',
	"rate_heterogeneity" => '1',
	"gamma_number" => '8',
	"user_tree" => '0',
	"no_tree" => '0',
	"branch_length" => '0',
	"estimates" => '1',
	"estimation_by" => '1',
	"list_unresolved" => '0',
	"list_trees" => '0',

    };

    $self->{PRECOND}  = {
	"Puzzle" => { "perl" => '1' },
	"stdinput" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"outtree" => { "perl" => '1' },
	"outdist" => { "perl" => '1' },
	"params" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"seqtype" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"approximate" => { "perl" => '1' },
	"puzzling_step" => { "perl" => '1' },
	"protein_options" => {
		"perl" => '$seqtype ne "DNA" ',
	},
	"protein_model" => {
		"perl" => '$seqtype ne "DNA"  && ! $guessmodel',
	},
	"dna_options" => {
		"perl" => '$seqtype eq "DNA" ',
	},
	"ratio" => {
		"perl" => '$seqtype eq "DNA" ',
	},
	"nuc_freq" => {
		"perl" => '$seqtype eq "DNA" ',
	},
	"use_specified" => {
		"perl" => '$seqtype eq "DNA" ',
	},
	"a_freq" => {
		"perl" => '$use_specified',
	},
	"c_freq" => {
		"perl" => '$use_specified',
	},
	"g_freq" => {
		"perl" => '$use_specified',
	},
	"dna_model" => {
		"perl" => '$seqtype eq "DNA" ',
	},
	"constrain_TN" => {
		"perl" => '$seqtype eq "DNA"  && $dna_model eq "2"',
	},
	"f84_ratio" => {
		"perl" => '$seqtype eq "DNA"  && $dna_model eq "2"',
	},
	"y_r" => {
		"perl" => '$seqtype eq "DNA"  && $dna_model eq "2"',
	},
	"symmetrize_frequencies" => {
		"perl" => '$seqtype eq "DNA"  && $dna_model eq "3"',
	},
	"rate_options" => { "perl" => '1' },
	"rate_heterogeneity" => { "perl" => '1' },
	"alpha" => {
		"perl" => '$rate_heterogeneity eq "2" || $rate_heterogeneity eq "4" ',
	},
	"gamma_number" => {
		"perl" => '$rate_heterogeneity eq "2" || $rate_heterogeneity eq "4" ',
	},
	"invariable" => {
		"perl" => '$rate_heterogeneity eq "3" || $rate_heterogeneity eq "4" ',
	},
	"user_tree_options" => { "perl" => '1' },
	"user_tree" => { "perl" => '1' },
	"tree_file" => {
		"perl" => '$user_tree',
	},
	"no_tree" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"outgroup" => { "perl" => '1' },
	"branch_length" => { "perl" => '1' },
	"estimates" => { "perl" => '1' },
	"estimation_by" => { "perl" => '1' },
	"list_unresolved" => { "perl" => '1' },
	"list_trees" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outtree" => {
		 '1' => "phylip_tree",
	},
	"outdist" => {
		 '1' => "phylip_dist",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"Puzzle" => 0,
	"stdinput" => 0,
	"confirm" => 0,
	"outfile" => 0,
	"outtree" => 0,
	"outdist" => 0,
	"params" => 0,
	"infile" => 0,
	"seqtype" => 0,
	"control_options" => 0,
	"approximate" => 0,
	"puzzling_step" => 0,
	"protein_options" => 0,
	"protein_model" => 0,
	"dna_options" => 0,
	"ratio" => 0,
	"nuc_freq" => 0,
	"use_specified" => 0,
	"a_freq" => 0,
	"c_freq" => 0,
	"g_freq" => 0,
	"dna_model" => 0,
	"constrain_TN" => 0,
	"f84_ratio" => 0,
	"y_r" => 0,
	"symmetrize_frequencies" => 0,
	"rate_options" => 0,
	"rate_heterogeneity" => 0,
	"alpha" => 0,
	"gamma_number" => 0,
	"invariable" => 0,
	"user_tree_options" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"no_tree" => 0,
	"output_options" => 0,
	"outgroup" => 0,
	"branch_length" => 0,
	"estimates" => 0,
	"estimation_by" => 0,
	"list_unresolved" => 0,
	"list_trees" => 0,

    };

    $self->{ISSIMPLE}  = {
	"Puzzle" => 0,
	"stdinput" => 0,
	"confirm" => 0,
	"outfile" => 0,
	"outtree" => 0,
	"outdist" => 0,
	"params" => 0,
	"infile" => 1,
	"seqtype" => 1,
	"control_options" => 0,
	"approximate" => 0,
	"puzzling_step" => 0,
	"protein_options" => 0,
	"protein_model" => 0,
	"dna_options" => 0,
	"ratio" => 0,
	"nuc_freq" => 0,
	"use_specified" => 0,
	"a_freq" => 0,
	"c_freq" => 0,
	"g_freq" => 0,
	"dna_model" => 0,
	"constrain_TN" => 0,
	"f84_ratio" => 0,
	"y_r" => 0,
	"symmetrize_frequencies" => 0,
	"rate_options" => 0,
	"rate_heterogeneity" => 0,
	"alpha" => 0,
	"gamma_number" => 0,
	"invariable" => 0,
	"user_tree_options" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"no_tree" => 0,
	"output_options" => 0,
	"outgroup" => 0,
	"branch_length" => 0,
	"estimates" => 0,
	"estimation_by" => 0,
	"list_unresolved" => 0,
	"list_trees" => 0,

    };

    $self->{PARAMFILE}  = {
	"confirm" => "params",
	"approximate" => "params",
	"puzzling_step" => "params",
	"protein_model" => "params",
	"ratio" => "params",
	"use_specified" => "params",
	"a_freq" => "params",
	"c_freq" => "params",
	"g_freq" => "params",
	"dna_model" => "params",
	"constrain_TN" => "params",
	"f84_ratio" => "params",
	"y_r" => "params",
	"symmetrize_frequencies" => "params",
	"rate_heterogeneity" => "params",
	"alpha" => "params",
	"gamma_number" => "params",
	"invariable" => "params",
	"user_tree" => "params",
	"tree_file" => "params",
	"no_tree" => "params",
	"outgroup" => "params",
	"branch_length" => "params",
	"estimates" => "params",
	"estimation_by" => "params",
	"list_unresolved" => "params",
	"list_trees" => "params",

    };

    $self->{COMMENT}  = {
	"protein_model" => [
		"The Dayhoff and JTT matrices are for use with proteins encoded on nuclear DNA, and the mtREV24 matrix is for use with proteins encoded on mtDNA. The BLOSUM 62 model is for more distantly related amino acid sequences (Henikoff and Henikoff 1992).",
	],
	"dna_model" => [
		"The following models are implemented for nucleotides: the Tamura-Nei (TN) model, the Hasegawa et al. (HKY) model, and the Schöniger & von Haeseler (SH) model. The SH model describes the evolution of pairs of dependent nucleotides (pairs are the first and the second nucleotide, the third and the fourth nucleotide and so on). It allows for specification of the transition-transversion ratio. The originally proposed model (Schöniger & von Haeseler 1994) is obtained by setting the transition-transversion parameter to 0.5. The Jukes-Cantor (1969), the Felsenstein (1981), and the Kimura (1980) model are all special cases of the HKY model.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/Puzzle.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

