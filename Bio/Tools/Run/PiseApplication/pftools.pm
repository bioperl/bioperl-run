
=head1 NAME

Bio::Tools::Run::PiseApplication::pftools

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pftools

      Bioperl class for:

	PFTOOLS	Profile Tools (P. Bucher)

	References:

		Bucher P, Karplus K, Moeri N and Hofmann, K. (1996).  A flexible motif search technique based on generalized profiles. Comput. Chem. 20:3-24.


      Parameters:


		pftools (Excl)
			PFTOOLS program

		clean_output (String)
			

		fastaformat (Switch)
			

		pfscan (Paragraph)
			PFSCAN parameters

		seqfile (Sequence)
			Sequence File

		prosite (Switch)
			Scan PROSITE db (default)?

		profiledb (InFile)
			Profile db (PROSITE/NUCSITE format) (if not PROSITE)

		pfscan_cutoff (Integer)
			Cut-off value

		pfsearch (Paragraph)
			PFSEARCH parameters

		profile (InFile)
			Profile File  (PROSITE/NUCSITE format, or see next option) 
			pipe: gcg_profile

		gcg2psa (Switch)
			Convert the profile from GCG format to PROSITE format ?

		aa_or_nuc_db (Excl)
			protein or nucleotid db

		aadb (Excl)
			Protein Database

		nucdb (Excl)
			Nucleotid Database

		pfsearch_cutoff (Integer)
			Cut-off value

		psa2msa (Switch)
			reformat PSA result file to Fasta multiple sequence alignment file?

		stdinput (Switch)
			

		control (Paragraph)
			Control options

		compl (Switch)
			 Search the complementary strands of DNA sequences as well (-b) 

		raw_score (Switch)
			Use raw scores rather than normalized scores for match selection. Normalized scores will not be listed in the output. (-r) 

		unique (Switch)
			Forces DISJOINT=UNIQUE (-u) 

		output (Paragraph)
			Output options

		optimal (Switch)
			Report optimal alignment scores for all sequences regardless of the cut-off value (-a)? 

		listseq (Switch)
			List the sequences of the matched regions as well. The output will be a Pearson/Fasta-formatted sequence library. (-s) 

		psa_format (Switch)
			List profile-sequence alignments in pftools PSA format. (-x) 

		between (Switch)
			 Display alignments between the profile and the matched sequence regions in a human-friendly format. (-y) 

=cut

#'
package Bio::Tools::Run::PiseApplication::pftools;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pftools = Bio::Tools::Run::PiseApplication::pftools->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pftools object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pftools = $factory->program('pftools');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pftools.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pftools.pm

    $self->{COMMAND}   = "pftools";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PFTOOLS";

    $self->{DESCRIPTION}   = "Profile Tools";

    $self->{AUTHORS}   = "P. Bucher";

    $self->{REFERENCE}   = [

         "Bucher P, Karplus K, Moeri N and Hofmann, K. (1996).  A flexible motif search technique based on generalized profiles. Comput. Chem. 20:3-24.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pftools",
	"clean_output",
	"fastaformat",
	"pfscan",
	"pfsearch",
	"stdinput",
	"control",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pftools", 	# PFTOOLS program
	"clean_output",
	"fastaformat",
	"pfscan", 	# PFSCAN parameters
	"seqfile", 	# Sequence File
	"prosite", 	# Scan PROSITE db (default)?
	"profiledb", 	# Profile db (PROSITE/NUCSITE format) (if not PROSITE)
	"pfscan_cutoff", 	# Cut-off value
	"pfsearch", 	# PFSEARCH parameters
	"profile", 	# Profile File  (PROSITE/NUCSITE format, or see next option) 
	"gcg2psa", 	# Convert the profile from GCG format to PROSITE format ?
	"aa_or_nuc_db", 	# protein or nucleotid db
	"aadb", 	# Protein Database
	"nucdb", 	# Nucleotid Database
	"pfsearch_cutoff", 	# Cut-off value
	"psa2msa", 	# reformat PSA result file to Fasta multiple sequence alignment file?
	"stdinput",
	"control", 	# Control options
	"compl", 	#  Search the complementary strands of DNA sequences as well (-b) 
	"raw_score", 	# Use raw scores rather than normalized scores for match selection. Normalized scores will not be listed in the output. (-r) 
	"unique", 	# Forces DISJOINT=UNIQUE (-u) 
	"output", 	# Output options
	"optimal", 	# Report optimal alignment scores for all sequences regardless of the cut-off value (-a)? 
	"listseq", 	# List the sequences of the matched regions as well. The output will be a Pearson/Fasta-formatted sequence library. (-s) 
	"psa_format", 	# List profile-sequence alignments in pftools PSA format. (-x) 
	"between", 	#  Display alignments between the profile and the matched sequence regions in a human-friendly format. (-y) 

    ];

    $self->{TYPE}  = {
	"pftools" => 'Excl',
	"clean_output" => 'String',
	"fastaformat" => 'Switch',
	"pfscan" => 'Paragraph',
	"seqfile" => 'Sequence',
	"prosite" => 'Switch',
	"profiledb" => 'InFile',
	"pfscan_cutoff" => 'Integer',
	"pfsearch" => 'Paragraph',
	"profile" => 'InFile',
	"gcg2psa" => 'Switch',
	"aa_or_nuc_db" => 'Excl',
	"aadb" => 'Excl',
	"nucdb" => 'Excl',
	"pfsearch_cutoff" => 'Integer',
	"psa2msa" => 'Switch',
	"stdinput" => 'Switch',
	"control" => 'Paragraph',
	"compl" => 'Switch',
	"raw_score" => 'Switch',
	"unique" => 'Switch',
	"output" => 'Paragraph',
	"optimal" => 'Switch',
	"listseq" => 'Switch',
	"psa_format" => 'Switch',
	"between" => 'Switch',

    };

    $self->{FORMAT}  = {
	"pftools" => {
		"perl" => '"| $value "',
	},
	"clean_output" => {
		"perl" => '" | clean_pfscan_output  "',
	},
	"fastaformat" => {
		"perl" => '" -f"',
	},
	"pfscan" => {
	},
	"seqfile" => {
		"perl" => '"cat $value  "',
	},
	"prosite" => {
		"perl" => '($value)? " /local/gensoft/lib/pftools/db/prosite.dat" : ""',
	},
	"profiledb" => {
		"perl" => ' $value',
	},
	"pfscan_cutoff" => {
		"perl" => '(defined $value)? " L=$value":""',
	},
	"pfsearch" => {
	},
	"profile" => {
		"perl" => '($gcg2psa)? "gtop $value" : "cat $value" ',
	},
	"gcg2psa" => {
		"perl" => '""',
	},
	"aa_or_nuc_db" => {
		"perl" => '""',
	},
	"aadb" => {
		"perl" => ' " /local/gensoft/lib/fasta/db/$value" ',
	},
	"nucdb" => {
		"perl" => ' " /local/gensoft/lib/fasta/db/$value" ',
	},
	"pfsearch_cutoff" => {
		"perl" => '(defined $value)? " C=$value":""',
	},
	"psa2msa" => {
		"perl" => '($value)? " | psa2msa - " : "" ',
	},
	"stdinput" => {
		"perl" => '" - " ',
	},
	"control" => {
	},
	"compl" => {
		"perl" => '($value)? " -b":""',
	},
	"raw_score" => {
		"perl" => '($value)? " -r":""',
	},
	"unique" => {
		"perl" => '($value)? " -u":""',
	},
	"output" => {
	},
	"optimal" => {
		"perl" => '($value)? " -a":""',
	},
	"listseq" => {
		"perl" => '($value)? " -s":""',
	},
	"psa_format" => {
		"perl" => '($value)? " -x":""',
	},
	"between" => {
		"perl" => '($value)? " -y":""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqfile" => [8],

    };

    $self->{GROUP}  = {
	"pftools" => 2,
	"clean_output" => 10000,
	"fastaformat" => 3,
	"seqfile" => 1,
	"prosite" => 6,
	"profiledb" => 6,
	"pfscan_cutoff" => 7,
	"profile" => 1,
	"aadb" => 6,
	"nucdb" => 6,
	"pfsearch_cutoff" => 7,
	"psa2msa" => 8,
	"stdinput" => 5,
	"compl" => 4,
	"raw_score" => 4,
	"unique" => 4,
	"optimal" => 4,
	"listseq" => 4,
	"psa_format" => 4,
	"between" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"aa_or_nuc_db",
	"control",
	"output",
	"pfscan",
	"pfsearch",
	"gcg2psa",
	"profile",
	"seqfile",
	"pftools",
	"fastaformat",
	"between",
	"compl",
	"unique",
	"raw_score",
	"optimal",
	"listseq",
	"psa_format",
	"stdinput",
	"prosite",
	"profiledb",
	"aadb",
	"nucdb",
	"pfsearch_cutoff",
	"pfscan_cutoff",
	"psa2msa",
	"clean_output",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pftools" => 0,
	"clean_output" => 1,
	"fastaformat" => 1,
	"pfscan" => 0,
	"seqfile" => 0,
	"prosite" => 0,
	"profiledb" => 0,
	"pfscan_cutoff" => 0,
	"pfsearch" => 0,
	"profile" => 0,
	"gcg2psa" => 0,
	"aa_or_nuc_db" => 0,
	"aadb" => 0,
	"nucdb" => 0,
	"pfsearch_cutoff" => 0,
	"psa2msa" => 0,
	"stdinput" => 1,
	"control" => 0,
	"compl" => 0,
	"raw_score" => 0,
	"unique" => 0,
	"output" => 0,
	"optimal" => 0,
	"listseq" => 0,
	"psa_format" => 0,
	"between" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pftools" => 1,
	"clean_output" => 0,
	"fastaformat" => 0,
	"pfscan" => 0,
	"seqfile" => 0,
	"prosite" => 0,
	"profiledb" => 0,
	"pfscan_cutoff" => 0,
	"pfsearch" => 0,
	"profile" => 0,
	"gcg2psa" => 0,
	"aa_or_nuc_db" => 0,
	"aadb" => 0,
	"nucdb" => 0,
	"pfsearch_cutoff" => 0,
	"psa2msa" => 0,
	"stdinput" => 0,
	"control" => 0,
	"compl" => 0,
	"raw_score" => 0,
	"unique" => 0,
	"output" => 0,
	"optimal" => 0,
	"listseq" => 0,
	"psa_format" => 0,
	"between" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pftools" => 1,
	"clean_output" => 0,
	"fastaformat" => 0,
	"pfscan" => 0,
	"seqfile" => 1,
	"prosite" => 0,
	"profiledb" => 1,
	"pfscan_cutoff" => 0,
	"pfsearch" => 0,
	"profile" => 1,
	"gcg2psa" => 0,
	"aa_or_nuc_db" => 1,
	"aadb" => 0,
	"nucdb" => 0,
	"pfsearch_cutoff" => 0,
	"psa2msa" => 0,
	"stdinput" => 0,
	"control" => 0,
	"compl" => 0,
	"raw_score" => 0,
	"unique" => 0,
	"output" => 0,
	"optimal" => 0,
	"listseq" => 0,
	"psa_format" => 0,
	"between" => 0,

    };

    $self->{PROMPT}  = {
	"pftools" => "PFTOOLS program",
	"clean_output" => "",
	"fastaformat" => "",
	"pfscan" => "PFSCAN parameters",
	"seqfile" => "Sequence File",
	"prosite" => "Scan PROSITE db (default)?",
	"profiledb" => "Profile db (PROSITE/NUCSITE format) (if not PROSITE)",
	"pfscan_cutoff" => "Cut-off value",
	"pfsearch" => "PFSEARCH parameters",
	"profile" => "Profile File  (PROSITE/NUCSITE format, or see next option) ",
	"gcg2psa" => "Convert the profile from GCG format to PROSITE format ?",
	"aa_or_nuc_db" => "protein or nucleotid db",
	"aadb" => "Protein Database",
	"nucdb" => "Nucleotid Database",
	"pfsearch_cutoff" => "Cut-off value",
	"psa2msa" => "reformat PSA result file to Fasta multiple sequence alignment file?",
	"stdinput" => "",
	"control" => "Control options",
	"compl" => " Search the complementary strands of DNA sequences as well (-b) ",
	"raw_score" => "Use raw scores rather than normalized scores for match selection. Normalized scores will not be listed in the output. (-r) ",
	"unique" => "Forces DISJOINT=UNIQUE (-u) ",
	"output" => "Output options",
	"optimal" => "Report optimal alignment scores for all sequences regardless of the cut-off value (-a)? ",
	"listseq" => "List the sequences of the matched regions as well. The output will be a Pearson/Fasta-formatted sequence library. (-s) ",
	"psa_format" => "List profile-sequence alignments in pftools PSA format. (-x) ",
	"between" => " Display alignments between the profile and the matched sequence regions in a human-friendly format. (-y) ",

    };

    $self->{ISSTANDOUT}  = {
	"pftools" => 0,
	"clean_output" => 0,
	"fastaformat" => 0,
	"pfscan" => 0,
	"seqfile" => 0,
	"prosite" => 0,
	"profiledb" => 0,
	"pfscan_cutoff" => 0,
	"pfsearch" => 0,
	"profile" => 0,
	"gcg2psa" => 0,
	"aa_or_nuc_db" => 0,
	"aadb" => 0,
	"nucdb" => 0,
	"pfsearch_cutoff" => 0,
	"psa2msa" => 0,
	"stdinput" => 0,
	"control" => 0,
	"compl" => 0,
	"raw_score" => 0,
	"unique" => 0,
	"output" => 0,
	"optimal" => 0,
	"listseq" => 0,
	"psa_format" => 0,
	"between" => 0,

    };

    $self->{VLIST}  = {

	"pftools" => ['pfscan','pfscan: scan a sequence with a profile db','pfsearch','pfsearch: search a sequence db for segments matching a profile',],
	"pfscan" => ['seqfile','prosite','profiledb','pfscan_cutoff',],
	"pfsearch" => ['profile','gcg2psa','aa_or_nuc_db','aadb','nucdb','pfsearch_cutoff','psa2msa',],
	"aa_or_nuc_db" => ['protein','protein','dna','DNA',],
	"aadb" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','prodom','prodom: protein domains','sbase','sbase: annotated domains sequences',],
	"nucdb" => ['embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"control" => ['compl','raw_score','unique',],
	"output" => ['optimal','listseq','psa_format','between',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"pftools" => 'pfscan',
	"prosite" => '1',
	"gcg2psa" => '1',
	"aa_or_nuc_db" => 'protein',
	"aadb" => 'swissprot',
	"nucdb" => 'genbank',
	"psa2msa" => '1',

    };

    $self->{PRECOND}  = {
	"pftools" => { "perl" => '1' },
	"clean_output" => {
		"perl" => '$pftools eq "pfscan"',
	},
	"fastaformat" => { "perl" => '1' },
	"pfscan" => {
		"perl" => ' ($pftools eq "pfscan") ',
	},
	"seqfile" => {
		"perl" => ' ($pftools eq "pfscan") ',
	},
	"prosite" => {
		"perl" => ' ($pftools eq "pfscan") ',
	},
	"profiledb" => {
		"perl" => ' ($pftools eq "pfscan")  && ( ! $prosite )',
	},
	"pfscan_cutoff" => {
		"perl" => ' ($pftools eq "pfscan") ',
	},
	"pfsearch" => {
		"perl" => ' ($pftools eq "pfsearch") ',
	},
	"profile" => {
		"perl" => ' ($pftools eq "pfsearch") ',
	},
	"gcg2psa" => {
		"perl" => ' ($pftools eq "pfsearch") ',
	},
	"aa_or_nuc_db" => {
		"perl" => ' ($pftools eq "pfsearch") ',
	},
	"aadb" => {
		"perl" => ' ($pftools eq "pfsearch")  &&  ($aa_or_nuc_db eq "protein") ',
	},
	"nucdb" => {
		"perl" => ' ($pftools eq "pfsearch")  &&  ($aa_or_nuc_db eq "dna") ',
	},
	"pfsearch_cutoff" => {
		"perl" => ' ($pftools eq "pfsearch") ',
	},
	"psa2msa" => {
		"perl" => ' ($pftools eq "pfsearch") ',
	},
	"stdinput" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"compl" => { "perl" => '1' },
	"raw_score" => { "perl" => '1' },
	"unique" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"optimal" => { "perl" => '1' },
	"listseq" => { "perl" => '1' },
	"psa_format" => { "perl" => '1' },
	"between" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"aadb" => {
		"perl" => {
			'! (defined $aadb || defined $nucdb)' => "You must either choose a protein or a nucleotid db",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"profile" => {
		 "gcg_profile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"pftools" => 0,
	"clean_output" => 0,
	"fastaformat" => 0,
	"pfscan" => 0,
	"seqfile" => 0,
	"prosite" => 0,
	"profiledb" => 0,
	"pfscan_cutoff" => 0,
	"pfsearch" => 0,
	"profile" => 0,
	"gcg2psa" => 0,
	"aa_or_nuc_db" => 0,
	"aadb" => 0,
	"nucdb" => 0,
	"pfsearch_cutoff" => 0,
	"psa2msa" => 0,
	"stdinput" => 0,
	"control" => 0,
	"compl" => 0,
	"raw_score" => 0,
	"unique" => 0,
	"output" => 0,
	"optimal" => 0,
	"listseq" => 0,
	"psa_format" => 0,
	"between" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pftools" => 0,
	"clean_output" => 0,
	"fastaformat" => 0,
	"pfscan" => 0,
	"seqfile" => 1,
	"prosite" => 0,
	"profiledb" => 0,
	"pfscan_cutoff" => 0,
	"pfsearch" => 0,
	"profile" => 0,
	"gcg2psa" => 0,
	"aa_or_nuc_db" => 0,
	"aadb" => 0,
	"nucdb" => 0,
	"pfsearch_cutoff" => 0,
	"psa2msa" => 0,
	"stdinput" => 0,
	"control" => 0,
	"compl" => 0,
	"raw_score" => 0,
	"unique" => 0,
	"output" => 0,
	"optimal" => 0,
	"listseq" => 0,
	"psa_format" => 0,
	"between" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"pftools" => [
		"pfscan compares a protein or nucleic acid sequence against a profile library (default: Prosite).",
		"pfsearch compares a query profile against a DNA or protein sequence library.",
		"The result is an unsorted list of profile-sequence matches written to the standard output.",
	],
	"seqfile" => [
		"pfscan will scan this sequence with a profile db (default db: PROSITE)",
	],
	"pfscan_cutoff" => [
		"Cut-off level to be used for match selection. If level L is not specified in the profile, the next higher (if L is negative) or next lower (if L is positive) level specified is used instead.",
	],
	"pfsearch_cutoff" => [
		"Over-writes the level zero cut-off value specified in the profile. An integer argument is interpreted as a raw score value, a decimal argument as a normalized score value.",
	],
	"optimal" => [
		"This option simultaneously forces DISJOINT=UNIQUE.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pftools.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

