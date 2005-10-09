# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pestfind
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pestfind

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pestfind

      Bioperl class for:

	PESTFIND	Finds PEST motifs as potential proteolytic cleavage sites (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pestfind.html 
         for available values):


		pestfind (String)

		init (String)

		sequence (Sequence)
			Enter input sequence (-sequence)
			pipe: seqfile

		window (Integer)
			Enter window length (-window)

		order (Excl)
			Select sort order of results -- Sort order of results (-order)

		potential (Switch)
			Display potential PEST motifs (-potential)

		poor (Switch)
			Display poor PEST motifs (-poor)

		invalid (Switch)
			Display invalid PEST motifs (-invalid)

		map (Switch)
			Display PEST motifs map (-map)

		outfile (OutFile)
			Enter output filename (-outfile)

		graph (Excl)
			graph (-graph)

		threshold (Float)
			Enter threshold score (-threshold)

		aadata (String)
			Enter amino acid data filename (-aadata)

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

http://bioweb.pasteur.fr/seqanal/interfaces/pestfind.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pestfind;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pestfind = Bio::Tools::Run::PiseApplication::pestfind->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pestfind object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pestfind = $factory->program('pestfind');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pestfind.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pestfind.pm

    $self->{COMMAND}   = "pestfind";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PESTFIND";

    $self->{DESCRIPTION}   = "Finds PEST motifs as potential proteolytic cleavage sites (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pestfind.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pestfind",
	"init",
	"input",
	"required",
	"output",
	"advanced",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pestfind",
	"init",
	"input", 	# input Section
	"sequence", 	# Enter input sequence (-sequence)
	"required", 	# required Section
	"window", 	# Enter window length (-window)
	"order", 	# Select sort order of results -- Sort order of results (-order)
	"potential", 	# Display potential PEST motifs (-potential)
	"poor", 	# Display poor PEST motifs (-poor)
	"invalid", 	# Display invalid PEST motifs (-invalid)
	"map", 	# Display PEST motifs map (-map)
	"output", 	# output Section
	"outfile", 	# Enter output filename (-outfile)
	"graph", 	# graph (-graph)
	"advanced", 	# advanced Section
	"threshold", 	# Enter threshold score (-threshold)
	"aadata", 	# Enter amino acid data filename (-aadata)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"pestfind" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"window" => 'Integer',
	"order" => 'Excl',
	"potential" => 'Switch',
	"poor" => 'Switch',
	"invalid" => 'Switch',
	"map" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"graph" => 'Excl',
	"advanced" => 'Paragraph',
	"threshold" => 'Float',
	"aadata" => 'String',
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
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"window" => {
		"perl" => '" -window=$value"',
	},
	"order" => {
		"perl" => '" -order=$value"',
	},
	"potential" => {
		"perl" => '($value)? "" : " -nopotential"',
	},
	"poor" => {
		"perl" => '($value)? "" : " -nopoor"',
	},
	"invalid" => {
		"perl" => '($value)? " -invalid" : ""',
	},
	"map" => {
		"perl" => '($value)? "" : " -nomap"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"advanced" => {
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? " -threshold=$value" : ""',
	},
	"aadata" => {
		"perl" => '($value && $value ne $vdef)? " -aadata=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=pestfind"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"pestfind" => {
		"perl" => '"pestfind"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"window" => 2,
	"order" => 3,
	"potential" => 4,
	"poor" => 5,
	"invalid" => 6,
	"map" => 7,
	"outfile" => 8,
	"graph" => 9,
	"threshold" => 10,
	"aadata" => 11,
	"auto" => 12,
	"psouput" => 100,
	"pestfind" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pngresults",
	"required",
	"pestfind",
	"advanced",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"sequence",
	"window",
	"order",
	"potential",
	"poor",
	"invalid",
	"map",
	"outfile",
	"graph",
	"threshold",
	"aadata",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"order" => 0,
	"potential" => 0,
	"poor" => 0,
	"invalid" => 0,
	"map" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"aadata" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"pestfind" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"order" => 0,
	"potential" => 0,
	"poor" => 0,
	"invalid" => 0,
	"map" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"aadata" => 0,
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
	"sequence" => 1,
	"required" => 0,
	"window" => 1,
	"order" => 1,
	"potential" => 0,
	"poor" => 0,
	"invalid" => 0,
	"map" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"aadata" => 0,
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
	"sequence" => "Enter input sequence (-sequence)",
	"required" => "required Section",
	"window" => "Enter window length (-window)",
	"order" => "Select sort order of results -- Sort order of results (-order)",
	"potential" => "Display potential PEST motifs (-potential)",
	"poor" => "Display poor PEST motifs (-poor)",
	"invalid" => "Display invalid PEST motifs (-invalid)",
	"map" => "Display PEST motifs map (-map)",
	"output" => "output Section",
	"outfile" => "Enter output filename (-outfile)",
	"graph" => "graph (-graph)",
	"advanced" => "advanced Section",
	"threshold" => "Enter threshold score (-threshold)",
	"aadata" => "Enter amino acid data filename (-aadata)",
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
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"order" => 0,
	"potential" => 0,
	"poor" => 0,
	"invalid" => 0,
	"map" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"aadata" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['window','order','potential','poor','invalid','map',],
	"order" => ['1','length','2',' position','3',' score',],
	"output" => ['outfile','graph',],
	"graph" => ['1','','2','','3','',],
	"advanced" => ['threshold','aadata',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '10',
	"order" => 'score',
	"potential" => '1',
	"poor" => '1',
	"invalid" => '0',
	"map" => '1',
	"graph" => 'postscript',
	"threshold" => '+5.0',
	"aadata" => 'Eamino.dat',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"order" => { "perl" => '1' },
	"potential" => { "perl" => '1' },
	"poor" => { "perl" => '1' },
	"invalid" => { "perl" => '1' },
	"map" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"aadata" => { "perl" => '1' },
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
	"sequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"order" => 0,
	"potential" => 0,
	"poor" => 0,
	"invalid" => 0,
	"map" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"aadata" => 0,
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
	"sequence" => 1,
	"required" => 0,
	"window" => 1,
	"order" => 1,
	"potential" => 0,
	"poor" => 0,
	"invalid" => 0,
	"map" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"advanced" => 0,
	"threshold" => 0,
	"aadata" => 0,
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
	"sequence" => [
		"Protein sequence USA to be analysed.",
	],
	"window" => [
		"Minimal distance between positively charged amino acids.",
	],
	"order" => [
		"Name of the output file which holds the results of the analysis. Results may be sorted by length, position and score.",
	],
	"potential" => [
		"Decide whether potential PEST motifs should be printed.",
	],
	"poor" => [
		"Decide whether poor PEST motifs should be printed.",
	],
	"invalid" => [
		"Decide whether invalid PEST motifs should be printed.",
	],
	"map" => [
		"Decide whether PEST motifs should be mapped to sequence.",
	],
	"outfile" => [
		"Name of file to which results will be written.",
	],
	"threshold" => [
		"Threshold value to discriminate weak from potential PEST motifs.  Valid PEST motifs are discriminated into \'poor\' and \'potential\' motifs depending on this threshold score.  By default, the default value is set to +5.0 based on experimental data.  Alterations are not recommended since significance is a matter of biology, not mathematics.",
	],
	"aadata" => [
		"File of amino acid properties and molecular masses.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pestfind.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

