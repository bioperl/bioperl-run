
=head1 NAME

Bio::Tools::Run::PiseApplication::scan_for_matches

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::scan_for_matches

      Bioperl class for:

	scan_for_matches	Scan Nucleotide or Protein Sequences for Matching Patterns

      Parameters:


		scan_for_matches (String)


		pattern_file (Results)


		sequence (Sequence)
			Input sequence

		pattern_options (Paragraph)
			Pattern options

		pattern (String)
			Search pattern

		mismatches (Integer)
			Number of mismatches

		deletions (Integer)
			Number of deletions

		insertions (Integer)
			Number of insertions

		info_user_pattern_file (Label)
			Please look at the documentation for using your own patterns.

		user_pattern_file (InFile)
			You may give your own patterns

		control_options (Paragraph)
			Control options

		complementary_strand (Switch)
			Search complementary strand

		protein (Switch)
			Protein

		stop_after_n_misses (Integer)
			Stop after n misses

=cut

#'
package Bio::Tools::Run::PiseApplication::scan_for_matches;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $scan_for_matches = Bio::Tools::Run::PiseApplication::scan_for_matches->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::scan_for_matches object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $scan_for_matches = $factory->program('scan_for_matches');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::scan_for_matches.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/scan_for_matches.pm

    $self->{COMMAND}   = "scan_for_matches";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "scan_for_matches";

    $self->{DESCRIPTION}   = "Scan Nucleotide or Protein Sequences for Matching Patterns";

    $self->{CATEGORIES}   =  [  

         "pattern searching",
  ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"scan_for_matches",
	"pattern_file",
	"sequence",
	"pattern_options",
	"control_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"scan_for_matches",
	"pattern_file",
	"sequence", 	# Input sequence
	"pattern_options", 	# Pattern options
	"pattern", 	# Search pattern
	"mismatches", 	# Number of mismatches
	"deletions", 	# Number of deletions
	"insertions", 	# Number of insertions
	"info_user_pattern_file", 	# Please look at the documentation for using your own patterns.
	"user_pattern_file", 	# You may give your own patterns
	"control_options", 	# Control options
	"complementary_strand", 	# Search complementary strand
	"protein", 	# Protein
	"stop_after_n_misses", 	# Stop after n misses

    ];

    $self->{TYPE}  = {
	"scan_for_matches" => 'String',
	"pattern_file" => 'Results',
	"sequence" => 'Sequence',
	"pattern_options" => 'Paragraph',
	"pattern" => 'String',
	"mismatches" => 'Integer',
	"deletions" => 'Integer',
	"insertions" => 'Integer',
	"info_user_pattern_file" => 'Label',
	"user_pattern_file" => 'InFile',
	"control_options" => 'Paragraph',
	"complementary_strand" => 'Switch',
	"protein" => 'Switch',
	"stop_after_n_misses" => 'Integer',

    };

    $self->{FORMAT}  = {
	"scan_for_matches" => {
		"perl" => '($user_pattern_file)? "scan_for_matches $user_pattern_file" : "scan_for_matches pattern_file"',
	},
	"pattern_file" => {
	},
	"sequence" => {
		"perl" => '" < $value"',
	},
	"pattern_options" => {
	},
	"pattern" => {
		"perl" => '"$value"',
	},
	"mismatches" => {
		"perl" => '"[$value,"',
	},
	"deletions" => {
		"perl" => '"$value,"',
	},
	"insertions" => {
		"perl" => '"$value]"',
	},
	"info_user_pattern_file" => {
	},
	"user_pattern_file" => {
		"perl" => '""',
	},
	"control_options" => {
	},
	"complementary_strand" => {
		"perl" => '($value)? " -c" : ""',
	},
	"protein" => {
		"perl" => '($value)? " -p" : ""',
	},
	"stop_after_n_misses" => {
		"perl" => '($value)? " -n$value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"pattern_file" => 'pattern_file',

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"scan_for_matches" => 1,
	"sequence" => 100,
	"pattern" => 1,
	"mismatches" => 2,
	"deletions" => 3,
	"insertions" => 4,
	"user_pattern_file" =>  -1,
	"control_options" => 2,
	"complementary_strand" => 2,
	"protein" => 2,
	"stop_after_n_misses" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"user_pattern_file",
	"pattern_file",
	"info_user_pattern_file",
	"pattern_options",
	"scan_for_matches",
	"pattern",
	"mismatches",
	"control_options",
	"complementary_strand",
	"protein",
	"stop_after_n_misses",
	"deletions",
	"insertions",
	"sequence",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"scan_for_matches" => 1,
	"pattern_file" => 0,
	"sequence" => 0,
	"pattern_options" => 0,
	"pattern" => 0,
	"mismatches" => 0,
	"deletions" => 0,
	"insertions" => 0,
	"info_user_pattern_file" => 0,
	"user_pattern_file" => 0,
	"control_options" => 0,
	"complementary_strand" => 0,
	"protein" => 0,
	"stop_after_n_misses" => 0,

    };

    $self->{ISCOMMAND}  = {
	"scan_for_matches" => 1,
	"pattern_file" => 0,
	"sequence" => 0,
	"pattern_options" => 0,
	"pattern" => 0,
	"mismatches" => 0,
	"deletions" => 0,
	"insertions" => 0,
	"info_user_pattern_file" => 0,
	"user_pattern_file" => 0,
	"control_options" => 0,
	"complementary_strand" => 0,
	"protein" => 0,
	"stop_after_n_misses" => 0,

    };

    $self->{ISMANDATORY}  = {
	"scan_for_matches" => 1,
	"pattern_file" => 0,
	"sequence" => 1,
	"pattern_options" => 0,
	"pattern" => 1,
	"mismatches" => 1,
	"deletions" => 1,
	"insertions" => 1,
	"info_user_pattern_file" => 0,
	"user_pattern_file" => 0,
	"control_options" => 0,
	"complementary_strand" => 0,
	"protein" => 0,
	"stop_after_n_misses" => 0,

    };

    $self->{PROMPT}  = {
	"scan_for_matches" => "",
	"pattern_file" => "",
	"sequence" => "Input sequence",
	"pattern_options" => "Pattern options",
	"pattern" => "Search pattern",
	"mismatches" => "Number of mismatches",
	"deletions" => "Number of deletions",
	"insertions" => "Number of insertions",
	"info_user_pattern_file" => "Please look at the documentation for using your own patterns.",
	"user_pattern_file" => "You may give your own patterns",
	"control_options" => "Control options",
	"complementary_strand" => "Search complementary strand",
	"protein" => "Protein",
	"stop_after_n_misses" => "Stop after n misses",

    };

    $self->{ISSTANDOUT}  = {
	"scan_for_matches" => 0,
	"pattern_file" => 0,
	"sequence" => 0,
	"pattern_options" => 0,
	"pattern" => 0,
	"mismatches" => 0,
	"deletions" => 0,
	"insertions" => 0,
	"info_user_pattern_file" => 0,
	"user_pattern_file" => 0,
	"control_options" => 0,
	"complementary_strand" => 0,
	"protein" => 0,
	"stop_after_n_misses" => 0,

    };

    $self->{VLIST}  = {

	"pattern_options" => ['pattern','mismatches','deletions','insertions','info_user_pattern_file','user_pattern_file',],
	"control_options" => ['complementary_strand','protein','stop_after_n_misses',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mismatches" => '0',
	"deletions" => '0',
	"insertions" => '0',

    };

    $self->{PRECOND}  = {
	"scan_for_matches" => { "perl" => '1' },
	"pattern_file" => {
		"perl" => '! $user_pattern_file',
	},
	"sequence" => { "perl" => '1' },
	"pattern_options" => { "perl" => '1' },
	"pattern" => {
		"perl" => '! $user_pattern_file',
	},
	"mismatches" => {
		"perl" => '! $user_pattern_file',
	},
	"deletions" => {
		"perl" => '! $user_pattern_file',
	},
	"insertions" => {
		"perl" => '! $user_pattern_file',
	},
	"info_user_pattern_file" => { "perl" => '1' },
	"user_pattern_file" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"complementary_strand" => { "perl" => '1' },
	"protein" => { "perl" => '1' },
	"stop_after_n_misses" => { "perl" => '1' },

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
	"scan_for_matches" => 0,
	"pattern_file" => 0,
	"sequence" => 0,
	"pattern_options" => 0,
	"pattern" => 0,
	"mismatches" => 0,
	"deletions" => 0,
	"insertions" => 0,
	"info_user_pattern_file" => 0,
	"user_pattern_file" => 0,
	"control_options" => 0,
	"complementary_strand" => 0,
	"protein" => 0,
	"stop_after_n_misses" => 0,

    };

    $self->{ISSIMPLE}  = {
	"scan_for_matches" => 0,
	"pattern_file" => 0,
	"sequence" => 1,
	"pattern_options" => 0,
	"pattern" => 1,
	"mismatches" => 1,
	"deletions" => 1,
	"insertions" => 1,
	"info_user_pattern_file" => 0,
	"user_pattern_file" => 0,
	"control_options" => 0,
	"complementary_strand" => 0,
	"protein" => 0,
	"stop_after_n_misses" => 0,

    };

    $self->{PARAMFILE}  = {
	"pattern" => "pattern_file",
	"mismatches" => "pattern_file",
	"deletions" => "pattern_file",
	"insertions" => "pattern_file",

    };

    $self->{COMMENT}  = {
	"user_pattern_file" => [
		"Please look at the documentation.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/scan_for_matches.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

