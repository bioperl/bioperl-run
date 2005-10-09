# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::distmat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::distmat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::distmat

      Bioperl class for:

	DISTMAT	Creates a distance matrix from multiple alignments (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/distmat.html 
         for available values):


		distmat (String)

		init (String)

		msf (Sequence)
			msf -- gapany [set of sequences] (-msf)
			pipe: seqsfile

		nucmethod (Excl)
			Method to use -- Multiple substitution correction methods for nucleotides (-nucmethod)

		protmethod (Excl)
			Method to use -- Multiple substitution correction methods for proteins (-protmethod)

		ambiguous (Switch)
			Use the abiguous codes in the calculation. (-ambiguous)

		gapweight (Float)
			Weight given to gaps (-gapweight)

		position (Integer)
			Base position to analyse. (-position)

		calculatea (Switch)
			Calculate the a-parameter (-calculatea)

		parametera (Float)
			a-parameter (-parametera)

		outf (OutFile)
			Enter a name for the distance matrix (-outf)

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

http://bioweb.pasteur.fr/seqanal/interfaces/distmat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::distmat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $distmat = Bio::Tools::Run::PiseApplication::distmat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::distmat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $distmat = $factory->program('distmat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::distmat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/distmat.pm

    $self->{COMMAND}   = "distmat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DISTMAT";

    $self->{DESCRIPTION}   = "Creates a distance matrix from multiple alignments (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "phylogeny",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/distmat.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"distmat",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"distmat",
	"init",
	"input", 	# input Section
	"msf", 	# msf -- gapany [set of sequences] (-msf)
	"advanced", 	# advanced Section
	"nucmethod", 	# Method to use -- Multiple substitution correction methods for nucleotides (-nucmethod)
	"protmethod", 	# Method to use -- Multiple substitution correction methods for proteins (-protmethod)
	"ambiguous", 	# Use the abiguous codes in the calculation. (-ambiguous)
	"gapweight", 	# Weight given to gaps (-gapweight)
	"position", 	# Base position to analyse. (-position)
	"calculatea", 	# Calculate the a-parameter (-calculatea)
	"parametera", 	# a-parameter (-parametera)
	"output", 	# output Section
	"outf", 	# Enter a name for the distance matrix (-outf)
	"auto",

    ];

    $self->{TYPE}  = {
	"distmat" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"msf" => 'Sequence',
	"advanced" => 'Paragraph',
	"nucmethod" => 'Excl',
	"protmethod" => 'Excl',
	"ambiguous" => 'Switch',
	"gapweight" => 'Float',
	"position" => 'Integer',
	"calculatea" => 'Switch',
	"parametera" => 'Float',
	"output" => 'Paragraph',
	"outf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"msf" => {
		"perl" => '" -msf=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"nucmethod" => {
		"perl" => '" -nucmethod=$value"',
	},
	"protmethod" => {
		"perl" => '" -protmethod=$value"',
	},
	"ambiguous" => {
		"perl" => '($value)? " -ambiguous" : ""',
	},
	"gapweight" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapweight=$value" : ""',
	},
	"position" => {
		"perl" => '(defined $value && $value != $vdef)? " -position=$value" : ""',
	},
	"calculatea" => {
		"perl" => '($value)? " -calculatea" : ""',
	},
	"parametera" => {
		"perl" => '(defined $value && $value != $vdef)? " -parametera=$value" : ""',
	},
	"output" => {
	},
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"distmat" => {
		"perl" => '"distmat"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"msf" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"msf" => 1,
	"nucmethod" => 2,
	"protmethod" => 3,
	"ambiguous" => 4,
	"gapweight" => 5,
	"position" => 6,
	"calculatea" => 7,
	"parametera" => 8,
	"outf" => 9,
	"auto" => 10,
	"distmat" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"distmat",
	"msf",
	"nucmethod",
	"protmethod",
	"ambiguous",
	"gapweight",
	"position",
	"calculatea",
	"parametera",
	"outf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"nucmethod" => 0,
	"protmethod" => 0,
	"ambiguous" => 0,
	"gapweight" => 0,
	"position" => 0,
	"calculatea" => 0,
	"parametera" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 1,
	"distmat" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"nucmethod" => 0,
	"protmethod" => 0,
	"ambiguous" => 0,
	"gapweight" => 0,
	"position" => 0,
	"calculatea" => 0,
	"parametera" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 1,
	"advanced" => 0,
	"nucmethod" => 1,
	"protmethod" => 1,
	"ambiguous" => 0,
	"gapweight" => 0,
	"position" => 0,
	"calculatea" => 0,
	"parametera" => 0,
	"output" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"msf" => "msf -- gapany [set of sequences] (-msf)",
	"advanced" => "advanced Section",
	"nucmethod" => "Method to use -- Multiple substitution correction methods for nucleotides (-nucmethod)",
	"protmethod" => "Method to use -- Multiple substitution correction methods for proteins (-protmethod)",
	"ambiguous" => "Use the abiguous codes in the calculation. (-ambiguous)",
	"gapweight" => "Weight given to gaps (-gapweight)",
	"position" => "Base position to analyse. (-position)",
	"calculatea" => "Calculate the a-parameter (-calculatea)",
	"parametera" => "a-parameter (-parametera)",
	"output" => "output Section",
	"outf" => "Enter a name for the distance matrix (-outf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"nucmethod" => 0,
	"protmethod" => 0,
	"ambiguous" => 0,
	"gapweight" => 0,
	"position" => 0,
	"calculatea" => 0,
	"parametera" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['msf',],
	"advanced" => ['nucmethod','protmethod','ambiguous','gapweight','position','calculatea','parametera',],
	"nucmethod" => ['0','Uncorrected','1','Jukes-Cantor','2','Kimura','3','Tamura','4','Tajima-Nei','5','Jin-Nei Gamma',],
	"protmethod" => ['0','Uncorrected','1','Jukes-Cantor','2','Kimura Protein',],
	"output" => ['outf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"nucmethod" => '0',
	"protmethod" => '0',
	"ambiguous" => '0',
	"gapweight" => '0.',
	"position" => '123',
	"calculatea" => '0',
	"parametera" => '1.0',
	"outf" => 'outf.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"msf" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"nucmethod" => {
		"acd" => '@(!$(msf.protein))',
	},
	"protmethod" => {
		"perl" => '$msf.protein',
		"acd" => '$msf.protein',
	},
	"ambiguous" => { "perl" => '1' },
	"gapweight" => { "perl" => '1' },
	"position" => { "perl" => '1' },
	"calculatea" => { "perl" => '1' },
	"parametera" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"msf" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"nucmethod" => 0,
	"protmethod" => 0,
	"ambiguous" => 0,
	"gapweight" => 0,
	"position" => 0,
	"calculatea" => 0,
	"parametera" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 1,
	"advanced" => 0,
	"nucmethod" => 1,
	"protmethod" => 1,
	"ambiguous" => 0,
	"gapweight" => 0,
	"position" => 0,
	"calculatea" => 0,
	"parametera" => 0,
	"output" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"msf" => [
		"File containing a sequence alignment.",
	],
	"nucmethod" => [
		"Multiple substitution correction methods for nucleotides.",
	],
	"protmethod" => [
		"Multiple substitution correction methods for proteins.",
	],
	"ambiguous" => [
		"Option to use the abiguous codes in the calculation of the Jukes-Cantor method or if the sequences are proteins.",
	],
	"gapweight" => [
		"Option to weight gaps in the uncorrected (nucleotide) and Jukes-Cantor distance methods.",
	],
	"position" => [
		"Choose base positions to analyse in each codon i.e. 123 (all bases), 12 (the first two bases), 1, 2, or 3 individual bases.",
	],
	"calculatea" => [
		"This will force the calculation of the a-parameter in the Jin-Nei Gamma distance calculation, otherwise the default is 1.0 (see -parametera option).",
	],
	"parametera" => [
		"User defined a parameter to be use in the Jin-Nei Gamma distance calculation. The suggested value to be used is 1.0 [Jin et al.] and this is the default.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/distmat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

