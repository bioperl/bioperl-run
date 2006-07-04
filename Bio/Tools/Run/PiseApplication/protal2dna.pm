# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::protal2dna
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::protal2dna

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::protal2dna

      Bioperl class for:

	protal2dna	Align DNA sequences corresponding to a protein    alignment (K. Schuerer, C. Letondal)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/protal2dna.html 
         for available values):


		protal2dna (String)

		outfile (OutFile)
			pipe: readseq_ok_alig

		alig (Sequence)
			Protein alignment
			pipe: readseq_ok_alig

		dna (Sequence)
			DNA Sequences File

		fasta (String)

		same_ids (Switch)
			Identify corresponding DNA sequences by same ID or name (-i)

		outformat (Excl)
			Output Alignment Format

		genetic (Excl)
			Default Genetic Code (-g)

		speccode (InFile)
			Special Genetic Code (-G)

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

http://bioweb.pasteur.fr/seqanal/interfaces/protal2dna.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::protal2dna;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $protal2dna = Bio::Tools::Run::PiseApplication::protal2dna->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::protal2dna object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $protal2dna = $factory->program('protal2dna');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::protal2dna.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/protal2dna.pm

    $self->{COMMAND}   = "protal2dna";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "protal2dna";

    $self->{DESCRIPTION}   = "Align DNA sequences corresponding to a protein    alignment";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "K. Schuerer, C. Letondal";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"protal2dna",
	"outfile",
	"alig",
	"dna",
	"fasta",
	"same_ids",
	"outformat",
	"genetic",
	"speccode",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"protal2dna",
	"outfile",
	"alig", 	# Protein alignment
	"dna", 	# DNA Sequences File
	"fasta",
	"same_ids", 	# Identify corresponding DNA sequences by same ID or name (-i)
	"outformat", 	# Output Alignment Format
	"genetic", 	# Default Genetic Code (-g)
	"speccode", 	# Special Genetic Code (-G)

    ];

    $self->{TYPE}  = {
	"protal2dna" => 'String',
	"outfile" => 'OutFile',
	"alig" => 'Sequence',
	"dna" => 'Sequence',
	"fasta" => 'String',
	"same_ids" => 'Switch',
	"outformat" => 'Excl',
	"genetic" => 'Excl',
	"speccode" => 'InFile',

    };

    $self->{FORMAT}  = {
	"protal2dna" => {
		"perl" => '"protal2dna"',
	},
	"outfile" => {
	},
	"alig" => {
		"perl" => '" $value"',
	},
	"dna" => {
		"perl" => '" $value"',
	},
	"fasta" => {
		"perl" => '"mv $dna $dna.in ;  fasta2fasta $dna.in > $dna ; "',
	},
	"same_ids" => {
		"perl" => '($value && $value ne $vdef) ? " -i" : ""',
	},
	"outformat" => {
		"perl" => '($value && $value ne $vdef) ? " -f $value" : ""',
	},
	"genetic" => {
		"perl" => ' ($value && $value ne $vdef) ? " -g $value" : "" ',
	},
	"speccode" => {
		"perl" => ' ($value) ? " -G $value" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"alig" => [100],
	"dna" => [8],

    };

    $self->{GROUP}  = {
	"protal2dna" => 0,
	"alig" => 100,
	"dna" => 101,
	"fasta" => -10,
	"same_ids" => 1,
	"outformat" => 1,
	"genetic" => 1,
	"speccode" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"fasta",
	"protal2dna",
	"outfile",
	"speccode",
	"same_ids",
	"outformat",
	"genetic",
	"alig",
	"dna",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"protal2dna" => 1,
	"outfile" => 1,
	"alig" => 0,
	"dna" => 0,
	"fasta" => 1,
	"same_ids" => 0,
	"outformat" => 0,
	"genetic" => 0,
	"speccode" => 0,

    };

    $self->{ISCOMMAND}  = {
	"protal2dna" => 1,
	"outfile" => 0,
	"alig" => 0,
	"dna" => 0,
	"fasta" => 0,
	"same_ids" => 0,
	"outformat" => 0,
	"genetic" => 0,
	"speccode" => 0,

    };

    $self->{ISMANDATORY}  = {
	"protal2dna" => 0,
	"outfile" => 0,
	"alig" => 1,
	"dna" => 1,
	"fasta" => 0,
	"same_ids" => 0,
	"outformat" => 0,
	"genetic" => 0,
	"speccode" => 0,

    };

    $self->{PROMPT}  = {
	"protal2dna" => "",
	"outfile" => "",
	"alig" => "Protein alignment",
	"dna" => "DNA Sequences File",
	"fasta" => "",
	"same_ids" => "Identify corresponding DNA sequences by same ID or name (-i)",
	"outformat" => "Output Alignment Format",
	"genetic" => "Default Genetic Code (-g)",
	"speccode" => "Special Genetic Code (-G)",

    };

    $self->{ISSTANDOUT}  = {
	"protal2dna" => 0,
	"outfile" => 1,
	"alig" => 0,
	"dna" => 0,
	"fasta" => 0,
	"same_ids" => 0,
	"outformat" => 0,
	"genetic" => 0,
	"speccode" => 0,

    };

    $self->{VLIST}  = {

	"outformat" => ['fasta','Pearson/Fasta','pfam','Pfam','msf','MSF','clustalw','Clustalw',],
	"genetic" => ['1','Standard','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => '"protal2dna.out"',
	"same_ids" => '0',
	"outformat" => 'clustalw',
	"genetic" => '1',

    };

    $self->{PRECOND}  = {
	"protal2dna" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"alig" => { "perl" => '1' },
	"dna" => { "perl" => '1' },
	"fasta" => { "perl" => '1' },
	"same_ids" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },
	"genetic" => { "perl" => '1' },
	"speccode" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"alig" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"protal2dna" => 0,
	"outfile" => 0,
	"alig" => 0,
	"dna" => 0,
	"fasta" => 0,
	"same_ids" => 0,
	"outformat" => 0,
	"genetic" => 0,
	"speccode" => 0,

    };

    $self->{ISSIMPLE}  = {
	"protal2dna" => 0,
	"outfile" => 0,
	"alig" => 1,
	"dna" => 1,
	"fasta" => 0,
	"same_ids" => 1,
	"outformat" => 0,
	"genetic" => 0,
	"speccode" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"dna" => [
		"The DNA sequences must contain at least the region coding for each sequence of the protein alignment.",
	],
	"same_ids" => [
		"The correspondance between protein and DNA sequences may be based on their position in the files or by their name.",
	],
	"speccode" => [
		"File containing genetic code numbers of sequences that differs from the default code used. Format: one special code per line with prot-id used in the alignment followed by the code number",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/protal2dna.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

