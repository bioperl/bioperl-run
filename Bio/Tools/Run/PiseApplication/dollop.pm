# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::dollop
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::dollop

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dollop

      Bioperl class for:

	Phylip	dollop - Dollo and Polymorphism Parsimony Program (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/dollop.html 
         for available values):


		dollop (String)

		infile (InFile)
			Input File

		dollop_method (Switch)
			Use Polymorphism method (P)

		use_ancestral_state (Switch)
			Use ancestral states in input file (A)

		jumble (Switch)
			Randomize (jumble) input order (J)

		jumble_seed (Integer)
			Random number seed (must be odd)

		times (Integer)
			Number of times to jumble

		user_tree (Switch)
			Use User tree (default: no, search for best tree) (U)

		tree_file (InFile)
			User Tree file

		tree_nb (Integer)
			How many tree(s) in the User Tree file

		multiple_dataset (Switch)
			Analyze multiple data sets (M)

		datasets_nb (Integer)
			How many data sets

		consense (Switch)
			Compute a consensus tree

		print_tree (Switch)
			Print out tree (3)

		print_step (Switch)
			Print out steps in each character (4)

		print_states (Switch)
			Print states at all nodes of tree (5)

		print_treefile (Switch)
			Write out trees onto tree file (6)

		printdata (Switch)
			Print out the data at start of run (1)

		indent_tree (Switch)
			Indent treefile

		use_threshold (Switch)
			Use Threshold parsimony (T)

		threshold (Integer)
			Threshold value (if use threshold parsimony)

		confirm (String)

		terminal_type (String)

		consense_confirm (String)

		consense_terminal_type (String)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/dollop.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::dollop;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dollop = Bio::Tools::Run::PiseApplication::dollop->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dollop object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $dollop = $factory->program('dollop');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::dollop.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dollop.pm

    $self->{COMMAND}   = "dollop";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "dollop - Dollo and Polymorphism Parsimony Program";

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
	"dollop",
	"infile",
	"dollop_opt",
	"jumble_opt",
	"user_tree_opt",
	"bootstrap",
	"output",
	"pars_opt",
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
	"dollop",
	"infile", 	# Input File
	"dollop_opt", 	# Dollop options
	"dollop_method", 	# Use Polymorphism method (P)
	"use_ancestral_state", 	# Use ancestral states in input file (A)
	"jumble_opt", 	# Randomize options
	"jumble", 	# Randomize (jumble) input order (J)
	"jumble_seed", 	# Random number seed (must be odd)
	"times", 	# Number of times to jumble
	"user_tree_opt", 	# User tree options
	"user_tree", 	# Use User tree (default: no, search for best tree) (U)
	"tree_file", 	# User Tree file
	"tree_nb", 	# How many tree(s) in the User Tree file
	"bootstrap", 	# Bootstrap options
	"multiple_dataset", 	# Analyze multiple data sets (M)
	"datasets_nb", 	# How many data sets
	"consense", 	# Compute a consensus tree
	"output", 	# Output options
	"print_tree", 	# Print out tree (3)
	"print_step", 	# Print out steps in each character (4)
	"print_states", 	# Print states at all nodes of tree (5)
	"print_treefile", 	# Write out trees onto tree file (6)
	"printdata", 	# Print out the data at start of run (1)
	"indent_tree", 	# Indent treefile
	"pars_opt", 	# Parcimony options
	"use_threshold", 	# Use Threshold parsimony (T)
	"threshold", 	# Threshold value (if use threshold parsimony)
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
	"dollop" => 'String',
	"infile" => 'InFile',
	"dollop_opt" => 'Paragraph',
	"dollop_method" => 'Switch',
	"use_ancestral_state" => 'Switch',
	"jumble_opt" => 'Paragraph',
	"jumble" => 'Switch',
	"jumble_seed" => 'Integer',
	"times" => 'Integer',
	"user_tree_opt" => 'Paragraph',
	"user_tree" => 'Switch',
	"tree_file" => 'InFile',
	"tree_nb" => 'Integer',
	"bootstrap" => 'Paragraph',
	"multiple_dataset" => 'Switch',
	"datasets_nb" => 'Integer',
	"consense" => 'Switch',
	"output" => 'Paragraph',
	"print_tree" => 'Switch',
	"print_step" => 'Switch',
	"print_states" => 'Switch',
	"print_treefile" => 'Switch',
	"printdata" => 'Switch',
	"indent_tree" => 'Switch',
	"pars_opt" => 'Paragraph',
	"use_threshold" => 'Switch',
	"threshold" => 'Integer',
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
	"dollop" => {
		"perl" => ' "dollop < params" ',
	},
	"infile" => {
		"perl" => '"ln -s $infile infile; "',
	},
	"dollop_opt" => {
	},
	"dollop_method" => {
		"perl" => '($value)? "P\\n" : ""',
	},
	"use_ancestral_state" => {
		"perl" => '($value)? "A\\n" : ""',
	},
	"jumble_opt" => {
	},
	"jumble" => {
		"perl" => '($value)? "j\\n$jumble_seed\\n$times\\n" : "" ',
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
		"perl" => '($value)? "cat $tree_file >> infile; " : ""',
	},
	"tree_nb" => {
		"perl" => '"echo $value >> infile; "',
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
		"perl" => '($value) ? "; cp infile infile.dollop; cp outtree outtree.dollop; cp outfile outfile.dollop; mv outtree intree; consense < consense.params; cp outtree outtree.consense; cp outfile outfile.consense; mv outtree.dollop outtree; mv infile.dollop infile; mv outfile.dollop outfile" : ""',
	},
	"output" => {
	},
	"print_tree" => {
		"perl" => '($value)? "" : "3\\n"',
	},
	"print_step" => {
		"perl" => '($value)? "4\\n" : ""',
	},
	"print_states" => {
		"perl" => '($value)? "5\\n" : ""',
	},
	"print_treefile" => {
		"perl" => '($value) ? "" : "6\\n"',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"indent_tree" => {
		"perl" => '($value)? " && indenttree -o outtree.indent outtree" : "" ',
	},
	"pars_opt" => {
	},
	"use_threshold" => {
		"perl" => '($value)? "T\\n$threshold\\n" : ""',
	},
	"threshold" => {
		"perl" => '"" ',
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

    };

    $self->{GROUP}  = {
	"dollop" => 0,
	"infile" => -10,
	"dollop_method" => 1,
	"use_ancestral_state" => 1,
	"jumble" => 20,
	"jumble_seed" => 19,
	"times" => 19,
	"user_tree" => 1,
	"tree_file" => -1,
	"tree_nb" => -2,
	"multiple_dataset" => 10,
	"datasets_nb" => 9,
	"consense" => 10,
	"print_tree" => 1,
	"print_step" => 1,
	"print_states" => 1,
	"print_treefile" => 1,
	"printdata" => 1,
	"indent_tree" => 1000,
	"use_threshold" => 3,
	"threshold" => 2,
	"confirm" => 1000,
	"terminal_type" => -1,
	"consense_confirm" => 1000,
	"consense_terminal_type" => -2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"tree_nb",
	"consense_terminal_type",
	"terminal_type",
	"tree_file",
	"pars_opt",
	"jumble_opt",
	"params",
	"indented_treefile",
	"user_tree_opt",
	"output",
	"dollop",
	"dollop_opt",
	"bootstrap",
	"treefile",
	"tmp_params",
	"outfile",
	"consense_outfile",
	"consense_treefile",
	"print_step",
	"print_states",
	"print_treefile",
	"printdata",
	"dollop_method",
	"use_ancestral_state",
	"user_tree",
	"print_tree",
	"threshold",
	"use_threshold",
	"datasets_nb",
	"multiple_dataset",
	"consense",
	"jumble_seed",
	"times",
	"jumble",
	"confirm",
	"indent_tree",
	"consense_confirm",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dollop" => 1,
	"infile" => 0,
	"dollop_opt" => 0,
	"dollop_method" => 0,
	"use_ancestral_state" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_step" => 0,
	"print_states" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"pars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
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
	"dollop" => 1,
	"infile" => 0,
	"dollop_opt" => 0,
	"dollop_method" => 0,
	"use_ancestral_state" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_step" => 0,
	"print_states" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"pars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
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
	"dollop" => 0,
	"infile" => 1,
	"dollop_opt" => 0,
	"dollop_method" => 0,
	"use_ancestral_state" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 1,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 1,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 1,
	"consense" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_step" => 0,
	"print_states" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"pars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 1,
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
	"dollop" => "",
	"infile" => "Input File",
	"dollop_opt" => "Dollop options",
	"dollop_method" => "Use Polymorphism method (P)",
	"use_ancestral_state" => "Use ancestral states in input file (A)",
	"jumble_opt" => "Randomize options",
	"jumble" => "Randomize (jumble) input order (J)",
	"jumble_seed" => "Random number seed (must be odd)",
	"times" => "Number of times to jumble",
	"user_tree_opt" => "User tree options",
	"user_tree" => "Use User tree (default: no, search for best tree) (U)",
	"tree_file" => "User Tree file",
	"tree_nb" => "How many tree(s) in the User Tree file",
	"bootstrap" => "Bootstrap options",
	"multiple_dataset" => "Analyze multiple data sets (M)",
	"datasets_nb" => "How many data sets",
	"consense" => "Compute a consensus tree",
	"output" => "Output options",
	"print_tree" => "Print out tree (3)",
	"print_step" => "Print out steps in each character (4)",
	"print_states" => "Print states at all nodes of tree (5)",
	"print_treefile" => "Write out trees onto tree file (6)",
	"printdata" => "Print out the data at start of run (1)",
	"indent_tree" => "Indent treefile",
	"pars_opt" => "Parcimony options",
	"use_threshold" => "Use Threshold parsimony (T)",
	"threshold" => "Threshold value (if use threshold parsimony)",
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
	"dollop" => 0,
	"infile" => 0,
	"dollop_opt" => 0,
	"dollop_method" => 0,
	"use_ancestral_state" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_step" => 0,
	"print_states" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"pars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
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

	"dollop_opt" => ['dollop_method','use_ancestral_state',],
	"jumble_opt" => ['jumble','jumble_seed','times',],
	"user_tree_opt" => ['user_tree','tree_file','tree_nb',],
	"bootstrap" => ['multiple_dataset','datasets_nb','consense',],
	"output" => ['print_tree','print_step','print_states','print_treefile','printdata','indent_tree',],
	"pars_opt" => ['use_threshold','threshold',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"dollop_method" => '0',
	"jumble" => '0',
	"times" => '1',
	"user_tree" => '0',
	"tree_nb" => '1',
	"multiple_dataset" => '0',
	"consense" => '0',
	"print_tree" => '1',
	"print_step" => '0',
	"print_states" => '0',
	"print_treefile" => '1',
	"printdata" => '0',
	"indent_tree" => '0',
	"use_threshold" => '0',

    };

    $self->{PRECOND}  = {
	"dollop" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"dollop_opt" => { "perl" => '1' },
	"dollop_method" => { "perl" => '1' },
	"use_ancestral_state" => { "perl" => '1' },
	"jumble_opt" => { "perl" => '1' },
	"jumble" => { "perl" => '1' },
	"jumble_seed" => {
		"perl" => '$jumble',
	},
	"times" => { "perl" => '1' },
	"user_tree_opt" => { "perl" => '1' },
	"user_tree" => { "perl" => '1' },
	"tree_file" => {
		"perl" => '$user_tree',
	},
	"tree_nb" => {
		"perl" => '$tree_file',
	},
	"bootstrap" => { "perl" => '1' },
	"multiple_dataset" => { "perl" => '1' },
	"datasets_nb" => {
		"perl" => '$multiple_dataset',
	},
	"consense" => {
		"perl" => '$multiple_dataset && $print_treefile',
	},
	"output" => { "perl" => '1' },
	"print_tree" => { "perl" => '1' },
	"print_step" => { "perl" => '1' },
	"print_states" => { "perl" => '1' },
	"print_treefile" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"indent_tree" => { "perl" => '1' },
	"pars_opt" => { "perl" => '1' },
	"use_threshold" => { "perl" => '1' },
	"threshold" => {
		"perl" => '$use_threshold',
	},
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
	"jumble_seed" => {
		"perl" => {
			'$value <= 0 || (($value % 2) == 0)' => "Random number seed must be odd",
		},
	},
	"user_tree" => {
		"perl" => {
			'$user_tree && $jumble' => "you cannot randomize (jumble) your dataset and give a user tree at the same time",
		},
	},
	"datasets_nb" => {
		"perl" => {
			'($value > 1000) || ($value < 0)' => "enter a value > 0 ; there must be no more than 1000 datasets for this server",
		},
	},
	"threshold" => {
		"perl" => {
			'($threshold !~ /^\d+(\.\d+)?$/) || ($threshold < 1)' => "You must enter a numeric value, greater than 1",
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

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"dollop" => 0,
	"infile" => 0,
	"dollop_opt" => 0,
	"dollop_method" => 0,
	"use_ancestral_state" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_step" => 0,
	"print_states" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"pars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
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
	"dollop" => 0,
	"infile" => 1,
	"dollop_opt" => 0,
	"dollop_method" => 0,
	"use_ancestral_state" => 0,
	"jumble_opt" => 0,
	"jumble" => 0,
	"jumble_seed" => 0,
	"times" => 0,
	"user_tree_opt" => 0,
	"user_tree" => 0,
	"tree_file" => 0,
	"tree_nb" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_tree" => 0,
	"print_step" => 0,
	"print_states" => 0,
	"print_treefile" => 0,
	"printdata" => 0,
	"indent_tree" => 0,
	"pars_opt" => 0,
	"use_threshold" => 0,
	"threshold" => 0,
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
	"dollop_method" => "params",
	"use_ancestral_state" => "params",
	"jumble" => "params",
	"user_tree" => "params",
	"multiple_dataset" => "params",
	"print_tree" => "params",
	"print_step" => "params",
	"print_states" => "params",
	"print_treefile" => "params",
	"printdata" => "params",
	"use_threshold" => "params",
	"threshold" => "params",
	"confirm" => "params",
	"terminal_type" => "params",
	"consense_confirm" => "consense.params",
	"consense_terminal_type" => "consense.params",

    };

    $self->{COMMENT}  = {
	"infile" => [
		"Example input file:",
		"     5    6",
		"Alpha     110110",
		"Beta      110000",
		"Gamma     100110",
		"Delta     001001",
		"Epsilon   001110",
	],
	"dollop_method" => [
		"The Dollo parsimony method (default value) was firstsuggested in print in verbal form by Le Quesne (1974) and was firstwell-specified by Farris (1977). It allowing up to one forward change0-->1 and as many reversions 1-->0 as are necessary to explain thepattern of states seen. The program attempts to minimize the number of1-->0 reversions necessary. The assumptions of this method are ineffect:",
		"1. We know which state is the ancestral one(state 0). ",
		"2. The characters are evolving independently. ",
		"3. Different lineages evolveindependently. ",
		"4. The probability of a forward change(0-->1) is small over the evolutionary times involved.",
		"5. The probability of a reversion (1-->0) isalso small, but still far larger than the probability of a forwardchange, so that many reversions are easier to envisage than even oneextra forward change.",
		"6. Retention of polymorphism for both states(0 and 1) is highly improbable. ",
		"7. The lengths of the segments of the truetree are not so unequal that two changes in a long segment are asprobable as one in a short segment.",
		"   One problem can arise when using additive binary recoding to represent   a multistate character as a series of two-state characters. Unlike the   Camin-Sokal, Wagner, and Polymorphism methods, the Dollo method can   reconstruct ancestral states which do not exist. An example is given   in my 1979 paper. It will be necessary to check the output to make   sure that this has not occurred.   ",
		"   The polymorphism parsimony method was first used by me, and the   results published (without a clear specification of the method) by   Inger (1967). The method was independently published by Farris (1978a)   and by me (1979). The method assumes that we can explain the pattern   of states by no more than one origination (0-->1) of state 1, followed   by retention of polymorphism along as many segments of the tree as are   necessary, followed by loss of state 0 or of state 1 where necessary.   The program tries to minimize the total number of polymorphic   characters, where each polymorphism is counted once for each segment   of the tree in which it is retained.   The assumptions of the polymorphism parsimony method are in   effect:",
		"    1. The ancestral state (state 0) is known in each       character. ",
		"    2. The characters are evolving independently of each other. ",
		"    3. Different lineages are evolving independently. ",
		"   4. Forward change (0-->1) is highly improbable over the length of       time involved in the evolution of the group. ",
		"    5. Retention of polymorphism is also improbable, but far more       probable that forward change, so that we can more easily envisage       much polymorhism than even one additional forward change. ",
		"   6. Once state 1 is reached, reoccurrence of state 0 is very       improbable, much less probable than multiple retentions of       polymorphism. ",
		"   7. The lengths of segments in the true tree are not so unequal that       we can more easily envisage retention events occurring in both of       two long segments than one retention in a short segment. ",
		"   That these are the assumptions of parsimony methods has been   documented in a series of papers of mine: (1973a, 1978b, 1979, 1981b,   1983b, 1988b). For an opposing view arguing that the parsimony methods   make no substantive assumptions such as these, see the papers by   Farris (1983) and Sober (1983a, 1983b), but also read the exchange   between Felsenstein and Sober (1986).",
	],
	"use_ancestral_state" => [
		"There should also be, in the input  file  after  the  numbers  of species  and  characters,  an A on the first line of the file.  There must also be, before the character data, a line or lines giving the ancestral states  for each  character.   It will look like the data for a species (the ancestor).  It must start with the letter A in the first column.   There  then  follow  enough characters  or  blanks  to  complete  the  full length of a species name (e. g. ANCESTOR).  Then  the  states  which  are  ancestral  for  the  individual characters  follow.   These  may  be  0, 1 or ?, the latter indicating that the ancestral state is unknown.",
		"Examples:",
		"ANCESTOR  0010011",
	],
	"user_tree" => [
		"To give your tree to the program, you must normally put it in the alignement file, after the sequences, preceded by a line indicating how many trees you give.",
		"Here, this will be automatically appended: just give a treefile and the number of trees in it.",
	],
	"tree_file" => [
		"Give a tree whenever the infile does not already contain the tree.",
	],
	"tree_nb" => [
		"Give this information whenever the infile does not already contain the tree.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dollop.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

