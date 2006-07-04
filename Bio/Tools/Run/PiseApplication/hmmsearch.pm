# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::hmmsearch
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::hmmsearch

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmsearch

      Bioperl class for:

	HMMER	hmmsearch - search a sequence database with a profile HMM (S. Eddy)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/hmmsearch.html 
         for available values):


		toto (String)

		hmmsearch (String)

		hmmfile (InFile)
			HMM file
			pipe: hmmer_HMM

		seq_DB (Excl)
			choose one protein sequence database

		alignments_number (Integer)
			number of reported alignments (-A n)

		E_value_cutoff (Float)
			E_value cutoff (-E x)

		Bit_cutoff (Float)
			Bit score cutoff (-T x)

		E_value_calculation (Integer)
			Control of E_value calculation (-Z n)

		domE (Float)
			E-value cutoff for the per-domain ranked hit list (--domE x)

		domT (Float)
			bit score cutoff for the per-domain ranked hit list  (--domT x)

		forward (Switch)
			forward algorithm (--forward)

		null2 (Switch)
			turns off the second post processing step (--null2)

		xnu (Switch)
			turns on XNU filtering (--xnu)

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

http://bioweb.pasteur.fr/seqanal/interfaces/hmmsearch.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::hmmsearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmsearch = Bio::Tools::Run::PiseApplication::hmmsearch->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmsearch object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $hmmsearch = $factory->program('hmmsearch');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmsearch.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmsearch.pm

    $self->{COMMAND}   = "hmmsearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmsearch - search a sequence database with a profile HMM";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"description",
	"hmmsearch",
	"hmmfile",
	"seq_DB",
	"alignments_number",
	"E_value_cutoff",
	"Bit_cutoff",
	"E_value_calculation",
	"expert_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"description", 	# Description of hmmsearch
	"toto",
	"hmmsearch",
	"hmmfile", 	# HMM file
	"seq_DB", 	# choose one protein sequence database
	"alignments_number", 	# number of reported alignments (-A n)
	"E_value_cutoff", 	# E_value cutoff (-E x)
	"Bit_cutoff", 	# Bit score cutoff (-T x)
	"E_value_calculation", 	# Control of E_value calculation (-Z n)
	"expert_options", 	# Expert options
	"domE", 	# E-value cutoff for the per-domain ranked hit list (--domE x)
	"domT", 	# bit score cutoff for the per-domain ranked hit list  (--domT x)
	"forward", 	# forward algorithm (--forward)
	"null2", 	# turns off the second post processing step (--null2)
	"xnu", 	# turns on XNU filtering (--xnu)

    ];

    $self->{TYPE}  = {
	"description" => 'Paragraph',
	"toto" => 'String',
	"hmmsearch" => 'String',
	"hmmfile" => 'InFile',
	"seq_DB" => 'Excl',
	"alignments_number" => 'Integer',
	"E_value_cutoff" => 'Float',
	"Bit_cutoff" => 'Float',
	"E_value_calculation" => 'Integer',
	"expert_options" => 'Paragraph',
	"domE" => 'Float',
	"domT" => 'Float',
	"forward" => 'Switch',
	"null2" => 'Switch',
	"xnu" => 'Switch',

    };

    $self->{FORMAT}  = {
	"description" => {
	},
	"toto" => {
		"perl" => '""',
	},
	"hmmsearch" => {
		"perl" => '"hmmsearch"',
	},
	"hmmfile" => {
		"perl" => '" $value"',
	},
	"seq_DB" => {
		"perl" => '" $value"',
	},
	"alignments_number" => {
		"perl" => '($value) ? " -A $value" : ""',
	},
	"E_value_cutoff" => {
		"perl" => '(defined $value && $value != $vdef) ? " -E $value" : ""',
	},
	"Bit_cutoff" => {
		"perl" => '($value)? " -T $value" : ""',
	},
	"E_value_calculation" => {
		"perl" => '($value) ? " -Z $value" : ""',
	},
	"expert_options" => {
	},
	"domE" => {
		"perl" => '($value) ? " --domE $value" : ""',
	},
	"domT" => {
		"perl" => '($value) ? " --domT $value" : ""',
	},
	"forward" => {
		"perl" => '($value) ? " --forward" : ""',
	},
	"null2" => {
		"perl" => '($value) ? " --null2" : ""',
	},
	"xnu" => {
		"perl" => '($value)? " --xnu" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"toto" => 1000,
	"hmmsearch" => 0,
	"hmmfile" => 2,
	"seq_DB" => 3,
	"alignments_number" => 1,
	"E_value_cutoff" => 1,
	"Bit_cutoff" => 1,
	"E_value_calculation" => 1,
	"domE" => 1,
	"domT" => 1,
	"forward" => 1,
	"null2" => 1,
	"xnu" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"description",
	"expert_options",
	"hmmsearch",
	"null2",
	"xnu",
	"alignments_number",
	"E_value_cutoff",
	"Bit_cutoff",
	"E_value_calculation",
	"domE",
	"domT",
	"forward",
	"hmmfile",
	"seq_DB",
	"toto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"description" => 0,
	"toto" => 1,
	"hmmsearch" => 1,
	"hmmfile" => 0,
	"seq_DB" => 0,
	"alignments_number" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{ISCOMMAND}  = {
	"description" => 0,
	"toto" => 0,
	"hmmsearch" => 1,
	"hmmfile" => 0,
	"seq_DB" => 0,
	"alignments_number" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{ISMANDATORY}  = {
	"description" => 0,
	"toto" => 0,
	"hmmsearch" => 0,
	"hmmfile" => 1,
	"seq_DB" => 1,
	"alignments_number" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{PROMPT}  = {
	"description" => "Description of hmmsearch",
	"toto" => "",
	"hmmsearch" => "",
	"hmmfile" => "HMM file",
	"seq_DB" => "choose one protein sequence database",
	"alignments_number" => "number of reported alignments (-A n)",
	"E_value_cutoff" => "E_value cutoff (-E x)",
	"Bit_cutoff" => "Bit score cutoff (-T x)",
	"E_value_calculation" => "Control of E_value calculation (-Z n)",
	"expert_options" => "Expert options",
	"domE" => "E-value cutoff for the per-domain ranked hit list (--domE x)",
	"domT" => "bit score cutoff for the per-domain ranked hit list  (--domT x)",
	"forward" => "forward algorithm (--forward)",
	"null2" => "turns off the second post processing step (--null2)",
	"xnu" => "turns on XNU filtering (--xnu)",

    };

    $self->{ISSTANDOUT}  = {
	"description" => 0,
	"toto" => 0,
	"hmmsearch" => 0,
	"hmmfile" => 0,
	"seq_DB" => 0,
	"alignments_number" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{VLIST}  = {

	"description" => ['toto',],
	"seq_DB" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','sbase','sbase: annotated domains sequences',],
	"expert_options" => ['domE','domT','forward','null2','xnu',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"seq_DB" => 'sptrnrdb',
	"E_value_cutoff" => '10',

    };

    $self->{PRECOND}  = {
	"description" => { "perl" => '1' },
	"toto" => { "perl" => '1' },
	"hmmsearch" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"seq_DB" => { "perl" => '1' },
	"alignments_number" => { "perl" => '1' },
	"E_value_cutoff" => { "perl" => '1' },
	"Bit_cutoff" => { "perl" => '1' },
	"E_value_calculation" => { "perl" => '1' },
	"expert_options" => { "perl" => '1' },
	"domE" => { "perl" => '1' },
	"domT" => { "perl" => '1' },
	"forward" => { "perl" => '1' },
	"null2" => { "perl" => '1' },
	"xnu" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

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
	"hmmsearch" => 0,
	"hmmfile" => 0,
	"seq_DB" => 0,
	"alignments_number" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{ISSIMPLE}  = {
	"description" => 0,
	"toto" => 0,
	"hmmsearch" => 0,
	"hmmfile" => 0,
	"seq_DB" => 0,
	"alignments_number" => 0,
	"E_value_cutoff" => 0,
	"Bit_cutoff" => 0,
	"E_value_calculation" => 0,
	"expert_options" => 0,
	"domE" => 0,
	"domT" => 0,
	"forward" => 0,
	"null2" => 0,
	"xnu" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"description" => [
		"hmmsearch reads an HMM from hmmfile and searches seqfile for significantly similar sequence matches.",
		"hmmsearch may take minutes or even hours to run, depending on the size of the sequence database.",
		"The output consists of four sections: a ranked list of the best scoring sequences, a ranked list of the best scoring domains, alignments for all the best scoring domains, and a histogram of the scores. sequence score may be higher than a domain score for the same sequence if there is more than domain in the sequence; the sequence score takes into account all the domains. All sequences scoring above the -E and -T cutoffs are shown in the first list, then every domain found in this list is shown in the second list of domain hits. If desired, E-value and bit score thresholds may also be applied to the domain list using the --domE and --domT options.",
	],
	"seq_DB" => [
		"Please note that Swissprot usage by and for commercial entities requires a license agreement.",
	],
	"alignments_number" => [
		"Limits the alignment output to the n best scoring domains. -A0 shuts off the alignment output and can be used to reduce the size of output files.",
	],
	"E_value_cutoff" => [
		"Set the E-value cutoff for the per-sequence ranked hit list to x, where x is a positive real number. The default is 10.0. Hits with E-values better than (less than) this threshold will be shown.",
	],
	"Bit_cutoff" => [
		"Set the bit score cutoff for the per-sequence ranked hit list to x, where x is a real number. The default is negative infinity; by default, the threshold is controlled by E-value and not by bit score. Hits with bit scores better than (greater than) this threshold will be shown.",
	],
	"E_value_calculation" => [
		"Calculate the E-value scores as if we had seen a sequence database of n sequences. The default is the number of sequences seen in your database file seqfile.",
	],
	"domE" => [
		"Set the E-value cutoff for the per-domain ranked hit list to x, where x is a positive real number. The default is infinity; by default, all domains in the sequences that passed the first threshold will be reported in the second list, so that the number of domains reported in the per-sequence list is consistent with the number that appear in the per-domain list.",
	],
	"domT" => [
		"Set the bit score cutoff for the per-domain ranked hit list to x, where x is a real number. The default is negative infinity; by default, all domains in the sequences that passed the first threshold will be reported in the second list, so that the number of domains reported in the per-sequence list is consistent with the number that appear in the per-domain list. Important note: only one domain in a sequence is absolutely controlled by this parameter, or by --domT. The second and subsequent domains in a sequence have a de facto bit score threshold of 0 because of the details of how HMMER works. HMMER requires at least one pass through the main model per sequence; to do more than one pass (more than one domain) the multidomain alignment must have a better score than the single domain alignment, and hence the extra domains must contribute positive score. See the Users\' Guide for more detail. ",
	],
	"forward" => [
		"Use the Forward algorithm instead of the Viterbi algorithm to determine the per-sequence scores. Per-domain scores are still determined by the Viterbi algorithm. Some have argued that Forward is a more sensitive algorithm for detecting remote sequence homologues; my experiments with HMMER have not confirmed this, however.",
	],
	"null2" => [
		"Turn off the post hoc second null model. By default, each alignment is rescored by a postprocessing step that takes into account possible biased composition in either the HMM or the target sequence. This is almost essential in database searches, especially with local alignment models. There is a very small chance that this postprocessing might remove real matches, and in these cases --null2 may improve sensitivity at the expense of reducing specificity by letting biased composition hits through.",
	],
	"xnu" => [
		"Turn on XNU filtering of target protein sequences. Has no effect on nucleic acid sequences. In trial experiments, --xnu appears to perform less well than the default post hoc null2 model.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmsearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

