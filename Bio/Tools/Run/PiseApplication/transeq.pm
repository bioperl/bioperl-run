# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::transeq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::transeq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::transeq

      Bioperl class for:

	TRANSEQ	Translate nucleic acid sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/transeq.html 
         for available values):


		transeq (String)

		init (String)

		sequence (Sequence)
			sequence -- nucleotide [sequences] (-sequence)
			pipe: seqsfile

		frame (List)
			Frame(s) to translate -- Translation frames [select  values] (-frame)

		table (Excl)
			Code to use -- Genetic codes (-table)

		regions (Integer)
			Regions to translate (eg: 4-57,78-94) (-regions)

		trim (Switch)
			Trim trailing X's and *'s (-trim)

		alternative (Switch)
			Define frame '-1' as starting in the last codon (-alternative)

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

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

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

http://bioweb.pasteur.fr/seqanal/interfaces/transeq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::transeq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $transeq = Bio::Tools::Run::PiseApplication::transeq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::transeq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $transeq = $factory->program('transeq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::transeq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/transeq.pm

    $self->{COMMAND}   = "transeq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TRANSEQ";

    $self->{DESCRIPTION}   = "Translate nucleic acid sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:translation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/transeq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"transeq",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"transeq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- nucleotide [sequences] (-sequence)
	"advanced", 	# advanced Section
	"frame", 	# Frame(s) to translate -- Translation frames [select  values] (-frame)
	"table", 	# Code to use -- Genetic codes (-table)
	"regions", 	# Regions to translate (eg: 4-57,78-94) (-regions)
	"trim", 	# Trim trailing X's and *'s (-trim)
	"alternative", 	# Define frame '-1' as starting in the last codon (-alternative)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"transeq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"frame" => 'List',
	"table" => 'Excl',
	"regions" => 'Integer',
	"trim" => 'Switch',
	"alternative" => 'Switch',
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
	"frame" => {
		"perl" => '" -frame=$value"',
	},
	"table" => {
		"perl" => '" -table=$value"',
	},
	"regions" => {
		"perl" => '(defined $value && $value != $vdef)? " -regions=$value" : ""',
	},
	"trim" => {
		"perl" => '($value)? " -trim" : ""',
	},
	"alternative" => {
		"perl" => '($value)? " -alternative" : ""',
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
	"transeq" => {
		"perl" => '"transeq"',
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
	"frame" => 2,
	"table" => 3,
	"regions" => 4,
	"trim" => 5,
	"alternative" => 6,
	"outseq" => 7,
	"outseq_sformat" => 8,
	"auto" => 9,
	"transeq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"transeq",
	"sequence",
	"frame",
	"table",
	"regions",
	"trim",
	"alternative",
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
	"frame" => 0,
	"table" => 0,
	"regions" => 0,
	"trim" => 0,
	"alternative" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"transeq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"frame" => 0,
	"table" => 0,
	"regions" => 0,
	"trim" => 0,
	"alternative" => 0,
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
	"frame" => 1,
	"table" => 1,
	"regions" => 0,
	"trim" => 0,
	"alternative" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- nucleotide [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"frame" => "Frame(s) to translate -- Translation frames [select  values] (-frame)",
	"table" => "Code to use -- Genetic codes (-table)",
	"regions" => "Regions to translate (eg: 4-57,78-94) (-regions)",
	"trim" => "Trim trailing X's and *'s (-trim)",
	"alternative" => "Define frame '-1' as starting in the last codon (-alternative)",
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
	"frame" => 0,
	"table" => 0,
	"regions" => 0,
	"trim" => 0,
	"alternative" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['frame','table','regions','trim','alternative',],
	"frame" => ['1','1','2','2','3','3','F','Forward three frames','-1','-1','-2','-2','-3','-3','R','Reverse three frames','6','All six frames',],
	"table" => ['0','Standard','1','Standard (with alternative initiation codons)','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear','16','Chlorophycean Mitochondrial','21','Trematode Mitochondrial','22','Scenedesmus obliquus','23','Thraustochytrium Mitochondrial',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"frame" => ",",

    };

    $self->{VDEF}  = {
	"frame" => ['1',],
	"table" => '0',
	"regions" => '',
	"trim" => '0',
	"alternative" => '0',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"frame" => { "perl" => '1' },
	"table" => { "perl" => '1' },
	"regions" => { "perl" => '1' },
	"trim" => { "perl" => '1' },
	"alternative" => { "perl" => '1' },
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
	"frame" => 0,
	"table" => 0,
	"regions" => 0,
	"trim" => 0,
	"alternative" => 0,
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
	"frame" => 1,
	"table" => 1,
	"regions" => 0,
	"trim" => 0,
	"alternative" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"regions" => [
		"Regions to translate. <BR> If this is left blank, then the complete sequence is translated. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are separated by any non-digit, non-alpha character. <BR> Examples of region specifications are: <BR> 24-45, 56-78 <BR> 1:45, 67=99;765..888 <BR> 1,5,8,10,23,45,57,99 <BR> Note: you should not try to use this option with any other frame than the default, -frame=1",
	],
	"trim" => [
		"This removes all X and * characters from the right end of the translation. The trimming process starts at the end and continues until the next character is not a X or a *",
	],
	"alternative" => [
		"The default definition of frame \'-1\' is the reverse-complement of the set of codons used in frame 1.  (Frame -2 is the set of codons used by frame 2, similarly frames -3 and 3).  This is a common standard, used by the Staden package and other programs.  If you prefer to define frame \'-1\' as using the set of codons starting with the last codon of the sequence, then set this to be true.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/transeq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

