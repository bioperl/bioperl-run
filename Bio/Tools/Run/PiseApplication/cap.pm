
=head1 NAME

Bio::Tools::Run::PiseApplication::cap

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cap

      Bioperl class for:

	CAP	Contig Assembly Program

      Parameters:


		cap (String)


		seq (Sequence)
			Fragments File
			pipe: seqsfile

=cut

#'
package Bio::Tools::Run::PiseApplication::cap;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cap = Bio::Tools::Run::PiseApplication::cap->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cap object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $cap = $factory->program('cap');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::cap.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cap.pm

    $self->{COMMAND}   = "cap";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CAP";

    $self->{DESCRIPTION}   = "Contig Assembly Program";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cap",
	"seq",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cap",
	"seq", 	# Fragments File

    ];

    $self->{TYPE}  = {
	"cap" => 'String',
	"seq" => 'Sequence',

    };

    $self->{FORMAT}  = {
	"cap" => {
		"seqlab" => 'cap',
		"perl" => '"cap"',
	},
	"seq" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"cap" => 0,
	"seq" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"cap",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"cap" => 1,
	"seq" => 0,

    };

    $self->{ISCOMMAND}  = {
	"cap" => 1,
	"seq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"cap" => 0,
	"seq" => 1,

    };

    $self->{PROMPT}  = {
	"cap" => "",
	"seq" => "Fragments File",

    };

    $self->{ISSTANDOUT}  = {
	"cap" => 0,
	"seq" => 0,

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
	"cap" => { "perl" => '1' },
	"seq" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"cap" => 0,
	"seq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"cap" => 1,
	"seq" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cap.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

