
=head1 NAME

Bio::Tools::Run::PiseApplication::iep

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::iep

      Bioperl class for:

	IEP	Calculates the isoelectric point of a protein (EMBOSS)

      Parameters:


		iep (String)


		init (String)


		input (Paragraph)
			input Section

		sequencea (Sequence)
			sequencea -- pureprotein [sequences] (-sequencea)
			pipe: seqsfile

		advanced (Paragraph)
			advanced Section

		step (Float)
			pH step value (-step)

		amino (Integer)
			Number of N-termini (-amino)

		termini (Switch)
			Include charge at N and C terminus (-termini)

		output (Paragraph)
			output Section

		plot (Switch)
			Plot charge vs pH (-plot)

		report (Switch)
			Write results to a file (-report)

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
package Bio::Tools::Run::PiseApplication::iep;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $iep = Bio::Tools::Run::PiseApplication::iep->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::iep object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $iep = $factory->program('iep');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::iep.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/iep.pm

    $self->{COMMAND}   = "iep";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "IEP";

    $self->{DESCRIPTION}   = "Calculates the isoelectric point of a protein (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/iep.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"iep",
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
	"iep",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- pureprotein [sequences] (-sequencea)
	"advanced", 	# advanced Section
	"step", 	# pH step value (-step)
	"amino", 	# Number of N-termini (-amino)
	"termini", 	# Include charge at N and C terminus (-termini)
	"output", 	# output Section
	"plot", 	# Plot charge vs pH (-plot)
	"report", 	# Write results to a file (-report)
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
	"iep" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"advanced" => 'Paragraph',
	"step" => 'Float',
	"amino" => 'Integer',
	"termini" => 'Switch',
	"output" => 'Paragraph',
	"plot" => 'Switch',
	"report" => 'Switch',
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
	"advanced" => {
	},
	"step" => {
		"perl" => '(defined $value && $value != $vdef)? " -step=$value" : ""',
	},
	"amino" => {
		"perl" => '(defined $value && $value != $vdef)? " -amino=$value" : ""',
	},
	"termini" => {
		"perl" => '($value)? "" : " -notermini"',
	},
	"output" => {
	},
	"plot" => {
		"perl" => '($value)? " -plot" : ""',
	},
	"report" => {
		"perl" => '($value)? "" : " -noreport"',
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
		"perl" => '" -goutfile=iep"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"iep" => {
		"perl" => '"iep"',
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

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"step" => 2,
	"amino" => 3,
	"termini" => 4,
	"plot" => 5,
	"report" => 6,
	"graph" => 7,
	"outfile" => 8,
	"auto" => 9,
	"psouput" => 100,
	"iep" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"iep",
	"advanced",
	"psresults",
	"output",
	"metaresults",
	"dataresults",
	"pngresults",
	"sequencea",
	"step",
	"amino",
	"termini",
	"plot",
	"report",
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
	"advanced" => 0,
	"step" => 0,
	"amino" => 0,
	"termini" => 0,
	"output" => 0,
	"plot" => 0,
	"report" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"iep" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"step" => 0,
	"amino" => 0,
	"termini" => 0,
	"output" => 0,
	"plot" => 0,
	"report" => 0,
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
	"advanced" => 0,
	"step" => 0,
	"amino" => 0,
	"termini" => 0,
	"output" => 0,
	"plot" => 0,
	"report" => 0,
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
	"sequencea" => "sequencea -- pureprotein [sequences] (-sequencea)",
	"advanced" => "advanced Section",
	"step" => "pH step value (-step)",
	"amino" => "Number of N-termini (-amino)",
	"termini" => "Include charge at N and C terminus (-termini)",
	"output" => "output Section",
	"plot" => "Plot charge vs pH (-plot)",
	"report" => "Write results to a file (-report)",
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
	"sequencea" => 0,
	"advanced" => 0,
	"step" => 0,
	"amino" => 0,
	"termini" => 0,
	"output" => 0,
	"plot" => 0,
	"report" => 0,
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

	"input" => ['sequencea',],
	"advanced" => ['step','amino','termini',],
	"output" => ['plot','report','graph','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"step" => '.5',
	"amino" => '1',
	"termini" => '1',
	"plot" => '0',
	"report" => '1',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"step" => { "perl" => '1' },
	"amino" => { "perl" => '1' },
	"termini" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"plot" => { "perl" => '1' },
	"report" => { "perl" => '1' },
	"graph" => {
		"perl" => '$plot',
		"acd" => '$plot',
	},
	"outfile" => {
		"perl" => '$report',
		"acd" => '$report',
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
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"step" => 0,
	"amino" => 0,
	"termini" => 0,
	"output" => 0,
	"plot" => 0,
	"report" => 0,
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
	"advanced" => 0,
	"step" => 0,
	"amino" => 0,
	"termini" => 0,
	"output" => 0,
	"plot" => 0,
	"report" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/iep.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

