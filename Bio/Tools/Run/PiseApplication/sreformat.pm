
=head1 NAME

Bio::Tools::Run::PiseApplication::sreformat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::sreformat

      Bioperl class for:

	HMMER	sreformat - convert sequence file to different format (S. Eddy)

      Parameters:


		sreformat (String)


		seqfile (InFile)
			Sequence(s) file
			pipe: hmmer_alig

		single_seq_file (Results)

			pipe: seqfile

		multi_seq_file (Results)

			pipe: seqsfile

		alig_file (Results)

			pipe: readseq_ok_alig

		selex_alig_file (Results)

			pipe: hmmer_alig

		output_format (Excl)
			output format

		dna (Switch)
			DNA (-d)

		lowercase (Switch)
			Convert all sequence residues to lower case (-l)

		rna (Switch)
			RNA (-r)

		uppercase (Switch)
			Convert all sequence residues to upper case (-u)

		iupac_convert (Switch)
			Convert DNA non-IUPAC characters (such as X's) to N's (-x)

		expert_options (Paragraph)
			Expert options

		pfam (Switch)
			(--pfam)

		sam (Switch)
			(--sam)

		samfrac (Float)
			(--samfrac x)

=cut

#'
package Bio::Tools::Run::PiseApplication::sreformat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $sreformat = Bio::Tools::Run::PiseApplication::sreformat->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::sreformat object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $sreformat = $factory->program('sreformat');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::sreformat.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sreformat.pm

    $self->{COMMAND}   = "sreformat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "sreformat - convert sequence file to different format";

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"sreformat",
	"seqfile",
	"single_seq_file",
	"multi_seq_file",
	"alig_file",
	"selex_alig_file",
	"output_format",
	"dna",
	"lowercase",
	"rna",
	"uppercase",
	"iupac_convert",
	"expert_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"sreformat",
	"seqfile", 	# Sequence(s) file
	"single_seq_file",
	"multi_seq_file",
	"alig_file",
	"selex_alig_file",
	"output_format", 	# output format
	"dna", 	# DNA (-d)
	"lowercase", 	# Convert all sequence residues to lower case (-l)
	"rna", 	# RNA (-r)
	"uppercase", 	# Convert all sequence residues to upper case (-u)
	"iupac_convert", 	# Convert DNA non-IUPAC characters (such as X's) to N's (-x)
	"expert_options", 	# Expert options
	"pfam", 	# (--pfam)
	"sam", 	# (--sam)
	"samfrac", 	# (--samfrac x)

    ];

    $self->{TYPE}  = {
	"sreformat" => 'String',
	"seqfile" => 'InFile',
	"single_seq_file" => 'Results',
	"multi_seq_file" => 'Results',
	"alig_file" => 'Results',
	"selex_alig_file" => 'Results',
	"output_format" => 'Excl',
	"dna" => 'Switch',
	"lowercase" => 'Switch',
	"rna" => 'Switch',
	"uppercase" => 'Switch',
	"iupac_convert" => 'Switch',
	"expert_options" => 'Paragraph',
	"pfam" => 'Switch',
	"sam" => 'Switch',
	"samfrac" => 'Float',

    };

    $self->{FORMAT}  = {
	"sreformat" => {
		"perl" => '"sreformat "',
	},
	"seqfile" => {
		"perl" => '" $value"',
	},
	"single_seq_file" => {
		"perl" => '" > seqfile"',
	},
	"multi_seq_file" => {
		"perl" => '" > seqsfile"',
	},
	"alig_file" => {
		"perl" => '" > aligfile"',
	},
	"selex_alig_file" => {
		"perl" => '" > selex_aligfile"',
	},
	"output_format" => {
		"perl" => '" $value "',
	},
	"dna" => {
		"perl" => '($value) ? " -d" : ""',
	},
	"lowercase" => {
		"perl" => '($value) ? " -l" : ""',
	},
	"rna" => {
		"perl" => '($value) ? " -r" : ""',
	},
	"uppercase" => {
		"perl" => '($value) ? " -u" : ""',
	},
	"iupac_convert" => {
		"perl" => '($value) ? " -x" : ""',
	},
	"expert_options" => {
	},
	"pfam" => {
		"perl" => '($value) ? " --pfam" : ""',
	},
	"sam" => {
		"perl" => '($value)? " --sam " : ""',
	},
	"samfrac" => {
		"perl" => '($value)? " --samfrac " : ""',
	},

    };

    $self->{FILENAMES}  = {
	"single_seq_file" => '"seqfile"',
	"multi_seq_file" => '"seqsfile"',
	"alig_file" => '"aligfile"',
	"selex_alig_file" => '"selex_aligfile"',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"sreformat" => 0,
	"seqfile" => 3,
	"single_seq_file" => 10,
	"multi_seq_file" => 10,
	"alig_file" => 10,
	"selex_alig_file" => 10,
	"output_format" => 2,
	"dna" => 1,
	"lowercase" => 1,
	"rna" => 1,
	"uppercase" => 1,
	"iupac_convert" => 1,
	"pfam" => 1,
	"sam" => 1,
	"samfrac" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"sreformat",
	"expert_options",
	"iupac_convert",
	"pfam",
	"sam",
	"samfrac",
	"lowercase",
	"dna",
	"rna",
	"uppercase",
	"output_format",
	"seqfile",
	"single_seq_file",
	"multi_seq_file",
	"alig_file",
	"selex_alig_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"sreformat" => 1,
	"seqfile" => 0,
	"single_seq_file" => 1,
	"multi_seq_file" => 1,
	"alig_file" => 0,
	"selex_alig_file" => 0,
	"output_format" => 0,
	"dna" => 0,
	"lowercase" => 0,
	"rna" => 0,
	"uppercase" => 0,
	"iupac_convert" => 0,
	"expert_options" => 0,
	"pfam" => 0,
	"sam" => 0,
	"samfrac" => 0,

    };

    $self->{ISCOMMAND}  = {
	"sreformat" => 1,
	"seqfile" => 0,
	"single_seq_file" => 0,
	"multi_seq_file" => 0,
	"alig_file" => 0,
	"selex_alig_file" => 0,
	"output_format" => 0,
	"dna" => 0,
	"lowercase" => 0,
	"rna" => 0,
	"uppercase" => 0,
	"iupac_convert" => 0,
	"expert_options" => 0,
	"pfam" => 0,
	"sam" => 0,
	"samfrac" => 0,

    };

    $self->{ISMANDATORY}  = {
	"sreformat" => 0,
	"seqfile" => 1,
	"single_seq_file" => 0,
	"multi_seq_file" => 0,
	"alig_file" => 0,
	"selex_alig_file" => 0,
	"output_format" => 1,
	"dna" => 0,
	"lowercase" => 0,
	"rna" => 0,
	"uppercase" => 0,
	"iupac_convert" => 0,
	"expert_options" => 0,
	"pfam" => 0,
	"sam" => 0,
	"samfrac" => 0,

    };

    $self->{PROMPT}  = {
	"sreformat" => "",
	"seqfile" => "Sequence(s) file",
	"single_seq_file" => "",
	"multi_seq_file" => "",
	"alig_file" => "",
	"selex_alig_file" => "",
	"output_format" => "output format",
	"dna" => "DNA (-d)",
	"lowercase" => "Convert all sequence residues to lower case (-l)",
	"rna" => "RNA (-r)",
	"uppercase" => "Convert all sequence residues to upper case (-u)",
	"iupac_convert" => "Convert DNA non-IUPAC characters (such as X's) to N's (-x)",
	"expert_options" => "Expert options",
	"pfam" => "(--pfam)",
	"sam" => "(--sam)",
	"samfrac" => "(--samfrac x)",

    };

    $self->{ISSTANDOUT}  = {
	"sreformat" => 0,
	"seqfile" => 0,
	"single_seq_file" => 0,
	"multi_seq_file" => 0,
	"alig_file" => 0,
	"selex_alig_file" => 0,
	"output_format" => 0,
	"dna" => 0,
	"lowercase" => 0,
	"rna" => 0,
	"uppercase" => 0,
	"iupac_convert" => 0,
	"expert_options" => 0,
	"pfam" => 0,
	"sam" => 0,
	"samfrac" => 0,

    };

    $self->{VLIST}  = {

	"output_format" => ['fasta','FASTA format','embl','EMBL/SWISSPROT format','genbank','GENBANK format','GCG','GCG single sequence format','gcgdata','GCG flatfile database format','strider','MacStrider format','zuker','ZUKER MFOLD format','ig','Intelligenetics format','pir','PIR/CODATA flatfile format','squid','undocumented St Louis format','raw','raw sequence, no other information','stockholm','PFAM/Stockholm format','msf','GCG MSF format','a2m','aligned FASTA format','phylip','Felsenstein\'s PHYLIP format','selex','old SELEX/HMMER/Pfam annotated alignment format',],
	"expert_options" => ['pfam','sam','samfrac',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"sreformat" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"single_seq_file" => {
		"perl" => '$output_format eq "embl" || $output_format eq "GCG" || $output_format eq "pir" || $output_format eq "zuker"',
	},
	"multi_seq_file" => {
		"perl" => '$output_format eq "fasta" || $output_format eq "gcgdata" || $output_format eq "raw"',
	},
	"alig_file" => {
		"perl" => '$output_format eq "msf" || $output_format eq "a2m"',
	},
	"selex_alig_file" => {
		"perl" => '$output_format eq "selex"',
	},
	"output_format" => { "perl" => '1' },
	"dna" => { "perl" => '1' },
	"lowercase" => { "perl" => '1' },
	"rna" => { "perl" => '1' },
	"uppercase" => { "perl" => '1' },
	"iupac_convert" => { "perl" => '1' },
	"expert_options" => { "perl" => '1' },
	"pfam" => { "perl" => '1' },
	"sam" => { "perl" => '1' },
	"samfrac" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"single_seq_file" => {
		 '1' => "seqfile",
	},
	"multi_seq_file" => {
		 '1' => "seqsfile",
	},
	"alig_file" => {
		 '1' => "readseq_ok_alig",
	},
	"selex_alig_file" => {
		 '1' => "hmmer_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqfile" => {
		 "hmmer_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"sreformat" => 0,
	"seqfile" => 0,
	"single_seq_file" => 0,
	"multi_seq_file" => 0,
	"alig_file" => 0,
	"selex_alig_file" => 0,
	"output_format" => 0,
	"dna" => 0,
	"lowercase" => 0,
	"rna" => 0,
	"uppercase" => 0,
	"iupac_convert" => 0,
	"expert_options" => 0,
	"pfam" => 0,
	"sam" => 0,
	"samfrac" => 0,

    };

    $self->{ISSIMPLE}  = {
	"sreformat" => 0,
	"seqfile" => 0,
	"single_seq_file" => 0,
	"multi_seq_file" => 0,
	"alig_file" => 0,
	"selex_alig_file" => 0,
	"output_format" => 0,
	"dna" => 0,
	"lowercase" => 0,
	"rna" => 0,
	"uppercase" => 0,
	"iupac_convert" => 0,
	"expert_options" => 0,
	"pfam" => 0,
	"sam" => 0,
	"samfrac" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"seqfile" => [
		"Supported input formats include (but are not limited to) the unaligned formats FASTA, Genbank, EMBL, SWISS-PROT, PIR, and GCG, and the aligned formats SELEX, Clustal, and GCG MSF.",
		"Unaligned format files cannot be reformatted to aligned formats. However, aligned formats can be reformatted to unaligned formats -- gap characters are simply stripped out.",
	],
	"output_format" => [
		"Available unaligned output file format codes include fasta (FASTA format); embl (EMBL/SWISSPROT format); genbank (Genbank format); gcg (GCG single sequence format); gcgdata (GCG flatfile database format); strider (MacStrider format); zuker (Zuker MFOLD format); ig (Intelligenetics format); pir (PIR/CODATA flatfile format); squid (an undocumented St. Louisformat); raw (raw sequence, no other information). The available aligned output file format codes include stockholm (PFAM/Stockholm format); msf (GCG MSF format); a2m (aligned FASTA format, called A2M by the UC Santa Cruz HMM group); PHYLIP (Felsenstein\'s PHYLIP format); and selex (old SELEX/HMMER/Pfam annotated alignment format).",
	],
	"dna" => [
		"convert U\'s to T\'s, to make sure a nucleic acid sequence is shown as DNA not RNA.",
	],
	"lowercase" => [
		"convert all sequence residues to lower case.",
	],
	"rna" => [
		"convert T\'s to U\'s, to make sure a nucleic acid sequence is shown as RNA not DNA.",
	],
	"uppercase" => [
		"convert all sequence residues to upper case.",
	],
	"pfam" => [
		"For SELEX alignment output format only, put the entire alignment in one block (don\'t wrap into multiple blocks).",
	],
	"sam" => [
		"Try to convert gap characters to UC Santa Cruz SAM style, where a . means a gap in an insert column, and a - means a deletion in a consensus/match column. This only works for converting aligned file formats, and only if the alignment already adheres to the SAM convention of upper case for residues consensus/match columns, and lower case for residues in insert columns. This is true, for instance, of all alignments produced by old versions of HMMER. (HMMER2 produces alignments that adhere to SAM\'s conventions even in gap character choice.) This option was added to allow Pfam alignments to be reformatted into something more suitable for profile HMM construction using the UCSC SAM software.",
	],
	"samfrac" => [
		"Try to convert the alignment gap characters and residue cases to UC Santa Cruz SAM style, where a . means a gap in an insert column and a - means a deletion in a consensus/match column, and upper case means match/consensus residues and lower case means inserted resiudes. This will only work for converting aligned file formats, but unlike the -sam option, it will work regardless of whether the file adheres to the upper/lower case residue convention. Instead, any column containing more than a fraction x of gap characters is interpreted as an insert column, and all other columns are interpreted as match columns. This option was added to allow Pfam alignments to be reformatted into something more suitable for profile HMM construction using the UCSC SAM software.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/sreformat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

