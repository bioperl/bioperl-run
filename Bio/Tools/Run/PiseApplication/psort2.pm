
=head1 NAME

Bio::Tools::Run::PiseApplication::psort2

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::psort2

      Bioperl class for:

	PSORT	predicts protein subcellular localization sites from their amino acid sequences (Psort version II) (Nakai, K. and Horton, P.)

	References:

		PSORT: a program for detecting the sorting signals of proteins and predicting their subcellular localization,trends Biochem. Sci., in press, 1999.


      Parameters:


		psort2 (String)
			

		seqfile (Sequence)
			Protein sequence file

		Verbose (Switch)
			Verbose mode

		htmlfile (OutFile)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::psort2;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $psort2 = Bio::Tools::Run::PiseApplication::psort2->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::psort2 object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $psort2 = $factory->program('psort2');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::psort2.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/psort2.pm

    $self->{COMMAND}   = "psort2";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PSORT";

    $self->{DESCRIPTION}   = "predicts protein subcellular localization sites from their amino acid sequences (Psort version II)";

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{AUTHORS}   = "Nakai, K. and Horton, P.";

    $self->{REFERENCE}   = [

         "PSORT: a program for detecting the sorting signals of proteins and predicting their subcellular localization,trends Biochem. Sci., in press, 1999.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"psort2",
	"seqfile",
	"Verbose",
	"htmlfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"psort2",
	"seqfile", 	# Protein sequence file
	"Verbose", 	# Verbose mode
	"htmlfile",

    ];

    $self->{TYPE}  = {
	"psort2" => 'String',
	"seqfile" => 'Sequence',
	"Verbose" => 'Switch',
	"htmlfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"psort2" => {
		"perl" => 'psort',
	},
	"seqfile" => {
		"perl" => '" $value"',
	},
	"Verbose" => {
		"perl" => '($value)? " -w" : ""',
	},
	"htmlfile" => {
		"perl" => '" > psort2.html"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqfile" => [8],

    };

    $self->{GROUP}  = {
	"psort2" => 0,
	"seqfile" => 2,
	"Verbose" => 1,
	"htmlfile" => 100,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"psort2",
	"Verbose",
	"seqfile",
	"htmlfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"psort2" => 1,
	"seqfile" => 0,
	"Verbose" => 0,
	"htmlfile" => 1,

    };

    $self->{ISCOMMAND}  = {
	"psort2" => 1,
	"seqfile" => 0,
	"Verbose" => 0,
	"htmlfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"psort2" => 1,
	"seqfile" => 1,
	"Verbose" => 0,
	"htmlfile" => 0,

    };

    $self->{PROMPT}  = {
	"psort2" => "",
	"seqfile" => "Protein sequence file",
	"Verbose" => "Verbose mode",
	"htmlfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"psort2" => 0,
	"seqfile" => 0,
	"Verbose" => 0,
	"htmlfile" => 1,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"Verbose" => '1',
	"htmlfile" => '"psort2.html"',

    };

    $self->{PRECOND}  = {
	"psort2" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"Verbose" => { "perl" => '1' },
	"htmlfile" => { "perl" => '1' },

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
	"psort2" => 0,
	"seqfile" => 0,
	"Verbose" => 0,
	"htmlfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"psort2" => 0,
	"seqfile" => 1,
	"Verbose" => 0,
	"htmlfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/psort2.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

