
=head1 NAME

Bio::Tools::Run::PiseApplication::mfold

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mfold

      Bioperl class for:

	MFOLD	Prediction of RNA secondary structure (M. Zuker)

	References:

		A.E. Walter, D.H. Turner, J. Kim, M.H. Lyttle, P. Muller, D.H. Mathews and M. Zuker Coaxial stacking of helixes enhances binding of oligoribonucleotides and improves predictions of RNA folding. Proc. Natl. Acad. Sci. USA 91, 9218-9222 (1994)


      Parameters:


		mfold (String)


		SEQ (Sequence)
			Sequence File (SEQ)

		LC (Excl)
			Sequence type (default = linear) (LC)

		NA (Excl)
			RNA (default) or DNA (NA)

		control (Paragraph)
			Control options

		T (Integer)
			Temperature (T)

		P (Integer)
			Percent (P)

		W (Integer)
			Window parameter (default - set by sequence length) (W)

		MAX (Integer)
			Maximum number of foldings to be computed (MAX)

		START (Integer)
			5' base number (START)

		STOP (Integer)
			3' base number (default = end) (STOP)

		htmlfile (Results)


		outfiles (Results)


		psfiles (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::mfold;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mfold = Bio::Tools::Run::PiseApplication::mfold->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mfold object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $mfold = $factory->program('mfold');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::mfold.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mfold.pm

    $self->{COMMAND}   = "mfold";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MFOLD";

    $self->{DESCRIPTION}   = "Prediction of RNA secondary structure";

    $self->{AUTHORS}   = "M. Zuker";

    $self->{REFERENCE}   = [

         "A.E. Walter, D.H. Turner, J. Kim, M.H. Lyttle, P. Muller, D.H. Mathews and M. Zuker Coaxial stacking of helixes enhances binding of oligoribonucleotides and improves predictions of RNA folding. Proc. Natl. Acad. Sci. USA 91, 9218-9222 (1994)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mfold",
	"SEQ",
	"LC",
	"NA",
	"control",
	"htmlfile",
	"outfiles",
	"psfiles",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mfold",
	"SEQ", 	# Sequence File (SEQ)
	"LC", 	# Sequence type (default = linear) (LC)
	"NA", 	# RNA (default) or DNA (NA)
	"control", 	# Control options
	"T", 	# Temperature (T)
	"P", 	# Percent (P)
	"W", 	# Window parameter (default - set by sequence length) (W)
	"MAX", 	# Maximum number of foldings to be computed (MAX)
	"START", 	# 5' base number (START)
	"STOP", 	# 3' base number (default = end) (STOP)
	"htmlfile",
	"outfiles",
	"psfiles",

    ];

    $self->{TYPE}  = {
	"mfold" => 'String',
	"SEQ" => 'Sequence',
	"LC" => 'Excl',
	"NA" => 'Excl',
	"control" => 'Paragraph',
	"T" => 'Integer',
	"P" => 'Integer',
	"W" => 'Integer',
	"MAX" => 'Integer',
	"START" => 'Integer',
	"STOP" => 'Integer',
	"htmlfile" => 'Results',
	"outfiles" => 'Results',
	"psfiles" => 'Results',

    };

    $self->{FORMAT}  = {
	"mfold" => {
		"perl" => '($_html)? "mfold-html" : "mfold" ',
	},
	"SEQ" => {
		"perl" => '  " SEQ=$value"',
	},
	"LC" => {
		"perl" => '($value && $value ne $vdef)?" LC=$value":""',
	},
	"NA" => {
		"perl" => '($value && $value ne $vdef)?" NA=$value":""',
	},
	"control" => {
	},
	"T" => {
		"perl" => '(defined $value && $value ne $vdef)?" T=$value":""',
	},
	"P" => {
		"perl" => '(defined $value && $value ne $vdef)?" P=$value":""',
	},
	"W" => {
		"perl" => '(defined $value)?" W=$value":""',
	},
	"MAX" => {
		"perl" => '(defined $value && $value ne $vdef)?" MAX=$value":""',
	},
	"START" => {
		"perl" => '(defined $value && $value ne $vdef)?" START=$value":""',
	},
	"STOP" => {
		"perl" => '(defined $value)?" STOP=$value":""',
	},
	"htmlfile" => {
	},
	"outfiles" => {
	},
	"psfiles" => {
	},

    };

    $self->{FILENAMES}  = {
	"htmlfile" => '*.html',
	"outfiles" => '*.pnt *.plot',
	"psfiles" => '*.ps',

    };

    $self->{SEQFMT}  = {
	"SEQ" => [1,2,3,4,5,9],

    };

    $self->{GROUP}  = {
	"mfold" => 0,
	"SEQ" => 1,
	"LC" => 2,
	"NA" => 2,
	"control" => 3,
	"T" => 3,
	"P" => 3,
	"W" => 3,
	"MAX" => 3,
	"START" => 3,
	"STOP" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"mfold",
	"htmlfile",
	"outfiles",
	"psfiles",
	"SEQ",
	"NA",
	"LC",
	"W",
	"MAX",
	"START",
	"STOP",
	"control",
	"T",
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
	"W" => 0,
	"MAX" => 0,
	"START" => 0,
	"STOP" => 0,
	"htmlfile" => 0,
	"outfiles" => 0,
	"psfiles" => 0,

    };

    $self->{ISCOMMAND}  = {
	"mfold" => 1,
	"SEQ" => 0,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"W" => 0,
	"MAX" => 0,
	"START" => 0,
	"STOP" => 0,
	"htmlfile" => 0,
	"outfiles" => 0,
	"psfiles" => 0,

    };

    $self->{ISMANDATORY}  = {
	"mfold" => 0,
	"SEQ" => 1,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"W" => 0,
	"MAX" => 0,
	"START" => 0,
	"STOP" => 0,
	"htmlfile" => 0,
	"outfiles" => 0,
	"psfiles" => 0,

    };

    $self->{PROMPT}  = {
	"mfold" => "",
	"SEQ" => "Sequence File (SEQ)",
	"LC" => "Sequence type (default = linear) (LC)",
	"NA" => "RNA (default) or DNA (NA)",
	"control" => "Control options",
	"T" => "Temperature (T)",
	"P" => "Percent (P)",
	"W" => "Window parameter (default - set by sequence length) (W)",
	"MAX" => "Maximum number of foldings to be computed (MAX)",
	"START" => "5' base number (START)",
	"STOP" => "3' base number (default = end) (STOP)",
	"htmlfile" => "",
	"outfiles" => "",
	"psfiles" => "",

    };

    $self->{ISSTANDOUT}  = {
	"mfold" => 0,
	"SEQ" => 0,
	"LC" => 0,
	"NA" => 0,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"W" => 0,
	"MAX" => 0,
	"START" => 0,
	"STOP" => 0,
	"htmlfile" => 0,
	"outfiles" => 0,
	"psfiles" => 0,

    };

    $self->{VLIST}  = {

	"LC" => ['linear','linear','circular','circular',],
	"NA" => ['RNA','RNA','DNA','DNA',],
	"control" => ['T','P','W','MAX','START','STOP',],
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
	"MAX" => '100',
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
	"W" => { "perl" => '1' },
	"MAX" => { "perl" => '1' },
	"START" => { "perl" => '1' },
	"STOP" => { "perl" => '1' },
	"htmlfile" => {
		"perl" => '($_html)',
	},
	"outfiles" => { "perl" => '1' },
	"psfiles" => { "perl" => '1' },

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
	"W" => 0,
	"MAX" => 0,
	"START" => 0,
	"STOP" => 0,
	"htmlfile" => 0,
	"outfiles" => 0,
	"psfiles" => 0,

    };

    $self->{ISSIMPLE}  = {
	"mfold" => 0,
	"SEQ" => 1,
	"LC" => 1,
	"NA" => 1,
	"control" => 0,
	"T" => 0,
	"P" => 0,
	"W" => 0,
	"MAX" => 0,
	"START" => 0,
	"STOP" => 0,
	"htmlfile" => 0,
	"outfiles" => 0,
	"psfiles" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"P" => [
		"All computed folding will have energiy within P% from the computed minimum free energy.",
	],
	"W" => [
		"The window parameter controls how many foldings will be automatically computed and how different they will be from one another. It takes on positive whole number values. A smaller value of this parameter will usually result in more computed foldings that may be quite similar to one another. A larger value will result in fewer foldings that are very different from one another. If this parameter is not chosen by the user, a default value will be selected from the table below according to the sequence size.",
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

