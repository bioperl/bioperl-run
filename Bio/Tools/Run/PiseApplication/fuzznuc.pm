# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::fuzznuc
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::fuzznuc

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fuzznuc

      Bioperl class for:

	FUZZNUC	Nucleic acid pattern search (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/fuzznuc.html 
         for available values):


		fuzznuc (String)

		init (String)

		sequence (Sequence)
			sequence -- dna [sequences] (-sequence)
			pipe: seqsfile

		pattern (String)
			Search pattern (-pattern)

		mismatch (Integer)
			Number of mismatches (-mismatch)

		complement (Switch)
			Search complementary strand (-complement)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/fuzznuc.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::fuzznuc;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fuzznuc = Bio::Tools::Run::PiseApplication::fuzznuc->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fuzznuc object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $fuzznuc = $factory->program('fuzznuc');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::fuzznuc.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzznuc.pm

    $self->{COMMAND}   = "fuzznuc";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FUZZNUC";

    $self->{DESCRIPTION}   = "Nucleic acid pattern search (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/fuzznuc.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fuzznuc",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fuzznuc",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"required", 	# required Section
	"pattern", 	# Search pattern (-pattern)
	"mismatch", 	# Number of mismatches (-mismatch)
	"advanced", 	# advanced Section
	"complement", 	# Search complementary strand (-complement)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"fuzznuc" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"pattern" => 'String',
	"mismatch" => 'Integer',
	"advanced" => 'Paragraph',
	"complement" => 'Switch',
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
	"pattern" => {
		"perl" => '" -pattern=$value"',
	},
	"mismatch" => {
		"perl" => '" -mismatch=$value"',
	},
	"advanced" => {
	},
	"complement" => {
		"perl" => '($value)? " -complement" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"fuzznuc" => {
		"perl" => '"fuzznuc"',
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
	"pattern" => 2,
	"mismatch" => 3,
	"complement" => 4,
	"outfile" => 5,
	"auto" => 6,
	"fuzznuc" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"fuzznuc",
	"sequence",
	"pattern",
	"mismatch",
	"complement",
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
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"fuzznuc" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"pattern" => 1,
	"mismatch" => 1,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [sequences] (-sequence)",
	"required" => "required Section",
	"pattern" => "Search pattern (-pattern)",
	"mismatch" => "Number of mismatches (-mismatch)",
	"advanced" => "advanced Section",
	"complement" => "Search complementary strand (-complement)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['pattern','mismatch',],
	"advanced" => ['complement',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mismatch" => '0',
	"complement" => '0',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"pattern" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"complement" => { "perl" => '1' },
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
	"pattern" => 0,
	"mismatch" => 0,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"pattern" => 1,
	"mismatch" => 1,
	"advanced" => 0,
	"complement" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"pattern" => [
		"The standard IUPAC one-letter codes for the nucleotides are used. <BR>  The symbol `n\' is used for a position where any nucleotide is accepted. <BR>  Ambiguities are indicated by listing the acceptable nucleotides for a given position, between square parentheses `[ ]\'.  For example: [ACG] stands for A or C or G. <BR>  Ambiguities are also indicated by listing between a pair of curly brackets `{ }\' the nucleotides that are not accepted at a given position. For example: {AG} stands for any nucleotides except A and G. <BR>  Each element in a pattern is separated from its neighbor by a `-\'. (Optional in fuzznuc). <BR>  Repetition of an element of the pattern can be indicated by following that element with a numerical value or a numerical range between parenthesis. Examples: N(3) corresponds to N-N-N, N(2,4) corresponds to N-N or N-N-N or N-N-N-N. <BR>  When a pattern is restricted to either the 5\' or 3\' end of a sequence, that pattern either starts with a `<\' symbol or respectively ends with a `>\' symbol. <BR>  A period ends the pattern.  (Optional in fuzznuc). <BR>  For example, [CG](5)TG{A}N(1,5)C",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fuzznuc.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

