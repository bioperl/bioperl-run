
=head1 NAME

Bio::Tools::Run::PiseApplication::dssp

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dssp

      Bioperl class for:

	DSSP	Definition of secondary structure of proteins given a set of 3D coordinates (W.Kabsch, C. Sander)

	References:

		Kabsch,W. and Sander,C. (1983) Biopolymers 22, 2577-2637.


      Parameters:


		dssp (String)


		pdbfile (Sequence)
			PDB File

		pdbid (String)
			or you can instead enter a PDB id.

		output (Paragraph)
			Output parameters

		surface (Switch)
			Disables the calculation of accessible surface (-na)

		classic (Switch)
			Classic (pre-July 1995) format (-c)

		outfile (Results)

			pipe: dssp_outfile

=cut

#'
package Bio::Tools::Run::PiseApplication::dssp;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dssp = Bio::Tools::Run::PiseApplication::dssp->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dssp object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $dssp = $factory->program('dssp');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::dssp.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dssp.pm

    $self->{COMMAND}   = "dssp";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DSSP";

    $self->{DESCRIPTION}   = "Definition of secondary structure of proteins given a set of 3D coordinates";

    $self->{AUTHORS}   = "W.Kabsch, C. Sander";

    $self->{REFERENCE}   = [

         "Kabsch,W. and Sander,C. (1983) Biopolymers 22, 2577-2637.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dssp",
	"pdbfile",
	"pdbid",
	"output",
	"outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dssp",
	"pdbfile", 	# PDB File
	"pdbid", 	# or you can instead enter a PDB id.
	"output", 	# Output parameters
	"surface", 	# Disables the calculation of accessible surface (-na)
	"classic", 	# Classic (pre-July 1995) format (-c)
	"outfile",

    ];

    $self->{TYPE}  = {
	"dssp" => 'String',
	"pdbfile" => 'Sequence',
	"pdbid" => 'String',
	"output" => 'Paragraph',
	"surface" => 'Switch',
	"classic" => 'Switch',
	"outfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"dssp" => {
		"seqlab" => 'dssp',
		"perl" => '"dssp"',
	},
	"pdbfile" => {
		"perl" => '($pdbid)? " -- " : " $value"',
	},
	"pdbid" => {
		"perl" => '(($value =~ tr/A-Z/a-z/) || $value)? "pdbloc $value | xargs cat | " : "" ',
	},
	"output" => {
	},
	"surface" => {
		"perl" => ' ($value)? " -na" : "" ',
	},
	"classic" => {
		"perl" => ' ($value)? " -c" : "" ',
	},
	"outfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => '*.out',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"dssp" => 0,
	"pdbfile" => 10,
	"pdbid" => -10,
	"surface" => 1,
	"classic" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pdbid",
	"dssp",
	"outfile",
	"output",
	"classic",
	"surface",
	"pdbfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dssp" => 1,
	"pdbfile" => 0,
	"pdbid" => 0,
	"output" => 0,
	"surface" => 0,
	"classic" => 0,
	"outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"dssp" => 1,
	"pdbfile" => 0,
	"pdbid" => 0,
	"output" => 0,
	"surface" => 0,
	"classic" => 0,
	"outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"dssp" => 0,
	"pdbfile" => 0,
	"pdbid" => 0,
	"output" => 0,
	"surface" => 0,
	"classic" => 0,
	"outfile" => 0,

    };

    $self->{PROMPT}  = {
	"dssp" => "",
	"pdbfile" => "PDB File",
	"pdbid" => "or you can instead enter a PDB id.",
	"output" => "Output parameters",
	"surface" => "Disables the calculation of accessible surface (-na)",
	"classic" => "Classic (pre-July 1995) format (-c)",
	"outfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"dssp" => 0,
	"pdbfile" => 0,
	"pdbid" => 0,
	"output" => 0,
	"surface" => 0,
	"classic" => 0,
	"outfile" => 0,

    };

    $self->{VLIST}  = {

	"output" => ['surface','classic',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"surface" => '0',
	"classic" => '0',

    };

    $self->{PRECOND}  = {
	"dssp" => { "perl" => '1' },
	"pdbfile" => { "perl" => '1' },
	"pdbid" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"surface" => { "perl" => '1' },
	"classic" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"pdbfile" => {
		"perl" => {
			'! ($pdbid || $pdbfile)' => "You must enter either the PDB data or the PDB id",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "dssp_outfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"dssp" => 0,
	"pdbfile" => 0,
	"pdbid" => 0,
	"output" => 0,
	"surface" => 0,
	"classic" => 0,
	"outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"dssp" => 1,
	"pdbfile" => 1,
	"pdbid" => 1,
	"output" => 0,
	"surface" => 0,
	"classic" => 0,
	"outfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dssp.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

