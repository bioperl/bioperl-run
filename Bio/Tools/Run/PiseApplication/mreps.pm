# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::mreps
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::mreps

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::mreps

      Bioperl class for:

	mreps	Algorithm for finding maximal tandem repetitions (G. Kucherov)

	References:

		R. Kolpakov, G. Kucherov, Finding maximal repetitions in a word in linear time, 1999 Symposium on Foundations of Computer Science (FOCS), New-York (USA), pp. 596-604, IEEE Computer Society 

		R. Kolpakov, G. Kucherov, Finding Approximate Repetitions under Hamming Distance, 9-th European Symposium on Algorithms (ESA), Århus (Denmark), Lecture Notes in Computer Science, vol. 2161, pp 170-181.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/mreps.html 
         for available values):


		mreps (String)

		query (Sequence)
			Query Sequence file

		err (Integer)
			Specifies the resolution (error level) (-res)

		from (Integer)
			Specifies starting position (-from)

		to (Integer)
			Specifies end position (-to)

		win (Integer)
			Processes by sliding windows of size 2*n overlaping by n (-win)

		minsize (Integer)
			Report repetitions whose size is at least n (-minsize)

		maxsize (Integer)
			Report repetitions whose size is at most n (-maxsize)

		minperiod (Integer)
			Report repetitions whose period is at least n (-minperiod)

		maxperiod (Integer)
			Report repetitions whose period is at most n (-maxperiod)

		exp (Integer)
			Report repetitions whose exponent is at least n (-exp)

		small (Switch)
			Output small repeats that can occur randomly (-allowsmall)

		noprint (Switch)
			Do not output repetitions sequences (-noprint)

		xml (OutFile)
			XML format output file name (-xmloutput)

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

http://bioweb.pasteur.fr/seqanal/interfaces/mreps.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::mreps;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $mreps = Bio::Tools::Run::PiseApplication::mreps->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::mreps object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $mreps = $factory->program('mreps');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::mreps.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mreps.pm

    $self->{COMMAND}   = "mreps";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "mreps";

    $self->{DESCRIPTION}   = "Algorithm for finding maximal tandem repetitions";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:motifs",
  ];

    $self->{AUTHORS}   = "G. Kucherov";

    $self->{REFERENCE}   = [

         "R. Kolpakov, G. Kucherov, Finding maximal repetitions in a word in linear time, 1999 Symposium on Foundations of Computer Science (FOCS), New-York (USA), pp. 596-604, IEEE Computer Society ",

         "R. Kolpakov, G. Kucherov, Finding Approximate Repetitions under Hamming Distance, 9-th European Symposium on Algorithms (ESA), Århus (Denmark), Lecture Notes in Computer Science, vol. 2161, pp 170-181.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"mreps",
	"query",
	"err",
	"from",
	"to",
	"win",
	"minsize",
	"maxsize",
	"minperiod",
	"maxperiod",
	"exp",
	"small",
	"noprint",
	"xml",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"mreps",
	"query", 	# Query Sequence file
	"err", 	# Specifies the resolution (error level) (-res)
	"from", 	# Specifies starting position (-from)
	"to", 	# Specifies end position (-to)
	"win", 	# Processes by sliding windows of size 2*n overlaping by n (-win)
	"minsize", 	# Report repetitions whose size is at least n (-minsize)
	"maxsize", 	# Report repetitions whose size is at most n (-maxsize)
	"minperiod", 	# Report repetitions whose period is at least n (-minperiod)
	"maxperiod", 	# Report repetitions whose period is at most n (-maxperiod)
	"exp", 	# Report repetitions whose exponent is at least n (-exp)
	"small", 	# Output small repeats that can occur randomly (-allowsmall)
	"noprint", 	# Do not output repetitions sequences (-noprint)
	"xml", 	# XML format output file name (-xmloutput)

    ];

    $self->{TYPE}  = {
	"mreps" => 'String',
	"query" => 'Sequence',
	"err" => 'Integer',
	"from" => 'Integer',
	"to" => 'Integer',
	"win" => 'Integer',
	"minsize" => 'Integer',
	"maxsize" => 'Integer',
	"minperiod" => 'Integer',
	"maxperiod" => 'Integer',
	"exp" => 'Integer',
	"small" => 'Switch',
	"noprint" => 'Switch',
	"xml" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"mreps" => {
		"perl" => 'mreps',
	},
	"query" => {
		"perl" => '" -fasta $value"',
	},
	"err" => {
		"perl" => '(defined $value ) ? " -res $value" : ""',
	},
	"from" => {
		"perl" => '(defined $value) ? " -from $value" : ""',
	},
	"to" => {
		"perl" => '(defined $value) ? " -to $value" : ""',
	},
	"win" => {
		"perl" => '(defined $value) ? " -win $value" : ""',
	},
	"minsize" => {
		"perl" => '(defined $value) ? " -minsize $value" : ""',
	},
	"maxsize" => {
		"perl" => '(defined $value) ? " -maxsize $value" : ""',
	},
	"minperiod" => {
		"perl" => '(defined $value) ? " -minperiod $value" : ""',
	},
	"maxperiod" => {
		"perl" => '(defined $value) ? " -maxperiod $value" : ""',
	},
	"exp" => {
		"perl" => '(defined $value) ? " -exp $value" : ""',
	},
	"small" => {
		"perl" => '(defined $value) ? " -allowsmall" : ""',
	},
	"noprint" => {
		"perl" => '(defined $value) ? " -noprint" : ""',
	},
	"xml" => {
		"perl" => '(defined $value) ? " -xmloutput $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"mreps" => 0,
	"query" => 20,
	"err" => 10,
	"from" => 10,
	"to" => 10,
	"win" => 10,
	"minsize" => 10,
	"maxsize" => 10,
	"minperiod" => 10,
	"maxperiod" => 10,
	"exp" => 10,
	"small" => 10,
	"noprint" => 10,
	"xml" => 10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"mreps",
	"xml",
	"err",
	"from",
	"to",
	"win",
	"minsize",
	"maxsize",
	"minperiod",
	"maxperiod",
	"exp",
	"small",
	"noprint",
	"query",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"mreps" => 1,
	"query" => 0,
	"err" => 0,
	"from" => 0,
	"to" => 0,
	"win" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"minperiod" => 0,
	"maxperiod" => 0,
	"exp" => 0,
	"small" => 0,
	"noprint" => 0,
	"xml" => 0,

    };

    $self->{ISCOMMAND}  = {
	"mreps" => 1,
	"query" => 0,
	"err" => 0,
	"from" => 0,
	"to" => 0,
	"win" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"minperiod" => 0,
	"maxperiod" => 0,
	"exp" => 0,
	"small" => 0,
	"noprint" => 0,
	"xml" => 0,

    };

    $self->{ISMANDATORY}  = {
	"mreps" => 0,
	"query" => 1,
	"err" => 0,
	"from" => 0,
	"to" => 0,
	"win" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"minperiod" => 0,
	"maxperiod" => 0,
	"exp" => 0,
	"small" => 0,
	"noprint" => 0,
	"xml" => 0,

    };

    $self->{PROMPT}  = {
	"mreps" => "",
	"query" => "Query Sequence file",
	"err" => "Specifies the resolution (error level) (-res)",
	"from" => "Specifies starting position (-from)",
	"to" => "Specifies end position (-to)",
	"win" => "Processes by sliding windows of size 2*n overlaping by n (-win)",
	"minsize" => "Report repetitions whose size is at least n (-minsize)",
	"maxsize" => "Report repetitions whose size is at most n (-maxsize)",
	"minperiod" => "Report repetitions whose period is at least n (-minperiod)",
	"maxperiod" => "Report repetitions whose period is at most n (-maxperiod)",
	"exp" => "Report repetitions whose exponent is at least n (-exp)",
	"small" => "Output small repeats that can occur randomly (-allowsmall)",
	"noprint" => "Do not output repetitions sequences (-noprint)",
	"xml" => "XML format output file name (-xmloutput)",

    };

    $self->{ISSTANDOUT}  = {
	"mreps" => 0,
	"query" => 0,
	"err" => 0,
	"from" => 0,
	"to" => 0,
	"win" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"minperiod" => 0,
	"maxperiod" => 0,
	"exp" => 0,
	"small" => 0,
	"noprint" => 0,
	"xml" => 0,

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
	"mreps" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"err" => { "perl" => '1' },
	"from" => { "perl" => '1' },
	"to" => { "perl" => '1' },
	"win" => { "perl" => '1' },
	"minsize" => { "perl" => '1' },
	"maxsize" => { "perl" => '1' },
	"minperiod" => { "perl" => '1' },
	"maxperiod" => { "perl" => '1' },
	"exp" => { "perl" => '1' },
	"small" => { "perl" => '1' },
	"noprint" => { "perl" => '1' },
	"xml" => { "perl" => '1' },

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
	"mreps" => 0,
	"query" => 0,
	"err" => 0,
	"from" => 0,
	"to" => 0,
	"win" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"minperiod" => 0,
	"maxperiod" => 0,
	"exp" => 0,
	"small" => 0,
	"noprint" => 0,
	"xml" => 0,

    };

    $self->{ISSIMPLE}  = {
	"mreps" => 1,
	"query" => 1,
	"err" => 0,
	"from" => 0,
	"to" => 0,
	"win" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"minperiod" => 0,
	"maxperiod" => 0,
	"exp" => 0,
	"small" => 0,
	"noprint" => 0,
	"xml" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/mreps.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

