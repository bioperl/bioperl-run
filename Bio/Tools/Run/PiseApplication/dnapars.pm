
=head1 NAME

Bio::Tools::Run::PiseApplication::dnapars

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dnapars

      Bioperl class for:

	Phylip	dnapars - DNA Parsimony Program (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.


      Parameters:


		dnapars (String)
			

		infile (Sequence)
			Alignement File
			pipe: readseq_ok_alig

		dnapars_opt (Paragraph)
			Parcimony options

		use_threshold (Switch)
			Use Threshold parsimony (T)

		threshold (Integer)
			Threshold value (if use threshold parsimony)

		use_transversion (Switch)
			Use Transversion parsimony (N)

		bootstrap (Paragraph)
			Bootstrap options

		seqboot (Switch)
			Perform a bootstrap before analysis

		method (Excl)
			Resampling methods

		seqboot_seed (Integer)
			Random number seed (must be odd)

		jumble_message (Label)
			(You may also enter a random number seed for jumble)

		replicates (Integer)
			How many replicates

		consense (Switch)
			Compute a consensus tree

		multiple_dataset (String)
			

		bootconfirm (String)
			

		bootterminal_type (String)
			

		jumble_opt (Paragraph)
			Randomize options

		jumble (Switch)
			Randomize (jumble) input order (J)

		jumble_seed (Integer)
			Random number seed for jumble (must be odd)

		times (Integer)
			Number of times to jumble

		user_tree_opt (Paragraph)
			User tree options

		user_tree (Switch)
			Use User tree (default: no, search for best tree) (U)

		tree_file (InFile)
			User Tree file

		weight_opt (Paragraph)
			Weight options

		weights (Switch)
			Use weights for sites (W)

		weights_file (InFile)
			Weights file
			pipe: phylip_weights

		output (Paragraph)
			Output options

		print_tree (Switch)
			Print out tree (3)

		print_steps (Switch)
			Print out steps in each site (4)

		print_sequences (Switch)
			Print sequences at all nodes of tree (5)

		print_treefile (Switch)
			Write out trees onto tree file (6)

		printdata (Switch)
			Print out the data at start of run (1)

		indent_tree (Switch)
			Indent treefile

		other_options (Paragraph)
			Other options

		outgroup (Integer)
			Outgroup species (default, use as outgroup species 1) (O)

		outfile (Results)
			

		treefile (Results)
			
			pipe: phylip_tree

		indented_treefile (Results)
			

		params (Results)
			

		confirm (String)
			

		terminal_type (String)
			

		tmp_params (Results)
			

		consense_confirm (String)
			

		consense_terminal_type (String)
			

		consense_outfile (Results)
			

		consense_treefile (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::dnapars;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dnapars = Bio::Tools::Run::PiseApplication::dnapars->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dnapars object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $dnapars = $factory->program('dnapars');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::dnapars.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dnapars.pm

    $self->{COMMAND}   = "dnapars";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "dnapars - DNA Parsimony Program";

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dnapars",
	"infile",
	"dnapars_opt",
	"bootstrap",
	"jumble_opt",
	"user_tree_opt",
	"weight_opt",
	"output",
	"other_options",
	"outfile",
	"treefile",
	"indented_treefile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",
	"consense_confirm",
	"consense_terminal_type",
	"consense_outfile",
	"consense_treefile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dnapars",
	"infile", 	# Alignement File
	"dnapars_opt", 	# Parcimony options
	"use_threshold", 	# Use Threshold parsimony (T)
	"threshold", 	# Threshold value (if use threshold parsimony)
	"use_transversion", 	# Use Transversion parsimony (N)
	"bootstrap", 	# Bootstrap options
	"seqboot", 	# Perform a bootstrap before analysis
	"method", 	# Resampling methods
	"seqboot_seed", 	# Random number seed (must be odd)
	"jumble_message", 	# (You may also enter a random number seed for jumble)
	"replicates", 	# How many replicates
	"consense", 	# Compute a consensus tree
	"multiple_dataset",
	"bootconfirm",
	"bootterminal_type",
	"jumble_opt", 	# Randomize options
	"jumble", 	# Randomize (jumble) input order (J)
	"jumble_seed", 	# Random number seed for jumble (must be odd)
	"times", 	# Number of times to jumble
	"user_tree_opt", 	# User tree options
	"user_tree", 	# Use User tree (default: no, search for best tree) (U)
	"tree_file", 	# User Tree file
	"weight_opt", 	# Weight options
	"weights", 	# Use weights for sites (W)
	"weights_file", 	# Weights file
	"output", 	# Output options
	"print_tree", 	# Print out tree (3)
	"print_steps", 	# Print out steps in each site (4)
	"print_sequences", 	# Print sequences at all nodes of tree (5)
	"print_treefile", 	# Write out trees onto tree file (6)
	"printdata", 	# Print out the data at start of run (1)
	"indent_tree", 	# Indent treefile
	"other_options", 	# Other options
	"outgroup", 	# Outgroup species (default, use as outgroup species 1) (O)
	"outfile",
	"treefile",
	"indented_treefile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",
	"consense_confirm",
	"consense_terminal_type",
	"consense_outfile",
	"consense_treefile",

    ];

    $self->{TYPE}  = {
	"dnapars" => 'String',
	"infile" => 'Sequence',
	"dnapars_opt" => 'Paragraph',
	"use_threshold" => 'Switch',
	"threshold" => 'Integer',
	"use_transversion" => 'Switch',
	"bootstrap" => 'Paragraph',
	"seqboot" => 'Switch',
	"method" => 'Excl',
	"seqboot_seed" => 'Integer',
	"jumble_message" => 'Label',
	"replicates" => 'Integer',
	"consense" => 'Switch',
	"multiple_dataset" => 'String',
	"bootconfirm" => 'String',
	"bootterminal_type" => 'String',
	"jumble_opt" => 'Paragraph',
	"jumble" => 'Switch',
	"jumble_seed" => 'Integer',
	"times" => 'Integer',
	"user_tree_opt" => 'Paragraph',
	"user_tree" => 'Switch',
	"tree_file" => 'InFile',
	"weight_opt" => 'Paragraph',
	"weights" => 'Switch',
	"weights_file" => 'InFile',
	"output" => 'Paragraph',
	"print_tree" => 'Switch',
	"print_steps" => 'Switch',
	"print_sequences" => 'Switch',
	"print_treefile" => 'Switch',
	"printdata" => 'Switch',
	"indent_tree" => 'Switch',
	"other_options" => 'Paragraph',
	"outgroup" => 'Integer',
	"outfile" => 'Results',
	"treefile" => 'Results',
	"indented_treefile" => 'Results',
	"params" => 'Results',
	"confirm" => 'String',
	"terminal_type" => 'String',
	"tmp_params" => 'Results',
	"consense_confirm" => 'String',
	"consense_terminal_type" => 'String',
	"consense_outfile" => 'Results',
	"consense_treefile" => 'Results',

    };

    $self->{FORMAT}  = {
	"dnapars" => {
		"perl" => ' "dnapars < params" ',
	},
	"infile" => {
		"perl" => '"ln -s $infile infile; "',
	},
	"dnapars_opt" => {
	},
	"use_threshold" => {
		"perl" => '($value)? "T\\n$threshold\\n" : ""',
	},
	"threshold" => {
		"perl" => '"" ',
	},
	"use_transversion" => {
		"perl" => '($value)? "N\\n" : ""',
	},
	"bootstrap" => {
	},
	"seqboot" => {
		"perl" => '($value)? "seqboot < seqboot.params && mv outfile infile &&" : ""',
	},
	"method" => {
	},
	"seqboot_seed" => {
		"perl" => '"$value\\n"',
	},
	"jumble_message" => {
	},
	"replicates" => {
		"perl" => '($value && $value != $vdef)? "R\\n$value\\n" : ""',
	},
	"consense" => {
		"perl" => '($value)? ";cp infile infile.dnapars;mv outtree outtree.dnapars;mv outfile outfile.dnapars;cp outtree.dnapars intree;consense < consense.params; cp outtree outtree.consense; cp outfile outfile.consense; mv outtree.dnapars outtree; mv infile.dnapars infile; mv outfile.dnapars outfile" : ""',
	},
	"multiple_dataset" => {
		"perl" => '(defined $jumble_seed)?		"M\\nD\\n$replicates\\n$jumble_seed\\n$times\\n" : "M\\nD\\n$replicates\\n$seqboot_seed\\n$times\\n"',
	},
	"bootconfirm" => {
		"perl" => '"y\\n"',
	},
	"bootterminal_type" => {
		"perl" => '"0\\n"',
	},
	"jumble_opt" => {
	},
	"jumble" => {
		"perl" => '($value && ! $seqboot )? "j\\n$jumble_seed\\n$times\\n" : "" ',
	},
	"jumble_seed" => {
		"perl" => '""',
	},
	"times" => {
		"perl" => '""',
	},
	"user_tree_opt" => {
	},
	"user_tree" => {
		"perl" => '($value)? "U\\n" : "" ',
	},
	"tree_file" => {
		"perl" => '($value)? "ln -s $tree_file intree; " : ""',
	},
	"weight_opt" => {
	},
	"weights" => {
		"perl" => '($value)? "W\\n" : ""',
	},
	"weights_file" => {
		"perl" => '($value)? "ln -s $weights_file weights; " : ""',
	},
	"output" => {
	},
	"print_tree" => {
		"perl" => '($value)? "" : "3\\n"',
	},
	"print_steps" => {
		"perl" => '($value)? "5\\n" : ""',
	},
	"print_sequences" => {
		"perl" => '($value)? "5\\n" : ""',
	},
	"print_treefile" => {
		"perl" => '($value)? "" : "6\\n"',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"indent_tree" => {
		"perl" => '($value)? " && indenttree -o outtree.indent outtree" : "" ',
	},
	"other_options" => {
	},
	"outgroup" => {
		"perl" => '($value && $value != $vdef)? "o\\n$value\\n" : "" ',
	},
	"outfile" => {
	},
	"treefile" => {
	},
	"indented_treefile" => {
	},
	"params" => {
	},
	"confirm" => {
		"perl" => '"y\\n"',
	},
	"terminal_type" => {
		"perl" => '"0\\n"',
	},
	"tmp_params" => {
	},
	"consense_confirm" => {
		"perl" => '"Y\\n"',
	},
	"consense_terminal_type" => {
		"perl" => '"T\\n"',
	},
	"consense_outfile" => {
	},
	"consense_treefile" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'outfile',
	"treefile" => 'outtree',
	"indented_treefile" => 'outtree.indent',
	"params" => 'params',
	"tmp_params" => '*.params',
	"consense_outfile" => 'outfile.consense',
	"consense_treefile" => 'outtree.consense',

    };

    $self->{SEQFMT}  = {
	"infile" => [12],

    };

    $self->{GROUP}  = {
	"dnapars" => 0,
	"infile" => -10,
	"use_threshold" => 3,
	"threshold" => 2,
	"use_transversion" => 5,
	"seqboot" => -5,
	"method" => 1,
	"seqboot_seed" => 1010,
	"replicates" => 1,
	"consense" => 10,
	"multiple_dataset" => 1,
	"bootconfirm" => 1000,
	"bootterminal_type" => -1,
	"jumble" => 20,
	"jumble_seed" => 19,
	"times" => 19,
	"user_tree" => 1,
	"tree_file" => -1,
	"weights" => 1,
	"weights_file" => -1,
	"print_tree" => 1,
	"print_steps" => 1,
	"print_sequences" => 1,
	"print_treefile" => 1,
	"printdata" => 1,
	"indent_tree" => 1000,
	"outgroup" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,
	"consense_confirm" => 1000,
	"consense_terminal_type" => -2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"seqboot",
	"consense_terminal_type",
	"weights_file",
	"bootterminal_type",
	"tree_file",
	"terminal_type",
	"dnapars",
	"dnapars_opt",
	"output",
	"other_options",
	"outfile",
	"bootstrap",
	"treefile",
	"indented_treefile",
	"jumble_message",
	"params",
	"tmp_params",
	"consense_outfile",
	"consense_treefile",
	"jumble_opt",
	"user_tree_opt",
	"weight_opt",
	"outgroup",
	"user_tree",
	"print_tree",
	"method",
	"print_steps",
	"replicates",
	"print_sequences",
	"multiple_dataset",
	"print_treefile",
	"printdata",
	"weights",
	"threshold",
	"use_threshold",
	"use_transversion",
	"consense",
	"times",
	"jumble_seed",
	"jumble",
	"consense_confirm",
	"bootconfirm",
	"confirm",
	"indent_tree",
	"seqboot_seed",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dnapars" => 1,
	"infile" => 0,
	"dnapars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
	"use_transversion" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"jumble_message" => 0,
	"replicates" => 0,
	"consense" => 0,
	"multiple_dataset" => 1,
	"bootconfirm" => 1,
	"bootterminal_type" => 1,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_steps" => 0,
	"print_sequences" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 1,
	"terminal_type" => 1,
	"tmp_params" => 0,
	"consense_confirm" => 1,
	"consense_terminal_type" => 1,
	"consense_outfile" => 0,
	"consense_treefile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"dnapars" => 1,
	"infile" => 0,
	"dnapars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
	"use_transversion" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"jumble_message" => 0,
	"replicates" => 0,
	"consense" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_steps" => 0,
	"print_sequences" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"dnapars" => 0,
	"infile" => 1,
	"dnapars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 1,
	"use_transversion" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 1,
	"seqboot_seed" => 1,
	"jumble_message" => 0,
	"replicates" => 0,
	"consense" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 1,
	"times" => 1,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_steps" => 0,
	"print_sequences" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,

    };

    $self->{PROMPT}  = {
	"dnapars" => "",
	"infile" => "Alignement File",
	"dnapars_opt" => "Parcimony options",
	"use_threshold" => "Use Threshold parsimony (T)",
	"threshold" => "Threshold value (if use threshold parsimony)",
	"use_transversion" => "Use Transversion parsimony (N)",
	"bootstrap" => "Bootstrap options",
	"seqboot" => "Perform a bootstrap before analysis",
	"method" => "Resampling methods",
	"seqboot_seed" => "Random number seed (must be odd)",
	"jumble_message" => "(You may also enter a random number seed for jumble)",
	"replicates" => "How many replicates",
	"consense" => "Compute a consensus tree",
	"multiple_dataset" => "",
	"bootconfirm" => "",
	"bootterminal_type" => "",
	"jumble_opt" => "Randomize options",
	"jumble" => "Randomize (jumble) input order (J)",
	"jumble_seed" => "Random number seed for jumble (must be odd)",
	"times" => "Number of times to jumble",
	"user_tree_opt" => "User tree options",
	"user_tree" => "Use User tree (default: no, search for best tree) (U)",
	"tree_file" => "User Tree file",
	"weight_opt" => "Weight options",
	"weights" => "Use weights for sites (W)",
	"weights_file" => "Weights file",
	"output" => "Output options",
	"print_tree" => "Print out tree (3)",
	"print_steps" => "Print out steps in each site (4)",
	"print_sequences" => "Print sequences at all nodes of tree (5)",
	"print_treefile" => "Write out trees onto tree file (6)",
	"printdata" => "Print out the data at start of run (1)",
	"indent_tree" => "Indent treefile",
	"other_options" => "Other options",
	"outgroup" => "Outgroup species (default, use as outgroup species 1) (O)",
	"outfile" => "",
	"treefile" => "",
	"indented_treefile" => "",
	"params" => "",
	"confirm" => "",
	"terminal_type" => "",
	"tmp_params" => "",
	"consense_confirm" => "",
	"consense_terminal_type" => "",
	"consense_outfile" => "",
	"consense_treefile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"dnapars" => 0,
	"infile" => 0,
	"dnapars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
	"use_transversion" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"jumble_message" => 0,
	"replicates" => 0,
	"consense" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_steps" => 0,
	"print_sequences" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,

    };

    $self->{VLIST}  = {

	"dnapars_opt" => ['use_threshold','threshold','use_transversion',],
	"bootstrap" => ['seqboot','method','seqboot_seed','jumble_message','replicates','consense','multiple_dataset','bootconfirm','bootterminal_type',],
	"method" => ['bootstrap','Bootstrap','jackknife','Delete-half jackknife','permute','Permute species for each character',],
	"jumble_opt" => ['jumble','jumble_seed','times',],
	"user_tree_opt" => ['user_tree','tree_file',],
	"weight_opt" => ['weights','weights_file',],
	"output" => ['print_tree','print_steps','print_sequences','print_treefile','printdata','indent_tree',],
	"other_options" => ['outgroup',],
    };

    $self->{FLIST}  = {

	"method" => {
		'bootstrap' => '""',
		'permute' => '"J\\nJ\\n"',
		'jackknife' => '"J\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"use_threshold" => '0',
	"use_transversion" => '0',
	"seqboot" => '0',
	"method" => 'bootstrap',
	"replicates" => '100',
	"consense" => '0',
	"jumble" => '0',
	"times" => '1',
	"user_tree" => '0',
	"print_tree" => '1',
	"print_steps" => '0',
	"print_sequences" => '0',
	"print_treefile" => '1',
	"printdata" => '0',
	"indent_tree" => '0',
	"outgroup" => '1',

    };

    $self->{PRECOND}  = {
	"dnapars" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"dnapars_opt" => { "perl" => '1' },
	"use_threshold" => { "perl" => '1' },
	"threshold" => {
		"perl" => '$use_threshold',
	},
	"use_transversion" => { "perl" => '1' },
	"bootstrap" => { "perl" => '1' },
	"seqboot" => { "perl" => '1' },
	"method" => {
		"perl" => '$seqboot',
	},
	"seqboot_seed" => {
		"perl" => '$seqboot',
	},
	"jumble_message" => { "perl" => '1' },
	"replicates" => {
		"perl" => '$seqboot',
	},
	"consense" => {
		"perl" => '$seqboot && $print_treefile',
	},
	"multiple_dataset" => {
		"perl" => '$seqboot',
	},
	"bootconfirm" => {
		"perl" => '$seqboot',
	},
	"bootterminal_type" => {
		"perl" => '$seqboot',
	},
	"jumble_opt" => { "perl" => '1' },
	"jumble" => { "perl" => '1' },
	"jumble_seed" => {
		"perl" => '$jumble',
	},
	"times" => {
		"perl" => '$jumble || $seqboot',
	},
	"user_tree_opt" => { "perl" => '1' },
	"user_tree" => { "perl" => '1' },
	"tree_file" => {
		"perl" => '$user_tree',
	},
	"weight_opt" => { "perl" => '1' },
	"weights" => { "perl" => '1' },
	"weights_file" => {
		"perl" => '$weights',
	},
	"output" => { "perl" => '1' },
	"print_tree" => { "perl" => '1' },
	"print_steps" => { "perl" => '1' },
	"print_sequences" => { "perl" => '1' },
	"print_treefile" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"indent_tree" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"outgroup" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"treefile" => {
		"perl" => '$print_treefile',
	},
	"indented_treefile" => {
		"perl" => '$print_treefile && $indent_tree',
	},
	"params" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },
	"terminal_type" => { "perl" => '1' },
	"tmp_params" => { "perl" => '1' },
	"consense_confirm" => {
		"perl" => '$consense',
	},
	"consense_terminal_type" => {
		"perl" => '$consense',
	},
	"consense_outfile" => {
		"perl" => '$consense',
	},
	"consense_treefile" => {
		"perl" => '$consense',
	},

    };

    $self->{CTRL}  = {
	"threshold" => {
		"perl" => {
			'($threshold !~ /^\d+(\.\d+)?$/) || ($threshold < 1)' => "You must enter a numeric value, greater than 1",
		},
	},
	"seqboot_seed" => {
		"perl" => {
			'$value <= 0 || (($value % 2) == 0)' => "Random number seed must be odd",
		},
	},
	"replicates" => {
		"perl" => {
			'$replicates > 1000' => "this server allows no more than 1000 replicates",
		},
	},
	"jumble_seed" => {
		"perl" => {
			'defined $value && ($value <= 0 || (($value % 2) == 0))' => "Random number seed for jumble must be odd. ",
		},
	},
	"user_tree" => {
		"perl" => {
			'$user_tree && $jumble' => "you cannot randomize (jumble) your dataset and give a user tree at the same time",
			'$user_tree && $seqboot' => "you cannot bootstrap your dataset and give a user tree at the same time",
		},
	},
	"outgroup" => {
		"perl" => {
			'$value && $value < 1' => "Please enter a value greater than 0",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"treefile" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},
	"weights_file" => {
		 "phylip_weights" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {
	"weights_file" => {
		 "phylip_weights" => ["infile",]
	},

    };

    $self->{ISCLEAN}  = {
	"dnapars" => 0,
	"infile" => 0,
	"dnapars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
	"use_transversion" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"jumble_message" => 0,
	"replicates" => 0,
	"consense" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_steps" => 0,
	"print_sequences" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"dnapars" => 0,
	"infile" => 1,
	"dnapars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
	"use_transversion" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"jumble_message" => 0,
	"replicates" => 0,
	"consense" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_steps" => 0,
	"print_sequences" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,

    };

    $self->{PARAMFILE}  = {
	"use_threshold" => "params",
	"threshold" => "params",
	"use_transversion" => "params",
	"method" => "seqboot.params",
	"seqboot_seed" => "seqboot.params",
	"replicates" => "seqboot.params",
	"multiple_dataset" => "params",
	"bootconfirm" => "seqboot.params",
	"bootterminal_type" => "seqboot.params",
	"jumble" => "params",
	"user_tree" => "params",
	"weights" => "params",
	"print_tree" => "params",
	"print_steps" => "params",
	"print_sequences" => "params",
	"print_treefile" => "params",
	"printdata" => "params",
	"outgroup" => "params",
	"confirm" => "params",
	"terminal_type" => "params",
	"consense_confirm" => "consense.params",
	"consense_terminal_type" => "consense.params",

    };

    $self->{COMMENT}  = {
	"threshold" => [
		"Thresholds less than or equal to 1.0 do not have any meaning and should not be used: they will result in a tree  dependent  only on the input order of species and not at all on the data",
	],
	"seqboot" => [
		"By selecting this option, the bootstrap will be performed on your sequence file. So you don\'t need to perform a separated seqboot before.",
		"Don\'t give an already bootstrapped file to the		program, this won\'t work!",
		"You must also provide parameters for jumble.",
	],
	"method" => [
		"1. The bootstrap. Bootstrapping was invented by Bradley Efron in 1979, and its use in phylogeny estimation was introduced by me (Felsenstein, 1985b). It involves creating a new data set by sampling N characters randomly with replacement, so that the resulting data set has the same size as the original, but some characters have been left out and others are duplicated. The random variation of the results from analyzing these bootstrapped data sets can be shown statistically to be typical of the variation that you would get from collecting new data sets. The method assumes that the characters evolve independently, an assumption that may not be realistic for many kinds of data.",
		"2. Delete-half-jackknifing. This alternative to the bootstrap involves sampling a random half of the characters, and including them in the data but dropping the others. The resulting data sets are half the size of the original, and no characters are duplicated. The random variation from doing this should be very similar to that obtained from the bootstrap. The method is advocated by Wu (1986).",
		"3. Permuting species within characters. This method of resampling (well, OK, it may not be best to call it resampling) was introduced by Archie (1989) and Faith (1990; see also Faith and Cranston, 1991). It involves permuting the columns of the data matrix separately. This produces data matrices that have the same number and kinds of characters but no taxonomic structure. It is used for different purposes than the bootstrap, as it tests not the variation around an estimated tree but the hypothesis that there is no taxonomic structure in the data: if a statistic such as number of steps is significantly smaller in the actual data than it is in replicates that are permuted, then we can argue that there is some taxonomic structure in the data (though perhaps it might be just a pair of sibling species).",
	],
	"user_tree" => [
		"To give your tree to the program, you must normally put it in the alignement file, after the sequences, preceded by a line indicating how many trees you give.",
		"Here, this will be automatically appended: just give a treefile and the number of trees in it.",
	],
	"tree_file" => [
		"Give a tree whenever the infile does not already contain the tree.",
	],
	"print_tree" => [
		"Tells the program to print a semi-graphical picture of the tree in the outfile.",
	],
	"print_treefile" => [
		"Tells the program to save the tree in a tree file (outtree) (a standard representation of trees where the tree is specified by a nested pairs of parentheses, enclosing names and separated by commas).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dnapars.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

