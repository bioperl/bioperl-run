# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::digest
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::digest

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::digest

      Bioperl class for:

	DIGEST	Protein proteolytic enzyme or reagent cleavage digest (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/digest.html 
         for available values):


		digest (String)

		init (String)

		sequencea (Sequence)
			sequencea -- Protein [single sequence] (-sequencea)
			pipe: seqfile

		menu (Excl)
			Select number -- Enzymes and Reagents (-menu)

		unfavoured (Switch)
			Allow unfavoured cuts (-unfavoured)

		aadata (String)
			Amino acid data file (-aadata)

		overlap (Switch)
			Show overlapping partials (-overlap)

		allpartials (Switch)
			Show all partials (-allpartials)

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

http://bioweb.pasteur.fr/seqanal/interfaces/digest.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::digest;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $digest = Bio::Tools::Run::PiseApplication::digest->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::digest object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $digest = $factory->program('digest');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::digest.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/digest.pm

    $self->{COMMAND}   = "digest";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DIGEST";

    $self->{DESCRIPTION}   = "Protein proteolytic enzyme or reagent cleavage digest (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/digest.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"digest",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"digest",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- Protein [single sequence] (-sequencea)
	"required", 	# required Section
	"menu", 	# Select number -- Enzymes and Reagents (-menu)
	"advanced", 	# advanced Section
	"unfavoured", 	# Allow unfavoured cuts (-unfavoured)
	"aadata", 	# Amino acid data file (-aadata)
	"output", 	# output Section
	"overlap", 	# Show overlapping partials (-overlap)
	"allpartials", 	# Show all partials (-allpartials)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"digest" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"required" => 'Paragraph',
	"menu" => 'Excl',
	"advanced" => 'Paragraph',
	"unfavoured" => 'Switch',
	"aadata" => 'String',
	"output" => 'Paragraph',
	"overlap" => 'Switch',
	"allpartials" => 'Switch',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequencea" => {
		"perl" => '" -sequencea=$value -sformat=fasta"',
	},
	"required" => {
	},
	"menu" => {
		"perl" => '" -menu=$value"',
	},
	"advanced" => {
	},
	"unfavoured" => {
		"perl" => '($value)? " -unfavoured" : ""',
	},
	"aadata" => {
		"perl" => '($value && $value ne $vdef)? " -aadata=$value" : ""',
	},
	"output" => {
	},
	"overlap" => {
		"perl" => '($value)? " -overlap" : ""',
	},
	"allpartials" => {
		"perl" => '($value)? " -allpartials" : ""',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"digest" => {
		"perl" => '"digest"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"menu" => 2,
	"unfavoured" => 3,
	"aadata" => 4,
	"overlap" => 5,
	"allpartials" => 6,
	"outfile" => 7,
	"auto" => 8,
	"digest" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"digest",
	"sequencea",
	"menu",
	"unfavoured",
	"aadata",
	"overlap",
	"allpartials",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequencea" => 0,
	"required" => 0,
	"menu" => 0,
	"advanced" => 0,
	"unfavoured" => 0,
	"aadata" => 0,
	"output" => 0,
	"overlap" => 0,
	"allpartials" => 0,
	"outfile" => 0,
	"auto" => 1,
	"digest" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"required" => 0,
	"menu" => 0,
	"advanced" => 0,
	"unfavoured" => 0,
	"aadata" => 0,
	"output" => 0,
	"overlap" => 0,
	"allpartials" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"required" => 0,
	"menu" => 1,
	"advanced" => 0,
	"unfavoured" => 0,
	"aadata" => 0,
	"output" => 0,
	"overlap" => 0,
	"allpartials" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequencea" => "sequencea -- Protein [single sequence] (-sequencea)",
	"required" => "required Section",
	"menu" => "Select number -- Enzymes and Reagents (-menu)",
	"advanced" => "advanced Section",
	"unfavoured" => "Allow unfavoured cuts (-unfavoured)",
	"aadata" => "Amino acid data file (-aadata)",
	"output" => "output Section",
	"overlap" => "Show overlapping partials (-overlap)",
	"allpartials" => "Show all partials (-allpartials)",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"required" => 0,
	"menu" => 0,
	"advanced" => 0,
	"unfavoured" => 0,
	"aadata" => 0,
	"output" => 0,
	"overlap" => 0,
	"allpartials" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea',],
	"required" => ['menu',],
	"menu" => ['1','Trypsin','2','Lys-C','3','Arg-C','4','Asp-N','5','V8-bicarb','6','V8-phosph','7','Chymotrypsin','8','CNBr',],
	"advanced" => ['unfavoured','aadata',],
	"output" => ['overlap','allpartials','outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"menu" => '1',
	"aadata" => 'Eamino.dat',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"menu" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"unfavoured" => { "perl" => '1' },
	"aadata" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"overlap" => { "perl" => '1' },
	"allpartials" => { "perl" => '1' },
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
	"sequencea" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"required" => 0,
	"menu" => 0,
	"advanced" => 0,
	"unfavoured" => 0,
	"aadata" => 0,
	"output" => 0,
	"overlap" => 0,
	"allpartials" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"required" => 0,
	"menu" => 1,
	"advanced" => 0,
	"unfavoured" => 0,
	"aadata" => 0,
	"output" => 0,
	"overlap" => 0,
	"allpartials" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"unfavoured" => [
		"Trypsin will not normally cut after a K if it is followed by (e.g.) another K or a P. Specifying this shows those cuts. as well as the favoured ones.",
	],
	"aadata" => [
		"Molecular weight data for amino acids",
	],
	"overlap" => [
		"Used for partial digestion. Shows all cuts from favoured cut sites plus 1..3, 2..4, 3..5 etc but not (e.g.) 2..5. Overlaps are therefore fragments with exactly one potential cut site within it.",
	],
	"allpartials" => [
		"As for overlap but fragments containing more than one potential cut site are included.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/digest.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

