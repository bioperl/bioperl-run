
=head1 NAME

Bio::Tools::Run::PiseApplication::fuzztran

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fuzztran

      Bioperl class for:

	FUZZTRAN	Protein pattern search after translation (EMBOSS)

      Parameters:


		fuzztran (String)


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

		frame (Excl)
			Frame(s) to translate -- Translation frames (-frame)

		table (Excl)
			Code to use -- Genetic codes (-table)

		output (Paragraph)
			output Section

		outf (OutFile)
			outf (-outf)

		mmshow (Switch)
			Show mismatches (-mmshow)

		accshow (Switch)
			Show accession numbers (-accshow)

		usashow (Switch)
			Show USA (-usashow)

		descshow (Switch)
			Show descriptions (-descshow)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::fuzztran;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fuzztran = Bio::Tools::Run::PiseApplication::fuzztran->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fuzztran object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $fuzztran = $factory->program('fuzztran');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::fuzztran.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzztran.pm

    $self->{COMMAND}   = "fuzztran";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FUZZTRAN";

    $self->{DESCRIPTION}   = "Protein pattern search after translation (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:motifs",

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/fuzztran.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fuzztran",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fuzztran",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"required", 	# required Section
	"pattern", 	# Search pattern (-pattern)
	"mismatch", 	# Number of mismatches (-mismatch)
	"advanced", 	# advanced Section
	"frame", 	# Frame(s) to translate -- Translation frames (-frame)
	"table", 	# Code to use -- Genetic codes (-table)
	"output", 	# output Section
	"outf", 	# outf (-outf)
	"mmshow", 	# Show mismatches (-mmshow)
	"accshow", 	# Show accession numbers (-accshow)
	"usashow", 	# Show USA (-usashow)
	"descshow", 	# Show descriptions (-descshow)
	"auto",

    ];

    $self->{TYPE}  = {
	"fuzztran" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"pattern" => 'String',
	"mismatch" => 'Integer',
	"advanced" => 'Paragraph',
	"frame" => 'Excl',
	"table" => 'Excl',
	"output" => 'Paragraph',
	"outf" => 'OutFile',
	"mmshow" => 'Switch',
	"accshow" => 'Switch',
	"usashow" => 'Switch',
	"descshow" => 'Switch',
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
	"frame" => {
		"perl" => '" -frame=$value"',
	},
	"table" => {
		"perl" => '" -table=$value"',
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
	"usashow" => {
		"perl" => '($value)? " -usashow" : ""',
	},
	"descshow" => {
		"perl" => '($value)? " -descshow" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"fuzztran" => {
		"perl" => '"fuzztran"',
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
	"frame" => 4,
	"table" => 5,
	"outf" => 6,
	"mmshow" => 7,
	"accshow" => 8,
	"usashow" => 9,
	"descshow" => 10,
	"auto" => 11,
	"fuzztran" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"fuzztran",
	"sequence",
	"pattern",
	"mismatch",
	"frame",
	"table",
	"outf",
	"mmshow",
	"accshow",
	"usashow",
	"descshow",
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
	"frame" => 0,
	"table" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"auto" => 1,
	"fuzztran" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"frame" => 0,
	"table" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
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
	"frame" => 1,
	"table" => 1,
	"output" => 0,
	"outf" => 1,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
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
	"frame" => "Frame(s) to translate -- Translation frames (-frame)",
	"table" => "Code to use -- Genetic codes (-table)",
	"output" => "output Section",
	"outf" => "outf (-outf)",
	"mmshow" => "Show mismatches (-mmshow)",
	"accshow" => "Show accession numbers (-accshow)",
	"usashow" => "Show USA (-usashow)",
	"descshow" => "Show descriptions (-descshow)",
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
	"frame" => 0,
	"table" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['pattern','mismatch',],
	"advanced" => ['frame','table',],
	"frame" => ['1','1','2','2','3','3','F','Forward three frames','-1','-1','-2','-2','-3','-3','R','Reverse three frames','6','All six frames',],
	"table" => ['0','Standard','1','Standard (with alternative initiation codons)','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear','16','Chlorophycean Mitochondrial','21','Trematode Mitochondrial','22','Scenedesmus obliquus','23','Thraustochytrium Mitochondrial',],
	"output" => ['outf','mmshow','accshow','usashow','descshow',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mismatch" => '0',
	"frame" => '1',
	"table" => '0',
	"outf" => 'outf.out',
	"mmshow" => '0',
	"accshow" => '0',
	"usashow" => '0',
	"descshow" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"pattern" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"frame" => { "perl" => '1' },
	"table" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
	"mmshow" => { "perl" => '1' },
	"accshow" => { "perl" => '1' },
	"usashow" => { "perl" => '1' },
	"descshow" => { "perl" => '1' },
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
	"frame" => 0,
	"table" => 0,
	"output" => 0,
	"outf" => 0,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
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
	"frame" => 1,
	"table" => 1,
	"output" => 0,
	"outf" => 1,
	"mmshow" => 0,
	"accshow" => 0,
	"usashow" => 0,
	"descshow" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzztran.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

