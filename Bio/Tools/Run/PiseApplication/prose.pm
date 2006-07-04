# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::prose
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::prose

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prose

      Bioperl class for:

	prose	Prosite Pattern search (K. Schuerer)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/prose.html 
         for available values):


		prose (String)

		outfile (OutFile)

		infile (Sequence)
			Protein Sequence File

		skip (Switch)
			include abundant patterns

		report (Excl)
			report occurences (-m)

		case (Switch)
			search case-sensitive

		warn (Switch)
			warn of inproper prosite pattern syntaxe

		listfile (InFile)
			Pattern List File (-l)

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

http://bioweb.pasteur.fr/seqanal/interfaces/prose.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::prose;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prose = Bio::Tools::Run::PiseApplication::prose->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prose object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $prose = $factory->program('prose');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::prose.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prose.pm

    $self->{COMMAND}   = "prose";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "prose";

    $self->{DESCRIPTION}   = "Prosite Pattern search";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{AUTHORS}   = "K. Schuerer";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prose",
	"outfile",
	"infile",
	"skip",
	"report",
	"case",
	"warn",
	"patterns",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prose",
	"outfile",
	"infile", 	# Protein Sequence File
	"skip", 	# include abundant patterns
	"report", 	# report occurences (-m)
	"case", 	# search case-sensitive
	"warn", 	# warn of inproper prosite pattern syntaxe
	"patterns", 	# User defined patterns
	"listfile", 	# Pattern List File (-l)

    ];

    $self->{TYPE}  = {
	"prose" => 'String',
	"outfile" => 'OutFile',
	"infile" => 'Sequence',
	"skip" => 'Switch',
	"report" => 'Excl',
	"case" => 'Switch',
	"warn" => 'Switch',
	"patterns" => 'Paragraph',
	"listfile" => 'InFile',

    };

    $self->{FORMAT}  = {
	"prose" => {
		"perl" => '"prose"',
	},
	"outfile" => {
	},
	"infile" => {
		"perl" => '" $value"',
	},
	"skip" => {
		"perl" => '($value) ? " -s" : ""',
	},
	"report" => {
		"perl" => '(defined $value && $value ne $vdef) ? " -m $value" : ""',
	},
	"case" => {
		"perl" => '($value) ? " -c" : ""',
	},
	"warn" => {
		"perl" => '($value) ? " -w" : ""',
	},
	"patterns" => {
	},
	"listfile" => {
		"perl" => '($value && !$pattern) ? " -l $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"infile" => [8],

    };

    $self->{GROUP}  = {
	"prose" => 0,
	"infile" => 100,
	"skip" => 3,
	"report" => 3,
	"case" => 3,
	"warn" => 3,
	"patterns" => 2,
	"listfile" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"prose",
	"outfile",
	"listfile",
	"patterns",
	"report",
	"case",
	"warn",
	"skip",
	"infile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"prose" => 1,
	"outfile" => 1,
	"infile" => 0,
	"skip" => 0,
	"report" => 0,
	"case" => 0,
	"warn" => 0,
	"patterns" => 0,
	"listfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"prose" => 1,
	"outfile" => 0,
	"infile" => 0,
	"skip" => 0,
	"report" => 0,
	"case" => 0,
	"warn" => 0,
	"patterns" => 0,
	"listfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"prose" => 0,
	"outfile" => 0,
	"infile" => 1,
	"skip" => 0,
	"report" => 0,
	"case" => 0,
	"warn" => 0,
	"patterns" => 0,
	"listfile" => 0,

    };

    $self->{PROMPT}  = {
	"prose" => "",
	"outfile" => "",
	"infile" => "Protein Sequence File",
	"skip" => "include abundant patterns",
	"report" => "report occurences (-m)",
	"case" => "search case-sensitive",
	"warn" => "warn of inproper prosite pattern syntaxe",
	"patterns" => "User defined patterns",
	"listfile" => "Pattern List File (-l)",

    };

    $self->{ISSTANDOUT}  = {
	"prose" => 0,
	"outfile" => 1,
	"infile" => 0,
	"skip" => 0,
	"report" => 0,
	"case" => 0,
	"warn" => 0,
	"patterns" => 0,
	"listfile" => 0,

    };

    $self->{VLIST}  = {

	"report" => ['short','shortest only (short)','long','longest only (long)','all','all subpatterns (all)',],
	"patterns" => ['listfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => '"prose.out"',
	"skip" => '0',
	"report" => 'short',
	"case" => '0',
	"warn" => '0',

    };

    $self->{PRECOND}  = {
	"prose" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"skip" => { "perl" => '1' },
	"report" => { "perl" => '1' },
	"case" => { "perl" => '1' },
	"warn" => { "perl" => '1' },
	"patterns" => { "perl" => '1' },
	"listfile" => { "perl" => '1' },

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
	"prose" => 0,
	"outfile" => 0,
	"infile" => 0,
	"skip" => 0,
	"report" => 0,
	"case" => 0,
	"warn" => 0,
	"patterns" => 0,
	"listfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"prose" => 0,
	"outfile" => 0,
	"infile" => 1,
	"skip" => 1,
	"report" => 0,
	"case" => 0,
	"warn" => 0,
	"patterns" => 0,
	"listfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"report" => [
		"With sequence ACErrrACErrrrDFGrrrDFG and pattern	  A-C-E-x(0,)-D-F-G",
		"shortest (default): reports only ACErrrrDFG",
		"longest: reports only ACErrrACErrrrDFGrrrDFG as match",
		"all: reports ACErrrACErrrrDFGrrrDFG,	  ACErrrACErrrrDFG, ACErrrrDFGrrrDFG and ACErrrrDFG",
	],
	"listfile" => [
		"File format : one pattern per line.",
		"This option exclude the Pattern option (-p).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prose.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

