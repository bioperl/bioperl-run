# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmoment
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmoment

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmoment

      Bioperl class for:

	HMOMENT	Hydrophobic moment calculation (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmoment.html 
         for available values):


		hmoment (String)

		init (String)

		seqall (Sequence)
			seqall -- pureprotein [sequences] (-seqall)
			pipe: seqsfile

		window (Integer)
			Window (-window)

		aangle (Integer)
			Alpha helix angle (degrees) (-aangle)

		bangle (Integer)
			Beta sheet angle (degrees) (-bangle)

		baseline (Float)
			Graph marker line (-baseline)

		plot (Switch)
			Produce graphic (-plot)

		double (Switch)
			Plot two graphs (-double)

		graph (Excl)
			graph (-graph)

		outfile (OutFile)
			outfile (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmoment.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmoment;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmoment = Bio::Tools::Run::PiseApplication::hmoment->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmoment object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmoment = $factory->program('hmoment');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmoment.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmoment.pm

    $self->{COMMAND}   = "hmoment";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMOMENT";

    $self->{DESCRIPTION}   = "Hydrophobic moment calculation (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:2d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/hmoment.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmoment",
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
	"hmoment",
	"init",
	"input", 	# input Section
	"seqall", 	# seqall -- pureprotein [sequences] (-seqall)
	"advanced", 	# advanced Section
	"window", 	# Window (-window)
	"aangle", 	# Alpha helix angle (degrees) (-aangle)
	"bangle", 	# Beta sheet angle (degrees) (-bangle)
	"baseline", 	# Graph marker line (-baseline)
	"output", 	# output Section
	"plot", 	# Produce graphic (-plot)
	"double", 	# Plot two graphs (-double)
	"graph", 	# graph (-graph)
	"outfile", 	# outfile (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"hmoment" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seqall" => 'Sequence',
	"advanced" => 'Paragraph',
	"window" => 'Integer',
	"aangle" => 'Integer',
	"bangle" => 'Integer',
	"baseline" => 'Float',
	"output" => 'Paragraph',
	"plot" => 'Switch',
	"double" => 'Switch',
	"graph" => 'Excl',
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
	"seqall" => {
		"perl" => '" -seqall=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"aangle" => {
		"perl" => '(defined $value && $value != $vdef)? " -aangle=$value" : ""',
	},
	"bangle" => {
		"perl" => '(defined $value && $value != $vdef)? " -bangle=$value" : ""',
	},
	"baseline" => {
		"perl" => '(defined $value && $value != $vdef)? " -baseline=$value" : ""',
	},
	"output" => {
	},
	"plot" => {
		"perl" => '($value)? " -plot" : ""',
	},
	"double" => {
		"perl" => '($value)? " -double" : ""',
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=hmoment"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"hmoment" => {
		"perl" => '"hmoment"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"seqall" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"seqall" => 1,
	"window" => 2,
	"aangle" => 3,
	"bangle" => 4,
	"baseline" => 5,
	"plot" => 6,
	"double" => 7,
	"graph" => 8,
	"outfile" => 9,
	"auto" => 10,
	"psouput" => 100,
	"hmoment" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"hmoment",
	"advanced",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"seqall",
	"window",
	"aangle",
	"bangle",
	"baseline",
	"plot",
	"double",
	"graph",
	"outfile",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"window" => 0,
	"aangle" => 0,
	"bangle" => 0,
	"baseline" => 0,
	"output" => 0,
	"plot" => 0,
	"double" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"hmoment" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"window" => 0,
	"aangle" => 0,
	"bangle" => 0,
	"baseline" => 0,
	"output" => 0,
	"plot" => 0,
	"double" => 0,
	"graph" => 0,
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
	"seqall" => 1,
	"advanced" => 0,
	"window" => 0,
	"aangle" => 0,
	"bangle" => 0,
	"baseline" => 0,
	"output" => 0,
	"plot" => 0,
	"double" => 0,
	"graph" => 0,
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
	"seqall" => "seqall -- pureprotein [sequences] (-seqall)",
	"advanced" => "advanced Section",
	"window" => "Window (-window)",
	"aangle" => "Alpha helix angle (degrees) (-aangle)",
	"bangle" => "Beta sheet angle (degrees) (-bangle)",
	"baseline" => "Graph marker line (-baseline)",
	"output" => "output Section",
	"plot" => "Produce graphic (-plot)",
	"double" => "Plot two graphs (-double)",
	"graph" => "graph (-graph)",
	"outfile" => "outfile (-outfile)",
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
	"seqall" => 0,
	"advanced" => 0,
	"window" => 0,
	"aangle" => 0,
	"bangle" => 0,
	"baseline" => 0,
	"output" => 0,
	"plot" => 0,
	"double" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['seqall',],
	"advanced" => ['window','aangle','bangle','baseline',],
	"output" => ['plot','double','graph','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '10',
	"aangle" => '100',
	"bangle" => '160',
	"baseline" => '0.35',
	"plot" => '0',
	"double" => '0',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"seqall" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"aangle" => { "perl" => '1' },
	"bangle" => { "perl" => '1' },
	"baseline" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"plot" => { "perl" => '1' },
	"double" => { "perl" => '1' },
	"graph" => {
		"perl" => '$plot',
		"acd" => '$plot',
	},
	"outfile" => {
		"acd" => '@(!$(plot))',
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
	"seqall" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"window" => 0,
	"aangle" => 0,
	"bangle" => 0,
	"baseline" => 0,
	"output" => 0,
	"plot" => 0,
	"double" => 0,
	"graph" => 0,
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
	"seqall" => 1,
	"advanced" => 0,
	"window" => 0,
	"aangle" => 0,
	"bangle" => 0,
	"baseline" => 0,
	"output" => 0,
	"plot" => 0,
	"double" => 0,
	"graph" => 0,
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

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmoment.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

