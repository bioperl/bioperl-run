# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::diffseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::diffseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::diffseq

      Bioperl class for:

	DIFFSEQ	Find differences between nearly identical sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/diffseq.html 
         for available values):


		diffseq (String)

		init (String)

		asequence (Sequence)
			asequence -- any [single sequence] (-asequence)
			pipe: seqfile

		bsequence (Sequence)
			bsequence [single sequence] (-bsequence)

		wordsize (Integer)
			Word size (-wordsize)

		outfile (OutFile)
			Output report file (-outfile)

		afeatout (OutFile)
			Feature file for output asequence (-afeatout)

		afeatout_offormat (Excl)
			Feature output format (-offormat)

		bfeatout (OutFile)
			Feature file for output bsequence (-bfeatout)

		bfeatout_offormat (Excl)
			Feature output format (-offormat)

		columns (Switch)
			Output in columns format (-columns)

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

http://bioweb.pasteur.fr/seqanal/interfaces/diffseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::diffseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $diffseq = Bio::Tools::Run::PiseApplication::diffseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::diffseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $diffseq = $factory->program('diffseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::diffseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/diffseq.pm

    $self->{COMMAND}   = "diffseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DIFFSEQ";

    $self->{DESCRIPTION}   = "Find differences between nearly identical sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:differences",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/diffseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"diffseq",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"diffseq",
	"init",
	"input", 	# input Section
	"asequence", 	# asequence -- any [single sequence] (-asequence)
	"bsequence", 	# bsequence [single sequence] (-bsequence)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"outfile", 	# Output report file (-outfile)
	"afeatout", 	# Feature file for output asequence (-afeatout)
	"afeatout_offormat", 	# Feature output format (-offormat)
	"bfeatout", 	# Feature file for output bsequence (-bfeatout)
	"bfeatout_offormat", 	# Feature output format (-offormat)
	"columns", 	# Output in columns format (-columns)
	"auto",

    ];

    $self->{TYPE}  = {
	"diffseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"asequence" => 'Sequence',
	"bsequence" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"afeatout" => 'OutFile',
	"afeatout_offormat" => 'Excl',
	"bfeatout" => 'OutFile',
	"bfeatout_offormat" => 'Excl',
	"columns" => 'Switch',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"asequence" => {
		"perl" => '" -asequence=$value"',
	},
	"bsequence" => {
		"perl" => '" -bsequence=$value"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"afeatout" => {
		"perl" => '($value && $value ne $vdef)? " -afeatout=$value" : ""',
	},
	"afeatout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"bfeatout" => {
		"perl" => '($value && $value ne $vdef)? " -bfeatout=$value" : ""',
	},
	"bfeatout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"columns" => {
		"perl" => '($value)? " -columns" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"diffseq" => {
		"perl" => '"diffseq"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"asequence" => [2,4,14],
	"bsequence" => [2,4,14],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"asequence" => 1,
	"bsequence" => 2,
	"wordsize" => 3,
	"outfile" => 4,
	"afeatout" => 5,
	"afeatout_offormat" => 5,
	"bfeatout" => 6,
	"bfeatout_offormat" => 6,
	"columns" => 7,
	"auto" => 8,
	"diffseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"diffseq",
	"asequence",
	"bsequence",
	"wordsize",
	"outfile",
	"afeatout_offormat",
	"afeatout",
	"bfeatout",
	"bfeatout_offormat",
	"columns",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"columns" => 0,
	"auto" => 1,
	"diffseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 1,
	"bsequence" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"asequence" => "asequence -- any [single sequence] (-asequence)",
	"bsequence" => "bsequence [single sequence] (-bsequence)",
	"required" => "required Section",
	"wordsize" => "Word size (-wordsize)",
	"output" => "output Section",
	"outfile" => "Output report file (-outfile)",
	"afeatout" => "Feature file for output asequence (-afeatout)",
	"afeatout_offormat" => "Feature output format (-offormat)",
	"bfeatout" => "Feature file for output bsequence (-bfeatout)",
	"bfeatout_offormat" => "Feature output format (-offormat)",
	"columns" => "Output in columns format (-columns)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['asequence','bsequence',],
	"required" => ['wordsize',],
	"output" => ['outfile','afeatout','afeatout_offormat','bfeatout','bfeatout_offormat','columns',],
	"afeatout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
	"bfeatout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '10',
	"afeatout" => '',
	"afeatout_offormat" => 'gff',
	"bfeatout" => '',
	"bfeatout_offormat" => 'gff',
	"columns" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"asequence" => { "perl" => '1' },
	"bsequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"wordsize" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"afeatout" => { "perl" => '1' },
	"afeatout_offormat" => { "perl" => '1' },
	"bfeatout" => { "perl" => '1' },
	"bfeatout_offormat" => { "perl" => '1' },
	"columns" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"asequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 0,
	"bsequence" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"asequence" => 1,
	"bsequence" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"outfile" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"columns" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"wordsize" => [
		"The similar regions between the two sequences are found by creating a hash table of \'wordsize\'d subsequences. 10 is a reasonable default. Making this value larger (20?) may speed up the program slightly, but will mean that any two differences within \'wordsize\' of each other will be grouped as a single region of difference. This value may be made smaller (4?) to improve the resolution of nearby differences, but the program will go much slower.",
	],
	"afeatout" => [
		"File for output of first sequence\'s normal tab delimited gff\'s",
	],
	"bfeatout" => [
		"File for output of second sequence\'s normal tab delimited gff\'s",
	],
	"columns" => [
		"The default format for the output report file is to have several lines per difference giving the sequence positions, sequences and features. <BR> If this option is set true then the output report file\'s format is changed to a set of columns and no feature information is given.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/diffseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

