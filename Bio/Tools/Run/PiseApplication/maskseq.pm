# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::maskseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::maskseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::maskseq

      Bioperl class for:

	MASKSEQ	Mask off regions of a sequence. (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/maskseq.html 
         for available values):


		maskseq (String)

		init (String)

		sequence (Sequence)
			sequence -- any [single sequence] (-sequence)
			pipe: seqfile

		regions (Integer)
			Regions to mask (eg: 4-57,78-94) (-regions)

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

http://bioweb.pasteur.fr/seqanal/interfaces/maskseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::maskseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $maskseq = Bio::Tools::Run::PiseApplication::maskseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::maskseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $maskseq = $factory->program('maskseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::maskseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/maskseq.pm

    $self->{COMMAND}   = "maskseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MASKSEQ";

    $self->{DESCRIPTION}   = "Mask off regions of a sequence. (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/maskseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"maskseq",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"maskseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [single sequence] (-sequence)
	"required", 	# required Section
	"regions", 	# Regions to mask (eg: 4-57,78-94) (-regions)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"maskchar", 	# Character to mask with (-maskchar)
	"auto",

    ];

    $self->{TYPE}  = {
	"maskseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"regions" => 'Integer',
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
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"regions" => {
		"perl" => '" -regions=$value"',
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
	"maskseq" => {
		"perl" => '"maskseq"',
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
	"regions" => 2,
	"outseq" => 3,
	"outseq_sformat" => 4,
	"maskchar" => 5,
	"auto" => 6,
	"maskseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"maskseq",
	"sequence",
	"regions",
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
	"required" => 0,
	"regions" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 1,
	"maskseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"regions" => 0,
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
	"required" => 0,
	"regions" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [single sequence] (-sequence)",
	"required" => "required Section",
	"regions" => "Regions to mask (eg: 4-57,78-94) (-regions)",
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
	"required" => 0,
	"regions" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['regions',],
	"output" => ['outseq','outseq_sformat','maskchar',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"maskchar" => '',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"regions" => { "perl" => '1' },
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
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"regions" => 0,
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
	"required" => 0,
	"regions" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"maskchar" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"regions" => [
		"Regions to mask. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are separated by any non-digit, non-alpha character. <BR> Examples of region specifications are: <BR> 24-45, 56-78 <BR> 1:45, 67=99;765..888 <BR> 1,5,8,10,23,45,57,99",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/maskseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

