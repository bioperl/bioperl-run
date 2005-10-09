# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::rnaheat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::rnaheat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnaheat

      Bioperl class for:

	VIENNARNA	RNAheat - calculate specific heat of RNAs (Hofacker, Stadler)

	References:

		I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188

		J.S. McCaskill (1990) The equilibrium partition function and base pair binding probabilities for RNA secondary structures, Biopolymers 29: 11051119 D. Adams (1979) The hitchhiker's guide to the galaxy, Pan Books, London



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/rnaheat.html 
         for available values):


		rnaheat (String)

		seq (Sequence)
			RNA Sequences File

		temp_min (Integer)
			Lowest temperature, default is 0C (-Tmin)

		temp_max (Integer)
			Highest temperature, default is 100C (-Tmax)

		stepsize (Integer)
			Calculate partition function every stepsize degrees C. Default is 1C (-h)

		ipoints (Integer)
			Produces a smoother curve by increasing ipoints (-m)

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

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/rnaheat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::rnaheat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnaheat = Bio::Tools::Run::PiseApplication::rnaheat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnaheat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $rnaheat = $factory->program('rnaheat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnaheat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnaheat.pm

    $self->{COMMAND}   = "rnaheat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNAheat - calculate specific heat of RNAs";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Hofacker, Stadler";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-na.html#VIENNARNA";

    $self->{REFERENCE}   = [

         "I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188",

         "J.S. McCaskill (1990) The equilibrium partition function and base pair binding probabilities for RNA secondary structures, Biopolymers 29: 11051119 D. Adams (1979) The hitchhiker's guide to the galaxy, Pan Books, London",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnaheat",
	"seq",
	"control",
	"input",
	"readseq",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnaheat",
	"seq", 	# RNA Sequences File
	"control", 	# Control options
	"temp_min", 	# Lowest temperature, default is 0C (-Tmin)
	"temp_max", 	# Highest temperature, default is 100C (-Tmax)
	"stepsize", 	# Calculate partition function every stepsize degrees C. Default is 1C (-h)
	"ipoints", 	# Produces a smoother curve by increasing ipoints (-m)
	"tetraloops", 	# Do not include special stabilizing energies for certain tetraloops (-4)
	"dangling", 	# How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)
	"input", 	# Input parameters
	"noGU", 	# Do not allow GU pairs (-noGU)
	"noCloseGU", 	# Do not allow GU pairs at the end of helices (-noCloseGU)
	"nsp", 	# Non standard pairs (comma seperated list) (-nsp)
	"parameter", 	# Parameter file (-P)
	"energy", 	# Energy parameters for the artificial ABCD... alphabet (-e)
	"readseq",

    ];

    $self->{TYPE}  = {
	"rnaheat" => 'String',
	"seq" => 'Sequence',
	"control" => 'Paragraph',
	"temp_min" => 'Integer',
	"temp_max" => 'Integer',
	"stepsize" => 'Integer',
	"ipoints" => 'Integer',
	"tetraloops" => 'Switch',
	"dangling" => 'Excl',
	"input" => 'Paragraph',
	"noGU" => 'Switch',
	"noCloseGU" => 'Switch',
	"nsp" => 'String',
	"parameter" => 'InFile',
	"energy" => 'Excl',
	"readseq" => 'String',

    };

    $self->{FORMAT}  = {
	"rnaheat" => {
		"perl" => '"RNAheat"',
	},
	"seq" => {
		"perl" => '" < $value" ',
	},
	"control" => {
	},
	"temp_min" => {
		"perl" => '(defined $value && $value ne $vdef)? " -Tmin $value" : ""',
	},
	"temp_max" => {
		"perl" => '(defined $value && $value ne $vdef)? " -Tmax $value" : ""',
	},
	"stepsize" => {
		"perl" => '(defined $value && $value ne $vdef)? " -h $value" : ""',
	},
	"ipoints" => {
		"perl" => '(defined $value && $value ne $vdef)? " -m $value" : ""',
	},
	"tetraloops" => {
		"perl" => '($value)? " -4" : ""',
	},
	"dangling" => {
		"perl" => '($value)? " $value" : ""',
	},
	"input" => {
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
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"rnaheat" => 0,
	"seq" => 1000,
	"control" => 2,
	"temp_min" => 2,
	"temp_max" => 2,
	"stepsize" => 2,
	"ipoints" => 2,
	"tetraloops" => 2,
	"dangling" => 2,
	"input" => 2,
	"noGU" => 2,
	"noCloseGU" => 2,
	"nsp" => 2,
	"parameter" => 2,
	"energy" => 2,
	"readseq" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readseq",
	"rnaheat",
	"control",
	"temp_min",
	"temp_max",
	"stepsize",
	"ipoints",
	"tetraloops",
	"dangling",
	"input",
	"noGU",
	"noCloseGU",
	"nsp",
	"parameter",
	"energy",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnaheat" => 1,
	"seq" => 0,
	"control" => 0,
	"temp_min" => 0,
	"temp_max" => 0,
	"stepsize" => 0,
	"ipoints" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"input" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 1,

    };

    $self->{ISCOMMAND}  = {
	"rnaheat" => 1,
	"seq" => 0,
	"control" => 0,
	"temp_min" => 0,
	"temp_max" => 0,
	"stepsize" => 0,
	"ipoints" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"input" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnaheat" => 0,
	"seq" => 1,
	"control" => 0,
	"temp_min" => 0,
	"temp_max" => 0,
	"stepsize" => 0,
	"ipoints" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"input" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{PROMPT}  = {
	"rnaheat" => "",
	"seq" => "RNA Sequences File",
	"control" => "Control options",
	"temp_min" => "Lowest temperature, default is 0C (-Tmin)",
	"temp_max" => "Highest temperature, default is 100C (-Tmax)",
	"stepsize" => "Calculate partition function every stepsize degrees C. Default is 1C (-h)",
	"ipoints" => "Produces a smoother curve by increasing ipoints (-m)",
	"tetraloops" => "Do not include special stabilizing energies for certain tetraloops (-4)",
	"dangling" => "How to treat dangling end energies for bases adjacent to helices in free ends and multiloops (-d)",
	"input" => "Input parameters",
	"noGU" => "Do not allow GU pairs (-noGU)",
	"noCloseGU" => "Do not allow GU pairs at the end of helices (-noCloseGU)",
	"nsp" => "Non standard pairs (comma seperated list) (-nsp)",
	"parameter" => "Parameter file (-P)",
	"energy" => "Energy parameters for the artificial ABCD... alphabet (-e)",
	"readseq" => "",

    };

    $self->{ISSTANDOUT}  = {
	"rnaheat" => 0,
	"seq" => 0,
	"control" => 0,
	"temp_min" => 0,
	"temp_max" => 0,
	"stepsize" => 0,
	"ipoints" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"input" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['temp_min','temp_max','stepsize','ipoints','tetraloops','dangling',],
	"dangling" => ['','only unpaired bases can participate in at most one dangling end','-d','-d: ignores dangling ends altogether','-d2','-d2: the check is ignored, this is the default for partition function folding.',],
	"input" => ['noGU','noCloseGU','nsp','parameter','energy',],
	"energy" => ['1','1: use energy parameters for GC pairs','2','2: use energy parameters for AU pairs',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"temp_min" => '0',
	"temp_max" => '100',
	"stepsize" => '1',
	"ipoints" => '2',
	"tetraloops" => '0',
	"dangling" => '""',
	"noGU" => '0',
	"noCloseGU" => '0',

    };

    $self->{PRECOND}  = {
	"rnaheat" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"temp_min" => { "perl" => '1' },
	"temp_max" => { "perl" => '1' },
	"stepsize" => { "perl" => '1' },
	"ipoints" => { "perl" => '1' },
	"tetraloops" => { "perl" => '1' },
	"dangling" => { "perl" => '1' },
	"input" => { "perl" => '1' },
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
	"rnaheat" => 0,
	"seq" => 0,
	"control" => 0,
	"temp_min" => 0,
	"temp_max" => 0,
	"stepsize" => 0,
	"ipoints" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"input" => 0,
	"noGU" => 0,
	"noCloseGU" => 0,
	"nsp" => 0,
	"parameter" => 0,
	"energy" => 0,
	"readseq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnaheat" => 0,
	"seq" => 1,
	"control" => 0,
	"temp_min" => 0,
	"temp_max" => 0,
	"stepsize" => 0,
	"ipoints" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"input" => 0,
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
	"ipoints" => [
		"The program fits a parabola to 2*ipoints+1 data points to calculate 2nd derivatives. Increasing this parameter produces a smoother curve. Default is 2.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnaheat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

