# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::siggen
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::siggen

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::siggen

      Bioperl class for:

	SIGGEN	Generates a sparse protein signature (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/siggen.html 
         for available values):


		siggen (String)

		init (String)

		algpath (InFile)
			Location of alignment files for input (-algpath)

		algextn (String)
			Extension of alignment files for input (-algextn)

		sparsity (Integer)
			% sparsity of signature (-sparsity)

		randomise (Switch)
			Generate a randomised signature (-randomise)

		seqoption (List)
			Select number -- Sequence variability scoring method [select  values] (-seqoption)

		datafile (Excl)
			Substitution matrix to be used (-datafile)

		conoption (List)
			Select number -- Residue contacts scoring method [select  values] (-conoption)

		filtercon (Switch)
			Ignore alignment positions making less than a threshold number of contacts (-filtercon)

		conthresh (Integer)
			Threshold contact number (-conthresh)

		conpath (String)
			Location of contact files for input (-conpath)

		conextn (String)
			Extension of contact files (-conextn)

		cpdbpath (String)
			Location of coordinate files for input (embl-like format) (-cpdbpath)

		cpdbextn (String)
			Extension of coordinate files (embl-like format) (-cpdbextn)

		filterpsim (Switch)
			Ignore alignment postitions with post_similar value of 0 (-filterpsim)

		sigextn (String)
			Extension of signature files for output (-sigextn)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/siggen.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::siggen;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $siggen = Bio::Tools::Run::PiseApplication::siggen->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::siggen object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $siggen = $factory->program('siggen');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::siggen.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/siggen.pm

    $self->{COMMAND}   = "siggen";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SIGGEN";

    $self->{DESCRIPTION}   = "Generates a sparse protein signature (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:3d structure",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/siggen.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"siggen",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"siggen",
	"init",
	"input", 	# input Section
	"algpath", 	# Location of alignment files for input (-algpath)
	"algextn", 	# Extension of alignment files for input (-algextn)
	"required", 	# required Section
	"sparsity", 	# % sparsity of signature (-sparsity)
	"randomise", 	# Generate a randomised signature (-randomise)
	"advanced", 	# advanced Section
	"seqoption", 	# Select number -- Sequence variability scoring method [select  values] (-seqoption)
	"datafile", 	# Substitution matrix to be used (-datafile)
	"conoption", 	# Select number -- Residue contacts scoring method [select  values] (-conoption)
	"filtercon", 	# Ignore alignment positions making less than a threshold number of contacts (-filtercon)
	"conthresh", 	# Threshold contact number (-conthresh)
	"conpath", 	# Location of contact files for input (-conpath)
	"conextn", 	# Extension of contact files (-conextn)
	"cpdbpath", 	# Location of coordinate files for input (embl-like format) (-cpdbpath)
	"cpdbextn", 	# Extension of coordinate files (embl-like format) (-cpdbextn)
	"filterpsim", 	# Ignore alignment postitions with post_similar value of 0 (-filterpsim)
	"output", 	# output Section
	"sigpath", 	# Location of signature files for output (-sigpath)
	"sigextn", 	# Extension of signature files for output (-sigextn)
	"auto",

    ];

    $self->{TYPE}  = {
	"siggen" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"algpath" => 'InFile',
	"algextn" => 'String',
	"required" => 'Paragraph',
	"sparsity" => 'Integer',
	"randomise" => 'Switch',
	"advanced" => 'Paragraph',
	"seqoption" => 'List',
	"datafile" => 'Excl',
	"conoption" => 'List',
	"filtercon" => 'Switch',
	"conthresh" => 'Integer',
	"conpath" => 'String',
	"conextn" => 'String',
	"cpdbpath" => 'String',
	"cpdbextn" => 'String',
	"filterpsim" => 'Switch',
	"output" => 'Paragraph',
	"sigpath" => 'Results',
	"sigextn" => 'String',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"algpath" => {
		"perl" => '" -algpath=$value"',
	},
	"algextn" => {
		"perl" => '" -algextn=$value"',
	},
	"required" => {
	},
	"sparsity" => {
		"perl" => '" -sparsity=$value"',
	},
	"randomise" => {
		"perl" => '($value)? " -randomise" : ""',
	},
	"advanced" => {
	},
	"seqoption" => {
		"perl" => '" -seqoption=$value"',
	},
	"datafile" => {
		"perl" => '($value && $value ne $vdef)? " -datafile=$value" : ""',
	},
	"conoption" => {
		"perl" => '" -conoption=$value"',
	},
	"filtercon" => {
		"perl" => '($value)? " -filtercon" : ""',
	},
	"conthresh" => {
		"perl" => '(defined $value && $value != $vdef)? " -conthresh=$value" : ""',
	},
	"conpath" => {
		"perl" => '($value && $value ne $vdef)? " -conpath=$value" : ""',
	},
	"conextn" => {
		"perl" => '($value && $value ne $vdef)? " -conextn=$value" : ""',
	},
	"cpdbpath" => {
		"perl" => '($value && $value ne $vdef)? " -cpdbpath=$value" : ""',
	},
	"cpdbextn" => {
		"perl" => '($value && $value ne $vdef)? " -cpdbextn=$value" : ""',
	},
	"filterpsim" => {
		"perl" => '($value)? " -filterpsim" : ""',
	},
	"output" => {
	},
	"sigpath" => {
		"perl" => '" -sigpath=$value"',
	},
	"sigextn" => {
		"perl" => '" -sigextn=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"siggen" => {
		"perl" => '"siggen"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"algpath" => 1,
	"algextn" => 2,
	"sparsity" => 3,
	"randomise" => 4,
	"seqoption" => 5,
	"datafile" => 6,
	"conoption" => 7,
	"filtercon" => 8,
	"conthresh" => 9,
	"conpath" => 10,
	"conextn" => 11,
	"cpdbpath" => 12,
	"cpdbextn" => 13,
	"filterpsim" => 14,
	"sigpath" => 15,
	"sigextn" => 16,
	"auto" => 17,
	"siggen" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"siggen",
	"algpath",
	"algextn",
	"sparsity",
	"randomise",
	"seqoption",
	"datafile",
	"conoption",
	"filtercon",
	"conthresh",
	"conpath",
	"conextn",
	"cpdbpath",
	"cpdbextn",
	"filterpsim",
	"sigpath",
	"sigextn",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"algpath" => 0,
	"algextn" => 0,
	"required" => 0,
	"sparsity" => 0,
	"randomise" => 0,
	"advanced" => 0,
	"seqoption" => 0,
	"datafile" => 0,
	"conoption" => 0,
	"filtercon" => 0,
	"conthresh" => 0,
	"conpath" => 0,
	"conextn" => 0,
	"cpdbpath" => 0,
	"cpdbextn" => 0,
	"filterpsim" => 0,
	"output" => 0,
	"sigpath" => 0,
	"sigextn" => 0,
	"auto" => 1,
	"siggen" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"algpath" => 0,
	"algextn" => 0,
	"required" => 0,
	"sparsity" => 0,
	"randomise" => 0,
	"advanced" => 0,
	"seqoption" => 0,
	"datafile" => 0,
	"conoption" => 0,
	"filtercon" => 0,
	"conthresh" => 0,
	"conpath" => 0,
	"conextn" => 0,
	"cpdbpath" => 0,
	"cpdbextn" => 0,
	"filterpsim" => 0,
	"output" => 0,
	"sigpath" => 0,
	"sigextn" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"algpath" => 1,
	"algextn" => 1,
	"required" => 0,
	"sparsity" => 1,
	"randomise" => 0,
	"advanced" => 0,
	"seqoption" => 1,
	"datafile" => 0,
	"conoption" => 1,
	"filtercon" => 0,
	"conthresh" => 0,
	"conpath" => 0,
	"conextn" => 0,
	"cpdbpath" => 0,
	"cpdbextn" => 0,
	"filterpsim" => 0,
	"output" => 0,
	"sigpath" => 1,
	"sigextn" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"algpath" => "Location of alignment files for input (-algpath)",
	"algextn" => "Extension of alignment files for input (-algextn)",
	"required" => "required Section",
	"sparsity" => "% sparsity of signature (-sparsity)",
	"randomise" => "Generate a randomised signature (-randomise)",
	"advanced" => "advanced Section",
	"seqoption" => "Select number -- Sequence variability scoring method [select  values] (-seqoption)",
	"datafile" => "Substitution matrix to be used (-datafile)",
	"conoption" => "Select number -- Residue contacts scoring method [select  values] (-conoption)",
	"filtercon" => "Ignore alignment positions making less than a threshold number of contacts (-filtercon)",
	"conthresh" => "Threshold contact number (-conthresh)",
	"conpath" => "Location of contact files for input (-conpath)",
	"conextn" => "Extension of contact files (-conextn)",
	"cpdbpath" => "Location of coordinate files for input (embl-like format) (-cpdbpath)",
	"cpdbextn" => "Extension of coordinate files (embl-like format) (-cpdbextn)",
	"filterpsim" => "Ignore alignment postitions with post_similar value of 0 (-filterpsim)",
	"output" => "output Section",
	"sigpath" => "Location of signature files for output (-sigpath)",
	"sigextn" => "Extension of signature files for output (-sigextn)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"algpath" => 0,
	"algextn" => 0,
	"required" => 0,
	"sparsity" => 0,
	"randomise" => 0,
	"advanced" => 0,
	"seqoption" => 0,
	"datafile" => 0,
	"conoption" => 0,
	"filtercon" => 0,
	"conthresh" => 0,
	"conpath" => 0,
	"conextn" => 0,
	"cpdbpath" => 0,
	"cpdbextn" => 0,
	"filterpsim" => 0,
	"output" => 0,
	"sigpath" => 0,
	"sigextn" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['algpath','algextn',],
	"required" => ['sparsity','randomise',],
	"advanced" => ['seqoption','datafile','conoption','filtercon','conthresh','conpath','conextn','cpdbpath','cpdbextn','filterpsim',],
	"seqoption" => ['1','Substitution matrix','2','Residue class','3','None',],
	"datafile" => ['1','','2','','3','',],
	"conoption" => ['1','Number','2','Conservation','3','Number and conservation','4','None',],
	"output" => ['sigpath','sigextn',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"seqoption" => ",",
	"conoption" => ",",

    };

    $self->{VDEF}  = {
	"algextn" => '.align',
	"sparsity" => '10',
	"randomise" => '0',
	"seqoption" => ['3',],
	"datafile" => './EBLOSUM62',
	"conoption" => ['4',],
	"filtercon" => '0',
	"conthresh" => '10',
	"conpath" => '/data/contacts/',
	"conextn" => '.con',
	"cpdbpath" => '/data/cpdbscop/',
	"cpdbextn" => '.pxyz',
	"filterpsim" => '0',
	"sigpath" => './',
	"sigextn" => '.sig',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"algpath" => { "perl" => '1' },
	"algextn" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"sparsity" => { "perl" => '1' },
	"randomise" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"seqoption" => {
		"acd" => '@(!$(randomise))',
	},
	"datafile" => {
		"acd" => '@($(seqoption)==1)',
	},
	"conoption" => {
		"acd" => '@(!$(randomise))',
	},
	"filtercon" => {
		"acd" => '@(!$(randomise))',
	},
	"conthresh" => {
		"perl" => '$filtercon',
		"acd" => '$filtercon',
	},
	"conpath" => {
		"acd" => '@(!$(randomise))',
	},
	"conextn" => {
		"acd" => '@(!$(randomise))',
	},
	"cpdbpath" => {
		"acd" => '@(!$(randomise))',
	},
	"cpdbextn" => {
		"acd" => '@(!$(randomise))',
	},
	"filterpsim" => {
		"acd" => '@(!$(randomise))',
	},
	"output" => { "perl" => '1' },
	"sigpath" => { "perl" => '1' },
	"sigextn" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

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
	"init" => 0,
	"input" => 0,
	"algpath" => 0,
	"algextn" => 0,
	"required" => 0,
	"sparsity" => 0,
	"randomise" => 0,
	"advanced" => 0,
	"seqoption" => 0,
	"datafile" => 0,
	"conoption" => 0,
	"filtercon" => 0,
	"conthresh" => 0,
	"conpath" => 0,
	"conextn" => 0,
	"cpdbpath" => 0,
	"cpdbextn" => 0,
	"filterpsim" => 0,
	"output" => 0,
	"sigpath" => 0,
	"sigextn" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"algpath" => 1,
	"algextn" => 1,
	"required" => 0,
	"sparsity" => 1,
	"randomise" => 0,
	"advanced" => 0,
	"seqoption" => 1,
	"datafile" => 0,
	"conoption" => 1,
	"filtercon" => 0,
	"conthresh" => 0,
	"conpath" => 0,
	"conextn" => 0,
	"cpdbpath" => 0,
	"cpdbextn" => 0,
	"filterpsim" => 0,
	"output" => 0,
	"sigpath" => 1,
	"sigextn" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/siggen.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

