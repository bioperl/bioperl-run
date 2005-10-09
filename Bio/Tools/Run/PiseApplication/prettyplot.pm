# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::prettyplot
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::prettyplot

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prettyplot

      Bioperl class for:

	PRETTYPLOT	Displays aligned sequences, with colouring and boxing (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/prettyplot.html 
         for available values):


		prettyplot (String)

		init (String)

		msf (Sequence)
			Sequences file to be read in (-msf)
			pipe: seqsfile

		residuesperline (Integer)
			Number of residues to be displayed on each line (-residuesperline)

		resbreak (Integer)
			Residues before a space (-resbreak)

		ccolours (Switch)
			Colour residues by their consensus value. (-ccolours)

		cidentity (String)
			Colour to display identical residues (RED) (-cidentity)

		csimilarity (String)
			Colour to display similar residues (GREEN) (-csimilarity)

		cother (String)
			Colour to display other residues (BLACK) (-cother)

		docolour (Switch)
			Colour residues by table oily, amide etc. (-docolour)

		title (Switch)
			Do not display the title (-title)

		shade (String)
			shading (-shade)

		pair (String)
			Values to represent identical similar related (-pair)

		identity (Integer)
			Only match those which are identical in all sequences. (-identity)

		box (Switch)
			Display prettyboxes (-box)

		boxcol (Switch)
			Colour the background in the boxes (-boxcol)

		boxcolval (String)
			Colour to be used for background. (GREY) (-boxcolval)

		name (Switch)
			Display the sequence names (-name)

		maxnamelen (Integer)
			Margin size for the sequence name. (-maxnamelen)

		number (Switch)
			Display the residue number (-number)

		listoptions (Switch)
			Display the date and options used (-listoptions)

		plurality (Float)
			Plurality check value (totweight/2) (-plurality)

		consensus (Switch)
			Display the consensus (-consensus)

		collision (Switch)
			Allow collisions in calculating consensus (-collision)

		alternative (Integer)
			Use alternative collisions routine (-alternative)

		matrixfile (Excl)
			Matrix file (-matrixfile)

		showscore (Integer)
			Print residue scores (-showscore)

		portrait (Switch)
			Set page to Portrait (-portrait)

		data (Switch)
			data (-data)

		graph (Excl)
			graph [device to be displayed on] (-graph)

		auto (String)

		psouput (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/prettyplot.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::prettyplot;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prettyplot = Bio::Tools::Run::PiseApplication::prettyplot->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prettyplot object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $prettyplot = $factory->program('prettyplot');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::prettyplot.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prettyplot.pm

    $self->{COMMAND}   = "prettyplot";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PRETTYPLOT";

    $self->{DESCRIPTION}   = "Displays aligned sequences, with colouring and boxing (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/prettyplot.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prettyplot",
	"init",
	"input",
	"advanced",
	"showscore",
	"portrait",
	"output",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prettyplot",
	"init",
	"input", 	# input Section
	"msf", 	# Sequences file to be read in (-msf)
	"advanced", 	# advanced Section
	"residuesperline", 	# Number of residues to be displayed on each line (-residuesperline)
	"resbreak", 	# Residues before a space (-resbreak)
	"ccolours", 	# Colour residues by their consensus value. (-ccolours)
	"cidentity", 	# Colour to display identical residues (RED) (-cidentity)
	"csimilarity", 	# Colour to display similar residues (GREEN) (-csimilarity)
	"cother", 	# Colour to display other residues (BLACK) (-cother)
	"docolour", 	# Colour residues by table oily, amide etc. (-docolour)
	"title", 	# Do not display the title (-title)
	"shade", 	# shading (-shade)
	"pair", 	# Values to represent identical similar related (-pair)
	"identity", 	# Only match those which are identical in all sequences. (-identity)
	"box", 	# Display prettyboxes (-box)
	"boxcol", 	# Colour the background in the boxes (-boxcol)
	"boxcolval", 	# Colour to be used for background. (GREY) (-boxcolval)
	"name", 	# Display the sequence names (-name)
	"maxnamelen", 	# Margin size for the sequence name. (-maxnamelen)
	"number", 	# Display the residue number (-number)
	"listoptions", 	# Display the date and options used (-listoptions)
	"plurality", 	# Plurality check value (totweight/2) (-plurality)
	"consensussection", 	# consensus Section
	"consensus", 	# Display the consensus (-consensus)
	"collision", 	# Allow collisions in calculating consensus (-collision)
	"alternative", 	# Use alternative collisions routine (-alternative)
	"matrixfile", 	# Matrix file (-matrixfile)
	"showscore", 	# Print residue scores (-showscore)
	"portrait", 	# Set page to Portrait (-portrait)
	"output", 	# output Section
	"data", 	# data (-data)
	"graph", 	# graph [device to be displayed on] (-graph)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"prettyplot" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"msf" => 'Sequence',
	"advanced" => 'Paragraph',
	"residuesperline" => 'Integer',
	"resbreak" => 'Integer',
	"ccolours" => 'Switch',
	"cidentity" => 'String',
	"csimilarity" => 'String',
	"cother" => 'String',
	"docolour" => 'Switch',
	"title" => 'Switch',
	"shade" => 'String',
	"pair" => 'String',
	"identity" => 'Integer',
	"box" => 'Switch',
	"boxcol" => 'Switch',
	"boxcolval" => 'String',
	"name" => 'Switch',
	"maxnamelen" => 'Integer',
	"number" => 'Switch',
	"listoptions" => 'Switch',
	"plurality" => 'Float',
	"consensussection" => 'Paragraph',
	"consensus" => 'Switch',
	"collision" => 'Switch',
	"alternative" => 'Integer',
	"matrixfile" => 'Excl',
	"showscore" => 'Integer',
	"portrait" => 'Switch',
	"output" => 'Paragraph',
	"data" => 'Switch',
	"graph" => 'Excl',
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
	"msf" => {
		"perl" => '" -msf=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"residuesperline" => {
		"perl" => '(defined $value && $value != $vdef)? " -residuesperline=$value" : ""',
	},
	"resbreak" => {
		"perl" => '(defined $value && $value != $vdef)? " -resbreak=$value" : ""',
	},
	"ccolours" => {
		"perl" => '($value)? "" : " -noccolours"',
	},
	"cidentity" => {
		"perl" => '($value && $value ne $vdef)? " -cidentity=$value" : ""',
	},
	"csimilarity" => {
		"perl" => '($value && $value ne $vdef)? " -csimilarity=$value" : ""',
	},
	"cother" => {
		"perl" => '($value && $value ne $vdef)? " -cother=$value" : ""',
	},
	"docolour" => {
		"perl" => '($value)? " -docolour" : ""',
	},
	"title" => {
		"perl" => '($value)? "" : " -notitle"',
	},
	"shade" => {
		"perl" => '($value)? " -shade=$value" : ""',
	},
	"pair" => {
		"perl" => '($value && $value ne $vdef)? " -pair=$value" : ""',
	},
	"identity" => {
		"perl" => '(defined $value && $value != $vdef)? " -identity=$value" : ""',
	},
	"box" => {
		"perl" => '($value)? "" : " -nobox"',
	},
	"boxcol" => {
		"perl" => '($value)? " -boxcol" : ""',
	},
	"boxcolval" => {
		"perl" => '($value && $value ne $vdef)? " -boxcolval=$value" : ""',
	},
	"name" => {
		"perl" => '($value)? "" : " -noname"',
	},
	"maxnamelen" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxnamelen=$value" : ""',
	},
	"number" => {
		"perl" => '($value)? "" : " -nonumber"',
	},
	"listoptions" => {
		"perl" => '($value)? "" : " -nolistoptions"',
	},
	"plurality" => {
		"perl" => '(defined $value && $value != $vdef)? " -plurality=$value" : ""',
	},
	"consensussection" => {
	},
	"consensus" => {
		"perl" => '($value)? " -consensus" : ""',
	},
	"collision" => {
		"perl" => '($value)? "" : " -nocollision"',
	},
	"alternative" => {
		"perl" => '(defined $value && $value != $vdef)? " -alternative=$value" : ""',
	},
	"matrixfile" => {
		"perl" => '($value)? " -matrixfile=$value" : ""',
	},
	"showscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -showscore=$value" : ""',
	},
	"portrait" => {
		"perl" => '($value)? " -portrait" : ""',
	},
	"output" => {
	},
	"data" => {
		"perl" => '($value)? " -data" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=prettyplot"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"prettyplot" => {
		"perl" => '"prettyplot"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"msf" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"msf" => 1,
	"residuesperline" => 2,
	"resbreak" => 3,
	"ccolours" => 4,
	"cidentity" => 5,
	"csimilarity" => 6,
	"cother" => 7,
	"docolour" => 8,
	"title" => 9,
	"shade" => 10,
	"pair" => 11,
	"identity" => 12,
	"box" => 13,
	"boxcol" => 14,
	"boxcolval" => 15,
	"name" => 16,
	"maxnamelen" => 17,
	"number" => 18,
	"listoptions" => 19,
	"plurality" => 20,
	"consensus" => 21,
	"collision" => 22,
	"alternative" => 23,
	"matrixfile" => 24,
	"showscore" => 25,
	"portrait" => 26,
	"data" => 27,
	"graph" => 28,
	"auto" => 29,
	"psouput" => 100,
	"prettyplot" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"prettyplot",
	"advanced",
	"output",
	"consensussection",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"msf",
	"residuesperline",
	"resbreak",
	"ccolours",
	"cidentity",
	"csimilarity",
	"cother",
	"docolour",
	"title",
	"shade",
	"pair",
	"identity",
	"box",
	"boxcol",
	"boxcolval",
	"name",
	"maxnamelen",
	"number",
	"listoptions",
	"plurality",
	"consensus",
	"collision",
	"alternative",
	"matrixfile",
	"showscore",
	"portrait",
	"data",
	"graph",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"residuesperline" => 0,
	"resbreak" => 0,
	"ccolours" => 0,
	"cidentity" => 0,
	"csimilarity" => 0,
	"cother" => 0,
	"docolour" => 0,
	"title" => 0,
	"shade" => 0,
	"pair" => 0,
	"identity" => 0,
	"box" => 0,
	"boxcol" => 0,
	"boxcolval" => 0,
	"name" => 0,
	"maxnamelen" => 0,
	"number" => 0,
	"listoptions" => 0,
	"plurality" => 0,
	"consensussection" => 0,
	"consensus" => 0,
	"collision" => 0,
	"alternative" => 0,
	"matrixfile" => 0,
	"showscore" => 0,
	"portrait" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"prettyplot" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"residuesperline" => 0,
	"resbreak" => 0,
	"ccolours" => 0,
	"cidentity" => 0,
	"csimilarity" => 0,
	"cother" => 0,
	"docolour" => 0,
	"title" => 0,
	"shade" => 0,
	"pair" => 0,
	"identity" => 0,
	"box" => 0,
	"boxcol" => 0,
	"boxcolval" => 0,
	"name" => 0,
	"maxnamelen" => 0,
	"number" => 0,
	"listoptions" => 0,
	"plurality" => 0,
	"consensussection" => 0,
	"consensus" => 0,
	"collision" => 0,
	"alternative" => 0,
	"matrixfile" => 0,
	"showscore" => 0,
	"portrait" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
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
	"msf" => 1,
	"advanced" => 0,
	"residuesperline" => 0,
	"resbreak" => 0,
	"ccolours" => 0,
	"cidentity" => 0,
	"csimilarity" => 0,
	"cother" => 0,
	"docolour" => 0,
	"title" => 0,
	"shade" => 0,
	"pair" => 0,
	"identity" => 0,
	"box" => 0,
	"boxcol" => 0,
	"boxcolval" => 0,
	"name" => 0,
	"maxnamelen" => 0,
	"number" => 0,
	"listoptions" => 0,
	"plurality" => 0,
	"consensussection" => 0,
	"consensus" => 0,
	"collision" => 0,
	"alternative" => 0,
	"matrixfile" => 0,
	"showscore" => 0,
	"portrait" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
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
	"msf" => "Sequences file to be read in (-msf)",
	"advanced" => "advanced Section",
	"residuesperline" => "Number of residues to be displayed on each line (-residuesperline)",
	"resbreak" => "Residues before a space (-resbreak)",
	"ccolours" => "Colour residues by their consensus value. (-ccolours)",
	"cidentity" => "Colour to display identical residues (RED) (-cidentity)",
	"csimilarity" => "Colour to display similar residues (GREEN) (-csimilarity)",
	"cother" => "Colour to display other residues (BLACK) (-cother)",
	"docolour" => "Colour residues by table oily, amide etc. (-docolour)",
	"title" => "Do not display the title (-title)",
	"shade" => "shading (-shade)",
	"pair" => "Values to represent identical similar related (-pair)",
	"identity" => "Only match those which are identical in all sequences. (-identity)",
	"box" => "Display prettyboxes (-box)",
	"boxcol" => "Colour the background in the boxes (-boxcol)",
	"boxcolval" => "Colour to be used for background. (GREY) (-boxcolval)",
	"name" => "Display the sequence names (-name)",
	"maxnamelen" => "Margin size for the sequence name. (-maxnamelen)",
	"number" => "Display the residue number (-number)",
	"listoptions" => "Display the date and options used (-listoptions)",
	"plurality" => "Plurality check value (totweight/2) (-plurality)",
	"consensussection" => "consensus Section",
	"consensus" => "Display the consensus (-consensus)",
	"collision" => "Allow collisions in calculating consensus (-collision)",
	"alternative" => "Use alternative collisions routine (-alternative)",
	"matrixfile" => "Matrix file (-matrixfile)",
	"showscore" => "Print residue scores (-showscore)",
	"portrait" => "Set page to Portrait (-portrait)",
	"output" => "output Section",
	"data" => "data (-data)",
	"graph" => "graph [device to be displayed on] (-graph)",
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
	"msf" => 0,
	"advanced" => 0,
	"residuesperline" => 0,
	"resbreak" => 0,
	"ccolours" => 0,
	"cidentity" => 0,
	"csimilarity" => 0,
	"cother" => 0,
	"docolour" => 0,
	"title" => 0,
	"shade" => 0,
	"pair" => 0,
	"identity" => 0,
	"box" => 0,
	"boxcol" => 0,
	"boxcolval" => 0,
	"name" => 0,
	"maxnamelen" => 0,
	"number" => 0,
	"listoptions" => 0,
	"plurality" => 0,
	"consensussection" => 0,
	"consensus" => 0,
	"collision" => 0,
	"alternative" => 0,
	"matrixfile" => 0,
	"showscore" => 0,
	"portrait" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['msf',],
	"advanced" => ['residuesperline','resbreak','ccolours','cidentity','csimilarity','cother','docolour','title','shade','pair','identity','box','boxcol','boxcolval','name','maxnamelen','number','listoptions','plurality','consensussection',],
	"consensussection" => ['consensus','collision','alternative','matrixfile',],
	"matrixfile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['data','graph',],
	"graph" => ['colourps','colourps','tek4107t','tek4107t','tekt','tekt','hpgl','hpgl','x11','x11','cps','cps','none','none','xwindows','xwindows','tek','tek','null','null','text','text','meta','meta','xterm','xterm','ps','ps','png','png','hp7470','hp7470','postscript','postscript','data','data','hp7580','hp7580','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"residuesperline" => '50',
	"resbreak" => '',
	"ccolours" => '1',
	"cidentity" => 'RED',
	"csimilarity" => 'GREEN',
	"cother" => 'BLACK',
	"docolour" => '0',
	"title" => '1',
	"pair" => '1.5,1.0,0.5',
	"identity" => '0',
	"box" => '1',
	"boxcol" => '0',
	"boxcolval" => 'GREY',
	"name" => '1',
	"maxnamelen" => '10',
	"number" => '1',
	"listoptions" => '1',
	"plurality" => '',
	"consensus" => '0',
	"collision" => '1',
	"alternative" => '0',
	"showscore" => '-1',
	"portrait" => '0',
	"data" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"msf" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"residuesperline" => { "perl" => '1' },
	"resbreak" => { "perl" => '1' },
	"ccolours" => { "perl" => '1' },
	"cidentity" => { "perl" => '1' },
	"csimilarity" => { "perl" => '1' },
	"cother" => { "perl" => '1' },
	"docolour" => { "perl" => '1' },
	"title" => { "perl" => '1' },
	"shade" => { "perl" => '1' },
	"pair" => { "perl" => '1' },
	"identity" => { "perl" => '1' },
	"box" => { "perl" => '1' },
	"boxcol" => { "perl" => '1' },
	"boxcolval" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"maxnamelen" => { "perl" => '1' },
	"number" => { "perl" => '1' },
	"listoptions" => { "perl" => '1' },
	"plurality" => { "perl" => '1' },
	"consensussection" => { "perl" => '1' },
	"consensus" => { "perl" => '1' },
	"collision" => { "perl" => '1' },
	"alternative" => { "perl" => '1' },
	"matrixfile" => { "perl" => '1' },
	"showscore" => { "perl" => '1' },
	"portrait" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"data" => { "perl" => '1' },
	"graph" => {
		"acd" => '@(!$(data))',
	},
	"auto" => { "perl" => '1' },
	"psouput" => {
		"perl" => '$graph eq "postscript" || $graph eq "ps" || $graph eq "colourps"  || $graph eq "cps" || $graph eq "png"',
	},
	"psresults" => {
		"perl" => '$graph eq "postscript" || $graph eq "ps" || $graph eq "colourps" || $graph eq "cps"',
	},
	"metaresults" => {
		"perl" => '$graph eq "meta"',
	},
	"dataresults" => {
		"perl" => '$graph eq "data"',
	},
	"pngresults" => {
		"perl" => '$graph eq "png"',
	},

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
	"residuesperline" => 0,
	"resbreak" => 0,
	"ccolours" => 0,
	"cidentity" => 0,
	"csimilarity" => 0,
	"cother" => 0,
	"docolour" => 0,
	"title" => 0,
	"shade" => 0,
	"pair" => 0,
	"identity" => 0,
	"box" => 0,
	"boxcol" => 0,
	"boxcolval" => 0,
	"name" => 0,
	"maxnamelen" => 0,
	"number" => 0,
	"listoptions" => 0,
	"plurality" => 0,
	"consensussection" => 0,
	"consensus" => 0,
	"collision" => 0,
	"alternative" => 0,
	"matrixfile" => 0,
	"showscore" => 0,
	"portrait" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
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
	"msf" => 1,
	"advanced" => 0,
	"residuesperline" => 0,
	"resbreak" => 0,
	"ccolours" => 0,
	"cidentity" => 0,
	"csimilarity" => 0,
	"cother" => 0,
	"docolour" => 0,
	"title" => 0,
	"shade" => 0,
	"pair" => 0,
	"identity" => 0,
	"box" => 0,
	"boxcol" => 0,
	"boxcolval" => 0,
	"name" => 0,
	"maxnamelen" => 0,
	"number" => 0,
	"listoptions" => 0,
	"plurality" => 0,
	"consensussection" => 0,
	"consensus" => 0,
	"collision" => 0,
	"alternative" => 0,
	"matrixfile" => 0,
	"showscore" => 0,
	"portrait" => 0,
	"output" => 0,
	"data" => 0,
	"graph" => 0,
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
	"msf" => [
		"File containing a sequence alignment",
	],
	"residuesperline" => [
		"The number of residues to be displayed on each line",
	],
	"shade" => [
		"Set to BPLW for normal shading <BR> so for pair = 1.5,1.0,0.5 and shade = BPLW <BR> Residues score Colour <BR> 1.5 or over....... BLACK (B) <BR> 1.0 to 1.5 ....... BROWN (P) <BR> 0.5 to 1.0 ....... WHEAT (L) <BR> under 0.5 ....... WHITE (W) <BR> The only four letters allowed are BPLW, in any order.",
	],
	"alternative" => [
		"Use alternative collisions routine <BR> 0) Normal collision check. (default) <BR> 1) checks identical scores with the max score found. So if any other residue matches the identical score then a collision has occurred. <BR> 2) If another residue has a greater than or equal to matching score and these do not match then a collision has occurred. <BR> 3) Checks all those not in the current consensus.If any of these give a top score for matching or identical scores then a collision has occured.",
	],
	"matrixfile" => [
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prettyplot.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

