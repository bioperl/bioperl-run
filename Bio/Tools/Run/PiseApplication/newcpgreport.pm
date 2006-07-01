# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::newcpgreport
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::newcpgreport

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::newcpgreport

      Bioperl class for:

	NEWCPGREPORT	Report CpG rich areas (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/newcpgreport.html 
         for available values):


		newcpgreport (String)

		init (String)

		sequence (Sequence)
			sequence -- DNA [sequences] (-sequence)

		window (Integer)
			Window size (-window)

		shift (Integer)
			Shift increment (-shift)

		minlen (Integer)
			Minimum Length (-minlen)

		minoe (Float)
			Minimum observed/expected (-minoe)

		minpc (Float)
			Minimum percentage (-minpc)

		outfile (OutFile)
			outfile (-outfile)

		obsexp (Switch)
			Show observed/expected threshold line (-obsexp)

		cg (Switch)
			Show CpG rich regions (-cg)

		pc (Switch)
			Show percentage line (-pc)

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

http://bioweb.pasteur.fr/seqanal/interfaces/newcpgreport.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::newcpgreport;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $newcpgreport = Bio::Tools::Run::PiseApplication::newcpgreport->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::newcpgreport object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $newcpgreport = $factory->program('newcpgreport');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::newcpgreport.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/newcpgreport.pm

    $self->{COMMAND}   = "newcpgreport";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "NEWCPGREPORT";

    $self->{DESCRIPTION}   = "Report CpG rich areas (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "cpg islands",

         "dna features",
  ];

    $self->{DOCLINK}   = "http://www.sanger.ac.uk/Software/EMBOSS/Apps/newcpgreport.shtml";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"newcpgreport",
	"init",
	"sequence",
	"window",
	"shift",
	"minlen",
	"minoe",
	"minpc",
	"outfile",
	"obsexp",
	"cg",
	"pc",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"newcpgreport",
	"init",
	"sequence", 	# sequence -- DNA [sequences] (-sequence)
	"window", 	# Window size (-window)
	"shift", 	# Shift increment (-shift)
	"minlen", 	# Minimum Length (-minlen)
	"minoe", 	# Minimum observed/expected (-minoe)
	"minpc", 	# Minimum percentage (-minpc)
	"outfile", 	# outfile (-outfile)
	"obsexp", 	# Show observed/expected threshold line (-obsexp)
	"cg", 	# Show CpG rich regions (-cg)
	"pc", 	# Show percentage line (-pc)
	"auto",

    ];

    $self->{TYPE}  = {
	"newcpgreport" => 'String',
	"init" => 'String',
	"sequence" => 'Sequence',
	"window" => 'Integer',
	"shift" => 'Integer',
	"minlen" => 'Integer',
	"minoe" => 'Float',
	"minpc" => 'Float',
	"outfile" => 'OutFile',
	"obsexp" => 'Switch',
	"cg" => 'Switch',
	"pc" => 'Switch',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"shift" => {
		"perl" => '(defined $value && $value != $vdef)? " -shift=$value" : ""',
	},
	"minlen" => {
		"perl" => '(defined $value && $value != $vdef)? " -minlen=$value" : ""',
	},
	"minoe" => {
		"perl" => '(defined $value && $value != $vdef)? " -minoe=$value" : ""',
	},
	"minpc" => {
		"perl" => '(defined $value && $value != $vdef)? " -minpc=$value" : ""',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"obsexp" => {
		"perl" => '($value)? "" : " -noobsexp"',
	},
	"cg" => {
		"perl" => '($value)? "" : " -nocg"',
	},
	"pc" => {
		"perl" => '($value)? "" : " -nopc"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"newcpgreport" => {
		"perl" => '"newcpgreport"',
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
	"window" => 2,
	"shift" => 3,
	"minlen" => 4,
	"minoe" => 5,
	"minpc" => 6,
	"outfile" => 7,
	"obsexp" => 8,
	"cg" => 9,
	"pc" => 10,
	"auto" => 11,
	"newcpgreport" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"newcpgreport",
	"sequence",
	"window",
	"shift",
	"minlen",
	"minoe",
	"minpc",
	"outfile",
	"obsexp",
	"cg",
	"pc",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"sequence" => 0,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"outfile" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"auto" => 1,
	"newcpgreport" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"sequence" => 0,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"outfile" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"sequence" => 1,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"outfile" => 1,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"sequence" => "sequence -- DNA [sequences] (-sequence)",
	"window" => "Window size (-window)",
	"shift" => "Shift increment (-shift)",
	"minlen" => "Minimum Length (-minlen)",
	"minoe" => "Minimum observed/expected (-minoe)",
	"minpc" => "Minimum percentage (-minpc)",
	"outfile" => "outfile (-outfile)",
	"obsexp" => "Show observed/expected threshold line (-obsexp)",
	"cg" => "Show CpG rich regions (-cg)",
	"pc" => "Show percentage line (-pc)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"sequence" => 0,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"outfile" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"window" => '100',
	"shift" => '1',
	"minlen" => '200',
	"minoe" => '0.6',
	"minpc" => '50.',
	"outfile" => 'outfile.out',
	"obsexp" => '1',
	"cg" => '1',
	"pc" => '1',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"shift" => { "perl" => '1' },
	"minlen" => { "perl" => '1' },
	"minoe" => { "perl" => '1' },
	"minpc" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"obsexp" => { "perl" => '1' },
	"cg" => { "perl" => '1' },
	"pc" => { "perl" => '1' },
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
	"sequence" => 0,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"outfile" => 0,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"sequence" => 1,
	"window" => 0,
	"shift" => 0,
	"minlen" => 0,
	"minoe" => 0,
	"minpc" => 0,
	"outfile" => 1,
	"obsexp" => 0,
	"cg" => 0,
	"pc" => 0,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/newcpgreport.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

