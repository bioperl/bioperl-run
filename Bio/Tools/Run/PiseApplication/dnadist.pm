# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::dnadist
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::dnadist

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dnadist

      Bioperl class for:

	Phylip	dnadist - Compute distance matrix from nucleotide sequences (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/dnadist.html 
         for available values):


		dnadist (String)

		infile (Sequence)
			Alignment File
			pipe: readseq_ok_alig

		distance (Excl)
			Distance (D)

		ratio (Integer)
			Transition/transversion ratio (T)

		gamma (Excl)
			Gamma distributed rates across sites (G)

		variation_coeff (Float)
			Coefficient of variation of substitution rate among sites (must be positive) (if Gamma)

		invariant_sites (Float)
			Fraction of invariant sites (if Gamma)

		empirical_frequencies (Switch)
			Use empirical base frequencies (F)

		base_frequencies (String)
			Base frequencies for A, C, G, T/U (if not empirical) (separated by commas)

		one_category (Switch)
			One category of substitution rates (C)

		n_categ (Integer)
			Number of categories (1 to 9)

		categ_rates (String)
			Rate for each category (separated by commas)

		weights (Switch)
			Use weights for sites (W)

		weights_file (InFile)
			Weights file

		seqboot (Switch)
			Perform a bootstrap before analysis

		method (Excl)
			Resampling methods

		seqboot_seed (Integer)
			Random number seed (must be odd)

		replicates (Integer)
			How many replicates

		matrix_form (Switch)
			Lower-triangular distance matrix (L)

		printdata (Switch)
			Print out the data at start of run (1)

		confirm (String)

		terminal_type (String)

		multiple_dataset (String)

		seqboot_confirm (String)

		seqboot_terminal_type (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/dnadist.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::dnadist;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dnadist = Bio::Tools::Run::PiseApplication::dnadist->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dnadist object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $dnadist = $factory->program('dnadist');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::dnadist.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dnadist.pm

    $self->{COMMAND}   = "dnadist";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "dnadist - Compute distance matrix from nucleotide sequences";

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
	"dnadist",
	"infile",
	"dnadist_opt",
	"categ_opt",
	"weight_opt",
	"bootstrap",
	"output",
	"outfile",
	"params",
	"confirm",
	"terminal_type",
	"multiple_dataset",
	"seqboot_confirm",
	"seqboot_terminal_type",
	"tmp_params",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dnadist",
	"infile", 	# Alignment File
	"dnadist_opt", 	# dnadist options
	"distance", 	# Distance (D)
	"ratio", 	# Transition/transversion ratio (T)
	"gamma", 	# Gamma distributed rates across sites (G)
	"variation_coeff", 	# Coefficient of variation of substitution rate among sites (must be positive) (if Gamma)
	"invariant_sites", 	# Fraction of invariant sites (if Gamma)
	"empirical_frequencies", 	# Use empirical base frequencies (F)
	"base_frequencies", 	# Base frequencies for A, C, G, T/U (if not empirical) (separated by commas)
	"categ_opt", 	# Categories options
	"one_category", 	# One category of substitution rates (C)
	"n_categ", 	# Number of categories (1 to 9)
	"categ_rates", 	# Rate for each category (separated by commas)
	"weight_opt", 	# Weight options
	"weights", 	# Use weights for sites (W)
	"weights_file", 	# Weights file
	"bootstrap", 	# Bootstrap options
	"seqboot", 	# Perform a bootstrap before analysis
	"method", 	# Resampling methods
	"seqboot_seed", 	# Random number seed (must be odd)
	"replicates", 	# How many replicates
	"output", 	# Output options
	"matrix_form", 	# Lower-triangular distance matrix (L)
	"printdata", 	# Print out the data at start of run (1)
	"outfile",
	"params",
	"confirm",
	"terminal_type",
	"multiple_dataset",
	"seqboot_confirm",
	"seqboot_terminal_type",
	"tmp_params",

    ];

    $self->{TYPE}  = {
	"dnadist" => 'String',
	"infile" => 'Sequence',
	"dnadist_opt" => 'Paragraph',
	"distance" => 'Excl',
	"ratio" => 'Integer',
	"gamma" => 'Excl',
	"variation_coeff" => 'Float',
	"invariant_sites" => 'Float',
	"empirical_frequencies" => 'Switch',
	"base_frequencies" => 'String',
	"categ_opt" => 'Paragraph',
	"one_category" => 'Switch',
	"n_categ" => 'Integer',
	"categ_rates" => 'String',
	"weight_opt" => 'Paragraph',
	"weights" => 'Switch',
	"weights_file" => 'InFile',
	"bootstrap" => 'Paragraph',
	"seqboot" => 'Switch',
	"method" => 'Excl',
	"seqboot_seed" => 'Integer',
	"replicates" => 'Integer',
	"output" => 'Paragraph',
	"matrix_form" => 'Switch',
	"printdata" => 'Switch',
	"outfile" => 'Results',
	"params" => 'Results',
	"confirm" => 'String',
	"terminal_type" => 'String',
	"multiple_dataset" => 'String',
	"seqboot_confirm" => 'String',
	"seqboot_terminal_type" => 'String',
	"tmp_params" => 'Results',

    };

    $self->{FORMAT}  = {
	"dnadist" => {
		"perl" => ' "dnadist < params" ',
	},
	"infile" => {
		"perl" => '"ln -s $infile infile; "',
	},
	"dnadist_opt" => {
	},
	"distance" => {
	},
	"ratio" => {
		"perl" => '($value && $value != $vdef)? "T\\n$value\\n" : ""',
	},
	"gamma" => {
	},
	"variation_coeff" => {
		"perl" => '($value)? "$value\\n" : ""',
	},
	"invariant_sites" => {
		"perl" => '($value)? "$value\\n" : ""',
	},
	"empirical_frequencies" => {
		"perl" => '($value)? "" : "F\\n"',
	},
	"base_frequencies" => {
		"perl" => '""',
	},
	"categ_opt" => {
	},
	"one_category" => {
		"perl" => '(! $one_category)? "C\\n$n_categ\\n$categ_rates\\n" : "" ',
	},
	"n_categ" => {
		"perl" => '""',
	},
	"categ_rates" => {
		"perl" => '""',
	},
	"weight_opt" => {
	},
	"weights" => {
		"perl" => '($value)? "W\\n" : ""',
	},
	"weights_file" => {
		"perl" => '($value)? "ln -s $weights_file weights; " : ""',
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
	"replicates" => {
		"perl" => '($value && $value != $vdef)? "R\\n$value\\n" : ""',
	},
	"output" => {
	},
	"matrix_form" => {
		"perl" => '($value)? "L\\n" : ""',
	},
	"printdata" => {
		"perl" => '($value)? "1\\n" : ""',
	},
	"outfile" => {
	},
	"params" => {
	},
	"confirm" => {
		"perl" => '"y\\n"',
	},
	"terminal_type" => {
		"perl" => '"0\\n"',
	},
	"multiple_dataset" => {
		"perl" => '"M\\nD\\n$replicates\\n"',
	},
	"seqboot_confirm" => {
		"perl" => '"y\\n"',
	},
	"seqboot_terminal_type" => {
		"perl" => '"0\\n"',
	},
	"tmp_params" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'outfile',
	"params" => 'params',
	"tmp_params" => '*.params',

    };

    $self->{SEQFMT}  = {
	"infile" => [12],

    };

    $self->{GROUP}  = {
	"dnadist" => 0,
	"infile" => -10,
	"distance" => 1,
	"ratio" => 1,
	"gamma" => 5,
	"variation_coeff" => 1010,
	"invariant_sites" => 1011,
	"empirical_frequencies" => 1,
	"base_frequencies" => 2,
	"one_category" => 3,
	"n_categ" => 2,
	"categ_rates" => 3,
	"weights" => 1,
	"weights_file" => -1,
	"seqboot" => -5,
	"method" => 1,
	"seqboot_seed" => 1000,
	"replicates" => 1,
	"matrix_form" => 1,
	"printdata" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,
	"multiple_dataset" => 1,
	"seqboot_confirm" => 100,
	"seqboot_terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"seqboot",
	"weights_file",
	"seqboot_terminal_type",
	"terminal_type",
	"dnadist",
	"dnadist_opt",
	"categ_opt",
	"weight_opt",
	"bootstrap",
	"output",
	"outfile",
	"params",
	"tmp_params",
	"distance",
	"ratio",
	"matrix_form",
	"printdata",
	"method",
	"empirical_frequencies",
	"multiple_dataset",
	"replicates",
	"weights",
	"n_categ",
	"base_frequencies",
	"categ_rates",
	"one_category",
	"gamma",
	"seqboot_confirm",
	"confirm",
	"seqboot_seed",
	"variation_coeff",
	"invariant_sites",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dnadist" => 1,
	"infile" => 0,
	"dnadist_opt" => 0,
	"distance" => 0,
	"ratio" => 0,
	"gamma" => 0,
	"variation_coeff" => 0,
	"invariant_sites" => 0,
	"empirical_frequencies" => 0,
	"base_frequencies" => 0,
	"categ_opt" => 0,
	"one_category" => 0,
	"n_categ" => 0,
	"categ_rates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"output" => 0,
	"matrix_form" => 0,
	"printdata" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 1,
	"terminal_type" => 1,
	"multiple_dataset" => 1,
	"seqboot_confirm" => 1,
	"seqboot_terminal_type" => 1,
	"tmp_params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"dnadist" => 1,
	"infile" => 0,
	"dnadist_opt" => 0,
	"distance" => 0,
	"ratio" => 0,
	"gamma" => 0,
	"variation_coeff" => 0,
	"invariant_sites" => 0,
	"empirical_frequencies" => 0,
	"base_frequencies" => 0,
	"categ_opt" => 0,
	"one_category" => 0,
	"n_categ" => 0,
	"categ_rates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"output" => 0,
	"matrix_form" => 0,
	"printdata" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"multiple_dataset" => 0,
	"seqboot_confirm" => 0,
	"seqboot_terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"dnadist" => 0,
	"infile" => 1,
	"dnadist_opt" => 0,
	"distance" => 0,
	"ratio" => 0,
	"gamma" => 0,
	"variation_coeff" => 1,
	"invariant_sites" => 1,
	"empirical_frequencies" => 0,
	"base_frequencies" => 1,
	"categ_opt" => 0,
	"one_category" => 0,
	"n_categ" => 1,
	"categ_rates" => 1,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 1,
	"seqboot_seed" => 1,
	"replicates" => 1,
	"output" => 0,
	"matrix_form" => 0,
	"printdata" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"multiple_dataset" => 0,
	"seqboot_confirm" => 0,
	"seqboot_terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PROMPT}  = {
	"dnadist" => "",
	"infile" => "Alignment File",
	"dnadist_opt" => "dnadist options",
	"distance" => "Distance (D)",
	"ratio" => "Transition/transversion ratio (T)",
	"gamma" => "Gamma distributed rates across sites (G)",
	"variation_coeff" => "Coefficient of variation of substitution rate among sites (must be positive) (if Gamma)",
	"invariant_sites" => "Fraction of invariant sites (if Gamma)",
	"empirical_frequencies" => "Use empirical base frequencies (F)",
	"base_frequencies" => "Base frequencies for A, C, G, T/U (if not empirical) (separated by commas)",
	"categ_opt" => "Categories options",
	"one_category" => "One category of substitution rates (C)",
	"n_categ" => "Number of categories (1 to 9)",
	"categ_rates" => "Rate for each category (separated by commas)",
	"weight_opt" => "Weight options",
	"weights" => "Use weights for sites (W)",
	"weights_file" => "Weights file",
	"bootstrap" => "Bootstrap options",
	"seqboot" => "Perform a bootstrap before analysis",
	"method" => "Resampling methods",
	"seqboot_seed" => "Random number seed (must be odd)",
	"replicates" => "How many replicates",
	"output" => "Output options",
	"matrix_form" => "Lower-triangular distance matrix (L)",
	"printdata" => "Print out the data at start of run (1)",
	"outfile" => "",
	"params" => "",
	"confirm" => "",
	"terminal_type" => "",
	"multiple_dataset" => "",
	"seqboot_confirm" => "",
	"seqboot_terminal_type" => "",
	"tmp_params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"dnadist" => 0,
	"infile" => 0,
	"dnadist_opt" => 0,
	"distance" => 0,
	"ratio" => 0,
	"gamma" => 0,
	"variation_coeff" => 0,
	"invariant_sites" => 0,
	"empirical_frequencies" => 0,
	"base_frequencies" => 0,
	"categ_opt" => 0,
	"one_category" => 0,
	"n_categ" => 0,
	"categ_rates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"output" => 0,
	"matrix_form" => 0,
	"printdata" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"multiple_dataset" => 0,
	"seqboot_confirm" => 0,
	"seqboot_terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{VLIST}  = {

	"dnadist_opt" => ['distance','ratio','gamma','variation_coeff','invariant_sites','empirical_frequencies','base_frequencies',],
	"distance" => ['F84','F84','K','Kimura 2-parameter','JC','Jukes-Cantor','LogDet','LogDet','Similarity','Similarity table',],
	"gamma" => ['0','No','1','Yes','GI','Gamma+Invariant',],
	"categ_opt" => ['one_category','n_categ','categ_rates',],
	"weight_opt" => ['weights','weights_file',],
	"bootstrap" => ['seqboot','method','seqboot_seed','replicates',],
	"method" => ['bootstrap','Bootstrap','jackknife','Delete-half jackknife','permute','Permute species for each character',],
	"output" => ['matrix_form','printdata',],
    };

    $self->{FLIST}  = {

	"distance" => {
		'Similarity' => '"D\\nD\\nD\\nD\\n"',
		'' => '',
		'LogDet' => '"D\\nD\\nD\\n"',
		'JC' => '"D\\nD\\n"',
		'F84' => '',
		'K' => '"D\\n"',

	},
	"gamma" => {
		'' => '',
		'0' => '',
		'1' => '"G\\n"',
		'GI' => '"G\\nG\\n"',

	},
	"method" => {
		'bootstrap' => '""',
		'permute' => '"J\\nJ\\n"',
		'jackknife' => '"J\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"distance" => 'F84',
	"ratio" => '2.0',
	"gamma" => '0',
	"empirical_frequencies" => '1',
	"one_category" => '1',
	"seqboot" => '0',
	"method" => 'bootstrap',
	"replicates" => '100',
	"matrix_form" => '0',
	"printdata" => '0',

    };

    $self->{PRECOND}  = {
	"dnadist" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"dnadist_opt" => { "perl" => '1' },
	"distance" => { "perl" => '1' },
	"ratio" => {
		"perl" => '$distance eq "F84" || $distance eq "K"',
	},
	"gamma" => {
		"perl" => '$distance eq "F84" || $distance eq "K" || $distance eq "JC"',
	},
	"variation_coeff" => {
		"perl" => '$gamma',
	},
	"invariant_sites" => {
		"perl" => '$gamma eq "GI"',
	},
	"empirical_frequencies" => { "perl" => '1' },
	"base_frequencies" => {
		"perl" => '! $empirical_frequencies',
	},
	"categ_opt" => { "perl" => '1' },
	"one_category" => {
		"perl" => '$distance eq "F84" || $distance eq "K" || $distance eq "JC"',
	},
	"n_categ" => {
		"perl" => '! $one_category',
	},
	"categ_rates" => {
		"perl" => '! $one_category',
	},
	"weight_opt" => { "perl" => '1' },
	"weights" => { "perl" => '1' },
	"weights_file" => {
		"perl" => '$weights',
	},
	"bootstrap" => { "perl" => '1' },
	"seqboot" => { "perl" => '1' },
	"method" => {
		"perl" => '$seqboot',
	},
	"seqboot_seed" => {
		"perl" => '$seqboot',
	},
	"replicates" => {
		"perl" => '$seqboot',
	},
	"output" => { "perl" => '1' },
	"matrix_form" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"params" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },
	"terminal_type" => { "perl" => '1' },
	"multiple_dataset" => {
		"perl" => '$seqboot',
	},
	"seqboot_confirm" => {
		"perl" => '$seqboot',
	},
	"seqboot_terminal_type" => {
		"perl" => '$seqboot',
	},
	"tmp_params" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"base_frequencies" => {
		"perl" => {
			'($base_frequencies =~ s/,/ /g ) && 0' => "",
		},
	},
	"n_categ" => {
		"perl" => {
			'$value > 9' => "there must be no more than 9 categories",
			'$value < 1' => "there must be at least one category",
		},
	},
	"categ_rates" => {
		"perl" => {
			'($categ_rates =~ s/,/ /g ) && 0' => "",
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

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
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
	"dnadist" => 0,
	"infile" => 0,
	"dnadist_opt" => 0,
	"distance" => 0,
	"ratio" => 0,
	"gamma" => 0,
	"variation_coeff" => 0,
	"invariant_sites" => 0,
	"empirical_frequencies" => 0,
	"base_frequencies" => 0,
	"categ_opt" => 0,
	"one_category" => 0,
	"n_categ" => 0,
	"categ_rates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"output" => 0,
	"matrix_form" => 0,
	"printdata" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"multiple_dataset" => 0,
	"seqboot_confirm" => 0,
	"seqboot_terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"dnadist" => 0,
	"infile" => 1,
	"dnadist_opt" => 0,
	"distance" => 0,
	"ratio" => 0,
	"gamma" => 0,
	"variation_coeff" => 0,
	"invariant_sites" => 0,
	"empirical_frequencies" => 0,
	"base_frequencies" => 0,
	"categ_opt" => 0,
	"one_category" => 0,
	"n_categ" => 0,
	"categ_rates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"output" => 0,
	"matrix_form" => 0,
	"printdata" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"multiple_dataset" => 0,
	"seqboot_confirm" => 0,
	"seqboot_terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PARAMFILE}  = {
	"distance" => "params",
	"ratio" => "params",
	"gamma" => "params",
	"variation_coeff" => "params",
	"invariant_sites" => "params",
	"empirical_frequencies" => "params",
	"one_category" => "params",
	"weights" => "params",
	"method" => "seqboot.params",
	"seqboot_seed" => "seqboot.params",
	"replicates" => "seqboot.params",
	"matrix_form" => "params",
	"printdata" => "params",
	"confirm" => "params",
	"terminal_type" => "params",
	"multiple_dataset" => "params",
	"seqboot_confirm" => "seqboot.params",
	"seqboot_terminal_type" => "seqboot.params",

    };

    $self->{COMMENT}  = {
	"variation_coeff" => [
		"In gamma distribution parameters, this is 1/(square root of alpha)",
	],
	"categ_opt" => [
		"The alignment file MUST contain a C on the first line and the description of the categories of each site on the following line. Here is a toy example of a file of 5 species with 12 sites, and 2 different categories (first 2 lines):",
		"5 12 C",
		"CATEGORIES 111111222222",
	],
	"seqboot" => [
		"By selecting this option, the bootstrap will be performed on your sequence file. So you don\'t need to perform a separated seqboot before.",
		"Don\'t give an already bootstrapped file to the program, this won\'t work!",
	],
	"method" => [
		"1. The bootstrap. Bootstrapping was invented by Bradley Efron in 1979, and its use in phylogeny estimation was introduced by me (Felsenstein, 1985b). It involves creating a new data set by sampling N characters randomly with replacement, so that the resulting data set has the same size as the original, but some characters have been left out and others are duplicated. The random variation of the results from analyzing these bootstrapped data sets can be shown statistically to be typical of the variation that you would get from collecting new data sets. The method assumes that the characters evolve independently, an assumption that may not be realistic for many kinds of data.",
		"2. Delete-half-jackknifing. This alternative to the bootstrap involves sampling a random half of the characters, and including them in the data but dropping the others. The resulting data sets are half the size of the original, and no characters are duplicated. The random variation from doing this should be very similar to that obtained from the bootstrap. The method is advocated by Wu (1986).",
		"3. Permuting species within characters. This method of resampling (well, OK, it may not be best to call it resampling) was introduced by Archie (1989) and Faith (1990; see also Faith and Cranston, 1991). It involves permuting the columns of the data matrix separately. This produces data matrices that have the same number and kinds of characters but no taxonomic structure. It is used for different purposes than the bootstrap, as it tests not the variation around an estimated tree but the hypothesis that there is no taxonomic structure in the data: if a statistic such as number of steps is significantly smaller in the actual data than it is in replicates that are permuted, then we can argue that there is some taxonomic structure in the data (though perhaps it might be just a pair of sibling species).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dnadist.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

