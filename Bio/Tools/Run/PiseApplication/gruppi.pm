
=head1 NAME

Bio::Tools::Run::PiseApplication::gruppi

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::gruppi

      Bioperl class for:

	gruppi	clusters of binding sites (M. Pontoglio)

      Parameters:


		gruppi (String)
			

		seq (Sequence)
			Sequence File

=cut

#'
package Bio::Tools::Run::PiseApplication::gruppi;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $gruppi = Bio::Tools::Run::PiseApplication::gruppi->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::gruppi object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $gruppi = $factory->program('gruppi');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::gruppi.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gruppi.pm

    $self->{COMMAND}   = "gruppi";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "gruppi";

    $self->{DESCRIPTION}   = "clusters of binding sites";

    $self->{AUTHORS}   = "M. Pontoglio";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"gruppi",
	"seq",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"gruppi",
	"seq", 	# Sequence File

    ];

    $self->{TYPE}  = {
	"gruppi" => 'String',
	"seq" => 'Sequence',

    };

    $self->{FORMAT}  = {
	"gruppi" => {
		"perl" => ' "gruppi /local/gensoft/lib/gruppi/matrix.list" ',
	},
	"seq" => {
		"perl" => '"  $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [3],

    };

    $self->{GROUP}  = {
	"gruppi" => 0,
	"seq" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"gruppi",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"gruppi" => 1,
	"seq" => 0,

    };

    $self->{ISCOMMAND}  = {
	"gruppi" => 1,
	"seq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"gruppi" => 0,
	"seq" => 1,

    };

    $self->{PROMPT}  = {
	"gruppi" => "",
	"seq" => "Sequence File",

    };

    $self->{ISSTANDOUT}  = {
	"gruppi" => 0,
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
	"gruppi" => { "perl" => '1' },
	"seq" => { "perl" => '1' },

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
	"gruppi" => 0,
	"seq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"gruppi" => 0,
	"seq" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gruppi.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

