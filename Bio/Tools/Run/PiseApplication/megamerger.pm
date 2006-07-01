# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::megamerger
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::megamerger

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::megamerger

      Bioperl class for:

	MEGAMERGER	Merge two large overlapping nucleic acid sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/megamerger.html 
         for available values):


		megamerger (String)

		init (String)

		seqa (Sequence)
			seqa -- DNA [single sequence] (-seqa)
			pipe: seqfile

		seqb (Sequence)
			seqb -- DNA [single sequence] (-seqb)

		wordsize (Integer)
			Word size (-wordsize)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

		report (OutFile)
			Output report (-report)

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

http://bioweb.pasteur.fr/seqanal/interfaces/megamerger.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::megamerger;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $megamerger = Bio::Tools::Run::PiseApplication::megamerger->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::megamerger object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $megamerger = $factory->program('megamerger');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::megamerger.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/megamerger.pm

    $self->{COMMAND}   = "megamerger";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MEGAMERGER";

    $self->{DESCRIPTION}   = "Merge two large overlapping nucleic acid sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:consensus",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/megamerger.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"megamerger",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"megamerger",
	"init",
	"input", 	# input Section
	"seqa", 	# seqa -- DNA [single sequence] (-seqa)
	"seqb", 	# seqb -- DNA [single sequence] (-seqb)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"report", 	# Output report (-report)
	"auto",

    ];

    $self->{TYPE}  = {
	"megamerger" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seqa" => 'Sequence',
	"seqb" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"report" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"seqa" => {
		"perl" => '" -seqa=$value -sformat=fasta"',
	},
	"seqb" => {
		"perl" => '" -seqb=$value -sformat=fasta"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"report" => {
		"perl" => '" -report=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"megamerger" => {
		"perl" => '"megamerger"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqa" => [8],
	"seqb" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"seqa" => 1,
	"seqb" => 2,
	"wordsize" => 3,
	"outseq" => 4,
	"outseq_sformat" => 5,
	"report" => 6,
	"auto" => 7,
	"megamerger" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"megamerger",
	"required",
	"seqa",
	"seqb",
	"wordsize",
	"outseq",
	"outseq_sformat",
	"report",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"report" => 0,
	"auto" => 1,
	"megamerger" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"report" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 1,
	"seqb" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"report" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"seqa" => "seqa -- DNA [single sequence] (-seqa)",
	"seqb" => "seqb -- DNA [single sequence] (-seqb)",
	"required" => "required Section",
	"wordsize" => "Word size (-wordsize)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"report" => "Output report (-report)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"report" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['seqa','seqb',],
	"required" => ['wordsize',],
	"output" => ['outseq','outseq_sformat','report',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '20',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"report" => 'report.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"seqa" => { "perl" => '1' },
	"seqb" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"wordsize" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"report" => { "perl" => '1' },
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
	"seqa" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"report" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 1,
	"seqb" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"report" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/megamerger.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

