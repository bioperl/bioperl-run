
=head1 NAME

Bio::Tools::Run::PiseApplication::cpgreport

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cpgreport

      Bioperl class for:

	CPGREPORT	Reports all CpG rich regions (EMBOSS)

      Parameters:


		cpgreport (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		score (Integer)
			CpG score (-score)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		featout (OutFile)
			feature file for output (-featout)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::cpgreport;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cpgreport = Bio::Tools::Run::PiseApplication::cpgreport->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cpgreport object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $cpgreport = $factory->program('cpgreport');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::cpgreport.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cpgreport.pm

    $self->{COMMAND}   = "cpgreport";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CPGREPORT";

    $self->{DESCRIPTION}   = "Reports all CpG rich regions (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:cpg islands",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/cpgreport.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cpgreport",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cpgreport",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"score", 	# CpG score (-score)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"featout", 	# feature file for output (-featout)
	"auto",

    ];

    $self->{TYPE}  = {
	"cpgreport" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"score" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"featout" => 'OutFile',
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
	"score" => {
		"perl" => '" -score=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"featout" => {
		"perl" => '" -featout=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"cpgreport" => {
		"perl" => '"cpgreport"',
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
	"score" => 2,
	"outfile" => 3,
	"featout" => 4,
	"auto" => 5,
	"cpgreport" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"cpgreport",
	"required",
	"output",
	"sequence",
	"score",
	"outfile",
	"featout",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"auto" => 1,
	"cpgreport" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"score" => 1,
	"output" => 0,
	"outfile" => 1,
	"featout" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"required" => "required Section",
	"score" => "CpG score (-score)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"featout" => "feature file for output (-featout)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['score',],
	"output" => ['outfile','featout',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"score" => '17',
	"outfile" => 'outfile.out',
	"featout" => 'featout.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"score" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"featout" => { "perl" => '1' },
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
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"score" => 1,
	"output" => 0,
	"outfile" => 1,
	"featout" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"score" => [
		"This sets the score for each CG sequence found. A value of 17 is more sensitive, but 28 has also been used with some success.",
	],
	"featout" => [
		"File for output features",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cpgreport.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

