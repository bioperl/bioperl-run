# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::xblast
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::xblast

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::xblast

      Bioperl class for:

	XBLAST	read blast output and mask query


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/xblast.html 
         for available values):


		xblast (String)

		blast_output (InFile)
			Blast Output File (does not work on Blast2 or Blast-Wu output)
			pipe: blast_output

		query (InFile)
			Query File

		mask (String)
			masking character

		fasta (Switch)
			generate a fasta-format database of the matched segments

		reversed (Switch)
			generate a reversed output, e.g. masking the non-matched segments.

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

http://bioweb.pasteur.fr/seqanal/interfaces/xblast.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::xblast;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $xblast = Bio::Tools::Run::PiseApplication::xblast->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::xblast object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $xblast = $factory->program('xblast');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::xblast.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/xblast.pm

    $self->{COMMAND}   = "xblast";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "XBLAST";

    $self->{DESCRIPTION}   = "read blast output and mask query";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"xblast",
	"blast_output",
	"query",
	"mask",
	"fasta",
	"reversed",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"xblast",
	"blast_output", 	# Blast Output File (does not work on Blast2 or Blast-Wu output)
	"query", 	# Query File
	"mask", 	# masking character
	"fasta", 	# generate a fasta-format database of the matched segments
	"reversed", 	# generate a reversed output, e.g. masking the non-matched segments.

    ];

    $self->{TYPE}  = {
	"xblast" => 'String',
	"blast_output" => 'InFile',
	"query" => 'InFile',
	"mask" => 'String',
	"fasta" => 'Switch',
	"reversed" => 'Switch',

    };

    $self->{FORMAT}  = {
	"xblast" => {
		"seqlab" => 'xblast',
		"perl" => '"xblast"',
	},
	"blast_output" => {
		"perl" => '" $value"',
	},
	"query" => {
		"perl" => '" $value"',
	},
	"mask" => {
		"perl" => '" $value"',
	},
	"fasta" => {
		"perl" => '($value)? " -d":""',
	},
	"reversed" => {
		"perl" => '($value)? " -r":""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"xblast" => 0,
	"blast_output" => 2,
	"query" => 3,
	"mask" => 4,
	"fasta" => 1,
	"reversed" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"xblast",
	"fasta",
	"reversed",
	"blast_output",
	"query",
	"mask",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"xblast" => 1,
	"blast_output" => 0,
	"query" => 0,
	"mask" => 0,
	"fasta" => 0,
	"reversed" => 0,

    };

    $self->{ISCOMMAND}  = {
	"xblast" => 1,
	"blast_output" => 0,
	"query" => 0,
	"mask" => 0,
	"fasta" => 0,
	"reversed" => 0,

    };

    $self->{ISMANDATORY}  = {
	"xblast" => 0,
	"blast_output" => 1,
	"query" => 1,
	"mask" => 0,
	"fasta" => 0,
	"reversed" => 0,

    };

    $self->{PROMPT}  = {
	"xblast" => "",
	"blast_output" => "Blast Output File (does not work on Blast2 or Blast-Wu output)",
	"query" => "Query File",
	"mask" => "masking character",
	"fasta" => "generate a fasta-format database of the matched segments",
	"reversed" => "generate a reversed output, e.g. masking the non-matched segments.",

    };

    $self->{ISSTANDOUT}  = {
	"xblast" => 0,
	"blast_output" => 0,
	"query" => 0,
	"mask" => 0,
	"fasta" => 0,
	"reversed" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"fasta" => '0',
	"reversed" => '0',

    };

    $self->{PRECOND}  = {
	"xblast" => { "perl" => '1' },
	"blast_output" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"mask" => { "perl" => '1' },
	"fasta" => { "perl" => '1' },
	"reversed" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"blast_output" => {
		 "blast_output" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"xblast" => 0,
	"blast_output" => 0,
	"query" => 0,
	"mask" => 0,
	"fasta" => 0,
	"reversed" => 0,

    };

    $self->{ISSIMPLE}  = {
	"xblast" => 1,
	"blast_output" => 1,
	"query" => 0,
	"mask" => 0,
	"fasta" => 0,
	"reversed" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"mask" => [
		"no value: will generate a query masked with \'x\'",
		"N> will generate a query masked with \'N\', etc ... ",
		"for using special masking characters like \'!@#$%^&*- =><\' and others, quote them with \'\'",
		"for deleting instead of masking use empty double quotes : \'\'",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/xblast.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

