
=head1 NAME

Bio::Tools::Run::PiseApplication::profit

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::profit

      Bioperl class for:

	PROFIT	Scan a sequence or database with a matrix or profile (EMBOSS)

      Parameters:


		profit (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		infile (InFile)
			Profile or matrix file (-infile)

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::profit;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $profit = Bio::Tools::Run::PiseApplication::profit->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::profit object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $profit = $factory->program('profit');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::profit.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/profit.pm

    $self->{COMMAND}   = "profit";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PROFIT";

    $self->{DESCRIPTION}   = "Scan a sequence or database with a matrix or profile (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:profiles",

         "protein:profiles",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/profit.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"profit",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"profit",
	"init",
	"input", 	# input Section
	"infile", 	# Profile or matrix file (-infile)
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"profit" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"infile" => 'InFile',
	"sequence" => 'Sequence',
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
	"infile" => {
		"perl" => '" -infile=$value"',
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"profit" => {
		"perl" => '"profit"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"infile" => 1,
	"sequence" => 2,
	"outfile" => 3,
	"auto" => 4,
	"profit" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"profit",
	"infile",
	"sequence",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"infile" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"profit" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"sequence" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"infile" => "Profile or matrix file (-infile)",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['infile','sequence',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
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
	"infile" => 0,
	"sequence" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"infile" => 1,
	"sequence" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/profit.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

