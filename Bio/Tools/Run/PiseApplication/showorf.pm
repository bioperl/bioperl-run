
=head1 NAME

Bio::Tools::Run::PiseApplication::showorf

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::showorf

      Bioperl class for:

	SHOWORF	Pretty output of DNA translations (EMBOSS)

      Parameters:


		showorf (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- DNA [single sequence] (-sequence)
			pipe: seqfile

		required (Paragraph)
			required Section

		frames (List)
			Select one or more values -- Select Frames To Translate [select  values] (-frames)

		advanced (Paragraph)
			advanced Section

		cfile (Excl)
			Codon usage file (-cfile)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		ruler (Switch)
			Add a ruler (-ruler)

		plabel (Switch)
			Number translations (-plabel)

		nlabel (Switch)
			Number DNA sequence (-nlabel)

		width (Integer)
			Width of screen (-width)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::showorf;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $showorf = Bio::Tools::Run::PiseApplication::showorf->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::showorf object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $showorf = $factory->program('showorf');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::showorf.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showorf.pm

    $self->{COMMAND}   = "showorf";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SHOWORF";

    $self->{DESCRIPTION}   = "Pretty output of DNA translations (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:gene finding",

         "nucleic:translation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/showorf.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"showorf",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"showorf",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [single sequence] (-sequence)
	"required", 	# required Section
	"frames", 	# Select one or more values -- Select Frames To Translate [select  values] (-frames)
	"advanced", 	# advanced Section
	"cfile", 	# Codon usage file (-cfile)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"ruler", 	# Add a ruler (-ruler)
	"plabel", 	# Number translations (-plabel)
	"nlabel", 	# Number DNA sequence (-nlabel)
	"width", 	# Width of screen (-width)
	"auto",

    ];

    $self->{TYPE}  = {
	"showorf" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"frames" => 'List',
	"advanced" => 'Paragraph',
	"cfile" => 'Excl',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"ruler" => 'Switch',
	"plabel" => 'Switch',
	"nlabel" => 'Switch',
	"width" => 'Integer',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"frames" => {
		"perl" => '" -frames=$value"',
	},
	"advanced" => {
	},
	"cfile" => {
		"perl" => '($value && $value ne $vdef)? " -cfile=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"ruler" => {
		"perl" => '($value)? "" : " -noruler"',
	},
	"plabel" => {
		"perl" => '($value)? "" : " -noplabel"',
	},
	"nlabel" => {
		"perl" => '($value)? "" : " -nonlabel"',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"showorf" => {
		"perl" => '"showorf"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"frames" => 2,
	"cfile" => 3,
	"outfile" => 4,
	"ruler" => 5,
	"plabel" => 6,
	"nlabel" => 7,
	"width" => 8,
	"auto" => 9,
	"showorf" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"showorf",
	"sequence",
	"frames",
	"cfile",
	"outfile",
	"ruler",
	"plabel",
	"nlabel",
	"width",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"frames" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"width" => 0,
	"auto" => 1,
	"showorf" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"frames" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"frames" => 1,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 1,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [single sequence] (-sequence)",
	"required" => "required Section",
	"frames" => "Select one or more values -- Select Frames To Translate [select  values] (-frames)",
	"advanced" => "advanced Section",
	"cfile" => "Codon usage file (-cfile)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"ruler" => "Add a ruler (-ruler)",
	"plabel" => "Number translations (-plabel)",
	"nlabel" => "Number DNA sequence (-nlabel)",
	"width" => "Width of screen (-width)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"frames" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['frames',],
	"frames" => ['0','None','1','F1','2','F2','3','F3','4','R1','5','R2','6','R3',],
	"advanced" => ['cfile',],
	"cfile" => ['0','','1','','2','','3','','4','','5','','6','',],
	"output" => ['outfile','ruler','plabel','nlabel','width',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"frames" => ",",

    };

    $self->{VDEF}  = {
	"frames" => ['1,2,3,4,5,6',],
	"cfile" => 'Ehum.cut',
	"outfile" => 'outfile.out',
	"ruler" => '1',
	"plabel" => '1',
	"nlabel" => '1',
	"width" => '50',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"frames" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"cfile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"ruler" => { "perl" => '1' },
	"plabel" => { "perl" => '1' },
	"nlabel" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"frames" => 0,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 0,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"frames" => 1,
	"advanced" => 0,
	"cfile" => 0,
	"output" => 0,
	"outfile" => 1,
	"ruler" => 0,
	"plabel" => 0,
	"nlabel" => 0,
	"width" => 0,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showorf.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

