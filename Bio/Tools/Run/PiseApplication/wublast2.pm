
=head1 NAME

Bio::Tools::Run::PiseApplication::wublast2

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::wublast2

      Bioperl class for:

	WUBLAST2	Wash-U. multi-processors BLAST, with gaps (Gish. W)

	References:

		Gish, Warren (1994-1997).  unpublished.

		Gish, W, and DJ States (1993). Identification of protein coding regions by database similarity search. Nature Genetics 3:266-72. 

		Altschul, SF, and W Gish (1996). Local alignment statistics. ed. R. Doolittle. Methods in Enzymology 266:460-80.

		Korf, I, and W Gish (2000). MPBLAST: improved BLAST performance with multiplexed queries. Bioinformatics in press.

		Altschul, Stephen F., Warren Gish, Webb Miller, Eugene W. Myers, and David J. Lipman (1990).  Basic local alignment search tool.  J. Mol. Biol. 215:403-10.


      Parameters:


		wublast2 (Excl)
			Blast program

		query (Sequence)
			Sequence File
			pipe: seqfile

		nosegs (Switch)
			Do not segment the query sequence on hyphen (-) characters (-nosegs)

		protein_db (Excl)
			protein db

		nucleotid_db (Excl)
			nucleotid db

		compat (Excl)
			BLAST version

		filter_opt (Paragraph)
			Filtering and masking options

		wordmask (Switch)
			Use masking instead of filtering (-wordmask)

		filter (Excl)
			Use filter (-filter/-wordmask)

		maskextra (Switch)
			Extend masking additional distance into flanking regions (-maskextra)

		lc (Excl)
			Filter lower-case letters in query

		selectivite (Paragraph)
			Selectivity Options

		Expect (Float)
			Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (E)

		hspmax (Integer)
			Maximal number of HSPs saved or reported per subject sequence (-hspmax)

		E2 (Float)
			Expected number of HSPs that will be found when comparing two sequences that each have the same length (E2)

		Cutoff (Float)
			Cutoff score: threshold for report (S)

		S2 (Float)
			Cutoff score which defines HSPs (S2)

		W (Integer)
			Length of words identified in the query sequence (W)

		T (Integer)
			Neighborhood word score threshold (T)

		nwstart (Integer)
			Start generating neighborhood words here in query (blastwup/blastwux) (-nwstart)

		nwlen (Integer)
			Generate neighborhood words over this distance from 'nwstart' in query (blastwup/blastwux) (-nwlen)

		X (Integer)
			Word hit extension drop-off score (X)

		hitdist (Integer)
			Maximum word separation distance for 2-hit BLAST algorithm (-hitdist)

		wink (Integer)
			Generate word hits at every wink-th position (-wink)

		consistency (Switch)
			Turn off HSP consistency rules for statistics (-consistency)

		hspsepqmax (Integer)
			Maximal separation allowed between HSPs along query(-hspsepqmax)

		hspsepsmax (Integer)
			Maximal separation allowed between HSPs along subject (-hspsepsmax)

		span (Excl)
			Discard HSPs spanned on (-span*)

		nogap (Switch)
			Do not create gapped alignments (-nogap)

		gapall (Switch)
			Generate a gapped alignment for every ungapped HSP found (-gapall)

		gap_selectivite (Paragraph)
			Selectivity options for gapped alignments

		gapE (Float)
			Expectation threshold of sets of ungapped HSPs for subsequent use in seeding gapped alignments (-gapE)

		gapE2 (Float)
			Expectation threshold for saving individual gapped alignments (-gapE2)

		gapS2 (Integer)
			Cutoff score for saving individual gapped alignments (-gapS2)

		gapW (Integer)
			Set the window width within which gapped alignments are generated (-gapW)

		gapX (Integer)
			Set the maximum drop-off score during banded gapped alignment (gapX)

		gapsepqmax (Integer)
			Maximal permitted distance on the QUERY sequence between two consistent gapped alignments (-gapsepqmax)

		gapsepsmax (Integer)
			Maximal permitted distance on the subject sequence between two consistent gapped alignments (-gapsepsmax)

		scoring_opt (Paragraph)
			Scoring options

		M (Integer)
			Reward for a nucleotid match (blastwun) (M)

		N (Integer)
			Penalty for a nucleotid mismatch (blastwun) (N)

		matrix (String)
			Scoring matrix (PAM or BLOSUM, see help)

		Q (Integer)
			Open gap penalty (Q)

		R (Integer)
			Extending a gap penalty (R)

		translation_opt (Paragraph)
			Translation Option

		gcode (Excl)
			Genetic code to translate the query (blastx,tblastx) (-gcode)

		strand (Excl)
			which strands (for nucleotid query)

		dbgcode (Excl)
			Genetic code for database translation (tblastx,tblastn) (-dbgcode)

		dbstrand (Excl)
			which strands of the database sequences (tblastwun,tblastwux)

		statistics (Paragraph)
			Statistic options

		stat (Excl)
			Use statistics

		wordstats (Switch)
			Collect word-hit statistics (-stats)

		ctxfactor (Integer)
			Base statistics on this number of independent contexts or reading frames (-ctxfactor)

		olf (Float)
			Maximal fractional length of overlap for HSP consistency of two ungapped alignment (-olf)

		golf (Float)
			Maximal fractional length of overlap for HSP consistency of two gapped alignments (-olf)

		olmax (Integer)
			Maximal absolute length of overlap for HSP consistency  of two ungapped alignment (default unlimited) (-olmax)

		golmax (Integer)
			Maximal absolute length of overlap for HSP consistency  of two gapped alignment (default unlimited) (-golmax)

		gapdecayrate (Float)
			gapdecayrate

		kastats (Paragraph)
			Parameters for Karlin-Altschul statistics

		K (Integer)
			K parameter for ungapped alignment scores (K)

		L (Integer)
			lambda parameter for ungapped alignment scores (L)

		H (Integer)
			H parameter for ungapped alignment scores (H)

		gapK (Integer)
			K parameter for gapped alignment scores (gapK)

		gapL (Integer)
			lambda parameter for gapped alignment scores (gapL)

		gapH (Integer)
			H parameter for gapped alignment scores (gapH)

		affichage (Paragraph)
			Report options

		Histogram (Switch)
			Histogram (H)

		Descriptions (Integer)
			How many short descriptions? (V)

		Alignments (Integer)
			How many alignments? (B)

		sort (Excl)
			Sort order for reporting database sequences

		postsw (Switch)
			Perform full Smith-Waterman before output (blastwup only) (-postsw)

		output_format (Excl)
			output format?

		echofilter (Switch)
			Display filter sequences in output (-echofilter)

		prune (Switch)
			Do not prune insignificant HSPs from the output lists (-prune)

		topcomboN (Integer)
			Report this number of consistent (colinear) groups of HSPs (-topcomboN)

		topcomboE (Float)
			Only show HSP combos within this factor of the best combo (-topcomboE)

		gi (Switch)
			Display gi identifiers, when available (-gi)

		noseqs (Switch)
			Do not display sequence alignments (-noseqs)

		tmp_outfile (Results)
			
			pipe: blast_output

		htmlfile (Results)
			

		xmloutput (Results)
			

		cpus (Integer)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::wublast2;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $wublast2 = Bio::Tools::Run::PiseApplication::wublast2->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::wublast2 object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $wublast2 = $factory->program('wublast2');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::wublast2.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wublast2.pm

    $self->{COMMAND}   = "wublast2";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WUBLAST2";

    $self->{DESCRIPTION}   = "Wash-U. multi-processors BLAST, with gaps";

    $self->{AUTHORS}   = "Gish. W";

    $self->{REFERENCE}   = [

         "Gish, Warren (1994-1997).  unpublished.",

         "Gish, W, and DJ States (1993). Identification of protein coding regions by database similarity search. Nature Genetics 3:266-72. ",

         "Altschul, SF, and W Gish (1996). Local alignment statistics. ed. R. Doolittle. Methods in Enzymology 266:460-80.",

         "Korf, I, and W Gish (2000). MPBLAST: improved BLAST performance with multiplexed queries. Bioinformatics in press.",

         "Altschul, Stephen F., Warren Gish, Webb Miller, Eugene W. Myers, and David J. Lipman (1990).  Basic local alignment search tool.  J. Mol. Biol. 215:403-10.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"wublast2",
	"query",
	"nosegs",
	"protein_db",
	"nucleotid_db",
	"compat",
	"filter_opt",
	"selectivite",
	"scoring_opt",
	"translation_opt",
	"statistics",
	"affichage",
	"tmp_outfile",
	"htmlfile",
	"xmloutput",
	"cpus",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"wublast2", 	# Blast program
	"query", 	# Sequence File
	"nosegs", 	# Do not segment the query sequence on hyphen (-) characters (-nosegs)
	"protein_db", 	# protein db
	"nucleotid_db", 	# nucleotid db
	"compat", 	# BLAST version
	"filter_opt", 	# Filtering and masking options
	"wordmask", 	# Use masking instead of filtering (-wordmask)
	"filter", 	# Use filter (-filter/-wordmask)
	"maskextra", 	# Extend masking additional distance into flanking regions (-maskextra)
	"lc", 	# Filter lower-case letters in query
	"selectivite", 	# Selectivity Options
	"Expect", 	# Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (E)
	"hspmax", 	# Maximal number of HSPs saved or reported per subject sequence (-hspmax)
	"E2", 	# Expected number of HSPs that will be found when comparing two sequences that each have the same length (E2)
	"Cutoff", 	# Cutoff score: threshold for report (S)
	"S2", 	# Cutoff score which defines HSPs (S2)
	"W", 	# Length of words identified in the query sequence (W)
	"T", 	# Neighborhood word score threshold (T)
	"nwstart", 	# Start generating neighborhood words here in query (blastwup/blastwux) (-nwstart)
	"nwlen", 	# Generate neighborhood words over this distance from 'nwstart' in query (blastwup/blastwux) (-nwlen)
	"X", 	# Word hit extension drop-off score (X)
	"hitdist", 	# Maximum word separation distance for 2-hit BLAST algorithm (-hitdist)
	"wink", 	# Generate word hits at every wink-th position (-wink)
	"consistency", 	# Turn off HSP consistency rules for statistics (-consistency)
	"hspsepqmax", 	# Maximal separation allowed between HSPs along query(-hspsepqmax)
	"hspsepsmax", 	# Maximal separation allowed between HSPs along subject (-hspsepsmax)
	"span", 	# Discard HSPs spanned on (-span*)
	"nogap", 	# Do not create gapped alignments (-nogap)
	"gapall", 	# Generate a gapped alignment for every ungapped HSP found (-gapall)
	"gap_selectivite", 	# Selectivity options for gapped alignments
	"gapE", 	# Expectation threshold of sets of ungapped HSPs for subsequent use in seeding gapped alignments (-gapE)
	"gapE2", 	# Expectation threshold for saving individual gapped alignments (-gapE2)
	"gapS2", 	# Cutoff score for saving individual gapped alignments (-gapS2)
	"gapW", 	# Set the window width within which gapped alignments are generated (-gapW)
	"gapX", 	# Set the maximum drop-off score during banded gapped alignment (gapX)
	"gapsepqmax", 	# Maximal permitted distance on the QUERY sequence between two consistent gapped alignments (-gapsepqmax)
	"gapsepsmax", 	# Maximal permitted distance on the subject sequence between two consistent gapped alignments (-gapsepsmax)
	"scoring_opt", 	# Scoring options
	"M", 	# Reward for a nucleotid match (blastwun) (M)
	"N", 	# Penalty for a nucleotid mismatch (blastwun) (N)
	"matrix", 	# Scoring matrix (PAM or BLOSUM, see help)
	"Q", 	# Open gap penalty (Q)
	"R", 	# Extending a gap penalty (R)
	"translation_opt", 	# Translation Option
	"gcode", 	# Genetic code to translate the query (blastx,tblastx) (-gcode)
	"strand", 	# which strands (for nucleotid query)
	"dbgcode", 	# Genetic code for database translation (tblastx,tblastn) (-dbgcode)
	"dbstrand", 	# which strands of the database sequences (tblastwun,tblastwux)
	"statistics", 	# Statistic options
	"stat", 	# Use statistics
	"wordstats", 	# Collect word-hit statistics (-stats)
	"ctxfactor", 	# Base statistics on this number of independent contexts or reading frames (-ctxfactor)
	"olf", 	# Maximal fractional length of overlap for HSP consistency of two ungapped alignment (-olf)
	"golf", 	# Maximal fractional length of overlap for HSP consistency of two gapped alignments (-olf)
	"olmax", 	# Maximal absolute length of overlap for HSP consistency  of two ungapped alignment (default unlimited) (-olmax)
	"golmax", 	# Maximal absolute length of overlap for HSP consistency  of two gapped alignment (default unlimited) (-golmax)
	"gapdecayrate", 	# gapdecayrate
	"kastats", 	# Parameters for Karlin-Altschul statistics
	"K", 	# K parameter for ungapped alignment scores (K)
	"L", 	# lambda parameter for ungapped alignment scores (L)
	"H", 	# H parameter for ungapped alignment scores (H)
	"gapK", 	# K parameter for gapped alignment scores (gapK)
	"gapL", 	# lambda parameter for gapped alignment scores (gapL)
	"gapH", 	# H parameter for gapped alignment scores (gapH)
	"affichage", 	# Report options
	"Histogram", 	# Histogram (H)
	"Descriptions", 	# How many short descriptions? (V)
	"Alignments", 	# How many alignments? (B)
	"sort", 	# Sort order for reporting database sequences
	"postsw", 	# Perform full Smith-Waterman before output (blastwup only) (-postsw)
	"output_format", 	# output format?
	"echofilter", 	# Display filter sequences in output (-echofilter)
	"prune", 	# Do not prune insignificant HSPs from the output lists (-prune)
	"topcomboN", 	# Report this number of consistent (colinear) groups of HSPs (-topcomboN)
	"topcomboE", 	# Only show HSP combos within this factor of the best combo (-topcomboE)
	"gi", 	# Display gi identifiers, when available (-gi)
	"noseqs", 	# Do not display sequence alignments (-noseqs)
	"tmp_outfile",
	"htmlfile",
	"xmloutput",
	"cpus",

    ];

    $self->{TYPE}  = {
	"wublast2" => 'Excl',
	"query" => 'Sequence',
	"nosegs" => 'Switch',
	"protein_db" => 'Excl',
	"nucleotid_db" => 'Excl',
	"compat" => 'Excl',
	"filter_opt" => 'Paragraph',
	"wordmask" => 'Switch',
	"filter" => 'Excl',
	"maskextra" => 'Switch',
	"lc" => 'Excl',
	"selectivite" => 'Paragraph',
	"Expect" => 'Float',
	"hspmax" => 'Integer',
	"E2" => 'Float',
	"Cutoff" => 'Float',
	"S2" => 'Float',
	"W" => 'Integer',
	"T" => 'Integer',
	"nwstart" => 'Integer',
	"nwlen" => 'Integer',
	"X" => 'Integer',
	"hitdist" => 'Integer',
	"wink" => 'Integer',
	"consistency" => 'Switch',
	"hspsepqmax" => 'Integer',
	"hspsepsmax" => 'Integer',
	"span" => 'Excl',
	"nogap" => 'Switch',
	"gapall" => 'Switch',
	"gap_selectivite" => 'Paragraph',
	"gapE" => 'Float',
	"gapE2" => 'Float',
	"gapS2" => 'Integer',
	"gapW" => 'Integer',
	"gapX" => 'Integer',
	"gapsepqmax" => 'Integer',
	"gapsepsmax" => 'Integer',
	"scoring_opt" => 'Paragraph',
	"M" => 'Integer',
	"N" => 'Integer',
	"matrix" => 'String',
	"Q" => 'Integer',
	"R" => 'Integer',
	"translation_opt" => 'Paragraph',
	"gcode" => 'Excl',
	"strand" => 'Excl',
	"dbgcode" => 'Excl',
	"dbstrand" => 'Excl',
	"statistics" => 'Paragraph',
	"stat" => 'Excl',
	"wordstats" => 'Switch',
	"ctxfactor" => 'Integer',
	"olf" => 'Float',
	"golf" => 'Float',
	"olmax" => 'Integer',
	"golmax" => 'Integer',
	"gapdecayrate" => 'Float',
	"kastats" => 'Paragraph',
	"K" => 'Integer',
	"L" => 'Integer',
	"H" => 'Integer',
	"gapK" => 'Integer',
	"gapL" => 'Integer',
	"gapH" => 'Integer',
	"affichage" => 'Paragraph',
	"Histogram" => 'Switch',
	"Descriptions" => 'Integer',
	"Alignments" => 'Integer',
	"sort" => 'Excl',
	"postsw" => 'Switch',
	"output_format" => 'Excl',
	"echofilter" => 'Switch',
	"prune" => 'Switch',
	"topcomboN" => 'Integer',
	"topcomboE" => 'Float',
	"gi" => 'Switch',
	"noseqs" => 'Switch',
	"tmp_outfile" => 'Results',
	"htmlfile" => 'Results',
	"xmloutput" => 'Results',
	"cpus" => 'Integer',

    };

    $self->{FORMAT}  = {
	"wublast2" => {
		"perl" => '"$value"',
	},
	"query" => {
		"perl" => '" $query" ',
	},
	"nosegs" => {
		"perl" => '(defined $value && $value != $vdef) ? " -nosegs" : ""',
	},
	"protein_db" => {
		"perl" => ' " $value" ',
	},
	"nucleotid_db" => {
		"perl" => ' " $value" ',
	},
	"compat" => {
		"perl" => '($value ne $vdef) ? " -$value" : ""',
	},
	"filter_opt" => {
	},
	"wordmask" => {
	},
	"filter" => {
		"perl" => '($value ne $vdef) ? ($wordmask) ? " -wordmask $value" : " -filter $value" : ""',
	},
	"maskextra" => {
		"perl" => '($value != $vdef) ? " -maskextra" : ""',
	},
	"lc" => {
		"perl" => '($value != $vdef) ? " -$value" : ""',
	},
	"selectivite" => {
	},
	"Expect" => {
		"perl" => '(defined $value && $value != $vdef)? " E=$value":""',
	},
	"hspmax" => {
		"perl" => '(defined $value && $value != $vdef) ? " -hspmax $value" : ""',
	},
	"E2" => {
		"perl" => '(defined $value) ? " E2=$value":""',
	},
	"Cutoff" => {
		"perl" => '(defined $value && $value != $vdef)? " S=$value":""',
	},
	"S2" => {
		"perl" => '(defined $value)? " S2=$value":""',
	},
	"W" => {
		"perl" => '(defined $value)? " W=$value":""',
	},
	"T" => {
		"perl" => '(defined $value)? " T=$value":""',
	},
	"nwstart" => {
		"perl" => '(defined $value && $value != $vdef) ? " -nwstart $value" : ""',
	},
	"nwlen" => {
		"perl" => '(defined $value) ? " -nwlen $value" : ""',
	},
	"X" => {
		"perl" => '(defined $value)? " X=$value":""',
	},
	"hitdist" => {
		"perl" => '(defined $value && $value != $vdef) ? " -hitdist $value" : ""',
	},
	"wink" => {
		"perl" => '(defined $value && $value != $vdef) ? " -wink $value" : "" ',
	},
	"consistency" => {
		"perl" => '($value) ? " -consistency" : ""',
	},
	"hspsepqmax" => {
		"perl" => '(defined $value)? " -hspsepqmax $value" : ""',
	},
	"hspsepsmax" => {
		"perl" => '(defined $value) ? " -hspsepsmax $value" : ""',
	},
	"span" => {
		"perl" => '($value ne $vdef) ? " -$value" : ""',
	},
	"nogap" => {
		"perl" => '($value) ? " -nogap" : ""',
	},
	"gapall" => {
		"perl" => '($value) ? " -gapall" : ""',
	},
	"gap_selectivite" => {
	},
	"gapE" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapE $value" : ""',
	},
	"gapE2" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapE2 $value":""',
	},
	"gapS2" => {
		"perl" => '(defined $value) ? " -gapS2 $value" : ""',
	},
	"gapW" => {
		"perl" => '(defined $value) ? " -gapW $value" : ""',
	},
	"gapX" => {
		"perl" => '(defined $value) ? " gapX=$value":""',
	},
	"gapsepqmax" => {
		"perl" => '(defined $value)? " -gapsepqmax $value":""',
	},
	"gapsepsmax" => {
		"perl" => '(defined $value)? " -gapsepsmax $value":""',
	},
	"scoring_opt" => {
	},
	"M" => {
		"perl" => '(defined $value && $value != $vdef) ? " M=$value" : ""',
	},
	"N" => {
		"perl" => '(defined $value && $value != $vdef) ? " N=$value" : ""',
	},
	"matrix" => {
		"perl" => '($value ne $vdef) ? " -matrix $value" : ""',
	},
	"Q" => {
		"perl" => '(defined $value)? " Q=$value":""',
	},
	"R" => {
		"perl" => '(defined $value) ? " R=$value":""',
	},
	"translation_opt" => {
	},
	"gcode" => {
		"perl" => '($value != $vdef) ? "-gcode $value" : ""',
	},
	"strand" => {
		"perl" => '($value)? " $value":""',
	},
	"dbgcode" => {
		"perl" => '($value != $vdef) ? "-dbgcode $value" : ""',
	},
	"dbstrand" => {
		"perl" => '($value)? " $value":""',
	},
	"statistics" => {
	},
	"stat" => {
		"perl" => '($value ne $vdef) ? " -$value" : "" ',
	},
	"wordstats" => {
		"perl" => '($value != $vdef) ? " -stats" : ""',
	},
	"ctxfactor" => {
		"perl" => '(defined $value) ? " -ctxfactor $value" : ""',
	},
	"olf" => {
		"perl" => '(defined $value && $value != $vdef) ? " -olf $value" : ""',
	},
	"golf" => {
		"perl" => '(defined $value && $value != $vdef) ? " -golf $value" : ""',
	},
	"olmax" => {
		"perl" => '(defined $value) ? " -olmax $value" : ""',
	},
	"golmax" => {
		"perl" => '(defined $value) ? " -golmax $value" : ""',
	},
	"gapdecayrate" => {
		"perl" => '(defined $value && $value != $vdef) ? " -gapdecayrate $value" : ""',
	},
	"kastats" => {
	},
	"K" => {
		"perl" => '(defined $value)? " K=$value":""',
	},
	"L" => {
		"perl" => '(defined $value)? " L=$value":""',
	},
	"H" => {
		"perl" => '(defined $value)? " H=$value":""',
	},
	"gapK" => {
		"perl" => '(defined $value)? " gapK=$value":""',
	},
	"gapL" => {
		"perl" => '(defined $value)? " gapL=$value":""',
	},
	"gapH" => {
		"perl" => '(defined $value)? " gapH=$value":""',
	},
	"affichage" => {
	},
	"Histogram" => {
		"perl" => '($value)? " H=1":""',
	},
	"Descriptions" => {
		"perl" => '(defined $value && $value != $vdef)? " V=$value":""',
	},
	"Alignments" => {
		"perl" => '(defined $value && $value != $vdef)? " B=$value":""',
	},
	"sort" => {
		"perl" => '($value != $vdef) ? " $value" : ""',
	},
	"postsw" => {
		"perl" => '($value) ? " -postsw" : ""',
	},
	"output_format" => {
		"perl" => '($value) ? " > blastwu.txt && $value" : ""',
	},
	"echofilter" => {
		"perl" => '($value) ? " -echofilter" : ""',
	},
	"prune" => {
		"perl" => '($value) ? " -prune" : ""',
	},
	"topcomboN" => {
		"perl" => '(defined $value) ? " -topcomboN $value" : ""',
	},
	"topcomboE" => {
		"perl" => '(defined $value) ? " -topcomboE $value" : ""',
	},
	"gi" => {
		"perl" => '($value) ? " -gi" : ""',
	},
	"noseqs" => {
		"perl" => '($value) ? " -noseqs" : ""',
	},
	"tmp_outfile" => {
	},
	"htmlfile" => {
	},
	"xmloutput" => {
	},
	"cpus" => {
		"perl" => '" -cpus 2"',
	},

    };

    $self->{FILENAMES}  = {
	"tmp_outfile" => 'blastwu.txt',
	"htmlfile" => 'blastwu.html',
	"xmloutput" => 'blastwu.xml',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"wublast2" => 1,
	"query" => 4,
	"protein_db" => 3,
	"nucleotid_db" => 3,
	"filter_opt" => 6,
	"wordmask" => 6,
	"filter" => 6,
	"maskextra" => 6,
	"lc" => 6,
	"selectivite" => 5,
	"Expect" => 5,
	"hspmax" => 5,
	"E2" => 5,
	"Cutoff" => 5,
	"S2" => 5,
	"W" => 5,
	"T" => 5,
	"nwstart" => 5,
	"nwlen" => 5,
	"X" => 5,
	"hitdist" => 5,
	"wink" => 5,
	"consistency" => 5,
	"hspsepqmax" => 5,
	"hspsepsmax" => 5,
	"span" => 5,
	"nogap" => 5,
	"gapall" => 5,
	"gap_selectivite" => 5,
	"gapE" => 5,
	"gapE2" => 5,
	"gapS2" => 5,
	"gapW" => 5,
	"gapX" => 5,
	"gapsepqmax" => 5,
	"gapsepsmax" => 5,
	"scoring_opt" => 6,
	"M" => 6,
	"N" => 6,
	"matrix" => 6,
	"Q" => 6,
	"R" => 6,
	"translation_opt" => 6,
	"gcode" => 6,
	"strand" => 6,
	"dbgcode" => 6,
	"dbstrand" => 6,
	"statistics" => 6,
	"stat" => 6,
	"wordstats" => 6,
	"ctxfactor" => 6,
	"olf" => 6,
	"golf" => 6,
	"olmax" => 6,
	"golmax" => 6,
	"gapdecayrate" => 6,
	"kastats" => 6,
	"K" => 6,
	"L" => 6,
	"H" => 6,
	"gapK" => 6,
	"gapL" => 6,
	"gapH" => 6,
	"affichage" => 5,
	"Histogram" => 5,
	"Descriptions" => 5,
	"Alignments" => 5,
	"sort" => 5,
	"postsw" => 5,
	"output_format" => 500,
	"echofilter" => 5,
	"prune" => 5,
	"topcomboN" => 5,
	"topcomboE" => 5,
	"gi" => 5,
	"noseqs" => 5,
	"cpus" => 7,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"tmp_outfile",
	"nosegs",
	"compat",
	"htmlfile",
	"xmloutput",
	"wublast2",
	"nucleotid_db",
	"protein_db",
	"query",
	"gapsepqmax",
	"gapsepsmax",
	"selectivite",
	"Expect",
	"hspmax",
	"E2",
	"Cutoff",
	"S2",
	"W",
	"T",
	"nwstart",
	"nwlen",
	"X",
	"hitdist",
	"wink",
	"consistency",
	"hspsepqmax",
	"hspsepsmax",
	"span",
	"nogap",
	"gapall",
	"gap_selectivite",
	"gapE",
	"gapE2",
	"affichage",
	"Histogram",
	"Descriptions",
	"Alignments",
	"sort",
	"postsw",
	"echofilter",
	"prune",
	"topcomboN",
	"topcomboE",
	"gi",
	"noseqs",
	"gapS2",
	"gapW",
	"gapX",
	"dbstrand",
	"statistics",
	"stat",
	"wordstats",
	"ctxfactor",
	"olf",
	"golf",
	"olmax",
	"golmax",
	"gapdecayrate",
	"kastats",
	"K",
	"L",
	"H",
	"gapK",
	"gapL",
	"gapH",
	"filter_opt",
	"wordmask",
	"filter",
	"maskextra",
	"lc",
	"scoring_opt",
	"M",
	"N",
	"matrix",
	"Q",
	"R",
	"translation_opt",
	"gcode",
	"strand",
	"dbgcode",
	"cpus",
	"output_format",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"wublast2" => 0,
	"query" => 0,
	"nosegs" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"compat" => 0,
	"filter_opt" => 0,
	"wordmask" => 0,
	"filter" => 0,
	"maskextra" => 0,
	"lc" => 0,
	"selectivite" => 0,
	"Expect" => 0,
	"hspmax" => 0,
	"E2" => 0,
	"Cutoff" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"nwstart" => 0,
	"nwlen" => 0,
	"X" => 0,
	"hitdist" => 0,
	"wink" => 0,
	"consistency" => 0,
	"hspsepqmax" => 0,
	"hspsepsmax" => 0,
	"span" => 0,
	"nogap" => 0,
	"gapall" => 0,
	"gap_selectivite" => 0,
	"gapE" => 0,
	"gapE2" => 0,
	"gapS2" => 0,
	"gapW" => 0,
	"gapX" => 0,
	"gapsepqmax" => 0,
	"gapsepsmax" => 0,
	"scoring_opt" => 0,
	"M" => 0,
	"N" => 0,
	"matrix" => 0,
	"Q" => 0,
	"R" => 0,
	"translation_opt" => 0,
	"gcode" => 0,
	"strand" => 0,
	"dbgcode" => 0,
	"dbstrand" => 0,
	"statistics" => 0,
	"stat" => 0,
	"wordstats" => 0,
	"ctxfactor" => 0,
	"olf" => 0,
	"golf" => 0,
	"olmax" => 0,
	"golmax" => 0,
	"gapdecayrate" => 0,
	"kastats" => 0,
	"K" => 0,
	"L" => 0,
	"H" => 0,
	"gapK" => 0,
	"gapL" => 0,
	"gapH" => 0,
	"affichage" => 0,
	"Histogram" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"sort" => 0,
	"postsw" => 0,
	"output_format" => 0,
	"echofilter" => 0,
	"prune" => 0,
	"topcomboN" => 0,
	"topcomboE" => 0,
	"gi" => 0,
	"noseqs" => 0,
	"tmp_outfile" => 0,
	"htmlfile" => 0,
	"xmloutput" => 0,
	"cpus" => 1,

    };

    $self->{ISCOMMAND}  = {
	"wublast2" => 1,
	"query" => 0,
	"nosegs" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"compat" => 0,
	"filter_opt" => 0,
	"wordmask" => 0,
	"filter" => 0,
	"maskextra" => 0,
	"lc" => 0,
	"selectivite" => 0,
	"Expect" => 0,
	"hspmax" => 0,
	"E2" => 0,
	"Cutoff" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"nwstart" => 0,
	"nwlen" => 0,
	"X" => 0,
	"hitdist" => 0,
	"wink" => 0,
	"consistency" => 0,
	"hspsepqmax" => 0,
	"hspsepsmax" => 0,
	"span" => 0,
	"nogap" => 0,
	"gapall" => 0,
	"gap_selectivite" => 0,
	"gapE" => 0,
	"gapE2" => 0,
	"gapS2" => 0,
	"gapW" => 0,
	"gapX" => 0,
	"gapsepqmax" => 0,
	"gapsepsmax" => 0,
	"scoring_opt" => 0,
	"M" => 0,
	"N" => 0,
	"matrix" => 0,
	"Q" => 0,
	"R" => 0,
	"translation_opt" => 0,
	"gcode" => 0,
	"strand" => 0,
	"dbgcode" => 0,
	"dbstrand" => 0,
	"statistics" => 0,
	"stat" => 0,
	"wordstats" => 0,
	"ctxfactor" => 0,
	"olf" => 0,
	"golf" => 0,
	"olmax" => 0,
	"golmax" => 0,
	"gapdecayrate" => 0,
	"kastats" => 0,
	"K" => 0,
	"L" => 0,
	"H" => 0,
	"gapK" => 0,
	"gapL" => 0,
	"gapH" => 0,
	"affichage" => 0,
	"Histogram" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"sort" => 0,
	"postsw" => 0,
	"output_format" => 0,
	"echofilter" => 0,
	"prune" => 0,
	"topcomboN" => 0,
	"topcomboE" => 0,
	"gi" => 0,
	"noseqs" => 0,
	"tmp_outfile" => 0,
	"htmlfile" => 0,
	"xmloutput" => 0,
	"cpus" => 0,

    };

    $self->{ISMANDATORY}  = {
	"wublast2" => 1,
	"query" => 1,
	"nosegs" => 0,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"compat" => 0,
	"filter_opt" => 0,
	"wordmask" => 0,
	"filter" => 0,
	"maskextra" => 0,
	"lc" => 0,
	"selectivite" => 0,
	"Expect" => 0,
	"hspmax" => 0,
	"E2" => 0,
	"Cutoff" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"nwstart" => 0,
	"nwlen" => 0,
	"X" => 0,
	"hitdist" => 0,
	"wink" => 0,
	"consistency" => 0,
	"hspsepqmax" => 0,
	"hspsepsmax" => 0,
	"span" => 0,
	"nogap" => 0,
	"gapall" => 0,
	"gap_selectivite" => 0,
	"gapE" => 0,
	"gapE2" => 0,
	"gapS2" => 0,
	"gapW" => 0,
	"gapX" => 0,
	"gapsepqmax" => 0,
	"gapsepsmax" => 0,
	"scoring_opt" => 0,
	"M" => 0,
	"N" => 0,
	"matrix" => 0,
	"Q" => 0,
	"R" => 0,
	"translation_opt" => 0,
	"gcode" => 0,
	"strand" => 0,
	"dbgcode" => 0,
	"dbstrand" => 0,
	"statistics" => 0,
	"stat" => 0,
	"wordstats" => 0,
	"ctxfactor" => 0,
	"olf" => 0,
	"golf" => 0,
	"olmax" => 0,
	"golmax" => 0,
	"gapdecayrate" => 0,
	"kastats" => 0,
	"K" => 0,
	"L" => 0,
	"H" => 0,
	"gapK" => 0,
	"gapL" => 0,
	"gapH" => 0,
	"affichage" => 0,
	"Histogram" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"sort" => 0,
	"postsw" => 0,
	"output_format" => 0,
	"echofilter" => 0,
	"prune" => 0,
	"topcomboN" => 0,
	"topcomboE" => 0,
	"gi" => 0,
	"noseqs" => 0,
	"tmp_outfile" => 0,
	"htmlfile" => 0,
	"xmloutput" => 0,
	"cpus" => 0,

    };

    $self->{PROMPT}  = {
	"wublast2" => "Blast program",
	"query" => "Sequence File",
	"nosegs" => "Do not segment the query sequence on hyphen (-) characters (-nosegs)",
	"protein_db" => "protein db",
	"nucleotid_db" => "nucleotid db",
	"compat" => "BLAST version",
	"filter_opt" => "Filtering and masking options",
	"wordmask" => "Use masking instead of filtering (-wordmask)",
	"filter" => "Use filter (-filter/-wordmask)",
	"maskextra" => "Extend masking additional distance into flanking regions (-maskextra)",
	"lc" => "Filter lower-case letters in query",
	"selectivite" => "Selectivity Options",
	"Expect" => "Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (E)",
	"hspmax" => "Maximal number of HSPs saved or reported per subject sequence (-hspmax)",
	"E2" => "Expected number of HSPs that will be found when comparing two sequences that each have the same length (E2)",
	"Cutoff" => "Cutoff score: threshold for report (S)",
	"S2" => "Cutoff score which defines HSPs (S2)",
	"W" => "Length of words identified in the query sequence (W)",
	"T" => "Neighborhood word score threshold (T)",
	"nwstart" => "Start generating neighborhood words here in query (blastwup/blastwux) (-nwstart)",
	"nwlen" => "Generate neighborhood words over this distance from 'nwstart' in query (blastwup/blastwux) (-nwlen)",
	"X" => "Word hit extension drop-off score (X)",
	"hitdist" => "Maximum word separation distance for 2-hit BLAST algorithm (-hitdist)",
	"wink" => "Generate word hits at every wink-th position (-wink)",
	"consistency" => "Turn off HSP consistency rules for statistics (-consistency)",
	"hspsepqmax" => "Maximal separation allowed between HSPs along query(-hspsepqmax)",
	"hspsepsmax" => "Maximal separation allowed between HSPs along subject (-hspsepsmax)",
	"span" => "Discard HSPs spanned on (-span*)",
	"nogap" => "Do not create gapped alignments (-nogap)",
	"gapall" => "Generate a gapped alignment for every ungapped HSP found (-gapall)",
	"gap_selectivite" => "Selectivity options for gapped alignments",
	"gapE" => "Expectation threshold of sets of ungapped HSPs for subsequent use in seeding gapped alignments (-gapE)",
	"gapE2" => "Expectation threshold for saving individual gapped alignments (-gapE2)",
	"gapS2" => "Cutoff score for saving individual gapped alignments (-gapS2)",
	"gapW" => "Set the window width within which gapped alignments are generated (-gapW)",
	"gapX" => "Set the maximum drop-off score during banded gapped alignment (gapX)",
	"gapsepqmax" => "Maximal permitted distance on the QUERY sequence between two consistent gapped alignments (-gapsepqmax)",
	"gapsepsmax" => "Maximal permitted distance on the subject sequence between two consistent gapped alignments (-gapsepsmax)",
	"scoring_opt" => "Scoring options",
	"M" => "Reward for a nucleotid match (blastwun) (M)",
	"N" => "Penalty for a nucleotid mismatch (blastwun) (N)",
	"matrix" => "Scoring matrix (PAM or BLOSUM, see help)",
	"Q" => "Open gap penalty (Q)",
	"R" => "Extending a gap penalty (R)",
	"translation_opt" => "Translation Option",
	"gcode" => "Genetic code to translate the query (blastx,tblastx) (-gcode)",
	"strand" => "which strands (for nucleotid query)",
	"dbgcode" => "Genetic code for database translation (tblastx,tblastn) (-dbgcode)",
	"dbstrand" => "which strands of the database sequences (tblastwun,tblastwux)",
	"statistics" => "Statistic options",
	"stat" => "Use statistics",
	"wordstats" => "Collect word-hit statistics (-stats)",
	"ctxfactor" => "Base statistics on this number of independent contexts or reading frames (-ctxfactor)",
	"olf" => "Maximal fractional length of overlap for HSP consistency of two ungapped alignment (-olf)",
	"golf" => "Maximal fractional length of overlap for HSP consistency of two gapped alignments (-olf)",
	"olmax" => "Maximal absolute length of overlap for HSP consistency  of two ungapped alignment (default unlimited) (-olmax)",
	"golmax" => "Maximal absolute length of overlap for HSP consistency  of two gapped alignment (default unlimited) (-golmax)",
	"gapdecayrate" => "gapdecayrate",
	"kastats" => "Parameters for Karlin-Altschul statistics",
	"K" => "K parameter for ungapped alignment scores (K)",
	"L" => "lambda parameter for ungapped alignment scores (L)",
	"H" => "H parameter for ungapped alignment scores (H)",
	"gapK" => "K parameter for gapped alignment scores (gapK)",
	"gapL" => "lambda parameter for gapped alignment scores (gapL)",
	"gapH" => "H parameter for gapped alignment scores (gapH)",
	"affichage" => "Report options",
	"Histogram" => "Histogram (H)",
	"Descriptions" => "How many short descriptions? (V)",
	"Alignments" => "How many alignments? (B)",
	"sort" => "Sort order for reporting database sequences",
	"postsw" => "Perform full Smith-Waterman before output (blastwup only) (-postsw)",
	"output_format" => "output format?",
	"echofilter" => "Display filter sequences in output (-echofilter)",
	"prune" => "Do not prune insignificant HSPs from the output lists (-prune)",
	"topcomboN" => "Report this number of consistent (colinear) groups of HSPs (-topcomboN)",
	"topcomboE" => "Only show HSP combos within this factor of the best combo (-topcomboE)",
	"gi" => "Display gi identifiers, when available (-gi)",
	"noseqs" => "Do not display sequence alignments (-noseqs)",
	"tmp_outfile" => "",
	"htmlfile" => "",
	"xmloutput" => "",
	"cpus" => "",

    };

    $self->{ISSTANDOUT}  = {
	"wublast2" => 0,
	"query" => 0,
	"nosegs" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"compat" => 0,
	"filter_opt" => 0,
	"wordmask" => 0,
	"filter" => 0,
	"maskextra" => 0,
	"lc" => 0,
	"selectivite" => 0,
	"Expect" => 0,
	"hspmax" => 0,
	"E2" => 0,
	"Cutoff" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"nwstart" => 0,
	"nwlen" => 0,
	"X" => 0,
	"hitdist" => 0,
	"wink" => 0,
	"consistency" => 0,
	"hspsepqmax" => 0,
	"hspsepsmax" => 0,
	"span" => 0,
	"nogap" => 0,
	"gapall" => 0,
	"gap_selectivite" => 0,
	"gapE" => 0,
	"gapE2" => 0,
	"gapS2" => 0,
	"gapW" => 0,
	"gapX" => 0,
	"gapsepqmax" => 0,
	"gapsepsmax" => 0,
	"scoring_opt" => 0,
	"M" => 0,
	"N" => 0,
	"matrix" => 0,
	"Q" => 0,
	"R" => 0,
	"translation_opt" => 0,
	"gcode" => 0,
	"strand" => 0,
	"dbgcode" => 0,
	"dbstrand" => 0,
	"statistics" => 0,
	"stat" => 0,
	"wordstats" => 0,
	"ctxfactor" => 0,
	"olf" => 0,
	"golf" => 0,
	"olmax" => 0,
	"golmax" => 0,
	"gapdecayrate" => 0,
	"kastats" => 0,
	"K" => 0,
	"L" => 0,
	"H" => 0,
	"gapK" => 0,
	"gapL" => 0,
	"gapH" => 0,
	"affichage" => 0,
	"Histogram" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"sort" => 0,
	"postsw" => 0,
	"output_format" => 0,
	"echofilter" => 0,
	"prune" => 0,
	"topcomboN" => 0,
	"topcomboE" => 0,
	"gi" => 0,
	"noseqs" => 0,
	"tmp_outfile" => 0,
	"htmlfile" => 0,
	"xmloutput" => 0,
	"cpus" => 0,

    };

    $self->{VLIST}  = {

	"wublast2" => ['blastwun','blastwun: nucleotide query / nucleotide db','blastwup','blastwup: amino acid query / protein db','blastwux','blastwux: nucleotide query translated / protein db','tblastwun','tblastwun: protein query / translated nucleotide db','tblastwux','tblastwux: nucleotide query transl. / transl. nucleotide db',],
	"protein_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','prodom','prodom: protein domains','sbase','sbase: annotated domains sequences',],
	"nucleotid_db" => ['embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"compat" => ['current','current version 2.0','compat1.4','compat1.4: revert to BLAST version 1.4 (with bug fixes)','compat1.3','compat1.3: revert to BLAST version 1.3 (with bug fixes)',],
	"filter_opt" => ['wordmask','filter','maskextra','lc',],
	"filter" => ['none','none: no filter','dust','dust: DNA filter','seg','seg: masks low compositional complexity regions','xnu','xnu: masks regions containing short-periodicity internal repeats','seg+xnu','seg+xnu',],
	"lc" => ['no','none','lcfilter','lcfilter: filter by replacing with the appropriate ambiguity code','lcmask','lcmask: mask without altering the sequence',],
	"selectivite" => ['Expect','hspmax','E2','Cutoff','S2','W','T','nwstart','nwlen','X','hitdist','wink','consistency','hspsepqmax','hspsepsmax','span','nogap','gapall','gap_selectivite',],
	"span" => ['span2','span2: both query and subject by a better HSP','span1','span1: on query, subject or both by a better HSP','span','span: by other, better HSPs',],
	"gap_selectivite" => ['gapE','gapE2','gapS2','gapW','gapX','gapsepqmax','gapsepsmax',],
	"scoring_opt" => ['M','N','matrix','Q','R',],
	"translation_opt" => ['gcode','strand','dbgcode','dbstrand',],
	"gcode" => ['1','1: Standard','2','2: Vertebrate Mitochondrial','3','3: Yeast Mitochondrial','4','4: Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','5: Invertebrate Mitochondrial','6','6: Ciliate Macronuclear and Dasycladacean','9','9: Echinoderm Mitochondrial','10','10: Alternative Ciliate Marconuclear','11','11: Bacterial','12','12: Alternative Yeast Nuclear','13','13: Ascidian Mitochondrial','14','14: Flatworm Mitochondrial',],
	"strand" => ['','both','-top','top','-bottom','bottom',],
	"dbgcode" => ['1','1: Standard','2','2: Vertebrate Mitochondrial','3','3: Yeast Mitochondrial','4','4: Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','5: Invertebrate Mitochondrial','6','6: Ciliate Macronuclear and Dasycladacean','9','9: Echinoderm Mitochondrial','10','10: Alternative Ciliate Marconuclear','11','11: Bacterial','12','12: Alternative Yeast Nuclear','13','13: Ascidian Mitochondrial','14','14: Flatworm Mitochondrial',],
	"dbstrand" => ['','both','-dbtop','top','-dbbottom','bottom',],
	"statistics" => ['stat','wordstats','ctxfactor','olf','golf','olmax','golmax','gapdecayrate','kastats',],
	"stat" => ['poissonp','poissonp: Poisson statistics to evaluate multiple HSPs','kap','kap: Karlin-Altschul statistics on individual alignment scores','sump','sump: Karlin-Altschul \'Sum\' statistics',],
	"kastats" => ['K','L','H','gapK','gapL','gapH',],
	"affichage" => ['Histogram','Descriptions','Alignments','sort','postsw','output_format','echofilter','prune','topcomboN','topcomboE','gi','noseqs',],
	"sort" => ['-sort_by_pvalue','-sort_by_pvalue: from most significant to least significant','-sort_by_count','-sort_by_count: from highest to lowest by the number of HSPs found','-sort_by_highscore','-sort_by_highscore: from highest to lowest by the score of the highest segment','-sort_by_totalscore','-sort_by_totalscore: from highest to the lowest by the sum total score',],
	"output_format" => ['','text','blast2XML blastwu.txt > blastwu.xml','xml','"html4blast -o blastwu.html -s -g blastwu.txt"','html',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"wublast2" => 'blastwup',
	"nosegs" => '0',
	"protein_db" => 'sptrnrdb',
	"nucleotid_db" => 'embl',
	"compat" => 'current',
	"wordmask" => '0',
	"filter" => 'none',
	"maskextra" => '0',
	"lc" => 'no',
	"Expect" => '10.0',
	"hspmax" => '1000',
	"hitdist" => '0',
	"wink" => '1',
	"consistency" => '0',
	"span" => 'span2',
	"nogap" => '0',
	"gapall" => '1',
	"gapE" => '2000',
	"M" => '5',
	"N" => '-4',
	"matrix" => 'BLOSUM62',
	"gcode" => '1',
	"dbgcode" => '1',
	"stat" => 'sump',
	"wordstats" => '0',
	"olf" => '0.125',
	"golf" => '0.10',
	"gapdecayrate" => '0.5',
	"Descriptions" => '500',
	"Alignments" => '250',
	"sort" => '-sort_by_pvalue',
	"postsw" => '0',
	"echofilter" => '0',
	"prune" => '0',
	"gi" => '0',
	"noseqs" => '0',

    };

    $self->{PRECOND}  = {
	"wublast2" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"nosegs" => { "perl" => '1' },
	"protein_db" => {
		"perl" => ' ($wublast2 =~ /^blastwup|^blastwux/) ',
	},
	"nucleotid_db" => {
		"perl" => '($wublast2 =~ /^blastwun|^tblastwu/)  ',
	},
	"compat" => { "perl" => '1' },
	"filter_opt" => { "perl" => '1' },
	"wordmask" => { "perl" => '1' },
	"filter" => { "perl" => '1' },
	"maskextra" => {
		"perl" => '$wordmask',
	},
	"lc" => { "perl" => '1' },
	"selectivite" => { "perl" => '1' },
	"Expect" => { "perl" => '1' },
	"hspmax" => { "perl" => '1' },
	"E2" => { "perl" => '1' },
	"Cutoff" => { "perl" => '1' },
	"S2" => { "perl" => '1' },
	"W" => { "perl" => '1' },
	"T" => { "perl" => '1' },
	"nwstart" => {
		"perl" => '$wublast2 =~ /^blastwu[px]/',
	},
	"nwlen" => {
		"perl" => '$wublast2 =~ /^blastwu[px]/',
	},
	"X" => { "perl" => '1' },
	"hitdist" => { "perl" => '1' },
	"wink" => { "perl" => '1' },
	"consistency" => { "perl" => '1' },
	"hspsepqmax" => {
		"perl" => '! $consistency',
	},
	"hspsepsmax" => {
		"perl" => '! $consistency',
	},
	"span" => { "perl" => '1' },
	"nogap" => { "perl" => '1' },
	"gapall" => { "perl" => '1' },
	"gap_selectivite" => {
		"perl" => '(! $nogap) && (! $gapall)',
	},
	"gapE" => {
		"perl" => '(! $nogap) && (! $gapall)',
	},
	"gapE2" => {
		"perl" => '(! $nogap) && (! $gapall)',
	},
	"gapS2" => {
		"perl" => '(! $nogap) && (! $gapall)',
	},
	"gapW" => {
		"perl" => '(! $nogap) && (! $gapall)',
	},
	"gapX" => {
		"perl" => '(! $nogap) && (! $gapall)',
	},
	"gapsepqmax" => {
		"perl" => '(! $nogap) && (! $consistency)',
	},
	"gapsepsmax" => {
		"perl" => '(! $nogap) && (! $consistency)',
	},
	"scoring_opt" => { "perl" => '1' },
	"M" => {
		"perl" => '$wublast2 eq blastwun',
	},
	"N" => {
		"perl" => '$wublast2 eq blastwun',
	},
	"matrix" => {
		"perl" => '($wublast2 =~ /^blastwup|blastwux$/)',
	},
	"Q" => { "perl" => '1' },
	"R" => { "perl" => '1' },
	"translation_opt" => {
		"perl" => '$wublast2 ne blastwun',
	},
	"gcode" => {
		"perl" => '$wublast2 =~ /blastwux/',
	},
	"strand" => {
		"perl" => ' ($wublast2 =~ /^blastwun|blastwux$/) ',
	},
	"dbgcode" => {
		"perl" => '$wublast2  =~ /^tblast/',
	},
	"dbstrand" => {
		"perl" => ' ($wublast2 =~ /^tblast/) ',
	},
	"statistics" => { "perl" => '1' },
	"stat" => { "perl" => '1' },
	"wordstats" => { "perl" => '1' },
	"ctxfactor" => { "perl" => '1' },
	"olf" => { "perl" => '1' },
	"golf" => { "perl" => '1' },
	"olmax" => { "perl" => '1' },
	"golmax" => { "perl" => '1' },
	"gapdecayrate" => { "perl" => '1' },
	"kastats" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"K" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"L" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"H" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"gapK" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"gapL" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"gapH" => {
		"perl" => '$stat =~ /^kap|^sump/',
	},
	"affichage" => { "perl" => '1' },
	"Histogram" => { "perl" => '1' },
	"Descriptions" => { "perl" => '1' },
	"Alignments" => { "perl" => '1' },
	"sort" => { "perl" => '1' },
	"postsw" => {
		"perl" => '$wublast2 =~ /^blastwup/',
	},
	"output_format" => { "perl" => '1' },
	"echofilter" => { "perl" => '1' },
	"prune" => { "perl" => '1' },
	"topcomboN" => { "perl" => '1' },
	"topcomboE" => { "perl" => '1' },
	"gi" => { "perl" => '1' },
	"noseqs" => { "perl" => '1' },
	"tmp_outfile" => { "perl" => '1' },
	"htmlfile" => {
		"perl" => '$output_format =~ /^html4blast/',
	},
	"xmloutput" => {
		"perl" => '$output_format =~ /^blast2XML/',
	},
	"cpus" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"tmp_outfile" => {
		 '1' => "blast_output",
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
	"wublast2" => 0,
	"query" => 0,
	"nosegs" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"compat" => 0,
	"filter_opt" => 0,
	"wordmask" => 0,
	"filter" => 0,
	"maskextra" => 0,
	"lc" => 0,
	"selectivite" => 0,
	"Expect" => 0,
	"hspmax" => 0,
	"E2" => 0,
	"Cutoff" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"nwstart" => 0,
	"nwlen" => 0,
	"X" => 0,
	"hitdist" => 0,
	"wink" => 0,
	"consistency" => 0,
	"hspsepqmax" => 0,
	"hspsepsmax" => 0,
	"span" => 0,
	"nogap" => 0,
	"gapall" => 0,
	"gap_selectivite" => 0,
	"gapE" => 0,
	"gapE2" => 0,
	"gapS2" => 0,
	"gapW" => 0,
	"gapX" => 0,
	"gapsepqmax" => 0,
	"gapsepsmax" => 0,
	"scoring_opt" => 0,
	"M" => 0,
	"N" => 0,
	"matrix" => 0,
	"Q" => 0,
	"R" => 0,
	"translation_opt" => 0,
	"gcode" => 0,
	"strand" => 0,
	"dbgcode" => 0,
	"dbstrand" => 0,
	"statistics" => 0,
	"stat" => 0,
	"wordstats" => 0,
	"ctxfactor" => 0,
	"olf" => 0,
	"golf" => 0,
	"olmax" => 0,
	"golmax" => 0,
	"gapdecayrate" => 0,
	"kastats" => 0,
	"K" => 0,
	"L" => 0,
	"H" => 0,
	"gapK" => 0,
	"gapL" => 0,
	"gapH" => 0,
	"affichage" => 0,
	"Histogram" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"sort" => 0,
	"postsw" => 0,
	"output_format" => 0,
	"echofilter" => 0,
	"prune" => 0,
	"topcomboN" => 0,
	"topcomboE" => 0,
	"gi" => 0,
	"noseqs" => 0,
	"tmp_outfile" => 0,
	"htmlfile" => 0,
	"xmloutput" => 0,
	"cpus" => 0,

    };

    $self->{ISSIMPLE}  = {
	"wublast2" => 1,
	"query" => 1,
	"nosegs" => 0,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"compat" => 0,
	"filter_opt" => 0,
	"wordmask" => 0,
	"filter" => 0,
	"maskextra" => 0,
	"lc" => 0,
	"selectivite" => 0,
	"Expect" => 1,
	"hspmax" => 0,
	"E2" => 0,
	"Cutoff" => 0,
	"S2" => 0,
	"W" => 0,
	"T" => 0,
	"nwstart" => 0,
	"nwlen" => 0,
	"X" => 0,
	"hitdist" => 0,
	"wink" => 0,
	"consistency" => 0,
	"hspsepqmax" => 0,
	"hspsepsmax" => 0,
	"span" => 0,
	"nogap" => 0,
	"gapall" => 0,
	"gap_selectivite" => 0,
	"gapE" => 0,
	"gapE2" => 0,
	"gapS2" => 0,
	"gapW" => 0,
	"gapX" => 0,
	"gapsepqmax" => 0,
	"gapsepsmax" => 0,
	"scoring_opt" => 0,
	"M" => 0,
	"N" => 0,
	"matrix" => 0,
	"Q" => 0,
	"R" => 0,
	"translation_opt" => 0,
	"gcode" => 0,
	"strand" => 0,
	"dbgcode" => 0,
	"dbstrand" => 0,
	"statistics" => 0,
	"stat" => 0,
	"wordstats" => 0,
	"ctxfactor" => 0,
	"olf" => 0,
	"golf" => 0,
	"olmax" => 0,
	"golmax" => 0,
	"gapdecayrate" => 0,
	"kastats" => 0,
	"K" => 0,
	"L" => 0,
	"H" => 0,
	"gapK" => 0,
	"gapL" => 0,
	"gapH" => 0,
	"affichage" => 0,
	"Histogram" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"sort" => 0,
	"postsw" => 0,
	"output_format" => 0,
	"echofilter" => 0,
	"prune" => 0,
	"topcomboN" => 0,
	"topcomboE" => 0,
	"gi" => 0,
	"noseqs" => 0,
	"tmp_outfile" => 0,
	"htmlfile" => 0,
	"xmloutput" => 0,
	"cpus" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"wublast2" => [
		"The five BLAST programs described here perform the following tasks:",
		". blastwup compares an amino acid query sequence against a protein sequence database;",
		". blastwun compares a nucleotide query sequence against a nucleotide sequence database;",
		". blastwux compares the six-frame conceptual translation products of a nucleotide query sequence (both strands) against a protein sequence database;",
		". tblastwun compares a protein query sequence against a nucleotide sequence database dynamically translated in all six reading frames (both strands).",
		". tblastwux compares the six-frame translations of a nucleotide query sequence against the six-frame translations of a nucleotide sequence database.",
	],
	"protein_db" => [
		"Choose a protein db for blastwup or blastwux.",
		"Please note that Swissprot usage by and for commercial entities requires a license agreement.",
	],
	"nucleotid_db" => [
		"choose a nucleotide db for blastwun, tblastwun or tblastwux",
	],
	"wordmask" => [
		"Mask letters in the query sequence without altering the sequence itself, during neighborhood word generation.",
	],
	"filter" => [
		"This option activates filtering or masking of segments of the query sequence based on a potentially wide variety of criteria. The usual intent of filtering is to mask regions that are non-specific for protein identification using sequence similarity. For instance, it may be desired to mask acidic or basic segments that would otherwise yield overwhelming amounts of uninteresting, non-specific matches against a wide array of protein families from a comprehensive database search. The BLAST programs have internally-coded knowledge of the specific command line options needed to invoke the SEG and XNU programs as query sequence filters, but these two filter programs are not included in the BLAST software distribution and must be independently installed.",
		"The SEG program (Wootton and Federhen, 1993) masks low compositional complexity regions, while XNU (Claverie and States, 1993) masks regions containing short-periodicity internal repeats. The BLAST programs can pipe the filtered output from one program into another. For instance, XNU+SEG or SEG+XNU can be specified as the filtermethod to have each program filter the query sequence in succession. Note that neither SEG nor XNU is suitable for filtering untranslated nucleotide sequences for use by blastn",
	],
	"lc" => [
		"",
	],
	"Expect" => [
		"The parameter Expect (E) establishes a statistical significance threshold for reporting database sequence matches. E is interpreted as the upper bound on the expected frequency of chance occurrence of an HSP (or set of HSPs) within the context of the entire database search. Any database sequence whose matching satisfies E is subject to being reported in the program output. If the query sequence and database sequences follow the random sequence model of Karlin and Altschul (1990), and if sufficiently sensitive BLAST algorithm parameters are used, then E may be thought of as the number of matches one expects to observe by chance alone during the database search. The default value for E is 10, while the permitted range for this Real valued parameter is 0 < E <= 1000.",
	],
	"E2" => [
		"E2 is interpreted as the expected number of HSPs that will be found when comparing two sequences that each have the same length -- either 300 amino acids or 1000 nucleotides, whichever is appropriate for the particular program being used.",
		"The default value for E2 is typically about 0.15 but may vary from version to version of each program.",
	],
	"Cutoff" => [
		"The parameter Cutoff (S) represents the score at which a single HSP would by itself satisfy the significance threshold E. Higher scores -- higher values for S -- correspond to increasing statistical significance (lower probability of chance occurrence). Unless S is explicitly set on the command line, its default value is calculated from the value of E. If both S and E are set on the command line, the one which is the most restrictive is used. When neither parameter is specified on the command line, the default value for E is used to calculate S.",
	],
	"S2" => [
		"S2 may be thought of as the score expected for the MSP between two sequences that each have the same length -- either 300 amino acids or 1000 nucleotides, whichever is appropriate for the particular program being used.",
		"The default value for S2 will be calculated from E2 and, like the relationship between E and S, is dependent on the residue composition of the query sequence and the scoring system employed, as conveyed by the Karlin-Altschul K and Lambda statistics.",
	],
	"W" => [
		"The task of finding HSPs begins with identifying short words of length W in the query sequence that either match or satisfy some positive-valued threshold score T when aligned with a word of the same length in a database sequence. T is referred to as the neighborhood word score threshold (Altschul et al., 1990). These initial neighborhood word hits act as seeds for initiating searches to find longer HSPs containing them. The word hits are extended in both directions along each sequence for as far as the cumulative alignment score can be increased. Extension of the word hits in each direction are halted when: the cumulative alignment score falls off by the quantity X from its maximum achieved value; the cumulative score goes to zero or below, due to the accumulation of one or more negative-scoring residue alignments; or the end of either sequence is reached.",
	],
	"nwstart" => [
		"Restrict blast neighborhood word generation to a specific segment of the query sequence that begins at \'nwstart\' and continues for \'nwlen\' residues or until the end of the query sequence is reached. HSP alignments may extend outside the region of neighborhood word generation but hte alignments can only be initiated by word hits occurring within the region. Through the use of these options, a very long query sequence can be searched piecemeal, using short, overlapping segments each time. The amount of overlap from one meighborhood region to the next need only be the blast wordlength W minus 1, in order to be assured of detecting all HSPs.",
		"However, to provide greater freedom for stastical interpretation of multiple HSP findings (eg. matches against exons) more extensive overlapping is recommanded, with the extent to be chosen based on the expected gene density and length of introns.",
	],
	"hitdist" => [
		"Invoke a 2-hit BLAST algorithm similar to that of Altschul et al. (1997), with maximum  wordhit separation distance, as measured from the end of each wordhit. Altschul et al. (1997) use the equivalent of hitdist=40 in their software by default (except NCBI-BLASTN, where 2-hit BLAST is not available). In WU-BLASTN, setting \'hitdist\' and \'wink\' (see below) is akin to using double-length words generated on W-mer boundaries.",
		"For best sensitivity, 2-hit BLAST should generally not be used.",
	],
	"wink" => [
		"Generate word hits at every wink-th (\'W increment\') position along the query, where the default wink=1 produces neighborhood words at every position.",
		"For good sensitivity, this option should not be used. The benefit of using \'wink\' is in finding identical or nearly identical sequences rapidly. When used in conjunction with the \'hitdist\' option to obtain the highest speed, care should be taken that desired matches are not precluded by these parameters.",
	],
	"consistency" => [
		"This option turns off both the determination of the number of HSPs that ar consistent with each other in a gapped alignment and an adjustment that is made to the Sum and poisson statistics to account for the consistency of combined HSPs.",
	],
	"gapW" => [
		"Default values are 32 for protein comparisons and 16 for \'balstwun\'.",
	],
	"matrix" => [
		"Several PAM (point accepted mutations per 100 residues) amino acid scoring matrices are provided in the BLAST software distribution, including the PAM40, PAM120, and PAM250. While the BLOSUM62 matrix is a good general purpose scoring matrix and is the default matrix used by the BLAST programs, if one is restricted to using only PAM scoring matrices, then the PAM120 is recommended for general protein similarity searches (Altschul, 1991). The pam(1 program can be used to produce PAM matrices of any desired iteration from 2 to 511. Each matrix is most sensitive at finding similarities at its particular PAM distance. For more thorough searches, particularly when the mutational distance between potential homologs is unknown and the significance of their similarity may be only marginal, Altschul (1991, 1992) recommends performing at least three searches, one each with the PAM40, PAM120 and PAM250 matrices.",
	],
	"Q" => [
		"This option ses the penalty for a gap of length 1. Default values are Q=9 for proteins and Q=10 for \'blastwun\'. If a non-default scoring matrix is requested on the command line, the gap penalties do not automatically adjust.",
	],
	"R" => [
		"This option set the per-residue penalty for extending a gap. Default values are R=2 for proteins; R=10 for \'blastwun\'. If a non-default scoring matrix is requested on the command line, the gap penalties do not automatically adjust.>",
	],
	"statistics" => [
		"Parameters to use when evaluating the significance of gapped and ungapped alignment scores. Useful when precomputed values are unavailable for the chosen scoring matrix and gap penalty combination in the programs internal tables.",
	],
	"wordstats" => [
		"This option consumes marginally more cpu time.",
	],
	"olf" => [
		"",
	],
	"gapdecayrate" => [
		"This option defines the common ratio of the terms in a geometric progression used in normalizing probabilities across all numbers of Poisson events (typically the number of \'consistent\' HSPs). A Poisson probability for N segments is eighted by the reciprocal of the Nth term in the progression, where the first term has a value of (1-rate), the second term is (1-rate)*rate, the third term is (1-rate)*rate*rate, and so on.",
		"The default rate is 0.5, such that the probability assigned to a single HSP is discounted by a factor of 2, the Poisson probability of 2 HSPs is discounted by a factor of 4, for 3 HSPs the discount factor is 8, and so on. The rate essentially defines a penalty imposed on the gap between each HSP, where the default penalty is equivalent to 1 bit of information.",
	],
	"Descriptions" => [
		"Maximum number of database sequences for which one-line descriptions will be reported (V).",
	],
	"Alignments" => [
		"Maximum number of database sequences for which high-scoring segment pairs will be reported (B).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wublast2.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

