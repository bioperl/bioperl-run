
=head1 NAME

Bio::Tools::Run::PiseApplication::homology

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::homology

      Bioperl class for:

	homology	SCMF Homology Modelling Program (P. Koehl, M. Delarue)

	References:

		P. Koehl and M. Delarue. Nature Structural Biology. 2:163-169 (1995). 


      Parameters:


		homology (String)
			

		result_files (Results)
			

		pdb_file (Results)
			

		pdbfile (InFile)
			PDB data for the template protein
			pipe: pdbfile

		model_name (String)
			Name of the model protein to be built

		alignment (Sequence)
			Pairwise sequence alignment of template and model (MSF format preferred)
			pipe: readseq_ok_alig

		cycles (Float)
			Total number of cycles for SCMF refinement

		lambda (Float)
			Lambda for SCMF updates

=cut

#'
package Bio::Tools::Run::PiseApplication::homology;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $homology = Bio::Tools::Run::PiseApplication::homology->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::homology object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $homology = $factory->program('homology');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::homology.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/homology.pm

    $self->{COMMAND}   = "homology";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "homology";

    $self->{DESCRIPTION}   = "SCMF Homology Modelling Program";

    $self->{AUTHORS}   = "P. Koehl, M. Delarue";

    $self->{REFERENCE}   = [

         "P. Koehl and M. Delarue. Nature Structural Biology. 2:163-169 (1995). ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"homology",
	"result_files",
	"pdb_file",
	"pdbfile",
	"model_name",
	"alignment",
	"cycles",
	"lambda",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"homology",
	"result_files",
	"pdb_file",
	"pdbfile", 	# PDB data for the template protein
	"model_name", 	# Name of the model protein to be built
	"alignment", 	# Pairwise sequence alignment of template and model (MSF format preferred)
	"cycles", 	# Total number of cycles for SCMF refinement
	"lambda", 	# Lambda for SCMF updates

    ];

    $self->{TYPE}  = {
	"homology" => 'String',
	"result_files" => 'Results',
	"pdb_file" => 'Results',
	"pdbfile" => 'InFile',
	"model_name" => 'String',
	"alignment" => 'Sequence',
	"cycles" => 'Float',
	"lambda" => 'Float',

    };

    $self->{FORMAT}  = {
	"homology" => {
		"perl" => ' "homology.perl < params" ',
	},
	"result_files" => {
	},
	"pdb_file" => {
	},
	"pdbfile" => {
		"perl" => '"$value\\n"',
	},
	"model_name" => {
		"perl" => '"$value\\n"',
	},
	"alignment" => {
		"perl" => '"$value\\n"',
	},
	"cycles" => {
		"perl" => '"$value\\n"',
	},
	"lambda" => {
		"perl" => '"$value\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"result_files" => 'params *.info *.proba *.frame *.log model*',
	"pdb_file" => '*.pdb',

    };

    $self->{SEQFMT}  = {
	"alignment" => [15],

    };

    $self->{GROUP}  = {
	"homology" => 0,
	"pdbfile" => 1,
	"model_name" => 2,
	"alignment" => 3,
	"cycles" => 5,
	"lambda" => 6,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"homology",
	"result_files",
	"pdb_file",
	"pdbfile",
	"model_name",
	"alignment",
	"cycles",
	"lambda",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"homology" => 1,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"model_name" => 0,
	"alignment" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{ISCOMMAND}  = {
	"homology" => 1,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"model_name" => 0,
	"alignment" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{ISMANDATORY}  = {
	"homology" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 1,
	"model_name" => 1,
	"alignment" => 1,
	"cycles" => 1,
	"lambda" => 1,

    };

    $self->{PROMPT}  = {
	"homology" => "",
	"result_files" => "",
	"pdb_file" => "",
	"pdbfile" => "PDB data for the template protein",
	"model_name" => "Name of the model protein to be built",
	"alignment" => "Pairwise sequence alignment of template and model (MSF format preferred)",
	"cycles" => "Total number of cycles for SCMF refinement",
	"lambda" => "Lambda for SCMF updates",

    };

    $self->{ISSTANDOUT}  = {
	"homology" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"model_name" => 0,
	"alignment" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"model_name" => 'model',
	"cycles" => '30',
	"lambda" => '0.1',

    };

    $self->{PRECOND}  = {
	"homology" => { "perl" => '1' },
	"result_files" => { "perl" => '1' },
	"pdb_file" => { "perl" => '1' },
	"pdbfile" => { "perl" => '1' },
	"model_name" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"cycles" => { "perl" => '1' },
	"lambda" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"pdbfile" => {
		 "pdbfile" => '1',
	},
	"alignment" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"homology" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"model_name" => 0,
	"alignment" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{ISSIMPLE}  = {
	"homology" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 1,
	"model_name" => 1,
	"alignment" => 1,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{PARAMFILE}  = {
	"pdbfile" => "params",
	"model_name" => "params",
	"alignment" => "params",
	"cycles" => "params",
	"lambda" => "params",

    };

    $self->{COMMENT}  = {
	"model_name" => [
		"The file named MODEL.pdb will contain the model protein coordinates (where MODEL is the chosen name of the model).",
	],
	"alignment" => [
		"The template correspond to the molecule described in the PDB data, the model is the molecule whose structure is to be be computed.",
		"You must provide an alignment in this order:",
		"1st sequence: template",
		"2nd sequence: protein to model",
	],
	"cycles" => [
		"30 or 40 should be enough most of the time.",
	],
	"lambda" => [
		"Enter 0.1 or 0.2",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/homology.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

