# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::sirna
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::sirna

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::sirna

      Bioperl class for:

	SIRNA	Finds siRNA duplexes in mRNA (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/sirna.html 
         for available values):


		sirna (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		poliii (Switch)
			Select probes for Pol III expression vectors (-poliii)

		aa (Switch)
			Select only regions that start with AA (-aa)

		tt (Switch)
			Select only regions that end with TT (-tt)

		polybase (Switch)
			Allow regions with 4 repeats of a base (-polybase)

		outfile (OutFile)
			Output data file (-outfile)

		outseq (OutFile)
			Output sequence file (-outseq)
			pipe: seqsfile

		outseq_sformat (Excl)
			Output format for: Output sequence file

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

http://bioweb.pasteur.fr/seqanal/interfaces/sirna.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::sirna;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $sirna = Bio::Tools::Run::PiseApplication::sirna->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::sirna object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $sirna = $factory->program('sirna');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::sirna.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sirna.pm

    $self->{COMMAND}   = "sirna";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SIRNA";

    $self->{DESCRIPTION}   = "Finds siRNA duplexes in mRNA (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/sirna.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"sirna",
	"init",
	"input",
	"selection",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"sirna",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"selection", 	# selection Section
	"poliii", 	# Select probes for Pol III expression vectors (-poliii)
	"aa", 	# Select only regions that start with AA (-aa)
	"tt", 	# Select only regions that end with TT (-tt)
	"polybase", 	# Allow regions with 4 repeats of a base (-polybase)
	"output", 	# output Section
	"outfile", 	# Output data file (-outfile)
	"outseq", 	# Output sequence file (-outseq)
	"outseq_sformat", 	# Output format for: Output sequence file
	"auto",

    ];

    $self->{TYPE}  = {
	"sirna" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"selection" => 'Paragraph',
	"poliii" => 'Switch',
	"aa" => 'Switch',
	"tt" => 'Switch',
	"polybase" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
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
		"perl" => '" -sequence=$value"',
	},
	"selection" => {
	},
	"poliii" => {
		"perl" => '($value)? " -poliii" : ""',
	},
	"aa" => {
		"perl" => '($value)? " -aa" : ""',
	},
	"tt" => {
		"perl" => '($value)? " -tt" : ""',
	},
	"polybase" => {
		"perl" => '($value)? "" : " -nopolybase"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
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
	"sirna" => {
		"perl" => '"sirna"',
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
	"poliii" => 2,
	"aa" => 3,
	"tt" => 4,
	"polybase" => 5,
	"outfile" => 6,
	"outseq" => 7,
	"outseq_sformat" => 8,
	"auto" => 9,
	"sirna" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"selection",
	"output",
	"sirna",
	"sequence",
	"poliii",
	"aa",
	"tt",
	"polybase",
	"outfile",
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
	"selection" => 0,
	"poliii" => 0,
	"aa" => 0,
	"tt" => 0,
	"polybase" => 0,
	"output" => 0,
	"outfile" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"sirna" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"selection" => 0,
	"poliii" => 0,
	"aa" => 0,
	"tt" => 0,
	"polybase" => 0,
	"output" => 0,
	"outfile" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"selection" => 0,
	"poliii" => 0,
	"aa" => 0,
	"tt" => 0,
	"polybase" => 0,
	"output" => 0,
	"outfile" => 1,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"selection" => "selection Section",
	"poliii" => "Select probes for Pol III expression vectors (-poliii)",
	"aa" => "Select only regions that start with AA (-aa)",
	"tt" => "Select only regions that end with TT (-tt)",
	"polybase" => "Allow regions with 4 repeats of a base (-polybase)",
	"output" => "output Section",
	"outfile" => "Output data file (-outfile)",
	"outseq" => "Output sequence file (-outseq)",
	"outseq_sformat" => "Output format for: Output sequence file",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"selection" => 0,
	"poliii" => 0,
	"aa" => 0,
	"tt" => 0,
	"polybase" => 0,
	"output" => 0,
	"outfile" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"selection" => ['poliii','aa','tt','polybase',],
	"output" => ['outfile','outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"poliii" => '0',
	"aa" => '0',
	"tt" => '0',
	"polybase" => '1',
	"outfile" => 'outfile.out',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"selection" => { "perl" => '1' },
	"poliii" => { "perl" => '1' },
	"aa" => { "perl" => '1' },
	"tt" => { "perl" => '1' },
	"polybase" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
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
	"selection" => 0,
	"poliii" => 0,
	"aa" => 0,
	"tt" => 0,
	"polybase" => 0,
	"output" => 0,
	"outfile" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"selection" => 0,
	"poliii" => 0,
	"aa" => 0,
	"tt" => 0,
	"polybase" => 0,
	"output" => 0,
	"outfile" => 1,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"poliii" => [
		"This option allows you to select only the 21 base probes that start with a purine and so can be expressed from Pol III expression vectors. This is the NARN(17)YNN pattern that has been suggested by Tuschl et al.",
	],
	"aa" => [
		"This option allows you to select only those 23 base regions that start with AA. If this option is not selected then regions that start with AA will be favoured by giving them a higher score, but regions that do not start with AA will also be reported.",
	],
	"tt" => [
		"This option allows you to select only those 23 base regions that end with TT. If this option is not selected then regions that end with TT will be favoured by giving them a higher score, but regions that do not end with TT will also be reported.",
	],
	"polybase" => [
		"If this option is FALSE then only those 23 base regions that have no repeat of 4 or more of any bases in a row will be reported. No regions will ever be reported that have 4 or more G\'s in a row.",
	],
	"outfile" => [
		"The output is a table of the forward and reverse parts of the siRNA duplex. Both the forward and reverse sequences are written 5\' to 3\', ready to be ordered. The last two bases have been replaced by \'dTdT\'. The starting position of the 23 base region and the %GC content is also given.",
	],
	"outseq" => [
		"This is a file of the sequences of the 23 base regions that the siRNAs are selected from. You may use it to do searches of mRNA databases (e.g. REFSEQ) to confirm that the probes are unique to the gene you wish to use it on.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sirna.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

