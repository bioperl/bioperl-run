
=head1 NAME

Bio::Tools::Run::PiseApplication::blimps_block

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::blimps_block

      Bioperl class for:

	BLIMPS	score a query sequence against Blocks database (Wallace & Henikoff)

	References:

		J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).

		Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)


      Parameters:


		blimps_block (String)
			

		action (String)
			

		blocks_db (String)
			

		sequence_file (Sequence)
			Sequence file (SQ)

		control_parameters (Paragraph)
			Control parameters

		genetic_code (Excl)
			The Genetic code to use (if DNA sequence or database)

		strands (Integer)
			The number of strands to search (if DNA sequence or database)

		output_parameters (Paragraph)
			Output parameters

		outfile (OutFile)
			Output file filename

		error (Excl)
			Error level to report at

		histogram (Switch)
			Print the histogram values in the output file

		scores (Integer)
			The number of scores to report.

		repeats (Switch)
			Repeats are allowed in the scoring list

		config_file (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::blimps_block;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $blimps_block = Bio::Tools::Run::PiseApplication::blimps_block->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::blimps_block object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $blimps_block = $factory->program('blimps_block');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::blimps_block.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blimps_block.pm

    $self->{COMMAND}   = "blimps_block";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLIMPS";

    $self->{DESCRIPTION}   = "score a query sequence against Blocks database";

    $self->{AUTHORS}   = "Wallace & Henikoff";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-aa.html#BLIMPS";

    $self->{REFERENCE}   = [

         "J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).",

         "Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"blimps_block",
	"action",
	"blocks_db",
	"sequence_file",
	"control_parameters",
	"output_parameters",
	"config_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"blimps_block",
	"action",
	"blocks_db",
	"sequence_file", 	# Sequence file (SQ)
	"control_parameters", 	# Control parameters
	"genetic_code", 	# The Genetic code to use (if DNA sequence or database)
	"strands", 	# The number of strands to search (if DNA sequence or database)
	"output_parameters", 	# Output parameters
	"outfile", 	# Output file filename
	"error", 	# Error level to report at
	"histogram", 	# Print the histogram values in the output file
	"scores", 	# The number of scores to report.
	"repeats", 	# Repeats are allowed in the scoring list
	"config_file",

    ];

    $self->{TYPE}  = {
	"blimps_block" => 'String',
	"action" => 'String',
	"blocks_db" => 'String',
	"sequence_file" => 'Sequence',
	"control_parameters" => 'Paragraph',
	"genetic_code" => 'Excl',
	"strands" => 'Integer',
	"output_parameters" => 'Paragraph',
	"outfile" => 'OutFile',
	"error" => 'Excl',
	"histogram" => 'Switch',
	"scores" => 'Integer',
	"repeats" => 'Switch',
	"config_file" => 'Results',

    };

    $self->{FORMAT}  = {
	"blimps_block" => {
		"perl" => '"blimps blimps.cs"',
	},
	"action" => {
		"perl" => ' "SE	block\\n" ',
	},
	"blocks_db" => {
		"perl" => '"DB	/local/gensoft/lib/blimps/db/blocks.dat\\n" ',
	},
	"sequence_file" => {
		"perl" => ' "SQ	$value\\n" ',
	},
	"control_parameters" => {
	},
	"genetic_code" => {
		"perl" => '($value)? "GE	$value\\n" : "" ',
	},
	"strands" => {
		"perl" => '($value && $value != $vdef)? "ST	$value\\n" : ""',
	},
	"output_parameters" => {
	},
	"outfile" => {
		"perl" => '"OU	$value\\n" ',
	},
	"error" => {
		"perl" => '"ER	$value\\n"',
	},
	"histogram" => {
		"perl" => '(! $value)? "" : "HI	yes\\n" ',
	},
	"scores" => {
		"perl" => '(defined $value)? "NU	$value\\n" : "\\n" ',
	},
	"repeats" => {
		"perl" => '(! $value)? "RE	0\\n" : "" ',
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
	"blimps_block" => 0,
	"action" => 2,
	"control_parameters" => 4,
	"genetic_code" => 4,
	"strands" => 4,
	"output_parameters" => 5,
	"outfile" => 5,
	"error" => 1,
	"histogram" => 5,
	"scores" => 5,
	"repeats" => 5,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"blimps_block",
	"blocks_db",
	"sequence_file",
	"config_file",
	"error",
	"action",
	"strands",
	"control_parameters",
	"genetic_code",
	"output_parameters",
	"histogram",
	"scores",
	"repeats",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"blimps_block" => 1,
	"action" => 1,
	"blocks_db" => 1,
	"sequence_file" => 0,
	"control_parameters" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"blimps_block" => 1,
	"action" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"control_parameters" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"blimps_block" => 0,
	"action" => 1,
	"blocks_db" => 0,
	"sequence_file" => 1,
	"control_parameters" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 1,
	"error" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{PROMPT}  = {
	"blimps_block" => "",
	"action" => "",
	"blocks_db" => "",
	"sequence_file" => "Sequence file (SQ)",
	"control_parameters" => "Control parameters",
	"genetic_code" => "The Genetic code to use (if DNA sequence or database)",
	"strands" => "The number of strands to search (if DNA sequence or database)",
	"output_parameters" => "Output parameters",
	"outfile" => "Output file filename",
	"error" => "Error level to report at",
	"histogram" => "Print the histogram values in the output file",
	"scores" => "The number of scores to report.",
	"repeats" => "Repeats are allowed in the scoring list",
	"config_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"blimps_block" => 0,
	"action" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"control_parameters" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{VLIST}  = {

	"control_parameters" => ['genetic_code','strands',],
	"genetic_code" => ['0','0 - Standard (default)','1','1 - Vertebrate Mitochondrial','2','2 - Yeast Mitochondrial','3','3 - Mold Mitochondrial and Mycoplasma','4','4 - Invertebrate Mitochondrial','5','5 - Ciliate Macronuclear','6','6 - Protozoan Mitochondrial','7','7 - Plant Mitochondrial','8','8 - Echinodermate Mitochondrial',],
	"output_parameters" => ['outfile','error','histogram','scores','repeats',],
	"error" => ['1','1 - info ','2','2 - warning','3','3 - serious','4','4 - program error','5','5 - fatal error',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"genetic_code" => '0',
	"strands" => '2',
	"outfile" => 'blimps.results',
	"error" => '2',
	"histogram" => '0',
	"scores" => '0',
	"repeats" => '1',

    };

    $self->{PRECOND}  = {
	"blimps_block" => { "perl" => '1' },
	"action" => { "perl" => '1' },
	"blocks_db" => { "perl" => '1' },
	"sequence_file" => { "perl" => '1' },
	"control_parameters" => { "perl" => '1' },
	"genetic_code" => { "perl" => '1' },
	"strands" => { "perl" => '1' },
	"output_parameters" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"error" => { "perl" => '1' },
	"histogram" => { "perl" => '1' },
	"scores" => { "perl" => '1' },
	"repeats" => { "perl" => '1' },
	"config_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"strands" => {
		"perl" => {
			'$value != 1 && $value != 2' => "values allowed: 1 or 2",
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
	"blimps_block" => 0,
	"action" => 0,
	"blocks_db" => 0,
	"sequence_file" => 0,
	"control_parameters" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"blimps_block" => 0,
	"action" => 0,
	"blocks_db" => 0,
	"sequence_file" => 1,
	"control_parameters" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{PARAMFILE}  = {
	"action" => "blimps.cs",
	"blocks_db" => "blimps.cs",
	"sequence_file" => "blimps.cs",
	"genetic_code" => "blimps.cs",
	"strands" => "blimps.cs",
	"outfile" => "blimps.cs",
	"error" => "blimps.cs",
	"histogram" => "blimps.cs",
	"scores" => "blimps.cs",
	"repeats" => "blimps.cs",

    };

    $self->{COMMENT}  = {
	"sequence_file" => [
		"To score a query sequence against a database of blocks, specify the query sequence file name and the blocks database name. The query can be either a protein or DNA sequence. BLIMPS converts each block in the database to a position-specific scoring matrix and scores every possible alignment between each block and the query. If the query is DNA, alignments can be scored in all six translation frames or just the reading frames of the given strand, depending on the ST field in the configuration file.",
	],
	"strands" => [
		"If the query is DNA, alignments can be scored in all six translation frames or just the reading frames of the given strand.",
	],
	"error" => [
		"Errors of lesser value than the error level are not reported. The program will always handle a fatal error regardless of the error level setting.",
	],
	"scores" => [
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blimps_block.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

