# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::druid
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::druid

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::druid

      Bioperl class for:

	DRUID	Localization of recombination breakpoints in an   alignment of sequences (M. Zelwer, MF. Sagot)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/druid.html 
         for available values):


		druid (String)

		sequences (Sequence)
			Sequence File (at least 4 sequences)
			pipe: readseq_ok_alig

		window_size (Integer)
			window_size (-w)

		iterations (Integer)
			number of iterations (-n)

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

  http://bugzilla.open-bio.org/

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

http://bioweb.pasteur.fr/seqanal/interfaces/druid.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::druid;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $druid = Bio::Tools::Run::PiseApplication::druid->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::druid object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $druid = $factory->program('druid');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::druid.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/druid.pm

    $self->{COMMAND}   = "druid";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DRUID";

    $self->{DESCRIPTION}   = "Localization of recombination breakpoints in an   alignment of sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "M. Zelwer, MF. Sagot";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"druid",
	"sequences",
	"window_size",
	"iterations",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"druid",
	"sequences", 	# Sequence File (at least 4 sequences)
	"window_size", 	# window_size (-w)
	"iterations", 	# number of iterations (-n)

    ];

    $self->{TYPE}  = {
	"druid" => 'String',
	"sequences" => 'Sequence',
	"window_size" => 'Integer',
	"iterations" => 'Integer',

    };

    $self->{FORMAT}  = {
	"druid" => {
		"perl" => ' "druid" ',
	},
	"sequences" => {
		"perl" => '" $value"',
	},
	"window_size" => {
		"perl" => ' (defined $value && $value ne $vdef)? " -w $value" : ""',
	},
	"iterations" => {
		"perl" => ' (defined $value && $value ne $vdef)? " -n $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequences" => [12],

    };

    $self->{GROUP}  = {
	"druid" => 0,
	"sequences" => 4,
	"window_size" => 2,
	"iterations" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"druid",
	"window_size",
	"iterations",
	"sequences",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"druid" => 1,
	"sequences" => 0,
	"window_size" => 0,
	"iterations" => 0,

    };

    $self->{ISCOMMAND}  = {
	"druid" => 1,
	"sequences" => 0,
	"window_size" => 0,
	"iterations" => 0,

    };

    $self->{ISMANDATORY}  = {
	"druid" => 0,
	"sequences" => 1,
	"window_size" => 0,
	"iterations" => 0,

    };

    $self->{PROMPT}  = {
	"druid" => "",
	"sequences" => "Sequence File (at least 4 sequences)",
	"window_size" => "window_size (-w)",
	"iterations" => "number of iterations (-n)",

    };

    $self->{ISSTANDOUT}  = {
	"druid" => 0,
	"sequences" => 0,
	"window_size" => 0,
	"iterations" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window_size" => '5',
	"iterations" => '1000',

    };

    $self->{PRECOND}  = {
	"druid" => { "perl" => '1' },
	"sequences" => { "perl" => '1' },
	"window_size" => { "perl" => '1' },
	"iterations" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"iterations" => {
		"perl" => {
			'$value > 2000' => "If you want to run the program with this parameter set a value greater than 2000, please contact the authors.",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequences" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"druid" => 0,
	"sequences" => 0,
	"window_size" => 0,
	"iterations" => 0,

    };

    $self->{ISSIMPLE}  = {
	"druid" => 0,
	"sequences" => 1,
	"window_size" => 0,
	"iterations" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"sequences" => [
		"The data should be an alignment of DNA sequences containing at least four sequences",
	],
	"window_size" => [
		"This parameter sets the size of each half of the double window.    ",
	],
	"iterations" => [
		"This option specifies how many separate datasets should be simulated for each  Farris\' ILD test.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/druid.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

