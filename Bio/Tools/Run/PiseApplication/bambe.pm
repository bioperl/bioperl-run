# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::bambe
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::bambe

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::bambe

      Bioperl class for:

	BAMBE	Bayesian Analysis in Molecular Biology and Evolution (Simon, Larget)

	References:

		Larget, B. and D. Simon (1999). Markov chain Monte Carlo algorithms for the Bayesian analysis of phylogenetic trees. Molecular Biology and Evolution 16:750-759.

		Simon, D. and B. Larget. 1998. Bayesian analysis in molecular biology and evolution (BAMBE), version 1.01 beta. Department of Mathematics and Computer Science, Duquesne University.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/bambe.html 
         for available values):


		bambe (String)

		data_file (Sequence)
			Alignment file (data-file)
			pipe: readseq_ok_alig

		bambe_format (Switch)
			Alignement file in BAMBE format ?

		seed (Integer)
			Seed for random number generator (seed)

		cycles (Integer)
			Number of cycles to run the main algorithm (cycles)

		main_algorithm (Excl)
			Algorithm to run during production cycles (main-algorithm)

		burn (Integer)
			Number of cycles to run the burn algorithm (burn)

		burn_algorithm (Excl)
			Algorithm to run during burn (burn-algorithm)

		use_beta (Switch)
			Use scaled beta distribution modification of the local algorithm (use-beta)

		molecular_clock (Switch)
			Use a molecular clock (molecular-clock)

		likelihood_model (Excl)
			Likelihood model (molecular-clock)

		category_list (String)
			A valid category list (category-list)

		single_kappa (Switch)
			Single kappa (single-kappa)

		initial_kappa (String)
			Comma separated list of positive kappa values (initial-kappa)

		initial_theta (String)
			Comma separated list of positive theta values (initial-theta)

		estimate_pi (Switch)
			Use empirical relative frequencies (estimate-pi)

		initial_pia (String)
			Comma separated list of initial stationary probability of base A (initial-pia)

		initial_pig (String)
			>Comma separated list of initial stationary probability of base G (initial-pig)

		initial_pic (String)
			>Comma separated list of initial stationary probability of base C (initial-pia)

		initial_pit (String)
			>Comma separated list of initial stationary probability of base T (initial-pia)

		initial_ttp (String)
			Comma separated list of positive transition/transversion parameter values (TN93 model) (initial-ttp)

		initial_gamma (String)
			Comma separated list of positive gamma values ((TN93 model) (initial-gamma)

		parameter_update_interval (Integer)
			Parameter update interval (parameter-update-interval)

		update_kappa (Switch)
			Update kappa value (update-kappa)

		update_theta (Switch)
			Update theta value (update-theta)

		update_pi (Switch)
			Update pi value (update-pi)

		update_ttp (Switch)
			Update tpp value (TN93 model) (update-ttp)

		update_gamma (Switch)
			Update gamma value for (TN93 model) (update-gamma)

		tune_interval (Integer)
			Tune interval (tune-interval)

		global_tune (Float)
			Half-window width for global (global-tune)

		local_tune (Float)
			Stretch parameter for local (local-tune)

		theta_tune (Float)
			Dirichlet parameter for theta update (theta-tune)

		pi_tune (Float)
			Dirichlet parameter for pi update (pi-tune)

		kappa_tune (Float)
			Halft window width for kappa update (kappa-tune)

		ttp_tune (Float)
			Halft window width for tpp update (TN93 model) (tpp-tune)

		gamma_tune (Float)
			Half window width for gamma update (TN93 model) (gamma-tune)

		beta_tune (Float)
			Beta parameter for local update (beta-tune)

		sample_interval (Integer)
			Sample interval (sample-interval)

		newick_format (Switch)
			Newick format of tree file (newick-format)

		file_root (String)

		outgroup (Integer)
			Outgroup

		tree_file (InFile)
			Tree file (tree-file)

		init_tree_type (Excl)
			Initial tree type (initial-tree-type)

		max_initial_tree_height (Float)
			Initial tree height used to generate an initial random tree (max-initial-tree-height)

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

http://bioweb.pasteur.fr/seqanal/interfaces/bambe.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::bambe;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $bambe = Bio::Tools::Run::PiseApplication::bambe->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::bambe object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $bambe = $factory->program('bambe');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::bambe.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/bambe.pm

    $self->{COMMAND}   = "bambe";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BAMBE";

    $self->{DESCRIPTION}   = "Bayesian Analysis in Molecular Biology and Evolution";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Simon, Larget";

    $self->{REFERENCE}   = [

         "Larget, B. and D. Simon (1999). Markov chain Monte Carlo algorithms for the Bayesian analysis of phylogenetic trees. Molecular Biology and Evolution 16:750-759.",

         "Simon, D. and B. Larget. 1998. Bayesian analysis in molecular biology and evolution (BAMBE), version 1.01 beta. Department of Mathematics and Computer Science, Duquesne University.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"bambe",
	"rcfile",
	"data_file",
	"bambe_format",
	"run_options",
	"model_options",
	"param_update",
	"tuning_options",
	"output_options",
	"results_files",
	"result_tree",
	"top_file",
	"file_root",
	"input_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"bambe",
	"rcfile",
	"data_file", 	# Alignment file (data-file)
	"bambe_format", 	# Alignement file in BAMBE format ?
	"run_options", 	# Run characteristics
	"seed", 	# Seed for random number generator (seed)
	"cycles", 	# Number of cycles to run the main algorithm (cycles)
	"main_algorithm", 	# Algorithm to run during production cycles (main-algorithm)
	"burn", 	# Number of cycles to run the burn algorithm (burn)
	"burn_algorithm", 	# Algorithm to run during burn (burn-algorithm)
	"use_beta", 	# Use scaled beta distribution modification of the local algorithm (use-beta)
	"model_options", 	# Model specification
	"molecular_clock", 	# Use a molecular clock (molecular-clock)
	"likelihood_model", 	# Likelihood model (molecular-clock)
	"category_list", 	# A valid category list (category-list)
	"single_kappa", 	# Single kappa (single-kappa)
	"initial_kappa", 	# Comma separated list of positive kappa values (initial-kappa)
	"initial_theta", 	# Comma separated list of positive theta values (initial-theta)
	"estimate_pi", 	# Use empirical relative frequencies (estimate-pi)
	"initial_pia", 	# Comma separated list of initial stationary probability of base A (initial-pia)
	"initial_pig", 	# >Comma separated list of initial stationary probability of base G (initial-pig)
	"initial_pic", 	# >Comma separated list of initial stationary probability of base C (initial-pia)
	"initial_pit", 	# >Comma separated list of initial stationary probability of base T (initial-pia)
	"initial_ttp", 	# Comma separated list of positive transition/transversion parameter values (TN93 model) (initial-ttp)
	"initial_gamma", 	# Comma separated list of positive gamma values ((TN93 model) (initial-gamma)
	"param_update", 	# Parameter updating
	"parameter_update_interval", 	# Parameter update interval (parameter-update-interval)
	"update_kappa", 	# Update kappa value (update-kappa)
	"update_theta", 	# Update theta value (update-theta)
	"update_pi", 	# Update pi value (update-pi)
	"update_ttp", 	# Update tpp value (TN93 model) (update-ttp)
	"update_gamma", 	# Update gamma value for (TN93 model) (update-gamma)
	"tuning_options", 	# Tuning parameters
	"tune_interval", 	# Tune interval (tune-interval)
	"global_tune", 	# Half-window width for global (global-tune)
	"local_tune", 	# Stretch parameter for local (local-tune)
	"theta_tune", 	# Dirichlet parameter for theta update (theta-tune)
	"pi_tune", 	# Dirichlet parameter for pi update (pi-tune)
	"kappa_tune", 	# Halft window width for kappa update (kappa-tune)
	"ttp_tune", 	# Halft window width for tpp update (TN93 model) (tpp-tune)
	"gamma_tune", 	# Half window width for gamma update (TN93 model) (gamma-tune)
	"beta_tune", 	# Beta parameter for local update (beta-tune)
	"output_options", 	# Output options
	"sample_interval", 	# Sample interval (sample-interval)
	"newick_format", 	# Newick format of tree file (newick-format)
	"results_files",
	"result_tree",
	"top_file",
	"file_root",
	"input_options", 	# Input options
	"outgroup", 	# Outgroup
	"tree_file", 	# Tree file (tree-file)
	"init_tree_type", 	# Initial tree type (initial-tree-type)
	"max_initial_tree_height", 	# Initial tree height used to generate an initial random tree (max-initial-tree-height)

    ];

    $self->{TYPE}  = {
	"bambe" => 'String',
	"rcfile" => 'Results',
	"data_file" => 'Sequence',
	"bambe_format" => 'Switch',
	"run_options" => 'Paragraph',
	"seed" => 'Integer',
	"cycles" => 'Integer',
	"main_algorithm" => 'Excl',
	"burn" => 'Integer',
	"burn_algorithm" => 'Excl',
	"use_beta" => 'Switch',
	"model_options" => 'Paragraph',
	"molecular_clock" => 'Switch',
	"likelihood_model" => 'Excl',
	"category_list" => 'String',
	"single_kappa" => 'Switch',
	"initial_kappa" => 'String',
	"initial_theta" => 'String',
	"estimate_pi" => 'Switch',
	"initial_pia" => 'String',
	"initial_pig" => 'String',
	"initial_pic" => 'String',
	"initial_pit" => 'String',
	"initial_ttp" => 'String',
	"initial_gamma" => 'String',
	"param_update" => 'Paragraph',
	"parameter_update_interval" => 'Integer',
	"update_kappa" => 'Switch',
	"update_theta" => 'Switch',
	"update_pi" => 'Switch',
	"update_ttp" => 'Switch',
	"update_gamma" => 'Switch',
	"tuning_options" => 'Paragraph',
	"tune_interval" => 'Integer',
	"global_tune" => 'Float',
	"local_tune" => 'Float',
	"theta_tune" => 'Float',
	"pi_tune" => 'Float',
	"kappa_tune" => 'Float',
	"ttp_tune" => 'Float',
	"gamma_tune" => 'Float',
	"beta_tune" => 'Float',
	"output_options" => 'Paragraph',
	"sample_interval" => 'Integer',
	"newick_format" => 'Switch',
	"results_files" => 'Results',
	"result_tree" => 'Results',
	"top_file" => 'Results',
	"file_root" => 'String',
	"input_options" => 'Paragraph',
	"outgroup" => 'Integer',
	"tree_file" => 'InFile',
	"init_tree_type" => 'Excl',
	"max_initial_tree_height" => 'Float',

    };

    $self->{FORMAT}  = {
	"bambe" => {
		"perl" => '"bambe < bamberc"',
	},
	"rcfile" => {
	},
	"data_file" => {
		"perl" => '"data-file=$value\\n"',
	},
	"bambe_format" => {
		"perl" => '($value) ? "" : "cp $data_file $data_file.orig; fmtseq -f21 -p < $data_file.orig > $data_file; "',
	},
	"run_options" => {
	},
	"seed" => {
		"perl" => '(defined $value && $value != $vdef)? "seed=$value\\n" : ""',
	},
	"cycles" => {
		"perl" => '(defined $value && $value != $vdef)? "cycles=$value\\n" : ""',
	},
	"main_algorithm" => {
		"perl" => '($value && $value ne $vdef)? "main-algorithm=$value\\n" : ""',
	},
	"burn" => {
		"perl" => '(defined $value && $value != $vdef)? "burn=$value\\n" : ""',
	},
	"burn_algorithm" => {
		"perl" => '($value && $value ne $vdef)? "burn-algorithm=$value\\n" : ""',
	},
	"use_beta" => {
		"perl" => '($value) ? "use-beta=true\\n" : ""',
	},
	"model_options" => {
	},
	"molecular_clock" => {
		"perl" => '($value)? "" : "molecular-clock=false\\n"',
	},
	"likelihood_model" => {
		"perl" => '($value && $value ne $vdef) ? "likelihood-model=$value\\n" : ""',
	},
	"category_list" => {
		"perl" => '($value)? "category-list=$value\\n" : ""',
	},
	"single_kappa" => {
		"perl" => '($value)? "single-kappa=true\\n" : ""',
	},
	"initial_kappa" => {
		"perl" => '($value && $value ne $vdef)? "initial-kappa=$value\\n" : ""',
	},
	"initial_theta" => {
		"perl" => '($value && $value ne $vdef)? "initial-theta=$value\\n" : ""',
	},
	"estimate_pi" => {
		"perl" => '($value) ? "" : "estimate-pi=false\\n"',
	},
	"initial_pia" => {
		"perl" => '(defined $value && $value != $vdef) ? "initial-pia=$value\\n" : ""',
	},
	"initial_pig" => {
		"perl" => '(defined $value && $value != $vdef) ? "initial-pig=$value\\n" : ""',
	},
	"initial_pic" => {
		"perl" => '(defined $value && $value != $vdef) ? "initial-pic=$value\\n" : ""',
	},
	"initial_pit" => {
		"perl" => '(defined $value && $value != $vdef) ? "initial-pit=$value\\n" : ""',
	},
	"initial_ttp" => {
		"perl" => '($value && $value ne $vdef)? "initial-ttp=$value\\n" : ""',
	},
	"initial_gamma" => {
		"perl" => '($value && $value ne $vdef)? "initial-gamma=$value\\n" : ""',
	},
	"param_update" => {
	},
	"parameter_update_interval" => {
		"perl" => '(defined $value && $value != $vdef)? "parameter-update-interval=$value\\n" : ""',
	},
	"update_kappa" => {
		"perl" => '($value)? "" : "update-kappa=false\\n"',
	},
	"update_theta" => {
		"perl" => '($value)? "" : "update-theta=false\\n"',
	},
	"update_pi" => {
		"perl" => '($value)? "" : "update-pi=false\\n"',
	},
	"update_ttp" => {
		"perl" => '($value)? "" : "update-ttp=false\\n"',
	},
	"update_gamma" => {
		"perl" => '($value)? "" : "update-gamma=false\\n"',
	},
	"tuning_options" => {
	},
	"tune_interval" => {
		"perl" => '(defined $value && $value != $vdef)? "tune-interval=$value\\n" : ""',
	},
	"global_tune" => {
		"perl" => '(defined $value && $value != $vdef)? "global-tune=$value\\n" : ""',
	},
	"local_tune" => {
		"perl" => '(defined $value && $value != $vdef) ? "local-tune=$value\\n" : ""',
	},
	"theta_tune" => {
		"perl" => '(defined $value && $value != $vdef)? "theta-tune=$value\\n" : ""',
	},
	"pi_tune" => {
		"perl" => '(defined $value && $value != $vdef)? "pi-tune=$value\\n" : ""',
	},
	"kappa_tune" => {
		"perl" => '(defined $value && $value != $vdef)? "kappa-tune=$value\\n" : ""',
	},
	"ttp_tune" => {
		"perl" => '(defined $value && $value != $vdef)? "tpp-tune=$value\\n" : ""',
	},
	"gamma_tune" => {
		"perl" => '(defined $value && $value != $vdef) ? "gamma-tune=$value\\n" : ""',
	},
	"beta_tune" => {
		"perl" => '(defined $value && $value != $vdef)? "beta-tune=$value\\n" : ""',
	},
	"output_options" => {
	},
	"sample_interval" => {
		"perl" => '(defined $value && $value != $vdef)? "sample-interval=$value\\n" : ""',
	},
	"newick_format" => {
		"perl" => '($value)? "" : "newick-format=false\\n"',
	},
	"results_files" => {
	},
	"result_tree" => {
	},
	"top_file" => {
	},
	"file_root" => {
		"perl" => '"file-root=results\\n"',
	},
	"input_options" => {
	},
	"outgroup" => {
		"perl" => '(defined $value && $value != $vdef)? "outgroup=$value\\n" : ""',
	},
	"tree_file" => {
		"perl" => '($value)? "tree-file=$value\\n" : ""',
	},
	"init_tree_type" => {
	},
	"max_initial_tree_height" => {
		"perl" => '(defined $value && $value != $vdef)? "max-initial-tree-height=$value\\n" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"rcfile" => 'bamberc',
	"results_files" => 'results.lpd results.par results.out',
	"result_tree" => 'results.tre',
	"top_file" => 'results.top',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"bambe" => 0,
	"data_file" => 6,
	"bambe_format" => -10,
	"run_options" => 1,
	"seed" => 1,
	"cycles" => 1,
	"main_algorithm" => 1,
	"burn" => 1,
	"burn_algorithm" => 1,
	"use_beta" => 1,
	"model_options" => 2,
	"molecular_clock" => 2,
	"likelihood_model" => 2,
	"category_list" => 2,
	"single_kappa" => 2,
	"initial_kappa" => 2,
	"initial_theta" => 2,
	"estimate_pi" => 2,
	"initial_pia" => 2,
	"initial_pig" => 2,
	"initial_pic" => 2,
	"initial_pit" => 2,
	"initial_ttp" => 2,
	"initial_gamma" => 2,
	"param_update" => 4,
	"parameter_update_interval" => 4,
	"update_kappa" => 4,
	"update_theta" => 4,
	"update_pi" => 4,
	"update_ttp" => 4,
	"update_gamma" => 4,
	"tuning_options" => 5,
	"tune_interval" => 5,
	"global_tune" => 5,
	"local_tune" => 5,
	"theta_tune" => 5,
	"pi_tune" => 5,
	"kappa_tune" => 5,
	"ttp_tune" => 5,
	"gamma_tune" => 5,
	"beta_tune" => 5,
	"output_options" => 2,
	"sample_interval" => 2,
	"newick_format" => 2,
	"file_root" => 6,
	"input_options" => 7,
	"outgroup" => 7,
	"tree_file" => 7,
	"init_tree_type" => 7,
	"max_initial_tree_height" => 7,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"bambe_format",
	"bambe",
	"rcfile",
	"results_files",
	"result_tree",
	"top_file",
	"cycles",
	"main_algorithm",
	"burn",
	"burn_algorithm",
	"use_beta",
	"run_options",
	"seed",
	"likelihood_model",
	"category_list",
	"single_kappa",
	"initial_kappa",
	"initial_theta",
	"estimate_pi",
	"initial_pia",
	"initial_pig",
	"initial_pic",
	"initial_pit",
	"initial_ttp",
	"initial_gamma",
	"sample_interval",
	"newick_format",
	"output_options",
	"model_options",
	"molecular_clock",
	"update_ttp",
	"update_gamma",
	"param_update",
	"parameter_update_interval",
	"update_kappa",
	"update_theta",
	"update_pi",
	"pi_tune",
	"kappa_tune",
	"ttp_tune",
	"gamma_tune",
	"beta_tune",
	"theta_tune",
	"tuning_options",
	"tune_interval",
	"global_tune",
	"local_tune",
	"data_file",
	"file_root",
	"input_options",
	"outgroup",
	"tree_file",
	"init_tree_type",
	"max_initial_tree_height",

    ];

    $self->{SIZE}  = {
	"category_list" => 20,
	"initial_kappa" => 20,
	"initial_theta" => 20,
	"initial_pia" => 20,
	"initial_pig" => 20,
	"initial_pic" => 20,
	"initial_pit" => 20,
	"initial_ttp" => 20,
	"initial_gamma" => 20,

    };

    $self->{ISHIDDEN}  = {
	"bambe" => 1,
	"rcfile" => 0,
	"data_file" => 0,
	"bambe_format" => 0,
	"run_options" => 0,
	"seed" => 0,
	"cycles" => 0,
	"main_algorithm" => 0,
	"burn" => 0,
	"burn_algorithm" => 0,
	"use_beta" => 0,
	"model_options" => 0,
	"molecular_clock" => 0,
	"likelihood_model" => 0,
	"category_list" => 0,
	"single_kappa" => 0,
	"initial_kappa" => 0,
	"initial_theta" => 0,
	"estimate_pi" => 0,
	"initial_pia" => 0,
	"initial_pig" => 0,
	"initial_pic" => 0,
	"initial_pit" => 0,
	"initial_ttp" => 0,
	"initial_gamma" => 0,
	"param_update" => 0,
	"parameter_update_interval" => 0,
	"update_kappa" => 0,
	"update_theta" => 0,
	"update_pi" => 0,
	"update_ttp" => 0,
	"update_gamma" => 0,
	"tuning_options" => 0,
	"tune_interval" => 0,
	"global_tune" => 0,
	"local_tune" => 0,
	"theta_tune" => 0,
	"pi_tune" => 0,
	"kappa_tune" => 0,
	"ttp_tune" => 0,
	"gamma_tune" => 0,
	"beta_tune" => 0,
	"output_options" => 0,
	"sample_interval" => 0,
	"newick_format" => 0,
	"results_files" => 0,
	"result_tree" => 0,
	"top_file" => 0,
	"file_root" => 1,
	"input_options" => 0,
	"outgroup" => 0,
	"tree_file" => 0,
	"init_tree_type" => 0,
	"max_initial_tree_height" => 0,

    };

    $self->{ISCOMMAND}  = {
	"bambe" => 1,
	"rcfile" => 0,
	"data_file" => 0,
	"bambe_format" => 0,
	"run_options" => 0,
	"seed" => 0,
	"cycles" => 0,
	"main_algorithm" => 0,
	"burn" => 0,
	"burn_algorithm" => 0,
	"use_beta" => 0,
	"model_options" => 0,
	"molecular_clock" => 0,
	"likelihood_model" => 0,
	"category_list" => 0,
	"single_kappa" => 0,
	"initial_kappa" => 0,
	"initial_theta" => 0,
	"estimate_pi" => 0,
	"initial_pia" => 0,
	"initial_pig" => 0,
	"initial_pic" => 0,
	"initial_pit" => 0,
	"initial_ttp" => 0,
	"initial_gamma" => 0,
	"param_update" => 0,
	"parameter_update_interval" => 0,
	"update_kappa" => 0,
	"update_theta" => 0,
	"update_pi" => 0,
	"update_ttp" => 0,
	"update_gamma" => 0,
	"tuning_options" => 0,
	"tune_interval" => 0,
	"global_tune" => 0,
	"local_tune" => 0,
	"theta_tune" => 0,
	"pi_tune" => 0,
	"kappa_tune" => 0,
	"ttp_tune" => 0,
	"gamma_tune" => 0,
	"beta_tune" => 0,
	"output_options" => 0,
	"sample_interval" => 0,
	"newick_format" => 0,
	"results_files" => 0,
	"result_tree" => 0,
	"top_file" => 0,
	"file_root" => 0,
	"input_options" => 0,
	"outgroup" => 0,
	"tree_file" => 0,
	"init_tree_type" => 0,
	"max_initial_tree_height" => 0,

    };

    $self->{ISMANDATORY}  = {
	"bambe" => 0,
	"rcfile" => 0,
	"data_file" => 0,
	"bambe_format" => 0,
	"run_options" => 0,
	"seed" => 0,
	"cycles" => 0,
	"main_algorithm" => 0,
	"burn" => 0,
	"burn_algorithm" => 0,
	"use_beta" => 0,
	"model_options" => 0,
	"molecular_clock" => 0,
	"likelihood_model" => 0,
	"category_list" => 0,
	"single_kappa" => 0,
	"initial_kappa" => 0,
	"initial_theta" => 0,
	"estimate_pi" => 0,
	"initial_pia" => 0,
	"initial_pig" => 0,
	"initial_pic" => 0,
	"initial_pit" => 0,
	"initial_ttp" => 0,
	"initial_gamma" => 0,
	"param_update" => 0,
	"parameter_update_interval" => 0,
	"update_kappa" => 0,
	"update_theta" => 0,
	"update_pi" => 0,
	"update_ttp" => 0,
	"update_gamma" => 0,
	"tuning_options" => 0,
	"tune_interval" => 0,
	"global_tune" => 0,
	"local_tune" => 0,
	"theta_tune" => 0,
	"pi_tune" => 0,
	"kappa_tune" => 0,
	"ttp_tune" => 0,
	"gamma_tune" => 0,
	"beta_tune" => 0,
	"output_options" => 0,
	"sample_interval" => 0,
	"newick_format" => 0,
	"results_files" => 0,
	"result_tree" => 0,
	"top_file" => 0,
	"file_root" => 0,
	"input_options" => 0,
	"outgroup" => 0,
	"tree_file" => 0,
	"init_tree_type" => 0,
	"max_initial_tree_height" => 0,

    };

    $self->{PROMPT}  = {
	"bambe" => "",
	"rcfile" => "",
	"data_file" => "Alignment file (data-file)",
	"bambe_format" => "Alignement file in BAMBE format ?",
	"run_options" => "Run characteristics",
	"seed" => "Seed for random number generator (seed)",
	"cycles" => "Number of cycles to run the main algorithm (cycles)",
	"main_algorithm" => "Algorithm to run during production cycles (main-algorithm)",
	"burn" => "Number of cycles to run the burn algorithm (burn)",
	"burn_algorithm" => "Algorithm to run during burn (burn-algorithm)",
	"use_beta" => "Use scaled beta distribution modification of the local algorithm (use-beta)",
	"model_options" => "Model specification",
	"molecular_clock" => "Use a molecular clock (molecular-clock)",
	"likelihood_model" => "Likelihood model (molecular-clock)",
	"category_list" => "A valid category list (category-list)",
	"single_kappa" => "Single kappa (single-kappa)",
	"initial_kappa" => "Comma separated list of positive kappa values (initial-kappa)",
	"initial_theta" => "Comma separated list of positive theta values (initial-theta)",
	"estimate_pi" => "Use empirical relative frequencies (estimate-pi)",
	"initial_pia" => "Comma separated list of initial stationary probability of base A (initial-pia)",
	"initial_pig" => ">Comma separated list of initial stationary probability of base G (initial-pig)",
	"initial_pic" => ">Comma separated list of initial stationary probability of base C (initial-pia)",
	"initial_pit" => ">Comma separated list of initial stationary probability of base T (initial-pia)",
	"initial_ttp" => "Comma separated list of positive transition/transversion parameter values (TN93 model) (initial-ttp)",
	"initial_gamma" => "Comma separated list of positive gamma values ((TN93 model) (initial-gamma)",
	"param_update" => "Parameter updating",
	"parameter_update_interval" => "Parameter update interval (parameter-update-interval)",
	"update_kappa" => "Update kappa value (update-kappa)",
	"update_theta" => "Update theta value (update-theta)",
	"update_pi" => "Update pi value (update-pi)",
	"update_ttp" => "Update tpp value (TN93 model) (update-ttp)",
	"update_gamma" => "Update gamma value for (TN93 model) (update-gamma)",
	"tuning_options" => "Tuning parameters",
	"tune_interval" => "Tune interval (tune-interval)",
	"global_tune" => "Half-window width for global (global-tune)",
	"local_tune" => "Stretch parameter for local (local-tune)",
	"theta_tune" => "Dirichlet parameter for theta update (theta-tune)",
	"pi_tune" => "Dirichlet parameter for pi update (pi-tune)",
	"kappa_tune" => "Halft window width for kappa update (kappa-tune)",
	"ttp_tune" => "Halft window width for tpp update (TN93 model) (tpp-tune)",
	"gamma_tune" => "Half window width for gamma update (TN93 model) (gamma-tune)",
	"beta_tune" => "Beta parameter for local update (beta-tune)",
	"output_options" => "Output options",
	"sample_interval" => "Sample interval (sample-interval)",
	"newick_format" => "Newick format of tree file (newick-format)",
	"results_files" => "",
	"result_tree" => "",
	"top_file" => "",
	"file_root" => "",
	"input_options" => "Input options",
	"outgroup" => "Outgroup",
	"tree_file" => "Tree file (tree-file)",
	"init_tree_type" => "Initial tree type (initial-tree-type)",
	"max_initial_tree_height" => "Initial tree height used to generate an initial random tree (max-initial-tree-height)",

    };

    $self->{ISSTANDOUT}  = {
	"bambe" => 0,
	"rcfile" => 0,
	"data_file" => 0,
	"bambe_format" => 0,
	"run_options" => 0,
	"seed" => 0,
	"cycles" => 0,
	"main_algorithm" => 0,
	"burn" => 0,
	"burn_algorithm" => 0,
	"use_beta" => 0,
	"model_options" => 0,
	"molecular_clock" => 0,
	"likelihood_model" => 0,
	"category_list" => 0,
	"single_kappa" => 0,
	"initial_kappa" => 0,
	"initial_theta" => 0,
	"estimate_pi" => 0,
	"initial_pia" => 0,
	"initial_pig" => 0,
	"initial_pic" => 0,
	"initial_pit" => 0,
	"initial_ttp" => 0,
	"initial_gamma" => 0,
	"param_update" => 0,
	"parameter_update_interval" => 0,
	"update_kappa" => 0,
	"update_theta" => 0,
	"update_pi" => 0,
	"update_ttp" => 0,
	"update_gamma" => 0,
	"tuning_options" => 0,
	"tune_interval" => 0,
	"global_tune" => 0,
	"local_tune" => 0,
	"theta_tune" => 0,
	"pi_tune" => 0,
	"kappa_tune" => 0,
	"ttp_tune" => 0,
	"gamma_tune" => 0,
	"beta_tune" => 0,
	"output_options" => 0,
	"sample_interval" => 0,
	"newick_format" => 0,
	"results_files" => 0,
	"result_tree" => 0,
	"top_file" => 0,
	"file_root" => 0,
	"input_options" => 0,
	"outgroup" => 0,
	"tree_file" => 0,
	"init_tree_type" => 0,
	"max_initial_tree_height" => 0,

    };

    $self->{VLIST}  = {

	"run_options" => ['seed','cycles','main_algorithm','burn','burn_algorithm','use_beta',],
	"main_algorithm" => ['global','global','local','local',],
	"burn_algorithm" => ['global','global','local','local',],
	"model_options" => ['molecular_clock','likelihood_model','category_list','single_kappa','initial_kappa','initial_theta','estimate_pi','initial_pia','initial_pig','initial_pic','initial_pit','initial_ttp','initial_gamma',],
	"likelihood_model" => ['HKY85','HKY85: Hasegawa, Kishino, Yano (1985)','F84','F84: Felsenstein\'s PHYLIP (1984)','TN93','TN93: Tamura-Nei (1993)',],
	"param_update" => ['parameter_update_interval','update_kappa','update_theta','update_pi','update_ttp','update_gamma',],
	"tuning_options" => ['tune_interval','global_tune','local_tune','theta_tune','pi_tune','kappa_tune','ttp_tune','gamma_tune','beta_tune',],
	"output_options" => ['sample_interval','newick_format',],
	"input_options" => ['outgroup','tree_file','init_tree_type','max_initial_tree_height',],
	"init_tree_type" => ['random','random','upgma','upgma','neighbor-joining','neighbor-joining','newick','newick','bambe','bambe',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"bambe_format" => '0',
	"seed" => '194024933',
	"cycles" => '6000',
	"main_algorithm" => 'local',
	"burn" => '1000',
	"burn_algorithm" => 'global',
	"use_beta" => '0',
	"molecular_clock" => '1',
	"likelihood_model" => 'HKY85',
	"single_kappa" => '0',
	"initial_kappa" => '2.0,2.0,2.0',
	"initial_theta" => '1.0,1.0,1.0',
	"estimate_pi" => '1',
	"initial_pia" => '0.25,0.25,0.25',
	"initial_pig" => '0.25,0.25,0.25',
	"initial_pic" => '0.25,0.25,0.25',
	"initial_pit" => '0.25,0.25,0.25',
	"initial_ttp" => '1.0,1.0,1.0',
	"initial_gamma" => '1.0,1.0,1.0',
	"parameter_update_interval" => '1',
	"update_kappa" => '1',
	"update_theta" => '1',
	"update_pi" => '1',
	"update_ttp" => '1',
	"update_gamma" => '1',
	"tune_interval" => '200',
	"global_tune" => '0.01',
	"local_tune" => '0.19',
	"theta_tune" => '2000.0',
	"pi_tune" => '2000.0',
	"kappa_tune" => '0.1',
	"ttp_tune" => '0.1',
	"gamma_tune" => '0.1',
	"beta_tune" => '10.0',
	"sample_interval" => '200',
	"newick_format" => '1',
	"outgroup" => '1',
	"init_tree_type" => 'random',
	"max_initial_tree_height" => '0.1',

    };

    $self->{PRECOND}  = {
	"bambe" => { "perl" => '1' },
	"rcfile" => { "perl" => '1' },
	"data_file" => { "perl" => '1' },
	"bambe_format" => { "perl" => '1' },
	"run_options" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"cycles" => { "perl" => '1' },
	"main_algorithm" => { "perl" => '1' },
	"burn" => { "perl" => '1' },
	"burn_algorithm" => { "perl" => '1' },
	"use_beta" => {
		"perl" => '$main_algorithm eq "local" || $burn_algorithm eq "local"',
	},
	"model_options" => { "perl" => '1' },
	"molecular_clock" => { "perl" => '1' },
	"likelihood_model" => { "perl" => '1' },
	"category_list" => { "perl" => '1' },
	"single_kappa" => { "perl" => '1' },
	"initial_kappa" => { "perl" => '1' },
	"initial_theta" => { "perl" => '1' },
	"estimate_pi" => { "perl" => '1' },
	"initial_pia" => {
		"perl" => '! $estimate_pi',
	},
	"initial_pig" => {
		"perl" => '! $estimate_pi',
	},
	"initial_pic" => {
		"perl" => '! $estimate_pi',
	},
	"initial_pit" => {
		"perl" => '! $estimate_pi',
	},
	"initial_ttp" => {
		"perl" => '$likelihood_model eq "TN93"',
	},
	"initial_gamma" => {
		"perl" => '$likelihood_model eq "TN93"',
	},
	"param_update" => { "perl" => '1' },
	"parameter_update_interval" => { "perl" => '1' },
	"update_kappa" => { "perl" => '1' },
	"update_theta" => { "perl" => '1' },
	"update_pi" => { "perl" => '1' },
	"update_ttp" => {
		"perl" => '$likelihood_model eq "TN93"',
	},
	"update_gamma" => {
		"perl" => '$likelihood_model eq "TN93"',
	},
	"tuning_options" => { "perl" => '1' },
	"tune_interval" => { "perl" => '1' },
	"global_tune" => {
		"perl" => '$burn_algorithm =~ /^global/',
	},
	"local_tune" => {
		"perl" => '$burn_algorithm =~ /^global/ || $main_algorithm =~ /^global/',
	},
	"theta_tune" => { "perl" => '1' },
	"pi_tune" => { "perl" => '1' },
	"kappa_tune" => {
		"perl" => '$parameter_update_interval > 0 && $update_kappa',
	},
	"ttp_tune" => {
		"perl" => '$parameter_update_interval > 0 && $update_tpp',
	},
	"gamma_tune" => {
		"perl" => '$parameter_update_interval > 0 && $update_gamma',
	},
	"beta_tune" => {
		"perl" => '$use_beta',
	},
	"output_options" => { "perl" => '1' },
	"sample_interval" => { "perl" => '1' },
	"newick_format" => { "perl" => '1' },
	"results_files" => { "perl" => '1' },
	"result_tree" => { "perl" => '1' },
	"top_file" => { "perl" => '1' },
	"file_root" => { "perl" => '1' },
	"input_options" => { "perl" => '1' },
	"outgroup" => {
		"perl" => '! $molecular-clock',
	},
	"tree_file" => { "perl" => '1' },
	"init_tree_type" => { "perl" => '1' },
	"max_initial_tree_height" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"result_tree" => {
		 '$newick_format' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"data_file" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"bambe" => 0,
	"rcfile" => 0,
	"data_file" => 0,
	"bambe_format" => 0,
	"run_options" => 0,
	"seed" => 0,
	"cycles" => 0,
	"main_algorithm" => 0,
	"burn" => 0,
	"burn_algorithm" => 0,
	"use_beta" => 0,
	"model_options" => 0,
	"molecular_clock" => 0,
	"likelihood_model" => 0,
	"category_list" => 0,
	"single_kappa" => 0,
	"initial_kappa" => 0,
	"initial_theta" => 0,
	"estimate_pi" => 0,
	"initial_pia" => 0,
	"initial_pig" => 0,
	"initial_pic" => 0,
	"initial_pit" => 0,
	"initial_ttp" => 0,
	"initial_gamma" => 0,
	"param_update" => 0,
	"parameter_update_interval" => 0,
	"update_kappa" => 0,
	"update_theta" => 0,
	"update_pi" => 0,
	"update_ttp" => 0,
	"update_gamma" => 0,
	"tuning_options" => 0,
	"tune_interval" => 0,
	"global_tune" => 0,
	"local_tune" => 0,
	"theta_tune" => 0,
	"pi_tune" => 0,
	"kappa_tune" => 0,
	"ttp_tune" => 0,
	"gamma_tune" => 0,
	"beta_tune" => 0,
	"output_options" => 0,
	"sample_interval" => 0,
	"newick_format" => 0,
	"results_files" => 0,
	"result_tree" => 0,
	"top_file" => 0,
	"file_root" => 0,
	"input_options" => 0,
	"outgroup" => 0,
	"tree_file" => 0,
	"init_tree_type" => 0,
	"max_initial_tree_height" => 0,

    };

    $self->{ISSIMPLE}  = {
	"bambe" => 0,
	"rcfile" => 0,
	"data_file" => 1,
	"bambe_format" => 1,
	"run_options" => 0,
	"seed" => 0,
	"cycles" => 0,
	"main_algorithm" => 0,
	"burn" => 0,
	"burn_algorithm" => 0,
	"use_beta" => 0,
	"model_options" => 0,
	"molecular_clock" => 0,
	"likelihood_model" => 0,
	"category_list" => 0,
	"single_kappa" => 0,
	"initial_kappa" => 0,
	"initial_theta" => 0,
	"estimate_pi" => 0,
	"initial_pia" => 0,
	"initial_pig" => 0,
	"initial_pic" => 0,
	"initial_pit" => 0,
	"initial_ttp" => 0,
	"initial_gamma" => 0,
	"param_update" => 0,
	"parameter_update_interval" => 0,
	"update_kappa" => 0,
	"update_theta" => 0,
	"update_pi" => 0,
	"update_ttp" => 0,
	"update_gamma" => 0,
	"tuning_options" => 0,
	"tune_interval" => 0,
	"global_tune" => 0,
	"local_tune" => 0,
	"theta_tune" => 0,
	"pi_tune" => 0,
	"kappa_tune" => 0,
	"ttp_tune" => 0,
	"gamma_tune" => 0,
	"beta_tune" => 0,
	"output_options" => 0,
	"sample_interval" => 0,
	"newick_format" => 0,
	"results_files" => 0,
	"result_tree" => 0,
	"top_file" => 0,
	"file_root" => 0,
	"input_options" => 0,
	"outgroup" => 0,
	"tree_file" => 0,
	"init_tree_type" => 0,
	"max_initial_tree_height" => 0,

    };

    $self->{PARAMFILE}  = {
	"data_file" => "bamberc",
	"seed" => "bamberc",
	"cycles" => "bamberc",
	"main_algorithm" => "bamberc",
	"burn" => "bamberc",
	"burn_algorithm" => "bamberc",
	"use_beta" => "bamberc",
	"molecular_clock" => "bamberc",
	"likelihood_model" => "bamberc",
	"category_list" => "bamberc",
	"single_kappa" => "bamberc",
	"initial_kappa" => "bamberc",
	"initial_theta" => "bamberc",
	"estimate_pi" => "bamberc",
	"initial_ttp" => "bamberc",
	"initial_gamma" => "bamberc",
	"parameter_update_interval" => "bamberc",
	"update_kappa" => "bamberc",
	"update_theta" => "bamberc",
	"update_pi" => "bamberc",
	"update_ttp" => "bamberc",
	"update_gamma" => "bamberc",
	"tune_interval" => "bamberc",
	"global_tune" => "bamberc",
	"local_tune" => "bamberc",
	"theta_tune" => "bamberc",
	"pi_tune" => "bamberc",
	"kappa_tune" => "bamberc",
	"ttp_tune" => "bamberc",
	"gamma_tune" => "bamberc",
	"beta_tune" => "bamberc",
	"sample_interval" => "bamberc",
	"newick_format" => "bamberc",
	"file_root" => "bamberc",
	"outgroup" => "bamberc",
	"tree_file" => "bamberc",
	"init_tree_type" => "bamberc",
	"max_initial_tree_height" => "bamberc",

    };

    $self->{COMMENT}  = {
	"burn" => [
		"Parameter values are not updated during burn. User should discard these cycles and the initial cycles of the main algorithm before inference.",
	],
	"category_list" => [
		"Each category has its own set of	parameters. Each category is denoted by a positive integer between 1 and 10. A comma-separated list gives the categories of the sites in order, e.g., 1,2,3,1,3 means that the first site is in category 1, the second in 2, the third in 3, the fourth in 1, and the fifth site is in category 3.",
		"A repeat count is indicated by a caret (^). For example, 1^20,2^5,3^2 means that the first twenty sites are in category 1, the next five sites are in 2, and the next two sites are in category 3.",
		"Parentheses may be used to group sites together with a common repeat count, i.e., (1,2)^5 is the same as 1,2,1,2,1,2,1,2,1,2. Repeat counts may be nested, e.g., (1^3,2)^2 is the same as 1,1,1,2,1,1,1,2.",
		"Repetition to the end of the list of sites is indicated by an asterisk (*). For example, 1^5,2* means that the first five sites are in category 1, and all the remaining sites are in category 2. Parentheses may also be used in conjunction with the asterisk, e.g., (1,2)* is the same as 1,2,1,2,1,2,.... The category list may contain at most one asterisk and it must be associated with the last category or group in the list. In other words, an asterisk may appear only at the end of the list.",
		"Examples",
		"1* - all sites are the same category. (default)",
		"(1,2,3)* - all sites are partitioned by codon position.",
		"1^99,2^50,3^9 - the sites are divided over three genes. Each gene has its own set of parameters used by all sites in that gene. The first gene is composed of the first ninety-nine sites, the next by the next fifty sites, and the last by nine sites.",
	],
	"single_kappa" => [
		"If true, the same kappa parameter is used for all site categories. If false, there are different values for different site categories. It has no effect if there is only one rate category.",
	],
	"initial_kappa" => [
		"If single-kappa is true, a warning is given if more than one value is specified. The first value will be used. If single-kappa is false, a value must be specified for each category in use.",
	],
	"initial_theta" => [
		"The weighted average of these values should be 1, with weights given by the proportion of sites in each site category. (Renormalization is automatic and a warning given if the condition fails.) If there are an equal number of sites in each category, for example, the numbers should average to 1.",
	],
	"estimate_pi" => [
		"If ture, the initial stationary probabilities for each base in each category are estimated by the relative frequencies with which they appear in the data.",
	],
	"initial_ttp" => [
		"This is used only with TN93. There must be a value specified for each site-category used if TN93 is the chosen model.",
	],
	"initial_gamma" => [
		"This is used only with TN93. There must be a value specified for each site-category used if TN93 is the chosen model.",
	],
	"parameter_update_interval" => [
		"During the main algorithm, any \'on\' parameters are updated at each cycle divisible by this value. Use zero for no paramter updating.",
	],
	"tune_interval" => [
		"While running global during the burn, if the acceptance rate for tree proposal falls below 15% during this interval, delta is halved.",
	],
	"global_tune" => [
		"This tuning parameter is only used with the global algorithm during burn. The smaller its value, the greater the tree acceptance rate will be.",
	],
	"local_tune" => [
		"This tuning parameter is only used with the local algorithm. It modulates the size of a maximal stretch. The smaller the value, the greater the tree acceptance rate will be.",
	],
	"theta_tune" => [
		"Tuning parameter used during update of theta value(s). The larger its value, the more likely proposals are to be accepted.",
	],
	"pi_tune" => [
		"Tuning parameter used during update of pi values. The larger its value, the more likely proposals are to be accepted.",
	],
	"kappa_tune" => [
		"This tuning parameter is only used when \'parameter-update-interval\' is positive and \'update-kappa\' is true. The smaller its value, the greater the parameter acceptance rate will be.",
	],
	"ttp_tune" => [
		"This tuning parameter is only used when \'parameter-update-interval\' is positive and \'update-tpp\' is true. The smaller its value, the greater the parameter acceptance rate will be.",
	],
	"gamma_tune" => [
		"This tuning parameter is only used when \'parameter-update-interval\' is positive and \'update-gamma\' is true. The smaller its value, the greater the parameter acceptance rate will be.",
	],
	"beta_tune" => [
		"This tuning parameter is only used if the \'use-beta\' is true. The larger its value, the greater the parameter acceptance rate will be.",
	],
	"sample_interval" => [
		"During burn and main algorithms, the tree topology, log likelihoods, and parameters are written to files at each cycle divisible by this value.",
	],
	"newick_format" => [
		"Indicates the format of the tree to read (if not random) and the format of the tree to print after the run.",
	],
	"outgroup" => [
		"This is ignored if a molecular clock is assumed. In the absence of a clock, trees and tree topologies are printed with the outgroup emerging directly from the root.",
	],
	"tree_file" => [
		"If no tree file is given, the program generates a random tree from a flat distribution where each labeled history is equally likely.",
	],
	"init_tree_type" => [
		". random select a tree from the prior",
		". upgma sets the initial clock tree to the UPGMA tree using maximum likelihodd distances with the specified model and initial parameter values.",
		". neighbor-joining sets the initial nonclock tree to the neigbor joining tree using maximum liklihodd distances with the specified model and initial parameter values.",
		". newick reads in an initial tree in Newick format from a file.",
		". bambe reads in an initial tree in BAMBE format from a file.",
	],
	"max_initial_tree_height" => [
		"This parmeter is only used to generate an initial random tree.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/bambe.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

