
=head1 NAME

Bio::Tools::Run::PiseApplication::abiview

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::abiview

      Bioperl class for:

	ABIVIEW	Reads ABI file and display the trace (EMBOSS)

      Parameters:


		abiview (String)


		init (String)


		input (Paragraph)
			input Section

		fname (String)
			Name of the ABI trace file (-fname)

		output (Paragraph)
			output Section

		outseq (OutFile)
			Sequence file (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: Sequence file

		graph (Excl)
			graph (-graph)

		separate (Switch)
			Separate the trace graphs for the 4 bases (-separate)

		yticks (Switch)
			Display y-axis ticks (-yticks)

		sequence (Switch)
			Display the sequence on the graph (-sequence)

		window (Integer)
			Sequence display window size (-window)

		bases (String)
			Base graphs to be displayed (-bases)

		auto (String)


		psouput (String)


		psresults (Results)


		metaresults (Results)


		dataresults (Results)


		pngresults (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::abiview;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $abiview = Bio::Tools::Run::PiseApplication::abiview->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::abiview object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $abiview = $factory->program('abiview');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::abiview.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/abiview.pm

    $self->{COMMAND}   = "abiview";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ABIVIEW";

    $self->{DESCRIPTION}   = "Reads ABI file and display the trace (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/abiview.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"abiview",
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
	"abiview",
	"init",
	"input", 	# input Section
	"fname", 	# Name of the ABI trace file (-fname)
	"output", 	# output Section
	"outseq", 	# Sequence file (-outseq)
	"outseq_sformat", 	# Output format for: Sequence file
	"graph", 	# graph (-graph)
	"separate", 	# Separate the trace graphs for the 4 bases (-separate)
	"yticks", 	# Display y-axis ticks (-yticks)
	"sequence", 	# Display the sequence on the graph (-sequence)
	"window", 	# Sequence display window size (-window)
	"bases", 	# Base graphs to be displayed (-bases)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"abiview" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"fname" => 'String',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"graph" => 'Excl',
	"separate" => 'Switch',
	"yticks" => 'Switch',
	"sequence" => 'Switch',
	"window" => 'Integer',
	"bases" => 'String',
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
	"fname" => {
		"perl" => '" -fname=$value"',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"separate" => {
		"perl" => '($value)? " -separate" : ""',
	},
	"yticks" => {
		"perl" => '($value)? " -yticks" : ""',
	},
	"sequence" => {
		"perl" => '($value)? "" : " -nosequence"',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"bases" => {
		"perl" => '($value && $value ne $vdef)? " -bases=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=abiview"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"abiview" => {
		"perl" => '"abiview"',
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
	"fname" => 1,
	"outseq" => 2,
	"outseq_sformat" => 3,
	"graph" => 4,
	"separate" => 5,
	"yticks" => 6,
	"sequence" => 7,
	"window" => 8,
	"bases" => 9,
	"auto" => 10,
	"psouput" => 100,
	"abiview" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"abiview",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"fname",
	"outseq",
	"outseq_sformat",
	"graph",
	"separate",
	"yticks",
	"sequence",
	"window",
	"bases",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"abiview" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"fname" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"graph" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"fname" => "Name of the ABI trace file (-fname)",
	"output" => "output Section",
	"outseq" => "Sequence file (-outseq)",
	"outseq_sformat" => "Output format for: Sequence file",
	"graph" => "graph (-graph)",
	"separate" => "Separate the trace graphs for the 4 bases (-separate)",
	"yticks" => "Display y-axis ticks (-yticks)",
	"sequence" => "Display the sequence on the graph (-sequence)",
	"window" => "Sequence display window size (-window)",
	"bases" => "Base graphs to be displayed (-bases)",
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
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['fname',],
	"output" => ['outseq','outseq_sformat','graph','separate','yticks','sequence','window','bases',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"graph" => 'postscript',
	"separate" => '0',
	"yticks" => '0',
	"sequence" => '1',
	"window" => '40',
	"bases" => 'GATC',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"fname" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"separate" => { "perl" => '1' },
	"yticks" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"bases" => { "perl" => '1' },
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
	"outseq" => {
		 '1' => "seqfile",
	},

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
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"fname" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"graph" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/abiview.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

