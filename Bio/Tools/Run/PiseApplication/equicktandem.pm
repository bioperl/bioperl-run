
=head1 NAME

Bio::Tools::Run::PiseApplication::equicktandem

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::equicktandem

      Bioperl class for:

	EQUICKTANDEM	Finds tandem repeats (EMBOSS)

      Parameters:


		equicktandem (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- dna [single sequence] (-sequence)
			pipe: seqfile

		required (Paragraph)
			required Section

		maxrepeat (Integer)
			Maximum repeat size (-maxrepeat)

		threshold (Integer)
			Threshold score (-threshold)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::equicktandem;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $equicktandem = Bio::Tools::Run::PiseApplication::equicktandem->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::equicktandem object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $equicktandem = $factory->program('equicktandem');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::equicktandem.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/equicktandem.pm

    $self->{COMMAND}   = "equicktandem";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EQUICKTANDEM";

    $self->{DESCRIPTION}   = "Finds tandem repeats (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:repeats",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/equicktandem.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"equicktandem",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"equicktandem",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [single sequence] (-sequence)
	"required", 	# required Section
	"maxrepeat", 	# Maximum repeat size (-maxrepeat)
	"threshold", 	# Threshold score (-threshold)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"equicktandem" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"maxrepeat" => 'Integer',
	"threshold" => 'Integer',
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
	"maxrepeat" => {
		"perl" => '" -maxrepeat=$value"',
	},
	"threshold" => {
		"perl" => '" -threshold=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"equicktandem" => {
		"perl" => '"equicktandem"',
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
	"maxrepeat" => 2,
	"threshold" => 3,
	"outfile" => 4,
	"auto" => 5,
	"equicktandem" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"equicktandem",
	"sequence",
	"maxrepeat",
	"threshold",
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
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"equicktandem" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"maxrepeat" => 1,
	"threshold" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [single sequence] (-sequence)",
	"required" => "required Section",
	"maxrepeat" => "Maximum repeat size (-maxrepeat)",
	"threshold" => "Threshold score (-threshold)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['maxrepeat','threshold',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"maxrepeat" => '600',
	"threshold" => '20',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"maxrepeat" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
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
	"maxrepeat" => 0,
	"threshold" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"maxrepeat" => 1,
	"threshold" => 1,
	"output" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/equicktandem.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

