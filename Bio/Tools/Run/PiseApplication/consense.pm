
=head1 NAME

Bio::Tools::Run::PiseApplication::consense

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::consense

      Bioperl class for:

	Phylip	consense - Consensus tree program (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.


      Parameters:


		consense (String)
			

		infile (InFile)
			Trees File
			pipe: phylip_tree

		type (Excl)
			Consensus type

		output (Paragraph)
			Output options

		print_tree (Switch)
			Print out tree (3)

		print_treefile (Switch)
			Write out trees onto tree file (4)

		printdata (Switch)
			Print out the data at start of run (1)

		indent_tree (Switch)
			Indent treefile

		other_options (Paragraph)
			Other options

		outgroup (Integer)
			Outgroup (default, use as outgroup species 1) (O)

		rooted (Switch)
			Trees to be treated as rooted

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
package Bio::Tools::Run::PiseApplication::consense;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $consense = Bio::Tools::Run::PiseApplication::consense->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::consense object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $consense = $factory->program('consense');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::consense.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/consense.pm

    $self->{COMMAND}   = "consense";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "consense - Consensus tree program";

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"consense",
	"infile",
	"type",
	"output",
	"indent_tree",
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
	"consense",
	"infile", 	# Trees File
	"type", 	# Consensus type
	"output", 	# Output options
	"print_tree", 	# Print out tree (3)
	"print_treefile", 	# Write out trees onto tree file (4)
	"printdata", 	# Print out the data at start of run (1)
	"indent_tree", 	# Indent treefile
	"other_options", 	# Other options
	"outgroup", 	# Outgroup (default, use as outgroup species 1) (O)
	"rooted", 	# Trees to be treated as rooted
	"outfile",
	"treefile",
	"indented_treefile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",

    ];

    $self->{TYPE}  = {
	"consense" => 'String',
	"infile" => 'InFile',
	"type" => 'Excl',
	"output" => 'Paragraph',
	"print_tree" => 'Switch',
	"print_treefile" => 'Switch',
	"printdata" => 'Switch',
	"indent_tree" => 'Switch',
	"other_options" => 'Paragraph',
	"outgroup" => 'Integer',
	"rooted" => 'Switch',
	"outfile" => 'Results',
	"treefile" => 'Results',
	"indented_treefile" => 'Results',
	"params" => 'Results',
	"confirm" => 'String',
	"terminal_type" => 'String',
	"tmp_params" => 'Results',

    };

    $self->{FORMAT}  = {
	"consense" => {
		"perl" => '"consense < params"',
	},
	"infile" => {
		"perl" => '"ln -sf $infile intree; "',
	},
	"type" => {
	},
	"output" => {
	},
	"print_tree" => {
		"perl" => '($value)? "" : "3\\n"',
	},
	"print_treefile" => {
		"perl" => '($value)? "" : "4\\n"',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"indent_tree" => {
		"perl" => ' " && indenttree -o outtree.indent outtree" ',
	},
	"other_options" => {
	},
	"outgroup" => {
		"perl" => '($value && $value != $vdef)? "O\\n$value\\n" : "" ',
	},
	"rooted" => {
		"perl" => '($value)? "R\\n" : "" ',
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
		"perl" => '"T\\n"',
	},
	"tmp_params" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'outfile',
	"treefile" => 'outtree',
	"indented_treefile" => 'outtree.indent',
	"params" => 'params',
	"tmp_params" => '*.params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"consense" => 0,
	"infile" => -10,
	"print_tree" => 1,
	"print_treefile" => 1,
	"printdata" => 1,
	"indent_tree" => 1000,
	"outgroup" => 1,
	"rooted" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"terminal_type",
	"type",
	"output",
	"other_options",
	"outfile",
	"treefile",
	"indented_treefile",
	"params",
	"consense",
	"tmp_params",
	"print_treefile",
	"printdata",
	"outgroup",
	"rooted",
	"print_tree",
	"indent_tree",
	"confirm",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"consense" => 1,
	"infile" => 0,
	"type" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"rooted" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 1,
	"terminal_type" => 1,
	"tmp_params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"consense" => 1,
	"infile" => 0,
	"type" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"rooted" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"consense" => 0,
	"infile" => 1,
	"type" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"rooted" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PROMPT}  = {
	"consense" => "",
	"infile" => "Trees File",
	"type" => "Consensus type",
	"output" => "Output options",
	"print_tree" => "Print out tree (3)",
	"print_treefile" => "Write out trees onto tree file (4)",
	"printdata" => "Print out the data at start of run (1)",
	"indent_tree" => "Indent treefile",
	"other_options" => "Other options",
	"outgroup" => "Outgroup (default, use as outgroup species 1) (O)",
	"rooted" => "Trees to be treated as rooted",
	"outfile" => "",
	"treefile" => "",
	"indented_treefile" => "",
	"params" => "",
	"confirm" => "",
	"terminal_type" => "",
	"tmp_params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"consense" => 0,
	"infile" => 0,
	"type" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"rooted" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{VLIST}  = {

	"type" => ['MRE','Majority rule (extended)','S','Strict','MR','Majority rule','ML','Ml',],
	"output" => ['print_tree','print_treefile','printdata',],
	"other_options" => ['outgroup','rooted',],
    };

    $self->{FLIST}  = {

	"type" => {
		'MR' => '"C\\nC\\n"',
		'ML' => '"C\\nC\\nC\\n"',
		'S' => '"C\\n"',
		'MRE' => '""',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"type" => 'MRE',
	"print_tree" => '1',
	"print_treefile" => '1',
	"printdata" => '0',
	"indent_tree" => '1',
	"outgroup" => '1',
	"rooted" => '0',

    };

    $self->{PRECOND}  = {
	"consense" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"print_tree" => { "perl" => '1' },
	"print_treefile" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"indent_tree" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"outgroup" => { "perl" => '1' },
	"rooted" => { "perl" => '1' },
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
	"outgroup" => {
		"perl" => {
			'$value < 1' => "Please enter a value greater than 0",
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
		 "phylip_tree" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"consense" => 0,
	"infile" => 0,
	"type" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"rooted" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"consense" => 0,
	"infile" => 1,
	"type" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
	"outgroup" => 0,
	"rooted" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"indented_treefile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PARAMFILE}  = {
	"type" => "params",
	"print_tree" => "params",
	"print_treefile" => "params",
	"printdata" => "params",
	"outgroup" => "params",
	"rooted" => "params",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/consense.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

