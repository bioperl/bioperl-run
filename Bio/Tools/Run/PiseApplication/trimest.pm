# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::trimest
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::trimest

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::trimest

      Bioperl class for:

	TRIMEST	Trim poly-A tails off EST sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/trimest.html 
         for available values):


		trimest (String)

		init (String)

		sequence (Sequence)
			sequence -- dna [sequences] (-sequence)
			pipe: seqsfile

		minlength (Integer)
			Minimum length of a poly-A tail (-minlength)

		mismatches (Integer)
			Number of contiguous mismatches allowed in a tail (-mismatches)

		reverse (Switch)
			Write the reverse complement when poly-T is removed (-reverse)

		fiveprime (Switch)
			Remove poly-T tails at the 5' end of the sequence. (-fiveprime)

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

http://bioweb.pasteur.fr/seqanal/interfaces/trimest.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::trimest;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $trimest = Bio::Tools::Run::PiseApplication::trimest->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::trimest object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $trimest = $factory->program('trimest');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::trimest.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/trimest.pm

    $self->{COMMAND}   = "trimest";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TRIMEST";

    $self->{DESCRIPTION}   = "Trim poly-A tails off EST sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/trimest.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"trimest",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"trimest",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"advanced", 	# advanced Section
	"minlength", 	# Minimum length of a poly-A tail (-minlength)
	"mismatches", 	# Number of contiguous mismatches allowed in a tail (-mismatches)
	"reverse", 	# Write the reverse complement when poly-T is removed (-reverse)
	"fiveprime", 	# Remove poly-T tails at the 5' end of the sequence. (-fiveprime)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"trimest" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"minlength" => 'Integer',
	"mismatches" => 'Integer',
	"reverse" => 'Switch',
	"fiveprime" => 'Switch',
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
	"minlength" => {
		"perl" => '(defined $value && $value != $vdef)? " -minlength=$value" : ""',
	},
	"mismatches" => {
		"perl" => '(defined $value && $value != $vdef)? " -mismatches=$value" : ""',
	},
	"reverse" => {
		"perl" => '($value)? "" : " -noreverse"',
	},
	"fiveprime" => {
		"perl" => '($value)? "" : " -nofiveprime"',
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
	"trimest" => {
		"perl" => '"trimest"',
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
	"minlength" => 2,
	"mismatches" => 3,
	"reverse" => 4,
	"fiveprime" => 5,
	"outseq" => 6,
	"outseq_sformat" => 7,
	"auto" => 8,
	"trimest" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"trimest",
	"sequence",
	"minlength",
	"mismatches",
	"reverse",
	"fiveprime",
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
	"minlength" => 0,
	"mismatches" => 0,
	"reverse" => 0,
	"fiveprime" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"trimest" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"minlength" => 0,
	"mismatches" => 0,
	"reverse" => 0,
	"fiveprime" => 0,
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
	"minlength" => 0,
	"mismatches" => 0,
	"reverse" => 0,
	"fiveprime" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"minlength" => "Minimum length of a poly-A tail (-minlength)",
	"mismatches" => "Number of contiguous mismatches allowed in a tail (-mismatches)",
	"reverse" => "Write the reverse complement when poly-T is removed (-reverse)",
	"fiveprime" => "Remove poly-T tails at the 5' end of the sequence. (-fiveprime)",
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
	"minlength" => 0,
	"mismatches" => 0,
	"reverse" => 0,
	"fiveprime" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['minlength','mismatches','reverse','fiveprime',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"minlength" => '4',
	"mismatches" => '1',
	"reverse" => '1',
	"fiveprime" => '1',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"minlength" => { "perl" => '1' },
	"mismatches" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"fiveprime" => { "perl" => '1' },
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
	"minlength" => 0,
	"mismatches" => 0,
	"reverse" => 0,
	"fiveprime" => 0,
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
	"minlength" => 0,
	"mismatches" => 0,
	"reverse" => 0,
	"fiveprime" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"minlength" => [
		"This is the minimum length that a poly-A (or poly-T) tail must have before it is removed. If there are mismatches in the tail than there must be at least this length of poly-A tail before the mismatch for the mismatch to be considered part of the tail.",
	],
	"mismatches" => [
		"If there are this number or fewer contiguous non-A bases in a poly-A tail then, if there are \'-minlength\' \'A\' bases before them, they will be considered part of the tail and removed . <BR> For example the terminal 4 A\'s of GCAGAAAA would be removed with the default values of -minlength=4 and -mismatches=1 (There are not at least 4 A\'s before the last \'G\' and so only the A\'s after it are considered to be part of the tail). The terminal 9 bases of GCAAAAGAAAA would be removed; There are at least -minlength A\'s preceeding the last \'G\', so it is part of the tail.",
	],
	"reverse" => [
		"When a poly-T region at the 5\' end of the sequence is found and removed, it is likely that the sequence is in the reverse sense. This option will change the sequence to the forward sense when it is written out. If this option is not set, then the sense will not be changed.",
	],
	"fiveprime" => [
		"If this is set true, then the 5\' end of teh sequence is inspected for poly-T tails. These will be removed if they are longer than any 3\' poly-A tails. If this is false, then the 5\' end is ignored.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/trimest.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

