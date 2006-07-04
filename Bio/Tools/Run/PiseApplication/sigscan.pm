# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::sigscan
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::sigscan

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::sigscan

      Bioperl class for:

	SIGSCAN	Scans a sparse protein signature against swissprot (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/sigscan.html 
         for available values):


		sigscan (String)

		init (String)

		sigin (InFile)
			Name of signature file for input (-sigin)

		database (Sequence)
			Name of sequence database to search (-database)
			pipe: seqsfile

		targetf (InFile)
			Name of (optionally grouped) scop families file for input (-targetf)

		thresh (Integer)
			Minimum length (residues) of overlap required for two hits with the same code to be counted as the same hit. (-thresh)

		sub (Excl)
			Residue substitution matrix (-sub)

		gapo (Float)
			Gap insertion penalty (-gapo)

		gape (Float)
			Gap extension penalty (-gape)

		nterm (Excl)
			Select number -- N-terminal matching options (-nterm)

		nhits (Integer)
			Number of hits to output (-nhits)

		hitsf (OutFile)
			Name of signature hits file for output (-hitsf)

		alignf (OutFile)
			Name of signature alignments file for output (-alignf)

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

http://bioweb.pasteur.fr/seqanal/interfaces/sigscan.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::sigscan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $sigscan = Bio::Tools::Run::PiseApplication::sigscan->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::sigscan object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $sigscan = $factory->program('sigscan');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::sigscan.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sigscan.pm

    $self->{COMMAND}   = "sigscan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SIGSCAN";

    $self->{DESCRIPTION}   = "Scans a sparse protein signature against swissprot (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:3d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/sigscan.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"sigscan",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"sigscan",
	"init",
	"input", 	# input Section
	"sigin", 	# Name of signature file for input (-sigin)
	"database", 	# Name of sequence database to search (-database)
	"targetf", 	# Name of (optionally grouped) scop families file for input (-targetf)
	"required", 	# required Section
	"thresh", 	# Minimum length (residues) of overlap required for two hits with the same code to be counted as the same hit. (-thresh)
	"sub", 	# Residue substitution matrix (-sub)
	"gapo", 	# Gap insertion penalty (-gapo)
	"gape", 	# Gap extension penalty (-gape)
	"nterm", 	# Select number -- N-terminal matching options (-nterm)
	"output", 	# output Section
	"nhits", 	# Number of hits to output (-nhits)
	"hitsf", 	# Name of signature hits file for output (-hitsf)
	"alignf", 	# Name of signature alignments file for output (-alignf)
	"auto",

    ];

    $self->{TYPE}  = {
	"sigscan" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sigin" => 'InFile',
	"database" => 'Sequence',
	"targetf" => 'InFile',
	"required" => 'Paragraph',
	"thresh" => 'Integer',
	"sub" => 'Excl',
	"gapo" => 'Float',
	"gape" => 'Float',
	"nterm" => 'Excl',
	"output" => 'Paragraph',
	"nhits" => 'Integer',
	"hitsf" => 'OutFile',
	"alignf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sigin" => {
		"perl" => '" -sigin=$value"',
	},
	"database" => {
		"perl" => '" -database=$value -sformat=fasta"',
	},
	"targetf" => {
		"perl" => '" -targetf=$value"',
	},
	"required" => {
	},
	"thresh" => {
		"perl" => '" -thresh=$value"',
	},
	"sub" => {
		"perl" => '" -sub=$value"',
	},
	"gapo" => {
		"perl" => '" -gapo=$value"',
	},
	"gape" => {
		"perl" => '" -gape=$value"',
	},
	"nterm" => {
		"perl" => '" -nterm=$value"',
	},
	"output" => {
	},
	"nhits" => {
		"perl" => '" -nhits=$value"',
	},
	"hitsf" => {
		"perl" => '" -hitsf=$value"',
	},
	"alignf" => {
		"perl" => '" -alignf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"sigscan" => {
		"perl" => '"sigscan"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"database" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sigin" => 1,
	"database" => 2,
	"targetf" => 3,
	"thresh" => 4,
	"sub" => 5,
	"gapo" => 6,
	"gape" => 7,
	"nterm" => 8,
	"nhits" => 9,
	"hitsf" => 10,
	"alignf" => 11,
	"auto" => 12,
	"sigscan" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"sigscan",
	"sigin",
	"database",
	"targetf",
	"thresh",
	"sub",
	"gapo",
	"gape",
	"nterm",
	"nhits",
	"hitsf",
	"alignf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sigin" => 0,
	"database" => 0,
	"targetf" => 0,
	"required" => 0,
	"thresh" => 0,
	"sub" => 0,
	"gapo" => 0,
	"gape" => 0,
	"nterm" => 0,
	"output" => 0,
	"nhits" => 0,
	"hitsf" => 0,
	"alignf" => 0,
	"auto" => 1,
	"sigscan" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sigin" => 0,
	"database" => 0,
	"targetf" => 0,
	"required" => 0,
	"thresh" => 0,
	"sub" => 0,
	"gapo" => 0,
	"gape" => 0,
	"nterm" => 0,
	"output" => 0,
	"nhits" => 0,
	"hitsf" => 0,
	"alignf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sigin" => 1,
	"database" => 1,
	"targetf" => 1,
	"required" => 0,
	"thresh" => 1,
	"sub" => 1,
	"gapo" => 1,
	"gape" => 1,
	"nterm" => 1,
	"output" => 0,
	"nhits" => 1,
	"hitsf" => 1,
	"alignf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sigin" => "Name of signature file for input (-sigin)",
	"database" => "Name of sequence database to search (-database)",
	"targetf" => "Name of (optionally grouped) scop families file for input (-targetf)",
	"required" => "required Section",
	"thresh" => "Minimum length (residues) of overlap required for two hits with the same code to be counted as the same hit. (-thresh)",
	"sub" => "Residue substitution matrix (-sub)",
	"gapo" => "Gap insertion penalty (-gapo)",
	"gape" => "Gap extension penalty (-gape)",
	"nterm" => "Select number -- N-terminal matching options (-nterm)",
	"output" => "output Section",
	"nhits" => "Number of hits to output (-nhits)",
	"hitsf" => "Name of signature hits file for output (-hitsf)",
	"alignf" => "Name of signature alignments file for output (-alignf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sigin" => 0,
	"database" => 0,
	"targetf" => 0,
	"required" => 0,
	"thresh" => 0,
	"sub" => 0,
	"gapo" => 0,
	"gape" => 0,
	"nterm" => 0,
	"output" => 0,
	"nhits" => 0,
	"hitsf" => 0,
	"alignf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sigin','database','targetf',],
	"required" => ['thresh','sub','gapo','gape','nterm',],
	"sub" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"nterm" => ['1','Align anywhere and allow only complete signature-sequence fit','2','Align anywhere and allow partial signature-sequence fit','3','Use empirical gaps only',],
	"output" => ['nhits','hitsf','alignf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"thresh" => '20',
	"sub" => './EBLOSUM62',
	"gapo" => '10',
	"gape" => '0.5',
	"nterm" => '1',
	"nhits" => '100',
	"hitsf" => 'test.hits',
	"alignf" => 'test.align',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sigin" => { "perl" => '1' },
	"database" => { "perl" => '1' },
	"targetf" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"thresh" => { "perl" => '1' },
	"sub" => { "perl" => '1' },
	"gapo" => { "perl" => '1' },
	"gape" => { "perl" => '1' },
	"nterm" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"nhits" => { "perl" => '1' },
	"hitsf" => { "perl" => '1' },
	"alignf" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"database" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sigin" => 0,
	"database" => 0,
	"targetf" => 0,
	"required" => 0,
	"thresh" => 0,
	"sub" => 0,
	"gapo" => 0,
	"gape" => 0,
	"nterm" => 0,
	"output" => 0,
	"nhits" => 0,
	"hitsf" => 0,
	"alignf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sigin" => 1,
	"database" => 1,
	"targetf" => 1,
	"required" => 0,
	"thresh" => 1,
	"sub" => 1,
	"gapo" => 1,
	"gape" => 1,
	"nterm" => 1,
	"output" => 0,
	"nhits" => 1,
	"hitsf" => 1,
	"alignf" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"gapo" => [
		"The gap insertion penalty is the score taken away when a gap is created. The best value depends on the choice of comparison matrix. The default value assumes you are using the EBLOSUM62 matrix for protein sequences, and the EDNAMAT matrix for nucleotide sequences. Allowed values: Floating point number from 1.0 to 100.0",
	],
	"gape" => [
		"The gap extension, penalty is added to the standard gap penalty for each base or residue in the gap. This is how long gaps are penalized. Usually you will expect a few long gaps rather than many short gaps, so the gap extension penalty should be lower than the gap penalty. An exception is where one or both sequences are single reads with possible sequencing errors in which case you would expect many single base gaps. You can get this result by setting the gap open penalty to zero (or very low) and using the gap extension penalty to control gap scoring. Allowed values: Floating point number from 0.0 to 10.0",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sigscan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

