
=head1 NAME

Bio::Tools::Run::PiseApplication::pima

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pima

      Bioperl class for:

	PIMA	Pattern-Induced Multi-sequence Alignment program (R. D. Smith and T. F. Smith)

	References:

		R. D. Smith and T. F. Smith. Pattern-induced multi-sequence alignment (PIMA) algorithm employing secondary structure-dependent gap penalties for use in comparative modelling. protein Engineering, vol5, number 1, pp 35-41, 1992


      Parameters:


		pima (String)


		sequence (Sequence)
			Sequences

		cluster_name (String)
			cluster_name

		pima_params (Paragraph)
			Parameters

		ref_seq_name (String)
			ref_seq_name

		sec_struc_seq_filename (InFile)
			sec_struc_seq_filename

		pima_options (Paragraph)
			options

		score_cutoff (Float)
			 cluster score cutoff (-c) 

		ext_gap_cost (Integer)
			 gap extension penalty (-d) 

		gap_open_cost (Integer)
			 gap opening penalty (-i) 

		min_score (Integer)
			 minimum local score (-l) 

		mat_file (InFile)
			 matrix file (-m) 

		not_num_ext (Switch)
			Do not use numerical extensions on each step of the alignment. (-n)

		sec_struc_gap_cost (Integer)
			secondary structure gap penalty (-t)

		results (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::pima;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pima = Bio::Tools::Run::PiseApplication::pima->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pima object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pima = $factory->program('pima');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pima.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pima.pm

    $self->{COMMAND}   = "pima";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PIMA";

    $self->{DESCRIPTION}   = "Pattern-Induced Multi-sequence Alignment program";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{AUTHORS}   = "R. D. Smith and T. F. Smith";

    $self->{REFERENCE}   = [

         "R. D. Smith and T. F. Smith. Pattern-induced multi-sequence alignment (PIMA) algorithm employing secondary structure-dependent gap penalties for use in comparative modelling. protein Engineering, vol5, number 1, pp 35-41, 1992",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pima",
	"sequence",
	"cluster_name",
	"pima_params",
	"pima_options",
	"results",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pima",
	"sequence", 	# Sequences
	"cluster_name", 	# cluster_name
	"pima_params", 	# Parameters
	"ref_seq_name", 	# ref_seq_name
	"sec_struc_seq_filename", 	# sec_struc_seq_filename
	"pima_options", 	# options
	"score_cutoff", 	#  cluster score cutoff (-c) 
	"ext_gap_cost", 	#  gap extension penalty (-d) 
	"gap_open_cost", 	#  gap opening penalty (-i) 
	"min_score", 	#  minimum local score (-l) 
	"mat_file", 	#  matrix file (-m) 
	"not_num_ext", 	# Do not use numerical extensions on each step of the alignment. (-n)
	"sec_struc_gap_cost", 	# secondary structure gap penalty (-t)
	"results",

    ];

    $self->{TYPE}  = {
	"pima" => 'String',
	"sequence" => 'Sequence',
	"cluster_name" => 'String',
	"pima_params" => 'Paragraph',
	"ref_seq_name" => 'String',
	"sec_struc_seq_filename" => 'InFile',
	"pima_options" => 'Paragraph',
	"score_cutoff" => 'Float',
	"ext_gap_cost" => 'Integer',
	"gap_open_cost" => 'Integer',
	"min_score" => 'Integer',
	"mat_file" => 'InFile',
	"not_num_ext" => 'Switch',
	"sec_struc_gap_cost" => 'Integer',
	"results" => 'Results',

    };

    $self->{FORMAT}  = {
	"pima" => {
		"seqlab" => 'pima',
		"perl" => '"pima"',
	},
	"sequence" => {
		"perl" => '" $value" ',
	},
	"cluster_name" => {
		"perl" => '" $value"	',
	},
	"pima_params" => {
	},
	"ref_seq_name" => {
		"perl" => '			($value)? " $value" : "" 			',
	},
	"sec_struc_seq_filename" => {
		"perl" => '($value)? " $value" : "" ',
	},
	"pima_options" => {
	},
	"score_cutoff" => {
		"perl" => '($value)? " -c $value " : "" ',
	},
	"ext_gap_cost" => {
		"perl" => '($value)? " -d $value" : "" ',
	},
	"gap_open_cost" => {
		"perl" => '($value)? " -d $value" : "" ',
	},
	"min_score" => {
		"perl" => '($value)? " -l $value" : "" ',
	},
	"mat_file" => {
		"perl" => '($value)? " -m $value" : "" ',
	},
	"not_num_ext" => {
		"perl" => '($value)? " -n" : "" ',
	},
	"sec_struc_gap_cost" => {
		"perl" => '($value)? " -t $value " : "" ',
	},
	"results" => {
	},

    };

    $self->{FILENAMES}  = {
	"results" => '*.cluster *.pattern *.pima',

    };

    $self->{SEQFMT}  = {
	"sequence" => [1,8],

    };

    $self->{GROUP}  = {
	"pima" => 0,
	"sequence" => 3,
	"cluster_name" => 2,
	"ref_seq_name" => 4,
	"sec_struc_seq_filename" => 5,
	"pima_options" => 1,
	"score_cutoff" => 1,
	"ext_gap_cost" => 1,
	"gap_open_cost" => 1,
	"min_score" => 1,
	"mat_file" => 1,
	"not_num_ext" => 1,
	"sec_struc_gap_cost" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pima",
	"pima_params",
	"results",
	"mat_file",
	"not_num_ext",
	"sec_struc_gap_cost",
	"pima_options",
	"score_cutoff",
	"ext_gap_cost",
	"gap_open_cost",
	"min_score",
	"cluster_name",
	"sequence",
	"ref_seq_name",
	"sec_struc_seq_filename",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pima" => 1,
	"sequence" => 0,
	"cluster_name" => 0,
	"pima_params" => 0,
	"ref_seq_name" => 0,
	"sec_struc_seq_filename" => 0,
	"pima_options" => 0,
	"score_cutoff" => 0,
	"ext_gap_cost" => 0,
	"gap_open_cost" => 0,
	"min_score" => 0,
	"mat_file" => 0,
	"not_num_ext" => 0,
	"sec_struc_gap_cost" => 0,
	"results" => 0,

    };

    $self->{ISCOMMAND}  = {
	"pima" => 1,
	"sequence" => 0,
	"cluster_name" => 0,
	"pima_params" => 0,
	"ref_seq_name" => 0,
	"sec_struc_seq_filename" => 0,
	"pima_options" => 0,
	"score_cutoff" => 0,
	"ext_gap_cost" => 0,
	"gap_open_cost" => 0,
	"min_score" => 0,
	"mat_file" => 0,
	"not_num_ext" => 0,
	"sec_struc_gap_cost" => 0,
	"results" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pima" => 0,
	"sequence" => 1,
	"cluster_name" => 1,
	"pima_params" => 0,
	"ref_seq_name" => 0,
	"sec_struc_seq_filename" => 0,
	"pima_options" => 0,
	"score_cutoff" => 0,
	"ext_gap_cost" => 0,
	"gap_open_cost" => 0,
	"min_score" => 0,
	"mat_file" => 0,
	"not_num_ext" => 0,
	"sec_struc_gap_cost" => 0,
	"results" => 0,

    };

    $self->{PROMPT}  = {
	"pima" => "",
	"sequence" => "Sequences",
	"cluster_name" => "cluster_name",
	"pima_params" => "Parameters",
	"ref_seq_name" => "ref_seq_name",
	"sec_struc_seq_filename" => "sec_struc_seq_filename",
	"pima_options" => "options",
	"score_cutoff" => " cluster score cutoff (-c) ",
	"ext_gap_cost" => " gap extension penalty (-d) ",
	"gap_open_cost" => " gap opening penalty (-i) ",
	"min_score" => " minimum local score (-l) ",
	"mat_file" => " matrix file (-m) ",
	"not_num_ext" => "Do not use numerical extensions on each step of the alignment. (-n)",
	"sec_struc_gap_cost" => "secondary structure gap penalty (-t)",
	"results" => "",

    };

    $self->{ISSTANDOUT}  = {
	"pima" => 0,
	"sequence" => 0,
	"cluster_name" => 0,
	"pima_params" => 0,
	"ref_seq_name" => 0,
	"sec_struc_seq_filename" => 0,
	"pima_options" => 0,
	"score_cutoff" => 0,
	"ext_gap_cost" => 0,
	"gap_open_cost" => 0,
	"min_score" => 0,
	"mat_file" => 0,
	"not_num_ext" => 0,
	"sec_struc_gap_cost" => 0,
	"results" => 0,

    };

    $self->{VLIST}  = {

	"pima_params" => ['ref_seq_name','sec_struc_seq_filename',],
	"pima_options" => ['score_cutoff','ext_gap_cost','gap_open_cost','min_score','mat_file','not_num_ext','sec_struc_gap_cost',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"score_cutoff" => '0.0',
	"not_num_ext" => '0',

    };

    $self->{PRECOND}  = {
	"pima" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"cluster_name" => { "perl" => '1' },
	"pima_params" => { "perl" => '1' },
	"ref_seq_name" => { "perl" => '1' },
	"sec_struc_seq_filename" => { "perl" => '1' },
	"pima_options" => { "perl" => '1' },
	"score_cutoff" => { "perl" => '1' },
	"ext_gap_cost" => { "perl" => '1' },
	"gap_open_cost" => { "perl" => '1' },
	"min_score" => { "perl" => '1' },
	"mat_file" => { "perl" => '1' },
	"not_num_ext" => { "perl" => '1' },
	"sec_struc_gap_cost" => { "perl" => '1' },
	"results" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

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
	"pima" => 0,
	"sequence" => 0,
	"cluster_name" => 0,
	"pima_params" => 0,
	"ref_seq_name" => 0,
	"sec_struc_seq_filename" => 0,
	"pima_options" => 0,
	"score_cutoff" => 0,
	"ext_gap_cost" => 0,
	"gap_open_cost" => 0,
	"min_score" => 0,
	"mat_file" => 0,
	"not_num_ext" => 0,
	"sec_struc_gap_cost" => 0,
	"results" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pima" => 1,
	"sequence" => 1,
	"cluster_name" => 1,
	"pima_params" => 0,
	"ref_seq_name" => 0,
	"sec_struc_seq_filename" => 0,
	"pima_options" => 0,
	"score_cutoff" => 0,
	"ext_gap_cost" => 0,
	"gap_open_cost" => 0,
	"min_score" => 0,
	"mat_file" => 0,
	"not_num_ext" => 0,
	"sec_struc_gap_cost" => 0,
	"results" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"sequence" => [
		" Name of the input file containing the sequences to be clustered and multi-aligned.  Sequences can be in any of the following formats: IG/Stanford, GenBank/GB, NBRF, EMBL, Pearson/Fasta, PIR/CODATA, Table (LOCUS_NAME SEQUENCE [one seq/line]).  LOCUS_NAMES can not contain left or right parentheses.  The format of the output sequence files will match the format of this input file. ",
	],
	"cluster_name" => [
		"An arbitrary name used to label the cluster.",
	],
	"ref_seq_name" => [
		"[optional; if specified, then sec_struct_seq_filename must also be specified]. Locus name of one of the primary sequences for which the secondary structure is in the file seq_struct_seq_filename.",
	],
	"sec_struc_seq_filename" => [
		"[optional; if specified, then ref_seq_name must also be specified] Name of a file containing secondary structure sequences for one ormore of the primary sequences in the set.  The secondary structure sequences in this file must be in one of the formats listed above (see sequence_filename, above).  The locus name of each sequence must be the locus name of it\'s corresponding primary sequence with the suffix \'.ss\' (e.g. 1ldm.ss). An alpha-helix, 3-10 helix and beta-strand must be designated \'h\', \'g\', and \'e\', repectively.  All other characters in the secondary structure sequences will be ignored with respect to the the structure-dependent gap penalty.  To allow gaps to be placed between the first and the second and the last elements of these structures, the first and last 2 elements of each should be changed to another character designation.  In the secondary structure sequence file pdb-dssp.ss provided with this package, these end cap elements are designated \'i\', \'f\', and \'d\', for alpha-helices, 3-10 helices and beta-strands, respectfully.		",
	],
	"score_cutoff" => [
		"  Use a cluster score cutoff of number. This is the lowest match score to be used to incorporate a sequence into a cluster.  The default value of 0.0 will force all input sequences into 1 cluster, but the final pattern may be com-pletely degenerate.",
	],
	"ext_gap_cost" => [
		"Use a length dependent gap penalty of number. This is the cost of extending a gap.  The default value is dependent on the matrix file used.",
	],
	"gap_open_cost" => [
		"  Use a length independent gap penalty of number. This is the cost of opening a gap.  The default value is dependent on the matrix file used.",
	],
	"min_score" => [
		" Use minimum local score of number. This is the lowest score a quadrant can have before an attempt is made to join this local alignment with the local alignment at the previous step.  The default value is dependent on the matrix file used.",
	],
	"mat_file" => [
		"  Use matrix file with the name file. The default matrix fil is patgen.mat and is provided with this package.  The matrix file class1.mat uses the original pima alphabet.  The matrix file class2.mat is also provided, which is similar to the matrix file class1.mat but uses the new alphabet.",
	],
	"sec_struc_gap_cost" => [
		"Use a secondary structure gap penalty of number. This is the cost of a gap at a position matching a secondary structure character.  The default value is dependent on the matrix file used and is always 10 times the value of the length independent gap penalty of the matrix file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pima.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

