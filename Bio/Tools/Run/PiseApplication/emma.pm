# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::emma
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::emma

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::emma

      Bioperl class for:

	EMMA	Multiple alignment program - interface to ClustalW program (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/emma.html 
         for available values):


		emma (String)

		init (String)

		inseqs (Sequence)
			inseqs -- gapany [sequences] (-inseqs)
			pipe: seqsfile

		onlydend (Switch)
			Do you want to produce only the dendrogram file? (-onlydend)

		dend (Switch)
			Do you want to use an old dendogram file? (-dend)

		dendfile (String)
			What is the name of the old dendrogram file (-dendfile)

		insist (Switch)
			Insist that the sequence type is changed to protein (-insist)

		slowfast (Excl)
			Please select one -- Do you want to carry out slow or fast pairwise alignment (-slowfast)

		pwgapc (Float)
			Input value for gap open penalty (-pwgapc)

		pwgapv (Float)
			Input value for gap extension penalty (-pwgapv)

		prot (Switch)
			Do not change this value (-prot)

		pwmatrix (Excl)
			Select matrix -- Protein pairwise alignment matrix options (-pwmatrix)

		pwdnamatrix (Excl)
			Select matrix -- DNA pairwise alignment matrix options (-pwdnamatrix)

		pairwisedata (String)
			Input the filename of your pairwise matrix (-pairwisedata)

		ktup (Integer)
			Fast pairwise alignment: similarity scores: K-Tuple size (-ktup)

		gapw (Integer)
			Fast pairwise alignment: similarity scores: gap penalty (-gapw)

		topdiags (Integer)
			Fast pairwise alignment: similarity scores: number of diagonals to be considered (-topdiags)

		window (Integer)
			Fast pairwise alignment: similarity scores: diagonal window size (-window)

		nopercent (Switch)
			Fast pairwise alignment: similarity scores: suppresses percentage score (-nopercent)

		matrix (Excl)
			Select matrix -- Protein multiple alignment matrix options (-matrix)

		dnamatrix (Excl)
			Select matrix -- Nucleotide multiple alignment matrix options (-dnamatrix)

		mamatrix (String)
			Input the filename of your alignment matrix (-mamatrix)

		gapc (Float)
			Enter gap penalty (-gapc)

		gapv (Float)
			Enter variable gap penalty (-gapv)

		endgaps (Switch)
			Use end gap separation penalty (-endgaps)

		gapdist (Integer)
			Gap separation distance (-gapdist)

		norgap (Switch)
			No residue specific gaps (-norgap)

		hgapres (String)
			List of hydrophilic residues (-hgapres)

		nohgap (Switch)
			No hydrophilic gaps (-nohgap)

		maxdiv (Integer)
			Cut-off to delay the alignment of the most divergent sequences (-maxdiv)

		outseq (OutFile)
			The sequence alignment output filename (-outseq)
			pipe: seqsfile

		outseq_sformat (Excl)
			Output format for: The sequence alignment output filename

		dendoutfile (OutFile)
			The dendogram output filename (-dendoutfile)

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

http://bioweb.pasteur.fr/seqanal/interfaces/emma.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::emma;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $emma = Bio::Tools::Run::PiseApplication::emma->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::emma object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $emma = $factory->program('emma');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::emma.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/emma.pm

    $self->{COMMAND}   = "emma";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EMMA";

    $self->{DESCRIPTION}   = "Multiple alignment program - interface to ClustalW program (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/emma.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"emma",
	"init",
	"input",
	"advanced",
	"insist",
	"maxdiv",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"emma",
	"init",
	"input", 	# input Section
	"inseqs", 	# inseqs -- gapany [sequences] (-inseqs)
	"advanced", 	# advanced Section
	"dendsection", 	# dendsection Section
	"onlydend", 	# Do you want to produce only the dendrogram file? (-onlydend)
	"dend", 	# Do you want to use an old dendogram file? (-dend)
	"dendfile", 	# What is the name of the old dendrogram file (-dendfile)
	"insist", 	# Insist that the sequence type is changed to protein (-insist)
	"slowsection", 	# slowsection Section
	"slowfast", 	# Please select one -- Do you want to carry out slow or fast pairwise alignment (-slowfast)
	"pwgapc", 	# Input value for gap open penalty (-pwgapc)
	"pwgapv", 	# Input value for gap extension penalty (-pwgapv)
	"protsection", 	# protsection Section
	"prot", 	# Do not change this value (-prot)
	"pwmatrix", 	# Select matrix -- Protein pairwise alignment matrix options (-pwmatrix)
	"pwdnamatrix", 	# Select matrix -- DNA pairwise alignment matrix options (-pwdnamatrix)
	"pairwisedata", 	# Input the filename of your pairwise matrix (-pairwisedata)
	"fastsection", 	# fastsection Section
	"ktup", 	# Fast pairwise alignment: similarity scores: K-Tuple size (-ktup)
	"gapw", 	# Fast pairwise alignment: similarity scores: gap penalty (-gapw)
	"topdiags", 	# Fast pairwise alignment: similarity scores: number of diagonals to be considered (-topdiags)
	"window", 	# Fast pairwise alignment: similarity scores: diagonal window size (-window)
	"nopercent", 	# Fast pairwise alignment: similarity scores: suppresses percentage score (-nopercent)
	"matrixsection", 	# matrixsection Section
	"matrix", 	# Select matrix -- Protein multiple alignment matrix options (-matrix)
	"dnamatrix", 	# Select matrix -- Nucleotide multiple alignment matrix options (-dnamatrix)
	"mamatrix", 	# Input the filename of your alignment matrix (-mamatrix)
	"gapsection", 	# gapsection Section
	"gapc", 	# Enter gap penalty (-gapc)
	"gapv", 	# Enter variable gap penalty (-gapv)
	"endgaps", 	# Use end gap separation penalty (-endgaps)
	"gapdist", 	# Gap separation distance (-gapdist)
	"norgap", 	# No residue specific gaps (-norgap)
	"hgapres", 	# List of hydrophilic residues (-hgapres)
	"nohgap", 	# No hydrophilic gaps (-nohgap)
	"maxdiv", 	# Cut-off to delay the alignment of the most divergent sequences (-maxdiv)
	"output", 	# output Section
	"outseq", 	# The sequence alignment output filename (-outseq)
	"outseq_sformat", 	# Output format for: The sequence alignment output filename
	"dendoutfile", 	# The dendogram output filename (-dendoutfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"emma" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"inseqs" => 'Sequence',
	"advanced" => 'Paragraph',
	"dendsection" => 'Paragraph',
	"onlydend" => 'Switch',
	"dend" => 'Switch',
	"dendfile" => 'String',
	"insist" => 'Switch',
	"slowsection" => 'Paragraph',
	"slowfast" => 'Excl',
	"pwgapc" => 'Float',
	"pwgapv" => 'Float',
	"protsection" => 'Paragraph',
	"prot" => 'Switch',
	"pwmatrix" => 'Excl',
	"pwdnamatrix" => 'Excl',
	"pairwisedata" => 'String',
	"fastsection" => 'Paragraph',
	"ktup" => 'Integer',
	"gapw" => 'Integer',
	"topdiags" => 'Integer',
	"window" => 'Integer',
	"nopercent" => 'Switch',
	"matrixsection" => 'Paragraph',
	"matrix" => 'Excl',
	"dnamatrix" => 'Excl',
	"mamatrix" => 'String',
	"gapsection" => 'Paragraph',
	"gapc" => 'Float',
	"gapv" => 'Float',
	"endgaps" => 'Switch',
	"gapdist" => 'Integer',
	"norgap" => 'Switch',
	"hgapres" => 'String',
	"nohgap" => 'Switch',
	"maxdiv" => 'Integer',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"dendoutfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"inseqs" => {
		"perl" => '" -inseqs=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"dendsection" => {
	},
	"onlydend" => {
		"perl" => '($value)? " -onlydend" : ""',
	},
	"dend" => {
		"perl" => '($value)? " -dend" : ""',
	},
	"dendfile" => {
		"perl" => '($value && $value ne $vdef)? " -dendfile=$value" : ""',
	},
	"insist" => {
		"perl" => '($value)? " -insist" : ""',
	},
	"slowsection" => {
	},
	"slowfast" => {
		"perl" => '" -slowfast=$value"',
	},
	"pwgapc" => {
		"perl" => '(defined $value && $value != $vdef)? " -pwgapc=$value" : ""',
	},
	"pwgapv" => {
		"perl" => '(defined $value && $value != $vdef)? " -pwgapv=$value" : ""',
	},
	"protsection" => {
	},
	"prot" => {
		"perl" => '($value)? " -prot" : ""',
	},
	"pwmatrix" => {
		"perl" => '" -pwmatrix=$value"',
	},
	"pwdnamatrix" => {
		"perl" => '" -pwdnamatrix=$value"',
	},
	"pairwisedata" => {
		"perl" => '($value && $value ne $vdef)? " -pairwisedata=$value" : ""',
	},
	"fastsection" => {
	},
	"ktup" => {
		"perl" => '(defined $value && $value != $vdef)? " -ktup=$value" : ""',
	},
	"gapw" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapw=$value" : ""',
	},
	"topdiags" => {
		"perl" => '(defined $value && $value != $vdef)? " -topdiags=$value" : ""',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -window=$value" : ""',
	},
	"nopercent" => {
		"perl" => '($value)? " -nopercent" : ""',
	},
	"matrixsection" => {
	},
	"matrix" => {
		"perl" => '" -matrix=$value"',
	},
	"dnamatrix" => {
		"perl" => '" -dnamatrix=$value"',
	},
	"mamatrix" => {
		"perl" => '($value && $value ne $vdef)? " -mamatrix=$value" : ""',
	},
	"gapsection" => {
	},
	"gapc" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapc=$value" : ""',
	},
	"gapv" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapv=$value" : ""',
	},
	"endgaps" => {
		"perl" => '($value)? " -endgaps" : ""',
	},
	"gapdist" => {
		"perl" => '(defined $value && $value != $vdef)? " -gapdist=$value" : ""',
	},
	"norgap" => {
		"perl" => '($value)? " -norgap" : ""',
	},
	"hgapres" => {
		"perl" => '($value && $value ne $vdef)? " -hgapres=$value" : ""',
	},
	"nohgap" => {
		"perl" => '($value)? " -nohgap" : ""',
	},
	"maxdiv" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxdiv=$value" : ""',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"dendoutfile" => {
		"perl" => '" -dendoutfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"emma" => {
		"perl" => '"emma"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"inseqs" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"inseqs" => 1,
	"onlydend" => 2,
	"dend" => 3,
	"dendfile" => 4,
	"insist" => 5,
	"slowfast" => 6,
	"pwgapc" => 7,
	"pwgapv" => 8,
	"prot" => 9,
	"pwmatrix" => 10,
	"pwdnamatrix" => 11,
	"pairwisedata" => 12,
	"ktup" => 13,
	"gapw" => 14,
	"topdiags" => 15,
	"window" => 16,
	"nopercent" => 17,
	"matrix" => 18,
	"dnamatrix" => 19,
	"mamatrix" => 20,
	"gapc" => 21,
	"gapv" => 22,
	"endgaps" => 23,
	"gapdist" => 24,
	"norgap" => 25,
	"hgapres" => 26,
	"nohgap" => 27,
	"maxdiv" => 28,
	"outseq" => 29,
	"outseq_sformat" => 30,
	"dendoutfile" => 31,
	"auto" => 32,
	"emma" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"emma",
	"advanced",
	"dendsection",
	"slowsection",
	"protsection",
	"fastsection",
	"matrixsection",
	"gapsection",
	"output",
	"inseqs",
	"onlydend",
	"dend",
	"dendfile",
	"insist",
	"slowfast",
	"pwgapc",
	"pwgapv",
	"prot",
	"pwmatrix",
	"pwdnamatrix",
	"pairwisedata",
	"ktup",
	"gapw",
	"topdiags",
	"window",
	"nopercent",
	"matrix",
	"dnamatrix",
	"mamatrix",
	"gapc",
	"gapv",
	"endgaps",
	"gapdist",
	"norgap",
	"hgapres",
	"nohgap",
	"maxdiv",
	"outseq",
	"outseq_sformat",
	"dendoutfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"inseqs" => 0,
	"advanced" => 0,
	"dendsection" => 0,
	"onlydend" => 0,
	"dend" => 0,
	"dendfile" => 0,
	"insist" => 0,
	"slowsection" => 0,
	"slowfast" => 0,
	"pwgapc" => 0,
	"pwgapv" => 0,
	"protsection" => 0,
	"prot" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pairwisedata" => 0,
	"fastsection" => 0,
	"ktup" => 0,
	"gapw" => 0,
	"topdiags" => 0,
	"window" => 0,
	"nopercent" => 0,
	"matrixsection" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"mamatrix" => 0,
	"gapsection" => 0,
	"gapc" => 0,
	"gapv" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"norgap" => 0,
	"hgapres" => 0,
	"nohgap" => 0,
	"maxdiv" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"dendoutfile" => 0,
	"auto" => 1,
	"emma" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"inseqs" => 0,
	"advanced" => 0,
	"dendsection" => 0,
	"onlydend" => 0,
	"dend" => 0,
	"dendfile" => 0,
	"insist" => 0,
	"slowsection" => 0,
	"slowfast" => 0,
	"pwgapc" => 0,
	"pwgapv" => 0,
	"protsection" => 0,
	"prot" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pairwisedata" => 0,
	"fastsection" => 0,
	"ktup" => 0,
	"gapw" => 0,
	"topdiags" => 0,
	"window" => 0,
	"nopercent" => 0,
	"matrixsection" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"mamatrix" => 0,
	"gapsection" => 0,
	"gapc" => 0,
	"gapv" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"norgap" => 0,
	"hgapres" => 0,
	"nohgap" => 0,
	"maxdiv" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"dendoutfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"inseqs" => 1,
	"advanced" => 0,
	"dendsection" => 0,
	"onlydend" => 0,
	"dend" => 0,
	"dendfile" => 0,
	"insist" => 0,
	"slowsection" => 0,
	"slowfast" => 1,
	"pwgapc" => 0,
	"pwgapv" => 0,
	"protsection" => 0,
	"prot" => 0,
	"pwmatrix" => 1,
	"pwdnamatrix" => 1,
	"pairwisedata" => 0,
	"fastsection" => 0,
	"ktup" => 0,
	"gapw" => 0,
	"topdiags" => 0,
	"window" => 0,
	"nopercent" => 0,
	"matrixsection" => 0,
	"matrix" => 1,
	"dnamatrix" => 1,
	"mamatrix" => 0,
	"gapsection" => 0,
	"gapc" => 0,
	"gapv" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"norgap" => 0,
	"hgapres" => 0,
	"nohgap" => 0,
	"maxdiv" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"dendoutfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"inseqs" => "inseqs -- gapany [sequences] (-inseqs)",
	"advanced" => "advanced Section",
	"dendsection" => "dendsection Section",
	"onlydend" => "Do you want to produce only the dendrogram file? (-onlydend)",
	"dend" => "Do you want to use an old dendogram file? (-dend)",
	"dendfile" => "What is the name of the old dendrogram file (-dendfile)",
	"insist" => "Insist that the sequence type is changed to protein (-insist)",
	"slowsection" => "slowsection Section",
	"slowfast" => "Please select one -- Do you want to carry out slow or fast pairwise alignment (-slowfast)",
	"pwgapc" => "Input value for gap open penalty (-pwgapc)",
	"pwgapv" => "Input value for gap extension penalty (-pwgapv)",
	"protsection" => "protsection Section",
	"prot" => "Do not change this value (-prot)",
	"pwmatrix" => "Select matrix -- Protein pairwise alignment matrix options (-pwmatrix)",
	"pwdnamatrix" => "Select matrix -- DNA pairwise alignment matrix options (-pwdnamatrix)",
	"pairwisedata" => "Input the filename of your pairwise matrix (-pairwisedata)",
	"fastsection" => "fastsection Section",
	"ktup" => "Fast pairwise alignment: similarity scores: K-Tuple size (-ktup)",
	"gapw" => "Fast pairwise alignment: similarity scores: gap penalty (-gapw)",
	"topdiags" => "Fast pairwise alignment: similarity scores: number of diagonals to be considered (-topdiags)",
	"window" => "Fast pairwise alignment: similarity scores: diagonal window size (-window)",
	"nopercent" => "Fast pairwise alignment: similarity scores: suppresses percentage score (-nopercent)",
	"matrixsection" => "matrixsection Section",
	"matrix" => "Select matrix -- Protein multiple alignment matrix options (-matrix)",
	"dnamatrix" => "Select matrix -- Nucleotide multiple alignment matrix options (-dnamatrix)",
	"mamatrix" => "Input the filename of your alignment matrix (-mamatrix)",
	"gapsection" => "gapsection Section",
	"gapc" => "Enter gap penalty (-gapc)",
	"gapv" => "Enter variable gap penalty (-gapv)",
	"endgaps" => "Use end gap separation penalty (-endgaps)",
	"gapdist" => "Gap separation distance (-gapdist)",
	"norgap" => "No residue specific gaps (-norgap)",
	"hgapres" => "List of hydrophilic residues (-hgapres)",
	"nohgap" => "No hydrophilic gaps (-nohgap)",
	"maxdiv" => "Cut-off to delay the alignment of the most divergent sequences (-maxdiv)",
	"output" => "output Section",
	"outseq" => "The sequence alignment output filename (-outseq)",
	"outseq_sformat" => "Output format for: The sequence alignment output filename",
	"dendoutfile" => "The dendogram output filename (-dendoutfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"inseqs" => 0,
	"advanced" => 0,
	"dendsection" => 0,
	"onlydend" => 0,
	"dend" => 0,
	"dendfile" => 0,
	"insist" => 0,
	"slowsection" => 0,
	"slowfast" => 0,
	"pwgapc" => 0,
	"pwgapv" => 0,
	"protsection" => 0,
	"prot" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pairwisedata" => 0,
	"fastsection" => 0,
	"ktup" => 0,
	"gapw" => 0,
	"topdiags" => 0,
	"window" => 0,
	"nopercent" => 0,
	"matrixsection" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"mamatrix" => 0,
	"gapsection" => 0,
	"gapc" => 0,
	"gapv" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"norgap" => 0,
	"hgapres" => 0,
	"nohgap" => 0,
	"maxdiv" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"dendoutfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['inseqs',],
	"advanced" => ['dendsection','slowsection','protsection','fastsection','matrixsection','gapsection',],
	"dendsection" => ['onlydend','dend','dendfile',],
	"slowsection" => ['slowfast','pwgapc','pwgapv',],
	"slowfast" => ['s','slow','f','fast',],
	"protsection" => ['prot','pwmatrix','pwdnamatrix','pairwisedata',],
	"pwmatrix" => ['b','blosum','p','pam','g','gonnet','i','id','o','own',],
	"pwdnamatrix" => ['i','iub','c','clustalw','o','own',],
	"fastsection" => ['ktup','gapw','topdiags','window','nopercent',],
	"matrixsection" => ['matrix','dnamatrix','mamatrix',],
	"matrix" => ['b','blosum','p','pam','g','gonnet','i','id','o','own',],
	"dnamatrix" => ['i','iub','c','clustalw','o','own',],
	"gapsection" => ['gapc','gapv','endgaps','gapdist','norgap','hgapres','nohgap',],
	"output" => ['outseq','outseq_sformat','dendoutfile',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"onlydend" => '0',
	"dend" => '0',
	"dendfile" => 'NULL',
	"insist" => '0',
	"slowfast" => 's',
	"pwgapc" => '10.0',
	"pwgapv" => '0.1',
	"prot" => '',
	"pwmatrix" => 'b',
	"pwdnamatrix" => 'i',
	"pairwisedata" => 'NULL',
	"ktup" => '',
	"gapw" => '',
	"topdiags" => '',
	"window" => '',
	"nopercent" => '0',
	"matrix" => 'b',
	"dnamatrix" => 'i',
	"mamatrix" => 'NULL',
	"gapc" => '10.0',
	"gapv" => '5.0',
	"endgaps" => '0',
	"gapdist" => '8',
	"norgap" => '0',
	"hgapres" => 'GPSNDQEKR',
	"nohgap" => '0',
	"maxdiv" => '30',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"dendoutfile" => 'dendoutfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"inseqs" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"dendsection" => { "perl" => '1' },
	"onlydend" => { "perl" => '1' },
	"dend" => { "perl" => '1' },
	"dendfile" => { "perl" => '1' },
	"insist" => { "perl" => '1' },
	"slowsection" => { "perl" => '1' },
	"slowfast" => { "perl" => '1' },
	"pwgapc" => { "perl" => '1' },
	"pwgapv" => { "perl" => '1' },
	"protsection" => { "perl" => '1' },
	"prot" => { "perl" => '1' },
	"pwmatrix" => { "perl" => '1' },
	"pwdnamatrix" => { "perl" => '1' },
	"pairwisedata" => { "perl" => '1' },
	"fastsection" => { "perl" => '1' },
	"ktup" => { "perl" => '1' },
	"gapw" => { "perl" => '1' },
	"topdiags" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"nopercent" => { "perl" => '1' },
	"matrixsection" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"dnamatrix" => { "perl" => '1' },
	"mamatrix" => { "perl" => '1' },
	"gapsection" => { "perl" => '1' },
	"gapc" => { "perl" => '1' },
	"gapv" => { "perl" => '1' },
	"endgaps" => { "perl" => '1' },
	"gapdist" => { "perl" => '1' },
	"norgap" => { "perl" => '1' },
	"hgapres" => { "perl" => '1' },
	"nohgap" => { "perl" => '1' },
	"maxdiv" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"dendoutfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqsfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"inseqs" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"inseqs" => 0,
	"advanced" => 0,
	"dendsection" => 0,
	"onlydend" => 0,
	"dend" => 0,
	"dendfile" => 0,
	"insist" => 0,
	"slowsection" => 0,
	"slowfast" => 0,
	"pwgapc" => 0,
	"pwgapv" => 0,
	"protsection" => 0,
	"prot" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pairwisedata" => 0,
	"fastsection" => 0,
	"ktup" => 0,
	"gapw" => 0,
	"topdiags" => 0,
	"window" => 0,
	"nopercent" => 0,
	"matrixsection" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"mamatrix" => 0,
	"gapsection" => 0,
	"gapc" => 0,
	"gapv" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"norgap" => 0,
	"hgapres" => 0,
	"nohgap" => 0,
	"maxdiv" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"dendoutfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"inseqs" => 1,
	"advanced" => 0,
	"dendsection" => 0,
	"onlydend" => 0,
	"dend" => 0,
	"dendfile" => 0,
	"insist" => 0,
	"slowsection" => 0,
	"slowfast" => 1,
	"pwgapc" => 0,
	"pwgapv" => 0,
	"protsection" => 0,
	"prot" => 0,
	"pwmatrix" => 1,
	"pwdnamatrix" => 1,
	"pairwisedata" => 0,
	"fastsection" => 0,
	"ktup" => 0,
	"gapw" => 0,
	"topdiags" => 0,
	"window" => 0,
	"nopercent" => 0,
	"matrixsection" => 0,
	"matrix" => 1,
	"dnamatrix" => 1,
	"mamatrix" => 0,
	"gapsection" => 0,
	"gapc" => 0,
	"gapv" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"norgap" => 0,
	"hgapres" => 0,
	"nohgap" => 0,
	"maxdiv" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"dendoutfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"slowfast" => [
		"A distance is calculated between every pair of sequences and these are used to construct the dendrogram which guides the final multiple alignment. The scores are calculated from separate pairwise alignments. These can be calculated using 2 methods: dynamic programming (slow but accurate) or by the method of Wilbur and Lipman (extremely fast but approximate). <BR> The slow-accurate method is fine for short sequences but will be VERY SLOW for many (e.g. >100) long (e.g. >1000 residue) sequences.",
	],
	"pwgapc" => [
		"The penalty for opening a gap in the pairwise alignments.",
	],
	"pwgapv" => [
		"The penalty for extending a gap by 1 residue in the pairwise alignments.",
	],
	"pwmatrix" => [
		"The scoring table which describes the similarity of each amino acid to each other. <BR> There are three \'in-built\' series of weight matrices offered. Each consists of several matrices which work differently at different evolutionary distances. To see the exact details, read the documentation. Crudely, we store several matrices in memory, spanning the full range of amino acid distance (from almost identical sequences to highly divergent ones). For very similar sequences, it is best to use a strict weight matrix which only gives a high score to identities and the most favoured conservative substitutions. For more divergent sequences, it is appropriate to use \'softer\' matrices which give a high score to many other frequent substitutions. <BR> 1) BLOSUM (Henikoff). These matrices appear to be the best available for carrying out data base similarity (homology searches). The matrices used are: Blosum80, 62, 45 and 30. <BR> 2) PAM (Dayhoff). These have been extremely widely used since the late \'70s. We use the PAM 120, 160, 250 and 350 matrices. <BR> 3) GONNET . These matrices were derived using almost the same procedure as the Dayhoff one (above) but are much more up to date and are based on a far larger data set. They appear to be more sensitive than the Dayhoff series. We use the GONNET 40, 80, 120, 160, 250 and 350 matrices. <BR> We also supply an identity matrix which gives a score of 1.0 to two identical amino acids and a score of zero otherwise. This matrix is not very useful.",
	],
	"pwdnamatrix" => [
		"The scoring table which describes the scores assigned to matches and mismatches (including IUB ambiguity codes).",
	],
	"ktup" => [
		"This is the size of exactly matching fragment that is used. INCREASE for speed (max= 2 for proteins; 4 for DNA), DECREASE for sensitivity. For longer sequences (e.g. >1000 residues) you may need to increase the default. Allowed values: integer from 0 to 4",
	],
	"gapw" => [
		"This is a penalty for each gap in the fast alignments. It has little affect on the speed or sensitivity except for extreme values. Allowed values: Positive integer",
	],
	"topdiags" => [
		"The number of k-tuple matches on each diagonal (in an imaginary dot-matrix plot) is calculated. Only the best ones (with most matches) are used in the alignment. This parameter specifies how many. Decrease for speed; increase for sensitivity. Allowed values: Positive integer",
	],
	"window" => [
		"This is the number of diagonals around each of the \'best\' diagonals that will be used. Decrease for speed; increase for sensitivity. Allowed values: Positive integer",
	],
	"matrix" => [
		"This gives a menu where you are offered a choice of weight matrices. The default for proteins is the PAM series derived by Gonnet and colleagues. Note, a series is used! The actual matrix that is used depends on how similar the sequences to be aligned at this alignment step are. Different matrices work differently at each evolutionary distance. <BR> There are three \'in-built\' series of weight matrices offered. Each consists of several matrices which work differently at different evolutionary distances. To see the exact details, read the documentation. Crudely, we store several matrices in memory, spanning the full range of amino acid distance (from almost identical sequences to highly divergent ones). For very similar sequences, it is best to use a strict weight matrix which only gives a high score to identities and the most favoured conservative substitutions. For more divergent sequences, it is appropriate to use \'softer\' matrices which give a high score to many other frequent substitutions. <BR> 1) BLOSUM (Henikoff). These matrices appear to be the best available for carrying out data base similarity (homology searches). The matrices used are: Blosum80, 62, 45 and 30. <BR> 2) PAM (Dayhoff). These have been extremely widely used since the late \'70s. We use the PAM 120, 160, 250 and 350 matrices. <BR> 3) GONNET . These matrices were derived using almost the same procedure as the Dayhoff one (above) but are much more up to date and are based on a far larger data set. They appear to be more sensitive than the Dayhoff series. We use the GONNET 40, 80, 120, 160, 250 and 350 matrices. <BR> We also supply an identity matrix which gives a score of 1.0 to two identical amino acids and a score of zero otherwise. This matrix is not very useful. Alternatively, you can read in your own (just one matrix, not a series).",
	],
	"dnamatrix" => [
		"This gives a menu where you are offered amenu where a single matrix (not a series) can be selected.",
	],
	"gapc" => [
		"The penalty for opening a gap in the alignment. Increasing the gap opening penalty will make gaps less frequent. Allowed values: Positive foating point number",
	],
	"gapv" => [
		"The penalty for extending a gap by 1 residue. Increasing the gap extension penalty will make gaps shorter. Terminal gaps are not penalised. Allowed values: Positive foating point number",
	],
	"endgaps" => [
		"\'End gap separation\' treats end gaps just like internal gaps for the purposes of avoiding gaps that are too close (set by \'gap separation distance\'). If you turn this off, end gaps will be ignored for this purpose. This is useful when you wish to align fragments where the end gaps are not biologically meaningful.",
	],
	"gapdist" => [
		"\'Gap separation distance\' tries to decrease the chances of gaps being too close to each other. Gaps that are less than this distance apart are penalised more than other gaps. This does not prevent close gaps; it makes them less frequent, promoting a block-like appearance of the alignment. Allowed values: Positive integer",
	],
	"norgap" => [
		"\'Residue specific penalties\' are amino acid specific gap penalties that reduce or increase the gap opening penalties at each position in the alignment or sequence. As an example, positions that are rich in glycine are more likely to have an adjacent gap than positions that are rich in valine.",
	],
	"hgapres" => [
		"This is a set of the residues \'considered\' to be hydrophilic. It is used when introducing Hydrophilic gap penalties.",
	],
	"nohgap" => [
		"\'Hydrophilic gap penalties\' are used to increase the chances of a gap within a run (5 or more residues) of hydrophilic amino acids; these are likely to be loop or random coil regions where gaps are more common. The residues that are \'considered\' to be hydrophilic are set by \'-hgapres\'.",
	],
	"maxdiv" => [
		"This switch, delays the alignment of the most distantly related sequences until after the most closely related sequences have been aligned. The setting shows the percent identity level required to delay the addition of a sequence; sequences that are less identical than this level to any other sequences will be aligned later. Allowed values: Integer from 0 to 100",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/emma.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

