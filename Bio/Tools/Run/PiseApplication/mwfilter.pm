# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::mwfilter
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::mwfilter

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mwfilter

      Bioperl class for:

	MWFILTER	Filter noisy molwts from mass spec output (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/mwfilter.html 
         for available values):


		mwfilter (String)

		init (String)

		infile (InFile)
			Molecular weight file input (-infile)

		tolerance (Float)
			ppm tolerance (-tolerance)

		showdel (Switch)
			Output deleted mwts (-showdel)

		datafile (String)
			Data file of noisy molecular weights (-datafile)

		outfile (OutFile)
			outfile (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/mwfilter.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::mwfilter;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mwfilter = Bio::Tools::Run::PiseApplication::mwfilter->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mwfilter object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $mwfilter = $factory->program('mwfilter');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::mwfilter.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mwfilter.pm

    $self->{COMMAND}   = "mwfilter";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MWFILTER";

    $self->{DESCRIPTION}   = "Filter noisy molwts from mass spec output (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/mwfilter.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mwfilter",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mwfilter",
	"init",
	"input", 	# input Section
	"infile", 	# Molecular weight file input (-infile)
	"required", 	# required Section
	"tolerance", 	# ppm tolerance (-tolerance)
	"showdel", 	# Output deleted mwts (-showdel)
	"advanced", 	# advanced Section
	"datafile", 	# Data file of noisy molecular weights (-datafile)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"mwfilter" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"infile" => 'InFile',
	"required" => 'Paragraph',
	"tolerance" => 'Float',
	"showdel" => 'Switch',
	"advanced" => 'Paragraph',
	"datafile" => 'String',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"infile" => {
		"perl" => '" -infile=$value"',
	},
	"required" => {
	},
	"tolerance" => {
		"perl" => '" -tolerance=$value"',
	},
	"showdel" => {
		"perl" => '($value)? " -showdel" : ""',
	},
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value && $value ne $vdef)? " -datafile=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"mwfilter" => {
		"perl" => '"mwfilter"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"infile" => 1,
	"tolerance" => 2,
	"showdel" => 3,
	"datafile" => 4,
	"outfile" => 5,
	"auto" => 6,
	"mwfilter" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"mwfilter",
	"infile",
	"tolerance",
	"showdel",
	"datafile",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"showdel" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"mwfilter" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"showdel" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"required" => 0,
	"tolerance" => 1,
	"showdel" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"infile" => "Molecular weight file input (-infile)",
	"required" => "required Section",
	"tolerance" => "ppm tolerance (-tolerance)",
	"showdel" => "Output deleted mwts (-showdel)",
	"advanced" => "advanced Section",
	"datafile" => "Data file of noisy molecular weights (-datafile)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"showdel" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['infile',],
	"required" => ['tolerance','showdel',],
	"advanced" => ['datafile',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"tolerance" => '50.0',
	"showdel" => '0',
	"datafile" => 'Emwfilter.dat',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"tolerance" => { "perl" => '1' },
	"showdel" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
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
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"showdel" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"required" => 0,
	"tolerance" => 1,
	"showdel" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mwfilter.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

