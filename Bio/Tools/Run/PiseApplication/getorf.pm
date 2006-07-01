# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::getorf
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::getorf

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::getorf

      Bioperl class for:

	GETORF	Finds and extracts open reading frames (ORFs) (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/getorf.html 
         for available values):


		getorf (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		table (Excl)
			Code to use -- Genetic codes (-table)

		minsize (Integer)
			Minimum nucleotide size of ORF to report (-minsize)

		find (Excl)
			Type of output -- Type of sequence to output (-find)

		methionine (Switch)
			Change initial START codons to Methionine (-methionine)

		circular (Switch)
			Is the sequence circular (-circular)

		reverse (Switch)
			Find ORFs in the reverse sequence (-reverse)

		flanking (Integer)
			Number of flanking nucleotides to report (-flanking)

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

http://bioweb.pasteur.fr/seqanal/interfaces/getorf.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::getorf;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $getorf = Bio::Tools::Run::PiseApplication::getorf->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::getorf object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $getorf = $factory->program('getorf');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::getorf.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/getorf.pm

    $self->{COMMAND}   = "getorf";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "GETORF";

    $self->{DESCRIPTION}   = "Finds and extracts open reading frames (ORFs) (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:gene finding",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/getorf.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"getorf",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"getorf",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"advanced", 	# advanced Section
	"table", 	# Code to use -- Genetic codes (-table)
	"minsize", 	# Minimum nucleotide size of ORF to report (-minsize)
	"find", 	# Type of output -- Type of sequence to output (-find)
	"methionine", 	# Change initial START codons to Methionine (-methionine)
	"circular", 	# Is the sequence circular (-circular)
	"reverse", 	# Find ORFs in the reverse sequence (-reverse)
	"flanking", 	# Number of flanking nucleotides to report (-flanking)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"getorf" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"table" => 'Excl',
	"minsize" => 'Integer',
	"find" => 'Excl',
	"methionine" => 'Switch',
	"circular" => 'Switch',
	"reverse" => 'Switch',
	"flanking" => 'Integer',
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
	"table" => {
		"perl" => '" -table=$value"',
	},
	"minsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -minsize=$value" : ""',
	},
	"find" => {
		"perl" => '" -find=$value"',
	},
	"methionine" => {
		"perl" => '($value)? "" : " -nomethionine"',
	},
	"circular" => {
		"perl" => '($value)? " -circular" : ""',
	},
	"reverse" => {
		"perl" => '($value)? "" : " -noreverse"',
	},
	"flanking" => {
		"perl" => '(defined $value && $value != $vdef)? " -flanking=$value" : ""',
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
	"getorf" => {
		"perl" => '"getorf"',
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
	"table" => 2,
	"minsize" => 3,
	"find" => 4,
	"methionine" => 5,
	"circular" => 6,
	"reverse" => 7,
	"flanking" => 8,
	"outseq" => 9,
	"outseq_sformat" => 10,
	"auto" => 11,
	"getorf" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"getorf",
	"sequence",
	"table",
	"minsize",
	"find",
	"methionine",
	"circular",
	"reverse",
	"flanking",
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
	"table" => 0,
	"minsize" => 0,
	"find" => 0,
	"methionine" => 0,
	"circular" => 0,
	"reverse" => 0,
	"flanking" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"getorf" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"table" => 0,
	"minsize" => 0,
	"find" => 0,
	"methionine" => 0,
	"circular" => 0,
	"reverse" => 0,
	"flanking" => 0,
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
	"table" => 1,
	"minsize" => 0,
	"find" => 1,
	"methionine" => 0,
	"circular" => 0,
	"reverse" => 0,
	"flanking" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"table" => "Code to use -- Genetic codes (-table)",
	"minsize" => "Minimum nucleotide size of ORF to report (-minsize)",
	"find" => "Type of output -- Type of sequence to output (-find)",
	"methionine" => "Change initial START codons to Methionine (-methionine)",
	"circular" => "Is the sequence circular (-circular)",
	"reverse" => "Find ORFs in the reverse sequence (-reverse)",
	"flanking" => "Number of flanking nucleotides to report (-flanking)",
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
	"table" => 0,
	"minsize" => 0,
	"find" => 0,
	"methionine" => 0,
	"circular" => 0,
	"reverse" => 0,
	"flanking" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['table','minsize','find','methionine','circular','reverse','flanking',],
	"table" => ['0','Standard','1','Standard (with alternative initiation codons)','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear','16','Chlorophycean Mitochondrial','21','Trematode Mitochondrial','22','Scenedesmus obliquus','23','Thraustochytrium Mitochondrial',],
	"find" => ['0','Translation of regions between STOP codons','1','Translation of regions between START and STOP codons','2','Nucleic sequences between STOP codons','3','Nucleic sequences between START and STOP codons','4','Nucleotides flanking START codons','5','Nucleotides flanking initial STOP codons','6','Nucleotides flanking ending STOP codons',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"table" => '0',
	"minsize" => '30',
	"find" => '0',
	"methionine" => '1',
	"circular" => '0',
	"reverse" => '1',
	"flanking" => '100',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"table" => { "perl" => '1' },
	"minsize" => { "perl" => '1' },
	"find" => { "perl" => '1' },
	"methionine" => { "perl" => '1' },
	"circular" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"flanking" => { "perl" => '1' },
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
	"table" => 0,
	"minsize" => 0,
	"find" => 0,
	"methionine" => 0,
	"circular" => 0,
	"reverse" => 0,
	"flanking" => 0,
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
	"table" => 1,
	"minsize" => 0,
	"find" => 1,
	"methionine" => 0,
	"circular" => 0,
	"reverse" => 0,
	"flanking" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"find" => [
		"This is a small menu of possible output options. The first four options are to select either the protein translation or the original nucleic acid sequence of the open reading frame. There are two possible definitions of an open reading frame: it can either be a region that is free of STOP codons or a region that begins with a START codon and ends with a STOP codon. The last three options are probably only of interest to people who wish to investigate the statistical properties of the regions around potential START or STOP codons. The last option assumes that ORF lengths are calculated between two STOP codons.",
	],
	"methionine" => [
		"START codons at the beginning of protein products will usually code for Methionine, despite what the codon will code for when it is internal to a protein. This qualifier sets all such START codons to code for Methionine by default.",
	],
	"reverse" => [
		"Set this to be false if you do not wish to find ORFs in the reverse complement of the sequence.",
	],
	"flanking" => [
		"If you have chosen one of the options of the type of sequence to find that gives the flanking sequence around a STOP or START codon, this allows you to set the number of nucleotides either side of that codon to output. If the region of flanking nucleotides crosses the start or end of the sequence, no output is given for this codon.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/getorf.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

