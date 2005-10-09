# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::prettyalign
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::prettyalign

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prettyalign

      Bioperl class for:

	SAM	prettyalign - make align2model output more readable (R. Hughey & A. Krogh)

	References:

		R. Hughey and A. Krogh., SAM: Sequence alignment and modeling software system. Technical Report UCSC-CRL-96-22, University of California, Santa Cruz, CA, September 1996. 



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/prettyalign.html 
         for available values):


		prettyalign (String)

		a2m (Sequence)
			Alignment
			pipe: readseq_ok_alig

		output_format (Excl)
			Output format (-f and -I)

		column (Switch)
			Output column indices (-c)

		sequence_index (Switch)
			Sequence index (number) on each line (-n)

		sequence_ID (Switch)
			Toggle sequence ID to each line (-i)

		max_inserts (Integer)
			Max number of insertions printed (-m)

		linelength (Integer)
			Characters per line (-l)

		space_char (String)
			Char to show inserts  (-s)

		max_length (Integer)
			Maximum length of input lines (-L)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

http://bioweb.pasteur.fr/seqanal/interfaces/prettyalign.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::prettyalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prettyalign = Bio::Tools::Run::PiseApplication::prettyalign->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prettyalign object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $prettyalign = $factory->program('prettyalign');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::prettyalign.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prettyalign.pm

    $self->{COMMAND}   = "prettyalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SAM";

    $self->{DESCRIPTION}   = "prettyalign - make align2model output more readable";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "R. Hughey & A. Krogh";

    $self->{DOCLINK}   = "http://www.cse.ucsc.edu/research/compbio/ismb99.tutorial.html";

    $self->{REFERENCE}   = [

         "R. Hughey and A. Krogh., SAM: Sequence alignment and modeling software system. Technical Report UCSC-CRL-96-22, University of California, Santa Cruz, CA, September 1996. ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prettyalign",
	"a2m",
	"output_format",
	"column",
	"sequence_index",
	"sequence_ID",
	"max_inserts",
	"linelength",
	"space_char",
	"max_length",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prettyalign",
	"a2m", 	# Alignment
	"output_format", 	# Output format (-f and -I)
	"column", 	# Output column indices (-c)
	"sequence_index", 	# Sequence index (number) on each line (-n)
	"sequence_ID", 	# Toggle sequence ID to each line (-i)
	"max_inserts", 	# Max number of insertions printed (-m)
	"linelength", 	# Characters per line (-l)
	"space_char", 	# Char to show inserts  (-s)
	"max_length", 	# Maximum length of input lines (-L)

    ];

    $self->{TYPE}  = {
	"prettyalign" => 'String',
	"a2m" => 'Sequence',
	"output_format" => 'Excl',
	"column" => 'Switch',
	"sequence_index" => 'Switch',
	"sequence_ID" => 'Switch',
	"max_inserts" => 'Integer',
	"linelength" => 'Integer',
	"space_char" => 'String',
	"max_length" => 'Integer',

    };

    $self->{FORMAT}  = {
	"prettyalign" => {
		"seqlab" => 'prettyalign',
		"perl" => '"prettyalign"',
	},
	"a2m" => {
		"perl" => '" $value"',
	},
	"output_format" => {
	},
	"column" => {
		"perl" => '(! $value)? " -c" : ""',
	},
	"sequence_index" => {
		"perl" => '($value)?  " -n" : ""',
	},
	"sequence_ID" => {
		"perl" => '(! $value)? " -i" : ""',
	},
	"max_inserts" => {
		"perl" => ' (defined $value && $value != $vdef)? " -m $value" : "" ',
	},
	"linelength" => {
		"perl" => ' (defined $value && $value != $vdef)? " -l $value" : "" ',
	},
	"space_char" => {
		"perl" => ' ($value && $value ne $vdef)? " -s $value" : "" ',
	},
	"max_length" => {
		"perl" => ' (defined $value && $value != $vdef)? " -L $value" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"prettyalign" => 0,
	"a2m" => 1,
	"output_format" => 2,
	"column" => 2,
	"sequence_index" => 2,
	"sequence_ID" => 2,
	"max_inserts" => 2,
	"linelength" => 2,
	"space_char" => 2,
	"max_length" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"prettyalign",
	"a2m",
	"output_format",
	"column",
	"sequence_index",
	"sequence_ID",
	"max_inserts",
	"linelength",
	"space_char",
	"max_length",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"prettyalign" => 1,
	"a2m" => 0,
	"output_format" => 0,
	"column" => 0,
	"sequence_index" => 0,
	"sequence_ID" => 0,
	"max_inserts" => 0,
	"linelength" => 0,
	"space_char" => 0,
	"max_length" => 0,

    };

    $self->{ISCOMMAND}  = {
	"prettyalign" => 1,
	"a2m" => 0,
	"output_format" => 0,
	"column" => 0,
	"sequence_index" => 0,
	"sequence_ID" => 0,
	"max_inserts" => 0,
	"linelength" => 0,
	"space_char" => 0,
	"max_length" => 0,

    };

    $self->{ISMANDATORY}  = {
	"prettyalign" => 0,
	"a2m" => 1,
	"output_format" => 0,
	"column" => 0,
	"sequence_index" => 0,
	"sequence_ID" => 0,
	"max_inserts" => 0,
	"linelength" => 0,
	"space_char" => 0,
	"max_length" => 0,

    };

    $self->{PROMPT}  = {
	"prettyalign" => "",
	"a2m" => "Alignment",
	"output_format" => "Output format (-f and -I)",
	"column" => "Output column indices (-c)",
	"sequence_index" => "Sequence index (number) on each line (-n)",
	"sequence_ID" => "Toggle sequence ID to each line (-i)",
	"max_inserts" => "Max number of insertions printed (-m)",
	"linelength" => "Characters per line (-l)",
	"space_char" => "Char to show inserts  (-s)",
	"max_length" => "Maximum length of input lines (-L)",

    };

    $self->{ISSTANDOUT}  = {
	"prettyalign" => 0,
	"a2m" => 0,
	"output_format" => 0,
	"column" => 0,
	"sequence_index" => 0,
	"sequence_ID" => 0,
	"max_inserts" => 0,
	"linelength" => 0,
	"space_char" => 0,
	"max_length" => 0,

    };

    $self->{VLIST}  = {

	"output_format" => ['f','fasta (-f)','i','IG, turn off column index (-I)',],
    };

    $self->{FLIST}  = {

	"output_format" => {
		'' => '""',
		'f' => '" -f"',
		'i' => '" -I"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"output_format" => '""',
	"column" => '1',
	"sequence_index" => '0',
	"sequence_ID" => '1',
	"max_inserts" => '2000000',
	"linelength" => '70',
	"space_char" => '.',
	"max_length" => '30000',

    };

    $self->{PRECOND}  = {
	"prettyalign" => { "perl" => '1' },
	"a2m" => { "perl" => '1' },
	"output_format" => { "perl" => '1' },
	"column" => { "perl" => '1' },
	"sequence_index" => { "perl" => '1' },
	"sequence_ID" => { "perl" => '1' },
	"max_inserts" => { "perl" => '1' },
	"linelength" => { "perl" => '1' },
	"space_char" => { "perl" => '1' },
	"max_length" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"a2m" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"prettyalign" => 0,
	"a2m" => 0,
	"output_format" => 0,
	"column" => 0,
	"sequence_index" => 0,
	"sequence_ID" => 0,
	"max_inserts" => 0,
	"linelength" => 0,
	"space_char" => 0,
	"max_length" => 0,

    };

    $self->{ISSIMPLE}  = {
	"prettyalign" => 1,
	"a2m" => 1,
	"output_format" => 0,
	"column" => 0,
	"sequence_index" => 0,
	"sequence_ID" => 0,
	"max_inserts" => 0,
	"linelength" => 0,
	"space_char" => 0,
	"max_length" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"max_inserts" => [
		"Example: the sequence \'GacguacguG\' could be printed out as \'Ga8guG\' if 4 was the largest number of insertions that was to be allowed (note that the character 8 is using up one of the positions). By default, insertions of up to length ten thousand are fully printed.",
		"If set to zero, no insertions are printed, and no indication of the lack is given.",
		"If less than zero, insertion characters are not printed, and that number of digits is used to indicate the length of each insertion. ",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prettyalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

