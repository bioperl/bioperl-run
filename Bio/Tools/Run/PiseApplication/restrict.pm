
=head1 NAME

Bio::Tools::Run::PiseApplication::restrict

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::restrict

      Bioperl class for:

	RESTRICT	Finds restriction enzyme cleavage sites (EMBOSS)

      Parameters:


		restrict (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		sitelen (Integer)
			Minimum recognition site length (-sitelen)

		enzymes (String)
			Comma separated enzyme list (-enzymes)

		advanced (Paragraph)
			advanced Section

		min (Integer)
			Minimum cuts per RE (-min)

		max (Integer)
			Maximum cuts per RE (-max)

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

		datafile (String)
			Alternative RE data file (-datafile)

		output (Paragraph)
			output Section

		limit (Switch)
			Limits reports to one isoschizomer (-limit)

		preferred (Switch)
			Report preferred isoschizomers (-preferred)

		alphabetic (Switch)
			Sort output alphabetically (-alphabetic)

		fragments (Switch)
			Show fragment lengths (-fragments)

		name (Switch)
			Show sequence name (-name)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::restrict;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $restrict = Bio::Tools::Run::PiseApplication::restrict->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::restrict object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $restrict = $factory->program('restrict');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::restrict.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/restrict.pm

    $self->{COMMAND}   = "restrict";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "RESTRICT";

    $self->{DESCRIPTION}   = "Finds restriction enzyme cleavage sites (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:restriction",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/restrict.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"restrict",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"restrict",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"sitelen", 	# Minimum recognition site length (-sitelen)
	"enzymes", 	# Comma separated enzyme list (-enzymes)
	"advanced", 	# advanced Section
	"min", 	# Minimum cuts per RE (-min)
	"max", 	# Maximum cuts per RE (-max)
	"single", 	# Force single site only cuts (-single)
	"blunt", 	# Allow blunt end cutters (-blunt)
	"sticky", 	# Allow sticky end cutters (-sticky)
	"ambiguity", 	# Allow ambiguous matches (-ambiguity)
	"plasmid", 	# Allow circular DNA (-plasmid)
	"commercial", 	# Only enzymes with suppliers (-commercial)
	"datafile", 	# Alternative RE data file (-datafile)
	"output", 	# output Section
	"limit", 	# Limits reports to one isoschizomer (-limit)
	"preferred", 	# Report preferred isoschizomers (-preferred)
	"alphabetic", 	# Sort output alphabetically (-alphabetic)
	"fragments", 	# Show fragment lengths (-fragments)
	"name", 	# Show sequence name (-name)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"restrict" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"sitelen" => 'Integer',
	"enzymes" => 'String',
	"advanced" => 'Paragraph',
	"min" => 'Integer',
	"max" => 'Integer',
	"single" => 'Switch',
	"blunt" => 'Switch',
	"sticky" => 'Switch',
	"ambiguity" => 'Switch',
	"plasmid" => 'Switch',
	"commercial" => 'Switch',
	"datafile" => 'String',
	"output" => 'Paragraph',
	"limit" => 'Switch',
	"preferred" => 'Switch',
	"alphabetic" => 'Switch',
	"fragments" => 'Switch',
	"name" => 'Switch',
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
	"sitelen" => {
		"perl" => '" -sitelen=$value"',
	},
	"enzymes" => {
		"perl" => '" -enzymes=$value"',
	},
	"advanced" => {
	},
	"min" => {
		"perl" => '(defined $value && $value != $vdef)? " -min=$value" : ""',
	},
	"max" => {
		"perl" => '(defined $value && $value != $vdef)? " -max=$value" : ""',
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
	"datafile" => {
		"perl" => '($value)? " -datafile=$value" : ""',
	},
	"output" => {
	},
	"limit" => {
		"perl" => '($value)? "" : " -nolimit"',
	},
	"preferred" => {
		"perl" => '($value)? " -preferred" : ""',
	},
	"alphabetic" => {
		"perl" => '($value)? " -alphabetic" : ""',
	},
	"fragments" => {
		"perl" => '($value)? " -fragments" : ""',
	},
	"name" => {
		"perl" => '($value)? " -name" : ""',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"restrict" => {
		"perl" => '"restrict"',
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
	"sitelen" => 2,
	"enzymes" => 3,
	"min" => 4,
	"max" => 5,
	"single" => 6,
	"blunt" => 7,
	"sticky" => 8,
	"ambiguity" => 9,
	"plasmid" => 10,
	"commercial" => 11,
	"datafile" => 12,
	"limit" => 13,
	"preferred" => 14,
	"alphabetic" => 15,
	"fragments" => 16,
	"name" => 17,
	"outfile" => 18,
	"auto" => 19,
	"restrict" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"restrict",
	"sequence",
	"sitelen",
	"enzymes",
	"min",
	"max",
	"single",
	"blunt",
	"sticky",
	"ambiguity",
	"plasmid",
	"commercial",
	"datafile",
	"limit",
	"preferred",
	"alphabetic",
	"fragments",
	"name",
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
	"sitelen" => 0,
	"enzymes" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 0,
	"auto" => 1,
	"restrict" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"sitelen" => 0,
	"enzymes" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"sitelen" => 1,
	"enzymes" => 1,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"required" => "required Section",
	"sitelen" => "Minimum recognition site length (-sitelen)",
	"enzymes" => "Comma separated enzyme list (-enzymes)",
	"advanced" => "advanced Section",
	"min" => "Minimum cuts per RE (-min)",
	"max" => "Maximum cuts per RE (-max)",
	"single" => "Force single site only cuts (-single)",
	"blunt" => "Allow blunt end cutters (-blunt)",
	"sticky" => "Allow sticky end cutters (-sticky)",
	"ambiguity" => "Allow ambiguous matches (-ambiguity)",
	"plasmid" => "Allow circular DNA (-plasmid)",
	"commercial" => "Only enzymes with suppliers (-commercial)",
	"datafile" => "Alternative RE data file (-datafile)",
	"output" => "output Section",
	"limit" => "Limits reports to one isoschizomer (-limit)",
	"preferred" => "Report preferred isoschizomers (-preferred)",
	"alphabetic" => "Sort output alphabetically (-alphabetic)",
	"fragments" => "Show fragment lengths (-fragments)",
	"name" => "Show sequence name (-name)",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"sitelen" => 0,
	"enzymes" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['sitelen','enzymes',],
	"advanced" => ['min','max','single','blunt','sticky','ambiguity','plasmid','commercial','datafile',],
	"output" => ['limit','preferred','alphabetic','fragments','name','outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"sitelen" => '4',
	"enzymes" => 'all',
	"min" => '1',
	"max" => '2000000000',
	"single" => '0',
	"blunt" => '1',
	"sticky" => '1',
	"ambiguity" => '1',
	"plasmid" => '0',
	"commercial" => '1',
	"limit" => '1',
	"preferred" => '0',
	"alphabetic" => '0',
	"fragments" => '0',
	"name" => '0',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"sitelen" => { "perl" => '1' },
	"enzymes" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"min" => { "perl" => '1' },
	"max" => { "perl" => '1' },
	"single" => { "perl" => '1' },
	"blunt" => { "perl" => '1' },
	"sticky" => { "perl" => '1' },
	"ambiguity" => { "perl" => '1' },
	"plasmid" => { "perl" => '1' },
	"commercial" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"limit" => { "perl" => '1' },
	"preferred" => { "perl" => '1' },
	"alphabetic" => { "perl" => '1' },
	"fragments" => { "perl" => '1' },
	"name" => { "perl" => '1' },
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
	"sitelen" => 0,
	"enzymes" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"sitelen" => 1,
	"enzymes" => 1,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"enzymes" => [
		"The name \'all\' reads in all enzyme names from the REBASE database. You can specify enzymes by giving their names with commas between then, such as: \'HincII,hinfI,ppiI,hindiii\'. <BR> The case of the names is not important. You can specify a file of enzyme names to read in by giving the name of the file holding the enzyme names with a \'\@\' character in front of it, for example, \'\@enz.list\'. <BR> Blank lines and lines starting with a hash character or \'!\' are ignored and all other lines are concatenated together with a comma character \',\' and then treated as the list of enzymes to search for. <BR> An example of a file of enzyme names is: <BR> ! my enzymes <BR> HincII, ppiII <BR> ! other enzymes <BR> hindiii <BR> HinfI <BR> PpiI",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/restrict.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

