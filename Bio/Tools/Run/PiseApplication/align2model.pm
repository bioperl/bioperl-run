
=head1 NAME

Bio::Tools::Run::PiseApplication::align2model

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::align2model

      Bioperl class for:

	SAM	align2model - create a multiple alignment of sequences to an existing model (R. Hughey, A. Krogh)

	References:

		R. Hughey and A. Krogh., SAM: Sequence alignment and modeling software system. Technical Report UCSC-CRL-96-22, University of California, Santa Cruz, CA, September 1996. 


      Parameters:


		align2model (String)
			

		run (String)
			Run name

		db (Sequence)
			Sequences to align (-db)

		model_file (InFile)
			Model (-i)
			pipe: sam_model

		a2m (Results)
			
			pipe: readseq_ok_alig

		input (Paragraph)
			Input options

		id (String)
			Sequence identifier(s) selection (separated by commas) (-id)

		nscoreseq (Integer)
			Maximum number of sequences to be read (-nscoreseq)

		control (Paragraph)
			Control options

		adpstyle (Excl)
			Dynamic programming style (-adpstyle

		SW (Excl)
			Sequence scoring (-SW)

		auto_fim (Switch)
			Add FIMs automatically (-auto_fim)

		jump_in_prob (Float)
			Probability cost of jumping into the center of the model (-jump_in_prob)

		jump_out_prob (Float)
			Probability cost of jumping out the center of the model (-jump_out_prob)

		output (Paragraph)
			Output options

		a2mdots (Switch)
			Print dots to fill space need for other sequences' insertions (-a2mdots)

		dump_parameters (Excl)
			(-dump_parameters)

=cut

#'
package Bio::Tools::Run::PiseApplication::align2model;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $align2model = Bio::Tools::Run::PiseApplication::align2model->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::align2model object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $align2model = $factory->program('align2model');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::align2model.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/align2model.pm

    $self->{COMMAND}   = "align2model";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "align2model - create a multiple alignment of sequences to an existing model";

    $self->{AUTHORS}   = "R. Hughey, A. Krogh";

    $self->{DOCLINK}   = "http://www.cse.ucsc.edu/research/compbio/ismb99.tutorial.htmlhttp://www.cse.ucsc.edu/research/compbio/sam.html";

    $self->{REFERENCE}   = [

         "R. Hughey and A. Krogh., SAM: Sequence alignment and modeling software system. Technical Report UCSC-CRL-96-22, University of California, Santa Cruz, CA, September 1996. ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"align2model",
	"run",
	"db",
	"model_file",
	"a2m",
	"input",
	"control",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"align2model",
	"run", 	# Run name
	"db", 	# Sequences to align (-db)
	"model_file", 	# Model (-i)
	"a2m",
	"input", 	# Input options
	"id", 	# Sequence identifier(s) selection (separated by commas) (-id)
	"nscoreseq", 	# Maximum number of sequences to be read (-nscoreseq)
	"control", 	# Control options
	"adpstyle", 	# Dynamic programming style (-adpstyle
	"SW", 	# Sequence scoring (-SW)
	"auto_fim", 	# Add FIMs automatically (-auto_fim)
	"jump_in_prob", 	# Probability cost of jumping into the center of the model (-jump_in_prob)
	"jump_out_prob", 	# Probability cost of jumping out the center of the model (-jump_out_prob)
	"output", 	# Output options
	"a2mdots", 	# Print dots to fill space need for other sequences' insertions (-a2mdots)
	"dump_parameters", 	# (-dump_parameters)

    ];

    $self->{TYPE}  = {
	"align2model" => 'String',
	"run" => 'String',
	"db" => 'Sequence',
	"model_file" => 'InFile',
	"a2m" => 'Results',
	"input" => 'Paragraph',
	"id" => 'String',
	"nscoreseq" => 'Integer',
	"control" => 'Paragraph',
	"adpstyle" => 'Excl',
	"SW" => 'Excl',
	"auto_fim" => 'Switch',
	"jump_in_prob" => 'Float',
	"jump_out_prob" => 'Float',
	"output" => 'Paragraph',
	"a2mdots" => 'Switch',
	"dump_parameters" => 'Excl',

    };

    $self->{FORMAT}  = {
	"align2model" => {
		"seqlab" => 'align2model',
		"perl" => '"align2model"',
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
	"a2m" => {
	},
	"input" => {
	},
	"id" => {
		"perl" => '($value && ($value !~ /,/ || $value =~ s/,/ -id /g) ) ? " -id $value " : "" ',
	},
	"nscoreseq" => {
		"perl" => ' (defined $value && $value != $vdef)? " -nscoreseq $value" : "" ',
	},
	"control" => {
	},
	"adpstyle" => {
		"perl" => '($value != $vdef) ? " -adpstyle $value" : ""',
	},
	"SW" => {
		"perl" => ' ($value)? " -SW $value":""',
	},
	"auto_fim" => {
		"perl" => '($value) ? "" : " -auto_fim 1"',
	},
	"jump_in_prob" => {
		"perl" => '(defined $value && $value != $vdef) ? " -jump_in_prob $value" : ""',
	},
	"jump_out_prob" => {
		"perl" => '(defined $value && $value != $vdef) ? " -jump_out_prob $value" : ""',
	},
	"output" => {
	},
	"a2mdots" => {
		"perl" => ' ($value) ? "" : " -a2mdots 0"',
	},
	"dump_parameters" => {
		"perl" => ' ($value && $value ne $vdef)? " -dump_parameters $value":""',
	},

    };

    $self->{FILENAMES}  = {
	"a2m" => '*.a2m',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"align2model" => 0,
	"run" => 1,
	"db" => 2,
	"model_file" => 2,
	"input" => 2,
	"id" => 2,
	"nscoreseq" => 2,
	"control" => 3,
	"adpstyle" => 3,
	"SW" => 3,
	"auto_fim" => 3,
	"jump_in_prob" => 3,
	"jump_out_prob" => 3,
	"output" => 4,
	"a2mdots" => 4,
	"dump_parameters" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"align2model",
	"a2m",
	"run",
	"db",
	"model_file",
	"input",
	"id",
	"nscoreseq",
	"control",
	"adpstyle",
	"SW",
	"auto_fim",
	"jump_in_prob",
	"jump_out_prob",
	"output",
	"a2mdots",
	"dump_parameters",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"align2model" => 1,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"a2m" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"control" => 0,
	"adpstyle" => 0,
	"SW" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"output" => 0,
	"a2mdots" => 0,
	"dump_parameters" => 0,

    };

    $self->{ISCOMMAND}  = {
	"align2model" => 1,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"a2m" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"control" => 0,
	"adpstyle" => 0,
	"SW" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"output" => 0,
	"a2mdots" => 0,
	"dump_parameters" => 0,

    };

    $self->{ISMANDATORY}  = {
	"align2model" => 0,
	"run" => 1,
	"db" => 1,
	"model_file" => 1,
	"a2m" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"control" => 0,
	"adpstyle" => 0,
	"SW" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"output" => 0,
	"a2mdots" => 0,
	"dump_parameters" => 0,

    };

    $self->{PROMPT}  = {
	"align2model" => "",
	"run" => "Run name",
	"db" => "Sequences to align (-db)",
	"model_file" => "Model (-i)",
	"a2m" => "",
	"input" => "Input options",
	"id" => "Sequence identifier(s) selection (separated by commas) (-id)",
	"nscoreseq" => "Maximum number of sequences to be read (-nscoreseq)",
	"control" => "Control options",
	"adpstyle" => "Dynamic programming style (-adpstyle",
	"SW" => "Sequence scoring (-SW)",
	"auto_fim" => "Add FIMs automatically (-auto_fim)",
	"jump_in_prob" => "Probability cost of jumping into the center of the model (-jump_in_prob)",
	"jump_out_prob" => "Probability cost of jumping out the center of the model (-jump_out_prob)",
	"output" => "Output options",
	"a2mdots" => "Print dots to fill space need for other sequences' insertions (-a2mdots)",
	"dump_parameters" => "(-dump_parameters)",

    };

    $self->{ISSTANDOUT}  = {
	"align2model" => 0,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"a2m" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"control" => 0,
	"adpstyle" => 0,
	"SW" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"output" => 0,
	"a2mdots" => 0,
	"dump_parameters" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['id','nscoreseq',],
	"control" => ['adpstyle','SW','auto_fim','jump_in_prob','jump_out_prob',],
	"adpstyle" => ['1','1: Viterbi','4','4: posterior_decoded alignment on transitions and character emissions','5','5: posterior_decoded alignment on only character emissions',],
	"SW" => ['0','0: Global','1','1: semi-local (fragments)','2','2: local (fragments)','3','3: domains',],
	"output" => ['a2mdots','dump_parameters',],
	"dump_parameters" => ['0','0: only modified parameters are printed','1','1: all parameters are printed','2','2: print dump parameters and exit',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"run" => 'test',
	"nscoreseq" => '100000',
	"adpstyle" => '1',
	"SW" => '0',
	"auto_fim" => '1',
	"jump_in_prob" => '1.0',
	"jump_out_prob" => '1.0',
	"a2mdots" => '1',
	"dump_parameters" => '0',

    };

    $self->{PRECOND}  = {
	"align2model" => { "perl" => '1' },
	"run" => { "perl" => '1' },
	"db" => { "perl" => '1' },
	"model_file" => { "perl" => '1' },
	"a2m" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"id" => { "perl" => '1' },
	"nscoreseq" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"adpstyle" => { "perl" => '1' },
	"SW" => {
		"perl" => '$adpstyle != 1',
	},
	"auto_fim" => { "perl" => '1' },
	"jump_in_prob" => {
		"perl" => '$SW',
	},
	"jump_out_prob" => {
		"perl" => '$SW',
	},
	"output" => { "perl" => '1' },
	"a2mdots" => { "perl" => '1' },
	"dump_parameters" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"a2m" => {
		 '1' => "readseq_ok_alig",
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
	"align2model" => 0,
	"run" => 0,
	"db" => 0,
	"model_file" => 0,
	"a2m" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"control" => 0,
	"adpstyle" => 0,
	"SW" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"output" => 0,
	"a2mdots" => 0,
	"dump_parameters" => 0,

    };

    $self->{ISSIMPLE}  = {
	"align2model" => 1,
	"run" => 0,
	"db" => 1,
	"model_file" => 1,
	"a2m" => 0,
	"input" => 0,
	"id" => 0,
	"nscoreseq" => 0,
	"control" => 0,
	"adpstyle" => 0,
	"SW" => 0,
	"auto_fim" => 0,
	"jump_in_prob" => 0,
	"jump_out_prob" => 0,
	"output" => 0,
	"a2mdots" => 0,
	"dump_parameters" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"adpstyle" => [
		"Alignment methods 4 and 5 are much slower and memory consuming than standard Viterbi alignment.",
	],
	"SW" => [
		". 1: start matching the model at any location (rather than only the begin node) and end at any location (rather than only the end node). This will improve alignment for short sequences that match a segment of the model.",
		". 2: this is similar to Smith and Waterman method of sequence comparison, which will find the best alignment for any pair of subsequences within two sequences. When this is done, sequences can jump from the initial module into the match state of any module in the model, and can also jump out of the match state of any module within the model to the delete state of the next-to-last node. The first and next-to-last module are assumed to be FIMs, hence the rational is that a sequence will use the FIM for some period of time to consume characters that do not match the model, then the sequence will jump to the model node corresponding to the start of the fragment, use several model nodes, and then jump to the ending FIM to consume the rest of the sequence. ",
		" 3: use for domains. It matchs part of a model to all of a sequence.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/align2model.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

