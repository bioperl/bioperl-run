
=head1 NAME

Bio::Tools::Run::PiseApplication::hmmer2sam

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmer2sam

      Bioperl class for:

	SAM: hmmer2sam (R. Hughey & A. Krogh)	

      Parameters:


		hmmer2sam (String)
			

		hmmfile (InFile)
			HMMER model file
			pipe: hmm_textfile

		model_file (OutFile)
			SAM model file
			pipe: sam_model

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmer2sam;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmer2sam = Bio::Tools::Run::PiseApplication::hmmer2sam->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmer2sam object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $hmmer2sam = $factory->program('hmmer2sam');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmer2sam.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmer2sam.pm

    $self->{COMMAND}   = "hmmer2sam";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM: hmmer2sam (R. Hughey & A. Krogh)";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmer2sam",
	"hmmfile",
	"model_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmer2sam",
	"hmmfile", 	# HMMER model file
	"model_file", 	# SAM model file

    ];

    $self->{TYPE}  = {
	"hmmer2sam" => 'String',
	"hmmfile" => 'InFile',
	"model_file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"hmmer2sam" => {
		"seqlab" => 'hmmer2sam',
		"perl" => '"hmmer2sam"',
	},
	"hmmfile" => {
		"perl" => '" $value"',
	},
	"model_file" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 1,
	"model_file" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"hmmer2sam",
	"hmmfile",
	"model_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmer2sam" => 1,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmer2sam" => 1,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 1,
	"model_file" => 1,

    };

    $self->{PROMPT}  = {
	"hmmer2sam" => "",
	"hmmfile" => "HMMER model file",
	"model_file" => "SAM model file",

    };

    $self->{ISSTANDOUT}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 0,
	"model_file" => 0,

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
	"hmmer2sam" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"model_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"model_file" => {
		 '1' => "sam_model",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"hmmfile" => {
		 "hmm_textfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmer2sam" => 1,
	"hmmfile" => 1,
	"model_file" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmer2sam.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

