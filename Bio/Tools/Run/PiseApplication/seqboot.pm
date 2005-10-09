# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::seqboot
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::seqboot

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::seqboot

      Bioperl class for:

	Phylip	seqboot - Bootstrap, Jackknife, or Permutation Resampling (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/seqboot.html 
         for available values):


		seqboot (String)

		infile (InFile)
			Alignement File

		data_type (Excl)
			Data type (D)

		method (Excl)
			Resampling methods (J)

		seed (Integer)
			Random number seed (must be odd)

		replicates (Integer)
			How many replicates (R)

		alleles (Switch)
			All alleles present at each locus (default: no, one absent at each locus) (A)

		enzymes_nb (Switch)
			Number of enzymes: not present in input file (E)

		confirm (String)

		terminal_type (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/seqboot.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::seqboot;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $seqboot = Bio::Tools::Run::PiseApplication::seqboot->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::seqboot object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $seqboot = $factory->program('seqboot');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::seqboot.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqboot.pm

    $self->{COMMAND}   = "seqboot";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "seqboot - Bootstrap, Jackknife, or Permutation Resampling";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"seqboot",
	"infile",
	"data_type",
	"method",
	"seed",
	"replicates",
	"freq_opt",
	"rest_opt",
	"outfile",
	"params",
	"confirm",
	"terminal_type",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"seqboot",
	"infile", 	# Alignement File
	"data_type", 	# Data type (D)
	"method", 	# Resampling methods (J)
	"seed", 	# Random number seed (must be odd)
	"replicates", 	# How many replicates (R)
	"freq_opt", 	# Genes Frequencies options
	"alleles", 	# All alleles present at each locus (default: no, one absent at each locus) (A)
	"rest_opt", 	# Restriction enzymes options
	"enzymes_nb", 	# Number of enzymes: not present in input file (E)
	"outfile",
	"params",
	"confirm",
	"terminal_type",

    ];

    $self->{TYPE}  = {
	"seqboot" => 'String',
	"infile" => 'InFile',
	"data_type" => 'Excl',
	"method" => 'Excl',
	"seed" => 'Integer',
	"replicates" => 'Integer',
	"freq_opt" => 'Paragraph',
	"alleles" => 'Switch',
	"rest_opt" => 'Paragraph',
	"enzymes_nb" => 'Switch',
	"outfile" => 'Results',
	"params" => 'Results',
	"confirm" => 'String',
	"terminal_type" => 'String',

    };

    $self->{FORMAT}  = {
	"seqboot" => {
		"perl" => ' "seqboot < params" ',
	},
	"infile" => {
		"perl" => '"ln -s $infile infile; "',
	},
	"data_type" => {
	},
	"method" => {
		"perl" => '$format',
	},
	"seed" => {
		"perl" => '"$value\\n"',
	},
	"replicates" => {
		"perl" => '($value && $value != $vdef)? "R\\n$value\\n" : ""',
	},
	"freq_opt" => {
	},
	"alleles" => {
		"perl" => '($value)? "A\\n" : ""',
	},
	"rest_opt" => {
	},
	"enzymes_nb" => {
		"perl" => '(! $value)? "E\\n" : ""',
	},
	"outfile" => {
	},
	"params" => {
	},
	"confirm" => {
		"perl" => '"y\\n"',
	},
	"terminal_type" => {
		"perl" => '"0\\n"',
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'outfile',
	"params" => 'params',

    };

    $self->{SEQFMT}  = {
	"infile" => [12],

    };

    $self->{GROUP}  = {
	"seqboot" => 0,
	"infile" => -5,
	"data_type" => 1,
	"method" => 1,
	"seed" => 1010,
	"replicates" => 1,
	"alleles" => 1,
	"enzymes_nb" => 1,
	"confirm" => 1000,
	"terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"terminal_type",
	"rest_opt",
	"freq_opt",
	"outfile",
	"params",
	"seqboot",
	"alleles",
	"enzymes_nb",
	"data_type",
	"method",
	"replicates",
	"confirm",
	"seed",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"seqboot" => 1,
	"infile" => 0,
	"data_type" => 0,
	"method" => 0,
	"seed" => 0,
	"replicates" => 0,
	"freq_opt" => 0,
	"alleles" => 0,
	"rest_opt" => 0,
	"enzymes_nb" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 1,
	"terminal_type" => 1,

    };

    $self->{ISCOMMAND}  = {
	"seqboot" => 1,
	"infile" => 0,
	"data_type" => 0,
	"method" => 0,
	"seed" => 0,
	"replicates" => 0,
	"freq_opt" => 0,
	"alleles" => 0,
	"rest_opt" => 0,
	"enzymes_nb" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,

    };

    $self->{ISMANDATORY}  = {
	"seqboot" => 0,
	"infile" => 1,
	"data_type" => 1,
	"method" => 1,
	"seed" => 1,
	"replicates" => 0,
	"freq_opt" => 0,
	"alleles" => 0,
	"rest_opt" => 0,
	"enzymes_nb" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,

    };

    $self->{PROMPT}  = {
	"seqboot" => "",
	"infile" => "Alignement File",
	"data_type" => "Data type (D)",
	"method" => "Resampling methods (J)",
	"seed" => "Random number seed (must be odd)",
	"replicates" => "How many replicates (R)",
	"freq_opt" => "Genes Frequencies options",
	"alleles" => "All alleles present at each locus (default: no, one absent at each locus) (A)",
	"rest_opt" => "Restriction enzymes options",
	"enzymes_nb" => "Number of enzymes: not present in input file (E)",
	"outfile" => "",
	"params" => "",
	"confirm" => "",
	"terminal_type" => "",

    };

    $self->{ISSTANDOUT}  = {
	"seqboot" => 0,
	"infile" => 0,
	"data_type" => 0,
	"method" => 0,
	"seed" => 0,
	"replicates" => 0,
	"freq_opt" => 0,
	"alleles" => 0,
	"rest_opt" => 0,
	"enzymes_nb" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,

    };

    $self->{VLIST}  = {

	"data_type" => ['sequence','Molecular sequences','morph','Discrete Morphology','rest','Restriction Sites','freq','Gene Frequencies',],
	"method" => ['bootstrap','Bootstrap','jackknife','Delete-half jackknife','permute','Permute species for each character',],
	"freq_opt" => ['alleles',],
	"rest_opt" => ['enzymes_nb',],
    };

    $self->{FLIST}  = {

	"data_type" => {
		'morph' => '"D\\n"',
		'sequence' => '""',
		'freq' => '"D\\nD\\nD\\n"',
		'rest' => '"D\\nD\\n"',

	},
	"method" => {
		'bootstrap' => '""',
		'permute' => '"J\\nJ\\n"',
		'jackknife' => '"J\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"data_type" => 'sequence',
	"method" => 'bootstrap',
	"replicates" => '100',
	"alleles" => '0',
	"enzymes_nb" => '1',

    };

    $self->{PRECOND}  = {
	"seqboot" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"data_type" => { "perl" => '1' },
	"method" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"replicates" => { "perl" => '1' },
	"freq_opt" => {
		"perl" => '$data_type eq "freq"',
	},
	"alleles" => {
		"perl" => '$data_type eq "freq"',
	},
	"rest_opt" => {
		"perl" => '$data_type eq "rest"',
	},
	"enzymes_nb" => {
		"perl" => '$data_type eq "rest"',
	},
	"outfile" => { "perl" => '1' },
	"params" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },
	"terminal_type" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"replicates" => {
		"perl" => {
			'$replicates > 1000' => "this server allows no more than 1000 replicates",
		},
	},

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
	"seqboot" => 0,
	"infile" => 0,
	"data_type" => 0,
	"method" => 0,
	"seed" => 0,
	"replicates" => 0,
	"freq_opt" => 0,
	"alleles" => 0,
	"rest_opt" => 0,
	"enzymes_nb" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,

    };

    $self->{ISSIMPLE}  = {
	"seqboot" => 0,
	"infile" => 1,
	"data_type" => 1,
	"method" => 1,
	"seed" => 1,
	"replicates" => 0,
	"freq_opt" => 0,
	"alleles" => 0,
	"rest_opt" => 0,
	"enzymes_nb" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,

    };

    $self->{PARAMFILE}  = {
	"data_type" => "params",
	"method" => "params",
	"seed" => "params",
	"replicates" => "params",
	"alleles" => "params",
	"enzymes_nb" => "params",
	"confirm" => "params",
	"terminal_type" => "params",

    };

    $self->{COMMENT}  = {
	"method" => [
		"1. The bootstrap. Bootstrapping was invented by Bradley Efron in 1979, and its use in phylogeny estimation was introduced by me (Felsenstein, 1985b). It involves creating a new data set by sampling N characters randomly with replacement, so that the resulting data set has the same size as the original, but some characters have been left out and others are duplicated. The random variation of the results from analyzing these bootstrapped data sets can be shown statistically to be typical of the variation that you would get from collecting new data sets. The method assumes that the characters evolve independently, an assumption that may not be realistic for many kinds of data.",
		"2. Delete-half-jackknifing. This alternative to the bootstrap involves sampling a random half of the characters, and including them in the data but dropping the others. The resulting data sets are half the size of the original, and no characters are duplicated. The random variation from doing this should be very similar to that obtained from the bootstrap. The method is advocated by Wu (1986).",
		"3. Permuting species within characters. This method of resampling (well, OK, it may not be best to call it resampling) was introduced by Archie (1989) and Faith (1990; see also Faith and Cranston, 1991). It involves permuting the columns of the data matrix separately. This produces data matrices that have the same number and kinds of characters but no taxonomic structure. It is used for different purposes than the bootstrap, as it tests not the variation around an estimated tree but the hypothesis that there is no taxonomic structure in the data: if a statistic such as number of steps is significantly smaller in the actual data than it is in replicates that are permuted, then we can argue that there is some taxonomic structure in the data (though perhaps it might be just a pair of sibling species).",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/seqboot.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

