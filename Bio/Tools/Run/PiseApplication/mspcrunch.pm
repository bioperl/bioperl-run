# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::mspcrunch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::mspcrunch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mspcrunch

      Bioperl class for:

	MSPcrunch	a BLAST post-processing filter (Sonnhammer, Durbin)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/mspcrunch.html 
         for available values):


		mspcrunch (String)

		blast_output (InFile)
			BLAST output File
			pipe: blast_output

		outfile (OutFile)
			Result file

		gapped (Switch)
			Make gapped alignment of ungapped-MSP contigs (-G)

		big_pict (Switch)
			Big Picture (-P)

		sfs (Switch)
			Produce SFS    output (-H)

		seqbl (Switch)
			Produce seqbl  output (for Blixem) (-q)

		ace (Switch)
			Produce .ace   output (for ACEDB 4) (-4)

		exblx (Switch)
			Produce exblx  output (for easy parsing) (-x)

		exbldb (Switch)
			Produce exbldb output (as exblx with query names) (-d)

		fasta (Switch)
			Produce fasta  output (unaligned, for mult.alignm.) (-2)

		three_frame (Switch)
			Print 3 frame translation (blastn only) (-3)

		footer (Switch)
			Print footer with parameters and stats (-f)

		matches_one_line (Switch)
			For -P output, force all matches to the same subject on one line (-F)

		percentage_id (Switch)
			Print percentage identity (seqbl output only) (-i)

		stats_file (OutFile)
			Output coverage stats to file (-o)

		domainer (Switch)
			Produce output for Domainer (trim overlaps) (-D)

		silent_mutations (Switch)
			Do Statistics of Silent mutations (only cDNA!) (-S)

		all_expected (Switch)
			Print all Expected scores (default only when positive) (-X)

		matrix_stats (Switch)
			Print statistics on used matrices (-E)

		stats_without_X (Switch)
			Recalculate percentage identity, ignoring X residues. (-j)

		ignore_hits (Switch)
			Ignore hits to earlier seqnames (for All-vs-All). (-A)

		line_length (Integer)
			Line length of Wrapped alignment (0 -> no wrapping) (-W)

		wublast_numbered (Switch)
			indicate query insertions with numbers (For seqbl output from Wublast) (-N)

		dont_reject (Switch)
			Don't reject any MSPs (-w)

		report_rejected (Switch)
			Report only rejected MSPs (-r)

		threshold (Float)
			Reject all matches with less than this % identity (-I)

		expect (Float)
			Reject all matches with E-value higher than this value (-e)

		whole_contig (Switch)
			Coverage limitation requires whole contig to be covered (always for Blastp) (-a)

		hits_to_self (Switch)
			Accept hits to self (-s)

		no_hits_to_earlier (Switch)
			Ignore hits to earlier seqnames (for All-vs-All) (-A)

		dont_mirror (Switch)
			Don't mirror (i.e. print the subject object) in ACE4 format (-M)

		old_cutoff (Switch)
			 Use old step cutoffs for adjacency instead of the new continuous system. (-O)

		force_blastp (Switch)
			Force Blastp mode (default Blastx) (-p)

		force_blastn (Switch)
			Force Blastn mode (default Blastx) (-n)

		matrix (String)
			Scoring matrix (PAM or BLOSUM, see help) (-m)

		query (Sequence)
			Read in query seq (for rereading .seqbl files) (-Q)

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

http://bioweb.pasteur.fr/seqanal/interfaces/mspcrunch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::mspcrunch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mspcrunch = Bio::Tools::Run::PiseApplication::mspcrunch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mspcrunch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $mspcrunch = $factory->program('mspcrunch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::mspcrunch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mspcrunch.pm

    $self->{COMMAND}   = "mspcrunch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MSPcrunch";

    $self->{DESCRIPTION}   = "a BLAST post-processing filter";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Sonnhammer, Durbin";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mspcrunch",
	"blast_output",
	"output_options",
	"control_options",
	"input_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mspcrunch",
	"blast_output", 	# BLAST output File
	"output_options", 	# Output Options
	"outfile", 	# Result file
	"gapped", 	# Make gapped alignment of ungapped-MSP contigs (-G)
	"big_pict", 	# Big Picture (-P)
	"sfs", 	# Produce SFS    output (-H)
	"seqbl", 	# Produce seqbl  output (for Blixem) (-q)
	"ace", 	# Produce .ace   output (for ACEDB 4) (-4)
	"exblx", 	# Produce exblx  output (for easy parsing) (-x)
	"exbldb", 	# Produce exbldb output (as exblx with query names) (-d)
	"fasta", 	# Produce fasta  output (unaligned, for mult.alignm.) (-2)
	"three_frame", 	# Print 3 frame translation (blastn only) (-3)
	"footer", 	# Print footer with parameters and stats (-f)
	"matches_one_line", 	# For -P output, force all matches to the same subject on one line (-F)
	"percentage_id", 	# Print percentage identity (seqbl output only) (-i)
	"stats_file", 	# Output coverage stats to file (-o)
	"domainer", 	# Produce output for Domainer (trim overlaps) (-D)
	"silent_mutations", 	# Do Statistics of Silent mutations (only cDNA!) (-S)
	"all_expected", 	# Print all Expected scores (default only when positive) (-X)
	"matrix_stats", 	# Print statistics on used matrices (-E)
	"stats_without_X", 	# Recalculate percentage identity, ignoring X residues. (-j)
	"ignore_hits", 	# Ignore hits to earlier seqnames (for All-vs-All). (-A)
	"line_length", 	# Line length of Wrapped alignment (0 -> no wrapping) (-W)
	"wublast_numbered", 	# indicate query insertions with numbers (For seqbl output from Wublast) (-N)
	"control_options", 	# Control Options
	"dont_reject", 	# Don't reject any MSPs (-w)
	"report_rejected", 	# Report only rejected MSPs (-r)
	"threshold", 	# Reject all matches with less than this % identity (-I)
	"expect", 	# Reject all matches with E-value higher than this value (-e)
	"whole_contig", 	# Coverage limitation requires whole contig to be covered (always for Blastp) (-a)
	"hits_to_self", 	# Accept hits to self (-s)
	"no_hits_to_earlier", 	# Ignore hits to earlier seqnames (for All-vs-All) (-A)
	"dont_mirror", 	# Don't mirror (i.e. print the subject object) in ACE4 format (-M)
	"old_cutoff", 	#  Use old step cutoffs for adjacency instead of the new continuous system. (-O)
	"input_options", 	# Input Options
	"force_blastp", 	# Force Blastp mode (default Blastx) (-p)
	"force_blastn", 	# Force Blastn mode (default Blastx) (-n)
	"matrix", 	# Scoring matrix (PAM or BLOSUM, see help) (-m)
	"query", 	# Read in query seq (for rereading .seqbl files) (-Q)

    ];

    $self->{TYPE}  = {
	"mspcrunch" => 'String',
	"blast_output" => 'InFile',
	"output_options" => 'Paragraph',
	"outfile" => 'OutFile',
	"gapped" => 'Switch',
	"big_pict" => 'Switch',
	"sfs" => 'Switch',
	"seqbl" => 'Switch',
	"ace" => 'Switch',
	"exblx" => 'Switch',
	"exbldb" => 'Switch',
	"fasta" => 'Switch',
	"three_frame" => 'Switch',
	"footer" => 'Switch',
	"matches_one_line" => 'Switch',
	"percentage_id" => 'Switch',
	"stats_file" => 'OutFile',
	"domainer" => 'Switch',
	"silent_mutations" => 'Switch',
	"all_expected" => 'Switch',
	"matrix_stats" => 'Switch',
	"stats_without_X" => 'Switch',
	"ignore_hits" => 'Switch',
	"line_length" => 'Integer',
	"wublast_numbered" => 'Switch',
	"control_options" => 'Paragraph',
	"dont_reject" => 'Switch',
	"report_rejected" => 'Switch',
	"threshold" => 'Float',
	"expect" => 'Float',
	"whole_contig" => 'Switch',
	"hits_to_self" => 'Switch',
	"no_hits_to_earlier" => 'Switch',
	"dont_mirror" => 'Switch',
	"old_cutoff" => 'Switch',
	"input_options" => 'Paragraph',
	"force_blastp" => 'Switch',
	"force_blastn" => 'Switch',
	"matrix" => 'String',
	"query" => 'Sequence',

    };

    $self->{FORMAT}  = {
	"mspcrunch" => {
		"perl" => '"MSPcrunch"',
	},
	"blast_output" => {
		"perl" => '" $value"',
	},
	"output_options" => {
	},
	"outfile" => {
		"perl" => ' " > $value " ',
	},
	"gapped" => {
		"perl" => '($value) ? " -G" : "" ',
	},
	"big_pict" => {
		"perl" => '($value) ? " -P" : "" ',
	},
	"sfs" => {
		"perl" => '($value) ? " -H" : ""',
	},
	"seqbl" => {
		"perl" => '($value) ? " -q" : "" ',
	},
	"ace" => {
		"perl" => '($value) ? " -4" : "" ',
	},
	"exblx" => {
		"perl" => '($value) ? " -x" : "" ',
	},
	"exbldb" => {
		"perl" => '($value) ? " -d" : "" ',
	},
	"fasta" => {
		"perl" => '($value) ? " -2" : "" ',
	},
	"three_frame" => {
		"perl" => '($value) ? " -3" : "" ',
	},
	"footer" => {
		"perl" => '($value) ? " -f" : "" ',
	},
	"matches_one_line" => {
		"perl" => '($value) ? " -F" : "" ',
	},
	"percentage_id" => {
		"perl" => '($value) ? " -i" : "" ',
	},
	"stats_file" => {
		"perl" => '($value) ? " -o $value" : "" ',
	},
	"domainer" => {
		"perl" => '($value) ? " -D" : "" ',
	},
	"silent_mutations" => {
		"perl" => '($value) ? " -S" : "" ',
	},
	"all_expected" => {
		"perl" => '($value) ? " -X" : "" ',
	},
	"matrix_stats" => {
		"perl" => '($value) ? " -E" : "" ',
	},
	"stats_without_X" => {
		"perl" => '($value) ? " -j" : "" ',
	},
	"ignore_hits" => {
		"perl" => '($value) ? " -A" : "" ',
	},
	"line_length" => {
		"perl" => '(defined $value) ? " -W $value" : "" ',
	},
	"wublast_numbered" => {
		"perl" => '($value) ? " -N" : "" ',
	},
	"control_options" => {
	},
	"dont_reject" => {
		"perl" => '($value) ? " -w" : "" ',
	},
	"report_rejected" => {
		"perl" => '($value) ? " -r" : "" ',
	},
	"threshold" => {
		"perl" => '(defined $value) ? " -I $value" : "" ',
	},
	"expect" => {
		"perl" => '(defined $value) ? " -e $value" : ""',
	},
	"whole_contig" => {
		"perl" => '($value) ? " -a" : "" ',
	},
	"hits_to_self" => {
		"perl" => '($value) ? " -s" : "" ',
	},
	"no_hits_to_earlier" => {
		"perl" => '($value) ? " -A" : "" ',
	},
	"dont_mirror" => {
		"perl" => '($value) ? " -M" : "" ',
	},
	"old_cutoff" => {
		"perl" => '($value) ? " -O" : "" ',
	},
	"input_options" => {
	},
	"force_blastp" => {
		"perl" => '($value) ? " -p" : "" ',
	},
	"force_blastn" => {
		"perl" => '($value) ? " -n" : "" ',
	},
	"matrix" => {
		"perl" => ' ($value)?" -m /local/gensoft/lib/MSPcrunch/matrix/$value":""',
	},
	"query" => {
		"perl" => '($value)? " -Q $query" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"mspcrunch" => 0,
	"blast_output" => 2,
	"output_options" => 1,
	"outfile" => 1000,
	"gapped" => 1,
	"big_pict" => 1,
	"sfs" => 1,
	"seqbl" => 1,
	"ace" => 1,
	"exblx" => 1,
	"exbldb" => 1,
	"fasta" => 1,
	"three_frame" => 1,
	"footer" => 1,
	"matches_one_line" => 1,
	"percentage_id" => 1,
	"stats_file" => 1,
	"domainer" => 1,
	"silent_mutations" => 1,
	"all_expected" => 1,
	"matrix_stats" => 1,
	"stats_without_X" => 1,
	"ignore_hits" => 1,
	"line_length" => 1,
	"wublast_numbered" => 1,
	"control_options" => 1,
	"dont_reject" => 1,
	"report_rejected" => 1,
	"threshold" => 1,
	"expect" => 1,
	"whole_contig" => 1,
	"hits_to_self" => 1,
	"no_hits_to_earlier" => 1,
	"dont_mirror" => 1,
	"old_cutoff" => 1,
	"input_options" => 1,
	"force_blastp" => 1,
	"force_blastn" => 1,
	"matrix" => 1,
	"query" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"mspcrunch",
	"matrix",
	"output_options",
	"query",
	"gapped",
	"big_pict",
	"sfs",
	"seqbl",
	"ace",
	"exblx",
	"exbldb",
	"fasta",
	"three_frame",
	"footer",
	"matches_one_line",
	"percentage_id",
	"stats_file",
	"domainer",
	"silent_mutations",
	"all_expected",
	"matrix_stats",
	"stats_without_X",
	"ignore_hits",
	"line_length",
	"wublast_numbered",
	"control_options",
	"dont_reject",
	"report_rejected",
	"threshold",
	"expect",
	"whole_contig",
	"hits_to_self",
	"no_hits_to_earlier",
	"dont_mirror",
	"old_cutoff",
	"input_options",
	"force_blastp",
	"force_blastn",
	"blast_output",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"mspcrunch" => 1,
	"blast_output" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"gapped" => 0,
	"big_pict" => 0,
	"sfs" => 0,
	"seqbl" => 0,
	"ace" => 0,
	"exblx" => 0,
	"exbldb" => 0,
	"fasta" => 0,
	"three_frame" => 0,
	"footer" => 0,
	"matches_one_line" => 0,
	"percentage_id" => 0,
	"stats_file" => 0,
	"domainer" => 0,
	"silent_mutations" => 0,
	"all_expected" => 0,
	"matrix_stats" => 0,
	"stats_without_X" => 0,
	"ignore_hits" => 0,
	"line_length" => 0,
	"wublast_numbered" => 0,
	"control_options" => 0,
	"dont_reject" => 0,
	"report_rejected" => 0,
	"threshold" => 0,
	"expect" => 0,
	"whole_contig" => 0,
	"hits_to_self" => 0,
	"no_hits_to_earlier" => 0,
	"dont_mirror" => 0,
	"old_cutoff" => 0,
	"input_options" => 0,
	"force_blastp" => 0,
	"force_blastn" => 0,
	"matrix" => 0,
	"query" => 0,

    };

    $self->{ISCOMMAND}  = {
	"mspcrunch" => 1,
	"blast_output" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"gapped" => 0,
	"big_pict" => 0,
	"sfs" => 0,
	"seqbl" => 0,
	"ace" => 0,
	"exblx" => 0,
	"exbldb" => 0,
	"fasta" => 0,
	"three_frame" => 0,
	"footer" => 0,
	"matches_one_line" => 0,
	"percentage_id" => 0,
	"stats_file" => 0,
	"domainer" => 0,
	"silent_mutations" => 0,
	"all_expected" => 0,
	"matrix_stats" => 0,
	"stats_without_X" => 0,
	"ignore_hits" => 0,
	"line_length" => 0,
	"wublast_numbered" => 0,
	"control_options" => 0,
	"dont_reject" => 0,
	"report_rejected" => 0,
	"threshold" => 0,
	"expect" => 0,
	"whole_contig" => 0,
	"hits_to_self" => 0,
	"no_hits_to_earlier" => 0,
	"dont_mirror" => 0,
	"old_cutoff" => 0,
	"input_options" => 0,
	"force_blastp" => 0,
	"force_blastn" => 0,
	"matrix" => 0,
	"query" => 0,

    };

    $self->{ISMANDATORY}  = {
	"mspcrunch" => 0,
	"blast_output" => 1,
	"output_options" => 0,
	"outfile" => 0,
	"gapped" => 0,
	"big_pict" => 0,
	"sfs" => 0,
	"seqbl" => 0,
	"ace" => 0,
	"exblx" => 0,
	"exbldb" => 0,
	"fasta" => 0,
	"three_frame" => 0,
	"footer" => 0,
	"matches_one_line" => 0,
	"percentage_id" => 0,
	"stats_file" => 0,
	"domainer" => 0,
	"silent_mutations" => 0,
	"all_expected" => 0,
	"matrix_stats" => 0,
	"stats_without_X" => 0,
	"ignore_hits" => 0,
	"line_length" => 0,
	"wublast_numbered" => 0,
	"control_options" => 0,
	"dont_reject" => 0,
	"report_rejected" => 0,
	"threshold" => 0,
	"expect" => 0,
	"whole_contig" => 0,
	"hits_to_self" => 0,
	"no_hits_to_earlier" => 0,
	"dont_mirror" => 0,
	"old_cutoff" => 0,
	"input_options" => 0,
	"force_blastp" => 0,
	"force_blastn" => 0,
	"matrix" => 0,
	"query" => 0,

    };

    $self->{PROMPT}  = {
	"mspcrunch" => "",
	"blast_output" => "BLAST output File",
	"output_options" => "Output Options",
	"outfile" => "Result file",
	"gapped" => "Make gapped alignment of ungapped-MSP contigs (-G)",
	"big_pict" => "Big Picture (-P)",
	"sfs" => "Produce SFS    output (-H)",
	"seqbl" => "Produce seqbl  output (for Blixem) (-q)",
	"ace" => "Produce .ace   output (for ACEDB 4) (-4)",
	"exblx" => "Produce exblx  output (for easy parsing) (-x)",
	"exbldb" => "Produce exbldb output (as exblx with query names) (-d)",
	"fasta" => "Produce fasta  output (unaligned, for mult.alignm.) (-2)",
	"three_frame" => "Print 3 frame translation (blastn only) (-3)",
	"footer" => "Print footer with parameters and stats (-f)",
	"matches_one_line" => "For -P output, force all matches to the same subject on one line (-F)",
	"percentage_id" => "Print percentage identity (seqbl output only) (-i)",
	"stats_file" => "Output coverage stats to file (-o)",
	"domainer" => "Produce output for Domainer (trim overlaps) (-D)",
	"silent_mutations" => "Do Statistics of Silent mutations (only cDNA!) (-S)",
	"all_expected" => "Print all Expected scores (default only when positive) (-X)",
	"matrix_stats" => "Print statistics on used matrices (-E)",
	"stats_without_X" => "Recalculate percentage identity, ignoring X residues. (-j)",
	"ignore_hits" => "Ignore hits to earlier seqnames (for All-vs-All). (-A)",
	"line_length" => "Line length of Wrapped alignment (0 -> no wrapping) (-W)",
	"wublast_numbered" => "indicate query insertions with numbers (For seqbl output from Wublast) (-N)",
	"control_options" => "Control Options",
	"dont_reject" => "Don't reject any MSPs (-w)",
	"report_rejected" => "Report only rejected MSPs (-r)",
	"threshold" => "Reject all matches with less than this % identity (-I)",
	"expect" => "Reject all matches with E-value higher than this value (-e)",
	"whole_contig" => "Coverage limitation requires whole contig to be covered (always for Blastp) (-a)",
	"hits_to_self" => "Accept hits to self (-s)",
	"no_hits_to_earlier" => "Ignore hits to earlier seqnames (for All-vs-All) (-A)",
	"dont_mirror" => "Don't mirror (i.e. print the subject object) in ACE4 format (-M)",
	"old_cutoff" => " Use old step cutoffs for adjacency instead of the new continuous system. (-O)",
	"input_options" => "Input Options",
	"force_blastp" => "Force Blastp mode (default Blastx) (-p)",
	"force_blastn" => "Force Blastn mode (default Blastx) (-n)",
	"matrix" => "Scoring matrix (PAM or BLOSUM, see help) (-m)",
	"query" => "Read in query seq (for rereading .seqbl files) (-Q)",

    };

    $self->{ISSTANDOUT}  = {
	"mspcrunch" => 0,
	"blast_output" => 0,
	"output_options" => 0,
	"outfile" => 1,
	"gapped" => 0,
	"big_pict" => 0,
	"sfs" => 0,
	"seqbl" => 0,
	"ace" => 0,
	"exblx" => 0,
	"exbldb" => 0,
	"fasta" => 0,
	"three_frame" => 0,
	"footer" => 0,
	"matches_one_line" => 0,
	"percentage_id" => 0,
	"stats_file" => 0,
	"domainer" => 0,
	"silent_mutations" => 0,
	"all_expected" => 0,
	"matrix_stats" => 0,
	"stats_without_X" => 0,
	"ignore_hits" => 0,
	"line_length" => 0,
	"wublast_numbered" => 0,
	"control_options" => 0,
	"dont_reject" => 0,
	"report_rejected" => 0,
	"threshold" => 0,
	"expect" => 0,
	"whole_contig" => 0,
	"hits_to_self" => 0,
	"no_hits_to_earlier" => 0,
	"dont_mirror" => 0,
	"old_cutoff" => 0,
	"input_options" => 0,
	"force_blastp" => 0,
	"force_blastn" => 0,
	"matrix" => 0,
	"query" => 0,

    };

    $self->{VLIST}  = {

	"output_options" => ['outfile','gapped','big_pict','sfs','seqbl','ace','exblx','exbldb','fasta','three_frame','footer','matches_one_line','percentage_id','stats_file','domainer','silent_mutations','all_expected','matrix_stats','stats_without_X','ignore_hits','line_length','wublast_numbered',],
	"control_options" => ['dont_reject','report_rejected','threshold','expect','whole_contig','hits_to_self','no_hits_to_earlier','dont_mirror','old_cutoff',],
	"input_options" => ['force_blastp','force_blastn','matrix','query',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'mspcrunch.txt',

    };

    $self->{PRECOND}  = {
	"mspcrunch" => { "perl" => '1' },
	"blast_output" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"gapped" => { "perl" => '1' },
	"big_pict" => { "perl" => '1' },
	"sfs" => { "perl" => '1' },
	"seqbl" => { "perl" => '1' },
	"ace" => { "perl" => '1' },
	"exblx" => { "perl" => '1' },
	"exbldb" => { "perl" => '1' },
	"fasta" => { "perl" => '1' },
	"three_frame" => { "perl" => '1' },
	"footer" => { "perl" => '1' },
	"matches_one_line" => {
		"perl" => '$big_pict',
	},
	"percentage_id" => {
		"perl" => '$seqbl',
	},
	"stats_file" => { "perl" => '1' },
	"domainer" => { "perl" => '1' },
	"silent_mutations" => { "perl" => '1' },
	"all_expected" => { "perl" => '1' },
	"matrix_stats" => { "perl" => '1' },
	"stats_without_X" => { "perl" => '1' },
	"ignore_hits" => { "perl" => '1' },
	"line_length" => { "perl" => '1' },
	"wublast_numbered" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"dont_reject" => { "perl" => '1' },
	"report_rejected" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"expect" => { "perl" => '1' },
	"whole_contig" => { "perl" => '1' },
	"hits_to_self" => { "perl" => '1' },
	"no_hits_to_earlier" => { "perl" => '1' },
	"dont_mirror" => {
		"perl" => '$ace',
	},
	"old_cutoff" => { "perl" => '1' },
	"input_options" => { "perl" => '1' },
	"force_blastp" => { "perl" => '1' },
	"force_blastn" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"query" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"blast_output" => {
		 "blast_output" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"mspcrunch" => 0,
	"blast_output" => 0,
	"output_options" => 0,
	"outfile" => 0,
	"gapped" => 0,
	"big_pict" => 0,
	"sfs" => 0,
	"seqbl" => 0,
	"ace" => 0,
	"exblx" => 0,
	"exbldb" => 0,
	"fasta" => 0,
	"three_frame" => 0,
	"footer" => 0,
	"matches_one_line" => 0,
	"percentage_id" => 0,
	"stats_file" => 0,
	"domainer" => 0,
	"silent_mutations" => 0,
	"all_expected" => 0,
	"matrix_stats" => 0,
	"stats_without_X" => 0,
	"ignore_hits" => 0,
	"line_length" => 0,
	"wublast_numbered" => 0,
	"control_options" => 0,
	"dont_reject" => 0,
	"report_rejected" => 0,
	"threshold" => 0,
	"expect" => 0,
	"whole_contig" => 0,
	"hits_to_self" => 0,
	"no_hits_to_earlier" => 0,
	"dont_mirror" => 0,
	"old_cutoff" => 0,
	"input_options" => 0,
	"force_blastp" => 0,
	"force_blastn" => 0,
	"matrix" => 0,
	"query" => 0,

    };

    $self->{ISSIMPLE}  = {
	"mspcrunch" => 0,
	"blast_output" => 1,
	"output_options" => 0,
	"outfile" => 0,
	"gapped" => 0,
	"big_pict" => 0,
	"sfs" => 0,
	"seqbl" => 0,
	"ace" => 0,
	"exblx" => 0,
	"exbldb" => 0,
	"fasta" => 0,
	"three_frame" => 0,
	"footer" => 0,
	"matches_one_line" => 0,
	"percentage_id" => 0,
	"stats_file" => 0,
	"domainer" => 0,
	"silent_mutations" => 0,
	"all_expected" => 0,
	"matrix_stats" => 0,
	"stats_without_X" => 0,
	"ignore_hits" => 0,
	"line_length" => 0,
	"wublast_numbered" => 0,
	"control_options" => 0,
	"dont_reject" => 0,
	"report_rejected" => 0,
	"threshold" => 0,
	"expect" => 0,
	"whole_contig" => 0,
	"hits_to_self" => 0,
	"no_hits_to_earlier" => 0,
	"dont_mirror" => 0,
	"old_cutoff" => 0,
	"input_options" => 0,
	"force_blastp" => 0,
	"force_blastn" => 0,
	"matrix" => 0,
	"query" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"matrix" => [
		"You can give the name of:",
		". a PAM matrix : PAMxxx, where xxx ranges from 10 to 500, with a step of 10",
		". a BLOSUM matrix : BLOSUMxxx, where xxx ranges from 30 to 100, with a step of 5 - with the exception of BLOSUM62 which is the default scoring matrix",
		"Several PAM (point accepted mutations per 100 residues) amino acid scoring matrices are provided in the BLAST software distribution, including the PAM40, PAM120, and PAM250. While the BLOSUM62 matrix is a good general purpose scoring matrix and is the default matrix used by the BLAST programs, if one is restricted to using only PAM scoring matrices, then the PAM120 is recommended for general protein similarity searches (Altschul, 1991). The pam(1) program can be used to produce PAM matrices of any desired iteration from 2 to 511. Each matrix is most sensitive at finding similarities at its particular PAM distance. For more thorough searches, particularly when the mutational distance between potential homologs is unknown and the significance of their similarity may be only marginal, Altschul (1991, 1992) recommends performing at least three searches, one each with the PAM40, PAM120 and PAM250 matrices.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mspcrunch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

