# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pam
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pam

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pam

      Bioperl class for:

	PAM	Generate a PAM matrix


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pam.html 
         for available values):


		pam (String)

		scale (Float)
			Scale 0. < scale <= 1000 (-s)

		x (Integer)
			Substitution value for X with any other letter (-x)

		distance (Integer)
			PAM distance (from 2 to 511)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/pam.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pam;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pam = Bio::Tools::Run::PiseApplication::pam->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pam object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pam = $factory->program('pam');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pam.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pam.pm

    $self->{COMMAND}   = "pam";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PAM";

    $self->{DESCRIPTION}   = "Generate a PAM matrix";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pam",
	"scale",
	"x",
	"distance",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pam",
	"scale", 	# Scale 0. < scale <= 1000 (-s)
	"x", 	# Substitution value for X with any other letter (-x)
	"distance", 	# PAM distance (from 2 to 511)

    ];

    $self->{TYPE}  = {
	"pam" => 'String',
	"scale" => 'Float',
	"x" => 'Integer',
	"distance" => 'Integer',

    };

    $self->{FORMAT}  = {
	"pam" => {
		"seqlab" => 'pam',
		"perl" => '"pam"',
	},
	"scale" => {
		"perl" => ' ($value)? " -s $value" : "" ',
	},
	"x" => {
		"perl" => ' ($value)? " -x $value" : "" ',
	},
	"distance" => {
		"perl" => ' ($value)? " $value" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"pam" => 0,
	"scale" => 1,
	"x" => 2,
	"distance" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pam",
	"scale",
	"x",
	"distance",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pam" => 1,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pam" => 1,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pam" => 0,
	"scale" => 0,
	"x" => 0,
	"distance" => 1,

    };

    $self->{PROMPT}  = {
	"pam" => "",
	"scale" => "Scale 0. < scale <= 1000 (-s)",
	"x" => "Substitution value for X with any other letter (-x)",
	"distance" => "PAM distance (from 2 to 511)",

    };

    $self->{ISSTANDOUT}  = {
	"pam" => 0,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

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
	"pam" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"x" => { "perl" => '1' },
	"distance" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"scale" => {
		"perl" => {
			'(defined $scale) && ($value <=0 || $value > 1000)' => "0 < scale <= 1000",
		},
	},
	"distance" => {
		"perl" => {
			'$value < 2 || $value > 511' => "2 <= pam distance <= 511",
		},
	},

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
	"pam" => 0,
	"scale" => 0,
	"x" => 0,
	"distance" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pam" => 1,
	"scale" => 0,
	"x" => 0,
	"distance" => 1,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"scale" => [
		"An optional floating-point scale for the log-odds matrix in the range 0 < scale <= 1000",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pam.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

