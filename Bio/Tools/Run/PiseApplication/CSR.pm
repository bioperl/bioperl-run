
=head1 NAME

Bio::Tools::Run::PiseApplication::CSR

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::CSR

      Bioperl class for:

	CSR	Maximal Common 3D Substructure Searching (M.Petitjean)

	References:

		M.Petitjean, Interactive Maximal Common 3D Substructure Searching with the Combined SDM/RMS Algorithm. Comput.Chem.1998,22[6],pp.463-465. 


      Parameters:


		CSR (String)
			

		param (Results)
			

		endparams (String)
			

		pdbfile (InFile)
			File containing both molecules
			pipe: pdbfile

		file_format (Excl)
			Input file format

		imol1 (Integer)
			Position of the 1st molecule in the file (IMOL1)

		imol2 (Integer)
			Position of the 2d molecule in the file (IMOL2)

		itermx (Integer)
			How many iterations (ITERMX)

		cutoff (Excl)
			Cutoff distance (CUT-OFF DIST)

		substructure (OutFile)
			

		pdb_outfile (Results)
			
			pipe: pdbfile

=cut

#'
package Bio::Tools::Run::PiseApplication::CSR;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $CSR = Bio::Tools::Run::PiseApplication::CSR->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::CSR object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $CSR = $factory->program('CSR');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::CSR.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/CSR.pm

    $self->{COMMAND}   = "CSR";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CSR";

    $self->{DESCRIPTION}   = "Maximal Common 3D Substructure Searching";

    $self->{AUTHORS}   = "M.Petitjean";

    $self->{REFERENCE}   = [

         "M.Petitjean, Interactive Maximal Common 3D Substructure Searching with the Combined SDM/RMS Algorithm. Comput.Chem.1998,22[6],pp.463-465. ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"CSR",
	"param",
	"endparams",
	"pdbfile",
	"file_format",
	"imol1",
	"imol2",
	"itermx",
	"cutoff",
	"substructure",
	"pdb_outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"CSR",
	"param",
	"endparams",
	"pdbfile", 	# File containing both molecules
	"file_format", 	# Input file format
	"imol1", 	# Position of the 1st molecule in the file (IMOL1)
	"imol2", 	# Position of the 2d molecule in the file (IMOL2)
	"itermx", 	# How many iterations (ITERMX)
	"cutoff", 	# Cutoff distance (CUT-OFF DIST)
	"substructure",
	"pdb_outfile",

    ];

    $self->{TYPE}  = {
	"CSR" => 'String',
	"param" => 'Results',
	"endparams" => 'String',
	"pdbfile" => 'InFile',
	"file_format" => 'Excl',
	"imol1" => 'Integer',
	"imol2" => 'Integer',
	"itermx" => 'Integer',
	"cutoff" => 'Excl',
	"substructure" => 'OutFile',
	"pdb_outfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"CSR" => {
		"perl" => ' "CSR < params" ',
	},
	"param" => {
	},
	"endparams" => {
		"perl" => '"\\n\\n"',
	},
	"pdbfile" => {
		"perl" => '"$value\\n"',
	},
	"file_format" => {
		"perl" => '"$value\\n"',
	},
	"imol1" => {
		"perl" => '"$value"',
	},
	"imol2" => {
		"perl" => '" $value"',
	},
	"itermx" => {
		"perl" => '" $value"',
	},
	"cutoff" => {
		"perl" => '" $value\\n"',
	},
	"substructure" => {
		"perl" => '"new_mol2.coord\\n"',
	},
	"pdb_outfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"param" => 'params',
	"pdb_outfile" => 'new_mol2.coord',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"CSR" => 0,
	"endparams" => 10,
	"pdbfile" => 2,
	"file_format" => 1,
	"imol1" => 4,
	"imol2" => 5,
	"itermx" => 6,
	"cutoff" => 7,
	"substructure" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"CSR",
	"param",
	"pdb_outfile",
	"file_format",
	"pdbfile",
	"substructure",
	"imol1",
	"imol2",
	"itermx",
	"cutoff",
	"endparams",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"CSR" => 1,
	"param" => 0,
	"endparams" => 1,
	"pdbfile" => 0,
	"file_format" => 0,
	"imol1" => 0,
	"imol2" => 0,
	"itermx" => 0,
	"cutoff" => 0,
	"substructure" => 1,
	"pdb_outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"CSR" => 1,
	"param" => 0,
	"endparams" => 0,
	"pdbfile" => 0,
	"file_format" => 0,
	"imol1" => 0,
	"imol2" => 0,
	"itermx" => 0,
	"cutoff" => 0,
	"substructure" => 0,
	"pdb_outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"CSR" => 0,
	"param" => 0,
	"endparams" => 0,
	"pdbfile" => 1,
	"file_format" => 1,
	"imol1" => 1,
	"imol2" => 1,
	"itermx" => 1,
	"cutoff" => 1,
	"substructure" => 1,
	"pdb_outfile" => 0,

    };

    $self->{PROMPT}  = {
	"CSR" => "",
	"param" => "",
	"endparams" => "",
	"pdbfile" => "File containing both molecules",
	"file_format" => "Input file format",
	"imol1" => "Position of the 1st molecule in the file (IMOL1)",
	"imol2" => "Position of the 2d molecule in the file (IMOL2)",
	"itermx" => "How many iterations (ITERMX)",
	"cutoff" => "Cutoff distance (CUT-OFF DIST)",
	"substructure" => "",
	"pdb_outfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"CSR" => 0,
	"param" => 0,
	"endparams" => 0,
	"pdbfile" => 0,
	"file_format" => 0,
	"imol1" => 0,
	"imol2" => 0,
	"itermx" => 0,
	"cutoff" => 0,
	"substructure" => 0,
	"pdb_outfile" => 0,

    };

    $self->{VLIST}  = {

	"file_format" => ['HIN','HIN: alchemy-type','MDL','MDL: Cambridge Crystallographic Model','ML2','ML2: Mol2 SYBYL','PDB','PDB: Protein Data Bank or Nucleic Acid Data Bank','BIO','BIO: Biosym (MSI)',],
	"cutoff" => ['1.2','1.2: for a protein','2','2: for an inorganic molecule','5','5: for a C-alpha backbone.',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"file_format" => 'PDB',
	"imol1" => '1',
	"imol2" => '2',
	"itermx" => '200',
	"cutoff" => '1.2',
	"substructure" => 'new_mol2.coord',

    };

    $self->{PRECOND}  = {
	"CSR" => { "perl" => '1' },
	"param" => { "perl" => '1' },
	"endparams" => { "perl" => '1' },
	"pdbfile" => { "perl" => '1' },
	"file_format" => { "perl" => '1' },
	"imol1" => { "perl" => '1' },
	"imol2" => { "perl" => '1' },
	"itermx" => { "perl" => '1' },
	"cutoff" => { "perl" => '1' },
	"substructure" => { "perl" => '1' },
	"pdb_outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"pdb_outfile" => {
		 '1' => "pdbfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"pdbfile" => {
		 "pdbfile" => '$file_format eq "PDB"',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"CSR" => 0,
	"param" => 0,
	"endparams" => 0,
	"pdbfile" => 0,
	"file_format" => 0,
	"imol1" => 0,
	"imol2" => 0,
	"itermx" => 0,
	"cutoff" => 0,
	"substructure" => 0,
	"pdb_outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"CSR" => 0,
	"param" => 0,
	"endparams" => 0,
	"pdbfile" => 1,
	"file_format" => 1,
	"imol1" => 1,
	"imol2" => 1,
	"itermx" => 1,
	"cutoff" => 0,
	"substructure" => 0,
	"pdb_outfile" => 0,

    };

    $self->{PARAMFILE}  = {
	"endparams" => "params",
	"pdbfile" => "params",
	"file_format" => "params",
	"imol1" => "params",
	"imol2" => "params",
	"itermx" => "params",
	"cutoff" => "params",
	"substructure" => "params",

    };

    $self->{COMMENT}  = {
	"pdbfile" => [
		"This file must contain BOTH molecules.",
		"See below the position parameters of each molecules.",
	],
	"itermx" => [
		"About 200 for a small molecule of less than 100 atoms, about 2000 for less than 1000 atoms, 20000 for more than 1000 atoms",
	],
	"cutoff" => [
		"This parameter does not change the results, it just saves memory and space.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/CSR.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

