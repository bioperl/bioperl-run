
=head1 NAME

Bio::Tools::Run::PiseApplication::qstar

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::qstar

      Bioperl class for:

	PHYLOQUART	qstar - reliable phylogeny reconstruction from a set of quartets (Berry)

      Parameters:


		qstar (String)


		quartfile (InFile)
			quartfile containing the list of quartets
			pipe: quartfile

		quartfile_res (OutFile)


		quartfile_left (OutFile)


		bipfile (OutFile)

			pipe: bipfile

		tree_pop (Switch)


		treefile (Results)

			pipe: phylip_tree

=cut

#'
package Bio::Tools::Run::PiseApplication::qstar;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $qstar = Bio::Tools::Run::PiseApplication::qstar->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::qstar object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $qstar = $factory->program('qstar');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::qstar.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/qstar.pm

    $self->{COMMAND}   = "qstar";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PHYLOQUART";

    $self->{DESCRIPTION}   = "qstar - reliable phylogeny reconstruction from a set of quartets";

    $self->{AUTHORS}   = "Berry";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"qstar",
	"quartfile",
	"quartfile_res",
	"quartfile_left",
	"bipfile",
	"tree_pop",
	"treefile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"qstar",
	"quartfile", 	# quartfile containing the list of quartets
	"quartfile_res",
	"quartfile_left",
	"bipfile",
	"tree_pop",
	"treefile",

    ];

    $self->{TYPE}  = {
	"qstar" => 'String',
	"quartfile" => 'InFile',
	"quartfile_res" => 'OutFile',
	"quartfile_left" => 'OutFile',
	"bipfile" => 'OutFile',
	"tree_pop" => 'Switch',
	"treefile" => 'Results',

    };

    $self->{FORMAT}  = {
	"qstar" => {
		"seqlab" => 'qstar',
		"perl" => '"qstar"',
	},
	"quartfile" => {
		"perl" => '"ln -s $quartfile quartfile; "',
	},
	"quartfile_res" => {
	},
	"quartfile_left" => {
	},
	"bipfile" => {
	},
	"tree_pop" => {
		"perl" => '" ;tree-pop"',
	},
	"treefile" => {
	},

    };

    $self->{FILENAMES}  = {
	"treefile" => 'treefile',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"qstar" => 0,
	"quartfile" => -10,
	"tree_pop" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"quartfile",
	"qstar",
	"quartfile_res",
	"quartfile_left",
	"bipfile",
	"treefile",
	"tree_pop",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"qstar" => 1,
	"quartfile" => 0,
	"quartfile_res" => 1,
	"quartfile_left" => 1,
	"bipfile" => 1,
	"tree_pop" => 1,
	"treefile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"qstar" => 1,
	"quartfile" => 0,
	"quartfile_res" => 0,
	"quartfile_left" => 0,
	"bipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"qstar" => 0,
	"quartfile" => 1,
	"quartfile_res" => 0,
	"quartfile_left" => 0,
	"bipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{PROMPT}  = {
	"qstar" => "",
	"quartfile" => "quartfile containing the list of quartets",
	"quartfile_res" => "",
	"quartfile_left" => "",
	"bipfile" => "",
	"tree_pop" => "",
	"treefile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"qstar" => 0,
	"quartfile" => 0,
	"quartfile_res" => 0,
	"quartfile_left" => 0,
	"bipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"quartfile_res" => '"quartfile.res"',
	"quartfile_left" => '"quartfile.left"',
	"bipfile" => '"bipfile"',

    };

    $self->{PRECOND}  = {
	"qstar" => { "perl" => '1' },
	"quartfile" => { "perl" => '1' },
	"quartfile_res" => { "perl" => '1' },
	"quartfile_left" => { "perl" => '1' },
	"bipfile" => { "perl" => '1' },
	"tree_pop" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"bipfile" => {
		 '1' => "bipfile",
	},
	"treefile" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {
	"bipfile" => {
		 "bipfile" => ["quartfile_left","quartfile_res",]
	},

    };

    $self->{PIPEIN}  = {
	"quartfile" => {
		 "quartfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"qstar" => 0,
	"quartfile" => 0,
	"quartfile_res" => 0,
	"quartfile_left" => 0,
	"bipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"qstar" => 1,
	"quartfile" => 1,
	"quartfile_res" => 0,
	"quartfile_left" => 0,
	"bipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"quartfile" => [
		"This file is computed by quartet inference programs (parciquart and distquart) which infer a set of quartets from biological data, mainly nucleotide sequences for the species or inter-species distances.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/qstar.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

