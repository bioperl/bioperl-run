
=head1 NAME

Bio::Tools::Run::PiseApplication::rnainverse

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnainverse

      Bioperl class for:

	VIENNARNA	RNAinverse - find RNA sequences with given secondary structure (Hofacker)

	References:

		I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188

		A. Walter, D Turner, J Kim, M Lyttle, P Muller, D Mathews, M Zuker Coaxial stacking of helices enhances binding of oligoribonucleotides. PNAS, 91, pp 9218-9222, 1994

		M. Zuker, P. Stiegler (1981) Optimal computer folding of large RNA sequences using thermodynamic and auxiliary information, Nucl Acid Res 9: 133-148

		J.S. McCaskill (1990) The equilibrium partition function and base pair binding probabilities for RNA secondary structures, Biopolymers 29: 11051119 D.H. Turner N. Sugimoto and S.M. Freier (1988) RNA structure prediction, Ann Rev Biophys Biophys Chem 17: 167-192

		D. Adams (1979) The hitchhiker's guide to the galaxy, Pan Books, London


      Parameters:


		rnainverse (String)


		seqstruct (InFile)
			Sequences/Structures File

		control (Paragraph)
			Control options

		folding (Excl)
			Folding method (-F)

		final (Integer)
			Stop search when sequence is found with E(s)-F smaller than this value (-f)

		repeats (Integer)
			Search repeatedly for the same structure (-R)

		alphabet (String)
			Find sequences using only bases from this alphabet (-a)

		others_options (Paragraph)
			Other options

		temperature (Integer)
			Rescale energy parameters to a temperature of temp C. (-T)

		tetraloops (Switch)
			Do not include special stabilizing energies for certain tetraloops (-4)

		dangling (Excl)
			How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)

		noGU (Switch)
			Do not allow GU pairs (-noGU)

		noCloseGU (Switch)
			Do not allow GU pairs at the end of helices (-noCloseGU)

		nsp (String)
			Non standard pairs (comma seperated list) (-nsp)

		parameter (InFile)
			Parameter file (-P)

		energy (Excl)
			Energy parameters for the artificial ABCD... alphabet (-e)

		readseq (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::rnainverse;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnainverse = Bio::Tools::Run::PiseApplication::rnainverse->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnainverse object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $rnainverse = $factory->program('rnainverse');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnainverse.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnainverse.pm

    $self->{COMMAND}   = "rnainverse";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNAinverse - find RNA sequences with given secondary structure";

    $self->{AUTHORS}   = "Hofacker";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-na.html#VIENNARNA";

    $self->{REFERENCE}   = [

         "I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188",

         "A. Walter, D Turner, J Kim, M Lyttle, P Muller, D Mathews, M Zuker Coaxial stacking of helices enhances binding of oligoribonucleotides. PNAS, 91, pp 9218-9222, 1994",

         "M. Zuker, P. Stiegler (1981) Optimal computer folding of large RNA sequences using thermodynamic and auxiliary information, Nucl Acid Res 9: 133-148",

         "J.S. McCaskill (1990) The equilibrium partition function and base pair binding probabilities for RNA secondary structures, Biopolymers 29: 11051119 D.H. Turner N. Sugimoto and S.M. Freier (1988) RNA structure prediction, Ann Rev Biophys Biophys Chem 17: 167-192",

         "D. Adams (1979) The hitchhiker's guide to the galaxy, Pan Books, London",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnainverse",
	"seqstruct",
	"control",
	"others_options",
	"readseq",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnainverse",
	"seqstruct", 	# Sequences/Structures File
	"control", 	# Control options
	"folding", 	# Folding method (-F)
	"final", 	# Stop search when sequence is found with E(s)-F smaller than this value (-f)
	"repeats", 	# Search repeatedly for the same structure (-R)
	"alphabet", 	# Find sequences using only bases from this alphabet (-a)
	"others_options", 	# Other options
	"temperature", 	# Rescale energy parameters to a temperature of temp C. (-T)
	"tetraloops", 	# Do not include special stabilizing energies for certain tetraloops (-4)
	"dangling", 	# How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)
	"noGU", 	# Do not allow GU pairs (-noGU)
	"noCloseGU", 	# Do not allow GU pairs at the end of helices (-noCloseGU)
	"nsp", 	# Non standard pairs (comma seperated list) (-nsp)
	"parameter", 	# Parameter file (-P)
	"energy", 	# Energy parameters for the artificial ABCD... alphabet (-e)
	"readseq",

    ];

    $self->{TYPE}  = {
	"rnainverse" => 'String',
	"seqstruct" => 'InFile',
	"control" => 'Paragraph',
	"folding" => 'Excl',
	"final" => 'Integer',
	"repeats" => 'Integer',
	"alphabet" => 'String',
	"others_options" => 'Paragraph',
	"temperature" => 'Integer',
	"tetraloops" => 'Switch',
	"dangling" => 'Excl',
	"noGU" => 'Switch',
	"noCloseGU" => 'Switch',
	"nsp" => 'String',
	"parameter" => 'InFile',
	"energy" => 'Excl',
	"readseq" => 'String',

    };

    $self->{FORMAT}  = {
	"rnainverse" => {
		"perl" => '"RNAinverse"',
	},
	"seqstruct" => {
		"perl" => '" < $value" ',
	},
	"control" => {
	},
	"folding" => {
		"perl" => '(defined $value && $value ne $vdef)? " -F$value" : ""',
	},
	"final" => {
		"perl" => '(defined $value)? " -f $value" : ""',
	},
	"repeats" => {
		"perl" => '(defined $value)? " -R $value" : ""',
	},
	"alphabet" => {
		"perl" => '($value)? " -a $value" : ""',
	},
	"others_options" => {
	},
	"temperature" => {
		"perl" => '(defined $value && $value ne $vdef)? " -T $value" : ""',
	},
	"tetraloops" => {
		"perl" => '($value)? " -4" : ""',
	},
	"dangling" => {
		"perl" => '($value)? " $value" : ""',
	},
	"noGU" => {
		"perl" => '($value)? " -noGU" : ""',
	},
	"noCloseGU" => {
		"perl" => '($value)? " -noCloseGU" : ""',
	},
	"nsp" => {
		"perl" => '($value)? " -nsp $value" : "" ',
	},
	"parameter" => {
		"perl" => '($value)? " -P $value" : ""',
	},
	"energy" => {
		"perl" => '($value)? " -e $value" : ""',
	},
	"readseq" => {
		"perl" => '"/local/gensoft/lib/ViennaRNA/readseq  -f=19 -a $seq > $seq.tmp && (cp $seq $seq.orig && mv $seq.tmp $seq) ; "',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"rnainverse" => 0,
	"seqstruct" => 1000,
	"control" => 2,
	"folding" => 2,
	"final" => 2,
	"repeats" => 2,
	"alphabet" => 2,
	"others_options" => 2,
	"temperature" => 2,
	"tetraloops" => 2,
	"dangling" => 2,
	"noGU" => 2,
	"noCloseGU" => 2,
	"nsp" => 2,
	"parameter" => 2,
	"energy" => 2,
	"readseq" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readseq",
	"rnainverse",
	"control",
	"folding",
	"final",
	"repeats",
	"alphabet",
	"others_options",
	"temperature",
	"tetraloops",
	"dangling",
	"noGU",
	"noCloseGU",
	"nsp",
	"parameter",
	"energy",
	"seqstruct",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnainverse" => 1,
	"seqstruct" => 0,
	"control" => 0,
	"folding" => 0,
	"final" => 0,
	"repeats" => 0,
	"alphabet" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 1,

    };

    $self->{ISCOMMAND}  = {
	"rnainverse" => 1,
	"seqstruct" => 0,
	"control" => 0,
	"folding" => 0,
	"final" => 0,
	"repeats" => 0,
	"alphabet" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnainverse" => 0,
	"seqstruct" => 1,
	"control" => 0,
	"folding" => 0,
	"final" => 0,
	"repeats" => 0,
	"alphabet" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{PROMPT}  = {
	"rnainverse" => "",
	"seqstruct" => "Sequences/Structures File",
	"control" => "Control options",
	"folding" => "Folding method (-F)",
	"final" => "Stop search when sequence is found with E(s)-F smaller than this value (-f)",
	"repeats" => "Search repeatedly for the same structure (-R)",
	"alphabet" => "Find sequences using only bases from this alphabet (-a)",
	"others_options" => "Other options",
	"temperature" => "Rescale energy parameters to a temperature of temp C. (-T)",
	"tetraloops" => "Do not include special stabilizing energies for certain tetraloops (-4)",
	"dangling" => "How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)",
	"noGU" => "Do not allow GU pairs (-noGU)",
	"noCloseGU" => "Do not allow GU pairs at the end of helices (-noCloseGU)",
	"nsp" => "Non standard pairs (comma seperated list) (-nsp)",
	"parameter" => "Parameter file (-P)",
	"energy" => "Energy parameters for the artificial ABCD... alphabet (-e)",
	"readseq" => "",

    };

    $self->{ISSTANDOUT}  = {
	"rnainverse" => 0,
	"seqstruct" => 0,
	"control" => 0,
	"folding" => 0,
	"final" => 0,
	"repeats" => 0,
	"alphabet" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['folding','final','repeats','alphabet',],
	"folding" => ['m','m: minimum energy','p','p: partition function','mp','mp: both',],
	"others_options" => ['temperature','tetraloops','dangling','noGU','noCloseGU','nsp','parameter','energy',],
	"dangling" => ['','only unpaired bases can participate in at most one dangling end','-d','-d: ignores dangling ends altogether','-d2','-d2: the check is ignored, this is the default for partition function folding.',],
	"energy" => ['1','1: use energy parameters for GC pairs','2','2: use energy parameters for AU pairs',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"rnainverse" => 'rnainverse',
	"folding" => 'm',
	"temperature" => '37',
	"tetraloops" => '0',
	"dangling" => '""',
	"noGU" => '0',
	"noCloseGU" => '0',

    };

    $self->{PRECOND}  = {
	"rnainverse" => { "perl" => '1' },
	"seqstruct" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"folding" => { "perl" => '1' },
	"final" => {
		"perl" => '$folding =~ /p/',
	},
	"repeats" => { "perl" => '1' },
	"alphabet" => { "perl" => '1' },
	"others_options" => { "perl" => '1' },
	"temperature" => { "perl" => '1' },
	"tetraloops" => { "perl" => '1' },
	"dangling" => { "perl" => '1' },
	"noGU" => { "perl" => '1' },
	"noCloseGU" => { "perl" => '1' },
	"nsp" => { "perl" => '1' },
	"parameter" => { "perl" => '1' },
	"energy" => { "perl" => '1' },
	"readseq" => {
		"perl" => 'defined $rnafold || defined $rnasubopt',
	},

    };

    $self->{CTRL}  = {
	"dangling" => {
		"perl" => {
			'(! (defined $rnafold || defined $rnaeval || defined $rnainverse) &&   ($dangling eq "-d2")  && ($dangling = "") && 0)' => "no message",
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
	"rnainverse" => 0,
	"seqstruct" => 0,
	"control" => 0,
	"folding" => 0,
	"final" => 0,
	"repeats" => 0,
	"alphabet" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnainverse" => 0,
	"seqstruct" => 1,
	"control" => 0,
	"folding" => 0,
	"final" => 0,
	"repeats" => 0,
	"alphabet" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"seqstruct" => [
		"Target structures and starting sequences for the search are read alternately from stdin. If a \'0\' is given instead of a starting sequence a random sequence is used.",
	],
	"final" => [
		"In combination with -Fp",
		"F=-kT*ln(Q)",
	],
	"repeats" => [
		"If \'0\' was given instead of a starting sequence, a new random starting sequences is used for each subsequent trial.",
		"If repeats is negative search until -repeats exact solutions are found, no output is done for unsuccessful searches.",
		"The program will not terminate if the target can not be found.",
	],
	"dangling" => [
		"How to treat \'dangling end\' energies for bases adjacent to helices in free ends and multiloops: Normally only unpaired bases can participate in at most one dangling end. With -d2 this check is ignored, this is the default for partition function folding (-p). -d ignores dangling ends altogether. Note that by default pf and mfe folding treat dangling ends differently, use -d2 (or -d) in addition to -p to ensure that both algorithms use the same energy model. The -d2 options is available for RNAfold, RNAeval, and RNAinverse only.",
	],
	"nsp" => [
		"Allow other pairs in addition to the usual AU,GC,and GU pairs. pairs is a comma seperated list of additionally allowed pairs. If a the first character is a \'-\' then AB will imply that AB and BA are allowed pairs. e.g. RNAfold -nsp -GA will allow GA and AG pairs. Nonstandard pairs are given 0 stacking energy.",
	],
	"parameter" => [
		"Read energy parameters from paramfile, instead of using the default parameter set. A sample parameterfile should accompany your distribution. See the RNAlib documentation for details on the file format.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnainverse.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

