# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::lgicsearch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::lgicsearch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::lgicsearch

      Bioperl class for:

	LGIC	Search LGIC databases (Le Novere, Changeux)

	References:

		Nicolas LE NOVERE and Jean-Pierre CHANGEUX (1999). The Ligand-Gated Ion Channel database. Nucleic Acid Research, 27 : 340-342



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/lgicsearch.html 
         for available values):


		lgicsearch (Excl)
			Fasta program

		query (Sequence)
			Query sequence File

		seqtype (Excl)
			Is it a DNA or protein sequence

		protein_db (Excl)
			Protein Database

		nucleotid_db (Excl)
			Nucleotid Database

		ktup (Integer)

		threeframe (Switch)
			(tfasta only) only the three forward frames are searched

		txtoutput (String)

		lgicdbf2h (Switch)

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

http://bioweb.pasteur.fr/seqanal/interfaces/lgicsearch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::lgicsearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $lgicsearch = Bio::Tools::Run::PiseApplication::lgicsearch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::lgicsearch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $lgicsearch = $factory->program('lgicsearch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::lgicsearch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lgicsearch.pm

    $self->{COMMAND}   = "lgicsearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "LGIC";

    $self->{DESCRIPTION}   = "Search LGIC databases";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Le Novere, Changeux";

    $self->{DOCLINK}   = "http://www.pasteur.fr/recherche/banques/LGIC/LGIC.html";

    $self->{REFERENCE}   = [

         "Nicolas LE NOVERE and Jean-Pierre CHANGEUX (1999). The Ligand-Gated Ion Channel database. Nucleic Acid Research, 27 : 340-342",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"lgicsearch",
	"query",
	"seqtype",
	"protein_db",
	"nucleotid_db",
	"ktup",
	"threeframe",
	"tmp_outfile",
	"txtoutput",
	"lgicdbf2h",
	"html_outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"lgicsearch", 	# Fasta program
	"query", 	# Query sequence File
	"seqtype", 	# Is it a DNA or protein sequence
	"protein_db", 	# Protein Database
	"nucleotid_db", 	# Nucleotid Database
	"ktup",
	"threeframe", 	# (tfasta only) only the three forward frames are searched
	"tmp_outfile",
	"txtoutput",
	"lgicdbf2h",
	"html_outfile",

    ];

    $self->{TYPE}  = {
	"lgicsearch" => 'Excl',
	"query" => 'Sequence',
	"seqtype" => 'Excl',
	"protein_db" => 'Excl',
	"nucleotid_db" => 'Excl',
	"ktup" => 'Integer',
	"threeframe" => 'Switch',
	"tmp_outfile" => 'Results',
	"txtoutput" => 'String',
	"lgicdbf2h" => 'Switch',
	"html_outfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"lgicsearch" => {
		"perl" => '$value',
	},
	"query" => {
		"perl" => '" $value"',
	},
	"seqtype" => {
		"perl" => '(($lgicsearch =~ /^fasta/ && $value eq "DNA") || $lgicsearch =~ /^fast(x|y)/)? " -n":""',
	},
	"protein_db" => {
		"perl" => ' " /local/databases/fasta/$value"',
	},
	"nucleotid_db" => {
		"perl" => ' " /local/databases/fasta/$value" ',
	},
	"ktup" => {
		"perl" => '(defined $value)? " 1":""',
	},
	"threeframe" => {
		"perl" => '($value)? " -3":""',
	},
	"tmp_outfile" => {
	},
	"txtoutput" => {
		"perl" => ' " > lgicsearch.txt" ',
	},
	"lgicdbf2h" => {
		"perl" => ' " && lgicdbf2h < lgicsearch.txt > lgicsearch.html " ',
	},
	"html_outfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"tmp_outfile" => 'lgicsearch.txt',
	"html_outfile" => 'lgicsearch.html',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"lgicsearch" => 0,
	"query" => 2,
	"seqtype" => 1,
	"protein_db" => 3,
	"nucleotid_db" => 3,
	"ktup" => 4,
	"threeframe" => 1,
	"txtoutput" => 7,
	"lgicdbf2h" => 100,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"lgicsearch",
	"tmp_outfile",
	"html_outfile",
	"seqtype",
	"threeframe",
	"query",
	"protein_db",
	"nucleotid_db",
	"ktup",
	"txtoutput",
	"lgicdbf2h",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"lgicsearch" => 0,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"ktup" => 1,
	"threeframe" => 0,
	"tmp_outfile" => 0,
	"txtoutput" => 1,
	"lgicdbf2h" => 1,
	"html_outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"lgicsearch" => 1,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"ktup" => 0,
	"threeframe" => 0,
	"tmp_outfile" => 0,
	"txtoutput" => 0,
	"lgicdbf2h" => 0,
	"html_outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"lgicsearch" => 1,
	"query" => 1,
	"seqtype" => 1,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"ktup" => 0,
	"threeframe" => 0,
	"tmp_outfile" => 0,
	"txtoutput" => 0,
	"lgicdbf2h" => 0,
	"html_outfile" => 0,

    };

    $self->{PROMPT}  = {
	"lgicsearch" => "Fasta program",
	"query" => "Query sequence File",
	"seqtype" => "Is it a DNA or protein sequence",
	"protein_db" => "Protein Database",
	"nucleotid_db" => "Nucleotid Database",
	"ktup" => "",
	"threeframe" => "(tfasta only) only the three forward frames are searched",
	"tmp_outfile" => "",
	"txtoutput" => "",
	"lgicdbf2h" => "",
	"html_outfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"lgicsearch" => 0,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"ktup" => 0,
	"threeframe" => 0,
	"tmp_outfile" => 0,
	"txtoutput" => 0,
	"lgicdbf2h" => 0,
	"html_outfile" => 0,

    };

    $self->{VLIST}  = {

	"lgicsearch" => ['fasta_t','fasta: protein or DNA query vs similar db (FASTA release 3.0)','tfasta_t','tfasta: protein query vs translated DNA db (rel 3.0)',],
	"seqtype" => ['DNA','DNA','protein','protein',],
	"protein_db" => ['lgicallpep','lgicallpep: all super-families','lgicachpep','lgicachpep: acetylcholine super-family subunits','lgicglupep','lgicglupep: glutamate excitatory super-family','lgicatppep','lgicatppep: ATP super-family',],
	"nucleotid_db" => ['lgicallnuc','lgicallnuc: all super-families','lgicachnuc','lgicachnuc: acetylcholine super-family subunits','lgicglunuc','lgicglunuc: glutamate excitatory super-family','lgicatpnuc','lgicatpnuc: ATP super-family',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"lgicsearch" => 'fasta_t',
	"protein_db" => 'allpep',
	"nucleotid_db" => 'allnuc',

    };

    $self->{PRECOND}  = {
	"lgicsearch" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"seqtype" => { "perl" => '1' },
	"protein_db" => {
		"perl" => '($seqtype eq "protein" && $lgicsearch =~ /^fasta/)',
	},
	"nucleotid_db" => {
		"perl" => ' ($seqtype eq "DNA" && $lgicsearch =~ /^fasta/ ) || $lgicsearch =~ /^tfast/ ',
	},
	"ktup" => { "perl" => '1' },
	"threeframe" => {
		"perl" => ' ($lgicsearch =~ /^tfasta/) ',
	},
	"tmp_outfile" => { "perl" => '1' },
	"txtoutput" => { "perl" => '1' },
	"lgicdbf2h" => { "perl" => '1' },
	"html_outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"seqtype" => {
		"perl" => {
			'$lgicsearch =~ /^tfast/ && $seqtype eq "DNA"' => "tfasta, tfastx and tfasty take a protein sequence",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"tmp_outfile" => {
		 '1' => "mview_input",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"lgicsearch" => 0,
	"query" => 0,
	"seqtype" => 0,
	"protein_db" => 0,
	"nucleotid_db" => 0,
	"ktup" => 0,
	"threeframe" => 0,
	"tmp_outfile" => 0,
	"txtoutput" => 0,
	"lgicdbf2h" => 0,
	"html_outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"lgicsearch" => 0,
	"query" => 1,
	"seqtype" => 1,
	"protein_db" => 1,
	"nucleotid_db" => 1,
	"ktup" => 0,
	"threeframe" => 0,
	"tmp_outfile" => 0,
	"txtoutput" => 0,
	"lgicdbf2h" => 0,
	"html_outfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/lgicsearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

