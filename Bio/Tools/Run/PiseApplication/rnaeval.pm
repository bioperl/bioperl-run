# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::rnaeval
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::rnaeval

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnaeval

      Bioperl class for:

	VIENNARNA	RNAeval - calculate energy of RNA sequences on given secondary structure (Hofacker, Stadler)

	References:

		I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/rnaeval.html 
         for available values):


		rnaeval (String)

		seqstruct (InFile)
			Sequences/Structures File (output of RNAfold)
			pipe: rnafold_struct

		temperature (Integer)
			Rescale energy parameters to a temperature of temp C. (-T)

		tetraloops (Switch)
			Do not include special stabilizing energies for certain tetraloops (-4)

		dangling (Switch)
			Don't give stabilizing energies to single stacked bases in dangling ends (-d)

		d2 (Switch)
			Treat dangling ends as in the partition function algorithm (-d2)

		logML (Switch)
			Let multiloop energies depend logarithmically on the size (-logML)

		parameter (InFile)
			Parameter file (-P)

		energy (Excl)
			Energy parameters for the artificial ABCD... alphabet (-e)

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

  http://bugzilla.open-bio.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/rnaeval.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::rnaeval;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnaeval = Bio::Tools::Run::PiseApplication::rnaeval->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnaeval object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $rnaeval = $factory->program('rnaeval');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnaeval.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnaeval.pm

    $self->{COMMAND}   = "rnaeval";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNAeval - calculate energy of RNA sequences on given secondary structure";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Hofacker, Stadler";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-na.html#VIENNARNA";

    $self->{REFERENCE}   = [

         "I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125: 167-188",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnaeval",
	"seqstruct",
	"others_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnaeval",
	"seqstruct", 	# Sequences/Structures File (output of RNAfold)
	"others_options", 	# Other options
	"temperature", 	# Rescale energy parameters to a temperature of temp C. (-T)
	"tetraloops", 	# Do not include special stabilizing energies for certain tetraloops (-4)
	"dangling", 	# Don't give stabilizing energies to single stacked bases in dangling ends (-d)
	"d2", 	# Treat dangling ends as in the partition function algorithm (-d2)
	"logML", 	# Let multiloop energies depend logarithmically on the size (-logML)
	"parameter", 	# Parameter file (-P)
	"energy", 	# Energy parameters for the artificial ABCD... alphabet (-e)

    ];

    $self->{TYPE}  = {
	"rnaeval" => 'String',
	"seqstruct" => 'InFile',
	"others_options" => 'Paragraph',
	"temperature" => 'Integer',
	"tetraloops" => 'Switch',
	"dangling" => 'Switch',
	"d2" => 'Switch',
	"logML" => 'Switch',
	"parameter" => 'InFile',
	"energy" => 'Excl',

    };

    $self->{FORMAT}  = {
	"rnaeval" => {
		"perl" => '"RNAeval"',
	},
	"seqstruct" => {
		"perl" => '" < $value" ',
	},
	"others_options" => {
	},
	"temperature" => {
		"perl" => '(defined $value && $value ne $vdef)? " -T $value" : ""',
	},
	"tetraloops" => {
		"perl" => '($value)? " -4" : ""',
	},
	"dangling" => {
		"perl" => '($value)? " -d" : ""',
	},
	"d2" => {
		"perl" => '($value)? " -d2" : ""',
	},
	"logML" => {
		"perl" => '($value)? " -logML" : ""',
	},
	"parameter" => {
		"perl" => '($value)? " -P $value" : ""',
	},
	"energy" => {
		"perl" => '($value)? " -e $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"rnaeval" => 0,
	"seqstruct" => 1000,
	"others_options" => 2,
	"temperature" => 2,
	"tetraloops" => 2,
	"dangling" => 2,
	"d2" => 2,
	"logML" => 2,
	"parameter" => 2,
	"energy" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"rnaeval",
	"energy",
	"others_options",
	"temperature",
	"tetraloops",
	"dangling",
	"d2",
	"logML",
	"parameter",
	"seqstruct",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnaeval" => 1,
	"seqstruct" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"d2" => 0,
	"logML" => 0,
	"parameter" => 0,
	"energy" => 0,

    };

    $self->{ISCOMMAND}  = {
	"rnaeval" => 1,
	"seqstruct" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"d2" => 0,
	"logML" => 0,
	"parameter" => 0,
	"energy" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnaeval" => 0,
	"seqstruct" => 1,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"d2" => 0,
	"logML" => 0,
	"parameter" => 0,
	"energy" => 0,

    };

    $self->{PROMPT}  = {
	"rnaeval" => "",
	"seqstruct" => "Sequences/Structures File (output of RNAfold)",
	"others_options" => "Other options",
	"temperature" => "Rescale energy parameters to a temperature of temp C. (-T)",
	"tetraloops" => "Do not include special stabilizing energies for certain tetraloops (-4)",
	"dangling" => "Don't give stabilizing energies to single stacked bases in dangling ends (-d)",
	"d2" => "Treat dangling ends as in the partition function algorithm (-d2)",
	"logML" => "Let multiloop energies depend logarithmically on the size (-logML)",
	"parameter" => "Parameter file (-P)",
	"energy" => "Energy parameters for the artificial ABCD... alphabet (-e)",

    };

    $self->{ISSTANDOUT}  = {
	"rnaeval" => 0,
	"seqstruct" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"d2" => 0,
	"logML" => 0,
	"parameter" => 0,
	"energy" => 0,

    };

    $self->{VLIST}  = {

	"others_options" => ['temperature','tetraloops','dangling','d2','logML','parameter','energy',],
	"energy" => ['1','1: use energy parameters for GC pairs','2','2: use energy parameters for AU pairs',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"rnaeval" => 'rnaeval',
	"temperature" => '37',
	"tetraloops" => '0',
	"dangling" => '0',
	"d2" => '0',
	"logML" => '0',

    };

    $self->{PRECOND}  = {
	"rnaeval" => { "perl" => '1' },
	"seqstruct" => { "perl" => '1' },
	"others_options" => { "perl" => '1' },
	"temperature" => { "perl" => '1' },
	"tetraloops" => { "perl" => '1' },
	"dangling" => { "perl" => '1' },
	"d2" => { "perl" => '1' },
	"logML" => { "perl" => '1' },
	"parameter" => { "perl" => '1' },
	"energy" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqstruct" => {
		 "rnafold_struct" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"rnaeval" => 0,
	"seqstruct" => 0,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"d2" => 0,
	"logML" => 0,
	"parameter" => 0,
	"energy" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnaeval" => 0,
	"seqstruct" => 1,
	"others_options" => 0,
	"temperature" => 0,
	"tetraloops" => 0,
	"dangling" => 0,
	"d2" => 0,
	"logML" => 0,
	"parameter" => 0,
	"energy" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"dangling" => [
		"Do not give stabilizing energies to unpaired bases adjacent to helices in multiloops and free ends (\'dangling ends\'). Same as -d0, opposite of -d1 (the default).",
	],
	"d2" => [
		"Treat dangling ends as in the partition function algorithm, i.e. bases adjacent to helices in multiloops and free ends give a stabilizing energy contribution, regardless whether they\'re paired or unpaired.",
	],
	"logML" => [
		"Let multiloop energies depend logarithmically on the size, instead of the usual linear energy function.",
	],
	"parameter" => [
		"Read energy parameters from paramfile, instead of using the default parameter set. A sample parameterfile should accompany your distribution. See the RNAlib documentation for details on the file format.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnaeval.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

