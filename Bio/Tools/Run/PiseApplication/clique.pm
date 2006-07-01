# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::clique
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::clique

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::clique

      Bioperl class for:

	Phylip	clique - Compatibility Program (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/clique.html 
         for available values):


		clique (String)

		infile (InFile)
			Input File

		use_ancestral_state (Switch)
			Use ancestral states in input file (A)

		spec_min_clique_size (Switch)
			Specify minimum clique size? (C)

		min_clique_size (Integer)
			Minimum clique size

		multiple_dataset (Switch)
			Analyze multiple data sets (M)

		datasets_nb (Integer)
			How many data sets

		consense (Switch)
			Compute a consensus tree

		print_matrix (Switch)
			Print out compatibility matrix (3)

		print_tree (Switch)
			Print out tree (4)

		print_treefile (Switch)
			Write out trees onto tree file (5)

		printdata (Switch)
			Print out the data at start of run (1)

		indent_tree (Switch)
			Indent treefile

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

http://bioweb.pasteur.fr/seqanal/interfaces/clique.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::clique;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $clique = Bio::Tools::Run::PiseApplication::clique->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::clique object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $clique = $factory->program('clique');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::clique.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/clique.pm

    $self->{COMMAND}   = "clique";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "clique - Compatibility Program";

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
	"clique",
	"infile",
	"clique_opt",
	"bootstrap",
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
	"clique",
	"infile", 	# Input File
	"clique_opt", 	# Clique options
	"use_ancestral_state", 	# Use ancestral states in input file (A)
	"spec_min_clique_size", 	# Specify minimum clique size? (C)
	"min_clique_size", 	# Minimum clique size
	"bootstrap", 	# Bootstrap options
	"multiple_dataset", 	# Analyze multiple data sets (M)
	"datasets_nb", 	# How many data sets
	"consense", 	# Compute a consensus tree
	"output", 	# Output options
	"print_matrix", 	# Print out compatibility matrix (3)
	"print_tree", 	# Print out tree (4)
	"print_treefile", 	# Write out trees onto tree file (5)
	"printdata", 	# Print out the data at start of run (1)
	"indent_tree", 	# Indent treefile
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
	"clique" => 'String',
	"infile" => 'InFile',
	"clique_opt" => 'Paragraph',
	"use_ancestral_state" => 'Switch',
	"spec_min_clique_size" => 'Switch',
	"min_clique_size" => 'Integer',
	"bootstrap" => 'Paragraph',
	"multiple_dataset" => 'Switch',
	"datasets_nb" => 'Integer',
	"consense" => 'Switch',
	"output" => 'Paragraph',
	"print_matrix" => 'Switch',
	"print_tree" => 'Switch',
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
	"clique" => {
		"perl" => '"clique < params"',
	},
	"infile" => {
		"perl" => '"ln -sf $infile infile; "',
	},
	"clique_opt" => {
	},
	"use_ancestral_state" => {
		"perl" => '($value) ? "A\\n" : ""',
	},
	"spec_min_clique_size" => {
		"perl" => '($value)? "C\\n$min_clique_size\\n" : ""',
	},
	"min_clique_size" => {
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
		"perl" => '($value)? "; cp infile infile.clique; cp outtree outtree.clique; cp outfile outfile.clique; mv treefile intree; consense < consense.params; cp outtree outtree.consense; cp outfile outfile.consense; mv outtree.clique outtree; mv infile.clique infile; mv outfile.clique outfile" : ""',
	},
	"output" => {
	},
	"print_matrix" => {
		"perl" => '($value)? "" : "3\\n"',
	},
	"print_tree" => {
		"perl" => '($value)? "" : "4\\n"',
	},
	"print_treefile" => {
		"perl" => '($value)? "" : "5\\n"',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"indent_tree" => {
		"perl" => '($value) ? " && indenttree -o outtree.indent outtree" : ""',
	},
	"other_options" => {
	},
	"outgroup" => {
		"perl" => '($value && $value != $vdef)? "O\\n$value\\n" : "" ',
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
	"clique" => 0,
	"infile" => -10,
	"use_ancestral_state" => 1,
	"spec_min_clique_size" => 3,
	"min_clique_size" => 2,
	"multiple_dataset" => 10,
	"datasets_nb" => 9,
	"consense" => 10,
	"print_matrix" => 1,
	"print_tree" => 1,
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
	"consense_terminal_type",
	"terminal_type",
	"output",
	"params",
	"indented_treefile",
	"bootstrap",
	"treefile",
	"outfile",
	"other_options",
	"clique",
	"tmp_params",
	"clique_opt",
	"consense_outfile",
	"consense_treefile",
	"outgroup",
	"use_ancestral_state",
	"print_matrix",
	"print_tree",
	"print_treefile",
	"printdata",
	"min_clique_size",
	"spec_min_clique_size",
	"datasets_nb",
	"consense",
	"multiple_dataset",
	"confirm",
	"indent_tree",
	"consense_confirm",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"clique" => 1,
	"infile" => 0,
	"clique_opt" => 0,
	"use_ancestral_state" => 0,
	"spec_min_clique_size" => 0,
	"min_clique_size" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_matrix" => 0,
	"print_tree" => 0,
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
	"clique" => 1,
	"infile" => 0,
	"clique_opt" => 0,
	"use_ancestral_state" => 0,
	"spec_min_clique_size" => 0,
	"min_clique_size" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_matrix" => 0,
	"print_tree" => 0,
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
	"clique" => 0,
	"infile" => 1,
	"clique_opt" => 0,
	"use_ancestral_state" => 0,
	"spec_min_clique_size" => 0,
	"min_clique_size" => 1,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 1,
	"consense" => 0,
	"output" => 0,
	"print_matrix" => 0,
	"print_tree" => 0,
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
	"clique" => "",
	"infile" => "Input File",
	"clique_opt" => "Clique options",
	"use_ancestral_state" => "Use ancestral states in input file (A)",
	"spec_min_clique_size" => "Specify minimum clique size? (C)",
	"min_clique_size" => "Minimum clique size",
	"bootstrap" => "Bootstrap options",
	"multiple_dataset" => "Analyze multiple data sets (M)",
	"datasets_nb" => "How many data sets",
	"consense" => "Compute a consensus tree",
	"output" => "Output options",
	"print_matrix" => "Print out compatibility matrix (3)",
	"print_tree" => "Print out tree (4)",
	"print_treefile" => "Write out trees onto tree file (5)",
	"printdata" => "Print out the data at start of run (1)",
	"indent_tree" => "Indent treefile",
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
	"clique" => 0,
	"infile" => 0,
	"clique_opt" => 0,
	"use_ancestral_state" => 0,
	"spec_min_clique_size" => 0,
	"min_clique_size" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_matrix" => 0,
	"print_tree" => 0,
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

	"clique_opt" => ['use_ancestral_state','spec_min_clique_size','min_clique_size',],
	"bootstrap" => ['multiple_dataset','datasets_nb','consense',],
	"output" => ['print_matrix','print_tree','print_treefile','printdata','indent_tree',],
	"other_options" => ['outgroup',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"spec_min_clique_size" => '0',
	"multiple_dataset" => '0',
	"consense" => '0',
	"print_matrix" => '1',
	"print_tree" => '1',
	"print_treefile" => '1',
	"printdata" => '0',
	"indent_tree" => '0',
	"outgroup" => '1',

    };

    $self->{PRECOND}  = {
	"clique" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"clique_opt" => { "perl" => '1' },
	"use_ancestral_state" => { "perl" => '1' },
	"spec_min_clique_size" => { "perl" => '1' },
	"min_clique_size" => {
		"perl" => '$spec_min_clique_size',
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
	"print_matrix" => { "perl" => '1' },
	"print_tree" => { "perl" => '1' },
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
	"min_clique_size" => {
		"perl" => {
			'($min_clique_size !~ /^\d+(\.\d+)?$/) || ($min_clique_size < 0)' => "You must enter a numeric value, greater than 0",
		},
	},
	"datasets_nb" => {
		"perl" => {
			'($value > 1000) || ($value < 0)' => "enter a value > 0 ; there must be no more than 1000 datasets for this server",
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
	"clique" => 0,
	"infile" => 0,
	"clique_opt" => 0,
	"use_ancestral_state" => 0,
	"spec_min_clique_size" => 0,
	"min_clique_size" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_matrix" => 0,
	"print_tree" => 0,
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
	"clique" => 0,
	"infile" => 1,
	"clique_opt" => 0,
	"use_ancestral_state" => 0,
	"spec_min_clique_size" => 0,
	"min_clique_size" => 0,
	"bootstrap" => 0,
	"multiple_dataset" => 0,
	"datasets_nb" => 0,
	"consense" => 0,
	"output" => 0,
	"print_matrix" => 0,
	"print_tree" => 0,
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
	"use_ancestral_state" => "params",
	"spec_min_clique_size" => "params",
	"min_clique_size" => "params",
	"multiple_dataset" => "params",
	"print_matrix" => "params",
	"print_tree" => "params",
	"print_treefile" => "params",
	"printdata" => "params",
	"outgroup" => "params",
	"confirm" => "params",
	"terminal_type" => "params",
	"consense_confirm" => "consense.params",
	"consense_terminal_type" => "consense.params",

    };

    $self->{COMMENT}  = {
	"infile" => [
		"Example input file",
		"     5    6",
		"Alpha     110110",
		"Beta      110000",
		"Gamma     100110",
		"Delta     001001",
		"Epsilon   001110",
	],
	"use_ancestral_state" => [
		"There should also be, in the input  file  after  the  numbers  of species  and  characters,  an A on the first line of the file.  There must also be, before the character data, a line or lines giving the ancestral states  for each  character.   It will look like the data for a species (the ancestor).  It must start with the letter A in the first column.   There  then  follow  enough characters  or  blanks  to  complete  the  full length of a species name (e. g. ANCESTOR).  Then  the  states  which  are  ancestral  for  the  individual characters  follow.   These  may  be  0, 1 or ?, the latter indicating that the ancestral state is unknown.",
		"Examples:",
		"ANCESTOR  0010011",
	],
	"min_clique_size" => [
		"This option indicates that you wish to  specify  a  minimum clique size and print out all cliques (and their associated trees) greater than or equal to than that size.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/clique.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

