
=head1 NAME

Bio::Tools::Run::PiseApplication::prophecy

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prophecy

      Bioperl class for:

	PROPHECY	Creates matrices/profiles from multiple alignments (EMBOSS)

      Parameters:


		prophecy (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- gapany [set of sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		type (Excl)
			Select type -- Profile type (-type)

		name (String)
			Enter a name for the profile (-name)

		advanced (Paragraph)
			advanced Section

		typesection (Paragraph)
			typesection Section

		threshold (Integer)
			Enter threshold reporting percentage (-threshold)

		datafile (Excl)
			Scoring matrix (-datafile)

		dogapsection (Paragraph)
			dogapsection Section

		open (Float)
			Gap opening penalty (-open)

		extension (Float)
			Gap extension penalty (-extension)

		output (Paragraph)
			output Section

		outf (OutFile)
			outf (-outf)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::prophecy;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prophecy = Bio::Tools::Run::PiseApplication::prophecy->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prophecy object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $prophecy = $factory->program('prophecy');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::prophecy.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prophecy.pm

    $self->{COMMAND}   = "prophecy";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PROPHECY";

    $self->{DESCRIPTION}   = "Creates matrices/profiles from multiple alignments (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:profiles",

         "protein:profiles",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/prophecy.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prophecy",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prophecy",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- gapany [set of sequences] (-sequence)
	"required", 	# required Section
	"type", 	# Select type -- Profile type (-type)
	"name", 	# Enter a name for the profile (-name)
	"advanced", 	# advanced Section
	"typesection", 	# typesection Section
	"threshold", 	# Enter threshold reporting percentage (-threshold)
	"datafile", 	# Scoring matrix (-datafile)
	"dogapsection", 	# dogapsection Section
	"open", 	# Gap opening penalty (-open)
	"extension", 	# Gap extension penalty (-extension)
	"output", 	# output Section
	"outf", 	# outf (-outf)
	"auto",

    ];

    $self->{TYPE}  = {
	"prophecy" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"type" => 'Excl',
	"name" => 'String',
	"advanced" => 'Paragraph',
	"typesection" => 'Paragraph',
	"threshold" => 'Integer',
	"datafile" => 'Excl',
	"dogapsection" => 'Paragraph',
	"open" => 'Float',
	"extension" => 'Float',
	"output" => 'Paragraph',
	"outf" => 'OutFile',
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
	"type" => {
		"perl" => '" -type=$value"',
	},
	"name" => {
		"perl" => '" -name=$value"',
	},
	"advanced" => {
	},
	"typesection" => {
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? " -threshold=$value" : ""',
	},
	"datafile" => {
		"perl" => '($value && $value ne $vdef)? " -datafile=$value" : ""',
	},
	"dogapsection" => {
	},
	"open" => {
		"perl" => '(defined $value && $value != $vdef)? " -open=$value" : ""',
	},
	"extension" => {
		"perl" => '(defined $value && $value != $vdef)? " -extension=$value" : ""',
	},
	"output" => {
	},
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"prophecy" => {
		"perl" => '"prophecy"',
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
	"type" => 2,
	"name" => 3,
	"threshold" => 4,
	"datafile" => 5,
	"open" => 6,
	"extension" => 7,
	"outf" => 8,
	"auto" => 9,
	"prophecy" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"prophecy",
	"required",
	"advanced",
	"typesection",
	"dogapsection",
	"output",
	"sequence",
	"type",
	"name",
	"threshold",
	"datafile",
	"open",
	"extension",
	"outf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"type" => 0,
	"name" => 0,
	"advanced" => 0,
	"typesection" => 0,
	"threshold" => 0,
	"datafile" => 0,
	"dogapsection" => 0,
	"open" => 0,
	"extension" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 1,
	"prophecy" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"type" => 0,
	"name" => 0,
	"advanced" => 0,
	"typesection" => 0,
	"threshold" => 0,
	"datafile" => 0,
	"dogapsection" => 0,
	"open" => 0,
	"extension" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"type" => 1,
	"name" => 1,
	"advanced" => 0,
	"typesection" => 0,
	"threshold" => 0,
	"datafile" => 0,
	"dogapsection" => 0,
	"open" => 0,
	"extension" => 0,
	"output" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- gapany [set of sequences] (-sequence)",
	"required" => "required Section",
	"type" => "Select type -- Profile type (-type)",
	"name" => "Enter a name for the profile (-name)",
	"advanced" => "advanced Section",
	"typesection" => "typesection Section",
	"threshold" => "Enter threshold reporting percentage (-threshold)",
	"datafile" => "Scoring matrix (-datafile)",
	"dogapsection" => "dogapsection Section",
	"open" => "Gap opening penalty (-open)",
	"extension" => "Gap extension penalty (-extension)",
	"output" => "output Section",
	"outf" => "outf (-outf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"type" => 0,
	"name" => 0,
	"advanced" => 0,
	"typesection" => 0,
	"threshold" => 0,
	"datafile" => 0,
	"dogapsection" => 0,
	"open" => 0,
	"extension" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['type','name',],
	"type" => ['F','Frequency','G','Gribskov','H','Henikoff',],
	"advanced" => ['typesection','dogapsection',],
	"typesection" => ['threshold','datafile',],
	"datafile" => ['F','','G','','H','',],
	"dogapsection" => ['open','extension',],
	"output" => ['outf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"type" => 'F',
	"name" => 'mymatrix',
	"threshold" => '75',
	"datafile" => '',
	"open" => '3.0',
	"extension" => '0.3',
	"outf" => 'outf.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"typesection" => { "perl" => '1' },
	"threshold" => {
		"acd" => '@($(type)==F)',
	},
	"datafile" => {
		"acd" => '@($(type)!=F)',
	},
	"dogapsection" => { "perl" => '1' },
	"open" => {
		"perl" => '$dogap',
		"acd" => '$dogap',
	},
	"extension" => {
		"perl" => '$dogap',
		"acd" => '$dogap',
	},
	"output" => { "perl" => '1' },
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
	"type" => 0,
	"name" => 0,
	"advanced" => 0,
	"typesection" => 0,
	"threshold" => 0,
	"datafile" => 0,
	"dogapsection" => 0,
	"open" => 0,
	"extension" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"type" => 1,
	"name" => 1,
	"advanced" => 0,
	"typesection" => 0,
	"threshold" => 0,
	"datafile" => 0,
	"dogapsection" => 0,
	"open" => 0,
	"extension" => 0,
	"output" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prophecy.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

