
=head1 NAME

Bio::Tools::Run::PiseApplication::checktrans

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::checktrans

      Bioperl class for:

	CHECKTRANS	Reports STOP codons and ORF statistics of a protein sequence (EMBOSS)

      Parameters:


		checktrans (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- stopprotein [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		orfml (Integer)
			Minimum ORF Length to report (-orfml)

		output (Paragraph)
			output Section

		report (OutFile)
			report (-report)

		outseq (OutFile)
			Sequence file to hold output ORF sequences (-outseq)
			pipe: seqsfile

		outseq_sformat (Excl)
			Output format for: Sequence file to hold output ORF sequences

		featout (OutFile)
			feature file for output (-featout)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::checktrans;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $checktrans = Bio::Tools::Run::PiseApplication::checktrans->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::checktrans object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $checktrans = $factory->program('checktrans');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::checktrans.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/checktrans.pm

    $self->{COMMAND}   = "checktrans";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CHECKTRANS";

    $self->{DESCRIPTION}   = "Reports STOP codons and ORF statistics of a protein sequence (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/checktrans.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"checktrans",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"checktrans",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- stopprotein [sequences] (-sequence)
	"required", 	# required Section
	"orfml", 	# Minimum ORF Length to report (-orfml)
	"output", 	# output Section
	"report", 	# report (-report)
	"outseq", 	# Sequence file to hold output ORF sequences (-outseq)
	"outseq_sformat", 	# Output format for: Sequence file to hold output ORF sequences
	"featout", 	# feature file for output (-featout)
	"auto",

    ];

    $self->{TYPE}  = {
	"checktrans" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"orfml" => 'Integer',
	"output" => 'Paragraph',
	"report" => 'OutFile',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
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
	"orfml" => {
		"perl" => '" -orfml=$value"',
	},
	"output" => {
	},
	"report" => {
		"perl" => '" -report=$value"',
	},
	"outseq" => {
		"perl" => '($value)? " -outseq=$value" : ""',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"featout" => {
		"perl" => '" -featout=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"checktrans" => {
		"perl" => '"checktrans"',
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
	"orfml" => 2,
	"report" => 3,
	"outseq" => 4,
	"outseq_sformat" => 5,
	"featout" => 6,
	"auto" => 7,
	"checktrans" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"checktrans",
	"sequence",
	"orfml",
	"report",
	"outseq",
	"outseq_sformat",
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
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"auto" => 1,
	"checktrans" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"orfml" => 1,
	"output" => 0,
	"report" => 1,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- stopprotein [sequences] (-sequence)",
	"required" => "required Section",
	"orfml" => "Minimum ORF Length to report (-orfml)",
	"output" => "output Section",
	"report" => "report (-report)",
	"outseq" => "Sequence file to hold output ORF sequences (-outseq)",
	"outseq_sformat" => "Output format for: Sequence file to hold output ORF sequences",
	"featout" => "feature file for output (-featout)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['orfml',],
	"output" => ['report','outseq','outseq_sformat','featout',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"orfml" => '100',
	"report" => 'report.out',
	"outseq_sformat" => 'fasta',
	"featout" => 'featout.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"orfml" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"report" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"featout" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqsfile",
	},

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
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"orfml" => 1,
	"output" => 0,
	"report" => 1,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/checktrans.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

