# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pyreval
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pyreval

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pyreval

      Bioperl class for:

	PYRAMIDS	pyreval - pyramidal analysis tool for sequence clustering (JC AUDE)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pyreval.html 
         for available values):


		pyreval (String)

		pyr_file (InFile)
			Pyramidal representations file (.pyr or .pyt)
			pipe: pyramid_file

		uti_file (InFile)
			Pyramids informations file (.uti)

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

http://bioweb.pasteur.fr/seqanal/interfaces/pyreval.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pyreval;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pyreval = Bio::Tools::Run::PiseApplication::pyreval->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pyreval object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pyreval = $factory->program('pyreval');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pyreval.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pyreval.pm

    $self->{COMMAND}   = "pyreval";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PYRAMIDS";

    $self->{DESCRIPTION}   = "pyreval - pyramidal analysis tool for sequence clustering";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "JC AUDE";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pyreval",
	"pyr_file",
	"uti_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pyreval",
	"pyr_file", 	# Pyramidal representations file (.pyr or .pyt)
	"uti_file", 	# Pyramids informations file (.uti)

    ];

    $self->{TYPE}  = {
	"pyreval" => 'String',
	"pyr_file" => 'InFile',
	"uti_file" => 'InFile',

    };

    $self->{FORMAT}  = {
	"pyreval" => {
		"seqlab" => 'pyreval',
		"perl" => '"pyreval"',
	},
	"pyr_file" => {
		"perl" => '" $value"',
	},
	"uti_file" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"pyreval" => 0,
	"pyr_file" => 2,
	"uti_file" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pyreval",
	"uti_file",
	"pyr_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pyreval" => 1,
	"pyr_file" => 0,
	"uti_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pyreval" => 1,
	"pyr_file" => 0,
	"uti_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pyreval" => 0,
	"pyr_file" => 1,
	"uti_file" => 1,

    };

    $self->{PROMPT}  = {
	"pyreval" => "",
	"pyr_file" => "Pyramidal representations file (.pyr or .pyt)",
	"uti_file" => "Pyramids informations file (.uti)",

    };

    $self->{ISSTANDOUT}  = {
	"pyreval" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,

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
	"pyreval" => { "perl" => '1' },
	"pyr_file" => { "perl" => '1' },
	"uti_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"pyr_file" => {
		 "pyramid_file" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {
	"pyr_file" => {
		 "pyramid_file" => ["uti_file",]
	},

    };

    $self->{ISCLEAN}  = {
	"pyreval" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pyreval" => 1,
	"pyr_file" => 1,
	"uti_file" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pyreval.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

