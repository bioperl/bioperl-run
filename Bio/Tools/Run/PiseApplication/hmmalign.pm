# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmalign
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmalign

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmalign

      Bioperl class for:

	HMMER	hmmalign - align sequences to an HMM profile (S .Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmalign.html 
         for available values):


		hmmalign (String)

		seqfile (Sequence)
			Sequences File
			pipe: seqsfile

		hmmfile (InFile)
			HMM file
			pipe: hmmer_HMM

		output_format (Switch)
			Additional output in GCG MSF format (default is SELEX format)

		match_states (Switch)
			Include in the alignment only those symbols aligned to match states. Do not show symbols assigned to insert states. (-m)

		mapali (String)
			(--mapali f)

		withali (String)
			(--withali f)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmalign.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmalign = Bio::Tools::Run::PiseApplication::hmmalign->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmalign object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmalign = $factory->program('hmmalign');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmalign.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmalign.pm

    $self->{COMMAND}   = "hmmalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmalign - align sequences to an HMM profile";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S .Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmalign",
	"seqfile",
	"hmmfile",
	"align_file",
	"output_format",
	"msf_align_file",
	"match_states",
	"expert_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmalign",
	"seqfile", 	# Sequences File
	"hmmfile", 	# HMM file
	"align_file",
	"output_format", 	# Additional output in GCG MSF format (default is SELEX format)
	"msf_align_file",
	"match_states", 	# Include in the alignment only those symbols aligned to match states. Do not show symbols assigned to insert states. (-m)
	"expert_options", 	# Expert Options
	"mapali", 	# (--mapali f)
	"withali", 	# (--withali f)

    ];

    $self->{TYPE}  = {
	"hmmalign" => 'String',
	"seqfile" => 'Sequence',
	"hmmfile" => 'InFile',
	"align_file" => 'Results',
	"output_format" => 'Switch',
	"msf_align_file" => 'Results',
	"match_states" => 'Switch',
	"expert_options" => 'Paragraph',
	"mapali" => 'String',
	"withali" => 'String',

    };

    $self->{FORMAT}  = {
	"hmmalign" => {
		"perl" => '"hmmalign"',
	},
	"seqfile" => {
		"perl" => '" $seqfile" ',
	},
	"hmmfile" => {
		"perl" => '" $value"',
	},
	"align_file" => {
		"perl" => '" -o selex_alignment"',
	},
	"output_format" => {
		"perl" => '""',
	},
	"msf_align_file" => {
		"perl" => '"; sreformat msf selex_alignment > msf_alignment"',
	},
	"match_states" => {
		"perl" => '($value) ? " -m" : ""',
	},
	"expert_options" => {
	},
	"mapali" => {
		"perl" => '($value) ? " --mapali $value" : ""',
	},
	"withali" => {
		"perl" => '($value) ? " --withali $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"align_file" => '"selex_alignment"',
	"msf_align_file" => '"msf_alignment"',

    };

    $self->{SEQFMT}  = {
	"seqfile" => [8,11,12,15],

    };

    $self->{GROUP}  = {
	"hmmalign" => 0,
	"seqfile" => 3,
	"hmmfile" => 2,
	"align_file" => 1,
	"output_format" => 100,
	"msf_align_file" => 100,
	"match_states" => 1,
	"expert_options" => 1,
	"mapali" => 1,
	"withali" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"hmmalign",
	"withali",
	"match_states",
	"align_file",
	"expert_options",
	"mapali",
	"hmmfile",
	"seqfile",
	"output_format",
	"msf_align_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmalign" => 1,
	"seqfile" => 0,
	"hmmfile" => 0,
	"align_file" => 1,
	"output_format" => 0,
	"msf_align_file" => 1,
	"match_states" => 0,
	"expert_options" => 0,
	"mapali" => 0,
	"withali" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmalign" => 1,
	"seqfile" => 0,
	"hmmfile" => 0,
	"align_file" => 0,
	"output_format" => 0,
	"msf_align_file" => 0,
	"match_states" => 0,
	"expert_options" => 0,
	"mapali" => 0,
	"withali" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmalign" => 0,
	"seqfile" => 1,
	"hmmfile" => 1,
	"align_file" => 0,
	"output_format" => 0,
	"msf_align_file" => 0,
	"match_states" => 0,
	"expert_options" => 0,
	"mapali" => 0,
	"withali" => 0,

    };

    $self->{PROMPT}  = {
	"hmmalign" => "",
	"seqfile" => "Sequences File",
	"hmmfile" => "HMM file",
	"align_file" => "",
	"output_format" => "Additional output in GCG MSF format (default is SELEX format)",
	"msf_align_file" => "",
	"match_states" => "Include in the alignment only those symbols aligned to match states. Do not show symbols assigned to insert states. (-m)",
	"expert_options" => "Expert Options",
	"mapali" => "(--mapali f)",
	"withali" => "(--withali f)",

    };

    $self->{ISSTANDOUT}  = {
	"hmmalign" => 0,
	"seqfile" => 0,
	"hmmfile" => 0,
	"align_file" => 0,
	"output_format" => 0,
	"msf_align_file" => 0,
	"match_states" => 0,
	"expert_options" => 0,
	"mapali" => 0,
	"withali" => 0,

    };

    $self->{VLIST}  = {

	"expert_options" => ['mapali','withali',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"hmmalign" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"align_file" => { "perl" => '1' },
	"output_format" => { "perl" => '1' },
	"msf_align_file" => {
		"perl" => '$output_format',
	},
	"match_states" => { "perl" => '1' },
	"expert_options" => { "perl" => '1' },
	"mapali" => { "perl" => '1' },
	"withali" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"align_file" => {
		 '1' => "hmmer_alig",
	},
	"msf_align_file" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqfile" => {
		 "seqsfile" => '1',
	},
	"hmmfile" => {
		 "hmmer_HMM" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmalign" => 0,
	"seqfile" => 0,
	"hmmfile" => 0,
	"align_file" => 0,
	"output_format" => 0,
	"msf_align_file" => 0,
	"match_states" => 0,
	"expert_options" => 0,
	"mapali" => 0,
	"withali" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmalign" => 0,
	"seqfile" => 0,
	"hmmfile" => 0,
	"align_file" => 0,
	"output_format" => 0,
	"msf_align_file" => 0,
	"match_states" => 0,
	"expert_options" => 0,
	"mapali" => 0,
	"withali" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"mapali" => [
		"Reads an alignment from file f and aligns it as a single object to the HMM; e.g. the alignment in f is held fixed. This allows you to align sequences to a model with hmmalign and view them in the context of an existing trusted multiple alignment. The alignment to the alignment is defined by a \'map\' kept in the HMM, and so is fast and guaranteed to be consistent with the way the HMM was constructed from the alignment. The alignment in the file f must be exactly the alignment that the HMM was built from. Compare the --withali option.",
	],
	"withali" => [
		"Reads an alignment from file f and aligns it as a single object to the HMM; e.g. the alignment in f is held fixed. This allows you to align sequences to a model with hmmalign and view them in the context of an existing trusted multiple alignment. The alignment to the alignment is done with a heuristic (nonoptimal) dynamic programming procedure, which may be somewhat slow and is not guaranteed to be completely consistent with the way the HMM was constructed (though it should be quite close). However, any alignment can be used, not just the alignment that the HMM was built from. Compare the --mapali option.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

