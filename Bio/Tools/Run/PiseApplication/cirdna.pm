# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::cirdna
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::cirdna

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cirdna

      Bioperl class for:

	CIRDNA	Draws circular maps of DNA constructs (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/cirdna.html 
         for available values):


		cirdna (String)

		init (String)

		graphout (Excl)
			graphout [device to be displayed on] (-graphout)

		inputfile (InFile)
			input file containing mapping data (-inputfile)

		ruler (Switch)
			do you want a ruler (-ruler)

		blocktype (Excl)
			type of blocks (-blocktype)

		originangle (Float)
			position of the molecule's origin on the circle (enter a number in the range 0 - 360) (-originangle)

		posticks (Excl)
			ticks inside or outside the circle (enter In or Out) (-posticks)

		posblocks (Excl)
			text inside or outside the blocks (enter In or Out) (-posblocks)

		intersymbol (Switch)
			do you want horizontal junctions between blocks (-intersymbol)

		intercolour (Integer)
			colour of junctions between blocks (enter a colour number) (-intercolour)

		interticks (Switch)
			do you want horizontal junctions between ticks (-interticks)

		gapsize (Integer)
			interval between ticks in the ruler (enter an integer) (-gapsize)

		ticklines (Switch)
			do you want vertical lines at the ruler's ticks (-ticklines)

		textheight (Float)
			height of text (enter a number to multiply the default height) (-textheight)

		textlength (Float)
			length of text (enter a number to multiply the default length) (-textlength)

		tickheight (Float)
			height of ticks (enter a number to multiply the default height) (-tickheight)

		blockheight (Float)
			height of blocks (enter a number to multiply the default height) (-blockheight)

		rangeheight (Float)
			height of range ends (enter a number to multiply the default height) (-rangeheight)

		gapgroup (Float)
			space between groups (enter a number to multiply the default space) (-gapgroup)

		postext (Float)
			space between text and ticks, blocks, and ranges (enter a number to multiply the default space) (-postext)

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

http://bioweb.pasteur.fr/seqanal/interfaces/cirdna.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::cirdna;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cirdna = Bio::Tools::Run::PiseApplication::cirdna->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cirdna object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $cirdna = $factory->program('cirdna');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::cirdna.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cirdna.pm

    $self->{COMMAND}   = "cirdna";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CIRDNA";

    $self->{DESCRIPTION}   = "Draws circular maps of DNA constructs (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/cirdna.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cirdna",
	"init",
	"graphout",
	"inputfile",
	"ruler",
	"blocktype",
	"originangle",
	"posticks",
	"posblocks",
	"intersymbol",
	"intercolour",
	"interticks",
	"gapsize",
	"ticklines",
	"textheight",
	"textlength",
	"tickheight",
	"blockheight",
	"rangeheight",
	"gapgroup",
	"postext",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cirdna",
	"init",
	"graphout", 	# graphout [device to be displayed on] (-graphout)
	"inputfile", 	# input file containing mapping data (-inputfile)
	"ruler", 	# do you want a ruler (-ruler)
	"blocktype", 	# type of blocks (-blocktype)
	"originangle", 	# position of the molecule's origin on the circle (enter a number in the range 0 - 360) (-originangle)
	"posticks", 	# ticks inside or outside the circle (enter In or Out) (-posticks)
	"posblocks", 	# text inside or outside the blocks (enter In or Out) (-posblocks)
	"intersymbol", 	# do you want horizontal junctions between blocks (-intersymbol)
	"intercolour", 	# colour of junctions between blocks (enter a colour number) (-intercolour)
	"interticks", 	# do you want horizontal junctions between ticks (-interticks)
	"gapsize", 	# interval between ticks in the ruler (enter an integer) (-gapsize)
	"ticklines", 	# do you want vertical lines at the ruler's ticks (-ticklines)
	"textheight", 	# height of text (enter a number to multiply the default height) (-textheight)
	"textlength", 	# length of text (enter a number to multiply the default length) (-textlength)
	"tickheight", 	# height of ticks (enter a number to multiply the default height) (-tickheight)
	"blockheight", 	# height of blocks (enter a number to multiply the default height) (-blockheight)
	"rangeheight", 	# height of range ends (enter a number to multiply the default height) (-rangeheight)
	"gapgroup", 	# space between groups (enter a number to multiply the default space) (-gapgroup)
	"postext", 	# space between text and ticks, blocks, and ranges (enter a number to multiply the default space) (-postext)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"cirdna" => 'String',
	"init" => 'String',
	"graphout" => 'Excl',
	"inputfile" => 'InFile',
	"ruler" => 'Switch',
	"blocktype" => 'Excl',
	"originangle" => 'Float',
	"posticks" => 'Excl',
	"posblocks" => 'Excl',
	"intersymbol" => 'Switch',
	"intercolour" => 'Integer',
	"interticks" => 'Switch',
	"gapsize" => 'Integer',
	"ticklines" => 'Switch',
	"textheight" => 'Float',
	"textlength" => 'Float',
	"tickheight" => 'Float',
	"blockheight" => 'Float',
	"rangeheight" => 'Float',
	"gapgroup" => 'Float',
	"postext" => 'Float',
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
	"graphout" => {
		"perl" => '($value)? " -graphout=$value" : ""',
	},
	"inputfile" => {
		"perl" => '($value && $value ne $vdef)? " -inputfile=$value" : ""',
	},
	"ruler" => {
		"perl" => '($value)? "" : " -noruler"',
	},
	"blocktype" => {
		"perl" => '($value && $value ne $vdef)? " -blocktype=$value" : ""',
	},
	"originangle" => {
		"perl" => '(defined $value && $value != $vdef)? " -originangle=$value" : ""',
	},
	"posticks" => {
		"perl" => '($value && $value ne $vdef)? " -posticks=$value" : ""',
	},
	"posblocks" => {
		"perl" => '($value && $value ne $vdef)? " -posblocks=$value" : ""',
	},
	"intersymbol" => {
		"perl" => '($value)? "" : " -nointersymbol"',
	},
	"intercolour" => {
		"perl" => '(defined $value && $value != $vdef)? " -intercolour=$value" : ""',
	},
	"interticks" => {
		"perl" => '($value)? " -interticks" : ""',
	},
	"gapsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapsize=$value" : ""',
	},
	"ticklines" => {
		"perl" => '($value)? " -ticklines" : ""',
	},
	"textheight" => {
		"perl" => '(defined $value && $value != $vdef)? " -textheight=$value" : ""',
	},
	"textlength" => {
		"perl" => '(defined $value && $value != $vdef)? " -textlength=$value" : ""',
	},
	"tickheight" => {
		"perl" => '(defined $value && $value != $vdef)? " -tickheight=$value" : ""',
	},
	"blockheight" => {
		"perl" => '(defined $value && $value != $vdef)? " -blockheight=$value" : ""',
	},
	"rangeheight" => {
		"perl" => '(defined $value && $value != $vdef)? " -rangeheight=$value" : ""',
	},
	"gapgroup" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapgroup=$value" : ""',
	},
	"postext" => {
		"perl" => '(defined $value && $value != $vdef)? " -postext=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=cirdna"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"cirdna" => {
		"perl" => '"cirdna"',
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
	"graphout" => 1,
	"inputfile" => 2,
	"ruler" => 3,
	"blocktype" => 4,
	"originangle" => 5,
	"posticks" => 6,
	"posblocks" => 7,
	"intersymbol" => 8,
	"intercolour" => 9,
	"interticks" => 10,
	"gapsize" => 11,
	"ticklines" => 12,
	"textheight" => 13,
	"textlength" => 14,
	"tickheight" => 15,
	"blockheight" => 16,
	"rangeheight" => 17,
	"gapgroup" => 18,
	"postext" => 19,
	"auto" => 20,
	"psouput" => 100,
	"cirdna" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"pngresults",
	"cirdna",
	"metaresults",
	"psresults",
	"dataresults",
	"graphout",
	"inputfile",
	"ruler",
	"blocktype",
	"originangle",
	"posticks",
	"posblocks",
	"intersymbol",
	"intercolour",
	"interticks",
	"gapsize",
	"ticklines",
	"textheight",
	"textlength",
	"tickheight",
	"blockheight",
	"rangeheight",
	"gapgroup",
	"postext",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"graphout" => 0,
	"inputfile" => 0,
	"ruler" => 0,
	"blocktype" => 0,
	"originangle" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"intersymbol" => 0,
	"intercolour" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
	"textheight" => 0,
	"textlength" => 0,
	"tickheight" => 0,
	"blockheight" => 0,
	"rangeheight" => 0,
	"gapgroup" => 0,
	"postext" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"cirdna" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"graphout" => 0,
	"inputfile" => 0,
	"ruler" => 0,
	"blocktype" => 0,
	"originangle" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"intersymbol" => 0,
	"intercolour" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
	"textheight" => 0,
	"textlength" => 0,
	"tickheight" => 0,
	"blockheight" => 0,
	"rangeheight" => 0,
	"gapgroup" => 0,
	"postext" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"graphout" => 0,
	"inputfile" => 0,
	"ruler" => 0,
	"blocktype" => 0,
	"originangle" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"intersymbol" => 0,
	"intercolour" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
	"textheight" => 0,
	"textlength" => 0,
	"tickheight" => 0,
	"blockheight" => 0,
	"rangeheight" => 0,
	"gapgroup" => 0,
	"postext" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"graphout" => "graphout [device to be displayed on] (-graphout)",
	"inputfile" => "input file containing mapping data (-inputfile)",
	"ruler" => "do you want a ruler (-ruler)",
	"blocktype" => "type of blocks (-blocktype)",
	"originangle" => "position of the molecule's origin on the circle (enter a number in the range 0 - 360) (-originangle)",
	"posticks" => "ticks inside or outside the circle (enter In or Out) (-posticks)",
	"posblocks" => "text inside or outside the blocks (enter In or Out) (-posblocks)",
	"intersymbol" => "do you want horizontal junctions between blocks (-intersymbol)",
	"intercolour" => "colour of junctions between blocks (enter a colour number) (-intercolour)",
	"interticks" => "do you want horizontal junctions between ticks (-interticks)",
	"gapsize" => "interval between ticks in the ruler (enter an integer) (-gapsize)",
	"ticklines" => "do you want vertical lines at the ruler's ticks (-ticklines)",
	"textheight" => "height of text (enter a number to multiply the default height) (-textheight)",
	"textlength" => "length of text (enter a number to multiply the default length) (-textlength)",
	"tickheight" => "height of ticks (enter a number to multiply the default height) (-tickheight)",
	"blockheight" => "height of blocks (enter a number to multiply the default height) (-blockheight)",
	"rangeheight" => "height of range ends (enter a number to multiply the default height) (-rangeheight)",
	"gapgroup" => "space between groups (enter a number to multiply the default space) (-gapgroup)",
	"postext" => "space between text and ticks, blocks, and ranges (enter a number to multiply the default space) (-postext)",
	"auto" => "",
	"psouput" => "",
	"psresults" => "",
	"metaresults" => "",
	"dataresults" => "",
	"pngresults" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"graphout" => 0,
	"inputfile" => 0,
	"ruler" => 0,
	"blocktype" => 0,
	"originangle" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"intersymbol" => 0,
	"intercolour" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
	"textheight" => 0,
	"textlength" => 0,
	"tickheight" => 0,
	"blockheight" => 0,
	"rangeheight" => 0,
	"gapgroup" => 0,
	"postext" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"graphout" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
	"blocktype" => ['1','Open','2','Filled','3','Outline',],
	"posticks" => ['1','In','2','Out',],
	"posblocks" => ['1','In','2','Out',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"graphout" => 'postscript',
	"ruler" => '1',
	"blocktype" => 'Filled',
	"originangle" => '90',
	"posticks" => 'Out',
	"posblocks" => 'In',
	"intersymbol" => '1',
	"intercolour" => '1',
	"interticks" => '0',
	"gapsize" => '500',
	"ticklines" => '0',
	"textheight" => '1',
	"textlength" => '1',
	"tickheight" => '1',
	"blockheight" => '1',
	"rangeheight" => '1',
	"gapgroup" => '1',
	"postext" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"graphout" => { "perl" => '1' },
	"inputfile" => { "perl" => '1' },
	"ruler" => { "perl" => '1' },
	"blocktype" => { "perl" => '1' },
	"originangle" => { "perl" => '1' },
	"posticks" => { "perl" => '1' },
	"posblocks" => { "perl" => '1' },
	"intersymbol" => { "perl" => '1' },
	"intercolour" => { "perl" => '1' },
	"interticks" => { "perl" => '1' },
	"gapsize" => { "perl" => '1' },
	"ticklines" => { "perl" => '1' },
	"textheight" => { "perl" => '1' },
	"textlength" => { "perl" => '1' },
	"tickheight" => { "perl" => '1' },
	"blockheight" => { "perl" => '1' },
	"rangeheight" => { "perl" => '1' },
	"gapgroup" => { "perl" => '1' },
	"postext" => { "perl" => '1' },
	"auto" => { "perl" => '1' },
	"psouput" => {
		"perl" => '$graphout eq "postscript" || $graphout eq "ps" || $graphout eq "colourps"  || $graphout eq "cps" || $graphout eq "png"',
	},
	"psresults" => {
		"perl" => '$graphout eq "postscript" || $graphout eq "ps" || $graphout eq "colourps" || $graphout eq "cps"',
	},
	"metaresults" => {
		"perl" => '$graphout eq "meta"',
	},
	"dataresults" => {
		"perl" => '$graphout eq "data"',
	},
	"pngresults" => {
		"perl" => '$graphout eq "png"',
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
	"graphout" => 0,
	"inputfile" => 0,
	"ruler" => 0,
	"blocktype" => 0,
	"originangle" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"intersymbol" => 0,
	"intercolour" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
	"textheight" => 0,
	"textlength" => 0,
	"tickheight" => 0,
	"blockheight" => 0,
	"rangeheight" => 0,
	"gapgroup" => 0,
	"postext" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"graphout" => 0,
	"inputfile" => 0,
	"ruler" => 0,
	"blocktype" => 0,
	"originangle" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"intersymbol" => 0,
	"intercolour" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
	"textheight" => 0,
	"textlength" => 0,
	"tickheight" => 0,
	"blockheight" => 0,
	"rangeheight" => 0,
	"gapgroup" => 0,
	"postext" => 0,
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
	"blocktype" => [
		"type of blocks: Open, Filled, or Outline. Option \'Outline\' draws filled blocks surrounded by a black border",
	],
	"textheight" => [
		"height of text. Enter a number <1 or >1 to decrease or increase the size, respectively",
	],
	"textlength" => [
		"length of text. Enter a number <1 or >1 to decrease or increase the size, respectively",
	],
	"tickheight" => [
		"height of ticks. Enter a number <1 or >1 to decrease or increase the size, respectively",
	],
	"blockheight" => [
		"height of blocks. Enter a number <1 or >1 to decrease or increase the size, respectively",
	],
	"rangeheight" => [
		"height of range ends. Enter a number <1 or >1 to decrease or increase the size, respectively",
	],
	"gapgroup" => [
		"space between groups. Enter a number <1 or >1 to decrease or increase the size, respectively",
	],
	"postext" => [
		"space between text and ticks, blocks, and ranges. Enter a number <1 or >1 to decrease or increase the size, respectively",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cirdna.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

