# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::golden
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::golden

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::golden

      Bioperl class for:

	GOLDEN	fetch a database entry (N. Joly)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/golden.html 
         for available values):


		golden (String)

		db (Excl)
			Database

		query (String)
			query (Entry name or Accesion number)

		ac (Switch)
			Search with Accession number only (except nrl3d) (-a)

		id (Switch)
			Search with entry name only (-i)

		outfile (OutFile)
			pipe: seqfile

		convert (Switch)
			Change output format

		seqformat (Excl)
			Output Format

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

http://bioweb.pasteur.fr/seqanal/interfaces/golden.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::golden;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $golden = Bio::Tools::Run::PiseApplication::golden->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::golden object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $golden = $factory->program('golden');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::golden.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/golden.pm

    $self->{COMMAND}   = "golden";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "GOLDEN";

    $self->{DESCRIPTION}   = "fetch a database entry";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "N. Joly";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"golden",
	"db",
	"query",
	"ac",
	"id",
	"outfile",
	"convert",
	"seqformat",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"golden",
	"db", 	# Database
	"query", 	# query (Entry name or Accesion number)
	"ac", 	# Search with Accession number only (except nrl3d) (-a)
	"id", 	# Search with entry name only (-i)
	"outfile",
	"convert", 	# Change output format
	"seqformat", 	# Output Format

    ];

    $self->{TYPE}  = {
	"golden" => 'String',
	"db" => 'Excl',
	"query" => 'String',
	"ac" => 'Switch',
	"id" => 'Switch',
	"outfile" => 'OutFile',
	"convert" => 'Switch',
	"seqformat" => 'Excl',

    };

    $self->{FORMAT}  = {
	"golden" => {
		"seqlab" => 'golden',
		"perl" => '"golden"',
	},
	"db" => {
		"perl" => '" $db:"',
	},
	"query" => {
		"perl" => '"$value"',
	},
	"ac" => {
		"perl" => '($value) ? " -a" : ""',
	},
	"id" => {
		"perl" => '($value) ? " -i" : ""',
	},
	"outfile" => {
		"perl" => '""',
	},
	"convert" => {
		"perl" => '($value) ? " | fmtseq -p " : ""',
	},
	"seqformat" => {
		"perl" => '" -f$value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"golden" => 0,
	"db" => 2,
	"query" => 3,
	"ac" => 1,
	"id" => 1,
	"convert" => 100,
	"seqformat" => 110,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"golden",
	"outfile",
	"id",
	"ac",
	"db",
	"query",
	"convert",
	"seqformat",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"golden" => 1,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"id" => 0,
	"outfile" => 1,
	"convert" => 0,
	"seqformat" => 0,

    };

    $self->{ISCOMMAND}  = {
	"golden" => 1,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"id" => 0,
	"outfile" => 0,
	"convert" => 0,
	"seqformat" => 0,

    };

    $self->{ISMANDATORY}  = {
	"golden" => 0,
	"db" => 1,
	"query" => 1,
	"ac" => 0,
	"id" => 0,
	"outfile" => 0,
	"convert" => 0,
	"seqformat" => 1,

    };

    $self->{PROMPT}  = {
	"golden" => "",
	"db" => "Database",
	"query" => "query (Entry name or Accesion number)",
	"ac" => "Search with Accession number only (except nrl3d) (-a)",
	"id" => "Search with entry name only (-i)",
	"outfile" => "",
	"convert" => "Change output format",
	"seqformat" => "Output Format",

    };

    $self->{ISSTANDOUT}  = {
	"golden" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"id" => 0,
	"outfile" => 1,
	"convert" => 0,
	"seqformat" => 0,

    };

    $self->{VLIST}  = {

	"db" => ['embl','embl','epd','epd','genbank','genbank','genpept','genpept','pir','pir','swissprot','swissprot','trembl','trembl','nrl3d','nrl3d','imgt','imgt','sptrnrdb','sptrnrdb','prosite','prosite',],
	"seqformat" => ['1','1. Raw','2','2. Plain','3','3. EMBL','4','4. Swiss-Prot','5','5. GenBank','6','6. PIR (codata)','7','7. ASN.1','8','8. FASTA (Pearson)','9','9. FASTA','12','12. NBRF','13','13. NBRF-old','14','14. IG/Stanford','15','15. IG-old','16','16. GCG','17','17. MSF','18','18. PHYLIP','19','19. PHYLIP-Interleaved','20','20. PHYLIP-Sequential','21','21. Clustalw','22','22. Pretty',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"db" => 'embl',
	"ac" => '0',
	"id" => '0',
	"outfile" => '"golden.out"',
	"convert" => '0',
	"seqformat" => '9',

    };

    $self->{PRECOND}  = {
	"golden" => { "perl" => '1' },
	"db" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"ac" => { "perl" => '1' },
	"id" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"convert" => { "perl" => '1' },
	"seqformat" => {
		"perl" => '$convert',
	},

    };

    $self->{CTRL}  = {
	"ac" => {
		"perl" => {
			'$ac and $db eq "nrl3d"' => "No Accesion number for Nrl3d",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '! $entrynameonly' => "seqfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"golden" => 0,
	"db" => 0,
	"query" => 0,
	"ac" => 0,
	"id" => 0,
	"outfile" => 0,
	"convert" => 0,
	"seqformat" => 0,

    };

    $self->{ISSIMPLE}  = {
	"golden" => 1,
	"db" => 1,
	"query" => 1,
	"ac" => 0,
	"id" => 0,
	"outfile" => 0,
	"convert" => 1,
	"seqformat" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/golden.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

