
=head1 NAME

Bio::Tools::Run::PiseApplication::unroot

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::unroot

      Bioperl class for:

	Phylip	unroot: use of RETREE to unroot a tree (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.


      Parameters:


		unroot (String)
			

		treefile (InFile)
			Tree File
			pipe: phylip_tree

		outtree (Results)
			
			pipe: phylip_tree

		params (Results)
			

		commands (String)
			

		terminal_type (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::unroot;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $unroot = Bio::Tools::Run::PiseApplication::unroot->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::unroot object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $unroot = $factory->program('unroot');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::unroot.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/unroot.pm

    $self->{COMMAND}   = "unroot";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "unroot: use of RETREE to unroot a tree";

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"unroot",
	"treefile",
	"outtree",
	"params",
	"commands",
	"terminal_type",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"unroot",
	"treefile", 	# Tree File
	"outtree",
	"params",
	"commands",
	"terminal_type",

    ];

    $self->{TYPE}  = {
	"unroot" => 'String',
	"treefile" => 'InFile',
	"outtree" => 'Results',
	"params" => 'Results',
	"commands" => 'String',
	"terminal_type" => 'String',

    };

    $self->{FORMAT}  = {
	"unroot" => {
		"perl" => ' "retree < params" ',
	},
	"treefile" => {
		"perl" => '"ln -s $treefile intree; "',
	},
	"outtree" => {
	},
	"params" => {
	},
	"commands" => {
		"perl" => '"Y\\nW\\nU\\nQ\\n"',
	},
	"terminal_type" => {
		"perl" => '"0\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"outtree" => 'outtree',
	"params" => 'params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"unroot" => 0,
	"treefile" => -10,
	"commands" => 1000,
	"terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treefile",
	"terminal_type",
	"unroot",
	"outtree",
	"params",
	"commands",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"unroot" => 1,
	"treefile" => 0,
	"outtree" => 0,
	"params" => 0,
	"commands" => 1,
	"terminal_type" => 1,

    };

    $self->{ISCOMMAND}  = {
	"unroot" => 1,
	"treefile" => 0,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,
	"terminal_type" => 0,

    };

    $self->{ISMANDATORY}  = {
	"unroot" => 0,
	"treefile" => 1,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,
	"terminal_type" => 0,

    };

    $self->{PROMPT}  = {
	"unroot" => "",
	"treefile" => "Tree File",
	"outtree" => "",
	"params" => "",
	"commands" => "",
	"terminal_type" => "",

    };

    $self->{ISSTANDOUT}  = {
	"unroot" => 0,
	"treefile" => 0,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,
	"terminal_type" => 0,

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
	"unroot" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },
	"outtree" => { "perl" => '1' },
	"params" => { "perl" => '1' },
	"commands" => { "perl" => '1' },
	"terminal_type" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outtree" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"treefile" => {
		 "phylip_tree" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"unroot" => 0,
	"treefile" => 0,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,
	"terminal_type" => 0,

    };

    $self->{ISSIMPLE}  = {
	"unroot" => 0,
	"treefile" => 1,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,
	"terminal_type" => 0,

    };

    $self->{PARAMFILE}  = {
	"commands" => "params",
	"terminal_type" => "params",

    };

    $self->{COMMENT}  = {
	"treefile" => [
		"The program hangs when provided a tree with [...] added to branch lengths.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/unroot.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

