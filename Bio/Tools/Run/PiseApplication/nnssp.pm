# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::nnssp
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::nnssp

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::nnssp

      Bioperl class for:

	NNSSP	Prediction of protein secondary structure by combining nearest-neighbor algorithms and multiple sequence alignment (Salamov & Solovyev)

	References:

		Salamov AA, Solovyev VV (1995) Prediction of protein secondary structure by combinin nearest-neighbr algorithms and multiple sequence alignment. J Mol Biol, 247 : 11-15



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/nnssp.html 
         for available values):


		nnssp (String)

		infile (Sequence)
			Clustalw Alignment File
			pipe: readseq_ok_alig

		seq (String)
			Name of the sequence to analyze

		outfile (OutFile)
			Output File

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

http://bioweb.pasteur.fr/seqanal/interfaces/nnssp.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::nnssp;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $nnssp = Bio::Tools::Run::PiseApplication::nnssp->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::nnssp object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $nnssp = $factory->program('nnssp');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::nnssp.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/nnssp.pm

    $self->{COMMAND}   = "nnssp";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "NNSSP";

    $self->{DESCRIPTION}   = "Prediction of protein secondary structure by combining nearest-neighbor algorithms and multiple sequence alignment";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Salamov & Solovyev";

    $self->{REFERENCE}   = [

         "Salamov AA, Solovyev VV (1995) Prediction of protein secondary structure by combinin nearest-neighbr algorithms and multiple sequence alignment. J Mol Biol, 247 : 11-15",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"nnssp",
	"infile",
	"seq",
	"nnsspfile",
	"outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"nnssp",
	"infile", 	# Clustalw Alignment File
	"seq", 	# Name of the sequence to analyze
	"nnsspfile",
	"outfile", 	# Output File

    ];

    $self->{TYPE}  = {
	"nnssp" => 'String',
	"infile" => 'Sequence',
	"seq" => 'String',
	"nnsspfile" => 'Results',
	"outfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"nnssp" => {
		"perl" => ' "clu2nnssp -I$infile -O$infile.nns -S$seq; nnssp $infile.nns" ',
	},
	"infile" => {
		"perl" => '""',
	},
	"seq" => {
		"perl" => '""',
	},
	"nnsspfile" => {
	},
	"outfile" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {
	"nnsspfile" => '*.nns',

    };

    $self->{SEQFMT}  = {
	"infile" => [100],

    };

    $self->{GROUP}  = {
	"nnssp" => 0,
	"infile" => 1,
	"seq" => 1,
	"outfile" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"nnssp",
	"nnsspfile",
	"infile",
	"seq",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"nnssp" => 1,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"nnssp" => 1,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"nnssp" => 0,
	"infile" => 1,
	"seq" => 1,
	"nnsspfile" => 0,
	"outfile" => 1,

    };

    $self->{PROMPT}  = {
	"nnssp" => "",
	"infile" => "Clustalw Alignment File",
	"seq" => "Name of the sequence to analyze",
	"nnsspfile" => "",
	"outfile" => "Output File",

    };

    $self->{ISSTANDOUT}  = {
	"nnssp" => 0,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'nnssp.results',

    };

    $self->{PRECOND}  = {
	"nnssp" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"nnsspfile" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

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
	"nnssp" => 0,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"nnssp" => 0,
	"infile" => 1,
	"seq" => 1,
	"nnsspfile" => 0,
	"outfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/nnssp.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

