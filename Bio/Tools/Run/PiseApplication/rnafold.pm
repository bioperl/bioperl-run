# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::rnafold
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::rnafold

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnafold

      Bioperl class for:

	VIENNARNA	RNAfold - calculate secondary structures of RNAs (Hofacker, Fontana, Bonhoeffer, Stadler)

	References:

		I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188

		A. Walter, D Turner, J Kim, M Lyttle, P Muller, D Mathews, M Zuker Coaxial stacking of helices enhances binding of oligoribonucleotides. PNAS, 91, pp 9218-9222, 1994

		M. Zuker, P. Stiegler (1981) Optimal computer folding of large RNA sequences using thermodynamic and auxiliary information, Nucl Acid Res 9: 133-148

		J.S. McCaskill (1990) The equilibrium partition function and base pair binding probabilities for RNA secondary structures, Biopolymers 29: 11051119 D.H. Turner N. Sugimoto and S.M. Freier (1988) RNA structure prediction, Ann Rev Biophys Biophys Chem 17: 167-192

		D. Adams (1979) The hitchhiker's guide to the galaxy, Pan Books, London



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/rnafold.html 
         for available values):


		rnafold (String)

		seq (Sequence)
			RNA Sequences File

		partition (Switch)
			Calculate the partition function and base pairing probability matrix (-p)

		pf (Switch)
			Calculate the pf without pairing matrix (-p0)

		temperature (Integer)
			Rescale energy parameters to a temperature of temp C. (-T)

		tetraloops (Switch)
			Do not include special stabilizing energies for certain tetraloops (-4)

		dangling (Excl)
			How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)

		scale (Integer)
			Use scale*mfe as an estimate for the free energy (-S)

		constraints (Switch)
			Calculate structures subject to constraints (-C)

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

		energy (Excl)
			Energy parameters for the artificial ABCD... alphabet (-e)

		outfile (OutFile)
			Result file
			pipe: rnafold_struct

		b2ct (Switch)
			converts the bracket notation produced by RNAfold into an .ct file, as produced by Zukers mfold

		readseq (String)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://bioweb.pasteur.fr/seqanal/interfaces/rnafold.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::rnafold;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnafold = Bio::Tools::Run::PiseApplication::rnafold->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnafold object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $rnafold = $factory->program('rnafold');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnafold.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnafold.pm

    $self->{COMMAND}   = "rnafold";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNAfold - calculate secondary structures of RNAs";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Hofacker, Fontana, Bonhoeffer, Stadler";

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
	"rnafold",
	"seq",
	"control",
	"input",
	"output_options",
	"readseq",
	"ctfiles",
	"psfiles",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnafold",
	"seq", 	# RNA Sequences File
	"control", 	# Control options
	"partition", 	# Calculate the partition function and base pairing probability matrix (-p)
	"pf", 	# Calculate the pf without pairing matrix (-p0)
	"temperature", 	# Rescale energy parameters to a temperature of temp C. (-T)
	"tetraloops", 	# Do not include special stabilizing energies for certain tetraloops (-4)
	"dangling", 	# How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)
	"scale", 	# Use scale*mfe as an estimate for the free energy (-S)
	"input", 	# Input parameters
	"constraints", 	# Calculate structures subject to constraints (-C)
	"noLP", 	# Avoid lonely pairs (helices of length 1) (-noLP)
	"noGU", 	# Do not allow GU pairs (-noGU)
	"noCloseGU", 	# Do not allow GU pairs at the end of helices (-noCloseGU)
	"nsp", 	# Non standard pairs (comma seperated list) (-nsp)
	"parameter", 	# Parameter file (-P)
	"energy", 	# Energy parameters for the artificial ABCD... alphabet (-e)
	"output_options", 	# Output options
	"outfile", 	# Result file
	"b2ct", 	# converts the bracket notation produced by RNAfold into an .ct file, as produced by Zukers mfold
	"readseq",
	"ctfiles",
	"psfiles",

    ];

    $self->{TYPE}  = {
	"rnafold" => 'String',
	"seq" => 'Sequence',
	"control" => 'Paragraph',
	"partition" => 'Switch',
	"pf" => 'Switch',
	"temperature" => 'Integer',
	"tetraloops" => 'Switch',
	"dangling" => 'Excl',
	"scale" => 'Integer',
	"input" => 'Paragraph',
	"constraints" => 'Switch',
	"noLP" => 'Switch',
	"noGU" => 'Switch',
	"noCloseGU" => 'Switch',
	"nsp" => 'String',
	"parameter" => 'InFile',
	"energy" => 'Excl',
	"output_options" => 'Paragraph',
	"outfile" => 'OutFile',
	"b2ct" => 'Switch',
	"readseq" => 'String',
	"ctfiles" => 'Results',
	"psfiles" => 'Results',

    };

    $self->{FORMAT}  = {
	"rnafold" => {
		"perl" => '"RNAfold"',
	},
	"seq" => {
		"perl" => '" < $value" ',
	},
	"control" => {
	},
	"partition" => {
		"perl" => '($value)? " -p" : ""',
	},
	"pf" => {
		"perl" => '($value)? " -p0" : ""',
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
	"scale" => {
		"perl" => '($value)? " -S $value" : ""',
	},
	"input" => {
	},
	"constraints" => {
		"perl" => '($value)? " -C" : ""',
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
	"energy" => {
		"perl" => '($value)? " -e $value" : ""',
	},
	"output_options" => {
	},
	"outfile" => {
		"perl" => '($value)? " > $value" : ""',
	},
	"b2ct" => {
		"perl" => '($value)? " ; head -2 rnafold.out | b2ct > rnafold.ct " : ""',
	},
	"readseq" => {
		"perl" => '"/local/gensoft/lib/ViennaRNA/readseq  -f=19 -a $seq > $seq.tmp && (cp $seq $seq.orig && mv $seq.tmp $seq) ; "',
	},
	"ctfiles" => {
	},
	"psfiles" => {
	},

    };

    $self->{FILENAMES}  = {
	"ctfiles" => 'rnafold.ct',
	"psfiles" => '*.ps',

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"rnafold" => 0,
	"seq" => 1000,
	"control" => 2,
	"partition" => 2,
	"pf" => 2,
	"temperature" => 2,
	"tetraloops" => 2,
	"dangling" => 2,
	"scale" => 2,
	"input" => 2,
	"constraints" => 2,
	"noLP" => 2,
	"noGU" => 2,
	"noCloseGU" => 2,
	"nsp" => 2,
	"parameter" => 2,
	"energy" => 2,
	"outfile" => 2000,
	"b2ct" => 2000,
	"readseq" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readseq",
	"rnafold",
	"output_options",
	"ctfiles",
	"psfiles",
	"temperature",
	"tetraloops",
	"dangling",
	"scale",
	"input",
	"constraints",
	"noLP",
	"noGU",
	"noCloseGU",
	"nsp",
	"parameter",
	"energy",
	"control",
	"partition",
	"pf",
	"seq",
	"outfile",
	"b2ct",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnafold" => 1,
	"seq" => 0,
	"control" => 0,
	"partition" => 0,
	"pf" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"scale" => 0,
	"input" => 0,
	"constraints" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"b2ct" => 0,
	"readseq" => 1,
	"ctfiles" => 0,
	"psfiles" => 0,

    };

    $self->{ISCOMMAND}  = {
	"rnafold" => 1,
	"seq" => 0,
	"control" => 0,
	"partition" => 0,
	"pf" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"scale" => 0,
	"input" => 0,
	"constraints" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"b2ct" => 0,
	"readseq" => 0,
	"ctfiles" => 0,
	"psfiles" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnafold" => 0,
	"seq" => 1,
	"control" => 0,
	"partition" => 0,
	"pf" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"scale" => 0,
	"input" => 0,
	"constraints" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"output_options" => 0,
	"outfile" => 1,
	"b2ct" => 0,
	"readseq" => 0,
	"ctfiles" => 0,
	"psfiles" => 0,

    };

    $self->{PROMPT}  = {
	"rnafold" => "",
	"seq" => "RNA Sequences File",
	"control" => "Control options",
	"partition" => "Calculate the partition function and base pairing probability matrix (-p)",
	"pf" => "Calculate the pf without pairing matrix (-p0)",
	"temperature" => "Rescale energy parameters to a temperature of temp C. (-T)",
	"tetraloops" => "Do not include special stabilizing energies for certain tetraloops (-4)",
	"dangling" => "How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)",
	"scale" => "Use scale*mfe as an estimate for the free energy (-S)",
	"input" => "Input parameters",
	"constraints" => "Calculate structures subject to constraints (-C)",
	"noLP" => "Avoid lonely pairs (helices of length 1) (-noLP)",
	"noGU" => "Do not allow GU pairs (-noGU)",
	"noCloseGU" => "Do not allow GU pairs at the end of helices (-noCloseGU)",
	"nsp" => "Non standard pairs (comma seperated list) (-nsp)",
	"parameter" => "Parameter file (-P)",
	"energy" => "Energy parameters for the artificial ABCD... alphabet (-e)",
	"output_options" => "Output options",
	"outfile" => "Result file",
	"b2ct" => "converts the bracket notation produced by RNAfold into an .ct file, as produced by Zukers mfold",
	"readseq" => "",
	"ctfiles" => "",
	"psfiles" => "",

    };

    $self->{ISSTANDOUT}  = {
	"rnafold" => 0,
	"seq" => 0,
	"control" => 0,
	"partition" => 0,
	"pf" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"scale" => 0,
	"input" => 0,
	"constraints" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"output_options" => 0,
	"outfile" => 1,
	"b2ct" => 0,
	"readseq" => 0,
	"ctfiles" => 0,
	"psfiles" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['partition','pf','temperature','tetraloops','dangling','scale',],
	"dangling" => ['','only unpaired bases can participate in at most one dangling end','-d','-d: ignores dangling ends altogether','-d2','-d2: the check is ignored, this is the default for partition function folding.',],
	"input" => ['constraints','noLP','noGU','noCloseGU','nsp','parameter','energy',],
	"energy" => ['1','1: use energy parameters for GC pairs','2','2: use energy parameters for AU pairs',],
	"output_options" => ['outfile','b2ct',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"rnafold" => 'rnafold',
	"partition" => '0',
	"pf" => '0',
	"temperature" => '37',
	"tetraloops" => '0',
	"dangling" => '""',
	"constraints" => '0',
	"noLP" => '0',
	"noGU" => '0',
	"noCloseGU" => '0',
	"outfile" => 'struct.out',
	"b2ct" => '0',

    };

    $self->{PRECOND}  = {
	"rnafold" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"partition" => { "perl" => '1' },
	"pf" => { "perl" => '1' },
	"temperature" => { "perl" => '1' },
	"tetraloops" => { "perl" => '1' },
	"dangling" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"constraints" => { "perl" => '1' },
	"noLP" => { "perl" => '1' },
	"noGU" => { "perl" => '1' },
	"noCloseGU" => { "perl" => '1' },
	"nsp" => { "perl" => '1' },
	"parameter" => { "perl" => '1' },
	"energy" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"b2ct" => { "perl" => '1' },
	"readseq" => {
		"perl" => 'defined $rnafold || defined $rnasubopt',
	},
	"ctfiles" => {
		"perl" => '$b2ct',
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
	"outfile" => {
		 '! $partition' => "rnafold_struct",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"rnafold" => 0,
	"seq" => 0,
	"control" => 0,
	"partition" => 0,
	"pf" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"scale" => 0,
	"input" => 0,
	"constraints" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"b2ct" => 0,
	"readseq" => 0,
	"ctfiles" => 0,
	"psfiles" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnafold" => 0,
	"seq" => 1,
	"control" => 0,
	"partition" => 1,
	"pf" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"scale" => 0,
	"input" => 0,
	"constraints" => 0,
	"noLP" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"b2ct" => 0,
	"readseq" => 0,
	"ctfiles" => 0,
	"psfiles" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"pf" => [
		"Calculate the pf without pairing matrix and print the ensemble free energy -kT ln(Z). This is much faster.",
	],
	"dangling" => [
		"How to treat \'dangling end\' energies for bases adjacent to helices in free ends and multiloops: Normally only unpaired bases can participate in at most one dangling end. With -d2 this check is ignored, this is the default for partition function folding (-p). -d ignores dangling ends altogether. Note that by default pf and mfe folding treat dangling ends differently, use -d2 (or -d) in addition to -p to ensure that both algorithms use the same energy model. The -d2 options is available for RNAfold, RNAeval, and RNAinverse only.",
	],
	"scale" => [
		"In the calculation of the pf use scale*mfe as an estimate for the ensemble free energy (used to avoid overflows). The default is 1.07, usefull values are 1.0 to 1.2. Occasionally needed for long sequences. You can also recompile the programm to use double precision (see the README file).",
	],
	"constraints" => [
		"The programm reads first the sequence then the a string containg constraints on the structure encoded with the symbols: ",
		"| (the corresponding base has to be paired x (the base is unpaired)",
		"< (base i is paired with a base j>i)",
		"> (base i is paired with a base j<i)",
		"matching brackets ( ) (base i pairs base j)",
		"Pf folding ignores constraints of type \'|\' \'<\' and \'>\', but disallow all pairs conflicting with a constraint of type \'x\' or \'( )\'. This is usually sufficient to enforce the constraint.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnafold.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

