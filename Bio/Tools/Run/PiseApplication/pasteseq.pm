# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pasteseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pasteseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pasteseq

      Bioperl class for:

	PASTESEQ	Insert one sequence into another (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pasteseq.html 
         for available values):


		pasteseq (String)

		init (String)

		sequence (Sequence)
			sequence -- any [single sequence] (-sequence)
			pipe: seqfile

		insseq (Sequence)
			Sequence to insert (-insseq)

		pos (Integer)
			Position to insert after (-pos)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

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

http://bioweb.pasteur.fr/seqanal/interfaces/pasteseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pasteseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pasteseq = Bio::Tools::Run::PiseApplication::pasteseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pasteseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pasteseq = $factory->program('pasteseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pasteseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pasteseq.pm

    $self->{COMMAND}   = "pasteseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PASTESEQ";

    $self->{DESCRIPTION}   = "Insert one sequence into another (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pasteseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pasteseq",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pasteseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [single sequence] (-sequence)
	"insseq", 	# Sequence to insert (-insseq)
	"required", 	# required Section
	"pos", 	# Position to insert after (-pos)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"pasteseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"insseq" => 'Sequence',
	"required" => 'Paragraph',
	"pos" => 'Integer',
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
	"insseq" => {
		"perl" => '" -insseq=$value -sformat=fasta"',
	},
	"required" => {
	},
	"pos" => {
		"perl" => '" -pos=$value"',
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
	"pasteseq" => {
		"perl" => '"pasteseq"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],
	"insseq" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"insseq" => 2,
	"pos" => 3,
	"outseq" => 4,
	"outseq_sformat" => 5,
	"auto" => 6,
	"pasteseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"pasteseq",
	"required",
	"sequence",
	"insseq",
	"pos",
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
	"insseq" => 0,
	"required" => 0,
	"pos" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"pasteseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"insseq" => 0,
	"required" => 0,
	"pos" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"insseq" => 1,
	"required" => 0,
	"pos" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [single sequence] (-sequence)",
	"insseq" => "Sequence to insert (-insseq)",
	"required" => "required Section",
	"pos" => "Position to insert after (-pos)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"insseq" => 0,
	"required" => 0,
	"pos" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence','insseq',],
	"required" => ['pos',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"insseq" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"pos" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
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
	"insseq" => 0,
	"required" => 0,
	"pos" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"insseq" => 1,
	"required" => 0,
	"pos" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"pos" => [
		"The position in the main input sequence to insert after. <BR> To insert before the start use the position 0.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pasteseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

