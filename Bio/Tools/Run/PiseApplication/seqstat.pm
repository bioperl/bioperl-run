# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::seqstat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::seqstat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::seqstat

      Bioperl class for:

	HMMER	seqstat - show statistics and format for a sequence file (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/seqstat.html 
         for available values):


		seqstat (String)

		seqfile (Sequence)
			Sequences file

		verbose (Switch)
			Show additional verbose information (-a)

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

http://bioweb.pasteur.fr/seqanal/interfaces/seqstat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::seqstat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $seqstat = Bio::Tools::Run::PiseApplication::seqstat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::seqstat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $seqstat = $factory->program('seqstat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::seqstat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqstat.pm

    $self->{COMMAND}   = "seqstat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "seqstat - show statistics and format for a sequence file";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"seqstat",
	"seqfile",
	"verbose",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"seqstat",
	"seqfile", 	# Sequences file
	"verbose", 	# Show additional verbose information (-a)

    ];

    $self->{TYPE}  = {
	"seqstat" => 'String',
	"seqfile" => 'Sequence',
	"verbose" => 'Switch',

    };

    $self->{FORMAT}  = {
	"seqstat" => {
		"perl" => '"seqstat"',
	},
	"seqfile" => {
		"perl" => '" $value"',
	},
	"verbose" => {
		"perl" => '($value) ? " -a " : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqfile" => [2,4,5,8,15],

    };

    $self->{GROUP}  = {
	"seqstat" => 0,
	"seqfile" => 2,
	"verbose" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"seqstat",
	"verbose",
	"seqfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"seqstat" => 1,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{ISCOMMAND}  = {
	"seqstat" => 1,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{ISMANDATORY}  = {
	"seqstat" => 0,
	"seqfile" => 1,
	"verbose" => 0,

    };

    $self->{PROMPT}  = {
	"seqstat" => "",
	"seqfile" => "Sequences file",
	"verbose" => "Show additional verbose information (-a)",

    };

    $self->{ISSTANDOUT}  = {
	"seqstat" => 0,
	"seqfile" => 0,
	"verbose" => 0,

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
	"seqstat" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },

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
	"seqstat" => 0,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{ISSIMPLE}  = {
	"seqstat" => 0,
	"seqfile" => 0,
	"verbose" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"verbose" => [
		"a table with one line per sequence showing name, length, and description line. These lines are prefixed with a * character to enable easily grep\'ing them out and sorting them.",
		"seqfile",
		"perl",
		"1",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqstat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

