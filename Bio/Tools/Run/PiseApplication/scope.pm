
=head1 NAME

Bio::Tools::Run::PiseApplication::scope

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::scope

      Bioperl class for:

	SCOPE	Convert raw scop classification file to embl-like format (EMBOSS)

      Parameters:


		scope (String)


		init (String)


		input (Paragraph)
			input Section

		infile (InFile)
			Name of scop file for input (raw format) (-infile)

		output (Paragraph)
			output Section

		outfile (OutFile)
			Name of scop file for output (embl-like format) (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::scope;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $scope = Bio::Tools::Run::PiseApplication::scope->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::scope object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $scope = $factory->program('scope');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::scope.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/scope.pm

    $self->{COMMAND}   = "scope";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SCOPE";

    $self->{DESCRIPTION}   = "Convert raw scop classification file to embl-like format (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "utils:database creation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/scope.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"scope",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"scope",
	"init",
	"input", 	# input Section
	"infile", 	# Name of scop file for input (raw format) (-infile)
	"output", 	# output Section
	"outfile", 	# Name of scop file for output (embl-like format) (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"scope" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"infile" => 'InFile',
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
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"scope" => {
		"perl" => '"scope"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"infile" => 1,
	"outfile" => 2,
	"auto" => 3,
	"scope" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"scope",
	"infile",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"infile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"scope" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"infile" => "Name of scop file for input (raw format) (-infile)",
	"output" => "output Section",
	"outfile" => "Name of scop file for output (embl-like format) (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['infile',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'Escop.dat',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
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
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/scope.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

