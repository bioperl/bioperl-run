
=head1 NAME

Bio::Tools::Run::PiseApplication::restover

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::restover

      Bioperl class for:

	RESTOVER	Finds restriction enzymes that produce a specific overhang (EMBOSS)

      Parameters:


		restover (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		seqcomp (String)
			Overlap sequence (-seqcomp)

		advanced (Paragraph)
			advanced Section

		min (Integer)
			Minimum cuts per RE (-min)

		max (Integer)
			Maximum cuts per RE (-max)

		single (Switch)
			Force single site only cuts (-single)

		threeprime (Switch)
			3' overhang? (else 5') e.g. BamHI has CTAG as a 5' overhang, and ApaI has CCGG as 3' overhang. (-threeprime)

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

		html (Switch)
			Create HTML output (-html)

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
package Bio::Tools::Run::PiseApplication::restover;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $restover = Bio::Tools::Run::PiseApplication::restover->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::restover object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $restover = $factory->program('restover');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::restover.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/restover.pm

    $self->{COMMAND}   = "restover";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "RESTOVER";

    $self->{DESCRIPTION}   = "Finds restriction enzymes that produce a specific overhang (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:restriction",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/restover.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"restover",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"restover",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"seqcomp", 	# Overlap sequence (-seqcomp)
	"advanced", 	# advanced Section
	"min", 	# Minimum cuts per RE (-min)
	"max", 	# Maximum cuts per RE (-max)
	"single", 	# Force single site only cuts (-single)
	"threeprime", 	# 3' overhang? (else 5') e.g. BamHI has CTAG as a 5' overhang, and ApaI has CCGG as 3' overhang. (-threeprime)
	"blunt", 	# Allow blunt end cutters (-blunt)
	"sticky", 	# Allow sticky end cutters (-sticky)
	"ambiguity", 	# Allow ambiguous matches (-ambiguity)
	"plasmid", 	# Allow circular DNA (-plasmid)
	"commercial", 	# Only enzymes with suppliers (-commercial)
	"datafile", 	# Alternative RE data file (-datafile)
	"output", 	# output Section
	"html", 	# Create HTML output (-html)
	"limit", 	# Limits reports to one isoschizomer (-limit)
	"preferred", 	# Report preferred isoschizomers (-preferred)
	"alphabetic", 	# Sort output alphabetically (-alphabetic)
	"fragments", 	# Show fragment lengths (-fragments)
	"name", 	# Show sequence name (-name)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"restover" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"seqcomp" => 'String',
	"advanced" => 'Paragraph',
	"min" => 'Integer',
	"max" => 'Integer',
	"single" => 'Switch',
	"threeprime" => 'Switch',
	"blunt" => 'Switch',
	"sticky" => 'Switch',
	"ambiguity" => 'Switch',
	"plasmid" => 'Switch',
	"commercial" => 'Switch',
	"datafile" => 'String',
	"output" => 'Paragraph',
	"html" => 'Switch',
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
	"seqcomp" => {
		"perl" => '" -seqcomp=$value"',
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
	"threeprime" => {
		"perl" => '($value)? " -threeprime" : ""',
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
	"html" => {
		"perl" => '($value)? " -html" : ""',
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
	"restover" => {
		"perl" => '"restover"',
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
	"seqcomp" => 2,
	"min" => 3,
	"max" => 4,
	"single" => 5,
	"threeprime" => 6,
	"blunt" => 7,
	"sticky" => 8,
	"ambiguity" => 9,
	"plasmid" => 10,
	"commercial" => 11,
	"datafile" => 12,
	"html" => 13,
	"limit" => 14,
	"preferred" => 15,
	"alphabetic" => 16,
	"fragments" => 17,
	"name" => 18,
	"outfile" => 19,
	"auto" => 20,
	"restover" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"restover",
	"sequence",
	"seqcomp",
	"min",
	"max",
	"single",
	"threeprime",
	"blunt",
	"sticky",
	"ambiguity",
	"plasmid",
	"commercial",
	"datafile",
	"html",
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
	"seqcomp" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"threeprime" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"html" => 0,
	"limit" => 0,
	"preferred" => 0,
	"alphabetic" => 0,
	"fragments" => 0,
	"name" => 0,
	"outfile" => 0,
	"auto" => 1,
	"restover" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"seqcomp" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"threeprime" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"html" => 0,
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
	"seqcomp" => 1,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"threeprime" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"html" => 0,
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
	"seqcomp" => "Overlap sequence (-seqcomp)",
	"advanced" => "advanced Section",
	"min" => "Minimum cuts per RE (-min)",
	"max" => "Maximum cuts per RE (-max)",
	"single" => "Force single site only cuts (-single)",
	"threeprime" => "3' overhang? (else 5') e.g. BamHI has CTAG as a 5' overhang, and ApaI has CCGG as 3' overhang. (-threeprime)",
	"blunt" => "Allow blunt end cutters (-blunt)",
	"sticky" => "Allow sticky end cutters (-sticky)",
	"ambiguity" => "Allow ambiguous matches (-ambiguity)",
	"plasmid" => "Allow circular DNA (-plasmid)",
	"commercial" => "Only enzymes with suppliers (-commercial)",
	"datafile" => "Alternative RE data file (-datafile)",
	"output" => "output Section",
	"html" => "Create HTML output (-html)",
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
	"seqcomp" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"threeprime" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"html" => 0,
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
	"required" => ['seqcomp',],
	"advanced" => ['min','max','single','threeprime','blunt','sticky','ambiguity','plasmid','commercial','datafile',],
	"output" => ['html','limit','preferred','alphabetic','fragments','name','outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"min" => '1',
	"max" => '2000000000',
	"single" => '0',
	"threeprime" => '0',
	"blunt" => '1',
	"sticky" => '1',
	"ambiguity" => '1',
	"plasmid" => '0',
	"commercial" => '1',
	"html" => '0',
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
	"seqcomp" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"min" => { "perl" => '1' },
	"max" => { "perl" => '1' },
	"single" => { "perl" => '1' },
	"threeprime" => { "perl" => '1' },
	"blunt" => { "perl" => '1' },
	"sticky" => { "perl" => '1' },
	"ambiguity" => { "perl" => '1' },
	"plasmid" => { "perl" => '1' },
	"commercial" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"html" => { "perl" => '1' },
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
	"seqcomp" => 0,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"threeprime" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"html" => 0,
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
	"seqcomp" => 1,
	"advanced" => 0,
	"min" => 0,
	"max" => 0,
	"single" => 0,
	"threeprime" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"datafile" => 0,
	"output" => 0,
	"html" => 0,
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

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/restover.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

