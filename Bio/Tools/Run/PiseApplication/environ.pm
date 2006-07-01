# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::environ
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::environ

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::environ

      Bioperl class for:

	environ	Calculates Energies Associated with Accessible as well as Buried Surface Areas in Proteins (P. Koehl, M. Delarue)

	References:

		P. Koehl and M. Delarue, Proteins 20:264-278 (1994)



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/environ.html 
         for available values):


		environ (String)

		pdbfile (InFile)
			PDB file
			pipe: pdbfile

		accessibility_per_residue_file (OutFile)

		accessibility_per_atom_file (OutFile)

		free_energy__file (OutFile)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://bioweb.pasteur.fr/seqanal/interfaces/environ.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::environ;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $environ = Bio::Tools::Run::PiseApplication::environ->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::environ object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $environ = $factory->program('environ');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::environ.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/environ.pm

    $self->{COMMAND}   = "environ";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "environ";

    $self->{DESCRIPTION}   = "Calculates Energies Associated with Accessible as well as Buried Surface Areas in Proteins";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "P. Koehl, M. Delarue";

    $self->{REFERENCE}   = [

         "P. Koehl and M. Delarue, Proteins 20:264-278 (1994)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"environ",
	"param",
	"pdbfile",
	"accessibility_per_residue_file",
	"accessibility_per_atom_file",
	"free_energy__file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"environ",
	"param",
	"pdbfile", 	# PDB file
	"accessibility_per_residue_file",
	"accessibility_per_atom_file",
	"free_energy__file",

    ];

    $self->{TYPE}  = {
	"environ" => 'String',
	"param" => 'Results',
	"pdbfile" => 'InFile',
	"accessibility_per_residue_file" => 'OutFile',
	"accessibility_per_atom_file" => 'OutFile',
	"free_energy__file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"environ" => {
		"perl" => ' "environ < params" ',
	},
	"param" => {
	},
	"pdbfile" => {
		"perl" => '"$value\\n"',
	},
	"accessibility_per_residue_file" => {
		"perl" => '"accessibility_per_residue\\n"',
	},
	"accessibility_per_atom_file" => {
		"perl" => '"accessibility_per_atom\\n"',
	},
	"free_energy__file" => {
		"perl" => '"free_energy\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"param" => 'params accessibility_per_residue accessibility_per_atom free_energy',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"environ" => 0,
	"pdbfile" => 1,
	"accessibility_per_residue_file" => 2,
	"accessibility_per_atom_file" => 3,
	"free_energy__file" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"environ",
	"param",
	"pdbfile",
	"accessibility_per_residue_file",
	"accessibility_per_atom_file",
	"free_energy__file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"environ" => 1,
	"param" => 0,
	"pdbfile" => 0,
	"accessibility_per_residue_file" => 1,
	"accessibility_per_atom_file" => 1,
	"free_energy__file" => 1,

    };

    $self->{ISCOMMAND}  = {
	"environ" => 1,
	"param" => 0,
	"pdbfile" => 0,
	"accessibility_per_residue_file" => 0,
	"accessibility_per_atom_file" => 0,
	"free_energy__file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"environ" => 0,
	"param" => 0,
	"pdbfile" => 1,
	"accessibility_per_residue_file" => 0,
	"accessibility_per_atom_file" => 0,
	"free_energy__file" => 0,

    };

    $self->{PROMPT}  = {
	"environ" => "",
	"param" => "",
	"pdbfile" => "PDB file",
	"accessibility_per_residue_file" => "",
	"accessibility_per_atom_file" => "",
	"free_energy__file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"environ" => 0,
	"param" => 0,
	"pdbfile" => 0,
	"accessibility_per_residue_file" => 0,
	"accessibility_per_atom_file" => 0,
	"free_energy__file" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"environ" => { "perl" => '1' },
	"param" => { "perl" => '1' },
	"pdbfile" => { "perl" => '1' },
	"accessibility_per_residue_file" => { "perl" => '1' },
	"accessibility_per_atom_file" => { "perl" => '1' },
	"free_energy__file" => { "perl" => '1' },

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
	"environ" => 0,
	"param" => 0,
	"pdbfile" => 0,
	"accessibility_per_residue_file" => 0,
	"accessibility_per_atom_file" => 0,
	"free_energy__file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"environ" => 0,
	"param" => 0,
	"pdbfile" => 1,
	"accessibility_per_residue_file" => 0,
	"accessibility_per_atom_file" => 0,
	"free_energy__file" => 0,

    };

    $self->{PARAMFILE}  = {
	"pdbfile" => "params",
	"accessibility_per_residue_file" => "params",
	"accessibility_per_atom_file" => "params",
	"free_energy__file" => "params",

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/environ.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

