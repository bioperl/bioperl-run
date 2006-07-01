# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::trimseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::trimseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::trimseq

      Bioperl class for:

	TRIMSEQ	Trim ambiguous bits off the ends of sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/trimseq.html 
         for available values):


		trimseq (String)

		init (String)

		sequence (Sequence)
			sequence -- gapany [sequences] (-sequence)
			pipe: seqsfile

		window (Integer)
			Window size (-window)

		percent (Float)
			Percent threshold of ambiguity in window (-percent)

		strict (Switch)
			Trim off all ambiguity codes, not just N or X (-strict)

		star (Switch)
			Trim off asterisks (-star)

		left (Switch)
			Trim at the start (-left)

		right (Switch)
			Trim at the end (-right)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqsfile

		outseq_sformat (Excl)
			Output format for: outseq

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

http://bioweb.pasteur.fr/seqanal/interfaces/trimseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::trimseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $trimseq = Bio::Tools::Run::PiseApplication::trimseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::trimseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $trimseq = $factory->program('trimseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::trimseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/trimseq.pm

    $self->{COMMAND}   = "trimseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TRIMSEQ";

    $self->{DESCRIPTION}   = "Trim ambiguous bits off the ends of sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/trimseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"trimseq",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"trimseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- gapany [sequences] (-sequence)
	"advanced", 	# advanced Section
	"window", 	# Window size (-window)
	"percent", 	# Percent threshold of ambiguity in window (-percent)
	"strict", 	# Trim off all ambiguity codes, not just N or X (-strict)
	"star", 	# Trim off asterisks (-star)
	"left", 	# Trim at the start (-left)
	"right", 	# Trim at the end (-right)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"trimseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"window" => 'Integer',
	"percent" => 'Float',
	"strict" => 'Switch',
	"star" => 'Switch',
	"left" => 'Switch',
	"right" => 'Switch',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
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
	"advanced" => {
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"percent" => {
		"perl" => '(defined $value && $value != $vdef)? " -percent=$value" : ""',
	},
	"strict" => {
		"perl" => '($value)? " -strict" : ""',
	},
	"star" => {
		"perl" => '($value)? " -star" : ""',
	},
	"left" => {
		"perl" => '($value)? "" : " -noleft"',
	},
	"right" => {
		"perl" => '($value)? "" : " -noright"',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"trimseq" => {
		"perl" => '"trimseq"',
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
	"window" => 2,
	"percent" => 3,
	"strict" => 4,
	"star" => 5,
	"left" => 6,
	"right" => 7,
	"outseq" => 8,
	"outseq_sformat" => 9,
	"auto" => 10,
	"trimseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"trimseq",
	"sequence",
	"window",
	"percent",
	"strict",
	"star",
	"left",
	"right",
	"outseq",
	"outseq_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"window" => 0,
	"percent" => 0,
	"strict" => 0,
	"star" => 0,
	"left" => 0,
	"right" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"trimseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"window" => 0,
	"percent" => 0,
	"strict" => 0,
	"star" => 0,
	"left" => 0,
	"right" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"window" => 0,
	"percent" => 0,
	"strict" => 0,
	"star" => 0,
	"left" => 0,
	"right" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- gapany [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"window" => "Window size (-window)",
	"percent" => "Percent threshold of ambiguity in window (-percent)",
	"strict" => "Trim off all ambiguity codes, not just N or X (-strict)",
	"star" => "Trim off asterisks (-star)",
	"left" => "Trim at the start (-left)",
	"right" => "Trim at the end (-right)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"window" => 0,
	"percent" => 0,
	"strict" => 0,
	"star" => 0,
	"left" => 0,
	"right" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['window','percent','strict','star','left','right',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '1',
	"percent" => '100.0',
	"strict" => '0',
	"star" => '0',
	"left" => '1',
	"right" => '1',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"percent" => { "perl" => '1' },
	"strict" => { "perl" => '1' },
	"star" => { "perl" => '1' },
	"left" => { "perl" => '1' },
	"right" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqsfile",
	},

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
	"advanced" => 0,
	"window" => 0,
	"percent" => 0,
	"strict" => 0,
	"star" => 0,
	"left" => 0,
	"right" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"window" => 0,
	"percent" => 0,
	"strict" => 0,
	"star" => 0,
	"left" => 0,
	"right" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"window" => [
		"This determines the size of the region that is considered when deciding whether the percentage of ambiguity is greater than the threshold. A value of 5 means that a region of 5 letters in the sequence is shifted along the sequence from the ends and trimming is done only if there is a greater or equal percentage of ambiguity than the threshold percentage.",
	],
	"percent" => [
		"This is the threshold of the percentage ambiguity in the window required in order to trim a sequence.",
	],
	"strict" => [
		"In nucleic sequences, trim off not only N\'s and X\'s, but also the nucleotide IUPAC ambiguity codes M, R, W, S, Y, K, V, H, D and B. In protein sequences, trim off not only X\'s but also B and Z.",
	],
	"star" => [
		"In protein sequences, trim off not only X\'s, but also the *\'s",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/trimseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

