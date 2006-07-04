# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::oddcomp
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::oddcomp

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::oddcomp

      Bioperl class for:

	ODDCOMP	Finds protein sequence regions with a biased composition (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/oddcomp.html 
         for available values):


		oddcomp (String)

		init (String)

		sequence (Sequence)
			sequence -- Protein [sequences] (-sequence)
			pipe: seqsfile

		compdata (InFile)
			'compseq' file to use for expected word frequencies (-compdata)

		window (Integer)
			Window size to consider (e.g. 30 aa) (-window)

		ignorebz (Switch)
			Ignore the amino acids B and Z and just count them as 'Other' (-ignorebz)

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

http://bioweb.pasteur.fr/seqanal/interfaces/oddcomp.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::oddcomp;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $oddcomp = Bio::Tools::Run::PiseApplication::oddcomp->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::oddcomp object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $oddcomp = $factory->program('oddcomp');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::oddcomp.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/oddcomp.pm

    $self->{COMMAND}   = "oddcomp";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ODDCOMP";

    $self->{DESCRIPTION}   = "Finds protein sequence regions with a biased composition (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/oddcomp.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"oddcomp",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"oddcomp",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- Protein [sequences] (-sequence)
	"required", 	# required Section
	"compdata", 	# 'compseq' file to use for expected word frequencies (-compdata)
	"window", 	# Window size to consider (e.g. 30 aa) (-window)
	"advanced", 	# advanced Section
	"ignorebz", 	# Ignore the amino acids B and Z and just count them as 'Other' (-ignorebz)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"oddcomp" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"compdata" => 'InFile',
	"window" => 'Integer',
	"advanced" => 'Paragraph',
	"ignorebz" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"compdata" => {
		"perl" => '" -compdata=$value"',
	},
	"window" => {
		"perl" => '" -window=$value"',
	},
	"advanced" => {
	},
	"ignorebz" => {
		"perl" => '($value)? "" : " -noignorebz"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"oddcomp" => {
		"perl" => '"oddcomp"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"compdata" => 2,
	"window" => 3,
	"ignorebz" => 4,
	"outfile" => 5,
	"auto" => 6,
	"oddcomp" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"oddcomp",
	"sequence",
	"compdata",
	"window",
	"ignorebz",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"compdata" => 0,
	"window" => 0,
	"advanced" => 0,
	"ignorebz" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"oddcomp" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"compdata" => 0,
	"window" => 0,
	"advanced" => 0,
	"ignorebz" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"compdata" => 1,
	"window" => 1,
	"advanced" => 0,
	"ignorebz" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- Protein [sequences] (-sequence)",
	"required" => "required Section",
	"compdata" => "'compseq' file to use for expected word frequencies (-compdata)",
	"window" => "Window size to consider (e.g. 30 aa) (-window)",
	"advanced" => "advanced Section",
	"ignorebz" => "Ignore the amino acids B and Z and just count them as 'Other' (-ignorebz)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"compdata" => 0,
	"window" => 0,
	"advanced" => 0,
	"ignorebz" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['compdata','window',],
	"advanced" => ['ignorebz',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '30',
	"ignorebz" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"compdata" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"ignorebz" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"compdata" => 0,
	"window" => 0,
	"advanced" => 0,
	"ignorebz" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"compdata" => 1,
	"window" => 1,
	"advanced" => 0,
	"ignorebz" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"compdata" => [
		"This is a file in the format of the output produced by \'compseq\' that is used to set the minimum frequencies of words in this analysis.",
	],
	"window" => [
		"This is the size of window in which to count. <BR> Thus if you want to count frequencies in a 40 aa stretch you should enter 40 here.",
	],
	"ignorebz" => [
		"The amino acid code B represents Asparagine or Aspartic acid and the code Z represents Glutamine or Glutamic acid. <BR> These are not commonly used codes and you may wish not to count words containing them, just noting them in the count of \'Other\' words.",
	],
	"outfile" => [
		"This is the results file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/oddcomp.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

