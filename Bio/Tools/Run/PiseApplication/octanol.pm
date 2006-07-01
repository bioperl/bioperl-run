# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::octanol
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::octanol

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::octanol

      Bioperl class for:

	OCTANOL	Displays protein hydropathy (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/octanol.html 
         for available values):


		octanol (String)

		init (String)

		sequencea (Sequence)
			sequencea -- pureprotein [single sequence] (-sequencea)
			pipe: seqfile

		datafile (InFile)
			White-Wimley data file (Ewhite-wimley.dat) (-datafile)

		width (Integer)
			window size (-width)

		graph (Excl)
			graph (-graph)

		octanolplot (Switch)
			Display the octanol plot (-octanolplot)

		interfaceplot (Switch)
			Display the interface plot (-interfaceplot)

		differenceplot (Switch)
			Display the difference plot (-differenceplot)

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

http://bioweb.pasteur.fr/seqanal/interfaces/octanol.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::octanol;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $octanol = Bio::Tools::Run::PiseApplication::octanol->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::octanol object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $octanol = $factory->program('octanol');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::octanol.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/octanol.pm

    $self->{COMMAND}   = "octanol";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "OCTANOL";

    $self->{DESCRIPTION}   = "Displays protein hydropathy (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/octanol.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"octanol",
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
	"octanol",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- pureprotein [single sequence] (-sequencea)
	"advanced", 	# advanced Section
	"datafile", 	# White-Wimley data file (Ewhite-wimley.dat) (-datafile)
	"width", 	# window size (-width)
	"output", 	# output Section
	"graph", 	# graph (-graph)
	"octanolplot", 	# Display the octanol plot (-octanolplot)
	"interfaceplot", 	# Display the interface plot (-interfaceplot)
	"differenceplot", 	# Display the difference plot (-differenceplot)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"octanol" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"advanced" => 'Paragraph',
	"datafile" => 'InFile',
	"width" => 'Integer',
	"output" => 'Paragraph',
	"graph" => 'Excl',
	"octanolplot" => 'Switch',
	"interfaceplot" => 'Switch',
	"differenceplot" => 'Switch',
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
	"sequencea" => {
		"perl" => '" -sequencea=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value && $value ne $vdef)? " -datafile=$value" : ""',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"output" => {
	},
	"graph" => {
		"perl" => '" -graph=$value"',
	},
	"octanolplot" => {
		"perl" => '($value)? " -octanolplot" : ""',
	},
	"interfaceplot" => {
		"perl" => '($value)? " -interfaceplot" : ""',
	},
	"differenceplot" => {
		"perl" => '($value)? "" : " -nodifferenceplot"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"psouput" => {
		"perl" => '" -goutfile=octanol"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"octanol" => {
		"perl" => '"octanol"',
	}

    };

    $self->{FILENAMES}  = {
	"psresults" => '*.ps',
	"metaresults" => '*.meta',
	"dataresults" => '*.dat',
	"pngresults" => '*.png *.2 *.3',

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"datafile" => 2,
	"width" => 3,
	"graph" => 4,
	"octanolplot" => 5,
	"interfaceplot" => 6,
	"differenceplot" => 7,
	"auto" => 8,
	"psouput" => 100,
	"octanol" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"octanol",
	"advanced",
	"psresults",
	"output",
	"metaresults",
	"dataresults",
	"pngresults",
	"sequencea",
	"datafile",
	"width",
	"graph",
	"octanolplot",
	"interfaceplot",
	"differenceplot",
	"auto",
	"psouput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"width" => 0,
	"output" => 0,
	"graph" => 0,
	"octanolplot" => 0,
	"interfaceplot" => 0,
	"differenceplot" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"octanol" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"width" => 0,
	"output" => 0,
	"graph" => 0,
	"octanolplot" => 0,
	"interfaceplot" => 0,
	"differenceplot" => 0,
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
	"sequencea" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"width" => 0,
	"output" => 0,
	"graph" => 1,
	"octanolplot" => 0,
	"interfaceplot" => 0,
	"differenceplot" => 0,
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
	"sequencea" => "sequencea -- pureprotein [single sequence] (-sequencea)",
	"advanced" => "advanced Section",
	"datafile" => "White-Wimley data file (Ewhite-wimley.dat) (-datafile)",
	"width" => "window size (-width)",
	"output" => "output Section",
	"graph" => "graph (-graph)",
	"octanolplot" => "Display the octanol plot (-octanolplot)",
	"interfaceplot" => "Display the interface plot (-interfaceplot)",
	"differenceplot" => "Display the difference plot (-differenceplot)",
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
	"sequencea" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"width" => 0,
	"output" => 0,
	"graph" => 0,
	"octanolplot" => 0,
	"interfaceplot" => 0,
	"differenceplot" => 0,
	"auto" => 0,
	"psouput" => 0,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea',],
	"advanced" => ['datafile','width',],
	"output" => ['graph','octanolplot','interfaceplot','differenceplot',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"width" => '19',
	"graph" => 'postscript',
	"octanolplot" => '0',
	"interfaceplot" => '0',
	"differenceplot" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"graph" => { "perl" => '1' },
	"octanolplot" => { "perl" => '1' },
	"interfaceplot" => { "perl" => '1' },
	"differenceplot" => { "perl" => '1' },
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
	"sequencea" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"width" => 0,
	"output" => 0,
	"graph" => 0,
	"octanolplot" => 0,
	"interfaceplot" => 0,
	"differenceplot" => 0,
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
	"sequencea" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"width" => 0,
	"output" => 0,
	"graph" => 1,
	"octanolplot" => 0,
	"interfaceplot" => 0,
	"differenceplot" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/octanol.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

