# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::showseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::showseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::showseq

      Bioperl class for:

	SHOWSEQ	Display a sequence with features, translation etc.. (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/showseq.html 
         for available values):


		showseq (String)

		init (String)

		sequence (Sequence)
			sequence [sequences] (-sequence)
			pipe: seqsfile

		format (Excl)
			Display format -- Things to display (-format)

		things (List)
			Enter a list of things to display -- Specify your own things to display [select  values] (-things)

		translate (Integer)
			Regions to translate (eg: 4-57,78-94) (-translate)

		orfminsize (Integer)
			Minimum size of ORFs (-orfminsize)

		uppercase (Integer)
			Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)

		highlight (Integer)
			Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)

		annotation (Integer)
			Regions to mark (eg: 4-57 promoter region 78-94 first exon) (-annotation)

		flatreformat (Switch)
			Display RE sites in flat format (-flatreformat)

		mincuts (Integer)
			Minimum cuts per RE (-mincuts)

		maxcuts (Integer)
			Maximum cuts per RE (-maxcuts)

		sitelen (Integer)
			Minimum recognition site length (-sitelen)

		single (Switch)
			Force single RE site only cuts (-single)

		blunt (Switch)
			Allow blunt end RE cutters (-blunt)

		sticky (Switch)
			Allow sticky end RE cutters (-sticky)

		ambiguity (Switch)
			Allow ambiguous RE matches (-ambiguity)

		plasmid (Switch)
			Allow circular DNA (-plasmid)

		commercial (Switch)
			Only use restriction enzymes with suppliers (-commercial)

		limit (Switch)
			Limits RE hits to one isoschizomer (-limit)

		preferred (Switch)
			Report preferred isoschizomers (-preferred)

		enzymes (String)
			Comma separated restriction enzyme list (-enzymes)

		table (Excl)
			Code to use -- Genetic codes (-table)

		threeletter (Switch)
			Display protein sequences in three-letter code (-threeletter)

		number (Switch)
			Number the sequences (-number)

		width (Integer)
			Width of sequence to display (-width)

		length (Integer)
			Line length of page (0 for indefinite) (-length)

		margin (Integer)
			Margin around sequence for numbering (-margin)

		name (Switch)
			Show sequence ID (-name)

		description (Switch)
			Show description (-description)

		offset (Integer)
			Offset to start numbering the sequence from (-offset)

		html (Switch)
			Use HTML formatting (-html)

		matchsource (String)
			Source of feature to display (-matchsource)

		matchtype (String)
			Type of feature to display (-matchtype)

		matchsense (Integer)
			Sense of feature to display (-matchsense)

		minscore (Float)
			Minimum score of feature to display (-minscore)

		maxscore (Float)
			Maximum score of feature to display (-maxscore)

		matchtag (String)
			Tag of feature to display (-matchtag)

		matchvalue (String)
			Value of feature tags to display (-matchvalue)

		outfile (OutFile)
			Output sequence details to a file (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/showseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::showseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $showseq = Bio::Tools::Run::PiseApplication::showseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::showseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $showseq = $factory->program('showseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::showseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showseq.pm

    $self->{COMMAND}   = "showseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SHOWSEQ";

    $self->{DESCRIPTION}   = "Display a sequence with features, translation etc.. (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",

         "nucleic:translation",

         "nucleic:restriction",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/showseq.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"showseq",
	"init",
	"input",
	"required",
	"advanced",
	"table",
	"threeletter",
	"number",
	"width",
	"length",
	"margin",
	"name",
	"description",
	"offset",
	"html",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"showseq",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence [sequences] (-sequence)
	"required", 	# required Section
	"format", 	# Display format -- Things to display (-format)
	"advanced", 	# advanced Section
	"things", 	# Enter a list of things to display -- Specify your own things to display [select  values] (-things)
	"translate", 	# Regions to translate (eg: 4-57,78-94) (-translate)
	"orfminsize", 	# Minimum size of ORFs (-orfminsize)
	"uppercase", 	# Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)
	"highlight", 	# Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)
	"annotation", 	# Regions to mark (eg: 4-57 promoter region 78-94 first exon) (-annotation)
	"restrictsection", 	# restriction Section
	"flatreformat", 	# Display RE sites in flat format (-flatreformat)
	"mincuts", 	# Minimum cuts per RE (-mincuts)
	"maxcuts", 	# Maximum cuts per RE (-maxcuts)
	"sitelen", 	# Minimum recognition site length (-sitelen)
	"single", 	# Force single RE site only cuts (-single)
	"blunt", 	# Allow blunt end RE cutters (-blunt)
	"sticky", 	# Allow sticky end RE cutters (-sticky)
	"ambiguity", 	# Allow ambiguous RE matches (-ambiguity)
	"plasmid", 	# Allow circular DNA (-plasmid)
	"commercial", 	# Only use restriction enzymes with suppliers (-commercial)
	"limit", 	# Limits RE hits to one isoschizomer (-limit)
	"preferred", 	# Report preferred isoschizomers (-preferred)
	"enzymes", 	# Comma separated restriction enzyme list (-enzymes)
	"table", 	# Code to use -- Genetic codes (-table)
	"threeletter", 	# Display protein sequences in three-letter code (-threeletter)
	"number", 	# Number the sequences (-number)
	"width", 	# Width of sequence to display (-width)
	"length", 	# Line length of page (0 for indefinite) (-length)
	"margin", 	# Margin around sequence for numbering (-margin)
	"name", 	# Show sequence ID (-name)
	"description", 	# Show description (-description)
	"offset", 	# Offset to start numbering the sequence from (-offset)
	"html", 	# Use HTML formatting (-html)
	"featuresection", 	# feature Section
	"matchsource", 	# Source of feature to display (-matchsource)
	"matchtype", 	# Type of feature to display (-matchtype)
	"matchsense", 	# Sense of feature to display (-matchsense)
	"minscore", 	# Minimum score of feature to display (-minscore)
	"maxscore", 	# Maximum score of feature to display (-maxscore)
	"matchtag", 	# Tag of feature to display (-matchtag)
	"matchvalue", 	# Value of feature tags to display (-matchvalue)
	"output", 	# output Section
	"outfile", 	# Output sequence details to a file (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"showseq" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"format" => 'Excl',
	"advanced" => 'Paragraph',
	"things" => 'List',
	"translate" => 'Integer',
	"orfminsize" => 'Integer',
	"uppercase" => 'Integer',
	"highlight" => 'Integer',
	"annotation" => 'Integer',
	"restrictsection" => 'Paragraph',
	"flatreformat" => 'Switch',
	"mincuts" => 'Integer',
	"maxcuts" => 'Integer',
	"sitelen" => 'Integer',
	"single" => 'Switch',
	"blunt" => 'Switch',
	"sticky" => 'Switch',
	"ambiguity" => 'Switch',
	"plasmid" => 'Switch',
	"commercial" => 'Switch',
	"limit" => 'Switch',
	"preferred" => 'Switch',
	"enzymes" => 'String',
	"table" => 'Excl',
	"threeletter" => 'Switch',
	"number" => 'Switch',
	"width" => 'Integer',
	"length" => 'Integer',
	"margin" => 'Integer',
	"name" => 'Switch',
	"description" => 'Switch',
	"offset" => 'Integer',
	"html" => 'Switch',
	"featuresection" => 'Paragraph',
	"matchsource" => 'String',
	"matchtype" => 'String',
	"matchsense" => 'Integer',
	"minscore" => 'Float',
	"maxscore" => 'Float',
	"matchtag" => 'String',
	"matchvalue" => 'String',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
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
	"required" => {
	},
	"format" => {
		"perl" => '" -format=$value"',
	},
	"advanced" => {
	},
	"things" => {
		"perl" => '" -things=$value"',
	},
	"translate" => {
		"perl" => '($value)? " -translate=$value" : ""',
	},
	"orfminsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -orfminsize=$value" : ""',
	},
	"uppercase" => {
		"perl" => '($value)? " -uppercase=$value" : ""',
	},
	"highlight" => {
		"perl" => '($value)? " -highlight=$value" : ""',
	},
	"annotation" => {
		"perl" => '($value)? " -annotation=$value" : ""',
	},
	"restrictsection" => {
	},
	"flatreformat" => {
		"perl" => '($value)? " -flatreformat" : ""',
	},
	"mincuts" => {
		"perl" => '(defined $value && $value != $vdef)? " -mincuts=$value" : ""',
	},
	"maxcuts" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxcuts=$value" : ""',
	},
	"sitelen" => {
		"perl" => '(defined $value && $value != $vdef)? " -sitelen=$value" : ""',
	},
	"single" => {
		"perl" => '($value)? " -single" : ""',
	},
	"blunt" => {
		"perl" => '($value)? "" : " -noblunt"',
	},
	"sticky" => {
		"perl" => '($value)? "" : " -nosticky"',
	},
	"ambiguity" => {
		"perl" => '($value)? "" : " -noambiguity"',
	},
	"plasmid" => {
		"perl" => '($value)? " -plasmid" : ""',
	},
	"commercial" => {
		"perl" => '($value)? "" : " -nocommercial"',
	},
	"limit" => {
		"perl" => '($value)? "" : " -nolimit"',
	},
	"preferred" => {
		"perl" => '($value)? " -preferred" : ""',
	},
	"enzymes" => {
		"perl" => '($value && $value ne $vdef)? " -enzymes=$value" : ""',
	},
	"table" => {
		"perl" => '" -table=$value"',
	},
	"threeletter" => {
		"perl" => '($value)? " -threeletter" : ""',
	},
	"number" => {
		"perl" => '($value)? " -number" : ""',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"length" => {
		"perl" => '(defined $value && $value != $vdef)? " -length=$value" : ""',
	},
	"margin" => {
		"perl" => '(defined $value && $value != $vdef)? " -margin=$value" : ""',
	},
	"name" => {
		"perl" => '($value)? "" : " -noname"',
	},
	"description" => {
		"perl" => '($value)? "" : " -nodescription"',
	},
	"offset" => {
		"perl" => '(defined $value && $value != $vdef)? " -offset=$value" : ""',
	},
	"html" => {
		"perl" => '($value)? " -html" : ""',
	},
	"featuresection" => {
	},
	"matchsource" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchsource=$value" : ""',
	},
	"matchtype" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchtype=$value" : ""',
	},
	"matchsense" => {
		"perl" => '(defined $value && $value != $vdef)? " -matchsense=$value" : ""',
	},
	"minscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -minscore=$value" : ""',
	},
	"maxscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxscore=$value" : ""',
	},
	"matchtag" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchtag=$value" : ""',
	},
	"matchvalue" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchvalue=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"showseq" => {
		"perl" => '"showseq"',
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
	"format" => 2,
	"things" => 3,
	"translate" => 4,
	"orfminsize" => 5,
	"uppercase" => 6,
	"highlight" => 7,
	"annotation" => 8,
	"flatreformat" => 9,
	"mincuts" => 10,
	"maxcuts" => 11,
	"sitelen" => 12,
	"single" => 13,
	"blunt" => 14,
	"sticky" => 15,
	"ambiguity" => 16,
	"plasmid" => 17,
	"commercial" => 18,
	"limit" => 19,
	"preferred" => 20,
	"enzymes" => 21,
	"table" => 22,
	"threeletter" => 23,
	"number" => 24,
	"width" => 25,
	"length" => 26,
	"margin" => 27,
	"name" => 28,
	"description" => 29,
	"offset" => 30,
	"html" => 31,
	"matchsource" => 32,
	"matchtype" => 33,
	"matchsense" => 34,
	"minscore" => 35,
	"maxscore" => 36,
	"matchtag" => 37,
	"matchvalue" => 38,
	"outfile" => 39,
	"auto" => 40,
	"showseq" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"showseq",
	"required",
	"advanced",
	"restrictsection",
	"featuresection",
	"output",
	"sequence",
	"format",
	"things",
	"translate",
	"orfminsize",
	"uppercase",
	"highlight",
	"annotation",
	"flatreformat",
	"mincuts",
	"maxcuts",
	"sitelen",
	"single",
	"blunt",
	"sticky",
	"ambiguity",
	"plasmid",
	"commercial",
	"limit",
	"preferred",
	"enzymes",
	"table",
	"threeletter",
	"number",
	"width",
	"length",
	"margin",
	"name",
	"description",
	"offset",
	"html",
	"matchsource",
	"matchtype",
	"matchsense",
	"minscore",
	"maxscore",
	"matchtag",
	"matchvalue",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"format" => 0,
	"advanced" => 0,
	"things" => 0,
	"translate" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"annotation" => 0,
	"restrictsection" => 0,
	"flatreformat" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"sitelen" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"limit" => 0,
	"preferred" => 0,
	"enzymes" => 0,
	"table" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"featuresection" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchsense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"showseq" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"format" => 0,
	"advanced" => 0,
	"things" => 0,
	"translate" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"annotation" => 0,
	"restrictsection" => 0,
	"flatreformat" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"sitelen" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"limit" => 0,
	"preferred" => 0,
	"enzymes" => 0,
	"table" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"featuresection" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchsense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"format" => 1,
	"advanced" => 0,
	"things" => 1,
	"translate" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"annotation" => 0,
	"restrictsection" => 0,
	"flatreformat" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"sitelen" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"limit" => 0,
	"preferred" => 0,
	"enzymes" => 0,
	"table" => 1,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"featuresection" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchsense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence [sequences] (-sequence)",
	"required" => "required Section",
	"format" => "Display format -- Things to display (-format)",
	"advanced" => "advanced Section",
	"things" => "Enter a list of things to display -- Specify your own things to display [select  values] (-things)",
	"translate" => "Regions to translate (eg: 4-57,78-94) (-translate)",
	"orfminsize" => "Minimum size of ORFs (-orfminsize)",
	"uppercase" => "Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)",
	"highlight" => "Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)",
	"annotation" => "Regions to mark (eg: 4-57 promoter region 78-94 first exon) (-annotation)",
	"restrictsection" => "restriction Section",
	"flatreformat" => "Display RE sites in flat format (-flatreformat)",
	"mincuts" => "Minimum cuts per RE (-mincuts)",
	"maxcuts" => "Maximum cuts per RE (-maxcuts)",
	"sitelen" => "Minimum recognition site length (-sitelen)",
	"single" => "Force single RE site only cuts (-single)",
	"blunt" => "Allow blunt end RE cutters (-blunt)",
	"sticky" => "Allow sticky end RE cutters (-sticky)",
	"ambiguity" => "Allow ambiguous RE matches (-ambiguity)",
	"plasmid" => "Allow circular DNA (-plasmid)",
	"commercial" => "Only use restriction enzymes with suppliers (-commercial)",
	"limit" => "Limits RE hits to one isoschizomer (-limit)",
	"preferred" => "Report preferred isoschizomers (-preferred)",
	"enzymes" => "Comma separated restriction enzyme list (-enzymes)",
	"table" => "Code to use -- Genetic codes (-table)",
	"threeletter" => "Display protein sequences in three-letter code (-threeletter)",
	"number" => "Number the sequences (-number)",
	"width" => "Width of sequence to display (-width)",
	"length" => "Line length of page (0 for indefinite) (-length)",
	"margin" => "Margin around sequence for numbering (-margin)",
	"name" => "Show sequence ID (-name)",
	"description" => "Show description (-description)",
	"offset" => "Offset to start numbering the sequence from (-offset)",
	"html" => "Use HTML formatting (-html)",
	"featuresection" => "feature Section",
	"matchsource" => "Source of feature to display (-matchsource)",
	"matchtype" => "Type of feature to display (-matchtype)",
	"matchsense" => "Sense of feature to display (-matchsense)",
	"minscore" => "Minimum score of feature to display (-minscore)",
	"maxscore" => "Maximum score of feature to display (-maxscore)",
	"matchtag" => "Tag of feature to display (-matchtag)",
	"matchvalue" => "Value of feature tags to display (-matchvalue)",
	"output" => "output Section",
	"outfile" => "Output sequence details to a file (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"format" => 0,
	"advanced" => 0,
	"things" => 0,
	"translate" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"annotation" => 0,
	"restrictsection" => 0,
	"flatreformat" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"sitelen" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"limit" => 0,
	"preferred" => 0,
	"enzymes" => 0,
	"table" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"featuresection" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchsense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['format',],
	"format" => ['0','Enter your own list of things to display','1','Sequence only','2','Default sequence with features','3','Pretty sequence','4','One frame translation','5','Three frame translations','6','Six frame translations','7','Restriction enzyme map','8','Baroque',],
	"advanced" => ['things','translate','orfminsize','uppercase','highlight','annotation','restrictsection','featuresection',],
	"things" => ['S','Sequence','B','Blank line','1','Frame1 translation','2','Frame2 translation','3','Frame3 translation','-1','CompFrame1 translation','-2','CompFrame2 translation','-3','CompFrame3 translation','T','Ticks line','N','Number ticks line','C','Complement sequence','F','Features','R','Restriction enzyme cut sites in forward sense','-R','Restriction enzyme cut sites in reverse sense','A','Annotation',],
	"restrictsection" => ['flatreformat','mincuts','maxcuts','sitelen','single','blunt','sticky','ambiguity','plasmid','commercial','limit','preferred','enzymes',],
	"table" => ['0','Standard','1','Standard (with alternative initiation codons)','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear','16','Chlorophycean Mitochondrial','21','Trematode Mitochondrial','22','Scenedesmus obliquus','23','Thraustochytrium Mitochondrial',],
	"featuresection" => ['matchsource','matchtype','matchsense','minscore','maxscore','matchtag','matchvalue',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"things" => ",",

    };

    $self->{VDEF}  = {
	"format" => '2',
	"things" => ['B,N,T,S,A,F',],
	"orfminsize" => '0',
	"flatreformat" => '0',
	"mincuts" => '1',
	"maxcuts" => '2000000000',
	"sitelen" => '4',
	"single" => '0',
	"blunt" => '1',
	"sticky" => '1',
	"ambiguity" => '1',
	"plasmid" => '0',
	"commercial" => '1',
	"limit" => '1',
	"preferred" => '0',
	"enzymes" => 'all',
	"table" => '0',
	"threeletter" => '0',
	"number" => '0',
	"width" => '60',
	"length" => '0',
	"margin" => '10',
	"name" => '1',
	"description" => '1',
	"offset" => '1',
	"html" => '0',
	"matchsource" => 'all',
	"matchtype" => 'all',
	"matchsense" => '0',
	"minscore" => '0.0',
	"maxscore" => '0.0',
	"matchtag" => 'all',
	"matchvalue" => 'all',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"format" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"things" => {
		"acd" => '@($(format) == 0)',
	},
	"translate" => { "perl" => '1' },
	"orfminsize" => { "perl" => '1' },
	"uppercase" => { "perl" => '1' },
	"highlight" => { "perl" => '1' },
	"annotation" => { "perl" => '1' },
	"restrictsection" => { "perl" => '1' },
	"flatreformat" => { "perl" => '1' },
	"mincuts" => { "perl" => '1' },
	"maxcuts" => { "perl" => '1' },
	"sitelen" => { "perl" => '1' },
	"single" => { "perl" => '1' },
	"blunt" => { "perl" => '1' },
	"sticky" => { "perl" => '1' },
	"ambiguity" => { "perl" => '1' },
	"plasmid" => { "perl" => '1' },
	"commercial" => { "perl" => '1' },
	"limit" => { "perl" => '1' },
	"preferred" => { "perl" => '1' },
	"enzymes" => { "perl" => '1' },
	"table" => { "perl" => '1' },
	"threeletter" => { "perl" => '1' },
	"number" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"margin" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"offset" => { "perl" => '1' },
	"html" => { "perl" => '1' },
	"featuresection" => { "perl" => '1' },
	"matchsource" => { "perl" => '1' },
	"matchtype" => { "perl" => '1' },
	"matchsense" => { "perl" => '1' },
	"minscore" => { "perl" => '1' },
	"maxscore" => { "perl" => '1' },
	"matchtag" => { "perl" => '1' },
	"matchvalue" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

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
	"format" => 0,
	"advanced" => 0,
	"things" => 0,
	"translate" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"annotation" => 0,
	"restrictsection" => 0,
	"flatreformat" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"sitelen" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"limit" => 0,
	"preferred" => 0,
	"enzymes" => 0,
	"table" => 0,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"featuresection" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchsense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"format" => 1,
	"advanced" => 0,
	"things" => 1,
	"translate" => 0,
	"orfminsize" => 0,
	"uppercase" => 0,
	"highlight" => 0,
	"annotation" => 0,
	"restrictsection" => 0,
	"flatreformat" => 0,
	"mincuts" => 0,
	"maxcuts" => 0,
	"sitelen" => 0,
	"single" => 0,
	"blunt" => 0,
	"sticky" => 0,
	"ambiguity" => 0,
	"plasmid" => 0,
	"commercial" => 0,
	"limit" => 0,
	"preferred" => 0,
	"enzymes" => 0,
	"table" => 1,
	"threeletter" => 0,
	"number" => 0,
	"width" => 0,
	"length" => 0,
	"margin" => 0,
	"name" => 0,
	"description" => 0,
	"offset" => 0,
	"html" => 0,
	"featuresection" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchsense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"things" => [
		"Specify a list of one or more code characters in the order in which you wish things to be displayed one above the other down the page. For example if you wish to see things displayed in the order: sequence, complement sequence, ticks line, frame 1 translation, blank line; then you should enter \'S,C,T,1,B\'.",
	],
	"translate" => [
		"Regions to translate (if translating). <BR> If this is left blank the complete sequence is translated. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are separated by any non-digit, non-alpha character. <BR> Examples of region specifications are: <BR> 24-45, 56-78 <BR> 1:45, 67=99;765..888 <BR> 1,5,8,10,23,45,57,99",
	],
	"orfminsize" => [
		"Minimum size of Open Reading Frames (ORFs) to display in the translations.",
	],
	"uppercase" => [
		"Regions to put in uppercase. <BR> If this is left blank, then the sequence case is left alone. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are separated by any non-digit, non-alpha character. <BR> Examples of region specifications are: <BR> 24-45, 56-78 <BR> 1:45, 67=99;765..888 <BR> 1,5,8,10,23,45,57,99",
	],
	"highlight" => [
		"Regions to colour if formatting for HTML. <BR> If this is left blank, then the sequence is left alone. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are followed by any valid HTML font colour. <BR> Examples of region specifications are: <BR> 24-45 blue 56-78 orange <BR> 1-100 green 120-156 red <BR> A file of ranges to colour (one range per line) can be specified as \'\@filename\'.",
	],
	"annotation" => [
		"Regions to annotate by marking. <BR> If this is left blank, then no annotation is added. <BR> A set of regions is specified by a set of pairs of positions followed by optional text. <BR> The positions are integers. <BR> They are followed by any text (but not digits when on the command-line). <BR> Examples of region specifications are: <BR> 24-45 new domain 56-78 match to Mouse <BR> 1-100 First part 120-156 oligo <BR> A file of ranges to annotate (one range per line) can be specified as \'\@filename\'.",
	],
	"enzymes" => [
		"The name \'all\' reads in all enzyme names from the REBASE database. You can specify enzymes by giving their names with commas between then, such as: \'HincII,hinfI,ppiI,hindiii\'. <BR> The case of the names is not important. You can specify a file of enzyme names to read in by giving the name of the file holding the enzyme names with a \'\@\' character in front of it, for example, \'\@enz.list\'. <BR> Blank lines and lines starting with a hash character or \'!\' are ignored and all other lines are concatenated together with a comma character \',\' and then treated as the list of enzymes to search for. <BR> An example of a file of enzyme names is: <BR> ! my enzymes <BR> HincII, ppiII <BR> ! other enzymes <BR> hindiii <BR> HinfI <BR> PpiI",
	],
	"name" => [
		"Set this to be false if you do not wish to display the ID name of the sequence",
	],
	"description" => [
		"Set this to be false if you do not wish to display the description of the sequence",
	],
	"matchsource" => [
		"By default any feature source in the feature table is shown. You can set this to match any feature source you wish to show. <BR> The source name is usually either the name of the program that detected the feature or it is the feature table (eg: EMBL) that the feature came from. <BR> The source may be wildcarded by using \'*\'. <BR> If you wish to show more than one source, separate their names with the character \'|\', eg: <BR> gene* | embl",
	],
	"matchtype" => [
		"By default any feature type in the feature table is shown. You can set this to match any feature type you wish to show. <BR> See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types. <BR> The type may be wildcarded by using \'*\'. <BR> If you wish to show more than one type, separate their names with the character \'|\', eg: <BR> *UTR | intron",
	],
	"matchsense" => [
		"By default any feature type in the feature table is shown. You can set this to match any feature sense you wish to show. 0 - any sense, 1 - forward sense, -1 - reverse sense",
	],
	"minscore" => [
		"If this is greater than or equal to the maximum score, then any score is permitted",
	],
	"maxscore" => [
		"If this is less than or equal to the maximum score, then any score is permitted",
	],
	"matchtag" => [
		"Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Some of these tags also have values, for example \'/gene\' can have the value of the gene name. <BR> By default any feature tag in the feature table is shown. You can set this to match any feature tag you wish to show. <BR> The tag may be wildcarded by using \'*\'. <BR> If you wish to show more than one tag, separate their names with the character \'|\', eg: <BR> gene | label",
	],
	"matchvalue" => [
		"Tag values are the values associated with a feature tag. Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Only some of these tags can have values, for example \'/gene\' can have the value of the gene name. By default any feature tag value in the feature table is shown. You can set this to match any feature tag valueyou wish to show. <BR> The tag value may be wildcarded by using \'*\'. <BR> If you wish to show more than one tag value, separate their names with the character \'|\', eg: <BR> pax* | 10",
	],
	"outfile" => [
		"If you enter the name of a file here then this program will write the sequence details into that file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

