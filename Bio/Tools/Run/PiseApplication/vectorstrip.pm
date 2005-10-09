# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::vectorstrip
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::vectorstrip

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::vectorstrip

      Bioperl class for:

	VECTORSTRIP	Strips out DNA between a pair of vector sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/vectorstrip.html 
         for available values):


		vectorstrip (String)

		init (String)

		sequence (Sequence)
			sequence -- dna [sequences] (-sequence)
			pipe: seqsfile

		vectorfile (Switch)
			Are your vector sequences in a file? (-vectorfile)

		vectors (InFile)
			Name of vectorfile (-vectors)

		mismatch (Integer)
			Max allowed % mismatch (-mismatch)

		besthits (Switch)
			Show only the best hits (minimise mismatches)? (-besthits)

		linkera (String)
			5' sequence (-linkera)

		linkerb (String)
			3' sequence (-linkerb)

		outf (OutFile)
			outf (-outf)

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

http://bioweb.pasteur.fr/seqanal/interfaces/vectorstrip.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::vectorstrip;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $vectorstrip = Bio::Tools::Run::PiseApplication::vectorstrip->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::vectorstrip object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $vectorstrip = $factory->program('vectorstrip');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::vectorstrip.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/vectorstrip.pm

    $self->{COMMAND}   = "vectorstrip";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VECTORSTRIP";

    $self->{DESCRIPTION}   = "Strips out DNA between a pair of vector sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/vectorstrip.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"vectorstrip",
	"init",
	"input",
	"required",
	"mismatch",
	"besthits",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"vectorstrip",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"required", 	# required Section
	"vectorfilesection", 	# vectorfilesection Section
	"vectorfile", 	# Are your vector sequences in a file? (-vectorfile)
	"vectors", 	# Name of vectorfile (-vectors)
	"mismatch", 	# Max allowed % mismatch (-mismatch)
	"besthits", 	# Show only the best hits (minimise mismatches)? (-besthits)
	"advanced", 	# advanced Section
	"linkera", 	# 5' sequence (-linkera)
	"linkerb", 	# 3' sequence (-linkerb)
	"output", 	# output Section
	"outf", 	# outf (-outf)
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"vectorstrip" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"vectorfilesection" => 'Paragraph',
	"vectorfile" => 'Switch',
	"vectors" => 'InFile',
	"mismatch" => 'Integer',
	"besthits" => 'Switch',
	"advanced" => 'Paragraph',
	"linkera" => 'String',
	"linkerb" => 'String',
	"output" => 'Paragraph',
	"outf" => 'OutFile',
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
	"required" => {
	},
	"vectorfilesection" => {
	},
	"vectorfile" => {
		"perl" => '($value)? "" : " -novectorfile"',
	},
	"vectors" => {
		"perl" => '" -vectors=$value"',
	},
	"mismatch" => {
		"perl" => '(defined $value && $value != $vdef)? " -mismatch=$value" : ""',
	},
	"besthits" => {
		"perl" => '($value)? "" : " -nobesthits"',
	},
	"advanced" => {
	},
	"linkera" => {
		"perl" => '($value)? " -linkera=$value" : ""',
	},
	"linkerb" => {
		"perl" => '($value)? " -linkerb=$value" : ""',
	},
	"output" => {
	},
	"outf" => {
		"perl" => '" -outf=$value"',
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
	"vectorstrip" => {
		"perl" => '"vectorstrip"',
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
	"vectorfile" => 2,
	"vectors" => 3,
	"mismatch" => 4,
	"besthits" => 5,
	"linkera" => 6,
	"linkerb" => 7,
	"outf" => 8,
	"outseq" => 9,
	"outseq_sformat" => 10,
	"auto" => 11,
	"vectorstrip" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"vectorstrip",
	"required",
	"vectorfilesection",
	"advanced",
	"output",
	"sequence",
	"vectorfile",
	"vectors",
	"mismatch",
	"besthits",
	"linkera",
	"linkerb",
	"outf",
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
	"required" => 0,
	"vectorfilesection" => 0,
	"vectorfile" => 0,
	"vectors" => 0,
	"mismatch" => 0,
	"besthits" => 0,
	"advanced" => 0,
	"linkera" => 0,
	"linkerb" => 0,
	"output" => 0,
	"outf" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"vectorstrip" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"vectorfilesection" => 0,
	"vectorfile" => 0,
	"vectors" => 0,
	"mismatch" => 0,
	"besthits" => 0,
	"advanced" => 0,
	"linkera" => 0,
	"linkerb" => 0,
	"output" => 0,
	"outf" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"vectorfilesection" => 0,
	"vectorfile" => 0,
	"vectors" => 1,
	"mismatch" => 0,
	"besthits" => 0,
	"advanced" => 0,
	"linkera" => 0,
	"linkerb" => 0,
	"output" => 0,
	"outf" => 1,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [sequences] (-sequence)",
	"required" => "required Section",
	"vectorfilesection" => "vectorfilesection Section",
	"vectorfile" => "Are your vector sequences in a file? (-vectorfile)",
	"vectors" => "Name of vectorfile (-vectors)",
	"mismatch" => "Max allowed % mismatch (-mismatch)",
	"besthits" => "Show only the best hits (minimise mismatches)? (-besthits)",
	"advanced" => "advanced Section",
	"linkera" => "5' sequence (-linkera)",
	"linkerb" => "3' sequence (-linkerb)",
	"output" => "output Section",
	"outf" => "outf (-outf)",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"vectorfilesection" => 0,
	"vectorfile" => 0,
	"vectors" => 0,
	"mismatch" => 0,
	"besthits" => 0,
	"advanced" => 0,
	"linkera" => 0,
	"linkerb" => 0,
	"output" => 0,
	"outf" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['vectorfilesection',],
	"vectorfilesection" => ['vectorfile','vectors',],
	"advanced" => ['linkera','linkerb',],
	"output" => ['outf','outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"vectorfile" => '1',
	"mismatch" => '10',
	"besthits" => '1',
	"outf" => 'outf.out',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"vectorfilesection" => { "perl" => '1' },
	"vectorfile" => { "perl" => '1' },
	"vectors" => {
		"acd" => '@($(vectorfile)?Y:N)',
	},
	"mismatch" => { "perl" => '1' },
	"besthits" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"linkera" => {
		"acd" => '@(!$(vectorfile))',
	},
	"linkerb" => {
		"acd" => '@(!$(vectorfile))',
	},
	"output" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
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
	"required" => 0,
	"vectorfilesection" => 0,
	"vectorfile" => 0,
	"vectors" => 0,
	"mismatch" => 0,
	"besthits" => 0,
	"advanced" => 0,
	"linkera" => 0,
	"linkerb" => 0,
	"output" => 0,
	"outf" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"vectorfilesection" => 0,
	"vectorfile" => 0,
	"vectors" => 1,
	"mismatch" => 0,
	"besthits" => 0,
	"advanced" => 0,
	"linkera" => 0,
	"linkerb" => 0,
	"output" => 0,
	"outf" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/vectorstrip.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

