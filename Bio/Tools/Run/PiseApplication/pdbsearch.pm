# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pdbsearch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pdbsearch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pdbsearch

      Bioperl class for:

	PDBSEARCH	Fetch a PDB entry (C. Maufrais)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pdbsearch.html 
         for available values):


		pdbsearch (String)

		query (String)
			query (4 letters)

		extract_seq (Switch)
			Extracts sequence? (-i)

		outfile (OutFile)
			pipe: pdbfile
			pipe: seqfile

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

http://bioweb.pasteur.fr/seqanal/interfaces/pdbsearch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pdbsearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pdbsearch = Bio::Tools::Run::PiseApplication::pdbsearch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pdbsearch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pdbsearch = $factory->program('pdbsearch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pdbsearch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pdbsearch.pm

    $self->{COMMAND}   = "pdbsearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PDBSEARCH";

    $self->{DESCRIPTION}   = "Fetch a PDB entry";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "C. Maufrais";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pdbsearch",
	"query",
	"extract_seq",
	"outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pdbsearch",
	"query", 	# query (4 letters)
	"extract_seq", 	# Extracts sequence? (-i)
	"outfile",

    ];

    $self->{TYPE}  = {
	"pdbsearch" => 'String',
	"query" => 'String',
	"extract_seq" => 'Switch',
	"outfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"query" => {
		"perl" => '" $value"',
	},
	"extract_seq" => {
		"perl" => ' ($value)? " -i":""',
	},
	"outfile" => {
	},
	"pdbsearch" => {
		"perl" => '"pdbsearch"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"query" => 3,
	"extract_seq" => 2,
	"pdbsearch" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"outfile",
	"pdbsearch",
	"extract_seq",
	"query",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"query" => 0,
	"extract_seq" => 0,
	"outfile" => 1,
	"pdbsearch" => 1

    };

    $self->{ISCOMMAND}  = {
	"query" => 0,
	"extract_seq" => 0,
	"outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"query" => 1,
	"extract_seq" => 0,
	"outfile" => 0,

    };

    $self->{PROMPT}  = {
	"query" => "query (4 letters)",
	"extract_seq" => "Extracts sequence? (-i)",
	"outfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"query" => 0,
	"extract_seq" => 0,
	"outfile" => 1,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"extract_seq" => '0',
	"outfile" => '"pdbsearch.out"',

    };

    $self->{PRECOND}  = {
	"query" => { "perl" => '1' },
	"extract_seq" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '! $extract_seq' => "pdbfile",
		 '$extract_seq' => "seqfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"query" => 0,
	"extract_seq" => 0,
	"outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"query" => 1,
	"extract_seq" => 1,
	"outfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pdbsearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

