
=head1 NAME

Bio::Tools::Run::PiseApplication::pepstats

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pepstats

      Bioperl class for:

	PEPSTATS	Protein statistics (EMBOSS)

      Parameters:


		pepstats (String)


		init (String)


		input (Paragraph)
			input Section

		sequencea (Sequence)
			sequencea -- PureProtein [single sequence] (-sequencea)
			pipe: seqfile

		advanced (Paragraph)
			advanced Section

		termini (Switch)
			Include charge at N and C terminus (-termini)

		aadata (String)
			Amino acid data file (-aadata)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::pepstats;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pepstats = Bio::Tools::Run::PiseApplication::pepstats->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pepstats object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pepstats = $factory->program('pepstats');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pepstats.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepstats.pm

    $self->{COMMAND}   = "pepstats";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PEPSTATS";

    $self->{DESCRIPTION}   = "Protein statistics (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pepstats.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pepstats",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pepstats",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- PureProtein [single sequence] (-sequencea)
	"advanced", 	# advanced Section
	"termini", 	# Include charge at N and C terminus (-termini)
	"aadata", 	# Amino acid data file (-aadata)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"pepstats" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"advanced" => 'Paragraph',
	"termini" => 'Switch',
	"aadata" => 'String',
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
	"sequencea" => {
		"perl" => '" -sequencea=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"termini" => {
		"perl" => '($value)? "" : " -notermini"',
	},
	"aadata" => {
		"perl" => '($value && $value ne $vdef)? " -aadata=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"pepstats" => {
		"perl" => '"pepstats"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"termini" => 2,
	"aadata" => 3,
	"outfile" => 4,
	"auto" => 5,
	"pepstats" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"pepstats",
	"sequencea",
	"termini",
	"aadata",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"termini" => 0,
	"aadata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"pepstats" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"termini" => 0,
	"aadata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"advanced" => 0,
	"termini" => 0,
	"aadata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequencea" => "sequencea -- PureProtein [single sequence] (-sequencea)",
	"advanced" => "advanced Section",
	"termini" => "Include charge at N and C terminus (-termini)",
	"aadata" => "Amino acid data file (-aadata)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"termini" => 0,
	"aadata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea',],
	"advanced" => ['termini','aadata',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"termini" => '1',
	"aadata" => 'Eamino.dat',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"termini" => { "perl" => '1' },
	"aadata" => { "perl" => '1' },
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
	"sequencea" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"termini" => 0,
	"aadata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"advanced" => 0,
	"termini" => 0,
	"aadata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"aadata" => [
		"Molecular weight data for amino acids",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepstats.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

