
=head1 NAME

Bio::Tools::Run::PiseApplication::rnasubopt

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnasubopt

      Bioperl class for:

	VIENNARNA	RNAsubopt - calculate suboptimal secondary structures of RNAs (Wuchty, Hofacker, Fontana)

	References:

		S. Wuchty, W. Fontana, I. L. Hofacker and P. Schuster Complete Suboptimal Folding of RNA and the Stability of Secondary Structures, Biopolymers, 49, 145-165 (1999)


      Parameters:


		rnasubopt (String)


		seq (Sequence)
			RNA Sequences File

		control (Paragraph)
			Control options

		temperature (Integer)
			Rescale energy parameters to a temperature of temp C. (-T)

		tetraloops (Switch)
			Do not include special stabilizing energies for certain tetraloops (-4)

		mfe (Integer)
			Calculate suboptimal structures within this range kcal/mol of the mfe (-e)

		lodos (Switch)
			Calculate the Lower Density of States (-lodos)

		dangling (Excl)
			How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)

		logML (Switch)
			Recalculate energies of structures using a logarithmic energy function for multi-loops (-logML)

		ep (Integer)
			Only print structures with energy within this prange of the mfe (with -logML) (-ep)

		sort (Switch)
			Sort the structures by energy (-sort)

		input (Paragraph)
			Input parameters

		noLP (Switch)
			Avoid lonely pairs (helices of length 1) (-noLP)

		noGU (Switch)
			Do not allow GU pairs (-noGU)

		noCloseGU (Switch)
			Do not allow GU pairs at the end of helices (-noCloseGU)

		nsp (String)
			Non standard pairs (comma seperated list) (-nsp)

		parameter (InFile)
			Parameter file (-P)

		readseq (String)


		psfiles (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::rnasubopt;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnasubopt = Bio::Tools::Run::PiseApplication::rnasubopt->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnasubopt object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $rnasubopt = $factory->program('rnasubopt');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnasubopt.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnasubopt.pm

    $self->{COMMAND}   = "rnasubopt";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNAsubopt - calculate suboptimal secondary structures of RNAs";

    $self->{AUTHORS}   = "Wuchty, Hofacker, Fontana";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-na.html#VIENNARNA";

    $self->{REFERENCE}   = [

         "S. Wuchty, W. Fontana, I. L. Hofacker and P. Schuster Complete Suboptimal Folding of RNA and the Stability of Secondary Structures, Biopolymers, 49, 145-165 (1999)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnasubopt",
	"seq",
	"control",
	"input",
	"readseq",
	"psfiles",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnasubopt",
	"seq", 	# RNA Sequences File
	"control", 	# Control options
	"temperature", 	# Rescale energy parameters to a temperature of temp C. (-T)
	"tetraloops", 	# Do not include special stabilizing energies for certain tetraloops (-4)
	"mfe", 	# Calculate suboptimal structures within this range kcal/mol of the mfe (-e)
	"lodos", 	# Calculate the Lower Density of States (-lodos)
	"dangling", 	# How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)
	"logML", 	# Recalculate energies of structures using a logarithmic energy function for multi-loops (-logML)
	"ep", 	# Only print structures with energy within this prange of the mfe (with -logML) (-ep)
	"sort", 	# Sort the structures by energy (-sort)
	"input", 	# Input parameters
	"noLP", 	# Avoid lonely pairs (helices of length 1) (-noLP)
	"noGU", 	# Do not allow GU pairs (-noGU)
	"noCloseGU", 	# Do not allow GU pairs at the end of helices (-noCloseGU)
	"nsp", 	# Non standard pairs (comma seperated list) (-nsp)
	"parameter", 	# Parameter file (-P)
	"readseq",
	"psfiles",

    ];

    $self->{TYPE}  = {
	"rnasubopt" => 'String',
	"seq" => 'Sequence',
	"control" => 'Paragraph',
	"temperature" => 'Integer',
	"tetraloops" => 'Switch',
	"mfe" => 'Integer',
	"lodos" => 'Switch',
	"dangling" => 'Excl',
	"logML" => 'Switch',
	"ep" => 'Integer',
	"sort" => 'Switch',
	"input" => 'Paragraph',
	"noLP" => 'Switch',
	"noGU" => 'Switch',
	"noCloseGU" => 'Switch',
	"nsp" => 'String',
	"parameter" => 'InFile',
	"readseq" => 'String',
	"psfiles" => 'Results',

    };

    $self->{FORMAT}  = {
	"rnasubopt" => {
		"perl" => '"RNAsubopt"',
	},
	"seq" => {
		"perl" => '" < $value" ',
	},
	"control" => {
	},
	"temperature" => {
		"perl" => '(defined $value && $value ne $vdef)? " -T $value" : ""',
	},
	"tetraloops" => {
		"perl" => '($value)? " -4" : ""',
	},
	"mfe" => {
		"perl" => '(defined $value && $value != $vdef)? " -e $value" : ""',
	},
	"lodos" => {
		"perl" => '($value)? " -lodos" : ""',
	},
	"dangling" => {
		"perl" => '($value)? " $value" : ""',
	},
	"logML" => {
		"perl" => '($value)? " -logML" : ""',
	},
	"ep" => {
		"perl" => '(defined $value)? " -ep $value" : ""',
	},
	"sort" => {
		"perl" => '($value)? " -sort" : ""',
	},
	"input" => {
	},
	"noLP" => {
		"perl" => '($value)? " -noLP" : ""',
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
	"readseq" => {
		"perl" => '"/local/gensoft/lib/ViennaRNA/readseq  -f=19 -a $seq > $seq.tmp && (cp $seq $seq.orig && mv $seq.tmp $seq) ; "',
	},
	"psfiles" => {
	},

    };

    $self->{FILENAMES}  = {
	"psfiles" => '*.ps',

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"rnasubopt" => 0,
	"seq" => 1000,
	"control" => 2,
	"temperature" => 2,
	"tetraloops" => 2,
	"mfe" => 2,
	"lodos" => 2,
	"dangling" => 2,
	"logML" => 2,
	"ep" => 2,
	"sort" => 2,
	"input" => 2,
	"noLP" => 2,
	"noGU" => 2,
	"noCloseGU" => 2,
	"nsp" => 2,
	"parameter" => 2,
	"readseq" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readseq",
	"rnasubopt",
	"psfiles",
	"temperature",
	"tetraloops",
	"mfe",
	"lodos",
	"dangling",
	"logML",
	"ep",
	"sort",
	"input",
	"noLP",
	"noGU",
	"noCloseGU",
	"nsp",
	"parameter",
	"control",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnasubopt" => 1,
	"seq" => 0,
	"control" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"mfe" => 0,
	"lodos" => 0,
	"dangling" => 0,
	"logML" => 0,
	"ep" => 0,
	"sort" => 0,
	"input" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"readseq" => 1,
	"psfiles" => 0,

    };

    $self->{ISCOMMAND}  = {
	"rnasubopt" => 1,
	"seq" => 0,
	"control" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"mfe" => 0,
	"lodos" => 0,
	"dangling" => 0,
	"logML" => 0,
	"ep" => 0,
	"sort" => 0,
	"input" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"readseq" => 0,
	"psfiles" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnasubopt" => 0,
	"seq" => 1,
	"control" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"mfe" => 0,
	"lodos" => 0,
	"dangling" => 0,
	"logML" => 0,
	"ep" => 0,
	"sort" => 0,
	"input" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"readseq" => 0,
	"psfiles" => 0,

    };

    $self->{PROMPT}  = {
	"rnasubopt" => "",
	"seq" => "RNA Sequences File",
	"control" => "Control options",
	"temperature" => "Rescale energy parameters to a temperature of temp C. (-T)",
	"tetraloops" => "Do not include special stabilizing energies for certain tetraloops (-4)",
	"mfe" => "Calculate suboptimal structures within this range kcal/mol of the mfe (-e)",
	"lodos" => "Calculate the Lower Density of States (-lodos)",
	"dangling" => "How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)",
	"logML" => "Recalculate energies of structures using a logarithmic energy function for multi-loops (-logML)",
	"ep" => "Only print structures with energy within this prange of the mfe (with -logML) (-ep)",
	"sort" => "Sort the structures by energy (-sort)",
	"input" => "Input parameters",
	"noLP" => "Avoid lonely pairs (helices of length 1) (-noLP)",
	"noGU" => "Do not allow GU pairs (-noGU)",
	"noCloseGU" => "Do not allow GU pairs at the end of helices (-noCloseGU)",
	"nsp" => "Non standard pairs (comma seperated list) (-nsp)",
	"parameter" => "Parameter file (-P)",
	"readseq" => "",
	"psfiles" => "",

    };

    $self->{ISSTANDOUT}  = {
	"rnasubopt" => 0,
	"seq" => 0,
	"control" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"mfe" => 0,
	"lodos" => 0,
	"dangling" => 0,
	"logML" => 0,
	"ep" => 0,
	"sort" => 0,
	"input" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"readseq" => 0,
	"psfiles" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['temperature','tetraloops','mfe','lodos','dangling','logML','ep','sort',],
	"dangling" => ['','only unpaired bases can participate in at most one dangling end','-d','-d: ignores dangling ends altogether','-d2','-d2: the check is ignored, this is the default for partition function folding.',],
	"input" => ['noLP','noGU','noCloseGU','nsp','parameter',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"rnasubopt" => 'rnasubopt',
	"temperature" => '37',
	"tetraloops" => '0',
	"mfe" => '1',
	"lodos" => '0',
	"dangling" => '""',
	"logML" => '0',
	"sort" => '0',
	"noLP" => '0',
	"noGU" => '0',
	"noCloseGU" => '0',

    };

    $self->{PRECOND}  = {
	"rnasubopt" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"temperature" => { "perl" => '1' },
	"tetraloops" => { "perl" => '1' },
	"mfe" => { "perl" => '1' },
	"lodos" => { "perl" => '1' },
	"dangling" => { "perl" => '1' },
	"logML" => { "perl" => '1' },
	"ep" => {
		"perl" => '$logML',
	},
	"sort" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"noLP" => { "perl" => '1' },
	"noGU" => { "perl" => '1' },
	"noCloseGU" => { "perl" => '1' },
	"nsp" => { "perl" => '1' },
	"parameter" => { "perl" => '1' },
	"readseq" => {
		"perl" => 'defined $rnafold || defined $rnasubopt',
	},
	"psfiles" => { "perl" => '1' },

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
	"rnasubopt" => 0,
	"seq" => 0,
	"control" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"mfe" => 0,
	"lodos" => 0,
	"dangling" => 0,
	"logML" => 0,
	"ep" => 0,
	"sort" => 0,
	"input" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"readseq" => 0,
	"psfiles" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnasubopt" => 0,
	"seq" => 1,
	"control" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"mfe" => 0,
	"lodos" => 0,
	"dangling" => 0,
	"logML" => 0,
	"ep" => 0,
	"sort" => 0,
	"input" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"readseq" => 0,
	"psfiles" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"lodos" => [
		"Output lines consist of an energy followed by the number of structures with that energy, suitable for plotting the density of states. Does not print the structures themseleves.",
	],
	"dangling" => [
		"How to treat \'dangling end\' energies for bases adjacent to helices in free ends and multiloops: Normally only unpaired bases can participate in at most one dangling end. With -d2 this check is ignored, this is the default for partition function folding (-p). -d ignores dangling ends altogether. Note that by default pf and mfe folding treat dangling ends differently, use -d2 (or -d) in addition to -p to ensure that both algorithms use the same energy model. The -d2 options is available for RNAfold, RNAeval, and RNAinverse only.",
	],
	"logML" => [
		"This option does not effect structure generation, only the energies that is printed out. Since logML lowers energies somewhat, some structures may be missing.",
	],
	"noLP" => [
		"This works by disallowing pairs that can only occur isolated. Other pairs may still occasionally occur as helices of length 1.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnasubopt.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

