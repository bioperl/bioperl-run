
=head1 NAME

Bio::Tools::Run::PiseApplication::dottup

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dottup

      Bioperl class for:

	DOTTUP	Displays a wordmatch dotplot of two sequences (EMBOSS)

      Parameters:


		dottup (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequencea (Sequence)
			sequencea -- any [single sequence] (-sequencea)
			pipe: seqfile

		sequenceb (Sequence)
			sequenceb [single sequence] (-sequenceb)

		required (Paragraph)
			required Section

		wordsize (Integer)
			Word size (-wordsize)

		output (Paragraph)
			output Section

		stretch (Switch)
			Stretch axes (-stretch)

		data (Switch)
			Display as data (-data)

		graph (Excl)
			graph [device to be displayed on] (-graph)

		xygraph (Excl)
			xygraph (-xygraph)

		boxit (Switch)
			Draw a box around dotplot (-boxit)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

		psouput (String)
			

		psresults (Results)
			

		metaresults (Results)
			

		dataresults (Results)
			

		pngresults (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::dottup;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dottup = Bio::Tools::Run::PiseApplication::dottup->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dottup object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $dottup = $factory->program('dottup');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::dottup.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dottup.pm

    $self->{COMMAND}   = "dottup";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DOTTUP";

    $self->{DESCRIPTION}   = "Displays a wordmatch dotplot of two sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:dot plots",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/dottup.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dottup",
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
	"dottup",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- any [single sequence] (-sequencea)
	"sequenceb", 	# sequenceb [single sequence] (-sequenceb)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"stretch", 	# Stretch axes (-stretch)
	"data", 	# Display as data (-data)
	"graph", 	# graph [device to be displayed on] (-graph)
	"xygraph", 	# xygraph (-xygraph)
	"boxit", 	# Draw a box around dotplot (-boxit)
	"outfile", 	# outfile (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"dottup" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"sequenceb" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"stretch" => 'Switch',
	"data" => 'Switch',
	"graph" => 'Excl',
	"xygraph" => 'Excl',
	"boxit" => 'Switch',
	"outfile" => 'OutFile',
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
	"sequencea" => {
		"perl" => '" -sequencea=$value -sformat=fasta"',
	},
	"sequenceb" => {
		"perl" => '" -sequenceb=$value -sformat=fasta"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"stretch" => {
		"perl" => '($value)? " -stretch" : ""',
	},
	"data" => {
		"perl" => '($value)? " -data" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"xygraph" => {
		"perl" => '($value)? " -xygraph=$value" : ""',
	},
	"boxit" => {
		"perl" => '($value)? "" : " -noboxit"',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=dottup"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"dottup" => {
		"perl" => '"dottup"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],
	"sequenceb" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"sequenceb" => 2,
	"wordsize" => 3,
	"stretch" => 4,
	"data" => 5,
	"graph" => 6,
	"xygraph" => 7,
	"boxit" => 8,
	"outfile" => 9,
	"auto" => 10,
	"psouput" => 100,
	"dottup" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pngresults",
	"dottup",
	"required",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"sequencea",
	"sequenceb",
	"wordsize",
	"stretch",
	"data",
	"graph",
	"xygraph",
	"boxit",
	"outfile",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"boxit" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"dottup" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"boxit" => 0,
	"outfile" => 0,
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
	"sequencea" => 1,
	"sequenceb" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"boxit" => 0,
	"outfile" => 0,
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
	"sequencea" => "sequencea -- any [single sequence] (-sequencea)",
	"sequenceb" => "sequenceb [single sequence] (-sequenceb)",
	"required" => "required Section",
	"wordsize" => "Word size (-wordsize)",
	"output" => "output Section",
	"stretch" => "Stretch axes (-stretch)",
	"data" => "Display as data (-data)",
	"graph" => "graph [device to be displayed on] (-graph)",
	"xygraph" => "xygraph (-xygraph)",
	"boxit" => "Draw a box around dotplot (-boxit)",
	"outfile" => "outfile (-outfile)",
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
	"sequencea" => 0,
	"sequenceb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"boxit" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea','sequenceb',],
	"required" => ['wordsize',],
	"output" => ['stretch','data','graph','xygraph','boxit','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
	"xygraph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','data','data','null','null','hp7580','hp7580','colourps','colourps','text','text','tek4107t','tek4107t','none','none','tekt','tekt','hpgl','hpgl','xwindows','xwindows','meta','meta','xterm','xterm','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '4',
	"stretch" => '0',
	"data" => '0',
	"graph" => 'postscript',
	"xygraph" => 'postscript',
	"boxit" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"sequenceb" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"wordsize" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"stretch" => { "perl" => '1' },
	"data" => {
		"acd" => '@(!$(stretch))',
	},
	"graph" => {
		"acd" => '@(@(!$(data)) & @(!$(stretch)))',
	},
	"xygraph" => {
		"perl" => '$stretch',
		"acd" => '$stretch',
	},
	"boxit" => { "perl" => '1' },
	"outfile" => {
		"acd" => '@($(data) & @(!$(stretch)))',
	},
	"auto" => { "perl" => '1' },
	"psouput" => {
		"perl" => '$xygraph eq "postscript" || $xygraph eq "ps" || $xygraph eq "colourps"  || $xygraph eq "cps" || $xygraph eq "png"',
	},
	"psresults" => {
		"perl" => '$xygraph eq "postscript" || $xygraph eq "ps" || $xygraph eq "colourps" || $xygraph eq "cps"',
	},
	"metaresults" => {
		"perl" => '$xygraph eq "meta"',
	},
	"dataresults" => {
		"perl" => '$xygraph eq "data"',
	},
	"pngresults" => {
		"perl" => '$xygraph eq "png"',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequencea" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"boxit" => 0,
	"outfile" => 0,
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
	"sequencea" => 1,
	"sequenceb" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"boxit" => 0,
	"outfile" => 0,
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
	"stretch" => [
		"Use non-proportional axes",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dottup.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

