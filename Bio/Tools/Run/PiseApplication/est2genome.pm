# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::est2genome
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::est2genome

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::est2genome

      Bioperl class for:

	EST2GENOME	Align EST and genomic DNA sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/est2genome.html 
         for available values):


		est2genome (String)

		init (String)

		est (Sequence)
			EST sequence(s) (-est)
			pipe: seqsfile

		genome (Sequence)
			Genomic sequence (-genome)
			pipe: seqfile

		match (Integer)
			Score for matching two bases (-match)

		mismatch (Integer)
			Cost for mismatching two bases (-mismatch)

		gappenalty (Integer)
			Gap penalty (-gappenalty)

		intronpenalty (Integer)
			Intron penalty (-intronpenalty)

		splicepenalty (Integer)
			Splice site penalty (-splicepenalty)

		minscore (Integer)
			Minimum accepted score (-minscore)

		reverse (Switch)
			Reverse orientation (-reverse)

		splice (Switch)
			Use donor and acceptor splice sites (-splice)

		mode (String)
			Comparison mode (-mode)

		best (Switch)
			Print out only best alignment (-best)

		space (Float)
			Space threshold (in megabytes) (-space)

		shuffle (Integer)
			Shuffle (-shuffle)

		seed (Integer)
			Random number seed (-seed)

		outfile (OutFile)
			outfile (-outfile)

		align (Switch)
			Show the alignment (-align)

		width (Integer)
			Alignment width (-width)

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

http://bioweb.pasteur.fr/seqanal/interfaces/est2genome.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::est2genome;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $est2genome = Bio::Tools::Run::PiseApplication::est2genome->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::est2genome object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $est2genome = $factory->program('est2genome');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::est2genome.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/est2genome.pm

    $self->{COMMAND}   = "est2genome";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EST2GENOME";

    $self->{DESCRIPTION}   = "Align EST and genomic DNA sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:global",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/est2genome.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"est2genome",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"est2genome",
	"init",
	"input", 	# input Section
	"est", 	# EST sequence(s) (-est)
	"genome", 	# Genomic sequence (-genome)
	"advanced", 	# advanced Section
	"match", 	# Score for matching two bases (-match)
	"mismatch", 	# Cost for mismatching two bases (-mismatch)
	"gappenalty", 	# Gap penalty (-gappenalty)
	"intronpenalty", 	# Intron penalty (-intronpenalty)
	"splicepenalty", 	# Splice site penalty (-splicepenalty)
	"minscore", 	# Minimum accepted score (-minscore)
	"reverse", 	# Reverse orientation (-reverse)
	"splice", 	# Use donor and acceptor splice sites (-splice)
	"mode", 	# Comparison mode (-mode)
	"best", 	# Print out only best alignment (-best)
	"space", 	# Space threshold (in megabytes) (-space)
	"shuffle", 	# Shuffle (-shuffle)
	"seed", 	# Random number seed (-seed)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"align", 	# Show the alignment (-align)
	"width", 	# Alignment width (-width)
	"auto",

    ];

    $self->{TYPE}  = {
	"est2genome" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"est" => 'Sequence',
	"genome" => 'Sequence',
	"advanced" => 'Paragraph',
	"match" => 'Integer',
	"mismatch" => 'Integer',
	"gappenalty" => 'Integer',
	"intronpenalty" => 'Integer',
	"splicepenalty" => 'Integer',
	"minscore" => 'Integer',
	"reverse" => 'Switch',
	"splice" => 'Switch',
	"mode" => 'String',
	"best" => 'Switch',
	"space" => 'Float',
	"shuffle" => 'Integer',
	"seed" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"align" => 'Switch',
	"width" => 'Integer',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"est" => {
		"perl" => '" -est=$value -sformat=fasta"',
	},
	"genome" => {
		"perl" => '" -genome=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"match" => {
		"perl" => '(defined $value && $value != $vdef)? " -match=$value" : ""',
	},
	"mismatch" => {
		"perl" => '(defined $value && $value != $vdef)? " -mismatch=$value" : ""',
	},
	"gappenalty" => {
		"perl" => '(defined $value && $value != $vdef)? " -gappenalty=$value" : ""',
	},
	"intronpenalty" => {
		"perl" => '(defined $value && $value != $vdef)? " -intronpenalty=$value" : ""',
	},
	"splicepenalty" => {
		"perl" => '(defined $value && $value != $vdef)? " -splicepenalty=$value" : ""',
	},
	"minscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -minscore=$value" : ""',
	},
	"reverse" => {
		"perl" => '($value)? " -reverse" : ""',
	},
	"splice" => {
		"perl" => '($value)? "" : " -nosplice"',
	},
	"mode" => {
		"perl" => '($value && $value ne $vdef)? " -mode=$value" : ""',
	},
	"best" => {
		"perl" => '($value)? "" : " -nobest"',
	},
	"space" => {
		"perl" => '(defined $value && $value != $vdef)? " -space=$value" : ""',
	},
	"shuffle" => {
		"perl" => '($value)? " -shuffle=$value" : ""',
	},
	"seed" => {
		"perl" => '(defined $value && $value != $vdef)? " -seed=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"align" => {
		"perl" => '($value)? " -align" : ""',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"est2genome" => {
		"perl" => '"est2genome"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"est" => [8],
	"genome" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"est" => 1,
	"genome" => 2,
	"match" => 3,
	"mismatch" => 4,
	"gappenalty" => 5,
	"intronpenalty" => 6,
	"splicepenalty" => 7,
	"minscore" => 8,
	"reverse" => 9,
	"splice" => 10,
	"mode" => 11,
	"best" => 12,
	"space" => 13,
	"shuffle" => 14,
	"seed" => 15,
	"outfile" => 16,
	"align" => 17,
	"width" => 18,
	"auto" => 19,
	"est2genome" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"est2genome",
	"est",
	"genome",
	"match",
	"mismatch",
	"gappenalty",
	"intronpenalty",
	"splicepenalty",
	"minscore",
	"reverse",
	"splice",
	"mode",
	"best",
	"space",
	"shuffle",
	"seed",
	"outfile",
	"align",
	"width",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"est" => 0,
	"genome" => 0,
	"advanced" => 0,
	"match" => 0,
	"mismatch" => 0,
	"gappenalty" => 0,
	"intronpenalty" => 0,
	"splicepenalty" => 0,
	"minscore" => 0,
	"reverse" => 0,
	"splice" => 0,
	"mode" => 0,
	"best" => 0,
	"space" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"output" => 0,
	"outfile" => 0,
	"align" => 0,
	"width" => 0,
	"auto" => 1,
	"est2genome" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"est" => 0,
	"genome" => 0,
	"advanced" => 0,
	"match" => 0,
	"mismatch" => 0,
	"gappenalty" => 0,
	"intronpenalty" => 0,
	"splicepenalty" => 0,
	"minscore" => 0,
	"reverse" => 0,
	"splice" => 0,
	"mode" => 0,
	"best" => 0,
	"space" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"output" => 0,
	"outfile" => 0,
	"align" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"est" => 1,
	"genome" => 1,
	"advanced" => 0,
	"match" => 0,
	"mismatch" => 0,
	"gappenalty" => 0,
	"intronpenalty" => 0,
	"splicepenalty" => 0,
	"minscore" => 0,
	"reverse" => 0,
	"splice" => 0,
	"mode" => 0,
	"best" => 0,
	"space" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"output" => 0,
	"outfile" => 1,
	"align" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"est" => "EST sequence(s) (-est)",
	"genome" => "Genomic sequence (-genome)",
	"advanced" => "advanced Section",
	"match" => "Score for matching two bases (-match)",
	"mismatch" => "Cost for mismatching two bases (-mismatch)",
	"gappenalty" => "Gap penalty (-gappenalty)",
	"intronpenalty" => "Intron penalty (-intronpenalty)",
	"splicepenalty" => "Splice site penalty (-splicepenalty)",
	"minscore" => "Minimum accepted score (-minscore)",
	"reverse" => "Reverse orientation (-reverse)",
	"splice" => "Use donor and acceptor splice sites (-splice)",
	"mode" => "Comparison mode (-mode)",
	"best" => "Print out only best alignment (-best)",
	"space" => "Space threshold (in megabytes) (-space)",
	"shuffle" => "Shuffle (-shuffle)",
	"seed" => "Random number seed (-seed)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"align" => "Show the alignment (-align)",
	"width" => "Alignment width (-width)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"est" => 0,
	"genome" => 0,
	"advanced" => 0,
	"match" => 0,
	"mismatch" => 0,
	"gappenalty" => 0,
	"intronpenalty" => 0,
	"splicepenalty" => 0,
	"minscore" => 0,
	"reverse" => 0,
	"splice" => 0,
	"mode" => 0,
	"best" => 0,
	"space" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"output" => 0,
	"outfile" => 0,
	"align" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['est','genome',],
	"advanced" => ['match','mismatch','gappenalty','intronpenalty','splicepenalty','minscore','reverse','splice','mode','best','space','shuffle','seed',],
	"output" => ['outfile','align','width',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"match" => '1',
	"mismatch" => '1',
	"gappenalty" => '2',
	"intronpenalty" => '40',
	"splicepenalty" => '20',
	"minscore" => '30',
	"splice" => '1',
	"mode" => 'both',
	"best" => '1',
	"space" => '10.0',
	"seed" => '20825',
	"outfile" => 'outfile.out',
	"width" => '50',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"est" => { "perl" => '1' },
	"genome" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"match" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"gappenalty" => { "perl" => '1' },
	"intronpenalty" => { "perl" => '1' },
	"splicepenalty" => { "perl" => '1' },
	"minscore" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"splice" => { "perl" => '1' },
	"mode" => { "perl" => '1' },
	"best" => { "perl" => '1' },
	"space" => { "perl" => '1' },
	"shuffle" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"align" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"est" => {
		 "seqsfile" => '1',
	},
	"genome" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"est" => 0,
	"genome" => 0,
	"advanced" => 0,
	"match" => 0,
	"mismatch" => 0,
	"gappenalty" => 0,
	"intronpenalty" => 0,
	"splicepenalty" => 0,
	"minscore" => 0,
	"reverse" => 0,
	"splice" => 0,
	"mode" => 0,
	"best" => 0,
	"space" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"output" => 0,
	"outfile" => 0,
	"align" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"est" => 1,
	"genome" => 1,
	"advanced" => 0,
	"match" => 0,
	"mismatch" => 0,
	"gappenalty" => 0,
	"intronpenalty" => 0,
	"splicepenalty" => 0,
	"minscore" => 0,
	"reverse" => 0,
	"splice" => 0,
	"mode" => 0,
	"best" => 0,
	"space" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"output" => 0,
	"outfile" => 1,
	"align" => 0,
	"width" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"gappenalty" => [
		"Cost for deleting a single base in either sequence, excluding introns",
	],
	"intronpenalty" => [
		"Cost for an intron, independent of length.",
	],
	"splicepenalty" => [
		"Cost for an intron, independent of length and starting/ending on donor-acceptor sites",
	],
	"minscore" => [
		"Exclude alignments with scores below this threshold score.",
	],
	"reverse" => [
		"Reverse the orientation of the EST sequence",
	],
	"splice" => [
		"Use donor and acceptor splice sites. If you want to ignore donor-acceptor sites then set this to be false.",
	],
	"mode" => [
		"This determines the comparion mode. The default value is \'both\', in which case both strands of the est are compared assuming a forward gene direction (ie GT/AG splice sites), and the best comparsion redone assuming a reversed (CT/AC) gene splicing direction. The other allowed modes are \'forward\', when just the forward strand is searched, and \'reverse\', ditto for the reverse strand.",
	],
	"best" => [
		"You can print out all comparisons instead of just the best one by setting this to be false.",
	],
	"space" => [
		"for linear-space recursion. If product of sequence lengths divided by 4 exceeds this then a divide-and-conquer strategy is used to control the memory requirements. In this way very long sequences can be aligned. <BR> If you have a machine with plenty of memory you can raise this parameter (but do not exceed the machine\'s physical RAM)",
	],
	"align" => [
		"Show the alignment. The alignment includes the first and last 5 bases of each intron, together with the intron width. The direction of splicing is indicated by angle brackets (forward or reverse) or ???? (unknown).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/est2genome.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

