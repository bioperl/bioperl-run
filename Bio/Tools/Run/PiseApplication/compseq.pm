
=head1 NAME

Bio::Tools::Run::PiseApplication::compseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::compseq

      Bioperl class for:

	COMPSEQ	Counts the composition of dimer/trimer/etc words in a sequence (EMBOSS)

      Parameters:


		compseq (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		word (Integer)
			Word size to consider (e.g. 2=dimer) (-word)

		advanced (Paragraph)
			advanced Section

		infile (InFile)
			'compseq' file to use for expected word frequencies (-infile)

		frame (Integer)
			Frame of word to look at (0=all frames) (-frame)

		ignorebz (Switch)
			Ignore the amino acids B and Z and just count them as 'Other' (-ignorebz)

		reverse (Switch)
			Count words in the forward and reverse sense (-reverse)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		zerocount (Switch)
			Display the words that have a frequency of zero (-zerocount)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::compseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $compseq = Bio::Tools::Run::PiseApplication::compseq->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::compseq object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $compseq = $factory->program('compseq');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::compseq.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/compseq.pm

    $self->{COMMAND}   = "compseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "COMPSEQ";

    $self->{DESCRIPTION}   = "Counts the composition of dimer/trimer/etc words in a sequence (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:composition",

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/compseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"compseq",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"compseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence [sequences] (-sequence)
	"required", 	# required Section
	"word", 	# Word size to consider (e.g. 2=dimer) (-word)
	"advanced", 	# advanced Section
	"infile", 	# 'compseq' file to use for expected word frequencies (-infile)
	"frame", 	# Frame of word to look at (0=all frames) (-frame)
	"ignorebz", 	# Ignore the amino acids B and Z and just count them as 'Other' (-ignorebz)
	"reverse", 	# Count words in the forward and reverse sense (-reverse)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"zerocount", 	# Display the words that have a frequency of zero (-zerocount)
	"auto",

    ];

    $self->{TYPE}  = {
	"compseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"word" => 'Integer',
	"advanced" => 'Paragraph',
	"infile" => 'InFile',
	"frame" => 'Integer',
	"ignorebz" => 'Switch',
	"reverse" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"zerocount" => 'Switch',
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
	"word" => {
		"perl" => '" -word=$value"',
	},
	"advanced" => {
	},
	"infile" => {
		"perl" => '($value)? " -infile=$value" : ""',
	},
	"frame" => {
		"perl" => '(defined $value && $value != $vdef)? " -frame=$value" : ""',
	},
	"ignorebz" => {
		"perl" => '($value)? "" : " -noignorebz"',
	},
	"reverse" => {
		"perl" => '($value)? " -reverse" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"zerocount" => {
		"perl" => '($value)? "" : " -nozerocount"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"compseq" => {
		"perl" => '"compseq"',
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
	"word" => 2,
	"infile" => 3,
	"frame" => 4,
	"ignorebz" => 5,
	"reverse" => 6,
	"outfile" => 7,
	"zerocount" => 8,
	"auto" => 9,
	"compseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"compseq",
	"sequence",
	"word",
	"infile",
	"frame",
	"ignorebz",
	"reverse",
	"outfile",
	"zerocount",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"word" => 0,
	"advanced" => 0,
	"infile" => 0,
	"frame" => 0,
	"ignorebz" => 0,
	"reverse" => 0,
	"output" => 0,
	"outfile" => 0,
	"zerocount" => 0,
	"auto" => 1,
	"compseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"word" => 0,
	"advanced" => 0,
	"infile" => 0,
	"frame" => 0,
	"ignorebz" => 0,
	"reverse" => 0,
	"output" => 0,
	"outfile" => 0,
	"zerocount" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"word" => 1,
	"advanced" => 0,
	"infile" => 0,
	"frame" => 0,
	"ignorebz" => 0,
	"reverse" => 0,
	"output" => 0,
	"outfile" => 1,
	"zerocount" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence [sequences] (-sequence)",
	"required" => "required Section",
	"word" => "Word size to consider (e.g. 2=dimer) (-word)",
	"advanced" => "advanced Section",
	"infile" => "'compseq' file to use for expected word frequencies (-infile)",
	"frame" => "Frame of word to look at (0=all frames) (-frame)",
	"ignorebz" => "Ignore the amino acids B and Z and just count them as 'Other' (-ignorebz)",
	"reverse" => "Count words in the forward and reverse sense (-reverse)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"zerocount" => "Display the words that have a frequency of zero (-zerocount)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"word" => 0,
	"advanced" => 0,
	"infile" => 0,
	"frame" => 0,
	"ignorebz" => 0,
	"reverse" => 0,
	"output" => 0,
	"outfile" => 0,
	"zerocount" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['word',],
	"advanced" => ['infile','frame','ignorebz','reverse',],
	"output" => ['outfile','zerocount',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"word" => '2',
	"frame" => '0',
	"ignorebz" => '1',
	"reverse" => '0',
	"outfile" => 'outfile.out',
	"zerocount" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"word" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"frame" => { "perl" => '1' },
	"ignorebz" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"zerocount" => { "perl" => '1' },
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
	"word" => 0,
	"advanced" => 0,
	"infile" => 0,
	"frame" => 0,
	"ignorebz" => 0,
	"reverse" => 0,
	"output" => 0,
	"outfile" => 0,
	"zerocount" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"word" => 1,
	"advanced" => 0,
	"infile" => 0,
	"frame" => 0,
	"ignorebz" => 0,
	"reverse" => 0,
	"output" => 0,
	"outfile" => 1,
	"zerocount" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"word" => [
		"This is the size of word (n-mer) to count. <BR> Thus if you want to count codon frequencies, you should enter 3 here.",
	],
	"infile" => [
		"This is a file previously produced by \'compseq\' that can be used to set the expected frequencies of words in this analysis. <BR> The word size in the current run must be the same as the one in this results file. Obviously, you should use a file produced from protein sequences if you are counting protein sequence word frequencies, and you must use one made from nucleotide frequencies if you and analysing a nucleotide sequence.",
	],
	"frame" => [
		"The normal behaviour of \'compseq\' is to count the frequencies of all words that occur by moving a window of length \'word\' up by one each time. <BR> This option allows you to move the window up by the length of the word each time, skipping over the intervening words. <BR> You can count only those words that occur in a single frame of the word by setting this value to a number other than zero. <BR> If you set it to 1 it will only count the words in frame 1, 2 will only count the words in frame 2 and so on.",
	],
	"ignorebz" => [
		"The amino acid code B represents Asparagine or Aspartic acid and the code Z represents Glutamine or Glutamic acid. <BR> These are not commonly used codes and you may wish not to count words containing them, just noting them in the count of \'Other\' words.",
	],
	"reverse" => [
		"Set this to be true if you also wish to also count words in the reverse complement of a nucleic sequence.",
	],
	"outfile" => [
		"This is the results file.",
	],
	"zerocount" => [
		"You can make the output results file much smaller if you do not display the words with a zero count.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/compseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

