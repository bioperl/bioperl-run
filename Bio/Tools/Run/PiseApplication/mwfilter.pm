
=head1 NAME

Bio::Tools::Run::PiseApplication::mwfilter

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mwfilter

      Bioperl class for:

	MWFILTER	Filter noisy molwts from mass spec output (EMBOSS)

      Parameters:


		mwfilter (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		infile (InFile)
			Molecular weight file input (-infile)

		required (Paragraph)
			required Section

		tolerance (Float)
			ppm tolerance (-tolerance)

		advanced (Paragraph)
			advanced Section

		datafile (String)
			Data file of noisy molecular weights (-datafile)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::mwfilter;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mwfilter = Bio::Tools::Run::PiseApplication::mwfilter->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mwfilter object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $mwfilter = $factory->program('mwfilter');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::mwfilter.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mwfilter.pm

    $self->{COMMAND}   = "mwfilter";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MWFILTER";

    $self->{DESCRIPTION}   = "Filter noisy molwts from mass spec output (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/mwfilter.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mwfilter",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mwfilter",
	"init",
	"input", 	# input Section
	"infile", 	# Molecular weight file input (-infile)
	"required", 	# required Section
	"tolerance", 	# ppm tolerance (-tolerance)
	"advanced", 	# advanced Section
	"datafile", 	# Data file of noisy molecular weights (-datafile)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"mwfilter" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"infile" => 'InFile',
	"required" => 'Paragraph',
	"tolerance" => 'Float',
	"advanced" => 'Paragraph',
	"datafile" => 'String',
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
	"infile" => {
		"perl" => '" -infile=$value"',
	},
	"required" => {
	},
	"tolerance" => {
		"perl" => '" -tolerance=$value"',
	},
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value && $value ne $vdef)? " -datafile=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"mwfilter" => {
		"perl" => '"mwfilter"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"infile" => 1,
	"tolerance" => 2,
	"datafile" => 3,
	"outfile" => 4,
	"auto" => 5,
	"mwfilter" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"mwfilter",
	"infile",
	"tolerance",
	"datafile",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"mwfilter" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"required" => 0,
	"tolerance" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"infile" => "Molecular weight file input (-infile)",
	"required" => "required Section",
	"tolerance" => "ppm tolerance (-tolerance)",
	"advanced" => "advanced Section",
	"datafile" => "Data file of noisy molecular weights (-datafile)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['infile',],
	"required" => ['tolerance',],
	"advanced" => ['datafile',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"tolerance" => '50.0',
	"datafile" => 'Emwfilter.dat',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"tolerance" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
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

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"required" => 0,
	"tolerance" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"required" => 0,
	"tolerance" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mwfilter.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

