
=head1 NAME

Bio::Tools::Run::PiseApplication::modelfromalign

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::modelfromalign

      Bioperl class for:

	SAM	modelfromalign - use an existing multiple alignment to create an initial model (R. Hughey, A. Krogh)

      Parameters:


		modelfromalign (String)
			

		run (String)
			Run name

		alignfile (Sequence)
			Aligned sequences (-alignfile)

		sam_model_file (Results)
			
			pipe: sam_model

		input (Paragraph)
			Input options

		alignment_weights (InFile)
			Sequence weights for alignments used to form initial models (-alignment_weights)

		control (Paragraph)
			Control options

		align_fim (Switch)
			Add FIMs to the ends of the initial model (-align_fim)

		regul (Paragraph)
			Regularizers and mixtures parameters

		regularizerfile (Excl)
			Regularizer (-regularizerfile)

		reglength (Integer)
			Length of the regularizer (-reglength)

		priorlibrary (Excl)
			Dirichlet mixture prior (-priorlibrary)

		prior_weight (Float)
			Weight of the prior library (-prior_weight)

		del_jump_conf (Float)
			Confidence in the regularizer for transitions leaving a delete state. The regularizer's transition values are multiplied by this number (-del_jump_conf)

		ins_jump_conf (Float)
			Confidence in the regularizer for transitions leaving an insert state (-ins_jump_conf)

		insconf (Float)
			Confidence in the regularizer for character probabilities in an insert state (-insconf)

		match_jump_conf (Float)
			Confidence in the regularizer for transitions leaving a match state (-match_jump_conf)

		matchconf (Float)
			Confidence in the regularizer for character probabilities in a match state (-matchconf)

		mainline_cutoff (Float)
			Confidence in the regularizer for transitions leaving a match state (-mainline_cutoff)

		output (Paragraph)
			Output options

		binary_output (Switch)
			Write models in binary format (-binary_output)

=cut

#'
package Bio::Tools::Run::PiseApplication::modelfromalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $modelfromalign = Bio::Tools::Run::PiseApplication::modelfromalign->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::modelfromalign object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $modelfromalign = $factory->program('modelfromalign');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::modelfromalign.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/modelfromalign.pm

    $self->{COMMAND}   = "modelfromalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "modelfromalign - use an existing multiple alignment to create an initial model";

    $self->{AUTHORS}   = "R. Hughey, A. Krogh";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"modelfromalign",
	"run",
	"alignfile",
	"sam_model_file",
	"input",
	"control",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"modelfromalign",
	"run", 	# Run name
	"alignfile", 	# Aligned sequences (-alignfile)
	"sam_model_file",
	"input", 	# Input options
	"alignment_weights", 	# Sequence weights for alignments used to form initial models (-alignment_weights)
	"control", 	# Control options
	"align_fim", 	# Add FIMs to the ends of the initial model (-align_fim)
	"regul", 	# Regularizers and mixtures parameters
	"regularizerfile", 	# Regularizer (-regularizerfile)
	"reglength", 	# Length of the regularizer (-reglength)
	"priorlibrary", 	# Dirichlet mixture prior (-priorlibrary)
	"prior_weight", 	# Weight of the prior library (-prior_weight)
	"del_jump_conf", 	# Confidence in the regularizer for transitions leaving a delete state. The regularizer's transition values are multiplied by this number (-del_jump_conf)
	"ins_jump_conf", 	# Confidence in the regularizer for transitions leaving an insert state (-ins_jump_conf)
	"insconf", 	# Confidence in the regularizer for character probabilities in an insert state (-insconf)
	"match_jump_conf", 	# Confidence in the regularizer for transitions leaving a match state (-match_jump_conf)
	"matchconf", 	# Confidence in the regularizer for character probabilities in a match state (-matchconf)
	"mainline_cutoff", 	# Confidence in the regularizer for transitions leaving a match state (-mainline_cutoff)
	"output", 	# Output options
	"binary_output", 	# Write models in binary format (-binary_output)

    ];

    $self->{TYPE}  = {
	"modelfromalign" => 'String',
	"run" => 'String',
	"alignfile" => 'Sequence',
	"sam_model_file" => 'Results',
	"input" => 'Paragraph',
	"alignment_weights" => 'InFile',
	"control" => 'Paragraph',
	"align_fim" => 'Switch',
	"regul" => 'Paragraph',
	"regularizerfile" => 'Excl',
	"reglength" => 'Integer',
	"priorlibrary" => 'Excl',
	"prior_weight" => 'Float',
	"del_jump_conf" => 'Float',
	"ins_jump_conf" => 'Float',
	"insconf" => 'Float',
	"match_jump_conf" => 'Float',
	"matchconf" => 'Float',
	"mainline_cutoff" => 'Float',
	"output" => 'Paragraph',
	"binary_output" => 'Switch',

    };

    $self->{FORMAT}  = {
	"modelfromalign" => {
		"seqlab" => 'modelfromalign',
		"perl" => '"modelfromalign"',
	},
	"run" => {
		"perl" => '" $value"',
	},
	"alignfile" => {
		"perl" => '" -alignfile $value"',
	},
	"sam_model_file" => {
	},
	"input" => {
	},
	"alignment_weights" => {
		"perl" => ' ($value)? " -alignment_weights $value" : ""',
	},
	"control" => {
	},
	"align_fim" => {
		"perl" => ' ($value)? " -align_fim 1":""',
	},
	"regul" => {
	},
	"regularizerfile" => {
		"perl" => ' ($value)? " -regularizerfile /local/gensoft/lib/sam/$value":""',
	},
	"reglength" => {
		"perl" => ' ($value)? " -reglength $value" : "" ',
	},
	"priorlibrary" => {
		"perl" => '($value && $value ne $vdef)? " -priorlibrary /local/gensoft/lib/sam/$value":""',
	},
	"prior_weight" => {
		"perl" => ' ($value && $value != $vdef)? " -prior_weight $value" : "" ',
	},
	"del_jump_conf" => {
		"perl" => ' ($value && $value != $vdef)? " -del_jump_conf $value" : "" ',
	},
	"ins_jump_conf" => {
		"perl" => ' ($value && $value != $vdef)? " -ins_jump_conf $value" : "" ',
	},
	"insconf" => {
		"perl" => ' ($value && $value != $vdef)? " -insconf $value" : "" ',
	},
	"match_jump_conf" => {
		"perl" => ' ($value && $value != $vdef)? " -match_jump_conf $value" : "" ',
	},
	"matchconf" => {
		"perl" => ' ($value && $value != $vdef)? " -matchconf $value" : "" ',
	},
	"mainline_cutoff" => {
		"perl" => ' ($value && $value != $vdef)? " -mainline_cutoff $value" : "" ',
	},
	"output" => {
	},
	"binary_output" => {
		"perl" => ' ($value)? " -binary_output 1":""',
	},

    };

    $self->{FILENAMES}  = {
	"sam_model_file" => '$run.mod',

    };

    $self->{SEQFMT}  = {
	"alignfile" => [8],

    };

    $self->{GROUP}  = {
	"modelfromalign" => 0,
	"run" => 1,
	"alignfile" => 2,
	"input" => 2,
	"alignment_weights" => 2,
	"control" => 2,
	"align_fim" => 2,
	"regul" => 2,
	"regularizerfile" => 2,
	"reglength" => 2,
	"priorlibrary" => 2,
	"prior_weight" => 2,
	"del_jump_conf" => 2,
	"ins_jump_conf" => 2,
	"insconf" => 2,
	"match_jump_conf" => 2,
	"matchconf" => 2,
	"mainline_cutoff" => 2,
	"output" => 2,
	"binary_output" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"modelfromalign",
	"sam_model_file",
	"run",
	"alignfile",
	"input",
	"alignment_weights",
	"control",
	"align_fim",
	"regul",
	"regularizerfile",
	"reglength",
	"priorlibrary",
	"prior_weight",
	"del_jump_conf",
	"ins_jump_conf",
	"insconf",
	"match_jump_conf",
	"matchconf",
	"mainline_cutoff",
	"output",
	"binary_output",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"modelfromalign" => 1,
	"run" => 0,
	"alignfile" => 0,
	"sam_model_file" => 0,
	"input" => 0,
	"alignment_weights" => 0,
	"control" => 0,
	"align_fim" => 0,
	"regul" => 0,
	"regularizerfile" => 0,
	"reglength" => 0,
	"priorlibrary" => 0,
	"prior_weight" => 0,
	"del_jump_conf" => 0,
	"ins_jump_conf" => 0,
	"insconf" => 0,
	"match_jump_conf" => 0,
	"matchconf" => 0,
	"mainline_cutoff" => 0,
	"output" => 0,
	"binary_output" => 0,

    };

    $self->{ISCOMMAND}  = {
	"modelfromalign" => 1,
	"run" => 0,
	"alignfile" => 0,
	"sam_model_file" => 0,
	"input" => 0,
	"alignment_weights" => 0,
	"control" => 0,
	"align_fim" => 0,
	"regul" => 0,
	"regularizerfile" => 0,
	"reglength" => 0,
	"priorlibrary" => 0,
	"prior_weight" => 0,
	"del_jump_conf" => 0,
	"ins_jump_conf" => 0,
	"insconf" => 0,
	"match_jump_conf" => 0,
	"matchconf" => 0,
	"mainline_cutoff" => 0,
	"output" => 0,
	"binary_output" => 0,

    };

    $self->{ISMANDATORY}  = {
	"modelfromalign" => 0,
	"run" => 1,
	"alignfile" => 1,
	"sam_model_file" => 0,
	"input" => 0,
	"alignment_weights" => 0,
	"control" => 0,
	"align_fim" => 0,
	"regul" => 0,
	"regularizerfile" => 0,
	"reglength" => 0,
	"priorlibrary" => 0,
	"prior_weight" => 0,
	"del_jump_conf" => 0,
	"ins_jump_conf" => 0,
	"insconf" => 0,
	"match_jump_conf" => 0,
	"matchconf" => 0,
	"mainline_cutoff" => 0,
	"output" => 0,
	"binary_output" => 0,

    };

    $self->{PROMPT}  = {
	"modelfromalign" => "",
	"run" => "Run name",
	"alignfile" => "Aligned sequences (-alignfile)",
	"sam_model_file" => "",
	"input" => "Input options",
	"alignment_weights" => "Sequence weights for alignments used to form initial models (-alignment_weights)",
	"control" => "Control options",
	"align_fim" => "Add FIMs to the ends of the initial model (-align_fim)",
	"regul" => "Regularizers and mixtures parameters",
	"regularizerfile" => "Regularizer (-regularizerfile)",
	"reglength" => "Length of the regularizer (-reglength)",
	"priorlibrary" => "Dirichlet mixture prior (-priorlibrary)",
	"prior_weight" => "Weight of the prior library (-prior_weight)",
	"del_jump_conf" => "Confidence in the regularizer for transitions leaving a delete state. The regularizer's transition values are multiplied by this number (-del_jump_conf)",
	"ins_jump_conf" => "Confidence in the regularizer for transitions leaving an insert state (-ins_jump_conf)",
	"insconf" => "Confidence in the regularizer for character probabilities in an insert state (-insconf)",
	"match_jump_conf" => "Confidence in the regularizer for transitions leaving a match state (-match_jump_conf)",
	"matchconf" => "Confidence in the regularizer for character probabilities in a match state (-matchconf)",
	"mainline_cutoff" => "Confidence in the regularizer for transitions leaving a match state (-mainline_cutoff)",
	"output" => "Output options",
	"binary_output" => "Write models in binary format (-binary_output)",

    };

    $self->{ISSTANDOUT}  = {
	"modelfromalign" => 0,
	"run" => 0,
	"alignfile" => 0,
	"sam_model_file" => 0,
	"input" => 0,
	"alignment_weights" => 0,
	"control" => 0,
	"align_fim" => 0,
	"regul" => 0,
	"regularizerfile" => 0,
	"reglength" => 0,
	"priorlibrary" => 0,
	"prior_weight" => 0,
	"del_jump_conf" => 0,
	"ins_jump_conf" => 0,
	"insconf" => 0,
	"match_jump_conf" => 0,
	"matchconf" => 0,
	"mainline_cutoff" => 0,
	"output" => 0,
	"binary_output" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['alignment_weights',],
	"control" => ['align_fim','regul',],
	"regul" => ['regularizerfile','reglength','priorlibrary','prior_weight','del_jump_conf','ins_jump_conf','insconf','match_jump_conf','matchconf','mainline_cutoff',],
	"regularizerfile" => ['long_match.regularizer','long_match.regularizer','trained.regularizer','trained.regularizer','weak-gap.regularizer','weak-gap.regularizer','sam1.3.regularizer','sam1.3.regularizer',],
	"priorlibrary" => ['mall-opt.9comp','mall-opt.9comp','opt-weight1.9comp','opt-weight1.9comp','uprior.9comp','uprior.9comp','null.1comp','null.1comp','recode1.20comp','recode1.20comp',],
	"output" => ['binary_output',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"run" => 'test',
	"align_fim" => '0',
	"priorlibrary" => 'recode1.20comp',
	"prior_weight" => '1.0',
	"del_jump_conf" => '1.0',
	"ins_jump_conf" => '1.0',
	"insconf" => '10000',
	"match_jump_conf" => '1.0',
	"matchconf" => '1.0',
	"mainline_cutoff" => '0.5',
	"binary_output" => '0',

    };

    $self->{PRECOND}  = {
	"modelfromalign" => { "perl" => '1' },
	"run" => { "perl" => '1' },
	"alignfile" => { "perl" => '1' },
	"sam_model_file" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"alignment_weights" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"align_fim" => { "perl" => '1' },
	"regul" => { "perl" => '1' },
	"regularizerfile" => { "perl" => '1' },
	"reglength" => { "perl" => '1' },
	"priorlibrary" => { "perl" => '1' },
	"prior_weight" => {
		"perl" => '$priorlibrary',
	},
	"del_jump_conf" => { "perl" => '1' },
	"ins_jump_conf" => { "perl" => '1' },
	"insconf" => { "perl" => '1' },
	"match_jump_conf" => { "perl" => '1' },
	"matchconf" => { "perl" => '1' },
	"mainline_cutoff" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"binary_output" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"sam_model_file" => {
		 '1' => "sam_model",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"modelfromalign" => 0,
	"run" => 0,
	"alignfile" => 0,
	"sam_model_file" => 0,
	"input" => 0,
	"alignment_weights" => 0,
	"control" => 0,
	"align_fim" => 0,
	"regul" => 0,
	"regularizerfile" => 0,
	"reglength" => 0,
	"priorlibrary" => 0,
	"prior_weight" => 0,
	"del_jump_conf" => 0,
	"ins_jump_conf" => 0,
	"insconf" => 0,
	"match_jump_conf" => 0,
	"matchconf" => 0,
	"mainline_cutoff" => 0,
	"output" => 0,
	"binary_output" => 0,

    };

    $self->{ISSIMPLE}  = {
	"modelfromalign" => 1,
	"run" => 0,
	"alignfile" => 1,
	"sam_model_file" => 0,
	"input" => 0,
	"alignment_weights" => 0,
	"control" => 0,
	"align_fim" => 0,
	"regul" => 0,
	"regularizerfile" => 0,
	"reglength" => 0,
	"priorlibrary" => 0,
	"prior_weight" => 0,
	"del_jump_conf" => 0,
	"ins_jump_conf" => 0,
	"insconf" => 0,
	"match_jump_conf" => 0,
	"matchconf" => 0,
	"mainline_cutoff" => 0,
	"output" => 0,
	"binary_output" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"regularizerfile" => [
		"trained.regularizer: Regularizer optimized for unweighted transition counts on some set of re-estimated HSSP alignments ",
		"cheap_gap.regularizer: Makes gap opening and closing very cheap allowing exploration of many different alignments, but giving too high a cost to long matches",
		"long_match.regularizer: Assigns somewhat reasonable gap costs for unweighted data, useful for sweeping away \'chatter\' into big matches and big gaps, by making gap opening expensive but gap extension fairly cheap.",
	],
	"priorlibrary" => [
		"uprior9.plib: The 9-component library discussed in the aforementioned paper. Optimized for unweighted blocks data.",
		"mall-opt.9comp: Library re-optimized for unweighted data from an HSSP subset.",
		"opt-weight1.9comp: Library reoptimized for weighted version of same HSSP subset.",
		"recode1.20comp: A 20-component Dirichlet mixture trained on (realigned) HSSP alignments that have a diverse set of sequences. Intended for use in recoding inputs to neural net, but also useful as a standard regularizer.",
		"null.1comp: A one-component regularizer with tiny alpha, to get effectively no regularization.",
	],
	"insconf" => [
		"The high default means that the regularizer will overpower the actual counts determined by aligning sequences to the model. The regularizer\'s character insert values are multiplied by this number. ",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/modelfromalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

