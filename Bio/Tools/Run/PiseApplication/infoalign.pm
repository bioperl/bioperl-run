
=head1 NAME

Bio::Tools::Run::PiseApplication::infoalign

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::infoalign

      Bioperl class for:

	INFOALIGN	Information on a multiple sequence alignment (EMBOSS)

      Parameters:


		infoalign (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- gapany [set of sequences] (-sequence)
			pipe: seqsfile

		advanced (Paragraph)
			advanced Section

		refseq (String)
			The number or the name of the reference sequence (-refseq)

		matrix (Excl)
			Similarity scoring Matrix file (-matrix)

		plurality (Float)
			Plurality check % for consensus (-plurality)

		identity (Float)
			Required % of identities at a position fro consensus (-identity)

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

		seqlength (Switch)
			Display 'seqlength' column (-seqlength)

		alignlength (Switch)
			Display 'alignlength' column (-alignlength)

		gaps (Switch)
			Display number of gaps (-gaps)

		gapcount (Switch)
			Display number of gap positions (-gapcount)

		idcount (Switch)
			Display number of identical positions (-idcount)

		simcount (Switch)
			Display number of similar positions (-simcount)

		diffcount (Switch)
			Display number of different positions (-diffcount)

		change (Switch)
			Display % number of changed positions (-change)

		description (Switch)
			Display 'description' column (-description)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::infoalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $infoalign = Bio::Tools::Run::PiseApplication::infoalign->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::infoalign object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $infoalign = $factory->program('infoalign');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::infoalign.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/infoalign.pm

    $self->{COMMAND}   = "infoalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "INFOALIGN";

    $self->{DESCRIPTION}   = "Information on a multiple sequence alignment (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",

         "information",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/infoalign.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"infoalign",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"infoalign",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- gapany [set of sequences] (-sequence)
	"advanced", 	# advanced Section
	"refseq", 	# The number or the name of the reference sequence (-refseq)
	"matrix", 	# Similarity scoring Matrix file (-matrix)
	"plurality", 	# Plurality check % for consensus (-plurality)
	"identity", 	# Required % of identities at a position fro consensus (-identity)
	"output", 	# output Section
	"outfile", 	# Output sequence details to a file (-outfile)
	"html", 	# Format output as an HTML table (-html)
	"only", 	# Display the specified columns (-only)
	"heading", 	# Display column headings (-heading)
	"usa", 	# Display the USA of the sequence (-usa)
	"name", 	# Display 'name' column (-name)
	"seqlength", 	# Display 'seqlength' column (-seqlength)
	"alignlength", 	# Display 'alignlength' column (-alignlength)
	"gaps", 	# Display number of gaps (-gaps)
	"gapcount", 	# Display number of gap positions (-gapcount)
	"idcount", 	# Display number of identical positions (-idcount)
	"simcount", 	# Display number of similar positions (-simcount)
	"diffcount", 	# Display number of different positions (-diffcount)
	"change", 	# Display % number of changed positions (-change)
	"description", 	# Display 'description' column (-description)
	"auto",

    ];

    $self->{TYPE}  = {
	"infoalign" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"refseq" => 'String',
	"matrix" => 'Excl',
	"plurality" => 'Float',
	"identity" => 'Float',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"html" => 'Switch',
	"only" => 'Switch',
	"heading" => 'Switch',
	"usa" => 'Switch',
	"name" => 'Switch',
	"seqlength" => 'Switch',
	"alignlength" => 'Switch',
	"gaps" => 'Switch',
	"gapcount" => 'Switch',
	"idcount" => 'Switch',
	"simcount" => 'Switch',
	"diffcount" => 'Switch',
	"change" => 'Switch',
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
	"advanced" => {
	},
	"refseq" => {
		"perl" => '($value && $value ne $vdef)? " -refseq=$value" : ""',
	},
	"matrix" => {
		"perl" => '($value)? " -matrix=$value" : ""',
	},
	"plurality" => {
		"perl" => '(defined $value && $value != $vdef)? " -plurality=$value" : ""',
	},
	"identity" => {
		"perl" => '(defined $value && $value != $vdef)? " -identity=$value" : ""',
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
	"seqlength" => {
		"perl" => '($value)? " -seqlength" : ""',
	},
	"alignlength" => {
		"perl" => '($value)? " -alignlength" : ""',
	},
	"gaps" => {
		"perl" => '($value)? " -gaps" : ""',
	},
	"gapcount" => {
		"perl" => '($value)? " -gapcount" : ""',
	},
	"idcount" => {
		"perl" => '($value)? " -idcount" : ""',
	},
	"simcount" => {
		"perl" => '($value)? " -simcount" : ""',
	},
	"diffcount" => {
		"perl" => '($value)? " -diffcount" : ""',
	},
	"change" => {
		"perl" => '($value)? " -change" : ""',
	},
	"description" => {
		"perl" => '($value)? " -description" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"infoalign" => {
		"perl" => '"infoalign"',
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
	"refseq" => 2,
	"matrix" => 3,
	"plurality" => 4,
	"identity" => 5,
	"outfile" => 6,
	"html" => 7,
	"only" => 8,
	"heading" => 9,
	"usa" => 10,
	"name" => 11,
	"seqlength" => 12,
	"alignlength" => 13,
	"gaps" => 14,
	"gapcount" => 15,
	"idcount" => 16,
	"simcount" => 17,
	"diffcount" => 18,
	"change" => 19,
	"description" => 20,
	"auto" => 21,
	"infoalign" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"infoalign",
	"sequence",
	"refseq",
	"matrix",
	"plurality",
	"identity",
	"outfile",
	"html",
	"only",
	"heading",
	"usa",
	"name",
	"seqlength",
	"alignlength",
	"gaps",
	"gapcount",
	"idcount",
	"simcount",
	"diffcount",
	"change",
	"description",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"refseq" => 0,
	"matrix" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"seqlength" => 0,
	"alignlength" => 0,
	"gaps" => 0,
	"gapcount" => 0,
	"idcount" => 0,
	"simcount" => 0,
	"diffcount" => 0,
	"change" => 0,
	"description" => 0,
	"auto" => 1,
	"infoalign" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"refseq" => 0,
	"matrix" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"seqlength" => 0,
	"alignlength" => 0,
	"gaps" => 0,
	"gapcount" => 0,
	"idcount" => 0,
	"simcount" => 0,
	"diffcount" => 0,
	"change" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"refseq" => 0,
	"matrix" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"seqlength" => 0,
	"alignlength" => 0,
	"gaps" => 0,
	"gapcount" => 0,
	"idcount" => 0,
	"simcount" => 0,
	"diffcount" => 0,
	"change" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- gapany [set of sequences] (-sequence)",
	"advanced" => "advanced Section",
	"refseq" => "The number or the name of the reference sequence (-refseq)",
	"matrix" => "Similarity scoring Matrix file (-matrix)",
	"plurality" => "Plurality check % for consensus (-plurality)",
	"identity" => "Required % of identities at a position fro consensus (-identity)",
	"output" => "output Section",
	"outfile" => "Output sequence details to a file (-outfile)",
	"html" => "Format output as an HTML table (-html)",
	"only" => "Display the specified columns (-only)",
	"heading" => "Display column headings (-heading)",
	"usa" => "Display the USA of the sequence (-usa)",
	"name" => "Display 'name' column (-name)",
	"seqlength" => "Display 'seqlength' column (-seqlength)",
	"alignlength" => "Display 'alignlength' column (-alignlength)",
	"gaps" => "Display number of gaps (-gaps)",
	"gapcount" => "Display number of gap positions (-gapcount)",
	"idcount" => "Display number of identical positions (-idcount)",
	"simcount" => "Display number of similar positions (-simcount)",
	"diffcount" => "Display number of different positions (-diffcount)",
	"change" => "Display % number of changed positions (-change)",
	"description" => "Display 'description' column (-description)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"refseq" => 0,
	"matrix" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"seqlength" => 0,
	"alignlength" => 0,
	"gaps" => 0,
	"gapcount" => 0,
	"idcount" => 0,
	"simcount" => 0,
	"diffcount" => 0,
	"change" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['refseq','matrix','plurality','identity',],
	"matrix" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['outfile','html','only','heading','usa','name','seqlength','alignlength','gaps','gapcount','idcount','simcount','diffcount','change','description',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"refseq" => '0',
	"plurality" => '50.0',
	"identity" => '0.0',
	"outfile" => 'stdout',
	"html" => '0',
	"only" => '0',
	"heading" => '',
	"usa" => '',
	"name" => '',
	"seqlength" => '',
	"alignlength" => '',
	"gaps" => '',
	"gapcount" => '',
	"idcount" => '',
	"simcount" => '',
	"diffcount" => '',
	"change" => '',
	"description" => '',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"refseq" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"plurality" => { "perl" => '1' },
	"identity" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"html" => { "perl" => '1' },
	"only" => { "perl" => '1' },
	"heading" => { "perl" => '1' },
	"usa" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"seqlength" => { "perl" => '1' },
	"alignlength" => { "perl" => '1' },
	"gaps" => { "perl" => '1' },
	"gapcount" => { "perl" => '1' },
	"idcount" => { "perl" => '1' },
	"simcount" => { "perl" => '1' },
	"diffcount" => { "perl" => '1' },
	"change" => { "perl" => '1' },
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
	"advanced" => 0,
	"refseq" => 0,
	"matrix" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"seqlength" => 0,
	"alignlength" => 0,
	"gaps" => 0,
	"gapcount" => 0,
	"idcount" => 0,
	"simcount" => 0,
	"diffcount" => 0,
	"change" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"refseq" => 0,
	"matrix" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outfile" => 0,
	"html" => 0,
	"only" => 0,
	"heading" => 0,
	"usa" => 0,
	"name" => 0,
	"seqlength" => 0,
	"alignlength" => 0,
	"gaps" => 0,
	"gapcount" => 0,
	"idcount" => 0,
	"simcount" => 0,
	"diffcount" => 0,
	"change" => 0,
	"description" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"sequence" => [
		"The sequence alignment to be displayed.",
	],
	"refseq" => [
		"If you give the number in the alignment or the name of a sequence, it will be taken to be the reference sequence. The reference sequence is the one against which all the other sequences are compared. If this is set to 0 then the consensus sequence will be used as the reference sequence. By default the consensus sequence is used as the reference sequence.",
	],
	"plurality" => [
		"Set a cut-off for the % of positive scoring matches below which there is no consensus. The default plurality is taken as 50% of the total weight of all the sequences in the alignment.",
	],
	"identity" => [
		"Provides the facility of setting the required number of identities at a position for it to give a consensus. Therefore, if this is set to 100% only columns of identities contribute to the consensus.",
	],
	"outfile" => [
		"If you enter the name of a file here then this program will write the sequence details into that file.",
	],
	"only" => [
		"This is a way of shortening the command line if you only want a few things to be displayed. Instead of specifying: <BR> \'-nohead -nousa -noname -noalign -nogaps -nogapcount -nosimcount -noidcount -nodiffcount\' <BR> to get only the sequence length output, you can specify <BR> \'-only -seqlength\'",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/infoalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

