
=head1 NAME

Bio::Tools::Run::PiseApplication::prophet

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prophet

      Bioperl class for:

	PROPHET	Gapped alignment for profiles (EMBOSS)

      Parameters:


		prophet (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		infile (InFile)
			Profile or matrix file (-infile)

		gapopen (Float)
			Gap opening coefficient (-gapopen)

		gapextend (Float)
			Gap extension coefficient (-gapextend)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::prophet;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prophet = Bio::Tools::Run::PiseApplication::prophet->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prophet object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $prophet = $factory->program('prophet');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::prophet.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prophet.pm

    $self->{COMMAND}   = "prophet";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PROPHET";

    $self->{DESCRIPTION}   = "Gapped alignment for profiles (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:profiles",

         "protein:profiles",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/prophet.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prophet",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prophet",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"required", 	# required Section
	"infile", 	# Profile or matrix file (-infile)
	"gapopen", 	# Gap opening coefficient (-gapopen)
	"gapextend", 	# Gap extension coefficient (-gapextend)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"prophet" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"infile" => 'InFile',
	"gapopen" => 'Float',
	"gapextend" => 'Float',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"infile" => {
		"perl" => '" -infile=$value"',
	},
	"gapopen" => {
		"perl" => '" -gapopen=$value"',
	},
	"gapextend" => {
		"perl" => '" -gapextend=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"prophet" => {
		"perl" => '"prophet"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"infile" => 2,
	"gapopen" => 3,
	"gapextend" => 4,
	"outfile" => 5,
	"auto" => 6,
	"prophet" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"prophet",
	"sequence",
	"infile",
	"gapopen",
	"gapextend",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"infile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"prophet" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"infile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"infile" => 1,
	"gapopen" => 1,
	"gapextend" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"required" => "required Section",
	"infile" => "Profile or matrix file (-infile)",
	"gapopen" => "Gap opening coefficient (-gapopen)",
	"gapextend" => "Gap extension coefficient (-gapextend)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"infile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['infile','gapopen','gapextend',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gapopen" => '1.0',
	"gapextend" => '1.0',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"gapopen" => { "perl" => '1' },
	"gapextend" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"infile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"infile" => 1,
	"gapopen" => 1,
	"gapextend" => 1,
	"output" => 0,
	"outfile" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prophet.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

