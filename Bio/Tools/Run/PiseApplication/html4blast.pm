# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::html4blast
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::html4blast

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::html4blast

      Bioperl class for:

	html4blast	HTML blast results formatter (Nicolas Joly)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/html4blast.html 
         for available values):


		html4blast (String)

		input (InFile)
			Blast output file
			pipe: blast_output

		links (Excl)
			Database links

		graph (Switch)
			Graphical alignment summary

		hspline (Switch)
			Draw one HSP per graphic line

		queryimagename (Switch)
			Generate query based images names

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

http://bioweb.pasteur.fr/seqanal/interfaces/html4blast.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::html4blast;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $html4blast = Bio::Tools::Run::PiseApplication::html4blast->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::html4blast object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $html4blast = $factory->program('html4blast');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::html4blast.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/html4blast.pm

    $self->{COMMAND}   = "html4blast";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "html4blast";

    $self->{DESCRIPTION}   = "HTML blast results formatter";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Nicolas Joly";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"html4blast",
	"input",
	"output",
	"links",
	"graph",
	"hspline",
	"queryimagename",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"html4blast",
	"input", 	# Blast output file
	"output",
	"links", 	# Database links
	"graph", 	# Graphical alignment summary
	"hspline", 	# Draw one HSP per graphic line
	"queryimagename", 	# Generate query based images names

    ];

    $self->{TYPE}  = {
	"html4blast" => 'String',
	"input" => 'InFile',
	"output" => 'Results',
	"links" => 'Excl',
	"graph" => 'Switch',
	"hspline" => 'Switch',
	"queryimagename" => 'Switch',

    };

    $self->{FORMAT}  = {
	"html4blast" => {
		"perl" => 'html4blast',
	},
	"input" => {
		"perl" => '" $value"',
	},
	"output" => {
	},
	"links" => {
		"perl" => '($value ne "") ? " $value" : ""',
	},
	"graph" => {
		"perl" => '($value) ? " -g" : ""',
	},
	"hspline" => {
		"perl" => '($value) ? " -l" : ""',
	},
	"queryimagename" => {
		"perl" => '($value) ? " -q" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"output" => 'blast.html',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"html4blast" => 0,
	"input" => 4,
	"links" => 1,
	"graph" => 2,
	"hspline" => 2,
	"queryimagename" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"html4blast",
	"output",
	"links",
	"graph",
	"hspline",
	"queryimagename",
	"input",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"html4blast" => 1,
	"input" => 0,
	"output" => 0,
	"links" => 0,
	"graph" => 0,
	"hspline" => 0,
	"queryimagename" => 0,

    };

    $self->{ISCOMMAND}  = {
	"html4blast" => 1,
	"input" => 0,
	"output" => 0,
	"links" => 0,
	"graph" => 0,
	"hspline" => 0,
	"queryimagename" => 0,

    };

    $self->{ISMANDATORY}  = {
	"html4blast" => 0,
	"input" => 1,
	"output" => 0,
	"links" => 0,
	"graph" => 0,
	"hspline" => 0,
	"queryimagename" => 0,

    };

    $self->{PROMPT}  = {
	"html4blast" => "",
	"input" => "Blast output file",
	"output" => "",
	"links" => "Database links",
	"graph" => "Graphical alignment summary",
	"hspline" => "Draw one HSP per graphic line",
	"queryimagename" => "Generate query based images names",

    };

    $self->{ISSTANDOUT}  = {
	"html4blast" => 0,
	"input" => 0,
	"output" => 0,
	"links" => 0,
	"graph" => 0,
	"hspline" => 0,
	"queryimagename" => 0,

    };

    $self->{VLIST}  = {

	"links" => ['-n','no links','','efetch links','-s','Srs links','-e','external sites links',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"graph" => '1',
	"hspline" => '0',
	"queryimagename" => '0',

    };

    $self->{PRECOND}  = {
	"html4blast" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"links" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"hspline" => { "perl" => '1' },
	"queryimagename" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"input" => {
		 "blast_output" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"html4blast" => 0,
	"input" => 0,
	"output" => 0,
	"links" => 0,
	"graph" => 0,
	"hspline" => 0,
	"queryimagename" => 0,

    };

    $self->{ISSIMPLE}  = {
	"html4blast" => 0,
	"input" => 1,
	"output" => 0,
	"links" => 0,
	"graph" => 0,
	"hspline" => 0,
	"queryimagename" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/html4blast.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

