
=head1 NAME

Bio::Tools::Run::PiseApplication::listor

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::listor

      Bioperl class for:

	LISTOR	Writes a list file of the logical OR of two sets of sequences (EMBOSS)

      Parameters:


		listor (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		firstset (Sequence)
			firstset [set of sequences] (-firstset)
			pipe: seqsfile

		secondset (Sequence)
			secondset [set of sequences] (-secondset)

		advanced (Paragraph)
			advanced Section

		operator (Excl)
			Enter the logical operator to combine the sequences -- Logical operator to combine sequence lists (-operator)

		output (Paragraph)
			output Section

		outlist (OutFile)
			Output list file (-outlist)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::listor;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $listor = Bio::Tools::Run::PiseApplication::listor->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::listor object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $listor = $factory->program('listor');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::listor.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/listor.pm

    $self->{COMMAND}   = "listor";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "LISTOR";

    $self->{DESCRIPTION}   = "Writes a list file of the logical OR of two sets of sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/listor.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"listor",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"listor",
	"init",
	"input", 	# input Section
	"firstset", 	# firstset [set of sequences] (-firstset)
	"secondset", 	# secondset [set of sequences] (-secondset)
	"advanced", 	# advanced Section
	"operator", 	# Enter the logical operator to combine the sequences -- Logical operator to combine sequence lists (-operator)
	"output", 	# output Section
	"outlist", 	# Output list file (-outlist)
	"auto",

    ];

    $self->{TYPE}  = {
	"listor" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"firstset" => 'Sequence',
	"secondset" => 'Sequence',
	"advanced" => 'Paragraph',
	"operator" => 'Excl',
	"output" => 'Paragraph',
	"outlist" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"firstset" => {
		"perl" => '" -firstset=$value -sformat=fasta"',
	},
	"secondset" => {
		"perl" => '" -secondset=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"operator" => {
		"perl" => '" -operator=$value"',
	},
	"output" => {
	},
	"outlist" => {
		"perl" => '" -outlist=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"listor" => {
		"perl" => '"listor"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"firstset" => [8],
	"secondset" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"firstset" => 1,
	"secondset" => 2,
	"operator" => 3,
	"outlist" => 4,
	"auto" => 5,
	"listor" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"listor",
	"firstset",
	"secondset",
	"operator",
	"outlist",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"firstset" => 0,
	"secondset" => 0,
	"advanced" => 0,
	"operator" => 0,
	"output" => 0,
	"outlist" => 0,
	"auto" => 1,
	"listor" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"firstset" => 0,
	"secondset" => 0,
	"advanced" => 0,
	"operator" => 0,
	"output" => 0,
	"outlist" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"firstset" => 1,
	"secondset" => 1,
	"advanced" => 0,
	"operator" => 1,
	"output" => 0,
	"outlist" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"firstset" => "firstset [set of sequences] (-firstset)",
	"secondset" => "secondset [set of sequences] (-secondset)",
	"advanced" => "advanced Section",
	"operator" => "Enter the logical operator to combine the sequences -- Logical operator to combine sequence lists (-operator)",
	"output" => "output Section",
	"outlist" => "Output list file (-outlist)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"firstset" => 0,
	"secondset" => 0,
	"advanced" => 0,
	"operator" => 0,
	"output" => 0,
	"outlist" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['firstset','secondset',],
	"advanced" => ['operator',],
	"operator" => ['O','OR - merger of both sets','A','AND - only those in both sets','X','XOR - only those not in both sets','N','NOT - those of the first set that are not in the second',],
	"output" => ['outlist',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"operator" => 'OR',
	"outlist" => 'outlist.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"firstset" => { "perl" => '1' },
	"secondset" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"operator" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outlist" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"firstset" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"firstset" => 0,
	"secondset" => 0,
	"advanced" => 0,
	"operator" => 0,
	"output" => 0,
	"outlist" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"firstset" => 1,
	"secondset" => 1,
	"advanced" => 0,
	"operator" => 1,
	"output" => 0,
	"outlist" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"operator" => [
		"The following logical operators combine the sequences in the following ways: <BR> OR - gives all that occur in one set or the other <BR> AND - gives only those which occur in both sets <BR> XOR - gives those which only occur in one set or the other, but not in both <BR> NOT - gives those which occur in the first set except for those that also occur in the second",
	],
	"outlist" => [
		"The list of sequence names will be written to this list file",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/listor.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

