# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::tacg
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::tacg

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::tacg

      Bioperl class for:

	TACG	Restriction Enzyme analysis (Mangalam)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/tacg.html 
         for available values):


		tacg (String)

		sequence (Sequence)
			DNA Sequence (raw sequence)

		beginning (Integer)
			Beginning of a subsequence in your sequence (-b)

		end (Integer)
			End of a subsequence in your sequence (-e)

		topology (Excl)
			Form (or topology) of DNA (-f)

		degeneracy (Excl)
			Degeneracy flag - controls input and analysis of degenerate sequence input (-D)

		codon (Excl)
			Codon Usage table to use for translation (-C)

		order_by_cut (Switch)
			Order the output by number of cuts/fragments (-c)

		width (Integer)
			Output width (between 60 and 210) (-w)

		graphic (Excl)
			Histogram output (-G)

		binsize (Integer)
			Step size in histogram

		enzymes (String)
			Enzymes selection list (separated by comma)

		max_cut (Integer)
			Maximum number of cuts allowed in sequence (-M)

		min_cut (Integer)
			Minimum number of cuts in sequence for the enzyme to be selected (-m)

		magnitude (Excl)
			Select enzymes by magnitude of recognition site (-n)

		overhang (Excl)
			Select enzymes by overhang generated (-o)

		summary (Switch)
			Summary of site information (-s)

		print_fragments (Excl)
			Table of fragments (-F)

		sites (Switch)
			Table of actual cut sites (a la Strider) (-S)

		ladder_map (Switch)
			Ladder map of selected enzymes (-l)

		gel_map (Switch)
			Pseudo-graphic gel map (-g)

		cutoff (Integer)
			Low-end cutoff in number of bases for gel map (>= 10) 

		linear_map (Switch)
			Linear map a la Strider (-L)

		translation (Switch)
			Linear co-translation  (-t,-T)

		translation_frames (Excl)
			Translation in how many frames

		three_letter (Switch)
			Translation in 3-letter code (-T)

		orf (Switch)
			Do an ORF analysis

		frame (List)
			Frames to search

		min_size (Integer)
			Min ORF size

		pattern_search (Switch)
			Do a pattern search (-p)

		pattern (String)
			Pattern (<30 IUPAC character)

		errors (Integer)
			Max number of errors that are tolerated (<6) (-p)

		name (String)
			Label of pattern

		proximity (Switch)
			Do a proximity search

		distance (String)
			Distance between factors

		nameA (String)
			Name of first factor (nameA)

		nameB (String)
			Name of second factor (nameB)

		quiet (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/tacg.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::tacg;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $tacg = Bio::Tools::Run::PiseApplication::tacg->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::tacg object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $tacg = $factory->program('tacg');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::tacg.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/tacg.pm

    $self->{COMMAND}   = "tacg";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "TACG";

    $self->{DESCRIPTION}   = "Restriction Enzyme analysis";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:restriction",
  ];

    $self->{AUTHORS}   = "Mangalam";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"tacg",
	"sequence",
	"input_options",
	"output_options",
	"selection_options",
	"analyses",
	"quiet",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"tacg",
	"sequence", 	# DNA Sequence (raw sequence)
	"input_options", 	# Input options
	"beginning", 	# Beginning of a subsequence in your sequence (-b)
	"end", 	# End of a subsequence in your sequence (-e)
	"topology", 	# Form (or topology) of DNA (-f)
	"degeneracy", 	# Degeneracy flag - controls input and analysis of degenerate sequence input (-D)
	"codon", 	# Codon Usage table to use for translation (-C)
	"output_options", 	# Output options
	"order_by_cut", 	# Order the output by number of cuts/fragments (-c)
	"width", 	# Output width (between 60 and 210) (-w)
	"graphic", 	# Histogram output (-G)
	"binsize", 	# Step size in histogram
	"selection_options", 	# Enzymes Selection options
	"enzymes", 	# Enzymes selection list (separated by comma)
	"max_cut", 	# Maximum number of cuts allowed in sequence (-M)
	"min_cut", 	# Minimum number of cuts in sequence for the enzyme to be selected (-m)
	"magnitude", 	# Select enzymes by magnitude of recognition site (-n)
	"overhang", 	# Select enzymes by overhang generated (-o)
	"analyses", 	# Analyses
	"summary", 	# Summary of site information (-s)
	"print_fragments", 	# Table of fragments (-F)
	"sites", 	# Table of actual cut sites (a la Strider) (-S)
	"ladder_map", 	# Ladder map of selected enzymes (-l)
	"gel_map", 	# Pseudo-graphic gel map (-g)
	"cutoff", 	# Low-end cutoff in number of bases for gel map (>= 10) 
	"linear_map_options", 	# Linear map
	"linear_map", 	# Linear map a la Strider (-L)
	"translation", 	# Linear co-translation  (-t,-T)
	"translation_frames", 	# Translation in how many frames
	"three_letter", 	# Translation in 3-letter code (-T)
	"orf_options", 	# Open Reading Frames
	"orf", 	# Do an ORF analysis
	"frame", 	# Frames to search
	"min_size", 	# Min ORF size
	"pattern_search_options", 	# Pattern Search
	"pattern_search", 	# Do a pattern search (-p)
	"pattern", 	# Pattern (<30 IUPAC character)
	"errors", 	# Max number of errors that are tolerated (<6) (-p)
	"name", 	# Label of pattern
	"proximity_options", 	# Search for spatial relationships between factors (-P)
	"proximity", 	# Do a proximity search
	"distance", 	# Distance between factors
	"nameA", 	# Name of first factor (nameA)
	"nameB", 	# Name of second factor (nameB)
	"quiet",

    ];

    $self->{TYPE}  = {
	"tacg" => 'String',
	"sequence" => 'Sequence',
	"input_options" => 'Paragraph',
	"beginning" => 'Integer',
	"end" => 'Integer',
	"topology" => 'Excl',
	"degeneracy" => 'Excl',
	"codon" => 'Excl',
	"output_options" => 'Paragraph',
	"order_by_cut" => 'Switch',
	"width" => 'Integer',
	"graphic" => 'Excl',
	"binsize" => 'Integer',
	"selection_options" => 'Paragraph',
	"enzymes" => 'String',
	"max_cut" => 'Integer',
	"min_cut" => 'Integer',
	"magnitude" => 'Excl',
	"overhang" => 'Excl',
	"analyses" => 'Paragraph',
	"summary" => 'Switch',
	"print_fragments" => 'Excl',
	"sites" => 'Switch',
	"ladder_map" => 'Switch',
	"gel_map" => 'Switch',
	"cutoff" => 'Integer',
	"linear_map_options" => 'Paragraph',
	"linear_map" => 'Switch',
	"translation" => 'Switch',
	"translation_frames" => 'Excl',
	"three_letter" => 'Switch',
	"orf_options" => 'Paragraph',
	"orf" => 'Switch',
	"frame" => 'List',
	"min_size" => 'Integer',
	"pattern_search_options" => 'Paragraph',
	"pattern_search" => 'Switch',
	"pattern" => 'String',
	"errors" => 'Integer',
	"name" => 'String',
	"proximity_options" => 'Paragraph',
	"proximity" => 'Switch',
	"distance" => 'String',
	"nameA" => 'String',
	"nameB" => 'String',
	"quiet" => 'String',

    };

    $self->{FORMAT}  = {
	"tacg" => {
		"perl" => '"tacg"',
	},
	"sequence" => {
		"perl" => '" < $value "',
	},
	"input_options" => {
	},
	"beginning" => {
		"perl" => '($value)? " -b $value" : "" ',
	},
	"end" => {
		"perl" => '($value)? " -e $value" : ""',
	},
	"topology" => {
		"perl" => '(defined $value && $value != $vdef)? " -f $value" : "" ',
	},
	"degeneracy" => {
		"perl" => '($value && $value != $vdef)? " -D $value" : "" ',
	},
	"codon" => {
		"perl" => '($value)? " -C $value" : "" ',
	},
	"output_options" => {
	},
	"order_by_cut" => {
		"perl" => '($value)? " -c" : ""',
	},
	"width" => {
		"perl" => '($value && $value ne $vdef)? " -w $value" : ""',
	},
	"graphic" => {
		"perl" => '($value)? " -G$binsize,$value" : ""',
	},
	"binsize" => {
		"perl" => ' "" ',
	},
	"selection_options" => {
	},
	"enzymes" => {
		"perl" => '($value)? " -r $value" : "" ',
	},
	"max_cut" => {
		"perl" => '($value)? " -M $value" : "" ',
	},
	"min_cut" => {
		"perl" => '($value)? " -m $value" : "" ',
	},
	"magnitude" => {
		"perl" => '($value && $value ne $vdef)? " -n $value" : "" ',
	},
	"overhang" => {
		"perl" => '(defined $value && $value ne $vdef)? " -o $value" : "" ',
	},
	"analyses" => {
	},
	"summary" => {
		"perl" => '($value)? " -s" : "" ',
	},
	"print_fragments" => {
		"perl" => '($value)? " -F $value" : "" ',
	},
	"sites" => {
		"perl" => '($value)? " -S" : "" ',
	},
	"ladder_map" => {
		"perl" => '($value)? " -l" : "" ',
	},
	"gel_map" => {
		"perl" => '($value)? " -g $cutoff" : "" ',
	},
	"cutoff" => {
		"perl" => ' "" ',
	},
	"linear_map_options" => {
	},
	"linear_map" => {
		"perl" => '($value)? " -L" : "" ',
	},
	"translation" => {
		"perl" => '($value)? " $trans_flag $translation_frames" : ""',
	},
	"translation_frames" => {
	},
	"three_letter" => {
		"perl" => '""',
	},
	"orf_options" => {
	},
	"orf" => {
		"perl" => '($value)? " -O $frame,$min_size" : "" ',
	},
	"frame" => {
		"perl" => '""',
	},
	"min_size" => {
		"perl" => '""',
	},
	"pattern_search_options" => {
	},
	"pattern_search" => {
		"perl" => '($value)? " -p $name,$pattern,$errors" : "" ',
	},
	"pattern" => {
		"perl" => '"" ',
	},
	"errors" => {
		"perl" => '""',
	},
	"name" => {
		"perl" => ' "" ',
	},
	"proximity_options" => {
	},
	"proximity" => {
		"perl" => '($value)? " -P $nameA,$distance,$nameB" : "" ',
	},
	"distance" => {
		"perl" => '""',
	},
	"nameA" => {
		"perl" => ' "" ',
	},
	"nameB" => {
		"perl" => '"" ',
	},
	"quiet" => {
		"perl" => '" -q"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [13],

    };

    $self->{GROUP}  = {
	"tacg" => 0,
	"sequence" => 100,
	"input_options" => 2,
	"beginning" => 2,
	"end" => 2,
	"topology" => 2,
	"degeneracy" => 2,
	"codon" => 2,
	"output_options" => 2,
	"order_by_cut" => 2,
	"width" => 2,
	"graphic" => 2,
	"binsize" => 2,
	"selection_options" => 2,
	"enzymes" => 2,
	"max_cut" => 2,
	"min_cut" => 2,
	"magnitude" => 2,
	"overhang" => 2,
	"analyses" => 2,
	"summary" => 2,
	"print_fragments" => 2,
	"sites" => 2,
	"ladder_map" => 2,
	"gel_map" => 2,
	"cutoff" => 2,
	"linear_map_options" => 2,
	"linear_map" => 2,
	"translation" => 2,
	"translation_frames" => 2,
	"three_letter" => 2,
	"orf_options" => 2,
	"orf" => 2,
	"frame" => 2,
	"min_size" => 2,
	"pattern_search_options" => 2,
	"pattern_search" => 2,
	"pattern" => 2,
	"errors" => 2,
	"name" => 2,
	"proximity_options" => 2,
	"proximity" => 2,
	"distance" => 2,
	"nameA" => 2,
	"nameB" => 2,
	"quiet" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"tacg",
	"quiet",
	"input_options",
	"beginning",
	"end",
	"topology",
	"degeneracy",
	"codon",
	"output_options",
	"order_by_cut",
	"width",
	"graphic",
	"binsize",
	"selection_options",
	"enzymes",
	"max_cut",
	"min_cut",
	"magnitude",
	"overhang",
	"analyses",
	"summary",
	"print_fragments",
	"sites",
	"ladder_map",
	"gel_map",
	"cutoff",
	"linear_map_options",
	"linear_map",
	"translation",
	"translation_frames",
	"three_letter",
	"orf_options",
	"orf",
	"frame",
	"min_size",
	"pattern_search_options",
	"pattern_search",
	"pattern",
	"errors",
	"name",
	"proximity_options",
	"proximity",
	"distance",
	"nameA",
	"nameB",
	"sequence",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"tacg" => 1,
	"sequence" => 0,
	"input_options" => 0,
	"beginning" => 0,
	"end" => 0,
	"topology" => 0,
	"degeneracy" => 0,
	"codon" => 0,
	"output_options" => 0,
	"order_by_cut" => 0,
	"width" => 0,
	"graphic" => 0,
	"binsize" => 0,
	"selection_options" => 0,
	"enzymes" => 0,
	"max_cut" => 0,
	"min_cut" => 0,
	"magnitude" => 0,
	"overhang" => 0,
	"analyses" => 0,
	"summary" => 0,
	"print_fragments" => 0,
	"sites" => 0,
	"ladder_map" => 0,
	"gel_map" => 0,
	"cutoff" => 0,
	"linear_map_options" => 0,
	"linear_map" => 0,
	"translation" => 0,
	"translation_frames" => 0,
	"three_letter" => 0,
	"orf_options" => 0,
	"orf" => 0,
	"frame" => 0,
	"min_size" => 0,
	"pattern_search_options" => 0,
	"pattern_search" => 0,
	"pattern" => 0,
	"errors" => 0,
	"name" => 0,
	"proximity_options" => 0,
	"proximity" => 0,
	"distance" => 0,
	"nameA" => 0,
	"nameB" => 0,
	"quiet" => 1,

    };

    $self->{ISCOMMAND}  = {
	"tacg" => 1,
	"sequence" => 0,
	"input_options" => 0,
	"beginning" => 0,
	"end" => 0,
	"topology" => 0,
	"degeneracy" => 0,
	"codon" => 0,
	"output_options" => 0,
	"order_by_cut" => 0,
	"width" => 0,
	"graphic" => 0,
	"binsize" => 0,
	"selection_options" => 0,
	"enzymes" => 0,
	"max_cut" => 0,
	"min_cut" => 0,
	"magnitude" => 0,
	"overhang" => 0,
	"analyses" => 0,
	"summary" => 0,
	"print_fragments" => 0,
	"sites" => 0,
	"ladder_map" => 0,
	"gel_map" => 0,
	"cutoff" => 0,
	"linear_map_options" => 0,
	"linear_map" => 0,
	"translation" => 0,
	"translation_frames" => 0,
	"three_letter" => 0,
	"orf_options" => 0,
	"orf" => 0,
	"frame" => 0,
	"min_size" => 0,
	"pattern_search_options" => 0,
	"pattern_search" => 0,
	"pattern" => 0,
	"errors" => 0,
	"name" => 0,
	"proximity_options" => 0,
	"proximity" => 0,
	"distance" => 0,
	"nameA" => 0,
	"nameB" => 0,
	"quiet" => 0,

    };

    $self->{ISMANDATORY}  = {
	"tacg" => 0,
	"sequence" => 1,
	"input_options" => 0,
	"beginning" => 0,
	"end" => 0,
	"topology" => 0,
	"degeneracy" => 0,
	"codon" => 0,
	"output_options" => 0,
	"order_by_cut" => 0,
	"width" => 0,
	"graphic" => 0,
	"binsize" => 1,
	"selection_options" => 0,
	"enzymes" => 0,
	"max_cut" => 0,
	"min_cut" => 0,
	"magnitude" => 0,
	"overhang" => 0,
	"analyses" => 0,
	"summary" => 0,
	"print_fragments" => 0,
	"sites" => 0,
	"ladder_map" => 0,
	"gel_map" => 0,
	"cutoff" => 1,
	"linear_map_options" => 0,
	"linear_map" => 0,
	"translation" => 0,
	"translation_frames" => 1,
	"three_letter" => 0,
	"orf_options" => 0,
	"orf" => 0,
	"frame" => 1,
	"min_size" => 1,
	"pattern_search_options" => 0,
	"pattern_search" => 0,
	"pattern" => 1,
	"errors" => 1,
	"name" => 1,
	"proximity_options" => 0,
	"proximity" => 0,
	"distance" => 1,
	"nameA" => 1,
	"nameB" => 1,
	"quiet" => 0,

    };

    $self->{PROMPT}  = {
	"tacg" => "",
	"sequence" => "DNA Sequence (raw sequence)",
	"input_options" => "Input options",
	"beginning" => "Beginning of a subsequence in your sequence (-b)",
	"end" => "End of a subsequence in your sequence (-e)",
	"topology" => "Form (or topology) of DNA (-f)",
	"degeneracy" => "Degeneracy flag - controls input and analysis of degenerate sequence input (-D)",
	"codon" => "Codon Usage table to use for translation (-C)",
	"output_options" => "Output options",
	"order_by_cut" => "Order the output by number of cuts/fragments (-c)",
	"width" => "Output width (between 60 and 210) (-w)",
	"graphic" => "Histogram output (-G)",
	"binsize" => "Step size in histogram",
	"selection_options" => "Enzymes Selection options",
	"enzymes" => "Enzymes selection list (separated by comma)",
	"max_cut" => "Maximum number of cuts allowed in sequence (-M)",
	"min_cut" => "Minimum number of cuts in sequence for the enzyme to be selected (-m)",
	"magnitude" => "Select enzymes by magnitude of recognition site (-n)",
	"overhang" => "Select enzymes by overhang generated (-o)",
	"analyses" => "Analyses",
	"summary" => "Summary of site information (-s)",
	"print_fragments" => "Table of fragments (-F)",
	"sites" => "Table of actual cut sites (a la Strider) (-S)",
	"ladder_map" => "Ladder map of selected enzymes (-l)",
	"gel_map" => "Pseudo-graphic gel map (-g)",
	"cutoff" => "Low-end cutoff in number of bases for gel map (>= 10) ",
	"linear_map_options" => "Linear map",
	"linear_map" => "Linear map a la Strider (-L)",
	"translation" => "Linear co-translation  (-t,-T)",
	"translation_frames" => "Translation in how many frames",
	"three_letter" => "Translation in 3-letter code (-T)",
	"orf_options" => "Open Reading Frames",
	"orf" => "Do an ORF analysis",
	"frame" => "Frames to search",
	"min_size" => "Min ORF size",
	"pattern_search_options" => "Pattern Search",
	"pattern_search" => "Do a pattern search (-p)",
	"pattern" => "Pattern (<30 IUPAC character)",
	"errors" => "Max number of errors that are tolerated (<6) (-p)",
	"name" => "Label of pattern",
	"proximity_options" => "Search for spatial relationships between factors (-P)",
	"proximity" => "Do a proximity search",
	"distance" => "Distance between factors",
	"nameA" => "Name of first factor (nameA)",
	"nameB" => "Name of second factor (nameB)",
	"quiet" => "",

    };

    $self->{ISSTANDOUT}  = {
	"tacg" => 0,
	"sequence" => 0,
	"input_options" => 0,
	"beginning" => 0,
	"end" => 0,
	"topology" => 0,
	"degeneracy" => 0,
	"codon" => 0,
	"output_options" => 0,
	"order_by_cut" => 0,
	"width" => 0,
	"graphic" => 0,
	"binsize" => 0,
	"selection_options" => 0,
	"enzymes" => 0,
	"max_cut" => 0,
	"min_cut" => 0,
	"magnitude" => 0,
	"overhang" => 0,
	"analyses" => 0,
	"summary" => 0,
	"print_fragments" => 0,
	"sites" => 0,
	"ladder_map" => 0,
	"gel_map" => 0,
	"cutoff" => 0,
	"linear_map_options" => 0,
	"linear_map" => 0,
	"translation" => 0,
	"translation_frames" => 0,
	"three_letter" => 0,
	"orf_options" => 0,
	"orf" => 0,
	"frame" => 0,
	"min_size" => 0,
	"pattern_search_options" => 0,
	"pattern_search" => 0,
	"pattern" => 0,
	"errors" => 0,
	"name" => 0,
	"proximity_options" => 0,
	"proximity" => 0,
	"distance" => 0,
	"nameA" => 0,
	"nameB" => 0,
	"quiet" => 0,

    };

    $self->{VLIST}  = {

	"input_options" => ['beginning','end','topology','degeneracy','codon',],
	"topology" => ['0','0: circular','1','1: linear',],
	"degeneracy" => ['0','0: FORCES excl\'n of degens in seq; only \'acgtu\' accepted','1','1: cut as NONdegen unless degen\'s found; then cut as \'-D3\'','2','2: degen\'s OK; ignore in KEY, but match outside of KEY','3','3: degen\'s OK; expand in KEY, find only EXACT matches','4','4: degen\'s OK; expand in KEY, find ALL POSSIBLE matches',],
	"codon" => ['0','0: Universal','1','1: Mito_Vertebrates','2','2: Mito_Drosophila','3','3: Mito_S_Cervisiae','4','4: Mito_S_Pombe','5','5: Mito_N_crassa','6','6: Mito_Higher_Plants','7','7: Ciliates',],
	"output_options" => ['order_by_cut','width','graphic','binsize',],
	"graphic" => ['X','X: horizontal X axis','Y','Y: vertical X axis','Z','Z: long output',],
	"selection_options" => ['enzymes','max_cut','min_cut','magnitude','overhang',],
	"magnitude" => ['3','3','4','4','5','5','6','6','7','7','8','8',],
	"overhang" => ['5','5: 5\' overhang','3','3: 3\'','0','0: blunt (no overhang)','1','1: all',],
	"analyses" => ['summary','print_fragments','sites','ladder_map','gel_map','cutoff','linear_map_options','orf_options','pattern_search_options',],
	"print_fragments" => ['0','0: don\'t print fragments','1','1: by sites','2','2: sorted by sizes','3','3: both',],
	"linear_map_options" => ['linear_map','translation','translation_frames','three_letter',],
	"translation_frames" => ['1','1 frame','3','3 frames','6','6 frames',],
	"orf_options" => ['orf','frame','min_size',],
	"frame" => ['1','1','2','2','3','3','4','4','5','5','6','6',],
	"pattern_search_options" => ['pattern_search','pattern','errors','name','proximity_options',],
	"proximity_options" => ['proximity','distance','nameA','nameB',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"frame" => "'",

    };

    $self->{VDEF}  = {
	"topology" => '1',
	"degeneracy" => '1',
	"codon" => '0',
	"order_by_cut" => '0',
	"width" => '60',
	"magnitude" => '3',
	"overhang" => '1',
	"summary" => '1',
	"print_fragments" => '0',
	"sites" => '0',
	"translation_frames" => '1',
	"three_letter" => '0',
	"frame" => ['1',],
	"errors" => '0',
	"name" => 'pattern1',

    };

    $self->{PRECOND}  = {
	"tacg" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"input_options" => { "perl" => '1' },
	"beginning" => { "perl" => '1' },
	"end" => { "perl" => '1' },
	"topology" => { "perl" => '1' },
	"degeneracy" => { "perl" => '1' },
	"codon" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"order_by_cut" => {
		"perl" => '$print_fragments || $sites || $ladder_map || $gel_map',
	},
	"width" => { "perl" => '1' },
	"graphic" => { "perl" => '1' },
	"binsize" => {
		"perl" => '$graphic',
	},
	"selection_options" => { "perl" => '1' },
	"enzymes" => { "perl" => '1' },
	"max_cut" => { "perl" => '1' },
	"min_cut" => { "perl" => '1' },
	"magnitude" => { "perl" => '1' },
	"overhang" => { "perl" => '1' },
	"analyses" => { "perl" => '1' },
	"summary" => { "perl" => '1' },
	"print_fragments" => { "perl" => '1' },
	"sites" => { "perl" => '1' },
	"ladder_map" => { "perl" => '1' },
	"gel_map" => { "perl" => '1' },
	"cutoff" => {
		"perl" => '$gel_map',
	},
	"linear_map_options" => { "perl" => '1' },
	"linear_map" => { "perl" => '1' },
	"translation" => {
		"perl" => '$linear_map',
	},
	"translation_frames" => {
		"perl" => '$translation',
	},
	"three_letter" => {
		"perl" => '$translation',
	},
	"orf_options" => { "perl" => '1' },
	"orf" => { "perl" => '1' },
	"frame" => {
		"perl" => '$orf',
	},
	"min_size" => {
		"perl" => '$orf',
	},
	"pattern_search_options" => { "perl" => '1' },
	"pattern_search" => { "perl" => '1' },
	"pattern" => {
		"perl" => '$pattern_search',
	},
	"errors" => {
		"perl" => '$pattern_search',
	},
	"name" => {
		"perl" => '$pattern_search',
	},
	"proximity_options" => { "perl" => '1' },
	"proximity" => { "perl" => '1' },
	"distance" => {
		"perl" => '$proximity',
	},
	"nameA" => {
		"perl" => '$proximity',
	},
	"nameB" => {
		"perl" => '$proximity',
	},
	"quiet" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"translation" => {
		"perl" => {
			'$three_letter && ($trans_flag="-T") && 0' => "no message 1",
			'! $three_letter && ($trans_flag="-t") && 0' => "no message 2",
		},
	},
	"orf" => {
		"perl" => {
			'($frame=~ s/\\s//g) && 0' => "no message",
		},
	},

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
	"tacg" => 0,
	"sequence" => 0,
	"input_options" => 0,
	"beginning" => 0,
	"end" => 0,
	"topology" => 0,
	"degeneracy" => 0,
	"codon" => 0,
	"output_options" => 0,
	"order_by_cut" => 0,
	"width" => 0,
	"graphic" => 0,
	"binsize" => 0,
	"selection_options" => 0,
	"enzymes" => 0,
	"max_cut" => 0,
	"min_cut" => 0,
	"magnitude" => 0,
	"overhang" => 0,
	"analyses" => 0,
	"summary" => 0,
	"print_fragments" => 0,
	"sites" => 0,
	"ladder_map" => 0,
	"gel_map" => 0,
	"cutoff" => 0,
	"linear_map_options" => 0,
	"linear_map" => 0,
	"translation" => 0,
	"translation_frames" => 0,
	"three_letter" => 0,
	"orf_options" => 0,
	"orf" => 0,
	"frame" => 0,
	"min_size" => 0,
	"pattern_search_options" => 0,
	"pattern_search" => 0,
	"pattern" => 0,
	"errors" => 0,
	"name" => 0,
	"proximity_options" => 0,
	"proximity" => 0,
	"distance" => 0,
	"nameA" => 0,
	"nameB" => 0,
	"quiet" => 0,

    };

    $self->{ISSIMPLE}  = {
	"tacg" => 1,
	"sequence" => 1,
	"input_options" => 0,
	"beginning" => 0,
	"end" => 0,
	"topology" => 0,
	"degeneracy" => 0,
	"codon" => 0,
	"output_options" => 0,
	"order_by_cut" => 0,
	"width" => 0,
	"graphic" => 0,
	"binsize" => 0,
	"selection_options" => 0,
	"enzymes" => 0,
	"max_cut" => 0,
	"min_cut" => 0,
	"magnitude" => 0,
	"overhang" => 0,
	"analyses" => 0,
	"summary" => 0,
	"print_fragments" => 0,
	"sites" => 0,
	"ladder_map" => 0,
	"gel_map" => 0,
	"cutoff" => 0,
	"linear_map_options" => 0,
	"linear_map" => 0,
	"translation" => 0,
	"translation_frames" => 0,
	"three_letter" => 0,
	"orf_options" => 0,
	"orf" => 0,
	"frame" => 0,
	"min_size" => 0,
	"pattern_search_options" => 0,
	"pattern_search" => 0,
	"pattern" => 0,
	"errors" => 0,
	"name" => 0,
	"proximity_options" => 0,
	"proximity" => 0,
	"distance" => 0,
	"nameA" => 0,
	"nameB" => 0,
	"quiet" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"magnitude" => [
		"The \'magnitude\' of the recognition sequence depends on the number of defined bases that make up the site. Degenerate bases can also contribute:",
		"acgt each count \'1\' magnitude point",
		"yrwsmk each count \'1/2\' magnitude point",
		"bdhu each count \'1/4\' magnitude point",
		"n doesn\'t count at all",
		"Those enzymes sequences\' patterns that \'sum\' to the equivalent of at least the given magnitude pass the test",
		"Examples: tgca=4, tgyrca=5, tgcnnngca=6, etc...",
		"The values are upwardly inclusive (5=5,6,7,8 6=6,7,8 ...)",
	],
	"cutoff" => [
		"You can cut off any size in 10^n increments (as you might want to cut off very large fragments if you were doing chromosomal digests).",
	],
	"distance" => [
		"Distance specification: [+-][lg]Dist_Lo[-Dist_Hi",
		"+ NameA is DOWNSTREAM of NameB (default is either)",
		"- NameA is UPSTREAM of NameB (ditto)",
		"l NameA is LESS THAN Dist_Lo from NameB (default)",
		"g NameA is GREATER THAN Dist_Lo from NameB",
		"examples:",
		"HindIII,350,bamhi: Matches HindIII sites within 350 bp of BamHI sites",
		"Pit1,-30-2500,Tataa: Match Pit1 sites 30 to 2500 bp UPSTREAM of a Tataa site",
	],
	"nameA" => [
		"NameA and NameB must be enzymes names (Rebase db)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/tacg.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

