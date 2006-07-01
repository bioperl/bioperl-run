# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::bionj
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::bionj

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::bionj

      Bioperl class for:

	BIONJ	a version of the NJ algorithm improved for molecular sequences (O. Gascuel)

	References:

		Gascuel O., 1997, BIONJ: an improved version of the NJ algorithm based on a simple model of sequence data, Molecular Biology and Evolution 14(7):685-695



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/bionj.html 
         for available values):


		bionj (String)

		infile (InFile)
			Distances matrix File
			pipe: phylip_dist

		treefile (OutFile)
			Tree File
			pipe: phylip_tree

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

http://bioweb.pasteur.fr/seqanal/interfaces/bionj.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::bionj;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $bionj = Bio::Tools::Run::PiseApplication::bionj->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::bionj object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $bionj = $factory->program('bionj');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::bionj.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/bionj.pm

    $self->{COMMAND}   = "bionj";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BIONJ";

    $self->{DESCRIPTION}   = "a version of the NJ algorithm improved for molecular sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "O. Gascuel";

    $self->{REFERENCE}   = [

         "Gascuel O., 1997, BIONJ: an improved version of the NJ algorithm based on a simple model of sequence data, Molecular Biology and Evolution 14(7):685-695",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"bionj",
	"infile",
	"treefile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"bionj",
	"infile", 	# Distances matrix File
	"treefile", 	# Tree File

    ];

    $self->{TYPE}  = {
	"bionj" => 'String',
	"infile" => 'InFile',
	"treefile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"bionj" => {
		"perl" => 'bionj',
	},
	"infile" => {
		"perl" => '" $value"',
	},
	"treefile" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"bionj" => 0,
	"infile" => 1,
	"treefile" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"bionj",
	"infile",
	"treefile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"bionj" => 1,
	"infile" => 0,
	"treefile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"bionj" => 1,
	"infile" => 0,
	"treefile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"bionj" => 0,
	"infile" => 1,
	"treefile" => 1,

    };

    $self->{PROMPT}  = {
	"bionj" => "",
	"infile" => "Distances matrix File",
	"treefile" => "Tree File",

    };

    $self->{ISSTANDOUT}  = {
	"bionj" => 0,
	"infile" => 0,
	"treefile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"treefile" => 'treefile',

    };

    $self->{PRECOND}  = {
	"bionj" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
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
	"bionj" => 0,
	"infile" => 0,
	"treefile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"bionj" => 0,
	"infile" => 1,
	"treefile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"infile" => [
		"Enter a matrix in Phylip format.",
		"This algorithm is adapted to evolutive distances calculated from molecular data sequences (O. Gascuel, 1997, MBE 14(7), 685-695).",
		"If only one data matrix is given, then BIONJ returns one tree. When the input file contains several matrices given one after the other, as obtained when combining PHYLIP\'s SEQBOOT and DNADIST to perform a bootstrap, BIONJ returns the same number of trees, written one after the other in the output file; this file may be given to PHYLIP\'s CONSENSE to obtain the bootstrap tree.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/bionj.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

