# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmemit
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmemit

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmemit

      Bioperl class for:

	HMMER	hmmemit - generate sequences from a profile HMM (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmemit.html 
         for available values):


		toto (String)

		hmmemit (String)

		hmmfile (InFile)
			HMM file
			pipe: hmmer_HMM

		output_format (Switch)
			Selex output_format (-a)

		consensus (Switch)
			consensus sequence (-c)

		number (Integer)
			number of generated sequences (-n n)

		seed (Integer)
			seed number (--seed n)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmemit.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmemit;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmemit = Bio::Tools::Run::PiseApplication::hmmemit->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmemit object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmemit = $factory->program('hmmemit');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmemit.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmemit.pm

    $self->{COMMAND}   = "hmmemit";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmemit - generate sequences from a profile HMM";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"description",
	"hmmemit",
	"hmmfile",
	"fasta_output",
	"selex_output",
	"output_format",
	"consensus",
	"number",
	"seed",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"description", 	# Description of hmmemit
	"toto",
	"hmmemit",
	"hmmfile", 	# HMM file
	"fasta_output",
	"selex_output",
	"output_format", 	# Selex output_format (-a)
	"consensus", 	# consensus sequence (-c)
	"number", 	# number of generated sequences (-n n)
	"seed", 	# seed number (--seed n)

    ];

    $self->{TYPE}  = {
	"description" => 'Paragraph',
	"toto" => 'String',
	"hmmemit" => 'String',
	"hmmfile" => 'InFile',
	"fasta_output" => 'Results',
	"selex_output" => 'Results',
	"output_format" => 'Switch',
	"consensus" => 'Switch',
	"number" => 'Integer',
	"seed" => 'Integer',

    };

    $self->{FORMAT}  = {
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"hmmemit" => {
		"perl" => '"hmmemit"',
	},
	"hmmfile" => {
		"perl" => '" $hmmfile"',
	},
	"fasta_output" => {
		"perl" => '" -o $hmmfile.seqs"',
	},
	"selex_output" => {
		"perl" => '" -o $hmmfile.seqs"',
	},
	"output_format" => {
		"perl" => '($value) ? " -a " : ""',
	},
	"consensus" => {
		"perl" => '($value) ? " -c" : ""',
	},
	"number" => {
		"perl" => '(defined $value && $value != $vdef) ? " -n $value " : ""',
	},
	"seed" => {
		"perl" => '(defined $value && $value != $vdef) ? " --seed $value " : ""',
	},

    };

    $self->{FILENAMES}  = {
	"fasta_output" => '"$hmmfile.seqs"',
	"selex_output" => '"$hmmfile.seqs"',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"toto" => 1000,
	"hmmemit" => 0,
	"hmmfile" => 2,
	"fasta_output" => 1,
	"selex_output" => 1,
	"output_format" => 1,
	"consensus" => 1,
	"number" => 1,
	"seed" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"description",
	"hmmemit",
	"seed",
	"selex_output",
	"fasta_output",
	"output_format",
	"consensus",
	"number",
	"hmmfile",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"description" => 0,
	"toto" => 1,
	"hmmemit" => 1,
	"hmmfile" => 0,
	"fasta_output" => 1,
	"selex_output" => 1,
	"output_format" => 0,
	"consensus" => 0,
	"number" => 0,
	"seed" => 0,

    };

    $self->{ISCOMMAND}  = {
	"description" => 0,
	"toto" => 0,
	"hmmemit" => 1,
	"hmmfile" => 0,
	"fasta_output" => 0,
	"selex_output" => 0,
	"output_format" => 0,
	"consensus" => 0,
	"number" => 0,
	"seed" => 0,

    };

    $self->{ISMANDATORY}  = {
	"description" => 0,
	"toto" => 0,
	"hmmemit" => 0,
	"hmmfile" => 0,
	"fasta_output" => 0,
	"selex_output" => 0,
	"output_format" => 0,
	"consensus" => 0,
	"number" => 0,
	"seed" => 0,

    };

    $self->{PROMPT}  = {
	"description" => "Description of hmmemit",
	"toto" => "",
	"hmmemit" => "",
	"hmmfile" => "HMM file",
	"fasta_output" => "",
	"selex_output" => "",
	"output_format" => "Selex output_format (-a)",
	"consensus" => "consensus sequence (-c)",
	"number" => "number of generated sequences (-n n)",
	"seed" => "seed number (--seed n)",

    };

    $self->{ISSTANDOUT}  = {
	"description" => 0,
	"toto" => 0,
	"hmmemit" => 0,
	"hmmfile" => 0,
	"fasta_output" => 0,
	"selex_output" => 0,
	"output_format" => 0,
	"consensus" => 0,
	"number" => 0,
	"seed" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"number" => '10',

    };

    $self->{PRECOND}  = {
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"hmmemit" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"fasta_output" => {
		"perl" => '! $output_format',
	},
	"selex_output" => {
		"perl" => '$output_format',
	},
	"output_format" => { "perl" => '1' },
	"consensus" => { "perl" => '1' },
	"number" => { "perl" => '1' },
	"seed" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"fasta_output" => {
		 '1' => "seqsfile",
	},
	"selex_output" => {
		 '1' => "hmmer_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"hmmfile" => {
		 "hmmer_HMM" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"description" => 0,
	"toto" => 0,
	"hmmemit" => 0,
	"hmmfile" => 0,
	"fasta_output" => 0,
	"selex_output" => 0,
	"output_format" => 0,
	"consensus" => 0,
	"number" => 0,
	"seed" => 0,

    };

    $self->{ISSIMPLE}  = {
	"description" => 0,
	"toto" => 0,
	"hmmemit" => 0,
	"hmmfile" => 0,
	"fasta_output" => 0,
	"selex_output" => 0,
	"output_format" => 0,
	"consensus" => 0,
	"number" => 0,
	"seed" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmemit reads an HMM file from hmmfile and generates a number of sequences from it; or, if the -c option is selected, generate a single majority-rule consensus. This can be useful for various applications in which one needs a simulation of sequences consistent with a sequence family consensus.By default, hmmemit generates 10 sequences and outputs them in FASTA (unaligned) format.",
	],
	"output_format" => [
		"Write the generated sequences in an aligned format (SELEX) rather than FASTA.",
	],
	"consensus" => [
		"Predict a single majority-rule consensus sequence instead of sampling sequences from the HMM\'s probability distribution. Highly conserved residues (p >= 0.9 for DNA, p >= 0.5 for protein) are shown in upper case; others are shown in lower case. Some insert states may become part of the majority rule consensus, because they are used in >= 50% of generated sequences; when this happens, insert-generated residues are simply shown as x.",
	],
	"seed" => [
		"Set the random seed to n, where n is a positive integer. The default is to use time() to generate a different seed for each run, which means that two different runs of hmmemit on the same HMM will give slightly different results. You can use this option to generate reproducible results.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmemit.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

