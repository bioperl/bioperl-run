# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::codnocod
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::codnocod

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::codnocod

      Bioperl class for:

	CODNOCOD	outputs feature from Genbank entries


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/codnocod.html 
         for available values):


		codnocod (String)

		seq (Sequence)
			Genbank sequence File
			pipe: gb_seq

		length (Switch)
			Length (-l)

		definition (Switch)
			DEFINITION (-d)

		accession (Switch)
			ACCESSION (-a)

		nid (Switch)
			NID (-N)

		organism (Switch)
			ORGANISM (-o)

		cds_dna (Switch)
			Coding sequence - dna (-c)

		cds_aa (Switch)
			Coding sequence - aa (-C)

		cinq (Switch)
			5' sequence (-f)

		trois (Switch)
			3' sequence (-t)

		exon_list (Switch)
			Exon list (-e)

		exon_sequences (Switch)
			Exon sequences (-E)

		intron_sequences (Switch)
			Intron sequences (-I)

		all_sequences (Switch)
			All sequences (-A)

		srs (Switch)
			Entries retrieved using SRS (-S)

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

http://bioweb.pasteur.fr/seqanal/interfaces/codnocod.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::codnocod;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $codnocod = Bio::Tools::Run::PiseApplication::codnocod->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::codnocod object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $codnocod = $factory->program('codnocod');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::codnocod.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codnocod.pm

    $self->{COMMAND}   = "codnocod";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CODNOCOD";

    $self->{DESCRIPTION}   = "outputs feature from Genbank entries";

    $self->{OPT_EMAIL}   = 0;

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"codnocod",
	"seq",
	"length",
	"definition",
	"accession",
	"nid",
	"organism",
	"cds_dna",
	"cds_aa",
	"cinq",
	"trois",
	"exon_list",
	"exon_sequences",
	"intron_sequences",
	"all_sequences",
	"srs",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"codnocod",
	"seq", 	# Genbank sequence File
	"length", 	# Length (-l)
	"definition", 	# DEFINITION (-d)
	"accession", 	# ACCESSION (-a)
	"nid", 	# NID (-N)
	"organism", 	# ORGANISM (-o)
	"cds_dna", 	# Coding sequence - dna (-c)
	"cds_aa", 	# Coding sequence - aa (-C)
	"cinq", 	# 5' sequence (-f)
	"trois", 	# 3' sequence (-t)
	"exon_list", 	# Exon list (-e)
	"exon_sequences", 	# Exon sequences (-E)
	"intron_sequences", 	# Intron sequences (-I)
	"all_sequences", 	# All sequences (-A)
	"srs", 	# Entries retrieved using SRS (-S)

    ];

    $self->{TYPE}  = {
	"codnocod" => 'String',
	"seq" => 'Sequence',
	"length" => 'Switch',
	"definition" => 'Switch',
	"accession" => 'Switch',
	"nid" => 'Switch',
	"organism" => 'Switch',
	"cds_dna" => 'Switch',
	"cds_aa" => 'Switch',
	"cinq" => 'Switch',
	"trois" => 'Switch',
	"exon_list" => 'Switch',
	"exon_sequences" => 'Switch',
	"intron_sequences" => 'Switch',
	"all_sequences" => 'Switch',
	"srs" => 'Switch',

    };

    $self->{FORMAT}  = {
	"codnocod" => {
		"seqlab" => 'codnocod',
		"perl" => '"codnocod"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"length" => {
		"perl" => ' ($value)? " -l" : "" ',
	},
	"definition" => {
		"perl" => ' ($value)? " -d" : "" ',
	},
	"accession" => {
		"perl" => ' ($value)? " -a" : "" ',
	},
	"nid" => {
		"perl" => ' ($value)? " -N" : "" ',
	},
	"organism" => {
		"perl" => ' ($value)? " -o" : "" ',
	},
	"cds_dna" => {
		"perl" => ' ($value)? " -c" : "" ',
	},
	"cds_aa" => {
		"perl" => ' ($value)? " -C" : "" ',
	},
	"cinq" => {
		"perl" => ' ($value)? " -f" : "" ',
	},
	"trois" => {
		"perl" => ' ($value)? " -t" : "" ',
	},
	"exon_list" => {
		"perl" => ' ($value)? " -e" : "" ',
	},
	"exon_sequences" => {
		"perl" => ' ($value)? " -E" : "" ',
	},
	"intron_sequences" => {
		"perl" => ' ($value)? " -I" : "" ',
	},
	"all_sequences" => {
		"perl" => ' ($value)? " -A" : "" ',
	},
	"srs" => {
		"perl" => ' ($value)? " -S" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [2],

    };

    $self->{GROUP}  = {
	"codnocod" => 0,
	"seq" => 2,
	"length" => 1,
	"definition" => 1,
	"accession" => 1,
	"nid" => 1,
	"organism" => 1,
	"cds_dna" => 1,
	"cds_aa" => 1,
	"cinq" => 1,
	"trois" => 1,
	"exon_list" => 1,
	"exon_sequences" => 1,
	"intron_sequences" => 1,
	"all_sequences" => 1,
	"srs" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"codnocod",
	"srs",
	"length",
	"definition",
	"accession",
	"nid",
	"organism",
	"cds_dna",
	"cds_aa",
	"cinq",
	"trois",
	"exon_list",
	"exon_sequences",
	"intron_sequences",
	"all_sequences",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"codnocod" => 1,
	"seq" => 0,
	"length" => 0,
	"definition" => 0,
	"accession" => 0,
	"nid" => 0,
	"organism" => 0,
	"cds_dna" => 0,
	"cds_aa" => 0,
	"cinq" => 0,
	"trois" => 0,
	"exon_list" => 0,
	"exon_sequences" => 0,
	"intron_sequences" => 0,
	"all_sequences" => 0,
	"srs" => 0,

    };

    $self->{ISCOMMAND}  = {
	"codnocod" => 1,
	"seq" => 0,
	"length" => 0,
	"definition" => 0,
	"accession" => 0,
	"nid" => 0,
	"organism" => 0,
	"cds_dna" => 0,
	"cds_aa" => 0,
	"cinq" => 0,
	"trois" => 0,
	"exon_list" => 0,
	"exon_sequences" => 0,
	"intron_sequences" => 0,
	"all_sequences" => 0,
	"srs" => 0,

    };

    $self->{ISMANDATORY}  = {
	"codnocod" => 0,
	"seq" => 1,
	"length" => 0,
	"definition" => 0,
	"accession" => 0,
	"nid" => 0,
	"organism" => 0,
	"cds_dna" => 0,
	"cds_aa" => 0,
	"cinq" => 0,
	"trois" => 0,
	"exon_list" => 0,
	"exon_sequences" => 0,
	"intron_sequences" => 0,
	"all_sequences" => 0,
	"srs" => 0,

    };

    $self->{PROMPT}  = {
	"codnocod" => "",
	"seq" => "Genbank sequence File",
	"length" => "Length (-l)",
	"definition" => "DEFINITION (-d)",
	"accession" => "ACCESSION (-a)",
	"nid" => "NID (-N)",
	"organism" => "ORGANISM (-o)",
	"cds_dna" => "Coding sequence - dna (-c)",
	"cds_aa" => "Coding sequence - aa (-C)",
	"cinq" => "5' sequence (-f)",
	"trois" => "3' sequence (-t)",
	"exon_list" => "Exon list (-e)",
	"exon_sequences" => "Exon sequences (-E)",
	"intron_sequences" => "Intron sequences (-I)",
	"all_sequences" => "All sequences (-A)",
	"srs" => "Entries retrieved using SRS (-S)",

    };

    $self->{ISSTANDOUT}  = {
	"codnocod" => 0,
	"seq" => 0,
	"length" => 0,
	"definition" => 0,
	"accession" => 0,
	"nid" => 0,
	"organism" => 0,
	"cds_dna" => 0,
	"cds_aa" => 0,
	"cinq" => 0,
	"trois" => 0,
	"exon_list" => 0,
	"exon_sequences" => 0,
	"intron_sequences" => 0,
	"all_sequences" => 0,
	"srs" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"length" => '0',
	"definition" => '0',
	"accession" => '0',
	"nid" => '0',
	"organism" => '0',
	"cds_dna" => '0',
	"cds_aa" => '0',
	"cinq" => '0',
	"trois" => '0',
	"exon_list" => '0',
	"exon_sequences" => '0',
	"intron_sequences" => '0',
	"all_sequences" => '0',
	"srs" => '0',

    };

    $self->{PRECOND}  = {
	"codnocod" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"definition" => { "perl" => '1' },
	"accession" => { "perl" => '1' },
	"nid" => { "perl" => '1' },
	"organism" => { "perl" => '1' },
	"cds_dna" => { "perl" => '1' },
	"cds_aa" => { "perl" => '1' },
	"cinq" => { "perl" => '1' },
	"trois" => { "perl" => '1' },
	"exon_list" => { "perl" => '1' },
	"exon_sequences" => { "perl" => '1' },
	"intron_sequences" => { "perl" => '1' },
	"all_sequences" => { "perl" => '1' },
	"srs" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "gb_seq" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"codnocod" => 0,
	"seq" => 0,
	"length" => 0,
	"definition" => 0,
	"accession" => 0,
	"nid" => 0,
	"organism" => 0,
	"cds_dna" => 0,
	"cds_aa" => 0,
	"cinq" => 0,
	"trois" => 0,
	"exon_list" => 0,
	"exon_sequences" => 0,
	"intron_sequences" => 0,
	"all_sequences" => 0,
	"srs" => 0,

    };

    $self->{ISSIMPLE}  = {
	"codnocod" => 1,
	"seq" => 1,
	"length" => 1,
	"definition" => 1,
	"accession" => 1,
	"nid" => 1,
	"organism" => 1,
	"cds_dna" => 1,
	"cds_aa" => 1,
	"cinq" => 1,
	"trois" => 1,
	"exon_list" => 1,
	"exon_sequences" => 1,
	"intron_sequences" => 1,
	"all_sequences" => 1,
	"srs" => 1,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"srs" => [
		"no ORIGIN line and sequence is numbered on the right",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codnocod.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

