
=head1 NAME

Bio::Tools::Run::PiseApplication::addquart

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::addquart

      Bioperl class for:

	PHYLOQUART	addquart - phylogeny reconstruction from a set of quartets and a partially resolved tree (Berry)

      Parameters:


		addquart (String)


		bipfile (InFile)
			bipfile: contains the edges of the tree T to complete
			pipe: bipfile

		quartfile_left (InFile)
			quartfile.left: contains the set of quartets unresolved by the tree T

		quartfile_res (InFile)
			quartfile.res: contains the set of satisfied quartets

		outbipfile (Results)


		tree_pop (Switch)


		treefile (Results)

			pipe: phylip_tree

=cut

#'
package Bio::Tools::Run::PiseApplication::addquart;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $addquart = Bio::Tools::Run::PiseApplication::addquart->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::addquart object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $addquart = $factory->program('addquart');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::addquart.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/addquart.pm

    $self->{COMMAND}   = "addquart";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PHYLOQUART";

    $self->{DESCRIPTION}   = "addquart - phylogeny reconstruction from a set of quartets and a partially resolved tree";

    $self->{AUTHORS}   = "Berry";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"addquart",
	"bipfile",
	"quartfile_left",
	"quartfile_res",
	"outbipfile",
	"tree_pop",
	"treefile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"addquart",
	"bipfile", 	# bipfile: contains the edges of the tree T to complete
	"quartfile_left", 	# quartfile.left: contains the set of quartets unresolved by the tree T
	"quartfile_res", 	# quartfile.res: contains the set of satisfied quartets
	"outbipfile",
	"tree_pop",
	"treefile",

    ];

    $self->{TYPE}  = {
	"addquart" => 'String',
	"bipfile" => 'InFile',
	"quartfile_left" => 'InFile',
	"quartfile_res" => 'InFile',
	"outbipfile" => 'Results',
	"tree_pop" => 'Switch',
	"treefile" => 'Results',

    };

    $self->{FORMAT}  = {
	"addquart" => {
		"perl" => '"addquart"',
	},
	"bipfile" => {
		"perl" => '"ln -s $bipfile bipfile; "',
	},
	"quartfile_left" => {
		"perl" => '"ln -s $quartfile_left quartfile.left; "',
	},
	"quartfile_res" => {
		"perl" => '($value)? "ln -s $quartfile_res quartfile.res; " : ""',
	},
	"outbipfile" => {
	},
	"tree_pop" => {
		"perl" => '" ;tree-pop"',
	},
	"treefile" => {
	},

    };

    $self->{FILENAMES}  = {
	"outbipfile" => 'bipfile',
	"treefile" => 'treefile',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"addquart" => 0,
	"bipfile" => -10,
	"quartfile_left" => -10,
	"quartfile_res" => -10,
	"tree_pop" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"quartfile_res",
	"bipfile",
	"quartfile_left",
	"addquart",
	"outbipfile",
	"treefile",
	"tree_pop",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"addquart" => 1,
	"bipfile" => 0,
	"quartfile_left" => 0,
	"quartfile_res" => 0,
	"outbipfile" => 0,
	"tree_pop" => 1,
	"treefile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"addquart" => 1,
	"bipfile" => 0,
	"quartfile_left" => 0,
	"quartfile_res" => 0,
	"outbipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"addquart" => 0,
	"bipfile" => 1,
	"quartfile_left" => 1,
	"quartfile_res" => 0,
	"outbipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{PROMPT}  = {
	"addquart" => "",
	"bipfile" => "bipfile: contains the edges of the tree T to complete",
	"quartfile_left" => "quartfile.left: contains the set of quartets unresolved by the tree T",
	"quartfile_res" => "quartfile.res: contains the set of satisfied quartets",
	"outbipfile" => "",
	"tree_pop" => "",
	"treefile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"addquart" => 0,
	"bipfile" => 0,
	"quartfile_left" => 0,
	"quartfile_res" => 0,
	"outbipfile" => 0,
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

    };

    $self->{PRECOND}  = {
	"addquart" => { "perl" => '1' },
	"bipfile" => { "perl" => '1' },
	"quartfile_left" => { "perl" => '1' },
	"quartfile_res" => { "perl" => '1' },
	"outbipfile" => { "perl" => '1' },
	"tree_pop" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"treefile" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"bipfile" => {
		 "bipfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {
	"bipfile" => {
		 "bipfile" => ["quartfile_left","quartfile_res",]
	},

    };

    $self->{ISCLEAN}  = {
	"addquart" => 0,
	"bipfile" => 0,
	"quartfile_left" => 0,
	"quartfile_res" => 0,
	"outbipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"addquart" => 1,
	"bipfile" => 1,
	"quartfile_left" => 1,
	"quartfile_res" => 0,
	"outbipfile" => 0,
	"tree_pop" => 0,
	"treefile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"bipfile" => [
		"Contains the number of taxa, the association of a number to each taxa, then the edges of the tree T to complete, coded as the bipartitions (splits) they induce on the taxa, eg: 1 2 3 | 4 5 6 corresponds to the edge separating taxa 1, 2 and 3 from taxa 4,5 and 6.",
		"This file can be computed by qstar program of the same package.",
	],
	"quartfile_left" => [
		"Contains the set Q\' of quartets unresolved by the tree T and which are to be respected as much as possible when extending the tree T.",
		"This file is computed by the qstar program of the same package in a previous step.",
	],
	"quartfile_res" => [
		"If present, this file is used to add the number of quartets of Q* to the number of quartets satisfied by the tree inferred by AddQuart. Otherwise, AddQuart only indicates the number of quartets of Q\' satisfied by the output tree.",
		"This file is computed by the qstar program of the same package in a previous step.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/addquart.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

