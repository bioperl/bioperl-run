# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::domainer
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::domainer

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::domainer

      Bioperl class for:

	DOMAINER	Build domain coordinate files (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/domainer.html 
         for available values):


		domainer (String)

		init (String)

		scop (InFile)
			Name of scop file for input (embl-like format) (-scop)

		cpdb (String)
			Location of coordinate files for input (embl-like format) (-cpdb)

		cpdbscop (String)
			Location of coordinate files for output (embl-like format) (-cpdbscop)

		cpdbextn (String)
			Extension of coordinate files (embl-like format) (-cpdbextn)

		pdbscop (String)
			Location of coordinate files for output (pdb format) (-pdbscop)

		pdbextn (String)
			Extension of coordinate files (pdb format) (-pdbextn)

		cpdberrf (OutFile)
			Name of log file for the embl-like format build (-cpdberrf)

		pdberrf (OutFile)
			Name of log file for the pdb format build (-pdberrf)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/domainer.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::domainer;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $domainer = Bio::Tools::Run::PiseApplication::domainer->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::domainer object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $domainer = $factory->program('domainer');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::domainer.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/domainer.pm

    $self->{COMMAND}   = "domainer";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DOMAINER";

    $self->{DESCRIPTION}   = "Build domain coordinate files (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "utils:database creation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/domainer.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"domainer",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"domainer",
	"init",
	"input", 	# input Section
	"scop", 	# Name of scop file for input (embl-like format) (-scop)
	"cpdb", 	# Location of coordinate files for input (embl-like format) (-cpdb)
	"output", 	# output Section
	"cpdbscop", 	# Location of coordinate files for output (embl-like format) (-cpdbscop)
	"cpdbextn", 	# Extension of coordinate files (embl-like format) (-cpdbextn)
	"pdbscop", 	# Location of coordinate files for output (pdb format) (-pdbscop)
	"pdbextn", 	# Extension of coordinate files (pdb format) (-pdbextn)
	"cpdberrf", 	# Name of log file for the embl-like format build (-cpdberrf)
	"pdberrf", 	# Name of log file for the pdb format build (-pdberrf)
	"auto",

    ];

    $self->{TYPE}  = {
	"domainer" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"scop" => 'InFile',
	"cpdb" => 'String',
	"output" => 'Paragraph',
	"cpdbscop" => 'String',
	"cpdbextn" => 'String',
	"pdbscop" => 'String',
	"pdbextn" => 'String',
	"cpdberrf" => 'OutFile',
	"pdberrf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"scop" => {
		"perl" => '" -scop=$value"',
	},
	"cpdb" => {
		"perl" => '" -cpdb=$value"',
	},
	"output" => {
	},
	"cpdbscop" => {
		"perl" => '" -cpdbscop=$value"',
	},
	"cpdbextn" => {
		"perl" => '" -cpdbextn=$value"',
	},
	"pdbscop" => {
		"perl" => '" -pdbscop=$value"',
	},
	"pdbextn" => {
		"perl" => '" -pdbextn=$value"',
	},
	"cpdberrf" => {
		"perl" => '" -cpdberrf=$value"',
	},
	"pdberrf" => {
		"perl" => '" -pdberrf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"domainer" => {
		"perl" => '"domainer"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"scop" => 1,
	"cpdb" => 2,
	"cpdbscop" => 3,
	"cpdbextn" => 4,
	"pdbscop" => 5,
	"pdbextn" => 6,
	"cpdberrf" => 7,
	"pdberrf" => 8,
	"auto" => 9,
	"domainer" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"domainer",
	"scop",
	"cpdb",
	"cpdbscop",
	"cpdbextn",
	"pdbscop",
	"pdbextn",
	"cpdberrf",
	"pdberrf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"scop" => 0,
	"cpdb" => 0,
	"output" => 0,
	"cpdbscop" => 0,
	"cpdbextn" => 0,
	"pdbscop" => 0,
	"pdbextn" => 0,
	"cpdberrf" => 0,
	"pdberrf" => 0,
	"auto" => 1,
	"domainer" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"scop" => 0,
	"cpdb" => 0,
	"output" => 0,
	"cpdbscop" => 0,
	"cpdbextn" => 0,
	"pdbscop" => 0,
	"pdbextn" => 0,
	"cpdberrf" => 0,
	"pdberrf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"scop" => 1,
	"cpdb" => 1,
	"output" => 0,
	"cpdbscop" => 1,
	"cpdbextn" => 1,
	"pdbscop" => 1,
	"pdbextn" => 1,
	"cpdberrf" => 1,
	"pdberrf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"scop" => "Name of scop file for input (embl-like format) (-scop)",
	"cpdb" => "Location of coordinate files for input (embl-like format) (-cpdb)",
	"output" => "output Section",
	"cpdbscop" => "Location of coordinate files for output (embl-like format) (-cpdbscop)",
	"cpdbextn" => "Extension of coordinate files (embl-like format) (-cpdbextn)",
	"pdbscop" => "Location of coordinate files for output (pdb format) (-pdbscop)",
	"pdbextn" => "Extension of coordinate files (pdb format) (-pdbextn)",
	"cpdberrf" => "Name of log file for the embl-like format build (-cpdberrf)",
	"pdberrf" => "Name of log file for the pdb format build (-pdberrf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"scop" => 0,
	"cpdb" => 0,
	"output" => 0,
	"cpdbscop" => 0,
	"cpdbextn" => 0,
	"pdbscop" => 0,
	"pdbextn" => 0,
	"cpdberrf" => 0,
	"pdberrf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['scop','cpdb',],
	"output" => ['cpdbscop','cpdbextn','pdbscop','pdbextn','cpdberrf','pdberrf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"cpdb" => './',
	"cpdbscop" => './',
	"cpdbextn" => '.pxyz',
	"pdbscop" => './',
	"pdbextn" => '.ent',
	"cpdberrf" => 'domainer.log1',
	"pdberrf" => 'domainer.log2',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"scop" => { "perl" => '1' },
	"cpdb" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"cpdbscop" => { "perl" => '1' },
	"cpdbextn" => { "perl" => '1' },
	"pdbscop" => { "perl" => '1' },
	"pdbextn" => { "perl" => '1' },
	"cpdberrf" => { "perl" => '1' },
	"pdberrf" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"scop" => 0,
	"cpdb" => 0,
	"output" => 0,
	"cpdbscop" => 0,
	"cpdbextn" => 0,
	"pdbscop" => 0,
	"pdbextn" => 0,
	"cpdberrf" => 0,
	"pdberrf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"scop" => 1,
	"cpdb" => 1,
	"output" => 0,
	"cpdbscop" => 1,
	"cpdbextn" => 1,
	"pdbscop" => 1,
	"pdbextn" => 1,
	"cpdberrf" => 1,
	"pdberrf" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/domainer.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

