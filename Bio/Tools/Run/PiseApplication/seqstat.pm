
=head1 NAME

Bio::Tools::Run::PiseApplication::seqstat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::seqstat

      Bioperl class for:

	HMMER	seqstat - show statistics and format for a sequence file (S. Eddy)

      Parameters:


		seqstat (String)


		seqfile (Sequence)
			Sequences file

		verbose (Switch)
			Show additional verbose information (-a)

=cut

#'
package Bio::Tools::Run::PiseApplication::seqstat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $seqstat = Bio::Tools::Run::PiseApplication::seqstat->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::seqstat object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $seqstat = $factory->program('seqstat');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::seqstat.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqstat.pm

    $self->{COMMAND}   = "seqstat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "seqstat - show statistics and format for a sequence file";

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"seqstat",
	"seqfile",
	"verbose",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"seqstat",
	"seqfile", 	# Sequences file
	"verbose", 	# Show additional verbose information (-a)

    ];

    $self->{TYPE}  = {
	"seqstat" => 'String',
	"seqfile" => 'Sequence',
	"verbose" => 'Switch',

    };

    $self->{FORMAT}  = {
	"seqstat" => {
		"perl" => '"seqstat"',
	},
	"seqfile" => {
		"perl" => '" $value"',
	},
	"verbose" => {
		"perl" => '($value) ? " -a " : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqfile" => [2,4,5,8,15],

    };

    $self->{GROUP}  = {
	"seqstat" => 0,
	"seqfile" => 2,
	"verbose" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"seqstat",
	"verbose",
	"seqfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"seqstat" => 1,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{ISCOMMAND}  = {
	"seqstat" => 1,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{ISMANDATORY}  = {
	"seqstat" => 0,
	"seqfile" => 1,
	"verbose" => 0,

    };

    $self->{PROMPT}  = {
	"seqstat" => "",
	"seqfile" => "Sequences file",
	"verbose" => "Show additional verbose information (-a)",

    };

    $self->{ISSTANDOUT}  = {
	"seqstat" => 0,
	"seqfile" => 0,
	"verbose" => 0,

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
	"seqstat" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },

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
	"seqstat" => 0,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{ISSIMPLE}  = {
	"seqstat" => 0,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"verbose" => [
		"a table with one line per sequence showing name, length, and description line. These lines are prefixed with a * character to enable easily grep\'ing them out and sorting them.",
		"seqfile",
		"perl",
		"1",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqstat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

