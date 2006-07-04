# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::drawtree
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::drawtree

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::drawtree

      Bioperl class for:

	Phylip	drawtree - Plots an unrooted tree diagram (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/drawtree.html 
         for available values):


		drawtree (String)

		treefile (InFile)
			Tree File
			pipe: phylip_tree

		screen_type (String)

		plotter (Excl)
			Which plotter or printer will the tree be drawn on

		xxres (Float)
			X resolution

		xyres (Float)
			Y resolution

		laserjet_resolution (Excl)
			Laserjet resolution

		pcx_resolution (Excl)
			Paintbrush PCX resolution

		preview (String)

		branch_lengths (Switch)
			Use branch lengths

		angle (Excl)
			Angle of labels

		fixed_angle (Float)
			Fixed angle: Are the labels to be plotted vertically (90), horizontally (0), or downwards (-90)? 

		rotation (Float)
			Rotation of tree (in degrees from 360 to -360)

		arc (Float)
			Angle of arc for tree (in degrees from 0 to 360)

		iterate (Excl)
			Iterate to improve tree

		scale (Float)
			Scale of branch length (default: Automatically rescaled)

		horizontal_margins (Float)
			Horizontal margins

		vertical_margins (Float)
			Vertical margins

		character_height (Float)
			Relative character height

		font (String)
			Font (PostScript only)

		tops (String)

		topict (String)

		toxbm (String)

		confirm (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/drawtree.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::drawtree;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $drawtree = Bio::Tools::Run::PiseApplication::drawtree->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::drawtree object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $drawtree = $factory->program('drawtree');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::drawtree.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/drawtree.pm

    $self->{COMMAND}   = "drawtree";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "drawtree - Plots an unrooted tree diagram";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"drawtree",
	"treefile",
	"screen_type",
	"options",
	"preview",
	"branch_lengths",
	"angle",
	"fixed_angle",
	"rotation",
	"arc",
	"iterate",
	"scale",
	"horizontal_margins",
	"vertical_margins",
	"character_height",
	"font",
	"plotfile",
	"psfile",
	"pictfile",
	"xbmfile",
	"params",
	"tops",
	"topict",
	"toxbm",
	"confirm",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"drawtree",
	"treefile", 	# Tree File
	"screen_type",
	"options", 	# Drawtree options
	"plotter", 	# Which plotter or printer will the tree be drawn on
	"bitmap_options", 	# Bitmap options
	"xxres", 	# X resolution
	"xyres", 	# Y resolution
	"laserjet_options", 	# Laserjet options
	"laserjet_resolution", 	# Laserjet resolution
	"pcx_options", 	# Paintbrush options
	"pcx_resolution", 	# Paintbrush PCX resolution
	"preview",
	"branch_lengths", 	# Use branch lengths
	"angle", 	# Angle of labels
	"fixed_angle", 	# Fixed angle: Are the labels to be plotted vertically (90), horizontally (0), or downwards (-90)? 
	"rotation", 	# Rotation of tree (in degrees from 360 to -360)
	"arc", 	# Angle of arc for tree (in degrees from 0 to 360)
	"iterate", 	# Iterate to improve tree
	"scale", 	# Scale of branch length (default: Automatically rescaled)
	"horizontal_margins", 	# Horizontal margins
	"vertical_margins", 	# Vertical margins
	"character_height", 	# Relative character height
	"font", 	# Font (PostScript only)
	"plotfile",
	"psfile",
	"pictfile",
	"xbmfile",
	"params",
	"tops",
	"topict",
	"toxbm",
	"confirm",

    ];

    $self->{TYPE}  = {
	"drawtree" => 'String',
	"treefile" => 'InFile',
	"screen_type" => 'String',
	"options" => 'Paragraph',
	"plotter" => 'Excl',
	"bitmap_options" => 'Paragraph',
	"xxres" => 'Float',
	"xyres" => 'Float',
	"laserjet_options" => 'Paragraph',
	"laserjet_resolution" => 'Excl',
	"pcx_options" => 'Paragraph',
	"pcx_resolution" => 'Excl',
	"preview" => 'String',
	"branch_lengths" => 'Switch',
	"angle" => 'Excl',
	"fixed_angle" => 'Float',
	"rotation" => 'Float',
	"arc" => 'Float',
	"iterate" => 'Excl',
	"scale" => 'Float',
	"horizontal_margins" => 'Float',
	"vertical_margins" => 'Float',
	"character_height" => 'Float',
	"font" => 'String',
	"plotfile" => 'Results',
	"psfile" => 'Results',
	"pictfile" => 'Results',
	"xbmfile" => 'Results',
	"params" => 'Results',
	"tops" => 'String',
	"topict" => 'String',
	"toxbm" => 'String',
	"confirm" => 'String',

    };

    $self->{FORMAT}  = {
	"drawtree" => {
		"perl" => ' "drawtree < params" ',
	},
	"treefile" => {
		"perl" => '"ln -sf $treefile intree; "',
	},
	"screen_type" => {
		"perl" => '"0\\n"',
	},
	"options" => {
	},
	"plotter" => {
		"perl" => '(defined $value && $value ne $vdef) ? "P\\n$value\\n" : ""',
	},
	"bitmap_options" => {
	},
	"xxres" => {
		"perl" => '"$value\\n"',
	},
	"xyres" => {
		"perl" => '"$value\\n"',
	},
	"laserjet_options" => {
	},
	"laserjet_resolution" => {
		"perl" => '"$value\\n"',
	},
	"pcx_options" => {
	},
	"pcx_resolution" => {
		"perl" => '"$value\\n"',
	},
	"preview" => {
		"perl" => '"V\\nN\\n"',
	},
	"branch_lengths" => {
		"perl" => '($value)? "" : "B\\n"',
	},
	"angle" => {
	},
	"fixed_angle" => {
		"perl" => '(defined $value && $value != $vdef)? "L\\nF\\n$value\\n" : ""',
	},
	"rotation" => {
		"perl" => '(defined $value && $value != $vdef)? "R\\n$value\\n" : ""',
	},
	"arc" => {
		"perl" => '(defined $value && $value != $vdef)? "A\\n$value\\n" : ""',
	},
	"iterate" => {
	},
	"scale" => {
		"perl" => '(defined $value)? "S\\n$value\\n" : ""',
	},
	"horizontal_margins" => {
		"perl" => '(defined $value && $value != $vdef)? "M\\n$value\\n$vertical_margins\\n" : ""',
	},
	"vertical_margins" => {
		"perl" => '""',
	},
	"character_height" => {
		"perl" => '(defined $value && $value != $vdef)? "C\\n$value\\n" : ""',
	},
	"font" => {
		"perl" => '($value && $value ne $vdef)? "F\\n$value\\n" : ""',
	},
	"plotfile" => {
	},
	"psfile" => {
	},
	"pictfile" => {
	},
	"xbmfile" => {
	},
	"params" => {
	},
	"tops" => {
		"perl" => '($plotter eq "L") ? " ; ln -sf plotfile plotfile.ps" : "" ',
	},
	"topict" => {
		"perl" => '($plotter eq "M") ? " ; cp plotfile plotfile.pict" : "" ',
	},
	"toxbm" => {
		"perl" => '($plotter eq "X") ? " ; ln -sf plotfile plotfile.xbm" : "" ',
	},
	"confirm" => {
		"perl" => '"Y\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"plotfile" => 'plotfile',
	"psfile" => 'plotfile.ps',
	"pictfile" => 'plotfile.pict',
	"xbmfile" => 'plotfile.xbm',
	"params" => 'params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"drawtree" => 0,
	"treefile" => -10,
	"screen_type" => -1,
	"plotter" => 2,
	"xxres" => 3,
	"xyres" => 4,
	"laserjet_resolution" => 3,
	"pcx_resolution" => 3,
	"preview" => 1,
	"branch_lengths" => 5,
	"angle" => 5,
	"fixed_angle" => 7,
	"rotation" => 5,
	"arc" => 5,
	"iterate" => 5,
	"scale" => 5,
	"horizontal_margins" => 10,
	"vertical_margins" => 9,
	"character_height" => 5,
	"font" => 5,
	"tops" => 10,
	"topict" => 10,
	"toxbm" => 10,
	"confirm" => 1000,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treefile",
	"screen_type",
	"drawtree",
	"options",
	"params",
	"bitmap_options",
	"laserjet_options",
	"pcx_options",
	"plotfile",
	"psfile",
	"pictfile",
	"xbmfile",
	"preview",
	"plotter",
	"laserjet_resolution",
	"xxres",
	"pcx_resolution",
	"xyres",
	"scale",
	"character_height",
	"font",
	"branch_lengths",
	"angle",
	"arc",
	"rotation",
	"iterate",
	"fixed_angle",
	"vertical_margins",
	"horizontal_margins",
	"tops",
	"topict",
	"toxbm",
	"confirm",

    ];

    $self->{SIZE}  = {
	"font" => 50,

    };

    $self->{ISHIDDEN}  = {
	"drawtree" => 1,
	"treefile" => 0,
	"screen_type" => 1,
	"options" => 0,
	"plotter" => 0,
	"bitmap_options" => 0,
	"xxres" => 0,
	"xyres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"preview" => 1,
	"branch_lengths" => 0,
	"angle" => 0,
	"fixed_angle" => 0,
	"rotation" => 0,
	"arc" => 0,
	"iterate" => 0,
	"scale" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"character_height" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"xbmfile" => 0,
	"params" => 0,
	"tops" => 1,
	"topict" => 1,
	"toxbm" => 1,
	"confirm" => 1,

    };

    $self->{ISCOMMAND}  = {
	"drawtree" => 1,
	"treefile" => 0,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"bitmap_options" => 0,
	"xxres" => 0,
	"xyres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"preview" => 0,
	"branch_lengths" => 0,
	"angle" => 0,
	"fixed_angle" => 0,
	"rotation" => 0,
	"arc" => 0,
	"iterate" => 0,
	"scale" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"character_height" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"xbmfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"toxbm" => 0,
	"confirm" => 0,

    };

    $self->{ISMANDATORY}  = {
	"drawtree" => 0,
	"treefile" => 1,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 1,
	"bitmap_options" => 0,
	"xxres" => 1,
	"xyres" => 1,
	"laserjet_options" => 0,
	"laserjet_resolution" => 1,
	"pcx_options" => 0,
	"pcx_resolution" => 1,
	"preview" => 0,
	"branch_lengths" => 0,
	"angle" => 0,
	"fixed_angle" => 0,
	"rotation" => 0,
	"arc" => 0,
	"iterate" => 0,
	"scale" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"character_height" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"xbmfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"toxbm" => 0,
	"confirm" => 0,

    };

    $self->{PROMPT}  = {
	"drawtree" => "",
	"treefile" => "Tree File",
	"screen_type" => "",
	"options" => "Drawtree options",
	"plotter" => "Which plotter or printer will the tree be drawn on",
	"bitmap_options" => "Bitmap options",
	"xxres" => "X resolution",
	"xyres" => "Y resolution",
	"laserjet_options" => "Laserjet options",
	"laserjet_resolution" => "Laserjet resolution",
	"pcx_options" => "Paintbrush options",
	"pcx_resolution" => "Paintbrush PCX resolution",
	"preview" => "",
	"branch_lengths" => "Use branch lengths",
	"angle" => "Angle of labels",
	"fixed_angle" => "Fixed angle: Are the labels to be plotted vertically (90), horizontally (0), or downwards (-90)? ",
	"rotation" => "Rotation of tree (in degrees from 360 to -360)",
	"arc" => "Angle of arc for tree (in degrees from 0 to 360)",
	"iterate" => "Iterate to improve tree",
	"scale" => "Scale of branch length (default: Automatically rescaled)",
	"horizontal_margins" => "Horizontal margins",
	"vertical_margins" => "Vertical margins",
	"character_height" => "Relative character height",
	"font" => "Font (PostScript only)",
	"plotfile" => "",
	"psfile" => "",
	"pictfile" => "",
	"xbmfile" => "",
	"params" => "",
	"tops" => "",
	"topict" => "",
	"toxbm" => "",
	"confirm" => "",

    };

    $self->{ISSTANDOUT}  = {
	"drawtree" => 0,
	"treefile" => 0,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"bitmap_options" => 0,
	"xxres" => 0,
	"xyres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"preview" => 0,
	"branch_lengths" => 0,
	"angle" => 0,
	"fixed_angle" => 0,
	"rotation" => 0,
	"arc" => 0,
	"iterate" => 0,
	"scale" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"character_height" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"xbmfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"toxbm" => 0,
	"confirm" => 0,

    };

    $self->{VLIST}  = {

	"options" => ['plotter','bitmap_options','laserjet_options','pcx_options',],
	"plotter" => ['L','L: Postscript printer file format','M','M: PICT format','J','J: HP Laserjet PCL file format','W','W: MS-Windows Bitmap','K','K: TeKtronix 4010 graphics terminal','H','H: Hewlett-Packard pen plotter (HPLG)','D','D: DEC ReGIS graphics (VT240 terminal)','B','B: Houston Instruments plotter','E','E: Epson MX-80 dot-matrix printer','C','C: Prowriter/Imagewriter dot-matrix printer','O','O: Okidata dot-matrix printer','T','T: Toshiba 24-pin dot-matrix printer','P','P: PCX file format','X','X: X Bitmap format','F','F: FIG 2.0 drawing program format','A','A: Idraw drawing program format','Z','Z: VRML Virtual Reality Markup Language file','V','V: POVRAY 3D rendering program file','R','R: Rayshade 3D rendering program file',],
	"bitmap_options" => ['xxres','xyres',],
	"laserjet_options" => ['laserjet_resolution',],
	"laserjet_resolution" => ['1','1: 75 DPI','2','2: 150 DPI','3','3: 300 DPI',],
	"pcx_options" => ['pcx_resolution',],
	"pcx_resolution" => ['1','1: EGA 640 X 350','2','2: VGA 800 X 600','3','3: VGA 1024 X 768',],
	"angle" => ['F','F: Fixed','R','R: Radial','A','A: Along','M','M: Middle',],
	"iterate" => ['E','Equal-Daylight algorithm','B','n-Body algorithm','N','No',],
    };

    $self->{FLIST}  = {

	"angle" => {
		'F' => '""',
		'' => '""',
		'A' => '"L\\nA\\n"',
		'R' => '"L\\nR\\n"',
		'M' => '""',

	},
	"iterate" => {
		'N' => '"I\\nI\\n"',
		'B' => '"I\\n"',
		'E' => '""',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"plotter" => 'L',
	"xxres" => '500',
	"xyres" => '500',
	"laserjet_resolution" => '3',
	"pcx_resolution" => '3',
	"branch_lengths" => '1',
	"angle" => 'M',
	"fixed_angle" => '0.0',
	"rotation" => '0.0',
	"arc" => '0.0',
	"iterate" => 'E',
	"horizontal_margins" => '1.73',
	"vertical_margins" => '2.24',
	"character_height" => '0.3333',
	"font" => 'Hershey',

    };

    $self->{PRECOND}  = {
	"drawtree" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },
	"screen_type" => { "perl" => '1' },
	"options" => { "perl" => '1' },
	"plotter" => { "perl" => '1' },
	"bitmap_options" => {
		"perl" => '$plotter eq "X" or $plotter eq "W"',
	},
	"xxres" => {
		"perl" => '$plotter eq "X" or $plotter eq "W"',
	},
	"xyres" => {
		"perl" => '$plotter eq "X" or $plotter eq "W"',
	},
	"laserjet_options" => {
		"perl" => '$plotter eq "J"',
	},
	"laserjet_resolution" => {
		"perl" => '$plotter eq "J"',
	},
	"pcx_options" => {
		"perl" => '$plotter eq "P"',
	},
	"pcx_resolution" => {
		"perl" => '$plotter eq "P"',
	},
	"preview" => { "perl" => '1' },
	"branch_lengths" => { "perl" => '1' },
	"angle" => { "perl" => '1' },
	"fixed_angle" => {
		"perl" => '$angle eq "" || $angle eq "F"',
	},
	"rotation" => { "perl" => '1' },
	"arc" => { "perl" => '1' },
	"iterate" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"horizontal_margins" => { "perl" => '1' },
	"vertical_margins" => { "perl" => '1' },
	"character_height" => { "perl" => '1' },
	"font" => {
		"perl" => '$plotter eq "L"',
	},
	"plotfile" => {
		"perl" => '$plotter ne "L"',
	},
	"psfile" => {
		"perl" => '$plotter eq "L"',
	},
	"pictfile" => {
		"perl" => '$plotter eq "M"',
	},
	"xbmfile" => {
		"perl" => '$plotter eq "X"',
	},
	"params" => { "perl" => '1' },
	"tops" => { "perl" => '1' },
	"topict" => { "perl" => '1' },
	"toxbm" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"fixed_angle" => {
		"perl" => {
			'$value < -90.0 || $value > 90.0' => "The value must be comprised between -90 and 90",
		},
	},
	"rotation" => {
		"perl" => {
			'$value < -360.0 || $value > 360.0' => "The value must be comprised between -360 and +360",
		},
	},
	"arc" => {
		"perl" => {
			'$value < 0.0 || $value > 360.0' => "The value must be comprised between 0 and 360",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"treefile" => {
		 "phylip_tree" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"drawtree" => 0,
	"treefile" => 0,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"bitmap_options" => 0,
	"xxres" => 0,
	"xyres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"preview" => 0,
	"branch_lengths" => 0,
	"angle" => 0,
	"fixed_angle" => 0,
	"rotation" => 0,
	"arc" => 0,
	"iterate" => 0,
	"scale" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"character_height" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"xbmfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"toxbm" => 0,
	"confirm" => 0,

    };

    $self->{ISSIMPLE}  = {
	"drawtree" => 0,
	"treefile" => 1,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 1,
	"bitmap_options" => 0,
	"xxres" => 0,
	"xyres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"preview" => 0,
	"branch_lengths" => 0,
	"angle" => 0,
	"fixed_angle" => 0,
	"rotation" => 0,
	"arc" => 0,
	"iterate" => 0,
	"scale" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"character_height" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"xbmfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"toxbm" => 0,
	"confirm" => 0,

    };

    $self->{PARAMFILE}  = {
	"screen_type" => "params",
	"plotter" => "params",
	"xxres" => "params",
	"xyres" => "params",
	"laserjet_resolution" => "params",
	"pcx_resolution" => "params",
	"preview" => "params",
	"branch_lengths" => "params",
	"angle" => "params",
	"fixed_angle" => "params",
	"rotation" => "params",
	"arc" => "params",
	"iterate" => "params",
	"scale" => "params",
	"horizontal_margins" => "params",
	"vertical_margins" => "params",
	"character_height" => "params",
	"font" => "params",
	"confirm" => "params",

    };

    $self->{COMMENT}  = {
	"font" => [
		"Possible values: courier, helvetica,	        avantgarde_demi, souvenir_demi, ... (depends on local	        web server configuration)",
	],

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {
	"rotation" => 1,
	"arc" => 1,

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/drawtree.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

