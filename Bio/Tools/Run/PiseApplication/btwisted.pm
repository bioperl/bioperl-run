# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::btwisted
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::btwisted

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::btwisted

      Bioperl class for:

	BTWISTED	Calculates the twisting in a B-DNA sequence (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/btwisted.html 
         for available values):


		btwisted (String)

		init (String)

		sequence (Sequence)
			sequence -- PureDNA [single sequence] (-sequence)
			pipe: seqfile

		angledata (String)
			File containing base pair twist angles (-angledata)

		energydata (String)
			File containing base pair stacking energies (-energydata)

		outfile (OutFile)
			outfile (-outfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/btwisted.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::btwisted;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $btwisted = Bio::Tools::Run::PiseApplication::btwisted->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::btwisted object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $btwisted = $factory->program('btwisted');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::btwisted.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/btwisted.pm

    $self->{COMMAND}   = "btwisted";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BTWISTED";

    $self->{DESCRIPTION}   = "Calculates the twisting in a B-DNA sequence (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/btwisted.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"btwisted",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"btwisted",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- PureDNA [single sequence] (-sequence)
	"advanced", 	# advanced Section
	"angledata", 	# File containing base pair twist angles (-angledata)
	"energydata", 	# File containing base pair stacking energies (-energydata)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"btwisted" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"angledata" => 'String',
	"energydata" => 'String',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"angledata" => {
		"perl" => '($value && $value ne $vdef)? " -angledata=$value" : ""',
	},
	"energydata" => {
		"perl" => '($value && $value ne $vdef)? " -energydata=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"btwisted" => {
		"perl" => '"btwisted"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"angledata" => 2,
	"energydata" => 3,
	"outfile" => 4,
	"auto" => 5,
	"btwisted" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"btwisted",
	"sequence",
	"angledata",
	"energydata",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"angledata" => 0,
	"energydata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"btwisted" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"angledata" => 0,
	"energydata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"angledata" => 0,
	"energydata" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- PureDNA [single sequence] (-sequence)",
	"advanced" => "advanced Section",
	"angledata" => "File containing base pair twist angles (-angledata)",
	"energydata" => "File containing base pair stacking energies (-energydata)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"angledata" => 0,
	"energydata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['angledata','energydata',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"angledata" => 'Eangles.dat',
	"energydata" => 'Eenergy.dat',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"angledata" => { "perl" => '1' },
	"energydata" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"angledata" => 0,
	"energydata" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"angledata" => 0,
	"energydata" => 0,
	"output" => 0,
	"outfile" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/btwisted.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

