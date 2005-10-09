# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::boxshade
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::boxshade

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::boxshade

      Bioperl class for:

	BOXSHADE	printouts from multiple-aligned protein or DNA sequences (Hofmann, Baron)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/boxshade.html 
         for available values):


		boxshade (String)

		alignment (Sequence)
			Alignment File
			pipe: readseq_ok_alig

		input_format (String)

		output_format (Excl)
			Output format

		print_name (Switch)
			Should sequence name be printed

		ruler (Switch)
			Display ruler line

		space_between_name_sequence (Integer)
			How many spaces between name and sequence

		ignored_gaps (Integer)
			Number of gaps to be ignored when shading (-1: none)

		sequence_characters (Integer)
			How many sequence characters per line

		lines (Integer)
			How many lines between two sequence blocks

		character_size (Integer)
			Character size in Points (except for HTML and ASCII output formats)

		save_shading (Excl)
			Save Shading/Text

		rotate (Switch)
			Rotate plot

		label_similar (Switch)
			Special label for similar residues

		label_identical (Switch)
			Special label for identical residues in all sequences

		consensus (Switch)
			Display consensus line

		threshold (Float)
			Identity threshold

		different_background (Excl)
			Background for different residues

		different_foreground (Excl)
			Foreground for different residues (lowercase choices mean lowercase letters in the sequence)

		identical_background (Excl)
			Background for identical residues

		identical_foreground (Excl)
			Foreground for identical residues (lowercase choices mean lowercase letters in the sequence)

		similar_background (Excl)
			Background for similar residues

		similar_foreground (Excl)
			Foreground for similar residues (lowercase choices mean lowercase letters in the sequence)

		conserved_background (Excl)
			Background for conserved residues (if special label for identical residues)

		conserved_foreground (Excl)
			Foreground for conserved residues (lowercase choices mean lowercase letters in the sequence)

		single (Switch)
			Similarity to a single sequence

		seq_no (Integer)
			Which sequence (give its number)

		hide (Switch)
			Hide this sequence

		show_normal (Switch)
			Show this sequence in all-normal rendition

		matrix (Switch)
			Create identity / similarity matrix

		print_position (Excl)

		outfile (OutFile)

		psfile (OutFile)

		htmlfile (OutFile)

		pictfile (OutFile)

		matrixfile (OutFile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/boxshade.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::boxshade;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $boxshade = Bio::Tools::Run::PiseApplication::boxshade->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::boxshade object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $boxshade = $factory->program('boxshade');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::boxshade.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/boxshade.pm

    $self->{COMMAND}   = "boxshade";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BOXSHADE";

    $self->{DESCRIPTION}   = "printouts from multiple-aligned protein or DNA sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",

         "display",
  ];

    $self->{AUTHORS}   = "Hofmann, Baron";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"boxshade",
	"alignment",
	"input_format",
	"output_params",
	"sequence_params",
	"matrix",
	"print_position",
	"outfile",
	"psfile",
	"htmlfile",
	"pictfile",
	"matrixfile",
	"tmp_params",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"boxshade",
	"alignment", 	# Alignment File
	"input_format",
	"output_params", 	# Output parameters
	"output_format", 	# Output format
	"print_name", 	# Should sequence name be printed
	"ruler", 	# Display ruler line
	"space_between_name_sequence", 	# How many spaces between name and sequence
	"ignored_gaps", 	# Number of gaps to be ignored when shading (-1: none)
	"sequence_characters", 	# How many sequence characters per line
	"lines", 	# How many lines between two sequence blocks
	"character_size", 	# Character size in Points (except for HTML and ASCII output formats)
	"save_shading", 	# Save Shading/Text
	"rotate", 	# Rotate plot
	"sequence_params", 	# Sequence properties
	"label_similar", 	# Special label for similar residues
	"label_identical", 	# Special label for identical residues in all sequences
	"consensus", 	# Display consensus line
	"threshold", 	# Identity threshold
	"letters", 	# Letters foreground and background colors
	"different_background", 	# Background for different residues
	"different_foreground", 	# Foreground for different residues (lowercase choices mean lowercase letters in the sequence)
	"identical_background", 	# Background for identical residues
	"identical_foreground", 	# Foreground for identical residues (lowercase choices mean lowercase letters in the sequence)
	"similar_background", 	# Background for similar residues
	"similar_foreground", 	# Foreground for similar residues (lowercase choices mean lowercase letters in the sequence)
	"conserved_background", 	# Background for conserved residues (if special label for identical residues)
	"conserved_foreground", 	# Foreground for conserved residues (lowercase choices mean lowercase letters in the sequence)
	"single_comparison", 	# Comparison to a single sequence
	"single", 	# Similarity to a single sequence
	"seq_no", 	# Which sequence (give its number)
	"hide", 	# Hide this sequence
	"show_normal", 	# Show this sequence in all-normal rendition
	"matrix", 	# Create identity / similarity matrix
	"print_position",
	"outfile",
	"psfile",
	"htmlfile",
	"pictfile",
	"matrixfile",
	"tmp_params",

    ];

    $self->{TYPE}  = {
	"boxshade" => 'String',
	"alignment" => 'Sequence',
	"input_format" => 'String',
	"output_params" => 'Paragraph',
	"output_format" => 'Excl',
	"print_name" => 'Switch',
	"ruler" => 'Switch',
	"space_between_name_sequence" => 'Integer',
	"ignored_gaps" => 'Integer',
	"sequence_characters" => 'Integer',
	"lines" => 'Integer',
	"character_size" => 'Integer',
	"save_shading" => 'Excl',
	"rotate" => 'Switch',
	"sequence_params" => 'Paragraph',
	"label_similar" => 'Switch',
	"label_identical" => 'Switch',
	"consensus" => 'Switch',
	"threshold" => 'Float',
	"letters" => 'Paragraph',
	"different_background" => 'Excl',
	"different_foreground" => 'Excl',
	"identical_background" => 'Excl',
	"identical_foreground" => 'Excl',
	"similar_background" => 'Excl',
	"similar_foreground" => 'Excl',
	"conserved_background" => 'Excl',
	"conserved_foreground" => 'Excl',
	"single_comparison" => 'Paragraph',
	"single" => 'Switch',
	"seq_no" => 'Integer',
	"hide" => 'Switch',
	"show_normal" => 'Switch',
	"matrix" => 'Switch',
	"print_position" => 'Excl',
	"outfile" => 'OutFile',
	"psfile" => 'OutFile',
	"htmlfile" => 'OutFile',
	"pictfile" => 'OutFile',
	"matrixfile" => 'OutFile',
	"tmp_params" => 'Results',

    };

    $self->{FORMAT}  = {
	"boxshade" => {
		"perl" => ' "boxshade < params" ',
	},
	"alignment" => {
		"perl" => '"$value\\n"',
	},
	"input_format" => {
		"perl" => '"2\\n"',
	},
	"output_params" => {
	},
	"output_format" => {
		"perl" => '"$value\\n"',
	},
	"print_name" => {
		"perl" => '($value)? "y\\n" : "n\\n"',
	},
	"ruler" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"space_between_name_sequence" => {
		"perl" => '"$value\\n"',
	},
	"ignored_gaps" => {
		"perl" => '(defined $value && $value != $vdef)? "$value\\n" : "\\n"',
	},
	"sequence_characters" => {
		"perl" => '"$value\\n"',
	},
	"lines" => {
		"perl" => '"$value\\n"',
	},
	"character_size" => {
		"perl" => '(defined $value && $value != $vdef)? "$value\\n" : "\\n"',
	},
	"save_shading" => {
		"perl" => '"$value\\n"',
	},
	"rotate" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"sequence_params" => {
	},
	"label_similar" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"label_identical" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"consensus" => {
		"perl" => '($value)? "y\\n .*\\n" : "n\\n" ',
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? "$value\\n" : "\\n"',
	},
	"letters" => {
	},
	"different_background" => {
		"perl" => '"$value\\n"',
	},
	"different_foreground" => {
		"perl" => '"$value\\n"',
	},
	"identical_background" => {
		"perl" => '"$value\\n"',
	},
	"identical_foreground" => {
		"perl" => '"$value\\n"',
	},
	"similar_background" => {
		"perl" => '"$value\\n"',
	},
	"similar_foreground" => {
		"perl" => '"$value\\n"',
	},
	"conserved_background" => {
		"perl" => '"$value\\n"',
	},
	"conserved_foreground" => {
		"perl" => '"$value\\n"',
	},
	"single_comparison" => {
	},
	"single" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"seq_no" => {
		"perl" => '"$value\\n"',
	},
	"hide" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"show_normal" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"matrix" => {
		"perl" => '($value)? "y\\n" : "n\\n" ',
	},
	"print_position" => {
		"perl" => '"0\\n"',
	},
	"outfile" => {
		"perl" => '"boxshade.result\\n"',
	},
	"psfile" => {
		"perl" => '"boxshade.ps\\n"',
	},
	"htmlfile" => {
		"perl" => '"boxshade.html\\n"',
	},
	"pictfile" => {
		"perl" => '"boxshade.pict\\n"',
	},
	"matrixfile" => {
		"perl" => '"boxshade.matrix\\n"',
	},
	"tmp_params" => {
	},

    };

    $self->{FILENAMES}  = {
	"tmp_params" => 'params *.result *.pict',

    };

    $self->{SEQFMT}  = {
	"alignment" => [100],

    };

    $self->{GROUP}  = {
	"boxshade" => 0,
	"alignment" => 1,
	"input_format" => 2,
	"output_format" => 3,
	"print_name" => 13,
	"ruler" => 6,
	"space_between_name_sequence" => 15,
	"ignored_gaps" => 11,
	"sequence_characters" => 12,
	"lines" => 17,
	"character_size" => 28,
	"save_shading" => 29,
	"rotate" => 31,
	"label_similar" => 18,
	"label_identical" => 19,
	"consensus" => 5,
	"threshold" => 10,
	"different_background" => 20,
	"different_foreground" => 21,
	"identical_background" => 22,
	"identical_foreground" => 23,
	"similar_background" => 24,
	"similar_foreground" => 25,
	"conserved_background" => 26,
	"conserved_foreground" => 27,
	"single" => 4,
	"seq_no" => 40,
	"hide" => 41,
	"show_normal" => 42,
	"matrix" => 34,
	"print_position" => 14,
	"outfile" => 32,
	"psfile" => 33,
	"htmlfile" => 33,
	"pictfile" => 33,
	"matrixfile" => 35,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"boxshade",
	"tmp_params",
	"single_comparison",
	"output_params",
	"sequence_params",
	"letters",
	"alignment",
	"input_format",
	"output_format",
	"single",
	"consensus",
	"ruler",
	"threshold",
	"ignored_gaps",
	"sequence_characters",
	"print_name",
	"print_position",
	"space_between_name_sequence",
	"lines",
	"label_similar",
	"label_identical",
	"different_background",
	"different_foreground",
	"identical_background",
	"identical_foreground",
	"similar_background",
	"similar_foreground",
	"conserved_background",
	"conserved_foreground",
	"character_size",
	"save_shading",
	"rotate",
	"outfile",
	"psfile",
	"htmlfile",
	"pictfile",
	"matrix",
	"matrixfile",
	"seq_no",
	"hide",
	"show_normal",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"boxshade" => 1,
	"alignment" => 0,
	"input_format" => 1,
	"output_params" => 0,
	"output_format" => 0,
	"print_name" => 0,
	"ruler" => 0,
	"space_between_name_sequence" => 0,
	"ignored_gaps" => 0,
	"sequence_characters" => 0,
	"lines" => 0,
	"character_size" => 0,
	"save_shading" => 0,
	"rotate" => 0,
	"sequence_params" => 0,
	"label_similar" => 0,
	"label_identical" => 0,
	"consensus" => 0,
	"threshold" => 0,
	"letters" => 0,
	"different_background" => 0,
	"different_foreground" => 0,
	"identical_background" => 0,
	"identical_foreground" => 0,
	"similar_background" => 0,
	"similar_foreground" => 0,
	"conserved_background" => 0,
	"conserved_foreground" => 0,
	"single_comparison" => 0,
	"single" => 0,
	"seq_no" => 0,
	"hide" => 0,
	"show_normal" => 0,
	"matrix" => 0,
	"print_position" => 1,
	"outfile" => 1,
	"psfile" => 1,
	"htmlfile" => 1,
	"pictfile" => 1,
	"matrixfile" => 1,
	"tmp_params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"boxshade" => 1,
	"alignment" => 0,
	"input_format" => 0,
	"output_params" => 0,
	"output_format" => 0,
	"print_name" => 0,
	"ruler" => 0,
	"space_between_name_sequence" => 0,
	"ignored_gaps" => 0,
	"sequence_characters" => 0,
	"lines" => 0,
	"character_size" => 0,
	"save_shading" => 0,
	"rotate" => 0,
	"sequence_params" => 0,
	"label_similar" => 0,
	"label_identical" => 0,
	"consensus" => 0,
	"threshold" => 0,
	"letters" => 0,
	"different_background" => 0,
	"different_foreground" => 0,
	"identical_background" => 0,
	"identical_foreground" => 0,
	"similar_background" => 0,
	"similar_foreground" => 0,
	"conserved_background" => 0,
	"conserved_foreground" => 0,
	"single_comparison" => 0,
	"single" => 0,
	"seq_no" => 0,
	"hide" => 0,
	"show_normal" => 0,
	"matrix" => 0,
	"print_position" => 0,
	"outfile" => 0,
	"psfile" => 0,
	"htmlfile" => 0,
	"pictfile" => 0,
	"matrixfile" => 0,
	"tmp_params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"boxshade" => 0,
	"alignment" => 1,
	"input_format" => 0,
	"output_params" => 0,
	"output_format" => 1,
	"print_name" => 0,
	"ruler" => 0,
	"space_between_name_sequence" => 0,
	"ignored_gaps" => 0,
	"sequence_characters" => 0,
	"lines" => 0,
	"character_size" => 0,
	"save_shading" => 1,
	"rotate" => 0,
	"sequence_params" => 0,
	"label_similar" => 0,
	"label_identical" => 0,
	"consensus" => 0,
	"threshold" => 0,
	"letters" => 0,
	"different_background" => 1,
	"different_foreground" => 1,
	"identical_background" => 1,
	"identical_foreground" => 1,
	"similar_background" => 1,
	"similar_foreground" => 1,
	"conserved_background" => 1,
	"conserved_foreground" => 1,
	"single_comparison" => 0,
	"single" => 0,
	"seq_no" => 1,
	"hide" => 0,
	"show_normal" => 0,
	"matrix" => 0,
	"print_position" => 0,
	"outfile" => 1,
	"psfile" => 0,
	"htmlfile" => 0,
	"pictfile" => 0,
	"matrixfile" => 0,
	"tmp_params" => 0,

    };

    $self->{PROMPT}  = {
	"boxshade" => "",
	"alignment" => "Alignment File",
	"input_format" => "",
	"output_params" => "Output parameters",
	"output_format" => "Output format",
	"print_name" => "Should sequence name be printed",
	"ruler" => "Display ruler line",
	"space_between_name_sequence" => "How many spaces between name and sequence",
	"ignored_gaps" => "Number of gaps to be ignored when shading (-1: none)",
	"sequence_characters" => "How many sequence characters per line",
	"lines" => "How many lines between two sequence blocks",
	"character_size" => "Character size in Points (except for HTML and ASCII output formats)",
	"save_shading" => "Save Shading/Text",
	"rotate" => "Rotate plot",
	"sequence_params" => "Sequence properties",
	"label_similar" => "Special label for similar residues",
	"label_identical" => "Special label for identical residues in all sequences",
	"consensus" => "Display consensus line",
	"threshold" => "Identity threshold",
	"letters" => "Letters foreground and background colors",
	"different_background" => "Background for different residues",
	"different_foreground" => "Foreground for different residues (lowercase choices mean lowercase letters in the sequence)",
	"identical_background" => "Background for identical residues",
	"identical_foreground" => "Foreground for identical residues (lowercase choices mean lowercase letters in the sequence)",
	"similar_background" => "Background for similar residues",
	"similar_foreground" => "Foreground for similar residues (lowercase choices mean lowercase letters in the sequence)",
	"conserved_background" => "Background for conserved residues (if special label for identical residues)",
	"conserved_foreground" => "Foreground for conserved residues (lowercase choices mean lowercase letters in the sequence)",
	"single_comparison" => "Comparison to a single sequence",
	"single" => "Similarity to a single sequence",
	"seq_no" => "Which sequence (give its number)",
	"hide" => "Hide this sequence",
	"show_normal" => "Show this sequence in all-normal rendition",
	"matrix" => "Create identity / similarity matrix",
	"print_position" => "",
	"outfile" => "",
	"psfile" => "",
	"htmlfile" => "",
	"pictfile" => "",
	"matrixfile" => "",
	"tmp_params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"boxshade" => 0,
	"alignment" => 0,
	"input_format" => 0,
	"output_params" => 0,
	"output_format" => 0,
	"print_name" => 0,
	"ruler" => 0,
	"space_between_name_sequence" => 0,
	"ignored_gaps" => 0,
	"sequence_characters" => 0,
	"lines" => 0,
	"character_size" => 0,
	"save_shading" => 0,
	"rotate" => 0,
	"sequence_params" => 0,
	"label_similar" => 0,
	"label_identical" => 0,
	"consensus" => 0,
	"threshold" => 0,
	"letters" => 0,
	"different_background" => 0,
	"different_foreground" => 0,
	"identical_background" => 0,
	"identical_foreground" => 0,
	"similar_background" => 0,
	"similar_foreground" => 0,
	"conserved_background" => 0,
	"conserved_foreground" => 0,
	"single_comparison" => 0,
	"single" => 0,
	"seq_no" => 0,
	"hide" => 0,
	"show_normal" => 0,
	"matrix" => 0,
	"print_position" => 0,
	"outfile" => 0,
	"psfile" => 0,
	"htmlfile" => 0,
	"pictfile" => 0,
	"matrixfile" => 0,
	"tmp_params" => 0,

    };

    $self->{VLIST}  = {

	"output_params" => ['output_format','print_name','ruler','space_between_name_sequence','ignored_gaps','sequence_characters','lines','character_size','save_shading','rotate',],
	"output_format" => ['1','( 1) POSTSCRIPT','2','( 2) encapsulated POSTSCRIPT','3','( 3) HPGL','4','( 4) RTF (Rich Text Format)','6','( 6) ANSI-screen (PC-version)','7','( 7) VT100-screen (DEC-version)','8','( 8) ReGIS-screen (25 lines each)','9','( 9) ReGIS-file (without breaks)','a','( a) LJ250-printer file','c','( c) FIG file (for XFIG)','d','( d) PICT file','e','( e) HTML',],
	"save_shading" => ['S','Save shading (S)','T','Save Shading+Text (T)',],
	"sequence_params" => ['label_similar','label_identical','consensus','threshold','letters','single_comparison',],
	"letters" => ['different_background','different_foreground','identical_background','identical_foreground','similar_background','similar_foreground','conserved_background','conserved_foreground',],
	"different_background" => ['B','(B) black','W','(W) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 (darkest)','R','(R) Red','G','(G) Green','L','(L) Blue','Y','(Y) Yellow','M','(M) Magenta','C','(C) Cyan',],
	"different_foreground" => ['B','(B) black','b','(b) black','W','(W) white','w','(w) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 = darkest','5','gray value: 5 (lowercase)','6','gray value: 6 (lowercase)','7','gray value: 7 (lowercase)','8','gray value: 8 = darkest (lowercase)','R','(R) Red','r','(r) Red','G','(G) Green','g','(g) Green','L','(L) Blue','l','(l) Blue','Y','(Y) Yellow','y','(y) Yellow','M','(M) Magenta','m','(m) Magenta','C','(C) Cyan','c','(c) Cyan',],
	"identical_background" => ['B','(B) black','W','(W) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 (darkest)','R','(R) Red','G','(G) Green','L','(L) Blue','Y','(Y) Yellow','M','(M) Magenta','C','(C) Cyan',],
	"identical_foreground" => ['B','(B) black','b','(b) black','W','(W) white','w','(w) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 = darkest','5','gray value: 5 (lowercase)','6','gray value: 6 (lowercase)','7','gray value: 7 (lowercase)','8','gray value: 8 = darkest (lowercase)','R','(R) Red','r','(r) Red','G','(G) Green','g','(g) Green','L','(L) Blue','l','(l) Blue','Y','(Y) Yellow','y','(y) Yellow','M','(M) Magenta','m','(m) Magenta','C','(C) Cyan','c','(c) Cyan',],
	"similar_background" => ['B','(B) black','W','(W) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 (darkest)','R','(R) Red','G','(G) Green','L','(L) Blue','Y','(Y) Yellow','M','(M) Magenta','C','(C) Cyan',],
	"similar_foreground" => ['B','(B) black','b','(b) black','W','(W) white','w','(w) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 = darkest','5','gray value: 5 (lowercase)','6','gray value: 6 (lowercase)','7','gray value: 7 (lowercase)','8','gray value: 8 = darkest (lowercase)','R','(R) Red','r','(r) Red','G','(G) Green','g','(g) Green','L','(L) Blue','l','(l) Blue','Y','(Y) Yellow','y','(y) Yellow','M','(M) Magenta','m','(m) Magenta','C','(C) Cyan','c','(c) Cyan',],
	"conserved_background" => ['B','(B) black','W','(W) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 (darkest)','R','(R) Red','G','(G) Green','L','(L) Blue','Y','(Y) Yellow','M','(M) Magenta','C','(C) Cyan',],
	"conserved_foreground" => ['B','(B) black','b','(b) black','W','(W) white','w','(w) white','1','gray value: 1','2','gray value: 2','3','gray value: 3','4','gray value: 4 = darkest','5','gray value: 5 (lowercase)','6','gray value: 6 (lowercase)','7','gray value: 7 (lowercase)','8','gray value: 8 = darkest (lowercase)','R','(R) Red','r','(r) Red','G','(G) Green','g','(g) Green','L','(L) Blue','l','(l) Blue','Y','(Y) Yellow','y','(y) Yellow','M','(M) Magenta','m','(m) Magenta','C','(C) Cyan','c','(c) Cyan',],
	"single_comparison" => ['single','seq_no','hide','show_normal',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"output_format" => 'e',
	"print_name" => '1',
	"ruler" => '0',
	"space_between_name_sequence" => '1',
	"ignored_gaps" => '0',
	"sequence_characters" => '60',
	"lines" => '1',
	"character_size" => '10',
	"save_shading" => 'T',
	"rotate" => '0',
	"label_similar" => '1',
	"label_identical" => '0',
	"consensus" => '0',
	"threshold" => '0.50',
	"different_background" => 'W',
	"different_foreground" => 'B',
	"identical_background" => 'B',
	"identical_foreground" => 'W',
	"similar_background" => '1',
	"similar_foreground" => 'B',
	"conserved_background" => '1',
	"conserved_foreground" => 'B',
	"single" => '0',
	"seq_no" => '1',
	"hide" => '0',
	"show_normal" => '0',
	"matrix" => '0',
	"outfile" => '"boxshade.result"',
	"psfile" => '"boxshade.ps"',
	"htmlfile" => '"boxshade.html"',
	"pictfile" => '"boxshade.pict"',
	"matrixfile" => '"boxshade.matrix"',

    };

    $self->{PRECOND}  = {
	"boxshade" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"input_format" => { "perl" => '1' },
	"output_params" => { "perl" => '1' },
	"output_format" => { "perl" => '1' },
	"print_name" => { "perl" => '1' },
	"ruler" => { "perl" => '1' },
	"space_between_name_sequence" => {
		"perl" => '$print_name',
	},
	"ignored_gaps" => {
		"perl" => '$output_format ne "b"',
	},
	"sequence_characters" => { "perl" => '1' },
	"lines" => { "perl" => '1' },
	"character_size" => {
		"perl" => '$output_format ne "b" && $output_format ne "e"',
	},
	"save_shading" => {
		"perl" => '$output_format eq "d"',
	},
	"rotate" => {
		"perl" => '$output_format eq "1" || $output_format eq "2" || $output_format eq "d" || $output_format eq "3" ',
	},
	"sequence_params" => { "perl" => '1' },
	"label_similar" => { "perl" => '1' },
	"label_identical" => { "perl" => '1' },
	"consensus" => { "perl" => '1' },
	"threshold" => {
		"perl" => '$output_format ne "b"',
	},
	"letters" => { "perl" => '1' },
	"different_background" => {
		"perl" => '$output_format ne "b"',
	},
	"different_foreground" => { "perl" => '1' },
	"identical_background" => {
		"perl" => '$output_format ne "b"',
	},
	"identical_foreground" => { "perl" => '1' },
	"similar_background" => {
		"perl" => '$label_similar && $output_format ne "b"',
	},
	"similar_foreground" => {
		"perl" => '$label_similar',
	},
	"conserved_background" => {
		"perl" => '$label_identical && $output_format ne "b"',
	},
	"conserved_foreground" => {
		"perl" => '$label_identical',
	},
	"single_comparison" => { "perl" => '1' },
	"single" => {
		"perl" => '$output_format ne "b"',
	},
	"seq_no" => {
		"perl" => '$single',
	},
	"hide" => {
		"perl" => '$single',
	},
	"show_normal" => {
		"perl" => '$single',
	},
	"matrix" => { "perl" => '1' },
	"print_position" => {
		"perl" => '! $ruler',
	},
	"outfile" => {
		"perl" => '$output_format ne "1" && $output_format ne "e"  && $output_format ne "2" && $output_format ne "d"',
	},
	"psfile" => {
		"perl" => '$output_format eq "1" || $output_format eq "2"',
	},
	"htmlfile" => {
		"perl" => '$output_format eq "e" ',
	},
	"pictfile" => {
		"perl" => '$output_format eq "d"',
	},
	"matrixfile" => {
		"perl" => '$matrix',
	},
	"tmp_params" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"sequence_characters" => {
		"perl" => {
			'$value > 254' => "maximum is 254",
		},
	},
	"lines" => {
		"perl" => {
			'defined $value && $value < 1' => "Enter a value > 0",
		},
	},
	"threshold" => {
		"perl" => {
			'defined $value && ($threshold <= 0 || $threshold > 1)' => "The fraction must be between 0 and 1",
		},
	},
	"seq_no" => {
		"tcl" => {
			'[regexp {/^\\d+$/} $value match]' => "Give a sequence NUMBER",
		},
		"perl" => {
			'($value !~ /^\\d+$/)' => "Give a sequence NUMBER",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"alignment" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"boxshade" => 0,
	"alignment" => 0,
	"input_format" => 0,
	"output_params" => 0,
	"output_format" => 0,
	"print_name" => 0,
	"ruler" => 0,
	"space_between_name_sequence" => 0,
	"ignored_gaps" => 0,
	"sequence_characters" => 0,
	"lines" => 0,
	"character_size" => 0,
	"save_shading" => 0,
	"rotate" => 0,
	"sequence_params" => 0,
	"label_similar" => 0,
	"label_identical" => 0,
	"consensus" => 0,
	"threshold" => 0,
	"letters" => 0,
	"different_background" => 0,
	"different_foreground" => 0,
	"identical_background" => 0,
	"identical_foreground" => 0,
	"similar_background" => 0,
	"similar_foreground" => 0,
	"conserved_background" => 0,
	"conserved_foreground" => 0,
	"single_comparison" => 0,
	"single" => 0,
	"seq_no" => 0,
	"hide" => 0,
	"show_normal" => 0,
	"matrix" => 0,
	"print_position" => 0,
	"outfile" => 0,
	"psfile" => 0,
	"htmlfile" => 0,
	"pictfile" => 0,
	"matrixfile" => 0,
	"tmp_params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"boxshade" => 0,
	"alignment" => 1,
	"input_format" => 0,
	"output_params" => 0,
	"output_format" => 0,
	"print_name" => 0,
	"ruler" => 0,
	"space_between_name_sequence" => 0,
	"ignored_gaps" => 0,
	"sequence_characters" => 0,
	"lines" => 0,
	"character_size" => 0,
	"save_shading" => 0,
	"rotate" => 0,
	"sequence_params" => 0,
	"label_similar" => 0,
	"label_identical" => 0,
	"consensus" => 0,
	"threshold" => 0,
	"letters" => 0,
	"different_background" => 0,
	"different_foreground" => 0,
	"identical_background" => 0,
	"identical_foreground" => 0,
	"similar_background" => 0,
	"similar_foreground" => 0,
	"conserved_background" => 0,
	"conserved_foreground" => 0,
	"single_comparison" => 0,
	"single" => 0,
	"seq_no" => 0,
	"hide" => 0,
	"show_normal" => 0,
	"matrix" => 0,
	"print_position" => 0,
	"outfile" => 0,
	"psfile" => 0,
	"htmlfile" => 0,
	"pictfile" => 0,
	"matrixfile" => 0,
	"tmp_params" => 0,

    };

    $self->{PARAMFILE}  = {
	"alignment" => "params",
	"input_format" => "params",
	"output_format" => "params",
	"print_name" => "params",
	"ruler" => "params",
	"space_between_name_sequence" => "params",
	"ignored_gaps" => "params",
	"sequence_characters" => "params",
	"lines" => "params",
	"character_size" => "params",
	"save_shading" => "params",
	"rotate" => "params",
	"label_similar" => "params",
	"label_identical" => "params",
	"consensus" => "params",
	"threshold" => "params",
	"different_background" => "params",
	"different_foreground" => "params",
	"identical_background" => "params",
	"identical_foreground" => "params",
	"similar_background" => "params",
	"similar_foreground" => "params",
	"conserved_background" => "params",
	"conserved_foreground" => "params",
	"single" => "params",
	"seq_no" => "params",
	"hide" => "params",
	"show_normal" => "params",
	"matrix" => "params",
	"print_position" => "params",
	"outfile" => "params",
	"psfile" => "params",
	"htmlfile" => "params",
	"pictfile" => "params",
	"matrixfile" => "params",

    };

    $self->{COMMENT}  = {
	"threshold" => [
		"The threshold is the fraction of residues that must be identical or similar for shading to occur.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/boxshade.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

