
=head1 NAME

Bio::Tools::Run::PiseApplication::blimps

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::blimps

      Bioperl class for:

	BLIMPS	BLocks IMProved Searcher (Wallace, Henikoff)

      Parameters:


		blimps (String)
			

		action (Excl)
			Action

		block_parameters (Paragraph)
			Parameters for sequence against Block db (action=block)

		blocks_db (Excl)
			Blocks database

		sequence_file (Sequence)
			Sequence file filename to score against blocks database

		matrix_parameters (Paragraph)
			Parameters for block against sequences db (action=matrix)

		sequence_db (Excl)
			Sequences database

		block_file (InFile)
			Block file filename

		matrix_file (InFile)
			A precomputed site specific scoring matrix file

		control_parameters (Paragraph)
			Control parameters

		conversion (Excl)
			Conversion method for converting a block to a matrix

		genetic_code (Excl)
			The Genetic code to use

		strand (Switch)
			both strands to be searched

		output_parameters (Paragraph)
			Output parameters

		outfile (OutFile)
			Output file filename

		error (Excl)
			Error level to report at

		export_matrix (OutFile)
			Export matrix (matricies) to this filename

		histogram (Switch)
			Print the histogram values in the output file

		scores_number (Integer)
			The number of scores to report.

		repeats (Switch)
			Repeats are allowed in the scoring list

		error_file (OutFile)
			

		config_file (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::blimps;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $blimps = Bio::Tools::Run::PiseApplication::blimps->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::blimps object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $blimps = $factory->program('blimps');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::blimps.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blimps.pm

    $self->{COMMAND}   = "blimps";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLIMPS";

    $self->{DESCRIPTION}   = "BLocks IMProved Searcher";

    $self->{AUTHORS}   = "Wallace, Henikoff";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"blimps",
	"action",
	"block_parameters",
	"matrix_parameters",
	"control_parameters",
	"output_parameters",
	"config_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"blimps",
	"action", 	# Action
	"block_parameters", 	# Parameters for sequence against Block db (action=block)
	"blocks_db", 	# Blocks database
	"sequence_file", 	# Sequence file filename to score against blocks database
	"matrix_parameters", 	# Parameters for block against sequences db (action=matrix)
	"sequence_db", 	# Sequences database
	"block_file", 	# Block file filename
	"matrix_file", 	# A precomputed site specific scoring matrix file
	"control_parameters", 	# Control parameters
	"conversion", 	# Conversion method for converting a block to a matrix
	"genetic_code", 	# The Genetic code to use
	"strand", 	# both strands to be searched
	"output_parameters", 	# Output parameters
	"outfile", 	# Output file filename
	"error", 	# Error level to report at
	"export_matrix", 	# Export matrix (matricies) to this filename
	"histogram", 	# Print the histogram values in the output file
	"scores_number", 	# The number of scores to report.
	"repeats", 	# Repeats are allowed in the scoring list
	"error_file",
	"config_file",

    ];

    $self->{TYPE}  = {
	"blimps" => 'String',
	"action" => 'Excl',
	"block_parameters" => 'Paragraph',
	"blocks_db" => 'Excl',
	"sequence_file" => 'Sequence',
	"matrix_parameters" => 'Paragraph',
	"sequence_db" => 'Excl',
	"block_file" => 'InFile',
	"matrix_file" => 'InFile',
	"control_parameters" => 'Paragraph',
	"conversion" => 'Excl',
	"genetic_code" => 'Excl',
	"strand" => 'Switch',
	"output_parameters" => 'Paragraph',
	"outfile" => 'OutFile',
	"error" => 'Excl',
	"export_matrix" => 'OutFile',
	"histogram" => 'Switch',
	"scores_number" => 'Integer',
	"repeats" => 'Switch',
	"error_file" => 'OutFile',
	"config_file" => 'Results',

    };

    $self->{FORMAT}  = {
	"blimps" => {
		"perl" => '"blimps blimps.cs "',
	},
	"action" => {
		"perl" => ' "SE	$value\\n" ',
	},
	"block_parameters" => {
	},
	"blocks_db" => {
		"perl" => '"DB	/local/gensoft/lib/blimps/db/$value\\n" ',
	},
	"sequence_file" => {
		"perl" => ' "SQ	$value\\n" ',
	},
	"matrix_parameters" => {
	},
	"sequence_db" => {
		"perl" => ' "DB	/local/databases/fasta/$value\\n" ',
	},
	"block_file" => {
		"perl" => ' ($value eq "")? "" : "BL	$value\\n" ',
	},
	"matrix_file" => {
		"perl" => '($value eq "")? "" : "MA	$value\\n" ',
	},
	"control_parameters" => {
	},
	"conversion" => {
		"perl" => ' "CO	$value\\n" ',
	},
	"genetic_code" => {
		"perl" => '($value)? "GE	$value\\n" : "" ',
	},
	"strand" => {
		"perl" => '(! $value)? "ST	1\\n" : ""',
	},
	"output_parameters" => {
	},
	"outfile" => {
		"perl" => '"OU	$value\\n" ',
	},
	"error" => {
		"perl" => '"ER	$value\\n"',
	},
	"export_matrix" => {
		"perl" => '($value eq "")? "" : "EX	$value\\n" ',
	},
	"histogram" => {
		"perl" => '(! $value)? "" : "HI	yes\\n" ',
	},
	"scores_number" => {
		"perl" => '(defined $value)? "NU	$value\\n" : "\\n" ',
	},
	"repeats" => {
		"perl" => '(! $value)? "RE	0\\n" : "" ',
	},
	"error_file" => {
		"perl" => 'blimps.err',
	},
	"config_file" => {
	},

    };

    $self->{FILENAMES}  = {
	"config_file" => 'blimps.cs',

    };

    $self->{SEQFMT}  = {
	"sequence_file" => [8,2,14,4,5],

    };

    $self->{GROUP}  = {
	"blimps" => 0,
	"action" => 2,
	"block_parameters" => 3,
	"blocks_db" => 3,
	"sequence_file" => 3,
	"matrix_parameters" => 3,
	"sequence_db" => 3,
	"block_file" => 3,
	"matrix_file" => 3,
	"control_parameters" => 4,
	"conversion" => 4,
	"genetic_code" => 4,
	"strand" => 4,
	"output_parameters" => 5,
	"outfile" => 5,
	"error" => 1,
	"export_matrix" => 5,
	"histogram" => 5,
	"scores_number" => 5,
	"repeats" => 5,
	"error_file" => 5,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"blimps",
	"config_file",
	"error",
	"action",
	"block_parameters",
	"blocks_db",
	"sequence_file",
	"matrix_parameters",
	"sequence_db",
	"block_file",
	"matrix_file",
	"genetic_code",
	"strand",
	"control_parameters",
	"conversion",
	"output_parameters",
	"export_matrix",
	"histogram",
	"scores_number",
	"repeats",
	"error_file",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"blimps" => 1,
	"action" => 0,
	"block_parameters" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"matrix_parameters" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"matrix_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"genetic_code" => 0,
	"strand" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores_number" => 0,
	"repeats" => 0,
	"error_file" => 1,
	"config_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"blimps" => 1,
	"action" => 0,
	"block_parameters" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"matrix_parameters" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"matrix_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"genetic_code" => 0,
	"strand" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores_number" => 0,
	"repeats" => 0,
	"error_file" => 0,
	"config_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"blimps" => 0,
	"action" => 1,
	"block_parameters" => 0,
	"blocks_db" => 1,
	"sequence_file" => 1,
	"matrix_parameters" => 0,
	"sequence_db" => 1,
	"block_file" => 0,
	"matrix_file" => 0,
	"control_parameters" => 0,
	"conversion" => 1,
	"genetic_code" => 0,
	"strand" => 0,
	"output_parameters" => 0,
	"outfile" => 1,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores_number" => 0,
	"repeats" => 0,
	"error_file" => 0,
	"config_file" => 0,

    };

    $self->{PROMPT}  = {
	"blimps" => "",
	"action" => "Action",
	"block_parameters" => "Parameters for sequence against Block db (action=block)",
	"blocks_db" => "Blocks database",
	"sequence_file" => "Sequence file filename to score against blocks database",
	"matrix_parameters" => "Parameters for block against sequences db (action=matrix)",
	"sequence_db" => "Sequences database",
	"block_file" => "Block file filename",
	"matrix_file" => "A precomputed site specific scoring matrix file",
	"control_parameters" => "Control parameters",
	"conversion" => "Conversion method for converting a block to a matrix",
	"genetic_code" => "The Genetic code to use",
	"strand" => "both strands to be searched",
	"output_parameters" => "Output parameters",
	"outfile" => "Output file filename",
	"error" => "Error level to report at",
	"export_matrix" => "Export matrix (matricies) to this filename",
	"histogram" => "Print the histogram values in the output file",
	"scores_number" => "The number of scores to report.",
	"repeats" => "Repeats are allowed in the scoring list",
	"error_file" => "",
	"config_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"blimps" => 0,
	"action" => 0,
	"block_parameters" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"matrix_parameters" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"matrix_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"genetic_code" => 0,
	"strand" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores_number" => 0,
	"repeats" => 0,
	"error_file" => 0,
	"config_file" => 0,

    };

    $self->{VLIST}  = {

	"action" => ['block','block: score a query sequence against Blocks database','matrix','matrix: score a block or matrix against a database of sequences',],
	"block_parameters" => ['blocks_db','sequence_file',],
	"blocks_db" => ['blocks.dat','blocks.dat',],
	"matrix_parameters" => ['sequence_db','block_file','matrix_file',],
	"sequence_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','prodom','prodom: protein domains','sbase','sbase: annotated domains sequences','embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"control_parameters" => ['conversion','genetic_code','strand',],
	"conversion" => ['0','Clustering','1','patmat\'s method','2','Sequence weighing',],
	"genetic_code" => ['0','0 - Standard (default)','1','1 - Vertebrate Mitochondrial','2','2 - Yeast Mitochondrial','3','3 - Mold Mitochondrial and Mycoplasma','4','4 - Invertebrate Mitochondrial','5','5 - Ciliate Macronuclear','6','6 - Protozoan Mitochondrial','7','7 - Plant Mitochondrial','8','8 - Echinodermate Mitochondrial',],
	"output_parameters" => ['outfile','error','export_matrix','histogram','scores_number','repeats','error_file',],
	"error" => ['1','1 - info ','2','2 - warning','3','3 - serious','4','4 - program error','5','5 - fatal error',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"action" => 'block',
	"blocks_db" => 'blocks.dat',
	"sequence_db" => 'swissprot',
	"conversion" => '2',
	"genetic_code" => '0',
	"strand" => '1',
	"outfile" => 'blimps.results',
	"error" => '2',
	"histogram" => '0',
	"scores_number" => '0',
	"repeats" => '1',

    };

    $self->{PRECOND}  = {
	"blimps" => { "perl" => '1' },
	"action" => { "perl" => '1' },
	"block_parameters" => {
		"perl" => '$action eq "block"',
	},
	"blocks_db" => {
		"perl" => '$action eq "block"',
	},
	"sequence_file" => {
		"perl" => '$action eq "block"',
	},
	"matrix_parameters" => {
		"perl" => '$action eq "matrix"',
	},
	"sequence_db" => {
		"perl" => '$action eq "matrix"',
	},
	"block_file" => {
		"perl" => '$action eq "matrix"',
	},
	"matrix_file" => {
		"perl" => '$action eq "matrix"',
	},
	"control_parameters" => { "perl" => '1' },
	"conversion" => { "perl" => '1' },
	"genetic_code" => { "perl" => '1' },
	"strand" => { "perl" => '1' },
	"output_parameters" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"error" => { "perl" => '1' },
	"export_matrix" => {
		"perl" => '$action eq "matrix"',
	},
	"histogram" => { "perl" => '1' },
	"scores_number" => { "perl" => '1' },
	"repeats" => { "perl" => '1' },
	"error_file" => { "perl" => '1' },
	"config_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"block_file" => {
		"perl" => {
			'$matrix_file && $block_file' => "only one of the block or the matrix files is required",
		},
	},
	"matrix_file" => {
		"perl" => {
			'$matrix_file && $block_file' => "only one of the block or the matrix files is required",
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
	"blimps" => 0,
	"action" => 0,
	"block_parameters" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"matrix_parameters" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"matrix_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"genetic_code" => 0,
	"strand" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores_number" => 0,
	"repeats" => 0,
	"error_file" => 0,
	"config_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"blimps" => 0,
	"action" => 0,
	"block_parameters" => 0,
	"blocks_db" => 0,
	"sequence_file" => 1,
	"matrix_parameters" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"matrix_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"genetic_code" => 0,
	"strand" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores_number" => 0,
	"repeats" => 0,
	"error_file" => 0,
	"config_file" => 0,

    };

    $self->{PARAMFILE}  = {
	"action" => "blimps.cs",
	"blocks_db" => "blimps.cs",
	"sequence_file" => "blimps.cs",
	"sequence_db" => "blimps.cs",
	"block_file" => "blimps.cs",
	"matrix_file" => "blimps.cs",
	"conversion" => "blimps.cs",
	"genetic_code" => "blimps.cs",
	"strand" => "blimps.cs",
	"outfile" => "blimps.cs",
	"error" => "blimps.cs",
	"export_matrix" => "blimps.cs",
	"histogram" => "blimps.cs",
	"scores_number" => "blimps.cs",
	"repeats" => "blimps.cs",

    };

    $self->{COMMENT}  = {
	"action" => [
		"To score a query sequence against a database of blocks, specify the query sequence file name and the blocks database name. The query can be either a protein or DNA sequence. BLIMPS converts each block in the database to a position-specific scoring matrix and scores every possible alignment between each block and the query. If the query is DNA, alignments can be scored in all six translation frames or just the reading frames of the given strand, depending on the ST field in the configuration file.",
		"To score a block query against a database of sequences, specify the block file name and the sequence database name. The sequence database can be either a protein or DNA database. BLIMPS converts the query block to a position-specific scoring matrix and scores every possible alignment between it and every sequence in the database. If the database is DNA, alignments can be scored in all six translation frames or just the reading frames of the given strand.",
	],
	"matrix_file" => [
		"If you give a block file, Blimps converts it to a position-specific scoring matrix; but you can directly give a matrix file you have one.",
		"You can produce a matrix file by asking to export matricies to a file, only when action is to score a block query against a database of sequences (matrix).",
	],
	"conversion" => [
		"The field value is a number. The possible values so far are:",
		"0 - Clustering. Same as the original method, but cleaner and without the negative fields in the frequency file. It also does a weighted average of D & N to get B and of E & Q to get Z. If a B or Z is encountered, it is split between D & N or E & Q.",
		"1 - uses patmat\'s method, needs -1 and -2 in the frequency file - gets weird numbers due to division by zero if there are zeros in the frequency file.",
		"2 - Sequence weighing. The default. The same as clustering except that the weights of the sequences are taken explicitly from the given weights, rather than implicitly from the clustering.",
	],
	"error" => [
		"Errors of lesser value than the error level are not reported. The program will always handle a fatal error regardless of the error level setting.",
	],
	"export_matrix" => [
		"Not allowed for action = block.",
	],
	"scores_number" => [
		"A number less than zero means to report all the scores. A number of zero means to judge the number to report based on the query block or sequence. A number greater than zero is the number to actually report. The default value is zero.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blimps.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

