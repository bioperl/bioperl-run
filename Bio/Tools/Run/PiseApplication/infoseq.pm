
=head1 NAME

Bio::Tools::Run::PiseApplication::infoseq

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::infoseq

      Bioperl class for:

	INFOSEQ	Displays some simple information about sequences (EMBOSS)

      Parameters:


		infoseq (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence [sequences] (-sequence)
			pipe: seqsfile

		output (Paragraph)
			output Section

		outfile (OutFile)
			Output sequence details to a file (-outfile)

		html (Switch)
			Format output as an HTML table (-html)

		only (Switch)
			Display the specified columns (-only)

		heading (Switch)
			Display column headings (-heading)

		usa (Switch)
			Display the USA of the sequence (-usa)

		name (Switch)
			Display 'name' column (-name)

		accession (Switch)
			Display 'accession' column (-accession)

		type (Switch)
			Display 'type' column (-type)

		length (Switch)
			Display 'length' column (-length)

		pgc (Switch)
			Display 'percent GC content' column (-pgc)

		description (Switch)
			Display 'description' column (-description)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::infoseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $infoseq = Bio::Tools::Run::PiseApplication::infoseq->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::infoseq object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $infoseq = $factory->program('infoseq');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::infoseq.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/infoseq.pm

    $self->{COMMAND}   = "infoseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "INFOSEQ";

    $self->{DESCRIPTION}   = "Displays some simple information about sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "information",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/infoseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"infoseq",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"infoseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence [sequences] (-sequence)
	"output", 	# output Section
	"outfile", 	# Output sequence details to a file (-outfile)
	"html", 	# Format output as an HTML table (-html)
	"only", 	# Display the specified columns (-only)
	"heading", 	# Display column headings (-heading)
	"usa", 	# Display the USA of the sequence (-usa)
	"name", 	# Display 'name' column (-name)
	"accession", 	# Display 'accession' column (-accession)
	"type", 	# Display 'type' column (-type)
	"length", 	# Display 'length' column (-length)
	"pgc", 	# Display 'percent GC content' column (-pgc)
	"description", 	# Display 'description' column (-description)
	"auto",

    ];

    $self->{TYPE}  = {
	"infoseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"html" => 'Switch',
	"only" => 'Switch',
	"heading" => 'Switch',
	"usa" => 'Switch',
	"name" => 'Switch',
	"accession" => 'Switch',
	"type" => 'Switch',
	"length" => 'Switch',
	"pgc" => 'Switch',
	"description" => 'Switch',
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
	"output" => {
	},
	"outfile" => {
		"perl" => '($value && $value ne $vdef)? " -outfile=$value" : ""',
	},
	"html" => {
		"perl" => '($value)? " -html" : ""',
	},
	"only" => {
		"perl" => '($value)? " -only" : ""',
	},
	"heading" => {
		"perl" => '($value)? " -heading" : ""',
	},
	"usa" => {
		"perl" => '($value)? " -usa" : ""',
	},
	"name" => {
		"perl" => '($value)? " -name" : ""',
	},
	"accession" => {
		"perl" => '($value)? " -accession" : ""',
	},
	"type" => {
		"perl" => '($value)? " -type" : ""',
	},
	"length" => {
		"perl" => '($value)? " -length" : ""',
	},
	"pgc" => {
		"perl" => '($value)? " -pgc" : ""',
	},
	"description" => {
		"perl" => '($value)? " -description" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"infoseq" => {
		"perl" => '"infoseq"',
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
	"outfile" => 2,
	"html" => 3,
	"only" => 4,
	"heading" => 5,
	"usa" => 6,
	"name" => 7,
	"accession" => 8,
	"type" => 9,
	"length" => 10,
	"pgc" => 11,
	"description" => 12,
	"auto" => 13,
	"infoseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"infoseq",
	"sequence",
	"outfile",
	"html",
	"only",
	"heading",
	"usa",
	"name",
	"accession",
	"type",
	"length",
	"pgc",
	"description",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"accession" => 0,
	"type" => 0,
	"length" => 0,
	"pgc" => 0,
	"description" => 0,
	"auto" => 1,
	"infoseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"accession" => 0,
	"type" => 0,
	"length" => 0,
	"pgc" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"accession" => 0,
	"type" => 0,
	"length" => 0,
	"pgc" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence [sequences] (-sequence)",
	"output" => "output Section",
	"outfile" => "Output sequence details to a file (-outfile)",
	"html" => "Format output as an HTML table (-html)",
	"only" => "Display the specified columns (-only)",
	"heading" => "Display column headings (-heading)",
	"usa" => "Display the USA of the sequence (-usa)",
	"name" => "Display 'name' column (-name)",
	"accession" => "Display 'accession' column (-accession)",
	"type" => "Display 'type' column (-type)",
	"length" => "Display 'length' column (-length)",
	"pgc" => "Display 'percent GC content' column (-pgc)",
	"description" => "Display 'description' column (-description)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"accession" => 0,
	"type" => 0,
	"length" => 0,
	"pgc" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"output" => ['outfile','html','only','heading','usa','name','accession','type','length','pgc','description',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'stdout',
	"html" => '0',
	"only" => '0',
	"heading" => '',
	"usa" => '',
	"name" => '',
	"accession" => '',
	"type" => '',
	"length" => '',
	"pgc" => '',
	"description" => '',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"html" => { "perl" => '1' },
	"only" => { "perl" => '1' },
	"heading" => { "perl" => '1' },
	"usa" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"accession" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"pgc" => { "perl" => '1' },
	"description" => { "perl" => '1' },
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
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"accession" => 0,
	"type" => 0,
	"length" => 0,
	"pgc" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"accession" => 0,
	"type" => 0,
	"length" => 0,
	"pgc" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"outfile" => [
		"If you enter the name of a file here then this program will write the sequence details into that file.",
	],
	"only" => [
		"This is a way of shortening the command line if you only want a few things to be displayed. Instead of specifying: <BR> \'-nohead -noname -noacc -notype -nopgc -nodesc\' <BR> to get only the length output, you can specify <BR> \'-only -length\'",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/infoseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

