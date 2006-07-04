# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::stssearch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::stssearch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::stssearch

      Bioperl class for:

	STSSEARCH	Searches a DNA database for matches with a set of STS primers (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/stssearch.html 
         for available values):


		stssearch (String)

		init (String)

		sequences (Sequence)
			sequences -- dna [sequences] (-sequences)
			pipe: seqsfile

		primers (InFile)
			Primer file (-primers)

		out (OutFile)
			out (-out)

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

http://bioweb.pasteur.fr/seqanal/interfaces/stssearch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::stssearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $stssearch = Bio::Tools::Run::PiseApplication::stssearch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::stssearch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $stssearch = $factory->program('stssearch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::stssearch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/stssearch.pm

    $self->{COMMAND}   = "stssearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "STSSEARCH";

    $self->{DESCRIPTION}   = "Searches a DNA database for matches with a set of STS primers (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:primers",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/stssearch.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"stssearch",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"stssearch",
	"init",
	"input", 	# input Section
	"sequences", 	# sequences -- dna [sequences] (-sequences)
	"primers", 	# Primer file (-primers)
	"output", 	# output Section
	"out", 	# out (-out)
	"auto",

    ];

    $self->{TYPE}  = {
	"stssearch" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequences" => 'Sequence',
	"primers" => 'InFile',
	"output" => 'Paragraph',
	"out" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequences" => {
		"perl" => '" -sequences=$value -sformat=fasta"',
	},
	"primers" => {
		"perl" => '" -primers=$value"',
	},
	"output" => {
	},
	"out" => {
		"perl" => '" -out=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"stssearch" => {
		"perl" => '"stssearch"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequences" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequences" => 1,
	"primers" => 2,
	"out" => 3,
	"auto" => 4,
	"stssearch" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"stssearch",
	"sequences",
	"primers",
	"out",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 1,
	"stssearch" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 1,
	"primers" => 1,
	"output" => 0,
	"out" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequences" => "sequences -- dna [sequences] (-sequences)",
	"primers" => "Primer file (-primers)",
	"output" => "output Section",
	"out" => "out (-out)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequences','primers',],
	"output" => ['out',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"out" => 'out.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequences" => { "perl" => '1' },
	"primers" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"out" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequences" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"primers" => 0,
	"output" => 0,
	"out" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 1,
	"primers" => 1,
	"output" => 0,
	"out" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/stssearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

