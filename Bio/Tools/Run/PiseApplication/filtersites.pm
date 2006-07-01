# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::filtersites
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::filtersites

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::filtersites

      Bioperl class for:

	filtersites	Filter conserved sites in an alignment (K. Schuerer)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/filtersites.html 
         for available values):


		filtersites (String)

		outalig (OutFile)
			pipe: readseq_ok_alig

		outweights (OutFile)
			pipe: phylip_weights

		infile (Sequence)
			Alignment
			pipe: readseq_ok_alig

		threshold (Float)
			Threshold (-t)

		weights (Switch)
			Phylip weights file rather than filtered alignment (for parsimony programs only) (-w)

		phylip_alig (Switch)
			Phylip alignment output format

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

http://bioweb.pasteur.fr/seqanal/interfaces/filtersites.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::filtersites;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $filtersites = Bio::Tools::Run::PiseApplication::filtersites->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::filtersites object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $filtersites = $factory->program('filtersites');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::filtersites.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/filtersites.pm

    $self->{COMMAND}   = "filtersites";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "filtersites";

    $self->{DESCRIPTION}   = "Filter conserved sites in an alignment";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{AUTHORS}   = "K. Schuerer";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"filtersites",
	"outalig",
	"outweights",
	"infile",
	"threshold",
	"weights",
	"phylip_alig",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"filtersites",
	"outalig",
	"outweights",
	"infile", 	# Alignment
	"threshold", 	# Threshold (-t)
	"weights", 	# Phylip weights file rather than filtered alignment (for parsimony programs only) (-w)
	"phylip_alig", 	# Phylip alignment output format

    ];

    $self->{TYPE}  = {
	"filtersites" => 'String',
	"outalig" => 'OutFile',
	"outweights" => 'OutFile',
	"infile" => 'Sequence',
	"threshold" => 'Float',
	"weights" => 'Switch',
	"phylip_alig" => 'Switch',

    };

    $self->{FORMAT}  = {
	"filtersites" => {
		"perl" => '"filtersites"',
	},
	"outalig" => {
	},
	"outweights" => {
		"perl" => '" > weights.out"',
	},
	"infile" => {
		"perl" => '" $value"',
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef) ? " -t $value" : ""',
	},
	"weights" => {
		"perl" => '(defined $value && $value) ? " -w" : ""',
	},
	"phylip_alig" => {
		"perl" => ' ($value)? " | readseq -p -f12 " : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"infile" => [8],

    };

    $self->{GROUP}  = {
	"filtersites" => 0,
	"outweights" => 100,
	"infile" => 10,
	"threshold" => 2,
	"weights" => 3,
	"phylip_alig" => 100,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"filtersites",
	"outalig",
	"threshold",
	"weights",
	"infile",
	"outweights",
	"phylip_alig",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"filtersites" => 1,
	"outalig" => 1,
	"outweights" => 1,
	"infile" => 0,
	"threshold" => 0,
	"weights" => 0,
	"phylip_alig" => 0,

    };

    $self->{ISCOMMAND}  = {
	"filtersites" => 1,
	"outalig" => 0,
	"outweights" => 0,
	"infile" => 0,
	"threshold" => 0,
	"weights" => 0,
	"phylip_alig" => 0,

    };

    $self->{ISMANDATORY}  = {
	"filtersites" => 0,
	"outalig" => 0,
	"outweights" => 0,
	"infile" => 1,
	"threshold" => 0,
	"weights" => 0,
	"phylip_alig" => 0,

    };

    $self->{PROMPT}  = {
	"filtersites" => "",
	"outalig" => "",
	"outweights" => "",
	"infile" => "Alignment",
	"threshold" => "Threshold (-t)",
	"weights" => "Phylip weights file rather than filtered alignment (for parsimony programs only) (-w)",
	"phylip_alig" => "Phylip alignment output format",

    };

    $self->{ISSTANDOUT}  = {
	"filtersites" => 0,
	"outalig" => 1,
	"outweights" => 0,
	"infile" => 0,
	"threshold" => 0,
	"weights" => 0,
	"phylip_alig" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outalig" => '"filtersites.out"',
	"outweights" => '"weights.out"',
	"threshold" => '1.0',
	"weights" => '0',
	"phylip_alig" => '1',

    };

    $self->{PRECOND}  = {
	"filtersites" => { "perl" => '1' },
	"outalig" => {
		"perl" => '! $weights',
	},
	"outweights" => {
		"perl" => '$weights',
	},
	"infile" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"weights" => { "perl" => '1' },
	"phylip_alig" => {
		"perl" => '! $weights',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outalig" => {
		 '1' => "readseq_ok_alig",
	},
	"outweights" => {
		 '1' => "phylip_weights",
	},

    };

    $self->{WITHPIPEOUT}  = {
	"outweights" => {
		 "phylip_weights" => ["infile",]
	},

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"filtersites" => 0,
	"outalig" => 0,
	"outweights" => 0,
	"infile" => 0,
	"threshold" => 0,
	"weights" => 0,
	"phylip_alig" => 0,

    };

    $self->{ISSIMPLE}  = {
	"filtersites" => 0,
	"outalig" => 0,
	"outweights" => 0,
	"infile" => 1,
	"threshold" => 0,
	"weights" => 0,
	"phylip_alig" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/filtersites.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

