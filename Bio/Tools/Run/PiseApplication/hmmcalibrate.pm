# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmcalibrate
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmcalibrate

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmcalibrate

      Bioperl class for:

	HMMER	hmmcalibrate - calibrate HMM search statistics (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmcalibrate.html 
         for available values):


		hmmcalibrate (String)

		toto (String)

		hmmfile (InFile)
			HMM file
			pipe: hmmer_HMM

		fixed (Integer)
			Fix the length of the random sequences to n (--fixed n)

		histfile (OutFile)
			histogram of the scores(--histfile f)

		mean (Float)
			mean length (--mean x)

		num (Float)
			number of synthetic sequences(--num n)

		sd (Float)
			standard deviation (--sd x)

		seed (Integer)
			random seed (--seed n)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmcalibrate.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmcalibrate;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmcalibrate = Bio::Tools::Run::PiseApplication::hmmcalibrate->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmcalibrate object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmcalibrate = $factory->program('hmmcalibrate');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmcalibrate.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmcalibrate.pm

    $self->{COMMAND}   = "hmmcalibrate";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmcalibrate - calibrate HMM search statistics";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmcalibrate",
	"description",
	"hmmfile",
	"new_hmmfile",
	"expert_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmcalibrate",
	"description", 	# description of hmmcalibrate
	"toto",
	"hmmfile", 	# HMM file
	"new_hmmfile",
	"expert_options", 	# Expert Options
	"fixed", 	# Fix the length of the random sequences to n (--fixed n)
	"histfile", 	# histogram of the scores(--histfile f)
	"mean", 	# mean length (--mean x)
	"num", 	# number of synthetic sequences(--num n)
	"sd", 	# standard deviation (--sd x)
	"seed", 	# random seed (--seed n)

    ];

    $self->{TYPE}  = {
	"hmmcalibrate" => 'String',
	"description" => 'Paragraph',
	"toto" => 'String',
	"hmmfile" => 'InFile',
	"new_hmmfile" => 'Results',
	"expert_options" => 'Paragraph',
	"fixed" => 'Integer',
	"histfile" => 'OutFile',
	"mean" => 'Float',
	"num" => 'Float',
	"sd" => 'Float',
	"seed" => 'Integer',

    };

    $self->{FORMAT}  = {
	"hmmcalibrate" => {
		"perl" => '"hmmcalibrate"',
	},
	"description" => {
		"perl" => '""',
	},
	"toto" => {
		"perl" => '""',
	},
	"hmmfile" => {
		"perl" => '" $value"',
	},
	"new_hmmfile" => {
		"perl" => '""',
	},
	"expert_options" => {
	},
	"fixed" => {
		"perl" => '($value) ? " --fixed $value" : ""',
	},
	"histfile" => {
		"perl" => '($value) ? " --histfile $value" : ""',
	},
	"mean" => {
		"perl" => '($value) ? " --mean $value" : ""',
	},
	"num" => {
		"perl" => '($value) ? " --num $value" : ""',
	},
	"sd" => {
		"perl" => '($value) ? " -sd $value" : ""',
	},
	"seed" => {
		"perl" => '($value) ? " --seed $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"new_hmmfile" => '"$hmmfile"',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"hmmcalibrate" => 0,
	"description" => -100,
	"toto" => 1000,
	"hmmfile" => 2,
	"new_hmmfile" => 10,
	"expert_options" => 1,
	"fixed" => 1,
	"histfile" => 1,
	"mean" => 1,
	"num" => 1,
	"sd" => 1,
	"seed" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"description",
	"hmmcalibrate",
	"sd",
	"seed",
	"fixed",
	"expert_options",
	"histfile",
	"mean",
	"num",
	"hmmfile",
	"new_hmmfile",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmcalibrate" => 1,
	"description" => 0,
	"toto" => 1,
	"hmmfile" => 0,
	"new_hmmfile" => 1,
	"expert_options" => 0,
	"fixed" => 0,
	"histfile" => 0,
	"mean" => 0,
	"num" => 0,
	"sd" => 0,
	"seed" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmcalibrate" => 1,
	"description" => 0,
	"toto" => 0,
	"hmmfile" => 0,
	"new_hmmfile" => 0,
	"expert_options" => 0,
	"fixed" => 0,
	"histfile" => 0,
	"mean" => 0,
	"num" => 0,
	"sd" => 0,
	"seed" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmcalibrate" => 0,
	"description" => 0,
	"toto" => 0,
	"hmmfile" => 1,
	"new_hmmfile" => 0,
	"expert_options" => 0,
	"fixed" => 0,
	"histfile" => 0,
	"mean" => 0,
	"num" => 0,
	"sd" => 0,
	"seed" => 0,

    };

    $self->{PROMPT}  = {
	"hmmcalibrate" => "",
	"description" => "description of hmmcalibrate",
	"toto" => "",
	"hmmfile" => "HMM file",
	"new_hmmfile" => "",
	"expert_options" => "Expert Options",
	"fixed" => "Fix the length of the random sequences to n (--fixed n)",
	"histfile" => "histogram of the scores(--histfile f)",
	"mean" => "mean length (--mean x)",
	"num" => "number of synthetic sequences(--num n)",
	"sd" => "standard deviation (--sd x)",
	"seed" => "random seed (--seed n)",

    };

    $self->{ISSTANDOUT}  = {
	"hmmcalibrate" => 0,
	"description" => 0,
	"toto" => 0,
	"hmmfile" => 0,
	"new_hmmfile" => 0,
	"expert_options" => 0,
	"fixed" => 0,
	"histfile" => 0,
	"mean" => 0,
	"num" => 0,
	"sd" => 0,
	"seed" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
	"expert_options" => ['fixed','histfile','mean','num','sd','seed',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"hmmcalibrate" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"new_hmmfile" => { "perl" => '1' },
	"expert_options" => { "perl" => '1' },
	"fixed" => { "perl" => '1' },
	"histfile" => { "perl" => '1' },
	"mean" => { "perl" => '1' },
	"num" => { "perl" => '1' },
	"sd" => { "perl" => '1' },
	"seed" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"new_hmmfile" => {
		 '1' => "hmmer_HMM",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"hmmfile" => {
		 "hmmer_HMM" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmcalibrate" => 0,
	"description" => 0,
	"toto" => 0,
	"hmmfile" => 0,
	"new_hmmfile" => 0,
	"expert_options" => 0,
	"fixed" => 0,
	"histfile" => 0,
	"mean" => 0,
	"num" => 0,
	"sd" => 0,
	"seed" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmcalibrate" => 0,
	"description" => 0,
	"toto" => 0,
	"hmmfile" => 0,
	"new_hmmfile" => 0,
	"expert_options" => 0,
	"fixed" => 0,
	"histfile" => 0,
	"mean" => 0,
	"num" => 0,
	"sd" => 0,
	"seed" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmcalibrate reads an HMM file from hmmfile, scores a large number of synthesized random sequences with it, fits an extreme value distribution (EVD) to the histogram of those scores, and re-saves hmmfile now including the EVD parameters. hmmcalibrate may take several minutes (or longer) to run.",
	],
	"fixed" => [
		"Fix the length of the random sequences to n, where n is a positive (and reasonably sized) integer. The default is instead to generate sequences with a variety of different lengths, controlled by a Gaussian (normal) distribution.",
	],
	"histfile" => [
		"Save a histogram of the scores and the fitted theoretical curve to file f",
	],
	"mean" => [
		"Set the mean length of the synthetic sequences to x, where x is a positive real number. The default is 350. ",
	],
	"num" => [
		"Set the number of synthetic sequences to n, where n is a positive integer. If n is less than about 1000, Higher numbers of n will give better determined EVD parameters. The default is 5000; it was empirically chosen as a tradeoff between accuracy and computation time.",
	],
	"sd" => [
		"Set the standard deviation of the synthetic sequence length distribution to x, where x is a positive real number. The default is 350. Note that the Gaussian is left-truncated so that no sequences have lengths <= 0.",
	],
	"seed" => [
		"Set the random seed to n, where n is a positive integer. The default is to use time() to generate a different seed for each run, which means that two different runs of hmmcalibrate on the same HMM will give slightly different results. You can use this option to generate reproducible results for different hmmcalibrate runs on the same HMM.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmcalibrate.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

