# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::emowse
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::emowse

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::emowse

      Bioperl class for:

	EMOWSE	Protein identification by mass spectrometry (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/emowse.html 
         for available values):


		emowse (String)

		init (String)

		sequences (Sequence)
			sequences -- protein [sequences] (-sequences)
			pipe: seqsfile

		infile (InFile)
			Name of molecular weight data file (-infile)

		weight (Integer)
			Whole sequence molwt (-weight)

		enzyme (Excl)
			Enzyme or reagent -- Enzymes and reagents (-enzyme)

		aadata (String)
			Amino acid data file (-aadata)

		pcrange (Integer)
			Allowed whole sequence weight variability (-pcrange)

		frequencies (String)
			Frequencies file (-frequencies)

		tolerance (Float)
			tolerance -- enter a number (-tolerance)

		partials (Float)
			Partials factor (-partials)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/emowse.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::emowse;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $emowse = Bio::Tools::Run::PiseApplication::emowse->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::emowse object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $emowse = $factory->program('emowse');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::emowse.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/emowse.pm

    $self->{COMMAND}   = "emowse";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EMOWSE";

    $self->{DESCRIPTION}   = "Protein identification by mass spectrometry (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:composition",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/emowse.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"emowse",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"emowse",
	"init",
	"input", 	# input Section
	"sequences", 	# sequences -- protein [sequences] (-sequences)
	"infile", 	# Name of molecular weight data file (-infile)
	"required", 	# required Section
	"weight", 	# Whole sequence molwt (-weight)
	"advanced", 	# advanced Section
	"enzyme", 	# Enzyme or reagent -- Enzymes and reagents (-enzyme)
	"aadata", 	# Amino acid data file (-aadata)
	"pcrange", 	# Allowed whole sequence weight variability (-pcrange)
	"frequencies", 	# Frequencies file (-frequencies)
	"tolerance", 	# tolerance -- enter a number (-tolerance)
	"partials", 	# Partials factor (-partials)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"emowse" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequences" => 'Sequence',
	"infile" => 'InFile',
	"required" => 'Paragraph',
	"weight" => 'Integer',
	"advanced" => 'Paragraph',
	"enzyme" => 'Excl',
	"aadata" => 'String',
	"pcrange" => 'Integer',
	"frequencies" => 'String',
	"tolerance" => 'Float',
	"partials" => 'Float',
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
	"sequences" => {
		"perl" => '" -sequences=$value -sformat=fasta"',
	},
	"infile" => {
		"perl" => '" -infile=$value"',
	},
	"required" => {
	},
	"weight" => {
		"perl" => '" -weight=$value"',
	},
	"advanced" => {
	},
	"enzyme" => {
		"perl" => '" -enzyme=$value"',
	},
	"aadata" => {
		"perl" => '($value && $value ne $vdef)? " -aadata=$value" : ""',
	},
	"pcrange" => {
		"perl" => '(defined $value && $value != $vdef)? " -pcrange=$value" : ""',
	},
	"frequencies" => {
		"perl" => '($value && $value ne $vdef)? " -frequencies=$value" : ""',
	},
	"tolerance" => {
		"perl" => '(defined $value && $value != $vdef)? " -tolerance=$value" : ""',
	},
	"partials" => {
		"perl" => '(defined $value && $value != $vdef)? " -partials=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"emowse" => {
		"perl" => '"emowse"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequences" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequences" => 1,
	"infile" => 2,
	"weight" => 3,
	"enzyme" => 4,
	"aadata" => 5,
	"pcrange" => 6,
	"frequencies" => 7,
	"tolerance" => 8,
	"partials" => 9,
	"outfile" => 10,
	"auto" => 11,
	"emowse" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"emowse",
	"sequences",
	"infile",
	"weight",
	"enzyme",
	"aadata",
	"pcrange",
	"frequencies",
	"tolerance",
	"partials",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequences" => 0,
	"infile" => 0,
	"required" => 0,
	"weight" => 0,
	"advanced" => 0,
	"enzyme" => 0,
	"aadata" => 0,
	"pcrange" => 0,
	"frequencies" => 0,
	"tolerance" => 0,
	"partials" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"emowse" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"infile" => 0,
	"required" => 0,
	"weight" => 0,
	"advanced" => 0,
	"enzyme" => 0,
	"aadata" => 0,
	"pcrange" => 0,
	"frequencies" => 0,
	"tolerance" => 0,
	"partials" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 1,
	"infile" => 1,
	"required" => 0,
	"weight" => 1,
	"advanced" => 0,
	"enzyme" => 1,
	"aadata" => 0,
	"pcrange" => 0,
	"frequencies" => 0,
	"tolerance" => 0,
	"partials" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequences" => "sequences -- protein [sequences] (-sequences)",
	"infile" => "Name of molecular weight data file (-infile)",
	"required" => "required Section",
	"weight" => "Whole sequence molwt (-weight)",
	"advanced" => "advanced Section",
	"enzyme" => "Enzyme or reagent -- Enzymes and reagents (-enzyme)",
	"aadata" => "Amino acid data file (-aadata)",
	"pcrange" => "Allowed whole sequence weight variability (-pcrange)",
	"frequencies" => "Frequencies file (-frequencies)",
	"tolerance" => "tolerance -- enter a number (-tolerance)",
	"partials" => "Partials factor (-partials)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"infile" => 0,
	"required" => 0,
	"weight" => 0,
	"advanced" => 0,
	"enzyme" => 0,
	"aadata" => 0,
	"pcrange" => 0,
	"frequencies" => 0,
	"tolerance" => 0,
	"partials" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequences','infile',],
	"required" => ['weight',],
	"advanced" => ['enzyme','aadata','pcrange','frequencies','tolerance','partials',],
	"enzyme" => ['1','Trypsin','2','Lys-C','3','Arg-C','4','Asp-N','5','V8-bicarb','6','V8-phosph','7','Chymotrypsin','8','CNBr',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"weight" => '0',
	"enzyme" => '1',
	"aadata" => 'Eamino.dat',
	"pcrange" => '25',
	"frequencies" => 'Efreqs.dat',
	"tolerance" => '0.1',
	"partials" => '0.4',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequences" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"weight" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"enzyme" => { "perl" => '1' },
	"aadata" => { "perl" => '1' },
	"pcrange" => { "perl" => '1' },
	"frequencies" => { "perl" => '1' },
	"tolerance" => { "perl" => '1' },
	"partials" => { "perl" => '1' },
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
	"sequences" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 0,
	"infile" => 0,
	"required" => 0,
	"weight" => 0,
	"advanced" => 0,
	"enzyme" => 0,
	"aadata" => 0,
	"pcrange" => 0,
	"frequencies" => 0,
	"tolerance" => 0,
	"partials" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequences" => 1,
	"infile" => 1,
	"required" => 0,
	"weight" => 1,
	"advanced" => 0,
	"enzyme" => 1,
	"aadata" => 0,
	"pcrange" => 0,
	"frequencies" => 0,
	"tolerance" => 0,
	"partials" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"aadata" => [
		"Molecular weight data for amino acids",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/emowse.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

