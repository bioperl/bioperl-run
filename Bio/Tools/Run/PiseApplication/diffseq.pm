
=head1 NAME

Bio::Tools::Run::PiseApplication::diffseq

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::diffseq

      Bioperl class for:

	DIFFSEQ	Find differences (SNPs) between nearly identical sequences (EMBOSS)

      Parameters:


		diffseq (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		asequence (Sequence)
			asequence -- any [single sequence] (-asequence)
			pipe: seqfile

		bsequence (Sequence)
			bsequence [single sequence] (-bsequence)

		required (Paragraph)
			required Section

		wordsize (Integer)
			Word size (-wordsize)

		output (Paragraph)
			output Section

		outfile (OutFile)
			Output report file (-outfile)

		afeatout (OutFile)
			Feature file for output asequence (-afeatout)

		bfeatout (OutFile)
			Feature file for output bsequence (-bfeatout)

		columns (Switch)
			Output in columns format (-columns)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::diffseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $diffseq = Bio::Tools::Run::PiseApplication::diffseq->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::diffseq object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $diffseq = $factory->program('diffseq');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::diffseq.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/diffseq.pm

    $self->{COMMAND}   = "diffseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DIFFSEQ";

    $self->{DESCRIPTION}   = "Find differences (SNPs) between nearly identical sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:differences",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/diffseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"diffseq",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"diffseq",
	"init",
	"input", 	# input Section
	"asequence", 	# asequence -- any [single sequence] (-asequence)
	"bsequence", 	# bsequence [single sequence] (-bsequence)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"outfile", 	# Output report file (-outfile)
	"afeatout", 	# Feature file for output asequence (-afeatout)
	"bfeatout", 	# Feature file for output bsequence (-bfeatout)
	"columns", 	# Output in columns format (-columns)
	"auto",

    ];

    $self->{TYPE}  = {
	"diffseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"asequence" => 'Sequence',
	"bsequence" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"afeatout" => 'OutFile',
	"bfeatout" => 'OutFile',
	"columns" => 'Switch',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"asequence" => {
		"perl" => '" -asequence=$value"',
	},
	"bsequence" => {
		"perl" => '" -bsequence=$value"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"afeatout" => {
		"perl" => '($value && $value ne $vdef)? " -afeatout=$value" : ""',
	},
	"bfeatout" => {
		"perl" => '($value && $value ne $vdef)? " -bfeatout=$value" : ""',
	},
	"columns" => {
		"perl" => '($value)? " -columns" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"diffseq" => {
		"perl" => '"diffseq"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"asequence" => [2,4,14],
	"bsequence" => [2,4,14],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"asequence" => 1,
	"bsequence" => 2,
	"wordsize" => 3,
	"outfile" => 4,
	"afeatout" => 5,
	"bfeatout" => 6,
	"columns" => 7,
	"auto" => 8,
	"diffseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"diffseq",
	"asequence",
	"bsequence",
	"wordsize",
	"outfile",
	"afeatout",
	"bfeatout",
	"columns",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"bfeatout" => 0,
	"columns" => 0,
	"auto" => 1,
	"diffseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"bfeatout" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 1,
	"bsequence" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"bfeatout" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"asequence" => "asequence -- any [single sequence] (-asequence)",
	"bsequence" => "bsequence [single sequence] (-bsequence)",
	"required" => "required Section",
	"wordsize" => "Word size (-wordsize)",
	"output" => "output Section",
	"outfile" => "Output report file (-outfile)",
	"afeatout" => "Feature file for output asequence (-afeatout)",
	"bfeatout" => "Feature file for output bsequence (-bfeatout)",
	"columns" => "Output in columns format (-columns)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"bfeatout" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['asequence','bsequence',],
	"required" => ['wordsize',],
	"output" => ['outfile','afeatout','bfeatout','columns',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '10',
	"afeatout" => '',
	"bfeatout" => '',
	"columns" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"asequence" => { "perl" => '1' },
	"bsequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"wordsize" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"afeatout" => { "perl" => '1' },
	"bfeatout" => { "perl" => '1' },
	"columns" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"asequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"bfeatout" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 1,
	"bsequence" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"bfeatout" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"afeatout" => [
		"File for output of first sequence\'s normal tab delimited gff\'s",
	],
	"bfeatout" => [
		"File for output of second sequence\'s normal tab delimited gff\'s",
	],
	"columns" => [
		"The default format for the output report file is to have several lines per difference giving the sequence positions, sequences and features. <BR> If this option is set true then the output report file\'s format is changed to a set of columns and no feature information is given.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/diffseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

