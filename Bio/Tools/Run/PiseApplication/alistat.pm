# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::alistat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::alistat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::alistat

      Bioperl class for:

	HMMER	alistat - show statistics for a multiple alignment file (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/alistat.html 
         for available values):


		alistat (String)

		toto (String)

		multali_file (Sequence)
			multiple alignment file
			pipe: hmmer_alig

		verbose (Switch)
			Show additional verbose information (-a)

		fast (Switch)
			Fast (-f)

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

http://bioweb.pasteur.fr/seqanal/interfaces/alistat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::alistat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $alistat = Bio::Tools::Run::PiseApplication::alistat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::alistat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $alistat = $factory->program('alistat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::alistat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/alistat.pm

    $self->{COMMAND}   = "alistat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "alistat - show statistics for a multiple alignment file";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"alistat",
	"description",
	"multali_file",
	"verbose",
	"fast",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"alistat",
	"description", 	# description of alistat
	"toto",
	"multali_file", 	# multiple alignment file
	"verbose", 	# Show additional verbose information (-a)
	"fast", 	# Fast (-f)

    ];

    $self->{TYPE}  = {
	"alistat" => 'String',
	"description" => 'Paragraph',
	"toto" => 'String',
	"multali_file" => 'Sequence',
	"verbose" => 'Switch',
	"fast" => 'Switch',

    };

    $self->{FORMAT}  = {
	"alistat" => {
		"perl" => '"alistat"',
	},
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"multali_file" => {
		"perl" => '" $value"',
	},
	"verbose" => {
		"perl" => '($value) ? " -a" : ""',
	},
	"fast" => {
		"perl" => '($value) ? " -f" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"alistat" => 0,
	"toto" => 1000,
	"multali_file" => 2,
	"verbose" => 1,
	"fast" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"alistat",
	"description",
	"verbose",
	"fast",
	"multali_file",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"alistat" => 1,
	"description" => 0,
	"toto" => 1,
	"multali_file" => 0,
	"verbose" => 0,
	"fast" => 0,

    };

    $self->{ISCOMMAND}  = {
	"alistat" => 1,
	"description" => 0,
	"toto" => 0,
	"multali_file" => 0,
	"verbose" => 0,
	"fast" => 0,

    };

    $self->{ISMANDATORY}  = {
	"alistat" => 0,
	"description" => 0,
	"toto" => 0,
	"multali_file" => 1,
	"verbose" => 0,
	"fast" => 0,

    };

    $self->{PROMPT}  = {
	"alistat" => "",
	"description" => "description of alistat",
	"toto" => "",
	"multali_file" => "multiple alignment file",
	"verbose" => "Show additional verbose information (-a)",
	"fast" => "Fast (-f)",

    };

    $self->{ISSTANDOUT}  = {
	"alistat" => 0,
	"description" => 0,
	"toto" => 0,
	"multali_file" => 0,
	"verbose" => 0,
	"fast" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"alistat" => { "perl" => '1' },
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"multali_file" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"fast" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"multali_file" => {
		 "hmmer_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"alistat" => 0,
	"description" => 0,
	"toto" => 0,
	"multali_file" => 0,
	"verbose" => 0,
	"fast" => 0,

    };

    $self->{ISSIMPLE}  = {
	"alistat" => 0,
	"description" => 0,
	"toto" => 0,
	"multali_file" => 0,
	"verbose" => 0,
	"fast" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"alistat reads a multiple sequence alignment from the file alignfile in any supported format (including SELEX, GCG MSF, and CLUSTAL), and shows a number of simple statistics about it. These statistics include the name of the format, the number of sequences, the total number of residues, the average and range of the sequence lengths, the alignment length (e.g. including gap characters).",
		"Also shown are some percent identities. A percent pairwise alignment identity is defined as (idents / MIN(len1, len2)) where idents is the number of exact identities and len1, len2 are the unaligned lengths of the two sequences. The average percent identity, most related pair, and most unrelated pair of the alignment are the average, maximum, and minimum of all (N)(N-1)/2 pairs, respectively. The most distant seq is calculated by finding the maximum pairwise identity (best relative) for all N sequences, then finding the minimum of these N numbers (hence, the most outlying sequence).",
	],
	"verbose" => [
		"Additional information: a table with one line per sequence showing name, length, and its highest and lowest pairwise identity. These lines are prefixed with a * character to enable easily grep\'ing them out and sorting them. For example, alistat -a foo.slx grep * gives a ranked list of the most distant sequences in the alignment. Incompatible with the -f option.",
	],
	"fast" => [
		"use a sampling method to estimate the average %id. When this option is chosen, alistat doesn\'t show the other three pairwise identity numbers. This option is useful for very large alignments, for which the full (N)(N-1) calculation of all pairs would be prohibitive (e.g. Pfam\'s GP120 alignment, with over 10,000 sequences). Incompatible with the -a option.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/alistat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

