
=head1 NAME

Bio::Tools::Run::PiseApplication::helixturnhelix

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::helixturnhelix

      Bioperl class for:

	HELIXTURNHELIX	Report nucleic acid binding motifs (EMBOSS)

      Parameters:


		helixturnhelix (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- PureProtein [sequences] (-sequence)
			pipe: seqsfile

		advanced (Paragraph)
			advanced Section

		mean (Float)
			Mean value (-mean)

		sd (Float)
			Standard Deviation value (-sd)

		minsd (Float)
			Minimum SD (-minsd)

		eightyseven (Switch)
			Use the old (1987) weight data (-eightyseven)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::helixturnhelix;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $helixturnhelix = Bio::Tools::Run::PiseApplication::helixturnhelix->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::helixturnhelix object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $helixturnhelix = $factory->program('helixturnhelix');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::helixturnhelix.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/helixturnhelix.pm

    $self->{COMMAND}   = "helixturnhelix";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HELIXTURNHELIX";

    $self->{DESCRIPTION}   = "Report nucleic acid binding motifs (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:2d structure",

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/helixturnhelix.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"helixturnhelix",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"helixturnhelix",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- PureProtein [sequences] (-sequence)
	"advanced", 	# advanced Section
	"mean", 	# Mean value (-mean)
	"sd", 	# Standard Deviation value (-sd)
	"minsd", 	# Minimum SD (-minsd)
	"eightyseven", 	# Use the old (1987) weight data (-eightyseven)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"helixturnhelix" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"mean" => 'Float',
	"sd" => 'Float',
	"minsd" => 'Float',
	"eightyseven" => 'Switch',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"mean" => {
		"perl" => '(defined $value && $value != $vdef)? " -mean=$value" : ""',
	},
	"sd" => {
		"perl" => '(defined $value && $value != $vdef)? " -sd=$value" : ""',
	},
	"minsd" => {
		"perl" => '(defined $value && $value != $vdef)? " -minsd=$value" : ""',
	},
	"eightyseven" => {
		"perl" => '($value)? " -eightyseven" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"helixturnhelix" => {
		"perl" => '"helixturnhelix"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"mean" => 2,
	"sd" => 3,
	"minsd" => 4,
	"eightyseven" => 5,
	"outfile" => 6,
	"auto" => 7,
	"helixturnhelix" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"helixturnhelix",
	"sequence",
	"mean",
	"sd",
	"minsd",
	"eightyseven",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"mean" => 0,
	"sd" => 0,
	"minsd" => 0,
	"eightyseven" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"helixturnhelix" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"mean" => 0,
	"sd" => 0,
	"minsd" => 0,
	"eightyseven" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"mean" => 0,
	"sd" => 0,
	"minsd" => 0,
	"eightyseven" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- PureProtein [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"mean" => "Mean value (-mean)",
	"sd" => "Standard Deviation value (-sd)",
	"minsd" => "Minimum SD (-minsd)",
	"eightyseven" => "Use the old (1987) weight data (-eightyseven)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"mean" => 0,
	"sd" => 0,
	"minsd" => 0,
	"eightyseven" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['mean','sd','minsd','eightyseven',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"mean" => '238.71',
	"sd" => '293.61',
	"minsd" => '2.5',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"mean" => { "perl" => '1' },
	"sd" => { "perl" => '1' },
	"minsd" => { "perl" => '1' },
	"eightyseven" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"mean" => 0,
	"sd" => 0,
	"minsd" => 0,
	"eightyseven" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"mean" => 0,
	"sd" => 0,
	"minsd" => 0,
	"eightyseven" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/helixturnhelix.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

