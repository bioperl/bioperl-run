# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::blast2
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::blast2

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::blast2

      Bioperl class for:

	BLAST2	with gaps (Altschul, Madden, Schaeffer, Zhang, Miller, Lipman)

	References:

		Altschul, Stephen F., Thomas L. Madden, Alejandro A. Schaeffer,Jinghui Zhang, Zheng Zhang, Webb Miller, and David J. Lipman (1997), Gapped BLAST and PSI-BLAST: a new generation of protein database search programs,  Nucleic Acids Res. 25:3389-3402.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/blast2.html 
         for available values):


		blast_init (String)

		blast2 (Excl)
			Blast program

		nb_proc (Integer)

		query (Sequence)
			Sequence File
			pipe: seqfile

		start_region (Integer)
			Start of required region in query sequence (-L)

		end_region (Integer)
			End of required region in query sequence (-L)

		protein_db (Excl)
			protein db

		nucleotid_db (Excl)
			nucleotid db

		filter (Switch)
			Filter query sequence (DUST with blastn, SEG with others) (-F)

		other_filters (Excl)
			Filtering options (-F must be true)

		lower_case (Switch)
			Use lower case filtering (-U)

		Expect (Integer)
			Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)

		word_size (Integer)
			Word Size (-W) (zero invokes default behavior)

		dist_hits (Integer)
			Multiple Hits window size (zero for single hit algorithm) (-A)

		extend_hit (Integer)
			Threshold for extending hits (-f)

		dropoff_extent (Float)
			X dropoff for blast extention in bits (0.0 invokes default behavior) (-y)

		keep_hits (Integer)
			Number of best hits from region to keep (-K)

		gapped_alig (Switch)
			Perform gapped alignment (not available with tblastx) (-g)

		dropoff (Integer)
			X dropoff value for gapped alignment (in bits) (-X)

		dropoff_final (Integer)
			X dropoff value for final alignment (in bits) (-Z)

		mismatch (Integer)
			Penalty for a nucleotide mismatch (blastn) (-q)

		match (Integer)
			Reward for a nucleotide match (blastn) (-r)

		matrix (Excl)
			Matrix (-M)

		open_a_gap (Integer)
			Cost to open a gap (-G)

		extend_a_gap (Integer)
			Cost to extend a gap (-E)

		gc_query (Excl)
			Query Genetic code to use (blastx) (-Q)

		gc_db (Excl)
			DB Genetic code (for tblast[nx] only) (-D)

		strand (Excl)
			Query strand to search against database (for blastx and tblastx) (-S)

		Descriptions (Integer)
			How many short descriptions? (-v)

		Alignments (Integer)
			How many alignments? (-b)

		view_alignments (Excl)
			Alignment view options  (not with blastx/tblastx) (-m)

		show_gi (Switch)
			Show GI's in deflines (only available for NCBI db such as nrprot) (-I)

		seqalign_file (OutFile)
			SeqAlign file (-J option must be true) (-O)

		believe (Switch)
			Believe the query defline (-J)

		htmloutput (Switch)
			Html output

		html4blast_input (String)

		external_links (Switch)
			Use external web sites for databases entries retrieval links (-e instead of -s)

		one_HSP_per_line (Switch)
			Draw one HSP per line in image instead of putting all HSP in one line (-l)

		image_query (Switch)
			Generate images names based on corresponding query (-q)

		restrict_db (InFile)
			Restrict search of database to GI's in file (-l)

		psi_checkpoint (InFile)
			PSI-TBLASTN checkpoint file (-R)
			pipe: psiblast_matrix

		txtoutput (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/blast2.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::blast2;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $blast2 = Bio::Tools::Run::PiseApplication::blast2->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::blast2 object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $blast2 = $factory->program('blast2');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::blast2.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blast2.pm

    $self->{COMMAND}   = "blast2";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLAST2";

    $self->{DESCRIPTION}   = "with gaps";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Altschul, Madden, Schaeffer, Zhang, Miller, Lipman";

    $self->{REFERENCE}   = [

         "Altschul, Stephen F., Thomas L. Madden, Alejandro A. Schaeffer,Jinghui Zhang, Zheng Zhang, Webb Miller, and David J. Lipman (1997), Gapped BLAST and PSI-BLAST: a new generation of protein database search programs,  Nucleic Acids Res. 25:3389-3402.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"blast_init",
	"blast2",
	"nb_proc",
	"query",
	"start_region",
	"end_region",
	"protein_db",
	"nucleotid_db",
	"filter_opt",
	"selectivity_opt",
	"scoring_opt",
	"translation_opt",
	"affichage",
	"othersopt",
	"txtoutput",
	"tmp_outfile",
	"xmloutput",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"blast_init",
	"blast2", 	# Blast program
	"nb_proc",
	"query", 	# Sequence File
	"start_region", 	# Start of required region in query sequence (-L)
	"end_region", 	# End of required region in query sequence (-L)
	"protein_db", 	# protein db
	"nucleotid_db", 	# nucleotid db
	"filter_opt", 	# Filtering and masking options
	"filter", 	# Filter query sequence (DUST with blastn, SEG with others) (-F)
	"other_filters", 	# Filtering options (-F must be true)
	"lower_case", 	# Use lower case filtering (-U)
	"selectivity_opt", 	# Selectivity options
	"Expect", 	# Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)
	"word_size", 	# Word Size (-W) (zero invokes default behavior)
	"dist_hits", 	# Multiple Hits window size (zero for single hit algorithm) (-A)
	"extend_hit", 	# Threshold for extending hits (-f)
	"dropoff_extent", 	# X dropoff for blast extention in bits (0.0 invokes default behavior) (-y)
	"keep_hits", 	# Number of best hits from region to keep (-K)
	"gapped_alig", 	# Perform gapped alignment (not available with tblastx) (-g)
	"dropoff", 	# X dropoff value for gapped alignment (in bits) (-X)
	"dropoff_final", 	# X dropoff value for final alignment (in bits) (-Z)
	"scoring_opt", 	# Scoring options
	"mismatch", 	# Penalty for a nucleotide mismatch (blastn) (-q)
	"match", 	# Reward for a nucleotide match (blastn) (-r)
	"matrix", 	# Matrix (-M)
	"open_a_gap", 	# Cost to open a gap (-G)
	"extend_a_gap", 	# Cost to extend a gap (-E)
	"translation_opt", 	# Translation options
	"gc_query", 	# Query Genetic code to use (blastx) (-Q)
	"gc_db", 	# DB Genetic code (for tblast[nx] only) (-D)
	"strand", 	# Query strand to search against database (for blastx and tblastx) (-S)
	"affichage", 	# Report options
	"Descriptions", 	# How many short descriptions? (-v)
	"Alignments", 	# How many alignments? (-b)
	"view_alignments", 	# Alignment view options  (not with blastx/tblastx) (-m)
	"show_gi", 	# Show GI's in deflines (only available for NCBI db such as nrprot) (-I)
	"seqalign_file", 	# SeqAlign file (-J option must be true) (-O)
	"believe", 	# Believe the query defline (-J)
	"htmloutput", 	# Html output
	"htmlopt", 	# HTML output options (html4blast)
	"html4blast_input",
	"external_links", 	# Use external web sites for databases entries retrieval links (-e instead of -s)
	"one_HSP_per_line", 	# Draw one HSP per line in image instead of putting all HSP in one line (-l)
	"image_query", 	# Generate images names based on corresponding query (-q)
	"htmlfile",
	"othersopt", 	# Other Options
	"restrict_db", 	# Restrict search of database to GI's in file (-l)
	"psi_checkpoint", 	# PSI-TBLASTN checkpoint file (-R)
	"txtoutput",
	"tmp_outfile",
	"xmloutput",

    ];

    $self->{TYPE}  = {
	"blast_init" => 'String',
	"blast2" => 'Excl',
	"nb_proc" => 'Integer',
	"query" => 'Sequence',
	"start_region" => 'Integer',
	"end_region" => 'Integer',
	"protein_db" => 'Excl',
	"nucleotid_db" => 'Excl',
	"filter_opt" => 'Paragraph',
	"filter" => 'Switch',
	"other_filters" => 'Excl',
	"lower_case" => 'Switch',
	"selectivity_opt" => 'Paragraph',
	"Expect" => 'Integer',
	"word_size" => 'Integer',
	"dist_hits" => 'Integer',
	"extend_hit" => 'Integer',
	"dropoff_extent" => 'Float',
	"keep_hits" => 'Integer',
	"gapped_alig" => 'Switch',
	"dropoff" => 'Integer',
	"dropoff_final" => 'Integer',
	"scoring_opt" => 'Paragraph',
	"mismatch" => 'Integer',
	"match" => 'Integer',
	"matrix" => 'Excl',
	"open_a_gap" => 'Integer',
	"extend_a_gap" => 'Integer',
	"translation_opt" => 'Paragraph',
	"gc_query" => 'Excl',
	"gc_db" => 'Excl',
	"strand" => 'Excl',
	"affichage" => 'Paragraph',
	"Descriptions" => 'Integer',
	"Alignments" => 'Integer',
	"view_alignments" => 'Excl',
	"show_gi" => 'Switch',
	"seqalign_file" => 'OutFile',
	"believe" => 'Switch',
	"htmloutput" => 'Switch',
	"htmlopt" => 'Paragraph',
	"html4blast_input" => 'String',
	"external_links" => 'Switch',
	"one_HSP_per_line" => 'Switch',
	"image_query" => 'Switch',
	"htmlfile" => 'Results',
	"othersopt" => 'Paragraph',
	"restrict_db" => 'InFile',
	"psi_checkpoint" => 'InFile',
	"txtoutput" => 'String',
	"tmp_outfile" => 'Results',
	"xmloutput" => 'Results',

    };

    $self->{FORMAT}  = {
	"blast_init" => {
		"perl" => ' " " ',
	},
	"blast2" => {
		"perl" => '"blastall -p $value"',
	},
	"nb_proc" => {
		"perl" => '" -a 2"',
	},
	"query" => {
		"perl" => '" -i $query" ',
	},
	"start_region" => {
	},
	"end_region" => {
		"perl" => '(defined $value) ? " -L \"$start_region $value\"": " -L $start_region"',
	},
	"protein_db" => {
		"perl" => ' " -d $value" ',
	},
	"nucleotid_db" => {
		"perl" => ' " -d $value" ',
	},
	"filter_opt" => {
	},
	"filter" => {
		"perl" => '($value) ? "" : " -F F"',
	},
	"other_filters" => {
	},
	"lower_case" => {
		"perl" => '($value)? " -U T" : ""',
	},
	"selectivity_opt" => {
	},
	"Expect" => {
		"perl" => '(defined $value && $value != $vdef)? " -e $value":""',
	},
	"word_size" => {
		"perl" => '(defined $value) ? " -W $value" : ""',
	},
	"dist_hits" => {
		"perl" => '(defined $value) ? " -A $value" : ""',
	},
	"extend_hit" => {
		"perl" => '($value)? " -f $value":""',
	},
	"dropoff_extent" => {
		"perl" => '(defined $value) ? " -y $value" : ""',
	},
	"keep_hits" => {
		"perl" => '(defined $value) ? " -K $value" : ""',
	},
	"gapped_alig" => {
		"perl" => '($value)? "": " -g F"',
	},
	"dropoff" => {
		"perl" => '(defined $value)? " -X $value":""',
	},
	"dropoff_final" => {
		"perl" => '(defined $value) ? " -Z $value" : ""',
	},
	"scoring_opt" => {
	},
	"mismatch" => {
		"perl" => '(defined $value && $value != $vdef)? " -q $value":""',
	},
	"match" => {
		"perl" => '(defined $value && $value != $vdef)? " -r $value":""',
	},
	"matrix" => {
		"perl" => '(defined $value && $value ne $vdef)? " -M $value" : ""',
	},
	"open_a_gap" => {
		"perl" => '(defined $value)? " -G $value":""',
	},
	"extend_a_gap" => {
		"perl" => '(defined $value)? " -E $value":""',
	},
	"translation_opt" => {
	},
	"gc_query" => {
		"perl" => '(defined $value  &&  $value != $vdef)? " -Q $value":""',
	},
	"gc_db" => {
		"perl" => '($value != $vdef) ? " -D $value":""',
	},
	"strand" => {
		"perl" => '($value && $value != $vdef) ? " -S $value" : ""',
	},
	"affichage" => {
	},
	"Descriptions" => {
		"perl" => '(defined $value && $value != $vdef)? " -v $value":""',
	},
	"Alignments" => {
		"perl" => '(defined $value && $value != $vdef)? " -b $value":""',
	},
	"view_alignments" => {
		"perl" => '($value)? " -m $value" : "" ',
	},
	"show_gi" => {
		"perl" => '($value)? " -I" : "" ',
	},
	"seqalign_file" => {
		"perl" => '($value)? " -O $value" : ""',
	},
	"believe" => {
		"perl" => '($value)? " -J":""',
	},
	"htmloutput" => {
		"perl" => '($value)? " && html4blast -o blast2.html -g" : ""',
	},
	"htmlopt" => {
	},
	"html4blast_input" => {
		"perl" => '" blast2.txt"',
	},
	"external_links" => {
		"perl" => '($value)? " -e" : " -s" ',
	},
	"one_HSP_per_line" => {
		"perl" => '($value)? " -l" : "" ',
	},
	"image_query" => {
		"perl" => '($value)? " -q" : "" ',
	},
	"htmlfile" => {
	},
	"othersopt" => {
	},
	"restrict_db" => {
		"perl" => '(defined $value) ? " -l $value" : ""',
	},
	"psi_checkpoint" => {
		"perl" => '(defined $value) ? " -R $value" : ""',
	},
	"txtoutput" => {
		"perl" => '" > blast2.txt"',
	},
	"tmp_outfile" => {
	},
	"xmloutput" => {
		"perl" => '" > blast2.xml"',
	},

    };

    $self->{FILENAMES}  = {
	"htmlfile" => 'blast2.html',
	"tmp_outfile" => 'blast2.txt',
	"xmloutput" => 'blast2.xml',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"blast_init" => -10,
	"blast2" => 1,
	"nb_proc" => 6,
	"query" => 3,
	"end_region" => 5,
	"protein_db" => 2,
	"nucleotid_db" => 3,
	"filter_opt" => 4,
	"filter" => 4,
	"other_filters" => 4,
	"lower_case" => 4,
	"selectivity_opt" => 5,
	"Expect" => 5,
	"word_size" => 5,
	"dist_hits" => 5,
	"extend_hit" => 5,
	"dropoff_extent" => 5,
	"keep_hits" => 5,
	"gapped_alig" => 5,
	"dropoff" => 5,
	"dropoff_final" => 5,
	"scoring_opt" => 4,
	"mismatch" => 4,
	"match" => 4,
	"matrix" => 4,
	"open_a_gap" => 4,
	"extend_a_gap" => 5,
	"gc_query" => 4,
	"gc_db" => 4,
	"Descriptions" => 5,
	"Alignments" => 5,
	"view_alignments" => 4,
	"show_gi" => 4,
	"seqalign_file" => 4,
	"believe" => 4,
	"htmloutput" => 20,
	"html4blast_input" => 30,
	"external_links" => 25,
	"one_HSP_per_line" => 25,
	"image_query" => 25,
	"othersopt" => 5,
	"restrict_db" => 7,
	"psi_checkpoint" => 5,
	"txtoutput" => 7,
	"xmloutput" => 7,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"blast_init",
	"tmp_outfile",
	"htmlopt",
	"htmlfile",
	"start_region",
	"affichage",
	"strand",
	"translation_opt",
	"blast2",
	"protein_db",
	"query",
	"nucleotid_db",
	"gc_query",
	"gc_db",
	"filter_opt",
	"filter",
	"other_filters",
	"lower_case",
	"view_alignments",
	"show_gi",
	"seqalign_file",
	"believe",
	"scoring_opt",
	"mismatch",
	"match",
	"matrix",
	"open_a_gap",
	"extend_hit",
	"end_region",
	"selectivity_opt",
	"Expect",
	"word_size",
	"dist_hits",
	"Descriptions",
	"Alignments",
	"extend_a_gap",
	"dropoff_final",
	"dropoff",
	"gapped_alig",
	"keep_hits",
	"dropoff_extent",
	"othersopt",
	"psi_checkpoint",
	"nb_proc",
	"restrict_db",
	"txtoutput",
	"xmloutput",
	"htmloutput",
	"image_query",
	"one_HSP_per_line",
	"external_links",
	"html4blast_input",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"blast_init" => 1,
	"blast2" => 0,
	"nb_proc" => 1,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"word_size" => 0,
	"dist_hits" => 0,
	"extend_hit" => 0,
	"dropoff_extent" => 0,
	"keep_hits" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_final" => 0,
	"scoring_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"translation_opt" => 0,
	"gc_query" => 0,
	"gc_db" => 0,
	"strand" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"show_gi" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"htmloutput" => 0,
	"htmlopt" => 0,
	"html4blast_input" => 1,
	"external_links" => 0,
	"one_HSP_per_line" => 0,
	"image_query" => 0,
	"htmlfile" => 0,
	"othersopt" => 0,
	"restrict_db" => 0,
	"psi_checkpoint" => 0,
	"txtoutput" => 1,
	"tmp_outfile" => 0,
	"xmloutput" => 0,

    };

    $self->{ISCOMMAND}  = {
	"blast_init" => 0,
	"blast2" => 1,
	"nb_proc" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"word_size" => 0,
	"dist_hits" => 0,
	"extend_hit" => 0,
	"dropoff_extent" => 0,
	"keep_hits" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_final" => 0,
	"scoring_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"translation_opt" => 0,
	"gc_query" => 0,
	"gc_db" => 0,
	"strand" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"show_gi" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"htmloutput" => 0,
	"htmlopt" => 0,
	"html4blast_input" => 0,
	"external_links" => 0,
	"one_HSP_per_line" => 0,
	"image_query" => 0,
	"htmlfile" => 0,
	"othersopt" => 0,
	"restrict_db" => 0,
	"psi_checkpoint" => 0,
	"txtoutput" => 0,
	"tmp_outfile" => 0,
	"xmloutput" => 0,

    };

    $self->{ISMANDATORY}  = {
	"blast_init" => 0,
	"blast2" => 1,
	"nb_proc" => 0,
	"query" => 1,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"word_size" => 0,
	"dist_hits" => 0,
	"extend_hit" => 0,
	"dropoff_extent" => 0,
	"keep_hits" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_final" => 0,
	"scoring_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"translation_opt" => 0,
	"gc_query" => 0,
	"gc_db" => 0,
	"strand" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"show_gi" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"htmloutput" => 0,
	"htmlopt" => 0,
	"html4blast_input" => 0,
	"external_links" => 0,
	"one_HSP_per_line" => 0,
	"image_query" => 0,
	"htmlfile" => 0,
	"othersopt" => 0,
	"restrict_db" => 0,
	"psi_checkpoint" => 0,
	"txtoutput" => 0,
	"tmp_outfile" => 0,
	"xmloutput" => 0,

    };

    $self->{PROMPT}  = {
	"blast_init" => "",
	"blast2" => "Blast program",
	"nb_proc" => "",
	"query" => "Sequence File",
	"start_region" => "Start of required region in query sequence (-L)",
	"end_region" => "End of required region in query sequence (-L)",
	"protein_db" => "protein db",
	"nucleotid_db" => "nucleotid db",
	"filter_opt" => "Filtering and masking options",
	"filter" => "Filter query sequence (DUST with blastn, SEG with others) (-F)",
	"other_filters" => "Filtering options (-F must be true)",
	"lower_case" => "Use lower case filtering (-U)",
	"selectivity_opt" => "Selectivity options",
	"Expect" => "Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)",
	"word_size" => "Word Size (-W) (zero invokes default behavior)",
	"dist_hits" => "Multiple Hits window size (zero for single hit algorithm) (-A)",
	"extend_hit" => "Threshold for extending hits (-f)",
	"dropoff_extent" => "X dropoff for blast extention in bits (0.0 invokes default behavior) (-y)",
	"keep_hits" => "Number of best hits from region to keep (-K)",
	"gapped_alig" => "Perform gapped alignment (not available with tblastx) (-g)",
	"dropoff" => "X dropoff value for gapped alignment (in bits) (-X)",
	"dropoff_final" => "X dropoff value for final alignment (in bits) (-Z)",
	"scoring_opt" => "Scoring options",
	"mismatch" => "Penalty for a nucleotide mismatch (blastn) (-q)",
	"match" => "Reward for a nucleotide match (blastn) (-r)",
	"matrix" => "Matrix (-M)",
	"open_a_gap" => "Cost to open a gap (-G)",
	"extend_a_gap" => "Cost to extend a gap (-E)",
	"translation_opt" => "Translation options",
	"gc_query" => "Query Genetic code to use (blastx) (-Q)",
	"gc_db" => "DB Genetic code (for tblast[nx] only) (-D)",
	"strand" => "Query strand to search against database (for blastx and tblastx) (-S)",
	"affichage" => "Report options",
	"Descriptions" => "How many short descriptions? (-v)",
	"Alignments" => "How many alignments? (-b)",
	"view_alignments" => "Alignment view options  (not with blastx/tblastx) (-m)",
	"show_gi" => "Show GI's in deflines (only available for NCBI db such as nrprot) (-I)",
	"seqalign_file" => "SeqAlign file (-J option must be true) (-O)",
	"believe" => "Believe the query defline (-J)",
	"htmloutput" => "Html output",
	"htmlopt" => "HTML output options (html4blast)",
	"html4blast_input" => "",
	"external_links" => "Use external web sites for databases entries retrieval links (-e instead of -s)",
	"one_HSP_per_line" => "Draw one HSP per line in image instead of putting all HSP in one line (-l)",
	"image_query" => "Generate images names based on corresponding query (-q)",
	"htmlfile" => "",
	"othersopt" => "Other Options",
	"restrict_db" => "Restrict search of database to GI's in file (-l)",
	"psi_checkpoint" => "PSI-TBLASTN checkpoint file (-R)",
	"txtoutput" => "",
	"tmp_outfile" => "",
	"xmloutput" => "",

    };

    $self->{ISSTANDOUT}  = {
	"blast_init" => 0,
	"blast2" => 0,
	"nb_proc" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"word_size" => 0,
	"dist_hits" => 0,
	"extend_hit" => 0,
	"dropoff_extent" => 0,
	"keep_hits" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_final" => 0,
	"scoring_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"translation_opt" => 0,
	"gc_query" => 0,
	"gc_db" => 0,
	"strand" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"show_gi" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"htmloutput" => 0,
	"htmlopt" => 0,
	"html4blast_input" => 0,
	"external_links" => 0,
	"one_HSP_per_line" => 0,
	"image_query" => 0,
	"htmlfile" => 0,
	"othersopt" => 0,
	"restrict_db" => 0,
	"psi_checkpoint" => 0,
	"txtoutput" => 0,
	"tmp_outfile" => 0,
	"xmloutput" => 0,

    };

    $self->{VLIST}  = {

	"blast2" => ['blastn','blastn: nucleotide query / nucleotide db','blastp','blastp: amino acid query / protein db','blastx','blastx: nucleotide query translated / protein db','tblastn','tblastn: protein query / translated nucleotide db','tblastx','tblastx: nucleotide query transl. / transl. nucleotide db','psitblastn','psitblastn: protein query / transl. nucleotide db',],
	"protein_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','sbase','sbase: annotated domains sequences',],
	"nucleotid_db" => ['embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"filter_opt" => ['filter','other_filters','lower_case',],
	"other_filters" => ['v1','masking instead of filtering (with Seg)','v2','coiled-coiled filter','v3','both seg and coiled-coiled filters','v4','dust filter (DNA query)','v5','lower-case masking (-U must be true)',],
	"selectivity_opt" => ['Expect','word_size','dist_hits','extend_hit','dropoff_extent','keep_hits','gapped_alig','dropoff','dropoff_final',],
	"scoring_opt" => ['mismatch','match','matrix','open_a_gap','extend_a_gap',],
	"matrix" => ['BLOSUM62','BLOSUM62','BLOSUM45','BLOSUM45','BLOSUM80','BLOSUM80','PAM30','PAM30','PAM70','PAM70',],
	"translation_opt" => ['gc_query','gc_db','strand',],
	"gc_query" => ['1','1: Standard','2','2: Vertebrate Mitochondrial','3','3: Yeast Mitochondrial','4','4: Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','5: Invertebrate Mitochondrial','6','6: Ciliate Macronuclear and Dasycladacean','9','9: Echinoderm Mitochondrial','10','10: Euplotid Nuclear','11','11: Bacterial','12','12: Alternative Yeast Nuclear','13','13: Ascidian Mitochondrial','14','14: Flatworm Mitochondrial','15','15: Blepharisma Macronuclear',],
	"gc_db" => ['1','1: Standard','2','2: Vertebrate Mitochondrial','3','3: Yeast Mitochondrial','4','4: Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','5: Invertebrate Mitochondrial','6','6: Ciliate Macronuclear and Dasycladacean','9','9: Echinoderm Mitochondrial','10','10: Euplotid Nuclear','11','11: Bacterial','12','12: Alternative Yeast Nuclear','13','13: Ascidian Mitochondrial','14','14: Flatworm Mitochondrial','15','15: Blepharisma Macronuclear',],
	"strand" => ['1','1: top','2','2: bottom','3','3:both',],
	"affichage" => ['Descriptions','Alignments','view_alignments','show_gi','seqalign_file','believe','htmloutput','htmlopt',],
	"view_alignments" => ['0','0: pairwise','1','1: query-anchored showing identities','2','2: query-anchored no identities','3','3: flat query-anchored, show identities','4','4: flat query-anchored, no identities','5','5: query-anchored no identities and blunt ends','6','6: flat query-anchored, no identities and blunt ends','7','7: XML Blast output','8','8: Tabular output',],
	"htmlopt" => ['html4blast_input','external_links','one_HSP_per_line','image_query','htmlfile',],
	"othersopt" => ['restrict_db','psi_checkpoint',],
    };

    $self->{FLIST}  = {

	"other_filters" => {
		'v1' => '" -F \"m S\""',
		'v2' => '" -F C"',
		'v3' => '" -F \"C;S\""',
		'v4' => '" -F D"',
		'v5' => '" -F m"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"blast2" => 'blastp',
	"protein_db" => 'sptrnrdb',
	"nucleotid_db" => 'embl',
	"filter" => '1',
	"lower_case" => '0',
	"Expect" => '10',
	"gapped_alig" => '1',
	"mismatch" => '-3',
	"match" => '1',
	"matrix" => 'BLOSUM62',
	"gc_query" => '1',
	"gc_db" => '1',
	"strand" => '3',
	"Descriptions" => '500',
	"Alignments" => '250',
	"view_alignments" => '0',
	"show_gi" => '0',
	"believe" => '0',
	"htmloutput" => '1',
	"external_links" => '0',
	"one_HSP_per_line" => '0',
	"image_query" => '0',

    };

    $self->{PRECOND}  = {
	"blast_init" => { "perl" => '1' },
	"blast2" => { "perl" => '1' },
	"nb_proc" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"start_region" => { "perl" => '1' },
	"end_region" => {
		"perl" => '$start_region',
	},
	"protein_db" => {
		"perl" => '$blast2 =~ /^blast[px]/',
	},
	"nucleotid_db" => {
		"perl" => '$blast2 =~ /^blastn|tblast[nx]$/',
	},
	"filter_opt" => { "perl" => '1' },
	"filter" => { "perl" => '1' },
	"other_filters" => { "perl" => '1' },
	"lower_case" => { "perl" => '1' },
	"selectivity_opt" => { "perl" => '1' },
	"Expect" => { "perl" => '1' },
	"word_size" => { "perl" => '1' },
	"dist_hits" => { "perl" => '1' },
	"extend_hit" => { "perl" => '1' },
	"dropoff_extent" => { "perl" => '1' },
	"keep_hits" => { "perl" => '1' },
	"gapped_alig" => {
		"perl" => '$blast2 ne "tblastx"',
	},
	"dropoff" => { "perl" => '1' },
	"dropoff_final" => { "perl" => '1' },
	"scoring_opt" => { "perl" => '1' },
	"mismatch" => {
		"perl" => '$blast2 eq "blastn"',
	},
	"match" => {
		"perl" => '$blast2 eq "blastn"',
	},
	"matrix" => {
		"perl" => '$blast2 ne "blastn"',
	},
	"open_a_gap" => { "perl" => '1' },
	"extend_a_gap" => { "perl" => '1' },
	"translation_opt" => { "perl" => '1' },
	"gc_query" => {
		"perl" => '$blast2 =~ /blastx$/',
	},
	"gc_db" => {
		"perl" => '$blast2 =~ /^tblast/',
	},
	"strand" => {
		"perl" => '$blast =~ /blastx$/',
	},
	"affichage" => { "perl" => '1' },
	"Descriptions" => { "perl" => '1' },
	"Alignments" => { "perl" => '1' },
	"view_alignments" => {
		"perl" => '$blast2 !~ /blastx$/',
	},
	"show_gi" => {
		"perl" => '$protein_db eq "nrprot"',
	},
	"seqalign_file" => {
		"perl" => '$believe',
	},
	"believe" => { "perl" => '1' },
	"htmloutput" => {
		"perl" => '($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"htmlopt" => {
		"perl" => '$htmloutput && ($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"html4blast_input" => {
		"perl" => '$htmloutput && ($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"external_links" => {
		"perl" => '$htmloutput && ($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"one_HSP_per_line" => {
		"perl" => '$htmloutput && ($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"image_query" => {
		"perl" => '$htmloutput && ($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"htmlfile" => {
		"perl" => '$htmloutput && ($_html) && ($view_alignments !~ /^[78]$/)',
	},
	"othersopt" => { "perl" => '1' },
	"restrict_db" => {
		"perl" => '$protein_db eq "nrprot"',
	},
	"psi_checkpoint" => {
		"perl" => '$blast2 eq psitblastn',
	},
	"txtoutput" => {
		"perl" => '$view_alignments !~ 7',
	},
	"tmp_outfile" => { "perl" => '1' },
	"xmloutput" => {
		"perl" => '$view_alignments =~ 7',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"tmp_outfile" => {
		 '$view_alignments !~ [78]' => "blast_output",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"query" => {
		 "seqfile" => '1',
	},
	"psi_checkpoint" => {
		 "psiblast_matrix" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {
	"psi_checkpoint" => {
		 "psiblast_matrix" => ["query",]
	},

    };

    $self->{ISCLEAN}  = {
	"blast_init" => 0,
	"blast2" => 0,
	"nb_proc" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"word_size" => 0,
	"dist_hits" => 0,
	"extend_hit" => 0,
	"dropoff_extent" => 0,
	"keep_hits" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_final" => 0,
	"scoring_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"translation_opt" => 0,
	"gc_query" => 0,
	"gc_db" => 0,
	"strand" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"show_gi" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"htmloutput" => 0,
	"htmlopt" => 0,
	"html4blast_input" => 0,
	"external_links" => 0,
	"one_HSP_per_line" => 0,
	"image_query" => 0,
	"htmlfile" => 0,
	"othersopt" => 0,
	"restrict_db" => 0,
	"psi_checkpoint" => 0,
	"txtoutput" => 0,
	"tmp_outfile" => 0,
	"xmloutput" => 0,

    };

    $self->{ISSIMPLE}  = {
	"blast_init" => 0,
	"blast2" => 1,
	"nb_proc" => 0,
	"query" => 1,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"other_filters" => 0,
	"lower_case" => 0,
	"selectivity_opt" => 0,
	"Expect" => 1,
	"word_size" => 0,
	"dist_hits" => 0,
	"extend_hit" => 0,
	"dropoff_extent" => 0,
	"keep_hits" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_final" => 0,
	"scoring_opt" => 0,
	"mismatch" => 0,
	"match" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"translation_opt" => 0,
	"gc_query" => 0,
	"gc_db" => 0,
	"strand" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"show_gi" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"htmloutput" => 0,
	"htmlopt" => 0,
	"html4blast_input" => 0,
	"external_links" => 0,
	"one_HSP_per_line" => 0,
	"image_query" => 0,
	"htmlfile" => 0,
	"othersopt" => 0,
	"restrict_db" => 0,
	"psi_checkpoint" => 0,
	"txtoutput" => 0,
	"tmp_outfile" => 0,
	"xmloutput" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"blast2" => [
		"The five BLAST programs described here perform the following tasks:",
		". blastp compares an amino acid query sequence against a protein sequence database;",
		". blastn compares a nucleotide query sequence against a nucleotide sequence database;",
		". blastx compares the six-frame conceptual translation products of a nucleotide query sequence (both strands) against a protein sequence database;",
		". tblastn compares a protein query sequence against a nucleotide sequence database dynamically translated in all six reading frames (both strands).",
		". tblastx compares the six-frame translations of a nucleotide query sequence against the six-frame translations of a nucleotide sequence database.",
		"psitblastn compares a protein query sequence against a nucleotide sequence database dynamically translated in all six reading frames (both strands) using a position specific matrix created by PSI-BLAST.",
	],
	"protein_db" => [
		"Choose a protein db for blastp or blastx.",
		"Please note that Swissprot usage by and for commercial entities requires a license agreement.",
	],
	"nucleotid_db" => [
		"choose a nucleotide db for blastn, tblastn or tblastx",
	],
	"filter_opt" => [
		"BLAST 2.0 and 2.1 uses the dust low-complexity filter for blastn and seg for the other programs. Both \'dust\' and \'seg\' are integral parts of the NCBI toolkit and are accessed automatically.",
		"If one uses \'-F T\' then normal filtering by seg or dust (for blastn) occurs (likewise \'-F F\' means no filtering whatsoever). ",
		"This options also takes a string as an argument.  One may use such a string to change the specific parameters of seg or invoke other filters. Please see the \'Filtering Strings\' section (below) for details.",
	],
	"other_filters" => [
		"The -F argument can take a string as input specifying that seg should be run with certain values or that other non-standard filters should be used.",
		" A coiled-coiled filter, based on the work of Lupas et al. (Science, vol 252, pp. 1162-4 (1991)) written by John Kuzio (Wilson et al., J Gen Virol, vol. 76, pp. 2923-32 (1995)), may be invoked specifying: -F \'C\'",
		" One may also run both seg and coiled-coiled together by using a \';\': -F \'C;S\'",
		" Filtering by dust may also be specified by: -F \'D\'",
		" It is possible to specify that the masking should only be done during the process of building the initial words by starting the filtering command with \'m\', e.g.: -F \'m S\' which specifies that seg (with default arguments) should be used for masking, but that the masking should only be done when the words are being built.",
		" If the -U option (to mask any lower-case sequence in the input FASTA file) is used and one does not wish any other filtering, but does wish to mask when building the lookup tables then one should specify: -F \'m\'",
	],
	"lower_case" => [
		" This option specifies that any lower-case letters in the input FASTA file should be masked.",
	],
	"selectivity_opt" => [
		"The programs blastn and blastp offer fully gapped alignments. blastx and tblastn have \'in-frame\' gapped alignments and use sum statistics to link alignments from different frames. tblastx provides only ungapped alignments.",
	],
	"Expect" => [
		"The statistical significance threshold for reporting matches against database sequences; the default value is 10, such that 10 matches are expected to be found merely by chance, according to the stochastic model of Karlin and Altschul (1990). If the statistical significance ascribed to a match is greater than the EXPECT threshold, the match will not be reported. Lower EXPECT thresholds are more stringent, leading to fewer chance matches being reported. Fractional values are acceptable. ",
	],
	"extend_hit" => [
		"Blast seeks first short word pairs whose aligned score reaches at least this value (default for blastp is 11) (T in the NAR paper and in Blast 1.4)",
	],
	"keep_hits" => [
		"If this option is used a value of 100 is recommended.",
	],
	"dropoff" => [
		"This is the value that control the path graph region explored by Blast during a gapped extension (Xg in the NAR paper) (default for blastp is 15).",
	],
	"open_a_gap" => [
		"default is 5 for blastn, 10 for blastp, blastx and tblastn",
	],
	"extend_a_gap" => [
		"default is 2 for blastn, 1 for blastp, blastx and tblastn",
		"Limited values for gap existence and extension are supported for these three programs. Some supported and suggested values are:",
		"Existence Extension",
		"10 1",
		"10 2",
		"11 1",
		"8 2",
		"9 2",
		"(source: NCBI Blast page)",
	],
	"Descriptions" => [
		"Maximum number of database sequences for which one-line descriptions will be reported (-v).",
	],
	"Alignments" => [
		"Maximum number of database sequences for which high-scoring segment pairs will be reported (-b).",
	],
	"show_gi" => [
		"Causes NCBI gi identifiers to be shown in the output, in addition to the accession and/or locus name. ",
		"Warning: only available for NCBI db such as nrprot.",
	],
	"seqalign_file" => [
		"SeqAlign is in ASN.1 format, so that it can be read with NCBI tools (such as sequin). This allows one to view the results in different formats.",
	],
	"external_links" => [
		"-s option will use SRS for databases entries retrieval links, whereas -e will use the original database site links.",
	],
	"one_HSP_per_line" => [
		"Useful for genomes searching, where there is only one sequence in the database.",
	],
	"image_query" => [
		"Useful when you only want to keep the image.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blast2.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

