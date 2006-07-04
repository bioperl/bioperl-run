# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::tipdate
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::tipdate

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::tipdate

      Bioperl class for:

	TipDate	Analysis of trees with dated tips (Andrew Rambaut)

	References:

		Andrew Rambaut, 2000. Estimating the rate of molecular evolution: Incorporating non-contemporaneous sequences into maximum likelihood phylogenies. Bioinformatics.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/tipdate.html 
         for available values):


		tipdate (String)

		alignment (Sequence)
			Alignment file
			pipe: readseq_ok_alig

		model (Excl)
			MODEL (-m)

		constant_rate (Switch)
			Molecular clock model (SR model) (-k)

		change_rate (Excl)
			Estimate rate of change of rate (VRDT model: requires dated tips)

		change_rate_value (Integer)
			You may provide a constant rate value (-w #)

		absolute_rate (Float)
			Estimate absolute rate of substitution (SRDT model: requires dated tips) (+s)Absolute rate of molecular evolution (requires dated tips) (-s)

		absolute_rate_value (Integer)
			specify absolute rate of substitution (-s #)

		likelihood_root (Switch)
			Estimate maximum likelihood root (requires molecular clock)

		absolute_root_value (Integer)
			root with specified outgroup taxa (requires molecular clock) (-r #)

		absolute_rate (Float)
			Estimate absolute rate of substitution (SRDT model: requires dated tips) (+s)Absolute rate of molecular evolution (requires dated tips) (-s)

		estimate_root (Switch)
			Estimate maximum likelihood root (requires molecular clock) (+r)

		outgroup (Integer)
			Root with specified outgroup taxa (requires molecular clock) (-r)

		substitution_confidence (Switch)
			Estimate confidence intervals for rate of substitution (with +s option) (-is)

		date_confidence (Switch)
			Estimate confidence intervals for date of root of tree (with +s option) (-id)

		change_confidence (Switch)
			Estimate confidence intervals for rate of change of rate of substitution (with +w option) (-iw)

		limit (Float)
			Limit to use estimating confidence intervals (-l)

		codon_categories (String)
			CODON CATEGORIES = 112, 123, 120, etc. [default: homogeneity] (-p)

		codon_rate (String)
			CODON category rates: #1 #2 #3 separated by commas [default = estimate rates] (-c)

		seperate (Switch)
			Estimate seperate models for each site category (-e)

		gamma (Integer)
			Num categories for gamma rate heterogeneity (2 to 32) (-g)

		alpha (Integer)
			gamma shape (alpha) for site rate heterogeneity (-a)

		datasets (Integer)
			Number of Datasets (-n)

		user_branch (Switch)
			User branch-lengths [default = estimate] (-ul)

		treefile (InFile)
			Optional file containing trees

		equal_freq (Switch)
			Frequences of bases equal (-f=)

		freq_bases (String)
			Frequences of bases: #A #C #G #T separated by commas(-f)

		transition_transversion (Float)
			Transition/transversion ratio (-t)

		branch (Switch)
			Print final branch lengths (-vb)

		likelihoods (Switch)
			Write likelihoods for each Site (-vs)

		notrees (Switch)
			Don't Write trees (-vw)

		memory (Switch)
			Memory usage information (-vm)

		progress (Switch)

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

http://bioweb.pasteur.fr/seqanal/interfaces/tipdate.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::tipdate;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $tipdate = Bio::Tools::Run::PiseApplication::tipdate->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::tipdate object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $tipdate = $factory->program('tipdate');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::tipdate.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/tipdate.pm

    $self->{COMMAND}   = "tipdate";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TipDate";

    $self->{DESCRIPTION}   = "Analysis of trees with dated tips";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Andrew Rambaut";

    $self->{REFERENCE}   = [

         "Andrew Rambaut, 2000. Estimating the rate of molecular evolution: Incorporating non-contemporaneous sequences into maximum likelihood phylogenies. Bioinformatics.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"tipdate",
	"outtree",
	"alignment",
	"control_options",
	"output_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"tipdate",
	"outtree",
	"alignment", 	# Alignment file
	"control_options", 	# Control options
	"model", 	# MODEL (-m)
	"constant_rate", 	# Molecular clock model (SR model) (-k)
	"change_rate", 	# Estimate rate of change of rate (VRDT model: requires dated tips)
	"change_rate_value", 	# You may provide a constant rate value (-w #)
	"absolute_rate", 	# Estimate absolute rate of substitution (SRDT model: requires dated tips) (+s)Absolute rate of molecular evolution (requires dated tips) (-s)
	"absolute_rate_value", 	# specify absolute rate of substitution (-s #)
	"likelihood_root", 	# Estimate maximum likelihood root (requires molecular clock)
	"absolute_root_value", 	# root with specified outgroup taxa (requires molecular clock) (-r #)
	"absolute_rate", 	# Estimate absolute rate of substitution (SRDT model: requires dated tips) (+s)Absolute rate of molecular evolution (requires dated tips) (-s)
	"estimate_root", 	# Estimate maximum likelihood root (requires molecular clock) (+r)
	"outgroup", 	# Root with specified outgroup taxa (requires molecular clock) (-r)
	"substitution_confidence", 	# Estimate confidence intervals for rate of substitution (with +s option) (-is)
	"date_confidence", 	# Estimate confidence intervals for date of root of tree (with +s option) (-id)
	"change_confidence", 	# Estimate confidence intervals for rate of change of rate of substitution (with +w option) (-iw)
	"limit", 	# Limit to use estimating confidence intervals (-l)
	"codon_categories", 	# CODON CATEGORIES = 112, 123, 120, etc. [default: homogeneity] (-p)
	"codon_rate", 	# CODON category rates: #1 #2 #3 separated by commas [default = estimate rates] (-c)
	"seperate", 	# Estimate seperate models for each site category (-e)
	"gamma", 	# Num categories for gamma rate heterogeneity (2 to 32) (-g)
	"alpha", 	# gamma shape (alpha) for site rate heterogeneity (-a)
	"datasets", 	# Number of Datasets (-n)
	"user_branch", 	# User branch-lengths [default = estimate] (-ul)
	"treefile", 	# Optional file containing trees
	"equal_freq", 	# Frequences of bases equal (-f=)
	"freq_bases", 	# Frequences of bases: #A #C #G #T separated by commas(-f)
	"transition_transversion", 	# Transition/transversion ratio (-t)
	"output_options", 	# Output options
	"branch", 	# Print final branch lengths (-vb)
	"likelihoods", 	# Write likelihoods for each Site (-vs)
	"notrees", 	# Don't Write trees (-vw)
	"memory", 	# Memory usage information (-vm)
	"progress",

    ];

    $self->{TYPE}  = {
	"tipdate" => 'String',
	"outtree" => 'Results',
	"alignment" => 'Sequence',
	"control_options" => 'Paragraph',
	"model" => 'Excl',
	"constant_rate" => 'Switch',
	"change_rate" => 'Excl',
	"change_rate_value" => 'Integer',
	"absolute_rate" => 'Float',
	"absolute_rate_value" => 'Integer',
	"likelihood_root" => 'Switch',
	"absolute_root_value" => 'Integer',
	"absolute_rate" => 'Float',
	"estimate_root" => 'Switch',
	"outgroup" => 'Integer',
	"substitution_confidence" => 'Switch',
	"date_confidence" => 'Switch',
	"change_confidence" => 'Switch',
	"limit" => 'Float',
	"codon_categories" => 'String',
	"codon_rate" => 'String',
	"seperate" => 'Switch',
	"gamma" => 'Integer',
	"alpha" => 'Integer',
	"datasets" => 'Integer',
	"user_branch" => 'Switch',
	"treefile" => 'InFile',
	"equal_freq" => 'Switch',
	"freq_bases" => 'String',
	"transition_transversion" => 'Float',
	"output_options" => 'Paragraph',
	"branch" => 'Switch',
	"likelihoods" => 'Switch',
	"notrees" => 'Switch',
	"memory" => 'Switch',
	"progress" => 'Switch',

    };

    $self->{FORMAT}  = {
	"outtree" => {
	},
	"alignment" => {
		"perl" => '"  < $value"',
	},
	"control_options" => {
	},
	"model" => {
		"perl" => '($value && $value ne $vdef)? " -m$value" : ""',
	},
	"constant_rate" => {
		"perl" => '($value) ? " -k" : ""',
	},
	"change_rate" => {
		"perl" => '($value ne "-w") ? " $value" : ""',
	},
	"change_rate_value" => {
		"perl" => '" -k $value"',
	},
	"absolute_rate" => {
		"perl" => '(defined $value)? " -s$value" : ""',
	},
	"absolute_rate_value" => {
		"perl" => '($value) ? " -s $value" : ""',
	},
	"likelihood_root" => {
		"perl" => '($value) ? " +r" : ""',
	},
	"absolute_root_value" => {
		"perl" => '($value) ? " -r $value" : ""',
	},
	"absolute_rate" => {
		"perl" => '(defined $value)? " -s$value" : ""',
	},
	"estimate_root" => {
		"perl" => '($value)? " +r" : ""',
	},
	"outgroup" => {
		"perl" => '(defined $value)? " -r $value" : ""',
	},
	"substitution_confidence" => {
		"perl" => '($value)? " -is" : ""',
	},
	"date_confidence" => {
		"perl" => '($value)? " -id" : ""',
	},
	"change_confidence" => {
		"perl" => '($value)? " -iw" : ""',
	},
	"limit" => {
		"perl" => '(defined $value && $value != $vdef)? " -l $value" : ""',
	},
	"codon_categories" => {
		"perl" => '($value)? " -p $value" : ""',
	},
	"codon_rate" => {
		"perl" => '($value)? " -c$value" : ""',
	},
	"seperate" => {
		"perl" => '($value)? " -e" : ""',
	},
	"gamma" => {
		"perl" => '(defined $value)? " -g $value" : ""',
	},
	"alpha" => {
		"perl" => '(defined $value)? " -a $value" : ""',
	},
	"datasets" => {
		"perl" => '(defined $value && $value != $vdef)? " -n $value" : ""',
	},
	"user_branch" => {
		"perl" => '($ value) ? " -ul" : "" ',
	},
	"treefile" => {
		"perl" => ' ($value)? " $value":""',
	},
	"equal_freq" => {
		"perl" => '($value)? " -f=" : ""',
	},
	"freq_bases" => {
		"perl" => '($value)? " -f$value" : ""',
	},
	"transition_transversion" => {
		"perl" => '(defined $value && $value != $vdef)? " -t$value" : ""',
	},
	"output_options" => {
	},
	"branch" => {
		"perl" => '($value)? " -vb" : ""',
	},
	"likelihoods" => {
		"perl" => '($value)? " -vs" : ""',
	},
	"notrees" => {
		"perl" => '($value)? " -vw" : ""',
	},
	"memory" => {
		"perl" => '($value)? " -vm" : ""',
	},
	"progress" => {
		"perl" => '" -vp"',
	},
	"tipdate" => {
		"perl" => '"tipdate"',
	}

    };

    $self->{FILENAMES}  = {
	"outtree" => 'tipdate.out',

    };

    $self->{SEQFMT}  = {
	"alignment" => [11],

    };

    $self->{GROUP}  = {
	"alignment" => 10,
	"control_options" => 2,
	"model" => 2,
	"constant_rate" => 2,
	"change_rate" => 2,
	"change_rate_value" => 2,
	"absolute_rate" => 2,
	"absolute_rate_value" => 2,
	"likelihood_root" => 2,
	"absolute_root_value" => 2,
	"absolute_rate" => 2,
	"estimate_root" => 2,
	"outgroup" => 2,
	"substitution_confidence" => 2,
	"date_confidence" => 2,
	"change_confidence" => 2,
	"limit" => 2,
	"codon_categories" => 2,
	"codon_rate" => 2,
	"seperate" => 2,
	"gamma" => 2,
	"alpha" => 2,
	"datasets" => 2,
	"user_branch" => 2,
	"treefile" => 5,
	"equal_freq" => 2,
	"freq_bases" => 2,
	"transition_transversion" => 2,
	"output_options" => 3,
	"branch" => 3,
	"likelihoods" => 3,
	"notrees" => 3,
	"memory" => 3,
	"progress" => 3,
	"tipdate" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"outtree",
	"tipdate",
	"control_options",
	"model",
	"constant_rate",
	"change_rate",
	"change_rate_value",
	"absolute_rate",
	"absolute_rate_value",
	"likelihood_root",
	"absolute_root_value",
	"absolute_rate",
	"estimate_root",
	"outgroup",
	"substitution_confidence",
	"date_confidence",
	"change_confidence",
	"limit",
	"codon_categories",
	"codon_rate",
	"seperate",
	"gamma",
	"alpha",
	"datasets",
	"user_branch",
	"equal_freq",
	"freq_bases",
	"transition_transversion",
	"progress",
	"output_options",
	"branch",
	"likelihoods",
	"notrees",
	"memory",
	"treefile",
	"alignment",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"outtree" => 0,
	"alignment" => 0,
	"control_options" => 0,
	"model" => 0,
	"constant_rate" => 0,
	"change_rate" => 0,
	"change_rate_value" => 0,
	"absolute_rate" => 0,
	"absolute_rate_value" => 0,
	"likelihood_root" => 0,
	"absolute_root_value" => 0,
	"absolute_rate" => 0,
	"estimate_root" => 0,
	"outgroup" => 0,
	"substitution_confidence" => 0,
	"date_confidence" => 0,
	"change_confidence" => 0,
	"limit" => 0,
	"codon_categories" => 0,
	"codon_rate" => 0,
	"seperate" => 0,
	"gamma" => 0,
	"alpha" => 0,
	"datasets" => 0,
	"user_branch" => 0,
	"treefile" => 0,
	"equal_freq" => 0,
	"freq_bases" => 0,
	"transition_transversion" => 0,
	"output_options" => 0,
	"branch" => 0,
	"likelihoods" => 0,
	"notrees" => 0,
	"memory" => 0,
	"progress" => 1,
	"tipdate" => 1

    };

    $self->{ISCOMMAND}  = {
	"outtree" => 0,
	"alignment" => 0,
	"control_options" => 0,
	"model" => 0,
	"constant_rate" => 0,
	"change_rate" => 0,
	"change_rate_value" => 0,
	"absolute_rate" => 0,
	"absolute_rate_value" => 0,
	"likelihood_root" => 0,
	"absolute_root_value" => 0,
	"absolute_rate" => 0,
	"estimate_root" => 0,
	"outgroup" => 0,
	"substitution_confidence" => 0,
	"date_confidence" => 0,
	"change_confidence" => 0,
	"limit" => 0,
	"codon_categories" => 0,
	"codon_rate" => 0,
	"seperate" => 0,
	"gamma" => 0,
	"alpha" => 0,
	"datasets" => 0,
	"user_branch" => 0,
	"treefile" => 0,
	"equal_freq" => 0,
	"freq_bases" => 0,
	"transition_transversion" => 0,
	"output_options" => 0,
	"branch" => 0,
	"likelihoods" => 0,
	"notrees" => 0,
	"memory" => 0,
	"progress" => 0,

    };

    $self->{ISMANDATORY}  = {
	"outtree" => 0,
	"alignment" => 1,
	"control_options" => 0,
	"model" => 0,
	"constant_rate" => 0,
	"change_rate" => 0,
	"change_rate_value" => 1,
	"absolute_rate" => 0,
	"absolute_rate_value" => 0,
	"likelihood_root" => 0,
	"absolute_root_value" => 0,
	"absolute_rate" => 0,
	"estimate_root" => 0,
	"outgroup" => 0,
	"substitution_confidence" => 0,
	"date_confidence" => 0,
	"change_confidence" => 0,
	"limit" => 0,
	"codon_categories" => 0,
	"codon_rate" => 0,
	"seperate" => 0,
	"gamma" => 0,
	"alpha" => 0,
	"datasets" => 0,
	"user_branch" => 0,
	"treefile" => 0,
	"equal_freq" => 0,
	"freq_bases" => 0,
	"transition_transversion" => 0,
	"output_options" => 0,
	"branch" => 0,
	"likelihoods" => 0,
	"notrees" => 0,
	"memory" => 0,
	"progress" => 0,

    };

    $self->{PROMPT}  = {
	"outtree" => "",
	"alignment" => "Alignment file",
	"control_options" => "Control options",
	"model" => "MODEL (-m)",
	"constant_rate" => "Molecular clock model (SR model) (-k)",
	"change_rate" => "Estimate rate of change of rate (VRDT model: requires dated tips)",
	"change_rate_value" => "You may provide a constant rate value (-w #)",
	"absolute_rate" => "Estimate absolute rate of substitution (SRDT model: requires dated tips) (+s)Absolute rate of molecular evolution (requires dated tips) (-s)",
	"absolute_rate_value" => "specify absolute rate of substitution (-s #)",
	"likelihood_root" => "Estimate maximum likelihood root (requires molecular clock)",
	"absolute_root_value" => "root with specified outgroup taxa (requires molecular clock) (-r #)",
	"absolute_rate" => "Estimate absolute rate of substitution (SRDT model: requires dated tips) (+s)Absolute rate of molecular evolution (requires dated tips) (-s)",
	"estimate_root" => "Estimate maximum likelihood root (requires molecular clock) (+r)",
	"outgroup" => "Root with specified outgroup taxa (requires molecular clock) (-r)",
	"substitution_confidence" => "Estimate confidence intervals for rate of substitution (with +s option) (-is)",
	"date_confidence" => "Estimate confidence intervals for date of root of tree (with +s option) (-id)",
	"change_confidence" => "Estimate confidence intervals for rate of change of rate of substitution (with +w option) (-iw)",
	"limit" => "Limit to use estimating confidence intervals (-l)",
	"codon_categories" => "CODON CATEGORIES = 112, 123, 120, etc. [default: homogeneity] (-p)",
	"codon_rate" => "CODON category rates: #1 #2 #3 separated by commas [default = estimate rates] (-c)",
	"seperate" => "Estimate seperate models for each site category (-e)",
	"gamma" => "Num categories for gamma rate heterogeneity (2 to 32) (-g)",
	"alpha" => "gamma shape (alpha) for site rate heterogeneity (-a)",
	"datasets" => "Number of Datasets (-n)",
	"user_branch" => "User branch-lengths [default = estimate] (-ul)",
	"treefile" => "Optional file containing trees",
	"equal_freq" => "Frequences of bases equal (-f=)",
	"freq_bases" => "Frequences of bases: #A #C #G #T separated by commas(-f)",
	"transition_transversion" => "Transition/transversion ratio (-t)",
	"output_options" => "Output options",
	"branch" => "Print final branch lengths (-vb)",
	"likelihoods" => "Write likelihoods for each Site (-vs)",
	"notrees" => "Don't Write trees (-vw)",
	"memory" => "Memory usage information (-vm)",
	"progress" => "",

    };

    $self->{ISSTANDOUT}  = {
	"outtree" => 0,
	"alignment" => 0,
	"control_options" => 0,
	"model" => 0,
	"constant_rate" => 0,
	"change_rate" => 0,
	"change_rate_value" => 0,
	"absolute_rate" => 0,
	"absolute_rate_value" => 0,
	"likelihood_root" => 0,
	"absolute_root_value" => 0,
	"absolute_rate" => 0,
	"estimate_root" => 0,
	"outgroup" => 0,
	"substitution_confidence" => 0,
	"date_confidence" => 0,
	"change_confidence" => 0,
	"limit" => 0,
	"codon_categories" => 0,
	"codon_rate" => 0,
	"seperate" => 0,
	"gamma" => 0,
	"alpha" => 0,
	"datasets" => 0,
	"user_branch" => 0,
	"treefile" => 0,
	"equal_freq" => 0,
	"freq_bases" => 0,
	"transition_transversion" => 0,
	"output_options" => 0,
	"branch" => 0,
	"likelihoods" => 0,
	"notrees" => 0,
	"memory" => 0,
	"progress" => 0,

    };

    $self->{VLIST}  = {

	"control_options" => ['model','constant_rate','change_rate','change_rate_value','absolute_rate','absolute_rate_value','likelihood_root','absolute_root_value','absolute_rate','estimate_root','outgroup','substitution_confidence','date_confidence','change_confidence','limit','codon_categories','codon_rate','seperate','gamma','alpha','datasets','user_branch','treefile','equal_freq','freq_bases','transition_transversion',],
	"model" => ['F84','F84','HKY','HKY','REV','REV',],
	"change_rate" => ['+w','VRDT model: requires dated tips (+w)','+w+','Constrain to be +ve only (+w+)','+w-','Constrain to be -ve only (+w-)','-w','specify rate of change of rate (-w)',],
	"output_options" => ['branch','likelihoods','notrees','memory','progress',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"model" => 'F84',
	"limit" => '1.92',
	"datasets" => '1',
	"transition_transversion" => '2.0',

    };

    $self->{PRECOND}  = {
	"outtree" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"model" => { "perl" => '1' },
	"constant_rate" => { "perl" => '1' },
	"change_rate" => { "perl" => '1' },
	"change_rate_value" => {
		"perl" => '($change_rate eq "-w")',
	},
	"absolute_rate" => {
		"perl" => '! $absolute',
	},
	"absolute_rate_value" => {
		"perl" => '(! $absolute_rate)',
	},
	"likelihood_root" => { "perl" => '1' },
	"absolute_root_value" => {
		"perl" => '(! $likelihood_root)',
	},
	"absolute_rate" => {
		"perl" => '! $absolute',
	},
	"estimate_root" => {
		"perl" => '$constant_rate',
	},
	"outgroup" => {
		"perl" => '(! $estimate_root) && $constant_rate',
	},
	"substitution_confidence" => { "perl" => '1' },
	"date_confidence" => { "perl" => '1' },
	"change_confidence" => { "perl" => '1' },
	"limit" => { "perl" => '1' },
	"codon_categories" => { "perl" => '1' },
	"codon_rate" => { "perl" => '1' },
	"seperate" => { "perl" => '1' },
	"gamma" => { "perl" => '1' },
	"alpha" => {
		"perl" => '$gamma',
	},
	"datasets" => { "perl" => '1' },
	"user_branch" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },
	"equal_freq" => { "perl" => '1' },
	"freq_bases" => {
		"perl" => '! $equal_freq',
	},
	"transition_transversion" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"branch" => { "perl" => '1' },
	"likelihoods" => { "perl" => '1' },
	"notrees" => { "perl" => '1' },
	"memory" => { "perl" => '1' },
	"progress" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outtree" => {
		 '! $notrees' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"alignment" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"outtree" => 0,
	"alignment" => 0,
	"control_options" => 0,
	"model" => 0,
	"constant_rate" => 0,
	"change_rate" => 0,
	"change_rate_value" => 0,
	"absolute_rate" => 0,
	"absolute_rate_value" => 0,
	"likelihood_root" => 0,
	"absolute_root_value" => 0,
	"absolute_rate" => 0,
	"estimate_root" => 0,
	"outgroup" => 0,
	"substitution_confidence" => 0,
	"date_confidence" => 0,
	"change_confidence" => 0,
	"limit" => 0,
	"codon_categories" => 0,
	"codon_rate" => 0,
	"seperate" => 0,
	"gamma" => 0,
	"alpha" => 0,
	"datasets" => 0,
	"user_branch" => 0,
	"treefile" => 0,
	"equal_freq" => 0,
	"freq_bases" => 0,
	"transition_transversion" => 0,
	"output_options" => 0,
	"branch" => 0,
	"likelihoods" => 0,
	"notrees" => 0,
	"memory" => 0,
	"progress" => 0,

    };

    $self->{ISSIMPLE}  = {
	"outtree" => 0,
	"alignment" => 1,
	"control_options" => 0,
	"model" => 0,
	"constant_rate" => 0,
	"change_rate" => 0,
	"change_rate_value" => 0,
	"absolute_rate" => 0,
	"absolute_rate_value" => 0,
	"likelihood_root" => 0,
	"absolute_root_value" => 0,
	"absolute_rate" => 0,
	"estimate_root" => 0,
	"outgroup" => 0,
	"substitution_confidence" => 0,
	"date_confidence" => 0,
	"change_confidence" => 0,
	"limit" => 0,
	"codon_categories" => 0,
	"codon_rate" => 0,
	"seperate" => 0,
	"gamma" => 0,
	"alpha" => 0,
	"datasets" => 0,
	"user_branch" => 0,
	"treefile" => 0,
	"equal_freq" => 0,
	"freq_bases" => 0,
	"transition_transversion" => 0,
	"output_options" => 0,
	"branch" => 0,
	"likelihoods" => 0,
	"notrees" => 0,
	"memory" => 0,
	"progress" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"gamma" => [
		"Enter an integer between 2 and 32 that specifies the number of categories to use with the discrete gamma rate heterogeneity model.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/tipdate.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

