# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::wobble
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::wobble

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::wobble

      Bioperl class for:

	WOBBLE	Wobble base plot (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/wobble.html 
         for available values):


		wobble (String)

		init (String)

		sequence (Sequence)
			sequence -- dna [single sequence] (-sequence)
			pipe: seqfile

		bases (String)
			Bases used (-bases)

		window (Integer)
			Window size in codons (-window)

		graph (Excl)
			graph (-graph)

		outf (OutFile)
			outf (-outf)

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

http://bioweb.pasteur.fr/seqanal/interfaces/wobble.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::wobble;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $wobble = Bio::Tools::Run::PiseApplication::wobble->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::wobble object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $wobble = $factory->program('wobble');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::wobble.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wobble.pm

    $self->{COMMAND}   = "wobble";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WOBBLE";

    $self->{DESCRIPTION}   = "Wobble base plot (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:gene finding",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/wobble.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"wobble",
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
	"wobble",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [single sequence] (-sequence)
	"advanced", 	# advanced Section
	"bases", 	# Bases used (-bases)
	"window", 	# Window size in codons (-window)
	"output", 	# output Section
	"graph", 	# graph (-graph)
	"outf", 	# outf (-outf)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"wobble" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"bases" => 'String',
	"window" => 'Integer',
	"output" => 'Paragraph',
	"graph" => 'Excl',
	"outf" => 'OutFile',
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
	"advanced" => {
	},
	"bases" => {
		"perl" => '($value && $value ne $vdef)? " -bases=$value" : ""',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"output" => {
	},
	"graph" => {
		"perl" => '($value)? " -graph=$value" : ""',
	},
	"outf" => {
		"perl" => '($value)? " -outf=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=wobble"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"wobble" => {
		"perl" => '"wobble"',
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
	"bases" => 2,
	"window" => 3,
	"graph" => 4,
	"outf" => 5,
	"auto" => 6,
	"psouput" => 100,
	"wobble" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"wobble",
	"advanced",
	"output",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",
	"sequence",
	"bases",
	"window",
	"graph",
	"outf",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"bases" => 0,
	"window" => 0,
	"output" => 0,
	"graph" => 0,
	"outf" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"wobble" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"bases" => 0,
	"window" => 0,
	"output" => 0,
	"graph" => 0,
	"outf" => 0,
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
	"advanced" => 0,
	"bases" => 0,
	"window" => 0,
	"output" => 0,
	"graph" => 0,
	"outf" => 0,
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
	"sequence" => "sequence -- dna [single sequence] (-sequence)",
	"advanced" => "advanced Section",
	"bases" => "Bases used (-bases)",
	"window" => "Window size in codons (-window)",
	"output" => "output Section",
	"graph" => "graph (-graph)",
	"outf" => "outf (-outf)",
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
	"advanced" => 0,
	"bases" => 0,
	"window" => 0,
	"output" => 0,
	"graph" => 0,
	"outf" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['bases','window',],
	"output" => ['graph','outf',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"bases" => 'GC',
	"window" => '30',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"bases" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
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
	"advanced" => 0,
	"bases" => 0,
	"window" => 0,
	"output" => 0,
	"graph" => 0,
	"outf" => 0,
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
	"advanced" => 0,
	"bases" => 0,
	"window" => 0,
	"output" => 0,
	"graph" => 0,
	"outf" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wobble.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

