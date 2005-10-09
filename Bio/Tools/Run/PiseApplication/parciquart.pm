# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::parciquart
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::parciquart

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::parciquart

      Bioperl class for:

	PHYLOQUART	parciquart - quartet inference by maximum parsimony method (Berry)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/parciquart.html 
         for available values):


		parciquart (String)

		infile (Sequence)
			Nucleotide Sequences Alignement File
			pipe: readseq_ok_alig

		weight (Float)
			Weight of the transversion events compared to the transition events (-w)

		gap (Switch)
			Use gap position whenever is possible for computing the distance between two taxa (-g)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/parciquart.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::parciquart;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $parciquart = Bio::Tools::Run::PiseApplication::parciquart->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::parciquart object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $parciquart = $factory->program('parciquart');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::parciquart.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/parciquart.pm

    $self->{COMMAND}   = "parciquart";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PHYLOQUART";

    $self->{DESCRIPTION}   = "parciquart - quartet inference by maximum parsimony method";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Berry";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"parciquart",
	"infile",
	"weight",
	"gap",
	"quartfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"parciquart",
	"infile", 	# Nucleotide Sequences Alignement File
	"weight", 	# Weight of the transversion events compared to the transition events (-w)
	"gap", 	# Use gap position whenever is possible for computing the distance between two taxa (-g)
	"quartfile",

    ];

    $self->{TYPE}  = {
	"parciquart" => 'String',
	"infile" => 'Sequence',
	"weight" => 'Float',
	"gap" => 'Switch',
	"quartfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"parciquart" => {
		"seqlab" => 'parciquart',
		"perl" => '"parciquart"',
	},
	"infile" => {
		"perl" => '"ln -s $infile infile.nuc; "',
	},
	"weight" => {
		"perl" => '(defined $value)? " -w$value" : "" ',
	},
	"gap" => {
		"perl" => '($value)? " -g1" : "" ',
	},
	"quartfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"quartfile" => 'quartfile',

    };

    $self->{SEQFMT}  = {
	"infile" => [11],

    };

    $self->{GROUP}  = {
	"parciquart" => 0,
	"infile" => -10,
	"weight" => 1,
	"gap" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"parciquart",
	"quartfile",
	"weight",
	"gap",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"parciquart" => 1,
	"infile" => 0,
	"weight" => 0,
	"gap" => 0,
	"quartfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"parciquart" => 1,
	"infile" => 0,
	"weight" => 0,
	"gap" => 0,
	"quartfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"parciquart" => 0,
	"infile" => 1,
	"weight" => 0,
	"gap" => 0,
	"quartfile" => 0,

    };

    $self->{PROMPT}  = {
	"parciquart" => "",
	"infile" => "Nucleotide Sequences Alignement File",
	"weight" => "Weight of the transversion events compared to the transition events (-w)",
	"gap" => "Use gap position whenever is possible for computing the distance between two taxa (-g)",
	"quartfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"parciquart" => 0,
	"infile" => 0,
	"weight" => 0,
	"gap" => 0,
	"quartfile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gap" => '0',

    };

    $self->{PRECOND}  = {
	"parciquart" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"weight" => { "perl" => '1' },
	"gap" => { "perl" => '1' },
	"quartfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"quartfile" => {
		 '1' => "quartfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"parciquart" => 0,
	"infile" => 0,
	"weight" => 0,
	"gap" => 0,
	"quartfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"parciquart" => 1,
	"infile" => 1,
	"weight" => 0,
	"gap" => 0,
	"quartfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"weight" => [
		"Indicate the weight of the transversion events compared to the transition events when computing the parcimony value of a topology. Eg, -k2.5 gives 2.5 times more weight to transversions than to transitions.",
	],
	"gap" => [
		"If out, drop any position that contains a gap from the whole analysis.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/parciquart.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

