
=head1 NAME

Bio::Tools::Run::PiseApplication::drawgram

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::drawgram

      Bioperl class for:

	Phylip	drawgram - Plots a cladogram- or phenogram-like rooted tree (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.


      Parameters:


		drawgram (String)


		treefile (InFile)
			Tree File
			pipe: phylip_tree

		screen_type (String)


		options (Paragraph)
			Drawgram options

		plotter (Excl)
			Which plotter or printer will the tree be drawn on

		xbitmap_options (Paragraph)
			Bitmap options

		xres (Float)
			X resolution

		yres (Float)
			Y resolution

		laserjet_options (Paragraph)
			Laserjet options

		laserjet_resolution (Excl)
			Laserjet resolution

		pcx_options (Paragraph)
			Paintbrush options

		pcx_resolution (Excl)
			Paintbrush PCX resolution

		screen (String)


		grows (Excl)
			Tree grows...

		tree_style (Excl)
			Tree style

		branch_lengths (Switch)
			Use branch lengths

		horizontal_margins (Float)
			Horizontal margins

		vertical_margins (Float)
			Vertical margins

		scale (Float)
			Scale of branch length (default: Automatically rescaled)

		depth (Float)
			Depth/Breadth of tree

		stem (Float)
			Stem-length/tree-depth

		character_height (Float)
			Character ht / tip space

		ancestral (Excl)
			Ancestral nodes

		font (String)
			Font (PostScript only)

		plotfile (Results)


		psfile (Results)


		pictfile (Results)


		params (Results)


		tops (String)


		topict (String)


		confirm (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::drawgram;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $drawgram = Bio::Tools::Run::PiseApplication::drawgram->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::drawgram object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $drawgram = $factory->program('drawgram');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::drawgram.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/drawgram.pm

    $self->{COMMAND}   = "drawgram";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "drawgram - Plots a cladogram- or phenogram-like rooted tree";

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"drawgram",
	"treefile",
	"screen_type",
	"options",
	"screen",
	"grows",
	"tree_style",
	"branch_lengths",
	"horizontal_margins",
	"vertical_margins",
	"scale",
	"depth",
	"stem",
	"character_height",
	"ancestral",
	"font",
	"plotfile",
	"psfile",
	"pictfile",
	"params",
	"tops",
	"topict",
	"confirm",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"drawgram",
	"treefile", 	# Tree File
	"screen_type",
	"options", 	# Drawgram options
	"plotter", 	# Which plotter or printer will the tree be drawn on
	"xbitmap_options", 	# Bitmap options
	"xres", 	# X resolution
	"yres", 	# Y resolution
	"laserjet_options", 	# Laserjet options
	"laserjet_resolution", 	# Laserjet resolution
	"pcx_options", 	# Paintbrush options
	"pcx_resolution", 	# Paintbrush PCX resolution
	"screen",
	"grows", 	# Tree grows...
	"tree_style", 	# Tree style
	"branch_lengths", 	# Use branch lengths
	"horizontal_margins", 	# Horizontal margins
	"vertical_margins", 	# Vertical margins
	"scale", 	# Scale of branch length (default: Automatically rescaled)
	"depth", 	# Depth/Breadth of tree
	"stem", 	# Stem-length/tree-depth
	"character_height", 	# Character ht / tip space
	"ancestral", 	# Ancestral nodes
	"font", 	# Font (PostScript only)
	"plotfile",
	"psfile",
	"pictfile",
	"params",
	"tops",
	"topict",
	"confirm",

    ];

    $self->{TYPE}  = {
	"drawgram" => 'String',
	"treefile" => 'InFile',
	"screen_type" => 'String',
	"options" => 'Paragraph',
	"plotter" => 'Excl',
	"xbitmap_options" => 'Paragraph',
	"xres" => 'Float',
	"yres" => 'Float',
	"laserjet_options" => 'Paragraph',
	"laserjet_resolution" => 'Excl',
	"pcx_options" => 'Paragraph',
	"pcx_resolution" => 'Excl',
	"screen" => 'String',
	"grows" => 'Excl',
	"tree_style" => 'Excl',
	"branch_lengths" => 'Switch',
	"horizontal_margins" => 'Float',
	"vertical_margins" => 'Float',
	"scale" => 'Float',
	"depth" => 'Float',
	"stem" => 'Float',
	"character_height" => 'Float',
	"ancestral" => 'Excl',
	"font" => 'String',
	"plotfile" => 'Results',
	"psfile" => 'Results',
	"pictfile" => 'Results',
	"params" => 'Results',
	"tops" => 'String',
	"topict" => 'String',
	"confirm" => 'String',

    };

    $self->{FORMAT}  = {
	"drawgram" => {
		"perl" => ' "drawgram < params" ',
	},
	"treefile" => {
		"perl" => '"ln -s $treefile intree; "',
	},
	"screen_type" => {
		"perl" => '"0\\n"',
	},
	"options" => {
	},
	"plotter" => {
		"perl" => '(defined $value and $value ne $vdef) ? "P\\n$value\\n" : ""',
	},
	"xbitmap_options" => {
	},
	"xres" => {
		"perl" => '"$value\\n"',
	},
	"yres" => {
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
	"screen" => {
		"perl" => '"V\\nN\\n"',
	},
	"grows" => {
		"perl" => '($value ne $vdef) ? "H\\n" : "" ',
	},
	"tree_style" => {
	},
	"branch_lengths" => {
		"perl" => '($value) ? "" : "B\\n"',
	},
	"horizontal_margins" => {
		"perl" => '(defined $value and $value != $vdef)? "M\\n$value\\n$vertical_margins\\n" : ""',
	},
	"vertical_margins" => {
		"perl" => '""',
	},
	"scale" => {
		"perl" => '(defined $value) ? "R\\n$value\\n" : ""',
	},
	"depth" => {
		"perl" => '(defined $value and $value != $vdef)? "D\\n$value\\n" : ""',
	},
	"stem" => {
		"perl" => '(defined $value and $value != $vdef)? "T\\n$value\\n" : ""',
	},
	"character_height" => {
		"perl" => '(defined $value and $value != $vdef)? "C\\n$value\\n" : ""',
	},
	"ancestral" => {
		"perl" => '($value and $value ne $vdef)? "A\\n$value\\n" : ""',
	},
	"font" => {
		"perl" => '($value and $value ne $vdef)? "F\\n$value\\n" : ""',
	},
	"plotfile" => {
	},
	"psfile" => {
	},
	"pictfile" => {
	},
	"params" => {
	},
	"tops" => {
		"perl" => '($plotter eq "L") ? " ; ln -s plotfile plotfile.ps" : "" ',
	},
	"topict" => {
		"perl" => '($plotter eq "M") ? " ; cp plotfile plotfile.pict" : "" ',
	},
	"confirm" => {
		"perl" => '"Y\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"plotfile" => 'plotfile',
	"psfile" => 'plotfile.ps',
	"pictfile" => 'plotfile.pict',
	"params" => 'params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"drawgram" => 0,
	"treefile" => -10,
	"screen_type" => -1,
	"plotter" => 2,
	"xres" => 3,
	"yres" => 4,
	"laserjet_resolution" => 3,
	"pcx_resolution" => 3,
	"screen" => 1,
	"grows" => 5,
	"tree_style" => 5,
	"branch_lengths" => 5,
	"horizontal_margins" => 10,
	"vertical_margins" => 9,
	"scale" => 5,
	"depth" => 5,
	"stem" => 5,
	"character_height" => 5,
	"ancestral" => 5,
	"font" => 5,
	"tops" => 10,
	"topict" => 10,
	"confirm" => 1000,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treefile",
	"screen_type",
	"drawgram",
	"options",
	"params",
	"xbitmap_options",
	"laserjet_options",
	"pcx_options",
	"plotfile",
	"psfile",
	"pictfile",
	"screen",
	"plotter",
	"pcx_resolution",
	"laserjet_resolution",
	"xres",
	"yres",
	"depth",
	"stem",
	"character_height",
	"ancestral",
	"font",
	"grows",
	"tree_style",
	"branch_lengths",
	"scale",
	"vertical_margins",
	"horizontal_margins",
	"tops",
	"topict",
	"confirm",

    ];

    $self->{SIZE}  = {
	"font" => 50,

    };

    $self->{ISHIDDEN}  = {
	"drawgram" => 1,
	"treefile" => 0,
	"screen_type" => 1,
	"options" => 0,
	"plotter" => 0,
	"xbitmap_options" => 0,
	"xres" => 0,
	"yres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"screen" => 1,
	"grows" => 0,
	"tree_style" => 0,
	"branch_lengths" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"scale" => 0,
	"depth" => 0,
	"stem" => 0,
	"character_height" => 0,
	"ancestral" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"params" => 0,
	"tops" => 1,
	"topict" => 1,
	"confirm" => 1,

    };

    $self->{ISCOMMAND}  = {
	"drawgram" => 1,
	"treefile" => 0,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"xbitmap_options" => 0,
	"xres" => 0,
	"yres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"screen" => 0,
	"grows" => 0,
	"tree_style" => 0,
	"branch_lengths" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"scale" => 0,
	"depth" => 0,
	"stem" => 0,
	"character_height" => 0,
	"ancestral" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"confirm" => 0,

    };

    $self->{ISMANDATORY}  = {
	"drawgram" => 0,
	"treefile" => 1,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"xbitmap_options" => 0,
	"xres" => 1,
	"yres" => 1,
	"laserjet_options" => 0,
	"laserjet_resolution" => 1,
	"pcx_options" => 0,
	"pcx_resolution" => 1,
	"screen" => 0,
	"grows" => 0,
	"tree_style" => 0,
	"branch_lengths" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"scale" => 0,
	"depth" => 0,
	"stem" => 0,
	"character_height" => 0,
	"ancestral" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"confirm" => 0,

    };

    $self->{PROMPT}  = {
	"drawgram" => "",
	"treefile" => "Tree File",
	"screen_type" => "",
	"options" => "Drawgram options",
	"plotter" => "Which plotter or printer will the tree be drawn on",
	"xbitmap_options" => "Bitmap options",
	"xres" => "X resolution",
	"yres" => "Y resolution",
	"laserjet_options" => "Laserjet options",
	"laserjet_resolution" => "Laserjet resolution",
	"pcx_options" => "Paintbrush options",
	"pcx_resolution" => "Paintbrush PCX resolution",
	"screen" => "",
	"grows" => "Tree grows...",
	"tree_style" => "Tree style",
	"branch_lengths" => "Use branch lengths",
	"horizontal_margins" => "Horizontal margins",
	"vertical_margins" => "Vertical margins",
	"scale" => "Scale of branch length (default: Automatically rescaled)",
	"depth" => "Depth/Breadth of tree",
	"stem" => "Stem-length/tree-depth",
	"character_height" => "Character ht / tip space",
	"ancestral" => "Ancestral nodes",
	"font" => "Font (PostScript only)",
	"plotfile" => "",
	"psfile" => "",
	"pictfile" => "",
	"params" => "",
	"tops" => "",
	"topict" => "",
	"confirm" => "",

    };

    $self->{ISSTANDOUT}  = {
	"drawgram" => 0,
	"treefile" => 0,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"xbitmap_options" => 0,
	"xres" => 0,
	"yres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"screen" => 0,
	"grows" => 0,
	"tree_style" => 0,
	"branch_lengths" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"scale" => 0,
	"depth" => 0,
	"stem" => 0,
	"character_height" => 0,
	"ancestral" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"confirm" => 0,

    };

    $self->{VLIST}  = {

	"options" => ['plotter','xbitmap_options','laserjet_options','pcx_options',],
	"plotter" => ['L','L: Postscript printer file format','M','M: PICT format','J','J: HP Laserjet PCL file format','W','W: MS-Windows Bitmap','K','K: TeKtronix 4010 graphics terminal','H','H: Hewlett-Packard pen plotter (HPGL)','D','D: DEC ReGIS graphics (VT240 terminal)','B','B: Houston Instruments plotter','E','E: Epson MX-80 dot-matrix printer','C','C: Prowriter/Imagewriter dot-matrix printer','O','O: Okidata dot-matrix printer','T','T: Toshiba 24-pin dot-matrix printer','P','P: PCX file format','X','X: X Bitmap format','F','F: FIG 2.0 format','A','A: Idraw drawing program format','Z','Z: VRML Virtual Reality Markup Language file','V','V: POVRAY 3D rendering program file','R','R: Rayshade 3D rendering program file',],
	"xbitmap_options" => ['xres','yres',],
	"laserjet_options" => ['laserjet_resolution',],
	"laserjet_resolution" => ['1','1: 75 DPI','2','2: 150 DPI','3','3: 300 DPI',],
	"pcx_options" => ['pcx_resolution',],
	"pcx_resolution" => ['1','1: EGA 640 X 350','2','2: VGA 800 X 600','3','3: VGA 1024 X 768',],
	"grows" => ['Vertically','Vertically','Horizontally','Horizontally',],
	"tree_style" => ['C','C: Cladogram','P','P: Phenogram','V','V: Curvogram','E','E: Eurogram','S','S: Swoopogram','O','O: Circular tree',],
	"ancestral" => ['I','I: Intermediate','W','W: Weighted','C','C: Centered','N','N: Inner','V','V: So tree is V-shaped',],
    };

    $self->{FLIST}  = {

	"tree_style" => {
		'V' => '"S\\nV\\n"',
		'' => '',
		'O' => '"S\\nO\\n"',
		'P' => '"S\\nP\\n"',
		'S' => '"S\\nS\\n"',
		'C' => '',
		'E' => '"S\\nE\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"plotter" => 'L',
	"xres" => '500',
	"yres" => '500',
	"laserjet_resolution" => '3',
	"pcx_resolution" => '3',
	"grows" => 'Horizontally',
	"tree_style" => 'C',
	"branch_lengths" => '1',
	"horizontal_margins" => '1.65',
	"vertical_margins" => '2.16',
	"depth" => '1.00',
	"stem" => '0.05',
	"character_height" => '0.3333',
	"ancestral" => 'I',
	"font" => 'Hershey',

    };

    $self->{PRECOND}  = {
	"drawgram" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },
	"screen_type" => { "perl" => '1' },
	"options" => { "perl" => '1' },
	"plotter" => { "perl" => '1' },
	"xbitmap_options" => {
		"perl" => '$plotter eq "X" or $plotter eq "W"',
	},
	"xres" => {
		"perl" => '$plotter eq "X" or $plotter eq "W"',
	},
	"yres" => {
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
	"screen" => { "perl" => '1' },
	"grows" => { "perl" => '1' },
	"tree_style" => { "perl" => '1' },
	"branch_lengths" => { "perl" => '1' },
	"horizontal_margins" => { "perl" => '1' },
	"vertical_margins" => { "perl" => '1' },
	"scale" => { "perl" => '1' },
	"depth" => { "perl" => '1' },
	"stem" => { "perl" => '1' },
	"character_height" => { "perl" => '1' },
	"ancestral" => { "perl" => '1' },
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
	"params" => { "perl" => '1' },
	"tops" => { "perl" => '1' },
	"topict" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"stem" => {
		"perl" => {
			'$value < 0 || $value >= 1' => "You should enter a value between 0 and 1.",
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
	"drawgram" => 0,
	"treefile" => 0,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"xbitmap_options" => 0,
	"xres" => 0,
	"yres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"screen" => 0,
	"grows" => 0,
	"tree_style" => 0,
	"branch_lengths" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"scale" => 0,
	"depth" => 0,
	"stem" => 0,
	"character_height" => 0,
	"ancestral" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"confirm" => 0,

    };

    $self->{ISSIMPLE}  = {
	"drawgram" => 0,
	"treefile" => 1,
	"screen_type" => 0,
	"options" => 0,
	"plotter" => 0,
	"xbitmap_options" => 0,
	"xres" => 0,
	"yres" => 0,
	"laserjet_options" => 0,
	"laserjet_resolution" => 0,
	"pcx_options" => 0,
	"pcx_resolution" => 0,
	"screen" => 0,
	"grows" => 0,
	"tree_style" => 0,
	"branch_lengths" => 0,
	"horizontal_margins" => 0,
	"vertical_margins" => 0,
	"scale" => 0,
	"depth" => 0,
	"stem" => 0,
	"character_height" => 0,
	"ancestral" => 0,
	"font" => 0,
	"plotfile" => 0,
	"psfile" => 0,
	"pictfile" => 0,
	"params" => 0,
	"tops" => 0,
	"topict" => 0,
	"confirm" => 0,

    };

    $self->{PARAMFILE}  = {
	"screen_type" => "params",
	"plotter" => "params",
	"xres" => "params",
	"yres" => "params",
	"laserjet_resolution" => "params",
	"pcx_resolution" => "params",
	"screen" => "params",
	"grows" => "params",
	"tree_style" => "params",
	"branch_lengths" => "params",
	"horizontal_margins" => "params",
	"vertical_margins" => "params",
	"scale" => "params",
	"depth" => "params",
	"stem" => "params",
	"character_height" => "params",
	"ancestral" => "params",
	"font" => "params",
	"confirm" => "params",

    };

    $self->{COMMENT}  = {
	"stem" => [
		"Enter the stem length as fraction of tree depth (a value between 0 and 1).",
	],
	"character_height" => [
		"Enter character height as fraction of tip spacing.",
	],
	"font" => [
		"Possible values: courier, helvetica,	        avantgarde_demi, souvenir_demi, ... (depends on local	        web server configuration)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/drawgram.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

