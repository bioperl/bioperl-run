
=head1 NAME

Bio::Tools::Run::PiseApplication::prot_nucml

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prot_nucml

      Bioperl class for:

	Molphy	ProtML, NucML phylogeny programs (J. Adachi & M. Hasegawa)

      Parameters:


		prot_nucml (Excl)
			Program

		interleaved (String)
			

		tee (String)
			

		results (OutFile)
			
			pipe: phylip_dist

		outtree (OutFile)
			
			pipe: phylip_tree

		sequences (Sequence)
			Sequences File (protml or nucml)
			pipe: readseq_ok_alig

		model (Paragraph)
			Model (ProtML or NucML)

		modelprot (Excl)
			Model for ProtML

		modeldna (Excl)
			Model for NucML

		n1 (Integer)
			n1 : Alpha/Beta ratio (default:4.0) (option : -t n1)

		n2 (Integer)
			n2 AlphaY/AlphaR ratio (default:1.0) (option : -t n1,n2)

		search (Paragraph)
			Search strategy or Mode (ProtML or NucML)

		mode (Excl)
			Strategy or Mode

		topology (InFile)
			Topology File (if Users Tree mode or Exhaustive search)

		output (Paragraph)
			Output Parameters

		num (Integer)
			Retained top ranking trees (-n)

		verbose (Switch)
			Verbose to stderr (-v)

		info (Switch)
			Output some informations (-i -w)

		others (Paragraph)
			Others Options

		boot (Switch)
			no Bootstrap probabilities (Users trees) (-b)

		minimum_evolution (Switch)
			Minimum evolution (with -e) (-M)

		sequential (Switch)
			Sequential format (-S)

=cut

#'
package Bio::Tools::Run::PiseApplication::prot_nucml;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prot_nucml = Bio::Tools::Run::PiseApplication::prot_nucml->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prot_nucml object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $prot_nucml = $factory->program('prot_nucml');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::prot_nucml.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prot_nucml.pm

    $self->{COMMAND}   = "prot_nucml";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Molphy";

    $self->{DESCRIPTION}   = "ProtML, NucML phylogeny programs";

    $self->{AUTHORS}   = "J. Adachi & M. Hasegawa";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prot_nucml",
	"interleaved",
	"tee",
	"results",
	"outtree",
	"sequences",
	"model",
	"search",
	"output",
	"others",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prot_nucml", 	# Program
	"interleaved",
	"tee",
	"results",
	"outtree",
	"sequences", 	# Sequences File (protml or nucml)
	"model", 	# Model (ProtML or NucML)
	"modelprot", 	# Model for ProtML
	"modeldna", 	# Model for NucML
	"n1", 	# n1 : Alpha/Beta ratio (default:4.0) (option : -t n1)
	"n2", 	# n2 AlphaY/AlphaR ratio (default:1.0) (option : -t n1,n2)
	"search", 	# Search strategy or Mode (ProtML or NucML)
	"mode", 	# Strategy or Mode
	"topology", 	# Topology File (if Users Tree mode or Exhaustive search)
	"output", 	# Output Parameters
	"num", 	# Retained top ranking trees (-n)
	"verbose", 	# Verbose to stderr (-v)
	"info", 	# Output some informations (-i -w)
	"others", 	# Others Options
	"boot", 	# no Bootstrap probabilities (Users trees) (-b)
	"minimum_evolution", 	# Minimum evolution (with -e) (-M)
	"sequential", 	# Sequential format (-S)

    ];

    $self->{TYPE}  = {
	"prot_nucml" => 'Excl',
	"interleaved" => 'String',
	"tee" => 'String',
	"results" => 'OutFile',
	"outtree" => 'OutFile',
	"sequences" => 'Sequence',
	"model" => 'Paragraph',
	"modelprot" => 'Excl',
	"modeldna" => 'Excl',
	"n1" => 'Integer',
	"n2" => 'Integer',
	"search" => 'Paragraph',
	"mode" => 'Excl',
	"topology" => 'InFile',
	"output" => 'Paragraph',
	"num" => 'Integer',
	"verbose" => 'Switch',
	"info" => 'Switch',
	"others" => 'Paragraph',
	"boot" => 'Switch',
	"minimum_evolution" => 'Switch',
	"sequential" => 'Switch',

    };

    $self->{FORMAT}  = {
	"prot_nucml" => {
		"perl" => '"$value"',
	},
	"interleaved" => {
		"perl" => '" -I"',
	},
	"tee" => {
		"perl" => '" | tee molphy.results | sed -n \\"/;/p\\" "',
	},
	"results" => {
	},
	"outtree" => {
		"perl" => '" > outtree"',
	},
	"sequences" => {
		"perl" => '" $value"',
	},
	"model" => {
	},
	"modelprot" => {
		"perl" => '($value ne $vdef)? " $value" : "" ',
	},
	"modeldna" => {
		"perl" => '($value ne $vdef)? " $value" : "" ',
	},
	"n1" => {
		"perl" => '(! defined $n2 && defined $n1)? " -t $n1":""',
	},
	"n2" => {
		"perl" => '(defined $n1 && defined $n2)? " -t $n1,$n2":""',
	},
	"search" => {
	},
	"mode" => {
		"perl" => '" $value"',
	},
	"topology" => {
		"perl" => '($value)? " $value" : "" ',
	},
	"output" => {
	},
	"num" => {
		"perl" => '(defined $value)? " -n $value":""',
	},
	"verbose" => {
		"perl" => '($value)? " -v":""',
	},
	"info" => {
		"perl" => '($value)? " -i -w":""',
	},
	"others" => {
	},
	"boot" => {
		"perl" => '($value)? " -b":""',
	},
	"minimum_evolution" => {
		"perl" => '($value)? " -M":""',
	},
	"sequential" => {
		"perl" => '($value)? " -S":""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequences" => [12],

    };

    $self->{GROUP}  = {
	"prot_nucml" => 0,
	"interleaved" => 1,
	"tee" => 1000,
	"outtree" => 1100,
	"sequences" => 3,
	"modelprot" => 1,
	"modeldna" => 1,
	"n1" => 1,
	"n2" => 1,
	"mode" => 1,
	"topology" => 4,
	"num" => 1,
	"verbose" => 1,
	"info" => 1,
	"boot" => 1,
	"minimum_evolution" => 1,
	"sequential" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"prot_nucml",
	"model",
	"search",
	"results",
	"others",
	"output",
	"interleaved",
	"sequential",
	"modelprot",
	"modeldna",
	"n2",
	"n1",
	"mode",
	"num",
	"verbose",
	"info",
	"boot",
	"minimum_evolution",
	"sequences",
	"topology",
	"tee",
	"outtree",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"prot_nucml" => 0,
	"interleaved" => 1,
	"tee" => 1,
	"results" => 1,
	"outtree" => 1,
	"sequences" => 0,
	"model" => 0,
	"modelprot" => 0,
	"modeldna" => 0,
	"n1" => 0,
	"n2" => 0,
	"search" => 0,
	"mode" => 0,
	"topology" => 0,
	"output" => 0,
	"num" => 0,
	"verbose" => 0,
	"info" => 0,
	"others" => 0,
	"boot" => 0,
	"minimum_evolution" => 0,
	"sequential" => 0,

    };

    $self->{ISCOMMAND}  = {
	"prot_nucml" => 1,
	"interleaved" => 0,
	"tee" => 0,
	"results" => 0,
	"outtree" => 0,
	"sequences" => 0,
	"model" => 0,
	"modelprot" => 0,
	"modeldna" => 0,
	"n1" => 0,
	"n2" => 0,
	"search" => 0,
	"mode" => 0,
	"topology" => 0,
	"output" => 0,
	"num" => 0,
	"verbose" => 0,
	"info" => 0,
	"others" => 0,
	"boot" => 0,
	"minimum_evolution" => 0,
	"sequential" => 0,

    };

    $self->{ISMANDATORY}  = {
	"prot_nucml" => 1,
	"interleaved" => 0,
	"tee" => 0,
	"results" => 0,
	"outtree" => 0,
	"sequences" => 1,
	"model" => 0,
	"modelprot" => 0,
	"modeldna" => 0,
	"n1" => 0,
	"n2" => 0,
	"search" => 0,
	"mode" => 1,
	"topology" => 1,
	"output" => 0,
	"num" => 0,
	"verbose" => 0,
	"info" => 0,
	"others" => 0,
	"boot" => 0,
	"minimum_evolution" => 0,
	"sequential" => 0,

    };

    $self->{PROMPT}  = {
	"prot_nucml" => "Program",
	"interleaved" => "",
	"tee" => "",
	"results" => "",
	"outtree" => "",
	"sequences" => "Sequences File (protml or nucml)",
	"model" => "Model (ProtML or NucML)",
	"modelprot" => "Model for ProtML",
	"modeldna" => "Model for NucML",
	"n1" => "n1 : Alpha/Beta ratio (default:4.0) (option : -t n1)",
	"n2" => "n2 AlphaY/AlphaR ratio (default:1.0) (option : -t n1,n2)",
	"search" => "Search strategy or Mode (ProtML or NucML)",
	"mode" => "Strategy or Mode",
	"topology" => "Topology File (if Users Tree mode or Exhaustive search)",
	"output" => "Output Parameters",
	"num" => "Retained top ranking trees (-n)",
	"verbose" => "Verbose to stderr (-v)",
	"info" => "Output some informations (-i -w)",
	"others" => "Others Options",
	"boot" => "no Bootstrap probabilities (Users trees) (-b)",
	"minimum_evolution" => "Minimum evolution (with -e) (-M)",
	"sequential" => "Sequential format (-S)",

    };

    $self->{ISSTANDOUT}  = {
	"prot_nucml" => 0,
	"interleaved" => 0,
	"tee" => 0,
	"results" => 0,
	"outtree" => 1,
	"sequences" => 0,
	"model" => 0,
	"modelprot" => 0,
	"modeldna" => 0,
	"n1" => 0,
	"n2" => 0,
	"search" => 0,
	"mode" => 0,
	"topology" => 0,
	"output" => 0,
	"num" => 0,
	"verbose" => 0,
	"info" => 0,
	"others" => 0,
	"boot" => 0,
	"minimum_evolution" => 0,
	"sequential" => 0,

    };

    $self->{VLIST}  = {

	"prot_nucml" => ['protml','protml','nucml','nucml',],
	"model" => ['modelprot','modeldna','n1','n2',],
	"modelprot" => ['-j','JTT (Jones, Taylor & Thornton) (-j)','-jf','JTT-F (Jones, Taylor & Thornton) (-jf)','-d','Dayhoff (Dayhoff & al) (-d)','-df','Dayhoff-F (Dayhoff & al) (-df)','-m','mtREV4 (Adachi & Asegawa) (-m)','-mf','mtREV4-F (Adachi & Asegawa) (-mf)','-p','Poisson (-p)','-pf','Proportional (-pf)','-r','users RSF (Relative Substitution Frequencies) (-r)','-rf','users RSF-F (-rf)','-f','with data Frequencies (-f)',],
	"modeldna" => ['-t','Alpha/Beta (Hasegawa, Kishino & Yano) and/or AlphaY/AlphaR (Tamura & Nei) (-t)','-p','Proportional (-p)','-pf','Poisson (-pf)','-r','users RSR-F (Relative Substitution Rate)','-rf','users RSR (-rf)','-f','-f withOUT data Frequencies',],
	"search" => ['mode','topology',],
	"mode" => ['-u','Users trees (need users_trees file) (-u)','-R','local Rearrangement search (-R)','-RX','LBP (local bootstrap probability only) (-RX)','-e','Exhaustive search (with/without constrained_tree file) (-e)','-s','Star decomposition search (may not be the ML tree) (-s)','-q','Quick add OTUs search (may not be the ML tree) (-q)','-D','maximum likelihood Distance matrix (for NJDIST) (-D)',],
	"output" => ['num','verbose','info',],
	"others" => ['boot','minimum_evolution','sequential',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"prot_nucml" => 'nucml',
	"results" => '"molphy.results"',
	"outtree" => '"outtree"',
	"modelprot" => '-j',
	"modeldna" => '-t',
	"n1" => '4.0',
	"n2" => '1.0',
	"mode" => '-q',

    };

    $self->{PRECOND}  = {
	"prot_nucml" => { "perl" => '1' },
	"interleaved" => { "perl" => '1' },
	"tee" => { "perl" => '1' },
	"results" => { "perl" => '1' },
	"outtree" => { "perl" => '1' },
	"sequences" => {
		"perl" => '( $prot_nucml eq "protml" || $prot_nucml eq "nucml" )',
	},
	"model" => {
		"perl" => '( $prot_nucml eq "protml" || $prot_nucml eq "nucml" )',
	},
	"modelprot" => {
		"perl" => '($prot_nucml eq "protml" )',
	},
	"modeldna" => {
		"perl" => '( $prot_nucml eq "nucml" )',
	},
	"n1" => {
		"perl" => '($prot_nucml eq "nucml" && $modeldna =~ /^-t/) ',
	},
	"n2" => {
		"perl" => '($prot_nucml eq "nucml" && $modeldna =~ /^-t/) ',
	},
	"search" => { "perl" => '1' },
	"mode" => { "perl" => '1' },
	"topology" => {
		"perl" => '($mode eq "-u" || $mode eq "-e" )',
	},
	"output" => { "perl" => '1' },
	"num" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"info" => { "perl" => '1' },
	"others" => { "perl" => '1' },
	"boot" => {
		"perl" => '($mode =~ /^-u/ )',
	},
	"minimum_evolution" => {
		"perl" => '($mode =~ /^-e/ )',
	},
	"sequential" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"num" => {
		"perl" => {
			'$value !~ /^\\d*$/' => "You should enter an integer value",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"results" => {
		 '$mode eq "-D"' => "phylip_dist",
	},
	"outtree" => {
		 '! $info' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequences" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"prot_nucml" => 0,
	"interleaved" => 0,
	"tee" => 0,
	"results" => 0,
	"outtree" => 0,
	"sequences" => 0,
	"model" => 0,
	"modelprot" => 0,
	"modeldna" => 0,
	"n1" => 0,
	"n2" => 0,
	"search" => 0,
	"mode" => 0,
	"topology" => 0,
	"output" => 0,
	"num" => 0,
	"verbose" => 0,
	"info" => 0,
	"others" => 0,
	"boot" => 0,
	"minimum_evolution" => 0,
	"sequential" => 0,

    };

    $self->{ISSIMPLE}  = {
	"prot_nucml" => 0,
	"interleaved" => 0,
	"tee" => 0,
	"results" => 0,
	"outtree" => 0,
	"sequences" => 1,
	"model" => 0,
	"modelprot" => 0,
	"modeldna" => 0,
	"n1" => 0,
	"n2" => 0,
	"search" => 0,
	"mode" => 0,
	"topology" => 0,
	"output" => 0,
	"num" => 0,
	"verbose" => 0,
	"info" => 0,
	"others" => 0,
	"boot" => 0,
	"minimum_evolution" => 0,
	"sequential" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"prot_nucml" => [
		"ProtML: Maximum Likelihood Inference of Protein Phylogeny",
		"NucML: Maximum Likelihood Inference of Nucleic Acid Phylogeny",
	],
	"sequences" => [
		"Sequences file default format: interleaved (analog to Phylip format)",
	],
	"topology" => [
		"this file must contain the number of tree(s)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prot_nucml.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

