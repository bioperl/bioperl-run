# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmpfam
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmpfam

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmpfam

      Bioperl class for:

	HMMER	hmmpfam - search sequences against an HMM database (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmpfam.html 
         for available values):


		hmmpfam (String)

		toto (String)

		seqfile (Sequence)
			Sequence file
			pipe: seqfile

		HMMDB (Excl)
			HMM database

		nucleic_acid (Switch)
			Force nucleic acid models and sequences (-n)

		n_best (Integer)
			number of reported alignments (-A n)

		E_value_cutoff (Float)
			E_value cutoff (-E x)

		Bit_cutoff (Float)
			Bit score cutoff (-T x)

		E_value_calculation (Integer)
			Control of E_value calculation (-Z n)

		acc (Switch)
			Report accessions instead of names in the output reports (--acc)

		compat (Switch)
			Use the output format of HMMER 2.1.1 (--compat)

		domE (Float)
			E-value cutoff for the per-domain ranked hit list (--domE x)

		domT (Float)
			bit score cutoff for the per-domain ranked hit list (--domT x)

		forward (Switch)
			forward algorithm (--forward)

		null2 (Switch)
			turns off the second post processing step (--null2)

		xnu (Switch)
			turns on XNU filtering (--xnu)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmpfam.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmpfam;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmpfam = Bio::Tools::Run::PiseApplication::hmmpfam->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmpfam object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmpfam = $factory->program('hmmpfam');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmpfam.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmpfam.pm

    $self->{COMMAND}   = "hmmpfam";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmpfam - search sequences against an HMM database";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmpfam",
	"description",
	"seqfile",
	"HMMDB",
	"nucleic_acid",
	"n_best",
	"E_value_cutoff",
	"Bit_cutoff",
	"E_value_calculation",
	"expert_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmpfam",
	"description", 	# Description of hmmpfam
	"toto",
	"seqfile", 	# Sequence file
	"HMMDB", 	# HMM database
	"nucleic_acid", 	# Force nucleic acid models and sequences (-n)
	"n_best", 	# number of reported alignments (-A n)
	"E_value_cutoff", 	# E_value cutoff (-E x)
	"Bit_cutoff", 	# Bit score cutoff (-T x)
	"E_value_calculation", 	# Control of E_value calculation (-Z n)
	"expert_options", 	# Expert Options
	"acc", 	# Report accessions instead of names in the output reports (--acc)
	"compat", 	# Use the output format of HMMER 2.1.1 (--compat)
	"domE", 	# E-value cutoff for the per-domain ranked hit list (--domE x)
	"domT", 	# bit score cutoff for the per-domain ranked hit list (--domT x)
	"forward", 	# forward algorithm (--forward)
	"null2", 	# turns off the second post processing step (--null2)
	"xnu", 	# turns on XNU filtering (--xnu)

    ];

    $self->{TYPE}  = {
	"hmmpfam" => 'String',
	"description" => 'Paragraph',
	"toto" => 'String',
	"seqfile" => 'Sequence',
	"HMMDB" => 'Excl',
	"nucleic_acid" => 'Switch',
	"n_best" => 'Integer',
	"E_value_cutoff" => 'Float',
	"Bit_cutoff" => 'Float',
	"E_value_calculation" => 'Integer',
	"expert_options" => 'Paragraph',
	"acc" => 'Switch',
	"compat" => 'Switch',
	"domE" => 'Float',
	"domT" => 'Float',
	"forward" => 'Switch',
	"null2" => 'Switch',
	"xnu" => 'Switch',

    };

    $self->{FORMAT}  = {
	"hmmpfam" => {
		"perl" => '"hmmpfam"',
	},
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"seqfile" => {
		"perl" => '" $value"',
	},
	"HMMDB" => {
		"perl" => '" $value"',
	},
	"nucleic_acid" => {
		"perl" => '($value) ? " -n" : ""',
	},
	"n_best" => {
		"perl" => '($value) ? " -A $value" : ""',
	},
	"E_value_cutoff" => {
		"perl" => '(defined $value && $value != $vdef) ? " -E $value" : ""',
	},
	"Bit_cutoff" => {
		"perl" => '($value) ? " -T $value" : ""',
	},
	"E_value_calculation" => {
		"perl" => '($value) ? " -Z $value" : ""',
	},
	"expert_options" => {
	},
	"acc" => {
		"perl" => '($value) ? " --acc" : ""',
	},
	"compat" => {
		"perl" => '($value) ? " --compat" : ""',
	},
	"domE" => {
		"perl" => '($value) ? " --domE $value" : ""',
	},
	"domT" => {
		"perl" => '($value) ? " --domT $value" : ""',
	},
	"forward" => {
		"perl" => '($value) ? " --forward" : ""',
	},
	"null2" => {
		"perl" => '($value)? " --null2" : ""',
	},
	"xnu" => {
		"perl" => '($value) ? " --xnu" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqfile" => [8],

    };

    $self->{GROUP}  = {
	"hmmpfam" => 0,
	"toto" => 1000,
	"seqfile" => 3,
	"HMMDB" => 2,
	"nucleic_acid" => 1,
	"n_best" => 1,
	"E_value_cutoff" => 1,
	"Bit_cutoff" => 1,
	"E_value_calculation" => 1,
	"compat" => 1,
	"domE" => 1,
	"domT" => 1,
	"forward" => 1,
	"null2" => 1,
	"xnu" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"hmmpfam",
	"description",
	"expert_options",
	"acc",
	"xnu",
	"nucleic_acid",
	"n_best",
	"E_value_cutoff",
	"Bit_cutoff",
	"E_value_calculation",
	"compat",
	"domE",
	"domT",
	"forward",
	"null2",
	"HMMDB",
	"seqfile",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmpfam" => 1,
	"description" => 0,
	"toto" => 1,
	"seqfile" => 0,
	"HMMDB" => 0,
	"nucleic_acid" => 0,
	"n_best" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"acc" => 0,
	"compat" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmpfam" => 1,
	"description" => 0,
	"toto" => 0,
	"seqfile" => 0,
	"HMMDB" => 0,
	"nucleic_acid" => 0,
	"n_best" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"acc" => 0,
	"compat" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmpfam" => 0,
	"description" => 0,
	"toto" => 0,
	"seqfile" => 1,
	"HMMDB" => 1,
	"nucleic_acid" => 0,
	"n_best" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"acc" => 0,
	"compat" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{PROMPT}  = {
	"hmmpfam" => "",
	"description" => "Description of hmmpfam",
	"toto" => "",
	"seqfile" => "Sequence file",
	"HMMDB" => "HMM database",
	"nucleic_acid" => "Force nucleic acid models and sequences (-n)",
	"n_best" => "number of reported alignments (-A n)",
	"E_value_cutoff" => "E_value cutoff (-E x)",
	"Bit_cutoff" => "Bit score cutoff (-T x)",
	"E_value_calculation" => "Control of E_value calculation (-Z n)",
	"expert_options" => "Expert Options",
	"acc" => "Report accessions instead of names in the output reports (--acc)",
	"compat" => "Use the output format of HMMER 2.1.1 (--compat)",
	"domE" => "E-value cutoff for the per-domain ranked hit list (--domE x)",
	"domT" => "bit score cutoff for the per-domain ranked hit list (--domT x)",
	"forward" => "forward algorithm (--forward)",
	"null2" => "turns off the second post processing step (--null2)",
	"xnu" => "turns on XNU filtering (--xnu)",

    };

    $self->{ISSTANDOUT}  = {
	"hmmpfam" => 0,
	"description" => 0,
	"toto" => 0,
	"seqfile" => 0,
	"HMMDB" => 0,
	"nucleic_acid" => 0,
	"n_best" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"acc" => 0,
	"compat" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
	"HMMDB" => ['Pfam','Pfam','PfamFrag','PfamFrag',],
	"expert_options" => ['acc','compat','domE','domT','forward','null2','xnu',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"HMMDB" => 'Pfam',
	"E_value_cutoff" => '10.0',

    };

    $self->{PRECOND}  = {
	"hmmpfam" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"HMMDB" => { "perl" => '1' },
	"nucleic_acid" => { "perl" => '1' },
	"n_best" => { "perl" => '1' },
	"E_value_cutoff" => { "perl" => '1' },
	"Bit_cutoff" => { "perl" => '1' },
	"E_value_calculation" => { "perl" => '1' },
	"expert_options" => { "perl" => '1' },
	"acc" => { "perl" => '1' },
	"compat" => { "perl" => '1' },
	"domE" => { "perl" => '1' },
	"domT" => { "perl" => '1' },
	"forward" => { "perl" => '1' },
	"null2" => { "perl" => '1' },
	"xnu" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqfile" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmpfam" => 0,
	"description" => 0,
	"toto" => 0,
	"seqfile" => 0,
	"HMMDB" => 0,
	"nucleic_acid" => 0,
	"n_best" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"acc" => 0,
	"compat" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmpfam" => 0,
	"description" => 0,
	"toto" => 0,
	"seqfile" => 0,
	"HMMDB" => 0,
	"nucleic_acid" => 0,
	"n_best" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"acc" => 0,
	"compat" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmpfam reads a single sequence from seqfile and compares it against all the HMMs in hmmfile looking for significantly similar sequence matches.",
		"The output consists of three sections: a ranked list of the best scoring HMMs, a list of the best scoring domains in order of their occurrence in the sequence, and alignments for all the best scoring domains. A sequence score may be higher than a domain score for the same sequence if there is more than one domain in the sequence; the sequence score takes into account all the domains. All sequences scoring above the -E and -T cutoffs are shown in the first list, then every domain found in this list is shown in the second list of domain hits. If desired, E-value and score thresholds may also be applied to the domain list using the --domE and --domT options.",
	],
	"n_best" => [
		"Limits the alignment output to the n best scoring domains. -A0 shuts off the alignment output and can be used to reduce the size of output files.",
	],
	"E_value_cutoff" => [
		"Set the E-value cutoff for the per-sequence ranked hit list to x, where x is a positive real number. The default is 10.0. Hits with E-values better than (less than) this threshold will be shown.",
	],
	"Bit_cutoff" => [
		"Set the bit score cutoff for the per-sequence ranked hit list to x, where x is a real number. The default is negative infinity; by default, the threshold is controlled by E-value and not by bit score. Hits with bit scores better than (greater than) this threshold will be shown.",
	],
	"E_value_calculation" => [
		"Calculate the E-value scores as if we had seen a sequence database of n sequences. The default is arbitrarily set to 59021, the size of Swissprot 34.",
	],
	"domE" => [
		"Set the E-value cutoff for the per-domain ranked hit list to x, where x is a positive real number. The default is infinity; by default, all domains in the sequences that passed the first threshold will be reported in the second list, so that the number of domains reported in the per-sequence list is consistent with the number that appear in the per-domain list.",
	],
	"domT" => [
		"Set the bit score cutoff for the per-domain ranked hit list to x, where x is a real number. The default is negative infinity; by default, all domains in the sequences that passed the first threshold will be reported in the second list, so that the number of domains reported in the per-sequence list is consistent with the number that appear in the per-domain list. Important note: only one domain in a sequence is absolutely controlled by this parameter, or by --domT. The second and subsequent domains in a sequence have a de facto bit score threshold of 0 because of the details of how HMMER works. HMMER requires at east one pass through the main model per sequence; to do more than one pass (more than one domain) the multidomain alignment must have a better score than the single domain alignment, and hence the extra domains must contribute positive score. See the Users\' Guide for more detail. ",
	],
	"forward" => [
		"Use the Forward algorithm instead of the Viterbi algorithm to determine the per-sequence scores. Per-domain scores are still determined by the Viterbi algorithm. Some have argued that Forward is a more sensitive algorithm for detecting remote sequence homologues; my experiments with HMMER have not confirmed this, however.",
	],
	"null2" => [
		"Turn off the post hoc second null model. By default, each alignment is rescored by a postprocessing step that takes into account possible biased composition in either the HMM or the target sequence. This is almost essential in database searches, especially with local alignment models. There is a very small chance that this postprocessing might remove real matches, and in these cases --null2 may improve sensitivity at the expense of reducing specificity by letting biased composition hits through.",
	],
	"xnu" => [
		"Turn on XNU filtering of target protein sequences. Has no effect on nucleic acid sequences. In trial experiments, --xnu appears to perform less well than the default post hoc null2 model.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmpfam.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

