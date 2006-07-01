# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::tranalign
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::tranalign

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::tranalign

      Bioperl class for:

	TRANALIGN	Align nucleic coding regions given the aligned proteins (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/tranalign.html 
         for available values):


		tranalign (String)

		init (String)

		nsequence (Sequence)
			Nucleotide sequences to be aligned (-nsequence)
			pipe: seqsfile

		psequence (Sequence)
			Protein sequence alignment (-psequence)

		table (Excl)
			Code to use -- Genetic codes (-table)

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

http://bioweb.pasteur.fr/seqanal/interfaces/tranalign.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::tranalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $tranalign = Bio::Tools::Run::PiseApplication::tranalign->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::tranalign object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $tranalign = $factory->program('tranalign');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::tranalign.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/tranalign.pm

    $self->{COMMAND}   = "tranalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TRANALIGN";

    $self->{DESCRIPTION}   = "Align nucleic coding regions given the aligned proteins (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/tranalign.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"tranalign",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"tranalign",
	"init",
	"input", 	# input Section
	"nsequence", 	# Nucleotide sequences to be aligned (-nsequence)
	"psequence", 	# Protein sequence alignment (-psequence)
	"advanced", 	# advanced Section
	"table", 	# Code to use -- Genetic codes (-table)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"tranalign" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"nsequence" => 'Sequence',
	"psequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"table" => 'Excl',
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
	"nsequence" => {
		"perl" => '" -nsequence=$value -sformat=fasta"',
	},
	"psequence" => {
		"perl" => '" -psequence=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"table" => {
		"perl" => '" -table=$value"',
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
	"tranalign" => {
		"perl" => '"tranalign"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"nsequence" => [8],
	"psequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"nsequence" => 1,
	"psequence" => 2,
	"table" => 3,
	"outseq" => 4,
	"outseq_sformat" => 5,
	"auto" => 6,
	"tranalign" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"tranalign",
	"advanced",
	"nsequence",
	"psequence",
	"table",
	"outseq",
	"outseq_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"nsequence" => 0,
	"psequence" => 0,
	"advanced" => 0,
	"table" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"tranalign" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"nsequence" => 0,
	"psequence" => 0,
	"advanced" => 0,
	"table" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"nsequence" => 1,
	"psequence" => 1,
	"advanced" => 0,
	"table" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"nsequence" => "Nucleotide sequences to be aligned (-nsequence)",
	"psequence" => "Protein sequence alignment (-psequence)",
	"advanced" => "advanced Section",
	"table" => "Code to use -- Genetic codes (-table)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"nsequence" => 0,
	"psequence" => 0,
	"advanced" => 0,
	"table" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['nsequence','psequence',],
	"advanced" => ['table',],
	"table" => ['0','Standard','1','Standard (with alternative initiation codons)','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear','16','Chlorophycean Mitochondrial','21','Trematode Mitochondrial','22','Scenedesmus obliquus','23','Thraustochytrium Mitochondrial',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"table" => '0',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"nsequence" => { "perl" => '1' },
	"psequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"table" => { "perl" => '1' },
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
	"nsequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"nsequence" => 0,
	"psequence" => 0,
	"advanced" => 0,
	"table" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"nsequence" => 1,
	"psequence" => 1,
	"advanced" => 0,
	"table" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/tranalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

