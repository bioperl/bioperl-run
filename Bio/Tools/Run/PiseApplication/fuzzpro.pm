
=head1 NAME

Bio::Tools::Run::PiseApplication::fuzzpro

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fuzzpro

      Bioperl class for:

	FUZZPRO	Protein pattern search (EMBOSS)

      Parameters:


		fuzzpro (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- protein [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		pattern (String)
			Search pattern (-pattern)

		mismatch (Integer)
			Number of mismatches (-mismatch)

		output (Paragraph)
			output Section

		mmshow (Switch)
			Show mismatches (-mmshow)

		accshow (Switch)
			Show accession numbers (-accshow)

		usashow (Switch)
			Show USA (-usashow)

		descshow (Switch)
			Show descriptions (-descshow)

		outf (OutFile)
			outf (-outf)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::fuzzpro;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fuzzpro = Bio::Tools::Run::PiseApplication::fuzzpro->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fuzzpro object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $fuzzpro = $factory->program('fuzzpro');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::fuzzpro.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzzpro.pm

    $self->{COMMAND}   = "fuzzpro";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FUZZPRO";

    $self->{DESCRIPTION}   = "Protein pattern search (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/fuzzpro.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fuzzpro",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fuzzpro",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- protein [sequences] (-sequence)
	"required", 	# required Section
	"pattern", 	# Search pattern (-pattern)
	"mismatch", 	# Number of mismatches (-mismatch)
	"output", 	# output Section
	"mmshow", 	# Show mismatches (-mmshow)
	"accshow", 	# Show accession numbers (-accshow)
	"usashow", 	# Show USA (-usashow)
	"descshow", 	# Show descriptions (-descshow)
	"outf", 	# outf (-outf)
	"auto",

    ];

    $self->{TYPE}  = {
	"fuzzpro" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"pattern" => 'String',
	"mismatch" => 'Integer',
	"output" => 'Paragraph',
	"mmshow" => 'Switch',
	"accshow" => 'Switch',
	"usashow" => 'Switch',
	"descshow" => 'Switch',
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
	"pattern" => {
		"perl" => '" -pattern=$value"',
	},
	"mismatch" => {
		"perl" => '" -mismatch=$value"',
	},
	"output" => {
	},
	"mmshow" => {
		"perl" => '($value)? " -mmshow" : ""',
	},
	"accshow" => {
		"perl" => '($value)? " -accshow" : ""',
	},
	"usashow" => {
		"perl" => '($value)? " -usashow" : ""',
	},
	"descshow" => {
		"perl" => '($value)? " -descshow" : ""',
	},
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"fuzzpro" => {
		"perl" => '"fuzzpro"',
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
	"pattern" => 2,
	"mismatch" => 3,
	"mmshow" => 4,
	"accshow" => 5,
	"usashow" => 6,
	"descshow" => 7,
	"outf" => 8,
	"auto" => 9,
	"fuzzpro" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"fuzzpro",
	"sequence",
	"pattern",
	"mismatch",
	"mmshow",
	"accshow",
	"usashow",
	"descshow",
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
	"pattern" => 0,
	"mismatch" => 0,
	"output" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"outf" => 0,
	"auto" => 1,
	"fuzzpro" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"output" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"pattern" => 1,
	"mismatch" => 1,
	"output" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- protein [sequences] (-sequence)",
	"required" => "required Section",
	"pattern" => "Search pattern (-pattern)",
	"mismatch" => "Number of mismatches (-mismatch)",
	"output" => "output Section",
	"mmshow" => "Show mismatches (-mmshow)",
	"accshow" => "Show accession numbers (-accshow)",
	"usashow" => "Show USA (-usashow)",
	"descshow" => "Show descriptions (-descshow)",
	"outf" => "outf (-outf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"output" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['pattern','mismatch',],
	"output" => ['mmshow','accshow','usashow','descshow','outf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mismatch" => '0',
	"mmshow" => '0',
	"accshow" => '0',
	"usashow" => '0',
	"descshow" => '0',
	"outf" => 'outf.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"pattern" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"mmshow" => { "perl" => '1' },
	"accshow" => { "perl" => '1' },
	"usashow" => { "perl" => '1' },
	"descshow" => { "perl" => '1' },
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
	"pattern" => 0,
	"mismatch" => 0,
	"output" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"pattern" => 1,
	"mismatch" => 1,
	"output" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"usashow" => [
		"Showing the USA (Uniform Sequence Address) of the matching sequences will turn your output file into a \'list\' file that can then be read in by many other EMBOSS programs by specifying it with a \'\@\' in front of the filename.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzzpro.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

