# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::polydot
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::polydot

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::polydot

      Bioperl class for:

	POLYDOT	Displays all-against-all dotplots of a set of sequences (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/polydot.html 
         for available values):


		polydot (String)

		init (String)

		sequences (Sequence)
			Sequences file to be read in (-sequences)
			pipe: seqsfile

		wordsize (Integer)
			Word size (-wordsize)

		data (Switch)
			Display as data (-data)

		graph (Excl)
			graph [device to be displayed on] (-graph)

		outfile (OutFile)
			outfile (-outfile)

		gap (Integer)
			Gap (in residues) between dotplots (-gap)

		boxit (Switch)
			Draw a box around each dotplot (-boxit)

		dumpfeat (Switch)
			Dump all matches as feature files (-dumpfeat)

		format (String)
			format to Dump out as (-format)

		ext (String)
			Extension for feature file (-ext)

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

http://bioweb.pasteur.fr/seqanal/interfaces/polydot.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::polydot;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $polydot = Bio::Tools::Run::PiseApplication::polydot->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::polydot object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $polydot = $factory->program('polydot');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::polydot.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/polydot.pm

    $self->{COMMAND}   = "polydot";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "POLYDOT";

    $self->{DESCRIPTION}   = "Displays all-against-all dotplots of a set of sequences (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:dot plots",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/polydot.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"polydot",
	"init",
	"input",
	"required",
	"output",
	"gap",
	"boxit",
	"dumpfeat",
	"format",
	"ext",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"polydot",
	"init",
	"input", 	# input Section
	"sequences", 	# Sequences file to be read in (-sequences)
	"required", 	# required Section
	"wordsize", 	# Word size (-wordsize)
	"output", 	# output Section
	"datasection", 	# data Section
	"data", 	# Display as data (-data)
	"graph", 	# graph [device to be displayed on] (-graph)
	"outfile", 	# outfile (-outfile)
	"gap", 	# Gap (in residues) between dotplots (-gap)
	"boxit", 	# Draw a box around each dotplot (-boxit)
	"dumpfeat", 	# Dump all matches as feature files (-dumpfeat)
	"format", 	# format to Dump out as (-format)
	"ext", 	# Extension for feature file (-ext)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"polydot" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequences" => 'Sequence',
	"required" => 'Paragraph',
	"wordsize" => 'Integer',
	"output" => 'Paragraph',
	"datasection" => 'Paragraph',
	"data" => 'Switch',
	"graph" => 'Excl',
	"outfile" => 'OutFile',
	"gap" => 'Integer',
	"boxit" => 'Switch',
	"dumpfeat" => 'Switch',
	"format" => 'String',
	"ext" => 'String',
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
	"sequences" => {
		"perl" => '" -sequences=$value -sformat=fasta"',
	},
	"required" => {
	},
	"wordsize" => {
		"perl" => '" -wordsize=$value"',
	},
	"output" => {
	},
	"datasection" => {
	},
	"data" => {
		"perl" => '($value)? " -data" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"gap" => {
		"perl" => '(defined $value && $value != $vdef)? " -gap=$value" : ""',
	},
	"boxit" => {
		"perl" => '($value)? "" : " -noboxit"',
	},
	"dumpfeat" => {
		"perl" => '($value)? " -dumpfeat" : ""',
	},
	"format" => {
		"perl" => '($value && $value ne $vdef)? " -format=$value" : ""',
	},
	"ext" => {
		"perl" => '($value && $value ne $vdef)? " -ext=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=polydot"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"polydot" => {
		"perl" => '"polydot"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"sequences" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequences" => 1,
	"wordsize" => 2,
	"data" => 3,
	"graph" => 4,
	"outfile" => 5,
	"gap" => 6,
	"boxit" => 7,
	"dumpfeat" => 8,
	"format" => 9,
	"ext" => 10,
	"auto" => 11,
	"psouput" => 100,
	"polydot" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"polydot",
	"required",
	"datasection",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"sequences",
	"wordsize",
	"data",
	"graph",
	"outfile",
	"gap",
	"boxit",
	"dumpfeat",
	"format",
	"ext",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequences" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"gap" => 0,
	"boxit" => 0,
	"dumpfeat" => 0,
	"format" => 0,
	"ext" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"polydot" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"gap" => 0,
	"boxit" => 0,
	"dumpfeat" => 0,
	"format" => 0,
	"ext" => 0,
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
	"sequences" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"gap" => 0,
	"boxit" => 0,
	"dumpfeat" => 0,
	"format" => 0,
	"ext" => 0,
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
	"sequences" => "Sequences file to be read in (-sequences)",
	"required" => "required Section",
	"wordsize" => "Word size (-wordsize)",
	"output" => "output Section",
	"datasection" => "data Section",
	"data" => "Display as data (-data)",
	"graph" => "graph [device to be displayed on] (-graph)",
	"outfile" => "outfile (-outfile)",
	"gap" => "Gap (in residues) between dotplots (-gap)",
	"boxit" => "Draw a box around each dotplot (-boxit)",
	"dumpfeat" => "Dump all matches as feature files (-dumpfeat)",
	"format" => "format to Dump out as (-format)",
	"ext" => "Extension for feature file (-ext)",
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
	"sequences" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"gap" => 0,
	"boxit" => 0,
	"dumpfeat" => 0,
	"format" => 0,
	"ext" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequences',],
	"required" => ['wordsize',],
	"output" => ['datasection',],
	"datasection" => ['data','graph','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wordsize" => '6',
	"data" => '0',
	"graph" => 'postscript',
	"gap" => '10',
	"boxit" => '1',
	"dumpfeat" => '0',
	"format" => 'gff',
	"ext" => 'gff',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequences" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"wordsize" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"datasection" => { "perl" => '1' },
	"data" => { "perl" => '1' },
	"graph" => {
		"acd" => '@(!$(data))',
	},
	"outfile" => {
		"perl" => '$data',
		"acd" => '$data',
	},
	"gap" => { "perl" => '1' },
	"boxit" => { "perl" => '1' },
	"dumpfeat" => { "perl" => '1' },
	"format" => { "perl" => '1' },
	"ext" => { "perl" => '1' },
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
	"sequences" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"required" => 0,
	"wordsize" => 0,
	"output" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"gap" => 0,
	"boxit" => 0,
	"dumpfeat" => 0,
	"format" => 0,
	"ext" => 0,
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
	"sequences" => 1,
	"required" => 0,
	"wordsize" => 1,
	"output" => 0,
	"datasection" => 0,
	"data" => 0,
	"graph" => 0,
	"outfile" => 0,
	"gap" => 0,
	"boxit" => 0,
	"dumpfeat" => 0,
	"format" => 0,
	"ext" => 0,
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
	"sequences" => [
		"File containing a sequence alignment",
	],
	"data" => [
		"Output the match data to a file instead of plotting it",
	],
	"gap" => [
		"This specifies the size of the gap that is used to separate the individual dotplots in the display. The size is measured in residues, as displayed in the output.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/polydot.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

