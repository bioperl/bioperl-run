
=head1 NAME

Bio::Tools::Run::PiseApplication::recoder

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::recoder

      Bioperl class for:

	RECODER	Remove restriction sites but maintain the same translation (EMBOSS)

      Parameters:


		recoder (String)


		init (String)


		input (Paragraph)
			input Section

		seq (Sequence)
			Nucleic acid sequence (-seq)
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

		outf (OutFile)
			Results file name (-outf)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::recoder;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $recoder = Bio::Tools::Run::PiseApplication::recoder->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::recoder object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $recoder = $factory->program('recoder');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::recoder.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/recoder.pm

    $self->{COMMAND}   = "recoder";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "RECODER";

    $self->{DESCRIPTION}   = "Remove restriction sites but maintain the same translation (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:restriction",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/recoder.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"recoder",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"recoder",
	"init",
	"input", 	# input Section
	"seq", 	# Nucleic acid sequence (-seq)
	"required", 	# required Section
	"enzymes", 	# Comma separated enzyme list (-enzymes)
	"output", 	# output Section
	"sshow", 	# Display untranslated sequence (-sshow)
	"tshow", 	# Display translated sequence (-tshow)
	"outf", 	# Results file name (-outf)
	"auto",

    ];

    $self->{TYPE}  = {
	"recoder" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seq" => 'Sequence',
	"required" => 'Paragraph',
	"enzymes" => 'String',
	"output" => 'Paragraph',
	"sshow" => 'Switch',
	"tshow" => 'Switch',
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
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"recoder" => {
		"perl" => '"recoder"',
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
	"outf" => 5,
	"auto" => 6,
	"recoder" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"recoder",
	"seq",
	"enzymes",
	"sshow",
	"tshow",
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
	"outf" => 0,
	"auto" => 1,
	"recoder" => 1

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
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"seq" => "Nucleic acid sequence (-seq)",
	"required" => "required Section",
	"enzymes" => "Comma separated enzyme list (-enzymes)",
	"output" => "output Section",
	"sshow" => "Display untranslated sequence (-sshow)",
	"tshow" => "Display translated sequence (-tshow)",
	"outf" => "Results file name (-outf)",
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
	"outf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['seq',],
	"required" => ['enzymes',],
	"output" => ['sshow','tshow','outf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"enzymes" => 'all',
	"sshow" => '0',
	"tshow" => '0',
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/recoder.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

