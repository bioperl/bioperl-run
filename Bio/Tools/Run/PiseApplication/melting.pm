
=head1 NAME

Bio::Tools::Run::PiseApplication::melting

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::melting

      Bioperl class for:

	MELTING	enthalpie, entropy and melting temperature (N. Le Novere)

	References:

		Nicolas Le Novere (2001), MELTING, computing the melting temperature of nucleic acid duplex. Bioinformatics 17(12), 1226-1227


      Parameters:


		melting (String)
			

		hybridation_type (Excl)
			Hybridisation type (-H)

		nnfile (Excl)
			Nearest Neighbor parameters set (-A)

		sequence (String)
			Sequence string (-S)

		complement_string (String)
			Complementary sequence (-C)

		salt_concentratio (Float)
			Salt concentration (]0.0,10.0[ M) (-N)

		nucacid_concentration (Float)
			Nucleic acid concentration in excess (]0.0,0.1[ M) (-P)

		correction_factor (Float)
			Nucleic acid correction factor (-F)

		salt_correction (Excl)
			Salt correction (-K)

		approx (Switch)
			Force approximative temperature computation (-x)

		dangling ends (Switch)
			parameters for dangling ends: dnadnade.nn

		mismatches (Switch)
			nn parameters for mismatches: dnadnamm.nn

=cut

#'
package Bio::Tools::Run::PiseApplication::melting;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $melting = Bio::Tools::Run::PiseApplication::melting->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::melting object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $melting = $factory->program('melting');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::melting.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/melting.pm

    $self->{COMMAND}   = "melting";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MELTING";

    $self->{DESCRIPTION}   = "enthalpie, entropy and melting temperature";

    $self->{CATEGORIES}   =  [  

         "nucleic:composition",
  ];

    $self->{AUTHORS}   = "N. Le Novere";

    $self->{REFERENCE}   = [

         "Nicolas Le Novere (2001), MELTING, computing the melting temperature of nucleic acid duplex. Bioinformatics 17(12), 1226-1227",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"melting",
	"hybridation_type",
	"nnfile",
	"sequence",
	"complement_string",
	"salt_concentratio",
	"nucacid_concentration",
	"correction_factor",
	"salt_correction",
	"approx",
	"dangling ends",
	"mismatches",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"melting",
	"hybridation_type", 	# Hybridisation type (-H)
	"nnfile", 	# Nearest Neighbor parameters set (-A)
	"sequence", 	# Sequence string (-S)
	"complement_string", 	# Complementary sequence (-C)
	"salt_concentratio", 	# Salt concentration (]0.0,10.0[ M) (-N)
	"nucacid_concentration", 	# Nucleic acid concentration in excess (]0.0,0.1[ M) (-P)
	"correction_factor", 	# Nucleic acid correction factor (-F)
	"salt_correction", 	# Salt correction (-K)
	"approx", 	# Force approximative temperature computation (-x)
	"dangling ends",
	"mismatches", 	# nn parameters for mismatches: dnadnamm.nn

    ];

    $self->{TYPE}  = {
	"melting" => 'String',
	"hybridation_type" => 'Excl',
	"nnfile" => 'Excl',
	"sequence" => 'String',
	"complement_string" => 'String',
	"salt_concentratio" => 'Float',
	"nucacid_concentration" => 'Float',
	"correction_factor" => 'Float',
	"salt_correction" => 'Excl',
	"approx" => 'Switch',
	"dangling ends" => 'Switch',
	"mismatches" => 'Switch',

    };

    $self->{FORMAT}  = {
	"melting" => {
		"perl" => '"melting -q -v"',
	},
	"hybridation_type" => {
		"perl" => '" -H$value"',
	},
	"nnfile" => {
		"perl" => '($value && $value ne $vdef) ? " -A$value" : ""',
	},
	"sequence" => {
		"perl" => '" -S$value"',
	},
	"complement_string" => {
		"perl" => '$value ? " -C$value" : ""',
	},
	"salt_concentratio" => {
		"perl" => '" -N$value"',
	},
	"nucacid_concentration" => {
		"perl" => '$value ? " -P$value" : ""',
	},
	"correction_factor" => {
		"perl" => '$value ? " -F$value" : ""',
	},
	"salt_correction" => {
		"perl" => '$value ? " -K$value" : ""',
	},
	"approx" => {
		"perl" => '$value ? " -x" : ""',
	},
	"dangling ends" => {
		"perl" => '($value)? " -Ddnadnade.nn " : ""',
	},
	"mismatches" => {
		"perl" => '($value)? " -Mdnadnamm.nn " : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"melting" => 0,
	"hybridation_type" => 1,
	"nnfile" => 1,
	"sequence" => 1,
	"complement_string" => 1,
	"salt_concentratio" => 1,
	"nucacid_concentration" => 1,
	"correction_factor" => 1,
	"salt_correction" => 1,
	"approx" => 1,
	"dangling ends" => 1,
	"mismatches" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"melting",
	"hybridation_type",
	"nnfile",
	"sequence",
	"complement_string",
	"salt_concentratio",
	"nucacid_concentration",
	"correction_factor",
	"salt_correction",
	"approx",
	"dangling ends",
	"mismatches",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"melting" => 1,
	"hybridation_type" => 0,
	"nnfile" => 0,
	"sequence" => 0,
	"complement_string" => 0,
	"salt_concentratio" => 0,
	"nucacid_concentration" => 0,
	"correction_factor" => 0,
	"salt_correction" => 0,
	"approx" => 0,
	"dangling ends" => 0,
	"mismatches" => 0,

    };

    $self->{ISCOMMAND}  = {
	"melting" => 1,
	"hybridation_type" => 0,
	"nnfile" => 0,
	"sequence" => 0,
	"complement_string" => 0,
	"salt_concentratio" => 0,
	"nucacid_concentration" => 0,
	"correction_factor" => 0,
	"salt_correction" => 0,
	"approx" => 0,
	"dangling ends" => 0,
	"mismatches" => 0,

    };

    $self->{ISMANDATORY}  = {
	"melting" => 1,
	"hybridation_type" => 1,
	"nnfile" => 1,
	"sequence" => 1,
	"complement_string" => 0,
	"salt_concentratio" => 1,
	"nucacid_concentration" => 1,
	"correction_factor" => 0,
	"salt_correction" => 0,
	"approx" => 0,
	"dangling ends" => 0,
	"mismatches" => 0,

    };

    $self->{PROMPT}  = {
	"melting" => "",
	"hybridation_type" => "Hybridisation type (-H)",
	"nnfile" => "Nearest Neighbor parameters set (-A)",
	"sequence" => "Sequence string (-S)",
	"complement_string" => "Complementary sequence (-C)",
	"salt_concentratio" => "Salt concentration (]0.0,10.0[ M) (-N)",
	"nucacid_concentration" => "Nucleic acid concentration in excess (]0.0,0.1[ M) (-P)",
	"correction_factor" => "Nucleic acid correction factor (-F)",
	"salt_correction" => "Salt correction (-K)",
	"approx" => "Force approximative temperature computation (-x)",
	"dangling ends" => "parameters for dangling ends: dnadnade.nn",
	"mismatches" => "nn parameters for mismatches: dnadnamm.nn",

    };

    $self->{ISSTANDOUT}  = {
	"melting" => 0,
	"hybridation_type" => 0,
	"nnfile" => 0,
	"sequence" => 0,
	"complement_string" => 0,
	"salt_concentratio" => 0,
	"nucacid_concentration" => 0,
	"correction_factor" => 0,
	"salt_correction" => 0,
	"approx" => 0,
	"dangling ends" => 0,
	"mismatches" => 0,

    };

    $self->{VLIST}  = {

	"hybridation_type" => ['dnadna','Dna/Dna','dnarna','Dna/Rna','rnarna','Rna/Rna',],
	"nnfile" => ['default','(default)','all97a.nn','Allawi et al 1997','bre86a.nn','Breslauer et al 1986','fre86a.nn','Freier et al 1986','san96a.nn','SantaLucia et al 1996','sug95a.nn','Sugimoto et al 1995','sug96a.nn','Sugimoto et al 1996','xia98a.nn','Xia et al 1998',],
	"salt_correction" => ['wet91a','Wetmur 1991','san96a','SantaLucia et al. 1996','san98a','SantaLucia 1998',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"nnfile" => 'default',

    };

    $self->{PRECOND}  = {
	"melting" => { "perl" => '1' },
	"hybridation_type" => { "perl" => '1' },
	"nnfile" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"complement_string" => { "perl" => '1' },
	"salt_concentratio" => { "perl" => '1' },
	"nucacid_concentration" => { "perl" => '1' },
	"correction_factor" => { "perl" => '1' },
	"salt_correction" => { "perl" => '1' },
	"approx" => { "perl" => '1' },
	"dangling ends" => { "perl" => '1' },
	"mismatches" => { "perl" => '1' },

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
	"melting" => 0,
	"hybridation_type" => 0,
	"nnfile" => 0,
	"sequence" => 0,
	"complement_string" => 0,
	"salt_concentratio" => 0,
	"nucacid_concentration" => 0,
	"correction_factor" => 0,
	"salt_correction" => 0,
	"approx" => 0,
	"dangling ends" => 0,
	"mismatches" => 0,

    };

    $self->{ISSIMPLE}  = {
	"melting" => 0,
	"hybridation_type" => 1,
	"nnfile" => 1,
	"sequence" => 1,
	"complement_string" => 0,
	"salt_concentratio" => 1,
	"nucacid_concentration" => 1,
	"correction_factor" => 0,
	"salt_correction" => 0,
	"approx" => 0,
	"dangling ends" => 0,
	"mismatches" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/melting.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

