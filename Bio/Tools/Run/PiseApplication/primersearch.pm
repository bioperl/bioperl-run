
=head1 NAME

Bio::Tools::Run::PiseApplication::primersearch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::primersearch

      Bioperl class for:

	PRIMERSEARCH	Searches DNA sequences for matches with primer pairs (EMBOSS)

      Parameters:


		primersearch (String)


		init (String)


		input (Paragraph)
			input Section

		sequences (Sequence)
			sequences -- dna [sequences] (-sequences)
			pipe: seqsfile

		primers (InFile)
			Primer file (-primers)

		required (Paragraph)
			required Section

		mismatchpercent (Integer)
			Allowed percent mismatch (-mismatchpercent)

		output (Paragraph)
			output Section

		out (OutFile)
			out (-out)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::primersearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $primersearch = Bio::Tools::Run::PiseApplication::primersearch->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::primersearch object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $primersearch = $factory->program('primersearch');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::primersearch.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/primersearch.pm

    $self->{COMMAND}   = "primersearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PRIMERSEARCH";

    $self->{DESCRIPTION}   = "Searches DNA sequences for matches with primer pairs (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:primers",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/primersearch.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"primersearch",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"primersearch",
	"init",
	"input", 	# input Section
	"sequences", 	# sequences -- dna [sequences] (-sequences)
	"primers", 	# Primer file (-primers)
	"required", 	# required Section
	"mismatchpercent", 	# Allowed percent mismatch (-mismatchpercent)
	"output", 	# output Section
	"out", 	# out (-out)
	"auto",

    ];

    $self->{TYPE}  = {
	"primersearch" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequences" => 'Sequence',
	"primers" => 'InFile',
	"required" => 'Paragraph',
	"mismatchpercent" => 'Integer',
	"output" => 'Paragraph',
	"out" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequences" => {
		"perl" => '" -sequences=$value -sformat=fasta"',
	},
	"primers" => {
		"perl" => '" -primers=$value"',
	},
	"required" => {
	},
	"mismatchpercent" => {
		"perl" => '" -mismatchpercent=$value"',
	},
	"output" => {
	},
	"out" => {
		"perl" => '" -out=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"primersearch" => {
		"perl" => '"primersearch"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequences" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequences" => 1,
	"primers" => 2,
	"mismatchpercent" => 3,
	"out" => 4,
	"auto" => 5,
	"primersearch" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"primersearch",
	"sequences",
	"primers",
	"mismatchpercent",
	"out",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"required" => 0,
	"mismatchpercent" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 1,
	"primersearch" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"required" => 0,
	"mismatchpercent" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 1,
	"primers" => 1,
	"required" => 0,
	"mismatchpercent" => 1,
	"output" => 0,
	"out" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequences" => "sequences -- dna [sequences] (-sequences)",
	"primers" => "Primer file (-primers)",
	"required" => "required Section",
	"mismatchpercent" => "Allowed percent mismatch (-mismatchpercent)",
	"output" => "output Section",
	"out" => "out (-out)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"required" => 0,
	"mismatchpercent" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequences','primers',],
	"required" => ['mismatchpercent',],
	"output" => ['out',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mismatchpercent" => '0',
	"out" => 'out.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequences" => { "perl" => '1' },
	"primers" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"mismatchpercent" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"out" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequences" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"required" => 0,
	"mismatchpercent" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 1,
	"primers" => 1,
	"required" => 0,
	"mismatchpercent" => 1,
	"output" => 0,
	"out" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/primersearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

