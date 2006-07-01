# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::phyml
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::phyml

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::phyml

      Bioperl class for:

	PHYML	a program that  computes maximum likelihood phylogenies from DNA or AA homologous sequences (S. Guindon and O. Gascuel)

	References:

		 Guindon, S. and Gascuel, O. (2003) A simple, fast and accurate algorithm to estimate large phylogenies by maximum likelihood Syst. Biol., 52, 696-704



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/phyml.html 
         for available values):


		phyml (String)

		alignment (Sequence)
			Sequence Alignment
			pipe: readseq_ok_alig

		data_type (Excl)
			Data type

		format (Excl)
			Format

		datasets (Integer)
			Number of data sets to analyse

		bootstrap_sets (Integer)
			Number of bootstraps sets to analyse (only works with one data set to analyse)

		model (Excl)
			Substitution model

		kappa (Float)
			Transition/transversion ratio (only for DNA sequences)

		kappa_e (Switch)
			Estimate Transition/transversion ratio? (only for DNA sequences)

		invar (Float)
			Proportion of invariable sites

		invar_e (Switch)
			Estimate proportion of invariable sites?

		nb_categ (Integer)
			number of relative substitution rate categories (ex:4)

		alpha (Float)
			Gamma distribution parameter

		alpha_e (Switch)
			Estimate Gamma distribution parameter?

		opt_topology (Switch)
			Optimise tree topology?

		opt_lengths (Switch)
			Optimise branch lengths and rate parameters?

		user_tree (Switch)
			Starting tree?

		user_tree_file (InFile)
			Starting tree filename (Newick format)
			pipe: phylip_tree

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/phyml.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::phyml;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $phyml = Bio::Tools::Run::PiseApplication::phyml->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::phyml object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $phyml = $factory->program('phyml');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::phyml.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/phyml.pm

    $self->{COMMAND}   = "phyml";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PHYML";

    $self->{DESCRIPTION}   = "a program that  computes maximum likelihood phylogenies from DNA or AA homologous sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "phylogeny",
  ];

    $self->{AUTHORS}   = "S. Guindon and O. Gascuel";

    $self->{REFERENCE}   = [

         " Guindon, S. and Gascuel, O. (2003) A simple, fast and accurate algorithm to estimate large phylogenies by maximum likelihood Syst. Biol., 52, 696-704",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"phyml",
	"alignment",
	"data_type",
	"inputopt",
	"control_opt",
	"outfiles",
	"outtree_result",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"phyml",
	"alignment", 	# Sequence Alignment
	"data_type", 	# Data type
	"inputopt", 	# Input Options
	"format", 	# Format
	"datasets", 	# Number of data sets to analyse
	"bootstrap_sets", 	# Number of bootstraps sets to analyse (only works with one data set to analyse)
	"control_opt", 	# Control Options
	"model", 	# Substitution model
	"kappa", 	# Transition/transversion ratio (only for DNA sequences)
	"kappa_e", 	# Estimate Transition/transversion ratio? (only for DNA sequences)
	"invar", 	# Proportion of invariable sites
	"invar_e", 	# Estimate proportion of invariable sites?
	"nb_categ", 	# number of relative substitution rate categories (ex:4)
	"alpha", 	# Gamma distribution parameter
	"alpha_e", 	# Estimate Gamma distribution parameter?
	"opt_topology", 	# Optimise tree topology?
	"opt_lengths", 	# Optimise branch lengths and rate parameters?
	"user_tree", 	# Starting tree?
	"user_tree_file", 	# Starting tree filename (Newick format)
	"outfiles",
	"outtree_result",

    ];

    $self->{TYPE}  = {
	"phyml" => 'String',
	"alignment" => 'Sequence',
	"data_type" => 'Excl',
	"inputopt" => 'Paragraph',
	"format" => 'Excl',
	"datasets" => 'Integer',
	"bootstrap_sets" => 'Integer',
	"control_opt" => 'Paragraph',
	"model" => 'Excl',
	"kappa" => 'Float',
	"kappa_e" => 'Switch',
	"invar" => 'Float',
	"invar_e" => 'Switch',
	"nb_categ" => 'Integer',
	"alpha" => 'Float',
	"alpha_e" => 'Switch',
	"opt_topology" => 'Switch',
	"opt_lengths" => 'Switch',
	"user_tree" => 'Switch',
	"user_tree_file" => 'InFile',
	"outfiles" => 'Results',
	"outtree_result" => 'Results',

    };

    $self->{FORMAT}  = {
	"phyml" => {
		"perl" => '"phyml"',
	},
	"alignment" => {
		"perl" => '" $value"',
	},
	"data_type" => {
		"perl" => '(defined $value)? " $value" : ""',
	},
	"inputopt" => {
	},
	"format" => {
		"perl" => '" $value"',
	},
	"datasets" => {
		"perl" => '" $value"',
	},
	"bootstrap_sets" => {
		"perl" => '($datasets == 1)? " $value" : " 0"',
	},
	"control_opt" => {
	},
	"model" => {
		"perl" => '" $value"',
	},
	"kappa" => {
		"perl" => '" $value"',
	},
	"kappa_e" => {
		"perl" => '($value)? " e" : "" ',
	},
	"invar" => {
		"perl" => '" $value"',
	},
	"invar_e" => {
		"perl" => '($value)? " e" : "" ',
	},
	"nb_categ" => {
		"perl" => '" $value" ',
	},
	"alpha" => {
		"perl" => ' " $value" ',
	},
	"alpha_e" => {
		"perl" => '($value)? " e" : "" ',
	},
	"opt_topology" => {
		"perl" => '($value)? " y" : " n" ',
	},
	"opt_lengths" => {
		"perl" => '($value)? " y" : " n" ',
	},
	"user_tree" => {
		"perl" => '($value)? " $user_tree_file" : " BIONJ" ',
	},
	"user_tree_file" => {
		"perl" => '"" ',
	},
	"outfiles" => {
	},
	"outtree_result" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfiles" => '*.txt',
	"outtree_result" => '*tree* ',

    };

    $self->{SEQFMT}  = {
	"alignment" => [12],

    };

    $self->{GROUP}  = {
	"phyml" => 1,
	"alignment" => 2,
	"data_type" => 3,
	"format" => 4,
	"datasets" => 5,
	"bootstrap_sets" => 6,
	"model" => 7,
	"kappa" => 8,
	"kappa_e" => 8,
	"invar" => 9,
	"invar_e" => 9,
	"nb_categ" => 10,
	"alpha" => 11,
	"alpha_e" => 11,
	"opt_topology" => 55,
	"opt_lengths" => 56,
	"user_tree" => 50,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"user_tree_file",
	"outfiles",
	"outtree_result",
	"inputopt",
	"control_opt",
	"phyml",
	"alignment",
	"data_type",
	"format",
	"datasets",
	"bootstrap_sets",
	"model",
	"kappa_e",
	"kappa",
	"invar",
	"invar_e",
	"nb_categ",
	"alpha",
	"alpha_e",
	"user_tree",
	"opt_topology",
	"opt_lengths",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"phyml" => 1,
	"alignment" => 0,
	"data_type" => 0,
	"inputopt" => 0,
	"format" => 0,
	"datasets" => 0,
	"bootstrap_sets" => 0,
	"control_opt" => 0,
	"model" => 0,
	"kappa" => 0,
	"kappa_e" => 0,
	"invar" => 0,
	"invar_e" => 0,
	"nb_categ" => 0,
	"alpha" => 0,
	"alpha_e" => 0,
	"opt_topology" => 0,
	"opt_lengths" => 0,
	"user_tree" => 0,
	"user_tree_file" => 0,
	"outfiles" => 0,
	"outtree_result" => 0,

    };

    $self->{ISCOMMAND}  = {
	"phyml" => 1,
	"alignment" => 0,
	"data_type" => 0,
	"inputopt" => 0,
	"format" => 0,
	"datasets" => 0,
	"bootstrap_sets" => 0,
	"control_opt" => 0,
	"model" => 0,
	"kappa" => 0,
	"kappa_e" => 0,
	"invar" => 0,
	"invar_e" => 0,
	"nb_categ" => 0,
	"alpha" => 0,
	"alpha_e" => 0,
	"opt_topology" => 0,
	"opt_lengths" => 0,
	"user_tree" => 0,
	"user_tree_file" => 0,
	"outfiles" => 0,
	"outtree_result" => 0,

    };

    $self->{ISMANDATORY}  = {
	"phyml" => 0,
	"alignment" => 1,
	"data_type" => 1,
	"inputopt" => 0,
	"format" => 1,
	"datasets" => 1,
	"bootstrap_sets" => 1,
	"control_opt" => 0,
	"model" => 1,
	"kappa" => 1,
	"kappa_e" => 0,
	"invar" => 1,
	"invar_e" => 0,
	"nb_categ" => 1,
	"alpha" => 1,
	"alpha_e" => 0,
	"opt_topology" => 0,
	"opt_lengths" => 0,
	"user_tree" => 0,
	"user_tree_file" => 1,
	"outfiles" => 0,
	"outtree_result" => 0,

    };

    $self->{PROMPT}  = {
	"phyml" => "",
	"alignment" => "Sequence Alignment",
	"data_type" => "Data type",
	"inputopt" => "Input Options",
	"format" => "Format",
	"datasets" => "Number of data sets to analyse",
	"bootstrap_sets" => "Number of bootstraps sets to analyse (only works with one data set to analyse)",
	"control_opt" => "Control Options",
	"model" => "Substitution model",
	"kappa" => "Transition/transversion ratio (only for DNA sequences)",
	"kappa_e" => "Estimate Transition/transversion ratio? (only for DNA sequences)",
	"invar" => "Proportion of invariable sites",
	"invar_e" => "Estimate proportion of invariable sites?",
	"nb_categ" => "number of relative substitution rate categories (ex:4)",
	"alpha" => "Gamma distribution parameter",
	"alpha_e" => "Estimate Gamma distribution parameter?",
	"opt_topology" => "Optimise tree topology?",
	"opt_lengths" => "Optimise branch lengths and rate parameters?",
	"user_tree" => "Starting tree?",
	"user_tree_file" => "Starting tree filename (Newick format)",
	"outfiles" => "",
	"outtree_result" => "",

    };

    $self->{ISSTANDOUT}  = {
	"phyml" => 0,
	"alignment" => 0,
	"data_type" => 0,
	"inputopt" => 0,
	"format" => 0,
	"datasets" => 0,
	"bootstrap_sets" => 0,
	"control_opt" => 0,
	"model" => 0,
	"kappa" => 0,
	"kappa_e" => 0,
	"invar" => 0,
	"invar_e" => 0,
	"nb_categ" => 0,
	"alpha" => 0,
	"alpha_e" => 0,
	"opt_topology" => 0,
	"opt_lengths" => 0,
	"user_tree" => 0,
	"user_tree_file" => 0,
	"outfiles" => 0,
	"outtree_result" => 0,

    };

    $self->{VLIST}  = {

	"data_type" => ['0','DNA','1','Amino-Acids',],
	"inputopt" => ['format','datasets','bootstrap_sets',],
	"format" => ['i','interleaved','s','sequential',],
	"control_opt" => ['model','kappa','kappa_e','invar','invar_e','nb_categ','alpha','alpha_e','opt_topology','opt_lengths','user_tree','user_tree_file',],
	"model" => ['JC69','JC69 (DNA)','K2P','K2P (DNA)','F81','F81 (DNA)','HKY','HKY (DNA)','F84','F84 (DNA)','TN93','TN93 (DNA)','GTR','GTR (DNA)','JTT','JTT (Amino-Acids)','MtREV','MtREV (Amino-Acids)','Dayhoff','Dayhoff (Amino-Acids)','WAG','WAG (Amino-Acids)',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"format" => 'i',
	"datasets" => '1',
	"bootstrap_sets" => '2',
	"kappa" => '4',
	"kappa_e" => '1',
	"invar" => '0.0',
	"invar_e" => '1',
	"nb_categ" => '1',
	"alpha_e" => '1',
	"opt_topology" => '1',
	"opt_lengths" => '1',
	"user_tree" => '0',

    };

    $self->{PRECOND}  = {
	"phyml" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"data_type" => { "perl" => '1' },
	"inputopt" => { "perl" => '1' },
	"format" => { "perl" => '1' },
	"datasets" => { "perl" => '1' },
	"bootstrap_sets" => { "perl" => '1' },
	"control_opt" => { "perl" => '1' },
	"model" => { "perl" => '1' },
	"kappa" => {
		"perl" => '$data_type == 0 && not $kappa_e',
	},
	"kappa_e" => {
		"perl" => '$data_type == 0',
	},
	"invar" => {
		"perl" => 'not $invar_e',
	},
	"invar_e" => { "perl" => '1' },
	"nb_categ" => { "perl" => '1' },
	"alpha" => {
		"perl" => 'not $alpha_e',
	},
	"alpha_e" => { "perl" => '1' },
	"opt_topology" => { "perl" => '1' },
	"opt_lengths" => { "perl" => '1' },
	"user_tree" => { "perl" => '1' },
	"user_tree_file" => {
		"perl" => '$user_tree',
	},
	"outfiles" => { "perl" => '1' },
	"outtree_result" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outtree_result" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"alignment" => {
		 "readseq_ok_alig" => '1',
	},
	"user_tree_file" => {
		 "phylip_tree" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"phyml" => 0,
	"alignment" => 0,
	"data_type" => 0,
	"inputopt" => 0,
	"format" => 0,
	"datasets" => 0,
	"bootstrap_sets" => 0,
	"control_opt" => 0,
	"model" => 0,
	"kappa" => 0,
	"kappa_e" => 0,
	"invar" => 0,
	"invar_e" => 0,
	"nb_categ" => 0,
	"alpha" => 0,
	"alpha_e" => 0,
	"opt_topology" => 0,
	"opt_lengths" => 0,
	"user_tree" => 0,
	"user_tree_file" => 0,
	"outfiles" => 0,
	"outtree_result" => 0,

    };

    $self->{ISSIMPLE}  = {
	"phyml" => 0,
	"alignment" => 1,
	"data_type" => 1,
	"inputopt" => 0,
	"format" => 0,
	"datasets" => 0,
	"bootstrap_sets" => 0,
	"control_opt" => 0,
	"model" => 0,
	"kappa" => 0,
	"kappa_e" => 0,
	"invar" => 0,
	"invar_e" => 0,
	"nb_categ" => 0,
	"alpha" => 0,
	"alpha_e" => 0,
	"opt_topology" => 0,
	"opt_lengths" => 0,
	"user_tree" => 0,
	"user_tree_file" => 0,
	"outfiles" => 0,
	"outtree_result" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"kappa" => [
		"Either enter a value or ask for an estimate		(see following option).",
	],
	"kappa_e" => [
		"Either enter a value for the ratio (see		previous option) or ask for an estimate.",
	],
	"invar" => [
		"Either enter a value or ask for an estimate		(see following option).",
	],
	"invar_e" => [
		"Either enter a value for the proportion of		invariable sites (see previous option) or ask for an		estimate.",
	],
	"alpha" => [
		"Either enter a value or ask for an estimate		(see following option).",
	],
	"alpha_e" => [
		"Either enter a value for the gamma distribution (see		previous option) or ask for an estimate.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/phyml.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

