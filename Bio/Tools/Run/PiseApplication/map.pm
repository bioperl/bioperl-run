# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::map
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::map

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::map

      Bioperl class for:

	MAP	Multiple Alignment Program


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/map.html 
         for available values):


		map (String)

		seq (Sequence)
			Sequences File

		gap_size (Integer)
			gap size: minimum length of any gap in a short sequence charged with a constant gap penalty (gs)

		mismatch (Integer)
			score of a mismatch (<0)

		gapopen (Integer)
			gap open penalty (>=0)

		gapext (Integer)
			gap extension penalty (>=0)

		matrix (InFile)
			Matrix (Name of a file containing an alternate or user-defined scoring matrix)

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

http://bioweb.pasteur.fr/seqanal/interfaces/map.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::map;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $map = Bio::Tools::Run::PiseApplication::map->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::map object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $map = $factory->program('map');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::map.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/map.pm

    $self->{COMMAND}   = "map";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MAP";

    $self->{DESCRIPTION}   = "Multiple Alignment Program";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"map",
	"seq",
	"scoring",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"map",
	"seq", 	# Sequences File
	"scoring", 	# Scoring Parameters
	"gap_size", 	# gap size: minimum length of any gap in a short sequence charged with a constant gap penalty (gs)
	"mismatch", 	# score of a mismatch (<0)
	"gapopen", 	# gap open penalty (>=0)
	"gapext", 	# gap extension penalty (>=0)
	"matrix", 	# Matrix (Name of a file containing an alternate or user-defined scoring matrix)

    ];

    $self->{TYPE}  = {
	"map" => 'String',
	"seq" => 'Sequence',
	"scoring" => 'Paragraph',
	"gap_size" => 'Integer',
	"mismatch" => 'Integer',
	"gapopen" => 'Integer',
	"gapext" => 'Integer',
	"matrix" => 'InFile',

    };

    $self->{FORMAT}  = {
	"map" => {
		"seqlab" => 'map',
		"perl" => '"map"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"scoring" => {
	},
	"gap_size" => {
		"perl" => '(defined $value)? " $value" : ""',
	},
	"mismatch" => {
		"perl" => '($value < 0 && ! $matrix)? " $value" : "" ',
	},
	"gapopen" => {
		"perl" => '(defined $value)? " $value" : "" ',
	},
	"gapext" => {
		"perl" => '(defined $value)? " $value" : ""',
	},
	"matrix" => {
		"perl" => ' ($value)? " $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"map" => 0,
	"seq" => 1,
	"gap_size" => 2,
	"mismatch" => 3,
	"gapopen" => 4,
	"gapext" => 5,
	"matrix" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"map",
	"scoring",
	"seq",
	"gap_size",
	"mismatch",
	"matrix",
	"gapopen",
	"gapext",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"map" => 1,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{ISCOMMAND}  = {
	"map" => 1,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{ISMANDATORY}  = {
	"map" => 0,
	"seq" => 1,
	"scoring" => 0,
	"gap_size" => 1,
	"mismatch" => 1,
	"gapopen" => 1,
	"gapext" => 1,
	"matrix" => 0,

    };

    $self->{PROMPT}  = {
	"map" => "",
	"seq" => "Sequences File",
	"scoring" => "Scoring Parameters",
	"gap_size" => "gap size: minimum length of any gap in a short sequence charged with a constant gap penalty (gs)",
	"mismatch" => "score of a mismatch (<0)",
	"gapopen" => "gap open penalty (>=0)",
	"gapext" => "gap extension penalty (>=0)",
	"matrix" => "Matrix (Name of a file containing an alternate or user-defined scoring matrix)",

    };

    $self->{ISSTANDOUT}  = {
	"map" => 0,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{VLIST}  = {

	"scoring" => ['gap_size','mismatch','gapopen','gapext','matrix',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"map" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"scoring" => { "perl" => '1' },
	"gap_size" => { "perl" => '1' },
	"mismatch" => { "perl" => '1' },
	"gapopen" => { "perl" => '1' },
	"gapext" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"mismatch" => {
		"perl" => {
			'($value >= 0)' => "enter a negative value",
		},
	},
	"gapopen" => {
		"perl" => {
			'($value < 0)' => "enter a positive a null value",
		},
	},
	"gapext" => {
		"perl" => {
			'($value < 0)' => "enter a positive a null value",
		},
	},

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
	"map" => 0,
	"seq" => 0,
	"scoring" => 0,
	"gap_size" => 0,
	"mismatch" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"matrix" => 0,

    };

    $self->{ISSIMPLE}  = {
	"map" => 1,
	"seq" => 1,
	"scoring" => 0,
	"gap_size" => 1,
	"mismatch" => 1,
	"gapopen" => 1,
	"gapext" => 1,
	"matrix" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"scoring" => [
		"In the simplest form, users provide 3 integers: ms, q and r, where ms is the score of a mismatch and the score of an i-symbol indel is -(q + r * i). Each match automatically receives score 10. In addition, an integer gs is provided so that any gap of length > gs in a short sequence is given a penalty of -(q + r * gs), the linear penalty for a gap of length gs. In other words, long gaps in the short sequence are given a constant penalty. This simple scoring scheme may be used for DNA sequences. NOTE: all scores are integers.",
	],
	"gap_size" => [
		"gapsize is provided so that any gap of length > gs in a short sequence is given a penalty of -(q + r * gs), the linear penalty for a gap of length gs. In other words, long gaps in the short sequence are given a constant penalty. ",
	],
	"matrix" => [
		"users can define an alphabet of characters to appear in the sequences and a matrix that gives the substitution score for each pair of symbols in the alphabet. The 127 ASCII characters are eligible. The alphabet and matrix are given in a file, where the first line lists the characters in the alphabet and the lower triangle of the matrix comes next. ",
		"Example:",
		"ARNDC",
		" 13",
		"-15 19",
		"-10 -22 11",
		"-20 -10 -20 18",
		"-10 -20 -10 -20 12",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/map.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

