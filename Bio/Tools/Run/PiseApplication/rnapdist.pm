# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::rnapdist
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::rnapdist

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnapdist

      Bioperl class for:

	VIENNARNA	RNApdist - calculate distances of thermodynamic RNA secondary structures ensembles (Stadler, Hofacker, Bonhoeffer)

	References:

		Bonhoeffer S, McCaskill J S, Stadler P F, Schuster P, (1993) RNA multistructure landscapes, Euro Biophys J:22,13-24



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/rnapdist.html 
         for available values):


		rnapdist (String)

		seq (Sequence)
			RNA Sequences File

		compare (Excl)
			Which comparisons (-X)

		alignment_file (OutFile)
			Alignment file (-B)

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

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.open-bio.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/rnapdist.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::rnapdist;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnapdist = Bio::Tools::Run::PiseApplication::rnapdist->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnapdist object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $rnapdist = $factory->program('rnapdist');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnapdist.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnapdist.pm

    $self->{COMMAND}   = "rnapdist";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNApdist - calculate distances of thermodynamic RNA secondary structures ensembles";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Stadler, Hofacker, Bonhoeffer";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-na.html#VIENNARNA";

    $self->{REFERENCE}   = [

         "Bonhoeffer S, McCaskill J S, Stadler P F, Schuster P, (1993) RNA multistructure landscapes, Euro Biophys J:22,13-24",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnapdist",
	"seq",
	"comparison_options",
	"others_options",
	"readseq",
	"psfiles",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnapdist",
	"seq", 	# RNA Sequences File
	"comparison_options", 	# Comparison options
	"compare", 	# Which comparisons (-X)
	"alignment_file", 	# Alignment file (-B)
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
	"psfiles",

    ];

    $self->{TYPE}  = {
	"rnapdist" => 'String',
	"seq" => 'Sequence',
	"comparison_options" => 'Paragraph',
	"compare" => 'Excl',
	"alignment_file" => 'OutFile',
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
	"psfiles" => 'Results',

    };

    $self->{FORMAT}  = {
	"rnapdist" => {
		"perl" => '"RNApdist"',
	},
	"seq" => {
		"perl" => '" < $value" ',
	},
	"comparison_options" => {
	},
	"compare" => {
		"perl" => '($value && $value ne $vdef)? " -X$value" : ""',
	},
	"alignment_file" => {
		"perl" => '($value)? " -B $value" : ""',
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
	"rnapdist" => 0,
	"seq" => 1000,
	"comparison_options" => 2,
	"compare" => 2,
	"alignment_file" => 2,
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
	"rnapdist",
	"psfiles",
	"compare",
	"alignment_file",
	"others_options",
	"temperature",
	"tetraloops",
	"dangling",
	"noGU",
	"noCloseGU",
	"nsp",
	"parameter",
	"energy",
	"comparison_options",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnapdist" => 1,
	"seq" => 0,
	"comparison_options" => 0,
	"compare" => 0,
	"alignment_file" => 0,
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
	"psfiles" => 0,

    };

    $self->{ISCOMMAND}  = {
	"rnapdist" => 1,
	"seq" => 0,
	"comparison_options" => 0,
	"compare" => 0,
	"alignment_file" => 0,
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
	"psfiles" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnapdist" => 0,
	"seq" => 1,
	"comparison_options" => 0,
	"compare" => 0,
	"alignment_file" => 0,
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
	"psfiles" => 0,

    };

    $self->{PROMPT}  = {
	"rnapdist" => "",
	"seq" => "RNA Sequences File",
	"comparison_options" => "Comparison options",
	"compare" => "Which comparisons (-X)",
	"alignment_file" => "Alignment file (-B)",
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
	"psfiles" => "",

    };

    $self->{ISSTANDOUT}  = {
	"rnapdist" => 0,
	"seq" => 0,
	"comparison_options" => 0,
	"compare" => 0,
	"alignment_file" => 0,
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
	"psfiles" => 0,

    };

    $self->{VLIST}  = {

	"comparison_options" => ['compare','alignment_file',],
	"compare" => ['p','p: pairwise (1st/2nd, 3rd/4th etc)','m','m: distance matrix between all structures','f','f: each structure to the first one','c','c: continuously, that is i-th with (i+1)th structure',],
	"others_options" => ['temperature','tetraloops','dangling','noGU','noCloseGU','nsp','parameter','energy',],
	"dangling" => ['','only unpaired bases can participate in at most one dangling end','-d','-d: ignores dangling ends altogether','-d2','-d2: the check is ignored, this is the default for partition function folding.',],
	"energy" => ['1','1: use energy parameters for GC pairs','2','2: use energy parameters for AU pairs',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"compare" => 'p',
	"temperature" => '37',
	"tetraloops" => '0',
	"dangling" => '""',
	"noGU" => '0',
	"noCloseGU" => '0',

    };

    $self->{PRECOND}  = {
	"rnapdist" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"comparison_options" => { "perl" => '1' },
	"compare" => { "perl" => '1' },
	"alignment_file" => { "perl" => '1' },
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
	"rnapdist" => 0,
	"seq" => 0,
	"comparison_options" => 0,
	"compare" => 0,
	"alignment_file" => 0,
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
	"psfiles" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnapdist" => 0,
	"seq" => 1,
	"comparison_options" => 0,
	"compare" => 0,
	"alignment_file" => 0,
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
	"psfiles" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"alignment_file" => [
		"Print an \'alignment\' with gaps of the structures, to show matching substructures. The aligned structures are written to file, if specified. Otherwise output is written to stdout, unless the -Xm option is set in which case \'backtrack.file\' is used.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnapdist.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

