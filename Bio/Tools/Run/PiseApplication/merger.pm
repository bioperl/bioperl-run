# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::merger
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::merger

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::merger

      Bioperl class for:

	MERGER	Merge two overlapping nucleic acid sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/merger.html 
         for available values):


		merger (String)

		init (String)

		seqa (Sequence)
			seqa -- DNA [single sequence] (-seqa)
			pipe: seqfile

		seqb (Sequence)
			seqb -- DNA [single sequence] (-seqb)

		datafile (Excl)
			Matrix file (-datafile)

		gapopen (Float)
			Gap opening penalty (-gapopen)

		gapextend (Float)
			Gap extension penalty (-gapextend)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

		outfile (OutFile)
			Output alignment and explanation (-outfile)
			pipe: readseq_ok_alig

		outfile_aformat (Excl)
			Alignment output format (-aformat)

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

http://bioweb.pasteur.fr/seqanal/interfaces/merger.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::merger;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $merger = Bio::Tools::Run::PiseApplication::merger->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::merger object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $merger = $factory->program('merger');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::merger.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/merger.pm

    $self->{COMMAND}   = "merger";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MERGER";

    $self->{DESCRIPTION}   = "Merge two overlapping nucleic acid sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:consensus",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/merger.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"merger",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"merger",
	"init",
	"input", 	# input Section
	"seqa", 	# seqa -- DNA [single sequence] (-seqa)
	"seqb", 	# seqb -- DNA [single sequence] (-seqb)
	"advanced", 	# advanced Section
	"datafile", 	# Matrix file (-datafile)
	"gapopen", 	# Gap opening penalty (-gapopen)
	"gapextend", 	# Gap extension penalty (-gapextend)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"outfile", 	# Output alignment and explanation (-outfile)
	"outfile_aformat", 	# Alignment output format (-aformat)
	"auto",

    ];

    $self->{TYPE}  = {
	"merger" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seqa" => 'Sequence',
	"seqb" => 'Sequence',
	"advanced" => 'Paragraph',
	"datafile" => 'Excl',
	"gapopen" => 'Float',
	"gapextend" => 'Float',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"outfile" => 'OutFile',
	"outfile_aformat" => 'Excl',
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
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value)? " -datafile=$value" : ""',
	},
	"gapopen" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapopen=$value" : ""',
	},
	"gapextend" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapextend=$value" : ""',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"outfile_aformat" => {
		"perl" => '($value)? " -aformat=$value" : "" ',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"merger" => {
		"perl" => '"merger"',
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
	"datafile" => 3,
	"gapopen" => 4,
	"gapextend" => 5,
	"outseq" => 6,
	"outseq_sformat" => 7,
	"outfile" => 8,
	"outfile_aformat" => 8,
	"auto" => 9,
	"merger" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"merger",
	"seqa",
	"seqb",
	"datafile",
	"gapopen",
	"gapextend",
	"outseq",
	"outseq_sformat",
	"outfile",
	"outfile_aformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 1,
	"merger" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 1,
	"seqb" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"outfile" => 1,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"seqa" => "seqa -- DNA [single sequence] (-seqa)",
	"seqb" => "seqb -- DNA [single sequence] (-seqb)",
	"advanced" => "advanced Section",
	"datafile" => "Matrix file (-datafile)",
	"gapopen" => "Gap opening penalty (-gapopen)",
	"gapextend" => "Gap extension penalty (-gapextend)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"outfile" => "Output alignment and explanation (-outfile)",
	"outfile_aformat" => "Alignment output format (-aformat)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 0,
	"seqb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['seqa','seqb',],
	"advanced" => ['datafile','gapopen','gapextend',],
	"datafile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['outseq','outseq_sformat','outfile','outfile_aformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
	"outfile_aformat" => ['','default','fasta','fasta','MSF','MSF',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gapopen" => '50.0',
	"gapextend" => '5',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"outfile" => 'outfile.align',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"seqa" => { "perl" => '1' },
	"seqb" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"gapopen" => { "perl" => '1' },
	"gapextend" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"outfile_aformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqfile",
	},
	"outfile" => {
		 '$outfile_aformat ne ""' => "readseq_ok_alig",
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
	"advanced" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"seqa" => 1,
	"seqb" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"datafile" => [
		"This is the scoring matrix file used when comparing sequences.  By default it is the file \'EBLOSUM62\' (for proteins) or the file \'EDNAFULL\' (for nucleic sequences).  These files are found in the \'data\' directory of the EMBOSS installation.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/merger.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

