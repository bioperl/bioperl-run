# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::dan
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::dan

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dan

      Bioperl class for:

	DAN	Calculates DNA RNA/DNA melting temperature (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/dan.html 
         for available values):


		dan (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		windowsize (Integer)
			Enter window size (-windowsize)

		shiftincrement (Integer)
			Enter Shift Increment (-shiftincrement)

		dnaconc (Float)
			Enter DNA concentration (nM) (-dnaconc)

		saltconc (Float)
			Enter salt concentration (mM) (-saltconc)

		rna (Switch)
			Use RNA data values (-rna)

		product (Switch)
			Prompt for product values (-product)

		formamide (Float)
			Enter percentage of formamide (-formamide)

		mismatch (Float)
			Enter percent mismatch (-mismatch)

		prodlen (Integer)
			Enter the product length (-prodlen)

		thermo (Switch)
			Thermodynamic calculations (-thermo)

		temperature (Float)
			Enter temperature (-temperature)

		plot (Switch)
			Produce a plot (-plot)

		mintemp (Float)
			Enter minimum temperature (-mintemp)

		graph (Excl)
			graph (-graph)

		outfile (OutFile)
			Output data file (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/dan.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::dan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dan = Bio::Tools::Run::PiseApplication::dan->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dan object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $dan = $factory->program('dan');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::dan.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dan.pm

    $self->{COMMAND}   = "dan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DAN";

    $self->{DESCRIPTION}   = "Calculates DNA RNA/DNA melting temperature (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/dan.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dan",
	"init",
	"input",
	"required",
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
	"dan",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"windowsize", 	# Enter window size (-windowsize)
	"shiftincrement", 	# Enter Shift Increment (-shiftincrement)
	"dnaconc", 	# Enter DNA concentration (nM) (-dnaconc)
	"saltconc", 	# Enter salt concentration (mM) (-saltconc)
	"advanced", 	# advanced Section
	"rna", 	# Use RNA data values (-rna)
	"productsection", 	# productsection Section
	"product", 	# Prompt for product values (-product)
	"formamide", 	# Enter percentage of formamide (-formamide)
	"mismatch", 	# Enter percent mismatch (-mismatch)
	"prodlen", 	# Enter the product length (-prodlen)
	"thermosection", 	# thermosection Section
	"thermo", 	# Thermodynamic calculations (-thermo)
	"temperature", 	# Enter temperature (-temperature)
	"output", 	# output Section
	"plot", 	# Produce a plot (-plot)
	"mintemp", 	# Enter minimum temperature (-mintemp)
	"graph", 	# graph (-graph)
	"outfile", 	# Output data file (-outfile)
	"auto",
	"psouput",
	"psresults",
	"metaresults",
	"dataresults",
	"pngresults",

    ];

    $self->{TYPE}  = {
	"dan" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"windowsize" => 'Integer',
	"shiftincrement" => 'Integer',
	"dnaconc" => 'Float',
	"saltconc" => 'Float',
	"advanced" => 'Paragraph',
	"rna" => 'Switch',
	"productsection" => 'Paragraph',
	"product" => 'Switch',
	"formamide" => 'Float',
	"mismatch" => 'Float',
	"prodlen" => 'Integer',
	"thermosection" => 'Paragraph',
	"thermo" => 'Switch',
	"temperature" => 'Float',
	"output" => 'Paragraph',
	"plot" => 'Switch',
	"mintemp" => 'Float',
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
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"required" => {
	},
	"windowsize" => {
		"perl" => '" -windowsize=$value"',
	},
	"shiftincrement" => {
		"perl" => '" -shiftincrement=$value"',
	},
	"dnaconc" => {
		"perl" => '" -dnaconc=$value"',
	},
	"saltconc" => {
		"perl" => '" -saltconc=$value"',
	},
	"advanced" => {
	},
	"rna" => {
		"perl" => '($value)? " -rna" : ""',
	},
	"productsection" => {
	},
	"product" => {
		"perl" => '($value)? " -product" : ""',
	},
	"formamide" => {
		"perl" => '(defined $value && $value != $vdef)? " -formamide=$value" : ""',
	},
	"mismatch" => {
		"perl" => '(defined $value && $value != $vdef)? " -mismatch=$value" : ""',
	},
	"prodlen" => {
		"perl" => '(defined $value && $value != $vdef)? " -prodlen=$value" : ""',
	},
	"thermosection" => {
	},
	"thermo" => {
		"perl" => '($value)? " -thermo" : ""',
	},
	"temperature" => {
		"perl" => '(defined $value && $value != $vdef)? " -temperature=$value" : ""',
	},
	"output" => {
	},
	"plot" => {
		"perl" => '($value)? " -plot" : ""',
	},
	"mintemp" => {
		"perl" => '(defined $value && $value != $vdef)? " -mintemp=$value" : ""',
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
		"perl" => '" -goutfile=dan"',
	},
	"psresults" => {
	},
	"metaresults" => {
	},
	"dataresults" => {
	},
	"pngresults" => {
	},
	"dan" => {
		"perl" => '"dan"',
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
	"windowsize" => 2,
	"shiftincrement" => 3,
	"dnaconc" => 4,
	"saltconc" => 5,
	"rna" => 6,
	"product" => 7,
	"formamide" => 8,
	"mismatch" => 9,
	"prodlen" => 10,
	"thermo" => 11,
	"temperature" => 12,
	"plot" => 13,
	"mintemp" => 14,
	"graph" => 15,
	"outfile" => 16,
	"auto" => 17,
	"psouput" => 100,
	"dan" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"psresults",
	"required",
	"metaresults",
	"dataresults",
	"pngresults",
	"dan",
	"advanced",
	"productsection",
	"thermosection",
	"output",
	"sequence",
	"windowsize",
	"shiftincrement",
	"dnaconc",
	"saltconc",
	"rna",
	"product",
	"formamide",
	"mismatch",
	"prodlen",
	"thermo",
	"temperature",
	"plot",
	"mintemp",
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
	"sequence" => 0,
	"required" => 0,
	"windowsize" => 0,
	"shiftincrement" => 0,
	"dnaconc" => 0,
	"saltconc" => 0,
	"advanced" => 0,
	"rna" => 0,
	"productsection" => 0,
	"product" => 0,
	"formamide" => 0,
	"mismatch" => 0,
	"prodlen" => 0,
	"thermosection" => 0,
	"thermo" => 0,
	"temperature" => 0,
	"output" => 0,
	"plot" => 0,
	"mintemp" => 0,
	"graph" => 0,
	"outfile" => 0,
	"auto" => 1,
	"psouput" => 1,
	"psresults" => 0,
	"metaresults" => 0,
	"dataresults" => 0,
	"pngresults" => 0,
	"dan" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"windowsize" => 0,
	"shiftincrement" => 0,
	"dnaconc" => 0,
	"saltconc" => 0,
	"advanced" => 0,
	"rna" => 0,
	"productsection" => 0,
	"product" => 0,
	"formamide" => 0,
	"mismatch" => 0,
	"prodlen" => 0,
	"thermosection" => 0,
	"thermo" => 0,
	"temperature" => 0,
	"output" => 0,
	"plot" => 0,
	"mintemp" => 0,
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
	"sequence" => 1,
	"required" => 0,
	"windowsize" => 1,
	"shiftincrement" => 1,
	"dnaconc" => 1,
	"saltconc" => 1,
	"advanced" => 0,
	"rna" => 0,
	"productsection" => 0,
	"product" => 0,
	"formamide" => 0,
	"mismatch" => 0,
	"prodlen" => 0,
	"thermosection" => 0,
	"thermo" => 0,
	"temperature" => 0,
	"output" => 0,
	"plot" => 0,
	"mintemp" => 0,
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
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"required" => "required Section",
	"windowsize" => "Enter window size (-windowsize)",
	"shiftincrement" => "Enter Shift Increment (-shiftincrement)",
	"dnaconc" => "Enter DNA concentration (nM) (-dnaconc)",
	"saltconc" => "Enter salt concentration (mM) (-saltconc)",
	"advanced" => "advanced Section",
	"rna" => "Use RNA data values (-rna)",
	"productsection" => "productsection Section",
	"product" => "Prompt for product values (-product)",
	"formamide" => "Enter percentage of formamide (-formamide)",
	"mismatch" => "Enter percent mismatch (-mismatch)",
	"prodlen" => "Enter the product length (-prodlen)",
	"thermosection" => "thermosection Section",
	"thermo" => "Thermodynamic calculations (-thermo)",
	"temperature" => "Enter temperature (-temperature)",
	"output" => "output Section",
	"plot" => "Produce a plot (-plot)",
	"mintemp" => "Enter minimum temperature (-mintemp)",
	"graph" => "graph (-graph)",
	"outfile" => "Output data file (-outfile)",
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
	"windowsize" => 0,
	"shiftincrement" => 0,
	"dnaconc" => 0,
	"saltconc" => 0,
	"advanced" => 0,
	"rna" => 0,
	"productsection" => 0,
	"product" => 0,
	"formamide" => 0,
	"mismatch" => 0,
	"prodlen" => 0,
	"thermosection" => 0,
	"thermo" => 0,
	"temperature" => 0,
	"output" => 0,
	"plot" => 0,
	"mintemp" => 0,
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

	"input" => ['sequence',],
	"required" => ['windowsize','shiftincrement','dnaconc','saltconc',],
	"advanced" => ['rna','productsection','thermosection',],
	"productsection" => ['product','formamide','mismatch','prodlen',],
	"thermosection" => ['thermo','temperature',],
	"output" => ['plot','mintemp','graph','outfile',],
	"graph" => ['x11','x11','hp7470','hp7470','postscript','postscript','cps','cps','hp7580','hp7580','null','null','data','data','colourps','colourps','text','text','none','none','tek4107t','tek4107t','tekt','tekt','xwindows','xwindows','hpgl','hpgl','xterm','xterm','meta','meta','ps','ps','tek','tek','png','png','tektronics','tektronics',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"windowsize" => '20',
	"shiftincrement" => '1',
	"dnaconc" => '50.',
	"saltconc" => '50.',
	"formamide" => '0.',
	"mismatch" => '0.',
	"prodlen" => '',
	"temperature" => '25.',
	"mintemp" => '55.',
	"graph" => 'postscript',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"windowsize" => { "perl" => '1' },
	"shiftincrement" => { "perl" => '1' },
	"dnaconc" => { "perl" => '1' },
	"saltconc" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"rna" => { "perl" => '1' },
	"productsection" => { "perl" => '1' },
	"product" => { "perl" => '1' },
	"formamide" => {
		"perl" => '$product',
		"acd" => '$product',
	},
	"mismatch" => {
		"perl" => '$product',
		"acd" => '$product',
	},
	"prodlen" => {
		"perl" => '$product',
		"acd" => '$product',
	},
	"thermosection" => { "perl" => '1' },
	"thermo" => { "perl" => '1' },
	"temperature" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"plot" => { "perl" => '1' },
	"mintemp" => {
		"perl" => '$plot',
		"acd" => '$plot',
	},
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
	"windowsize" => 0,
	"shiftincrement" => 0,
	"dnaconc" => 0,
	"saltconc" => 0,
	"advanced" => 0,
	"rna" => 0,
	"productsection" => 0,
	"product" => 0,
	"formamide" => 0,
	"mismatch" => 0,
	"prodlen" => 0,
	"thermosection" => 0,
	"thermo" => 0,
	"temperature" => 0,
	"output" => 0,
	"plot" => 0,
	"mintemp" => 0,
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
	"sequence" => 1,
	"required" => 0,
	"windowsize" => 1,
	"shiftincrement" => 1,
	"dnaconc" => 1,
	"saltconc" => 1,
	"advanced" => 0,
	"rna" => 0,
	"productsection" => 0,
	"product" => 0,
	"formamide" => 0,
	"mismatch" => 0,
	"prodlen" => 0,
	"thermosection" => 0,
	"thermo" => 0,
	"temperature" => 0,
	"output" => 0,
	"plot" => 0,
	"mintemp" => 0,
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
	"windowsize" => [
		"The values of melting point and other thermodynamic properties of the sequence are determined by taking a short length of sequence known as a window and determining the properties of the sequence in that window. The window is incrementally moved along the sequence with the properties being calculated at each new position.",
	],
	"shiftincrement" => [
		"This is the amount by which the window is moved at each increment in order to find the melting point and other properties along the sequence.",
	],
	"rna" => [
		"This specifies that the sequence is an RNA sequnce and not a DNA sequence.",
	],
	"product" => [
		"This prompts for percent formamide, percent of mismatches allowed and product length.",
	],
	"formamide" => [
		"This specifies the percent formamide to be used in calculations (it is ignored unless -product is used).",
	],
	"mismatch" => [
		"This specifies the percent mismatch to be used in calculations (it is ignored unless -product is used).",
	],
	"prodlen" => [
		"This specifies the product length to be used in calculations (it is ignored unless -product is used).",
	],
	"thermo" => [
		"Output the DeltaG, DeltaH and DeltaS values of the sequence windows to the output data file.",
	],
	"temperature" => [
		"If -thermo has been specified then this specifies the temperature at which to calculate the DeltaG, DeltaH and DeltaS values.",
	],
	"plot" => [
		"If this is not specified then the file of output data is produced, else a plot of the melting point along the sequence is produced.",
	],
	"mintemp" => [
		"Enter a minimum value for the temperature scale (y-axis) of the plot.",
	],
	"outfile" => [
		"If a plot is not being produced then data on the melting point etc. in each window along the sequence is output to the file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

