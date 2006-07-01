# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::seqsblast
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::seqsblast

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::seqsblast

      Bioperl class for:

	SEQSBLAST	extracting sequences from a Blast output


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/seqsblast.html 
         for available values):


		seqsblast (String)

		infile (InFile)
			Blast output File
			pipe: blast_output

		howmany (Integer)
			How many sequences? (-n)

		outformat (Excl)
			Output Sequence Format (readseq formats) (-f)

		signif (Float)
			Signifiance threshold (-s)

		print_hsp (Switch)
			Get HSP (instead of entry) (-H)

		extend_hsp (Switch)
			Extend HSP to query (-e)

		extend_left (Integer)
			Extend to # additional position on the left (-l)

		extend_right (Integer)
			Extend to # additional position on the right (-r)

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

http://bioweb.pasteur.fr/seqanal/interfaces/seqsblast.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::seqsblast;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $seqsblast = Bio::Tools::Run::PiseApplication::seqsblast->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::seqsblast object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $seqsblast = $factory->program('seqsblast');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::seqsblast.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqsblast.pm

    $self->{COMMAND}   = "seqsblast";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SEQSBLAST";

    $self->{DESCRIPTION}   = "extracting sequences from a Blast output";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"seqsblast",
	"infile",
	"howmany",
	"other_options",
	"seqsfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"seqsblast",
	"infile", 	# Blast output File
	"howmany", 	# How many sequences? (-n)
	"other_options", 	# Other options
	"outformat", 	# Output Sequence Format (readseq formats) (-f)
	"signif", 	# Signifiance threshold (-s)
	"print_hsp", 	# Get HSP (instead of entry) (-H)
	"extend_hsp", 	# Extend HSP to query (-e)
	"extend_left", 	# Extend to # additional position on the left (-l)
	"extend_right", 	# Extend to # additional position on the right (-r)
	"seqsfile",

    ];

    $self->{TYPE}  = {
	"seqsblast" => 'String',
	"infile" => 'InFile',
	"howmany" => 'Integer',
	"other_options" => 'Paragraph',
	"outformat" => 'Excl',
	"signif" => 'Float',
	"print_hsp" => 'Switch',
	"extend_hsp" => 'Switch',
	"extend_left" => 'Integer',
	"extend_right" => 'Integer',
	"seqsfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"seqsblast" => {
		"seqlab" => 'seqsblast',
		"perl" => '"seqsblast"',
	},
	"infile" => {
		"perl" => '" $value"',
	},
	"howmany" => {
		"perl" => '($value) ? " -n $value" : ""',
	},
	"other_options" => {
	},
	"outformat" => {
		"perl" => '" -f $value"',
	},
	"signif" => {
		"perl" => '(defined $value)? " -s $value" : ""',
	},
	"print_hsp" => {
		"perl" => '($value)? " -H" : ""',
	},
	"extend_hsp" => {
		"perl" => '($value)? " -e" : ""',
	},
	"extend_left" => {
		"perl" => '($value)? " -l $value" : ""',
	},
	"extend_right" => {
		"perl" => '($value)? " -r $value" : ""',
	},
	"seqsfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"seqsfile" => '*.seqs',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"seqsblast" => 0,
	"infile" => 10,
	"howmany" => 1,
	"other_options" => 1,
	"outformat" => 1,
	"signif" => 1,
	"print_hsp" => 1,
	"extend_hsp" => 1,
	"extend_left" => 1,
	"extend_right" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"seqsblast",
	"seqsfile",
	"howmany",
	"other_options",
	"outformat",
	"signif",
	"print_hsp",
	"extend_hsp",
	"extend_left",
	"extend_right",
	"infile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"seqsblast" => 1,
	"infile" => 0,
	"howmany" => 0,
	"other_options" => 0,
	"outformat" => 0,
	"signif" => 0,
	"print_hsp" => 0,
	"extend_hsp" => 0,
	"extend_left" => 0,
	"extend_right" => 0,
	"seqsfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"seqsblast" => 1,
	"infile" => 0,
	"howmany" => 0,
	"other_options" => 0,
	"outformat" => 0,
	"signif" => 0,
	"print_hsp" => 0,
	"extend_hsp" => 0,
	"extend_left" => 0,
	"extend_right" => 0,
	"seqsfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"seqsblast" => 0,
	"infile" => 1,
	"howmany" => 0,
	"other_options" => 0,
	"outformat" => 1,
	"signif" => 0,
	"print_hsp" => 0,
	"extend_hsp" => 0,
	"extend_left" => 0,
	"extend_right" => 0,
	"seqsfile" => 0,

    };

    $self->{PROMPT}  = {
	"seqsblast" => "",
	"infile" => "Blast output File",
	"howmany" => "How many sequences? (-n)",
	"other_options" => "Other options",
	"outformat" => "Output Sequence Format (readseq formats) (-f)",
	"signif" => "Signifiance threshold (-s)",
	"print_hsp" => "Get HSP (instead of entry) (-H)",
	"extend_hsp" => "Extend HSP to query (-e)",
	"extend_left" => "Extend to # additional position on the left (-l)",
	"extend_right" => "Extend to # additional position on the right (-r)",
	"seqsfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"seqsblast" => 0,
	"infile" => 0,
	"howmany" => 0,
	"other_options" => 0,
	"outformat" => 0,
	"signif" => 0,
	"print_hsp" => 0,
	"extend_hsp" => 0,
	"extend_left" => 0,
	"extend_right" => 0,
	"seqsfile" => 0,

    };

    $self->{VLIST}  = {

	"other_options" => ['outformat','signif','print_hsp','extend_hsp','extend_left','extend_right',],
	"outformat" => ['1','1. IG/Stanford','2','2. GenBank/GB','3','3. NBRF','4','4. EMBL','6','6. DNAStrider','7','7. Fitch','8','8. Pearson/Fasta','9','9. Zuker','10','10. Olsen (in-only)','14','14. PIR/CODATA','16','16. ASN.1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outformat" => '8',
	"print_hsp" => '1',

    };

    $self->{PRECOND}  = {
	"seqsblast" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"howmany" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },
	"signif" => { "perl" => '1' },
	"print_hsp" => { "perl" => '1' },
	"extend_hsp" => { "perl" => '1' },
	"extend_left" => { "perl" => '1' },
	"extend_right" => { "perl" => '1' },
	"seqsfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"howmany" => {
		"perl" => {
			'! ($signif || $howmany)' => "You must either enter a number of sequences or a significance threshold.",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"seqsfile" => {
		 '1' => "seqsfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "blast_output" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"seqsblast" => 0,
	"infile" => 0,
	"howmany" => 0,
	"other_options" => 0,
	"outformat" => 0,
	"signif" => 0,
	"print_hsp" => 0,
	"extend_hsp" => 0,
	"extend_left" => 0,
	"extend_right" => 0,
	"seqsfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"seqsblast" => 1,
	"infile" => 1,
	"howmany" => 1,
	"other_options" => 0,
	"outformat" => 0,
	"signif" => 0,
	"print_hsp" => 1,
	"extend_hsp" => 0,
	"extend_left" => 0,
	"extend_right" => 0,
	"seqsfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"howmany" => [
		"You must either enter a number of sequences or a significance threshold (see: Other options).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqsblast.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

