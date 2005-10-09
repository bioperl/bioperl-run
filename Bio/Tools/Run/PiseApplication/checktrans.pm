# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::checktrans
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::checktrans

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::checktrans

      Bioperl class for:

	CHECKTRANS	Reports STOP codons and ORF statistics of a protein (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/checktrans.html 
         for available values):


		checktrans (String)

		init (String)

		sequence (Sequence)
			sequence -- stopprotein [sequences] (-sequence)
			pipe: seqsfile

		orfml (Integer)
			Minimum ORF Length to report (-orfml)

		report (OutFile)
			report (-report)

		outseq (OutFile)
			Sequence file to hold output ORF sequences (-outseq)
			pipe: seqsfile

		outseq_sformat (Excl)
			Output format for: Sequence file to hold output ORF sequences

		featout (OutFile)
			Feature file for output (-featout)

		featout_offormat (Excl)
			Feature output format (-offormat)

		addlast (Switch)
			Force the sequence to end with an asterisk (-addlast)

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

http://bioweb.pasteur.fr/seqanal/interfaces/checktrans.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::checktrans;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $checktrans = Bio::Tools::Run::PiseApplication::checktrans->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::checktrans object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $checktrans = $factory->program('checktrans');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::checktrans.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/checktrans.pm

    $self->{COMMAND}   = "checktrans";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CHECKTRANS";

    $self->{DESCRIPTION}   = "Reports STOP codons and ORF statistics of a protein (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/checktrans.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"checktrans",
	"init",
	"input",
	"required",
	"output",
	"advanced",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"checktrans",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- stopprotein [sequences] (-sequence)
	"required", 	# required Section
	"orfml", 	# Minimum ORF Length to report (-orfml)
	"output", 	# output Section
	"report", 	# report (-report)
	"outseq", 	# Sequence file to hold output ORF sequences (-outseq)
	"outseq_sformat", 	# Output format for: Sequence file to hold output ORF sequences
	"featout", 	# Feature file for output (-featout)
	"featout_offormat", 	# Feature output format (-offormat)
	"advanced", 	# advanced Section
	"addlast", 	# Force the sequence to end with an asterisk (-addlast)
	"auto",

    ];

    $self->{TYPE}  = {
	"checktrans" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"orfml" => 'Integer',
	"output" => 'Paragraph',
	"report" => 'OutFile',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"featout" => 'OutFile',
	"featout_offormat" => 'Excl',
	"advanced" => 'Paragraph',
	"addlast" => 'Switch',
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
	"orfml" => {
		"perl" => '" -orfml=$value"',
	},
	"output" => {
	},
	"report" => {
		"perl" => '" -report=$value"',
	},
	"outseq" => {
		"perl" => '($value)? " -outseq=$value" : ""',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"featout" => {
		"perl" => '" -featout=$value"',
	},
	"featout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"advanced" => {
	},
	"addlast" => {
		"perl" => '($value)? "" : " -noaddlast"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"checktrans" => {
		"perl" => '"checktrans"',
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
	"orfml" => 2,
	"report" => 3,
	"outseq" => 4,
	"outseq_sformat" => 5,
	"featout" => 6,
	"featout_offormat" => 6,
	"addlast" => 7,
	"auto" => 8,
	"checktrans" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"advanced",
	"checktrans",
	"sequence",
	"orfml",
	"report",
	"outseq",
	"outseq_sformat",
	"featout_offormat",
	"featout",
	"addlast",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"advanced" => 0,
	"addlast" => 0,
	"auto" => 1,
	"checktrans" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"advanced" => 0,
	"addlast" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"orfml" => 1,
	"output" => 0,
	"report" => 1,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 1,
	"featout_offormat" => 0,
	"advanced" => 0,
	"addlast" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- stopprotein [sequences] (-sequence)",
	"required" => "required Section",
	"orfml" => "Minimum ORF Length to report (-orfml)",
	"output" => "output Section",
	"report" => "report (-report)",
	"outseq" => "Sequence file to hold output ORF sequences (-outseq)",
	"outseq_sformat" => "Output format for: Sequence file to hold output ORF sequences",
	"featout" => "Feature file for output (-featout)",
	"featout_offormat" => "Feature output format (-offormat)",
	"advanced" => "advanced Section",
	"addlast" => "Force the sequence to end with an asterisk (-addlast)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"advanced" => 0,
	"addlast" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['orfml',],
	"output" => ['report','outseq','outseq_sformat','featout','featout_offormat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
	"featout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
	"advanced" => ['addlast',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"orfml" => '100',
	"report" => 'report.out',
	"outseq_sformat" => 'fasta',
	"featout" => 'featout.out',
	"featout_offormat" => 'gff',
	"addlast" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"orfml" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"report" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"featout" => { "perl" => '1' },
	"featout_offormat" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"addlast" => { "perl" => '1' },
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
	"orfml" => 0,
	"output" => 0,
	"report" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"advanced" => 0,
	"addlast" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"orfml" => 1,
	"output" => 0,
	"report" => 1,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"featout" => 1,
	"featout_offormat" => 0,
	"advanced" => 0,
	"addlast" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"featout" => [
		"File for output features",
	],
	"addlast" => [
		"An asterisk in the protein sequence indicates the position of a STOP codon.  Checktrans assumes that all ORFs end in a STOP codon.  Forcing the sequence to end with an asterisk, if there is not one there already, makes checktrans treat the end as a potential ORF. If an asterisk is added, it is not included in the reported count of STOPs.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/checktrans.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

