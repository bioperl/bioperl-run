
=head1 NAME

Bio::Tools::Run::PiseApplication::satellites

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::satellites

      Bioperl class for:

	satellites	identifying satellites and periodic repetitions in biological sequence s (constrained version) (MF. Sagot, G. Myers, E. Poiret)

      Parameters:


		satellites (String)
			

		param (Results)
			

		seq (Sequence)
			Sequence File

		alphabet (Excl)
			Alphabets and score system (-a)

		outputbase (String)
			

		scoreN (String)
			

		maxsym (String)
			

		resultsfiles (Results)
			

		range (String)
			

		gap (Integer)
			

		minlen (Integer)
			Minimum length of repeats (minlen)

		maxlen (Integer)
			Maximum length of repeats (maxlen)

		maxerr (Integer)
			Maximum number of errors allowed between each repeat and the model for a satellite (not more than 10% of the model length) (maxerr)

		indel (Switch)
			Insertions and deletions allowed (indel)

		maxjump (Integer)
			Maximum number of 'bad' repeats between 2 'good' ones (not more than 5) (maxjump)

		quorum (Integer)
			Minimum number of repeats a satellite must have (quorum)

		usematrix (Switch)
			Use scores instead of matrix (usematrix)

		scorematch (Integer)
			Score attributed to a match for the final scoring of a model (scorematch)

		scoresub (Integer)
			Score attributed to a substitution for the final scoring of a model (scoresub)

		scoregap (Integer)
			Score attributed to an indel for the final scoring of a model (scoregap)

		threshold (Integer)
			Filter threshold (threshold)

		threscore (Integer)
			Print threshold (i.e minimum score for printing a model) (threscore)

		inverted (Switch)
			Inverted occurences allowed (inverted)

		ngroup (String)
			

		xml (Switch)
			XML output (xml)

		xmldtdcopy (String)
			

		dtdfile (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::satellites;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $satellites = Bio::Tools::Run::PiseApplication::satellites->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::satellites object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $satellites = $factory->program('satellites');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::satellites.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/satellites.pm

    $self->{COMMAND}   = "satellites";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "satellites";

    $self->{DESCRIPTION}   = "identifying satellites and periodic repetitions in biological sequence s (constrained version)";

    $self->{AUTHORS}   = "MF. Sagot, G. Myers, E. Poiret";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"satellites",
	"param",
	"seq",
	"alphabet",
	"outputbase",
	"scoreN",
	"maxsym",
	"resultsfiles",
	"range",
	"gap",
	"minlen",
	"maxlen",
	"maxerr",
	"indel",
	"maxjump",
	"quorum",
	"usematrix",
	"scorematch",
	"scoresub",
	"scoregap",
	"threshold",
	"threscore",
	"inverted",
	"ngroup",
	"xml",
	"xmldtdcopy",
	"dtdfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"satellites",
	"param",
	"seq", 	# Sequence File
	"alphabet", 	# Alphabets and score system (-a)
	"outputbase",
	"scoreN",
	"maxsym",
	"resultsfiles",
	"range",
	"gap",
	"minlen", 	# Minimum length of repeats (minlen)
	"maxlen", 	# Maximum length of repeats (maxlen)
	"maxerr", 	# Maximum number of errors allowed between each repeat and the model for a satellite (not more than 10% of the model length) (maxerr)
	"indel", 	# Insertions and deletions allowed (indel)
	"maxjump", 	# Maximum number of 'bad' repeats between 2 'good' ones (not more than 5) (maxjump)
	"quorum", 	# Minimum number of repeats a satellite must have (quorum)
	"usematrix", 	# Use scores instead of matrix (usematrix)
	"scorematch", 	# Score attributed to a match for the final scoring of a model (scorematch)
	"scoresub", 	# Score attributed to a substitution for the final scoring of a model (scoresub)
	"scoregap", 	# Score attributed to an indel for the final scoring of a model (scoregap)
	"threshold", 	# Filter threshold (threshold)
	"threscore", 	# Print threshold (i.e minimum score for printing a model) (threscore)
	"inverted", 	# Inverted occurences allowed (inverted)
	"ngroup",
	"xml", 	# XML output (xml)
	"xmldtdcopy",
	"dtdfile",

    ];

    $self->{TYPE}  = {
	"satellites" => 'String',
	"param" => 'Results',
	"seq" => 'Sequence',
	"alphabet" => 'Excl',
	"outputbase" => 'String',
	"scoreN" => 'String',
	"maxsym" => 'String',
	"resultsfiles" => 'Results',
	"range" => 'String',
	"gap" => 'Integer',
	"minlen" => 'Integer',
	"maxlen" => 'Integer',
	"maxerr" => 'Integer',
	"indel" => 'Switch',
	"maxjump" => 'Integer',
	"quorum" => 'Integer',
	"usematrix" => 'Switch',
	"scorematch" => 'Integer',
	"scoresub" => 'Integer',
	"scoregap" => 'Integer',
	"threshold" => 'Integer',
	"threscore" => 'Integer',
	"inverted" => 'Switch',
	"ngroup" => 'String',
	"xml" => 'Switch',
	"xmldtdcopy" => 'String',
	"dtdfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"satellites" => {
		"perl" => ' "sat -p params" ',
	},
	"param" => {
	},
	"seq" => {
		"perl" => '" -f $value"',
	},
	"alphabet" => {
		"perl" => '" -a /local/gensoft/lib/satellites/alphabets/$value"',
	},
	"outputbase" => {
		"perl" => ' "outputbase: results\\n" ',
	},
	"scoreN" => {
		"perl" => ' "scoreN: 0\\n" ',
	},
	"maxsym" => {
		"perl" => ' "maxsym: 0\\n" ',
	},
	"resultsfiles" => {
	},
	"range" => {
		"perl" => ' "minrange: $minlen\\nmaxrange: $maxlen\\n" ',
	},
	"gap" => {
		"perl" => '"gap: $maxerr\\n"',
	},
	"minlen" => {
		"perl" => '"minlen: $value\\n"',
	},
	"maxlen" => {
		"perl" => '"maxlen: $value\\n"',
	},
	"maxerr" => {
		"perl" => '"maxerr: $value\\n"',
	},
	"indel" => {
		"perl" => '($value)? "indel: 1\\n" : "indel: 0\\n" ',
	},
	"maxjump" => {
		"perl" => '"maxjump: $value\\n"',
	},
	"quorum" => {
		"perl" => '"quorum: $value\\n"',
	},
	"usematrix" => {
		"perl" => '($value)? "usematrix: 0\\n" : "usematrix: 1\\n"',
	},
	"scorematch" => {
		"perl" => '"scorematch: $value\\n"',
	},
	"scoresub" => {
		"perl" => '"scoresub: $value\\n"',
	},
	"scoregap" => {
		"perl" => '"scoregap: $value\\n"',
	},
	"threshold" => {
		"perl" => '"threshold: $value\\n"',
	},
	"threscore" => {
		"perl" => '"threscore: $value\\n"',
	},
	"inverted" => {
		"perl" => '($value)? "inverted: 1\\n" : "inverted: 0\\n" ',
	},
	"ngroup" => {
		"perl" => ' "ngroup: 27\\n1 A\\n2 B\\n3 C\\n4 D\\n5 E\\n6 F\\n7 G\\n8 H\\n9 I\\n10 J\\n11 K\\n12 L\\n13 M\\n14 N\\n15 O\\n16 P\\n17 Q\\n18 R\\n19 S\\n20 T\\n21 U\\n22 V\\n23 W\\n24 X\\n25 Y\\n26 Z\\n27 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z\\n" ',
	},
	"xml" => {
		"perl" => '($value)? "xml: 1\\n" : "" ',
	},
	"xmldtdcopy" => {
		"perl" => '"; cp /local/gensoft/lib/satellites/satellites.dtd ."',
	},
	"dtdfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"param" => 'params',
	"resultsfiles" => 'results*',
	"dtdfile" => 'satellites.dtd',

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"satellites" => 0,
	"seq" => 1,
	"alphabet" => 1,
	"outputbase" => 1,
	"ngroup" => 100,
	"xmldtdcopy" => 100,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"satellites",
	"param",
	"inverted",
	"xml",
	"dtdfile",
	"scoreN",
	"maxsym",
	"resultsfiles",
	"range",
	"gap",
	"minlen",
	"maxlen",
	"maxerr",
	"indel",
	"maxjump",
	"quorum",
	"usematrix",
	"scorematch",
	"scoresub",
	"scoregap",
	"threshold",
	"threscore",
	"seq",
	"alphabet",
	"outputbase",
	"xmldtdcopy",
	"ngroup",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"satellites" => 1,
	"param" => 0,
	"seq" => 0,
	"alphabet" => 0,
	"outputbase" => 1,
	"scoreN" => 1,
	"maxsym" => 1,
	"resultsfiles" => 0,
	"range" => 1,
	"gap" => 1,
	"minlen" => 0,
	"maxlen" => 0,
	"maxerr" => 0,
	"indel" => 0,
	"maxjump" => 0,
	"quorum" => 0,
	"usematrix" => 0,
	"scorematch" => 0,
	"scoresub" => 0,
	"scoregap" => 0,
	"threshold" => 0,
	"threscore" => 0,
	"inverted" => 0,
	"ngroup" => 1,
	"xml" => 0,
	"xmldtdcopy" => 1,
	"dtdfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"satellites" => 1,
	"param" => 0,
	"seq" => 0,
	"alphabet" => 0,
	"outputbase" => 0,
	"scoreN" => 0,
	"maxsym" => 0,
	"resultsfiles" => 0,
	"range" => 0,
	"gap" => 0,
	"minlen" => 0,
	"maxlen" => 0,
	"maxerr" => 0,
	"indel" => 0,
	"maxjump" => 0,
	"quorum" => 0,
	"usematrix" => 0,
	"scorematch" => 0,
	"scoresub" => 0,
	"scoregap" => 0,
	"threshold" => 0,
	"threscore" => 0,
	"inverted" => 0,
	"ngroup" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"satellites" => 0,
	"param" => 0,
	"seq" => 1,
	"alphabet" => 1,
	"outputbase" => 0,
	"scoreN" => 0,
	"maxsym" => 0,
	"resultsfiles" => 0,
	"range" => 0,
	"gap" => 0,
	"minlen" => 1,
	"maxlen" => 1,
	"maxerr" => 1,
	"indel" => 0,
	"maxjump" => 1,
	"quorum" => 1,
	"usematrix" => 0,
	"scorematch" => 1,
	"scoresub" => 1,
	"scoregap" => 1,
	"threshold" => 1,
	"threscore" => 1,
	"inverted" => 0,
	"ngroup" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{PROMPT}  = {
	"satellites" => "",
	"param" => "",
	"seq" => "Sequence File",
	"alphabet" => "Alphabets and score system (-a)",
	"outputbase" => "",
	"scoreN" => "",
	"maxsym" => "",
	"resultsfiles" => "",
	"range" => "",
	"gap" => "",
	"minlen" => "Minimum length of repeats (minlen)",
	"maxlen" => "Maximum length of repeats (maxlen)",
	"maxerr" => "Maximum number of errors allowed between each repeat and the model for a satellite (not more than 10% of the model length) (maxerr)",
	"indel" => "Insertions and deletions allowed (indel)",
	"maxjump" => "Maximum number of 'bad' repeats between 2 'good' ones (not more than 5) (maxjump)",
	"quorum" => "Minimum number of repeats a satellite must have (quorum)",
	"usematrix" => "Use scores instead of matrix (usematrix)",
	"scorematch" => "Score attributed to a match for the final scoring of a model (scorematch)",
	"scoresub" => "Score attributed to a substitution for the final scoring of a model (scoresub)",
	"scoregap" => "Score attributed to an indel for the final scoring of a model (scoregap)",
	"threshold" => "Filter threshold (threshold)",
	"threscore" => "Print threshold (i.e minimum score for printing a model) (threscore)",
	"inverted" => "Inverted occurences allowed (inverted)",
	"ngroup" => "",
	"xml" => "XML output (xml)",
	"xmldtdcopy" => "",
	"dtdfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"satellites" => 0,
	"param" => 0,
	"seq" => 0,
	"alphabet" => 0,
	"outputbase" => 0,
	"scoreN" => 0,
	"maxsym" => 0,
	"resultsfiles" => 0,
	"range" => 0,
	"gap" => 0,
	"minlen" => 0,
	"maxlen" => 0,
	"maxerr" => 0,
	"indel" => 0,
	"maxjump" => 0,
	"quorum" => 0,
	"usematrix" => 0,
	"scorematch" => 0,
	"scoresub" => 0,
	"scoregap" => 0,
	"threshold" => 0,
	"threscore" => 0,
	"inverted" => 0,
	"ngroup" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{VLIST}  = {

	"alphabet" => ['dna.alphab','DNA','prot.alphab','protein identity','blosum62.alphab','blosum62','pam250.alphab','pam250',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"alphabet" => 'dna.alphab',
	"minlen" => '3',
	"maxlen" => '10',
	"maxerr" => '1',
	"indel" => '1',
	"maxjump" => '1',
	"quorum" => '20',
	"usematrix" => '1',
	"scorematch" => '1',
	"scoresub" => '-1',
	"scoregap" => '-2',
	"threshold" => '800',
	"threscore" => '50',
	"inverted" => '0',
	"xml" => '0',

    };

    $self->{PRECOND}  = {
	"satellites" => { "perl" => '1' },
	"param" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"alphabet" => { "perl" => '1' },
	"outputbase" => { "perl" => '1' },
	"scoreN" => { "perl" => '1' },
	"maxsym" => { "perl" => '1' },
	"resultsfiles" => { "perl" => '1' },
	"range" => { "perl" => '1' },
	"gap" => { "perl" => '1' },
	"minlen" => { "perl" => '1' },
	"maxlen" => { "perl" => '1' },
	"maxerr" => { "perl" => '1' },
	"indel" => { "perl" => '1' },
	"maxjump" => { "perl" => '1' },
	"quorum" => { "perl" => '1' },
	"usematrix" => { "perl" => '1' },
	"scorematch" => { "perl" => '1' },
	"scoresub" => { "perl" => '1' },
	"scoregap" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"threscore" => { "perl" => '1' },
	"inverted" => { "perl" => '1' },
	"ngroup" => { "perl" => '1' },
	"xml" => { "perl" => '1' },
	"xmldtdcopy" => {
		"perl" => '$xml',
	},
	"dtdfile" => {
		"perl" => '$xml',
	},

    };

    $self->{CTRL}  = {
	"maxlen" => {
		"perl" => {
			'$maxlen > 50' => "Maximum value : 50",
		},
	},
	"maxerr" => {
		"perl" => {
			'($maxlen > 10 && $maxerr > (($maxlen / 100) * 10)) || ($maxlen <= 10 && $maxerr > 1)' => "The number of errors may not be more than 10% of the model length",
		},
	},
	"maxjump" => {
		"perl" => {
			'$maxjump > 5' => "The number of 'bad' repeats may not be more than 5",
		},
	},
	"threshold" => {
		"perl" => {
			'$value < 0' => "please enter a non-negative integer value",
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
	"satellites" => 0,
	"param" => 0,
	"seq" => 0,
	"alphabet" => 0,
	"outputbase" => 0,
	"scoreN" => 0,
	"maxsym" => 0,
	"resultsfiles" => 0,
	"range" => 0,
	"gap" => 0,
	"minlen" => 0,
	"maxlen" => 0,
	"maxerr" => 0,
	"indel" => 0,
	"maxjump" => 0,
	"quorum" => 0,
	"usematrix" => 0,
	"scorematch" => 0,
	"scoresub" => 0,
	"scoregap" => 0,
	"threshold" => 0,
	"threscore" => 0,
	"inverted" => 0,
	"ngroup" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"satellites" => 0,
	"param" => 0,
	"seq" => 1,
	"alphabet" => 1,
	"outputbase" => 0,
	"scoreN" => 0,
	"maxsym" => 0,
	"resultsfiles" => 0,
	"range" => 0,
	"gap" => 0,
	"minlen" => 1,
	"maxlen" => 0,
	"maxerr" => 0,
	"indel" => 0,
	"maxjump" => 0,
	"quorum" => 0,
	"usematrix" => 0,
	"scorematch" => 0,
	"scoresub" => 0,
	"scoregap" => 0,
	"threshold" => 0,
	"threscore" => 0,
	"inverted" => 0,
	"ngroup" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{PARAMFILE}  = {
	"outputbase" => "params",
	"scoreN" => "params",
	"maxsym" => "params",
	"range" => "params",
	"gap" => "params",
	"minlen" => "params",
	"maxlen" => "params",
	"maxerr" => "params",
	"indel" => "params",
	"maxjump" => "params",
	"quorum" => "params",
	"usematrix" => "params",
	"scorematch" => "params",
	"scoresub" => "params",
	"scoregap" => "params",
	"threshold" => "params",
	"threscore" => "params",
	"inverted" => "params",
	"ngroup" => "params",
	"xml" => "params",

    };

    $self->{COMMENT}  = {
	"maxjump" => [
		"i.e having more than the maximum number of errors allowed",
	],
	"quorum" => [
		"Corresponds to min_repeat in the paper",
	],
	"usematrix" => [
		"If unset, will use the score matrix, otherwise will use scorematch and scoresub.",
	],
	"scorematch" => [
		"Suggestion: 1",
	],
	"scoresub" => [
		"Suggestion: -1",
	],
	"scoregap" => [
		"Suggestion: -2",
	],
	"threshold" => [
		"Set it to 0 for guaranteed exhaustive search.",
		"Suggestion: set it to 800 for 10%-15% error rate.",
	],
	"threscore" => [
		"Suggestion: for a flexible search, if the scoring values are the ones suggested, set it to 50.",
		"For a more pertinent search, set it to 100.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/satellites.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

