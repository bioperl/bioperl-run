# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::Puzzle
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::Puzzle

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::Puzzle

      Bioperl class for:

	Puzzle	Tree reconstruction for sequences by quartet puzzling and maximum likelihood (Strimmer, von Haeseler)

	References:

		Strimmer, K., and A. von Haeseler. 1996. Quartet puzzling:A quartet maximum likelihood method for reconstructing tree topologies. Mol. Biol. Evol. 13: 964-969.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/Puzzle.html 
         for available values):


		Puzzle (String)

		stdinput (String)

		confirm (String)

		infile (Sequence)
			Alignement File
			pipe: readseq_ok_alig

		seqtype (Excl)
			Is it a DNA or protein sequence

		approximate (Switch)
			Approximate quartet likelihood (v)

		puzzling_step (Integer)
			Number of puzzling steps (n)

		protein_model (Excl)
			Model of substitution for protein (if no automatic guess) (m)

		ratio (Float)
			Transition/transversion ratio (t)

		GTR_acrate (Float)
			A-C rate (1)

		GTR_agrate (Float)
			A-G rate (2)

		GTR_atrate (Float)
			A-T rate (3)

		GTR_cgrate (Float)
			C-G rate (4)

		GTR_ctrate (Float)
			C-T rate (5)

		GTR_gtrate (Float)
			G-T rate (6)

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

		rate_heterogeneity (Excl)
			Model of rate heterogeneity (w)

		alpha (Float)
			Gamma distribution parameter alpha (a)

		gamma_number (Integer)
			Number of Gamma rate categories (c)

		invariable (Float)
			Fraction of invariable sites (i)

		user_tree (Switch)
			Tree search procedure: User tree (k)

		tree_file (InFile)
			User Tree file

		no_tree (Switch)
			Pairwise distances only (no tree) (k)

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

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

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

http://bioweb.pasteur.fr/seqanal/interfaces/Puzzle.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::Puzzle;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $Puzzle = Bio::Tools::Run::PiseApplication::Puzzle->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::Puzzle object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $Puzzle = $factory->program('Puzzle');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::Puzzle.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/Puzzle.pm

    $self->{COMMAND}   = "Puzzle";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Puzzle";

    $self->{DESCRIPTION}   = "Tree reconstruction for sequences by quartet puzzling and maximum likelihood";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "phylogeny",
  ];

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
	"GTR_options", 	# GTR model rates
	"GTR_acrate", 	# A-C rate (1)
	"GTR_agrate", 	# A-G rate (2)
	"GTR_atrate", 	# A-T rate (3)
	"GTR_cgrate", 	# C-G rate (4)
	"GTR_ctrate", 	# C-T rate (5)
	"GTR_gtrate", 	# G-T rate (6)
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
	"GTR_options" => 'Paragraph',
	"GTR_acrate" => 'Float',
	"GTR_agrate" => 'Float',
	"GTR_atrate" => 'Float',
	"GTR_cgrate" => 'Float',
	"GTR_ctrate" => 'Float',
	"GTR_gtrate" => 'Float',
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
		"perl" => '"Puzzle"',
	},
	"stdinput" => {
		"perl" => '" < params"',
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
		"perl" => '" $infile"',
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
		"perl" => '(defined $value and $value != $vdef)? "n\\n$value\\n" : ""',
	},
	"protein_options" => {
	},
	"protein_model" => {
	},
	"dna_options" => {
	},
	"ratio" => {
		"perl" => '(defined $value) ? "t\\n$value\\n" : ""',
	},
	"GTR_options" => {
	},
	"GTR_acrate" => {
		"perl" => '(defined $value and $value != $vdef) ? "1\\n$value\\n" : ""',
	},
	"GTR_agrate" => {
		"perl" => '(defined $value and $value != $vdef) ? "2\\n$value\\n" : ""',
	},
	"GTR_atrate" => {
		"perl" => '(defined $value and $value != $vdef) ? "3\\n$value\\n" : ""',
	},
	"GTR_cgrate" => {
		"perl" => '(defined $value and $value != $vdef) ? "4\\n$value\\n" : ""',
	},
	"GTR_ctrate" => {
		"perl" => '(defined $value and $value != $vdef) ? "5\\n$value\\n" : ""',
	},
	"GTR_gtrate" => {
		"perl" => '(defined $value and $value != $vdef) ? "6\\n$value\\n" : ""',
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
		"perl" => '(defined $value and $value != $vdef)? "c\\n$value\\n" : ""',
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
	"outfile" => '*.puzzle',
	"outtree" => '*.tree',
	"outdist" => '*.dist',
	"params" => 'params',

    };

    $self->{SEQFMT}  = {
	"infile" => [12],

    };

    $self->{GROUP}  = {
	"Puzzle" => 0,
	"stdinput" => 2,
	"confirm" => 1000,
	"infile" => 1,
	"seqtype" => -10,
	"approximate" => 1,
	"puzzling_step" => 1,
	"protein_model" => 1,
	"ratio" => 1,
	"GTR_acrate" => 11,
	"GTR_agrate" => 11,
	"GTR_atrate" => 11,
	"GTR_cgrate" => 11,
	"GTR_ctrate" => 11,
	"GTR_gtrate" => 11,
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
	"nuc_freq",
	"GTR_options",
	"outfile",
	"outtree",
	"outdist",
	"params",
	"dna_options",
	"Puzzle",
	"control_options",
	"protein_options",
	"rate_options",
	"user_tree_options",
	"output_options",
	"protein_model",
	"ratio",
	"infile",
	"approximate",
	"user_tree",
	"no_tree",
	"puzzling_step",
	"outgroup",
	"branch_length",
	"estimates",
	"estimation_by",
	"list_unresolved",
	"list_trees",
	"stdinput",
	"dna_model",
	"GTR_ctrate",
	"GTR_gtrate",
	"GTR_acrate",
	"constrain_TN",
	"symmetrize_frequencies",
	"GTR_agrate",
	"GTR_atrate",
	"GTR_cgrate",
	"f84_ratio",
	"y_r",
	"rate_heterogeneity",
	"gamma_number",
	"invariable",
	"alpha",
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
	"GTR_options" => 0,
	"GTR_acrate" => 0,
	"GTR_agrate" => 0,
	"GTR_atrate" => 0,
	"GTR_cgrate" => 0,
	"GTR_ctrate" => 0,
	"GTR_gtrate" => 0,
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
	"GTR_options" => 0,
	"GTR_acrate" => 0,
	"GTR_agrate" => 0,
	"GTR_atrate" => 0,
	"GTR_cgrate" => 0,
	"GTR_ctrate" => 0,
	"GTR_gtrate" => 0,
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
	"GTR_options" => 0,
	"GTR_acrate" => 0,
	"GTR_agrate" => 0,
	"GTR_atrate" => 0,
	"GTR_cgrate" => 0,
	"GTR_ctrate" => 0,
	"GTR_gtrate" => 0,
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
	"GTR_options" => "GTR model rates",
	"GTR_acrate" => "A-C rate (1)",
	"GTR_agrate" => "A-G rate (2)",
	"GTR_atrate" => "A-T rate (3)",
	"GTR_cgrate" => "C-G rate (4)",
	"GTR_ctrate" => "C-T rate (5)",
	"GTR_gtrate" => "G-T rate (6)",
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
	"GTR_options" => 0,
	"GTR_acrate" => 0,
	"GTR_agrate" => 0,
	"GTR_atrate" => 0,
	"GTR_cgrate" => 0,
	"GTR_ctrate" => 0,
	"GTR_gtrate" => 0,
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
	"protein_model" => ['0','','1','Dayhoff (Dayhoff et al. 1978)','2','JTT (Jones et al. 1992)','3','mtREV24 (Adachi-Hasegawa 1996)','4','BLOSUM 62 (Henikoff-Henikoff 1992)','5','VT (Mueller-Vingron 2000)','6','WAG (Whelan-Goldman 2000)',],
	"dna_options" => ['ratio','GTR_options','nuc_freq',],
	"GTR_options" => ['GTR_acrate','GTR_agrate','GTR_atrate','GTR_cgrate','GTR_ctrate','GTR_gtrate',],
	"nuc_freq" => ['use_specified','a_freq','c_freq','g_freq',],
	"dna_model" => ['1','HKY (Hasegawa et al. 1985)','2','TN (Tamura-Nei 1993)','3','GTR (e.g. Lanave et al. 1980)',],
	"rate_options" => ['rate_heterogeneity','alpha','gamma_number','invariable',],
	"rate_heterogeneity" => ['1','Uniform rate','2','Gamma distributed rates','3','Two rates (1 invariable + 1 variable)','4','Mixed (1 invariable + n Gamma rates)',],
	"user_tree_options" => ['user_tree','tree_file','no_tree',],
	"output_options" => ['outgroup','branch_length','estimates','estimation_by','list_unresolved','list_trees',],
	"estimates" => ['1','Approximate (faster)','2','Exact (slow)',],
	"estimation_by" => ['1','Neighbor-joining tree','2','Quartet sampling + NJ tree',],
    };

    $self->{FLIST}  = {

	"protein_model" => {
		'0' => '""',
		'1' => '"m\\n"',
		'2' => '"m\\nm\\n"',
		'3' => '"m\\nm\\nm\\n"',
		'4' => '"m\\nm\\nm\\nm\\n"',
		'5' => '"m\\nm\\nm\\nm\\nm\\n"',
		'6' => '"m\\nm\\nm\\nm\\nm\\nm\\n"',

	},
	"dna_model" => {
		'' => '""',
		'1' => '""',
		'2' => '"m\\n"',
		'3' => '"m\\nm\\n"',

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
	"GTR_acrate" => '1.00',
	"GTR_agrate" => '1.00',
	"GTR_atrate" => '1.00',
	"GTR_cgrate" => '1.00',
	"GTR_ctrate" => '1.00',
	"GTR_gtrate" => '1.00',
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
		"perl" => '$seqtype ne "DNA" and ! $guessmodel',
	},
	"dna_options" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"ratio" => {
		"perl" => '$seqtype eq "DNA" ',
	},
	"GTR_options" => { "perl" => '1' },
	"GTR_acrate" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"GTR_agrate" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"GTR_atrate" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"GTR_cgrate" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"GTR_ctrate" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"GTR_gtrate" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
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
		"perl" => '$seqtype eq "DNA" and $dna_model eq "2"',
	},
	"f84_ratio" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "2"',
	},
	"y_r" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "2"',
	},
	"symmetrize_frequencies" => {
		"perl" => '$seqtype eq "DNA" and $dna_model eq "3"',
	},
	"rate_options" => { "perl" => '1' },
	"rate_heterogeneity" => { "perl" => '1' },
	"alpha" => {
		"perl" => '$rate_heterogeneity eq "2" or $rate_heterogeneity eq "4" ',
	},
	"gamma_number" => {
		"perl" => '$rate_heterogeneity eq "2" or $rate_heterogeneity eq "4" ',
	},
	"invariable" => {
		"perl" => '$rate_heterogeneity eq "3" or $rate_heterogeneity eq "4" ',
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
	"GTR_options" => 0,
	"GTR_acrate" => 0,
	"GTR_agrate" => 0,
	"GTR_atrate" => 0,
	"GTR_cgrate" => 0,
	"GTR_ctrate" => 0,
	"GTR_gtrate" => 0,
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
	"GTR_options" => 0,
	"GTR_acrate" => 0,
	"GTR_agrate" => 0,
	"GTR_atrate" => 0,
	"GTR_cgrate" => 0,
	"GTR_ctrate" => 0,
	"GTR_gtrate" => 0,
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
	"GTR_acrate" => "params",
	"GTR_agrate" => "params",
	"GTR_atrate" => "params",
	"GTR_cgrate" => "params",
	"GTR_ctrate" => "params",
	"GTR_gtrate" => "params",
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
		"The following models are implemented for nucleotides: the Tamura-Nei (TN) model, the Hasegawa et al. (HKY) model, and the Schöniger and von Haeseler (SH) model. The SH model describes the evolution of pairs of dependent nucleotides (pairs are the first and the second nucleotide, the third and the fourth nucleotide and so on). It allows for specification of the transition-transversion ratio. The originally proposed model (Schöniger and von Haeseler 1994) is obtained by setting the transition-transversion parameter to 0.5. The Jukes-Cantor (1969), the Felsenstein (1981), and the Kimura (1980) model are all special cases of the HKY model.",
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

