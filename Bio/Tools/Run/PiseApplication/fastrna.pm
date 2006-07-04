# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::fastrna
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::fastrna

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fastrna

      Bioperl class for:

	FAStRNA	Very fast identification of RNA motifs in genomic DNA (N. El-Mabrouk)

	References:

		N. El-Mabrouk and F. Lisacek. Very fast identification of RNA motifs in genomic DNA. Application to tRNA search in the yeast genome. J. Mol.Biol., 264:46-55, November 1996.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/fastrna.html 
         for available values):


		fastrna (Excl)

		seq (Sequence)
			Sequence File

		outfile (OutFile)
			Result file

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

http://bioweb.pasteur.fr/seqanal/interfaces/fastrna.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::fastrna;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fastrna = Bio::Tools::Run::PiseApplication::fastrna->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fastrna object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $fastrna = $factory->program('fastrna');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::fastrna.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fastrna.pm

    $self->{COMMAND}   = "fastrna";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "FAStRNA";

    $self->{DESCRIPTION}   = "Very fast identification of RNA motifs in genomic DNA";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "N. El-Mabrouk";

    $self->{REFERENCE}   = [

         "N. El-Mabrouk and F. Lisacek. Very fast identification of RNA motifs in genomic DNA. Application to tRNA search in the yeast genome. J. Mol.Biol., 264:46-55, November 1996.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fastrna",
	"seq",
	"outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fastrna",
	"seq", 	# Sequence File
	"outfile", 	# Result file

    ];

    $self->{TYPE}  = {
	"fastrna" => 'Excl',
	"seq" => 'Sequence',
	"outfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"fastrna" => {
		"perl" => '"$value"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"outfile" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [13],

    };

    $self->{GROUP}  = {
	"fastrna" => 0,
	"seq" => 2,
	"outfile" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"fastrna",
	"seq",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"fastrna" => 0,
	"seq" => 0,
	"outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"fastrna" => 1,
	"seq" => 0,
	"outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"fastrna" => 1,
	"seq" => 1,
	"outfile" => 1,

    };

    $self->{PROMPT}  = {
	"fastrna" => "",
	"seq" => "Sequence File",
	"outfile" => "Result file",

    };

    $self->{ISSTANDOUT}  = {
	"fastrna" => 0,
	"seq" => 0,
	"outfile" => 0,

    };

    $self->{VLIST}  = {

	"fastrna" => ['FAStRNA-CM','FAStRNA-CM: probabilistic model','FAStRNA-CLASS','FAStRNA-CLASS: pattern-matching approach',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'fastrna.res',

    };

    $self->{PRECOND}  = {
	"fastrna" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },

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
	"fastrna" => 0,
	"seq" => 0,
	"outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"fastrna" => 1,
	"seq" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fastrna.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

