# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::cpgreport
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::cpgreport

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cpgreport

      Bioperl class for:

	CPGREPORT	Reports all CpG rich regions (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/cpgreport.html 
         for available values):


		cpgreport (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)
			pipe: seqsfile

		score (Integer)
			CpG score (-score)

		outfile (OutFile)
			outfile (-outfile)

		featout (OutFile)
			feature file for output (-featout)

		featout_offormat (Excl)
			Feature output format (-offormat)

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

http://bioweb.pasteur.fr/seqanal/interfaces/cpgreport.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::cpgreport;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cpgreport = Bio::Tools::Run::PiseApplication::cpgreport->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cpgreport object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $cpgreport = $factory->program('cpgreport');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::cpgreport.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cpgreport.pm

    $self->{COMMAND}   = "cpgreport";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CPGREPORT";

    $self->{DESCRIPTION}   = "Reports all CpG rich regions (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:cpg islands",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/cpgreport.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cpgreport",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cpgreport",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"required", 	# required Section
	"score", 	# CpG score (-score)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"featout", 	# feature file for output (-featout)
	"featout_offormat", 	# Feature output format (-offormat)
	"auto",

    ];

    $self->{TYPE}  = {
	"cpgreport" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"score" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"featout" => 'OutFile',
	"featout_offormat" => 'Excl',
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
	"required" => {
	},
	"score" => {
		"perl" => '" -score=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"featout" => {
		"perl" => '" -featout=$value"',
	},
	"featout_offormat" => {
		"perl" => '($value)? " -offormat=$value" : "" ',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"cpgreport" => {
		"perl" => '"cpgreport"',
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
	"score" => 2,
	"outfile" => 3,
	"featout" => 4,
	"featout_offormat" => 4,
	"auto" => 5,
	"cpgreport" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"cpgreport",
	"sequence",
	"score",
	"outfile",
	"featout",
	"featout_offormat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"auto" => 1,
	"cpgreport" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"score" => 1,
	"output" => 0,
	"outfile" => 1,
	"featout" => 1,
	"featout_offormat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"required" => "required Section",
	"score" => "CpG score (-score)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"featout" => "feature file for output (-featout)",
	"featout_offormat" => "Feature output format (-offormat)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['score',],
	"output" => ['outfile','featout','featout_offormat',],
	"featout_offormat" => ['embl','embl','gff','gff','swiss','swiss','pir','pir','nbrf','nbrf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"score" => '17',
	"outfile" => 'outfile.out',
	"featout" => 'featout.out',
	"featout_offormat" => 'gff',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"score" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"featout" => { "perl" => '1' },
	"featout_offormat" => { "perl" => '1' },
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
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"score" => 0,
	"output" => 0,
	"outfile" => 0,
	"featout" => 0,
	"featout_offormat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"score" => 1,
	"output" => 0,
	"outfile" => 1,
	"featout" => 1,
	"featout_offormat" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"score" => [
		"This sets the score for each CG sequence found. A value of 17 is more sensitive, but 28 has also been used with some success.",
	],
	"featout" => [
		"File for output features",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cpgreport.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

