# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::cpgplot
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::cpgplot

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cpgplot

      Bioperl class for:

	CPGPLOT	Plot CpG rich areas (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/cpgplot.html 
         for available values):


		cpgplot (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		window (Integer)
			Window size (-window)

		shift (Integer)
			Window shift increment (-shift)

		minlen (Integer)
			Minimum length of an island (-minlen)

		minoe (Float)
			Minimum observed/expected (-minoe)

		minpc (Float)
			Minimum percentage (-minpc)

		outfile (OutFile)
			outfile (-outfile)

		graph (Excl)
			graph (-graph)

		obsexp (Switch)
			Show observed/expected threshold line (-obsexp)

		cg (Switch)
			Show CpG rich regions (-cg)

		pc (Switch)
			Show percentage line (-pc)

		featout (OutFile)
			feature file for output (-featout)

		featout_offormat (Excl)
			Feature output format (-offormat)

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

http://bioweb.pasteur.fr/seqanal/interfaces/cpgplot.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::cpgplot;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cpgplot = Bio::Tools::Run::PiseApplication::cpgplot->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cpgplot object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $cpgplot = $factory->program('cpgplot');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::cpgplot.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cpgplot.pm

    $self->{COMMAND}   = "cpgplot";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CPGPLOT";

    $self->{DESCRIPTION}   = "Plot CpG rich areas (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:cpg islands",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/cpgplot.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cpgplot",
	"init",
	"input",
	"required",
	"output",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cpgplot",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"window", 	# Window size (-window)
	"shift", 	# Window shift increment (-shift)
	"minlen", 	# Minimum length of an island (-minlen)
	"minoe", 	# Minimum observed/expected (-minoe)
	"minpc", 	# Minimum percentage (-minpc)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"graph", 	# graph (-graph)
	"obsexp", 	# Show observed/expected threshold line (-obsexp)
	"cg", 	# Show CpG rich regions (-cg)
	"pc", 	# Show percentage line (-pc)
	"featout", 	# feature file for output (-featout)
	"featout_offormat", 	# Feature output format (-offormat)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"cpgplot" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"window" => 'Integer',
	"shift" => 'Integer',
	"minlen" => 'Integer',
	"minoe" => 'Float',
	"minpc" => 'Float',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"graph" => 'Excl',
	"obsexp" => 'Switch',
	"cg" => 'Switch',
	"pc" => 'Switch',
	"featout" => 'OutFile',
	"featout_offormat" => 'Excl',
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
	"shift" => {
		"perl" => '" -shift=$value"',
	},
	"minlen" => {
		"perl" => '" -minlen=$value"',
	},
	"minoe" => {
		"perl" => '" -minoe=$value"',
	},
	"minpc" => {
		"perl" => '" -minpc=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"graph" => {
		"perl" => '" -graph=$value"',
	},
	"obsexp" => {
		"perl" => '($value)? "" : " -noobsexp"',
	},
	"cg" => {
		"perl" => '($value)? "" : " -nocg"',
	},
	"pc" => {
		"perl" => '($value)? "" : " -nopc"',
	},
	"featout" => {
		"perl" => '" -featout=$value"',
	},
	"featout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=cpgplot"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"cpgplot" => {
		"perl" => '"cpgplot"',
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
	"shift" => 3,
	"minlen" => 4,
	"minoe" => 5,
	"minpc" => 6,
	"outfile" => 7,
	"graph" => 8,
	"obsexp" => 9,
	"cg" => 10,
	"pc" => 11,
	"featout" => 12,
	"featout_offormat" => 12,
	"auto" => 13,
	"psouput" => 100,
	"cpgplot" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"cpgplot",
	"required",
	"psresults",
	"output",
	"metaresults",
	"dataresults",
	"pngresults",
	"sequence",
	"window",
	"shift",
	"minlen",
	"minoe",
	"minpc",
	"outfile",
	"graph",
	"obsexp",
	"cg",
	"pc",
	"featout",
	"featout_offormat",
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
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"cpgplot" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
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
	"shift" => 1,
	"minlen" => 1,
	"minoe" => 1,
	"minpc" => 1,
	"output" => 0,
	"outfile" => 1,
	"graph" => 1,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"featout" => 1,
	"featout_offormat" => 0,
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
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"required" => "required Section",
	"window" => "Window size (-window)",
	"shift" => "Window shift increment (-shift)",
	"minlen" => "Minimum length of an island (-minlen)",
	"minoe" => "Minimum observed/expected (-minoe)",
	"minpc" => "Minimum percentage (-minpc)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"graph" => "graph (-graph)",
	"obsexp" => "Show observed/expected threshold line (-obsexp)",
	"cg" => "Show CpG rich regions (-cg)",
	"pc" => "Show percentage line (-pc)",
	"featout" => "feature file for output (-featout)",
	"featout_offormat" => "Feature output format (-offormat)",
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
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['window','shift','minlen','minoe','minpc',],
	"output" => ['outfile','graph','obsexp','cg','pc','featout','featout_offormat',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
	"featout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '100',
	"shift" => '1',
	"minlen" => '200',
	"minoe" => '0.6',
	"minpc" => '50.',
	"outfile" => 'outfile.out',
	"graph" => 'postscript',
	"obsexp" => '1',
	"cg" => '1',
	"pc" => '1',
	"featout" => 'featout.out',
	"featout_offormat" => 'gff',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"shift" => { "perl" => '1' },
	"minlen" => { "perl" => '1' },
	"minoe" => { "perl" => '1' },
	"minpc" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"obsexp" => { "perl" => '1' },
	"cg" => { "perl" => '1' },
	"pc" => { "perl" => '1' },
	"featout" => { "perl" => '1' },
	"featout_offormat" => { "perl" => '1' },
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
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"output" => 0,
	"outfile" => 0,
	"graph" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
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
	"shift" => 1,
	"minlen" => 1,
	"minoe" => 1,
	"minpc" => 1,
	"output" => 0,
	"outfile" => 1,
	"graph" => 1,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"featout" => 1,
	"featout_offormat" => 0,
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
	"window" => [
		"The percentage CG content and the Observed frequency of CG is calculated within a window whose size is set by this parameter. The window is moved down the sequence and these statistics are calculated at each postition that the window is moved to.",
	],
	"shift" => [
		"This determines the number of bases that the window is moved each time after values of the percentage CG content and the Observed frequency of CG are calculated within the window.",
	],
	"minlen" => [
		"This sets the minimum length that a CpG island has to be before it is reported.",
	],
	"minoe" => [
		"This sets the minimum average observed to expected ratio of C plus G to CpG in a set of 10 windows that are required before a CpG island is reported.",
	],
	"minpc" => [
		"This sets the minimum average percentage of G plus C a set of 10 windows that are required before a CpG island is reported.",
	],
	"outfile" => [
		"This sets the name of the file holding the report of the input sequence name, CpG island parameters and the output details of any CpG islands that are found.",
	],
	"obsexp" => [
		"If this is set to true then the graph of the observed to expected ratio of C plus G to CpG within a window is displayed.",
	],
	"cg" => [
		"If this is set to true then the graph of the regions which have been determined to be CpG islands is displayed.",
	],
	"pc" => [
		"If this is set to true then the graph of the percentage C plus G within a window is displayed.",
	],
	"featout" => [
		"File for output features",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cpgplot.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

