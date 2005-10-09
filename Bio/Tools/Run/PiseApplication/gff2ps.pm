# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::gff2ps
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::gff2ps

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::gff2ps

      Bioperl class for:

	gff2ps	Produces PostScript graphical output from GFF-files (Josep Francesc ABRIL FERRANDO, Roderic GUIGO SERRA)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/gff2ps.html 
         for available values):


		gff2ps (String)

		outfile (OutFile)

		gff_file (InFile)
			GFF file

		page_size (String)
			Modify page size (-D)

		orientation (Switch)
			Switches page orientation to Portrait (default is Landscape) (-p)

		split (Integer)
			Sets how many pages are needed to split your output (-P)

		zoom_first (Integer)
			Zoom first nucleotide (default is sequence origin) (-S)

		zoom_last (Integer)
			Zoom last nucleotide (default is sequence length) (-E)

		blocks (Integer)
			Sets blocks per page (-B)

		nuc_per_line (Integer)
			Sets nucleotides per line (default is the largest sequence position from input gff-files) (-N)

		blocks_from_left_to_right (Switch)
			Blocks from left to right and from top to bottom (default is top to bottom first) (-b)

		no_headers (Switch)
			Switch off Header (Title area) (-L)

		set_title (String)
			Defining title (default is input gff filename) (-T)

		no_page_nb (Switch)
			Does not show page numbering (-l)

		no_date (Switch)
			Does not show date (-O)

		no_time (Switch)
			Does not show time (-o)

		no_copyright (Switch)
			Switch off CopyRight line on plot (-a)

		fg_color_name (String)
			Sets color for FOREGROUND (-G)

		bg_color_name (String)
			Sets color for BACKGROUND (-G)

		f0_color_name (String)
			Sets color for frame 0 (-0)

		f1_color_name (String)
			Sets color for frame 1 (-1)

		f2_color_name (String)
			Sets color for frame 2 (-2)

		f_color_name (String)
			Sets color for frame . (-3)

		major_tickmarks (Integer)
			Number of major tickmarks per line (-M)

		major_tickmarks_scale (Integer)
			Major tickmarks scale in nucleotides (-K)

		minor_tickmarks (Integer)
			Number of minor tickmarks between major tickmarks (-m)

		minor_tickmarks_scale (Integer)
			Minor tickmarks scale in nucleotides (-k)

		no_forward_strand (Switch)
			Switch off displaying forward-strand(Watson) elements (-w)

		no_reverse_strand (Switch)
			Switch off displaying reverse-strand(Crick) elements (-c)

		no_strand_independent (Switch)
			Switch off displaying strand-independent elements (-i)

		no_label (Switch)
			Switch off labels for element positions (-n)

		default_custom_file (Switch)
			Create a new default customfile (.gff2psrc) (-D)

		user_custom_file (InFile)
			Your custom rc file (.gff2psrc)

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

http://bioweb.pasteur.fr/seqanal/interfaces/gff2ps.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::gff2ps;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $gff2ps = Bio::Tools::Run::PiseApplication::gff2ps->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::gff2ps object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $gff2ps = $factory->program('gff2ps');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::gff2ps.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gff2ps.pm

    $self->{COMMAND}   = "gff2ps";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "gff2ps";

    $self->{DESCRIPTION}   = "Produces PostScript graphical output from GFF-files";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Josep Francesc ABRIL FERRANDO, Roderic GUIGO SERRA";

    $self->{DOCLINK}   = "http://www1.imim.es/~jabril/GFFTOOLS/GFF2PS.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"gff2ps",
	"outfile",
	"rcfile",
	"gff_file",
	"output_options",
	"color_options",
	"tickmark_options",
	"element_options",
	"other_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"gff2ps",
	"outfile",
	"rcfile",
	"gff_file", 	# GFF file
	"output_options", 	# Output Options
	"page_size", 	# Modify page size (-D)
	"orientation", 	# Switches page orientation to Portrait (default is Landscape) (-p)
	"split", 	# Sets how many pages are needed to split your output (-P)
	"zoom_first", 	# Zoom first nucleotide (default is sequence origin) (-S)
	"zoom_last", 	# Zoom last nucleotide (default is sequence length) (-E)
	"blocks", 	# Sets blocks per page (-B)
	"nuc_per_line", 	# Sets nucleotides per line (default is the largest sequence position from input gff-files) (-N)
	"blocks_from_left_to_right", 	# Blocks from left to right and from top to bottom (default is top to bottom first) (-b)
	"no_headers", 	# Switch off Header (Title area) (-L)
	"set_title", 	# Defining title (default is input gff filename) (-T)
	"no_page_nb", 	# Does not show page numbering (-l)
	"no_date", 	# Does not show date (-O)
	"no_time", 	# Does not show time (-o)
	"no_copyright", 	# Switch off CopyRight line on plot (-a)
	"color_options", 	# Color Options
	"fg_color_name", 	# Sets color for FOREGROUND (-G)
	"bg_color_name", 	# Sets color for BACKGROUND (-G)
	"f0_color_name", 	# Sets color for frame 0 (-0)
	"f1_color_name", 	# Sets color for frame 1 (-1)
	"f2_color_name", 	# Sets color for frame 2 (-2)
	"f_color_name", 	# Sets color for frame . (-3)
	"tickmark_options", 	# Tickmark Options
	"major_tickmarks", 	# Number of major tickmarks per line (-M)
	"major_tickmarks_scale", 	# Major tickmarks scale in nucleotides (-K)
	"minor_tickmarks", 	# Number of minor tickmarks between major tickmarks (-m)
	"minor_tickmarks_scale", 	# Minor tickmarks scale in nucleotides (-k)
	"element_options", 	# Display elements Options
	"no_forward_strand", 	# Switch off displaying forward-strand(Watson) elements (-w)
	"no_reverse_strand", 	# Switch off displaying reverse-strand(Crick) elements (-c)
	"no_strand_independent", 	# Switch off displaying strand-independent elements (-i)
	"no_label", 	# Switch off labels for element positions (-n)
	"other_options", 	# Other Options
	"default_custom_file", 	# Create a new default customfile (.gff2psrc) (-D)
	"user_custom_file", 	# Your custom rc file (.gff2psrc)

    ];

    $self->{TYPE}  = {
	"gff2ps" => 'String',
	"outfile" => 'OutFile',
	"rcfile" => 'Results',
	"gff_file" => 'InFile',
	"output_options" => 'Paragraph',
	"page_size" => 'String',
	"orientation" => 'Switch',
	"split" => 'Integer',
	"zoom_first" => 'Integer',
	"zoom_last" => 'Integer',
	"blocks" => 'Integer',
	"nuc_per_line" => 'Integer',
	"blocks_from_left_to_right" => 'Switch',
	"no_headers" => 'Switch',
	"set_title" => 'String',
	"no_page_nb" => 'Switch',
	"no_date" => 'Switch',
	"no_time" => 'Switch',
	"no_copyright" => 'Switch',
	"color_options" => 'Paragraph',
	"fg_color_name" => 'String',
	"bg_color_name" => 'String',
	"f0_color_name" => 'String',
	"f1_color_name" => 'String',
	"f2_color_name" => 'String',
	"f_color_name" => 'String',
	"tickmark_options" => 'Paragraph',
	"major_tickmarks" => 'Integer',
	"major_tickmarks_scale" => 'Integer',
	"minor_tickmarks" => 'Integer',
	"minor_tickmarks_scale" => 'Integer',
	"element_options" => 'Paragraph',
	"no_forward_strand" => 'Switch',
	"no_reverse_strand" => 'Switch',
	"no_strand_independent" => 'Switch',
	"no_label" => 'Switch',
	"other_options" => 'Paragraph',
	"default_custom_file" => 'Switch',
	"user_custom_file" => 'InFile',

    };

    $self->{FORMAT}  = {
	"gff2ps" => {
		"perl" => '"gff2ps"',
	},
	"outfile" => {
		"perl" => '""',
	},
	"rcfile" => {
	},
	"gff_file" => {
		"perl" => '" $value"',
	},
	"output_options" => {
	},
	"page_size" => {
		"perl" => '(defined $value && $value ne $vdef)? " -s $value" : ""',
	},
	"orientation" => {
		"perl" => '($value)? " -p" : ""',
	},
	"split" => {
		"perl" => '($value && $value != $vdef)? " -P $value" : ""',
	},
	"zoom_first" => {
		"perl" => '($value)? " -S $value" : ""',
	},
	"zoom_last" => {
		"perl" => '($value)? " -E $value" : ""',
	},
	"blocks" => {
		"perl" => '($value && $value != $vdef)? " -B $value" : ""',
	},
	"nuc_per_line" => {
		"perl" => '($value)? " -N $value" : ""',
	},
	"blocks_from_left_to_right" => {
		"perl" => '($value)? " -b" : ""',
	},
	"no_headers" => {
		"perl" => '($value)? " -L" : ""',
	},
	"set_title" => {
		"perl" => '($value)? " -T $value" : ""',
	},
	"no_page_nb" => {
		"perl" => '($value)? " -l" : ""',
	},
	"no_date" => {
		"perl" => '($value)? " -O" : ""',
	},
	"no_time" => {
		"perl" => '($value)? " -o" : ""',
	},
	"no_copyright" => {
		"perl" => '($value)? " -a" : ""',
	},
	"color_options" => {
	},
	"fg_color_name" => {
		"perl" => '($value && $value ne $vdef)? " -G $value" : ""',
	},
	"bg_color_name" => {
		"perl" => '($value && $value ne $vdef)? " -g $value" : ""',
	},
	"f0_color_name" => {
		"perl" => '($value && $value ne $vdef)? " -0 $value" : ""',
	},
	"f1_color_name" => {
		"perl" => '($value && $value ne $vdef)? " -1 $value" : ""',
	},
	"f2_color_name" => {
		"perl" => '($value && $value ne $vdef)? " -2 $value" : ""',
	},
	"f_color_name" => {
		"perl" => '($value && $value ne $vdef)? " -3 $value" : ""',
	},
	"tickmark_options" => {
	},
	"major_tickmarks" => {
		"perl" => '($value && $value != $vdef)? " -M $value" : ""',
	},
	"major_tickmarks_scale" => {
		"perl" => '($value)? " -K $value" : ""',
	},
	"minor_tickmarks" => {
		"perl" => '($value && $value != $vdef)? " -m $value" : ""',
	},
	"minor_tickmarks_scale" => {
		"perl" => '($value)? " -k $value" : ""',
	},
	"element_options" => {
	},
	"no_forward_strand" => {
		"perl" => '($value)? " -w" : ""',
	},
	"no_reverse_strand" => {
		"perl" => '($value)? " -c" : ""',
	},
	"no_strand_independent" => {
		"perl" => '($value)? " -i" : ""',
	},
	"no_label" => {
		"perl" => '($value)? " -n" : ""',
	},
	"other_options" => {
	},
	"default_custom_file" => {
		"perl" => '(defined $value)? " -D .gff2psrc" : ""',
	},
	"user_custom_file" => {
		"perl" => '($value)? " -C $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"rcfile" => '.gff2psrc',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"gff2ps" => 0,
	"gff_file" => 100,
	"output_options" => 1,
	"page_size" => 1,
	"orientation" => 1,
	"split" => 1,
	"zoom_first" => 1,
	"zoom_last" => 1,
	"blocks" => 1,
	"nuc_per_line" => 1,
	"blocks_from_left_to_right" => 1,
	"no_headers" => 1,
	"set_title" => 1,
	"no_page_nb" => 1,
	"no_date" => 1,
	"no_time" => 1,
	"no_copyright" => 1,
	"color_options" => 3,
	"fg_color_name" => 3,
	"bg_color_name" => 3,
	"f0_color_name" => 3,
	"f1_color_name" => 3,
	"f2_color_name" => 3,
	"f_color_name" => 3,
	"tickmark_options" => 2,
	"major_tickmarks" => 2,
	"major_tickmarks_scale" => 2,
	"minor_tickmarks" => 2,
	"minor_tickmarks_scale" => 2,
	"element_options" => 4,
	"no_forward_strand" => 4,
	"no_reverse_strand" => 4,
	"no_strand_independent" => 4,
	"no_label" => 4,
	"other_options" => 1,
	"default_custom_file" => 5,
	"user_custom_file" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"gff2ps",
	"outfile",
	"rcfile",
	"user_custom_file",
	"output_options",
	"page_size",
	"orientation",
	"split",
	"zoom_first",
	"zoom_last",
	"blocks",
	"nuc_per_line",
	"blocks_from_left_to_right",
	"no_headers",
	"set_title",
	"no_page_nb",
	"no_date",
	"no_time",
	"no_copyright",
	"other_options",
	"tickmark_options",
	"minor_tickmarks",
	"minor_tickmarks_scale",
	"major_tickmarks",
	"major_tickmarks_scale",
	"f_color_name",
	"color_options",
	"fg_color_name",
	"bg_color_name",
	"f0_color_name",
	"f1_color_name",
	"f2_color_name",
	"no_forward_strand",
	"no_reverse_strand",
	"no_strand_independent",
	"no_label",
	"element_options",
	"default_custom_file",
	"gff_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"gff2ps" => 1,
	"outfile" => 1,
	"rcfile" => 0,
	"gff_file" => 0,
	"output_options" => 0,
	"page_size" => 0,
	"orientation" => 0,
	"split" => 0,
	"zoom_first" => 0,
	"zoom_last" => 0,
	"blocks" => 0,
	"nuc_per_line" => 0,
	"blocks_from_left_to_right" => 0,
	"no_headers" => 0,
	"set_title" => 0,
	"no_page_nb" => 0,
	"no_date" => 0,
	"no_time" => 0,
	"no_copyright" => 0,
	"color_options" => 0,
	"fg_color_name" => 0,
	"bg_color_name" => 0,
	"f0_color_name" => 0,
	"f1_color_name" => 0,
	"f2_color_name" => 0,
	"f_color_name" => 0,
	"tickmark_options" => 0,
	"major_tickmarks" => 0,
	"major_tickmarks_scale" => 0,
	"minor_tickmarks" => 0,
	"minor_tickmarks_scale" => 0,
	"element_options" => 0,
	"no_forward_strand" => 0,
	"no_reverse_strand" => 0,
	"no_strand_independent" => 0,
	"no_label" => 0,
	"other_options" => 0,
	"default_custom_file" => 0,
	"user_custom_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"gff2ps" => 1,
	"outfile" => 0,
	"rcfile" => 0,
	"gff_file" => 0,
	"output_options" => 0,
	"page_size" => 0,
	"orientation" => 0,
	"split" => 0,
	"zoom_first" => 0,
	"zoom_last" => 0,
	"blocks" => 0,
	"nuc_per_line" => 0,
	"blocks_from_left_to_right" => 0,
	"no_headers" => 0,
	"set_title" => 0,
	"no_page_nb" => 0,
	"no_date" => 0,
	"no_time" => 0,
	"no_copyright" => 0,
	"color_options" => 0,
	"fg_color_name" => 0,
	"bg_color_name" => 0,
	"f0_color_name" => 0,
	"f1_color_name" => 0,
	"f2_color_name" => 0,
	"f_color_name" => 0,
	"tickmark_options" => 0,
	"major_tickmarks" => 0,
	"major_tickmarks_scale" => 0,
	"minor_tickmarks" => 0,
	"minor_tickmarks_scale" => 0,
	"element_options" => 0,
	"no_forward_strand" => 0,
	"no_reverse_strand" => 0,
	"no_strand_independent" => 0,
	"no_label" => 0,
	"other_options" => 0,
	"default_custom_file" => 0,
	"user_custom_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"gff2ps" => 0,
	"outfile" => 0,
	"rcfile" => 0,
	"gff_file" => 1,
	"output_options" => 0,
	"page_size" => 0,
	"orientation" => 0,
	"split" => 0,
	"zoom_first" => 0,
	"zoom_last" => 0,
	"blocks" => 0,
	"nuc_per_line" => 0,
	"blocks_from_left_to_right" => 0,
	"no_headers" => 0,
	"set_title" => 0,
	"no_page_nb" => 0,
	"no_date" => 0,
	"no_time" => 0,
	"no_copyright" => 0,
	"color_options" => 0,
	"fg_color_name" => 0,
	"bg_color_name" => 0,
	"f0_color_name" => 0,
	"f1_color_name" => 0,
	"f2_color_name" => 0,
	"f_color_name" => 0,
	"tickmark_options" => 0,
	"major_tickmarks" => 0,
	"major_tickmarks_scale" => 0,
	"minor_tickmarks" => 0,
	"minor_tickmarks_scale" => 0,
	"element_options" => 0,
	"no_forward_strand" => 0,
	"no_reverse_strand" => 0,
	"no_strand_independent" => 0,
	"no_label" => 0,
	"other_options" => 0,
	"default_custom_file" => 0,
	"user_custom_file" => 0,

    };

    $self->{PROMPT}  = {
	"gff2ps" => "",
	"outfile" => "",
	"rcfile" => "",
	"gff_file" => "GFF file",
	"output_options" => "Output Options",
	"page_size" => "Modify page size (-D)",
	"orientation" => "Switches page orientation to Portrait (default is Landscape) (-p)",
	"split" => "Sets how many pages are needed to split your output (-P)",
	"zoom_first" => "Zoom first nucleotide (default is sequence origin) (-S)",
	"zoom_last" => "Zoom last nucleotide (default is sequence length) (-E)",
	"blocks" => "Sets blocks per page (-B)",
	"nuc_per_line" => "Sets nucleotides per line (default is the largest sequence position from input gff-files) (-N)",
	"blocks_from_left_to_right" => "Blocks from left to right and from top to bottom (default is top to bottom first) (-b)",
	"no_headers" => "Switch off Header (Title area) (-L)",
	"set_title" => "Defining title (default is input gff filename) (-T)",
	"no_page_nb" => "Does not show page numbering (-l)",
	"no_date" => "Does not show date (-O)",
	"no_time" => "Does not show time (-o)",
	"no_copyright" => "Switch off CopyRight line on plot (-a)",
	"color_options" => "Color Options",
	"fg_color_name" => "Sets color for FOREGROUND (-G)",
	"bg_color_name" => "Sets color for BACKGROUND (-G)",
	"f0_color_name" => "Sets color for frame 0 (-0)",
	"f1_color_name" => "Sets color for frame 1 (-1)",
	"f2_color_name" => "Sets color for frame 2 (-2)",
	"f_color_name" => "Sets color for frame . (-3)",
	"tickmark_options" => "Tickmark Options",
	"major_tickmarks" => "Number of major tickmarks per line (-M)",
	"major_tickmarks_scale" => "Major tickmarks scale in nucleotides (-K)",
	"minor_tickmarks" => "Number of minor tickmarks between major tickmarks (-m)",
	"minor_tickmarks_scale" => "Minor tickmarks scale in nucleotides (-k)",
	"element_options" => "Display elements Options",
	"no_forward_strand" => "Switch off displaying forward-strand(Watson) elements (-w)",
	"no_reverse_strand" => "Switch off displaying reverse-strand(Crick) elements (-c)",
	"no_strand_independent" => "Switch off displaying strand-independent elements (-i)",
	"no_label" => "Switch off labels for element positions (-n)",
	"other_options" => "Other Options",
	"default_custom_file" => "Create a new default customfile (.gff2psrc) (-D)",
	"user_custom_file" => "Your custom rc file (.gff2psrc)",

    };

    $self->{ISSTANDOUT}  = {
	"gff2ps" => 0,
	"outfile" => 1,
	"rcfile" => 0,
	"gff_file" => 0,
	"output_options" => 0,
	"page_size" => 0,
	"orientation" => 0,
	"split" => 0,
	"zoom_first" => 0,
	"zoom_last" => 0,
	"blocks" => 0,
	"nuc_per_line" => 0,
	"blocks_from_left_to_right" => 0,
	"no_headers" => 0,
	"set_title" => 0,
	"no_page_nb" => 0,
	"no_date" => 0,
	"no_time" => 0,
	"no_copyright" => 0,
	"color_options" => 0,
	"fg_color_name" => 0,
	"bg_color_name" => 0,
	"f0_color_name" => 0,
	"f1_color_name" => 0,
	"f2_color_name" => 0,
	"f_color_name" => 0,
	"tickmark_options" => 0,
	"major_tickmarks" => 0,
	"major_tickmarks_scale" => 0,
	"minor_tickmarks" => 0,
	"minor_tickmarks_scale" => 0,
	"element_options" => 0,
	"no_forward_strand" => 0,
	"no_reverse_strand" => 0,
	"no_strand_independent" => 0,
	"no_label" => 0,
	"other_options" => 0,
	"default_custom_file" => 0,
	"user_custom_file" => 0,

    };

    $self->{VLIST}  = {

	"output_options" => ['page_size','orientation','split','zoom_first','zoom_last','blocks','nuc_per_line','blocks_from_left_to_right','no_headers','set_title','no_page_nb','no_date','no_time','no_copyright',],
	"color_options" => ['fg_color_name','bg_color_name','f0_color_name','f1_color_name','f2_color_name','f_color_name',],
	"tickmark_options" => ['major_tickmarks','major_tickmarks_scale','minor_tickmarks','minor_tickmarks_scale',],
	"element_options" => ['no_forward_strand','no_reverse_strand','no_strand_independent','no_label',],
	"other_options" => ['default_custom_file','user_custom_file',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => '"gff2ps.ps"',
	"page_size" => 'a4',
	"split" => '1',
	"blocks" => '1',
	"fg_color_name" => 'black',
	"bg_color_name" => 'white',
	"f0_color_name" => 'blue',
	"f1_color_name" => 'red',
	"f2_color_name" => 'green',
	"f_color_name" => 'orange',
	"major_tickmarks" => '10',
	"minor_tickmarks" => '10',

    };

    $self->{PRECOND}  = {
	"gff2ps" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"rcfile" => {
		"perl" => '$default_custom_file',
	},
	"gff_file" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"page_size" => { "perl" => '1' },
	"orientation" => { "perl" => '1' },
	"split" => { "perl" => '1' },
	"zoom_first" => { "perl" => '1' },
	"zoom_last" => { "perl" => '1' },
	"blocks" => { "perl" => '1' },
	"nuc_per_line" => { "perl" => '1' },
	"blocks_from_left_to_right" => { "perl" => '1' },
	"no_headers" => { "perl" => '1' },
	"set_title" => { "perl" => '1' },
	"no_page_nb" => { "perl" => '1' },
	"no_date" => { "perl" => '1' },
	"no_time" => { "perl" => '1' },
	"no_copyright" => { "perl" => '1' },
	"color_options" => { "perl" => '1' },
	"fg_color_name" => { "perl" => '1' },
	"bg_color_name" => { "perl" => '1' },
	"f0_color_name" => { "perl" => '1' },
	"f1_color_name" => { "perl" => '1' },
	"f2_color_name" => { "perl" => '1' },
	"f_color_name" => { "perl" => '1' },
	"tickmark_options" => { "perl" => '1' },
	"major_tickmarks" => { "perl" => '1' },
	"major_tickmarks_scale" => { "perl" => '1' },
	"minor_tickmarks" => { "perl" => '1' },
	"minor_tickmarks_scale" => { "perl" => '1' },
	"element_options" => { "perl" => '1' },
	"no_forward_strand" => { "perl" => '1' },
	"no_reverse_strand" => { "perl" => '1' },
	"no_strand_independent" => { "perl" => '1' },
	"no_label" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"default_custom_file" => { "perl" => '1' },
	"user_custom_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"gff2ps" => 0,
	"outfile" => 0,
	"rcfile" => 0,
	"gff_file" => 0,
	"output_options" => 0,
	"page_size" => 0,
	"orientation" => 0,
	"split" => 0,
	"zoom_first" => 0,
	"zoom_last" => 0,
	"blocks" => 0,
	"nuc_per_line" => 0,
	"blocks_from_left_to_right" => 0,
	"no_headers" => 0,
	"set_title" => 0,
	"no_page_nb" => 0,
	"no_date" => 0,
	"no_time" => 0,
	"no_copyright" => 0,
	"color_options" => 0,
	"fg_color_name" => 0,
	"bg_color_name" => 0,
	"f0_color_name" => 0,
	"f1_color_name" => 0,
	"f2_color_name" => 0,
	"f_color_name" => 0,
	"tickmark_options" => 0,
	"major_tickmarks" => 0,
	"major_tickmarks_scale" => 0,
	"minor_tickmarks" => 0,
	"minor_tickmarks_scale" => 0,
	"element_options" => 0,
	"no_forward_strand" => 0,
	"no_reverse_strand" => 0,
	"no_strand_independent" => 0,
	"no_label" => 0,
	"other_options" => 0,
	"default_custom_file" => 0,
	"user_custom_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"gff2ps" => 0,
	"outfile" => 0,
	"rcfile" => 0,
	"gff_file" => 1,
	"output_options" => 0,
	"page_size" => 0,
	"orientation" => 0,
	"split" => 0,
	"zoom_first" => 0,
	"zoom_last" => 0,
	"blocks" => 0,
	"nuc_per_line" => 0,
	"blocks_from_left_to_right" => 0,
	"no_headers" => 0,
	"set_title" => 0,
	"no_page_nb" => 0,
	"no_date" => 0,
	"no_time" => 0,
	"no_copyright" => 0,
	"color_options" => 0,
	"fg_color_name" => 0,
	"bg_color_name" => 0,
	"f0_color_name" => 0,
	"f1_color_name" => 0,
	"f2_color_name" => 0,
	"f_color_name" => 0,
	"tickmark_options" => 0,
	"major_tickmarks" => 0,
	"major_tickmarks_scale" => 0,
	"minor_tickmarks" => 0,
	"minor_tickmarks_scale" => 0,
	"element_options" => 0,
	"no_forward_strand" => 0,
	"no_reverse_strand" => 0,
	"no_strand_independent" => 0,
	"no_label" => 0,
	"other_options" => 0,
	"default_custom_file" => 0,
	"user_custom_file" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"major_tickmarks_scale" => [
		"Default is nucleotide length for lines divided by major tickmarks number (see option -T).",
	],
	"minor_tickmarks_scale" => [
		"Default is major tickmarks size divided by minor tickmarks number (see option -t).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gff2ps.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

