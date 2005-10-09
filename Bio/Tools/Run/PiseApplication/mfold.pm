# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::mfold
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::mfold

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mfold

      Bioperl class for:

	MFOLD	Prediction of RNA secondary structure (M. Zuker)

	References:

		M. Zuker, D.H. Mathews and D.H. Turner Algorithms and Thermodynamics for RNA Secondary Structure Prediction: A Practical Guide in RNA Biochemistry and Biotechnology, J. Barciszewski and B.F.C. Clark, eds., NATO ASI Series, Kluwer Academic Publishers, (1999) 



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/mfold.html 
         for available values):


		mfold (String)

		SEQ (Sequence)
			Sequence File (SEQ)

		LC (Excl)
			Sequence type (default = linear) (LC)

		NA (Excl)
			RNA (default) or DNA (NA)

		T (Integer)
			Temperature (T)

		P (Integer)
			Percent (P)

		NA_CONC (Float)
			Na+ molar concentration (NA_CONC)

		MG_CONC (Float)
			Mg++ molar concentration (MG_CONC)

		W (Integer)
			Window parameter (default - set by sequence length) (W)

		MAXBP (Integer)
			MAXBP: Max base pair distance (default - no limit)

		MAX (Integer)
			MAX: Maximum number of foldings to be computed

		ANN (Excl)
			Structure annotation type (default=none) (ANN)

		MODE (Excl)
			Structure display mode (default=auto) (MODE)

		ROT_ANG (Integer)
			Structure rotation angle (ROT_ANG)

		START (Integer)
			5' base number (START)

		STOP (Integer)
			3' base number (default = end) (STOP)

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

http://bioweb.pasteur.fr/seqanal/interfaces/mfold.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::mfold;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mfold = Bio::Tools::Run::PiseApplication::mfold->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mfold object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $mfold = $factory->program('mfold');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::mfold.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mfold.pm

    $self->{COMMAND}   = "mfold";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MFOLD";

    $self->{DESCRIPTION}   = "Prediction of RNA secondary structure";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "M. Zuker";

    $self->{REFERENCE}   = [

         "M. Zuker, D.H. Mathews and D.H. Turner Algorithms and Thermodynamics for RNA Secondary Structure Prediction: A Practical Guide in RNA Biochemistry and Biotechnology, J. Barciszewski and B.F.C. Clark, eds., NATO ASI Series, Kluwer Academic Publishers, (1999) ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mfold",
	"SEQ",
	"LC",
	"NA",
	"control",
	"outfiles",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mfold",
	"SEQ", 	# Sequence File (SEQ)
	"LC", 	# Sequence type (default = linear) (LC)
	"NA", 	# RNA (default) or DNA (NA)
	"control", 	# Control options
	"T", 	# Temperature (T)
	"P", 	# Percent (P)
	"NA_CONC", 	# Na+ molar concentration (NA_CONC)
	"MG_CONC", 	# Mg++ molar concentration (MG_CONC)
	"W", 	# Window parameter (default - set by sequence length) (W)
	"MAXBP", 	# MAXBP: Max base pair distance (default - no limit)
	"MAX", 	# MAX: Maximum number of foldings to be computed
	"ANN", 	# Structure annotation type (default=none) (ANN)
	"MODE", 	# Structure display mode (default=auto) (MODE)
	"ROT_ANG", 	# Structure rotation angle (ROT_ANG)
	"START", 	# 5' base number (START)
	"STOP", 	# 3' base number (default = end) (STOP)
	"outfiles",

    ];

    $self->{TYPE}  = {
	"mfold" => 'String',
	"SEQ" => 'Sequence',
	"LC" => 'Excl',
	"NA" => 'Excl',
	"control" => 'Paragraph',
	"T" => 'Integer',
	"P" => 'Integer',
	"NA_CONC" => 'Float',
	"MG_CONC" => 'Float',
	"W" => 'Integer',
	"MAXBP" => 'Integer',
	"MAX" => 'Integer',
	"ANN" => 'Excl',
	"MODE" => 'Excl',
	"ROT_ANG" => 'Integer',
	"START" => 'Integer',
	"STOP" => 'Integer',
	"outfiles" => 'Results',

    };

    $self->{FORMAT}  = {
	"mfold" => {
		"perl" => ' "mfold RUN_TYPE=html" ',
	},
	"SEQ" => {
		"perl" => '  " SEQ=$value"',
	},
	"LC" => {
		"perl" => '($value and $value ne $vdef)?" LC=$value":""',
	},
	"NA" => {
		"perl" => '($value and $value ne $vdef)?" NA=$value":""',
	},
	"control" => {
	},
	"T" => {
		"perl" => '(defined $value and $value ne $vdef)?" T=$value":""',
	},
	"P" => {
		"perl" => '(defined $value and $value ne $vdef)?" P=$value":""',
	},
	"NA_CONC" => {
		"perl" => '(defined $value and $value ne $vdef)?" NA_CONC=$value":""',
	},
	"MG_CONC" => {
		"perl" => '(defined $value and $value ne $vdef)?" MG_CONC=$value":""',
	},
	"W" => {
		"perl" => '(defined $value)?" W=$value":""',
	},
	"MAXBP" => {
		"perl" => '($value)?" MAXBP=$value":""',
	},
	"MAX" => {
		"perl" => '($value and $value ne $vdef)?" MAX=$value":""',
	},
	"ANN" => {
		"perl" => '($value and $value ne $vdef)?" ANN=$value":""',
	},
	"MODE" => {
		"perl" => '($value and $value ne $vdef)?" MODE=$value":""',
	},
	"ROT_ANG" => {
		"perl" => '($value and $value ne $vdef)?" ROT_ANG=$value":""',
	},
	"START" => {
		"perl" => '($value and $value ne $vdef)?" START=$value":""',
	},
	"STOP" => {
		"perl" => '($value)?" STOP=$value":""',
	},
	"outfiles" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfiles" => '*.pnt *.plot *.ct *.html *.gif',

    };

    $self->{SEQFMT}  = {
	"SEQ" => [1,2,4],

    };

    $self->{GROUP}  = {
	"mfold" => 0,
	"SEQ" => 1,
	"LC" => 2,
	"NA" => 2,
	"control" => 3,
	"T" => 3,
	"P" => 3,
	"NA_CONC" => 3,
	"MG_CONC" => 3,
	"W" => 3,
	"MAXBP" => 3,
	"MAX" => 3,
	"ANN" => 2,
	"MODE" => 2,
	"ROT_ANG" => 3,
	"START" => 3,
	"STOP" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"mfold",
	"outfiles",
	"SEQ",
	"NA",
	"ANN",
	"MODE",
	"LC",
	"NA_CONC",
	"MG_CONC",
	"W",
	"MAXBP",
	"MAX",
	"control",
	"T",
	"ROT_ANG",
	"START",
	"STOP",
	"P",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"mfold" => 1,
	"SEQ" => 0,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"NA_CONC" => 0,
	"MG_CONC" => 0,
	"W" => 0,
	"MAXBP" => 0,
	"MAX" => 0,
	"ANN" => 0,
	"MODE" => 0,
	"ROT_ANG" => 0,
	"START" => 0,
	"STOP" => 0,
	"outfiles" => 0,

    };

    $self->{ISCOMMAND}  = {
	"mfold" => 1,
	"SEQ" => 0,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"NA_CONC" => 0,
	"MG_CONC" => 0,
	"W" => 0,
	"MAXBP" => 0,
	"MAX" => 0,
	"ANN" => 0,
	"MODE" => 0,
	"ROT_ANG" => 0,
	"START" => 0,
	"STOP" => 0,
	"outfiles" => 0,

    };

    $self->{ISMANDATORY}  = {
	"mfold" => 0,
	"SEQ" => 1,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"NA_CONC" => 0,
	"MG_CONC" => 0,
	"W" => 0,
	"MAXBP" => 0,
	"MAX" => 0,
	"ANN" => 0,
	"MODE" => 0,
	"ROT_ANG" => 0,
	"START" => 0,
	"STOP" => 0,
	"outfiles" => 0,

    };

    $self->{PROMPT}  = {
	"mfold" => "",
	"SEQ" => "Sequence File (SEQ)",
	"LC" => "Sequence type (default = linear) (LC)",
	"NA" => "RNA (default) or DNA (NA)",
	"control" => "Control options",
	"T" => "Temperature (T)",
	"P" => "Percent (P)",
	"NA_CONC" => "Na+ molar concentration (NA_CONC)",
	"MG_CONC" => "Mg++ molar concentration (MG_CONC)",
	"W" => "Window parameter (default - set by sequence length) (W)",
	"MAXBP" => "MAXBP: Max base pair distance (default - no limit)",
	"MAX" => "MAX: Maximum number of foldings to be computed",
	"ANN" => "Structure annotation type (default=none) (ANN)",
	"MODE" => "Structure display mode (default=auto) (MODE)",
	"ROT_ANG" => "Structure rotation angle (ROT_ANG)",
	"START" => "5' base number (START)",
	"STOP" => "3' base number (default = end) (STOP)",
	"outfiles" => "",

    };

    $self->{ISSTANDOUT}  = {
	"mfold" => 0,
	"SEQ" => 0,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"NA_CONC" => 0,
	"MG_CONC" => 0,
	"W" => 0,
	"MAXBP" => 0,
	"MAX" => 0,
	"ANN" => 0,
	"MODE" => 0,
	"ROT_ANG" => 0,
	"START" => 0,
	"STOP" => 0,
	"outfiles" => 0,

    };

    $self->{VLIST}  = {

	"LC" => ['linear','linear','circular','circular',],
	"NA" => ['RNA','RNA','DNA','DNA',],
	"control" => ['T','P','NA_CONC','MG_CONC','W','MAXBP','MAX','ANN','MODE','ROT_ANG','START','STOP',],
	"ANN" => ['none','none','p-num','p-num','ss-count','ss-count',],
	"MODE" => ['auto','auto','bases','bases','lines','lines',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"LC" => 'linear',
	"NA" => 'RNA',
	"T" => '37',
	"P" => '5',
	"NA_CONC" => '1.0',
	"MG_CONC" => '0.0',
	"MAX" => '50',
	"ANN" => 'none',
	"MODE" => 'auto',
	"ROT_ANG" => '0',
	"START" => '1',

    };

    $self->{PRECOND}  = {
	"mfold" => { "perl" => '1' },
	"SEQ" => { "perl" => '1' },
	"LC" => { "perl" => '1' },
	"NA" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"T" => { "perl" => '1' },
	"P" => { "perl" => '1' },
	"NA_CONC" => { "perl" => '1' },
	"MG_CONC" => { "perl" => '1' },
	"W" => { "perl" => '1' },
	"MAXBP" => { "perl" => '1' },
	"MAX" => { "perl" => '1' },
	"ANN" => { "perl" => '1' },
	"MODE" => { "perl" => '1' },
	"ROT_ANG" => { "perl" => '1' },
	"START" => { "perl" => '1' },
	"STOP" => { "perl" => '1' },
	"outfiles" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

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
	"mfold" => 0,
	"SEQ" => 0,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"NA_CONC" => 0,
	"MG_CONC" => 0,
	"W" => 0,
	"MAXBP" => 0,
	"MAX" => 0,
	"ANN" => 0,
	"MODE" => 0,
	"ROT_ANG" => 0,
	"START" => 0,
	"STOP" => 0,
	"outfiles" => 0,

    };

    $self->{ISSIMPLE}  = {
	"mfold" => 0,
	"SEQ" => 1,
	"LC" => 1,
	"NA" => 1,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"NA_CONC" => 0,
	"MG_CONC" => 0,
	"W" => 0,
	"MAXBP" => 0,
	"MAX" => 0,
	"ANN" => 0,
	"MODE" => 0,
	"ROT_ANG" => 0,
	"START" => 0,
	"STOP" => 0,
	"outfiles" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"SEQ" => [
		"SEQ : The sequence file may contain multiple sequences.At present, the mfold script will fold the first sequence by default.",
	],
	"P" => [
		"P : This is the percent suboptimality for computing the energy dotplot and suboptimal foldings. The default value is 5%. This parametercontrols the value of the free energy increment, delta (deltaG).Delta of deltaG is set to P% of deltaG, the computed minimum freeenergy.  The energy dot plot shows only those base pairs that are infoldings with free energy minus or equal to deltaG plus delta(deltaG). Similarly, the free energies of computed foldings are in therange from deltaG to deltaG plus delta (deltaG). No matter the valueof P, mfold currently keeps delta (deltaG) in the range [1,12](kcal/mole).",
	],
	"W" => [
		"W : This is the window parameter that controls the number of foldingsthat are automatically computed by mfold . `W\' may be thought of as adistance parameter. The distance between 2 base pairs, i.j and i\'.j\'may be defined as max{|i-i\'|,|j-j\'|}. Then if k-1 foldings havealready been predicted by mfold , the kth folding will have at least Wbase pairs that are at least a distance W from any of the base pairsin the first k-1 foldings. As W increases, the number of predictedfoldings decreases. If W is not specified, mfold selects a value bydefault based on sequence length, as displayed in Table 3.",
	],
	"MAXBP" => [
		"MAXBP : A base pair i.j will not be allowed to form (in linear RNA) ifj-i > MAXBP. For circular RNA, a base pair i.j cannot form ifmin{j-i,n+i-j} > MAXBP . Thus small values of MAXBP ensure that onlyshort range base pairs will be predicted. By default, MAXBP=+infinity,indicating no constraint. ",
	],
	"MAX" => [
		"MAX : This is the maximum number of foldings that mfold will compute(50 by default). It is better to limit the number of foldings bycareful selection of the P and W parameters. ",
	],
	"ANN" => [
		"ANN : This parameter currently takes on 3 values. ",
		"1. `none\' :secondary structures are drawn without any special annotation. Lettersor outline are in black, while base pairs are red lines or dots for GCpairs and blue lines or dots for AU and GU pairs. ",
		"2. `p-num\' : Coloreddots, colored base characters or a combination are used to display ineach folding how well-determined each base is according to the P-numvalues in the `fold_name.ann\' file. ",
		"3. `ss-count\' : Colored dots,colored base characters or a combination are used to display in eachfolding how likely a base is to be single-stranded according to samplestatistics stored in the `fold_name.ss-count\' file. Both 2. and3. were recently described [38].",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mfold.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

