
=head1 NAME

Bio::Tools::Run::PiseApplication::plotcon

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::plotcon

      Bioperl class for:

	PLOTCON	Plots the quality of conservation of a sequence alignment (EMBOSS)

      Parameters:


		plotcon (String)


		init (String)


		input (Paragraph)
			input Section

		msf (Sequence)
			Sequences file to be read in (-msf)
			pipe: seqsfile

		required (Paragraph)
			required Section

		winsize (Integer)
			Window size (-winsize)

		advanced (Paragraph)
			advanced Section

		scorefile (Excl)
			Comparison matrix file (-scorefile)

		output (Paragraph)
			output Section

		data (Switch)
			Display as data (-data)

		graph (Excl)
			graph (-graph)

		outfile (OutFile)
			Display as data (-outfile)

		auto (String)


		psouput (String)


		psresults (Results)


		metaresults (Results)


		dataresults (Results)


		pngresults (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::plotcon;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $plotcon = Bio::Tools::Run::PiseApplication::plotcon->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::plotcon object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $plotcon = $factory->program('plotcon');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::plotcon.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/plotcon.pm

    $self->{COMMAND}   = "plotcon";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PLOTCON";

    $self->{DESCRIPTION}   = "Plots the quality of conservation of a sequence alignment (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/plotcon.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"plotcon",
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
	"plotcon",
	"init",
	"input", 	# input Section
	"msf", 	# Sequences file to be read in (-msf)
	"required", 	# required Section
	"winsize", 	# Window size (-winsize)
	"advanced", 	# advanced Section
	"scorefile", 	# Comparison matrix file (-scorefile)
	"output", 	# output Section
	"data", 	# Display as data (-data)
	"graph", 	# graph (-graph)
	"outfile", 	# Display as data (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"plotcon" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"msf" => 'Sequence',
	"required" => 'Paragraph',
	"winsize" => 'Integer',
	"advanced" => 'Paragraph',
	"scorefile" => 'Excl',
	"output" => 'Paragraph',
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
	"msf" => {
		"perl" => '" -msf=$value -sformat=fasta"',
	},
	"required" => {
	},
	"winsize" => {
		"perl" => '" -winsize=$value"',
	},
	"advanced" => {
	},
	"scorefile" => {
		"perl" => '($value)? " -scorefile=$value" : ""',
	},
	"output" => {
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
		"perl" => '" -goutfile=plotcon"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"plotcon" => {
		"perl" => '"plotcon"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"msf" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"msf" => 1,
	"winsize" => 2,
	"scorefile" => 3,
	"data" => 4,
	"graph" => 5,
	"outfile" => 6,
	"auto" => 7,
	"psouput" => 100,
	"plotcon" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pngresults",
	"required",
	"plotcon",
	"advanced",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"msf",
	"winsize",
	"scorefile",
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
	"msf" => 0,
	"required" => 0,
	"winsize" => 0,
	"advanced" => 0,
	"scorefile" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"plotcon" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"required" => 0,
	"winsize" => 0,
	"advanced" => 0,
	"scorefile" => 0,
	"output" => 0,
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
	"msf" => 1,
	"required" => 0,
	"winsize" => 1,
	"advanced" => 0,
	"scorefile" => 0,
	"output" => 0,
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
	"msf" => "Sequences file to be read in (-msf)",
	"required" => "required Section",
	"winsize" => "Window size (-winsize)",
	"advanced" => "advanced Section",
	"scorefile" => "Comparison matrix file (-scorefile)",
	"output" => "output Section",
	"data" => "Display as data (-data)",
	"graph" => "graph (-graph)",
	"outfile" => "Display as data (-outfile)",
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
	"msf" => 0,
	"required" => 0,
	"winsize" => 0,
	"advanced" => 0,
	"scorefile" => 0,
	"output" => 0,
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

	"input" => ['msf',],
	"required" => ['winsize',],
	"advanced" => ['scorefile',],
	"scorefile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['data','graph','outfile',],
	"graph" => ['colourps','colourps','tek4107t','tek4107t','tekt','tekt','hpgl','hpgl','x11','x11','cps','cps','none','none','xwindows','xwindows','tek','tek','null','null','text','text','meta','meta','xterm','xterm','ps','ps','png','png','hp7470','hp7470','postscript','postscript','data','data','hp7580','hp7580','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"winsize" => '4',
	"data" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"msf" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"winsize" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"scorefile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
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
	"msf" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"required" => 0,
	"winsize" => 0,
	"advanced" => 0,
	"scorefile" => 0,
	"output" => 0,
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
	"msf" => 1,
	"required" => 0,
	"winsize" => 1,
	"advanced" => 0,
	"scorefile" => 0,
	"output" => 0,
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
	"msf" => [
		"File containing a sequence alignment",
	],
	"winsize" => [
		"Number of columns to average alignment quality over. The larger this value is, the smoother the plot will be.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/plotcon.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

