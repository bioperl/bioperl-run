
=head1 NAME

Bio::Tools::Run::PiseApplication::pepcoil

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pepcoil

      Bioperl class for:

	PEPCOIL	Predicts coiled coil regions (EMBOSS)

      Parameters:


		pepcoil (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- PureProtein [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		window (Integer)
			Window size (-window)

		output (Paragraph)
			output Section

		coil (Switch)
			Report coiled coil regions (-coil)

		frame (Switch)
			Show coil frameshifts (-frame)

		other (Switch)
			Report non coiled coil regions (-other)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::pepcoil;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pepcoil = Bio::Tools::Run::PiseApplication::pepcoil->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pepcoil object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pepcoil = $factory->program('pepcoil');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pepcoil.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepcoil.pm

    $self->{COMMAND}   = "pepcoil";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PEPCOIL";

    $self->{DESCRIPTION}   = "Predicts coiled coil regions (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:2d structure",

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pepcoil.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pepcoil",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pepcoil",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- PureProtein [sequences] (-sequence)
	"required", 	# required Section
	"window", 	# Window size (-window)
	"output", 	# output Section
	"coil", 	# Report coiled coil regions (-coil)
	"frame", 	# Show coil frameshifts (-frame)
	"other", 	# Report non coiled coil regions (-other)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"pepcoil" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"window" => 'Integer',
	"output" => 'Paragraph',
	"coil" => 'Switch',
	"frame" => 'Switch',
	"other" => 'Switch',
	"outfile" => 'OutFile',
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
	"window" => {
		"perl" => '" -window=$value"',
	},
	"output" => {
	},
	"coil" => {
		"perl" => '($value)? "" : " -nocoil"',
	},
	"frame" => {
		"perl" => '($value)? " -frame" : ""',
	},
	"other" => {
		"perl" => '($value)? "" : " -noother"',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"pepcoil" => {
		"perl" => '"pepcoil"',
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
	"window" => 2,
	"coil" => 3,
	"frame" => 4,
	"other" => 5,
	"outfile" => 6,
	"auto" => 7,
	"pepcoil" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"pepcoil",
	"sequence",
	"window",
	"coil",
	"frame",
	"other",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"output" => 0,
	"coil" => 0,
	"frame" => 0,
	"other" => 0,
	"outfile" => 0,
	"auto" => 1,
	"pepcoil" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"output" => 0,
	"coil" => 0,
	"frame" => 0,
	"other" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"window" => 1,
	"output" => 0,
	"coil" => 0,
	"frame" => 0,
	"other" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- PureProtein [sequences] (-sequence)",
	"required" => "required Section",
	"window" => "Window size (-window)",
	"output" => "output Section",
	"coil" => "Report coiled coil regions (-coil)",
	"frame" => "Show coil frameshifts (-frame)",
	"other" => "Report non coiled coil regions (-other)",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"output" => 0,
	"coil" => 0,
	"frame" => 0,
	"other" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['window',],
	"output" => ['coil','frame','other','outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '28',
	"coil" => '1',
	"frame" => '',
	"other" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"coil" => { "perl" => '1' },
	"frame" => { "perl" => '1' },
	"other" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
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
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"output" => 0,
	"coil" => 0,
	"frame" => 0,
	"other" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"window" => 1,
	"output" => 0,
	"coil" => 0,
	"frame" => 0,
	"other" => 0,
	"outfile" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepcoil.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

