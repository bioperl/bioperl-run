
=head1 NAME

Bio::Tools::Run::PiseApplication::fuzznuc

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fuzznuc

      Bioperl class for:

	FUZZNUC	Nucleic acid pattern search (EMBOSS)

      Parameters:


		fuzznuc (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- dna [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		pattern (String)
			Search pattern (-pattern)

		mismatch (Integer)
			Number of mismatches (-mismatch)

		advanced (Paragraph)
			advanced Section

		complement (Switch)
			Search complementary strand (-complement)

		output (Paragraph)
			output Section

		outf (OutFile)
			outf (-outf)

		mmshow (Switch)
			Show mismatches (-mmshow)

		accshow (Switch)
			Show accession numbers (-accshow)

		descshow (Switch)
			Show descriptions (-descshow)

		usashow (Switch)
			Show USA (-usashow)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::fuzznuc;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fuzznuc = Bio::Tools::Run::PiseApplication::fuzznuc->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fuzznuc object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $fuzznuc = $factory->program('fuzznuc');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::fuzznuc.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzznuc.pm

    $self->{COMMAND}   = "fuzznuc";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FUZZNUC";

    $self->{DESCRIPTION}   = "Nucleic acid pattern search (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/fuzznuc.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fuzznuc",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fuzznuc",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"required", 	# required Section
	"pattern", 	# Search pattern (-pattern)
	"mismatch", 	# Number of mismatches (-mismatch)
	"advanced", 	# advanced Section
	"complement", 	# Search complementary strand (-complement)
	"output", 	# output Section
	"outf", 	# outf (-outf)
	"mmshow", 	# Show mismatches (-mmshow)
	"accshow", 	# Show accession numbers (-accshow)
	"descshow", 	# Show descriptions (-descshow)
	"usashow", 	# Show USA (-usashow)
	"auto",

    ];

    $self->{TYPE}  = {
	"fuzznuc" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"pattern" => 'String',
	"mismatch" => 'Integer',
	"advanced" => 'Paragraph',
	"complement" => 'Switch',
	"output" => 'Paragraph',
	"outf" => 'OutFile',
	"mmshow" => 'Switch',
	"accshow" => 'Switch',
	"descshow" => 'Switch',
	"usashow" => 'Switch',
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
	"advanced" => {
	},
	"complement" => {
		"perl" => '($value)? " -complement" : ""',
	},
	"output" => {
	},
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"mmshow" => {
		"perl" => '($value)? " -mmshow" : ""',
	},
	"accshow" => {
		"perl" => '($value)? " -accshow" : ""',
	},
	"descshow" => {
		"perl" => '($value)? " -descshow" : ""',
	},
	"usashow" => {
		"perl" => '($value)? " -usashow" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"fuzznuc" => {
		"perl" => '"fuzznuc"',
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
	"complement" => 4,
	"outf" => 5,
	"mmshow" => 6,
	"accshow" => 7,
	"descshow" => 8,
	"usashow" => 9,
	"auto" => 10,
	"fuzznuc" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"fuzznuc",
	"sequence",
	"pattern",
	"mismatch",
	"complement",
	"outf",
	"mmshow",
	"accshow",
	"descshow",
	"usashow",
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
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"descshow" => 0,
	"usashow" => 0,
	"auto" => 1,
	"fuzznuc" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"descshow" => 0,
	"usashow" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"pattern" => 1,
	"mismatch" => 1,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outf" => 1,
	"mmshow" => 0,
	"accshow" => 0,
	"descshow" => 0,
	"usashow" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [sequences] (-sequence)",
	"required" => "required Section",
	"pattern" => "Search pattern (-pattern)",
	"mismatch" => "Number of mismatches (-mismatch)",
	"advanced" => "advanced Section",
	"complement" => "Search complementary strand (-complement)",
	"output" => "output Section",
	"outf" => "outf (-outf)",
	"mmshow" => "Show mismatches (-mmshow)",
	"accshow" => "Show accession numbers (-accshow)",
	"descshow" => "Show descriptions (-descshow)",
	"usashow" => "Show USA (-usashow)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"descshow" => 0,
	"usashow" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['pattern','mismatch',],
	"advanced" => ['complement',],
	"output" => ['outf','mmshow','accshow','descshow','usashow',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mismatch" => '0',
	"complement" => '0',
	"outf" => 'outf.out',
	"mmshow" => '0',
	"accshow" => '0',
	"descshow" => '0',
	"usashow" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"pattern" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"complement" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
	"mmshow" => { "perl" => '1' },
	"accshow" => { "perl" => '1' },
	"descshow" => { "perl" => '1' },
	"usashow" => { "perl" => '1' },
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
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"descshow" => 0,
	"usashow" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"pattern" => 1,
	"mismatch" => 1,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outf" => 1,
	"mmshow" => 0,
	"accshow" => 0,
	"descshow" => 0,
	"usashow" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzznuc.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

