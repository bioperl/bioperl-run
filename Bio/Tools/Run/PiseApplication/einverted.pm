
=head1 NAME

Bio::Tools::Run::PiseApplication::einverted

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::einverted

      Bioperl class for:

	EINVERTED	Finds DNA inverted repeats (EMBOSS)

      Parameters:


		einverted (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- dna [single sequence] (-sequence)
			pipe: seqfile

		required (Paragraph)
			required Section

		gap (Integer)
			Gap penalty (-gap)

		threshold (Integer)
			Minimum score threshold (-threshold)

		match (Integer)
			Match score (-match)

		mismatch (Integer)
			Mismatch score (-mismatch)

		advanced (Paragraph)
			advanced Section

		maxrepeat (Integer)
			Maximum extent of repeats (-maxrepeat)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::einverted;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $einverted = Bio::Tools::Run::PiseApplication::einverted->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::einverted object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $einverted = $factory->program('einverted');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::einverted.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/einverted.pm

    $self->{COMMAND}   = "einverted";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EINVERTED";

    $self->{DESCRIPTION}   = "Finds DNA inverted repeats (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:repeats",

         "nucleic:2d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/einverted.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"einverted",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"einverted",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [single sequence] (-sequence)
	"required", 	# required Section
	"gap", 	# Gap penalty (-gap)
	"threshold", 	# Minimum score threshold (-threshold)
	"match", 	# Match score (-match)
	"mismatch", 	# Mismatch score (-mismatch)
	"advanced", 	# advanced Section
	"maxrepeat", 	# Maximum extent of repeats (-maxrepeat)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"einverted" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"gap" => 'Integer',
	"threshold" => 'Integer',
	"match" => 'Integer',
	"mismatch" => 'Integer',
	"advanced" => 'Paragraph',
	"maxrepeat" => 'Integer',
	"output" => 'Paragraph',
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
	"gap" => {
		"perl" => '" -gap=$value"',
	},
	"threshold" => {
		"perl" => '" -threshold=$value"',
	},
	"match" => {
		"perl" => '" -match=$value"',
	},
	"mismatch" => {
		"perl" => '" -mismatch=$value"',
	},
	"advanced" => {
	},
	"maxrepeat" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxrepeat=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"einverted" => {
		"perl" => '"einverted"',
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
	"gap" => 2,
	"threshold" => 3,
	"match" => 4,
	"mismatch" => 5,
	"maxrepeat" => 6,
	"outfile" => 7,
	"auto" => 8,
	"einverted" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"einverted",
	"sequence",
	"gap",
	"threshold",
	"match",
	"mismatch",
	"maxrepeat",
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
	"gap" => 0,
	"threshold" => 0,
	"match" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"maxrepeat" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"einverted" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"gap" => 0,
	"threshold" => 0,
	"match" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"maxrepeat" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"gap" => 1,
	"threshold" => 1,
	"match" => 1,
	"mismatch" => 1,
	"advanced" => 0,
	"maxrepeat" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [single sequence] (-sequence)",
	"required" => "required Section",
	"gap" => "Gap penalty (-gap)",
	"threshold" => "Minimum score threshold (-threshold)",
	"match" => "Match score (-match)",
	"mismatch" => "Mismatch score (-mismatch)",
	"advanced" => "advanced Section",
	"maxrepeat" => "Maximum extent of repeats (-maxrepeat)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"gap" => 0,
	"threshold" => 0,
	"match" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"maxrepeat" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['gap','threshold','match','mismatch',],
	"advanced" => ['maxrepeat',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gap" => '12',
	"threshold" => '50',
	"match" => '3',
	"mismatch" => '-4',
	"maxrepeat" => '4000',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"gap" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"match" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"maxrepeat" => { "perl" => '1' },
	"output" => { "perl" => '1' },
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
	"gap" => 0,
	"threshold" => 0,
	"match" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"maxrepeat" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"gap" => 1,
	"threshold" => 1,
	"match" => 1,
	"mismatch" => 1,
	"advanced" => 0,
	"maxrepeat" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"maxrepeat" => [
		"Maximum separation between the start of repeat and the end of the inverted repeat (the default is 4000 bases).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/einverted.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

