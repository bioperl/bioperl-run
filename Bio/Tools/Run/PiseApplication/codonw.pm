
=head1 NAME

Bio::Tools::Run::PiseApplication::codonw

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::codonw

      Bioperl class for:

	codonw	Correspondence Analysis of Codon Usage (J. Peden)

      Parameters:


		codonw (String)
			

		outfiles (String)
			

		results_files (Results)
			

		seqfile (Sequence)
			Sequences File

		defaults (Paragraph)
			Defaults settings

		gc (Excl)
			Genetic codes

		fop_values (Excl)
			Fop/CBI values

		cai_values (Excl)
			CAI values

		output_type (Switch)
			Output Computer readable

		genes (Switch)
			Concatenate genes (instead of individual genes)

		CU_options (Paragraph)
			Codon usage indices

		CAI (Switch)
			Codon Adaptation Index (CAI)

		Fop (Switch)
			Frequency of OPtimal codons (Fop)

		CBI (Switch)
			Codon bias index (CBI)

		cai_file (InFile)
			User input file of CAI values (may be computed by a previous COA)
			pipe: codonw_coa_file

		fop_file (InFile)
			User input file of Fop values (may be computed by a previous COA)

		cbi_file (InFile)
			User input file of CBI values (may be computed by a previous COA)

		ENc (Switch)
			Effective Number of Codons (ENc)

		GC (Switch)
			GC content of gene (G+C)

		GC3s (Switch)
			GC of silent 3rd codon posit. (GC3s)

		silent_bc (Switch)
			Silent base composition

		all_indices (Switch)
			All the above indices

		L_sym (Integer)
			Number of synonymous codons (N_sym)

		N_aa (Switch)
			Total Number of synonymous and non-synonymous codons (N_aa)

		Hydro (Switch)
			Hydrophobicity of protein (Hydro)

		Aromo (Switch)
			Aromaticity of protein (Aromo)

		bulk_output_option (Excl)
			Other output option

		COA_options (Paragraph)
			Correspondence analysis options (available for several sequences)

		coa_cu (Switch)
			COA on codon usage

		coa_rscu (Switch)
			COA on RSCU

		coa_aa (Switch)
			COA on Amino Acid usage

		coa_expert (Switch)
			Generate detailed(expert) statistics on COA

		coa_axes (Integer)
			Select number of axis to record

		coa_num (Integer)
			Select number of genes to use to identify optimal codons

		cai_coa (OutFile)
			
			pipe: codonw_coa_file

		coa_files (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::codonw;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $codonw = Bio::Tools::Run::PiseApplication::codonw->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::codonw object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $codonw = $factory->program('codonw');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::codonw.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codonw.pm

    $self->{COMMAND}   = "codonw";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "codonw";

    $self->{DESCRIPTION}   = "Correspondence Analysis of Codon Usage";

    $self->{AUTHORS}   = "J. Peden";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"codonw",
	"outfiles",
	"results_files",
	"seqfile",
	"defaults",
	"CU_options",
	"COA_options",
	"cai_coa",
	"coa_files",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"codonw",
	"outfiles",
	"results_files",
	"seqfile", 	# Sequences File
	"defaults", 	# Defaults settings
	"gc", 	# Genetic codes
	"fop_values", 	# Fop/CBI values
	"cai_values", 	# CAI values
	"output_type", 	# Output Computer readable
	"genes", 	# Concatenate genes (instead of individual genes)
	"CU_options", 	# Codon usage indices
	"CAI", 	# Codon Adaptation Index (CAI)
	"Fop", 	# Frequency of OPtimal codons (Fop)
	"CBI", 	# Codon bias index (CBI)
	"cai_file", 	# User input file of CAI values (may be computed by a previous COA)
	"fop_file", 	# User input file of Fop values (may be computed by a previous COA)
	"cbi_file", 	# User input file of CBI values (may be computed by a previous COA)
	"ENc", 	# Effective Number of Codons (ENc)
	"GC", 	# GC content of gene (G+C)
	"GC3s", 	# GC of silent 3rd codon posit. (GC3s)
	"silent_bc", 	# Silent base composition
	"all_indices", 	# All the above indices
	"L_sym", 	# Number of synonymous codons (N_sym)
	"N_aa", 	# Total Number of synonymous and non-synonymous codons (N_aa)
	"Hydro", 	# Hydrophobicity of protein (Hydro)
	"Aromo", 	# Aromaticity of protein (Aromo)
	"bulk_output_option", 	# Other output option
	"COA_options", 	# Correspondence analysis options (available for several sequences)
	"coa_cu", 	# COA on codon usage
	"coa_rscu", 	# COA on RSCU
	"coa_aa", 	# COA on Amino Acid usage
	"coa_expert", 	# Generate detailed(expert) statistics on COA
	"coa_axes", 	# Select number of axis to record
	"coa_num", 	# Select number of genes to use to identify optimal codons
	"cai_coa",
	"coa_files",

    ];

    $self->{TYPE}  = {
	"codonw" => 'String',
	"outfiles" => 'String',
	"results_files" => 'Results',
	"seqfile" => 'Sequence',
	"defaults" => 'Paragraph',
	"gc" => 'Excl',
	"fop_values" => 'Excl',
	"cai_values" => 'Excl',
	"output_type" => 'Switch',
	"genes" => 'Switch',
	"CU_options" => 'Paragraph',
	"CAI" => 'Switch',
	"Fop" => 'Switch',
	"CBI" => 'Switch',
	"cai_file" => 'InFile',
	"fop_file" => 'InFile',
	"cbi_file" => 'InFile',
	"ENc" => 'Switch',
	"GC" => 'Switch',
	"GC3s" => 'Switch',
	"silent_bc" => 'Switch',
	"all_indices" => 'Switch',
	"L_sym" => 'Integer',
	"N_aa" => 'Switch',
	"Hydro" => 'Switch',
	"Aromo" => 'Switch',
	"bulk_output_option" => 'Excl',
	"COA_options" => 'Paragraph',
	"coa_cu" => 'Switch',
	"coa_rscu" => 'Switch',
	"coa_aa" => 'Switch',
	"coa_expert" => 'Switch',
	"coa_axes" => 'Integer',
	"coa_num" => 'Integer',
	"cai_coa" => 'OutFile',
	"coa_files" => 'Results',

    };

    $self->{FORMAT}  = {
	"codonw" => {
		"perl" => '"codonw -silent -nomenu -nowarn"',
	},
	"outfiles" => {
		"perl" => '" $seqfile.indices $seqfile.bulk"',
	},
	"results_files" => {
	},
	"seqfile" => {
		"perl" => '  " $value"',
	},
	"defaults" => {
	},
	"gc" => {
		"perl" => '($value && $value ne $vdef)? " -code $value" : "" ',
	},
	"fop_values" => {
		"perl" => '($value)? " -f_type $value" : "" ',
	},
	"cai_values" => {
		"perl" => '($value)? " -c_type $value" : "" ',
	},
	"output_type" => {
		"perl" => '($value)? " -machine" : "" ',
	},
	"genes" => {
		"perl" => '($value)? " -totals" : "" ',
	},
	"CU_options" => {
	},
	"CAI" => {
		"perl" => '($value)? " -cai" : "" ',
	},
	"Fop" => {
		"perl" => '($value)? " -fop" : "" ',
	},
	"CBI" => {
		"perl" => '($value)? " -cbi" : "" ',
	},
	"cai_file" => {
		"perl" => '($value)? " -cai_file $value" : "" ',
	},
	"fop_file" => {
		"perl" => '($value)? " -fop_file $value" : "" ',
	},
	"cbi_file" => {
		"perl" => '($value)? " -cbi_file $value" : "" ',
	},
	"ENc" => {
		"perl" => '($value)? " -enc" : "" ',
	},
	"GC" => {
		"perl" => '($value)? " -gc" : "" ',
	},
	"GC3s" => {
		"perl" => '($value)? " -gc3s" : "" ',
	},
	"silent_bc" => {
		"perl" => '($value)? " -sil_base" : "" ',
	},
	"all_indices" => {
		"perl" => '($value)? " -all_indices" : "" ',
	},
	"L_sym" => {
		"perl" => '(defined $value)? " -N_sym" : "" ',
	},
	"N_aa" => {
		"perl" => '($value)? " -N_aa" : "" ',
	},
	"Hydro" => {
		"perl" => '($value)? " -hyd" : "" ',
	},
	"Aromo" => {
		"perl" => '($value)? " -aro" : "" ',
	},
	"bulk_output_option" => {
		"perl" => '($value && $value ne $vdef)? " $value" : "" ',
	},
	"COA_options" => {
	},
	"coa_cu" => {
		"perl" => '($value)? " -coa_cu" : "" ',
	},
	"coa_rscu" => {
		"perl" => '($value)? " -coa_rscu" : "" ',
	},
	"coa_aa" => {
		"perl" => '($value)? " -coa_aa" : "" ',
	},
	"coa_expert" => {
		"perl" => '($value)? " -coa_expert" : "" ',
	},
	"coa_axes" => {
		"perl" => '(defined $value)? " -coa_axes $value" : "" ',
	},
	"coa_num" => {
		"perl" => '(defined $value)? " -coa_num $value" : "" ',
	},
	"cai_coa" => {
		"perl" => '""',
	},
	"coa_files" => {
	},

    };

    $self->{FILENAMES}  = {
	"results_files" => '*.indices *.bulk',
	"coa_files" => '*.coa coa_raw',

    };

    $self->{SEQFMT}  = {
	"seqfile" => [8],

    };

    $self->{GROUP}  = {
	"codonw" => 0,
	"outfiles" => 2000,
	"seqfile" => 1000,
	"gc" => 2,
	"fop_values" => 2,
	"cai_values" => 2,
	"output_type" => 2,
	"genes" => 3,
	"CAI" => 4,
	"Fop" => 4,
	"CBI" => 4,
	"cai_file" => 2,
	"fop_file" => 2,
	"cbi_file" => 2,
	"ENc" => 4,
	"GC" => 4,
	"GC3s" => 4,
	"silent_bc" => 4,
	"all_indices" => 4,
	"L_sym" => 4,
	"N_aa" => 4,
	"Hydro" => 4,
	"Aromo" => 4,
	"bulk_output_option" => 4,
	"coa_cu" => 3,
	"coa_rscu" => 3,
	"coa_aa" => 3,
	"coa_expert" => 3,
	"coa_axes" => 3,
	"coa_num" => 3,
	"cai_coa" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"codonw",
	"coa_files",
	"results_files",
	"COA_options",
	"defaults",
	"CU_options",
	"cai_coa",
	"fop_values",
	"cai_values",
	"output_type",
	"cai_file",
	"fop_file",
	"cbi_file",
	"gc",
	"coa_rscu",
	"coa_aa",
	"coa_expert",
	"coa_axes",
	"coa_num",
	"coa_cu",
	"genes",
	"all_indices",
	"L_sym",
	"N_aa",
	"Hydro",
	"Aromo",
	"bulk_output_option",
	"CAI",
	"Fop",
	"CBI",
	"ENc",
	"GC",
	"GC3s",
	"silent_bc",
	"seqfile",
	"outfiles",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"codonw" => 1,
	"outfiles" => 1,
	"results_files" => 0,
	"seqfile" => 0,
	"defaults" => 0,
	"gc" => 0,
	"fop_values" => 0,
	"cai_values" => 0,
	"output_type" => 0,
	"genes" => 0,
	"CU_options" => 0,
	"CAI" => 0,
	"Fop" => 0,
	"CBI" => 0,
	"cai_file" => 0,
	"fop_file" => 0,
	"cbi_file" => 0,
	"ENc" => 0,
	"GC" => 0,
	"GC3s" => 0,
	"silent_bc" => 0,
	"all_indices" => 0,
	"L_sym" => 0,
	"N_aa" => 0,
	"Hydro" => 0,
	"Aromo" => 0,
	"bulk_output_option" => 0,
	"COA_options" => 0,
	"coa_cu" => 0,
	"coa_rscu" => 0,
	"coa_aa" => 0,
	"coa_expert" => 0,
	"coa_axes" => 0,
	"coa_num" => 0,
	"cai_coa" => 1,
	"coa_files" => 0,

    };

    $self->{ISCOMMAND}  = {
	"codonw" => 1,
	"outfiles" => 0,
	"results_files" => 0,
	"seqfile" => 0,
	"defaults" => 0,
	"gc" => 0,
	"fop_values" => 0,
	"cai_values" => 0,
	"output_type" => 0,
	"genes" => 0,
	"CU_options" => 0,
	"CAI" => 0,
	"Fop" => 0,
	"CBI" => 0,
	"cai_file" => 0,
	"fop_file" => 0,
	"cbi_file" => 0,
	"ENc" => 0,
	"GC" => 0,
	"GC3s" => 0,
	"silent_bc" => 0,
	"all_indices" => 0,
	"L_sym" => 0,
	"N_aa" => 0,
	"Hydro" => 0,
	"Aromo" => 0,
	"bulk_output_option" => 0,
	"COA_options" => 0,
	"coa_cu" => 0,
	"coa_rscu" => 0,
	"coa_aa" => 0,
	"coa_expert" => 0,
	"coa_axes" => 0,
	"coa_num" => 0,
	"cai_coa" => 0,
	"coa_files" => 0,

    };

    $self->{ISMANDATORY}  = {
	"codonw" => 0,
	"outfiles" => 0,
	"results_files" => 0,
	"seqfile" => 1,
	"defaults" => 0,
	"gc" => 0,
	"fop_values" => 0,
	"cai_values" => 0,
	"output_type" => 0,
	"genes" => 0,
	"CU_options" => 0,
	"CAI" => 0,
	"Fop" => 0,
	"CBI" => 0,
	"cai_file" => 0,
	"fop_file" => 0,
	"cbi_file" => 0,
	"ENc" => 0,
	"GC" => 0,
	"GC3s" => 0,
	"silent_bc" => 0,
	"all_indices" => 0,
	"L_sym" => 0,
	"N_aa" => 0,
	"Hydro" => 0,
	"Aromo" => 0,
	"bulk_output_option" => 0,
	"COA_options" => 0,
	"coa_cu" => 0,
	"coa_rscu" => 0,
	"coa_aa" => 0,
	"coa_expert" => 0,
	"coa_axes" => 0,
	"coa_num" => 0,
	"cai_coa" => 0,
	"coa_files" => 0,

    };

    $self->{PROMPT}  = {
	"codonw" => "",
	"outfiles" => "",
	"results_files" => "",
	"seqfile" => "Sequences File",
	"defaults" => "Defaults settings",
	"gc" => "Genetic codes",
	"fop_values" => "Fop/CBI values",
	"cai_values" => "CAI values",
	"output_type" => "Output Computer readable",
	"genes" => "Concatenate genes (instead of individual genes)",
	"CU_options" => "Codon usage indices",
	"CAI" => "Codon Adaptation Index (CAI)",
	"Fop" => "Frequency of OPtimal codons (Fop)",
	"CBI" => "Codon bias index (CBI)",
	"cai_file" => "User input file of CAI values (may be computed by a previous COA)",
	"fop_file" => "User input file of Fop values (may be computed by a previous COA)",
	"cbi_file" => "User input file of CBI values (may be computed by a previous COA)",
	"ENc" => "Effective Number of Codons (ENc)",
	"GC" => "GC content of gene (G+C)",
	"GC3s" => "GC of silent 3rd codon posit. (GC3s)",
	"silent_bc" => "Silent base composition",
	"all_indices" => "All the above indices",
	"L_sym" => "Number of synonymous codons (N_sym)",
	"N_aa" => "Total Number of synonymous and non-synonymous codons (N_aa)",
	"Hydro" => "Hydrophobicity of protein (Hydro)",
	"Aromo" => "Aromaticity of protein (Aromo)",
	"bulk_output_option" => "Other output option",
	"COA_options" => "Correspondence analysis options (available for several sequences)",
	"coa_cu" => "COA on codon usage",
	"coa_rscu" => "COA on RSCU",
	"coa_aa" => "COA on Amino Acid usage",
	"coa_expert" => "Generate detailed(expert) statistics on COA",
	"coa_axes" => "Select number of axis to record",
	"coa_num" => "Select number of genes to use to identify optimal codons",
	"cai_coa" => "",
	"coa_files" => "",

    };

    $self->{ISSTANDOUT}  = {
	"codonw" => 0,
	"outfiles" => 0,
	"results_files" => 0,
	"seqfile" => 0,
	"defaults" => 0,
	"gc" => 0,
	"fop_values" => 0,
	"cai_values" => 0,
	"output_type" => 0,
	"genes" => 0,
	"CU_options" => 0,
	"CAI" => 0,
	"Fop" => 0,
	"CBI" => 0,
	"cai_file" => 0,
	"fop_file" => 0,
	"cbi_file" => 0,
	"ENc" => 0,
	"GC" => 0,
	"GC3s" => 0,
	"silent_bc" => 0,
	"all_indices" => 0,
	"L_sym" => 0,
	"N_aa" => 0,
	"Hydro" => 0,
	"Aromo" => 0,
	"bulk_output_option" => 0,
	"COA_options" => 0,
	"coa_cu" => 0,
	"coa_rscu" => 0,
	"coa_aa" => 0,
	"coa_expert" => 0,
	"coa_axes" => 0,
	"coa_num" => 0,
	"cai_coa" => 0,
	"coa_files" => 0,

    };

    $self->{VLIST}  = {

	"defaults" => ['gc','fop_values','cai_values','output_type','genes',],
	"gc" => ['0','(0) Universal Genetic code [TGA=* TAA=* TAG=*]','1','(1) Vertebrate Mitochondrial code [AGR=* ATA=M TGA=W]','2','(2) Yeast Mitochondrial code [CTN=* ATA=M TGA=W]','3','(3) Filamentous fungi Mitochondrial code [TGA=W]','4','(4) Insects and Plathyhelminthes Mitochondrial co [ATA=M TGA=W AGR=S]','5','(5) Nuclear code of Cilitia [UAA=Q=Gln UAG=Q]','6','(6) Nuclear code of Euplotes [UGA=C]','7','(7) Mitochondrial code of Echinoderms UGA=W AGR=S AAA=N',],
	"fop_values" => ['0','(0) Escherichia coli','1','(1) Bacillus subtilis','2','(2) Dictyostelium discoideum','3','(3) Aspergillus nidulans','4','(4) Saccharomyces cerevisiae','5','(5) Drosophila melanogaster','6','(6) Caenorhabditis elegans','7','(7) Neurospora crassa',],
	"cai_values" => ['0','(0) Escherichia coli','1','(1) Bacillus subtilis','2','(2) Saccharomyces cerevisiae',],
	"CU_options" => ['CAI','Fop','CBI','cai_file','fop_file','cbi_file','ENc','GC','GC3s','silent_bc','all_indices','L_sym','N_aa','Hydro','Aromo','bulk_output_option',],
	"bulk_output_option" => ['-cu','Codon Usage (CU)','-aau','Amino Acid Usage (AAU)','-raau','Relative Amino Acid Usage (RAAU)','-cutab','Tabulation of codon usage','-cutot','Tabulation of dataset\'s codon usage','-rscu','Relative Synonymous Codon Usage (RSCU)','-fasta','fasta format','-reader','Reader format (codons are seperated by spaces)','-transl','Conceptual translation of DNA to amino acid','-base','Detailed report of codon G+C composition','-dinuc','Dinucleotide usage of the three codon pos.','-noblk','No bulk output to be written to file',],
	"COA_options" => ['coa_cu','coa_rscu','coa_aa','coa_expert','coa_axes','coa_num',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gc" => '0',
	"fop_values" => '0',
	"cai_values" => '0',
	"output_type" => '0',
	"bulk_output_option" => '-cu',
	"cai_coa" => '"cai.coa"',

    };

    $self->{PRECOND}  = {
	"codonw" => { "perl" => '1' },
	"outfiles" => { "perl" => '1' },
	"results_files" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"defaults" => { "perl" => '1' },
	"gc" => { "perl" => '1' },
	"fop_values" => { "perl" => '1' },
	"cai_values" => { "perl" => '1' },
	"output_type" => { "perl" => '1' },
	"genes" => { "perl" => '1' },
	"CU_options" => { "perl" => '1' },
	"CAI" => {
		"perl" => '! $all_indices',
	},
	"Fop" => {
		"perl" => '! $all_indices',
	},
	"CBI" => {
		"perl" => '! $all_indices',
	},
	"cai_file" => {
		"perl" => '$CAI',
	},
	"fop_file" => {
		"perl" => '$Fop',
	},
	"cbi_file" => {
		"perl" => '$CBI',
	},
	"ENc" => {
		"perl" => '! $all_indices',
	},
	"GC" => {
		"perl" => '! $all_indices',
	},
	"GC3s" => {
		"perl" => '! $all_indices',
	},
	"silent_bc" => {
		"perl" => '! $all_indices',
	},
	"all_indices" => { "perl" => '1' },
	"L_sym" => { "perl" => '1' },
	"N_aa" => { "perl" => '1' },
	"Hydro" => { "perl" => '1' },
	"Aromo" => { "perl" => '1' },
	"bulk_output_option" => { "perl" => '1' },
	"COA_options" => { "perl" => '1' },
	"coa_cu" => { "perl" => '1' },
	"coa_rscu" => { "perl" => '1' },
	"coa_aa" => { "perl" => '1' },
	"coa_expert" => { "perl" => '1' },
	"coa_axes" => { "perl" => '1' },
	"coa_num" => { "perl" => '1' },
	"cai_coa" => { "perl" => '1' },
	"coa_files" => {
		"perl" => '$coa_cu || $coa_rscu || $coa_aa',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"cai_coa" => {
		 '1' => "codonw_coa_file",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"cai_file" => {
		 "codonw_coa_file" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"codonw" => 0,
	"outfiles" => 0,
	"results_files" => 0,
	"seqfile" => 0,
	"defaults" => 0,
	"gc" => 0,
	"fop_values" => 0,
	"cai_values" => 0,
	"output_type" => 0,
	"genes" => 0,
	"CU_options" => 0,
	"CAI" => 0,
	"Fop" => 0,
	"CBI" => 0,
	"cai_file" => 0,
	"fop_file" => 0,
	"cbi_file" => 0,
	"ENc" => 0,
	"GC" => 0,
	"GC3s" => 0,
	"silent_bc" => 0,
	"all_indices" => 0,
	"L_sym" => 0,
	"N_aa" => 0,
	"Hydro" => 0,
	"Aromo" => 0,
	"bulk_output_option" => 0,
	"COA_options" => 0,
	"coa_cu" => 0,
	"coa_rscu" => 0,
	"coa_aa" => 0,
	"coa_expert" => 0,
	"coa_axes" => 0,
	"coa_num" => 0,
	"cai_coa" => 0,
	"coa_files" => 0,

    };

    $self->{ISSIMPLE}  = {
	"codonw" => 0,
	"outfiles" => 0,
	"results_files" => 0,
	"seqfile" => 1,
	"defaults" => 0,
	"gc" => 0,
	"fop_values" => 0,
	"cai_values" => 0,
	"output_type" => 0,
	"genes" => 0,
	"CU_options" => 0,
	"CAI" => 0,
	"Fop" => 0,
	"CBI" => 0,
	"cai_file" => 0,
	"fop_file" => 0,
	"cbi_file" => 0,
	"ENc" => 0,
	"GC" => 0,
	"GC3s" => 0,
	"silent_bc" => 0,
	"all_indices" => 0,
	"L_sym" => 0,
	"N_aa" => 0,
	"Hydro" => 0,
	"Aromo" => 0,
	"bulk_output_option" => 0,
	"COA_options" => 0,
	"coa_cu" => 0,
	"coa_rscu" => 0,
	"coa_aa" => 0,
	"coa_expert" => 0,
	"coa_axes" => 0,
	"coa_num" => 0,
	"cai_coa" => 0,
	"coa_files" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"coa_num" => [
		"Values can be whole numbers or a percentage (5 or 10%).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codonw.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

