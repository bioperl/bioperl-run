
=head1 NAME

Bio::Tools::Run::PiseApplication::confmat

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::confmat

      Bioperl class for:

	confmat	Side chain packing optimization on a given main chain template for protein PDB files (P. Koehl, M. Delarue)

	References:

		P. Koehl et M. Delarue. J. Mol. Biol. 239:249-275 (1994)


      Parameters:


		confmat (String)
			

		result_files (Results)
			

		pdbfile (InFile)
			PDB file
			pipe: pdbfile

		bridge_file (InFile)
			Disulphide bridges file

		generic_name (String)
			Generic name of output files

		cycles (Integer)
			Number of cycles you want to perform

		logfile (OutFile)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::confmat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $confmat = Bio::Tools::Run::PiseApplication::confmat->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::confmat object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $confmat = $factory->program('confmat');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::confmat.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/confmat.pm

    $self->{COMMAND}   = "confmat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "confmat";

    $self->{DESCRIPTION}   = "Side chain packing optimization on a given main chain template for protein PDB files";

    $self->{AUTHORS}   = "P. Koehl, M. Delarue";

    $self->{REFERENCE}   = [

         "P. Koehl et M. Delarue. J. Mol. Biol. 239:249-275 (1994)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"confmat",
	"result_files",
	"pdbfile",
	"bridge_file",
	"generic_name",
	"cycles",
	"logfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"confmat",
	"result_files",
	"pdbfile", 	# PDB file
	"bridge_file", 	# Disulphide bridges file
	"generic_name", 	# Generic name of output files
	"cycles", 	# Number of cycles you want to perform
	"logfile",

    ];

    $self->{TYPE}  = {
	"confmat" => 'String',
	"result_files" => 'Results',
	"pdbfile" => 'InFile',
	"bridge_file" => 'InFile',
	"generic_name" => 'String',
	"cycles" => 'Integer',
	"logfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"confmat" => {
		"perl" => ' "confmat < params" ',
	},
	"result_files" => {
	},
	"pdbfile" => {
		"perl" => '"$value\\n"',
	},
	"bridge_file" => {
		"perl" => '($value)? "$value\\n" : "\\n" ',
	},
	"generic_name" => {
		"perl" => '"$value\\n"',
	},
	"cycles" => {
		"perl" => '"$value\\n"',
	},
	"logfile" => {
		"perl" => '"logfile\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"result_files" => 'params logfile $generic_name*',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"confmat" => 0,
	"pdbfile" => 1,
	"bridge_file" => 2,
	"generic_name" => 3,
	"cycles" => 4,
	"logfile" => 5,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"confmat",
	"result_files",
	"pdbfile",
	"bridge_file",
	"generic_name",
	"cycles",
	"logfile",

    ];

    $self->{SIZE}  = {
	"generic_name" => 20,

    };

    $self->{ISHIDDEN}  = {
	"confmat" => 1,
	"result_files" => 0,
	"pdbfile" => 0,
	"bridge_file" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"logfile" => 1,

    };

    $self->{ISCOMMAND}  = {
	"confmat" => 1,
	"result_files" => 0,
	"pdbfile" => 0,
	"bridge_file" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"logfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"confmat" => 0,
	"result_files" => 0,
	"pdbfile" => 1,
	"bridge_file" => 0,
	"generic_name" => 1,
	"cycles" => 1,
	"logfile" => 0,

    };

    $self->{PROMPT}  = {
	"confmat" => "",
	"result_files" => "",
	"pdbfile" => "PDB file",
	"bridge_file" => "Disulphide bridges file",
	"generic_name" => "Generic name of output files",
	"cycles" => "Number of cycles you want to perform",
	"logfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"confmat" => 0,
	"result_files" => 0,
	"pdbfile" => 0,
	"bridge_file" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"logfile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"generic_name" => 'result',
	"cycles" => '20',

    };

    $self->{PRECOND}  = {
	"confmat" => { "perl" => '1' },
	"result_files" => { "perl" => '1' },
	"pdbfile" => { "perl" => '1' },
	"bridge_file" => { "perl" => '1' },
	"generic_name" => { "perl" => '1' },
	"cycles" => { "perl" => '1' },
	"logfile" => { "perl" => '1' },

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

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"confmat" => 0,
	"result_files" => 0,
	"pdbfile" => 0,
	"bridge_file" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"logfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"confmat" => 0,
	"result_files" => 0,
	"pdbfile" => 1,
	"bridge_file" => 0,
	"generic_name" => 0,
	"cycles" => 0,
	"logfile" => 0,

    };

    $self->{PARAMFILE}  = {
	"pdbfile" => "params",
	"bridge_file" => "params",
	"generic_name" => "params",
	"cycles" => "params",
	"logfile" => "params",

    };

    $self->{COMMENT}  = {
	"pdbfile" => [
		"The programm will read all coords, extract the sequence from the PDB file, forget about the side chains and reconstruct them according to the mean-field algorithm.",
	],
	"bridge_file" => [
		"This file should contain all known S-S bridges, one per line, in the format :",
		"SSBOND i j",
		"where i is the number of the first residue involved in the disulphide bridge and j its partner (Again, beware that i and j corresponds to the internal numbering, not the numbering used in the pdb file. Personally I reformatthe pdb file before running CONFMAT).",
		"The number of space between SSBOND and i and j are not important, however it is important that SSBOND be in upper case.",
	],
	"generic_name" => [
		"The program will generate, for each cycle of the iteration, files of the type:",
		"generic_nameN.pdb",
		"generic_nameN.proba",
		"generic_nameN.ent",
		"where generic_name is the name chosen by the user and N is the cycle number. The first file contains the coords in the current iteration cycle, the second one the probability matrix for each rotamer of each position and the third one an estimate of the entropy (disorder) of each residue, from which an estimate of the entropy gained upon folding for each residue can easily be calculated.",
		"The most important files to look at are the ones of the last iteration cycle (usually 20). The CONVERGENCE of the algorithm is monitored in the log file called logfile.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/confmat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

