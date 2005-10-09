# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::eprimer3
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::eprimer3

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::eprimer3

      Bioperl class for:

	EPRIMER3	Picks PCR primers and hybridization oligos (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/eprimer3.html 
         for available values):


		eprimer3 (String)

		init (String)

		sequence (Sequence)
			sequence -- dna [sequences] (-sequence)
			pipe: seqsfile

		explainflag (Switch)
			Explain flag (-explainflag)

		fileflag (Switch)
			Create results files for each sequence (-fileflag)

		task (Excl)
			Select task -- Task (-task)

		numreturn (Integer)
			Number of results to return (-numreturn)

		firstbaseindex (Integer)
			First base index (-firstbaseindex)

		includedregion (Integer)
			Included region(s) (-includedregion)

		target (Integer)
			Target region(s) (-target)

		excludedregion (Integer)
			Excluded region(s) (-excludedregion)

		forwardinput (String)
			Forward input primer sequence to check (-forwardinput)

		reverseinput (String)
			Reverse input primer sequence to check (-reverseinput)

		pickanyway (Switch)
			Pick anyway (-pickanyway)

		mispriminglibrary (InFile)
			Mispriming library (-mispriminglibrary)

		maxmispriming (Float)
			Primer maximum mispriming (-maxmispriming)

		pairmaxmispriming (Float)
			Primer pair maximum mispriming (-pairmaxmispriming)

		gcclamp (Integer)
			GC clamp (-gcclamp)

		osize (Integer)
			Primer optimum size (-osize)

		minsize (Integer)
			Primer minimum size (-minsize)

		maxsize (Integer)
			Primer maximum size (-maxsize)

		otm (Float)
			Primer optimum Tm (-otm)

		mintm (Float)
			Primer minimum Tm (-mintm)

		maxtm (Float)
			Primer maximum Tm (-maxtm)

		maxdifftm (Float)
			Maximum difference in Tm of primers (-maxdifftm)

		ogcpercent (Float)
			Primer optimum GC percent (-ogcpercent)

		mingc (Float)
			Primer minimum GC percent (-mingc)

		maxgc (Float)
			Primer maximum GC percent (-maxgc)

		saltconc (Float)
			Salt concentration (mM) (-saltconc)

		dnaconc (Float)
			DNA concentration (nM) (-dnaconc)

		numnsaccepted (Integer)
			Maximum Ns accepted in a primer (-numnsaccepted)

		selfany (Float)
			Maximum self complementarity (-selfany)

		selfend (Float)
			Maximum 3' self complementarity (-selfend)

		maxpolyx (Integer)
			Maximum polynucleotide repeat (-maxpolyx)

		productosize (Integer)
			Product optimum size (-productosize)

		productsizerange (Integer)
			Product size range (-productsizerange)

		productotm (Float)
			Product optimum Tm (-productotm)

		productmintm (Float)
			Product minimum Tm (-productmintm)

		productmaxtm (Float)
			Product maximum Tm (-productmaxtm)

		maxendstability (Float)
			Maximum 3' end stability (-maxendstability)

		oligoexcludedregion (Integer)
			Internal oligo excluded region (-oligoexcludedregion)

		oligoinput (String)
			Internal oligo input sequence (if any) (-oligoinput)

		oligoosize (Integer)
			Internal oligo optimum size (-oligoosize)

		oligominsize (Integer)
			Internal oligo minimum size (-oligominsize)

		oligomaxsize (Integer)
			Internal oligo maximum size (-oligomaxsize)

		oligootm (Float)
			Internal oligo optimum Tm (-oligootm)

		oligomintm (Float)
			Internal oligo minimum Tm (-oligomintm)

		oligomaxtm (Float)
			Internal oligo maximum Tm (-oligomaxtm)

		oligoogcpercent (Float)
			Internal oligo optimum GC percent (-oligoogcpercent)

		oligomingc (Float)
			Internal oligo minimum GC (-oligomingc)

		oligomaxgc (Float)
			Internal oligo maximum GC (-oligomaxgc)

		oligosaltconc (Float)
			Internal oligo salt concentration (mM) (-oligosaltconc)

		oligodnaconc (Float)
			Internal oligo DNA concentration (nM) (-oligodnaconc)

		oligoselfany (Float)
			Internal oligo maximum self complementarity (-oligoselfany)

		oligoselfend (Float)
			Internal oligo maximum 3' self complementarity (-oligoselfend)

		oligomaxpolyx (Integer)
			Internal oligo maximum polynucleotide repeat (-oligomaxpolyx)

		oligomishyblibrary (InFile)
			Internal oligo mishybridizing library (-oligomishyblibrary)

		oligomaxmishyb (Float)
			Internal oligo maximum mishybridization (-oligomaxmishyb)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/eprimer3.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::eprimer3;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $eprimer3 = Bio::Tools::Run::PiseApplication::eprimer3->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::eprimer3 object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $eprimer3 = $factory->program('eprimer3');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::eprimer3.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/eprimer3.pm

    $self->{COMMAND}   = "eprimer3";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EPRIMER3";

    $self->{DESCRIPTION}   = "Picks PCR primers and hybridization oligos (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "nucleic:primers",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/eprimer3.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"eprimer3",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"eprimer3",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"advanced", 	# advanced Section
	"program", 	# Program Options
	"explainflag", 	# Explain flag (-explainflag)
	"fileflag", 	# Create results files for each sequence (-fileflag)
	"task", 	# Select task -- Task (-task)
	"numreturn", 	# Number of results to return (-numreturn)
	"firstbaseindex", 	# First base index (-firstbaseindex)
	"sequenceopt", 	# Sequence options
	"includedregion", 	# Included region(s) (-includedregion)
	"target", 	# Target region(s) (-target)
	"excludedregion", 	# Excluded region(s) (-excludedregion)
	"forwardinput", 	# Forward input primer sequence to check (-forwardinput)
	"reverseinput", 	# Reverse input primer sequence to check (-reverseinput)
	"primer", 	# Primer Details
	"pickanyway", 	# Pick anyway (-pickanyway)
	"mispriminglibrary", 	# Mispriming library (-mispriminglibrary)
	"maxmispriming", 	# Primer maximum mispriming (-maxmispriming)
	"pairmaxmispriming", 	# Primer pair maximum mispriming (-pairmaxmispriming)
	"gcclamp", 	# GC clamp (-gcclamp)
	"osize", 	# Primer optimum size (-osize)
	"minsize", 	# Primer minimum size (-minsize)
	"maxsize", 	# Primer maximum size (-maxsize)
	"otm", 	# Primer optimum Tm (-otm)
	"mintm", 	# Primer minimum Tm (-mintm)
	"maxtm", 	# Primer maximum Tm (-maxtm)
	"maxdifftm", 	# Maximum difference in Tm of primers (-maxdifftm)
	"ogcpercent", 	# Primer optimum GC percent (-ogcpercent)
	"mingc", 	# Primer minimum GC percent (-mingc)
	"maxgc", 	# Primer maximum GC percent (-maxgc)
	"saltconc", 	# Salt concentration (mM) (-saltconc)
	"dnaconc", 	# DNA concentration (nM) (-dnaconc)
	"numnsaccepted", 	# Maximum Ns accepted in a primer (-numnsaccepted)
	"selfany", 	# Maximum self complementarity (-selfany)
	"selfend", 	# Maximum 3' self complementarity (-selfend)
	"maxpolyx", 	# Maximum polynucleotide repeat (-maxpolyx)
	"product", 	# Product details
	"productosize", 	# Product optimum size (-productosize)
	"productsizerange", 	# Product size range (-productsizerange)
	"productotm", 	# Product optimum Tm (-productotm)
	"productmintm", 	# Product minimum Tm (-productmintm)
	"productmaxtm", 	# Product maximum Tm (-productmaxtm)
	"primerweights", 	# Primer Penalty Weights
	"maxendstability", 	# Maximum 3' end stability (-maxendstability)
	"oligosinput", 	# Internal Oligo Input
	"oligoexcludedregion", 	# Internal oligo excluded region (-oligoexcludedregion)
	"oligoinput", 	# Internal oligo input sequence (if any) (-oligoinput)
	"oligos", 	# Internal Oligo Details
	"oligoosize", 	# Internal oligo optimum size (-oligoosize)
	"oligominsize", 	# Internal oligo minimum size (-oligominsize)
	"oligomaxsize", 	# Internal oligo maximum size (-oligomaxsize)
	"oligootm", 	# Internal oligo optimum Tm (-oligootm)
	"oligomintm", 	# Internal oligo minimum Tm (-oligomintm)
	"oligomaxtm", 	# Internal oligo maximum Tm (-oligomaxtm)
	"oligoogcpercent", 	# Internal oligo optimum GC percent (-oligoogcpercent)
	"oligomingc", 	# Internal oligo minimum GC (-oligomingc)
	"oligomaxgc", 	# Internal oligo maximum GC (-oligomaxgc)
	"oligosaltconc", 	# Internal oligo salt concentration (mM) (-oligosaltconc)
	"oligodnaconc", 	# Internal oligo DNA concentration (nM) (-oligodnaconc)
	"oligoselfany", 	# Internal oligo maximum self complementarity (-oligoselfany)
	"oligoselfend", 	# Internal oligo maximum 3' self complementarity (-oligoselfend)
	"oligomaxpolyx", 	# Internal oligo maximum polynucleotide repeat (-oligomaxpolyx)
	"oligomishyblibrary", 	# Internal oligo mishybridizing library (-oligomishyblibrary)
	"oligomaxmishyb", 	# Internal oligo maximum mishybridization (-oligomaxmishyb)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"eprimer3" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"program" => 'Paragraph',
	"explainflag" => 'Switch',
	"fileflag" => 'Switch',
	"task" => 'Excl',
	"numreturn" => 'Integer',
	"firstbaseindex" => 'Integer',
	"sequenceopt" => 'Paragraph',
	"includedregion" => 'Integer',
	"target" => 'Integer',
	"excludedregion" => 'Integer',
	"forwardinput" => 'String',
	"reverseinput" => 'String',
	"primer" => 'Paragraph',
	"pickanyway" => 'Switch',
	"mispriminglibrary" => 'InFile',
	"maxmispriming" => 'Float',
	"pairmaxmispriming" => 'Float',
	"gcclamp" => 'Integer',
	"osize" => 'Integer',
	"minsize" => 'Integer',
	"maxsize" => 'Integer',
	"otm" => 'Float',
	"mintm" => 'Float',
	"maxtm" => 'Float',
	"maxdifftm" => 'Float',
	"ogcpercent" => 'Float',
	"mingc" => 'Float',
	"maxgc" => 'Float',
	"saltconc" => 'Float',
	"dnaconc" => 'Float',
	"numnsaccepted" => 'Integer',
	"selfany" => 'Float',
	"selfend" => 'Float',
	"maxpolyx" => 'Integer',
	"product" => 'Paragraph',
	"productosize" => 'Integer',
	"productsizerange" => 'Integer',
	"productotm" => 'Float',
	"productmintm" => 'Float',
	"productmaxtm" => 'Float',
	"primerweights" => 'Paragraph',
	"maxendstability" => 'Float',
	"oligosinput" => 'Paragraph',
	"oligoexcludedregion" => 'Integer',
	"oligoinput" => 'String',
	"oligos" => 'Paragraph',
	"oligoosize" => 'Integer',
	"oligominsize" => 'Integer',
	"oligomaxsize" => 'Integer',
	"oligootm" => 'Float',
	"oligomintm" => 'Float',
	"oligomaxtm" => 'Float',
	"oligoogcpercent" => 'Float',
	"oligomingc" => 'Float',
	"oligomaxgc" => 'Float',
	"oligosaltconc" => 'Float',
	"oligodnaconc" => 'Float',
	"oligoselfany" => 'Float',
	"oligoselfend" => 'Float',
	"oligomaxpolyx" => 'Integer',
	"oligomishyblibrary" => 'InFile',
	"oligomaxmishyb" => 'Float',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"program" => {
	},
	"explainflag" => {
		"perl" => '($value)? " -explainflag" : ""',
	},
	"fileflag" => {
		"perl" => '($value)? " -fileflag" : ""',
	},
	"task" => {
		"perl" => '" -task=$value"',
	},
	"numreturn" => {
		"perl" => '(defined $value && $value != $vdef)? " -numreturn=$value" : ""',
	},
	"firstbaseindex" => {
		"perl" => '(defined $value && $value != $vdef)? " -firstbaseindex=$value" : ""',
	},
	"sequenceopt" => {
	},
	"includedregion" => {
		"perl" => '($value)? " -includedregion=$value" : ""',
	},
	"target" => {
		"perl" => '($value)? " -target=$value" : ""',
	},
	"excludedregion" => {
		"perl" => '($value)? " -excludedregion=$value" : ""',
	},
	"forwardinput" => {
		"perl" => '($value)? " -forwardinput=$value" : ""',
	},
	"reverseinput" => {
		"perl" => '($value)? " -reverseinput=$value" : ""',
	},
	"primer" => {
	},
	"pickanyway" => {
		"perl" => '($value)? " -pickanyway" : ""',
	},
	"mispriminglibrary" => {
		"perl" => '($value)? " -mispriminglibrary=$value" : ""',
	},
	"maxmispriming" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxmispriming=$value" : ""',
	},
	"pairmaxmispriming" => {
		"perl" => '(defined $value && $value != $vdef)? " -pairmaxmispriming=$value" : ""',
	},
	"gcclamp" => {
		"perl" => '(defined $value && $value != $vdef)? " -gcclamp=$value" : ""',
	},
	"osize" => {
		"perl" => '(defined $value && $value != $vdef)? " -osize=$value" : ""',
	},
	"minsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -minsize=$value" : ""',
	},
	"maxsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxsize=$value" : ""',
	},
	"otm" => {
		"perl" => '(defined $value && $value != $vdef)? " -otm=$value" : ""',
	},
	"mintm" => {
		"perl" => '(defined $value && $value != $vdef)? " -mintm=$value" : ""',
	},
	"maxtm" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxtm=$value" : ""',
	},
	"maxdifftm" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxdifftm=$value" : ""',
	},
	"ogcpercent" => {
		"perl" => '(defined $value && $value != $vdef)? " -ogcpercent=$value" : ""',
	},
	"mingc" => {
		"perl" => '(defined $value && $value != $vdef)? " -mingc=$value" : ""',
	},
	"maxgc" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxgc=$value" : ""',
	},
	"saltconc" => {
		"perl" => '(defined $value && $value != $vdef)? " -saltconc=$value" : ""',
	},
	"dnaconc" => {
		"perl" => '(defined $value && $value != $vdef)? " -dnaconc=$value" : ""',
	},
	"numnsaccepted" => {
		"perl" => '(defined $value && $value != $vdef)? " -numnsaccepted=$value" : ""',
	},
	"selfany" => {
		"perl" => '(defined $value && $value != $vdef)? " -selfany=$value" : ""',
	},
	"selfend" => {
		"perl" => '(defined $value && $value != $vdef)? " -selfend=$value" : ""',
	},
	"maxpolyx" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxpolyx=$value" : ""',
	},
	"product" => {
	},
	"productosize" => {
		"perl" => '(defined $value && $value != $vdef)? " -productosize=$value" : ""',
	},
	"productsizerange" => {
		"perl" => '(defined $value && $value != $vdef)? " -productsizerange=$value" : ""',
	},
	"productotm" => {
		"perl" => '(defined $value && $value != $vdef)? " -productotm=$value" : ""',
	},
	"productmintm" => {
		"perl" => '(defined $value && $value != $vdef)? " -productmintm=$value" : ""',
	},
	"productmaxtm" => {
		"perl" => '(defined $value && $value != $vdef)? " -productmaxtm=$value" : ""',
	},
	"primerweights" => {
	},
	"maxendstability" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxendstability=$value" : ""',
	},
	"oligosinput" => {
	},
	"oligoexcludedregion" => {
		"perl" => '($value)? " -oligoexcludedregion=$value" : ""',
	},
	"oligoinput" => {
		"perl" => '($value)? " -oligoinput=$value" : ""',
	},
	"oligos" => {
	},
	"oligoosize" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligoosize=$value" : ""',
	},
	"oligominsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligominsize=$value" : ""',
	},
	"oligomaxsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomaxsize=$value" : ""',
	},
	"oligootm" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligootm=$value" : ""',
	},
	"oligomintm" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomintm=$value" : ""',
	},
	"oligomaxtm" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomaxtm=$value" : ""',
	},
	"oligoogcpercent" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligoogcpercent=$value" : ""',
	},
	"oligomingc" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomingc=$value" : ""',
	},
	"oligomaxgc" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomaxgc=$value" : ""',
	},
	"oligosaltconc" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligosaltconc=$value" : ""',
	},
	"oligodnaconc" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligodnaconc=$value" : ""',
	},
	"oligoselfany" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligoselfany=$value" : ""',
	},
	"oligoselfend" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligoselfend=$value" : ""',
	},
	"oligomaxpolyx" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomaxpolyx=$value" : ""',
	},
	"oligomishyblibrary" => {
		"perl" => '($value)? " -oligomishyblibrary=$value" : ""',
	},
	"oligomaxmishyb" => {
		"perl" => '(defined $value && $value != $vdef)? " -oligomaxmishyb=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"eprimer3" => {
		"perl" => '"eprimer3"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"explainflag" => 2,
	"fileflag" => 3,
	"task" => 4,
	"numreturn" => 5,
	"firstbaseindex" => 6,
	"includedregion" => 7,
	"target" => 8,
	"excludedregion" => 9,
	"forwardinput" => 10,
	"reverseinput" => 11,
	"pickanyway" => 12,
	"mispriminglibrary" => 13,
	"maxmispriming" => 14,
	"pairmaxmispriming" => 15,
	"gcclamp" => 16,
	"osize" => 17,
	"minsize" => 18,
	"maxsize" => 19,
	"otm" => 20,
	"mintm" => 21,
	"maxtm" => 22,
	"maxdifftm" => 23,
	"ogcpercent" => 24,
	"mingc" => 25,
	"maxgc" => 26,
	"saltconc" => 27,
	"dnaconc" => 28,
	"numnsaccepted" => 29,
	"selfany" => 30,
	"selfend" => 31,
	"maxpolyx" => 32,
	"productosize" => 33,
	"productsizerange" => 34,
	"productotm" => 35,
	"productmintm" => 36,
	"productmaxtm" => 37,
	"maxendstability" => 38,
	"oligoexcludedregion" => 39,
	"oligoinput" => 40,
	"oligoosize" => 41,
	"oligominsize" => 42,
	"oligomaxsize" => 43,
	"oligootm" => 44,
	"oligomintm" => 45,
	"oligomaxtm" => 46,
	"oligoogcpercent" => 47,
	"oligomingc" => 48,
	"oligomaxgc" => 49,
	"oligosaltconc" => 50,
	"oligodnaconc" => 51,
	"oligoselfany" => 52,
	"oligoselfend" => 53,
	"oligomaxpolyx" => 54,
	"oligomishyblibrary" => 55,
	"oligomaxmishyb" => 56,
	"outfile" => 57,
	"auto" => 58,
	"eprimer3" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"eprimer3",
	"advanced",
	"program",
	"primer",
	"sequenceopt",
	"product",
	"primerweights",
	"oligosinput",
	"oligos",
	"output",
	"sequence",
	"explainflag",
	"fileflag",
	"task",
	"numreturn",
	"firstbaseindex",
	"includedregion",
	"target",
	"excludedregion",
	"forwardinput",
	"reverseinput",
	"pickanyway",
	"mispriminglibrary",
	"maxmispriming",
	"pairmaxmispriming",
	"gcclamp",
	"osize",
	"minsize",
	"maxsize",
	"otm",
	"mintm",
	"maxtm",
	"maxdifftm",
	"ogcpercent",
	"mingc",
	"maxgc",
	"saltconc",
	"dnaconc",
	"numnsaccepted",
	"selfany",
	"selfend",
	"maxpolyx",
	"productosize",
	"productsizerange",
	"productotm",
	"productmintm",
	"productmaxtm",
	"maxendstability",
	"oligoexcludedregion",
	"oligoinput",
	"oligoosize",
	"oligominsize",
	"oligomaxsize",
	"oligootm",
	"oligomintm",
	"oligomaxtm",
	"oligoogcpercent",
	"oligomingc",
	"oligomaxgc",
	"oligosaltconc",
	"oligodnaconc",
	"oligoselfany",
	"oligoselfend",
	"oligomaxpolyx",
	"oligomishyblibrary",
	"oligomaxmishyb",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"program" => 0,
	"explainflag" => 0,
	"fileflag" => 0,
	"task" => 0,
	"numreturn" => 0,
	"firstbaseindex" => 0,
	"sequenceopt" => 0,
	"includedregion" => 0,
	"target" => 0,
	"excludedregion" => 0,
	"forwardinput" => 0,
	"reverseinput" => 0,
	"primer" => 0,
	"pickanyway" => 0,
	"mispriminglibrary" => 0,
	"maxmispriming" => 0,
	"pairmaxmispriming" => 0,
	"gcclamp" => 0,
	"osize" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"otm" => 0,
	"mintm" => 0,
	"maxtm" => 0,
	"maxdifftm" => 0,
	"ogcpercent" => 0,
	"mingc" => 0,
	"maxgc" => 0,
	"saltconc" => 0,
	"dnaconc" => 0,
	"numnsaccepted" => 0,
	"selfany" => 0,
	"selfend" => 0,
	"maxpolyx" => 0,
	"product" => 0,
	"productosize" => 0,
	"productsizerange" => 0,
	"productotm" => 0,
	"productmintm" => 0,
	"productmaxtm" => 0,
	"primerweights" => 0,
	"maxendstability" => 0,
	"oligosinput" => 0,
	"oligoexcludedregion" => 0,
	"oligoinput" => 0,
	"oligos" => 0,
	"oligoosize" => 0,
	"oligominsize" => 0,
	"oligomaxsize" => 0,
	"oligootm" => 0,
	"oligomintm" => 0,
	"oligomaxtm" => 0,
	"oligoogcpercent" => 0,
	"oligomingc" => 0,
	"oligomaxgc" => 0,
	"oligosaltconc" => 0,
	"oligodnaconc" => 0,
	"oligoselfany" => 0,
	"oligoselfend" => 0,
	"oligomaxpolyx" => 0,
	"oligomishyblibrary" => 0,
	"oligomaxmishyb" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"eprimer3" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"program" => 0,
	"explainflag" => 0,
	"fileflag" => 0,
	"task" => 0,
	"numreturn" => 0,
	"firstbaseindex" => 0,
	"sequenceopt" => 0,
	"includedregion" => 0,
	"target" => 0,
	"excludedregion" => 0,
	"forwardinput" => 0,
	"reverseinput" => 0,
	"primer" => 0,
	"pickanyway" => 0,
	"mispriminglibrary" => 0,
	"maxmispriming" => 0,
	"pairmaxmispriming" => 0,
	"gcclamp" => 0,
	"osize" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"otm" => 0,
	"mintm" => 0,
	"maxtm" => 0,
	"maxdifftm" => 0,
	"ogcpercent" => 0,
	"mingc" => 0,
	"maxgc" => 0,
	"saltconc" => 0,
	"dnaconc" => 0,
	"numnsaccepted" => 0,
	"selfany" => 0,
	"selfend" => 0,
	"maxpolyx" => 0,
	"product" => 0,
	"productosize" => 0,
	"productsizerange" => 0,
	"productotm" => 0,
	"productmintm" => 0,
	"productmaxtm" => 0,
	"primerweights" => 0,
	"maxendstability" => 0,
	"oligosinput" => 0,
	"oligoexcludedregion" => 0,
	"oligoinput" => 0,
	"oligos" => 0,
	"oligoosize" => 0,
	"oligominsize" => 0,
	"oligomaxsize" => 0,
	"oligootm" => 0,
	"oligomintm" => 0,
	"oligomaxtm" => 0,
	"oligoogcpercent" => 0,
	"oligomingc" => 0,
	"oligomaxgc" => 0,
	"oligosaltconc" => 0,
	"oligodnaconc" => 0,
	"oligoselfany" => 0,
	"oligoselfend" => 0,
	"oligomaxpolyx" => 0,
	"oligomishyblibrary" => 0,
	"oligomaxmishyb" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"program" => 0,
	"explainflag" => 0,
	"fileflag" => 0,
	"task" => 1,
	"numreturn" => 0,
	"firstbaseindex" => 0,
	"sequenceopt" => 0,
	"includedregion" => 0,
	"target" => 0,
	"excludedregion" => 0,
	"forwardinput" => 0,
	"reverseinput" => 0,
	"primer" => 0,
	"pickanyway" => 0,
	"mispriminglibrary" => 0,
	"maxmispriming" => 0,
	"pairmaxmispriming" => 0,
	"gcclamp" => 0,
	"osize" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"otm" => 0,
	"mintm" => 0,
	"maxtm" => 0,
	"maxdifftm" => 0,
	"ogcpercent" => 0,
	"mingc" => 0,
	"maxgc" => 0,
	"saltconc" => 0,
	"dnaconc" => 0,
	"numnsaccepted" => 0,
	"selfany" => 0,
	"selfend" => 0,
	"maxpolyx" => 0,
	"product" => 0,
	"productosize" => 0,
	"productsizerange" => 0,
	"productotm" => 0,
	"productmintm" => 0,
	"productmaxtm" => 0,
	"primerweights" => 0,
	"maxendstability" => 0,
	"oligosinput" => 0,
	"oligoexcludedregion" => 0,
	"oligoinput" => 0,
	"oligos" => 0,
	"oligoosize" => 0,
	"oligominsize" => 0,
	"oligomaxsize" => 0,
	"oligootm" => 0,
	"oligomintm" => 0,
	"oligomaxtm" => 0,
	"oligoogcpercent" => 0,
	"oligomingc" => 0,
	"oligomaxgc" => 0,
	"oligosaltconc" => 0,
	"oligodnaconc" => 0,
	"oligoselfany" => 0,
	"oligoselfend" => 0,
	"oligomaxpolyx" => 0,
	"oligomishyblibrary" => 0,
	"oligomaxmishyb" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"program" => "Program Options",
	"explainflag" => "Explain flag (-explainflag)",
	"fileflag" => "Create results files for each sequence (-fileflag)",
	"task" => "Select task -- Task (-task)",
	"numreturn" => "Number of results to return (-numreturn)",
	"firstbaseindex" => "First base index (-firstbaseindex)",
	"sequenceopt" => "Sequence options",
	"includedregion" => "Included region(s) (-includedregion)",
	"target" => "Target region(s) (-target)",
	"excludedregion" => "Excluded region(s) (-excludedregion)",
	"forwardinput" => "Forward input primer sequence to check (-forwardinput)",
	"reverseinput" => "Reverse input primer sequence to check (-reverseinput)",
	"primer" => "Primer Details",
	"pickanyway" => "Pick anyway (-pickanyway)",
	"mispriminglibrary" => "Mispriming library (-mispriminglibrary)",
	"maxmispriming" => "Primer maximum mispriming (-maxmispriming)",
	"pairmaxmispriming" => "Primer pair maximum mispriming (-pairmaxmispriming)",
	"gcclamp" => "GC clamp (-gcclamp)",
	"osize" => "Primer optimum size (-osize)",
	"minsize" => "Primer minimum size (-minsize)",
	"maxsize" => "Primer maximum size (-maxsize)",
	"otm" => "Primer optimum Tm (-otm)",
	"mintm" => "Primer minimum Tm (-mintm)",
	"maxtm" => "Primer maximum Tm (-maxtm)",
	"maxdifftm" => "Maximum difference in Tm of primers (-maxdifftm)",
	"ogcpercent" => "Primer optimum GC percent (-ogcpercent)",
	"mingc" => "Primer minimum GC percent (-mingc)",
	"maxgc" => "Primer maximum GC percent (-maxgc)",
	"saltconc" => "Salt concentration (mM) (-saltconc)",
	"dnaconc" => "DNA concentration (nM) (-dnaconc)",
	"numnsaccepted" => "Maximum Ns accepted in a primer (-numnsaccepted)",
	"selfany" => "Maximum self complementarity (-selfany)",
	"selfend" => "Maximum 3' self complementarity (-selfend)",
	"maxpolyx" => "Maximum polynucleotide repeat (-maxpolyx)",
	"product" => "Product details",
	"productosize" => "Product optimum size (-productosize)",
	"productsizerange" => "Product size range (-productsizerange)",
	"productotm" => "Product optimum Tm (-productotm)",
	"productmintm" => "Product minimum Tm (-productmintm)",
	"productmaxtm" => "Product maximum Tm (-productmaxtm)",
	"primerweights" => "Primer Penalty Weights",
	"maxendstability" => "Maximum 3' end stability (-maxendstability)",
	"oligosinput" => "Internal Oligo Input",
	"oligoexcludedregion" => "Internal oligo excluded region (-oligoexcludedregion)",
	"oligoinput" => "Internal oligo input sequence (if any) (-oligoinput)",
	"oligos" => "Internal Oligo Details",
	"oligoosize" => "Internal oligo optimum size (-oligoosize)",
	"oligominsize" => "Internal oligo minimum size (-oligominsize)",
	"oligomaxsize" => "Internal oligo maximum size (-oligomaxsize)",
	"oligootm" => "Internal oligo optimum Tm (-oligootm)",
	"oligomintm" => "Internal oligo minimum Tm (-oligomintm)",
	"oligomaxtm" => "Internal oligo maximum Tm (-oligomaxtm)",
	"oligoogcpercent" => "Internal oligo optimum GC percent (-oligoogcpercent)",
	"oligomingc" => "Internal oligo minimum GC (-oligomingc)",
	"oligomaxgc" => "Internal oligo maximum GC (-oligomaxgc)",
	"oligosaltconc" => "Internal oligo salt concentration (mM) (-oligosaltconc)",
	"oligodnaconc" => "Internal oligo DNA concentration (nM) (-oligodnaconc)",
	"oligoselfany" => "Internal oligo maximum self complementarity (-oligoselfany)",
	"oligoselfend" => "Internal oligo maximum 3' self complementarity (-oligoselfend)",
	"oligomaxpolyx" => "Internal oligo maximum polynucleotide repeat (-oligomaxpolyx)",
	"oligomishyblibrary" => "Internal oligo mishybridizing library (-oligomishyblibrary)",
	"oligomaxmishyb" => "Internal oligo maximum mishybridization (-oligomaxmishyb)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"program" => 0,
	"explainflag" => 0,
	"fileflag" => 0,
	"task" => 0,
	"numreturn" => 0,
	"firstbaseindex" => 0,
	"sequenceopt" => 0,
	"includedregion" => 0,
	"target" => 0,
	"excludedregion" => 0,
	"forwardinput" => 0,
	"reverseinput" => 0,
	"primer" => 0,
	"pickanyway" => 0,
	"mispriminglibrary" => 0,
	"maxmispriming" => 0,
	"pairmaxmispriming" => 0,
	"gcclamp" => 0,
	"osize" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"otm" => 0,
	"mintm" => 0,
	"maxtm" => 0,
	"maxdifftm" => 0,
	"ogcpercent" => 0,
	"mingc" => 0,
	"maxgc" => 0,
	"saltconc" => 0,
	"dnaconc" => 0,
	"numnsaccepted" => 0,
	"selfany" => 0,
	"selfend" => 0,
	"maxpolyx" => 0,
	"product" => 0,
	"productosize" => 0,
	"productsizerange" => 0,
	"productotm" => 0,
	"productmintm" => 0,
	"productmaxtm" => 0,
	"primerweights" => 0,
	"maxendstability" => 0,
	"oligosinput" => 0,
	"oligoexcludedregion" => 0,
	"oligoinput" => 0,
	"oligos" => 0,
	"oligoosize" => 0,
	"oligominsize" => 0,
	"oligomaxsize" => 0,
	"oligootm" => 0,
	"oligomintm" => 0,
	"oligomaxtm" => 0,
	"oligoogcpercent" => 0,
	"oligomingc" => 0,
	"oligomaxgc" => 0,
	"oligosaltconc" => 0,
	"oligodnaconc" => 0,
	"oligoselfany" => 0,
	"oligoselfend" => 0,
	"oligomaxpolyx" => 0,
	"oligomishyblibrary" => 0,
	"oligomaxmishyb" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['program','sequenceopt','primer','product','primerweights','oligosinput','oligos',],
	"program" => ['explainflag','fileflag','task','numreturn','firstbaseindex',],
	"task" => ['0','Pick PCR primers','1','Pick PCR primers and hybridization probe','2','Pick forward primer only','3','Pick reverse primer only','4','Pick hybridization probe only',],
	"sequenceopt" => ['includedregion','target','excludedregion','forwardinput','reverseinput',],
	"primer" => ['pickanyway','mispriminglibrary','maxmispriming','pairmaxmispriming','gcclamp','osize','minsize','maxsize','otm','mintm','maxtm','maxdifftm','ogcpercent','mingc','maxgc','saltconc','dnaconc','numnsaccepted','selfany','selfend','maxpolyx',],
	"product" => ['productosize','productsizerange','productotm','productmintm','productmaxtm',],
	"primerweights" => ['maxendstability',],
	"oligosinput" => ['oligoexcludedregion','oligoinput',],
	"oligos" => ['oligoosize','oligominsize','oligomaxsize','oligootm','oligomintm','oligomaxtm','oligoogcpercent','oligomingc','oligomaxgc','oligosaltconc','oligodnaconc','oligoselfany','oligoselfend','oligomaxpolyx','oligomishyblibrary','oligomaxmishyb',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"explainflag" => '0',
	"fileflag" => '0',
	"task" => '0',
	"numreturn" => '5',
	"firstbaseindex" => '1',
	"pickanyway" => '0',
	"maxmispriming" => '12.00',
	"pairmaxmispriming" => '24.00',
	"gcclamp" => '0',
	"osize" => '20',
	"minsize" => '18',
	"maxsize" => '27',
	"otm" => '60.0',
	"mintm" => '57.0',
	"maxtm" => '63.0',
	"maxdifftm" => '100.0',
	"ogcpercent" => '50.0',
	"mingc" => '20.0',
	"maxgc" => '80.0',
	"saltconc" => '50.0',
	"dnaconc" => '50.0',
	"numnsaccepted" => '0',
	"selfany" => '8.00',
	"selfend" => '3.00',
	"maxpolyx" => '5',
	"productosize" => '200',
	"productsizerange" => '100-300',
	"productotm" => '0.0',
	"productmintm" => '-1000000.0',
	"productmaxtm" => '1000000.0',
	"maxendstability" => '9.0',
	"oligoosize" => '20',
	"oligominsize" => '18',
	"oligomaxsize" => '27',
	"oligootm" => '60.0',
	"oligomintm" => '57.0',
	"oligomaxtm" => '63.0',
	"oligoogcpercent" => '50.0',
	"oligomingc" => '20.0',
	"oligomaxgc" => '80.0',
	"oligosaltconc" => '50.0',
	"oligodnaconc" => '50.0',
	"oligoselfany" => '12.00',
	"oligoselfend" => '12.00',
	"oligomaxpolyx" => '5',
	"oligomaxmishyb" => '12.0',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"program" => { "perl" => '1' },
	"explainflag" => { "perl" => '1' },
	"fileflag" => { "perl" => '1' },
	"task" => { "perl" => '1' },
	"numreturn" => { "perl" => '1' },
	"firstbaseindex" => { "perl" => '1' },
	"sequenceopt" => { "perl" => '1' },
	"includedregion" => { "perl" => '1' },
	"target" => { "perl" => '1' },
	"excludedregion" => { "perl" => '1' },
	"forwardinput" => { "perl" => '1' },
	"reverseinput" => { "perl" => '1' },
	"primer" => { "perl" => '1' },
	"pickanyway" => { "perl" => '1' },
	"mispriminglibrary" => { "perl" => '1' },
	"maxmispriming" => { "perl" => '1' },
	"pairmaxmispriming" => { "perl" => '1' },
	"gcclamp" => { "perl" => '1' },
	"osize" => { "perl" => '1' },
	"minsize" => { "perl" => '1' },
	"maxsize" => { "perl" => '1' },
	"otm" => { "perl" => '1' },
	"mintm" => { "perl" => '1' },
	"maxtm" => { "perl" => '1' },
	"maxdifftm" => { "perl" => '1' },
	"ogcpercent" => { "perl" => '1' },
	"mingc" => { "perl" => '1' },
	"maxgc" => { "perl" => '1' },
	"saltconc" => { "perl" => '1' },
	"dnaconc" => { "perl" => '1' },
	"numnsaccepted" => { "perl" => '1' },
	"selfany" => { "perl" => '1' },
	"selfend" => { "perl" => '1' },
	"maxpolyx" => { "perl" => '1' },
	"product" => { "perl" => '1' },
	"productosize" => { "perl" => '1' },
	"productsizerange" => { "perl" => '1' },
	"productotm" => { "perl" => '1' },
	"productmintm" => { "perl" => '1' },
	"productmaxtm" => { "perl" => '1' },
	"primerweights" => { "perl" => '1' },
	"maxendstability" => { "perl" => '1' },
	"oligosinput" => { "perl" => '1' },
	"oligoexcludedregion" => { "perl" => '1' },
	"oligoinput" => { "perl" => '1' },
	"oligos" => { "perl" => '1' },
	"oligoosize" => { "perl" => '1' },
	"oligominsize" => { "perl" => '1' },
	"oligomaxsize" => { "perl" => '1' },
	"oligootm" => { "perl" => '1' },
	"oligomintm" => { "perl" => '1' },
	"oligomaxtm" => { "perl" => '1' },
	"oligoogcpercent" => { "perl" => '1' },
	"oligomingc" => { "perl" => '1' },
	"oligomaxgc" => { "perl" => '1' },
	"oligosaltconc" => { "perl" => '1' },
	"oligodnaconc" => { "perl" => '1' },
	"oligoselfany" => { "perl" => '1' },
	"oligoselfend" => { "perl" => '1' },
	"oligomaxpolyx" => { "perl" => '1' },
	"oligomishyblibrary" => { "perl" => '1' },
	"oligomaxmishyb" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"program" => 0,
	"explainflag" => 0,
	"fileflag" => 0,
	"task" => 0,
	"numreturn" => 0,
	"firstbaseindex" => 0,
	"sequenceopt" => 0,
	"includedregion" => 0,
	"target" => 0,
	"excludedregion" => 0,
	"forwardinput" => 0,
	"reverseinput" => 0,
	"primer" => 0,
	"pickanyway" => 0,
	"mispriminglibrary" => 0,
	"maxmispriming" => 0,
	"pairmaxmispriming" => 0,
	"gcclamp" => 0,
	"osize" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"otm" => 0,
	"mintm" => 0,
	"maxtm" => 0,
	"maxdifftm" => 0,
	"ogcpercent" => 0,
	"mingc" => 0,
	"maxgc" => 0,
	"saltconc" => 0,
	"dnaconc" => 0,
	"numnsaccepted" => 0,
	"selfany" => 0,
	"selfend" => 0,
	"maxpolyx" => 0,
	"product" => 0,
	"productosize" => 0,
	"productsizerange" => 0,
	"productotm" => 0,
	"productmintm" => 0,
	"productmaxtm" => 0,
	"primerweights" => 0,
	"maxendstability" => 0,
	"oligosinput" => 0,
	"oligoexcludedregion" => 0,
	"oligoinput" => 0,
	"oligos" => 0,
	"oligoosize" => 0,
	"oligominsize" => 0,
	"oligomaxsize" => 0,
	"oligootm" => 0,
	"oligomintm" => 0,
	"oligomaxtm" => 0,
	"oligoogcpercent" => 0,
	"oligomingc" => 0,
	"oligomaxgc" => 0,
	"oligosaltconc" => 0,
	"oligodnaconc" => 0,
	"oligoselfany" => 0,
	"oligoselfend" => 0,
	"oligomaxpolyx" => 0,
	"oligomishyblibrary" => 0,
	"oligomaxmishyb" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"program" => 0,
	"explainflag" => 0,
	"fileflag" => 0,
	"task" => 1,
	"numreturn" => 0,
	"firstbaseindex" => 0,
	"sequenceopt" => 0,
	"includedregion" => 0,
	"target" => 0,
	"excludedregion" => 0,
	"forwardinput" => 0,
	"reverseinput" => 0,
	"primer" => 0,
	"pickanyway" => 0,
	"mispriminglibrary" => 0,
	"maxmispriming" => 0,
	"pairmaxmispriming" => 0,
	"gcclamp" => 0,
	"osize" => 0,
	"minsize" => 0,
	"maxsize" => 0,
	"otm" => 0,
	"mintm" => 0,
	"maxtm" => 0,
	"maxdifftm" => 0,
	"ogcpercent" => 0,
	"mingc" => 0,
	"maxgc" => 0,
	"saltconc" => 0,
	"dnaconc" => 0,
	"numnsaccepted" => 0,
	"selfany" => 0,
	"selfend" => 0,
	"maxpolyx" => 0,
	"product" => 0,
	"productosize" => 0,
	"productsizerange" => 0,
	"productotm" => 0,
	"productmintm" => 0,
	"productmaxtm" => 0,
	"primerweights" => 0,
	"maxendstability" => 0,
	"oligosinput" => 0,
	"oligoexcludedregion" => 0,
	"oligoinput" => 0,
	"oligos" => 0,
	"oligoosize" => 0,
	"oligominsize" => 0,
	"oligomaxsize" => 0,
	"oligootm" => 0,
	"oligomintm" => 0,
	"oligomaxtm" => 0,
	"oligoogcpercent" => 0,
	"oligomingc" => 0,
	"oligomaxgc" => 0,
	"oligosaltconc" => 0,
	"oligodnaconc" => 0,
	"oligoselfany" => 0,
	"oligoselfend" => 0,
	"oligomaxpolyx" => 0,
	"oligomishyblibrary" => 0,
	"oligomaxmishyb" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"sequence" => [
		"The sequence from which to choose primers. The sequence must be presented 5\' to 3\'",
	],
	"explainflag" => [
		"If this flag is non-0, produce LEFT-EXPLAIN, RIGHT-EXPLAIN, and INTERNAL-OLIGO-EXPLAIN output tags, which are intended to provide information on the number of oligos and primer pairs that EPrimer3 examined, and statistics on the number discarded for various reasons.",
	],
	"fileflag" => [
		"If the associated value is non-0, then EPrimer3 creates two output files for each input SEQUENCE. File (sequence-id).for lists all acceptable forward primers for (sequence-id), and (sequence-id).rev lists all acceptable reverse primers for (sequence-id), where (sequence-id) is the value of the SEQUENCE-ID tag (which must be supplied). In addition, if the input tag TASK is 1 or 4, EPrimer3 produces a file (sequence-id).int, which lists all acceptable internal oligos.",
	],
	"task" => [
		"Tell EPrimer3 what task to perform. Legal values are 0: \'Pick PCR primers\', 1: \'Pick PCR primers and hybridization probe\', 2: \'Pick forward primer only\', 3: \'Pick reverse primer only\', 4: \'Pick hybridization probe only\'. <BR> The tasks should be self explanatory. <BR> Briefly, an \'internal oligo\' is intended to be used as a hybridization probe (hyb probe) to detect the PCR product after amplification.",
	],
	"numreturn" => [
		"The maximum number of primer pairs to return. Primer pairs returned are sorted by their \'quality\', in other words by the value of the objective function (where a lower number indicates a better primer pair). Caution: setting this parameter to a large value will increase running time.",
	],
	"firstbaseindex" => [
		"This parameter is the index of the first base in the input sequence. For input and output using 1-based indexing (such as that used in GenBank and to which many users are accustomed) set this parameter to 1. For input and output using 0-based indexing set this parameter to 0. (This parameter also affects the indexes in the contents of the files produced when the primer file flag is set.)",
	],
	"includedregion" => [
		"A sub-region of the given sequence in which to pick primers. For example, often the first dozen or so bases of a sequence are vector, and should be excluded from consideration. The value for this parameter has the form <BR> (start),(end) <BR> where (start) is the index of the first base to consider, and (end) is the last in the primer-picking region.",
	],
	"target" => [
		"If one or more Targets is specified then a legal primer pair must flank at least one of them. A Target might be a simple sequence repeat site (for example a CA repeat) or a single-base-pair polymorphism. The value should be a space-separated list of <BR> (start),(end) <BR> pairs where (start) is the index of the first base of a Target, and (end) is the last <BR> E.g. 50,51 requires primers to surround the 2 bases at positions 50 and 51.",
	],
	"excludedregion" => [
		"Primer oligos may not overlap any region specified in this tag. The associated value must be a space-separated list of <BR> (start),(end) <BR> pairs where (start) is the index of the first base of the excluded region, and and (end) is the last. This tag is useful for tasks such as excluding regions of low sequence quality or for excluding regions containing repetitive elements such as ALUs or LINEs. <BR> E.g. 401,407 68,70 forbids selection of primers in the 7 bases starting at 401 and the 3 bases at 68.",
	],
	"forwardinput" => [
		"The sequence of a forward primer to check and around which to design reverse primers and optional internal oligos. Must be a substring of SEQUENCE.",
	],
	"reverseinput" => [
		"The sequence of a reverse primer to check and around which to design forward primers and optional internal oligos. Must be a substring of the reverse strand of SEQUENCE.",
	],
	"pickanyway" => [
		"If true pick a primer pair even if LEFT-INPUT, RIGHT-INPUT, or INTERNAL-OLIGO-INPUT violates specific constraints.",
	],
	"mispriminglibrary" => [
		"The name of a file containing a nucleotide sequence library of sequences to avoid amplifying (for example repetitive sequences, or possibly the sequences of genes in a gene family that should not be amplified.) The file must be in (a slightly restricted) FASTA format (W. B. Pearson and D.J. Lipman, PNAS 85:8 pp 2444-2448 [1988]); we briefly discuss the organization of this file below. If this parameter is specified then EPrimer3 locally aligns each candidate primer against each library sequence and rejects those primers for which the local alignment score times a specified weight (see below) exceeds MAX-MISPRIMING. (The maximum value of the weight is arbitrarily set to 100.0.) <BR> Each sequence entry in the FASTA-format file must begin with an \'id line\' that starts with \'>\'. The contents of the id line is \'slightly restricted\' in that EPrimer3 parses everything after any optional asterisk (\'*\') as a floating point number to use as the weight mentioned above. If the id line contains no asterisk then the weight defaults to 1.0. The alignment scoring system used is the same as for calculating complementarity among oligos (e.g. SELF-ANY). The remainder of an entry contains the sequence as lines following the id line up until a line starting with \'>\' or the end of the file. Whitespace and newlines are ignored. Characters \'A\', \'T\', \'G\', \'C\', \'a\', \'t\', \'g\', \'c\' are retained and any other character is converted to \'N\' (with the consequence that any IUB / IUPAC codes for ambiguous bases are converted to \'N\'). There are no restrictions on line length. <BR> An empty value for this parameter indicates that no repeat library should be used.",
	],
	"maxmispriming" => [
		"The maximum allowed weighted similarity with any sequence in MISPRIMING-LIBRARY.",
	],
	"pairmaxmispriming" => [
		"The maximum allowed sum of weighted similarities of a primer pair (one similarity for each primer) with any single sequence in MISPRIMING-LIBRARY.",
	],
	"gcclamp" => [
		"Require the specified number of consecutive Gs and Cs at the 3\' end of both the forward and reverse primer. (This parameter has no effect on the internal oligo if one is requested.)",
	],
	"osize" => [
		"Optimum length (in bases) of a primer oligo. EPrimer3 will attempt to pick primers close to this length.",
	],
	"minsize" => [
		"Minimum acceptable length of a primer. Must be greater than 0 and less than or equal to MAX-SIZE.",
	],
	"maxsize" => [
		"Maximum acceptable length (in bases) of a primer. Currently this parameter cannot be larger than 35. This limit is governed by the maximum oligo size for which EPrimer3\'s melting-temperature is valid.",
	],
	"otm" => [
		"Optimum melting temperature(Celsius) for a primer oligo. EPrimer3 will try to pick primers with melting temperatures are close to this temperature. The oligo melting temperature formula in EPrimer3 is that given in Rychlik, Spencer and Rhoads, Nucleic Acids Research, vol 18, num 12, pp 6409-6412 and Breslauer, Frank, Bloeker and Marky, Proc. Natl. Acad. Sci. USA, vol 83, pp 3746-3750. Please refer to the former paper for background discussion.",
	],
	"mintm" => [
		"Minimum acceptable melting temperature(Celsius) for a primer oligo.",
	],
	"maxtm" => [
		"Maximum acceptable melting temperature(Celsius) for a primer oligo.",
	],
	"maxdifftm" => [
		"Maximum acceptable (unsigned) difference between the melting temperatures of the forward and reverse primers.",
	],
	"ogcpercent" => [
		"Primer optimum GC percent.",
	],
	"mingc" => [
		"Minimum allowable percentage of Gs and Cs in any primer.",
	],
	"maxgc" => [
		"Maximum allowable percentage of Gs and Cs in any primer generated by Primer.",
	],
	"saltconc" => [
		"The millimolar concentration of salt (usually KCl) in the PCR. EPrimer3 uses this argument to calculate oligo melting temperatures.",
	],
	"dnaconc" => [
		"The nanomolar concentration of annealing oligos in the PCR. EPrimer3 uses this argument to calculate oligo melting temperatures. The default (50nM) works well with the standard protocol used at the Whitehead/MIT Center for Genome Research--0.5 microliters of 20 micromolar concentration for each primer oligo in a 20 microliter reaction with 10 nanograms template, 0.025 units/microliter Taq polymerase in 0.1 mM each dNTP, 1.5mM MgCl2, 50mM KCl, 10mM Tris-HCL (pH 9.3) using 35 cycles with an annealing temperature of 56 degrees Celsius. This parameter corresponds to \'c\' in Rychlik, Spencer and Rhoads\' equation (ii) (Nucleic Acids Research, vol 18, num 12) where a suitable value (for a lower initial concentration of template) is \'empirically determined\'. The value of this parameter is less than the actual concentration of oligos in the reaction because it is the concentration of annealing oligos, which in turn depends on the amount of template (including PCR product) in a given cycle. This concentration increases a great deal during a PCR; fortunately PCR seems quite robust for a variety of oligo melting temperatures. <BR> See ADVICE FOR PICKING PRIMERS.",
	],
	"numnsaccepted" => [
		"Maximum number of unknown bases (N) allowable in any primer.",
	],
	"selfany" => [
		"The maximum allowable local alignment score when testing a single primer for (local) self-complementarity and the maximum allowable local alignment score when testing for complementarity between forward and reverse primers. Local self-complementarity is taken to predict the tendency of primers to anneal to each other without necessarily causing self-priming in the PCR. The scoring system gives 1.00 for complementary bases, -0.25 for a match of any base (or N) with an N, -1.00 for a mismatch, and -2.00 for a gap. Only single-base-pair gaps are allowed. For example, the alignment <BR> 5\' ATCGNA 3\' <BR> ...|| | | <BR> 3\' TA-CGT 5\' <BR> is allowed (and yields a score of 1.75), but the alignment <BR> 5\' ATCCGNA 3\' <BR> ...|| | | <BR> 3\' TA--CGT 5\' <BR> is not considered. Scores are non-negative, and a score of 0.00 indicates that there is no reasonable local alignment between two oligos.",
	],
	"selfend" => [
		"The maximum allowable 3\'-anchored global alignment score when testing a single primer for self-complementarity, and the maximum allowable 3\'-anchored global alignment score when testing for complementarity between forward and reverse primers. The 3\'-anchored global alignment score is taken to predict the likelihood of PCR-priming primer-dimers, for example <BR> 5\' ATGCCCTAGCTTCCGGATG 3\' <BR> .............||| ||||| <BR> ..........3\' AAGTCCTACATTTAGCCTAGT 5\' <BR> or <BR> 5\' AGGCTATGGGCCTCGCGA 3\' <BR> ...............|||||| <BR> ............3\' AGCGCTCCGGGTATCGGA 5\' <BR> The scoring system is as for the Maximum Complementarity argument. In the examples above the scores are 7.00 and 6.00 respectively. Scores are non-negative, and a score of 0.00 indicates that there is no reasonable 3\'-anchored global alignment between two oligos. In order to estimate 3\'-anchored global alignments for candidate primers and primer pairs, Primer assumes that the sequence from which to choose primers is presented 5\' to 3\'. It is nonsensical to provide a larger value for this parameter than for the Maximum (local) Complementarity parameter because the score of a local alignment will always be at least as great as the score of a global alignment.",
	],
	"maxpolyx" => [
		"The maximum allowable length of a mononucleotide repeat in a primer, for example AAAAAA.",
	],
	"productosize" => [
		"The optimum size for the PCR product. 0 indicates that there is no optimum product size.",
	],
	"productsizerange" => [
		"The associated values specify the lengths of the product that the user wants the primers to create, and is a space separated list of elements of the form <BR> (x)-(y) <BR> where an (x)-(y) pair is a legal range of lengths for the product. For example, if one wants PCR products to be between 100 to 150 bases (inclusive) then one would set this parameter to 100-150. If one desires PCR products in either the range from 100 to 150 bases or in the range from 200 to 250 bases then one would set this parameter to 100-150 200-250. <BR> EPrimer3 favors ranges to the left side of the parameter string. EPrimer3 will return legal primers pairs in the first range regardless the value of the objective function for these pairs. Only if there are an insufficient number of primers in the first range will EPrimer3 return primers in a subsequent range.",
	],
	"productotm" => [
		"The optimum melting temperature for the PCR product. 0 indicates that there is no optimum temperature.",
	],
	"productmintm" => [
		"The minimum allowed melting temperature of the amplicon. Please see the documentation on the maximum melting temperature of the product for details.",
	],
	"productmaxtm" => [
		"The maximum allowed melting temperature of the amplicon. Product Tm is calculated using the formula from Bolton and McCarthy, PNAS 84:1390 (1962) as presented in Sambrook, Fritsch and Maniatis, Molecular Cloning, p 11.46 (1989, CSHL Press). <BR> Tm = 81.5 + 16.6(log10([Na+])) + .41*(%GC) - 600/length <BR> Where [Na+} is the molar sodium concentration, (%GC) is the percent of Gs and Cs in the sequence, and length is the length of the sequence. <BR> A similar formula is used by the prime primer selection program in GCG http://www.gcg.com), which instead uses 675.0/length in the last term (after F. Baldino, Jr, M.-F. Chesselet, and M.E. Lewis, Methods in Enzymology 168:766 (1989) eqn (1) on page 766 without the mismatch and formamide terms). The formulas here and in Baldino et al. assume Na+ rather than K+. According to J.G. Wetmur, Critical Reviews in BioChem. and Mol. Bio. 26:227 (1991) 50 mM K+ should be equivalent in these formulae to .2 M Na+. EPrimer3 uses the same salt concentration value for calculating both the primer melting temperature and the oligo melting temperature. If you are planning to use the PCR product for hybridization later this behavior will not give you the Tm under hybridization conditions.",
	],
	"maxendstability" => [
		"The maximum stability for the five 3\' bases of a forward or reverse primer. Bigger numbers mean more stable 3\' ends. The value is the maximum delta G for duplex disruption for the five 3\' bases as calculated using the nearest neighbor parameters published in Breslauer, Frank, Bloeker and Marky, Proc. Natl. Acad. Sci. USA, vol 83, pp 3746-3750. EPrimer3 uses a completely permissive default value for backward compatibility (which we may change in the next release). Rychlik recommends a maximum value of 9 (Wojciech Rychlik, \'Selection of Primers for Polymerase Chain Reaction\' in BA White, Ed., \'Methods in Molecular Biology, Vol. 15: PCR Protocols: Current Methods and Applications\', 1993, pp 31-40, Humana Press, Totowa NJ).",
	],
	"oligoexcludedregion" => [
		"Middle oligos may not overlap any region specified by this tag. The associated value must be a space-separated list of <BR> (start),(end) <BR> pairs, where (start) is the index of the first base of an excluded region, and (end) is the last. Often one would make Target regions excluded regions for internal oligos.",
	],
	"oligoinput" => [
		"The sequence of an internal oligo to check and around which to design forward and reverse primers. Must be a substring of SEQUENCE.",
	],
	"oligoosize" => [
		"Optimum length (in bases) of an internal oligo. EPrimer3 will attempt to pick primers close to this length.",
	],
	"oligominsize" => [
		"Minimum acceptable length of an internal oligo. Must be greater than 0 and less than or equal to INTERNAL-OLIGO-MAX-SIZE.",
	],
	"oligomaxsize" => [
		"Maximum acceptable length (in bases) of an internal oligo. Currently this parameter cannot be larger than 35. This limit is governed by maximum oligo size for which EPrimer3\'s melting-temperature is valid.",
	],
	"oligootm" => [
		"Optimum melting temperature (Celsius) for an internal oligo. EPrimer3 will try to pick oligos with melting temperatures that are close to this temperature. The oligo melting temperature formula in EPrimer3 is that given in Rychlik, Spencer and Rhoads, Nucleic Acids Research, vol 18, num 12, pp 6409-6412 and Breslauer, Frank, Bloeker and Marky, Proc. Natl. Acad. Sci. USA, vol 83, pp 3746-3750. Please refer to the former paper for background discussion.",
	],
	"oligomintm" => [
		"Minimum acceptable melting temperature(Celsius) for an internal oligo.",
	],
	"oligomaxtm" => [
		"Maximum acceptable melting temperature (Celsius) for an internal oligo.",
	],
	"oligoogcpercent" => [
		"Internal oligo optimum GC percent.",
	],
	"oligomingc" => [
		"Minimum allowable percentage of Gs and Cs in an internal oligo.",
	],
	"oligomaxgc" => [
		"Maximum allowable percentage of Gs and Cs in any internal oligo generated by Primer.",
	],
	"oligosaltconc" => [
		"The millimolar concentration of salt (usually KCl) in the hybridization. EPrimer3 uses this argument to calculate internal oligo melting temperatures.",
	],
	"oligodnaconc" => [
		"The nanomolar concentration of annealing internal oligo in the hybridization.",
	],
	"oligoselfany" => [
		"The maximum allowable local alignment score when testing an internal oligo for (local) self-complementarity. Local self-complementarity is taken to predict the tendency of oligos to anneal to themselves The scoring system gives 1.00 for complementary bases, -0.25 for a match of any base (or N) with an N, -1.00 for a mismatch, and -2.00 for a gap. Only single-base-pair gaps are allowed. For example, the alignment <BR> 5\' ATCGNA 3\' <BR> || | | <BR> 3\' TA-CGT 5\' <BR> is allowed (and yields a score of 1.75), but the alignment <BR> 5\' ATCCGNA 3\' <BR> || | | <BR> 3\' TA--CGT 5\' <BR> is not considered. Scores are non-negative, and a score of 0.00 indicates that there is no reasonable local alignment between two oligos.",
	],
	"oligoselfend" => [
		"The maximum allowable 3\'-anchored global alignment score when testing a single oligo for self-complementarity. <BR> The scoring system is as for the Maximum Complementarity argument. In the examples above the scores are 7.00 and 6.00 respectively. Scores are non-negative, and a score of 0.00 indicates that there is no reasonable 3\'-anchored global alignment between two oligos. In order to estimate 3\'-anchored global alignments for candidate oligos, Primer assumes that the sequence from which to choose oligos is presented 5\' to 3\'. <BR> INTERNAL-OLIGO-SELF-END is meaningless when applied to internal oligos used for hybridization-based detection, since primer-dimer will not occur. We recommend that INTERNAL-OLIGO-SELF-END be set at least as high as INTERNAL-OLIGO-SELF-ANY.",
	],
	"oligomaxpolyx" => [
		"The maximum allowable length of an internal oligo mononucleotide repeat, for example AAAAAA.",
	],
	"oligomishyblibrary" => [
		"Similar to MISPRIMING-LIBRARY, except that the event we seek to avoid is hybridization of the internal oligo to sequences in this library rather than priming from them. <BR> The file must be in (a slightly restricted) FASTA format (W. B. Pearson and D.J. Lipman, PNAS 85:8 pp 2444-2448 [1988]); we briefly discuss the organization of this file below. If this parameter is specified then EPrimer3 locally aligns each candidate oligo against each library sequence and rejects those primers for which the local alignment score times a specified weight (see below) exceeds INTERNAL-OLIGO-MAX-MISHYB. (The maximum value of the weight is arbitrarily set to 12.0.) <BR> Each sequence entry in the FASTA-format file must begin with an \'id line\' that starts with \'>\'. The contents of the id line is \'slightly restricted\' in that EPrimer3 parses everything after any optional asterisk (\'*\') as a floating point number to use as the weight mentioned above. If the id line contains no asterisk then the weight defaults to 1.0. The alignment scoring system used is the same as for calculating complementarity among oligos (e.g. SELF-ANY). The remainder of an entry contains the sequence as lines following the id line up until a line starting with \'>\' or the end of the file. Whitespace and newlines are ignored. Characters \'A\', \'T\', \'G\', \'C\', \'a\', \'t\', \'g\', \'c\' are retained and any other character is converted to \'N\' (with the consequence that any IUB / IUPAC codes for ambiguous bases are converted to \'N\'). There are no restrictions on line length. <BR> An empty value for this parameter indicates that no library should be used.",
	],
	"oligomaxmishyb" => [
		"Similar to MAX-MISPRIMING except that this parameter applies to the similarity of candidate internal oligos to the library specified in INTERNAL-OLIGO-MISHYB-LIBRARY.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/eprimer3.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

