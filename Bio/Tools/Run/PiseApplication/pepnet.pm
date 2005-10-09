# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pepnet
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pepnet

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pepnet

      Bioperl class for:

	PEPNET	Displays proteins as a helical net (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pepnet.html 
         for available values):


		pepnet (String)

		init (String)

		sequence (Sequence)
			sequence -- Protein [single sequence] (-sequence)
			pipe: seqfile

		amphipathic (Switch)
			Prompt for amphipathic residue marking (-amphipathic)

		squares (String)
			Mark as squares (-squares)

		diamonds (String)
			Mark as diamonds (-diamonds)

		octags (String)
			Mark as octagons (-octags)

		data (Switch)
			Display as data (-data)

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

http://bioweb.pasteur.fr/seqanal/interfaces/pepnet.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pepnet;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pepnet = Bio::Tools::Run::PiseApplication::pepnet->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pepnet object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pepnet = $factory->program('pepnet');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pepnet.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepnet.pm

    $self->{COMMAND}   = "pepnet";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PEPNET";

    $self->{DESCRIPTION}   = "Displays proteins as a helical net (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "display",

         "protein:2d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pepnet.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pepnet",
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
	"pepnet",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- Protein [single sequence] (-sequence)
	"output", 	# output Section
	"amphipathic", 	# Prompt for amphipathic residue marking (-amphipathic)
	"squares", 	# Mark as squares (-squares)
	"diamonds", 	# Mark as diamonds (-diamonds)
	"octags", 	# Mark as octagons (-octags)
	"data", 	# Display as data (-data)
	"graph", 	# graph [device to be displayed on] (-graph)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"pepnet" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"output" => 'Paragraph',
	"amphipathic" => 'Switch',
	"squares" => 'String',
	"diamonds" => 'String',
	"octags" => 'String',
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
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"output" => {
	},
	"amphipathic" => {
		"perl" => '($value)? " -amphipathic" : ""',
	},
	"squares" => {
		"perl" => '($value && $value ne $vdef)? " -squares=$value" : ""',
	},
	"diamonds" => {
		"perl" => '($value && $value ne $vdef)? " -diamonds=$value" : ""',
	},
	"octags" => {
		"perl" => '($value && $value ne $vdef)? " -octags=$value" : ""',
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
		"perl" => '" -goutfile=pepnet"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"pepnet" => {
		"perl" => '"pepnet"',
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
	"amphipathic" => 2,
	"squares" => 3,
	"diamonds" => 4,
	"octags" => 5,
	"data" => 6,
	"graph" => 7,
	"auto" => 8,
	"psouput" => 100,
	"pepnet" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"pepnet",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"sequence",
	"amphipathic",
	"squares",
	"diamonds",
	"octags",
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
	"sequence" => 0,
	"output" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
	"data" => 0,
	"graph" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"pepnet" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
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
	"sequence" => 1,
	"output" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
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
	"sequence" => "sequence -- Protein [single sequence] (-sequence)",
	"output" => "output Section",
	"amphipathic" => "Prompt for amphipathic residue marking (-amphipathic)",
	"squares" => "Mark as squares (-squares)",
	"diamonds" => "Mark as diamonds (-diamonds)",
	"octags" => "Mark as octagons (-octags)",
	"data" => "Display as data (-data)",
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
	"sequence" => 0,
	"output" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
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

	"input" => ['sequence',],
	"output" => ['amphipathic','squares','diamonds','octags','data','graph',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"squares" => 'ILVM',
	"diamonds" => 'DENQST',
	"octags" => 'HKR',
	"data" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"amphipathic" => { "perl" => '1' },
	"squares" => { "perl" => '1' },
	"diamonds" => { "perl" => '1' },
	"octags" => { "perl" => '1' },
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
	"output" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
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
	"sequence" => 1,
	"output" => 0,
	"amphipathic" => 0,
	"squares" => 0,
	"diamonds" => 0,
	"octags" => 0,
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
	"amphipathic" => [
		"If this is true then the residues ACFGILMVWY are marked as squares and all other residues are unmarked. This overrides any other markup that you may have specified using the qualifiers \'-squares\', \'-diamonds\' and \'-octags\'.",
	],
	"squares" => [
		"By default the aliphatic residues ILVM are marked with squares.",
	],
	"diamonds" => [
		"By default the residues DENQST are marked with diamonds.",
	],
	"octags" => [
		"By default the positively charged residues HKR are marked with octagons.",
	],
	"data" => [
		"Output the data to a file instead of plotting it",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pepnet.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

