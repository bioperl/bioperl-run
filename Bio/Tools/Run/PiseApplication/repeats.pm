# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::repeats
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

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

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/repeats.html 
         for available values):


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

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/repeats.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::repeats;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $repeats = Bio::Tools::Run::PiseApplication::repeats->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::repeats object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $repeats = $factory->program('repeats');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::repeats.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/repeats.pm

    $self->{COMMAND}   = "repeats";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "repeats";

    $self->{DESCRIPTION}   = "search repeats in DNA";

    $self->{OPT_EMAIL}   = 0;

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

