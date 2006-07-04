# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::dotmatcher
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::dotmatcher

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dotmatcher

      Bioperl class for:

	DOTMATCHER	Displays a thresholded dotplot of two sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/dotmatcher.html 
         for available values):


		dotmatcher (String)

		init (String)

		sequencea (Sequence)
			sequencea -- any [single sequence] (-sequencea)
			pipe: seqfile

		sequenceb (Sequence)
			sequenceb [single sequence] (-sequenceb)

		windowsize (Integer)
			window size over which to test threshhold (-windowsize)

		threshold (Integer)
			threshold (-threshold)

		matrixfile (Excl)
			Matrix file (-matrixfile)

		stretch (Switch)
			Stretch plot (-stretch)

		data (Switch)
			Display as data (-data)

		graph (Excl)
			graph [device to be displayed on] (-graph)

		xygraph (Excl)
			xygraph (-xygraph)

		outfile (OutFile)
			Display as data (-outfile)

		auto (String)

		psouput (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/dotmatcher.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::dotmatcher;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dotmatcher = Bio::Tools::Run::PiseApplication::dotmatcher->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dotmatcher object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $dotmatcher = $factory->program('dotmatcher');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::dotmatcher.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dotmatcher.pm

    $self->{COMMAND}   = "dotmatcher";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DOTMATCHER";

    $self->{DESCRIPTION}   = "Displays a thresholded dotplot of two sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:dot plots",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/dotmatcher.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dotmatcher",
	"init",
	"input",
	"advanced",
	"output",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dotmatcher",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- any [single sequence] (-sequencea)
	"sequenceb", 	# sequenceb [single sequence] (-sequenceb)
	"advanced", 	# advanced Section
	"windowsize", 	# window size over which to test threshhold (-windowsize)
	"threshold", 	# threshold (-threshold)
	"matrixfile", 	# Matrix file (-matrixfile)
	"output", 	# output Section
	"stretch", 	# Stretch plot (-stretch)
	"data", 	# Display as data (-data)
	"graph", 	# graph [device to be displayed on] (-graph)
	"xygraph", 	# xygraph (-xygraph)
	"outfile", 	# Display as data (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"dotmatcher" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"sequenceb" => 'Sequence',
	"advanced" => 'Paragraph',
	"windowsize" => 'Integer',
	"threshold" => 'Integer',
	"matrixfile" => 'Excl',
	"output" => 'Paragraph',
	"stretch" => 'Switch',
	"data" => 'Switch',
	"graph" => 'Excl',
	"xygraph" => 'Excl',
	"outfile" => 'OutFile',
	"auto" => 'String',
	"psouput" => 'String',
	"psresults" => 'Results',
	"metaresults" => 'Results',
	"dataresults" => 'Results',
	"pngresults" => 'Results',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequencea" => {
		"perl" => '" -sequencea=$value -sformat=fasta"',
	},
	"sequenceb" => {
		"perl" => '" -sequenceb=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"windowsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -windowsize=$value" : ""',
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? " -threshold=$value" : ""',
	},
	"matrixfile" => {
		"perl" => '($value)? " -matrixfile=$value" : ""',
	},
	"output" => {
	},
	"stretch" => {
		"perl" => '($value)? " -stretch" : ""',
	},
	"data" => {
		"perl" => '($value)? " -data" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"xygraph" => {
		"perl" => '($value)? " -xygraph=$value" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=dotmatcher"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"dotmatcher" => {
		"perl" => '"dotmatcher"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],
	"sequenceb" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"sequenceb" => 2,
	"windowsize" => 3,
	"threshold" => 4,
	"matrixfile" => 5,
	"stretch" => 6,
	"data" => 7,
	"graph" => 8,
	"xygraph" => 9,
	"outfile" => 10,
	"auto" => 11,
	"psouput" => 100,
	"dotmatcher" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pngresults",
	"dotmatcher",
	"advanced",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"sequencea",
	"sequenceb",
	"windowsize",
	"threshold",
	"matrixfile",
	"stretch",
	"data",
	"graph",
	"xygraph",
	"outfile",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"windowsize" => 0,
	"threshold" => 0,
	"matrixfile" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"dotmatcher" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"windowsize" => 0,
	"threshold" => 0,
	"matrixfile" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"sequenceb" => 1,
	"advanced" => 0,
	"windowsize" => 0,
	"threshold" => 0,
	"matrixfile" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequencea" => "sequencea -- any [single sequence] (-sequencea)",
	"sequenceb" => "sequenceb [single sequence] (-sequenceb)",
	"advanced" => "advanced Section",
	"windowsize" => "window size over which to test threshhold (-windowsize)",
	"threshold" => "threshold (-threshold)",
	"matrixfile" => "Matrix file (-matrixfile)",
	"output" => "output Section",
	"stretch" => "Stretch plot (-stretch)",
	"data" => "Display as data (-data)",
	"graph" => "graph [device to be displayed on] (-graph)",
	"xygraph" => "xygraph (-xygraph)",
	"outfile" => "Display as data (-outfile)",
	"auto" => "",
	"psouput" => "",
	"psresults" => "",
	"metaresults" => "",
	"dataresults" => "",
	"pngresults" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"windowsize" => 0,
	"threshold" => 0,
	"matrixfile" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea','sequenceb',],
	"advanced" => ['windowsize','threshold','matrixfile',],
	"matrixfile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['stretch','data','graph','xygraph','outfile',],
	"graph" => ['colourps','colourps','tek4107t','tek4107t','tekt','tekt','hpgl','hpgl','x11','x11','cps','cps','none','none','xwindows','xwindows','tek','tek','null','null','text','text','meta','meta','xterm','xterm','ps','ps','png','png','hp7470','hp7470','postscript','postscript','data','data','hp7580','hp7580','tektronics','tektronics',],
	"xygraph" => ['colourps','colourps','tek4107t','tek4107t','tekt','tekt','hpgl','hpgl','x11','x11','cps','cps','none','none','xwindows','xwindows','tek','tek','null','null','text','text','meta','meta','xterm','xterm','ps','ps','png','png','hp7470','hp7470','postscript','postscript','data','data','hp7580','hp7580','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"windowsize" => '10',
	"threshold" => '23',
	"stretch" => '0',
	"data" => '0',
	"graph" => 'postscript',
	"xygraph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"sequenceb" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"windowsize" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"matrixfile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"stretch" => { "perl" => '1' },
	"data" => {
		"acd" => '@(!$(stretch))',
	},
	"graph" => {
		"acd" => '@(@(!$(data)) & @(!$(stretch)))',
	},
	"xygraph" => {
		"perl" => '$stretch',
		"acd" => '$stretch',
	},
	"outfile" => {
		"acd" => '@($(data) & @(!$(stretch)))',
	},
	"auto" => { "perl" => '1' },
	"psouput" => {
		"perl" => '$xygraph eq "postscript" || $xygraph eq "ps" || $xygraph eq "colourps"  || $xygraph eq "cps" || $xygraph eq "png"',
	},
	"psresults" => {
		"perl" => '$xygraph eq "postscript" || $xygraph eq "ps" || $xygraph eq "colourps" || $xygraph eq "cps"',
	},
	"metaresults" => {
		"perl" => '$xygraph eq "meta"',
	},
	"dataresults" => {
		"perl" => '$xygraph eq "data"',
	},
	"pngresults" => {
		"perl" => '$xygraph eq "png"',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequencea" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"windowsize" => 0,
	"threshold" => 0,
	"matrixfile" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"sequenceb" => 1,
	"advanced" => 0,
	"windowsize" => 0,
	"threshold" => 0,
	"matrixfile" => 0,
	"output" => 0,
	"stretch" => 0,
	"data" => 0,
	"graph" => 0,
	"xygraph" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"matrixfile" => [
		"This is the scoring matrix file used when comparing sequences.  By default it is the file \'EBLOSUM62\' (for proteins) or the file \'EDNAFULL\' (for nucleic sequences).  These files are found in the \'data\' directory of the EMBOSS installation.",
	],
	"stretch" => [
		"Display a non-proportional graph",
	],
	"data" => [
		"Output the match data to a file instead of plotting it",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dotmatcher.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

