
=head1 NAME

Bio::Tools::Run::PiseApplication::decorate

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::decorate

      Bioperl class for:

	decorate	Side chain packing optimization of a new sequence on a given template main chain. (P. Koehl, M. Delarue)

	References:

		P. Koehl et M. Delarue. J. Mol. Biol. 239:249-275 (1994)


      Parameters:


		decorate (String)


		result_files (Results)


		pdb_file (Results)


		pdbfile (InFile)
			PDB data for the template backbone
			pipe: pdbfile

		alignment (Sequence)
			Pairwise sequence alignment of template and model (MSF format required) PLEASE GIVE THE ALIGNEMENT IN THIS ORDER !  PDB Seq.(#1) vs Target Seq. (#2)
			pipe: readseq_ok_alig

		generic_name (String)
			Generic name of output files

		cycles (Integer)
			Total number of cycles you want to perform

		lambda (Float)
			Lambda factor for convergence

=cut

#'
package Bio::Tools::Run::PiseApplication::decorate;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $decorate = Bio::Tools::Run::PiseApplication::decorate->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::decorate object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $decorate = $factory->program('decorate');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::decorate.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/decorate.pm

    $self->{COMMAND}   = "decorate";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "decorate";

    $self->{DESCRIPTION}   = "Side chain packing optimization of a new sequence on a given template main chain.";

    $self->{AUTHORS}   = "P. Koehl, M. Delarue";

    $self->{REFERENCE}   = [

         "P. Koehl et M. Delarue. J. Mol. Biol. 239:249-275 (1994)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"decorate",
	"result_files",
	"pdb_file",
	"pdbfile",
	"alignment",
	"generic_name",
	"cycles",
	"lambda",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"decorate",
	"result_files",
	"pdb_file",
	"pdbfile", 	# PDB data for the template backbone
	"alignment", 	# Pairwise sequence alignment of template and model (MSF format required) PLEASE GIVE THE ALIGNEMENT IN THIS ORDER !  PDB Seq.(#1) vs Target Seq. (#2)
	"generic_name", 	# Generic name of output files
	"cycles", 	# Total number of cycles you want to perform
	"lambda", 	# Lambda factor for convergence

    ];

    $self->{TYPE}  = {
	"decorate" => 'String',
	"result_files" => 'Results',
	"pdb_file" => 'Results',
	"pdbfile" => 'InFile',
	"alignment" => 'Sequence',
	"generic_name" => 'String',
	"cycles" => 'Integer',
	"lambda" => 'Float',

    };

    $self->{FORMAT}  = {
	"decorate" => {
		"perl" => ' "decorate < params" ',
	},
	"result_files" => {
	},
	"pdb_file" => {
	},
	"pdbfile" => {
		"perl" => '"$value\\n"',
	},
	"alignment" => {
		"perl" => '"$value\\n"',
	},
	"generic_name" => {
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
	"result_files" => 'params *.proba *.log model*',
	"pdb_file" => '*.pdb',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"decorate" => 0,
	"pdbfile" => 1,
	"alignment" => 2,
	"generic_name" => 3,
	"cycles" => 4,
	"lambda" => 5,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"decorate",
	"result_files",
	"pdb_file",
	"pdbfile",
	"alignment",
	"generic_name",
	"cycles",
	"lambda",

    ];

    $self->{SIZE}  = {
	"generic_name" => 20,

    };

    $self->{ISHIDDEN}  = {
	"decorate" => 1,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"alignment" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{ISCOMMAND}  = {
	"decorate" => 1,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"alignment" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{ISMANDATORY}  = {
	"decorate" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 1,
	"alignment" => 1,
	"generic_name" => 1,
	"cycles" => 1,
	"lambda" => 1,

    };

    $self->{PROMPT}  = {
	"decorate" => "",
	"result_files" => "",
	"pdb_file" => "",
	"pdbfile" => "PDB data for the template backbone",
	"alignment" => "Pairwise sequence alignment of template and model (MSF format required) PLEASE GIVE THE ALIGNEMENT IN THIS ORDER !  PDB Seq.(#1) vs Target Seq. (#2)",
	"generic_name" => "Generic name of output files",
	"cycles" => "Total number of cycles you want to perform",
	"lambda" => "Lambda factor for convergence",

    };

    $self->{ISSTANDOUT}  = {
	"decorate" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"alignment" => 0,
	"generic_name" => 0,
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
	"generic_name" => 'model',
	"cycles" => '20',
	"lambda" => '0.5',

    };

    $self->{PRECOND}  = {
	"decorate" => { "perl" => '1' },
	"result_files" => { "perl" => '1' },
	"pdb_file" => { "perl" => '1' },
	"pdbfile" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"generic_name" => { "perl" => '1' },
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
	"decorate" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 0,
	"alignment" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{ISSIMPLE}  = {
	"decorate" => 0,
	"result_files" => 0,
	"pdb_file" => 0,
	"pdbfile" => 1,
	"alignment" => 1,
	"generic_name" => 1,
	"cycles" => 0,
	"lambda" => 0,

    };

    $self->{PARAMFILE}  = {
	"pdbfile" => "params",
	"alignment" => "params",
	"generic_name" => "params",
	"cycles" => "params",
	"lambda" => "params",

    };

    $self->{COMMENT}  = {
	"pdbfile" => [
		"PDB data for the template backbone.",
	],
	"alignment" => [
		"The template correspond to the molecule described in the PDB data, the model is the molecule whose structure is to be be computed.",
		"You MUST provide an alignment in this order:",
		"1st sequence: PDB template",
		"2nd sequence: protein to model",
	],
	"generic_name" => [
		"The program will generate, for the last cycle of the iteration, files of the type:",
		"check.pdb",
		"generic_name.log",
		"where generic_name is the name chosen by the user. The first file contains the coords of the last iteration cycle, the second one an estimate of the entropy (disorder) for each iteration cycle, from which an estimate of the entropy gained upon folding for each residue can easily be calculated.",
	],
	"cycles" => [
		"20 or 30 should be enough most of the time.",
	],
	"lambda" => [
		"Enter a number between 0.4 or 0.6",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/decorate.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

