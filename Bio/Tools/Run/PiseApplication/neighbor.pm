
=head1 NAME

Bio::Tools::Run::PiseApplication::neighbor

=head1 SYNOPSIS

   #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::neighbor

      Bioperl class for:

	Phylip	neighbor - Neighbor-Joining and UPGMA methods (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.


      Parameters:


		neighbor (String)
			

		distance_method (Excl)
			Distance method

		infile (InFile)
			Distances matrix File
			pipe: phylip_dist

		jumble_opt (Paragraph)
			Randomize options

		jumble (Switch)
			Randomize (jumble) input order (J)

		jumble_seed (Integer)
			Random number seed for jumble (must be odd)

		bootstrap (Paragraph)
			Bootstrap options

		multiple_dataset (Switch)
			Analyze multiple data sets (M)

		datasets_nb (Integer)
			How many data sets

		multiple_seed (Integer)
			Random number seed for multiple dataset (must be odd)

		consense (Switch)
			Compute a consensus tree

		consense_confirm (String)
			

		consense_terminal_type (String)
			

		consense_outfile (Results)
			

		consense_treefile (Results)
			
			pipe: phylip_tree

		output (Paragraph)
			Output options

		print_tree (Switch)
			Print out tree (3)

		print_treefile (Switch)
			Write out trees onto tree file (4)

		indent_tree (Switch)
			Indent treefile

		printdata (Switch)
			Print out the data at start of run (1)

		other_options (Paragraph)
			Other options

		outgroup (Integer)
			Outgroup species (default, use as outgroup species 1) (O)

		triangular (Excl)
			Matrix format

		outfile (Results)
			

		treefile (Results)
			
			pipe: phylip_tree

		indented_treefile (Results)
			

		params (Results)
			

		confirm (String)
			

		terminal_type (String)
			

		tmp_params (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::neighbor;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $neighbor = Bio::Tools::Run::PiseApplication::neighbor->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::neighbor object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $neighbor = $factory->program('neighbor');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::neighbor.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/neighbor.pm

    $self->{COMMAND}   = "neighbor";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "neighbor - Neighbor-Joining and UPGMA methods";

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"neighbor",
	"distance_method",
	"infile",
	"jumble_opt",
	"bootstrap",
	"consense_confirm",
	"consense_terminal_type",
	"consense_outfile",
	"consense_treefile",
	"output",
	"other_options",
	"outfile",
	"treefile",
	"indented_treefile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"neighbor",
	"distance_method", 	# Distance method
	"infile", 	# Distances matrix File
	"jumble_opt", 	# Randomize options
	"jumble", 	# Randomize (jumble) input order (J)
	"jumble_seed", 	# Random number seed for jumble (must be odd)
	"bootstrap", 	# Bootstrap options
	"multiple_dataset", 	# Analyze multiple data sets (M)
	"datasets_nb", 	# How many data sets
	"multiple_seed", 	# Random number seed for multiple dataset (must be odd)
	"consense", 	# Compute a consensus tree
	"consense_confirm",
	"consense_terminal_type",
	"consense_outfile",
	"consense_treefile",
	"output", 	# Output options
	"print_tree", 	# Print out tree (3)
	"print_treefile", 	# Write out trees onto tree file (4)
	"indent_tree", 	# Indent treefile
	"printdata", 	# Print out the data at start of run (1)
	"other_options", 	# Other options
	"outgroup", 	# Outgroup species (default, use as outgroup species 1) (O)
	"triangular", 	# Matrix format
	"outfile",
	"treefile",
	"indented_treefile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",

    ];

    $self->{TYPE}  = {
	"neighbor" => 'String',
	"distance_method" => 'Excl',
	"infile" => 'InFile',
	"jumble_opt" => 'Paragraph',
	"jumble" => 'Switch',
	"jumble_seed" => 'Integer',
	"bootstrap" => 'Paragraph',
	"multiple_dataset" => 'Switch',
	"datasets_nb" => 'Integer',
	"multiple_seed" => 'Integer',
	"consense" => 'Switch',
	"consense_confirm" => 'String',
	"consense_terminal_type" => 'String',
	"consense_outfile" => 'Results',
	"consense_treefile" => 'Results',
	"output" => 'Paragraph',
	"print_tree" => 'Switch',
	"print_treefile" => 'Switch',
	"indent_tree" => 'Switch',
	"printdata" => 'Switch',
	"other_options" => 'Paragraph',
	"outgroup" => 'Integer',
	"triangular" => 'Excl',
	"outfile" => 'Results',
	"treefile" => 'Results',
	"indented_treefile" => 'Results',
	"params" => 'Results',
	"confirm" => 'String',
	"terminal_type" => 'String',
	"tmp_params" => 'Results',

    };

    $self->{FORMAT}  = {
	"neighbor" => {
		"perl" => '"neighbor < params"',
	},
	"distance_method" => {
		"perl" => '($value eq "upgma") ? "N\\n" : ""',
	},
	"infile" => {
		"perl" => '"ln -sf $infile infile; "',
	},
	"jumble_opt" => {
	},
	"jumble" => {
		"perl" => '($value) ? "J\\n$jumble_seed\\n" : ""',
	},
	"jumble_seed" => {
		"perl" => '""',
	},
	"bootstrap" => {
	},
	"multiple_dataset" => {
		"perl" => '($value) ? "M\\n$datasets_nb\\n$multiple_seed\\n" : ""',
	},
	"datasets_nb" => {
		"perl" => '""',
	},
	"multiple_seed" => {
		"perl" => '""',
	},
	"consense" => {
		"perl" => '($value)? "; cp infile infile.neighbor; cp outtree outtree.neighbor; mv outfile outfile.neighbor; mv outtree intree; consense < consense.params; cp outtree outtree.consense; cp outfile outfile.consense; mv outtree.neighbor outtree; mv infile.neighbor infile; mv outfile.neighbor outfile" : ""',
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
	"output" => {
	},
	"print_tree" => {
		"perl" => '($value)? "" : "3\\n"',
	},
	"print_treefile" => {
		"perl" => '($value)? "" : "4\\n"',
	},
	"indent_tree" => {
		"perl" => ' " && indenttree -o outtree.indent outtree" ',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"other_options" => {
	},
	"outgroup" => {
		"perl" => '(defined $value && $value != $vdef)? "O\\n$value\\n" : ""',
	},
	"triangular" => {
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
		"perl" => '"Y\\n"',
	},
	"terminal_type" => {
		"perl" => '"0\\n"',
	},
	"tmp_params" => {
	},

    };

    $self->{FILENAMES}  = {
	"consense_outfile" => 'outfile.consense',
	"consense_treefile" => 'outtree.consense',
	"outfile" => 'outfile',
	"treefile" => 'outtree',
	"indented_treefile" => 'outtree.indent',
	"params" => 'params',
	"tmp_params" => '*.params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"neighbor" => 0,
	"distance_method" => 1,
	"infile" => -10,
	"jumble" => 20,
	"jumble_seed" => 19,
	"multiple_dataset" => 10,
	"datasets_nb" => 9,
	"consense" => 10,
	"consense_confirm" => 1000,
	"consense_terminal_type" => -2,
	"print_tree" => 1,
	"print_treefile" => 1,
	"indent_tree" => 1000,
	"printdata" => 1,
	"outgroup" => 1,
	"triangular" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"consense_terminal_type",
	"terminal_type",
	"neighbor",
	"other_options",
	"jumble_opt",
	"outfile",
	"treefile",
	"bootstrap",
	"indented_treefile",
	"params",
	"multiple_seed",
	"tmp_params",
	"consense_outfile",
	"consense_treefile",
	"output",
	"distance_method",
	"triangular",
	"printdata",
	"print_tree",
	"outgroup",
	"print_treefile",
	"datasets_nb",
	"multiple_dataset",
	"consense",
	"jumble_seed",
	"jumble",
	"confirm",
	"consense_confirm",
	"indent_tree",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"neighbor" => 1,
	"distance_method" => 0,
	"infile" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"multiple_seed" => 0,
	"consense" => 0,
	"consense_confirm" => 1,
	"consense_terminal_type" => 1,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"indent_tree" => 0,
	"printdata" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"triangular" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 1,
	"terminal_type" => 1,
	"tmp_params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"neighbor" => 1,
	"distance_method" => 0,
	"infile" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"multiple_seed" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"indent_tree" => 0,
	"printdata" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"triangular" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"neighbor" => 0,
	"distance_method" => 1,
	"infile" => 1,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 1,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 1,
	"multiple_seed" => 1,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"indent_tree" => 0,
	"printdata" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"triangular" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PROMPT}  = {
	"neighbor" => "",
	"distance_method" => "Distance method",
	"infile" => "Distances matrix File",
	"jumble_opt" => "Randomize options",
	"jumble" => "Randomize (jumble) input order (J)",
	"jumble_seed" => "Random number seed for jumble (must be odd)",
	"bootstrap" => "Bootstrap options",
	"multiple_dataset" => "Analyze multiple data sets (M)",
	"datasets_nb" => "How many data sets",
	"multiple_seed" => "Random number seed for multiple dataset (must be odd)",
	"consense" => "Compute a consensus tree",
	"consense_confirm" => "",
	"consense_terminal_type" => "",
	"consense_outfile" => "",
	"consense_treefile" => "",
	"output" => "Output options",
	"print_tree" => "Print out tree (3)",
	"print_treefile" => "Write out trees onto tree file (4)",
	"indent_tree" => "Indent treefile",
	"printdata" => "Print out the data at start of run (1)",
	"other_options" => "Other options",
	"outgroup" => "Outgroup species (default, use as outgroup species 1) (O)",
	"triangular" => "Matrix format",
	"outfile" => "",
	"treefile" => "",
	"indented_treefile" => "",
	"params" => "",
	"confirm" => "",
	"terminal_type" => "",
	"tmp_params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"neighbor" => 0,
	"distance_method" => 0,
	"infile" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"multiple_seed" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"indent_tree" => 0,
	"printdata" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"triangular" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{VLIST}  = {

	"distance_method" => ['neighbor','Neighbor-joining','upgma','UPGMA',],
	"jumble_opt" => ['jumble','jumble_seed',],
	"bootstrap" => ['multiple_dataset','datasets_nb','multiple_seed','consense',],
	"output" => ['print_tree','print_treefile','indent_tree','printdata',],
	"other_options" => ['outgroup','triangular',],
	"triangular" => ['square','Square','lower','Lower-triangular','upper','Upper-triangular',],
    };

    $self->{FLIST}  = {

	"triangular" => {
		'lower' => '"L\\n"',
		'square' => '""',
		'upper' => '"R\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"distance_method" => 'neighbor',
	"jumble" => '0',
	"multiple_dataset" => '0',
	"consense" => '0',
	"print_tree" => '1',
	"print_treefile" => '1',
	"indent_tree" => '1',
	"printdata" => '0',
	"outgroup" => '1',
	"triangular" => 'square',

    };

    $self->{PRECOND}  = {
	"neighbor" => { "perl" => '1' },
	"distance_method" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"jumble_opt" => { "perl" => '1' },
	"jumble" => {
		"perl" => 'not $multiple_dataset',
	},
	"jumble_seed" => {
		"perl" => '$jumble',
	},
	"bootstrap" => { "perl" => '1' },
	"multiple_dataset" => { "perl" => '1' },
	"datasets_nb" => {
		"perl" => '$multiple_dataset',
	},
	"multiple_seed" => {
		"perl" => '$multiple_dataset',
	},
	"consense" => {
		"perl" => '$multiple_dataset && $print_treefile',
	},
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
	"output" => { "perl" => '1' },
	"print_tree" => { "perl" => '1' },
	"print_treefile" => { "perl" => '1' },
	"indent_tree" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"outgroup" => {
		"perl" => '$distance_method eq "neighbor"',
	},
	"triangular" => { "perl" => '1' },
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

    };

    $self->{CTRL}  = {
	"jumble_seed" => {
		"perl" => {
			'$value <= 0 || (($value % 2) == 0)' => "Random number seed must be odd",
		},
	},
	"datasets_nb" => {
		"perl" => {
			'$value > 1000' => "there must be no more than 1000 datasets for this server",
		},
	},
	"multiple_seed" => {
		"perl" => {
			'$value <= 0 || (($value % 2) == 0)' => "Random number seed must be odd",
		},
	},
	"outgroup" => {
		"perl" => {
			'defined $value && $value < 1' => "Please enter a value greater than 0",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"consense_treefile" => {
		 '1' => "phylip_tree",
	},
	"treefile" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "phylip_dist" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"neighbor" => 0,
	"distance_method" => 0,
	"infile" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"multiple_seed" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"indent_tree" => 0,
	"printdata" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"triangular" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"neighbor" => 0,
	"distance_method" => 0,
	"infile" => 1,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"multiple_seed" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"indent_tree" => 0,
	"printdata" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"triangular" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PARAMFILE}  = {
	"distance_method" => "params",
	"jumble" => "params",
	"multiple_dataset" => "params",
	"multiple_seed" => "params",
	"consense_confirm" => "consense.params",
	"consense_terminal_type" => "consense.params",
	"print_tree" => "params",
	"print_treefile" => "params",
	"printdata" => "params",
	"outgroup" => "params",
	"triangular" => "params",
	"confirm" => "params",
	"terminal_type" => "params",

    };

    $self->{COMMENT}  = {
	"print_tree" => [
		"Tells the program to print a semi-graphical picture of the tree in the outfile.",
	],
	"print_treefile" => [
		"Tells the program to save the tree in a treefile (a standard representation of trees where the tree is specified by a nested pairs of parentheses, enclosing names and separated by commas).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/neighbor.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

