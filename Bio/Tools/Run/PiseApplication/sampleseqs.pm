
=head1 NAME

Bio::Tools::Run::PiseApplication::sampleseqs

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::sampleseqs

      Bioperl class for:

	SAM	sampleseqs - generate typical sequences from a model (R. Hughey, A. Krogh)

      Parameters:


		sampleseqs (String)


		run (String)
			Run name

		model_file (InFile)
			Model (-i)
			pipe: sam_model

		nseq (Integer)
			How many sequences (-nseq)

		seqfile (Results)

			pipe: seqsfile

=cut

#'
package Bio::Tools::Run::PiseApplication::sampleseqs;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $sampleseqs = Bio::Tools::Run::PiseApplication::sampleseqs->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::sampleseqs object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $sampleseqs = $factory->program('sampleseqs');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::sampleseqs.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sampleseqs.pm

    $self->{COMMAND}   = "sampleseqs";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "sampleseqs - generate typical sequences from a model";

    $self->{AUTHORS}   = "R. Hughey, A. Krogh";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"sampleseqs",
	"run",
	"model_file",
	"nseq",
	"seqfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"sampleseqs",
	"run", 	# Run name
	"model_file", 	# Model (-i)
	"nseq", 	# How many sequences (-nseq)
	"seqfile",

    ];

    $self->{TYPE}  = {
	"sampleseqs" => 'String',
	"run" => 'String',
	"model_file" => 'InFile',
	"nseq" => 'Integer',
	"seqfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"sampleseqs" => {
		"seqlab" => 'sampleseqs',
		"perl" => '"sampleseqs"',
	},
	"run" => {
		"perl" => '" $value"',
	},
	"model_file" => {
		"perl" => ' ($value)? " -i $value" : ""',
	},
	"nseq" => {
		"perl" => ' ($value)? " -nseq $value" : "" ',
	},
	"seqfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"seqfile" => '*.seq',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"sampleseqs" => 0,
	"run" => 1,
	"model_file" => 2,
	"nseq" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"sampleseqs",
	"seqfile",
	"run",
	"model_file",
	"nseq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"sampleseqs" => 1,
	"run" => 0,
	"model_file" => 0,
	"nseq" => 0,
	"seqfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"sampleseqs" => 1,
	"run" => 0,
	"model_file" => 0,
	"nseq" => 0,
	"seqfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"sampleseqs" => 0,
	"run" => 1,
	"model_file" => 1,
	"nseq" => 1,
	"seqfile" => 0,

    };

    $self->{PROMPT}  = {
	"sampleseqs" => "",
	"run" => "Run name",
	"model_file" => "Model (-i)",
	"nseq" => "How many sequences (-nseq)",
	"seqfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"sampleseqs" => 0,
	"run" => 0,
	"model_file" => 0,
	"nseq" => 0,
	"seqfile" => 0,

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
	"sampleseqs" => { "perl" => '1' },
	"run" => { "perl" => '1' },
	"model_file" => { "perl" => '1' },
	"nseq" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"seqfile" => {
		 '1' => "seqsfile",
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
	"sampleseqs" => 0,
	"run" => 0,
	"model_file" => 0,
	"nseq" => 0,
	"seqfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"sampleseqs" => 1,
	"run" => 0,
	"model_file" => 1,
	"nseq" => 1,
	"seqfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sampleseqs.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

