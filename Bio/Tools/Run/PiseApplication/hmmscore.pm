
=head1 NAME

Bio::Tools::Run::PiseApplication::hmmscore

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmscore

      Bioperl class for:

	SAM	hmmscore - calculate NLL scores, smooth curves and Z-scores for sequences given a model (R. Hughey, A. Krogh)

	References:

		R. Hughey and A. Krogh., SAM: Sequence alignment and modeling software system. Technical Report UCSC-CRL-96-22, University of California, Santa Cruz, CA, September 1996. 


      Parameters:


		hmmscore (String)


		run (String)
			Run name

		db (Sequence)
			Sequences to score against model (-db)

		model_file (InFile)
			Model (-i)
			pipe: sam_model

		scorefile (Results)

			pipe: sam_score

		outfiles (Results)


		input (Paragraph)
			Input options

		id (String)
			Sequence identifier(s) selection (separated by commas) (-id)

		nscoreseq (Integer)
			Maximum number of sequences to be read (-nscoreseq)

		read_smooth (Switch)


		smooth_file (InFile)
			Read a smooth curve from this smooth_file (-smooth_file and -read_smooth)

		control (Paragraph)
			Control options

		adjust_score (Excl)
			Adjust score option (-adjust_score)

		auto_fim (Switch)
			Automatically add FIMs to the model before scoring when simple or complex null model subtraction is used (-auto_fim)

		jump_in_prob (Float)
			Probability cost of jumping into the center of the model (if SW set) (-jump_in_prob)

		jump_out_prob (Float)
			Probability cost of jumping out the center of the model (if SW set) (-jump_out_prob)

		SW (Excl)
			Sequence scoring (-SW)

		window_size (Integer)
			Window size for use in Z-score calculation (-window_size)

		Zmax (Float)
			Z-score beyond which points are considered outliers during curve fitting (-Zmax)

		subtract_null (Excl)
			Null model scoring (-subtract_null)

		selection (Paragraph)
			Selection options

		select_score (Excl)
			Selection criteria used for listing sequence scores in file runname.dist (-select_score)

		select_seq (Excl)
			Selection criteria used for placing sequences in the file runname.sel (-select_seq)

		NLLNull (Float)
			If select_score/seq=1, sequences with an NLL or NLLNull score smaller than this number are selected (-NLLNull)

		NLLperBase (Float)
			If select_score/seq=2, sequences with an NLL score per base smaller than this number are selected (-NLLperBase)

		NLLperNode (Float)
			If select_score/seq=3, sequences with an NLL score per model node smaller than this number are selected (-NLLperNode)

		NLLFile (InFile)
			File with already-calculated sequence distances (-NLLFile)

		output (Paragraph)
			Output options

		calc_smooth (Switch)
			Calculate a smooth curve and write it to smooth_file (-calc_smooth)

		sort (Excl)
			Sequence sorting (-sort)

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmscore;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmscore = Bio::Tools::Run::PiseApplication::hmmscore->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmscore object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $hmmscore = $factory->program('hmmscore');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmscore.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmscore.pm

    $self->{COMMAND}   = "hmmscore";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "hmmscore - calculate NLL scores, smooth curves and Z-scores for sequences given a model";

    $self->{AUTHORS}   = "R. Hughey, A. Krogh";

    $self->{DOCLINK}   = "http://www.cse.ucsc.edu/research/compbio/ismb99.tutorial.htmlhttp://www.cse.ucsc.edu/research/compbio/papers/nullmod/nullmod.html";

    $self->{REFERENCE}   = [

         "R. Hughey and A. Krogh., SAM: Sequence alignment and modeling software system. Technical Report UCSC-CRL-96-22, University of California, Santa Cruz, CA, September 1996. ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmscore",
	"run",
	"db",
	"model_file",
	"scorefile",
	"outfiles",
	"input",
	"control",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmscore",
	"run", 	# Run name
	"db", 	# Sequences to score against model (-db)
	"model_file", 	# Model (-i)
	"scorefile",
	"outfiles",
	"input", 	# Input options
	"id", 	# Sequence identifier(s) selection (separated by commas) (-id)
	"nscoreseq", 	# Maximum number of sequences to be read (-nscoreseq)
	"read_smooth",
	"smooth_file", 	# Read a smooth curve from this smooth_file (-smooth_file and -read_smooth)
	"control", 	# Control options
	"adjust_score", 	# Adjust score option (-adjust_score)
	"auto_fim", 	# Automatically add FIMs to the model before scoring when simple or complex null model subtraction is used (-auto_fim)
	"jump_in_prob", 	# Probability cost of jumping into the center of the model (if SW set) (-jump_in_prob)
	"jump_out_prob", 	# Probability cost of jumping out the center of the model (if SW set) (-jump_out_prob)
	"SW", 	# Sequence scoring (-SW)
	"window_size", 	# Window size for use in Z-score calculation (-window_size)
	"Zmax", 	# Z-score beyond which points are considered outliers during curve fitting (-Zmax)
	"subtract_null", 	# Null model scoring (-subtract_null)
	"selection", 	# Selection options
	"select_score", 	# Selection criteria used for listing sequence scores in file runname.dist (-select_score)
	"select_seq", 	# Selection criteria used for placing sequences in the file runname.sel (-select_seq)
	"NLLNull", 	# If select_score/seq=1, sequences with an NLL or NLLNull score smaller than this number are selected (-NLLNull)
	"NLLperBase", 	# If select_score/seq=2, sequences with an NLL score per base smaller than this number are selected (-NLLperBase)
	"NLLperNode", 	# If select_score/seq=3, sequences with an NLL score per model node smaller than this number are selected (-NLLperNode)
	"NLLFile", 	# File with already-calculated sequence distances (-NLLFile)
	"output", 	# Output options
	"calc_smooth", 	# Calculate a smooth curve and write it to smooth_file (-calc_smooth)
	"sort", 	# Sequence sorting (-sort)

    ];

    $self->{TYPE}  = {
	"hmmscore" => 'String',
	"run" => 'String',
	"db" => 'Sequence',
	"model_file" => 'InFile',
	"scorefile" => 'Results',
	"outfiles" => 'Results',
	"input" => 'Paragraph',
	"id" => 'String',
	"nscoreseq" => 'Integer',
	"read_smooth" => 'Switch',
	"smooth_file" => 'InFile',
	"control" => 'Paragraph',
	"adjust_score" => 'Excl',
	"auto_fim" => 'Switch',
	"jump_in_prob" => 'Float',
	"jump_out_prob" => 'Float',
	"SW" => 'Excl',
	"window_size" => 'Integer',
	"Zmax" => 'Float',
	"subtract_null" => 'Excl',
	"selection" => 'Paragraph',
	"select_score" => 'Excl',
	"select_seq" => 'Excl',
	"NLLNull" => 'Float',
	"NLLperBase" => 'Float',
	"NLLperNode" => 'Float',
	"NLLFile" => 'InFile',
	"output" => 'Paragraph',
	"calc_smooth" => 'Switch',
	"sort" => 'Excl',

    };

    $self->{FORMAT}  = {
	"hmmscore" => {
		"seqlab" => 'hmmscore',
		"perl" => '"hmmscore"',
	},
	"run" => {
		"perl" => '" $value"',
	},
	"db" => {
		"perl" => '" -db $value"',
	},
	"model_file" => {
		"perl" => ' ($value)? " -i $value" : ""',
	},
	"scorefile" => {
	},
	"outfiles" => {
	},
	"input" => {
	},
	"id" => {
		"perl" => '($value && ($value !~ /,/ || $value =~ s/,/ -id /g) )? " -id $value" : "" ',
	},
	"nscoreseq" => {
		"perl" => ' (defined $value && $value != $vdef)? " -nscoreseq $value" : "" ',
	},
	"read_smooth" => {
		"perl" => '" -read_smooth 1"',
	},
	"smooth_file" => {
		"perl" => ' ($value)? "mv $value $run.smooth; " : ""',
	},
	"control" => {
	},
	"adjust_score" => {
		"perl" => '($value && $value ne $vdef)? " -adjust_score $value" : "" ',
	},
	"auto_fim" => {
		"perl" => '(!$value)? " -auto_fim 0" : "" ',
	},
	"jump_in_prob" => {
		"perl" => ' ($value && $value != $vdef)? " -jump_in_prob $value" : "" ',
	},
	"jump_out_prob" => {
		"perl" => ' ($value && $value != $vdef)? " -jump_out_prob $value" : "" ',
	},
	"SW" => {
		"perl" => ' ($value)? " -SW $value":""',
	},
	"window_size" => {
		"perl" => ' (defined $value && $value != $vdef)? " -window_size $value" : "" ',
	},
	"Zmax" => {
		"perl" => ' (defined $value && $value != $vdef)? " -Zmax $value" : "" ',
	},
	"subtract_null" => {
		"perl" => ' ($value && $value ne $vdef)? " -subtract_null $value":""',
	},
	"selection" => {
	},
	"select_score" => {
		"perl" => ' ($value && $value ne $vdef)? " -select_score $value" : "" ',
	},
	"select_seq" => {
		"perl" => ' ($value && $value ne $vdef)? " -select_seq $value" : "" ',
	},
	"NLLNull" => {
		"perl" => ' (defined $value)? " -NLLNull $value" : "" ',
	},
	"NLLperBase" => {
		"perl" => ' (defined $value)? " -NLLperBase  $value" : "" ',
	},
	"NLLperNode" => {
		"perl" => ' (defined $value)? " -NLLperNode  $value" : "" ',
	},
	"NLLFile" => {
		"perl" => ' ($value)? " -NLLFile $value" : ""',
	},
	"output" => {
	},
	"calc_smooth" => {
		"perl" => '($value)? " -calc_smooth 1" : "" ',
	},
	"sort" => {
		"perl" => ' ($value && $value ne $vdef)? " -sort $value":""',
	},

    };

    $self->{FILENAMES}  = {
	"scorefile" => '*.dist',
	"outfiles" => '$run.smooth *.sel',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"hmmscore" => 0,
	"run" => 1,
	"db" => 2,
	"model_file" => 2,
	"input" => 2,
	"id" => 2,
	"nscoreseq" => 2,
	"read_smooth" => 2,
	"smooth_file" => -10,
	"control" => 3,
	"adjust_score" => 3,
	"auto_fim" => 3,
	"jump_in_prob" => 3,
	"jump_out_prob" => 3,
	"SW" => 3,
	"window_size" => 3,
	"Zmax" => 3,
	"subtract_null" => 2,
	"selection" => 2,
	"select_score" => 2,
	"select_seq" => 2,
	"NLLNull" => 2,
	"NLLperBase" => 2,
	"NLLperNode" => 2,
	"NLLFile" => 2,
	"output" => 2,
	"calc_smooth" => 2,
	"sort" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"smooth_file",
	"hmmscore",
	"outfiles",
	"scorefile",
	"run",
	"db",
	"model_file",
	"input",
	"id",
	"nscoreseq",
	"read_smooth",
	"subtract_null",
	"selection",
	"select_score",
	"select_seq",
	"NLLNull",
	"NLLperBase",
	"NLLperNode",
	"NLLFile",
	"output",
	"calc_smooth",
	"sort",
	"jump_in_prob",
	"jump_out_prob",
	"SW",
	"window_size",
	"Zmax",
	"control",
	"adjust_score",
	"auto_fim",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmscore" => 1,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"scorefile" => 0,
	"outfiles" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"read_smooth" => 1,
	"smooth_file" => 0,
	"control" => 0,
	"adjust_score" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"SW" => 0,
	"window_size" => 0,
	"Zmax" => 0,
	"subtract_null" => 0,
	"selection" => 0,
	"select_score" => 0,
	"select_seq" => 0,
	"NLLNull" => 0,
	"NLLperBase" => 0,
	"NLLperNode" => 0,
	"NLLFile" => 0,
	"output" => 0,
	"calc_smooth" => 0,
	"sort" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmscore" => 1,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"scorefile" => 0,
	"outfiles" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"read_smooth" => 0,
	"smooth_file" => 0,
	"control" => 0,
	"adjust_score" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"SW" => 0,
	"window_size" => 0,
	"Zmax" => 0,
	"subtract_null" => 0,
	"selection" => 0,
	"select_score" => 0,
	"select_seq" => 0,
	"NLLNull" => 0,
	"NLLperBase" => 0,
	"NLLperNode" => 0,
	"NLLFile" => 0,
	"output" => 0,
	"calc_smooth" => 0,
	"sort" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmscore" => 0,
	"run" => 1,
	"db" => 1,
	"model_file" => 1,
	"scorefile" => 0,
	"outfiles" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"read_smooth" => 0,
	"smooth_file" => 0,
	"control" => 0,
	"adjust_score" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"SW" => 0,
	"window_size" => 0,
	"Zmax" => 0,
	"subtract_null" => 0,
	"selection" => 0,
	"select_score" => 0,
	"select_seq" => 0,
	"NLLNull" => 0,
	"NLLperBase" => 0,
	"NLLperNode" => 0,
	"NLLFile" => 0,
	"output" => 0,
	"calc_smooth" => 0,
	"sort" => 0,

    };

    $self->{PROMPT}  = {
	"hmmscore" => "",
	"run" => "Run name",
	"db" => "Sequences to score against model (-db)",
	"model_file" => "Model (-i)",
	"scorefile" => "",
	"outfiles" => "",
	"input" => "Input options",
	"id" => "Sequence identifier(s) selection (separated by commas) (-id)",
	"nscoreseq" => "Maximum number of sequences to be read (-nscoreseq)",
	"read_smooth" => "",
	"smooth_file" => "Read a smooth curve from this smooth_file (-smooth_file and -read_smooth)",
	"control" => "Control options",
	"adjust_score" => "Adjust score option (-adjust_score)",
	"auto_fim" => "Automatically add FIMs to the model before scoring when simple or complex null model subtraction is used (-auto_fim)",
	"jump_in_prob" => "Probability cost of jumping into the center of the model (if SW set) (-jump_in_prob)",
	"jump_out_prob" => "Probability cost of jumping out the center of the model (if SW set) (-jump_out_prob)",
	"SW" => "Sequence scoring (-SW)",
	"window_size" => "Window size for use in Z-score calculation (-window_size)",
	"Zmax" => "Z-score beyond which points are considered outliers during curve fitting (-Zmax)",
	"subtract_null" => "Null model scoring (-subtract_null)",
	"selection" => "Selection options",
	"select_score" => "Selection criteria used for listing sequence scores in file runname.dist (-select_score)",
	"select_seq" => "Selection criteria used for placing sequences in the file runname.sel (-select_seq)",
	"NLLNull" => "If select_score/seq=1, sequences with an NLL or NLLNull score smaller than this number are selected (-NLLNull)",
	"NLLperBase" => "If select_score/seq=2, sequences with an NLL score per base smaller than this number are selected (-NLLperBase)",
	"NLLperNode" => "If select_score/seq=3, sequences with an NLL score per model node smaller than this number are selected (-NLLperNode)",
	"NLLFile" => "File with already-calculated sequence distances (-NLLFile)",
	"output" => "Output options",
	"calc_smooth" => "Calculate a smooth curve and write it to smooth_file (-calc_smooth)",
	"sort" => "Sequence sorting (-sort)",

    };

    $self->{ISSTANDOUT}  = {
	"hmmscore" => 0,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"scorefile" => 0,
	"outfiles" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"read_smooth" => 0,
	"smooth_file" => 0,
	"control" => 0,
	"adjust_score" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"SW" => 0,
	"window_size" => 0,
	"Zmax" => 0,
	"subtract_null" => 0,
	"selection" => 0,
	"select_score" => 0,
	"select_seq" => 0,
	"NLLNull" => 0,
	"NLLperBase" => 0,
	"NLLperNode" => 0,
	"NLLFile" => 0,
	"output" => 0,
	"calc_smooth" => 0,
	"sort" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['id','nscoreseq','read_smooth','smooth_file',],
	"control" => ['adjust_score','auto_fim','jump_in_prob','jump_out_prob','SW','window_size','Zmax','subtract_null','selection',],
	"adjust_score" => ['0','0: no adjustment','1','1: add to score the log of the sum of sequence and model length (if SW=2)','2','2: add to score the log of the sum of sequence length (if SW=1 or 2)',],
	"SW" => ['0','0: Global','1','1: semi-local','2','2: local',],
	"subtract_null" => ['0','0: the unadjusted NLL scores of the model will be reported','1','1: use a simple null model','2','2: a regularizer of the same length and form as the model is used as a complex null model','3','3: a user-specified model identified by the NULLMODEL keyword is used',],
	"selection" => ['select_score','select_seq','NLLNull','NLLperBase','NLLperNode','NLLFile',],
	"select_score" => ['0','0: all scores are placed in the file','1','1: sequences are selected according to their NLL scores and NLLNull','2','2: sequences are selected according to their per-base NLL scores and NLLperase','3','3: sequences are selected according to their per-model-node NLL scores and NLLperNode','4','4: sequences are selected according to their Z-scores and Zmax',],
	"select_seq" => ['0','0: no sequences are placed in the file','1','1: sequences are selected according to their NLL scores and NLLNull','2','2: sequences are selected according to their per-base NLL scores and NLLperBase','3','3: sequences are selected according to their per-model-node NLL scores and NLLperNode','4','4: sequences are selected according to their Z-scores and Zmax',],
	"output" => ['calc_smooth','sort',],
	"sort" => ['0','0: sequences and results are not sorted','1','1: sequences are sorted by Z-scores, if available, or by NLL-NULL score per base','2','2: sequences are sorted by their raw NLL score','3','3: sequences are sorted by NLL-NULL score per base',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"run" => 'test',
	"nscoreseq" => '100000',
	"adjust_score" => '2',
	"auto_fim" => '1',
	"jump_in_prob" => '1.0',
	"jump_out_prob" => '1.0',
	"SW" => '2',
	"window_size" => '1000',
	"Zmax" => '4.0',
	"subtract_null" => '1',
	"select_score" => '0',
	"select_seq" => '0',
	"calc_smooth" => '0',
	"sort" => '1',

    };

    $self->{PRECOND}  = {
	"hmmscore" => { "perl" => '1' },
	"run" => { "perl" => '1' },
	"db" => { "perl" => '1' },
	"model_file" => { "perl" => '1' },
	"scorefile" => { "perl" => '1' },
	"outfiles" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"id" => { "perl" => '1' },
	"nscoreseq" => { "perl" => '1' },
	"read_smooth" => {
		"perl" => '$smooth_file',
	},
	"smooth_file" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"adjust_score" => { "perl" => '1' },
	"auto_fim" => { "perl" => '1' },
	"jump_in_prob" => {
		"perl" => '$SW',
	},
	"jump_out_prob" => {
		"perl" => '$SW',
	},
	"SW" => { "perl" => '1' },
	"window_size" => { "perl" => '1' },
	"Zmax" => { "perl" => '1' },
	"subtract_null" => { "perl" => '1' },
	"selection" => { "perl" => '1' },
	"select_score" => { "perl" => '1' },
	"select_seq" => { "perl" => '1' },
	"NLLNull" => {
		"perl" => '$select_score == 1 || $select_seq == 1',
	},
	"NLLperBase" => {
		"perl" => '$select_score == 2 || $select_seq == 2',
	},
	"NLLperNode" => {
		"perl" => '$select_score == 3 || $select_seq == 3',
	},
	"NLLFile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"calc_smooth" => { "perl" => '1' },
	"sort" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"scorefile" => {
		 '1' => "sam_score",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"model_file" => {
		 "sam_model" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmscore" => 0,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"scorefile" => 0,
	"outfiles" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"read_smooth" => 0,
	"smooth_file" => 0,
	"control" => 0,
	"adjust_score" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"SW" => 0,
	"window_size" => 0,
	"Zmax" => 0,
	"subtract_null" => 0,
	"selection" => 0,
	"select_score" => 0,
	"select_seq" => 0,
	"NLLNull" => 0,
	"NLLperBase" => 0,
	"NLLperNode" => 0,
	"NLLFile" => 0,
	"output" => 0,
	"calc_smooth" => 0,
	"sort" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmscore" => 1,
	"run" => 0,
	"db" => 1,
	"model_file" => 1,
	"scorefile" => 0,
	"outfiles" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"read_smooth" => 0,
	"smooth_file" => 0,
	"control" => 0,
	"adjust_score" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"SW" => 0,
	"window_size" => 0,
	"Zmax" => 0,
	"subtract_null" => 0,
	"selection" => 0,
	"select_score" => 0,
	"select_seq" => 0,
	"NLLNull" => 0,
	"NLLperBase" => 0,
	"NLLperNode" => 0,
	"NLLFile" => 0,
	"output" => 0,
	"calc_smooth" => 0,
	"sort" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmscore.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

