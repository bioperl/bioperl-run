
=head1 NAME

Bio::Tools::Run::PiseApplication::pratt

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pratt

      Bioperl class for:

	Pratt	pattern discovery (K. Sturzrehm, I. Jonassen)

      Parameters:


		pratt (String)


		seq (Sequence)
			Sequence File

		seqformat (Excl)
			Sequence File format

		conservation (Paragraph)
			Pattern conservation parameters

		CM (Integer)
			CM: min Nr of Seqs to Match (between 2 and 4)

		Cpct (Integer)
			C%: min Percentage Seqs to Match

		restrictions (Paragraph)
			Pattern restrictions parameters

		PP (Excl)
			PP: pos in seq

		PF (InFile)
			PF: Restriction File name (if PP not off)

		PL (Integer)
			PL: max Pattern Length

		PN (Integer)
			PN: max Nr of Pattern Symbols

		PX (Integer)
			PX: max Nr of consecutive x's

		FN (Integer)
			FN: max Nr of flexible spacers

		FL (Integer)
			FL: max Flexibility

		FP (Integer)
			FP: max Flex.Product

		BI (Switch)
			BI: Input Pattern Symbol File?

		BF (InFile)
			BF: Input Pattern Symbol File name (if BI on)

		BN (Integer)
			BN: Nr of Pattern Symbols Initial Search

		scoring (Paragraph)
			Pattern Scoring parameters

		S (Excl)
			S: Scoring

		treefile (InFile)
			Tree File (if Scoring = tree)

		distfile (InFile)
			Distances File (if Scoring = dist)

		swissprotdb (String)


		mdl_param (Paragraph)
			MDL parameters (Z0-Z3) (if MDL scoring)

		Z0 (Integer)
			Z0

		Z1 (Integer)
			Z1

		Z2 (Integer)
			Z2

		Z3 (Integer)
			Z3

		search (Paragraph)
			Search parameters

		G (Excl)
			G: Pattern Graph from:

		GF (InFile)
			Alignment or Query Filename (if G set to al or query)

		E (Integer)
			E: Search Greediness

		R (Switch)
			R: Pattern Refinement

		RG (Switch)
			RG: Generalise ambiguous symbols (if Pattern Refinement on)

		output (Paragraph)
			Output options

		OF (OutFile)
			OF: Output Filename

		outfiles (Results)


		OP (Switch)
			OP: PROSITE Pattern Format

		ON (Integer)
			ON: max number patterns

		OA (Integer)
			OA: max number Alignments

		M (Switch)
			M: Print Patterns in sequences

		MR (Integer)
			MR: ratio for printing

		MV (Switch)
			MV: print vertically

		report (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::pratt;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pratt = Bio::Tools::Run::PiseApplication::pratt->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pratt object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pratt = $factory->program('pratt');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pratt.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pratt.pm

    $self->{COMMAND}   = "pratt";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Pratt";

    $self->{DESCRIPTION}   = "pattern discovery";

    $self->{AUTHORS}   = "K. Sturzrehm, I. Jonassen";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pratt",
	"seq",
	"seqformat",
	"conservation",
	"restrictions",
	"scoring",
	"search",
	"output",
	"report",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pratt",
	"seq", 	# Sequence File
	"seqformat", 	# Sequence File format
	"conservation", 	# Pattern conservation parameters
	"CM", 	# CM: min Nr of Seqs to Match (between 2 and 4)
	"Cpct", 	# C%: min Percentage Seqs to Match
	"restrictions", 	# Pattern restrictions parameters
	"PP", 	# PP: pos in seq
	"PF", 	# PF: Restriction File name (if PP not off)
	"PL", 	# PL: max Pattern Length
	"PN", 	# PN: max Nr of Pattern Symbols
	"PX", 	# PX: max Nr of consecutive x's
	"FN", 	# FN: max Nr of flexible spacers
	"FL", 	# FL: max Flexibility
	"FP", 	# FP: max Flex.Product
	"BI", 	# BI: Input Pattern Symbol File?
	"BF", 	# BF: Input Pattern Symbol File name (if BI on)
	"BN", 	# BN: Nr of Pattern Symbols Initial Search
	"scoring", 	# Pattern Scoring parameters
	"S", 	# S: Scoring
	"treefile", 	# Tree File (if Scoring = tree)
	"distfile", 	# Distances File (if Scoring = dist)
	"swissprotdb",
	"mdl_param", 	# MDL parameters (Z0-Z3) (if MDL scoring)
	"Z0", 	# Z0
	"Z1", 	# Z1
	"Z2", 	# Z2
	"Z3", 	# Z3
	"search", 	# Search parameters
	"G", 	# G: Pattern Graph from:
	"GF", 	# Alignment or Query Filename (if G set to al or query)
	"E", 	# E: Search Greediness
	"R", 	# R: Pattern Refinement
	"RG", 	# RG: Generalise ambiguous symbols (if Pattern Refinement on)
	"output", 	# Output options
	"OF", 	# OF: Output Filename
	"outfiles",
	"OP", 	# OP: PROSITE Pattern Format
	"ON", 	# ON: max number patterns
	"OA", 	# OA: max number Alignments
	"M", 	# M: Print Patterns in sequences
	"MR", 	# MR: ratio for printing
	"MV", 	# MV: print vertically
	"report",

    ];

    $self->{TYPE}  = {
	"pratt" => 'String',
	"seq" => 'Sequence',
	"seqformat" => 'Excl',
	"conservation" => 'Paragraph',
	"CM" => 'Integer',
	"Cpct" => 'Integer',
	"restrictions" => 'Paragraph',
	"PP" => 'Excl',
	"PF" => 'InFile',
	"PL" => 'Integer',
	"PN" => 'Integer',
	"PX" => 'Integer',
	"FN" => 'Integer',
	"FL" => 'Integer',
	"FP" => 'Integer',
	"BI" => 'Switch',
	"BF" => 'InFile',
	"BN" => 'Integer',
	"scoring" => 'Paragraph',
	"S" => 'Excl',
	"treefile" => 'InFile',
	"distfile" => 'InFile',
	"swissprotdb" => 'String',
	"mdl_param" => 'Paragraph',
	"Z0" => 'Integer',
	"Z1" => 'Integer',
	"Z2" => 'Integer',
	"Z3" => 'Integer',
	"search" => 'Paragraph',
	"G" => 'Excl',
	"GF" => 'InFile',
	"E" => 'Integer',
	"R" => 'Switch',
	"RG" => 'Switch',
	"output" => 'Paragraph',
	"OF" => 'OutFile',
	"outfiles" => 'Results',
	"OP" => 'Switch',
	"ON" => 'Integer',
	"OA" => 'Integer',
	"M" => 'Switch',
	"MR" => 'Integer',
	"MV" => 'Switch',
	"report" => 'Results',

    };

    $self->{FORMAT}  = {
	"pratt" => {
		"perl" => ' "pratt" ',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"seqformat" => {
		"perl" => '" $value"',
	},
	"conservation" => {
	},
	"CM" => {
		"perl" => '(defined $value)? " -CM $value":""',
	},
	"Cpct" => {
		"perl" => '(defined $value && $value != $vdef)? " -C% $value":""',
	},
	"restrictions" => {
	},
	"PP" => {
		"perl" => '($value && $value ne $vdef)? " -PP $value":""',
	},
	"PF" => {
		"perl" => '" -PF $value"',
	},
	"PL" => {
		"perl" => '(defined $value && $value != $vdef)? " -PL $value":""',
	},
	"PN" => {
		"perl" => '(defined $value && $value != $vdef)? " -PN $value":" -AUTO"',
	},
	"PX" => {
		"perl" => '(defined $value && $value != $vdef)? " -PX $value":""',
	},
	"FN" => {
		"perl" => '(defined $value && $value != $vdef)? " -FN $value":""',
	},
	"FL" => {
		"perl" => '(defined $value && $value != $vdef)? " -FL $value":""',
	},
	"FP" => {
		"perl" => '(defined $value && $value != $vdef)? " -FP $value":""',
	},
	"BI" => {
		"perl" => '($value)? " -BI on":""',
	},
	"BF" => {
		"perl" => '($value) ? " -BI $value" : "/local/gensoft/lib/pratt/Pratt.sets.big" ',
	},
	"BN" => {
		"perl" => '(defined $value && $value != $vdef)? " -BN $value":""',
	},
	"scoring" => {
	},
	"S" => {
		"perl" => '($value && $value != $vdef)? " -S $value":""',
	},
	"treefile" => {
		"perl" => '" -SF $value "',
	},
	"distfile" => {
		"perl" => '" -SF $value; "',
	},
	"swissprotdb" => {
		"perl" => '" -SF /local/gensoft/lib/pratt/sprot.dat"',
	},
	"mdl_param" => {
	},
	"Z0" => {
		"perl" => '($value != $vdef)? " -Z0 $value" : "" ',
	},
	"Z1" => {
		"perl" => '($value != $vdef)? " -Z1 $value" : ""',
	},
	"Z2" => {
		"perl" => '($value != $vdef)? " -Z2 $value" : ""',
	},
	"Z3" => {
		"perl" => '($value != $vdef)? " -Z3 $value" : ""',
	},
	"search" => {
	},
	"G" => {
		"perl" => '($value && $value ne $vdef)? " -G $value":""',
	},
	"GF" => {
		"perl" => '" -GF $value"',
	},
	"E" => {
		"perl" => '(defined $value && $value != $vdef)? " -E $value":""',
	},
	"R" => {
		"perl" => '(! $value)? " -R off" : "" ',
	},
	"RG" => {
		"perl" => '($value)? " -RG on" : "" ',
	},
	"output" => {
	},
	"OF" => {
		"perl" => '($value)? " -OF $value" : "" ',
	},
	"outfiles" => {
	},
	"OP" => {
		"perl" => '(! $value)? " -OP off " : "" ',
	},
	"ON" => {
		"perl" => '(defined $value && $value != $vdef)? " -ON $value":""',
	},
	"OA" => {
		"perl" => '(defined $value && $value != $vdef)? " -OA $value":""',
	},
	"M" => {
		"perl" => '(! $value)? " -M off " : "" ',
	},
	"MR" => {
		"perl" => '(defined $value && $value != $vdef)? " -MR $value":""',
	},
	"MV" => {
		"perl" => '($value)? " -MV on " : "" ',
	},
	"report" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfiles" => '*.pat',
	"report" => 'report',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"pratt" => 1,
	"seq" => 4,
	"seqformat" => 3,
	"conservation" => 5,
	"CM" => 5,
	"Cpct" => 5,
	"restrictions" => 5,
	"PP" => 5,
	"PF" => 5,
	"PL" => 5,
	"PN" => 5,
	"PX" => 5,
	"FN" => 5,
	"FL" => 5,
	"FP" => 5,
	"BI" => 5,
	"BF" => 5,
	"BN" => 5,
	"scoring" => 5,
	"S" => 5,
	"treefile" => 5,
	"distfile" => 5,
	"swissprotdb" => 5,
	"mdl_param" => 5,
	"Z0" => 5,
	"Z1" => 5,
	"Z2" => 5,
	"Z3" => 5,
	"search" => 5,
	"G" => 5,
	"GF" => 5,
	"E" => 5,
	"R" => 5,
	"RG" => 5,
	"output" => 5,
	"OF" => 5,
	"outfiles" => 5,
	"OP" => 5,
	"ON" => 5,
	"OA" => 5,
	"M" => 5,
	"MR" => 5,
	"MV" => 5,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"report",
	"pratt",
	"seqformat",
	"seq",
	"CM",
	"Cpct",
	"restrictions",
	"PP",
	"PF",
	"PL",
	"PN",
	"PX",
	"FN",
	"FL",
	"FP",
	"BI",
	"BF",
	"BN",
	"scoring",
	"S",
	"treefile",
	"distfile",
	"swissprotdb",
	"mdl_param",
	"Z0",
	"Z1",
	"Z2",
	"Z3",
	"search",
	"G",
	"GF",
	"E",
	"R",
	"RG",
	"output",
	"OF",
	"outfiles",
	"OP",
	"ON",
	"OA",
	"M",
	"MR",
	"MV",
	"conservation",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pratt" => 1,
	"seq" => 0,
	"seqformat" => 0,
	"conservation" => 0,
	"CM" => 0,
	"Cpct" => 0,
	"restrictions" => 0,
	"PP" => 0,
	"PF" => 0,
	"PL" => 0,
	"PN" => 0,
	"PX" => 0,
	"FN" => 0,
	"FL" => 0,
	"FP" => 0,
	"BI" => 0,
	"BF" => 0,
	"BN" => 0,
	"scoring" => 0,
	"S" => 0,
	"treefile" => 0,
	"distfile" => 0,
	"swissprotdb" => 1,
	"mdl_param" => 0,
	"Z0" => 0,
	"Z1" => 0,
	"Z2" => 0,
	"Z3" => 0,
	"search" => 0,
	"G" => 0,
	"GF" => 0,
	"E" => 0,
	"R" => 0,
	"RG" => 0,
	"output" => 0,
	"OF" => 0,
	"outfiles" => 0,
	"OP" => 0,
	"ON" => 0,
	"OA" => 0,
	"M" => 0,
	"MR" => 0,
	"MV" => 0,
	"report" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pratt" => 1,
	"seq" => 0,
	"seqformat" => 0,
	"conservation" => 0,
	"CM" => 0,
	"Cpct" => 0,
	"restrictions" => 0,
	"PP" => 0,
	"PF" => 0,
	"PL" => 0,
	"PN" => 0,
	"PX" => 0,
	"FN" => 0,
	"FL" => 0,
	"FP" => 0,
	"BI" => 0,
	"BF" => 0,
	"BN" => 0,
	"scoring" => 0,
	"S" => 0,
	"treefile" => 0,
	"distfile" => 0,
	"swissprotdb" => 0,
	"mdl_param" => 0,
	"Z0" => 0,
	"Z1" => 0,
	"Z2" => 0,
	"Z3" => 0,
	"search" => 0,
	"G" => 0,
	"GF" => 0,
	"E" => 0,
	"R" => 0,
	"RG" => 0,
	"output" => 0,
	"OF" => 0,
	"outfiles" => 0,
	"OP" => 0,
	"ON" => 0,
	"OA" => 0,
	"M" => 0,
	"MR" => 0,
	"MV" => 0,
	"report" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pratt" => 0,
	"seq" => 1,
	"seqformat" => 1,
	"conservation" => 0,
	"CM" => 0,
	"Cpct" => 0,
	"restrictions" => 0,
	"PP" => 0,
	"PF" => 0,
	"PL" => 0,
	"PN" => 0,
	"PX" => 0,
	"FN" => 0,
	"FL" => 0,
	"FP" => 0,
	"BI" => 0,
	"BF" => 0,
	"BN" => 0,
	"scoring" => 0,
	"S" => 0,
	"treefile" => 1,
	"distfile" => 1,
	"swissprotdb" => 0,
	"mdl_param" => 0,
	"Z0" => 1,
	"Z1" => 1,
	"Z2" => 1,
	"Z3" => 1,
	"search" => 0,
	"G" => 0,
	"GF" => 1,
	"E" => 0,
	"R" => 0,
	"RG" => 0,
	"output" => 0,
	"OF" => 0,
	"outfiles" => 0,
	"OP" => 0,
	"ON" => 0,
	"OA" => 0,
	"M" => 0,
	"MR" => 0,
	"MV" => 0,
	"report" => 0,

    };

    $self->{PROMPT}  = {
	"pratt" => "",
	"seq" => "Sequence File",
	"seqformat" => "Sequence File format",
	"conservation" => "Pattern conservation parameters",
	"CM" => "CM: min Nr of Seqs to Match (between 2 and 4)",
	"Cpct" => "C%: min Percentage Seqs to Match",
	"restrictions" => "Pattern restrictions parameters",
	"PP" => "PP: pos in seq",
	"PF" => "PF: Restriction File name (if PP not off)",
	"PL" => "PL: max Pattern Length",
	"PN" => "PN: max Nr of Pattern Symbols",
	"PX" => "PX: max Nr of consecutive x's",
	"FN" => "FN: max Nr of flexible spacers",
	"FL" => "FL: max Flexibility",
	"FP" => "FP: max Flex.Product",
	"BI" => "BI: Input Pattern Symbol File?",
	"BF" => "BF: Input Pattern Symbol File name (if BI on)",
	"BN" => "BN: Nr of Pattern Symbols Initial Search",
	"scoring" => "Pattern Scoring parameters",
	"S" => "S: Scoring",
	"treefile" => "Tree File (if Scoring = tree)",
	"distfile" => "Distances File (if Scoring = dist)",
	"swissprotdb" => "",
	"mdl_param" => "MDL parameters (Z0-Z3) (if MDL scoring)",
	"Z0" => "Z0",
	"Z1" => "Z1",
	"Z2" => "Z2",
	"Z3" => "Z3",
	"search" => "Search parameters",
	"G" => "G: Pattern Graph from:",
	"GF" => "Alignment or Query Filename (if G set to al or query)",
	"E" => "E: Search Greediness",
	"R" => "R: Pattern Refinement",
	"RG" => "RG: Generalise ambiguous symbols (if Pattern Refinement on)",
	"output" => "Output options",
	"OF" => "OF: Output Filename",
	"outfiles" => "",
	"OP" => "OP: PROSITE Pattern Format",
	"ON" => "ON: max number patterns",
	"OA" => "OA: max number Alignments",
	"M" => "M: Print Patterns in sequences",
	"MR" => "MR: ratio for printing",
	"MV" => "MV: print vertically",
	"report" => "",

    };

    $self->{ISSTANDOUT}  = {
	"pratt" => 0,
	"seq" => 0,
	"seqformat" => 0,
	"conservation" => 0,
	"CM" => 0,
	"Cpct" => 0,
	"restrictions" => 0,
	"PP" => 0,
	"PF" => 0,
	"PL" => 0,
	"PN" => 0,
	"PX" => 0,
	"FN" => 0,
	"FL" => 0,
	"FP" => 0,
	"BI" => 0,
	"BF" => 0,
	"BN" => 0,
	"scoring" => 0,
	"S" => 0,
	"treefile" => 0,
	"distfile" => 0,
	"swissprotdb" => 0,
	"mdl_param" => 0,
	"Z0" => 0,
	"Z1" => 0,
	"Z2" => 0,
	"Z3" => 0,
	"search" => 0,
	"G" => 0,
	"GF" => 0,
	"E" => 0,
	"R" => 0,
	"RG" => 0,
	"output" => 0,
	"OF" => 0,
	"outfiles" => 0,
	"OP" => 0,
	"ON" => 0,
	"OA" => 0,
	"M" => 0,
	"MR" => 0,
	"MV" => 0,
	"report" => 0,

    };

    $self->{VLIST}  = {

	"seqformat" => ['swissprot','swissprot','fasta','fasta','gcg','gcg',],
	"conservation" => ['CM','Cpct',],
	"restrictions" => ['PP','PF','PL','PN','PX','FN','FL','FP','BI','BF','BN',],
	"PP" => ['off','off','complete','complete pattern match has to be in this area','start','start: pattern match has to start in this area',],
	"scoring" => ['S','treefile','distfile','swissprotdb','mdl_param',],
	"S" => ['info','info (information content)','mdl','mdl (Minimum Description Length)','tree','tree (diversity calculated from a dendrogram)','dist','dist (distances matrix)','ppv','ppv (Positive Predictive Value)',],
	"mdl_param" => ['Z0','Z1','Z2','Z3',],
	"search" => ['G','GF','E','R','RG',],
	"G" => ['seq','seq','al','al (alignment)','query','query',],
	"output" => ['OF','outfiles','OP','ON','OA','M','MR','MV',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"seqformat" => 'fasta',
	"Cpct" => '100',
	"PP" => 'off',
	"PL" => '50',
	"PN" => '50',
	"PX" => '5',
	"FN" => '2',
	"FL" => '2',
	"FP" => '10',
	"BI" => '0',
	"BN" => '20',
	"S" => 'info',
	"Z0" => '10.00',
	"Z1" => '10.00',
	"Z2" => '3.00',
	"Z3" => '10.00',
	"G" => 'seq',
	"E" => '3',
	"R" => '1',
	"RG" => '0',
	"OP" => '1',
	"ON" => '50',
	"OA" => '50',
	"M" => '1',
	"MR" => '10',
	"MV" => '0',

    };

    $self->{PRECOND}  = {
	"pratt" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"seqformat" => { "perl" => '1' },
	"conservation" => { "perl" => '1' },
	"CM" => { "perl" => '1' },
	"Cpct" => { "perl" => '1' },
	"restrictions" => { "perl" => '1' },
	"PP" => { "perl" => '1' },
	"PF" => {
		"perl" => '$PP && $PP ne "off"',
	},
	"PL" => { "perl" => '1' },
	"PN" => { "perl" => '1' },
	"PX" => { "perl" => '1' },
	"FN" => { "perl" => '1' },
	"FL" => { "perl" => '1' },
	"FP" => { "perl" => '1' },
	"BI" => { "perl" => '1' },
	"BF" => {
		"perl" => '$BI',
	},
	"BN" => { "perl" => '1' },
	"scoring" => { "perl" => '1' },
	"S" => { "perl" => '1' },
	"treefile" => {
		"perl" => '$S eq "tree"',
	},
	"distfile" => {
		"perl" => '$S eq "dist"',
	},
	"swissprotdb" => {
		"perl" => '$S eq "ppv"',
	},
	"mdl_param" => {
		"perl" => '$S eq "mdl"',
	},
	"Z0" => {
		"perl" => '$S eq "mdl"',
	},
	"Z1" => {
		"perl" => '$S eq "mdl"',
	},
	"Z2" => {
		"perl" => '$S eq "mdl"',
	},
	"Z3" => {
		"perl" => '$S eq "mdl"',
	},
	"search" => { "perl" => '1' },
	"G" => { "perl" => '1' },
	"GF" => {
		"perl" => '$G eq "al" or $G eq "query"',
	},
	"E" => { "perl" => '1' },
	"R" => { "perl" => '1' },
	"RG" => {
		"perl" => '$R',
	},
	"output" => { "perl" => '1' },
	"OF" => { "perl" => '1' },
	"outfiles" => { "perl" => '1' },
	"OP" => { "perl" => '1' },
	"ON" => { "perl" => '1' },
	"OA" => { "perl" => '1' },
	"M" => { "perl" => '1' },
	"MR" => { "perl" => '1' },
	"MV" => { "perl" => '1' },
	"report" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"CM" => {
		"perl" => {
			'$value && ($value < 2 || $value > 4)' => "value must be between 2 and 4",
			'$value =~ /\\./ ' => "value must be an integer between 2 and 4",
		},
	},
	"PP" => {
		"perl" => {
			'$PP && $PP ne "off" && ! $PF' => "you must give a file to define the regions (PF)",
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
	"pratt" => 0,
	"seq" => 0,
	"seqformat" => 0,
	"conservation" => 0,
	"CM" => 0,
	"Cpct" => 0,
	"restrictions" => 0,
	"PP" => 0,
	"PF" => 0,
	"PL" => 0,
	"PN" => 0,
	"PX" => 0,
	"FN" => 0,
	"FL" => 0,
	"FP" => 0,
	"BI" => 0,
	"BF" => 0,
	"BN" => 0,
	"scoring" => 0,
	"S" => 0,
	"treefile" => 0,
	"distfile" => 0,
	"swissprotdb" => 0,
	"mdl_param" => 0,
	"Z0" => 0,
	"Z1" => 0,
	"Z2" => 0,
	"Z3" => 0,
	"search" => 0,
	"G" => 0,
	"GF" => 0,
	"E" => 0,
	"R" => 0,
	"RG" => 0,
	"output" => 0,
	"OF" => 0,
	"outfiles" => 0,
	"OP" => 0,
	"ON" => 0,
	"OA" => 0,
	"M" => 0,
	"MR" => 0,
	"MV" => 0,
	"report" => 1,

    };

    $self->{ISSIMPLE}  = {
	"pratt" => 0,
	"seq" => 1,
	"seqformat" => 1,
	"conservation" => 0,
	"CM" => 0,
	"Cpct" => 0,
	"restrictions" => 0,
	"PP" => 0,
	"PF" => 0,
	"PL" => 0,
	"PN" => 0,
	"PX" => 0,
	"FN" => 0,
	"FL" => 0,
	"FP" => 0,
	"BI" => 0,
	"BF" => 0,
	"BN" => 0,
	"scoring" => 0,
	"S" => 0,
	"treefile" => 0,
	"distfile" => 0,
	"swissprotdb" => 0,
	"mdl_param" => 0,
	"Z0" => 0,
	"Z1" => 0,
	"Z2" => 0,
	"Z3" => 0,
	"search" => 0,
	"G" => 0,
	"GF" => 0,
	"E" => 0,
	"R" => 0,
	"RG" => 0,
	"output" => 0,
	"OF" => 0,
	"outfiles" => 0,
	"OP" => 0,
	"ON" => 0,
	"OA" => 0,
	"M" => 0,
	"MR" => 0,
	"MV" => 0,
	"report" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"PF" => [
		"This file contains lines to restrict pattern searches to certain regions in a sequence, say ACE2_YEAST: ",
		">ACE2_YEAST (100,200)",
	],
	"BF" => [
		"default file is: /local/gensoft/lib/pratt/Pratt.sets.big",
	],
	"GF" => [
		"alignment file must be in CLUSTALW format",
		"query file must be in Fasta format",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pratt.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

