# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmer2sam
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmer2sam

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmer2sam

      Bioperl class for:

	SAM: hmmer2sam (R. Hughey & A. Krogh)	


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmer2sam.html 
         for available values):


		hmmer2sam (String)

		hmmfile (InFile)
			HMMER model file
			pipe: hmm_textfile

		model_file (OutFile)
			SAM model file
			pipe: sam_model

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmer2sam.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmer2sam;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmer2sam = Bio::Tools::Run::PiseApplication::hmmer2sam->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmer2sam object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmer2sam = $factory->program('hmmer2sam');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmer2sam.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmer2sam.pm

    $self->{COMMAND}   = "hmmer2sam";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM: hmmer2sam (R. Hughey & A. Krogh)";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmer2sam",
	"hmmfile",
	"model_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmer2sam",
	"hmmfile", 	# HMMER model file
	"model_file", 	# SAM model file

    ];

    $self->{TYPE}  = {
	"hmmer2sam" => 'String',
	"hmmfile" => 'InFile',
	"model_file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"hmmer2sam" => {
		"seqlab" => 'hmmer2sam',
		"perl" => '"hmmer2sam"',
	},
	"hmmfile" => {
		"perl" => '" $value"',
	},
	"model_file" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 1,
	"model_file" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"hmmer2sam",
	"hmmfile",
	"model_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmer2sam" => 1,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmer2sam" => 1,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 1,
	"model_file" => 1,

    };

    $self->{PROMPT}  = {
	"hmmer2sam" => "",
	"hmmfile" => "HMMER model file",
	"model_file" => "SAM model file",

    };

    $self->{ISSTANDOUT}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"hmmer2sam" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"model_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"model_file" => {
		 '1' => "sam_model",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"hmmfile" => {
		 "hmm_textfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmer2sam" => 0,
	"hmmfile" => 0,
	"model_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmer2sam" => 1,
	"hmmfile" => 1,
	"model_file" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmer2sam.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

