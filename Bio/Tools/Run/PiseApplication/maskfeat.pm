# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::maskfeat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::maskfeat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::maskfeat

      Bioperl class for:

	MASKFEAT	Mask off features of a sequence. (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/maskfeat.html 
         for available values):


		maskfeat (String)

		init (String)

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		type (String)
			Type of feature to mask (-type)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

		maskchar (String)
			Character to mask with (-maskchar)

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

http://bioweb.pasteur.fr/seqanal/interfaces/maskfeat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::maskfeat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $maskfeat = Bio::Tools::Run::PiseApplication::maskfeat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::maskfeat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $maskfeat = $factory->program('maskfeat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::maskfeat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/maskfeat.pm

    $self->{COMMAND}   = "maskfeat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MASKFEAT";

    $self->{DESCRIPTION}   = "Mask off features of a sequence. (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",

         "feature tables",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/maskfeat.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"maskfeat",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"maskfeat",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"advanced", 	# advanced Section
	"type", 	# Type of feature to mask (-type)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"maskchar", 	# Character to mask with (-maskchar)
	"auto",

    ];

    $self->{TYPE}  = {
	"maskfeat" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"type" => 'String',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"maskchar" => 'String',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value"',
	},
	"advanced" => {
	},
	"type" => {
		"perl" => '($value && ($value ne $vdef || ($value .= "*")))? " -type=$value" : ""',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"maskchar" => {
		"perl" => '($value && $value ne $vdef)? " -maskchar=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"maskfeat" => {
		"perl" => '"maskfeat"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [2,4,14],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"type" => 2,
	"outseq" => 3,
	"outseq_sformat" => 4,
	"maskchar" => 5,
	"auto" => 6,
	"maskfeat" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"maskfeat",
	"sequence",
	"type",
	"outseq",
	"outseq_sformat",
	"maskchar",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"type" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 1,
	"maskfeat" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"type" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"type" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"type" => "Type of feature to mask (-type)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"maskchar" => "Character to mask with (-maskchar)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"type" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['type',],
	"output" => ['outseq','outseq_sformat','maskchar',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"type" => 'repeat',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"maskchar" => '',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"maskchar" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqfile",
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
	"type" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"type" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"type" => [
		"By default any feature in the feature table with a type starting \'repeat\' is masked. You can set this to be any feature type you wish to mask. <BR> See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types. <BR> The type may be wildcarded by using \'*\'. <BR> If you wish to mask more than one type, separate their names with spaces or commas, eg: <BR> *UTR repeat*",
	],
	"maskchar" => [
		"Character to use when masking. <BR> Default is \'X\' for protein sequences, \'N\' for nucleic sequences.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/maskfeat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

