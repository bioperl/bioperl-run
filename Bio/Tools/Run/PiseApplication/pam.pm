
=head1 NAME

Bio::Tools::Run::PiseApplication::pam

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pam

      Bioperl class for:

	PAM	Generate a PAM matrix

      Parameters:


		pam (String)
			

		scale (Float)
			Scale 0. < scale <= 1000 (-s)

		x (Integer)
			Substitution value for X with any other letter (-x)

		distance (Integer)
			PAM distance (from 2 to 511)

=cut

#'
package Bio::Tools::Run::PiseApplication::pam;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pam = Bio::Tools::Run::PiseApplication::pam->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pam object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pam = $factory->program('pam');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pam.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pam.pm

    $self->{COMMAND}   = "pam";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PAM";

    $self->{DESCRIPTION}   = "Generate a PAM matrix";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pam",
	"scale",
	"x",
	"distance",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pam",
	"scale", 	# Scale 0. < scale <= 1000 (-s)
	"x", 	# Substitution value for X with any other letter (-x)
	"distance", 	# PAM distance (from 2 to 511)

    ];

    $self->{TYPE}  = {
	"pam" => 'String',
	"scale" => 'Float',
	"x" => 'Integer',
	"distance" => 'Integer',

    };

    $self->{FORMAT}  = {
	"pam" => {
		"seqlab" => 'pam',
		"perl" => '"pam"',
	},
	"scale" => {
		"perl" => ' ($value)? " -s $value" : "" ',
	},
	"x" => {
		"perl" => ' ($value)? " -x $value" : "" ',
	},
	"distance" => {
		"perl" => ' ($value)? " $value" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"pam" => 0,
	"scale" => 1,
	"x" => 2,
	"distance" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pam",
	"scale",
	"x",
	"distance",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pam" => 1,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pam" => 1,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pam" => 0,
	"scale" => 0,
	"x" => 0,
	"distance" => 1,

    };

    $self->{PROMPT}  = {
	"pam" => "",
	"scale" => "Scale 0. < scale <= 1000 (-s)",
	"x" => "Substitution value for X with any other letter (-x)",
	"distance" => "PAM distance (from 2 to 511)",

    };

    $self->{ISSTANDOUT}  = {
	"pam" => 0,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"pam" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"x" => { "perl" => '1' },
	"distance" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"scale" => {
		"perl" => {
			'(defined $scale) && ($value <=0 || $value > 1000)' => "0 < scale <= 1000",
		},
	},
	"distance" => {
		"perl" => {
			'$value < 2 || $value > 511' => "2 <= pam distance <= 511",
		},
	},

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
	"pam" => 0,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pam" => 1,
	"scale" => 0,
	"x" => 0,
	"distance" => 1,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"scale" => [
		"An optional floating-point scale for the log-odds matrix in the range 0 < scale <= 1000",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pam.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

