# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::twofeat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::twofeat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::twofeat

      Bioperl class for:

	TWOFEAT	Finds neighbouring pairs of features in sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/twofeat.html 
         for available values):


		twofeat (String)

		init (String)

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		asource (String)
			Source of first feature (-asource)

		atype (String)
			Type of first feature (-atype)

		asense (Excl)
			Sense of first feature -- Sense of first feature (-asense)

		aminscore (Float)
			Minimum score of first feature (-aminscore)

		amaxscore (Float)
			Maximum score of first feature (-amaxscore)

		atag (String)
			Tag of first feature (-atag)

		avalue (String)
			Value of first feature's tags (-avalue)

		bsource (String)
			Source of second feature (-bsource)

		btype (String)
			Type of second feature (-btype)

		bsense (Excl)
			Sense of second feature -- Sense of second feature (-bsense)

		bminscore (Float)
			Minimum score of second feature (-bminscore)

		bmaxscore (Float)
			Maximum score of second feature (-bmaxscore)

		btag (String)
			Tag of second feature (-btag)

		bvalue (String)
			Value of second feature's tags (-bvalue)

		overlap (Excl)
			Specify overlap -- Type of overlap required (-overlap)

		minrange (Integer)
			The minimum distance between the features (-minrange)

		maxrange (Integer)
			The maximum distance between the features (-maxrange)

		rangetype (Excl)
			Specify position -- Positions from which to measure the distance (-rangetype)

		sense (Excl)
			Specify sense -- Sense of the features (-sense)

		order (Excl)
			Specify order -- Order of the features (-order)

		twoout (Switch)
			Do you want the two features written out individually (-twoout)

		typeout (String)
			Name of the output new feature (-typeout)

		outfile (OutFile)
			Output feature report (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/twofeat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::twofeat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $twofeat = Bio::Tools::Run::PiseApplication::twofeat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::twofeat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $twofeat = $factory->program('twofeat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::twofeat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/twofeat.pm

    $self->{COMMAND}   = "twofeat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TWOFEAT";

    $self->{DESCRIPTION}   = "Finds neighbouring pairs of features in sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "feature tables",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/twofeat.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"twofeat",
	"init",
	"input",
	"afeature",
	"bfeature",
	"relation",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"twofeat",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"afeature", 	# Select feature a
	"asource", 	# Source of first feature (-asource)
	"atype", 	# Type of first feature (-atype)
	"asense", 	# Sense of first feature -- Sense of first feature (-asense)
	"aminscore", 	# Minimum score of first feature (-aminscore)
	"amaxscore", 	# Maximum score of first feature (-amaxscore)
	"atag", 	# Tag of first feature (-atag)
	"avalue", 	# Value of first feature's tags (-avalue)
	"bfeature", 	# Select feature b
	"bsource", 	# Source of second feature (-bsource)
	"btype", 	# Type of second feature (-btype)
	"bsense", 	# Sense of second feature -- Sense of second feature (-bsense)
	"bminscore", 	# Minimum score of second feature (-bminscore)
	"bmaxscore", 	# Maximum score of second feature (-bmaxscore)
	"btag", 	# Tag of second feature (-btag)
	"bvalue", 	# Value of second feature's tags (-bvalue)
	"relation", 	# relation Section
	"overlap", 	# Specify overlap -- Type of overlap required (-overlap)
	"minrange", 	# The minimum distance between the features (-minrange)
	"maxrange", 	# The maximum distance between the features (-maxrange)
	"rangetype", 	# Specify position -- Positions from which to measure the distance (-rangetype)
	"sense", 	# Specify sense -- Sense of the features (-sense)
	"order", 	# Specify order -- Order of the features (-order)
	"output", 	# output Section
	"twoout", 	# Do you want the two features written out individually (-twoout)
	"typeout", 	# Name of the output new feature (-typeout)
	"outfile", 	# Output feature report (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"twofeat" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"afeature" => 'Paragraph',
	"asource" => 'String',
	"atype" => 'String',
	"asense" => 'Excl',
	"aminscore" => 'Float',
	"amaxscore" => 'Float',
	"atag" => 'String',
	"avalue" => 'String',
	"bfeature" => 'Paragraph',
	"bsource" => 'String',
	"btype" => 'String',
	"bsense" => 'Excl',
	"bminscore" => 'Float',
	"bmaxscore" => 'Float',
	"btag" => 'String',
	"bvalue" => 'String',
	"relation" => 'Paragraph',
	"overlap" => 'Excl',
	"minrange" => 'Integer',
	"maxrange" => 'Integer',
	"rangetype" => 'Excl',
	"sense" => 'Excl',
	"order" => 'Excl',
	"output" => 'Paragraph',
	"twoout" => 'Switch',
	"typeout" => 'String',
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
	"afeature" => {
	},
	"asource" => {
		"perl" => '($value && $value =~ s/all/*/)? " -asource=$value" : ""',
	},
	"atype" => {
		"perl" => '($value && $value =~ s/all/*/)? " -atype=$value" : ""',
	},
	"asense" => {
		"perl" => '" -asense=$value"',
	},
	"aminscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -aminscore=$value" : ""',
	},
	"amaxscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -amaxscore=$value" : ""',
	},
	"atag" => {
		"perl" => '($value && $value =~ s/all/*/)? " -atag=$value" : ""',
	},
	"avalue" => {
		"perl" => '($value && $value =~ s/all/*/)? " -avalue=$value" : ""',
	},
	"bfeature" => {
	},
	"bsource" => {
		"perl" => '($value && $value =~ s/all/*/)? " -bsource=$value" : ""',
	},
	"btype" => {
		"perl" => '($value && $value =~ s/all/*/)? " -btype=$value" : ""',
	},
	"bsense" => {
		"perl" => '" -bsense=$value"',
	},
	"bminscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -bminscore=$value" : ""',
	},
	"bmaxscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -bmaxscore=$value" : ""',
	},
	"btag" => {
		"perl" => '($value && $value =~ s/all/*/)? " -btag=$value" : ""',
	},
	"bvalue" => {
		"perl" => '($value && $value =~ s/all/*/)? " -bvalue=$value" : ""',
	},
	"relation" => {
	},
	"overlap" => {
		"perl" => '" -overlap=$value"',
	},
	"minrange" => {
		"perl" => '(defined $value && $value != $vdef)? " -minrange=$value" : ""',
	},
	"maxrange" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxrange=$value" : ""',
	},
	"rangetype" => {
		"perl" => '" -rangetype=$value"',
	},
	"sense" => {
		"perl" => '" -sense=$value"',
	},
	"order" => {
		"perl" => '" -order=$value"',
	},
	"output" => {
	},
	"twoout" => {
		"perl" => '($value)? " -twoout" : ""',
	},
	"typeout" => {
		"perl" => '($value && $value ne $vdef)? " -typeout=$value" : ""',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"twofeat" => {
		"perl" => '"twofeat"',
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
	"asource" => 2,
	"atype" => 3,
	"asense" => 4,
	"aminscore" => 5,
	"amaxscore" => 6,
	"atag" => 7,
	"avalue" => 8,
	"bsource" => 9,
	"btype" => 10,
	"bsense" => 11,
	"bminscore" => 12,
	"bmaxscore" => 13,
	"btag" => 14,
	"bvalue" => 15,
	"overlap" => 16,
	"minrange" => 17,
	"maxrange" => 18,
	"rangetype" => 19,
	"sense" => 20,
	"order" => 21,
	"twoout" => 22,
	"typeout" => 23,
	"outfile" => 24,
	"auto" => 25,
	"twofeat" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"twofeat",
	"afeature",
	"bfeature",
	"relation",
	"output",
	"sequence",
	"asource",
	"atype",
	"asense",
	"aminscore",
	"amaxscore",
	"atag",
	"avalue",
	"bsource",
	"btype",
	"bsense",
	"bminscore",
	"bmaxscore",
	"btag",
	"bvalue",
	"overlap",
	"minrange",
	"maxrange",
	"rangetype",
	"sense",
	"order",
	"twoout",
	"typeout",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"afeature" => 0,
	"asource" => 0,
	"atype" => 0,
	"asense" => 0,
	"aminscore" => 0,
	"amaxscore" => 0,
	"atag" => 0,
	"avalue" => 0,
	"bfeature" => 0,
	"bsource" => 0,
	"btype" => 0,
	"bsense" => 0,
	"bminscore" => 0,
	"bmaxscore" => 0,
	"btag" => 0,
	"bvalue" => 0,
	"relation" => 0,
	"overlap" => 0,
	"minrange" => 0,
	"maxrange" => 0,
	"rangetype" => 0,
	"sense" => 0,
	"order" => 0,
	"output" => 0,
	"twoout" => 0,
	"typeout" => 0,
	"outfile" => 0,
	"auto" => 1,
	"twofeat" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"afeature" => 0,
	"asource" => 0,
	"atype" => 0,
	"asense" => 0,
	"aminscore" => 0,
	"amaxscore" => 0,
	"atag" => 0,
	"avalue" => 0,
	"bfeature" => 0,
	"bsource" => 0,
	"btype" => 0,
	"bsense" => 0,
	"bminscore" => 0,
	"bmaxscore" => 0,
	"btag" => 0,
	"bvalue" => 0,
	"relation" => 0,
	"overlap" => 0,
	"minrange" => 0,
	"maxrange" => 0,
	"rangetype" => 0,
	"sense" => 0,
	"order" => 0,
	"output" => 0,
	"twoout" => 0,
	"typeout" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"afeature" => 0,
	"asource" => 0,
	"atype" => 0,
	"asense" => 1,
	"aminscore" => 0,
	"amaxscore" => 0,
	"atag" => 0,
	"avalue" => 0,
	"bfeature" => 0,
	"bsource" => 0,
	"btype" => 0,
	"bsense" => 1,
	"bminscore" => 0,
	"bmaxscore" => 0,
	"btag" => 0,
	"bvalue" => 0,
	"relation" => 0,
	"overlap" => 1,
	"minrange" => 0,
	"maxrange" => 0,
	"rangetype" => 1,
	"sense" => 1,
	"order" => 1,
	"output" => 0,
	"twoout" => 0,
	"typeout" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"afeature" => "Select feature a",
	"asource" => "Source of first feature (-asource)",
	"atype" => "Type of first feature (-atype)",
	"asense" => "Sense of first feature -- Sense of first feature (-asense)",
	"aminscore" => "Minimum score of first feature (-aminscore)",
	"amaxscore" => "Maximum score of first feature (-amaxscore)",
	"atag" => "Tag of first feature (-atag)",
	"avalue" => "Value of first feature's tags (-avalue)",
	"bfeature" => "Select feature b",
	"bsource" => "Source of second feature (-bsource)",
	"btype" => "Type of second feature (-btype)",
	"bsense" => "Sense of second feature -- Sense of second feature (-bsense)",
	"bminscore" => "Minimum score of second feature (-bminscore)",
	"bmaxscore" => "Maximum score of second feature (-bmaxscore)",
	"btag" => "Tag of second feature (-btag)",
	"bvalue" => "Value of second feature's tags (-bvalue)",
	"relation" => "relation Section",
	"overlap" => "Specify overlap -- Type of overlap required (-overlap)",
	"minrange" => "The minimum distance between the features (-minrange)",
	"maxrange" => "The maximum distance between the features (-maxrange)",
	"rangetype" => "Specify position -- Positions from which to measure the distance (-rangetype)",
	"sense" => "Specify sense -- Sense of the features (-sense)",
	"order" => "Specify order -- Order of the features (-order)",
	"output" => "output Section",
	"twoout" => "Do you want the two features written out individually (-twoout)",
	"typeout" => "Name of the output new feature (-typeout)",
	"outfile" => "Output feature report (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"afeature" => 0,
	"asource" => 0,
	"atype" => 0,
	"asense" => 0,
	"aminscore" => 0,
	"amaxscore" => 0,
	"atag" => 0,
	"avalue" => 0,
	"bfeature" => 0,
	"bsource" => 0,
	"btype" => 0,
	"bsense" => 0,
	"bminscore" => 0,
	"bmaxscore" => 0,
	"btag" => 0,
	"bvalue" => 0,
	"relation" => 0,
	"overlap" => 0,
	"minrange" => 0,
	"maxrange" => 0,
	"rangetype" => 0,
	"sense" => 0,
	"order" => 0,
	"output" => 0,
	"twoout" => 0,
	"typeout" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"afeature" => ['asource','atype','asense','aminscore','amaxscore','atag','avalue',],
	"asense" => ['0','Any sense','+','Forward sense','-','Reverse sense',],
	"bfeature" => ['bsource','btype','bsense','bminscore','bmaxscore','btag','bvalue',],
	"bsense" => ['0','Any sense','+','Forward sense','-','Reverse sense',],
	"relation" => ['overlap','minrange','maxrange','rangetype','sense','order',],
	"overlap" => ['A','Any','O','Overlap required','NO','No overlaps are allowed','NW','Overlap required but not within','AW','A must be all within B','BW','B must be all within A',],
	"rangetype" => ['N','From nearest ends','L','From left ends','R','From right ends','F','From furthest ends',],
	"sense" => ['A','Any sense','S','Same sense','O','Opposite sense',],
	"order" => ['A','Any','AB','Feature A then feature B','BA','Feature B then feature A',],
	"output" => ['twoout','typeout','outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"asource" => 'all',
	"atype" => 'all',
	"asense" => '0',
	"aminscore" => '0.0',
	"amaxscore" => '0.0',
	"atag" => 'all',
	"avalue" => 'all',
	"bsource" => 'all',
	"btype" => 'all',
	"bsense" => '0',
	"bminscore" => '0.0',
	"bmaxscore" => '0.0',
	"btag" => 'all',
	"bvalue" => 'all',
	"overlap" => 'A',
	"minrange" => '0',
	"maxrange" => '0',
	"rangetype" => 'N',
	"sense" => 'A',
	"order" => 'A',
	"twoout" => '0',
	"typeout" => 'misc_feature',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"afeature" => { "perl" => '1' },
	"asource" => { "perl" => '1' },
	"atype" => { "perl" => '1' },
	"asense" => { "perl" => '1' },
	"aminscore" => { "perl" => '1' },
	"amaxscore" => { "perl" => '1' },
	"atag" => { "perl" => '1' },
	"avalue" => { "perl" => '1' },
	"bfeature" => { "perl" => '1' },
	"bsource" => { "perl" => '1' },
	"btype" => { "perl" => '1' },
	"bsense" => { "perl" => '1' },
	"bminscore" => { "perl" => '1' },
	"bmaxscore" => { "perl" => '1' },
	"btag" => { "perl" => '1' },
	"bvalue" => { "perl" => '1' },
	"relation" => { "perl" => '1' },
	"overlap" => { "perl" => '1' },
	"minrange" => { "perl" => '1' },
	"maxrange" => { "perl" => '1' },
	"rangetype" => { "perl" => '1' },
	"sense" => { "perl" => '1' },
	"order" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"twoout" => { "perl" => '1' },
	"typeout" => { "perl" => '1' },
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
	"afeature" => 0,
	"asource" => 0,
	"atype" => 0,
	"asense" => 0,
	"aminscore" => 0,
	"amaxscore" => 0,
	"atag" => 0,
	"avalue" => 0,
	"bfeature" => 0,
	"bsource" => 0,
	"btype" => 0,
	"bsense" => 0,
	"bminscore" => 0,
	"bmaxscore" => 0,
	"btag" => 0,
	"bvalue" => 0,
	"relation" => 0,
	"overlap" => 0,
	"minrange" => 0,
	"maxrange" => 0,
	"rangetype" => 0,
	"sense" => 0,
	"order" => 0,
	"output" => 0,
	"twoout" => 0,
	"typeout" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"afeature" => 0,
	"asource" => 0,
	"atype" => 0,
	"asense" => 1,
	"aminscore" => 0,
	"amaxscore" => 0,
	"atag" => 0,
	"avalue" => 0,
	"bfeature" => 0,
	"bsource" => 0,
	"btype" => 0,
	"bsense" => 1,
	"bminscore" => 0,
	"bmaxscore" => 0,
	"btag" => 0,
	"bvalue" => 0,
	"relation" => 0,
	"overlap" => 1,
	"minrange" => 0,
	"maxrange" => 0,
	"rangetype" => 1,
	"sense" => 1,
	"order" => 1,
	"output" => 0,
	"twoout" => 0,
	"typeout" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"asource" => [
		"By default any feature source in the feature table is allowed. You can set this to match any feature source you wish to allow. <BR> The source name is usually either the name of the program that detected the feature or it is the feature table (eg: EMBL) that the feature came from. <BR> The source may be wildcarded by using \'*\'. <BR> If you wish to allow more than one source, separate their names with the character \'|\', eg: <BR> gene* | embl",
	],
	"atype" => [
		"By default every feature in the feature table is allowed. You can set this to be any feature type you wish to allow. <BR> See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types. <BR> The type may be wildcarded by using \'*\'. <BR> If you wish to allow more than one type, separate their names with the character \'|\', eg: <BR> *UTR | intron",
	],
	"asense" => [
		"By default any feature sense is allowed. You can set this to match the required sense.",
	],
	"aminscore" => [
		"If this is greater than or equal to the maximum score, then any score is allowed.",
	],
	"amaxscore" => [
		"If this is less than or equal to the maximum score, then any score is permitted.",
	],
	"atag" => [
		"Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Some of these tags also have values, for example \'/gene\' can have the value of the gene name. <BR> By default any feature tag in the feature table is allowed. You can set this to match any feature tag you wish to allow. <BR> The tag may be wildcarded by using \'*\'. <BR> If you wish to allow more than one tag, separate their names with the character \'|\', eg: <BR> gene | label",
	],
	"avalue" => [
		"Tag values are the values associated with a feature tag. Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Only some of these tags can have values, for example \'/gene\' can have the value of the gene name. By default any feature tag value in the feature table is allowed. You can set this to match any feature tag value you wish to allow. <BR> The tag value may be wildcarded by using \'*\'. <BR> If you wish to allow more than one tag value, separate their names with the character \'|\', eg: <BR> pax* | 10",
	],
	"bsource" => [
		"By default any feature source in the feature table is allowed. You can set this to match any feature source you wish to allow. <BR> The source name is usually either the name of the program that detected the feature or it is the feature table (eg: EMBL) that the feature came from. <BR> The source may be wildcarded by using \'*\'. <BR> If you wish to allow more than one source, separate their names with the character \'|\', eg: <BR> gene* | embl",
	],
	"btype" => [
		"By default every feature in the feature table is allowed. You can set this to be any feature type you wish to allow. <BR> See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types. <BR> The type may be wildcarded by using \'*\'. <BR> If you wish to allow more than one type, separate their names with the character \'|\', eg: <BR> *UTR | intron",
	],
	"bsense" => [
		"By default any feature sense is allowed. You can set this to match the required sense.",
	],
	"bminscore" => [
		"If this is greater than or equal to the maximum score, then any score is allowed.",
	],
	"bmaxscore" => [
		"If this is less than or equal to the maximum score, then any score is permitted.",
	],
	"btag" => [
		"Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Some of these tags also have values, for example \'/gene\' can have the value of the gene name. <BR> By default any feature tag in the feature table is allowed. You can set this to match any feature tag you wish to allow. <BR> The tag may be wildcarded by using \'*\'. <BR> If you wish to allow more than one tag, separate their names with the character \'|\', eg: <BR> gene | label",
	],
	"bvalue" => [
		"Tag values are the values associated with a feature tag. Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Only some of these tags can have values, for example \'/gene\' can have the value of the gene name. By default any feature tag value in the feature table is allowed. You can set this to match any feature tag value you wish to allow. <BR> The tag value may be wildcarded by using \'*\'. <BR> If you wish to allow more than one tag value, separate their names with the character \'|\', eg: <BR> pax* | 10",
	],
	"overlap" => [
		"This allows you to specify the allowed overlaps of the features A and B. <BR> You can allow any or no overlaps, specify that they must or must not overlap, that one must or must not be wholly enclosed within another feature.",
	],
	"minrange" => [
		"If this is greater or equal to \'maxrange\', then no min or max range is specified",
	],
	"maxrange" => [
		"If this is less than or equal to \'minrange\', then no min or max range is specified",
	],
	"rangetype" => [
		"This allows you to specify the positions from which the allowed minimum or maximum distance between the features is measured",
	],
	"sense" => [
		"This allows you to specify the required sense that the two features must be on. This is ignored (always \'Any\') when looking at protein sequence features.",
	],
	"order" => [
		"This allows you to specify the required order of the two features. The order is measured from the start positions of the features. This criterion is always applied despite the specified overlap type required.",
	],
	"twoout" => [
		"If you set this to be true, then the two features themselves will be written out. If it is left as false, then a single feature will be written out covering the two features you found.",
	],
	"typeout" => [
		"If you have specified that the pairs of features that are found should be reported as one feature in the ouput, then you can specify the \'type\' name of the new feature here.  By default every feature in the feature table is allowed.  See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types.  If you specify an invalid feature type name, then the default name \'misc_feature\' is used.",
	],
	"outfile" => [
		"File for output of neighbouring feature regions. This contains details of the pairs of features. By default, it is written in TABLE format.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/twofeat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

