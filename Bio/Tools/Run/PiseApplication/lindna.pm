
=head1 NAME

Bio::Tools::Run::PiseApplication::lindna

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::lindna

      Bioperl class for:

	LINDNA	Draws linear maps of DNA constructs (EMBOSS)

      Parameters:


		lindna (String)


		init (String)


		input (Paragraph)
			input Section

		inputfile (InFile)
			input file containing mapping data (-inputfile)

		output (Paragraph)
			output Section

		graphout (Excl)
			graphout [device to be displayed on] (-graphout)

		intersymbol (String)
			type of junctions between blocks (enter Straight, Up, Down, or No) (-intersymbol)

		intercolor (Integer)
			color of junctions between blocks (enter a color number) (-intercolor)

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
package Bio::Tools::Run::PiseApplication::lindna;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $lindna = Bio::Tools::Run::PiseApplication::lindna->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::lindna object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $lindna = $factory->program('lindna');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::lindna.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lindna.pm

    $self->{COMMAND}   = "lindna";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "LINDNA";

    $self->{DESCRIPTION}   = "Draws linear maps of DNA constructs (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/lindna.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"lindna",
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
	"lindna",
	"init",
	"input", 	# input Section
	"inputfile", 	# input file containing mapping data (-inputfile)
	"output", 	# output Section
	"graphout", 	# graphout [device to be displayed on] (-graphout)
	"intersymbol", 	# type of junctions between blocks (enter Straight, Up, Down, or No) (-intersymbol)
	"intercolor", 	# color of junctions between blocks (enter a color number) (-intercolor)
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
	"lindna" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"inputfile" => 'InFile',
	"output" => 'Paragraph',
	"graphout" => 'Excl',
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
	"output" => {
	},
	"graphout" => {
		"perl" => '($value)? " -graphout=$value" : ""',
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
		"perl" => '" -goutfile=lindna"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"lindna" => {
		"perl" => '"lindna"',
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
	"graphout" => 2,
	"intersymbol" => 3,
	"intercolor" => 4,
	"interticks" => 5,
	"gapsize" => 6,
	"ticklines" => 7,
	"tickheight" => 8,
	"blockheight" => 9,
	"rangeheight" => 10,
	"gapgroup" => 11,
	"postext" => 12,
	"auto" => 13,
	"psouput" => 100,
	"lindna" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"lindna",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"inputfile",
	"graphout",
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
	"output" => 0,
	"graphout" => 0,
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
	"lindna" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"inputfile" => 0,
	"output" => 0,
	"graphout" => 0,
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
	"output" => 0,
	"graphout" => 0,
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
	"output" => "output Section",
	"graphout" => "graphout [device to be displayed on] (-graphout)",
	"intersymbol" => "type of junctions between blocks (enter Straight, Up, Down, or No) (-intersymbol)",
	"intercolor" => "color of junctions between blocks (enter a color number) (-intercolor)",
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
	"output" => 0,
	"graphout" => 0,
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
	"output" => ['graphout','intersymbol','intercolor','interticks','gapsize','ticklines','tickheight','blockheight','rangeheight','gapgroup','postext',],
	"graphout" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"graphout" => 'postscript',
	"intersymbol" => 'Straight',
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
	"output" => { "perl" => '1' },
	"graphout" => { "perl" => '1' },
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
	"output" => 0,
	"graphout" => 0,
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
	"output" => 0,
	"graphout" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lindna.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

