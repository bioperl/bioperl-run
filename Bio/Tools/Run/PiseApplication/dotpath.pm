
=head1 NAME

Bio::Tools::Run::PiseApplication::dotpath

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dotpath

      Bioperl class for:

	DOTPATH	Displays a non-overlapping wordmatch dotplot of two sequences (EMBOSS)

      Parameters:


		dotpath (String)
			

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

		overlaps (Switch)
			Display the overlapping matches (-overlaps)

		boxit (Switch)
			Draw a box around dotplot (-boxit)

		datasection (Paragraph)
			datasection Section

		data (Switch)
			Display as data (-data)

		graph (Excl)
			graph [device to be displayed on] (-graph)

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
package Bio::Tools::Run::PiseApplication::dotpath;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dotpath = Bio::Tools::Run::PiseApplication::dotpath->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dotpath object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $dotpath = $factory->program('dotpath');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::dotpath.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dotpath.pm

    $self->{COMMAND}   = "dotpath";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DOTPATH";

    $self->{DESCRIPTION}   = "Displays a non-overlapping wordmatch dotplot of two sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:dot plots",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/dotpath.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dotpath",
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
	"dotpath",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- any [single sequence] (-sequencea)
	"sequenceb", 	# sequenceb [single sequence] (-sequenceb)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"overlaps", 	# Display the overlapping matches (-overlaps)
	"boxit", 	# Draw a box around dotplot (-boxit)
	"datasection", 	# datasection Section
	"data", 	# Display as data (-data)
	"graph", 	# graph [device to be displayed on] (-graph)
	"outfile", 	# outfile (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"dotpath" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"sequenceb" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"overlaps" => 'Switch',
	"boxit" => 'Switch',
	"datasection" => 'Paragraph',
	"data" => 'Switch',
	"graph" => 'Excl',
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
	"overlaps" => {
		"perl" => '($value)? " -overlaps" : ""',
	},
	"boxit" => {
		"perl" => '($value)? "" : " -noboxit"',
	},
	"datasection" => {
	},
	"data" => {
		"perl" => '($value)? " -data" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=dotpath"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"dotpath" => {
		"perl" => '"dotpath"',
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
	"overlaps" => 4,
	"boxit" => 5,
	"data" => 6,
	"graph" => 7,
	"outfile" => 8,
	"auto" => 9,
	"psouput" => 100,
	"dotpath" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pngresults",
	"dotpath",
	"required",
	"output",
	"datasection",
	"psresults",
	"metaresults",
	"dataresults",
	"sequencea",
	"sequenceb",
	"wordsize",
	"overlaps",
	"boxit",
	"data",
	"graph",
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
	"overlaps" => 0,
	"boxit" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"dotpath" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"overlaps" => 0,
	"boxit" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
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
	"overlaps" => 0,
	"boxit" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
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
	"overlaps" => "Display the overlapping matches (-overlaps)",
	"boxit" => "Draw a box around dotplot (-boxit)",
	"datasection" => "datasection Section",
	"data" => "Display as data (-data)",
	"graph" => "graph [device to be displayed on] (-graph)",
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
	"overlaps" => 0,
	"boxit" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
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
	"output" => ['overlaps','boxit','datasection',],
	"datasection" => ['data','graph','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '4',
	"overlaps" => '0',
	"boxit" => '1',
	"data" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"sequenceb" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"wordsize" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"overlaps" => { "perl" => '1' },
	"boxit" => { "perl" => '1' },
	"datasection" => { "perl" => '1' },
	"data" => { "perl" => '1' },
	"graph" => {
		"acd" => '@(!$(data))',
	},
	"outfile" => {
		"perl" => '$data',
		"acd" => '$data',
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
	"overlaps" => 0,
	"boxit" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
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
	"overlaps" => 0,
	"boxit" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
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
	"overlaps" => [
		"Displays the overlapping matches (in red) as well as the minimal set of non-overlapping matches",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dotpath.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

