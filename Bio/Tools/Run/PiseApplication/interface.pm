# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::interface
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::interface

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::interface

      Bioperl class for:

	INTERFACE	Reads coordinate files and writes inter-chain contact files (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/interface.html 
         for available values):


		interface (String)

		init (String)

		in (InFile)
			Coordinate file for input (embl-like format) (-in)

		out (OutFile)
			Contact file for output (-out)

		thresh (Float)
			Threshold contact distance (-thresh)

		ignore (Float)
			Threshold ignore distance (-ignore)

		vdwf (String)
			Name of data file with van der Waals radii (-vdwf)

		conerrf (OutFile)
			Name of log file for the build (-conerrf)

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

http://bioweb.pasteur.fr/seqanal/interfaces/interface.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::interface;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $interface = Bio::Tools::Run::PiseApplication::interface->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::interface object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $interface = $factory->program('interface');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::interface.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/interface.pm

    $self->{COMMAND}   = "interface";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "INTERFACE";

    $self->{DESCRIPTION}   = "Reads coordinate files and writes inter-chain contact files (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:3d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/interface.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"interface",
	"init",
	"in",
	"out",
	"thresh",
	"ignore",
	"vdwf",
	"conerrf",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"interface",
	"init",
	"in", 	# Coordinate file for input (embl-like format) (-in)
	"out", 	# Contact file for output (-out)
	"thresh", 	# Threshold contact distance (-thresh)
	"ignore", 	# Threshold ignore distance (-ignore)
	"vdwf", 	# Name of data file with van der Waals radii (-vdwf)
	"conerrf", 	# Name of log file for the build (-conerrf)
	"auto",

    ];

    $self->{TYPE}  = {
	"interface" => 'String',
	"init" => 'String',
	"in" => 'InFile',
	"out" => 'OutFile',
	"thresh" => 'Float',
	"ignore" => 'Float',
	"vdwf" => 'String',
	"conerrf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"in" => {
		"perl" => '" -in=$value"',
	},
	"out" => {
		"perl" => '" -out=$value"',
	},
	"thresh" => {
		"perl" => '" -thresh=$value"',
	},
	"ignore" => {
		"perl" => '(defined $value && $value != $vdef)? " -ignore=$value" : ""',
	},
	"vdwf" => {
		"perl" => '($value && $value ne $vdef)? " -vdwf=$value" : ""',
	},
	"conerrf" => {
		"perl" => '($value && $value ne $vdef)? " -conerrf=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"interface" => {
		"perl" => '"interface"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"in" => 1,
	"out" => 2,
	"thresh" => 3,
	"ignore" => 4,
	"vdwf" => 5,
	"conerrf" => 6,
	"auto" => 7,
	"interface" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"interface",
	"in",
	"out",
	"thresh",
	"ignore",
	"vdwf",
	"conerrf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"in" => 0,
	"out" => 0,
	"thresh" => 0,
	"ignore" => 0,
	"vdwf" => 0,
	"conerrf" => 0,
	"auto" => 1,
	"interface" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"in" => 0,
	"out" => 0,
	"thresh" => 0,
	"ignore" => 0,
	"vdwf" => 0,
	"conerrf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"in" => 1,
	"out" => 1,
	"thresh" => 1,
	"ignore" => 0,
	"vdwf" => 0,
	"conerrf" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"in" => "Coordinate file for input (embl-like format) (-in)",
	"out" => "Contact file for output (-out)",
	"thresh" => "Threshold contact distance (-thresh)",
	"ignore" => "Threshold ignore distance (-ignore)",
	"vdwf" => "Name of data file with van der Waals radii (-vdwf)",
	"conerrf" => "Name of log file for the build (-conerrf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"in" => 0,
	"out" => 0,
	"thresh" => 0,
	"ignore" => 0,
	"vdwf" => 0,
	"conerrf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"out" => 'test.con',
	"thresh" => '6.0',
	"ignore" => '20.0',
	"vdwf" => 'Evdw.dat',
	"conerrf" => 'interface.log',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"in" => { "perl" => '1' },
	"out" => { "perl" => '1' },
	"thresh" => { "perl" => '1' },
	"ignore" => { "perl" => '1' },
	"vdwf" => { "perl" => '1' },
	"conerrf" => { "perl" => '1' },
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
	"in" => 0,
	"out" => 0,
	"thresh" => 0,
	"ignore" => 0,
	"vdwf" => 0,
	"conerrf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"in" => 1,
	"out" => 1,
	"thresh" => 1,
	"ignore" => 0,
	"vdwf" => 0,
	"conerrf" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"ignore" => [
		"If any two atoms from two different residues are at least this distance apart then no futher inter-atomic contacts will be checked for for that residue pair . This speeds the calculation up considerably.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/interface.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

