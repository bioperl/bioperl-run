# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::unroot
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::unroot

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::unroot

      Bioperl class for:

	Phylip	unroot: use of RETREE to unroot a tree (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/unroot.html 
         for available values):


		unroot (String)

		treefile (InFile)
			Tree File
			pipe: phylip_tree

		commands (String)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://bioweb.pasteur.fr/seqanal/interfaces/unroot.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::unroot;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $unroot = Bio::Tools::Run::PiseApplication::unroot->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::unroot object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $unroot = $factory->program('unroot');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::unroot.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/unroot.pm

    $self->{COMMAND}   = "unroot";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "unroot: use of RETREE to unroot a tree";

    $self->{OPT_EMAIL}   = 0;

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

    ];

    $self->{PARAMETERS_ORDER}  = [
	"unroot",
	"treefile", 	# Tree File
	"outtree",
	"params",
	"commands",

    ];

    $self->{TYPE}  = {
	"unroot" => 'String',
	"treefile" => 'InFile',
	"outtree" => 'Results',
	"params" => 'Results',
	"commands" => 'String',

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

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treefile",
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

    };

    $self->{ISCOMMAND}  = {
	"unroot" => 1,
	"treefile" => 0,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,

    };

    $self->{ISMANDATORY}  = {
	"unroot" => 0,
	"treefile" => 1,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,

    };

    $self->{PROMPT}  = {
	"unroot" => "",
	"treefile" => "Tree File",
	"outtree" => "",
	"params" => "",
	"commands" => "",

    };

    $self->{ISSTANDOUT}  = {
	"unroot" => 0,
	"treefile" => 0,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,

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

    };

    $self->{ISSIMPLE}  = {
	"unroot" => 0,
	"treefile" => 1,
	"outtree" => 0,
	"params" => 0,
	"commands" => 0,

    };

    $self->{PARAMFILE}  = {
	"commands" => "params",

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

