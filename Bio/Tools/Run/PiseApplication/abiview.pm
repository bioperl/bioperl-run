# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::abiview
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::abiview

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::abiview

      Bioperl class for:

	ABIVIEW	Reads ABI file and display the trace (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/abiview.html 
         for available values):


		abiview (String)

		init (String)

		fname (InFile)
			Name of the ABI trace file (-fname)

		outseq (OutFile)
			Sequence file (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: Sequence file

		graph (Excl)
			graph (-graph)

		startbase (Integer)
			First base to report or display (-startbase)

		endbase (Integer)
			Last base to report or display (-endbase)

		separate (Switch)
			Separate the trace graphs for the 4 bases (-separate)

		yticks (Switch)
			Display y-axis ticks (-yticks)

		sequence (Switch)
			Display the sequence on the graph (-sequence)

		window (Integer)
			Sequence display window size (-window)

		bases (String)
			Base graphs to be displayed (-bases)

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

http://bioweb.pasteur.fr/seqanal/interfaces/abiview.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::abiview;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $abiview = Bio::Tools::Run::PiseApplication::abiview->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::abiview object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $abiview = $factory->program('abiview');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::abiview.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/abiview.pm

    $self->{COMMAND}   = "abiview";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ABIVIEW";

    $self->{DESCRIPTION}   = "Reads ABI file and display the trace (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/abiview.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"abiview",
	"init",
	"input",
	"output",
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"abiview",
	"init",
	"input", 	# input Section
	"fname", 	# Name of the ABI trace file (-fname)
	"output", 	# output Section
	"outseq", 	# Sequence file (-outseq)
	"outseq_sformat", 	# Output format for: Sequence file
	"graph", 	# graph (-graph)
	"startbase", 	# First base to report or display (-startbase)
	"endbase", 	# Last base to report or display (-endbase)
	"separate", 	# Separate the trace graphs for the 4 bases (-separate)
	"yticks", 	# Display y-axis ticks (-yticks)
	"sequence", 	# Display the sequence on the graph (-sequence)
	"window", 	# Sequence display window size (-window)
	"bases", 	# Base graphs to be displayed (-bases)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"abiview" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"fname" => 'InFile',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"graph" => 'Excl',
	"startbase" => 'Integer',
	"endbase" => 'Integer',
	"separate" => 'Switch',
	"yticks" => 'Switch',
	"sequence" => 'Switch',
	"window" => 'Integer',
	"bases" => 'String',
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
	"fname" => {
		"perl" => '" -fname=$value"',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"startbase" => {
		"perl" => '(defined $value && $value != $vdef)? " -startbase=$value" : ""',
	},
	"endbase" => {
		"perl" => '(defined $value && $value != $vdef)? " -endbase=$value" : ""',
	},
	"separate" => {
		"perl" => '($value)? " -separate" : ""',
	},
	"yticks" => {
		"perl" => '($value)? " -yticks" : ""',
	},
	"sequence" => {
		"perl" => '($value)? "" : " -nosequence"',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"bases" => {
		"perl" => '($value && $value ne $vdef)? " -bases=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=abiview"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"abiview" => {
		"perl" => '"abiview"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"fname" => 1,
	"outseq" => 2,
	"outseq_sformat" => 3,
	"graph" => 4,
	"startbase" => 5,
	"endbase" => 6,
	"separate" => 7,
	"yticks" => 8,
	"sequence" => 9,
	"window" => 10,
	"bases" => 11,
	"auto" => 12,
	"psouput" => 100,
	"abiview" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"abiview",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"fname",
	"outseq",
	"outseq_sformat",
	"graph",
	"startbase",
	"endbase",
	"separate",
	"yticks",
	"sequence",
	"window",
	"bases",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"startbase" => 0,
	"endbase" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"abiview" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"startbase" => 0,
	"endbase" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"fname" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"graph" => 0,
	"startbase" => 0,
	"endbase" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"fname" => "Name of the ABI trace file (-fname)",
	"output" => "output Section",
	"outseq" => "Sequence file (-outseq)",
	"outseq_sformat" => "Output format for: Sequence file",
	"graph" => "graph (-graph)",
	"startbase" => "First base to report or display (-startbase)",
	"endbase" => "Last base to report or display (-endbase)",
	"separate" => "Separate the trace graphs for the 4 bases (-separate)",
	"yticks" => "Display y-axis ticks (-yticks)",
	"sequence" => "Display the sequence on the graph (-sequence)",
	"window" => "Sequence display window size (-window)",
	"bases" => "Base graphs to be displayed (-bases)",
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
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"startbase" => 0,
	"endbase" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['fname',],
	"output" => ['outseq','outseq_sformat','graph','startbase','endbase','separate','yticks','sequence','window','bases',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"graph" => 'postscript',
	"startbase" => '0',
	"endbase" => '0',
	"separate" => '0',
	"yticks" => '0',
	"sequence" => '1',
	"window" => '40',
	"bases" => 'GATC',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"fname" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"startbase" => { "perl" => '1' },
	"endbase" => { "perl" => '1' },
	"separate" => { "perl" => '1' },
	"yticks" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"bases" => { "perl" => '1' },
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
	"outseq" => {
		 '1' => "seqfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"fname" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"graph" => 0,
	"startbase" => 0,
	"endbase" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"fname" => 1,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"graph" => 0,
	"startbase" => 0,
	"endbase" => 0,
	"separate" => 0,
	"yticks" => 0,
	"sequence" => 0,
	"window" => 0,
	"bases" => 0,
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
	"endbase" => [
		"Last sequence base to report or display. If the default is set to zero then the value of this  is taken as the maximum number of bases.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/abiview.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

