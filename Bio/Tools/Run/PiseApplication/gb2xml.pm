# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::gb2xml
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::gb2xml

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::gb2xml

      Bioperl class for:

	gb2xml	Genbank to XML conversion tool (P. Bouige)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/gb2xml.html 
         for available values):


		gb2xml (String)

		query (String)
			Accession

		access (Excl)
			Access method

		file (InFile)
			File

		xmldtdcopy (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/gb2xml.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::gb2xml;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $gb2xml = Bio::Tools::Run::PiseApplication::gb2xml->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::gb2xml object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $gb2xml = $factory->program('gb2xml');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::gb2xml.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gb2xml.pm

    $self->{COMMAND}   = "gb2xml";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "gb2xml";

    $self->{DESCRIPTION}   = "Genbank to XML conversion tool";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "P. Bouige";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"gb2xml",
	"query",
	"access",
	"file",
	"xmldtdcopy",
	"dtdfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"gb2xml",
	"query", 	# Accession
	"access", 	# Access method
	"file", 	# File
	"xmldtdcopy",
	"dtdfile",

    ];

    $self->{TYPE}  = {
	"gb2xml" => 'String',
	"query" => 'String',
	"access" => 'Excl',
	"file" => 'InFile',
	"xmldtdcopy" => 'String',
	"dtdfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"gb2xml" => {
		"seqlab" => 'gb2xml',
		"perl" => '"gb2xml"',
	},
	"query" => {
		"perl" => '" $value"',
	},
	"access" => {
		"perl" => '" -$value"',
	},
	"file" => {
		"perl" => '" $value"',
	},
	"xmldtdcopy" => {
		"perl" => '"; cp /local/gensoft/lib/pasteur/genbank.dtd ."',
	},
	"dtdfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"dtdfile" => 'genbank.dtd',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"gb2xml" => 0,
	"query" => 2,
	"access" => 1,
	"file" => 2,
	"xmldtdcopy" => 100,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"gb2xml",
	"dtdfile",
	"access",
	"query",
	"file",
	"xmldtdcopy",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"gb2xml" => 1,
	"query" => 0,
	"access" => 0,
	"file" => 0,
	"xmldtdcopy" => 1,
	"dtdfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"gb2xml" => 1,
	"query" => 0,
	"access" => 0,
	"file" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"gb2xml" => 0,
	"query" => 1,
	"access" => 0,
	"file" => 1,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{PROMPT}  = {
	"gb2xml" => "",
	"query" => "Accession",
	"access" => "Access method",
	"file" => "File",
	"xmldtdcopy" => "",
	"dtdfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"gb2xml" => 0,
	"query" => 0,
	"access" => 0,
	"file" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{VLIST}  = {

	"access" => ['e','fetch','g','SRS','f','file',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"access" => 'e',

    };

    $self->{PRECOND}  = {
	"gb2xml" => { "perl" => '1' },
	"query" => {
		"perl" => '$access ne "f"',
	},
	"access" => { "perl" => '1' },
	"file" => {
		"perl" => '$access eq "f"',
	},
	"xmldtdcopy" => { "perl" => '1' },
	"dtdfile" => { "perl" => '1' },

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
	"gb2xml" => 0,
	"query" => 0,
	"access" => 0,
	"file" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"gb2xml" => 1,
	"query" => 1,
	"access" => 0,
	"file" => 0,
	"xmldtdcopy" => 0,
	"dtdfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gb2xml.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

