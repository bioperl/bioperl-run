# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::coderet
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::coderet

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::coderet

      Bioperl class for:

	CODERET	Extract CDS, mRNA and translations from feature tables (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/coderet.html 
         for available values):


		coderet (String)

		init (String)

		seqall (Sequence)
			seqall -- DNA [sequences] (-seqall)
			pipe: seqsfile

		cds (Switch)
			Extract CDS sequences (-cds)

		mrna (Switch)
			Extract mrna sequences (-mrna)

		translation (Switch)
			Extract translated sequences (-translation)

		seqout (OutFile)
			seqout (-seqout)
			pipe: seqfile

		seqout_sformat (Excl)
			Output format for: seqout

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

http://bioweb.pasteur.fr/seqanal/interfaces/coderet.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::coderet;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $coderet = Bio::Tools::Run::PiseApplication::coderet->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::coderet object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $coderet = $factory->program('coderet');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::coderet.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/coderet.pm

    $self->{COMMAND}   = "coderet";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CODERET";

    $self->{DESCRIPTION}   = "Extract CDS, mRNA and translations from feature tables (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "feature tables",

         "nucleic:translation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/coderet.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"coderet",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"coderet",
	"init",
	"input", 	# input Section
	"seqall", 	# seqall -- DNA [sequences] (-seqall)
	"advanced", 	# advanced Section
	"cds", 	# Extract CDS sequences (-cds)
	"mrna", 	# Extract mrna sequences (-mrna)
	"translation", 	# Extract translated sequences (-translation)
	"output", 	# output Section
	"seqout", 	# seqout (-seqout)
	"seqout_sformat", 	# Output format for: seqout
	"auto",

    ];

    $self->{TYPE}  = {
	"coderet" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"seqall" => 'Sequence',
	"advanced" => 'Paragraph',
	"cds" => 'Switch',
	"mrna" => 'Switch',
	"translation" => 'Switch',
	"output" => 'Paragraph',
	"seqout" => 'OutFile',
	"seqout_sformat" => 'Excl',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"seqall" => {
		"perl" => '" -seqall=$value"',
	},
	"advanced" => {
	},
	"cds" => {
		"perl" => '($value)? "" : " -nocds"',
	},
	"mrna" => {
		"perl" => '($value)? "" : " -nomrna"',
	},
	"translation" => {
		"perl" => '($value)? "" : " -notranslation"',
	},
	"output" => {
	},
	"seqout" => {
		"perl" => '" -seqout=$value"',
	},
	"seqout_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"coderet" => {
		"perl" => '"coderet"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seqall" => [2,4,14],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"seqall" => 1,
	"cds" => 2,
	"mrna" => 3,
	"translation" => 4,
	"seqout" => 5,
	"seqout_sformat" => 6,
	"auto" => 7,
	"coderet" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"coderet",
	"seqall",
	"cds",
	"mrna",
	"translation",
	"seqout",
	"seqout_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"cds" => 0,
	"mrna" => 0,
	"translation" => 0,
	"output" => 0,
	"seqout" => 0,
	"seqout_sformat" => 0,
	"auto" => 1,
	"coderet" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"cds" => 0,
	"mrna" => 0,
	"translation" => 0,
	"output" => 0,
	"seqout" => 0,
	"seqout_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 1,
	"advanced" => 0,
	"cds" => 0,
	"mrna" => 0,
	"translation" => 0,
	"output" => 0,
	"seqout" => 1,
	"seqout_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"seqall" => "seqall -- DNA [sequences] (-seqall)",
	"advanced" => "advanced Section",
	"cds" => "Extract CDS sequences (-cds)",
	"mrna" => "Extract mrna sequences (-mrna)",
	"translation" => "Extract translated sequences (-translation)",
	"output" => "output Section",
	"seqout" => "seqout (-seqout)",
	"seqout_sformat" => "Output format for: seqout",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"cds" => 0,
	"mrna" => 0,
	"translation" => 0,
	"output" => 0,
	"seqout" => 0,
	"seqout_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['seqall',],
	"advanced" => ['cds','mrna','translation',],
	"output" => ['seqout','seqout_sformat',],
	"seqout_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"cds" => '1',
	"mrna" => '1',
	"translation" => '1',
	"seqout" => 'seqout.out',
	"seqout_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"seqall" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"cds" => { "perl" => '1' },
	"mrna" => { "perl" => '1' },
	"translation" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"seqout" => { "perl" => '1' },
	"seqout_sformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"seqout" => {
		 '1' => "seqfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seqall" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 0,
	"advanced" => 0,
	"cds" => 0,
	"mrna" => 0,
	"translation" => 0,
	"output" => 0,
	"seqout" => 0,
	"seqout_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"seqall" => 1,
	"advanced" => 0,
	"cds" => 0,
	"mrna" => 0,
	"translation" => 0,
	"output" => 0,
	"seqout" => 1,
	"seqout_sformat" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/coderet.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

