# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::getblock
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::getblock

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::getblock

      Bioperl class for:

	BLIMPS	getblock - fetch a block from Blocks database (Wallace & Henikoff)

	References:

		J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).

		Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/getblock.html 
         for available values):


		getblock (String)

		dbs (String)

		query (String)
			query (Accession Nr)

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

http://bioweb.pasteur.fr/seqanal/interfaces/getblock.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::getblock;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $getblock = Bio::Tools::Run::PiseApplication::getblock->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::getblock object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $getblock = $factory->program('getblock');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::getblock.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/getblock.pm

    $self->{COMMAND}   = "getblock";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLIMPS";

    $self->{DESCRIPTION}   = "getblock - fetch a block from Blocks database";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Wallace & Henikoff";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-aa.html#BLIMPS";

    $self->{REFERENCE}   = [

         "J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).",

         "Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"getblock",
	"dbs",
	"query",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"getblock",
	"dbs",
	"query", 	# query (Accession Nr)

    ];

    $self->{TYPE}  = {
	"getblock" => 'String',
	"dbs" => 'String',
	"query" => 'String',

    };

    $self->{FORMAT}  = {
	"getblock" => {
		"perl" => '"getblock"',
	},
	"dbs" => {
		"perl" => ' " /local/gensoft/lib/blimps/db/blocks.dat /local/gensoft/lib/blimps/db/" ',
	},
	"query" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"getblock" => 0,
	"dbs" => 2,
	"query" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"getblock",
	"query",
	"dbs",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"getblock" => 1,
	"dbs" => 1,
	"query" => 0,

    };

    $self->{ISCOMMAND}  = {
	"getblock" => 1,
	"dbs" => 0,
	"query" => 0,

    };

    $self->{ISMANDATORY}  = {
	"getblock" => 0,
	"dbs" => 0,
	"query" => 1,

    };

    $self->{PROMPT}  = {
	"getblock" => "",
	"dbs" => "",
	"query" => "query (Accession Nr)",

    };

    $self->{ISSTANDOUT}  = {
	"getblock" => 0,
	"dbs" => 0,
	"query" => 0,

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
	"getblock" => { "perl" => '1' },
	"dbs" => { "perl" => '1' },
	"query" => { "perl" => '1' },

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
	"getblock" => 0,
	"dbs" => 0,
	"query" => 0,

    };

    $self->{ISSIMPLE}  = {
	"getblock" => 0,
	"dbs" => 0,
	"query" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/getblock.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

