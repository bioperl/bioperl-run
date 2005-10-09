# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::kitsch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::kitsch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::kitsch

      Bioperl class for:

	Phylip	kitsch - Fitch-Margoliash and Least Squares Methods with Evolutionary Clock (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/kitsch.html 
         for available values):


		kitsch (String)

		infile (InFile)
			Distances matrix File
			pipe: phylip_dist

		method (Excl)
			Program method

		negative_branch (Switch)
			Negative branch lengths allowed (-)

		power (Integer)
			Power (P)

		jumble (Switch)
			Randomize (jumble) input order (J)

		jumble_seed (Integer)
			Random number seed (must be odd)

		times (Integer)
			Number of times to jumble

		multiple_dataset (Switch)
			Analyze multiple data sets (M)

		datasets_nb (Integer)
			How many data sets

		consense (Switch)
			Compute a consensus tree

		consense_confirm (String)

		consense_terminal_type (String)

		user_tree (Switch)
			Use User tree (default: no, search for best tree) (U)

		tree_file (InFile)
			User Tree file

		tree_nb (Integer)
			How many tree(s) in the User Tree file

		print_tree (Switch)
			Print out tree (3)

		print_treefile (Switch)
			Write out trees onto tree file (4)

		printdata (Switch)
			Print out the data at start of run (1)

		indent_tree (Switch)
			Indent treefile

		triangular (Excl)
			Matrix format

		confirm (String)

		terminal_type (String)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://bioweb.pasteur.fr/seqanal/interfaces/kitsch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::kitsch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $kitsch = Bio::Tools::Run::PiseApplication::kitsch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::kitsch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $kitsch = $factory->program('kitsch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::kitsch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/kitsch.pm

    $self->{COMMAND}   = "kitsch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "kitsch - Fitch-Margoliash and Least Squares Methods with Evolutionary Clock";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"kitsch",
	"infile",
	"fitch_options",
	"jumble_opt",
	"bootstrap",
	"consense_confirm",
	"consense_terminal_type",
	"consense_outfile",
	"consense_treefile",
	"user_tree_opt",
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
	"kitsch",
	"infile", 	# Distances matrix File
	"fitch_options", 	# Fitch options
	"method", 	# Program method
	"negative_branch", 	# Negative branch lengths allowed (-)
	"power", 	# Power (P)
	"jumble_opt", 	# Randomize options
	"jumble", 	# Randomize (jumble) input order (J)
	"jumble_seed", 	# Random number seed (must be odd)
	"times", 	# Number of times to jumble
	"bootstrap", 	# Bootstrap options
	"multiple_dataset", 	# Analyze multiple data sets (M)
	"datasets_nb", 	# How many data sets
	"consense", 	# Compute a consensus tree
	"consense_confirm",
	"consense_terminal_type",
	"consense_outfile",
	"consense_treefile",
	"user_tree_opt", 	# User tree options
	"user_tree", 	# Use User tree (default: no, search for best tree) (U)
	"tree_file", 	# User Tree file
	"tree_nb", 	# How many tree(s) in the User Tree file
	"output", 	# Output options
	"print_tree", 	# Print out tree (3)
	"print_treefile", 	# Write out trees onto tree file (4)
	"printdata", 	# Print out the data at start of run (1)
	"indent_tree", 	# Indent treefile
	"other_options", 	# Other options
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
	"kitsch" => 'String',
	"infile" => 'InFile',
	"fitch_options" => 'Paragraph',
	"method" => 'Excl',
	"negative_branch" => 'Switch',
	"power" => 'Integer',
	"jumble_opt" => 'Paragraph',
	"jumble" => 'Switch',
	"jumble_seed" => 'Integer',
	"times" => 'Integer',
	"bootstrap" => 'Paragraph',
	"multiple_dataset" => 'Switch',
	"datasets_nb" => 'Integer',
	"consense" => 'Switch',
	"consense_confirm" => 'String',
	"consense_terminal_type" => 'String',
	"consense_outfile" => 'Results',
	"consense_treefile" => 'Results',
	"user_tree_opt" => 'Paragraph',
	"user_tree" => 'Switch',
	"tree_file" => 'InFile',
	"tree_nb" => 'Integer',
	"output" => 'Paragraph',
	"print_tree" => 'Switch',
	"print_treefile" => 'Switch',
	"printdata" => 'Switch',
	"indent_tree" => 'Switch',
	"other_options" => 'Paragraph',
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
	"kitsch" => {
		"perl" => ' "kitsch < params" ',
	},
	"infile" => {
		"perl" => '"ln -sf $infile infile; "',
	},
	"fitch_options" => {
	},
	"method" => {
	},
	"negative_branch" => {
		"perl" => '($value)? "-\\n" : ""',
	},
	"power" => {
		"perl" => '(defined $value && $value != $vdef)? "P\\n$value\\n" : "" ',
	},
	"jumble_opt" => {
	},
	"jumble" => {
		"perl" => '($value)? "J\\n$jumble_seed\\n$times\\n" : "" ',
	},
	"jumble_seed" => {
		"perl" => '""',
	},
	"times" => {
		"perl" => '""',
	},
	"bootstrap" => {
	},
	"multiple_dataset" => {
		"perl" => '($value)? "M\\n$datasets_nb\\n" : ""',
	},
	"datasets_nb" => {
		"perl" => '""',
	},
	"consense" => {
		"perl" => '($value) ? "; cp infile infile.kitsch; cp outtree outtree.kitsch; mv outfile outfile.kitsch; mv outtree intree; consense < consense.params; cp outtree outtree.consense; cp outfile outfile.consense; mv outtree.kitsch outtree; mv infile.kitsch infile; mv outfile.kitsch outfile" : ""',
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
	"user_tree_opt" => {
	},
	"user_tree" => {
		"perl" => '($value) ? "U\\n" : "" ',
	},
	"tree_file" => {
		"perl" => '($value) ? "cat $tree_file >> intree; " : ""',
	},
	"tree_nb" => {
		"perl" => '"echo $value > infile; "',
	},
	"output" => {
	},
	"print_tree" => {
		"perl" => '($value)? "" : "3\\n"',
	},
	"print_treefile" => {
		"perl" => '($value) ? "" : "4\\n"',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"indent_tree" => {
		"perl" => ' " && indenttree -o outtree.indent outtree" ',
	},
	"other_options" => {
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
	"kitsch" => 0,
	"infile" => -5,
	"method" => 1,
	"negative_branch" => 1,
	"power" => 1,
	"jumble" => 20,
	"jumble_seed" => 19,
	"times" => 19,
	"multiple_dataset" => 10,
	"datasets_nb" => 9,
	"consense" => 10,
	"consense_confirm" => 1000,
	"consense_terminal_type" => -2,
	"user_tree" => 1,
	"tree_file" => -1,
	"tree_nb" => -2,
	"print_tree" => 1,
	"print_treefile" => 1,
	"printdata" => 1,
	"indent_tree" => 1000,
	"triangular" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"tree_nb",
	"consense_terminal_type",
	"tree_file",
	"terminal_type",
	"kitsch",
	"fitch_options",
	"output",
	"other_options",
	"outfile",
	"jumble_opt",
	"treefile",
	"indented_treefile",
	"params",
	"bootstrap",
	"tmp_params",
	"consense_outfile",
	"consense_treefile",
	"user_tree_opt",
	"method",
	"negative_branch",
	"power",
	"print_tree",
	"user_tree",
	"triangular",
	"print_treefile",
	"printdata",
	"datasets_nb",
	"consense",
	"multiple_dataset",
	"times",
	"jumble_seed",
	"jumble",
	"confirm",
	"consense_confirm",
	"indent_tree",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"kitsch" => 1,
	"infile" => 0,
	"fitch_options" => 0,
	"method" => 0,
	"negative_branch" => 0,
	"power" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"consense_confirm" => 1,
	"consense_terminal_type" => 1,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
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
	"kitsch" => 1,
	"infile" => 0,
	"fitch_options" => 0,
	"method" => 0,
	"negative_branch" => 0,
	"power" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
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
	"kitsch" => 0,
	"infile" => 1,
	"fitch_options" => 0,
	"method" => 0,
	"negative_branch" => 0,
	"power" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 1,
	"times" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 1,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 1,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
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
	"kitsch" => "",
	"infile" => "Distances matrix File",
	"fitch_options" => "Fitch options",
	"method" => "Program method",
	"negative_branch" => "Negative branch lengths allowed (-)",
	"power" => "Power (P)",
	"jumble_opt" => "Randomize options",
	"jumble" => "Randomize (jumble) input order (J)",
	"jumble_seed" => "Random number seed (must be odd)",
	"times" => "Number of times to jumble",
	"bootstrap" => "Bootstrap options",
	"multiple_dataset" => "Analyze multiple data sets (M)",
	"datasets_nb" => "How many data sets",
	"consense" => "Compute a consensus tree",
	"consense_confirm" => "",
	"consense_terminal_type" => "",
	"consense_outfile" => "",
	"consense_treefile" => "",
	"user_tree_opt" => "User tree options",
	"user_tree" => "Use User tree (default: no, search for best tree) (U)",
	"tree_file" => "User Tree file",
	"tree_nb" => "How many tree(s) in the User Tree file",
	"output" => "Output options",
	"print_tree" => "Print out tree (3)",
	"print_treefile" => "Write out trees onto tree file (4)",
	"printdata" => "Print out the data at start of run (1)",
	"indent_tree" => "Indent treefile",
	"other_options" => "Other options",
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
	"kitsch" => 0,
	"infile" => 0,
	"fitch_options" => 0,
	"method" => 0,
	"negative_branch" => 0,
	"power" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
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

	"fitch_options" => ['method','negative_branch','power',],
	"method" => ['F','Fitch-Margoliash','M','Minimum Evolution',],
	"jumble_opt" => ['jumble','jumble_seed','times',],
	"bootstrap" => ['multiple_dataset','datasets_nb','consense',],
	"user_tree_opt" => ['user_tree','tree_file','tree_nb',],
	"output" => ['print_tree','print_treefile','printdata',],
	"other_options" => ['triangular',],
	"triangular" => ['square','Square','lower','Lower-triangular','upper','Upper-triangular',],
    };

    $self->{FLIST}  = {

	"method" => {
		'F' => '""',
		'M' => '"D\\n"',

	},
	"triangular" => {
		'' => '""',
		'lower' => '"L\\n"',
		'square' => '""',
		'upper' => '"R\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"method" => 'F',
	"negative_branch" => '0',
	"power" => '2.0',
	"jumble" => '0',
	"times" => '1',
	"multiple_dataset" => '0',
	"consense" => '0',
	"user_tree" => '0',
	"tree_nb" => '1',
	"print_tree" => '1',
	"print_treefile" => '1',
	"printdata" => '0',
	"indent_tree" => '1',
	"triangular" => 'square',

    };

    $self->{PRECOND}  = {
	"kitsch" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"fitch_options" => { "perl" => '1' },
	"method" => { "perl" => '1' },
	"negative_branch" => { "perl" => '1' },
	"power" => { "perl" => '1' },
	"jumble_opt" => { "perl" => '1' },
	"jumble" => {
		"perl" => '$user_tree',
	},
	"jumble_seed" => {
		"perl" => '$jumble',
	},
	"times" => {
		"perl" => '$jumble && ( ! $neighbor) ',
	},
	"bootstrap" => { "perl" => '1' },
	"multiple_dataset" => { "perl" => '1' },
	"datasets_nb" => {
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
	"user_tree_opt" => { "perl" => '1' },
	"user_tree" => { "perl" => '1' },
	"tree_file" => {
		"perl" => '$user_tree',
	},
	"tree_nb" => {
		"perl" => '$tree_file',
	},
	"output" => { "perl" => '1' },
	"print_tree" => { "perl" => '1' },
	"print_treefile" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"indent_tree" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
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
	"user_tree" => {
		"perl" => {
			'$user_tree && $jumble' => "you cannot randomize (jumble) your dataset and give a user tree at the same time",
			'$user_tree && $seqboot' => "you cannot bootstrap your dataset and give a user tree at the same time",
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
		 "phylip_dist" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"kitsch" => 0,
	"infile" => 0,
	"fitch_options" => 0,
	"method" => 0,
	"negative_branch" => 0,
	"power" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
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
	"kitsch" => 0,
	"infile" => 1,
	"fitch_options" => 0,
	"method" => 0,
	"negative_branch" => 0,
	"power" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"consense_confirm" => 0,
	"consense_terminal_type" => 0,
	"consense_outfile" => 0,
	"consense_treefile" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"other_options" => 0,
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
	"method" => "params",
	"negative_branch" => "params",
	"power" => "params",
	"jumble" => "params",
	"multiple_dataset" => "params",
	"consense_confirm" => "consense.params",
	"consense_terminal_type" => "consense.params",
	"user_tree" => "params",
	"print_tree" => "params",
	"print_treefile" => "params",
	"printdata" => "params",
	"triangular" => "params",
	"confirm" => "params",
	"terminal_type" => "params",

    };

    $self->{COMMENT}  = {
	"power" => [
		"For the Fitch-Margoliash method, which is the default method with this program, P is 2.0. For the Cavalli-Sforza and Edwards least squares method it should be set to 0 (so that the denominator is always 1). An intermediate method is also available in which P is 1.0, and any other value of P, such as 4.0 or -2.3, can also be used. This generates a whole family of methods.",
		"Please read the documentation (man distance).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/kitsch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

