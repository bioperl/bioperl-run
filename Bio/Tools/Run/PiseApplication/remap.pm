
=head1 NAME

Bio::Tools::Run::PiseApplication::remap

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::remap

      Bioperl class for:

	REMAP	Display a sequence with restriction cut sites, translation etc.. (EMBOSS)

      Parameters:


		remap (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		enzymes (String)
			Comma separated enzyme list (-enzymes)

		sitelen (Integer)
			Minimum recognition site length (-sitelen)

		advanced (Paragraph)
			advanced Section

		mincuts (Integer)
			Minimum cuts per RE (-mincuts)

		maxcuts (Integer)
			Maximum cuts per RE (-maxcuts)

		single (Switch)
			Force single site only cuts (-single)

		blunt (Switch)
			Allow blunt end cutters (-blunt)

		sticky (Switch)
			Allow sticky end cutters (-sticky)

		ambiguity (Switch)
			Allow ambiguous matches (-ambiguity)

		plasmid (Switch)
			Allow circular DNA (-plasmid)

		commercial (Switch)
			Only enzymes with suppliers (-commercial)

		table (Excl)
			Code to use -- Genetic codes (-table)

		output (Paragraph)
			output Section

		outfile (OutFile)
			Output sequence details to a file (-outfile)

		cutlist (Switch)
			List the enzymes that cut (-cutlist)

		flatreformat (Switch)
			Display RE sites in flat format (-flatreformat)

		limit (Switch)
			Limits reports to one isoschizomer (-limit)

		preferred (Switch)
			Report preferred isoschizomers (-preferred)

		translation (Switch)
			Display translation (-translation)

		reverse (Switch)
			Display cut sites and translation of reverse sense (-reverse)

		orfminsize (Integer)
			Minimum size of ORFs (-orfminsize)

		uppercase (Integer)
			Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)

		highlight (Integer)
			Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)

		threeletter (Switch)
			Display protein sequences in three-letter code (-threeletter)

		number (Switch)
			Number the sequences (-number)

		width (Integer)
			Width of sequence to display (-width)

		length (Integer)
			Line length of page (0 for indefinite) (-length)

		margin (Integer)
			Margin around sequence for numbering (-margin)

		name (Switch)
			Display sequence ID (-name)

		description (Switch)
			Display description (-description)

		offset (Integer)
			Offset to start numbering the sequence from (-offset)

		html (Switch)
			Use HTML formatting (-html)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::remap;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $remap = Bio::Tools::Run::PiseApplication::remap->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::remap object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $remap = $factory->program('remap');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::remap.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/remap.pm

    $self->{COMMAND}   = "remap";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "REMAP";

    $self->{DESCRIPTION}   = "Display a sequence with restriction cut sites, translation etc.. (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "display",

         "nucleic:restriction",

         "nucleic:translation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/remap.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"remap",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"remap",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"enzymes", 	# Comma separated enzyme list (-enzymes)
	"sitelen", 	# Minimum recognition site length (-sitelen)
	"advanced", 	# advanced Section
	"mincuts", 	# Minimum cuts per RE (-mincuts)
	"maxcuts", 	# Maximum cuts per RE (-maxcuts)
	"single", 	# Force single site only cuts (-single)
	"blunt", 	# Allow blunt end cutters (-blunt)
	"sticky", 	# Allow sticky end cutters (-sticky)
	"ambiguity", 	# Allow ambiguous matches (-ambiguity)
	"plasmid", 	# Allow circular DNA (-plasmid)
	"commercial", 	# Only enzymes with suppliers (-commercial)
	"table", 	# Code to use -- Genetic codes (-table)
	"output", 	# output Section
	"outfile", 	# Output sequence details to a file (-outfile)
	"cutlist", 	# List the enzymes that cut (-cutlist)
	"flatreformat", 	# Display RE sites in flat format (-flatreformat)
	"limit", 	# Limits reports to one isoschizomer (-limit)
	"preferred", 	# Report preferred isoschizomers (-preferred)
	"translation", 	# Display translation (-translation)
	"reverse", 	# Display cut sites and translation of reverse sense (-reverse)
	"orfminsize", 	# Minimum size of ORFs (-orfminsize)
	"uppercase", 	# Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)
	"highlight", 	# Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)
	"threeletter", 	# Display protein sequences in three-letter code (-threeletter)
	"number", 	# Number the sequences (-number)
	"width", 	# Width of sequence to display (-width)
	"length", 	# Line length of page (0 for indefinite) (-length)
	"margin", 	# Margin around sequence for numbering (-margin)
	"name", 	# Display sequence ID (-name)
	"description", 	# Display description (-description)
	"offset", 	# Offset to start numbering the sequence from (-offset)
	"html", 	# Use HTML formatting (-html)
	"auto",

    ];

    $self->{TYPE}  = {
	"remap" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"enzymes" => 'String',
	"sitelen" => 'Integer',
	"advanced" => 'Paragraph',
	"mincuts" => 'Integer',
	"maxcuts" => 'Integer',
	"single" => 'Switch',
	"blunt" => 'Switch',
	"sticky" => 'Switch',
	"ambiguity" => 'Switch',
	"plasmid" => 'Switch',
	"commercial" => 'Switch',
	"table" => 'Excl',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"cutlist" => 'Switch',
	"flatreformat" => 'Switch',
	"limit" => 'Switch',
	"preferred" => 'Switch',
	"translation" => 'Switch',
	"reverse" => 'Switch',
	"orfminsize" => 'Integer',
	"uppercase" => 'Integer',
	"highlight" => 'Integer',
	"threeletter" => 'Switch',
	"number" => 'Switch',
	"width" => 'Integer',
	"length" => 'Integer',
	"margin" => 'Integer',
	"name" => 'Switch',
	"description" => 'Switch',
	"offset" => 'Integer',
	"html" => 'Switch',
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
	"enzymes" => {
		"perl" => '" -enzymes=$value"',
	},
	"sitelen" => {
		"perl" => '" -sitelen=$value"',
	},
	"advanced" => {
	},
	"mincuts" => {
		"perl" => '(defined $value && $value != $vdef)? " -mincuts=$value" : ""',
	},
	"maxcuts" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxcuts=$value" : ""',
	},
	"single" => {
		"perl" => '($value)? " -single" : ""',
	},
	"blunt" => {
		"perl" => '($value)? "" : " -noblunt"',
	},
	"sticky" => {
		"perl" => '($value)? "" : " -nosticky"',
	},
	"ambiguity" => {
		"perl" => '($value)? "" : " -noambiguity"',
	},
	"plasmid" => {
		"perl" => '($value)? " -plasmid" : ""',
	},
	"commercial" => {
		"perl" => '($value)? "" : " -nocommercial"',
	},
	"table" => {
		"perl" => '" -table=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"cutlist" => {
		"perl" => '($value)? "" : " -nocutlist"',
	},
	"flatreformat" => {
		"perl" => '($value)? " -flatreformat" : ""',
	},
	"limit" => {
		"perl" => '($value)? "" : " -nolimit"',
	},
	"preferred" => {
		"perl" => '($value)? " -preferred" : ""',
	},
	"translation" => {
		"perl" => '($value)? "" : " -notranslation"',
	},
	"reverse" => {
		"perl" => '($value)? "" : " -noreverse"',
	},
	"orfminsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -orfminsize=$value" : ""',
	},
	"uppercase" => {
		"perl" => '($value)? " -uppercase=$value" : ""',
	},
	"highlight" => {
		"perl" => '($value)? " -highlight=$value" : ""',
	},
	"threeletter" => {
		"perl" => '($value)? " -threeletter" : ""',
	},
	"number" => {
		"perl" => '($value)? " -number" : ""',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"length" => {
		"perl" => '(defined $value && $value != $vdef)? " -length=$value" : ""',
	},
	"margin" => {
		"perl" => '(defined $value && $value != $vdef)? " -margin=$value" : ""',
	},
	"name" => {
		"perl" => '($value)? "" : " -noname"',
	},
	"description" => {
		"perl" => '($value)? "" : " -nodescription"',
	},
	"offset" => {
		"perl" => '(defined $value && $value != $vdef)? " -offset=$value" : ""',
	},
	"html" => {
		"perl" => '($value)? " -html" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"remap" => {
		"perl" => '"remap"',
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
	"enzymes" => 2,
	"sitelen" => 3,
	"mincuts" => 4,
	"maxcuts" => 5,
	"single" => 6,
	"blunt" => 7,
	"sticky" => 8,
	"ambiguity" => 9,
	"plasmid" => 10,
	"commercial" => 11,
	"table" => 12,
	"outfile" => 13,
	"cutlist" => 14,
	"flatreformat" => 15,
	"limit" => 16,
	"preferred" => 17,
	"translation" => 18,
	"reverse" => 19,
	"orfminsize" => 20,
	"uppercase" => 21,
	"highlight" => 22,
	"threeletter" => 23,
	"number" => 24,
	"width" => 25,
	"length" => 26,
	"margin" => 27,
	"name" => 28,
	"description" => 29,
	"offset" => 30,
	"html" => 31,
	"auto" => 32,
	"remap" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"remap",
	"sequence",
	"enzymes",
	"sitelen",
	"mincuts",
	"maxcuts",
	"single",
	"blunt",
	"sticky",
	"ambiguity",
	"plasmid",
	"commercial",
	"table",
	"outfile",
	"cutlist",
	"flatreformat",
	"limit",
	"preferred",
	"translation",
	"reverse",
	"orfminsize",
	"uppercase",
	"highlight",
	"threeletter",
	"number",
	"width",
	"length",
	"margin",
	"name",
	"description",
	"offset",
	"html",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"enzymes" => 0,
	"sitelen" => 0,
	"advanced" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"table" => 0,
	"output" => 0,
	"outfile" => 0,
	"cutlist" => 0,
	"flatreformat" => 0,
	"limit" => 0,
	"preferred" => 0,
	"translation" => 0,
	"reverse" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"auto" => 1,
	"remap" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"enzymes" => 0,
	"sitelen" => 0,
	"advanced" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"table" => 0,
	"output" => 0,
	"outfile" => 0,
	"cutlist" => 0,
	"flatreformat" => 0,
	"limit" => 0,
	"preferred" => 0,
	"translation" => 0,
	"reverse" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"enzymes" => 1,
	"sitelen" => 1,
	"advanced" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"table" => 1,
	"output" => 0,
	"outfile" => 1,
	"cutlist" => 0,
	"flatreformat" => 0,
	"limit" => 0,
	"preferred" => 0,
	"translation" => 0,
	"reverse" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"required" => "required Section",
	"enzymes" => "Comma separated enzyme list (-enzymes)",
	"sitelen" => "Minimum recognition site length (-sitelen)",
	"advanced" => "advanced Section",
	"mincuts" => "Minimum cuts per RE (-mincuts)",
	"maxcuts" => "Maximum cuts per RE (-maxcuts)",
	"single" => "Force single site only cuts (-single)",
	"blunt" => "Allow blunt end cutters (-blunt)",
	"sticky" => "Allow sticky end cutters (-sticky)",
	"ambiguity" => "Allow ambiguous matches (-ambiguity)",
	"plasmid" => "Allow circular DNA (-plasmid)",
	"commercial" => "Only enzymes with suppliers (-commercial)",
	"table" => "Code to use -- Genetic codes (-table)",
	"output" => "output Section",
	"outfile" => "Output sequence details to a file (-outfile)",
	"cutlist" => "List the enzymes that cut (-cutlist)",
	"flatreformat" => "Display RE sites in flat format (-flatreformat)",
	"limit" => "Limits reports to one isoschizomer (-limit)",
	"preferred" => "Report preferred isoschizomers (-preferred)",
	"translation" => "Display translation (-translation)",
	"reverse" => "Display cut sites and translation of reverse sense (-reverse)",
	"orfminsize" => "Minimum size of ORFs (-orfminsize)",
	"uppercase" => "Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)",
	"highlight" => "Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)",
	"threeletter" => "Display protein sequences in three-letter code (-threeletter)",
	"number" => "Number the sequences (-number)",
	"width" => "Width of sequence to display (-width)",
	"length" => "Line length of page (0 for indefinite) (-length)",
	"margin" => "Margin around sequence for numbering (-margin)",
	"name" => "Display sequence ID (-name)",
	"description" => "Display description (-description)",
	"offset" => "Offset to start numbering the sequence from (-offset)",
	"html" => "Use HTML formatting (-html)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"enzymes" => 0,
	"sitelen" => 0,
	"advanced" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"table" => 0,
	"output" => 0,
	"outfile" => 0,
	"cutlist" => 0,
	"flatreformat" => 0,
	"limit" => 0,
	"preferred" => 0,
	"translation" => 0,
	"reverse" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['enzymes','sitelen',],
	"advanced" => ['mincuts','maxcuts','single','blunt','sticky','ambiguity','plasmid','commercial','table',],
	"table" => ['0','Standard','1','Standard (with alternative initiation codons)','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear','16','Chlorophycean Mitochondrial','21','Trematode Mitochondrial','22','Scenedesmus obliquus','23','Thraustochytrium Mitochondrial',],
	"output" => ['outfile','cutlist','flatreformat','limit','preferred','translation','reverse','orfminsize','uppercase','highlight','threeletter','number','width','length','margin','name','description','offset','html',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"enzymes" => 'all',
	"sitelen" => '4',
	"mincuts" => '1',
	"maxcuts" => '2000000000',
	"single" => '0',
	"blunt" => '1',
	"sticky" => '1',
	"ambiguity" => '1',
	"plasmid" => '0',
	"commercial" => '1',
	"table" => '0',
	"outfile" => 'outfile.out',
	"cutlist" => '1',
	"flatreformat" => '0',
	"limit" => '1',
	"preferred" => '0',
	"translation" => '1',
	"reverse" => '1',
	"orfminsize" => '0',
	"threeletter" => '0',
	"number" => '0',
	"width" => '60',
	"length" => '0',
	"margin" => '10',
	"name" => '1',
	"description" => '1',
	"offset" => '1',
	"html" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"enzymes" => { "perl" => '1' },
	"sitelen" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"mincuts" => { "perl" => '1' },
	"maxcuts" => { "perl" => '1' },
	"single" => { "perl" => '1' },
	"blunt" => { "perl" => '1' },
	"sticky" => { "perl" => '1' },
	"ambiguity" => { "perl" => '1' },
	"plasmid" => { "perl" => '1' },
	"commercial" => { "perl" => '1' },
	"table" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"cutlist" => { "perl" => '1' },
	"flatreformat" => { "perl" => '1' },
	"limit" => { "perl" => '1' },
	"preferred" => { "perl" => '1' },
	"translation" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"orfminsize" => { "perl" => '1' },
	"uppercase" => { "perl" => '1' },
	"highlight" => { "perl" => '1' },
	"threeletter" => { "perl" => '1' },
	"number" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"margin" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"offset" => { "perl" => '1' },
	"html" => { "perl" => '1' },
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
	"enzymes" => 0,
	"sitelen" => 0,
	"advanced" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"table" => 0,
	"output" => 0,
	"outfile" => 0,
	"cutlist" => 0,
	"flatreformat" => 0,
	"limit" => 0,
	"preferred" => 0,
	"translation" => 0,
	"reverse" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"enzymes" => 1,
	"sitelen" => 1,
	"advanced" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"table" => 1,
	"output" => 0,
	"outfile" => 1,
	"cutlist" => 0,
	"flatreformat" => 0,
	"limit" => 0,
	"preferred" => 0,
	"translation" => 0,
	"reverse" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"enzymes" => [
		"The name \'all\' reads in all enzyme names from the REBASE database. You can specify enzymes by giving their names with commas between then, such as: \'HincII,hinfI,ppiI,hindiii\'. <BR> The case of the names is not important. You can specify a file of enzyme names to read in by giving the name of the file holding the enzyme names with a \'\@\' character in front of it, for example, \'\@enz.list\'. <BR> Blank lines and lines starting with a hash character or \'!\' are ignored and all other lines are concatenated together with a comma character \',\' and then treated as the list of enzymes to search for. <BR> An example of a file of enzyme names is: <BR> ! my enzymes <BR> HincII, ppiII <BR> ! other enzymes <BR> hindiii <BR> HinfI <BR> PpiI",
	],
	"outfile" => [
		"If you enter the name of a file here then this program will write the sequence details into that file.",
	],
	"orfminsize" => [
		"Minimum size of Open Reading Frames (ORFs) to display in the translations.",
	],
	"uppercase" => [
		"Regions to put in uppercase. <BR> If this is left blank, then the sequence case is left alone. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are separated by any non-digit, non-alpha character. <BR> Examples of region specifications are: <BR> 24-45, 56-78 <BR> 1:45, 67=99;765..888 <BR> 1,5,8,10,23,45,57,99",
	],
	"highlight" => [
		"Regions to colour if formatting for HTML. <BR> If this is left blank, then the sequence is left alone. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are followed by any valid HTML font colour. <BR> Examples of region specifications are: <BR> 24-45 blue 56-78 orange <BR> 1-100 green 120-156 red <BR> A file of ranges to colour (one range per line) can be specifed as \'\@filename\'.",
	],
	"name" => [
		"Set this to be false if you do not wish to display the ID name of the sequence",
	],
	"description" => [
		"Set this to be false if you do not wish to display the description of the sequence",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/remap.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

