# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmfetch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmfetch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmfetch

      Bioperl class for:

	HMMER	hmmfetch - retrieve an HMM from an HMM database (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmfetch.html 
         for available values):


		toto (String)

		hmmfetch (String)

		name (String)
			name of the HMM

		HMMDB (Excl)
			HMM database

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmfetch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmfetch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmfetch = Bio::Tools::Run::PiseApplication::hmmfetch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmfetch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmfetch = $factory->program('hmmfetch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmfetch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmfetch.pm

    $self->{COMMAND}   = "hmmfetch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmfetch - retrieve an HMM from an HMM database";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"description",
	"hmmfetch",
	"name",
	"HMMDB",
	"hmmfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"description", 	# Description of hmmfetch
	"toto",
	"hmmfetch",
	"name", 	# name of the HMM
	"HMMDB", 	# HMM database
	"hmmfile",

    ];

    $self->{TYPE}  = {
	"description" => 'Paragraph',
	"toto" => 'String',
	"hmmfetch" => 'String',
	"name" => 'String',
	"HMMDB" => 'Excl',
	"hmmfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"hmmfetch" => {
		"perl" => '"hmmfetch"',
	},
	"name" => {
		"perl" => '" $value"',
	},
	"HMMDB" => {
		"perl" => '" $value"',
	},
	"hmmfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"hmmfile" => '"hmmfetch.out"',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"toto" => 1000,
	"hmmfetch" => 0,
	"name" => 2,
	"HMMDB" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"description",
	"hmmfetch",
	"hmmfile",
	"HMMDB",
	"name",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"description" => 0,
	"toto" => 1,
	"hmmfetch" => 1,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 1,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 1,
	"HMMDB" => 1,
	"hmmfile" => 0,

    };

    $self->{PROMPT}  = {
	"description" => "Description of hmmfetch",
	"toto" => "",
	"hmmfetch" => "",
	"name" => "name of the HMM",
	"HMMDB" => "HMM database",
	"hmmfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
	"HMMDB" => ['Pfam','Pfam','PfamFrag','PfamFrag',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"HMMDB" => 'Pfam',

    };

    $self->{PRECOND}  = {
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"hmmfetch" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"HMMDB" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"hmmfile" => {
		 '1' => "hmmer_HMM",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"description" => 0,
	"toto" => 0,
	"hmmfetch" => 0,
	"name" => 0,
	"HMMDB" => 0,
	"hmmfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmfetch is a small utility that retrieves an HMM from a HMMER model database in a new format, and prints that model to standard output. The retrieved HMM file is written in HMMER 2 ASCII format.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmfetch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

