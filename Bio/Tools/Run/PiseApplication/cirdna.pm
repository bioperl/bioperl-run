
=head1 NAME

Bio::Tools::Run::PiseApplication::cirdna

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cirdna

      Bioperl class for:

	CIRDNA	Draws circular maps of DNA constructs (EMBOSS)

      Parameters:


		cirdna (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		inputfile (InFile)
			input file containing mapping data (-inputfile)

		required (Paragraph)
			required Section

		posticks (String)
			ticks inside or outside the circle (enter In or Out) (-posticks)

		posblocks (String)
			text inside or outside the blocks (enter In or Out) (-posblocks)

		output (Paragraph)
			output Section

		graphout (Excl)
			graphout [device to be displayed on] (-graphout)

		originangle (Float)
			position of the molecule's origin on the circle (enter a number in the range 0 - 360) (-originangle)

		intersymbol (String)
			do you want horizontal junctions between blocks (Y or N) (-intersymbol)

		intercolor (Integer)
			color for junctions between blocks (enter a color number) (-intercolor)

		interticks (String)
			do you want horizontal junctions between ticks (Y or N) (-interticks)

		gapsize (Integer)
			interval between ticks in the ruler (enter an integer) (-gapsize)

		ticklines (String)
			do you want vertical lines at the ruler's ticks (Y or N) (-ticklines)

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
			

		psresults (Results)
			

		metaresults (Results)
			

		dataresults (Results)
			

		pngresults (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::cirdna;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cirdna = Bio::Tools::Run::PiseApplication::cirdna->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cirdna object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $cirdna = $factory->program('cirdna');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::cirdna.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cirdna.pm

    $self->{COMMAND}   = "cirdna";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CIRDNA";

    $self->{DESCRIPTION}   = "Draws circular maps of DNA constructs (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/cirdna.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cirdna",
	"init",
	"input",
	"required",
	"output",
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
	"input", 	# input Section
	"inputfile", 	# input file containing mapping data (-inputfile)
	"required", 	# required Section
	"posticks", 	# ticks inside or outside the circle (enter In or Out) (-posticks)
	"posblocks", 	# text inside or outside the blocks (enter In or Out) (-posblocks)
	"output", 	# output Section
	"graphout", 	# graphout [device to be displayed on] (-graphout)
	"originangle", 	# position of the molecule's origin on the circle (enter a number in the range 0 - 360) (-originangle)
	"intersymbol", 	# do you want horizontal junctions between blocks (Y or N) (-intersymbol)
	"intercolor", 	# color for junctions between blocks (enter a color number) (-intercolor)
	"interticks", 	# do you want horizontal junctions between ticks (Y or N) (-interticks)
	"gapsize", 	# interval between ticks in the ruler (enter an integer) (-gapsize)
	"ticklines", 	# do you want vertical lines at the ruler's ticks (Y or N) (-ticklines)
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
	"input" => 'Paragraph',
	"inputfile" => 'InFile',
	"required" => 'Paragraph',
	"posticks" => 'String',
	"posblocks" => 'String',
	"output" => 'Paragraph',
	"graphout" => 'Excl',
	"originangle" => 'Float',
	"intersymbol" => 'String',
	"intercolor" => 'Integer',
	"interticks" => 'String',
	"gapsize" => 'Integer',
	"ticklines" => 'String',
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
	"input" => {
	},
	"inputfile" => {
		"perl" => '($value && $value ne $vdef)? " -inputfile=$value" : ""',
	},
	"required" => {
	},
	"posticks" => {
		"perl" => '" -posticks=$value"',
	},
	"posblocks" => {
		"perl" => '" -posblocks=$value"',
	},
	"output" => {
	},
	"graphout" => {
		"perl" => '($value)? " -graphout=$value" : ""',
	},
	"originangle" => {
		"perl" => '(defined $value && $value != $vdef)? " -originangle=$value" : ""',
	},
	"intersymbol" => {
		"perl" => '($value && $value ne $vdef)? " -intersymbol=$value" : ""',
	},
	"intercolor" => {
		"perl" => '(defined $value && $value != $vdef)? " -intercolor=$value" : ""',
	},
	"interticks" => {
		"perl" => '($value && $value ne $vdef)? " -interticks=$value" : ""',
	},
	"gapsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapsize=$value" : ""',
	},
	"ticklines" => {
		"perl" => '($value && $value ne $vdef)? " -ticklines=$value" : ""',
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
	"inputfile" => 1,
	"posticks" => 2,
	"posblocks" => 3,
	"graphout" => 4,
	"originangle" => 5,
	"intersymbol" => 6,
	"intercolor" => 7,
	"interticks" => 8,
	"gapsize" => 9,
	"ticklines" => 10,
	"tickheight" => 11,
	"blockheight" => 12,
	"rangeheight" => 13,
	"gapgroup" => 14,
	"postext" => 15,
	"auto" => 16,
	"psouput" => 100,
	"cirdna" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"cirdna",
	"required",
	"psresults",
	"output",
	"metaresults",
	"dataresults",
	"pngresults",
	"inputfile",
	"posticks",
	"posblocks",
	"graphout",
	"originangle",
	"intersymbol",
	"intercolor",
	"interticks",
	"gapsize",
	"ticklines",
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
	"input" => 0,
	"inputfile" => 0,
	"required" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"output" => 0,
	"graphout" => 0,
	"originangle" => 0,
	"intersymbol" => 0,
	"intercolor" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
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
	"input" => 0,
	"inputfile" => 0,
	"required" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"output" => 0,
	"graphout" => 0,
	"originangle" => 0,
	"intersymbol" => 0,
	"intercolor" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
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
	"input" => 0,
	"inputfile" => 0,
	"required" => 0,
	"posticks" => 1,
	"posblocks" => 1,
	"output" => 0,
	"graphout" => 0,
	"originangle" => 0,
	"intersymbol" => 0,
	"intercolor" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
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
	"input" => "input Section",
	"inputfile" => "input file containing mapping data (-inputfile)",
	"required" => "required Section",
	"posticks" => "ticks inside or outside the circle (enter In or Out) (-posticks)",
	"posblocks" => "text inside or outside the blocks (enter In or Out) (-posblocks)",
	"output" => "output Section",
	"graphout" => "graphout [device to be displayed on] (-graphout)",
	"originangle" => "position of the molecule's origin on the circle (enter a number in the range 0 - 360) (-originangle)",
	"intersymbol" => "do you want horizontal junctions between blocks (Y or N) (-intersymbol)",
	"intercolor" => "color for junctions between blocks (enter a color number) (-intercolor)",
	"interticks" => "do you want horizontal junctions between ticks (Y or N) (-interticks)",
	"gapsize" => "interval between ticks in the ruler (enter an integer) (-gapsize)",
	"ticklines" => "do you want vertical lines at the ruler's ticks (Y or N) (-ticklines)",
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
	"input" => 0,
	"inputfile" => 0,
	"required" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"output" => 0,
	"graphout" => 0,
	"originangle" => 0,
	"intersymbol" => 0,
	"intercolor" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
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

	"input" => ['inputfile',],
	"required" => ['posticks','posblocks',],
	"output" => ['graphout','originangle','intersymbol','intercolor','interticks','gapsize','ticklines','tickheight','blockheight','rangeheight','gapgroup','postext',],
	"graphout" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"posticks" => 'Out',
	"posblocks" => 'In',
	"graphout" => 'postscript',
	"originangle" => '90',
	"intersymbol" => 'Y',
	"intercolor" => '1',
	"interticks" => 'N',
	"gapsize" => '500',
	"ticklines" => 'N',
	"tickheight" => '1',
	"blockheight" => '1',
	"rangeheight" => '1',
	"gapgroup" => '1',
	"postext" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"inputfile" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"posticks" => { "perl" => '1' },
	"posblocks" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"graphout" => { "perl" => '1' },
	"originangle" => { "perl" => '1' },
	"intersymbol" => { "perl" => '1' },
	"intercolor" => { "perl" => '1' },
	"interticks" => { "perl" => '1' },
	"gapsize" => { "perl" => '1' },
	"ticklines" => { "perl" => '1' },
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
	"input" => 0,
	"inputfile" => 0,
	"required" => 0,
	"posticks" => 0,
	"posblocks" => 0,
	"output" => 0,
	"graphout" => 0,
	"originangle" => 0,
	"intersymbol" => 0,
	"intercolor" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
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
	"input" => 0,
	"inputfile" => 0,
	"required" => 0,
	"posticks" => 1,
	"posblocks" => 1,
	"output" => 0,
	"graphout" => 0,
	"originangle" => 0,
	"intersymbol" => 0,
	"intercolor" => 0,
	"interticks" => 0,
	"gapsize" => 0,
	"ticklines" => 0,
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

