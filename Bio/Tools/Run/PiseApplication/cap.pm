# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::cap
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::cap

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cap

      Bioperl class for:

	CAP	Contig Assembly Program


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/cap.html 
         for available values):


		cap (String)

		seq (Sequence)
			Fragments File
			pipe: seqsfile

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

http://bioweb.pasteur.fr/seqanal/interfaces/cap.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::cap;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cap = Bio::Tools::Run::PiseApplication::cap->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cap object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $cap = $factory->program('cap');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::cap.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cap.pm

    $self->{COMMAND}   = "cap";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CAP";

    $self->{DESCRIPTION}   = "Contig Assembly Program";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cap",
	"seq",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cap",
	"seq", 	# Fragments File

    ];

    $self->{TYPE}  = {
	"cap" => 'String',
	"seq" => 'Sequence',

    };

    $self->{FORMAT}  = {
	"cap" => {
		"seqlab" => 'cap',
		"perl" => '"cap"',
	},
	"seq" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"cap" => 0,
	"seq" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"cap",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"cap" => 1,
	"seq" => 0,

    };

    $self->{ISCOMMAND}  = {
	"cap" => 1,
	"seq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"cap" => 0,
	"seq" => 1,

    };

    $self->{PROMPT}  = {
	"cap" => "",
	"seq" => "Fragments File",

    };

    $self->{ISSTANDOUT}  = {
	"cap" => 0,
	"seq" => 0,

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
	"cap" => { "perl" => '1' },
	"seq" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"cap" => 0,
	"seq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"cap" => 1,
	"seq" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cap.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

