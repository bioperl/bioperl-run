# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::dsc
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::dsc

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dsc

      Bioperl class for:

	DSC	Discrimination of protein Secondary structure Class (R. D. King, M.J.E. Sternberg)

	References:

		Identification and application of the concepts important for accurate and reliable protein secondary structure prediction by Ross D. King and Michael J.E. Sternberg (Protein Science). 



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/dsc.html 
         for available values):


		dsc (String)

		seq (Sequence)
			Protein sequence(s) File
			pipe: readseq_ok_alig

		poorly (Switch)
			Turn off removal of poorly Aligned sections (-a)

		isolated (Switch)
			Stop automatic removal of Isolated predictions (-i)

		filtering (Integer)
			Level of Filtering of predictions (-f)

		seqlen (Integer)
			Length of sequence used to determine poor alignment (-l)

		identity (Integer)
			Threshold peRcentage of identity used to determine poor alignment (-r)

		casp (Switch)
			CASP output format (-c)

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

http://bioweb.pasteur.fr/seqanal/interfaces/dsc.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::dsc;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dsc = Bio::Tools::Run::PiseApplication::dsc->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dsc object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $dsc = $factory->program('dsc');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::dsc.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dsc.pm

    $self->{COMMAND}   = "dsc";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DSC";

    $self->{DESCRIPTION}   = "Discrimination of protein Secondary structure Class";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "R. D. King, M.J.E. Sternberg";

    $self->{REFERENCE}   = [

         "Identification and application of the concepts important for accurate and reliable protein secondary structure prediction by Ross D. King and Michael J.E. Sternberg (Protein Science). ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dsc",
	"seq",
	"control",
	"output",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dsc",
	"seq", 	# Protein sequence(s) File
	"control", 	# Control parameters
	"poorly", 	# Turn off removal of poorly Aligned sections (-a)
	"isolated", 	# Stop automatic removal of Isolated predictions (-i)
	"filtering", 	# Level of Filtering of predictions (-f)
	"seqlen", 	# Length of sequence used to determine poor alignment (-l)
	"identity", 	# Threshold peRcentage of identity used to determine poor alignment (-r)
	"output", 	# Output parameters
	"casp", 	# CASP output format (-c)

    ];

    $self->{TYPE}  = {
	"dsc" => 'String',
	"seq" => 'Sequence',
	"control" => 'Paragraph',
	"poorly" => 'Switch',
	"isolated" => 'Switch',
	"filtering" => 'Integer',
	"seqlen" => 'Integer',
	"identity" => 'Integer',
	"output" => 'Paragraph',
	"casp" => 'Switch',

    };

    $self->{FORMAT}  = {
	"dsc" => {
		"seqlab" => 'dsc',
		"perl" => '"dsc -m"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"control" => {
	},
	"poorly" => {
		"perl" => ' ($value)? " -a":""',
	},
	"isolated" => {
		"perl" => ' ($value)? " -i":""',
	},
	"filtering" => {
		"perl" => '(defined $value && $value != $vdef)? " -f$value":""',
	},
	"seqlen" => {
		"perl" => '(defined $value)? " -l$value":""',
	},
	"identity" => {
		"perl" => '(defined $value)? " -r$value":""',
	},
	"output" => {
	},
	"casp" => {
		"perl" => ' ($value)? " -c":""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [15],

    };

    $self->{GROUP}  = {
	"dsc" => 0,
	"seq" => 10,
	"control" => 1,
	"poorly" => 1,
	"isolated" => 1,
	"filtering" => 1,
	"seqlen" => 1,
	"identity" => 1,
	"output" => 1,
	"casp" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"dsc",
	"casp",
	"control",
	"poorly",
	"isolated",
	"filtering",
	"seqlen",
	"identity",
	"output",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dsc" => 1,
	"seq" => 0,
	"control" => 0,
	"poorly" => 0,
	"isolated" => 0,
	"filtering" => 0,
	"seqlen" => 0,
	"identity" => 0,
	"output" => 0,
	"casp" => 0,

    };

    $self->{ISCOMMAND}  = {
	"dsc" => 1,
	"seq" => 0,
	"control" => 0,
	"poorly" => 0,
	"isolated" => 0,
	"filtering" => 0,
	"seqlen" => 0,
	"identity" => 0,
	"output" => 0,
	"casp" => 0,

    };

    $self->{ISMANDATORY}  = {
	"dsc" => 0,
	"seq" => 1,
	"control" => 0,
	"poorly" => 0,
	"isolated" => 0,
	"filtering" => 0,
	"seqlen" => 0,
	"identity" => 0,
	"output" => 0,
	"casp" => 0,

    };

    $self->{PROMPT}  = {
	"dsc" => "",
	"seq" => "Protein sequence(s) File",
	"control" => "Control parameters",
	"poorly" => "Turn off removal of poorly Aligned sections (-a)",
	"isolated" => "Stop automatic removal of Isolated predictions (-i)",
	"filtering" => "Level of Filtering of predictions (-f)",
	"seqlen" => "Length of sequence used to determine poor alignment (-l)",
	"identity" => "Threshold peRcentage of identity used to determine poor alignment (-r)",
	"output" => "Output parameters",
	"casp" => "CASP output format (-c)",

    };

    $self->{ISSTANDOUT}  = {
	"dsc" => 0,
	"seq" => 0,
	"control" => 0,
	"poorly" => 0,
	"isolated" => 0,
	"filtering" => 0,
	"seqlen" => 0,
	"identity" => 0,
	"output" => 0,
	"casp" => 0,

    };

    $self->{VLIST}  = {

	"control" => ['poorly','isolated','filtering','seqlen','identity',],
	"output" => ['casp',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"poorly" => '0',
	"isolated" => '0',
	"filtering" => '1',
	"casp" => '0',

    };

    $self->{PRECOND}  = {
	"dsc" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"control" => { "perl" => '1' },
	"poorly" => { "perl" => '1' },
	"isolated" => { "perl" => '1' },
	"filtering" => { "perl" => '1' },
	"seqlen" => { "perl" => '1' },
	"identity" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"casp" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"dsc" => 0,
	"seq" => 0,
	"control" => 0,
	"poorly" => 0,
	"isolated" => 0,
	"filtering" => 0,
	"seqlen" => 0,
	"identity" => 0,
	"output" => 0,
	"casp" => 0,

    };

    $self->{ISSIMPLE}  = {
	"dsc" => 1,
	"seq" => 1,
	"control" => 0,
	"poorly" => 0,
	"isolated" => 0,
	"filtering" => 0,
	"seqlen" => 0,
	"identity" => 0,
	"output" => 0,
	"casp" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"filtering" => [
		"DSC incorporates rules to filter predictions. As default these rules are set on. These rules can be used recursively by setting the filter level, e.g. setting the flag to 2 would run the rules twice, 0 would not apply any filtering, level 1 is default.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dsc.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

