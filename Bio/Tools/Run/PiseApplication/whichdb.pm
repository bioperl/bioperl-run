# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::whichdb
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::whichdb

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::whichdb

      Bioperl class for:

	WHICHDB	Search all databases for an entry (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/whichdb.html 
         for available values):


		whichdb (String)

		init (String)

		entry (String)
			ID or Accession number (-entry)

		get (Switch)
			Retrieve sequences (-get)

		showall (Switch)
			Show failed attempts (-showall)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/whichdb.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::whichdb;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $whichdb = Bio::Tools::Run::PiseApplication::whichdb->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::whichdb object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $whichdb = $factory->program('whichdb');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::whichdb.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/whichdb.pm

    $self->{COMMAND}   = "whichdb";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WHICHDB";

    $self->{DESCRIPTION}   = "Search all databases for an entry (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "information",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/whichdb.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"whichdb",
	"init",
	"entry",
	"get",
	"showall",
	"outfile",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"whichdb",
	"init",
	"entry", 	# ID or Accession number (-entry)
	"get", 	# Retrieve sequences (-get)
	"showall", 	# Show failed attempts (-showall)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"whichdb" => 'String',
	"init" => 'String',
	"entry" => 'String',
	"get" => 'Switch',
	"showall" => 'Switch',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"entry" => {
		"perl" => '" -entry=$value"',
	},
	"get" => {
		"perl" => '($value)? " -get" : ""',
	},
	"showall" => {
		"perl" => '($value)? " -showall" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"whichdb" => {
		"perl" => '"whichdb"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"entry" => 1,
	"get" => 2,
	"showall" => 3,
	"outfile" => 4,
	"auto" => 5,
	"whichdb" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"whichdb",
	"entry",
	"get",
	"showall",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"entry" => 0,
	"get" => 0,
	"showall" => 0,
	"outfile" => 0,
	"auto" => 1,
	"whichdb" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"entry" => 0,
	"get" => 0,
	"showall" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"entry" => 1,
	"get" => 0,
	"showall" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"entry" => "ID or Accession number (-entry)",
	"get" => "Retrieve sequences (-get)",
	"showall" => "Show failed attempts (-showall)",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"entry" => 0,
	"get" => 0,
	"showall" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"get" => '0',
	"showall" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"entry" => { "perl" => '1' },
	"get" => { "perl" => '1' },
	"showall" => { "perl" => '1' },
	"outfile" => {
		"acd" => '@(!$(get))',
	},
	"auto" => { "perl" => '1' },

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
	"init" => 0,
	"entry" => 0,
	"get" => 0,
	"showall" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"entry" => 1,
	"get" => 0,
	"showall" => 0,
	"outfile" => 0,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/whichdb.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

