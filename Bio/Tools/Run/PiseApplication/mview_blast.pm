
=head1 NAME

Bio::Tools::Run::PiseApplication::mview_blast

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mview_blast

      Bioperl class for:

	MVIEW	view Blast results as a multiple alignment (N. P. Brown)

	References:

		Brown, N.P., Leroy C., Sander C. (1998). MView: A Web compatible database search or multiple alignment  viewer. Bioinformatics. 14(4):380-381.


      Parameters:


		mview_blast (String)


		blast_output (InFile)
			Blast/FASTA Output File
			pipe: blast_output
			pipe: mview_input

		in (Excl)
			Type of search (-in)

		main_formatting_options (Paragraph)
			Main formatting options

		ruler (Switch)
			Attach a ruler (-ruler)

		alignment (Switch)
			Show alignment (-alignment)

		consensus (Switch)
			Show consensus (-consensus)

		dna (Switch)
			Use DNA/RNA colormaps and/or consensus groups (-dna)

		alignment_options (Paragraph)
			Alignment options

		coloring (Excl)
			Colour scheme (-coloring)

		threshold (Float)
			Threshold percentage for consensus coloring (-threshold)

		ignore (Excl)
			Ignore singleton or class group (-ignore)

		consensus_options (Paragraph)
			Consensus options

		con_coloring (Excl)
			Basic style of coloring (-con_coloring)

		con_threshold (String)
			Consensus line thresholds (in range 50..100) (separated by commas) (-con_threshold)

		con_ignore (Excl)
			Ignore singleton or class group (-con_ignore)

		hybrid_alignment_consensus_options (Paragraph)
			Hybrid alignment and consensus options

		con_gaps (Switch)
			Count gaps during consensus computations (-con_gaps)

		general_row_column_filters (Paragraph)
			General row/column filters

		top (Integer)
			Report top N hits (-top)

		range (String)
			Display column range M..N as numbered by ruler (M,N) (-range)

		maxident (Integer)
			Only report sequences with %identity <= N (-maxident)

		ref (Integer)
			Use row N or row identifier as %id entity reference (-ref)

		keep_only (String)
			Keep only the rows from start to end (separated by commas: start,end) (-keep)

		disc (String)
			Discard rows from start to end (separated by commas: start,end) (-disc)

		nops (String)
			Display rows unprocessed (separated by commas) (-nops)

		general_formatting_options (Paragraph)
			General formatting options

		width (Integer)
			Paginate in N columns of alignment (-width)

		gap (String)
			Use this character as the gap (-gap)

		label0 (Switch)
			Switch off label: row number (-label0)

		label1 (Switch)
			Switch off label: identifier (-label1)

		label2 (Switch)
			Switch off label: description (-label2)

		label3 (Switch)
			Switch off label: scores (-label3)

		label4 (Switch)
			Switch off label: percent identity (-label4)

		register (Switch)
			Output multi-pass alignments with columns in register (-register)

		html_markup_options (Paragraph)
			HTML markup options

		html_output (Excl)
			HTML output

		pagecolor (String)
			Page backgound color (-pagecolor)

		textcolor (String)
			Page text color (-textcolor)

		linkcolor (String)
			Link color (-linkcolor)

		alinkcolor (String)
			Active link color (-alinkcolor)

		vlinkcolor (String)
			Visited link color (-vlinkcolor)

		alncolor (String)
			Alignment background color (-alncolor)

		symcolor (String)
			Alignment default text color (-symcolor)

		gapcolor (String)
			Alignment gap color (-gapcolor)

		bold (Switch)
			Use bold emphasis for coloured residues (-bold)

		css (Excl)
			Use Cascading Style Sheets (-css)

		srs (Switch)
			Try to use SRS links (-srs)

		blast_options (Paragraph)
			BLAST options

		hsp (Excl)
			HSP tiling method (-hsp)

		strand (Excl)
			Report only these query strand orientations (-strand)

		blast1_options (Paragraph)
			BLAST series 1 options

		maxpval (Float)
			Ignore hits with p-value more than N -- Blastp only (-maxpval)

		minscore (Float)
			Ignore hits with score less than N (-minscore)

		blast2_options (Paragraph)
			BLAST series 2 options

		maxeval (Float)
			Ignore hits with p-value more than N -- Blast2 only (-maxeval)

		minbits (Float)
			Ignore hits with bits less than N (-minbits)

		cycle (String)
			Process the Nth cycle of a multipass search (-cycle)

		fasta_options (Paragraph)
			FASTA options

		minopt (Integer)
			Ignore hits with opt score less than N (-minopt)

		fasta_strand (Excl)
			Report only these query strand orientations (-strand)

		html_output_file (OutFile)


		html_file (Results)


		alig_file (Results)

			pipe: readseq_ok_alig

		out (Excl)
			Output format (-out)

=cut

#'
package Bio::Tools::Run::PiseApplication::mview_blast;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mview_blast = Bio::Tools::Run::PiseApplication::mview_blast->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mview_blast object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $mview_blast = $factory->program('mview_blast');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::mview_blast.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mview_blast.pm

    $self->{COMMAND}   = "mview_blast";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MVIEW";

    $self->{DESCRIPTION}   = "view Blast results as a multiple alignment";

    $self->{AUTHORS}   = "N. P. Brown";

    $self->{REFERENCE}   = [

         "Brown, N.P., Leroy C., Sander C. (1998). MView: A Web compatible database search or multiple alignment  viewer. Bioinformatics. 14(4):380-381.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mview_blast",
	"blast_output",
	"in",
	"main_formatting_options",
	"alignment_options",
	"consensus_options",
	"hybrid_alignment_consensus_options",
	"general_row_column_filters",
	"general_formatting_options",
	"html_markup_options",
	"blast_options",
	"fasta_options",
	"html_output_file",
	"html_file",
	"alig_file",
	"out",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mview_blast",
	"blast_output", 	# Blast/FASTA Output File
	"in", 	# Type of search (-in)
	"main_formatting_options", 	# Main formatting options
	"ruler", 	# Attach a ruler (-ruler)
	"alignment", 	# Show alignment (-alignment)
	"consensus", 	# Show consensus (-consensus)
	"dna", 	# Use DNA/RNA colormaps and/or consensus groups (-dna)
	"alignment_options", 	# Alignment options
	"coloring", 	# Colour scheme (-coloring)
	"threshold", 	# Threshold percentage for consensus coloring (-threshold)
	"ignore", 	# Ignore singleton or class group (-ignore)
	"consensus_options", 	# Consensus options
	"con_coloring", 	# Basic style of coloring (-con_coloring)
	"con_threshold", 	# Consensus line thresholds (in range 50..100) (separated by commas) (-con_threshold)
	"con_ignore", 	# Ignore singleton or class group (-con_ignore)
	"hybrid_alignment_consensus_options", 	# Hybrid alignment and consensus options
	"con_gaps", 	# Count gaps during consensus computations (-con_gaps)
	"general_row_column_filters", 	# General row/column filters
	"top", 	# Report top N hits (-top)
	"range", 	# Display column range M..N as numbered by ruler (M,N) (-range)
	"maxident", 	# Only report sequences with %identity <= N (-maxident)
	"ref", 	# Use row N or row identifier as %id entity reference (-ref)
	"keep_only", 	# Keep only the rows from start to end (separated by commas: start,end) (-keep)
	"disc", 	# Discard rows from start to end (separated by commas: start,end) (-disc)
	"nops", 	# Display rows unprocessed (separated by commas) (-nops)
	"general_formatting_options", 	# General formatting options
	"width", 	# Paginate in N columns of alignment (-width)
	"gap", 	# Use this character as the gap (-gap)
	"label0", 	# Switch off label: row number (-label0)
	"label1", 	# Switch off label: identifier (-label1)
	"label2", 	# Switch off label: description (-label2)
	"label3", 	# Switch off label: scores (-label3)
	"label4", 	# Switch off label: percent identity (-label4)
	"register", 	# Output multi-pass alignments with columns in register (-register)
	"html_markup_options", 	# HTML markup options
	"html_output", 	# HTML output
	"pagecolor", 	# Page backgound color (-pagecolor)
	"textcolor", 	# Page text color (-textcolor)
	"linkcolor", 	# Link color (-linkcolor)
	"alinkcolor", 	# Active link color (-alinkcolor)
	"vlinkcolor", 	# Visited link color (-vlinkcolor)
	"alncolor", 	# Alignment background color (-alncolor)
	"symcolor", 	# Alignment default text color (-symcolor)
	"gapcolor", 	# Alignment gap color (-gapcolor)
	"bold", 	# Use bold emphasis for coloured residues (-bold)
	"css", 	# Use Cascading Style Sheets (-css)
	"srs", 	# Try to use SRS links (-srs)
	"blast_options", 	# BLAST options
	"hsp", 	# HSP tiling method (-hsp)
	"strand", 	# Report only these query strand orientations (-strand)
	"blast1_options", 	# BLAST series 1 options
	"maxpval", 	# Ignore hits with p-value more than N -- Blastp only (-maxpval)
	"minscore", 	# Ignore hits with score less than N (-minscore)
	"blast2_options", 	# BLAST series 2 options
	"maxeval", 	# Ignore hits with p-value more than N -- Blast2 only (-maxeval)
	"minbits", 	# Ignore hits with bits less than N (-minbits)
	"cycle", 	# Process the Nth cycle of a multipass search (-cycle)
	"fasta_options", 	# FASTA options
	"minopt", 	# Ignore hits with opt score less than N (-minopt)
	"fasta_strand", 	# Report only these query strand orientations (-strand)
	"html_output_file",
	"html_file",
	"alig_file",
	"out", 	# Output format (-out)

    ];

    $self->{TYPE}  = {
	"mview_blast" => 'String',
	"blast_output" => 'InFile',
	"in" => 'Excl',
	"main_formatting_options" => 'Paragraph',
	"ruler" => 'Switch',
	"alignment" => 'Switch',
	"consensus" => 'Switch',
	"dna" => 'Switch',
	"alignment_options" => 'Paragraph',
	"coloring" => 'Excl',
	"threshold" => 'Float',
	"ignore" => 'Excl',
	"consensus_options" => 'Paragraph',
	"con_coloring" => 'Excl',
	"con_threshold" => 'String',
	"con_ignore" => 'Excl',
	"hybrid_alignment_consensus_options" => 'Paragraph',
	"con_gaps" => 'Switch',
	"general_row_column_filters" => 'Paragraph',
	"top" => 'Integer',
	"range" => 'String',
	"maxident" => 'Integer',
	"ref" => 'Integer',
	"keep_only" => 'String',
	"disc" => 'String',
	"nops" => 'String',
	"general_formatting_options" => 'Paragraph',
	"width" => 'Integer',
	"gap" => 'String',
	"label0" => 'Switch',
	"label1" => 'Switch',
	"label2" => 'Switch',
	"label3" => 'Switch',
	"label4" => 'Switch',
	"register" => 'Switch',
	"html_markup_options" => 'Paragraph',
	"html_output" => 'Excl',
	"pagecolor" => 'String',
	"textcolor" => 'String',
	"linkcolor" => 'String',
	"alinkcolor" => 'String',
	"vlinkcolor" => 'String',
	"alncolor" => 'String',
	"symcolor" => 'String',
	"gapcolor" => 'String',
	"bold" => 'Switch',
	"css" => 'Excl',
	"srs" => 'Switch',
	"blast_options" => 'Paragraph',
	"hsp" => 'Excl',
	"strand" => 'Excl',
	"blast1_options" => 'Paragraph',
	"maxpval" => 'Float',
	"minscore" => 'Float',
	"blast2_options" => 'Paragraph',
	"maxeval" => 'Float',
	"minbits" => 'Float',
	"cycle" => 'String',
	"fasta_options" => 'Paragraph',
	"minopt" => 'Integer',
	"fasta_strand" => 'Excl',
	"html_output_file" => 'OutFile',
	"html_file" => 'Results',
	"alig_file" => 'Results',
	"out" => 'Excl',

    };

    $self->{FORMAT}  = {
	"mview_blast" => {
		"perl" => ' "mview" ',
	},
	"blast_output" => {
		"perl" => '" $value"',
	},
	"in" => {
		"perl" => ' " -in $value" ',
	},
	"main_formatting_options" => {
	},
	"ruler" => {
		"perl" => '($value)? " -ruler on":""',
	},
	"alignment" => {
		"perl" => '($value)? " " : " -alignment off"',
	},
	"consensus" => {
		"perl" => '($value)? " -consensus on":""',
	},
	"dna" => {
		"perl" => '($value)? " -dna":""',
	},
	"alignment_options" => {
	},
	"coloring" => {
		"perl" => '($value)? " -coloring $value":""',
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? " -threshold $value":""',
	},
	"ignore" => {
		"perl" => '($value && $value ne $vdef)? " -ignore $value" : ""',
	},
	"consensus_options" => {
	},
	"con_coloring" => {
		"perl" => '($value)? " -con_coloring $value":""',
	},
	"con_threshold" => {
		"perl" => '($value && $value ne $vdef)? " -con_threshold $value":""',
	},
	"con_ignore" => {
		"perl" => '($value && $value ne $vdef)? " -con_ignore $value" : ""',
	},
	"hybrid_alignment_consensus_options" => {
	},
	"con_gaps" => {
		"perl" => '($value)? "" : " -con_gaps off"',
	},
	"general_row_column_filters" => {
	},
	"top" => {
		"perl" => '(defined $value)? " -top $value":""',
	},
	"range" => {
		"perl" => '($value && ($value =~ s/,/:/g))? " -range $value":""',
	},
	"maxident" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxident $value":""',
	},
	"ref" => {
		"perl" => '($value)? " -ref $value":""',
	},
	"keep_only" => {
		"perl" => '($value && ($value =~ s/,/../))? " -disc \\"/.*/\\" -keep $value" : "" ',
	},
	"disc" => {
		"perl" => '($value && ($value =~ s/,/../))? " -disc $value" : "" ',
	},
	"nops" => {
		"perl" => '($value)? " -nops $value" : "" ',
	},
	"general_formatting_options" => {
	},
	"width" => {
		"perl" => '(defined $value)? " -width $value":""',
	},
	"gap" => {
		"perl" => '($value)? " -gap $value" : " " ',
	},
	"label0" => {
		"perl" => '($value)? " -label0":""',
	},
	"label1" => {
		"perl" => '($value)? " -label1":""',
	},
	"label2" => {
		"perl" => '($value)? " -label2":""',
	},
	"label3" => {
		"perl" => '($value)? " -label3":""',
	},
	"label4" => {
		"perl" => '($value)? " -label4":""',
	},
	"register" => {
		"perl" => '($value)? " -register on":""',
	},
	"html_markup_options" => {
	},
	"html_output" => {
		"perl" => '" -html $value"',
	},
	"pagecolor" => {
		"perl" => '($value)? " -pagecolor $value" : ""',
	},
	"textcolor" => {
		"perl" => '($value && $value ne $vdef)? " -textcolor $value" : ""',
	},
	"linkcolor" => {
		"perl" => '($value && $value ne $vdef)? " -linkcolor $value" : ""',
	},
	"alinkcolor" => {
		"perl" => '($value && $value ne $vdef)? " -alinkcolor $value" : ""',
	},
	"vlinkcolor" => {
		"perl" => '($value && $value ne $vdef)? " -vlinkcolor $value" : ""',
	},
	"alncolor" => {
		"perl" => '($value)? " -alncolor $value" : ""',
	},
	"symcolor" => {
		"perl" => '($value)? " -symcolor $value" : ""',
	},
	"gapcolor" => {
		"perl" => '($value)? " -gapcolor $value" : ""',
	},
	"bold" => {
		"perl" => '($value)? " -bold":""',
	},
	"css" => {
		"perl" => '($value eq "on")? " -css on" : ""',
	},
	"srs" => {
		"perl" => '($value)? " -srs on":""',
	},
	"blast_options" => {
	},
	"hsp" => {
		"perl" => '($value && $value ne $vdef)? " -hsp $value":""',
	},
	"strand" => {
		"perl" => '(defined $value && $value ne $vdef)? " -strand $value":""',
	},
	"blast1_options" => {
	},
	"maxpval" => {
		"perl" => '(defined $value)? " -maxpval $value":""',
	},
	"minscore" => {
		"perl" => '(defined $value)? " -minscore $value":""',
	},
	"blast2_options" => {
	},
	"maxeval" => {
		"perl" => '(defined $value)? " -maxeval $value":""',
	},
	"minbits" => {
		"perl" => '(defined $value)? " -minbits $value":""',
	},
	"cycle" => {
		"perl" => '($value)? " -cycle $value" : "" ',
	},
	"fasta_options" => {
	},
	"minopt" => {
		"perl" => '(defined $value)? " -minopt $value":""',
	},
	"fasta_strand" => {
		"perl" => '(defined $value && $value ne $vdef)? " -strand $value":""',
	},
	"html_output_file" => {
		"perl" => '" > mview.html"',
	},
	"html_file" => {
	},
	"alig_file" => {
	},
	"out" => {
		"perl" => '($value eq "html")? "" : " -out $value"',
	},

    };

    $self->{FILENAMES}  = {
	"html_file" => 'mview.html',
	"alig_file" => 'mview*.out',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"mview_blast" => 0,
	"blast_output" => 1000,
	"in" => 2,
	"main_formatting_options" => 2,
	"ruler" => 2,
	"alignment" => 2,
	"consensus" => 2,
	"dna" => 2,
	"alignment_options" => 3,
	"coloring" => 3,
	"threshold" => 3,
	"ignore" => 3,
	"consensus_options" => 3,
	"con_coloring" => 3,
	"con_threshold" => 3,
	"con_ignore" => 3,
	"hybrid_alignment_consensus_options" => 3,
	"con_gaps" => 3,
	"general_row_column_filters" => 3,
	"top" => 3,
	"range" => 3,
	"maxident" => 3,
	"ref" => 3,
	"keep_only" => 3,
	"disc" => 3,
	"nops" => 3,
	"general_formatting_options" => 3,
	"width" => 3,
	"gap" => 3,
	"label0" => 3,
	"label1" => 3,
	"label2" => 3,
	"label3" => 3,
	"label4" => 3,
	"register" => 3,
	"html_markup_options" => 3,
	"html_output" => 1,
	"pagecolor" => 3,
	"textcolor" => 3,
	"linkcolor" => 3,
	"alinkcolor" => 3,
	"vlinkcolor" => 3,
	"alncolor" => 3,
	"symcolor" => 3,
	"gapcolor" => 3,
	"bold" => 3,
	"css" => 3,
	"srs" => 3,
	"blast_options" => 3,
	"hsp" => 3,
	"strand" => 3,
	"blast1_options" => 3,
	"maxpval" => 3,
	"minscore" => 3,
	"blast2_options" => 3,
	"maxeval" => 3,
	"minbits" => 3,
	"cycle" => 3,
	"html_output_file" => 2000,
	"out" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"mview_blast",
	"alig_file",
	"fasta_options",
	"minopt",
	"fasta_strand",
	"html_file",
	"html_output",
	"out",
	"in",
	"main_formatting_options",
	"ruler",
	"alignment",
	"consensus",
	"dna",
	"con_threshold",
	"con_ignore",
	"hybrid_alignment_consensus_options",
	"con_gaps",
	"general_row_column_filters",
	"top",
	"range",
	"maxident",
	"ref",
	"keep_only",
	"disc",
	"nops",
	"general_formatting_options",
	"width",
	"gap",
	"label0",
	"label1",
	"label2",
	"label3",
	"label4",
	"register",
	"html_markup_options",
	"pagecolor",
	"textcolor",
	"linkcolor",
	"alinkcolor",
	"vlinkcolor",
	"alncolor",
	"symcolor",
	"gapcolor",
	"bold",
	"css",
	"srs",
	"blast_options",
	"hsp",
	"strand",
	"blast1_options",
	"maxpval",
	"minscore",
	"blast2_options",
	"maxeval",
	"minbits",
	"cycle",
	"alignment_options",
	"coloring",
	"threshold",
	"ignore",
	"consensus_options",
	"con_coloring",
	"blast_output",
	"html_output_file",

    ];

    $self->{SIZE}  = {
	"con_threshold" => 50,
	"pagecolor" => 20,
	"textcolor" => 20,
	"linkcolor" => 20,
	"alinkcolor" => 20,
	"vlinkcolor" => 20,
	"alncolor" => 20,
	"symcolor" => 20,
	"gapcolor" => 20,

    };

    $self->{ISHIDDEN}  = {
	"mview_blast" => 1,
	"blast_output" => 0,
	"in" => 0,
	"main_formatting_options" => 0,
	"ruler" => 0,
	"alignment" => 0,
	"consensus" => 0,
	"dna" => 0,
	"alignment_options" => 0,
	"coloring" => 0,
	"threshold" => 0,
	"ignore" => 0,
	"consensus_options" => 0,
	"con_coloring" => 0,
	"con_threshold" => 0,
	"con_ignore" => 0,
	"hybrid_alignment_consensus_options" => 0,
	"con_gaps" => 0,
	"general_row_column_filters" => 0,
	"top" => 0,
	"range" => 0,
	"maxident" => 0,
	"ref" => 0,
	"keep_only" => 0,
	"disc" => 0,
	"nops" => 0,
	"general_formatting_options" => 0,
	"width" => 0,
	"gap" => 0,
	"label0" => 0,
	"label1" => 0,
	"label2" => 0,
	"label3" => 0,
	"label4" => 0,
	"register" => 0,
	"html_markup_options" => 0,
	"html_output" => 0,
	"pagecolor" => 0,
	"textcolor" => 0,
	"linkcolor" => 0,
	"alinkcolor" => 0,
	"vlinkcolor" => 0,
	"alncolor" => 0,
	"symcolor" => 0,
	"gapcolor" => 0,
	"bold" => 0,
	"css" => 0,
	"srs" => 0,
	"blast_options" => 0,
	"hsp" => 0,
	"strand" => 0,
	"blast1_options" => 0,
	"maxpval" => 0,
	"minscore" => 0,
	"blast2_options" => 0,
	"maxeval" => 0,
	"minbits" => 0,
	"cycle" => 0,
	"fasta_options" => 0,
	"minopt" => 0,
	"fasta_strand" => 0,
	"html_output_file" => 1,
	"html_file" => 0,
	"alig_file" => 0,
	"out" => 0,

    };

    $self->{ISCOMMAND}  = {
	"mview_blast" => 1,
	"blast_output" => 0,
	"in" => 0,
	"main_formatting_options" => 0,
	"ruler" => 0,
	"alignment" => 0,
	"consensus" => 0,
	"dna" => 0,
	"alignment_options" => 0,
	"coloring" => 0,
	"threshold" => 0,
	"ignore" => 0,
	"consensus_options" => 0,
	"con_coloring" => 0,
	"con_threshold" => 0,
	"con_ignore" => 0,
	"hybrid_alignment_consensus_options" => 0,
	"con_gaps" => 0,
	"general_row_column_filters" => 0,
	"top" => 0,
	"range" => 0,
	"maxident" => 0,
	"ref" => 0,
	"keep_only" => 0,
	"disc" => 0,
	"nops" => 0,
	"general_formatting_options" => 0,
	"width" => 0,
	"gap" => 0,
	"label0" => 0,
	"label1" => 0,
	"label2" => 0,
	"label3" => 0,
	"label4" => 0,
	"register" => 0,
	"html_markup_options" => 0,
	"html_output" => 0,
	"pagecolor" => 0,
	"textcolor" => 0,
	"linkcolor" => 0,
	"alinkcolor" => 0,
	"vlinkcolor" => 0,
	"alncolor" => 0,
	"symcolor" => 0,
	"gapcolor" => 0,
	"bold" => 0,
	"css" => 0,
	"srs" => 0,
	"blast_options" => 0,
	"hsp" => 0,
	"strand" => 0,
	"blast1_options" => 0,
	"maxpval" => 0,
	"minscore" => 0,
	"blast2_options" => 0,
	"maxeval" => 0,
	"minbits" => 0,
	"cycle" => 0,
	"fasta_options" => 0,
	"minopt" => 0,
	"fasta_strand" => 0,
	"html_output_file" => 0,
	"html_file" => 0,
	"alig_file" => 0,
	"out" => 0,

    };

    $self->{ISMANDATORY}  = {
	"mview_blast" => 0,
	"blast_output" => 1,
	"in" => 1,
	"main_formatting_options" => 0,
	"ruler" => 0,
	"alignment" => 0,
	"consensus" => 0,
	"dna" => 0,
	"alignment_options" => 0,
	"coloring" => 0,
	"threshold" => 0,
	"ignore" => 0,
	"consensus_options" => 0,
	"con_coloring" => 0,
	"con_threshold" => 0,
	"con_ignore" => 0,
	"hybrid_alignment_consensus_options" => 0,
	"con_gaps" => 0,
	"general_row_column_filters" => 0,
	"top" => 0,
	"range" => 0,
	"maxident" => 0,
	"ref" => 0,
	"keep_only" => 0,
	"disc" => 0,
	"nops" => 0,
	"general_formatting_options" => 0,
	"width" => 0,
	"gap" => 0,
	"label0" => 0,
	"label1" => 0,
	"label2" => 0,
	"label3" => 0,
	"label4" => 0,
	"register" => 0,
	"html_markup_options" => 0,
	"html_output" => 1,
	"pagecolor" => 0,
	"textcolor" => 0,
	"linkcolor" => 0,
	"alinkcolor" => 0,
	"vlinkcolor" => 0,
	"alncolor" => 0,
	"symcolor" => 0,
	"gapcolor" => 0,
	"bold" => 0,
	"css" => 0,
	"srs" => 0,
	"blast_options" => 0,
	"hsp" => 0,
	"strand" => 0,
	"blast1_options" => 0,
	"maxpval" => 0,
	"minscore" => 0,
	"blast2_options" => 0,
	"maxeval" => 0,
	"minbits" => 0,
	"cycle" => 0,
	"fasta_options" => 0,
	"minopt" => 0,
	"fasta_strand" => 0,
	"html_output_file" => 0,
	"html_file" => 0,
	"alig_file" => 0,
	"out" => 1,

    };

    $self->{PROMPT}  = {
	"mview_blast" => "",
	"blast_output" => "Blast/FASTA Output File",
	"in" => "Type of search (-in)",
	"main_formatting_options" => "Main formatting options",
	"ruler" => "Attach a ruler (-ruler)",
	"alignment" => "Show alignment (-alignment)",
	"consensus" => "Show consensus (-consensus)",
	"dna" => "Use DNA/RNA colormaps and/or consensus groups (-dna)",
	"alignment_options" => "Alignment options",
	"coloring" => "Colour scheme (-coloring)",
	"threshold" => "Threshold percentage for consensus coloring (-threshold)",
	"ignore" => "Ignore singleton or class group (-ignore)",
	"consensus_options" => "Consensus options",
	"con_coloring" => "Basic style of coloring (-con_coloring)",
	"con_threshold" => "Consensus line thresholds (in range 50..100) (separated by commas) (-con_threshold)",
	"con_ignore" => "Ignore singleton or class group (-con_ignore)",
	"hybrid_alignment_consensus_options" => "Hybrid alignment and consensus options",
	"con_gaps" => "Count gaps during consensus computations (-con_gaps)",
	"general_row_column_filters" => "General row/column filters",
	"top" => "Report top N hits (-top)",
	"range" => "Display column range M..N as numbered by ruler (M,N) (-range)",
	"maxident" => "Only report sequences with %identity <= N (-maxident)",
	"ref" => "Use row N or row identifier as %id entity reference (-ref)",
	"keep_only" => "Keep only the rows from start to end (separated by commas: start,end) (-keep)",
	"disc" => "Discard rows from start to end (separated by commas: start,end) (-disc)",
	"nops" => "Display rows unprocessed (separated by commas) (-nops)",
	"general_formatting_options" => "General formatting options",
	"width" => "Paginate in N columns of alignment (-width)",
	"gap" => "Use this character as the gap (-gap)",
	"label0" => "Switch off label: row number (-label0)",
	"label1" => "Switch off label: identifier (-label1)",
	"label2" => "Switch off label: description (-label2)",
	"label3" => "Switch off label: scores (-label3)",
	"label4" => "Switch off label: percent identity (-label4)",
	"register" => "Output multi-pass alignments with columns in register (-register)",
	"html_markup_options" => "HTML markup options",
	"html_output" => "HTML output",
	"pagecolor" => "Page backgound color (-pagecolor)",
	"textcolor" => "Page text color (-textcolor)",
	"linkcolor" => "Link color (-linkcolor)",
	"alinkcolor" => "Active link color (-alinkcolor)",
	"vlinkcolor" => "Visited link color (-vlinkcolor)",
	"alncolor" => "Alignment background color (-alncolor)",
	"symcolor" => "Alignment default text color (-symcolor)",
	"gapcolor" => "Alignment gap color (-gapcolor)",
	"bold" => "Use bold emphasis for coloured residues (-bold)",
	"css" => "Use Cascading Style Sheets (-css)",
	"srs" => "Try to use SRS links (-srs)",
	"blast_options" => "BLAST options",
	"hsp" => "HSP tiling method (-hsp)",
	"strand" => "Report only these query strand orientations (-strand)",
	"blast1_options" => "BLAST series 1 options",
	"maxpval" => "Ignore hits with p-value more than N -- Blastp only (-maxpval)",
	"minscore" => "Ignore hits with score less than N (-minscore)",
	"blast2_options" => "BLAST series 2 options",
	"maxeval" => "Ignore hits with p-value more than N -- Blast2 only (-maxeval)",
	"minbits" => "Ignore hits with bits less than N (-minbits)",
	"cycle" => "Process the Nth cycle of a multipass search (-cycle)",
	"fasta_options" => "FASTA options",
	"minopt" => "Ignore hits with opt score less than N (-minopt)",
	"fasta_strand" => "Report only these query strand orientations (-strand)",
	"html_output_file" => "",
	"html_file" => "",
	"alig_file" => "",
	"out" => "Output format (-out)",

    };

    $self->{ISSTANDOUT}  = {
	"mview_blast" => 0,
	"blast_output" => 0,
	"in" => 0,
	"main_formatting_options" => 0,
	"ruler" => 0,
	"alignment" => 0,
	"consensus" => 0,
	"dna" => 0,
	"alignment_options" => 0,
	"coloring" => 0,
	"threshold" => 0,
	"ignore" => 0,
	"consensus_options" => 0,
	"con_coloring" => 0,
	"con_threshold" => 0,
	"con_ignore" => 0,
	"hybrid_alignment_consensus_options" => 0,
	"con_gaps" => 0,
	"general_row_column_filters" => 0,
	"top" => 0,
	"range" => 0,
	"maxident" => 0,
	"ref" => 0,
	"keep_only" => 0,
	"disc" => 0,
	"nops" => 0,
	"general_formatting_options" => 0,
	"width" => 0,
	"gap" => 0,
	"label0" => 0,
	"label1" => 0,
	"label2" => 0,
	"label3" => 0,
	"label4" => 0,
	"register" => 0,
	"html_markup_options" => 0,
	"html_output" => 0,
	"pagecolor" => 0,
	"textcolor" => 0,
	"linkcolor" => 0,
	"alinkcolor" => 0,
	"vlinkcolor" => 0,
	"alncolor" => 0,
	"symcolor" => 0,
	"gapcolor" => 0,
	"bold" => 0,
	"css" => 0,
	"srs" => 0,
	"blast_options" => 0,
	"hsp" => 0,
	"strand" => 0,
	"blast1_options" => 0,
	"maxpval" => 0,
	"minscore" => 0,
	"blast2_options" => 0,
	"maxeval" => 0,
	"minbits" => 0,
	"cycle" => 0,
	"fasta_options" => 0,
	"minopt" => 0,
	"fasta_strand" => 0,
	"html_output_file" => 1,
	"html_file" => 0,
	"alig_file" => 0,
	"out" => 0,

    };

    $self->{VLIST}  = {

	"in" => ['blast','Blast','fasta','FASTA',],
	"main_formatting_options" => ['ruler','alignment','consensus','dna',],
	"alignment_options" => ['coloring','threshold','ignore',],
	"coloring" => ['any','any: colour all the residues','consensus','consensus: colour only when above a given percent similarity','group','group: colours residues by the colour of the class to which they belong','identity','identity: colouring by identity to the first sequence','none','none: no colouring',],
	"ignore" => ['class','class','none','none','singleton','singleton',],
	"consensus_options" => ['con_coloring','con_threshold','con_ignore',],
	"con_coloring" => ['any','any: colour all the residues','identity','identity: colouring by identity to the first sequence','none','none: no colouring',],
	"con_ignore" => ['class','class','none','none','singleton','singleton',],
	"hybrid_alignment_consensus_options" => ['con_gaps',],
	"general_row_column_filters" => ['top','range','maxident','ref','keep_only','disc','nops',],
	"general_formatting_options" => ['width','gap','label0','label1','label2','label3','label4','register',],
	"html_markup_options" => ['html_output','pagecolor','textcolor','linkcolor','alinkcolor','vlinkcolor','alncolor','symcolor','gapcolor','bold','css','srs',],
	"html_output" => ['full','full','head','head','body','body','data','data','css','css','off','off',],
	"css" => ['off','off','on','on',],
	"blast_options" => ['hsp','strand','blast1_options','blast2_options',],
	"hsp" => ['all','all','discrete','discrete','ranked','ranked',],
	"strand" => ['p','p','m','m','*','*',],
	"blast1_options" => ['maxpval','minscore',],
	"blast2_options" => ['maxeval','minbits','cycle',],
	"fasta_options" => ['minopt','fasta_strand',],
	"fasta_strand" => ['p','p','m','m','*','*',],
	"out" => ['html','HTML','msf','GCG/MSF','pearson','Pearson/FASTA','pir','PIR','rdb','RDB table for storage/manipulation in relational database form',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"in" => 'blast',
	"alignment" => '1',
	"dna" => '0',
	"threshold" => '70.0',
	"ignore" => 'none',
	"con_threshold" => '100,90,80,70',
	"con_ignore" => 'none',
	"con_gaps" => '1',
	"maxident" => '100',
	"html_output" => 'full',
	"textcolor" => 'black',
	"linkcolor" => 'blue',
	"alinkcolor" => 'red',
	"vlinkcolor" => 'purple',
	"css" => 'off',
	"hsp" => 'ranked',
	"strand" => '*',
	"fasta_strand" => '*',
	"out" => 'html',

    };

    $self->{PRECOND}  = {
	"mview_blast" => { "perl" => '1' },
	"blast_output" => { "perl" => '1' },
	"in" => { "perl" => '1' },
	"main_formatting_options" => { "perl" => '1' },
	"ruler" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"consensus" => { "perl" => '1' },
	"dna" => { "perl" => '1' },
	"alignment_options" => { "perl" => '1' },
	"coloring" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"ignore" => { "perl" => '1' },
	"consensus_options" => {
		"perl" => '$consensus',
	},
	"con_coloring" => {
		"perl" => '$consensus',
	},
	"con_threshold" => {
		"perl" => '$consensus',
	},
	"con_ignore" => {
		"perl" => '$consensus',
	},
	"hybrid_alignment_consensus_options" => { "perl" => '1' },
	"con_gaps" => { "perl" => '1' },
	"general_row_column_filters" => { "perl" => '1' },
	"top" => { "perl" => '1' },
	"range" => { "perl" => '1' },
	"maxident" => { "perl" => '1' },
	"ref" => { "perl" => '1' },
	"keep_only" => { "perl" => '1' },
	"disc" => { "perl" => '1' },
	"nops" => { "perl" => '1' },
	"general_formatting_options" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"gap" => { "perl" => '1' },
	"label0" => { "perl" => '1' },
	"label1" => { "perl" => '1' },
	"label2" => { "perl" => '1' },
	"label3" => { "perl" => '1' },
	"label4" => { "perl" => '1' },
	"register" => { "perl" => '1' },
	"html_markup_options" => { "perl" => '1' },
	"html_output" => {
		"perl" => '$_html && $out eq "html" ',
	},
	"pagecolor" => { "perl" => '1' },
	"textcolor" => { "perl" => '1' },
	"linkcolor" => { "perl" => '1' },
	"alinkcolor" => { "perl" => '1' },
	"vlinkcolor" => { "perl" => '1' },
	"alncolor" => { "perl" => '1' },
	"symcolor" => { "perl" => '1' },
	"gapcolor" => { "perl" => '1' },
	"bold" => { "perl" => '1' },
	"css" => { "perl" => '1' },
	"srs" => { "perl" => '1' },
	"blast_options" => {
		"perl" => ' $in eq "blast" ',
	},
	"hsp" => {
		"perl" => ' $in eq "blast" ',
	},
	"strand" => {
		"perl" => ' $in eq "blast" ',
	},
	"blast1_options" => {
		"perl" => ' $in eq "blast" ',
	},
	"maxpval" => {
		"perl" => ' $in eq "blast" ',
	},
	"minscore" => {
		"perl" => ' $in eq "blast" ',
	},
	"blast2_options" => {
		"perl" => ' $in eq "blast" ',
	},
	"maxeval" => {
		"perl" => ' $in eq "blast" ',
	},
	"minbits" => {
		"perl" => ' $in eq "blast" ',
	},
	"cycle" => {
		"perl" => ' $in eq "blast" ',
	},
	"fasta_options" => { "perl" => '1' },
	"minopt" => { "perl" => '1' },
	"fasta_strand" => { "perl" => '1' },
	"html_output_file" => {
		"perl" => '$_html && $out eq "html" ',
	},
	"html_file" => {
		"perl" => '$_html && $out eq "html" ',
	},
	"alig_file" => {
		"perl" => '$out eq "msf" || $out eq "pearson" || $out eq "pir"',
	},
	"out" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"alig_file" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"blast_output" => {
		 "blast_output" => '1',
		 "mview_input" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"mview_blast" => 0,
	"blast_output" => 0,
	"in" => 0,
	"main_formatting_options" => 0,
	"ruler" => 0,
	"alignment" => 0,
	"consensus" => 0,
	"dna" => 0,
	"alignment_options" => 0,
	"coloring" => 0,
	"threshold" => 0,
	"ignore" => 0,
	"consensus_options" => 0,
	"con_coloring" => 0,
	"con_threshold" => 0,
	"con_ignore" => 0,
	"hybrid_alignment_consensus_options" => 0,
	"con_gaps" => 0,
	"general_row_column_filters" => 0,
	"top" => 0,
	"range" => 0,
	"maxident" => 0,
	"ref" => 0,
	"keep_only" => 0,
	"disc" => 0,
	"nops" => 0,
	"general_formatting_options" => 0,
	"width" => 0,
	"gap" => 0,
	"label0" => 0,
	"label1" => 0,
	"label2" => 0,
	"label3" => 0,
	"label4" => 0,
	"register" => 0,
	"html_markup_options" => 0,
	"html_output" => 0,
	"pagecolor" => 0,
	"textcolor" => 0,
	"linkcolor" => 0,
	"alinkcolor" => 0,
	"vlinkcolor" => 0,
	"alncolor" => 0,
	"symcolor" => 0,
	"gapcolor" => 0,
	"bold" => 0,
	"css" => 0,
	"srs" => 0,
	"blast_options" => 0,
	"hsp" => 0,
	"strand" => 0,
	"blast1_options" => 0,
	"maxpval" => 0,
	"minscore" => 0,
	"blast2_options" => 0,
	"maxeval" => 0,
	"minbits" => 0,
	"cycle" => 0,
	"fasta_options" => 0,
	"minopt" => 0,
	"fasta_strand" => 0,
	"html_output_file" => 0,
	"html_file" => 0,
	"alig_file" => 0,
	"out" => 0,

    };

    $self->{ISSIMPLE}  = {
	"mview_blast" => 0,
	"blast_output" => 1,
	"in" => 1,
	"main_formatting_options" => 0,
	"ruler" => 1,
	"alignment" => 1,
	"consensus" => 1,
	"dna" => 1,
	"alignment_options" => 0,
	"coloring" => 1,
	"threshold" => 0,
	"ignore" => 0,
	"consensus_options" => 0,
	"con_coloring" => 0,
	"con_threshold" => 0,
	"con_ignore" => 0,
	"hybrid_alignment_consensus_options" => 0,
	"con_gaps" => 0,
	"general_row_column_filters" => 0,
	"top" => 0,
	"range" => 0,
	"maxident" => 0,
	"ref" => 0,
	"keep_only" => 0,
	"disc" => 0,
	"nops" => 0,
	"general_formatting_options" => 0,
	"width" => 0,
	"gap" => 0,
	"label0" => 0,
	"label1" => 0,
	"label2" => 0,
	"label3" => 0,
	"label4" => 0,
	"register" => 0,
	"html_markup_options" => 0,
	"html_output" => 0,
	"pagecolor" => 0,
	"textcolor" => 0,
	"linkcolor" => 0,
	"alinkcolor" => 0,
	"vlinkcolor" => 0,
	"alncolor" => 0,
	"symcolor" => 0,
	"gapcolor" => 0,
	"bold" => 0,
	"css" => 0,
	"srs" => 0,
	"blast_options" => 0,
	"hsp" => 0,
	"strand" => 0,
	"blast1_options" => 0,
	"maxpval" => 0,
	"minscore" => 0,
	"blast2_options" => 0,
	"maxeval" => 0,
	"minbits" => 0,
	"cycle" => 0,
	"fasta_options" => 0,
	"minopt" => 0,
	"fasta_strand" => 0,
	"html_output_file" => 0,
	"html_file" => 0,
	"alig_file" => 0,
	"out" => 1,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"coloring" => [
		"-coloring consensus: will colour only those residues that belong to a specified physicochemical class that is conserved in at least a specified percentage of all rows for a given column. This defaults to 70% and and may be set to another threshold, eg., -coloring consensus -threshold 80 would specify 80%. Note that the physicochemical classes in question can be confined to individual residues. ",
		"-coloring group, is like -coloring consensus, but colours residues by the colour of the class to which they belong.",
		"By default, the consensus computation counts gap characters, so that sections of the alignment may be uncolored where the presence of gaps prevents the non-gap count from reaching the threshold. Setting -con_gaps off prevents this, allowing sequence-only based consensus thresholding. ",
		"The default palette assumes the input alignment is of protein sequences and sets their colours according to amino acid physicochemical properties: another palette should be selected for DNA or RNA alignments. ",
		"Consensus colouring is complicated and some understanding of palettes and consensus patterns is required first before trying to explain alignment consensus colouring.",
	],
	"ignore" => [
		"Tip: If you want to see only the conserved residues above the threshold (ie., only one type of conserved residue per column), add the option -ignore class. ",
	],
	"con_coloring" => [
		"-coloring consensus: will colour only those residues that belong to a specified physicochemical class that is conserved in at least a specified percentage of all rows for a given column. This defaults to 70% and and may be set to another threshold, eg., -coloring consensus -threshold 80 would specify 80%. Note that the physicochemical classes in question can be confined to individual residues. ",
		"-coloring group, is like -coloring consensus, but colours residues by the colour of the class to which they belong.",
		"By default, the consensus computation counts gap characters, so that sections of the alignment may be uncolored where the presence of gaps prevents the non-gap count from reaching the threshold. Setting -con_gaps off prevents this, allowing sequence-only based consensus thresholding. ",
		"The default palette assumes the input alignment is of protein sequences and sets their colours according to amino acid physicochemical properties: another palette should be selected for DNA or RNA alignments. ",
		"Consensus colouring is complicated and some understanding of palettes and consensus patterns is required first before trying to explain alignment consensus colouring.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mview_blast.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

