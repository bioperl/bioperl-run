
=head1 NAME

Bio::Tools::Run::PiseApplication::msbar

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::msbar

      Bioperl class for:

	MSBAR	Mutate sequence beyond all recognition (EMBOSS)

      Parameters:


		msbar (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		count (Integer)
			Number of times to perform the mutation operations (-count)

		point (List)
			Types of point mutations to perform -- Point mutation operations [select  values] (-point)

		block (List)
			Types of block mutations to perform -- Block mutation operations [select  values] (-block)

		advanced (Paragraph)
			advanced Section

		inframe (Switch)
			Do 'codon' and 'block' operations in frame (-inframe)

		codon (List)
			Types of codon mutations to perform -- Codon mutation operations [select  values] (-codon)

		minimum (Integer)
			Minimum size for a block mutation (-minimum)

		maximum (Integer)
			Maximum size for a block mutation (-maximum)

		output (Paragraph)
			output Section

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqsfile

		outseq_sformat (Excl)
			Output format for: outseq

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::msbar;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $msbar = Bio::Tools::Run::PiseApplication::msbar->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::msbar object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $msbar = $factory->program('msbar');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::msbar.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/msbar.pm

    $self->{COMMAND}   = "msbar";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MSBAR";

    $self->{DESCRIPTION}   = "Mutate sequence beyond all recognition (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:mutation",

         "protein:mutation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/msbar.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"msbar",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"msbar",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"required", 	# required Section
	"count", 	# Number of times to perform the mutation operations (-count)
	"point", 	# Types of point mutations to perform -- Point mutation operations [select  values] (-point)
	"block", 	# Types of block mutations to perform -- Block mutation operations [select  values] (-block)
	"advanced", 	# advanced Section
	"inframe", 	# Do 'codon' and 'block' operations in frame (-inframe)
	"codon", 	# Types of codon mutations to perform -- Codon mutation operations [select  values] (-codon)
	"minimum", 	# Minimum size for a block mutation (-minimum)
	"maximum", 	# Maximum size for a block mutation (-maximum)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"msbar" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"count" => 'Integer',
	"point" => 'List',
	"block" => 'List',
	"advanced" => 'Paragraph',
	"inframe" => 'Switch',
	"codon" => 'List',
	"minimum" => 'Integer',
	"maximum" => 'Integer',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
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
	"count" => {
		"perl" => '" -count=$value"',
	},
	"point" => {
		"perl" => '" -point=$value"',
	},
	"block" => {
		"perl" => '" -block=$value"',
	},
	"advanced" => {
	},
	"inframe" => {
		"perl" => '($value)? " -inframe" : ""',
	},
	"codon" => {
		"perl" => '" -codon=$value"',
	},
	"minimum" => {
		"perl" => '(defined $value && $value != $vdef)? " -minimum=$value" : ""',
	},
	"maximum" => {
		"perl" => '(defined $value && $value != $vdef)? " -maximum=$value" : ""',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"msbar" => {
		"perl" => '"msbar"',
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
	"count" => 2,
	"point" => 3,
	"block" => 4,
	"inframe" => 5,
	"codon" => 6,
	"minimum" => 7,
	"maximum" => 8,
	"outseq" => 9,
	"outseq_sformat" => 10,
	"auto" => 11,
	"msbar" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"msbar",
	"sequence",
	"count",
	"point",
	"block",
	"inframe",
	"codon",
	"minimum",
	"maximum",
	"outseq",
	"outseq_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"count" => 0,
	"point" => 0,
	"block" => 0,
	"advanced" => 0,
	"inframe" => 0,
	"codon" => 0,
	"minimum" => 0,
	"maximum" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"msbar" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"count" => 0,
	"point" => 0,
	"block" => 0,
	"advanced" => 0,
	"inframe" => 0,
	"codon" => 0,
	"minimum" => 0,
	"maximum" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"count" => 1,
	"point" => 1,
	"block" => 1,
	"advanced" => 0,
	"inframe" => 0,
	"codon" => 1,
	"minimum" => 0,
	"maximum" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"required" => "required Section",
	"count" => "Number of times to perform the mutation operations (-count)",
	"point" => "Types of point mutations to perform -- Point mutation operations [select  values] (-point)",
	"block" => "Types of block mutations to perform -- Block mutation operations [select  values] (-block)",
	"advanced" => "advanced Section",
	"inframe" => "Do 'codon' and 'block' operations in frame (-inframe)",
	"codon" => "Types of codon mutations to perform -- Codon mutation operations [select  values] (-codon)",
	"minimum" => "Minimum size for a block mutation (-minimum)",
	"maximum" => "Maximum size for a block mutation (-maximum)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"count" => 0,
	"point" => 0,
	"block" => 0,
	"advanced" => 0,
	"inframe" => 0,
	"codon" => 0,
	"minimum" => 0,
	"maximum" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['count','point','block',],
	"point" => ['0','None','1','Any of the following','2','Insertions','3','Deletions','4','Changes','5','Duplications','6','Moves',],
	"block" => ['0','None','1','Any of the following','2','Insertions','3','Deletions','4','Changes','5','Duplications','6','Moves',],
	"advanced" => ['inframe','codon','minimum','maximum',],
	"codon" => ['0','None','1','Any of the following','2','Insertions','3','Deletions','4','Changes','5','Duplications','6','Moves',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"point" => ",",
	"block" => ",",
	"codon" => ",",

    };

    $self->{VDEF}  = {
	"count" => '1',
	"point" => ['0',],
	"block" => ['0',],
	"inframe" => '0',
	"codon" => ['0',],
	"minimum" => '1',
	"maximum" => '10',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"count" => { "perl" => '1' },
	"point" => { "perl" => '1' },
	"block" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"inframe" => { "perl" => '1' },
	"codon" => {
		"acd" => '@($(sequence.protein)?N:Y)',
	},
	"minimum" => { "perl" => '1' },
	"maximum" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
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
	"count" => 0,
	"point" => 0,
	"block" => 0,
	"advanced" => 0,
	"inframe" => 0,
	"codon" => 0,
	"minimum" => 0,
	"maximum" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"count" => 1,
	"point" => 1,
	"block" => 1,
	"advanced" => 0,
	"inframe" => 0,
	"codon" => 1,
	"minimum" => 0,
	"maximum" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"codon" => [
		"Types of codon mutations to perform. These are only done if the sequence is nucleic.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/msbar.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

