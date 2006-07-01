# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::equicktandem
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::equicktandem

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::equicktandem

      Bioperl class for:

	EQUICKTANDEM	Finds tandem repeats (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/equicktandem.html 
         for available values):


		equicktandem (String)

		init (String)

		sequence (Sequence)
			sequence -- dna [single sequence] (-sequence)
			pipe: seqfile

		maxrepeat (Integer)
			Maximum repeat size (-maxrepeat)

		threshold (Integer)
			Threshold score (-threshold)

		outfile (OutFile)
			outfile (-outfile)

		origfile (OutFile)
			origfile (-origfile)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/equicktandem.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::equicktandem;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $equicktandem = Bio::Tools::Run::PiseApplication::equicktandem->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::equicktandem object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $equicktandem = $factory->program('equicktandem');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::equicktandem.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/equicktandem.pm

    $self->{COMMAND}   = "equicktandem";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EQUICKTANDEM";

    $self->{DESCRIPTION}   = "Finds tandem repeats (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:repeats",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/equicktandem.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"equicktandem",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"equicktandem",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [single sequence] (-sequence)
	"required", 	# required Section
	"maxrepeat", 	# Maximum repeat size (-maxrepeat)
	"threshold", 	# Threshold score (-threshold)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"origfile", 	# origfile (-origfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"equicktandem" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"maxrepeat" => 'Integer',
	"threshold" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"origfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"maxrepeat" => {
		"perl" => '" -maxrepeat=$value"',
	},
	"threshold" => {
		"perl" => '" -threshold=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"origfile" => {
		"perl" => '($value)? " -origfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"equicktandem" => {
		"perl" => '"equicktandem"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"maxrepeat" => 2,
	"threshold" => 3,
	"outfile" => 4,
	"origfile" => 5,
	"auto" => 6,
	"equicktandem" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"equicktandem",
	"sequence",
	"maxrepeat",
	"threshold",
	"outfile",
	"origfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"origfile" => 0,
	"auto" => 1,
	"equicktandem" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"origfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"maxrepeat" => 1,
	"threshold" => 1,
	"output" => 0,
	"outfile" => 1,
	"origfile" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [single sequence] (-sequence)",
	"required" => "required Section",
	"maxrepeat" => "Maximum repeat size (-maxrepeat)",
	"threshold" => "Threshold score (-threshold)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"origfile" => "origfile (-origfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"origfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['maxrepeat','threshold',],
	"output" => ['outfile','origfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"maxrepeat" => '600',
	"threshold" => '20',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"maxrepeat" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"origfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"origfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"maxrepeat" => 1,
	"threshold" => 1,
	"output" => 0,
	"outfile" => 1,
	"origfile" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/equicktandem.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

