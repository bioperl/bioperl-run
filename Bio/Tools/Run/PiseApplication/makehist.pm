# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::makehist
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::makehist

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::makehist

      Bioperl class for:

	SAM	makehist - create a histogram from a score file (R. Hughey, A. Krogh)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/makehist.html 
         for available values):


		makehist (String)

		run (String)
			Run name

		Nllfile (InFile)
			Score file (-Nllfile)
			pipe: sam_score

		histbins (Integer)
			Number of bins (-histbins)

		plotps (Excl)
			Creates a postscript file (-plotps)

		plotmax (Float)
			Highest Y axis value (-plotmax)

		plotmin (Float)
			Lowest Y axis value (-plotmin)

		plotleft (Float)
			Lowest X axis value (-plotleft)

		plotright (Float)
			Highest X axis value (-plotright)

		plotline (Float)
			Vertical line at plotline if <> 0 (-plotline)

		plotnegate (Switch)
			Negate scores (-plotnegate)

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

http://bioweb.pasteur.fr/seqanal/interfaces/makehist.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::makehist;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $makehist = Bio::Tools::Run::PiseApplication::makehist->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::makehist object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $makehist = $factory->program('makehist');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::makehist.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/makehist.pm

    $self->{COMMAND}   = "makehist";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "makehist - create a histogram from a score file";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "R. Hughey, A. Krogh";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"makehist",
	"run",
	"Nllfile",
	"outfiles",
	"output",
	"plot_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"makehist",
	"run", 	# Run name
	"Nllfile", 	# Score file (-Nllfile)
	"outfiles",
	"output", 	# Output options
	"histbins", 	# Number of bins (-histbins)
	"plotps", 	# Creates a postscript file (-plotps)
	"plot_options", 	# Plot options
	"plotmax", 	# Highest Y axis value (-plotmax)
	"plotmin", 	# Lowest Y axis value (-plotmin)
	"plotleft", 	# Lowest X axis value (-plotleft)
	"plotright", 	# Highest X axis value (-plotright)
	"plotline", 	# Vertical line at plotline if <> 0 (-plotline)
	"plotnegate", 	# Negate scores (-plotnegate)

    ];

    $self->{TYPE}  = {
	"makehist" => 'String',
	"run" => 'String',
	"Nllfile" => 'InFile',
	"outfiles" => 'Results',
	"output" => 'Paragraph',
	"histbins" => 'Integer',
	"plotps" => 'Excl',
	"plot_options" => 'Paragraph',
	"plotmax" => 'Float',
	"plotmin" => 'Float',
	"plotleft" => 'Float',
	"plotright" => 'Float',
	"plotline" => 'Float',
	"plotnegate" => 'Switch',

    };

    $self->{FORMAT}  = {
	"makehist" => {
		"seqlab" => 'makehist',
		"perl" => '"makehist"',
	},
	"run" => {
		"perl" => '" $value"',
	},
	"Nllfile" => {
		"perl" => '" -Nllfile $value"',
	},
	"outfiles" => {
	},
	"output" => {
	},
	"histbins" => {
		"perl" => '($value && $value != $vdef)? " -histbins $value" : "" ',
	},
	"plotps" => {
		"perl" => '($value && $value ne $vdef)? " -plotps $value" : "" ',
	},
	"plot_options" => {
	},
	"plotmax" => {
		"perl" => '(defined $value)? " -plotmax $value" : "" ',
	},
	"plotmin" => {
		"perl" => '(defined $value)? " -plotmin $value" : "" ',
	},
	"plotleft" => {
		"perl" => '(defined $value)? " -plotleft $value" : "" ',
	},
	"plotright" => {
		"perl" => '(defined $value)? " -plotright $value" : "" ',
	},
	"plotline" => {
		"perl" => '(defined $value)? " -plotline $value" : "" ',
	},
	"plotnegate" => {
		"perl" => '($value)? " -plotnegate 1" : "" ',
	},

    };

    $self->{FILENAMES}  = {
	"outfiles" => '*.ps *.data *.plt',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"makehist" => 0,
	"run" => 1,
	"Nllfile" => 2,
	"output" => 2,
	"histbins" => 2,
	"plotps" => 2,
	"plot_options" => 2,
	"plotmax" => 2,
	"plotmin" => 2,
	"plotleft" => 2,
	"plotright" => 2,
	"plotline" => 2,
	"plotnegate" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"makehist",
	"outfiles",
	"run",
	"Nllfile",
	"output",
	"histbins",
	"plotps",
	"plot_options",
	"plotmax",
	"plotmin",
	"plotleft",
	"plotright",
	"plotline",
	"plotnegate",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"makehist" => 1,
	"run" => 0,
	"Nllfile" => 0,
	"outfiles" => 0,
	"output" => 0,
	"histbins" => 0,
	"plotps" => 0,
	"plot_options" => 0,
	"plotmax" => 0,
	"plotmin" => 0,
	"plotleft" => 0,
	"plotright" => 0,
	"plotline" => 0,
	"plotnegate" => 0,

    };

    $self->{ISCOMMAND}  = {
	"makehist" => 1,
	"run" => 0,
	"Nllfile" => 0,
	"outfiles" => 0,
	"output" => 0,
	"histbins" => 0,
	"plotps" => 0,
	"plot_options" => 0,
	"plotmax" => 0,
	"plotmin" => 0,
	"plotleft" => 0,
	"plotright" => 0,
	"plotline" => 0,
	"plotnegate" => 0,

    };

    $self->{ISMANDATORY}  = {
	"makehist" => 0,
	"run" => 1,
	"Nllfile" => 1,
	"outfiles" => 0,
	"output" => 0,
	"histbins" => 0,
	"plotps" => 0,
	"plot_options" => 0,
	"plotmax" => 0,
	"plotmin" => 0,
	"plotleft" => 0,
	"plotright" => 0,
	"plotline" => 0,
	"plotnegate" => 0,

    };

    $self->{PROMPT}  = {
	"makehist" => "",
	"run" => "Run name",
	"Nllfile" => "Score file (-Nllfile)",
	"outfiles" => "",
	"output" => "Output options",
	"histbins" => "Number of bins (-histbins)",
	"plotps" => "Creates a postscript file (-plotps)",
	"plot_options" => "Plot options",
	"plotmax" => "Highest Y axis value (-plotmax)",
	"plotmin" => "Lowest Y axis value (-plotmin)",
	"plotleft" => "Lowest X axis value (-plotleft)",
	"plotright" => "Highest X axis value (-plotright)",
	"plotline" => "Vertical line at plotline if <> 0 (-plotline)",
	"plotnegate" => "Negate scores (-plotnegate)",

    };

    $self->{ISSTANDOUT}  = {
	"makehist" => 0,
	"run" => 0,
	"Nllfile" => 0,
	"outfiles" => 0,
	"output" => 0,
	"histbins" => 0,
	"plotps" => 0,
	"plot_options" => 0,
	"plotmax" => 0,
	"plotmin" => 0,
	"plotleft" => 0,
	"plotright" => 0,
	"plotline" => 0,
	"plotnegate" => 0,

    };

    $self->{VLIST}  = {

	"output" => ['histbins','plotps',],
	"plotps" => ['0','0: only a .plt file and one or two .data files are generated','1','1: PostScript, default rectangular shape','2','2: PostScript, square plot','3','3: PostScript + .plt and .data files',],
	"plot_options" => ['plotmax','plotmin','plotleft','plotright','plotline','plotnegate',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"run" => 'test',
	"histbins" => '10',
	"plotps" => '1',
	"plotnegate" => '0',

    };

    $self->{PRECOND}  = {
	"makehist" => { "perl" => '1' },
	"run" => { "perl" => '1' },
	"Nllfile" => { "perl" => '1' },
	"outfiles" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"histbins" => { "perl" => '1' },
	"plotps" => { "perl" => '1' },
	"plot_options" => { "perl" => '1' },
	"plotmax" => { "perl" => '1' },
	"plotmin" => { "perl" => '1' },
	"plotleft" => { "perl" => '1' },
	"plotright" => { "perl" => '1' },
	"plotline" => { "perl" => '1' },
	"plotnegate" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"Nllfile" => {
		 "sam_score" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"makehist" => 0,
	"run" => 0,
	"Nllfile" => 0,
	"outfiles" => 0,
	"output" => 0,
	"histbins" => 0,
	"plotps" => 0,
	"plot_options" => 0,
	"plotmax" => 0,
	"plotmin" => 0,
	"plotleft" => 0,
	"plotright" => 0,
	"plotline" => 0,
	"plotnegate" => 0,

    };

    $self->{ISSIMPLE}  = {
	"makehist" => 1,
	"run" => 0,
	"Nllfile" => 1,
	"outfiles" => 0,
	"output" => 0,
	"histbins" => 0,
	"plotps" => 0,
	"plot_options" => 0,
	"plotmax" => 0,
	"plotmin" => 0,
	"plotleft" => 0,
	"plotright" => 0,
	"plotline" => 0,
	"plotnegate" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"plotmin" => [
		"Y axis calculated internally if plotmax = plotmin",
	],
	"plotright" => [
		"X axis calculated internally if plotleft = plotright",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/makehist.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

