
=head1 NAME

Bio::Tools::Run::PiseApplication::pepinfo

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pepinfo

      Bioperl class for:

	PEPINFO	Plots simple amino acid properties in parallel (EMBOSS)

      Parameters:


		pepinfo (String)


		init (String)


		input (Paragraph)
			input Section

		inseq (Sequence)
			inseq -- protein [single sequence] (-inseq)
			pipe: seqfile

		output (Paragraph)
			output Section

		graph (Excl)
			graph (-graph)

		outfile (OutFile)
			outfile (-outfile)

		generalplot (Switch)
			plot histogram of general properties (-generalplot)

		hydropathyplot (Switch)
			plot graphs of hydropathy (-hydropathyplot)

		advanced (Paragraph)
			advanced Section

		hwindow (Integer)
			Window size for hydropathy averaging (-hwindow)

		aaproperties (String)
			Enter user defined file of amino acid properties or leave blank (-aaproperties)

		aahydropathy (String)
			Enter user defined file of hydropathy data or leave blank (-aahydropathy)

		auto (String)


		psouput (String)


		psresults (Results)


		metaresults (Results)


		dataresults (Results)


		pngresults (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::pepinfo;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pepinfo = Bio::Tools::Run::PiseApplication::pepinfo->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pepinfo object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pepinfo = $factory->program('pepinfo');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pepinfo.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepinfo.pm

    $self->{COMMAND}   = "pepinfo";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PEPINFO";

    $self->{DESCRIPTION}   = "Plots simple amino acid properties in parallel (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pepinfo.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pepinfo",
	"init",
	"input",
	"output",
	"advanced",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pepinfo",
	"init",
	"input", 	# input Section
	"inseq", 	# inseq -- protein [single sequence] (-inseq)
	"output", 	# output Section
	"graph", 	# graph (-graph)
	"outfile", 	# outfile (-outfile)
	"generalplot", 	# plot histogram of general properties (-generalplot)
	"hydropathyplot", 	# plot graphs of hydropathy (-hydropathyplot)
	"advanced", 	# advanced Section
	"hwindow", 	# Window size for hydropathy averaging (-hwindow)
	"aaproperties", 	# Enter user defined file of amino acid properties or leave blank (-aaproperties)
	"aahydropathy", 	# Enter user defined file of hydropathy data or leave blank (-aahydropathy)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"pepinfo" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"inseq" => 'Sequence',
	"output" => 'Paragraph',
	"graph" => 'Excl',
	"outfile" => 'OutFile',
	"generalplot" => 'Switch',
	"hydropathyplot" => 'Switch',
	"advanced" => 'Paragraph',
	"hwindow" => 'Integer',
	"aaproperties" => 'String',
	"aahydropathy" => 'String',
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
	"inseq" => {
		"perl" => '" -inseq=$value -sformat=fasta"',
	},
	"output" => {
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"generalplot" => {
		"perl" => '($value)? "" : " -nogeneralplot"',
	},
	"hydropathyplot" => {
		"perl" => '($value)? "" : " -nohydropathyplot"',
	},
	"advanced" => {
	},
	"hwindow" => {
		"perl" => '(defined $value && $value != $vdef)? " -hwindow=$value" : ""',
	},
	"aaproperties" => {
		"perl" => '($value && $value ne $vdef)? " -aaproperties=$value" : ""',
	},
	"aahydropathy" => {
		"perl" => '($value && $value ne $vdef)? " -aahydropathy=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=pepinfo"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"pepinfo" => {
		"perl" => '"pepinfo"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"inseq" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"inseq" => 1,
	"graph" => 2,
	"outfile" => 3,
	"generalplot" => 4,
	"hydropathyplot" => 5,
	"hwindow" => 6,
	"aaproperties" => 7,
	"aahydropathy" => 8,
	"auto" => 9,
	"psouput" => 100,
	"pepinfo" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pepinfo",
	"output",
	"advanced",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"inseq",
	"graph",
	"outfile",
	"generalplot",
	"hydropathyplot",
	"hwindow",
	"aaproperties",
	"aahydropathy",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"inseq" => 0,
	"output" => 0,
	"graph" => 0,
	"outfile" => 0,
	"generalplot" => 0,
	"hydropathyplot" => 0,
	"advanced" => 0,
	"hwindow" => 0,
	"aaproperties" => 0,
	"aahydropathy" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"pepinfo" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"inseq" => 0,
	"output" => 0,
	"graph" => 0,
	"outfile" => 0,
	"generalplot" => 0,
	"hydropathyplot" => 0,
	"advanced" => 0,
	"hwindow" => 0,
	"aaproperties" => 0,
	"aahydropathy" => 0,
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
	"inseq" => 1,
	"output" => 0,
	"graph" => 0,
	"outfile" => 1,
	"generalplot" => 0,
	"hydropathyplot" => 0,
	"advanced" => 0,
	"hwindow" => 0,
	"aaproperties" => 0,
	"aahydropathy" => 0,
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
	"inseq" => "inseq -- protein [single sequence] (-inseq)",
	"output" => "output Section",
	"graph" => "graph (-graph)",
	"outfile" => "outfile (-outfile)",
	"generalplot" => "plot histogram of general properties (-generalplot)",
	"hydropathyplot" => "plot graphs of hydropathy (-hydropathyplot)",
	"advanced" => "advanced Section",
	"hwindow" => "Window size for hydropathy averaging (-hwindow)",
	"aaproperties" => "Enter user defined file of amino acid properties or leave blank (-aaproperties)",
	"aahydropathy" => "Enter user defined file of hydropathy data or leave blank (-aahydropathy)",
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
	"inseq" => 0,
	"output" => 0,
	"graph" => 0,
	"outfile" => 0,
	"generalplot" => 0,
	"hydropathyplot" => 0,
	"advanced" => 0,
	"hwindow" => 0,
	"aaproperties" => 0,
	"aahydropathy" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['inseq',],
	"output" => ['graph','outfile','generalplot','hydropathyplot',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
	"advanced" => ['hwindow','aaproperties','aahydropathy',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"graph" => 'postscript',
	"outfile" => 'pepinfo.out',
	"generalplot" => '1',
	"hydropathyplot" => '1',
	"hwindow" => '9',
	"aaproperties" => 'Eaa_properties.dat',
	"aahydropathy" => 'Eaa_hydropathy.dat',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"inseq" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"generalplot" => { "perl" => '1' },
	"hydropathyplot" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"hwindow" => { "perl" => '1' },
	"aaproperties" => { "perl" => '1' },
	"aahydropathy" => { "perl" => '1' },
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
	"inseq" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"inseq" => 0,
	"output" => 0,
	"graph" => 0,
	"outfile" => 0,
	"generalplot" => 0,
	"hydropathyplot" => 0,
	"advanced" => 0,
	"hwindow" => 0,
	"aaproperties" => 0,
	"aahydropathy" => 0,
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
	"inseq" => 1,
	"output" => 0,
	"graph" => 0,
	"outfile" => 1,
	"generalplot" => 0,
	"hydropathyplot" => 0,
	"advanced" => 0,
	"hwindow" => 0,
	"aaproperties" => 0,
	"aahydropathy" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepinfo.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

