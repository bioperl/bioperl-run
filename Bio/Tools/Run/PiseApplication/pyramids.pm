# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::pyramids
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::pyramids

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pyramids

      Bioperl class for:

	PYRAMIDS	A pyramidal analysis tool for sequence  clustering (JC AUDE)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/pyramids.html 
         for available values):


		pyramids (String)

		infile (InFile)
			Distances matrix File
			pipe: phylip_dist

		out_file (OutFile)

		rect (Excl)
			Matrix format

		pyr_file (OutFile)
			pipe: pyramid_file

		uti_file (OutFile)

		pyt_file (OutFile)
			pipe: pyramid_file

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

http://bioweb.pasteur.fr/seqanal/interfaces/pyramids.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::pyramids;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pyramids = Bio::Tools::Run::PiseApplication::pyramids->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pyramids object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $pyramids = $factory->program('pyramids');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::pyramids.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pyramids.pm

    $self->{COMMAND}   = "pyramids";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PYRAMIDS";

    $self->{DESCRIPTION}   = "A pyramidal analysis tool for sequence  clustering";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "JC AUDE";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pyramids",
	"infile",
	"out_file",
	"rect",
	"pyr_file",
	"uti_file",
	"pyt_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pyramids",
	"infile", 	# Distances matrix File
	"out_file",
	"rect", 	# Matrix format
	"pyr_file",
	"uti_file",
	"pyt_file",

    ];

    $self->{TYPE}  = {
	"pyramids" => 'String',
	"infile" => 'InFile',
	"out_file" => 'OutFile',
	"rect" => 'Excl',
	"pyr_file" => 'OutFile',
	"uti_file" => 'OutFile',
	"pyt_file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"pyramids" => {
		"seqlab" => 'pyramids',
		"perl" => '"pyramids"',
	},
	"infile" => {
		"perl" => '" $value"',
	},
	"out_file" => {
		"perl" => '" results"',
	},
	"rect" => {
		"perl" => '" -$value"',
	},
	"pyr_file" => {
		"perl" => '""',
	},
	"uti_file" => {
		"perl" => '""',
	},
	"pyt_file" => {
		"perl" => '""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"pyramids" => 0,
	"infile" => 2,
	"out_file" => 3,
	"rect" => 1,
	"pyr_file" => 10,
	"uti_file" => 10,
	"pyt_file" => 10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pyramids",
	"rect",
	"infile",
	"out_file",
	"pyr_file",
	"uti_file",
	"pyt_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"pyramids" => 1,
	"infile" => 0,
	"out_file" => 1,
	"rect" => 0,
	"pyr_file" => 1,
	"uti_file" => 1,
	"pyt_file" => 1,

    };

    $self->{ISCOMMAND}  = {
	"pyramids" => 1,
	"infile" => 0,
	"out_file" => 0,
	"rect" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,
	"pyt_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"pyramids" => 0,
	"infile" => 1,
	"out_file" => 0,
	"rect" => 1,
	"pyr_file" => 0,
	"uti_file" => 0,
	"pyt_file" => 0,

    };

    $self->{PROMPT}  = {
	"pyramids" => "",
	"infile" => "Distances matrix File",
	"out_file" => "",
	"rect" => "Matrix format",
	"pyr_file" => "",
	"uti_file" => "",
	"pyt_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"pyramids" => 0,
	"infile" => 0,
	"out_file" => 0,
	"rect" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,
	"pyt_file" => 0,

    };

    $self->{VLIST}  = {

	"rect" => ['RE','Rectangular (Phylip)','TS','Triangular superior','TI','Triangular inferior',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"out_file" => 'results',
	"rect" => 'RE',
	"pyr_file" => '"$out_file.pyr"',
	"uti_file" => '"$out_file.uti"',
	"pyt_file" => '"$out_file.pyt"',

    };

    $self->{PRECOND}  = {
	"pyramids" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"out_file" => { "perl" => '1' },
	"rect" => { "perl" => '1' },
	"pyr_file" => { "perl" => '1' },
	"uti_file" => { "perl" => '1' },
	"pyt_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"pyr_file" => {
		 '1' => "pyramid_file",
	},
	"pyt_file" => {
		 '1' => "pyramid_file",
	},

    };

    $self->{WITHPIPEOUT}  = {
	"pyr_file" => {
		 "pyramid_file" => ["uti_file",]
	},
	"pyt_file" => {
		 "pyramid_file" => ["uti_file",]
	},

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "phylip_dist" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"pyramids" => 0,
	"infile" => 0,
	"out_file" => 0,
	"rect" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,
	"pyt_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"pyramids" => 1,
	"infile" => 1,
	"out_file" => 0,
	"rect" => 0,
	"pyr_file" => 0,
	"uti_file" => 0,
	"pyt_file" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pyramids.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

