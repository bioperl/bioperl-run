# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::palindrome
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::palindrome

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::palindrome

      Bioperl class for:

	PALINDROME	Looks for inverted repeats in a nucleotide sequence (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/palindrome.html 
         for available values):


		palindrome (String)

		init (String)

		insequence (Sequence)
			insequence -- nucleotide [sequences] (-insequence)
			pipe: seqsfile

		minpallen (Integer)
			Enter minimum length of palindrome (-minpallen)

		maxpallen (Integer)
			Enter maximum length of palindrome (-maxpallen)

		gaplimit (Integer)
			Enter maximum gap between repeated regions (-gaplimit)

		nummismatches (Integer)
			Number of mismatches allowed (-nummismatches)

		outfile (OutFile)
			outfile (-outfile)

		overlap (Switch)
			Report overlapping matches (-overlap)

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

http://bioweb.pasteur.fr/seqanal/interfaces/palindrome.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::palindrome;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $palindrome = Bio::Tools::Run::PiseApplication::palindrome->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::palindrome object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $palindrome = $factory->program('palindrome');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::palindrome.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/palindrome.pm

    $self->{COMMAND}   = "palindrome";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PALINDROME";

    $self->{DESCRIPTION}   = "Looks for inverted repeats in a nucleotide sequence (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:repeats",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/palindrome.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"palindrome",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"palindrome",
	"init",
	"input", 	# input Section
	"insequence", 	# insequence -- nucleotide [sequences] (-insequence)
	"required", 	# required Section
	"minpallen", 	# Enter minimum length of palindrome (-minpallen)
	"maxpallen", 	# Enter maximum length of palindrome (-maxpallen)
	"gaplimit", 	# Enter maximum gap between repeated regions (-gaplimit)
	"nummismatches", 	# Number of mismatches allowed (-nummismatches)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"overlap", 	# Report overlapping matches (-overlap)
	"auto",

    ];

    $self->{TYPE}  = {
	"palindrome" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"insequence" => 'Sequence',
	"required" => 'Paragraph',
	"minpallen" => 'Integer',
	"maxpallen" => 'Integer',
	"gaplimit" => 'Integer',
	"nummismatches" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"overlap" => 'Switch',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"insequence" => {
		"perl" => '" -insequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"minpallen" => {
		"perl" => '" -minpallen=$value"',
	},
	"maxpallen" => {
		"perl" => '" -maxpallen=$value"',
	},
	"gaplimit" => {
		"perl" => '" -gaplimit=$value"',
	},
	"nummismatches" => {
		"perl" => '" -nummismatches=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"overlap" => {
		"perl" => '($value)? "" : " -nooverlap"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"palindrome" => {
		"perl" => '"palindrome"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"insequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"insequence" => 1,
	"minpallen" => 2,
	"maxpallen" => 3,
	"gaplimit" => 4,
	"nummismatches" => 5,
	"outfile" => 6,
	"overlap" => 7,
	"auto" => 8,
	"palindrome" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"palindrome",
	"insequence",
	"minpallen",
	"maxpallen",
	"gaplimit",
	"nummismatches",
	"outfile",
	"overlap",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"insequence" => 0,
	"required" => 0,
	"minpallen" => 0,
	"maxpallen" => 0,
	"gaplimit" => 0,
	"nummismatches" => 0,
	"output" => 0,
	"outfile" => 0,
	"overlap" => 0,
	"auto" => 1,
	"palindrome" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"insequence" => 0,
	"required" => 0,
	"minpallen" => 0,
	"maxpallen" => 0,
	"gaplimit" => 0,
	"nummismatches" => 0,
	"output" => 0,
	"outfile" => 0,
	"overlap" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"insequence" => 1,
	"required" => 0,
	"minpallen" => 1,
	"maxpallen" => 1,
	"gaplimit" => 1,
	"nummismatches" => 1,
	"output" => 0,
	"outfile" => 1,
	"overlap" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"insequence" => "insequence -- nucleotide [sequences] (-insequence)",
	"required" => "required Section",
	"minpallen" => "Enter minimum length of palindrome (-minpallen)",
	"maxpallen" => "Enter maximum length of palindrome (-maxpallen)",
	"gaplimit" => "Enter maximum gap between repeated regions (-gaplimit)",
	"nummismatches" => "Number of mismatches allowed (-nummismatches)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"overlap" => "Report overlapping matches (-overlap)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"insequence" => 0,
	"required" => 0,
	"minpallen" => 0,
	"maxpallen" => 0,
	"gaplimit" => 0,
	"nummismatches" => 0,
	"output" => 0,
	"outfile" => 0,
	"overlap" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['insequence',],
	"required" => ['minpallen','maxpallen','gaplimit','nummismatches',],
	"output" => ['outfile','overlap',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"minpallen" => '10',
	"maxpallen" => '100',
	"gaplimit" => '100',
	"nummismatches" => '0',
	"outfile" => 'outfile.out',
	"overlap" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"insequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"minpallen" => { "perl" => '1' },
	"maxpallen" => { "perl" => '1' },
	"gaplimit" => { "perl" => '1' },
	"nummismatches" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"overlap" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"insequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"insequence" => 0,
	"required" => 0,
	"minpallen" => 0,
	"maxpallen" => 0,
	"gaplimit" => 0,
	"nummismatches" => 0,
	"output" => 0,
	"outfile" => 0,
	"overlap" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"insequence" => 1,
	"required" => 0,
	"minpallen" => 1,
	"maxpallen" => 1,
	"gaplimit" => 1,
	"nummismatches" => 1,
	"output" => 0,
	"outfile" => 1,
	"overlap" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"nummismatches" => [
		" Allowed values: Positive integer",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/palindrome.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

