
=head1 NAME

Bio::Tools::Run::PiseApplication::scopparse

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::scopparse

      Bioperl class for:

	SCOPPARSE	Reads raw scop classifications file and writes embl-like format scop classification file. (EMBOSS)

      Parameters:


		scopparse (String)
			

		init (String)
			

		infilea (InFile)
			Name of scop classification file for input (raw format dir.cla.scop.txt_X.XX file) (-infilea)

		infileb (InFile)
			Name of description file for input (raw format dir.des.scop.txt_X.XX file) (-infileb)

		outfile (OutFile)
			Name of scop file for output (embl-like format) (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::scopparse;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $scopparse = Bio::Tools::Run::PiseApplication::scopparse->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::scopparse object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $scopparse = $factory->program('scopparse');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::scopparse.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/scopparse.pm

    $self->{COMMAND}   = "scopparse";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SCOPPARSE";

    $self->{DESCRIPTION}   = "Reads raw scop classifications file and writes embl-like format scop classification file. (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "utils:database creation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/scopparse.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"scopparse",
	"init",
	"infilea",
	"infileb",
	"outfile",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"scopparse",
	"init",
	"infilea", 	# Name of scop classification file for input (raw format dir.cla.scop.txt_X.XX file) (-infilea)
	"infileb", 	# Name of description file for input (raw format dir.des.scop.txt_X.XX file) (-infileb)
	"outfile", 	# Name of scop file for output (embl-like format) (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"scopparse" => 'String',
	"init" => 'String',
	"infilea" => 'InFile',
	"infileb" => 'InFile',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"infilea" => {
		"perl" => '" -infilea=$value"',
	},
	"infileb" => {
		"perl" => '" -infileb=$value"',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"scopparse" => {
		"perl" => '"scopparse"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"infilea" => 1,
	"infileb" => 2,
	"outfile" => 3,
	"auto" => 4,
	"scopparse" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"scopparse",
	"infilea",
	"infileb",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"infilea" => 0,
	"infileb" => 0,
	"outfile" => 0,
	"auto" => 1,
	"scopparse" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"infilea" => 0,
	"infileb" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"infilea" => 1,
	"infileb" => 1,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"infilea" => "Name of scop classification file for input (raw format dir.cla.scop.txt_X.XX file) (-infilea)",
	"infileb" => "Name of description file for input (raw format dir.des.scop.txt_X.XX file) (-infileb)",
	"outfile" => "Name of scop file for output (embl-like format) (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"infilea" => 0,
	"infileb" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'Escop.dat',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"infilea" => { "perl" => '1' },
	"infileb" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

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
	"init" => 0,
	"infilea" => 0,
	"infileb" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"infilea" => 1,
	"infileb" => 1,
	"outfile" => 1,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/scopparse.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

