# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::newseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::newseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::newseq

      Bioperl class for:

	NEWSEQ	Type in a short new sequence. (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/newseq.html 
         for available values):


		newseq (String)

		init (String)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

		name (String)
			Name of the sequence (-name)

		description (String)
			Description of the sequence (-description)

		type (Excl)
			Type of sequence -- Type of sequence (-type)

		sequence (String)
			Enter the sequence (-sequence)

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

  http://bugzilla.open-bio.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/newseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::newseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $newseq = Bio::Tools::Run::PiseApplication::newseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::newseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $newseq = $factory->program('newseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::newseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/newseq.pm

    $self->{COMMAND}   = "newseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "NEWSEQ";

    $self->{DESCRIPTION}   = "Type in a short new sequence. (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/newseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"newseq",
	"init",
	"output",
	"required",
	"input",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"newseq",
	"init",
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"required", 	# required Section
	"name", 	# Name of the sequence (-name)
	"description", 	# Description of the sequence (-description)
	"type", 	# Type of sequence -- Type of sequence (-type)
	"input", 	# input Section
	"sequence", 	# Enter the sequence (-sequence)
	"auto",

    ];

    $self->{TYPE}  = {
	"newseq" => 'String',
	"init" => 'String',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"required" => 'Paragraph',
	"name" => 'String',
	"description" => 'String',
	"type" => 'Excl',
	"input" => 'Paragraph',
	"sequence" => 'String',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"required" => {
	},
	"name" => {
		"perl" => '" -name=$value"',
	},
	"description" => {
		"perl" => '" -description=$value"',
	},
	"type" => {
		"perl" => '" -type=$value"',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"newseq" => {
		"perl" => '"newseq"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"outseq" => 1,
	"outseq_sformat" => 2,
	"name" => 3,
	"description" => 4,
	"type" => 5,
	"sequence" => 6,
	"auto" => 7,
	"newseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"output",
	"required",
	"input",
	"newseq",
	"outseq",
	"outseq_sformat",
	"name",
	"description",
	"type",
	"sequence",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"required" => 0,
	"name" => 0,
	"description" => 0,
	"type" => 0,
	"input" => 0,
	"sequence" => 0,
	"auto" => 1,
	"newseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"required" => 0,
	"name" => 0,
	"description" => 0,
	"type" => 0,
	"input" => 0,
	"sequence" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"required" => 0,
	"name" => 1,
	"description" => 1,
	"type" => 1,
	"input" => 0,
	"sequence" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"required" => "required Section",
	"name" => "Name of the sequence (-name)",
	"description" => "Description of the sequence (-description)",
	"type" => "Type of sequence -- Type of sequence (-type)",
	"input" => "input Section",
	"sequence" => "Enter the sequence (-sequence)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"required" => 0,
	"name" => 0,
	"description" => 0,
	"type" => 0,
	"input" => 0,
	"sequence" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
	"required" => ['name','description','type',],
	"type" => ['N','Nucleic','P','Protein',],
	"input" => ['sequence',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"type" => 'N',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
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

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"required" => 0,
	"name" => 0,
	"description" => 0,
	"type" => 0,
	"input" => 0,
	"sequence" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"required" => 0,
	"name" => 1,
	"description" => 1,
	"type" => 1,
	"input" => 0,
	"sequence" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"name" => [
		"The name of of the sequence should be a single word that you will use to identify the sequence. It should have no (or few) punctuation characters in it.",
	],
	"description" => [
		"Enter any description of the sequence that you require.",
	],
	"sequence" => [
		"The sequence itself. <BR> Because of the limitation of the operating system, you will only be able to type in a short sequence of (typically) 250 characters, or so. <BR> The keyboard will beep at you when you have reached this limit and you will not be able to press the RETURN/ENTER key until you have deleted a few characters.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/newseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

