
=head1 NAME

Bio::Tools::Run::PiseApplication::hmmfetch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmfetch

      Bioperl class for:

	HMMER	hmmfetch - retrieve an HMM from an HMM database (S. Eddy)

      Parameters:


		description (Paragraph)
			Description of hmmfetch

		toto (String)


		hmmfetch (String)


		name (String)
			name of the HMM

		HMMDB (Excl)
			HMM database

		hmmfile (Results)

			pipe: hmmer_HMM

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmfetch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmfetch = Bio::Tools::Run::PiseApplication::hmmfetch->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmfetch object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $hmmfetch = $factory->program('hmmfetch');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmfetch.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmfetch.pm

    $self->{COMMAND}   = "hmmfetch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmfetch - retrieve an HMM from an HMM database";

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"description",
	"hmmfetch",
	"name",
	"HMMDB",
	"hmmfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"description", 	# Description of hmmfetch
	"toto",
	"hmmfetch",
	"name", 	# name of the HMM
	"HMMDB", 	# HMM database
	"hmmfile",

    ];

    $self->{TYPE}  = {
	"description" => 'Paragraph',
	"toto" => 'String',
	"hmmfetch" => 'String',
	"name" => 'String',
	"HMMDB" => 'Excl',
	"hmmfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"hmmfetch" => {
		"perl" => '"hmmfetch"',
	},
	"name" => {
		"perl" => '" $value"',
	},
	"HMMDB" => {
		"perl" => '" $value"',
	},
	"hmmfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"hmmfile" => '"hmmfetch.out"',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"toto" => 1000,
	"hmmfetch" => 0,
	"name" => 2,
	"HMMDB" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"description",
	"hmmfetch",
	"hmmfile",
	"HMMDB",
	"name",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"description" => 0,
	"toto" => 1,
	"hmmfetch" => 1,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 1,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 1,
	"HMMDB" => 1,
	"hmmfile" => 0,

    };

    $self->{PROMPT}  = {
	"description" => "Description of hmmfetch",
	"toto" => "",
	"hmmfetch" => "",
	"name" => "name of the HMM",
	"HMMDB" => "HMM database",
	"hmmfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
	"HMMDB" => ['Pfam','Pfam','PfamFrag','PfamFrag',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"HMMDB" => 'Pfam',

    };

    $self->{PRECOND}  = {
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"hmmfetch" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"HMMDB" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"hmmfile" => {
		 '1' => "hmmer_HMM",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmfetch is a small utility that retrieves an HMM from a HMMER model database in a new format, and prints that model to standard output. The retrieved HMM file is written in HMMER 2 ASCII format.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmfetch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

