
=head1 NAME

Bio::Tools::Run::PiseApplication::freak

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::freak

      Bioperl class for:

	FREAK	Residue/base frequency table or plot (EMBOSS)

      Parameters:


		freak (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		seqall (Sequence)
			seqall -- any [sequences] (-seqall)
			pipe: seqsfile

		required (Paragraph)
			required Section

		letters (String)
			Residue letters (-letters)

		advanced (Paragraph)
			advanced Section

		step (Integer)
			Stepping value (-step)

		window (Integer)
			Averaging window (-window)

		output (Paragraph)
			output Section

		plot (Switch)
			Produce graphic (-plot)

		graph (Excl)
			graph (-graph)

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
package Bio::Tools::Run::PiseApplication::freak;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $freak = Bio::Tools::Run::PiseApplication::freak->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::freak object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $freak = $factory->program('freak');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::freak.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/freak.pm

    $self->{COMMAND}   = "freak";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FREAK";

    $self->{DESCRIPTION}   = "Residue/base frequency table or plot (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:composition",

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/freak.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"freak",
	"init",
	"input",
	"required",
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
	"freak",
	"init",
	"input", 	# input Section
	"seqall", 	# seqall -- any [sequences] (-seqall)
	"required", 	# required Section
	"letters", 	# Residue letters (-letters)
	"advanced", 	# advanced Section
	"step", 	# Stepping value (-step)
	"window", 	# Averaging window (-window)
	"output", 	# output Section
	"plot", 	# Produce graphic (-plot)
	"graph", 	# graph (-graph)
	"outfile", 	# outfile (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"freak" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seqall" => 'Sequence',
	"required" => 'Paragraph',
	"letters" => 'String',
	"advanced" => 'Paragraph',
	"step" => 'Integer',
	"window" => 'Integer',
	"output" => 'Paragraph',
	"plot" => 'Switch',
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
	"seqall" => {
		"perl" => '" -seqall=$value -sformat=fasta"',
	},
	"required" => {
	},
	"letters" => {
		"perl" => '" -letters=$value"',
	},
	"advanced" => {
	},
	"step" => {
		"perl" => '(defined $value && $value != $vdef)? " -step=$value" : ""',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"output" => {
	},
	"plot" => {
		"perl" => '($value)? " -plot" : ""',
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
		"perl" => '" -goutfile=freak"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"freak" => {
		"perl" => '"freak"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"seqall" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"seqall" => 1,
	"letters" => 2,
	"step" => 3,
	"window" => 4,
	"plot" => 5,
	"graph" => 6,
	"outfile" => 7,
	"auto" => 8,
	"psouput" => 100,
	"freak" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"freak",
	"required",
	"output",
	"advanced",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"seqall",
	"letters",
	"step",
	"window",
	"plot",
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
	"seqall" => 0,
	"required" => 0,
	"letters" => 0,
	"advanced" => 0,
	"step" => 0,
	"window" => 0,
	"output" => 0,
	"plot" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"freak" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"required" => 0,
	"letters" => 0,
	"advanced" => 0,
	"step" => 0,
	"window" => 0,
	"output" => 0,
	"plot" => 0,
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
	"seqall" => 1,
	"required" => 0,
	"letters" => 1,
	"advanced" => 0,
	"step" => 0,
	"window" => 0,
	"output" => 0,
	"plot" => 0,
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
	"seqall" => "seqall -- any [sequences] (-seqall)",
	"required" => "required Section",
	"letters" => "Residue letters (-letters)",
	"advanced" => "advanced Section",
	"step" => "Stepping value (-step)",
	"window" => "Averaging window (-window)",
	"output" => "output Section",
	"plot" => "Produce graphic (-plot)",
	"graph" => "graph (-graph)",
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
	"seqall" => 0,
	"required" => 0,
	"letters" => 0,
	"advanced" => 0,
	"step" => 0,
	"window" => 0,
	"output" => 0,
	"plot" => 0,
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

	"input" => ['seqall',],
	"required" => ['letters',],
	"advanced" => ['step','window',],
	"output" => ['plot','graph','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"letters" => 'gc',
	"step" => '1',
	"window" => '30',
	"plot" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"seqall" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"letters" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"step" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"plot" => { "perl" => '1' },
	"graph" => {
		"perl" => '$plot',
		"acd" => '$plot',
	},
	"outfile" => {
		"acd" => '@(!$(plot))',
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
	"seqall" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"required" => 0,
	"letters" => 0,
	"advanced" => 0,
	"step" => 0,
	"window" => 0,
	"output" => 0,
	"plot" => 0,
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
	"seqall" => 1,
	"required" => 0,
	"letters" => 1,
	"advanced" => 0,
	"step" => 0,
	"window" => 0,
	"output" => 0,
	"plot" => 0,
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

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/freak.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

