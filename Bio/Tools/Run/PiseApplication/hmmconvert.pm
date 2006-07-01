# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmconvert
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmconvert

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmconvert

      Bioperl class for:

	HMMER	hmmconvert - convert between profile HMM file formats (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmconvert.html 
         for available values):


		hmmconvert (String)

		toto (String)

		oldhmmfile (InFile)
			Old HMM file
			pipe: hmmer_HMM

		new_format (Excl)
			new format

		append_file (InFile)
			append the new HMM to an existing file (-A)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmconvert.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmconvert;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmconvert = Bio::Tools::Run::PiseApplication::hmmconvert->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmconvert object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmconvert = $factory->program('hmmconvert');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmconvert.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmconvert.pm

    $self->{COMMAND}   = "hmmconvert";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmconvert - convert between profile HMM file formats";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmconvert",
	"description",
	"oldhmmfile",
	"result_file",
	"new_format",
	"append_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmconvert",
	"description", 	# description of hmmconvert
	"toto",
	"oldhmmfile", 	# Old HMM file
	"result_file",
	"new_format", 	# new format
	"append_file", 	# append the new HMM to an existing file (-A)

    ];

    $self->{TYPE}  = {
	"hmmconvert" => 'String',
	"description" => 'Paragraph',
	"toto" => 'String',
	"oldhmmfile" => 'InFile',
	"result_file" => 'Results',
	"new_format" => 'Excl',
	"append_file" => 'InFile',

    };

    $self->{FORMAT}  = {
	"hmmconvert" => {
		"perl" => '"hmmconvert"',
	},
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"oldhmmfile" => {
		"perl" => '" $oldhmmfile"',
	},
	"result_file" => {
		"perl" => '($append_file) ? " $append_file" : " $oldhmmfile.convert"',
	},
	"new_format" => {
		"perl" => '" $value"',
	},
	"append_file" => {
		"perl" => '($value) ? " -A" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"result_file" => '$append_file $oldhmmfile.convert',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"hmmconvert" => 0,
	"toto" => 1000,
	"oldhmmfile" => 2,
	"result_file" => 3,
	"new_format" => 1,
	"append_file" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"hmmconvert",
	"description",
	"new_format",
	"append_file",
	"oldhmmfile",
	"result_file",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmconvert" => 1,
	"description" => 0,
	"toto" => 1,
	"oldhmmfile" => 0,
	"result_file" => 1,
	"new_format" => 0,
	"append_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"hmmconvert" => 1,
	"description" => 0,
	"toto" => 0,
	"oldhmmfile" => 0,
	"result_file" => 0,
	"new_format" => 0,
	"append_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmconvert" => 0,
	"description" => 0,
	"toto" => 0,
	"oldhmmfile" => 1,
	"result_file" => 0,
	"new_format" => 0,
	"append_file" => 0,

    };

    $self->{PROMPT}  = {
	"hmmconvert" => "",
	"description" => "description of hmmconvert",
	"toto" => "",
	"oldhmmfile" => "Old HMM file",
	"result_file" => "",
	"new_format" => "new format",
	"append_file" => "append the new HMM to an existing file (-A)",

    };

    $self->{ISSTANDOUT}  = {
	"hmmconvert" => 0,
	"description" => 0,
	"toto" => 0,
	"oldhmmfile" => 0,
	"result_file" => 0,
	"new_format" => 0,
	"append_file" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
	"new_format" => ['','HMMER 2 ASCII (default)','-b','HMMER 2 binary (-b)','-p','GCG profile (-p)','-P','Compugen XSW extended profile (-P)',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"hmmconvert" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"oldhmmfile" => { "perl" => '1' },
	"result_file" => { "perl" => '1' },
	"new_format" => { "perl" => '1' },
	"append_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"oldhmmfile" => {
		 "hmmer_HMM" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmconvert" => 0,
	"description" => 0,
	"toto" => 0,
	"oldhmmfile" => 0,
	"result_file" => 0,
	"new_format" => 0,
	"append_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmconvert" => 0,
	"description" => 0,
	"toto" => 0,
	"oldhmmfile" => 0,
	"result_file" => 0,
	"new_format" => 0,
	"append_file" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmconvert reads an HMM file from oldhmmfile in any HMMER format, and writes it to a new file newhmmfile in a new format. oldhmmfile and newhmmfile must be different files; you can\'t reliably overwrite the old file. By default, the new HMM file is written in HMMER 2 ASCII format.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmconvert.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

