# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::gruppi
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::gruppi

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::gruppi

      Bioperl class for:

	gruppi	clusters of binding sites (M. Pontoglio)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/gruppi.html 
         for available values):


		gruppi (String)

		seq (Sequence)
			Sequence File

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

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

http://bioweb.pasteur.fr/seqanal/interfaces/gruppi.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::gruppi;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $gruppi = Bio::Tools::Run::PiseApplication::gruppi->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::gruppi object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $gruppi = $factory->program('gruppi');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::gruppi.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gruppi.pm

    $self->{COMMAND}   = "gruppi";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "gruppi";

    $self->{DESCRIPTION}   = "clusters of binding sites";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "M. Pontoglio";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"gruppi",
	"seq",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"gruppi",
	"seq", 	# Sequence File

    ];

    $self->{TYPE}  = {
	"gruppi" => 'String',
	"seq" => 'Sequence',

    };

    $self->{FORMAT}  = {
	"gruppi" => {
		"perl" => ' "gruppi /local/gensoft/lib/gruppi/matrix.list" ',
	},
	"seq" => {
		"perl" => '"  $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [3],

    };

    $self->{GROUP}  = {
	"gruppi" => 0,
	"seq" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"gruppi",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"gruppi" => 1,
	"seq" => 0,

    };

    $self->{ISCOMMAND}  = {
	"gruppi" => 1,
	"seq" => 0,

    };

    $self->{ISMANDATORY}  = {
	"gruppi" => 0,
	"seq" => 1,

    };

    $self->{PROMPT}  = {
	"gruppi" => "",
	"seq" => "Sequence File",

    };

    $self->{ISSTANDOUT}  = {
	"gruppi" => 0,
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
	"gruppi" => { "perl" => '1' },
	"seq" => { "perl" => '1' },

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
	"gruppi" => 0,
	"seq" => 0,

    };

    $self->{ISSIMPLE}  = {
	"gruppi" => 0,
	"seq" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gruppi.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

