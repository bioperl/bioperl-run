
=head1 NAME

Bio::Tools::Run::PiseApplication::repeats

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::repeats

      Bioperl class for:

	repeats	search repeats in DNA (G. Benson)

	References:

		A method for fast database search for all k-nucleotide repeats, by Gary Benson and Michael S. Waterman, Nucleic Acids Research (1994) Vol. 22, No. 22, pp 4828-4836.


      Parameters:


		repeats (String)


		seq (Sequence)
			Sequence File

		alpha (Integer)
			match bonus (input as positive) (Alpha)

		beta (Integer)
			mismatch penalty (input as positive) (Beta)

		delta (Integer)
			indel penalty  (Delta)

		reportmax (Integer)
			Score to report an alignment (Reportmax)

		Size (Integer)
			Pattern size (Size)

		lookcount (Integer)
			Number of characters to match to trigger dynamic programming (Lookcount)

		noshortperiods (Switch)
			Patterns with shorter periods are excluded ? (Noshortperiods)

=cut

#'
package Bio::Tools::Run::PiseApplication::repeats;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $repeats = Bio::Tools::Run::PiseApplication::repeats->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::repeats object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $repeats = $factory->program('repeats');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::repeats.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/repeats.pm

    $self->{COMMAND}   = "repeats";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "repeats";

    $self->{DESCRIPTION}   = "search repeats in DNA";

    $self->{CATEGORIES}   =  [  

         "nucleic:motifs",
  ];

    $self->{AUTHORS}   = "G. Benson";

    $self->{REFERENCE}   = [

         "A method for fast database search for all k-nucleotide repeats, by Gary Benson and Michael S. Waterman, Nucleic Acids Research (1994) Vol. 22, No. 22, pp 4828-4836.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"repeats",
	"seq",
	"alpha",
	"beta",
	"delta",
	"reportmax",
	"Size",
	"lookcount",
	"noshortperiods",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"repeats",
	"seq", 	# Sequence File
	"alpha", 	# match bonus (input as positive) (Alpha)
	"beta", 	# mismatch penalty (input as positive) (Beta)
	"delta", 	# indel penalty  (Delta)
	"reportmax", 	# Score to report an alignment (Reportmax)
	"Size", 	# Pattern size (Size)
	"lookcount", 	# Number of characters to match to trigger dynamic programming (Lookcount)
	"noshortperiods", 	# Patterns with shorter periods are excluded ? (Noshortperiods)

    ];

    $self->{TYPE}  = {
	"repeats" => 'String',
	"seq" => 'Sequence',
	"alpha" => 'Integer',
	"beta" => 'Integer',
	"delta" => 'Integer',
	"reportmax" => 'Integer',
	"Size" => 'Integer',
	"lookcount" => 'Integer',
	"noshortperiods" => 'Switch',

    };

    $self->{FORMAT}  = {
	"repeats" => {
		"seqlab" => 'repeats',
		"perl" => '"repeats"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"alpha" => {
		"perl" => ' " $value"',
	},
	"beta" => {
		"perl" => ' " $value"  ',
	},
	"delta" => {
		"perl" => ' " $value"  ',
	},
	"reportmax" => {
		"perl" => ' " $value"  ',
	},
	"Size" => {
		"perl" => ' " $value"  ',
	},
	"lookcount" => {
		"perl" => ' " $value"  ',
	},
	"noshortperiods" => {
		"perl" => ' ($value)? " 1 ":" 0"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [2],

    };

    $self->{GROUP}  = {
	"repeats" => 0,
	"seq" => 1,
	"alpha" => 2,
	"beta" => 3,
	"delta" => 4,
	"reportmax" => 5,
	"Size" => 6,
	"lookcount" => 7,
	"noshortperiods" => 8,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"repeats",
	"seq",
	"alpha",
	"beta",
	"delta",
	"reportmax",
	"Size",
	"lookcount",
	"noshortperiods",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"repeats" => 1,
	"seq" => 0,
	"alpha" => 0,
	"beta" => 0,
	"delta" => 0,
	"reportmax" => 0,
	"Size" => 0,
	"lookcount" => 0,
	"noshortperiods" => 0,

    };

    $self->{ISCOMMAND}  = {
	"repeats" => 1,
	"seq" => 0,
	"alpha" => 0,
	"beta" => 0,
	"delta" => 0,
	"reportmax" => 0,
	"Size" => 0,
	"lookcount" => 0,
	"noshortperiods" => 0,

    };

    $self->{ISMANDATORY}  = {
	"repeats" => 0,
	"seq" => 1,
	"alpha" => 1,
	"beta" => 1,
	"delta" => 1,
	"reportmax" => 1,
	"Size" => 1,
	"lookcount" => 1,
	"noshortperiods" => 0,

    };

    $self->{PROMPT}  = {
	"repeats" => "",
	"seq" => "Sequence File",
	"alpha" => "match bonus (input as positive) (Alpha)",
	"beta" => "mismatch penalty (input as positive) (Beta)",
	"delta" => "indel penalty  (Delta)",
	"reportmax" => "Score to report an alignment (Reportmax)",
	"Size" => "Pattern size (Size)",
	"lookcount" => "Number of characters to match to trigger dynamic programming (Lookcount)",
	"noshortperiods" => "Patterns with shorter periods are excluded ? (Noshortperiods)",

    };

    $self->{ISSTANDOUT}  = {
	"repeats" => 0,
	"seq" => 0,
	"alpha" => 0,
	"beta" => 0,
	"delta" => 0,
	"reportmax" => 0,
	"Size" => 0,
	"lookcount" => 0,
	"noshortperiods" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"noshortperiods" => '0',

    };

    $self->{PRECOND}  = {
	"repeats" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"alpha" => { "perl" => '1' },
	"beta" => { "perl" => '1' },
	"delta" => { "perl" => '1' },
	"reportmax" => { "perl" => '1' },
	"Size" => { "perl" => '1' },
	"lookcount" => { "perl" => '1' },
	"noshortperiods" => { "perl" => '1' },

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
	"repeats" => 0,
	"seq" => 0,
	"alpha" => 0,
	"beta" => 0,
	"delta" => 0,
	"reportmax" => 0,
	"Size" => 0,
	"lookcount" => 0,
	"noshortperiods" => 0,

    };

    $self->{ISSIMPLE}  = {
	"repeats" => 1,
	"seq" => 1,
	"alpha" => 1,
	"beta" => 1,
	"delta" => 1,
	"reportmax" => 1,
	"Size" => 1,
	"lookcount" => 1,
	"noshortperiods" => 1,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"Size" => [
		"A possible repeat is found if *lookcount* characters are repeated at a separation of *size*.",
	],
	"lookcount" => [
		"A possible repeat is found if *lookcount* characters are repeated at a separation of *size*.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/repeats.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

