
=head1 NAME

Bio::Tools::Run::PiseApplication::wordmatch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::wordmatch

      Bioperl class for:

	WORDMATCH	Finds all exact matches of a given size between 2 sequences (EMBOSS)

      Parameters:


		wordmatch (String)


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
			outfile (-outfile)

		afeatout (OutFile)
			feature file for output aseq (-afeatout)

		bfeatout (OutFile)
			feature file for output bseq (-bfeatout)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::wordmatch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $wordmatch = Bio::Tools::Run::PiseApplication::wordmatch->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::wordmatch object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $wordmatch = $factory->program('wordmatch');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::wordmatch.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wordmatch.pm

    $self->{COMMAND}   = "wordmatch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WORDMATCH";

    $self->{DESCRIPTION}   = "Finds all exact matches of a given size between 2 sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:local",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/wordmatch.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"wordmatch",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"wordmatch",
	"init",
	"input", 	# input Section
	"asequence", 	# asequence -- any [single sequence] (-asequence)
	"bsequence", 	# bsequence [single sequence] (-bsequence)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"afeatout", 	# feature file for output aseq (-afeatout)
	"bfeatout", 	# feature file for output bseq (-bfeatout)
	"auto",

    ];

    $self->{TYPE}  = {
	"wordmatch" => 'String',
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
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"asequence" => {
		"perl" => '" -asequence=$value -sformat=fasta"',
	},
	"bsequence" => {
		"perl" => '" -bsequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"afeatout" => {
		"perl" => '" -afeatout=$value"',
	},
	"bfeatout" => {
		"perl" => '" -bfeatout=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"wordmatch" => {
		"perl" => '"wordmatch"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"asequence" => [8],
	"bsequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"asequence" => 1,
	"bsequence" => 2,
	"wordsize" => 3,
	"outfile" => 4,
	"afeatout" => 5,
	"bfeatout" => 6,
	"auto" => 7,
	"wordmatch" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"wordmatch",
	"required",
	"asequence",
	"bsequence",
	"wordsize",
	"outfile",
	"afeatout",
	"bfeatout",
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
	"auto" => 1,
	"wordmatch" => 1

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
	"outfile" => 1,
	"afeatout" => 1,
	"bfeatout" => 1,
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
	"outfile" => "outfile (-outfile)",
	"afeatout" => "feature file for output aseq (-afeatout)",
	"bfeatout" => "feature file for output bseq (-bfeatout)",
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
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['asequence','bsequence',],
	"required" => ['wordsize',],
	"output" => ['outfile','afeatout','bfeatout',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '4',
	"outfile" => 'outfile.out',
	"afeatout" => 'afeatout.out',
	"bfeatout" => 'bfeatout.out',

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
	"outfile" => 1,
	"afeatout" => 1,
	"bfeatout" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"afeatout" => [
		"File for output of normal tab delimted gff\'s",
	],
	"bfeatout" => [
		"File for output of normal tab delimted gff\'s",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wordmatch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

