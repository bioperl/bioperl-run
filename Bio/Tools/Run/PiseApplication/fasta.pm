# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::fasta
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::fasta

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fasta

      Bioperl class for:

	FASTA	Sequence database search (version 3) (W. Pearson)

	References:

		Pearson, W. R. (1999) Flexible sequence similarity searching with the FASTA3 program package. Methods in Molecular Biology

		W. R. Pearson and D. J. Lipman (1988), Improved Tools for Biological Sequence Analysis, PNAS 85:2444-2448

		 W. R. Pearson (1998) Empirical statistical estimates for sequence similarity searches. In J. Mol. Biol. 276:71-84

		Pearson, W. R. (1996) Effective protein sequence comparison. In Meth. Enz., R. F. Doolittle, ed. (San Diego: Academic Press) 266:227-258



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/fasta.html 
         for available values):


		fasta (Excl)
			Fasta program

		query (Sequence)
			Query sequence File
			pipe: seqfile

		seqtype (Excl)
			Is it a DNA or protein sequence (-n)

		protein_db (Excl)
			Protein Database

		nucleotid_db (Excl)
			Nucleotid Database

		break_long (Integer)
			Break long library sequences into blocks (-N)

		ktup (Integer)
			ktup : sensitivity and speed of the search (protein:2, DNA:6)

		optcut (Integer)
			OPTCUT : the threshold for optimization. (-c)

		gapinit (Integer)
			Penalty for gap initiation (-12 by default for fasta with proteins, -16 for DNA) (-f)

		gapext (Integer)
			Penalty for gap extention (-2 by default for fasta with proteins, -4 for DNA) (-g)

		high_expect (Float)
			Maximal expectation value threshold for displaying scores and alignments (-E)

		low_expect (Float)
			Minimal expectation value threshold for displaying scores and alignments (-F)

		nucleotid_match (Integer)
			Reward for a nucleotid match (-r)

		nucleotid_mismatch (Integer)
			Penalty for a nucleotid mismatch (-r)

		matrix (Excl)
			Scoring matrix file (-s)

		X_penalty (Integer)
			Penalty for a match to 'X' (independently of the PAM matrix) (-x)

		frameshift (Integer)
			Penalty for frameshift between codon (fast[xy]/tfast[xy])(-h)

		frameshift_within (Integer)
			Penalty for frameshift within a codon (fasty/tfasty)(-j)

		threeframe (Switch)
			Search only the three forward frames (tfasta) (-3)

		invert (Switch)
			Reverse complement the query sequence (all tfasta) (-i)

		genetic_code (Excl)
			Use genetic code for translation (tfasta/tfast[xy]/fast[xy]) (-t)

		band (Integer)
			band-width used for optimization (-y)

		swalig (Switch)
			unlimited Smith-Waterman alignment for DNA (-A)

		noopt (Switch)
			no limited optimization (-o)

		stat (Excl)
			Specify statistical calculation. (-z)

		random (Switch)
			Estimate stat parameters from shuffled copies of each library sequence (-z)

		histogram (Switch)
			No histogram (-H)

		scores (Integer)
			number of similarity scores to be shown (-b)

		alns (Integer)
			number of alignments to be shown (-d)

		html_output (Switch)
			HTML output (-m)

		markx (Excl)
			Alternate display of matches and mismatches in alignments

		init1 (Switch)
			sequences ranked by the z-score based on the init1 score (-1)

		z_score_out (Excl)
			Show normalize score as (-B)

		showall (Switch)
			both sequences are shown in their entirety in alignments (fasta only) (-a)

		linlen (Integer)
			output line length for sequence alignments (max. 200) (-w)

		offsets (String)
			Start numbering the aligned sequences at position x1 x2 (2 numbers) (-X)

		info (Switch)
			Display more information about the library sequence in the alignment (-L)

		statfile (OutFile)
			Write out the sequence identifier, superfamily number, and similarity scores to this file (-R)

		filter (Switch)
			Lower case filtering (-S)

		outfile (OutFile)
			pipe: mview_input

		html_outfile (OutFile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/fasta.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::fasta;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fasta = Bio::Tools::Run::PiseApplication::fasta->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fasta object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $fasta = $factory->program('fasta');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::fasta.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fasta.pm

    $self->{COMMAND}   = "fasta";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FASTA";

    $self->{DESCRIPTION}   = "Sequence database search (version 3)";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "W. Pearson";

    $self->{REFERENCE}   = [

         "Pearson, W. R. (1999) Flexible sequence similarity searching with the FASTA3 program package. Methods in Molecular Biology",

         "W. R. Pearson and D. J. Lipman (1988), Improved Tools for Biological Sequence Analysis, PNAS 85:2444-2448",

         " W. R. Pearson (1998) Empirical statistical estimates for sequence similarity searches. In J. Mol. Biol. 276:71-84",

         "Pearson, W. R. (1996) Effective protein sequence comparison. In Meth. Enz., R. F. Doolittle, ed. (San Diego: Academic Press) 266:227-258",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fasta",
	"query",
	"seqtype",
	"protein_db",
	"nucleotid_db",
	"break_long",
	"slectivity_opt",
	"score_opt",
	"frame_transl_opt",
	"optimize_opt",
	"affichage",
	"other_opt",
	"outfile",
	"html_outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fasta", 	# Fasta program
	"query", 	# Query sequence File
	"seqtype", 	# Is it a DNA or protein sequence (-n)
	"protein_db", 	# Protein Database
	"nucleotid_db", 	# Nucleotid Database
	"break_long", 	# Break long library sequences into blocks (-N)
	"slectivity_opt", 	# Selectivity options
	"ktup", 	# ktup : sensitivity and speed of the search (protein:2, DNA:6)
	"optcut", 	# OPTCUT : the threshold for optimization. (-c)
	"gapinit", 	# Penalty for gap initiation (-12 by default for fasta with proteins, -16 for DNA) (-f)
	"gapext", 	# Penalty for gap extention (-2 by default for fasta with proteins, -4 for DNA) (-g)
	"high_expect", 	# Maximal expectation value threshold for displaying scores and alignments (-E)
	"low_expect", 	# Minimal expectation value threshold for displaying scores and alignments (-F)
	"score_opt", 	# Scoring options
	"nucleotid_match", 	# Reward for a nucleotid match (-r)
	"nucleotid_mismatch", 	# Penalty for a nucleotid mismatch (-r)
	"matrix", 	# Scoring matrix file (-s)
	"X_penalty", 	# Penalty for a match to 'X' (independently of the PAM matrix) (-x)
	"frame_transl_opt", 	# Frameshift and translation options
	"frameshift", 	# Penalty for frameshift between codon (fast[xy]/tfast[xy])(-h)
	"frameshift_within", 	# Penalty for frameshift within a codon (fasty/tfasty)(-j)
	"threeframe", 	# Search only the three forward frames (tfasta) (-3)
	"invert", 	# Reverse complement the query sequence (all tfasta) (-i)
	"genetic_code", 	# Use genetic code for translation (tfasta/tfast[xy]/fast[xy]) (-t)
	"optimize_opt", 	# Optimization options
	"band", 	# band-width used for optimization (-y)
	"swalig", 	# unlimited Smith-Waterman alignment for DNA (-A)
	"noopt", 	# no limited optimization (-o)
	"stat", 	# Specify statistical calculation. (-z)
	"random", 	# Estimate stat parameters from shuffled copies of each library sequence (-z)
	"affichage", 	# Report options
	"histogram", 	# No histogram (-H)
	"scores", 	# number of similarity scores to be shown (-b)
	"alns", 	# number of alignments to be shown (-d)
	"html_output", 	# HTML output (-m)
	"markx", 	# Alternate display of matches and mismatches in alignments
	"init1", 	# sequences ranked by the z-score based on the init1 score (-1)
	"z_score_out", 	# Show normalize score as (-B)
	"showall", 	# both sequences are shown in their entirety in alignments (fasta only) (-a)
	"linlen", 	# output line length for sequence alignments (max. 200) (-w)
	"offsets", 	# Start numbering the aligned sequences at position x1 x2 (2 numbers) (-X)
	"info", 	# Display more information about the library sequence in the alignment (-L)
	"statfile", 	# Write out the sequence identifier, superfamily number, and similarity scores to this file (-R)
	"other_opt", 	# Other options
	"filter", 	# Lower case filtering (-S)
	"outfile",
	"html_outfile",

    ];

    $self->{TYPE}  = {
	"fasta" => 'Excl',
	"query" => 'Sequence',
	"seqtype" => 'Excl',
	"protein_db" => 'Excl',
	"nucleotid_db" => 'Excl',
	"break_long" => 'Integer',
	"slectivity_opt" => 'Paragraph',
	"ktup" => 'Integer',
	"optcut" => 'Integer',
	"gapinit" => 'Integer',
	"gapext" => 'Integer',
	"high_expect" => 'Float',
	"low_expect" => 'Float',
	"score_opt" => 'Paragraph',
	"nucleotid_match" => 'Integer',
	"nucleotid_mismatch" => 'Integer',
	"matrix" => 'Excl',
	"X_penalty" => 'Integer',
	"frame_transl_opt" => 'Paragraph',
	"frameshift" => 'Integer',
	"frameshift_within" => 'Integer',
	"threeframe" => 'Switch',
	"invert" => 'Switch',
	"genetic_code" => 'Excl',
	"optimize_opt" => 'Paragraph',
	"band" => 'Integer',
	"swalig" => 'Switch',
	"noopt" => 'Switch',
	"stat" => 'Excl',
	"random" => 'Switch',
	"affichage" => 'Paragraph',
	"histogram" => 'Switch',
	"scores" => 'Integer',
	"alns" => 'Integer',
	"html_output" => 'Switch',
	"markx" => 'Excl',
	"init1" => 'Switch',
	"z_score_out" => 'Excl',
	"showall" => 'Switch',
	"linlen" => 'Integer',
	"offsets" => 'String',
	"info" => 'Switch',
	"statfile" => 'OutFile',
	"other_opt" => 'Paragraph',
	"filter" => 'Switch',
	"outfile" => 'OutFile',
	"html_outfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"fasta" => {
		"perl" => '"$value -q"',
	},
	"query" => {
		"perl" => '" $value"',
	},
	"seqtype" => {
		"perl" => '(($fasta =~ /^fasta/ && $value eq "DNA") || $fasta =~ /^fast(x|y)/)? " -n":""',
	},
	"protein_db" => {
		"perl" => ' " /local/databases/fasta/$value"',
	},
	"nucleotid_db" => {
		"perl" => ' " /local/databases/fasta/$value"',
	},
	"break_long" => {
		"perl" => '(defined $value) ? " -N $value" : ""',
	},
	"slectivity_opt" => {
	},
	"ktup" => {
		"perl" => '(defined $value)? " $value":""',
	},
	"optcut" => {
		"perl" => '(defined $value)? " -c $value":""',
	},
	"gapinit" => {
		"perl" => '(defined $value)? " -f $value":""',
	},
	"gapext" => {
		"perl" => '(defined $value)? " -g $value":""',
	},
	"high_expect" => {
		"perl" => '(defined $value && $value != $vdef)? " -E $value":""',
	},
	"low_expect" => {
		"perl" => '(defined $value) ? " -F $value":""',
	},
	"score_opt" => {
	},
	"nucleotid_match" => {
	},
	"nucleotid_mismatch" => {
		"perl" => '(defined $value && ($value != $vdef || $dna_match != 5)) ? " -r \"$dna_match/$value\"" : ""',
	},
	"matrix" => {
		"perl" => ' ($value ne $vdef) ? " -s $value" : ""',
	},
	"X_penalty" => {
		"perl" => '(defined $value) ? " -x $value" : ""',
	},
	"frame_transl_opt" => {
	},
	"frameshift" => {
		"perl" => '(defined $value)? " -h $value":""',
	},
	"frameshift_within" => {
		"perl" => '(defined $value)? " -j $value":""',
	},
	"threeframe" => {
		"perl" => '($value) ? " -3":""',
	},
	"invert" => {
		"perl" => '($value) ? " -i" : ""',
	},
	"genetic_code" => {
		"perl" => '($value != $vdef) ? " -t $value" : ""',
	},
	"optimize_opt" => {
	},
	"band" => {
		"perl" => '(defined $value)? " -y $value":""',
	},
	"swalig" => {
		"perl" => '($value)? " -A":""',
	},
	"noopt" => {
		"perl" => '($value)? " -o":""',
	},
	"stat" => {
		"perl" => '($random && $value > 0) ? " -z 1$value"		: ($value != $vdef) ? " -z $value" : ""',
	},
	"random" => {
	},
	"affichage" => {
	},
	"histogram" => {
		"perl" => '($value)? " -H":""',
	},
	"scores" => {
		"perl" => '(defined $value)? " -b $value":""',
	},
	"alns" => {
		"perl" => '(defined $value)? " -d $value":""',
	},
	"html_output" => {
		"perl" => '($value)? " -m 6" : "" ',
	},
	"markx" => {
		"perl" => ' ($value && $value != $vdef )? " -m $value" : "" ',
	},
	"init1" => {
		"perl" => '($value)? " -1":""',
	},
	"z_score_out" => {
		"perl" => '($value) ? " -B" : ""',
	},
	"showall" => {
		"perl" => '($value)? " -a":""',
	},
	"linlen" => {
		"perl" => '(defined $value && $value != $vdef)? " -w $value":""',
	},
	"offsets" => {
		"perl" => '($value)? " -X \"$value\"":""',
	},
	"info" => {
		"perl" => '($value)? " -L":""',
	},
	"statfile" => {
		"perl" => '($value)? " -R $value":""',
	},
	"other_opt" => {
	},
	"filter" => {
		"perl" => '($value) ? " -S" : ""',
	},
	"outfile" => {
	},
	"html_outfile" => {
		"perl" => '" > fasta.html"',
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'fasta.out',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"fasta" => 0,
	"query" => 2,
	"seqtype" => 1,
	"protein_db" => 3,
	"nucleotid_db" => 3,
	"slectivity_opt" => 1,
	"ktup" => 4,
	"optcut" => 1,
	"gapinit" => 1,
	"gapext" => 1,
	"high_expect" => 1,
	"low_expect" => 1,
	"score_opt" => 1,
	"nucleotid_match" => 1,
	"nucleotid_mismatch" => 1,
	"matrix" => 1,
	"X_penalty" => 1,
	"frame_transl_opt" => 1,
	"frameshift" => 1,
	"frameshift_within" => 1,
	"threeframe" => 1,
	"invert" => 1,
	"genetic_code" => 1,
	"optimize_opt" => 1,
	"band" => 1,
	"swalig" => 1,
	"noopt" => 1,
	"stat" => 1,
	"random" => 1,
	"affichage" => 1,
	"histogram" => 1,
	"scores" => 1,
	"alns" => 1,
	"html_output" => 1,
	"markx" => 1,
	"init1" => 1,
	"z_score_out" => 1,
	"showall" => 1,
	"linlen" => 1,
	"offsets" => 1,
	"info" => 1,
	"statfile" => 1,
	"other_opt" => 1,
	"filter" => 1,
	"outfile" => 100,
	"html_outfile" => 100,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"fasta",
	"break_long",
	"info",
	"seqtype",
	"statfile",
	"other_opt",
	"slectivity_opt",
	"filter",
	"optcut",
	"gapinit",
	"gapext",
	"high_expect",
	"low_expect",
	"score_opt",
	"nucleotid_match",
	"nucleotid_mismatch",
	"matrix",
	"X_penalty",
	"frame_transl_opt",
	"frameshift",
	"frameshift_within",
	"threeframe",
	"invert",
	"genetic_code",
	"optimize_opt",
	"band",
	"swalig",
	"noopt",
	"stat",
	"random",
	"affichage",
	"histogram",
	"scores",
	"alns",
	"html_output",
	"markx",
	"init1",
	"z_score_out",
	"showall",
	"linlen",
	"offsets",
	"query",
	"protein_db",
	"nucleotid_db",
	"ktup",
	"outfile",
	"html_outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"fasta" => 0,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"break_long" => 0,
	"slectivity_opt" => 0,
	"ktup" => 0,
	"optcut" => 0,
	"gapinit" => 0,
	"gapext" => 0,
	"high_expect" => 0,
	"low_expect" => 0,
	"score_opt" => 0,
	"nucleotid_match" => 0,
	"nucleotid_mismatch" => 0,
	"matrix" => 0,
	"X_penalty" => 0,
	"frame_transl_opt" => 0,
	"frameshift" => 0,
	"frameshift_within" => 0,
	"threeframe" => 0,
	"invert" => 0,
	"genetic_code" => 0,
	"optimize_opt" => 0,
	"band" => 0,
	"swalig" => 0,
	"noopt" => 0,
	"stat" => 0,
	"random" => 0,
	"affichage" => 0,
	"histogram" => 0,
	"scores" => 0,
	"alns" => 0,
	"html_output" => 0,
	"markx" => 0,
	"init1" => 0,
	"z_score_out" => 0,
	"showall" => 0,
	"linlen" => 0,
	"offsets" => 0,
	"info" => 0,
	"statfile" => 0,
	"other_opt" => 0,
	"filter" => 0,
	"outfile" => 1,
	"html_outfile" => 1,

    };

    $self->{ISCOMMAND}  = {
	"fasta" => 1,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"break_long" => 0,
	"slectivity_opt" => 0,
	"ktup" => 0,
	"optcut" => 0,
	"gapinit" => 0,
	"gapext" => 0,
	"high_expect" => 0,
	"low_expect" => 0,
	"score_opt" => 0,
	"nucleotid_match" => 0,
	"nucleotid_mismatch" => 0,
	"matrix" => 0,
	"X_penalty" => 0,
	"frame_transl_opt" => 0,
	"frameshift" => 0,
	"frameshift_within" => 0,
	"threeframe" => 0,
	"invert" => 0,
	"genetic_code" => 0,
	"optimize_opt" => 0,
	"band" => 0,
	"swalig" => 0,
	"noopt" => 0,
	"stat" => 0,
	"random" => 0,
	"affichage" => 0,
	"histogram" => 0,
	"scores" => 0,
	"alns" => 0,
	"html_output" => 0,
	"markx" => 0,
	"init1" => 0,
	"z_score_out" => 0,
	"showall" => 0,
	"linlen" => 0,
	"offsets" => 0,
	"info" => 0,
	"statfile" => 0,
	"other_opt" => 0,
	"filter" => 0,
	"outfile" => 0,
	"html_outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"fasta" => 1,
	"query" => 1,
	"seqtype" => 1,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"break_long" => 0,
	"slectivity_opt" => 0,
	"ktup" => 0,
	"optcut" => 0,
	"gapinit" => 0,
	"gapext" => 0,
	"high_expect" => 0,
	"low_expect" => 0,
	"score_opt" => 0,
	"nucleotid_match" => 0,
	"nucleotid_mismatch" => 0,
	"matrix" => 0,
	"X_penalty" => 0,
	"frame_transl_opt" => 0,
	"frameshift" => 0,
	"frameshift_within" => 0,
	"threeframe" => 0,
	"invert" => 0,
	"genetic_code" => 0,
	"optimize_opt" => 0,
	"band" => 0,
	"swalig" => 0,
	"noopt" => 0,
	"stat" => 0,
	"random" => 0,
	"affichage" => 0,
	"histogram" => 0,
	"scores" => 0,
	"alns" => 0,
	"html_output" => 0,
	"markx" => 0,
	"init1" => 0,
	"z_score_out" => 0,
	"showall" => 0,
	"linlen" => 0,
	"offsets" => 0,
	"info" => 0,
	"statfile" => 0,
	"other_opt" => 0,
	"filter" => 0,
	"outfile" => 0,
	"html_outfile" => 0,

    };

    $self->{PROMPT}  = {
	"fasta" => "Fasta program",
	"query" => "Query sequence File",
	"seqtype" => "Is it a DNA or protein sequence (-n)",
	"protein_db" => "Protein Database",
	"nucleotid_db" => "Nucleotid Database",
	"break_long" => "Break long library sequences into blocks (-N)",
	"slectivity_opt" => "Selectivity options",
	"ktup" => "ktup : sensitivity and speed of the search (protein:2, DNA:6)",
	"optcut" => "OPTCUT : the threshold for optimization. (-c)",
	"gapinit" => "Penalty for gap initiation (-12 by default for fasta with proteins, -16 for DNA) (-f)",
	"gapext" => "Penalty for gap extention (-2 by default for fasta with proteins, -4 for DNA) (-g)",
	"high_expect" => "Maximal expectation value threshold for displaying scores and alignments (-E)",
	"low_expect" => "Minimal expectation value threshold for displaying scores and alignments (-F)",
	"score_opt" => "Scoring options",
	"nucleotid_match" => "Reward for a nucleotid match (-r)",
	"nucleotid_mismatch" => "Penalty for a nucleotid mismatch (-r)",
	"matrix" => "Scoring matrix file (-s)",
	"X_penalty" => "Penalty for a match to 'X' (independently of the PAM matrix) (-x)",
	"frame_transl_opt" => "Frameshift and translation options",
	"frameshift" => "Penalty for frameshift between codon (fast[xy]/tfast[xy])(-h)",
	"frameshift_within" => "Penalty for frameshift within a codon (fasty/tfasty)(-j)",
	"threeframe" => "Search only the three forward frames (tfasta) (-3)",
	"invert" => "Reverse complement the query sequence (all tfasta) (-i)",
	"genetic_code" => "Use genetic code for translation (tfasta/tfast[xy]/fast[xy]) (-t)",
	"optimize_opt" => "Optimization options",
	"band" => "band-width used for optimization (-y)",
	"swalig" => "unlimited Smith-Waterman alignment for DNA (-A)",
	"noopt" => "no limited optimization (-o)",
	"stat" => "Specify statistical calculation. (-z)",
	"random" => "Estimate stat parameters from shuffled copies of each library sequence (-z)",
	"affichage" => "Report options",
	"histogram" => "No histogram (-H)",
	"scores" => "number of similarity scores to be shown (-b)",
	"alns" => "number of alignments to be shown (-d)",
	"html_output" => "HTML output (-m)",
	"markx" => "Alternate display of matches and mismatches in alignments",
	"init1" => "sequences ranked by the z-score based on the init1 score (-1)",
	"z_score_out" => "Show normalize score as (-B)",
	"showall" => "both sequences are shown in their entirety in alignments (fasta only) (-a)",
	"linlen" => "output line length for sequence alignments (max. 200) (-w)",
	"offsets" => "Start numbering the aligned sequences at position x1 x2 (2 numbers) (-X)",
	"info" => "Display more information about the library sequence in the alignment (-L)",
	"statfile" => "Write out the sequence identifier, superfamily number, and similarity scores to this file (-R)",
	"other_opt" => "Other options",
	"filter" => "Lower case filtering (-S)",
	"outfile" => "",
	"html_outfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"fasta" => 0,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"break_long" => 0,
	"slectivity_opt" => 0,
	"ktup" => 0,
	"optcut" => 0,
	"gapinit" => 0,
	"gapext" => 0,
	"high_expect" => 0,
	"low_expect" => 0,
	"score_opt" => 0,
	"nucleotid_match" => 0,
	"nucleotid_mismatch" => 0,
	"matrix" => 0,
	"X_penalty" => 0,
	"frame_transl_opt" => 0,
	"frameshift" => 0,
	"frameshift_within" => 0,
	"threeframe" => 0,
	"invert" => 0,
	"genetic_code" => 0,
	"optimize_opt" => 0,
	"band" => 0,
	"swalig" => 0,
	"noopt" => 0,
	"stat" => 0,
	"random" => 0,
	"affichage" => 0,
	"histogram" => 0,
	"scores" => 0,
	"alns" => 0,
	"html_output" => 0,
	"markx" => 0,
	"init1" => 0,
	"z_score_out" => 0,
	"showall" => 0,
	"linlen" => 0,
	"offsets" => 0,
	"info" => 0,
	"statfile" => 0,
	"other_opt" => 0,
	"filter" => 0,
	"outfile" => 1,
	"html_outfile" => 1,

    };

    $self->{VLIST}  = {

	"fasta" => ['fasta_t','fasta: protein or DNA query vs similar db (FASTA release 3.0)','tfasta_t','tfasta: protein query vs translated DNA db','fastx_t','fastx: DNA query (translated, 3 frames) vs protein db (frameshifts only between codons) ','tfastx_t','tfastx: protein query vs translated DNA db (frameshifts only between codons)','fasty_t','fasty = fastx + frameshifts anywhere','tfasty_t','tfasty = tfastx + frameshifts anywhere','fastf_t','fastf: mixed peptide seq vs protein db (modified algorithm)','tfastf_t','tfastf: mixed peptide seq vs translated DNA db (modified algorithm)','fasts_t','fasts: several short peptide seq vs protein db (modified algorithm)','tfasts_t','tfasts: several short peptide seq vs translated DNA db (modified algorithm)',],
	"seqtype" => ['DNA','DNA','protein','protein',],
	"protein_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','sbase','sbase: annotated domains sequences',],
	"nucleotid_db" => ['embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"slectivity_opt" => ['ktup','optcut','gapinit','gapext','high_expect','low_expect',],
	"score_opt" => ['nucleotid_match','nucleotid_mismatch','matrix','X_penalty',],
	"matrix" => ['BL50','BLOSUM50','BL62','BLOSUM62','BL80','BLOSUM80','P20','PAM20','P40','PAM40','P120','PAM120','P250','PAM250','M10','MDM_10','M20','MDM_20','M40','MDM_40',],
	"frame_transl_opt" => ['frameshift','frameshift_within','threeframe','invert','genetic_code',],
	"genetic_code" => ['1','1: Standard','2','2: Vertebrate Mitochondrial','3','3: Yeast Mitochondrial','4','4: Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','5: Invertebrate Mitochondrial','6','6: Ciliate Macronuclear and Dasycladacean','9','9: Echinoderm Mitochondrial','10','10: Euplotid Nuclear','11','11: Bacterial','12','12: Alternative Yeast Nuclear','13','13: Ascidian Mitochondrial','14','14: Flatworm Mitochondrial','15','15: Blepharisma Macronuclear',],
	"optimize_opt" => ['band','swalig','noopt','stat','random',],
	"stat" => ['-1','-1: turn off statistics','0',' 0: no correction of library sequebce length','1',' 1: weigthed regression against the length of the library sequence','2',' 2: maximum likelihood estimates of Lambda abd K','3',' 3: Altschul-Gish parameters','4',' 4: Variation1 of 1','5',' 5: Variation2 of 1',],
	"affichage" => ['histogram','scores','alns','html_output','markx','init1','z_score_out','showall','linlen','offsets','info','statfile',],
	"markx" => ['0','0 [: identities] [. conservative repl] [ non-conserv repl]','1','1: [ identities] [x conservative repl] [X non-conserv repl]','2','2: [. identities] [res mismatch] - don\'t display the 2nd seq','3','3: writes a file of library sequences in FASTA format','4','4: displays a graph of the alignment','9','9: 0 + percent identity + coordinates','10','10: output more information',],
	"z_score_out" => ['1','z-score','0','bit-score',],
	"other_opt" => ['filter',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"fasta" => 'fasta_t',
	"protein_db" => 'sptrnrdb',
	"nucleotid_db" => 'embl',
	"high_expect" => '10.0',
	"nucleotid_match" => '+5',
	"nucleotid_mismatch" => '-4',
	"matrix" => 'BL50',
	"genetic_code" => '1',
	"stat" => '1',
	"random" => '0',
	"html_output" => '0',
	"markx" => '0',
	"z_score_out" => '0',
	"linlen" => '60',
	"filter" => '0',
	"html_outfile" => '"fasta.html"',

    };

    $self->{PRECOND}  = {
	"fasta" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"seqtype" => { "perl" => '1' },
	"protein_db" => {
		"perl" => '($seqtype eq "protein" && $fasta =~ /^fasta/) || $fasta =~ /^fast(x|y|s|f)/',
	},
	"nucleotid_db" => {
		"perl" => ' ($seqtype eq "DNA" && $fasta =~ /^fasta/ ) || $fasta =~ /^tfast/ ',
	},
	"break_long" => { "perl" => '1' },
	"slectivity_opt" => { "perl" => '1' },
	"ktup" => { "perl" => '1' },
	"optcut" => { "perl" => '1' },
	"gapinit" => { "perl" => '1' },
	"gapext" => { "perl" => '1' },
	"high_expect" => { "perl" => '1' },
	"low_expect" => { "perl" => '1' },
	"score_opt" => { "perl" => '1' },
	"nucleotid_match" => { "perl" => '1' },
	"nucleotid_mismatch" => {
		"perl" => 'defined $dna_match',
	},
	"matrix" => { "perl" => '1' },
	"X_penalty" => { "perl" => '1' },
	"frame_transl_opt" => { "perl" => '1' },
	"frameshift" => {
		"perl" => ' ($fasta =~ /fast(x|y)/) ',
	},
	"frameshift_within" => {
		"perl" => ' ($fasta =~ /fasty/) ',
	},
	"threeframe" => {
		"perl" => '$fasta =~ /^tfasta/',
	},
	"invert" => {
		"perl" => '$fasta =~ /^tfasta/',
	},
	"genetic_code" => {
		"perl" => '$fasta =~ /^tfast/ || $fasta =~ /fast[xy]/',
	},
	"optimize_opt" => { "perl" => '1' },
	"band" => { "perl" => '1' },
	"swalig" => { "perl" => '1' },
	"noopt" => { "perl" => '1' },
	"stat" => { "perl" => '1' },
	"random" => {
		" 0" => '',
	},
	"affichage" => { "perl" => '1' },
	"histogram" => { "perl" => '1' },
	"scores" => { "perl" => '1' },
	"alns" => { "perl" => '1' },
	"html_output" => { "perl" => '1' },
	"markx" => {
		"perl" => '! $html_output',
	},
	"init1" => { "perl" => '1' },
	"z_score_out" => { "perl" => '1' },
	"showall" => { "perl" => '1' },
	"linlen" => { "perl" => '1' },
	"offsets" => { "perl" => '1' },
	"info" => { "perl" => '1' },
	"statfile" => { "perl" => '1' },
	"other_opt" => { "perl" => '1' },
	"filter" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"html_outfile" => {
		"perl" => '$html_output',
	},

    };

    $self->{CTRL}  = {
	"seqtype" => {
		"perl" => {
			'$fasta =~ /^fast(f|s)/ && $seqtype eq "DNA"' => "fastf and fasts take a protein sequence ",
			'$fasta =~ /^tfast/ && $seqtype eq "DNA"' => "tfasta, tfastx, tfasty, tfastf and tfasts take a protein sequence",
			'$fasta =~ /^fast(x|y)/ && $seqtype eq "protein"' => "fastx and fasty take a DNA sequence ",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "mview_input",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"query" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"fasta" => 0,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"break_long" => 0,
	"slectivity_opt" => 0,
	"ktup" => 0,
	"optcut" => 0,
	"gapinit" => 0,
	"gapext" => 0,
	"high_expect" => 0,
	"low_expect" => 0,
	"score_opt" => 0,
	"nucleotid_match" => 0,
	"nucleotid_mismatch" => 0,
	"matrix" => 0,
	"X_penalty" => 0,
	"frame_transl_opt" => 0,
	"frameshift" => 0,
	"frameshift_within" => 0,
	"threeframe" => 0,
	"invert" => 0,
	"genetic_code" => 0,
	"optimize_opt" => 0,
	"band" => 0,
	"swalig" => 0,
	"noopt" => 0,
	"stat" => 0,
	"random" => 0,
	"affichage" => 0,
	"histogram" => 0,
	"scores" => 0,
	"alns" => 0,
	"html_output" => 0,
	"markx" => 0,
	"init1" => 0,
	"z_score_out" => 0,
	"showall" => 0,
	"linlen" => 0,
	"offsets" => 0,
	"info" => 0,
	"statfile" => 0,
	"other_opt" => 0,
	"filter" => 0,
	"outfile" => 0,
	"html_outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"fasta" => 0,
	"query" => 1,
	"seqtype" => 1,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"break_long" => 0,
	"slectivity_opt" => 0,
	"ktup" => 0,
	"optcut" => 0,
	"gapinit" => 0,
	"gapext" => 0,
	"high_expect" => 0,
	"low_expect" => 0,
	"score_opt" => 0,
	"nucleotid_match" => 0,
	"nucleotid_mismatch" => 0,
	"matrix" => 0,
	"X_penalty" => 0,
	"frame_transl_opt" => 0,
	"frameshift" => 0,
	"frameshift_within" => 0,
	"threeframe" => 0,
	"invert" => 0,
	"genetic_code" => 0,
	"optimize_opt" => 0,
	"band" => 0,
	"swalig" => 0,
	"noopt" => 0,
	"stat" => 0,
	"random" => 0,
	"affichage" => 0,
	"histogram" => 0,
	"scores" => 0,
	"alns" => 0,
	"html_output" => 1,
	"markx" => 0,
	"init1" => 0,
	"z_score_out" => 0,
	"showall" => 0,
	"linlen" => 0,
	"offsets" => 0,
	"info" => 0,
	"statfile" => 0,
	"other_opt" => 0,
	"filter" => 0,
	"outfile" => 0,
	"html_outfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"fasta" => [
		". fasta - scan a protein or DNA sequence library for similar sequences",
		". tfasta - compare a protein sequence to a DNA sequence librarSy, translating the DNA sequence library `on-the-fly\' to the 3 forward and the 3 reverse frames without framshifts.",
		". fastx/fasty - compare a DNA sequence to a protein sequence database, comparing the translated DNA sequence in three frames, with frameshifts. fasty2 allows frameshifts inside codons.",
		". tfastx/tfasty - compare a protein sequence vs a translated DNA db, with frameshifts. tfasty allows frameshifts inside codons.",
		". fastf/tfastf - compare an ordered peptide mixture (obtained for example by Edman degradation of a CNBr cleavage) against a protein or translated DNA database.",
		". fasts/tfasts - compare a set of short peptide fragments (obtainded from a mass-spec analysis of a protein) against a protein or translated DNA database.",
	],
	"protein_db" => [
		"Please note that Swissprot usage by and for commercial entities requires a license agreement.",
	],
	"ktup" => [
		"ktup sets the sensitivity and speed of the search. If ktup=2, similar regions in the two sequences being compared are found by looking at pairs of aligned residues; if ktup=1, single aligned amino acids are examined. ktup can be set to 2 or 1 for protein sequences, or from 1 to 6 for DNA sequences. The default if ktup is not specified is 2 for proteins and 6 for DNA. 1ktup=1 should be used for oligonucleotides (DNA query length < 20).",
	],
	"optcut" => [
		"The OPTCUT value is normally calculated based on sequence length.",
	],
	"gapinit" => [
		"The default for fastx/fasty/tfastz/tfasty is -15.",
	],
	"gapext" => [
		"The default for fastx/fasty/tfastz/tfasty is -3.",
	],
	"high_expect" => [
		"Expectation value limit for displaying scores and alignments. Typically 10.0 for protein sequence comparisons; 5.0 for fastx, and 2.0 for DNA sequence comparisons.",
	],
	"low_expect" => [
		"This allow one to skip over close relationships in searches for more distant relationships.",
	],
	"nucleotid_mismatch" => [
		"\'+5/-4\' are the default values for nucleotid match/mismatch, but \'+3/-2\' can perform better in some cases.",
	],
	"X_penalty" => [
		"Particularly useful for fast[xy], where termination codons are encoded as \'X\'.",
	],
	"band" => [
		"Set the band-width used for optimization. -y 16 is the default for protein when ktup=2 and for all DNA alignments. -y 32 is used for protein and ktup=1. For proteins, optimization slows comparison 2-fold and is highly recommended.",
	],
	"swalig" => [
		"force Smith-Waterman alignment for output. Smith-Waterman is the default for protein sequences and FASTX, but not for TFASTA or DNA comparisons with FASTA.",
	],
	"noopt" => [
		"Turn off default optimization of all scores greater than OPTCUT. Shirt results by \'initn\' scores reduces the accuracy of statistical estimates.",
	],
	"stat" => [
		"In general, 1 and 2 are the best methods.",
	],
	"random" => [
		"This doubles the time required for a search, but allows accurate statistics to be estimated for libraries comprised of a single protein family.",
	],
	"markx" => [
		"(MARKX) =0,1,2,3,4. Alternate display of matches and mismatches in alignments.",
		"MARKX=0 uses \':\',\'.\',\' \', for identities, conservative replacements, and non-conservative replacements, respectively.",
		"MARKX=1 uses \' \',\'x\', and \'X\'. ",
		"MARKX=2 does not show the second sequence, but uses the second alignment line to display matches with a \'.\' for identity, or with the mismatched residue for mismatches. MARKX=2 is useful for aligning large numbers of similar sequences.",
		"MARKX=3 writes out a file of library sequences in FASTA format. MARKX=3 should always be used with the \'SHOWALL\' (-a) option, but this does not completely ensure that all of the sequences output will be aligned. ",
		"MARKX=4 displays a graph of the alignment of the library sequence with repect to the query sequence, so that one can identify the regions of the query sequence that are conserved.",
	],
	"offsets" => [
		"causes fasta/lfasta/plfasta to start numbering the aligned sequences starting with offset1 and offset2, rather than 1 and 1. This is particularly useful for showing alignments of promoter regions.",
	],
	"filter" => [
		"Treat lower-case characters in the query or library sequence as \'low-complexity\' residues. These characters are treated as \'X\' during the initial scan, but are treated as normal residues during the final alignment. Sinces statistical significance is calculated from similarity score calculated during library search, low complexity regions will not produce statistical significant matches.",
		"If a significant alignment contains low complexity regions the final score may be higher than the score obtainded during the search.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fasta.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

