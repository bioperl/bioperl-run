
=head1 NAME

Bio::Tools::Run::PiseApplication::comalign

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::comalign

      Bioperl class for:

	ComAlign	Combining many multiple alignments in one improved alignment (O. Caprani, K. Bucka-Lassen)

      Parameters:


		comalign (String)


		seq (Sequence)
			Sequences File (-f)
			pipe: seqsfile

		seed (Integer)
			Random seed number (-s)

		seqnb (Integer)
			Number of sequences that are to be aligned (-n)

		iterations (Integer)
			Number of iterations (-i)

		score (Integer)
			score: ComAlign records the time it took to  find a solution as good as this score (-l)

		time (Integer)
			ComAlign marks the best solution found after this number of 1/100 seconds (-t)

		last_iterations (Integer)
			Makes ComAlign terminate if the score hasn't changed within the last this number of iterations (-c)

		print_best (Switch)
			Print the best found alignment on termination (-a)

=cut

#'
package Bio::Tools::Run::PiseApplication::comalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $comalign = Bio::Tools::Run::PiseApplication::comalign->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::comalign object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $comalign = $factory->program('comalign');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::comalign.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/comalign.pm

    $self->{COMMAND}   = "comalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ComAlign";

    $self->{DESCRIPTION}   = "Combining many multiple alignments in one improved alignment";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{AUTHORS}   = "O. Caprani, K. Bucka-Lassen";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"comalign",
	"seq",
	"seed",
	"seqnb",
	"iterations",
	"score",
	"time",
	"last_iterations",
	"print_best",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"comalign",
	"seq", 	# Sequences File (-f)
	"seed", 	# Random seed number (-s)
	"seqnb", 	# Number of sequences that are to be aligned (-n)
	"iterations", 	# Number of iterations (-i)
	"score", 	# score: ComAlign records the time it took to  find a solution as good as this score (-l)
	"time", 	# ComAlign marks the best solution found after this number of 1/100 seconds (-t)
	"last_iterations", 	# Makes ComAlign terminate if the score hasn't changed within the last this number of iterations (-c)
	"print_best", 	# Print the best found alignment on termination (-a)

    ];

    $self->{TYPE}  = {
	"comalign" => 'String',
	"seq" => 'Sequence',
	"seed" => 'Integer',
	"seqnb" => 'Integer',
	"iterations" => 'Integer',
	"score" => 'Integer',
	"time" => 'Integer',
	"last_iterations" => 'Integer',
	"print_best" => 'Switch',

    };

    $self->{FORMAT}  = {
	"comalign" => {
		"perl" => '"ComAlign"',
	},
	"seq" => {
		"perl" => '" -f$value"',
	},
	"seed" => {
		"perl" => '(defined $value && $value != $vdef)? " -s$value" :""',
	},
	"seqnb" => {
		"perl" => '(defined $value && $value != $vdef)? " -n$value" :""',
	},
	"iterations" => {
		"perl" => '(defined $value && $value != $vdef)? " -i$value" :""',
	},
	"score" => {
		"perl" => '(defined $value)? " -l$value" :""',
	},
	"time" => {
		"perl" => '(defined $value)? " -t$value" :""',
	},
	"last_iterations" => {
		"perl" => '(defined $value && $value != $vdef)? " -c$value" :""',
	},
	"print_best" => {
		"perl" => '($value)? " -a" :""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [8],

    };

    $self->{GROUP}  = {
	"comalign" => 0,
	"seq" => 1,
	"seed" => 1,
	"seqnb" => 1,
	"iterations" => 1,
	"score" => 1,
	"time" => 1,
	"last_iterations" => 1,
	"print_best" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"comalign",
	"seq",
	"seed",
	"seqnb",
	"iterations",
	"score",
	"time",
	"last_iterations",
	"print_best",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"comalign" => 1,
	"seq" => 0,
	"seed" => 0,
	"seqnb" => 0,
	"iterations" => 0,
	"score" => 0,
	"time" => 0,
	"last_iterations" => 0,
	"print_best" => 0,

    };

    $self->{ISCOMMAND}  = {
	"comalign" => 1,
	"seq" => 0,
	"seed" => 0,
	"seqnb" => 0,
	"iterations" => 0,
	"score" => 0,
	"time" => 0,
	"last_iterations" => 0,
	"print_best" => 0,

    };

    $self->{ISMANDATORY}  = {
	"comalign" => 0,
	"seq" => 1,
	"seed" => 0,
	"seqnb" => 0,
	"iterations" => 0,
	"score" => 0,
	"time" => 0,
	"last_iterations" => 0,
	"print_best" => 0,

    };

    $self->{PROMPT}  = {
	"comalign" => "",
	"seq" => "Sequences File (-f)",
	"seed" => "Random seed number (-s)",
	"seqnb" => "Number of sequences that are to be aligned (-n)",
	"iterations" => "Number of iterations (-i)",
	"score" => "score: ComAlign records the time it took to  find a solution as good as this score (-l)",
	"time" => "ComAlign marks the best solution found after this number of 1/100 seconds (-t)",
	"last_iterations" => "Makes ComAlign terminate if the score hasn't changed within the last this number of iterations (-c)",
	"print_best" => "Print the best found alignment on termination (-a)",

    };

    $self->{ISSTANDOUT}  = {
	"comalign" => 0,
	"seq" => 0,
	"seed" => 0,
	"seqnb" => 0,
	"iterations" => 0,
	"score" => 0,
	"time" => 0,
	"last_iterations" => 0,
	"print_best" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"seed" => '1',
	"seqnb" => '2',
	"iterations" => '10',
	"last_iterations" => '20',
	"print_best" => '1',

    };

    $self->{PRECOND}  = {
	"comalign" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"seqnb" => { "perl" => '1' },
	"iterations" => { "perl" => '1' },
	"score" => { "perl" => '1' },
	"time" => { "perl" => '1' },
	"last_iterations" => { "perl" => '1' },
	"print_best" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"comalign" => 0,
	"seq" => 0,
	"seed" => 0,
	"seqnb" => 0,
	"iterations" => 0,
	"score" => 0,
	"time" => 0,
	"last_iterations" => 0,
	"print_best" => 0,

    };

    $self->{ISSIMPLE}  = {
	"comalign" => 0,
	"seq" => 1,
	"seed" => 0,
	"seqnb" => 0,
	"iterations" => 0,
	"score" => 0,
	"time" => 0,
	"last_iterations" => 0,
	"print_best" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"iterations" => [
		"On each iteration a new alignment is added to the pool of alignments ComAlign is working on",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/comalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

