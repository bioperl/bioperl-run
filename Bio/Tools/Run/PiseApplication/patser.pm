# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::patser
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::patser

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::patser

      Bioperl class for:

	PATSER	score the words of a sequence against an alignment matrix (Hertz, Storm)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/patser.html 
         for available values):


		patser (String)

		matrix (InFile)
			Matrix file (-m)
			pipe: consensus_matrix

		sequence (Sequence)
			Sequences file

		weight (Switch)
			Matrix is a weight matrix (-w)

		vertical (Switch)
			Matrix is a vertical matrix (-v)

		correction (Integer)
			Correction added to the elements of the alignment matrix (-b)

		print_matrix (Switch)
			Print the weight matrix derived from the alignment matrix (-p)

		dna (Switch)
			Alphabet and normalization information for DNA

		protein (Switch)
			Alphabet and normalization information for protein

		ascii_alphabet (InFile)
			Alphabet and normalization information (-a)

		score (Excl)
			Score options (-d)

		range (Integer)
			Range for approximating a weight matrix with integers (-R)

		min_score (Integer)
			Minimum score for calculating the p-value of scores (-M)

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

http://bioweb.pasteur.fr/seqanal/interfaces/patser.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::patser;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $patser = Bio::Tools::Run::PiseApplication::patser->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::patser object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $patser = $factory->program('patser');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::patser.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/patser.pm

    $self->{COMMAND}   = "patser";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PATSER";

    $self->{DESCRIPTION}   = "score the words of a sequence against an alignment matrix";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Hertz, Storm";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"patser",
	"matrix",
	"sequence",
	"control_options",
	"score",
	"range",
	"min_score",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"patser",
	"matrix", 	# Matrix file (-m)
	"sequence", 	# Sequences file
	"control_options", 	# Control options
	"matrix_options", 	# Matrix options
	"weight", 	# Matrix is a weight matrix (-w)
	"vertical", 	# Matrix is a vertical matrix (-v)
	"correction", 	# Correction added to the elements of the alignment matrix (-b)
	"print_matrix", 	# Print the weight matrix derived from the alignment matrix (-p)
	"alphabet_options", 	# Alphabet options
	"dna", 	# Alphabet and normalization information for DNA
	"protein", 	# Alphabet and normalization information for protein
	"ascii_alphabet", 	# Alphabet and normalization information (-a)
	"score", 	# Score options (-d)
	"range", 	# Range for approximating a weight matrix with integers (-R)
	"min_score", 	# Minimum score for calculating the p-value of scores (-M)

    ];

    $self->{TYPE}  = {
	"patser" => 'String',
	"matrix" => 'InFile',
	"sequence" => 'Sequence',
	"control_options" => 'Paragraph',
	"matrix_options" => 'Paragraph',
	"weight" => 'Switch',
	"vertical" => 'Switch',
	"correction" => 'Integer',
	"print_matrix" => 'Switch',
	"alphabet_options" => 'Paragraph',
	"dna" => 'Switch',
	"protein" => 'Switch',
	"ascii_alphabet" => 'InFile',
	"score" => 'Excl',
	"range" => 'Integer',
	"min_score" => 'Integer',

    };

    $self->{FORMAT}  = {
	"patser" => {
		"perl" => '"fasta-consensus < $sequence > $sequence.wcons; patser "',
	},
	"matrix" => {
		"perl" => '" -m $value"',
	},
	"sequence" => {
		"perl" => '" -f $sequence.wcons"',
	},
	"control_options" => {
	},
	"matrix_options" => {
	},
	"weight" => {
		"perl" => '($value)? " -w" : ""',
	},
	"vertical" => {
		"perl" => '($value)? " -v" : ""',
	},
	"correction" => {
		"perl" => '(defined $value && $value != $vdef)? " -b$value" : ""',
	},
	"print_matrix" => {
		"perl" => '($value)? " -p" : ""',
	},
	"alphabet_options" => {
	},
	"dna" => {
		"perl" => '($value)? " -A a:t c:g" : ""',
	},
	"protein" => {
		"perl" => '($value) ? " -a /local/gensoft/lib/consensus/prot-alphabet" : ""',
	},
	"ascii_alphabet" => {
		"perl" => '($value) ? " -a $value" : "" ',
	},
	"score" => {
		"perl" => '($value && $value ne $vdef)? " -d$value" : ""',
	},
	"range" => {
		"perl" => '(defined $value && $value != $vdef)? " -R$value" : ""',
	},
	"min_score" => {
		"perl" => '(defined $value && $value != $vdef)? " -M$value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"patser" => 0,
	"matrix" => 1,
	"sequence" => 1,
	"control_options" => 1,
	"matrix_options" => 1,
	"weight" => 1,
	"vertical" => 1,
	"correction" => 1,
	"print_matrix" => 1,
	"alphabet_options" => 1,
	"dna" => 1,
	"protein" => 1,
	"ascii_alphabet" => 1,
	"score" => 1,
	"range" => 1,
	"min_score" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"patser",
	"matrix",
	"sequence",
	"control_options",
	"matrix_options",
	"weight",
	"vertical",
	"correction",
	"print_matrix",
	"alphabet_options",
	"dna",
	"protein",
	"ascii_alphabet",
	"score",
	"range",
	"min_score",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"patser" => 1,
	"matrix" => 0,
	"sequence" => 0,
	"control_options" => 0,
	"matrix_options" => 0,
	"weight" => 0,
	"vertical" => 0,
	"correction" => 0,
	"print_matrix" => 0,
	"alphabet_options" => 0,
	"dna" => 0,
	"protein" => 0,
	"ascii_alphabet" => 0,
	"score" => 0,
	"range" => 0,
	"min_score" => 0,

    };

    $self->{ISCOMMAND}  = {
	"patser" => 1,
	"matrix" => 0,
	"sequence" => 0,
	"control_options" => 0,
	"matrix_options" => 0,
	"weight" => 0,
	"vertical" => 0,
	"correction" => 0,
	"print_matrix" => 0,
	"alphabet_options" => 0,
	"dna" => 0,
	"protein" => 0,
	"ascii_alphabet" => 0,
	"score" => 0,
	"range" => 0,
	"min_score" => 0,

    };

    $self->{ISMANDATORY}  = {
	"patser" => 0,
	"matrix" => 1,
	"sequence" => 1,
	"control_options" => 0,
	"matrix_options" => 0,
	"weight" => 0,
	"vertical" => 0,
	"correction" => 0,
	"print_matrix" => 0,
	"alphabet_options" => 0,
	"dna" => 0,
	"protein" => 0,
	"ascii_alphabet" => 0,
	"score" => 0,
	"range" => 0,
	"min_score" => 0,

    };

    $self->{PROMPT}  = {
	"patser" => "",
	"matrix" => "Matrix file (-m)",
	"sequence" => "Sequences file",
	"control_options" => "Control options",
	"matrix_options" => "Matrix options",
	"weight" => "Matrix is a weight matrix (-w)",
	"vertical" => "Matrix is a vertical matrix (-v)",
	"correction" => "Correction added to the elements of the alignment matrix (-b)",
	"print_matrix" => "Print the weight matrix derived from the alignment matrix (-p)",
	"alphabet_options" => "Alphabet options",
	"dna" => "Alphabet and normalization information for DNA",
	"protein" => "Alphabet and normalization information for protein",
	"ascii_alphabet" => "Alphabet and normalization information (-a)",
	"score" => "Score options (-d)",
	"range" => "Range for approximating a weight matrix with integers (-R)",
	"min_score" => "Minimum score for calculating the p-value of scores (-M)",

    };

    $self->{ISSTANDOUT}  = {
	"patser" => 0,
	"matrix" => 0,
	"sequence" => 0,
	"control_options" => 0,
	"matrix_options" => 0,
	"weight" => 0,
	"vertical" => 0,
	"correction" => 0,
	"print_matrix" => 0,
	"alphabet_options" => 0,
	"dna" => 0,
	"protein" => 0,
	"ascii_alphabet" => 0,
	"score" => 0,
	"range" => 0,
	"min_score" => 0,

    };

    $self->{VLIST}  = {

	"control_options" => ['matrix_options','alphabet_options',],
	"matrix_options" => ['weight','vertical','correction','print_matrix',],
	"alphabet_options" => ['dna','protein','ascii_alphabet',],
	"score" => ['0','-d0: Treat unrecognized characters as errors','1','-d1: Treat unrecognized characters as discontinuities, but print warning','2','-d2: Treat unrecognized characters as discontinuities, and print NO warning',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"weight" => '0',
	"vertical" => '0',
	"correction" => '1',
	"print_matrix" => '0',
	"protein" => '1',
	"score" => '1',
	"range" => '10000',
	"min_score" => '0',

    };

    $self->{PRECOND}  = {
	"patser" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"matrix_options" => { "perl" => '1' },
	"weight" => { "perl" => '1' },
	"vertical" => { "perl" => '1' },
	"correction" => { "perl" => '1' },
	"print_matrix" => { "perl" => '1' },
	"alphabet_options" => { "perl" => '1' },
	"dna" => { "perl" => '1' },
	"protein" => { "perl" => '1' },
	"ascii_alphabet" => { "perl" => '1' },
	"score" => { "perl" => '1' },
	"range" => { "perl" => '1' },
	"min_score" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"matrix" => {
		 "consensus_matrix" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"patser" => 0,
	"matrix" => 0,
	"sequence" => 0,
	"control_options" => 0,
	"matrix_options" => 0,
	"weight" => 0,
	"vertical" => 0,
	"correction" => 0,
	"print_matrix" => 0,
	"alphabet_options" => 0,
	"dna" => 0,
	"protein" => 0,
	"ascii_alphabet" => 0,
	"score" => 0,
	"range" => 0,
	"min_score" => 0,

    };

    $self->{ISSIMPLE}  = {
	"patser" => 0,
	"matrix" => 1,
	"sequence" => 1,
	"control_options" => 0,
	"matrix_options" => 0,
	"weight" => 0,
	"vertical" => 0,
	"correction" => 0,
	"print_matrix" => 0,
	"alphabet_options" => 0,
	"dna" => 1,
	"protein" => 1,
	"ascii_alphabet" => 0,
	"score" => 0,
	"range" => 0,
	"min_score" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"ascii_alphabet" => [
		"Each line contains a letter (a symbol in the alphabet) followed by an optional normalization number (default: 1.0). The normalization is based on the relative prior probabilities of the letters. For nucleic acids, this might be be the genomic frequency of the bases; however, if the -d option is not used, the frequencies observed in your own sequence data are used. In nucleic acid alphabets, a letter and its complement appear on the same line, separated by a colon (a letter can be its own complement, e.g. when using a dimer alphabet).",
		"Complementary letters may use the same normalization number. Only the standard 26 letters are permissible; however, when the -CS option is used, the alphabet is case sensitive so that a total of 52 different characters are possible.",
		"POSSIBLE LINE FORMATS WITHOUT COMPLEMENTARY LETTERS:",
		"letter",
		"letter normalization",
		"POSSIBLE LINE FORMATS WITH COMPLEMENTARY LETTERS:",
		"letter:complement",
		"letter:complement normalization",
		"letter:complement normalization:complement\'s_normalization",
	],
	"range" => [
		"This number is the difference between the largest and smallest integers used to estimate the scores. Higher values increase precision, but will take longer to calculate the table of p-values.",
	],
	"min_score" => [
		"Higher values will increase precision, but may miss interesting scores",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/patser.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

