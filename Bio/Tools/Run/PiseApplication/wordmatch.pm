# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::wordmatch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::wordmatch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::wordmatch

      Bioperl class for:

	WORDMATCH	Finds all exact matches of a given size between 2 sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/wordmatch.html 
         for available values):


		wordmatch (String)

		init (String)

		asequence (Sequence)
			asequence -- any [single sequence] (-asequence)
			pipe: seqfile

		bsequence (Sequence)
			bsequence [single sequence] (-bsequence)

		wordsize (Integer)
			Word size (-wordsize)

		outfile (OutFile)
			outfile (-outfile)
			pipe: readseq_ok_alig

		outfile_aformat (Excl)
			Alignment output format (-aformat)

		afeatout (OutFile)
			feature file for output aseq (-afeatout)

		afeatout_offormat (Excl)
			Feature output format (-offormat)

		bfeatout (OutFile)
			feature file for output bseq (-bfeatout)

		bfeatout_offormat (Excl)
			Feature output format (-offormat)

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

http://bioweb.pasteur.fr/seqanal/interfaces/wordmatch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::wordmatch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $wordmatch = Bio::Tools::Run::PiseApplication::wordmatch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::wordmatch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $wordmatch = $factory->program('wordmatch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::wordmatch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wordmatch.pm

    $self->{COMMAND}   = "wordmatch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WORDMATCH";

    $self->{DESCRIPTION}   = "Finds all exact matches of a given size between 2 sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:local",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/wordmatch.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"wordmatch",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"wordmatch",
	"init",
	"input", 	# input Section
	"asequence", 	# asequence -- any [single sequence] (-asequence)
	"bsequence", 	# bsequence [single sequence] (-bsequence)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"outfile_aformat", 	# Alignment output format (-aformat)
	"afeatout", 	# feature file for output aseq (-afeatout)
	"afeatout_offormat", 	# Feature output format (-offormat)
	"bfeatout", 	# feature file for output bseq (-bfeatout)
	"bfeatout_offormat", 	# Feature output format (-offormat)
	"auto",

    ];

    $self->{TYPE}  = {
	"wordmatch" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"asequence" => 'Sequence',
	"bsequence" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"outfile_aformat" => 'Excl',
	"afeatout" => 'OutFile',
	"afeatout_offormat" => 'Excl',
	"bfeatout" => 'OutFile',
	"bfeatout_offormat" => 'Excl',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"asequence" => {
		"perl" => '" -asequence=$value -sformat=fasta"',
	},
	"bsequence" => {
		"perl" => '" -bsequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"outfile_aformat" => {
		"perl" => '($value)? " -aformat=$value" : "" ',
	},
	"afeatout" => {
		"perl" => '" -afeatout=$value"',
	},
	"afeatout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"bfeatout" => {
		"perl" => '" -bfeatout=$value"',
	},
	"bfeatout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"wordmatch" => {
		"perl" => '"wordmatch"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"asequence" => [8],
	"bsequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"asequence" => 1,
	"bsequence" => 2,
	"wordsize" => 3,
	"outfile" => 4,
	"outfile_aformat" => 4,
	"afeatout" => 5,
	"afeatout_offormat" => 5,
	"bfeatout" => 6,
	"bfeatout_offormat" => 6,
	"auto" => 7,
	"wordmatch" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"wordmatch",
	"asequence",
	"bsequence",
	"wordsize",
	"outfile_aformat",
	"outfile",
	"afeatout_offormat",
	"afeatout",
	"bfeatout",
	"bfeatout_offormat",
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
	"outfile_aformat" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"auto" => 1,
	"wordmatch" => 1

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
	"outfile_aformat" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
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
	"outfile" => 1,
	"outfile_aformat" => 0,
	"afeatout" => 1,
	"afeatout_offormat" => 0,
	"bfeatout" => 1,
	"bfeatout_offormat" => 0,
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
	"outfile" => "outfile (-outfile)",
	"outfile_aformat" => "Alignment output format (-aformat)",
	"afeatout" => "feature file for output aseq (-afeatout)",
	"afeatout_offormat" => "Feature output format (-offormat)",
	"bfeatout" => "feature file for output bseq (-bfeatout)",
	"bfeatout_offormat" => "Feature output format (-offormat)",
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
	"outfile_aformat" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['asequence','bsequence',],
	"required" => ['wordsize',],
	"output" => ['outfile','outfile_aformat','afeatout','afeatout_offormat','bfeatout','bfeatout_offormat',],
	"outfile_aformat" => ['','default','fasta','fasta','MSF','MSF',],
	"afeatout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
	"bfeatout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '4',
	"outfile" => 'outfile.align',
	"afeatout" => 'afeatout.out',
	"afeatout_offormat" => 'gff',
	"bfeatout" => 'bfeatout.out',
	"bfeatout_offormat" => 'gff',

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
	"outfile_aformat" => { "perl" => '1' },
	"afeatout" => { "perl" => '1' },
	"afeatout_offormat" => { "perl" => '1' },
	"bfeatout" => { "perl" => '1' },
	"bfeatout_offormat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '$outfile_aformat ne ""' => "readseq_ok_alig",
	},

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
	"outfile_aformat" => 0,
	"afeatout" => 0,
	"afeatout_offormat" => 0,
	"bfeatout" => 0,
	"bfeatout_offormat" => 0,
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
	"outfile_aformat" => 0,
	"afeatout" => 1,
	"afeatout_offormat" => 0,
	"bfeatout" => 1,
	"bfeatout_offormat" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"afeatout" => [
		"File for output of normal tab delimited GFF features",
	],
	"bfeatout" => [
		"File for output of normal tab delimited GFF features",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wordmatch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

