# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::findkm
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::findkm

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::findkm

      Bioperl class for:

	FINDKM	Find Km and Vmax for an enzyme reaction by a Hanes/Woolf plot (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/findkm.html 
         for available values):


		findkm (String)

		init (String)

		infile (InFile)
			Enter name of file containing data (-infile)

		plot (Switch)
			S/V vs S (-plot)

		outfile (OutFile)
			outfile (-outfile)

		graphlb (Excl)
			graphlb (-graphlb)

		auto (String)

		psouput (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/findkm.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::findkm;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $findkm = Bio::Tools::Run::PiseApplication::findkm->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::findkm object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $findkm = $factory->program('findkm');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::findkm.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/findkm.pm

    $self->{COMMAND}   = "findkm";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FINDKM";

    $self->{DESCRIPTION}   = "Find Km and Vmax for an enzyme reaction by a Hanes/Woolf plot (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "enzyme kinetics",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/findkm.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"findkm",
	"init",
	"input",
	"advanced",
	"output",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"findkm",
	"init",
	"input", 	# input Section
	"infile", 	# Enter name of file containing data (-infile)
	"advanced", 	# advanced Section
	"plot", 	# S/V vs S (-plot)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"graphlb", 	# graphlb (-graphlb)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"findkm" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"infile" => 'InFile',
	"advanced" => 'Paragraph',
	"plot" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"graphlb" => 'Excl',
	"auto" => 'String',
	"psouput" => 'String',
	"psresults" => 'Results',
	"metaresults" => 'Results',
	"dataresults" => 'Results',
	"pngresults" => 'Results',

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
	"advanced" => {
	},
	"plot" => {
		"perl" => '($value)? "" : " -noplot"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"graphlb" => {
		"perl" => '($value)? " -graphlb=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=findkm"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"findkm" => {
		"perl" => '"findkm"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"infile" => 1,
	"plot" => 2,
	"outfile" => 3,
	"graphlb" => 4,
	"auto" => 5,
	"psouput" => 100,
	"findkm" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"findkm",
	"advanced",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"infile",
	"plot",
	"outfile",
	"graphlb",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"infile" => 0,
	"advanced" => 0,
	"plot" => 0,
	"output" => 0,
	"outfile" => 0,
	"graphlb" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"findkm" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"advanced" => 0,
	"plot" => 0,
	"output" => 0,
	"outfile" => 0,
	"graphlb" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"advanced" => 0,
	"plot" => 0,
	"output" => 0,
	"outfile" => 1,
	"graphlb" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"infile" => "Enter name of file containing data (-infile)",
	"advanced" => "advanced Section",
	"plot" => "S/V vs S (-plot)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"graphlb" => "graphlb (-graphlb)",
	"auto" => "",
	"psouput" => "",
	"psresults" => "",
	"metaresults" => "",
	"dataresults" => "",
	"pngresults" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"advanced" => 0,
	"plot" => 0,
	"output" => 0,
	"outfile" => 0,
	"graphlb" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['infile',],
	"advanced" => ['plot',],
	"output" => ['outfile','graphlb',],
	"graphlb" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"plot" => '1',
	"outfile" => 'outfile.out',
	"graphlb" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"plot" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"graphlb" => { "perl" => '1' },
	"auto" => { "perl" => '1' },
	"psouput" => {
		"perl" => '$graphlb eq "postscript" || $graphlb eq "ps" || $graphlb eq "colourps"  || $graphlb eq "cps" || $graphlb eq "png"',
	},
	"psresults" => {
		"perl" => '$graphlb eq "postscript" || $graphlb eq "ps" || $graphlb eq "colourps" || $graphlb eq "cps"',
	},
	"metaresults" => {
		"perl" => '$graphlb eq "meta"',
	},
	"dataresults" => {
		"perl" => '$graphlb eq "data"',
	},
	"pngresults" => {
		"perl" => '$graphlb eq "png"',
	},

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
	"advanced" => 0,
	"plot" => 0,
	"output" => 0,
	"outfile" => 0,
	"graphlb" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"advanced" => 0,
	"plot" => 0,
	"output" => 0,
	"outfile" => 1,
	"graphlb" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/findkm.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

