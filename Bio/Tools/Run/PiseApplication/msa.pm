
=head1 NAME

Bio::Tools::Run::PiseApplication::msa

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::msa

      Bioperl class for:

	MSA	multiple sequence alignment (S. F. Altschul)

      Parameters:


		msa (String)


		seqs (Sequence)
			Sequences File

		control (Paragraph)
			Control parameters

		optimal (Switch)
			Turns off the optimal multiple alignment

		forcedres (InFile)
			forced aligned residues file (see the documentation)

		Cost (Paragraph)
			Cost parameters

		endgap (Switch)
			charges terminal gaps the same as internal gaps

		unweight (Switch)
			cost = unweighted sum

		maxscore (Integer)
			maximum score of an optimal multiple alignment

		epsilons (InFile)
			Epsilons file (see the documentation)

		costs (InFile)
			Costs file (see the documentation)

		output (Paragraph)
			Output parameters

		quiet (Switch)
			suppress verbose output

=cut

#'
package Bio::Tools::Run::PiseApplication::msa;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $msa = Bio::Tools::Run::PiseApplication::msa->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::msa object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $msa = $factory->program('msa');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::msa.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/msa.pm

    $self->{COMMAND}   = "msa";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MSA";

    $self->{DESCRIPTION}   = "multiple sequence alignment";

    $self->{AUTHORS}   = "S. F. Altschul";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"msa",
	"seqs",
	"control",
	"Cost",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"msa",
	"seqs", 	# Sequences File
	"control", 	# Control parameters
	"optimal", 	# Turns off the optimal multiple alignment
	"forcedres", 	# forced aligned residues file (see the documentation)
	"Cost", 	# Cost parameters
	"endgap", 	# charges terminal gaps the same as internal gaps
	"unweight", 	# cost = unweighted sum
	"maxscore", 	# maximum score of an optimal multiple alignment
	"epsilons", 	# Epsilons file (see the documentation)
	"costs", 	# Costs file (see the documentation)
	"output", 	# Output parameters
	"quiet", 	# suppress verbose output

    ];

    $self->{TYPE}  = {
	"msa" => 'String',
	"seqs" => 'Sequence',
	"control" => 'Paragraph',
	"optimal" => 'Switch',
	"forcedres" => 'InFile',
	"Cost" => 'Paragraph',
	"endgap" => 'Switch',
	"unweight" => 'Switch',
	"maxscore" => 'Integer',
	"epsilons" => 'InFile',
	"costs" => 'InFile',
	"output" => 'Paragraph',
	"quiet" => 'Switch',

    };

    $self->{FORMAT}  = {
	"msa" => {
		"perl" => '"msa"',
	},
	"seqs" => {
		"perl" => '" $value"',
	},
	"control" => {
	},
	"optimal" => {
		"perl" => '($value)? " -m":""',
	},
	"forcedres" => {
		"perl" => '($value)? " -f $value" : "" ',
	},
	"Cost" => {
	},
	"endgap" => {
		"perl" => ' ($value)? " -g":""',
	},
	"unweight" => {
		"perl" => ' ($value)? " -b":""',
	},
	"maxscore" => {
		"perl" => ' (defined $value)? " -d$value" : ""',
	},
	"epsilons" => {
		"perl" => '($value)? " -e $value" : "" ',
	},
	"costs" => {
		"perl" => '($value)? " -c $value" : "" ',
	},
	"output" => {
	},
	"quiet" => {
		"perl" => '($value)? " -o":""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqs" => [8],

    };

    $self->{GROUP}  = {
	"msa" => 0,
	"seqs" => 2,
	"optimal" => 1,
	"forcedres" => 1,
	"endgap" => 1,
	"unweight" => 1,
	"maxscore" => 1,
	"epsilons" => 1,
	"costs" => 1,
	"quiet" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"msa",
	"output",
	"control",
	"Cost",
	"optimal",
	"forcedres",
	"endgap",
	"unweight",
	"maxscore",
	"epsilons",
	"costs",
	"quiet",
	"seqs",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"msa" => 1,
	"seqs" => 0,
	"control" => 0,
	"optimal" => 0,
	"forcedres" => 0,
	"Cost" => 0,
	"endgap" => 0,
	"unweight" => 0,
	"maxscore" => 0,
	"epsilons" => 0,
	"costs" => 0,
	"output" => 0,
	"quiet" => 0,

    };

    $self->{ISCOMMAND}  = {
	"msa" => 1,
	"seqs" => 0,
	"control" => 0,
	"optimal" => 0,
	"forcedres" => 0,
	"Cost" => 0,
	"endgap" => 0,
	"unweight" => 0,
	"maxscore" => 0,
	"epsilons" => 0,
	"costs" => 0,
	"output" => 0,
	"quiet" => 0,

    };

    $self->{ISMANDATORY}  = {
	"msa" => 0,
	"seqs" => 1,
	"control" => 0,
	"optimal" => 0,
	"forcedres" => 0,
	"Cost" => 0,
	"endgap" => 0,
	"unweight" => 0,
	"maxscore" => 0,
	"epsilons" => 0,
	"costs" => 0,
	"output" => 0,
	"quiet" => 0,

    };

    $self->{PROMPT}  = {
	"msa" => "",
	"seqs" => "Sequences File",
	"control" => "Control parameters",
	"optimal" => "Turns off the optimal multiple alignment",
	"forcedres" => "forced aligned residues file (see the documentation)",
	"Cost" => "Cost parameters",
	"endgap" => "charges terminal gaps the same as internal gaps",
	"unweight" => "cost = unweighted sum",
	"maxscore" => "maximum score of an optimal multiple alignment",
	"epsilons" => "Epsilons file (see the documentation)",
	"costs" => "Costs file (see the documentation)",
	"output" => "Output parameters",
	"quiet" => "suppress verbose output",

    };

    $self->{ISSTANDOUT}  = {
	"msa" => 0,
	"seqs" => 0,
	"control" => 0,
	"optimal" => 0,
	"forcedres" => 0,
	"Cost" => 0,
	"endgap" => 0,
	"unweight" => 0,
	"maxscore" => 0,
	"epsilons" => 0,
	"costs" => 0,
	"output" => 0,
	"quiet" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['optimal','forcedres',],
	"Cost" => ['endgap','unweight','maxscore','epsilons','costs',],
	"output" => ['quiet',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"optimal" => '0',
	"endgap" => '0',
	"unweight" => '0',

    };

    $self->{PRECOND}  = {
	"msa" => { "perl" => '1' },
	"seqs" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"optimal" => { "perl" => '1' },
	"forcedres" => { "perl" => '1' },
	"Cost" => { "perl" => '1' },
	"endgap" => { "perl" => '1' },
	"unweight" => { "perl" => '1' },
	"maxscore" => { "perl" => '1' },
	"epsilons" => { "perl" => '1' },
	"costs" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"quiet" => { "perl" => '1' },

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
	"msa" => 0,
	"seqs" => 0,
	"control" => 0,
	"optimal" => 0,
	"forcedres" => 0,
	"Cost" => 0,
	"endgap" => 0,
	"unweight" => 0,
	"maxscore" => 0,
	"epsilons" => 0,
	"costs" => 0,
	"output" => 0,
	"quiet" => 0,

    };

    $self->{ISSIMPLE}  = {
	"msa" => 1,
	"seqs" => 1,
	"control" => 0,
	"optimal" => 0,
	"forcedres" => 0,
	"Cost" => 0,
	"endgap" => 0,
	"unweight" => 0,
	"maxscore" => 0,
	"epsilons" => 0,
	"costs" => 0,
	"output" => 0,
	"quiet" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/msa.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

