# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::showfeat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::showfeat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::showfeat

      Bioperl class for:

	SHOWFEAT	Show features of a sequence. (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/showfeat.html 
         for available values):


		showfeat (String)

		init (String)

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		matchsource (String)
			Source of feature to display (-matchsource)

		matchtype (String)
			Type of feature to display (-matchtype)

		matchtag (String)
			Tag of feature to display (-matchtag)

		matchvalue (String)
			Value of feature tags to display (-matchvalue)

		sort (Excl)
			Sort features by Type, Start or Source, Nosort (don't sort - use input order) or join coding regions together and leave other features in the input order -- Sorting features (-sort)

		html (Switch)
			Use HTML formatting (-html)

		id (Switch)
			Show sequence ID (-id)

		description (Switch)
			Show description (-description)

		scale (Switch)
			Show scale line (-scale)

		width (Integer)
			Width of graphics lines (-width)

		collapse (Switch)
			Display features with the same type on one line (-collapse)

		forward (Switch)
			Display forward sense features (-forward)

		reverse (Switch)
			Display reverse sense features (-reverse)

		unknown (Switch)
			Display unknown sense features (-unknown)

		strand (Switch)
			Display strand of features (-strand)

		source (Switch)
			Display source of features (-source)

		position (Switch)
			Display position of features (-position)

		type (Switch)
			Display type of features (-type)

		tags (Switch)
			Display tags of features (-tags)

		values (Switch)
			Display tag values of features (-values)

		outfile (OutFile)
			Output feature details to a file (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/showfeat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::showfeat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $showfeat = Bio::Tools::Run::PiseApplication::showfeat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::showfeat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $showfeat = $factory->program('showfeat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::showfeat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showfeat.pm

    $self->{COMMAND}   = "showfeat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SHOWFEAT";

    $self->{DESCRIPTION}   = "Show features of a sequence. (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",

         "feature tables",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/showfeat.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"showfeat",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"showfeat",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"advanced", 	# advanced Section
	"matchsource", 	# Source of feature to display (-matchsource)
	"matchtype", 	# Type of feature to display (-matchtype)
	"matchtag", 	# Tag of feature to display (-matchtag)
	"matchvalue", 	# Value of feature tags to display (-matchvalue)
	"sort", 	# Sort features by Type, Start or Source, Nosort (don't sort - use input order) or join coding regions together and leave other features in the input order -- Sorting features (-sort)
	"html", 	# Use HTML formatting (-html)
	"id", 	# Show sequence ID (-id)
	"description", 	# Show description (-description)
	"scale", 	# Show scale line (-scale)
	"width", 	# Width of graphics lines (-width)
	"collapse", 	# Display features with the same type on one line (-collapse)
	"forward", 	# Display forward sense features (-forward)
	"reverse", 	# Display reverse sense features (-reverse)
	"unknown", 	# Display unknown sense features (-unknown)
	"strand", 	# Display strand of features (-strand)
	"source", 	# Display source of features (-source)
	"position", 	# Display position of features (-position)
	"type", 	# Display type of features (-type)
	"tags", 	# Display tags of features (-tags)
	"values", 	# Display tag values of features (-values)
	"output", 	# output Section
	"outfile", 	# Output feature details to a file (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"showfeat" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"matchsource" => 'String',
	"matchtype" => 'String',
	"matchtag" => 'String',
	"matchvalue" => 'String',
	"sort" => 'Excl',
	"html" => 'Switch',
	"id" => 'Switch',
	"description" => 'Switch',
	"scale" => 'Switch',
	"width" => 'Integer',
	"collapse" => 'Switch',
	"forward" => 'Switch',
	"reverse" => 'Switch',
	"unknown" => 'Switch',
	"strand" => 'Switch',
	"source" => 'Switch',
	"position" => 'Switch',
	"type" => 'Switch',
	"tags" => 'Switch',
	"values" => 'Switch',
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
	"advanced" => {
	},
	"matchsource" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchsource=$value" : ""',
	},
	"matchtype" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchtype=$value" : ""',
	},
	"matchtag" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchtag=$value" : ""',
	},
	"matchvalue" => {
		"perl" => '($value && $value =~ s/all/*/)? " -matchvalue=$value" : ""',
	},
	"sort" => {
		"perl" => '" -sort=$value"',
	},
	"html" => {
		"perl" => '($value)? " -html" : ""',
	},
	"id" => {
		"perl" => '($value)? "" : " -noid"',
	},
	"description" => {
		"perl" => '($value)? "" : " -nodescription"',
	},
	"scale" => {
		"perl" => '($value)? "" : " -noscale"',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"collapse" => {
		"perl" => '($value)? " -collapse" : ""',
	},
	"forward" => {
		"perl" => '($value)? "" : " -noforward"',
	},
	"reverse" => {
		"perl" => '($value)? "" : " -noreverse"',
	},
	"unknown" => {
		"perl" => '($value)? "" : " -nounknown"',
	},
	"strand" => {
		"perl" => '($value)? " -strand" : ""',
	},
	"source" => {
		"perl" => '($value)? " -source" : ""',
	},
	"position" => {
		"perl" => '($value)? " -position" : ""',
	},
	"type" => {
		"perl" => '($value)? "" : " -notype"',
	},
	"tags" => {
		"perl" => '($value)? " -tags" : ""',
	},
	"values" => {
		"perl" => '($value)? "" : " -novalues"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"showfeat" => {
		"perl" => '"showfeat"',
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
	"matchsource" => 2,
	"matchtype" => 3,
	"matchtag" => 4,
	"matchvalue" => 5,
	"sort" => 6,
	"html" => 7,
	"id" => 8,
	"description" => 9,
	"scale" => 10,
	"width" => 11,
	"collapse" => 12,
	"forward" => 13,
	"reverse" => 14,
	"unknown" => 15,
	"strand" => 16,
	"source" => 17,
	"position" => 18,
	"type" => 19,
	"tags" => 20,
	"values" => 21,
	"outfile" => 22,
	"auto" => 23,
	"showfeat" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"showfeat",
	"sequence",
	"matchsource",
	"matchtype",
	"matchtag",
	"matchvalue",
	"sort",
	"html",
	"id",
	"description",
	"scale",
	"width",
	"collapse",
	"forward",
	"reverse",
	"unknown",
	"strand",
	"source",
	"position",
	"type",
	"tags",
	"values",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"sort" => 0,
	"html" => 0,
	"id" => 0,
	"description" => 0,
	"scale" => 0,
	"width" => 0,
	"collapse" => 0,
	"forward" => 0,
	"reverse" => 0,
	"unknown" => 0,
	"strand" => 0,
	"source" => 0,
	"position" => 0,
	"type" => 0,
	"tags" => 0,
	"values" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"showfeat" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"sort" => 0,
	"html" => 0,
	"id" => 0,
	"description" => 0,
	"scale" => 0,
	"width" => 0,
	"collapse" => 0,
	"forward" => 0,
	"reverse" => 0,
	"unknown" => 0,
	"strand" => 0,
	"source" => 0,
	"position" => 0,
	"type" => 0,
	"tags" => 0,
	"values" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"sort" => 1,
	"html" => 0,
	"id" => 0,
	"description" => 0,
	"scale" => 0,
	"width" => 0,
	"collapse" => 0,
	"forward" => 0,
	"reverse" => 0,
	"unknown" => 0,
	"strand" => 0,
	"source" => 0,
	"position" => 0,
	"type" => 0,
	"tags" => 0,
	"values" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"matchsource" => "Source of feature to display (-matchsource)",
	"matchtype" => "Type of feature to display (-matchtype)",
	"matchtag" => "Tag of feature to display (-matchtag)",
	"matchvalue" => "Value of feature tags to display (-matchvalue)",
	"sort" => "Sort features by Type, Start or Source, Nosort (don't sort - use input order) or join coding regions together and leave other features in the input order -- Sorting features (-sort)",
	"html" => "Use HTML formatting (-html)",
	"id" => "Show sequence ID (-id)",
	"description" => "Show description (-description)",
	"scale" => "Show scale line (-scale)",
	"width" => "Width of graphics lines (-width)",
	"collapse" => "Display features with the same type on one line (-collapse)",
	"forward" => "Display forward sense features (-forward)",
	"reverse" => "Display reverse sense features (-reverse)",
	"unknown" => "Display unknown sense features (-unknown)",
	"strand" => "Display strand of features (-strand)",
	"source" => "Display source of features (-source)",
	"position" => "Display position of features (-position)",
	"type" => "Display type of features (-type)",
	"tags" => "Display tags of features (-tags)",
	"values" => "Display tag values of features (-values)",
	"output" => "output Section",
	"outfile" => "Output feature details to a file (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"sort" => 0,
	"html" => 0,
	"id" => 0,
	"description" => 0,
	"scale" => 0,
	"width" => 0,
	"collapse" => 0,
	"forward" => 0,
	"reverse" => 0,
	"unknown" => 0,
	"strand" => 0,
	"source" => 0,
	"position" => 0,
	"type" => 0,
	"tags" => 0,
	"values" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['matchsource','matchtype','matchtag','matchvalue','sort','html','id','description','scale','width','collapse','forward','reverse','unknown','strand','source','position','type','tags','values',],
	"sort" => ['source','Sort by Source','start','Sort by Start position','type','Sort by Type','nosort','No sorting done','join','Join coding regions together',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"matchsource" => 'all',
	"matchtype" => 'all',
	"matchtag" => 'all',
	"matchvalue" => 'all',
	"sort" => 'start',
	"html" => '0',
	"id" => '1',
	"description" => '1',
	"scale" => '1',
	"width" => '60',
	"collapse" => '0',
	"forward" => '1',
	"reverse" => '1',
	"unknown" => '1',
	"strand" => '0',
	"source" => '0',
	"position" => '0',
	"type" => '1',
	"tags" => '0',
	"values" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"matchsource" => { "perl" => '1' },
	"matchtype" => { "perl" => '1' },
	"matchtag" => { "perl" => '1' },
	"matchvalue" => { "perl" => '1' },
	"sort" => { "perl" => '1' },
	"html" => { "perl" => '1' },
	"id" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"collapse" => { "perl" => '1' },
	"forward" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"unknown" => { "perl" => '1' },
	"strand" => { "perl" => '1' },
	"source" => { "perl" => '1' },
	"position" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"tags" => { "perl" => '1' },
	"values" => { "perl" => '1' },
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
	"advanced" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"sort" => 0,
	"html" => 0,
	"id" => 0,
	"description" => 0,
	"scale" => 0,
	"width" => 0,
	"collapse" => 0,
	"forward" => 0,
	"reverse" => 0,
	"unknown" => 0,
	"strand" => 0,
	"source" => 0,
	"position" => 0,
	"type" => 0,
	"tags" => 0,
	"values" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"matchsource" => 0,
	"matchtype" => 0,
	"matchtag" => 0,
	"matchvalue" => 0,
	"sort" => 1,
	"html" => 0,
	"id" => 0,
	"description" => 0,
	"scale" => 0,
	"width" => 0,
	"collapse" => 0,
	"forward" => 0,
	"reverse" => 0,
	"unknown" => 0,
	"strand" => 0,
	"source" => 0,
	"position" => 0,
	"type" => 0,
	"tags" => 0,
	"values" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"matchsource" => [
		"By default any feature source in the feature table is shown. You can set this to match any feature source you wish to show. <BR> The source name is usually either the name of the program that detected the feature or it is the feature table (eg: EMBL) that the feature came from. <BR> The source may be wildcarded by using \'*\'. <BR> If you wish to show more than one source, separate their names with the character \'|\', eg: <BR> gene* | embl",
	],
	"matchtype" => [
		"By default any feature type in the feature table is shown. You can set this to match any feature type you wish to show. <BR> See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types. <BR> The type may be wildcarded by using \'*\'. <BR> If you wish to show more than one type, separate their names with the character \'|\', eg: <BR> *UTR | intron",
	],
	"matchtag" => [
		"Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Some of these tags also have values, for example \'/gene\' can have the value of the gene name. <BR> By default any feature tag in the feature table is shown. You can set this to match any feature tag you wish to show. <BR> The tag may be wildcarded by using \'*\'. <BR> If you wish to show more than one tag, separate their names with the character \'|\', eg: <BR> gene | label",
	],
	"matchvalue" => [
		"Tag values are the values associated with a feature tag. Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Only some of these tags can have values, for example \'/gene\' can have the value of the gene name. By default any feature tag value in the feature table is shown. You can set this to match any feature tag valueyou wish to show. <BR> The tag value may be wildcarded by using \'*\'. <BR> If you wish to show more than one tag value, separate their names with the character \'|\', eg: <BR> pax* | 10",
	],
	"id" => [
		"Set this to be false if you do not wish to display the ID name of the sequence.",
	],
	"description" => [
		"Set this to be false if you do not wish to display the description of the sequence.",
	],
	"scale" => [
		"Set this to be false if you do not wish to display the scale line.",
	],
	"width" => [
		"You can expand (or contract) the width of the ASCII-character graphics display of the positions of the features using this value. <BR> For example, a width of 80 characters would cover a standard page width and a width a 10 characters would be nearly unreadable. <BR> If the width is set to less than 4, the graphics lines and the scale line will not be displayed.",
	],
	"collapse" => [
		"If this is set, then features from the same source and of the same type and sense are all printed on the same line. For instance if there are several features from the EMBL feature table (ie. the same source) which are all of type \'exon\' in the same sense, then they will all be displayed on the same line. This makes it hard to distinguish overlapping features. <BR> If this is set to false then each feature is displayed on a separate line making it easier to distinguish where features start and end.",
	],
	"forward" => [
		"Set this to be false if you do not wish to display forward sense features.",
	],
	"reverse" => [
		"Set this to be false if you do not wish to display reverse sense features.",
	],
	"unknown" => [
		"Set this to be false if you do not wish to display unknown sense features. (ie. features with no directionality - all protein features are of this type and some nucleic features (for example, CG-rich regions)).",
	],
	"strand" => [
		"Set this if you wish to display the strand of the features. Protein features are always directionless (indicated by \'0\'), forward is indicated by \'+\' and reverse is \'-\'.",
	],
	"source" => [
		"Set this if you wish to display the source of the features. <BR> The source name is usually either the name of the program that detected the feature or it is the name of the feature table (eg: EMBL) that the feature came from.",
	],
	"position" => [
		"Set this if you wish to display the start and end position of the features. If several features are being displayed on the same line, then the start and end positions will be joined by a comma, for example: \'189-189,225-225\'.",
	],
	"type" => [
		"Set this to be false if you do not wish to display the type of the features.",
	],
	"tags" => [
		"Set this to be false if you do not wish to display the tags and values of the features.",
	],
	"values" => [
		"Set this to be false if you do not wish to display the tag values of the features. If this is set to be false, only the tag names will be displayed. If the tags are not displayed, then the values will not be displayed. The value of the \'translation\' tag is never displayed as it is often extremely long.",
	],
	"outfile" => [
		"If you enter the name of a file here then this program will write the feature details into that file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showfeat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

