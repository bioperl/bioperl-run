# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::plsearch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::plsearch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::plsearch

      Bioperl class for:

	PLSEARCH	search protein sequences for similarity to AACC patterns (R. Smith & T. Smit)

	References:

		Smith, Randall F. and Temple F. Smith (1990).  Automatic generation of diagnostic sequence patterns from sets of related protein sequences.  Proc. Natl. Acad. Sci. USA 87:118-122.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/plsearch.html 
         for available values):


		plsearch (String)

		type (String)

		no_detach (String)

		protein (Sequence)
			Protein sequence File

		outfile (OutFile)
			Results file

		max_alignements (Integer)
			Maximum number of alignments

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

http://bioweb.pasteur.fr/seqanal/interfaces/plsearch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::plsearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $plsearch = Bio::Tools::Run::PiseApplication::plsearch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::plsearch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $plsearch = $factory->program('plsearch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::plsearch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/plsearch.pm

    $self->{COMMAND}   = "plsearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PLSEARCH";

    $self->{DESCRIPTION}   = "search protein sequences for similarity to AACC patterns";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{AUTHORS}   = "R. Smith & T. Smit";

    $self->{REFERENCE}   = [

         "Smith, Randall F. and Temple F. Smith (1990).  Automatic generation of diagnostic sequence patterns from sets of related protein sequences.  Proc. Natl. Acad. Sci. USA 87:118-122.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"plsearch",
	"type",
	"no_detach",
	"protein",
	"outfile",
	"max_alignements",
	"params",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"plsearch",
	"type",
	"no_detach",
	"protein", 	# Protein sequence File
	"outfile", 	# Results file
	"max_alignements", 	# Maximum number of alignments
	"params",

    ];

    $self->{TYPE}  = {
	"plsearch" => 'String',
	"type" => 'String',
	"no_detach" => 'String',
	"protein" => 'Sequence',
	"outfile" => 'OutFile',
	"max_alignements" => 'Integer',
	"params" => 'Results',

    };

    $self->{FORMAT}  = {
	"plsearch" => {
		"perl" => '"readseq -p -f1 < $protein | IG-to-tbl > tmp; cp tmp $protein; plsearch < params " ',
	},
	"type" => {
		"perl" => '"1\\n" ',
	},
	"no_detach" => {
		"perl" => '"no\\n" ',
	},
	"protein" => {
		"perl" => '`basename $value` ',
	},
	"outfile" => {
		"perl" => '($value)? "$value\\n" : "plsearch.res\\n"',
	},
	"max_alignements" => {
		"perl" => '(defined $value && $value != $vdef)? "$value\\n":"$vdef\\n"',
	},
	"params" => {
	},

    };

    $self->{FILENAMES}  = {
	"params" => 'params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"plsearch" => 0,
	"type" => 1,
	"no_detach" => 5,
	"protein" => 2,
	"outfile" => 3,
	"max_alignements" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"plsearch",
	"params",
	"type",
	"protein",
	"outfile",
	"max_alignements",
	"no_detach",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"plsearch" => 1,
	"type" => 1,
	"no_detach" => 1,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"plsearch" => 1,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 1,
	"outfile" => 1,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{PROMPT}  = {
	"plsearch" => "",
	"type" => "",
	"no_detach" => "",
	"protein" => "Protein sequence File",
	"outfile" => "Results file",
	"max_alignements" => "Maximum number of alignments",
	"params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'plsearch.res',
	"max_alignements" => '20',

    };

    $self->{PRECOND}  = {
	"plsearch" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"no_detach" => { "perl" => '1' },
	"protein" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"max_alignements" => { "perl" => '1' },
	"params" => { "perl" => '1' },

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
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 1,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{PARAMFILE}  = {
	"type" => "params",
	"no_detach" => "params",
	"protein" => "params",
	"outfile" => "params",
	"max_alignements" => "params",

    };

    $self->{COMMENT}  = {
	"max_alignements" => [
		"This value sets the maximum, however all matches with SDAM values greater than 4.0 will be displayed regardless of the value specified here.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/plsearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

