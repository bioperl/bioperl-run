# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pepwheel
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pepwheel

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pepwheel

      Bioperl class for:

	PEPWHEEL	Shows protein sequences as helices (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pepwheel.html 
         for available values):


		pepwheel (String)

		init (String)

		sequence (Sequence)
			sequence -- Protein [single sequence] (-sequence)
			pipe: seqfile

		wheel (Switch)
			Plot the wheel (-wheel)

		steps (Integer)
			Number of steps (-steps)

		turns (Integer)
			Number of turns (-turns)

		amphipathic (Switch)
			Prompt for amphipathic residue marking (-amphipathic)

		squares (String)
			Mark as squares (-squares)

		diamonds (String)
			Mark as diamonds (-diamonds)

		octags (String)
			Mark as octagons (-octags)

		data (Switch)
			Display as data (-data)

		outfile (OutFile)
			outfile (-outfile)

		graph (Excl)
			graph [device to be displayed on] (-graph)

		auto (String)

		psouput (String)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/pepwheel.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pepwheel;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pepwheel = Bio::Tools::Run::PiseApplication::pepwheel->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pepwheel object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pepwheel = $factory->program('pepwheel');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pepwheel.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepwheel.pm

    $self->{COMMAND}   = "pepwheel";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PEPWHEEL";

    $self->{DESCRIPTION}   = "Shows protein sequences as helices (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",

         "protein:2d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pepwheel.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pepwheel",
	"init",
	"input",
	"output",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pepwheel",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- Protein [single sequence] (-sequence)
	"output", 	# output Section
	"wheel", 	# Plot the wheel (-wheel)
	"steps", 	# Number of steps (-steps)
	"turns", 	# Number of turns (-turns)
	"amphipathicsection", 	# amphipathic Section
	"amphipathic", 	# Prompt for amphipathic residue marking (-amphipathic)
	"squares", 	# Mark as squares (-squares)
	"diamonds", 	# Mark as diamonds (-diamonds)
	"octags", 	# Mark as octagons (-octags)
	"datasection", 	# datasection Section
	"data", 	# Display as data (-data)
	"outfile", 	# outfile (-outfile)
	"graph", 	# graph [device to be displayed on] (-graph)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"pepwheel" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"output" => 'Paragraph',
	"wheel" => 'Switch',
	"steps" => 'Integer',
	"turns" => 'Integer',
	"amphipathicsection" => 'Paragraph',
	"amphipathic" => 'Switch',
	"squares" => 'String',
	"diamonds" => 'String',
	"octags" => 'String',
	"datasection" => 'Paragraph',
	"data" => 'Switch',
	"outfile" => 'OutFile',
	"graph" => 'Excl',
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
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"output" => {
	},
	"wheel" => {
		"perl" => '($value)? "" : " -nowheel"',
	},
	"steps" => {
		"perl" => '(defined $value && $value != $vdef)? " -steps=$value" : ""',
	},
	"turns" => {
		"perl" => '(defined $value && $value != $vdef)? " -turns=$value" : ""',
	},
	"amphipathicsection" => {
	},
	"amphipathic" => {
		"perl" => '($value)? " -amphipathic" : ""',
	},
	"squares" => {
		"perl" => '($value && $value ne $vdef)? " -squares=$value" : ""',
	},
	"diamonds" => {
		"perl" => '($value && $value ne $vdef)? " -diamonds=$value" : ""',
	},
	"octags" => {
		"perl" => '($value && $value ne $vdef)? " -octags=$value" : ""',
	},
	"datasection" => {
	},
	"data" => {
		"perl" => '($value)? " -data" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=pepwheel"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"pepwheel" => {
		"perl" => '"pepwheel"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"wheel" => 2,
	"steps" => 3,
	"turns" => 4,
	"amphipathic" => 5,
	"squares" => 6,
	"diamonds" => 7,
	"octags" => 8,
	"data" => 9,
	"outfile" => 10,
	"graph" => 11,
	"auto" => 12,
	"psouput" => 100,
	"pepwheel" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pngresults",
	"output",
	"pepwheel",
	"datasection",
	"amphipathicsection",
	"psresults",
	"metaresults",
	"dataresults",
	"sequence",
	"wheel",
	"steps",
	"turns",
	"amphipathic",
	"squares",
	"diamonds",
	"octags",
	"data",
	"outfile",
	"graph",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"wheel" => 0,
	"steps" => 0,
	"turns" => 0,
	"amphipathicsection" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"datasection" => 0,
	"data" => 0,
	"outfile" => 0,
	"graph" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"pepwheel" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"wheel" => 0,
	"steps" => 0,
	"turns" => 0,
	"amphipathicsection" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"datasection" => 0,
	"data" => 0,
	"outfile" => 0,
	"graph" => 0,
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
	"sequence" => 1,
	"output" => 0,
	"wheel" => 0,
	"steps" => 0,
	"turns" => 0,
	"amphipathicsection" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"datasection" => 0,
	"data" => 0,
	"outfile" => 0,
	"graph" => 0,
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
	"sequence" => "sequence -- Protein [single sequence] (-sequence)",
	"output" => "output Section",
	"wheel" => "Plot the wheel (-wheel)",
	"steps" => "Number of steps (-steps)",
	"turns" => "Number of turns (-turns)",
	"amphipathicsection" => "amphipathic Section",
	"amphipathic" => "Prompt for amphipathic residue marking (-amphipathic)",
	"squares" => "Mark as squares (-squares)",
	"diamonds" => "Mark as diamonds (-diamonds)",
	"octags" => "Mark as octagons (-octags)",
	"datasection" => "datasection Section",
	"data" => "Display as data (-data)",
	"outfile" => "outfile (-outfile)",
	"graph" => "graph [device to be displayed on] (-graph)",
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
	"sequence" => 0,
	"output" => 0,
	"wheel" => 0,
	"steps" => 0,
	"turns" => 0,
	"amphipathicsection" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"datasection" => 0,
	"data" => 0,
	"outfile" => 0,
	"graph" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"output" => ['wheel','steps','turns','amphipathicsection','datasection',],
	"amphipathicsection" => ['amphipathic','squares','diamonds','octags',],
	"datasection" => ['data','outfile','graph',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wheel" => '1',
	"steps" => '18',
	"turns" => '5',
	"squares" => 'ILVM',
	"diamonds" => 'DENQST',
	"octags" => 'HKR',
	"data" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"wheel" => { "perl" => '1' },
	"steps" => { "perl" => '1' },
	"turns" => { "perl" => '1' },
	"amphipathicsection" => { "perl" => '1' },
	"amphipathic" => { "perl" => '1' },
	"squares" => { "perl" => '1' },
	"diamonds" => { "perl" => '1' },
	"octags" => { "perl" => '1' },
	"datasection" => { "perl" => '1' },
	"data" => { "perl" => '1' },
	"outfile" => {
		"perl" => '$data',
		"acd" => '$data',
	},
	"graph" => {
		"acd" => '@(!$(data))',
	},
	"auto" => { "perl" => '1' },
	"psouput" => {
		"perl" => '$graph eq "postscript" || $graph eq "ps" || $graph eq "colourps"  || $graph eq "cps" || $graph eq "png"',
	},
	"psresults" => {
		"perl" => '$graph eq "postscript" || $graph eq "ps" || $graph eq "colourps" || $graph eq "cps"',
	},
	"metaresults" => {
		"perl" => '$graph eq "meta"',
	},
	"dataresults" => {
		"perl" => '$graph eq "data"',
	},
	"pngresults" => {
		"perl" => '$graph eq "png"',
	},

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
	"output" => 0,
	"wheel" => 0,
	"steps" => 0,
	"turns" => 0,
	"amphipathicsection" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"datasection" => 0,
	"data" => 0,
	"outfile" => 0,
	"graph" => 0,
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
	"sequence" => 1,
	"output" => 0,
	"wheel" => 0,
	"steps" => 0,
	"turns" => 0,
	"amphipathicsection" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"datasection" => 0,
	"data" => 0,
	"outfile" => 0,
	"graph" => 0,
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
	"steps" => [
		"The number of residues plotted per turn is this value divided by the \'turns\' value.",
	],
	"turns" => [
		"The number of residues plotted per turn is the \'steps\' value divided by this value.",
	],
	"amphipathic" => [
		"If this is true then the residues ACFGILMVWY are marked as squares and all other residues are unmarked. This overrides any other markup that you may have specified using the qualifiers \'-squares\', \'-diamonds\' and \'-octags\'.",
	],
	"squares" => [
		"By default the aliphatic residues ILVM are marked with squares.",
	],
	"diamonds" => [
		"By default the residues DENQST are marked with diamonds.",
	],
	"octags" => [
		"By default the positively charged residues HKR are marked with octagons.",
	],
	"data" => [
		"Output the match data to a file instead of plotting it",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepwheel.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

