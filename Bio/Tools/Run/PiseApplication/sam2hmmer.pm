
=head1 NAME

Bio::Tools::Run::PiseApplication::sam2hmmer

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::sam2hmmer

      Bioperl class for:

	SAM	sam2hmmer (R. Hughey, A. Krogh)

      Parameters:


		sam2hmmer (String)


		run (String)
			Run name

		model_file (InFile)
			Model (-i)
			pipe: sam_model

		hmmfile (Results)

			pipe: hmmfile

=cut

#'
package Bio::Tools::Run::PiseApplication::sam2hmmer;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $sam2hmmer = Bio::Tools::Run::PiseApplication::sam2hmmer->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::sam2hmmer object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $sam2hmmer = $factory->program('sam2hmmer');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::sam2hmmer.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sam2hmmer.pm

    $self->{COMMAND}   = "sam2hmmer";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "sam2hmmer";

    $self->{AUTHORS}   = "R. Hughey, A. Krogh";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"sam2hmmer",
	"run",
	"model_file",
	"hmmfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"sam2hmmer",
	"run", 	# Run name
	"model_file", 	# Model (-i)
	"hmmfile",

    ];

    $self->{TYPE}  = {
	"sam2hmmer" => 'String',
	"run" => 'String',
	"model_file" => 'InFile',
	"hmmfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"sam2hmmer" => {
		"seqlab" => 'sam2hmmer',
		"perl" => '"sam2hmmer"',
	},
	"run" => {
		"perl" => '" $value"',
	},
	"model_file" => {
		"perl" => ' ($value)? " -i $value" : ""',
	},
	"hmmfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"hmmfile" => '*.hmmer',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"sam2hmmer" => 0,
	"run" => 1,
	"model_file" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"sam2hmmer",
	"hmmfile",
	"run",
	"model_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"sam2hmmer" => 1,
	"run" => 0,
	"model_file" => 0,
	"hmmfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"sam2hmmer" => 1,
	"run" => 0,
	"model_file" => 0,
	"hmmfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"sam2hmmer" => 0,
	"run" => 1,
	"model_file" => 1,
	"hmmfile" => 0,

    };

    $self->{PROMPT}  = {
	"sam2hmmer" => "",
	"run" => "Run name",
	"model_file" => "Model (-i)",
	"hmmfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"sam2hmmer" => 0,
	"run" => 0,
	"model_file" => 0,
	"hmmfile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"run" => 'test',

    };

    $self->{PRECOND}  = {
	"sam2hmmer" => { "perl" => '1' },
	"run" => { "perl" => '1' },
	"model_file" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"hmmfile" => {
		 '1' => "hmmfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"model_file" => {
		 "sam_model" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"sam2hmmer" => 0,
	"run" => 0,
	"model_file" => 0,
	"hmmfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"sam2hmmer" => 1,
	"run" => 0,
	"model_file" => 1,
	"hmmfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sam2hmmer.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

