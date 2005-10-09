# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::distquart
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::distquart

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::distquart

      Bioperl class for:

	PHYLOQUART	distquart - quartet inference by weak four-point method (NJ) (Berry)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/distquart.html 
         for available values):


		distquart (String)

		dist (Switch)
			Reads as input inter-species distances (as opposed to sequences) (-d)

		infile (Sequence)
			Nucleotide Sequences Alignement File
			pipe: readseq_ok_alig

		gap (Switch)
			Use gap position whenever is possible for computing the distance between two taxa (-g)

		correct (Excl)
			Evolutionary model correction (-c)

		savedist (Switch)
			Save in the file outfile.dist the inter-species Hamming distances computed from the input nucleotide sequences (-s)

		distfile (InFile)
			Distances matrix File (lower triangular)
			pipe: phylip_dist

		lower (Switch)
			Lower triangular distances matrix (-l)

		outdistfile (OutFile)
			pipe: phylip_dist

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

http://bioweb.pasteur.fr/seqanal/interfaces/distquart.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::distquart;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $distquart = Bio::Tools::Run::PiseApplication::distquart->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::distquart object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $distquart = $factory->program('distquart');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::distquart.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/distquart.pm

    $self->{COMMAND}   = "distquart";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PHYLOQUART";

    $self->{DESCRIPTION}   = "distquart - quartet inference by weak four-point method (NJ)";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Berry";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"distquart",
	"dist",
	"sequence_param",
	"distfile",
	"lower",
	"quartfile",
	"outdistfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"distquart",
	"dist", 	# Reads as input inter-species distances (as opposed to sequences) (-d)
	"sequence_param", 	# Sequences parameters
	"infile", 	# Nucleotide Sequences Alignement File
	"gap", 	# Use gap position whenever is possible for computing the distance between two taxa (-g)
	"correct", 	# Evolutionary model correction (-c)
	"savedist", 	# Save in the file outfile.dist the inter-species Hamming distances computed from the input nucleotide sequences (-s)
	"distfile", 	# Distances matrix File (lower triangular)
	"lower", 	# Lower triangular distances matrix (-l)
	"quartfile",
	"outdistfile",

    ];

    $self->{TYPE}  = {
	"distquart" => 'String',
	"dist" => 'Switch',
	"sequence_param" => 'Paragraph',
	"infile" => 'Sequence',
	"gap" => 'Switch',
	"correct" => 'Excl',
	"savedist" => 'Switch',
	"distfile" => 'InFile',
	"lower" => 'Switch',
	"quartfile" => 'Results',
	"outdistfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"distquart" => {
		"seqlab" => 'distquart',
		"perl" => '"distquart"',
	},
	"dist" => {
		"perl" => '($value)? " -d1" : " -d0"',
	},
	"sequence_param" => {
	},
	"infile" => {
		"perl" => '"ln -s $infile infile.nuc; "',
	},
	"gap" => {
		"perl" => '($value)? " -g1" : "" ',
	},
	"correct" => {
		"perl" => '($value)? " -c$value" : "" ',
	},
	"savedist" => {
		"perl" => '($value)? " -s1" : "" ',
	},
	"distfile" => {
		"perl" => '"ln -s $distfile infile.dist; "',
	},
	"lower" => {
		"perl" => '($value)? " -l1" : ""',
	},
	"quartfile" => {
	},
	"outdistfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"quartfile" => 'quartfile',

    };

    $self->{SEQFMT}  = {
	"infile" => [11],

    };

    $self->{GROUP}  = {
	"distquart" => 0,
	"dist" => 1,
	"infile" => -10,
	"gap" => 1,
	"correct" => 1,
	"savedist" => 1,
	"distfile" => -10,
	"lower" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"distfile",
	"distquart",
	"sequence_param",
	"quartfile",
	"outdistfile",
	"savedist",
	"dist",
	"lower",
	"gap",
	"correct",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"distquart" => 1,
	"dist" => 0,
	"sequence_param" => 0,
	"infile" => 0,
	"gap" => 0,
	"correct" => 0,
	"savedist" => 0,
	"distfile" => 0,
	"lower" => 0,
	"quartfile" => 0,
	"outdistfile" => 1,

    };

    $self->{ISCOMMAND}  = {
	"distquart" => 1,
	"dist" => 0,
	"sequence_param" => 0,
	"infile" => 0,
	"gap" => 0,
	"correct" => 0,
	"savedist" => 0,
	"distfile" => 0,
	"lower" => 0,
	"quartfile" => 0,
	"outdistfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"distquart" => 0,
	"dist" => 0,
	"sequence_param" => 0,
	"infile" => 1,
	"gap" => 0,
	"correct" => 0,
	"savedist" => 0,
	"distfile" => 1,
	"lower" => 0,
	"quartfile" => 0,
	"outdistfile" => 0,

    };

    $self->{PROMPT}  = {
	"distquart" => "",
	"dist" => "Reads as input inter-species distances (as opposed to sequences) (-d)",
	"sequence_param" => "Sequences parameters",
	"infile" => "Nucleotide Sequences Alignement File",
	"gap" => "Use gap position whenever is possible for computing the distance between two taxa (-g)",
	"correct" => "Evolutionary model correction (-c)",
	"savedist" => "Save in the file outfile.dist the inter-species Hamming distances computed from the input nucleotide sequences (-s)",
	"distfile" => "Distances matrix File (lower triangular)",
	"lower" => "Lower triangular distances matrix (-l)",
	"quartfile" => "",
	"outdistfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"distquart" => 0,
	"dist" => 0,
	"sequence_param" => 0,
	"infile" => 0,
	"gap" => 0,
	"correct" => 0,
	"savedist" => 0,
	"distfile" => 0,
	"lower" => 0,
	"quartfile" => 0,
	"outdistfile" => 0,

    };

    $self->{VLIST}  = {

	"sequence_param" => ['infile','gap','correct','savedist',],
	"correct" => ['0','0: no correction','1','1: correct according to the Jukes-Cantor 1969 model','2','2: correct according to the 2-param Kimura 1980 model',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gap" => '0',
	"correct" => '0',
	"savedist" => '0',
	"lower" => '0',
	"outdistfile" => '"outfile.dist"',

    };

    $self->{PRECOND}  = {
	"distquart" => { "perl" => '1' },
	"dist" => { "perl" => '1' },
	"sequence_param" => { "perl" => '1' },
	"infile" => {
		"perl" => '! $dist',
	},
	"gap" => {
		"perl" => '! $dist',
	},
	"correct" => {
		"perl" => '! $dist',
	},
	"savedist" => {
		"perl" => '! $dist',
	},
	"distfile" => {
		"perl" => '$dist',
	},
	"lower" => { "perl" => '1' },
	"quartfile" => { "perl" => '1' },
	"outdistfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"quartfile" => {
		 '1' => "quartfile",
	},
	"outdistfile" => {
		 '(! $dist) && $savedist' => "phylip_dist",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},
	"distfile" => {
		 "phylip_dist" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"distquart" => 0,
	"dist" => 0,
	"sequence_param" => 0,
	"infile" => 0,
	"gap" => 0,
	"correct" => 0,
	"savedist" => 0,
	"distfile" => 0,
	"lower" => 0,
	"quartfile" => 0,
	"outdistfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"distquart" => 1,
	"dist" => 1,
	"sequence_param" => 0,
	"infile" => 1,
	"gap" => 0,
	"correct" => 0,
	"savedist" => 0,
	"distfile" => 1,
	"lower" => 1,
	"quartfile" => 0,
	"outdistfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"dist" => [
		"The program can take as input either a distance matrix (lower triangular) (infile.dist), either a character matrix in the file (infile.nuc) (ie, nucleotide sequences for the species in the same format as the PHYLIP package or as output by the readseq program) from which it computes the Hamming distance between species to infer the quartets.",
	],
	"infile" => [
		"If you provide no distance matrix file, the Hamming distances will be computed from this file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/distquart.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

