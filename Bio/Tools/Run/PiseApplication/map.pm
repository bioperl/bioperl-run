
=head1 NAME

Bio::Tools::Run::PiseApplication::map

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::map

      Bioperl class for:

	MAP	Multiple Alignment Program

      Parameters:


		map (String)
			

		seq (Sequence)
			Sequences File

		scoring (Paragraph)
			Scoring Parameters

		gap_size (Integer)
			gap size: minimum length of any gap in a short sequence charged with a constant gap penalty (gs)

		mismatch (Integer)
			score of a mismatch (<0)

		gapopen (Integer)
			gap open penalty (>=0)

		gapext (Integer)
			gap extension penalty (>=0)

		matrix (InFile)
			Matrix (Name of a file containing an alternate or user-defined scoring matrix)

=cut

#'
package Bio::Tools::Run::PiseApplication::map;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $map = Bio::Tools::Run::PiseApplication::map->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::map object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $map = $factory->program('map');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::map.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/map.pm

    $self->{COMMAND}   = "map";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MAP";

    $self->{DESCRIPTION}   = "Multiple Alignment Program";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"map",
	"seq",
	"scoring",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"map",
	"seq", 	# Sequences File
	"scoring", 	# Scoring Parameters
	"gap_size", 	# gap size: minimum length of any gap in a short sequence charged with a constant gap penalty (gs)
	"mismatch", 	# score of a mismatch (<0)
	"gapopen", 	# gap open penalty (>=0)
	"gapext", 	# gap extension penalty (>=0)
	"matrix", 	# Matrix (Name of a file containing an alternate or user-defined scoring matrix)

    ];

    $self->{TYPE}  = {
	"map" => 'String',
	"seq" => 'Sequence',
	"scoring" => 'Paragraph',
	"gap_size" => 'Integer',
	"mismatch" => 'Integer',
	"gapopen" => 'Integer',
	"gapext" => 'Integer',
	"matrix" => 'InFile',

    };

    $self->{FORMAT}  = {
	"map" => {
		"seqlab" => 'map',
		"perl" => '"map"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"scoring" => {
	},
	"gap_size" => {
		"perl" => '(defined $value)? " $value" : ""',
	},
	"mismatch" => {
		"perl" => '($value < 0 && ! $matrix)? " $value" : "" ',
	},
	"gapopen" => {
		"perl" => '(defined $value)? " $value" : "" ',
	},
	"gapext" => {
		"perl" => '(defined $value)? " $value" : ""',
	},
	"matrix" => {
		"perl" => ' ($value)? " $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"map" => 0,
	"seq" => 1,
	"gap_size" => 2,
	"mismatch" => 3,
	"gapopen" => 4,
	"gapext" => 5,
	"matrix" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"map",
	"scoring",
	"seq",
	"gap_size",
	"mismatch",
	"matrix",
	"gapopen",
	"gapext",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"map" => 1,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{ISCOMMAND}  = {
	"map" => 1,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{ISMANDATORY}  = {
	"map" => 0,
	"seq" => 1,
	"scoring" => 0,
	"gap_size" => 1,
	"mismatch" => 1,
	"gapopen" => 1,
	"gapext" => 1,
	"matrix" => 0,

    };

    $self->{PROMPT}  = {
	"map" => "",
	"seq" => "Sequences File",
	"scoring" => "Scoring Parameters",
	"gap_size" => "gap size: minimum length of any gap in a short sequence charged with a constant gap penalty (gs)",
	"mismatch" => "score of a mismatch (<0)",
	"gapopen" => "gap open penalty (>=0)",
	"gapext" => "gap extension penalty (>=0)",
	"matrix" => "Matrix (Name of a file containing an alternate or user-defined scoring matrix)",

    };

    $self->{ISSTANDOUT}  = {
	"map" => 0,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{VLIST}  = {

	"scoring" => ['gap_size','mismatch','gapopen','gapext','matrix',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"map" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"scoring" => { "perl" => '1' },
	"gap_size" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"gapopen" => { "perl" => '1' },
	"gapext" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"mismatch" => {
		"perl" => {
			'($value >= 0)' => "enter a negative value",
		},
	},
	"gapopen" => {
		"perl" => {
			'($value < 0)' => "enter a positive a null value",
		},
	},
	"gapext" => {
		"perl" => {
			'($value < 0)' => "enter a positive a null value",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"map" => 0,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{ISSIMPLE}  = {
	"map" => 1,
	"seq" => 1,
	"scoring" => 0,
	"gap_size" => 1,
	"mismatch" => 1,
	"gapopen" => 1,
	"gapext" => 1,
	"matrix" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"scoring" => [
		"In the simplest form, users provide 3 integers: ms, q and r, where ms is the score of a mismatch and the score of an i-symbol indel is -(q + r * i). Each match automatically receives score 10. In addition, an integer gs is provided so that any gap of length > gs in a short sequence is given a penalty of -(q + r * gs), the linear penalty for a gap of length gs. In other words, long gaps in the short sequence are given a constant penalty. This simple scoring scheme may be used for DNA sequences. NOTE: all scores are integers.",
	],
	"gap_size" => [
		"gapsize is provided so that any gap of length > gs in a short sequence is given a penalty of -(q + r * gs), the linear penalty for a gap of length gs. In other words, long gaps in the short sequence are given a constant penalty. ",
	],
	"matrix" => [
		"users can define an alphabet of characters to appear in the sequences and a matrix that gives the substitution score for each pair of symbols in the alphabet. The 127 ASCII characters are eligible. The alphabet and matrix are given in a file, where the first line lists the characters in the alphabet and the lower triangle of the matrix comes next. ",
		"Example:",
		"ARNDC",
		" 13",
		"-15 19",
		"-10 -22 11",
		"-20 -10 -20 18",
		"-10 -20 -10 -20 12",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/map.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

