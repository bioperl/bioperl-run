
=head1 NAME

Bio::Tools::Run::PiseApplication::pyreval

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pyreval

      Bioperl class for:

	PYRAMIDS	pyreval - pyramidal analysis tool for sequence clustering (JC AUDE)

      Parameters:


		pyreval (String)
			

		pyr_file (InFile)
			Pyramidal representations file (.pyr or .pyt)
			pipe: pyramid_file

		uti_file (InFile)
			Pyramids informations file (.uti)

=cut

#'
package Bio::Tools::Run::PiseApplication::pyreval;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pyreval = Bio::Tools::Run::PiseApplication::pyreval->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pyreval object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pyreval = $factory->program('pyreval');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pyreval.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pyreval.pm

    $self->{COMMAND}   = "pyreval";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PYRAMIDS";

    $self->{DESCRIPTION}   = "pyreval - pyramidal analysis tool for sequence clustering";

    $self->{AUTHORS}   = "JC AUDE";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pyreval",
	"pyr_file",
	"uti_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pyreval",
	"pyr_file", 	# Pyramidal representations file (.pyr or .pyt)
	"uti_file", 	# Pyramids informations file (.uti)

    ];

    $self->{TYPE}  = {
	"pyreval" => 'String',
	"pyr_file" => 'InFile',
	"uti_file" => 'InFile',

    };

    $self->{FORMAT}  = {
	"pyreval" => {
		"seqlab" => 'pyreval',
		"perl" => '"pyreval"',
	},
	"pyr_file" => {
		"perl" => '" $value"',
	},
	"uti_file" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"pyreval" => 0,
	"pyr_file" => 2,
	"uti_file" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pyreval",
	"uti_file",
	"pyr_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pyreval" => 1,
	"pyr_file" => 0,
	"uti_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pyreval" => 1,
	"pyr_file" => 0,
	"uti_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pyreval" => 0,
	"pyr_file" => 1,
	"uti_file" => 1,

    };

    $self->{PROMPT}  = {
	"pyreval" => "",
	"pyr_file" => "Pyramidal representations file (.pyr or .pyt)",
	"uti_file" => "Pyramids informations file (.uti)",

    };

    $self->{ISSTANDOUT}  = {
	"pyreval" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,

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
	"pyreval" => { "perl" => '1' },
	"pyr_file" => { "perl" => '1' },
	"uti_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"pyr_file" => {
		 "pyramid_file" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {
	"pyr_file" => {
		 "pyramid_file" => ["uti_file",]
	},

    };

    $self->{ISCLEAN}  = {
	"pyreval" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pyreval" => 1,
	"pyr_file" => 1,
	"uti_file" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pyreval.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

