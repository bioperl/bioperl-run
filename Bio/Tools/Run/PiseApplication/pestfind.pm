
=head1 NAME

Bio::Tools::Run::PiseApplication::pestfind

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pestfind

      Bioperl class for:

	PESTFIND	Find PEST (proline, glutamic acid, serine and    threonin) sequences from a single protein sequence (D. Mathog, M. Rechsteiner)

      Parameters:


		pestfind (String)
			

		pest_params (Results)
			

		in_file (Sequence)
			Sequence file

		minimum_aa (Integer)
			Minimum AA number between positive flanks

		print_invalid (Switch)
			Print invalid sequences

		out_file (OutFile)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::pestfind;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pestfind = Bio::Tools::Run::PiseApplication::pestfind->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pestfind object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pestfind = $factory->program('pestfind');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pestfind.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pestfind.pm

    $self->{COMMAND}   = "pestfind";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PESTFIND";

    $self->{DESCRIPTION}   = "Find PEST (proline, glutamic acid, serine and    threonin) sequences from a single protein sequence";

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{AUTHORS}   = "D. Mathog, M. Rechsteiner";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pestfind",
	"pest_params",
	"in_file",
	"minimum_aa",
	"print_invalid",
	"out_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pestfind",
	"pest_params",
	"in_file", 	# Sequence file
	"minimum_aa", 	# Minimum AA number between positive flanks
	"print_invalid", 	# Print invalid sequences
	"out_file",

    ];

    $self->{TYPE}  = {
	"pestfind" => 'String',
	"pest_params" => 'Results',
	"in_file" => 'Sequence',
	"minimum_aa" => 'Integer',
	"print_invalid" => 'Switch',
	"out_file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"pestfind" => {
		"perl" => '"pestfind < params"',
	},
	"pest_params" => {
	},
	"in_file" => {
		"perl" => '"$value\\n"',
	},
	"minimum_aa" => {
		"perl" => '"$value\\n"',
	},
	"print_invalid" => {
		"perl" => '($value)?"y\\n":"n\\n"',
	},
	"out_file" => {
		"perl" => '"results\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"pest_params" => 'params',

    };

    $self->{SEQFMT}  = {
	"in_file" => [13],

    };

    $self->{GROUP}  = {
	"pestfind" => 0,
	"in_file" => 1,
	"minimum_aa" => 2,
	"print_invalid" => 3,
	"out_file" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pestfind",
	"pest_params",
	"in_file",
	"minimum_aa",
	"print_invalid",
	"out_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pestfind" => 1,
	"pest_params" => 0,
	"in_file" => 0,
	"minimum_aa" => 0,
	"print_invalid" => 0,
	"out_file" => 1,

    };

    $self->{ISCOMMAND}  = {
	"pestfind" => 1,
	"pest_params" => 0,
	"in_file" => 0,
	"minimum_aa" => 0,
	"print_invalid" => 0,
	"out_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pestfind" => 0,
	"pest_params" => 0,
	"in_file" => 1,
	"minimum_aa" => 1,
	"print_invalid" => 0,
	"out_file" => 0,

    };

    $self->{PROMPT}  = {
	"pestfind" => "",
	"pest_params" => "",
	"in_file" => "Sequence file",
	"minimum_aa" => "Minimum AA number between positive flanks",
	"print_invalid" => "Print invalid sequences",
	"out_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"pestfind" => 0,
	"pest_params" => 0,
	"in_file" => 0,
	"minimum_aa" => 0,
	"print_invalid" => 0,
	"out_file" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"print_invalid" => '0',
	"out_file" => 'results',

    };

    $self->{PRECOND}  = {
	"pestfind" => { "perl" => '1' },
	"pest_params" => { "perl" => '1' },
	"in_file" => { "perl" => '1' },
	"minimum_aa" => { "perl" => '1' },
	"print_invalid" => { "perl" => '1' },
	"out_file" => { "perl" => '1' },

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
	"pestfind" => 0,
	"pest_params" => 0,
	"in_file" => 0,
	"minimum_aa" => 0,
	"print_invalid" => 0,
	"out_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pestfind" => 0,
	"pest_params" => 0,
	"in_file" => 1,
	"minimum_aa" => 1,
	"print_invalid" => 0,
	"out_file" => 0,

    };

    $self->{PARAMFILE}  = {
	"in_file" => "params",
	"minimum_aa" => "params",
	"print_invalid" => "params",
	"out_file" => "params",

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pestfind.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

