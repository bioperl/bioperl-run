
=head1 NAME

Bio::Tools::Run::PiseApplication::etandem

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::etandem

      Bioperl class for:

	ETANDEM	Looks for tandem repeats in a nucleotide sequence (EMBOSS)

      Parameters:


		etandem (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- dna [single sequence] (-sequence)
			pipe: seqfile

		required (Paragraph)
			required Section

		minrepeat (Integer)
			Minimum repeat size (-minrepeat)

		maxrepeat (Integer)
			Maximum repeat size (-maxrepeat)

		advanced (Paragraph)
			advanced Section

		threshold (Integer)
			Threshold score (-threshold)

		mismatch (Switch)
			Allow N as a mismatch (-mismatch)

		uniform (Switch)
			Allow uniform consensus (-uniform)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::etandem;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $etandem = Bio::Tools::Run::PiseApplication::etandem->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::etandem object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $etandem = $factory->program('etandem');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::etandem.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/etandem.pm

    $self->{COMMAND}   = "etandem";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ETANDEM";

    $self->{DESCRIPTION}   = "Looks for tandem repeats in a nucleotide sequence (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:repeats",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/etandem.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"etandem",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"etandem",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [single sequence] (-sequence)
	"required", 	# required Section
	"minrepeat", 	# Minimum repeat size (-minrepeat)
	"maxrepeat", 	# Maximum repeat size (-maxrepeat)
	"advanced", 	# advanced Section
	"threshold", 	# Threshold score (-threshold)
	"mismatch", 	# Allow N as a mismatch (-mismatch)
	"uniform", 	# Allow uniform consensus (-uniform)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"etandem" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"minrepeat" => 'Integer',
	"maxrepeat" => 'Integer',
	"advanced" => 'Paragraph',
	"threshold" => 'Integer',
	"mismatch" => 'Switch',
	"uniform" => 'Switch',
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
	"minrepeat" => {
		"perl" => '" -minrepeat=$value"',
	},
	"maxrepeat" => {
		"perl" => '" -maxrepeat=$value"',
	},
	"advanced" => {
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? " -threshold=$value" : ""',
	},
	"mismatch" => {
		"perl" => '($value)? " -mismatch" : ""',
	},
	"uniform" => {
		"perl" => '($value)? " -uniform" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"etandem" => {
		"perl" => '"etandem"',
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
	"minrepeat" => 2,
	"maxrepeat" => 3,
	"threshold" => 4,
	"mismatch" => 5,
	"uniform" => 6,
	"outfile" => 7,
	"auto" => 8,
	"etandem" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"etandem",
	"sequence",
	"minrepeat",
	"maxrepeat",
	"threshold",
	"mismatch",
	"uniform",
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
	"minrepeat" => 0,
	"maxrepeat" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"mismatch" => 0,
	"uniform" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"etandem" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"minrepeat" => 0,
	"maxrepeat" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"mismatch" => 0,
	"uniform" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"minrepeat" => 1,
	"maxrepeat" => 1,
	"advanced" => 0,
	"threshold" => 0,
	"mismatch" => 0,
	"uniform" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [single sequence] (-sequence)",
	"required" => "required Section",
	"minrepeat" => "Minimum repeat size (-minrepeat)",
	"maxrepeat" => "Maximum repeat size (-maxrepeat)",
	"advanced" => "advanced Section",
	"threshold" => "Threshold score (-threshold)",
	"mismatch" => "Allow N as a mismatch (-mismatch)",
	"uniform" => "Allow uniform consensus (-uniform)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"minrepeat" => 0,
	"maxrepeat" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"mismatch" => 0,
	"uniform" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['minrepeat','maxrepeat',],
	"advanced" => ['threshold','mismatch','uniform',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"minrepeat" => '10',
	"maxrepeat" => '',
	"threshold" => '20',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"minrepeat" => { "perl" => '1' },
	"maxrepeat" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"uniform" => { "perl" => '1' },
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
	"minrepeat" => 0,
	"maxrepeat" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"mismatch" => 0,
	"uniform" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"minrepeat" => 1,
	"maxrepeat" => 1,
	"advanced" => 0,
	"threshold" => 0,
	"mismatch" => 0,
	"uniform" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"minrepeat" => [
		" Allowed values: Integer, 2 or higher",
	],
	"maxrepeat" => [
		" Allowed values: Integer, same as -minrepeat or higher",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/etandem.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

