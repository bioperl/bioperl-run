
=head1 NAME

Bio::Tools::Run::PiseApplication::silent

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::silent

      Bioperl class for:

	SILENT	Silent mutation restriction enzyme scan (EMBOSS)

      Parameters:


		silent (String)


		init (String)


		input (Paragraph)
			input Section

		seq (Sequence)
			seq [single sequence] (-seq)
			pipe: seqfile

		required (Paragraph)
			required Section

		enzymes (String)
			Comma separated enzyme list (-enzymes)

		output (Paragraph)
			output Section

		sshow (Switch)
			Display untranslated sequence (-sshow)

		tshow (Switch)
			Display translated sequence (-tshow)

		allmut (Switch)
			Display all mutations (-allmut)

		outf (OutFile)
			outf (-outf)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::silent;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $silent = Bio::Tools::Run::PiseApplication::silent->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::silent object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $silent = $factory->program('silent');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::silent.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/silent.pm

    $self->{COMMAND}   = "silent";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SILENT";

    $self->{DESCRIPTION}   = "Silent mutation restriction enzyme scan (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:restriction",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/silent.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"silent",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"silent",
	"init",
	"input", 	# input Section
	"seq", 	# seq [single sequence] (-seq)
	"required", 	# required Section
	"enzymes", 	# Comma separated enzyme list (-enzymes)
	"output", 	# output Section
	"sshow", 	# Display untranslated sequence (-sshow)
	"tshow", 	# Display translated sequence (-tshow)
	"allmut", 	# Display all mutations (-allmut)
	"outf", 	# outf (-outf)
	"auto",

    ];

    $self->{TYPE}  = {
	"silent" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seq" => 'Sequence',
	"required" => 'Paragraph',
	"enzymes" => 'String',
	"output" => 'Paragraph',
	"sshow" => 'Switch',
	"tshow" => 'Switch',
	"allmut" => 'Switch',
	"outf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"seq" => {
		"perl" => '" -seq=$value -sformat=fasta"',
	},
	"required" => {
	},
	"enzymes" => {
		"perl" => '" -enzymes=$value"',
	},
	"output" => {
	},
	"sshow" => {
		"perl" => '($value)? " -sshow" : ""',
	},
	"tshow" => {
		"perl" => '($value)? " -tshow" : ""',
	},
	"allmut" => {
		"perl" => '($value)? " -allmut" : ""',
	},
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"silent" => {
		"perl" => '"silent"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"seq" => 1,
	"enzymes" => 2,
	"sshow" => 3,
	"tshow" => 4,
	"allmut" => 5,
	"outf" => 6,
	"auto" => 7,
	"silent" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"silent",
	"seq",
	"enzymes",
	"sshow",
	"tshow",
	"allmut",
	"outf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"seq" => 0,
	"required" => 0,
	"enzymes" => 0,
	"output" => 0,
	"sshow" => 0,
	"tshow" => 0,
	"allmut" => 0,
	"outf" => 0,
	"auto" => 1,
	"silent" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"seq" => 0,
	"required" => 0,
	"enzymes" => 0,
	"output" => 0,
	"sshow" => 0,
	"tshow" => 0,
	"allmut" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"seq" => 1,
	"required" => 0,
	"enzymes" => 1,
	"output" => 0,
	"sshow" => 0,
	"tshow" => 0,
	"allmut" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"seq" => "seq [single sequence] (-seq)",
	"required" => "required Section",
	"enzymes" => "Comma separated enzyme list (-enzymes)",
	"output" => "output Section",
	"sshow" => "Display untranslated sequence (-sshow)",
	"tshow" => "Display translated sequence (-tshow)",
	"allmut" => "Display all mutations (-allmut)",
	"outf" => "outf (-outf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"seq" => 0,
	"required" => 0,
	"enzymes" => 0,
	"output" => 0,
	"sshow" => 0,
	"tshow" => 0,
	"allmut" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['seq',],
	"required" => ['enzymes',],
	"output" => ['sshow','tshow','allmut','outf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"enzymes" => 'all',
	"sshow" => '0',
	"tshow" => '0',
	"allmut" => '0',
	"outf" => 'outf.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"enzymes" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"sshow" => { "perl" => '1' },
	"tshow" => { "perl" => '1' },
	"allmut" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"seq" => 0,
	"required" => 0,
	"enzymes" => 0,
	"output" => 0,
	"sshow" => 0,
	"tshow" => 0,
	"allmut" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"seq" => 1,
	"required" => 0,
	"enzymes" => 1,
	"output" => 0,
	"sshow" => 0,
	"tshow" => 0,
	"allmut" => 0,
	"outf" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/silent.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

