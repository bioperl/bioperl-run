# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::readnexus
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::readnexus

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::readnexus

      Bioperl class for:

	readnexus	Convert NEXUS files into fasta/mega format (W. Fischer)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/readnexus.html 
         for available values):


		readnexus (String)

		seq (Sequence)
			Nexus File
			pipe: nexus_file

		outformat (Excl)
			Output format

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

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

http://bioweb.pasteur.fr/seqanal/interfaces/readnexus.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::readnexus;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $readnexus = Bio::Tools::Run::PiseApplication::readnexus->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::readnexus object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $readnexus = $factory->program('readnexus');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::readnexus.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/readnexus.pm

    $self->{COMMAND}   = "readnexus";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "readnexus";

    $self->{DESCRIPTION}   = "Convert NEXUS files into fasta/mega format";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "W. Fischer";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"readnexus",
	"seq",
	"fastafile",
	"megfile",
	"outformat",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"readnexus",
	"seq", 	# Nexus File
	"fastafile",
	"megfile",
	"outformat", 	# Output format

    ];

    $self->{TYPE}  = {
	"readnexus" => 'String',
	"seq" => 'Sequence',
	"fastafile" => 'Results',
	"megfile" => 'Results',
	"outformat" => 'Excl',

    };

    $self->{FORMAT}  = {
	"readnexus" => {
		"seqlab" => 'readnexus',
		"perl" => '"readnexus"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"fastafile" => {
	},
	"megfile" => {
	},
	"outformat" => {
		"perl" => '($value)? " $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"fastafile" => '*.fasta',
	"megfile" => '*.meg',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"readnexus" => 0,
	"seq" => 2,
	"outformat" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readnexus",
	"fastafile",
	"megfile",
	"outformat",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"readnexus" => 1,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{ISCOMMAND}  = {
	"readnexus" => 1,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{ISMANDATORY}  = {
	"readnexus" => 0,
	"seq" => 1,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{PROMPT}  = {
	"readnexus" => "",
	"seq" => "Nexus File",
	"fastafile" => "",
	"megfile" => "",
	"outformat" => "Output format",

    };

    $self->{ISSTANDOUT}  = {
	"readnexus" => 0,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{VLIST}  = {

	"outformat" => ['-f','fasta (-f)','-m','mega (-m)',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outformat" => '-f',

    };

    $self->{PRECOND}  = {
	"readnexus" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"fastafile" => { "perl" => '1' },
	"megfile" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"fastafile" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "nexus_file" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"readnexus" => 0,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{ISSIMPLE}  = {
	"readnexus" => 1,
	"seq" => 1,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/readnexus.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

