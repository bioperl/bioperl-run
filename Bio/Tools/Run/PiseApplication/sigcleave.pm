
=head1 NAME

Bio::Tools::Run::PiseApplication::sigcleave

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::sigcleave

      Bioperl class for:

	SIGCLEAVE	Reports protein signal cleavage sites (EMBOSS)

      Parameters:


		sigcleave (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- PureProtein [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		minweight (Float)
			Minimum weight (-minweight)

		advanced (Paragraph)
			advanced Section

		prokaryote (Switch)
			Use prokaryotic cleavage data (-prokaryote)

		pval (Integer)
			Pval (-pval)

		nval (Integer)
			Nval (-nval)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::sigcleave;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $sigcleave = Bio::Tools::Run::PiseApplication::sigcleave->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::sigcleave object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $sigcleave = $factory->program('sigcleave');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::sigcleave.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sigcleave.pm

    $self->{COMMAND}   = "sigcleave";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SIGCLEAVE";

    $self->{DESCRIPTION}   = "Reports protein signal cleavage sites (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/sigcleave.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"sigcleave",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"sigcleave",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- PureProtein [sequences] (-sequence)
	"required", 	# required Section
	"minweight", 	# Minimum weight (-minweight)
	"advanced", 	# advanced Section
	"prokaryote", 	# Use prokaryotic cleavage data (-prokaryote)
	"pval", 	# Pval (-pval)
	"nval", 	# Nval (-nval)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"sigcleave" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"minweight" => 'Float',
	"advanced" => 'Paragraph',
	"prokaryote" => 'Switch',
	"pval" => 'Integer',
	"nval" => 'Integer',
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
	"minweight" => {
		"perl" => '" -minweight=$value"',
	},
	"advanced" => {
	},
	"prokaryote" => {
		"perl" => '($value)? " -prokaryote" : ""',
	},
	"pval" => {
		"perl" => '(defined $value && $value != $vdef)? " -pval=$value" : ""',
	},
	"nval" => {
		"perl" => '(defined $value && $value != $vdef)? " -nval=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"sigcleave" => {
		"perl" => '"sigcleave"',
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
	"minweight" => 2,
	"prokaryote" => 3,
	"pval" => 4,
	"nval" => 5,
	"outfile" => 6,
	"auto" => 7,
	"sigcleave" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"sigcleave",
	"sequence",
	"minweight",
	"prokaryote",
	"pval",
	"nval",
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
	"minweight" => 0,
	"advanced" => 0,
	"prokaryote" => 0,
	"pval" => 0,
	"nval" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"sigcleave" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"minweight" => 0,
	"advanced" => 0,
	"prokaryote" => 0,
	"pval" => 0,
	"nval" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"minweight" => 1,
	"advanced" => 0,
	"prokaryote" => 0,
	"pval" => 0,
	"nval" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- PureProtein [sequences] (-sequence)",
	"required" => "required Section",
	"minweight" => "Minimum weight (-minweight)",
	"advanced" => "advanced Section",
	"prokaryote" => "Use prokaryotic cleavage data (-prokaryote)",
	"pval" => "Pval (-pval)",
	"nval" => "Nval (-nval)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"minweight" => 0,
	"advanced" => 0,
	"prokaryote" => 0,
	"pval" => 0,
	"nval" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['minweight',],
	"advanced" => ['prokaryote','pval','nval',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"minweight" => '3.5',
	"pval" => '-13',
	"nval" => '',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"minweight" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"prokaryote" => { "perl" => '1' },
	"pval" => { "perl" => '1' },
	"nval" => { "perl" => '1' },
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
	"minweight" => 0,
	"advanced" => 0,
	"prokaryote" => 0,
	"pval" => 0,
	"nval" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"minweight" => 1,
	"advanced" => 0,
	"prokaryote" => 0,
	"pval" => 0,
	"nval" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"minweight" => [
		"Minimum scoring weight value for the predicted cleavage site",
	],
	"prokaryote" => [
		"Specifies the sequence is prokaryotic and changes the default scoring data file name",
	],
	"pval" => [
		"Specifies the number of columns before the residue at the cleavage site in the weight matrix table",
	],
	"nval" => [
		"specifies the number of columns after the residue at the cleavage site in the weight matrix table",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sigcleave.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

