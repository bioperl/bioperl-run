# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::mix
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::mix

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mix

      Bioperl class for:

	Phylip	mix - Mixed method parsimony (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/mix.html 
         for available values):


		mix (String)

		infile (InFile)
			Input File

		use_mixed (Switch)
			Use Mixed method (X)

		parsimony_method (Excl)
			Parsimony method (P)

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

		outgroup (Integer)
			Outgroup root (default, use as outgroup species 1) (O)

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

  http://bugzilla.open-bio.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/mix.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::mix;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mix = Bio::Tools::Run::PiseApplication::mix->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mix object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $mix = $factory->program('mix');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::mix.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mix.pm

    $self->{COMMAND}   = "mix";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "mix - Mixed method parsimony";

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
	"mix",
	"infile",
	"mix_opt",
	"jumble_opt",
	"user_tree_opt",
	"bootstrap",
	"output",
	"pars_opt",
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
	"mix",
	"infile", 	# Input File
	"mix_opt", 	# Mix options
	"use_mixed", 	# Use Mixed method (X)
	"parsimony_method", 	# Parsimony method (P)
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
	"other_options", 	# Other options
	"outgroup", 	# Outgroup root (default, use as outgroup species 1) (O)
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
	"mix" => 'String',
	"infile" => 'InFile',
	"mix_opt" => 'Paragraph',
	"use_mixed" => 'Switch',
	"parsimony_method" => 'Excl',
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
	"mix" => {
		"perl" => ' "mix < params" ',
	},
	"infile" => {
		"perl" => '"ln -s $infile infile; "',
	},
	"mix_opt" => {
	},
	"use_mixed" => {
		"perl" => '($value)? "X\\n" : ""',
	},
	"parsimony_method" => {
		"perl" => '($value eq "camin")? "P\\n" : "" ',
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
		"perl" => '($value) ? "; cp infile infile.mix; cp outtree outtree.mix; cp outfile outfile.mix; mv outtree intree; consense < consense.params; cp outtree outtree.consense; cp outfile outfile.consense; mv outtree.mix outtree; mv infile.mix infile; mv outfile.mix outfile" : ""',
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

    };

    $self->{GROUP}  = {
	"mix" => 0,
	"infile" => -10,
	"use_mixed" => 1,
	"parsimony_method" => 1,
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
	"outgroup" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,
	"consense_confirm" => 1000,
	"consense_terminal_type" => -2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"tree_nb",
	"consense_terminal_type",
	"tree_file",
	"terminal_type",
	"pars_opt",
	"jumble_opt",
	"params",
	"indented_treefile",
	"treefile",
	"user_tree_opt",
	"output",
	"mix",
	"mix_opt",
	"bootstrap",
	"outfile",
	"tmp_params",
	"other_options",
	"consense_outfile",
	"consense_treefile",
	"print_step",
	"print_states",
	"print_treefile",
	"printdata",
	"outgroup",
	"use_mixed",
	"parsimony_method",
	"use_ancestral_state",
	"user_tree",
	"print_tree",
	"threshold",
	"use_threshold",
	"datasets_nb",
	"multiple_dataset",
	"consense",
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
	"mix" => 1,
	"infile" => 0,
	"mix_opt" => 0,
	"use_mixed" => 0,
	"parsimony_method" => 0,
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
	"mix" => 1,
	"infile" => 0,
	"mix_opt" => 0,
	"use_mixed" => 0,
	"parsimony_method" => 0,
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
	"mix" => 0,
	"infile" => 1,
	"mix_opt" => 0,
	"use_mixed" => 0,
	"parsimony_method" => 1,
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
	"mix" => "",
	"infile" => "Input File",
	"mix_opt" => "Mix options",
	"use_mixed" => "Use Mixed method (X)",
	"parsimony_method" => "Parsimony method (P)",
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
	"other_options" => "Other options",
	"outgroup" => "Outgroup root (default, use as outgroup species 1) (O)",
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
	"mix" => 0,
	"infile" => 0,
	"mix_opt" => 0,
	"use_mixed" => 0,
	"parsimony_method" => 0,
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

	"mix_opt" => ['use_mixed','parsimony_method','use_ancestral_state',],
	"parsimony_method" => ['wagner','Wagner','camin','Camin-Sokal',],
	"jumble_opt" => ['jumble','jumble_seed','times',],
	"user_tree_opt" => ['user_tree','tree_file','tree_nb',],
	"bootstrap" => ['multiple_dataset','datasets_nb','consense',],
	"output" => ['print_tree','print_step','print_states','print_treefile','printdata','indent_tree',],
	"pars_opt" => ['use_threshold','threshold',],
	"other_options" => ['outgroup',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"use_mixed" => '0',
	"parsimony_method" => 'neighbor',
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
	"outgroup" => '1',

    };

    $self->{PRECOND}  = {
	"mix" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"mix_opt" => { "perl" => '1' },
	"use_mixed" => { "perl" => '1' },
	"parsimony_method" => {
		"perl" => '! $use_mixed',
	},
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

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"mix" => 0,
	"infile" => 0,
	"mix_opt" => 0,
	"use_mixed" => 0,
	"parsimony_method" => 0,
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
	"mix" => 0,
	"infile" => 1,
	"mix_opt" => 0,
	"use_mixed" => 0,
	"parsimony_method" => 0,
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
	"use_mixed" => "params",
	"parsimony_method" => "params",
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
	"outgroup" => "params",
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
	"use_mixed" => [
		"You have to put on the first line  of  the  input file, after the number of species and the number of characters, the character M, to signal that the Mixture information follows.  There then follows, before the species  data,  a  line  or  lines, the first character the first line being M. There then follow as many characters as are needed to fill out the length of  a species  name, and one letter for each for each character.  These letters are C or S  if  the  character  is  to  be  reconstructed  according  to  Camin-Sokal parsimony,  W  or ? if the character is to be reconstructed according to Wagner parsimony.  So if there are 20 characters the line  giving  the  mixture  might look like this:",
		"Mixture   WWWCC WWCWC",
	],
	"parsimony_method" => [
		"Only if Use Mixed method is disabled.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mix.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

