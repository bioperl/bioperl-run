# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::psiblast
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::psiblast

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::psiblast

      Bioperl class for:

	BLAST2	psiblast - Position Specific Iterative Blast (Altschul, Madden, Schaeffer, Zhang, Miller, Lipman)

	References:

		Altschul, Stephen F., Thomas L. Madden, Alejandro A. Schaeffer,Jinghui Zhang, Zheng Zhang, Webb Miller, and David J. Lipman (1997), Gapped BLAST and PSI-BLAST: a new generation of protein database search programs,  Nucleic Acids Res. 25:3389-3402.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/psiblast.html 
         for available values):


		psiblast (String)

		query (Sequence)
			Sequence File
			pipe: seqfile

		start_region (Integer)
			Start of required region in query (-S)

		end_region (Integer)
			End of required region in query (-1 indicates end of query) (-H)

		protein_db (Excl)
			protein db

		filter (Switch)
			Filter query sequence with SEG (-F)

		Expect (Integer)
			Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)

		window (Integer)
			Multiple hits window size (zero for single hit algorithm) (-A)

		extend_hit (Integer)
			Threshold for extending hits (-f)

		dropoff_y (Float)
			Dropoff for blast ungapped extensions in bits (-y)

		gapped_alig (Switch)
			Perform gapped alignment (-g)

		dropoff (Integer)
			X dropoff value for gapped alignment (in bits) (-X)

		dropoff_z (Integer)
			X dropoff value for final gapped alignment (in bits) (-Z)

		matrix (Excl)
			Matrix (-M)

		open_a_gap (Integer)
			Cost to open a gap (-G)

		extend_a_gap (Integer)
			Cost to extend a gap (-E)

		max_passes (Integer)
			Maximum number of passes to use in  multipass version (-j)

		expect_in_multipass (Float)
			e-value threshold for inclusion in multipass model (-h)

		pseudocounts (Integer)
			Constant in pseudocounts for multipass version (-c)

		trigger (Float)
			Number of bits to trigger gapping (-N)

		Descriptions (Integer)
			How many short descriptions? (-v)

		Alignments (Integer)
			How many alignments? (-b)

		view_alignments (Excl)
			Alignment view options  (not with blastx/tblastx) (-m)

		htmloutput (Switch)
			HTML output

		seqalign_file (OutFile)
			SeqAlign file (-J option must be true) (-O)

		believe (Switch)
			Believe the query defline (-J)

		save_matrix (OutFile)
			Save PSI-Blast Matrix to file (-C)
			pipe: psiblast_matrix

		save_txt_matrix (OutFile)
			Save PSI-BLAST Matrix as text to file (-Q)

		nb_proc (Integer)

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

http://bioweb.pasteur.fr/seqanal/interfaces/psiblast.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::psiblast;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $psiblast = Bio::Tools::Run::PiseApplication::psiblast->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::psiblast object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $psiblast = $factory->program('psiblast');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::psiblast.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/psiblast.pm

    $self->{COMMAND}   = "psiblast";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLAST2";

    $self->{DESCRIPTION}   = "psiblast - Position Specific Iterative Blast";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Altschul, Madden, Schaeffer, Zhang, Miller, Lipman";

    $self->{REFERENCE}   = [

         "Altschul, Stephen F., Thomas L. Madden, Alejandro A. Schaeffer,Jinghui Zhang, Zheng Zhang, Webb Miller, and David J. Lipman (1997), Gapped BLAST and PSI-BLAST: a new generation of protein database search programs,  Nucleic Acids Res. 25:3389-3402.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"psiblast",
	"query",
	"start_region",
	"end_region",
	"protein_db",
	"filter_opt",
	"selectivity_opt",
	"scoring",
	"psi_spec_opt",
	"affichage",
	"html_file",
	"txt_output",
	"nb_proc",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"psiblast",
	"query", 	# Sequence File
	"start_region", 	# Start of required region in query (-S)
	"end_region", 	# End of required region in query (-1 indicates end of query) (-H)
	"protein_db", 	# protein db
	"filter_opt", 	# Filtering and masking options
	"filter", 	# Filter query sequence with SEG (-F)
	"selectivity_opt", 	# Selectivity options
	"Expect", 	# Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)
	"window", 	# Multiple hits window size (zero for single hit algorithm) (-A)
	"extend_hit", 	# Threshold for extending hits (-f)
	"dropoff_y", 	# Dropoff for blast ungapped extensions in bits (-y)
	"gapped_alig", 	# Perform gapped alignment (-g)
	"dropoff", 	# X dropoff value for gapped alignment (in bits) (-X)
	"dropoff_z", 	# X dropoff value for final gapped alignment (in bits) (-Z)
	"scoring", 	# Scoring option
	"matrix", 	# Matrix (-M)
	"open_a_gap", 	# Cost to open a gap (-G)
	"extend_a_gap", 	# Cost to extend a gap (-E)
	"psi_spec_opt", 	# PSI-Blast specific selectivity options
	"max_passes", 	# Maximum number of passes to use in  multipass version (-j)
	"expect_in_multipass", 	# e-value threshold for inclusion in multipass model (-h)
	"pseudocounts", 	# Constant in pseudocounts for multipass version (-c)
	"trigger", 	# Number of bits to trigger gapping (-N)
	"affichage", 	# Report options
	"Descriptions", 	# How many short descriptions? (-v)
	"Alignments", 	# How many alignments? (-b)
	"view_alignments", 	# Alignment view options  (not with blastx/tblastx) (-m)
	"htmloutput", 	# HTML output
	"seqalign_file", 	# SeqAlign file (-J option must be true) (-O)
	"believe", 	# Believe the query defline (-J)
	"save_matrix", 	# Save PSI-Blast Matrix to file (-C)
	"save_txt_matrix", 	# Save PSI-BLAST Matrix as text to file (-Q)
	"html_file",
	"txt_output",
	"nb_proc",

    ];

    $self->{TYPE}  = {
	"psiblast" => 'String',
	"query" => 'Sequence',
	"start_region" => 'Integer',
	"end_region" => 'Integer',
	"protein_db" => 'Excl',
	"filter_opt" => 'Paragraph',
	"filter" => 'Switch',
	"selectivity_opt" => 'Paragraph',
	"Expect" => 'Integer',
	"window" => 'Integer',
	"extend_hit" => 'Integer',
	"dropoff_y" => 'Float',
	"gapped_alig" => 'Switch',
	"dropoff" => 'Integer',
	"dropoff_z" => 'Integer',
	"scoring" => 'Paragraph',
	"matrix" => 'Excl',
	"open_a_gap" => 'Integer',
	"extend_a_gap" => 'Integer',
	"psi_spec_opt" => 'Paragraph',
	"max_passes" => 'Integer',
	"expect_in_multipass" => 'Float',
	"pseudocounts" => 'Integer',
	"trigger" => 'Float',
	"affichage" => 'Paragraph',
	"Descriptions" => 'Integer',
	"Alignments" => 'Integer',
	"view_alignments" => 'Excl',
	"htmloutput" => 'Switch',
	"seqalign_file" => 'OutFile',
	"believe" => 'Switch',
	"save_matrix" => 'OutFile',
	"save_txt_matrix" => 'OutFile',
	"html_file" => 'Results',
	"txt_output" => 'Results',
	"nb_proc" => 'Integer',

    };

    $self->{FORMAT}  = {
	"psiblast" => {
		"perl" => '"blastpgp"',
	},
	"query" => {
		"perl" => '" -i $query" ',
	},
	"start_region" => {
		"perl" => '(defined $value && $value != $vdef)? " -S $value" : ""',
	},
	"end_region" => {
		"perl" => '(defined $value && $value != $vdef)? " -H $value" : ""',
	},
	"protein_db" => {
		"perl" => ' " -d $value" ',
	},
	"filter_opt" => {
	},
	"filter" => {
		"perl" => '($value) ? " -F T" : ""',
	},
	"selectivity_opt" => {
	},
	"Expect" => {
		"perl" => '(defined $value && $value != $vdef)? " -e $value":""',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -A $value" : ""',
	},
	"extend_hit" => {
		"perl" => '($value)? " -f $value" : ""',
	},
	"dropoff_y" => {
		"perl" => '(defined $value && $value != $vdef)? " -y $value" : ""',
	},
	"gapped_alig" => {
		"perl" => ' ($value) ? "": " -g F"',
	},
	"dropoff" => {
		"perl" => '(defined $value && $value != $vdef)? " -X $value":""',
	},
	"dropoff_z" => {
		"perl" => '(defined $value && $value != $vdef)? " -Z $value" : ""',
	},
	"scoring" => {
	},
	"matrix" => {
		"perl" => '($value && $value ne $vdef)? " -M $value" : ""',
	},
	"open_a_gap" => {
		"perl" => '(defined $value && $value != $vdef)? " -G $value":""',
	},
	"extend_a_gap" => {
		"perl" => '(defined $value && $value != $vdef)? " -E $value":""',
	},
	"psi_spec_opt" => {
	},
	"max_passes" => {
		"perl" => '(defined $value && $value != $vdef) ? " -j $value" : ""',
	},
	"expect_in_multipass" => {
		"perl" => '(defined $value && $value != $vdef)? " -h $value" : ""',
	},
	"pseudocounts" => {
		"perl" => '(defined $value && $value != $vdef)? " -c $value" : ""',
	},
	"trigger" => {
		"perl" => '(defined $value && $value != $vdef)? " -N $value" : ""',
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
	"htmloutput" => {
		"perl" => ' " && html4blast -o psiblast.html -s -g psiblast.txt" ',
	},
	"seqalign_file" => {
		"perl" => '($value)? " -O $value" : ""',
	},
	"believe" => {
		"perl" => '($value)? " -J":""',
	},
	"save_matrix" => {
		"perl" => '(defined $value) ? " -C $save_matrix" : ""',
	},
	"save_txt_matrix" => {
		"perl" => '(defined $value)? " -Q $save_txt_matrix" : ""',
	},
	"html_file" => {
	},
	"txt_output" => {
		"perl" => '" > psiblast.txt"',
	},
	"nb_proc" => {
		"perl" => '" -a 2"',
	},

    };

    $self->{FILENAMES}  = {
	"html_file" => 'psiblast.html',
	"txt_output" => 'psiblast.txt',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"psiblast" => 0,
	"query" => 3,
	"protein_db" => 2,
	"filter_opt" => 4,
	"filter" => 4,
	"selectivity_opt" => 5,
	"Expect" => 5,
	"window" => 5,
	"extend_hit" => 5,
	"dropoff_y" => 5,
	"gapped_alig" => 5,
	"dropoff" => 5,
	"dropoff_z" => 5,
	"scoring" => 4,
	"matrix" => 5,
	"open_a_gap" => 4,
	"extend_a_gap" => 5,
	"psi_spec_opt" => 5,
	"max_passes" => 5,
	"expect_in_multipass" => 5,
	"pseudocounts" => 5,
	"trigger" => 5,
	"Descriptions" => 5,
	"Alignments" => 5,
	"view_alignments" => 4,
	"htmloutput" => 51,
	"seqalign_file" => 4,
	"believe" => 4,
	"txt_output" => 50,
	"nb_proc" => 6,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"psiblast",
	"html_file",
	"start_region",
	"end_region",
	"affichage",
	"save_matrix",
	"save_txt_matrix",
	"protein_db",
	"query",
	"filter_opt",
	"view_alignments",
	"seqalign_file",
	"believe",
	"filter",
	"scoring",
	"open_a_gap",
	"dropoff_z",
	"matrix",
	"extend_a_gap",
	"psi_spec_opt",
	"max_passes",
	"expect_in_multipass",
	"pseudocounts",
	"trigger",
	"selectivity_opt",
	"Descriptions",
	"Alignments",
	"Expect",
	"window",
	"extend_hit",
	"dropoff_y",
	"gapped_alig",
	"dropoff",
	"nb_proc",
	"txt_output",
	"htmloutput",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"psiblast" => 1,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff_y" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"psi_spec_opt" => 0,
	"max_passes" => 0,
	"expect_in_multipass" => 0,
	"pseudocounts" => 0,
	"trigger" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"htmloutput" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"save_matrix" => 0,
	"save_txt_matrix" => 0,
	"html_file" => 0,
	"txt_output" => 0,
	"nb_proc" => 1,

    };

    $self->{ISCOMMAND}  = {
	"psiblast" => 1,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff_y" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"psi_spec_opt" => 0,
	"max_passes" => 0,
	"expect_in_multipass" => 0,
	"pseudocounts" => 0,
	"trigger" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"htmloutput" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"save_matrix" => 0,
	"save_txt_matrix" => 0,
	"html_file" => 0,
	"txt_output" => 0,
	"nb_proc" => 0,

    };

    $self->{ISMANDATORY}  = {
	"psiblast" => 0,
	"query" => 1,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff_y" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"psi_spec_opt" => 0,
	"max_passes" => 0,
	"expect_in_multipass" => 0,
	"pseudocounts" => 0,
	"trigger" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"htmloutput" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"save_matrix" => 0,
	"save_txt_matrix" => 0,
	"html_file" => 0,
	"txt_output" => 0,
	"nb_proc" => 0,

    };

    $self->{PROMPT}  = {
	"psiblast" => "",
	"query" => "Sequence File",
	"start_region" => "Start of required region in query (-S)",
	"end_region" => "End of required region in query (-1 indicates end of query) (-H)",
	"protein_db" => "protein db",
	"filter_opt" => "Filtering and masking options",
	"filter" => "Filter query sequence with SEG (-F)",
	"selectivity_opt" => "Selectivity options",
	"Expect" => "Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)",
	"window" => "Multiple hits window size (zero for single hit algorithm) (-A)",
	"extend_hit" => "Threshold for extending hits (-f)",
	"dropoff_y" => "Dropoff for blast ungapped extensions in bits (-y)",
	"gapped_alig" => "Perform gapped alignment (-g)",
	"dropoff" => "X dropoff value for gapped alignment (in bits) (-X)",
	"dropoff_z" => "X dropoff value for final gapped alignment (in bits) (-Z)",
	"scoring" => "Scoring option",
	"matrix" => "Matrix (-M)",
	"open_a_gap" => "Cost to open a gap (-G)",
	"extend_a_gap" => "Cost to extend a gap (-E)",
	"psi_spec_opt" => "PSI-Blast specific selectivity options",
	"max_passes" => "Maximum number of passes to use in  multipass version (-j)",
	"expect_in_multipass" => "e-value threshold for inclusion in multipass model (-h)",
	"pseudocounts" => "Constant in pseudocounts for multipass version (-c)",
	"trigger" => "Number of bits to trigger gapping (-N)",
	"affichage" => "Report options",
	"Descriptions" => "How many short descriptions? (-v)",
	"Alignments" => "How many alignments? (-b)",
	"view_alignments" => "Alignment view options  (not with blastx/tblastx) (-m)",
	"htmloutput" => "HTML output",
	"seqalign_file" => "SeqAlign file (-J option must be true) (-O)",
	"believe" => "Believe the query defline (-J)",
	"save_matrix" => "Save PSI-Blast Matrix to file (-C)",
	"save_txt_matrix" => "Save PSI-BLAST Matrix as text to file (-Q)",
	"html_file" => "",
	"txt_output" => "",
	"nb_proc" => "",

    };

    $self->{ISSTANDOUT}  = {
	"psiblast" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff_y" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"psi_spec_opt" => 0,
	"max_passes" => 0,
	"expect_in_multipass" => 0,
	"pseudocounts" => 0,
	"trigger" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"htmloutput" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"save_matrix" => 0,
	"save_txt_matrix" => 0,
	"html_file" => 0,
	"txt_output" => 0,
	"nb_proc" => 0,

    };

    $self->{VLIST}  = {

	"protein_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','sbase','sbase: annotated domains sequences',],
	"filter_opt" => ['filter',],
	"selectivity_opt" => ['Expect','window','extend_hit','dropoff_y','gapped_alig','dropoff','dropoff_z',],
	"scoring" => ['matrix','open_a_gap','extend_a_gap',],
	"matrix" => ['PAM30','PAM30','PAM70','PAM70','BLOSUM80','BLOSUM80','BLOSUM62','BLOSUM62','BLOSUM45','BLOSUM45',],
	"psi_spec_opt" => ['max_passes','expect_in_multipass','pseudocounts','trigger',],
	"affichage" => ['Descriptions','Alignments','view_alignments','htmloutput','seqalign_file','believe','save_matrix','save_txt_matrix',],
	"view_alignments" => ['0','0: pairwise','1','1: query-anchored showing identities','2','2: query-anchored no identities','3','3: flat query-anchored, show identities','4','4: flat query-anchored, no identities','5','5: query-anchored no identities and blunt ends','6','6: flat query-anchored, no identities and blunt ends','7','7: XML Blast output','8','8: Tabular output',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"start_region" => '1',
	"end_region" => '-1',
	"protein_db" => 'sptrnrdb',
	"filter" => '0',
	"Expect" => '10',
	"window" => '40',
	"extend_hit" => '0',
	"dropoff_y" => '7.0',
	"gapped_alig" => '1',
	"dropoff" => '15',
	"dropoff_z" => '25',
	"matrix" => 'BLOSUM62',
	"open_a_gap" => '11',
	"extend_a_gap" => '1',
	"max_passes" => '1',
	"expect_in_multipass" => '0.01',
	"pseudocounts" => '10',
	"trigger" => '22.0',
	"Descriptions" => '500',
	"Alignments" => '250',
	"view_alignments" => '0',
	"believe" => '0',

    };

    $self->{PRECOND}  = {
	"psiblast" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"start_region" => { "perl" => '1' },
	"end_region" => { "perl" => '1' },
	"protein_db" => { "perl" => '1' },
	"filter_opt" => { "perl" => '1' },
	"filter" => { "perl" => '1' },
	"selectivity_opt" => { "perl" => '1' },
	"Expect" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"extend_hit" => { "perl" => '1' },
	"dropoff_y" => { "perl" => '1' },
	"gapped_alig" => { "perl" => '1' },
	"dropoff" => { "perl" => '1' },
	"dropoff_z" => { "perl" => '1' },
	"scoring" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"open_a_gap" => { "perl" => '1' },
	"extend_a_gap" => { "perl" => '1' },
	"psi_spec_opt" => { "perl" => '1' },
	"max_passes" => { "perl" => '1' },
	"expect_in_multipass" => { "perl" => '1' },
	"pseudocounts" => { "perl" => '1' },
	"trigger" => { "perl" => '1' },
	"affichage" => { "perl" => '1' },
	"Descriptions" => { "perl" => '1' },
	"Alignments" => { "perl" => '1' },
	"view_alignments" => { "perl" => '1' },
	"htmloutput" => {
		"perl" => '$view_alignments !~ /^[78]$/',
	},
	"seqalign_file" => {
		"perl" => '$believe',
	},
	"believe" => { "perl" => '1' },
	"save_matrix" => {
		"perl" => '$max_passes > 1',
	},
	"save_txt_matrix" => {
		"perl" => '$max_passes > 1',
	},
	"html_file" => {
		"perl" => '$htmloutput',
	},
	"txt_output" => { "perl" => '1' },
	"nb_proc" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"save_matrix" => {
		 '1' => "psiblast_matrix",
	},

    };

    $self->{WITHPIPEOUT}  = {
	"save_matrix" => {
		 "psiblast_matrix" => ["query",]
	},

    };

    $self->{PIPEIN}  = {
	"query" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"psiblast" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff_y" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"psi_spec_opt" => 0,
	"max_passes" => 0,
	"expect_in_multipass" => 0,
	"pseudocounts" => 0,
	"trigger" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"htmloutput" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"save_matrix" => 0,
	"save_txt_matrix" => 0,
	"html_file" => 0,
	"txt_output" => 0,
	"nb_proc" => 0,

    };

    $self->{ISSIMPLE}  = {
	"psiblast" => 0,
	"query" => 1,
	"start_region" => 0,
	"end_region" => 0,
	"protein_db" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 1,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff_y" => 0,
	"gapped_alig" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"psi_spec_opt" => 0,
	"max_passes" => 0,
	"expect_in_multipass" => 0,
	"pseudocounts" => 0,
	"trigger" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"htmloutput" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"save_matrix" => 0,
	"save_txt_matrix" => 0,
	"html_file" => 0,
	"txt_output" => 0,
	"nb_proc" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"psiblast" => [
		"The blastpgp program can do an iterative search in which sequences found in one round of searching are used to build a score model for the next round of searching. In this usage, the program is called Position-Specific Iterated BLAST, or PSI-BLAST. As explained in the accompanying paper, the BLAST algorithm is not tied to a specific score matrix. Traditionally, it has been implemented using an AxA substitution matrix where A is the alphabet size. PSI-BLAST instead uses a QxA matrix, where Q is the length of the query sequence; at each position the cost of a letter depends on the position w.r.t. the query and the letter in the subject sequence.",
		"The position-specific matrix for round i+1 is built from a constrained multiple alignment among the query and the sequences found with sufficiently low e-value in round i. The top part of the output for each round distinguishes the sequences into: sequences found previously and used in the score model, and sequences not used in the score model. The output currently includes lots of diagnostics requested by users at NCBI. To skip quickly from the output of one round to the next, search for the string \'producing\', which is part of the header for each round and likely does not appear elsewhere in the output. PSI-BLAST \'converges\' and stops if all sequences found at round i+1 below the e-value threshold were already in the model at the beginning of the round.",
	],
	"protein_db" => [
		"Choose a protein db for blastp or blastx.",
		"Please note that Swissprot usage by and for commercial entities requires a license agreement.",
	],
	"filter_opt" => [
		"This options also takes a string as an argument.  One may use such a string to change the specific parameters of seg or invoke other filters. Please see the \'Filtering Strings\' section (below) for details.",
	],
	"Expect" => [
		"The statistical significance threshold for reporting matches against database sequences; the default value is 10, such that 10 matches are expected to be found merely by chance, according to the stochastic model of Karlin and Altschul (1990). If the statistical significance ascribed to a match is greater than the EXPECT threshold, the match will not be reported. Lower EXPECT thresholds are more stringent, leading to fewer chance matches being reported. Fractional values are acceptable. ",
	],
	"window" => [
		"When multiple hits method is used, this		parameter defines the distance from last hit on the		same diagonal to the new one.",
		"Zero means single hit algorithm.",
	],
	"extend_hit" => [
		"Blast seeks first short word pairs whose aligned score reaches at least this value (default for blastp is 11) (T in the NAR paper and in Blast 1.4)",
	],
	"dropoff_y" => [
		"This parameter controls the dropoff at ungapped extension stage. See also the -X parameter.",
	],
	"dropoff" => [
		"This is the value that control the path graph region explored by Blast during a gapped extension (Xg in the NAR paper).",
	],
	"dropoff_z" => [
		"This parameter controls the dropoff for the final reported alignment. See also the -X parameter.",
	],
	"extend_a_gap" => [
		"Limited values for gap existence and extension are supported for these three programs. Some supported and suggested values are:",
		"Existence Extension",
		"10 1",
		"10 2",
		"11 1",
		"8 2",
		"9 2",
		"(source: NCBI Blast page)",
	],
	"pseudocounts" => [
		"This constant is the weight given to a pre-calculated residue target frequency (versus the observed one) in a column of the position specific matrix. The larger its value, the greater the emphasis given to prior knowledge of residue relationships vis a vis observed residue frequencies (beta constant in NAR paper).",
	],
	"trigger" => [
		"Blast does first an ungapped extension of the hit to make an HSP. The gapped extension is triggered when the HSP score reaches this value (Sg in the NAR paper).",
	],
	"Descriptions" => [
		"Maximum number of database sequences for which one-line descriptions will be reported (-v).",
	],
	"Alignments" => [
		"Maximum number of database sequences for which high-scoring segment pairs will be reported (-b).",
	],
	"seqalign_file" => [
		"SeqAlign is in ASN.1 format, so that it can be read with NCBI tools (such as sequin). This allows one to view the results in different formats.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/psiblast.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

