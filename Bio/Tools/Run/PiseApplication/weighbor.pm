# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::weighbor
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::weighbor

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::weighbor

      Bioperl class for:

	Weighbor	Weighted neighbor joining (Bruno, Halpern, Socci)

	References:

		W. J. Bruno, N. D. Socci, and A. L. Halpern. Weighted Neighbor Joining: A Likelihood-Based Approach to Distance-Based Phylogeny Reconstruction, Mol. Biol. Evol. 17 (1): 189-197 (2000).



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/weighbor.html 
         for available values):


		weighbor (String)

		infile (InFile)
			Distances matrix File (-i)
			pipe: phylip_dist

		length (Integer)
			Length of the sequences (-L)

		size (Integer)
			Size of the alphabet (-b)

		Verbose output (Excl)
			Verbose (-v)

		outfile (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/weighbor.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::weighbor;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $weighbor = Bio::Tools::Run::PiseApplication::weighbor->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::weighbor object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $weighbor = $factory->program('weighbor');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::weighbor.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/weighbor.pm

    $self->{COMMAND}   = "weighbor";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Weighbor";

    $self->{DESCRIPTION}   = "Weighted neighbor joining";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Bruno, Halpern, Socci";

    $self->{REFERENCE}   = [

         "W. J. Bruno, N. D. Socci, and A. L. Halpern. Weighted Neighbor Joining: A Likelihood-Based Approach to Distance-Based Phylogeny Reconstruction, Mol. Biol. Evol. 17 (1): 189-197 (2000).",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"weighbor",
	"infile",
	"length",
	"size",
	"Verbose output",
	"outfile",
	"treefile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"weighbor",
	"infile", 	# Distances matrix File (-i)
	"length", 	# Length of the sequences (-L)
	"size", 	# Size of the alphabet (-b)
	"Verbose output",
	"outfile",
	"treefile",

    ];

    $self->{TYPE}  = {
	"weighbor" => 'String',
	"infile" => 'InFile',
	"length" => 'Integer',
	"size" => 'Integer',
	"Verbose output" => 'Excl',
	"outfile" => 'String',
	"treefile" => 'Results',

    };

    $self->{FORMAT}  = {
	"infile" => {
		"perl" => '" -i $value"',
	},
	"length" => {
		"perl" => '($value)? " -L $value" : ""',
	},
	"size" => {
		"perl" => '($value && $value != $vdef)? " -b $value" : ""',
	},
	"Verbose output" => {
		"perl" => '($value)? " -$value" : ""',
	},
	"outfile" => {
		"perl" => ' " -o treefile" ',
	},
	"treefile" => {
	},
	"weighbor" => {
		"perl" => '"weighbor"',
	}

    };

    $self->{FILENAMES}  = {
	"treefile" => 'treefile',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"infile" => 1,
	"length" => 2,
	"size" => 2,
	"Verbose output" => 2,
	"outfile" => 3,
	"weighbor" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treefile",
	"weighbor",
	"infile",
	"Verbose output",
	"length",
	"size",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"infile" => 0,
	"length" => 0,
	"size" => 0,
	"Verbose output" => 0,
	"outfile" => 1,
	"treefile" => 0,
	"weighbor" => 1

    };

    $self->{ISCOMMAND}  = {
	"infile" => 0,
	"length" => 0,
	"size" => 0,
	"Verbose output" => 0,
	"outfile" => 0,
	"treefile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"infile" => 1,
	"length" => 0,
	"size" => 0,
	"Verbose output" => 0,
	"outfile" => 0,
	"treefile" => 0,

    };

    $self->{PROMPT}  = {
	"infile" => "Distances matrix File (-i)",
	"length" => "Length of the sequences (-L)",
	"size" => "Size of the alphabet (-b)",
	"Verbose output" => "Verbose (-v)",
	"outfile" => "",
	"treefile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"infile" => 0,
	"length" => 0,
	"size" => 0,
	"Verbose output" => 0,
	"outfile" => 0,
	"treefile" => 0,

    };

    $self->{VLIST}  = {

	"Verbose output" => ['v','verbose','vv','very verbose','vvv','very very verbose',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"size" => '4',

    };

    $self->{PRECOND}  = {
	"infile" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"size" => { "perl" => '1' },
	"Verbose output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"treefile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"treefile" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "phylip_dist" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"infile" => 0,
	"length" => 0,
	"size" => 0,
	"Verbose output" => 0,
	"outfile" => 0,
	"treefile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"infile" => 1,
	"length" => 0,
	"size" => 0,
	"Verbose output" => 0,
	"outfile" => 0,
	"treefile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"length" => [
		"Default is 500. This is the effective sequence length equal to the number of varying sites. Note if the -L option is not used then the program will print a warning message to stderr indicating that it is using this default length.",
	],
	"size" => [
		"Sets the size of the alphabet of characters (number of bases) b. 1/b is equal to the probablity that there will be a match for infinite evolution time. The default value for b is 4.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/weighbor.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

