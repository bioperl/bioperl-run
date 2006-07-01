# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::showalign
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::showalign

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::showalign

      Bioperl class for:

	SHOWALIGN	Displays a multiple sequence alignment (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/showalign.html 
         for available values):


		showalign (String)

		init (String)

		sequence (Sequence)
			sequence -- gapany [set of sequences] (-sequence)
			pipe: seqsfile

		refseq (String)
			The number or the name of the reference sequence (-refseq)

		bottom (Switch)
			Display the reference sequence at the bottom (-bottom)

		show (Excl)
			What to show -- What to show (-show)

		order (Excl)
			Output order of the sequences -- Output order of the sequences (-order)

		similarcase (Switch)
			Show similar residues in lower-case (-similarcase)

		matrix (Excl)
			Similarity scoring Matrix file (-matrix)

		uppercase (Integer)
			Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)

		number (Switch)
			Number the sequences (-number)

		ruler (Switch)
			Display ruler (-ruler)

		width (Integer)
			Width of sequence to display (-width)

		margin (Integer)
			Length of margin for sequence names (-margin)

		html (Switch)
			Use HTML formatting (-html)

		highlight (Integer)
			Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)

		plurality (Float)
			Plurality check % for consensus (-plurality)

		setcase (Float)
			Threshold above which the consensus is given in uppercase (-setcase)

		identity (Float)
			Required % of identities at a position fro consensus (-identity)

		consensus (Switch)
			Display the consensus line (-consensus)

		outfile (OutFile)
			Output sequence details to a file (-outfile)

		auto (String)

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

http://bioweb.pasteur.fr/seqanal/interfaces/showalign.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::showalign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $showalign = Bio::Tools::Run::PiseApplication::showalign->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::showalign object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $showalign = $factory->program('showalign');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::showalign.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showalign.pm

    $self->{COMMAND}   = "showalign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "SHOWALIGN";

    $self->{DESCRIPTION}   = "Displays a multiple sequence alignment (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",

         "display",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/showalign.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"showalign",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"showalign",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- gapany [set of sequences] (-sequence)
	"advanced", 	# advanced Section
	"refseq", 	# The number or the name of the reference sequence (-refseq)
	"bottom", 	# Display the reference sequence at the bottom (-bottom)
	"show", 	# What to show -- What to show (-show)
	"order", 	# Output order of the sequences -- Output order of the sequences (-order)
	"similarcase", 	# Show similar residues in lower-case (-similarcase)
	"matrix", 	# Similarity scoring Matrix file (-matrix)
	"uppercase", 	# Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)
	"number", 	# Number the sequences (-number)
	"ruler", 	# Display ruler (-ruler)
	"width", 	# Width of sequence to display (-width)
	"margin", 	# Length of margin for sequence names (-margin)
	"html", 	# Use HTML formatting (-html)
	"highlight", 	# Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)
	"plurality", 	# Plurality check % for consensus (-plurality)
	"setcase", 	# Threshold above which the consensus is given in uppercase (-setcase)
	"identity", 	# Required % of identities at a position fro consensus (-identity)
	"consensus", 	# Display the consensus line (-consensus)
	"output", 	# output Section
	"outfile", 	# Output sequence details to a file (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"showalign" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"refseq" => 'String',
	"bottom" => 'Switch',
	"show" => 'Excl',
	"order" => 'Excl',
	"similarcase" => 'Switch',
	"matrix" => 'Excl',
	"uppercase" => 'Integer',
	"number" => 'Switch',
	"ruler" => 'Switch',
	"width" => 'Integer',
	"margin" => 'Integer',
	"html" => 'Switch',
	"highlight" => 'Integer',
	"plurality" => 'Float',
	"setcase" => 'Float',
	"identity" => 'Float',
	"consensus" => 'Switch',
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
	"refseq" => {
		"perl" => '($value && $value ne $vdef)? " -refseq=$value" : ""',
	},
	"bottom" => {
		"perl" => '($value)? "" : " -nobottom"',
	},
	"show" => {
		"perl" => '" -show=$value"',
	},
	"order" => {
		"perl" => '" -order=$value"',
	},
	"similarcase" => {
		"perl" => '($value)? "" : " -nosimilarcase"',
	},
	"matrix" => {
		"perl" => '($value)? " -matrix=$value" : ""',
	},
	"uppercase" => {
		"perl" => '($value)? " -uppercase=$value" : ""',
	},
	"number" => {
		"perl" => '($value)? "" : " -nonumber"',
	},
	"ruler" => {
		"perl" => '($value)? "" : " -noruler"',
	},
	"width" => {
		"perl" => '(defined $value && $value != $vdef)? " -width=$value" : ""',
	},
	"margin" => {
		"perl" => '(defined $value && $value != $vdef)? " -margin=$value" : ""',
	},
	"html" => {
		"perl" => '($value)? " -html" : ""',
	},
	"highlight" => {
		"perl" => '($value)? " -highlight=$value" : ""',
	},
	"plurality" => {
		"perl" => '(defined $value && $value != $vdef)? " -plurality=$value" : ""',
	},
	"setcase" => {
		"perl" => '(defined $value && $value != $vdef)? " -setcase=$value" : ""',
	},
	"identity" => {
		"perl" => '(defined $value && $value != $vdef)? " -identity=$value" : ""',
	},
	"consensus" => {
		"perl" => '($value)? "" : " -noconsensus"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"showalign" => {
		"perl" => '"showalign"',
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
	"refseq" => 2,
	"bottom" => 3,
	"show" => 4,
	"order" => 5,
	"similarcase" => 6,
	"matrix" => 7,
	"uppercase" => 8,
	"number" => 9,
	"ruler" => 10,
	"width" => 11,
	"margin" => 12,
	"html" => 13,
	"highlight" => 14,
	"plurality" => 15,
	"setcase" => 16,
	"identity" => 17,
	"consensus" => 18,
	"outfile" => 19,
	"auto" => 20,
	"showalign" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"showalign",
	"sequence",
	"refseq",
	"bottom",
	"show",
	"order",
	"similarcase",
	"matrix",
	"uppercase",
	"number",
	"ruler",
	"width",
	"margin",
	"html",
	"highlight",
	"plurality",
	"setcase",
	"identity",
	"consensus",
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
	"refseq" => 0,
	"bottom" => 0,
	"show" => 0,
	"order" => 0,
	"similarcase" => 0,
	"matrix" => 0,
	"uppercase" => 0,
	"number" => 0,
	"ruler" => 0,
	"width" => 0,
	"margin" => 0,
	"html" => 0,
	"highlight" => 0,
	"plurality" => 0,
	"setcase" => 0,
	"identity" => 0,
	"consensus" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"showalign" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"refseq" => 0,
	"bottom" => 0,
	"show" => 0,
	"order" => 0,
	"similarcase" => 0,
	"matrix" => 0,
	"uppercase" => 0,
	"number" => 0,
	"ruler" => 0,
	"width" => 0,
	"margin" => 0,
	"html" => 0,
	"highlight" => 0,
	"plurality" => 0,
	"setcase" => 0,
	"identity" => 0,
	"consensus" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"refseq" => 0,
	"bottom" => 0,
	"show" => 1,
	"order" => 1,
	"similarcase" => 0,
	"matrix" => 0,
	"uppercase" => 0,
	"number" => 0,
	"ruler" => 0,
	"width" => 0,
	"margin" => 0,
	"html" => 0,
	"highlight" => 0,
	"plurality" => 0,
	"setcase" => 0,
	"identity" => 0,
	"consensus" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- gapany [set of sequences] (-sequence)",
	"advanced" => "advanced Section",
	"refseq" => "The number or the name of the reference sequence (-refseq)",
	"bottom" => "Display the reference sequence at the bottom (-bottom)",
	"show" => "What to show -- What to show (-show)",
	"order" => "Output order of the sequences -- Output order of the sequences (-order)",
	"similarcase" => "Show similar residues in lower-case (-similarcase)",
	"matrix" => "Similarity scoring Matrix file (-matrix)",
	"uppercase" => "Regions to put in uppercase (eg: 4-57,78-94) (-uppercase)",
	"number" => "Number the sequences (-number)",
	"ruler" => "Display ruler (-ruler)",
	"width" => "Width of sequence to display (-width)",
	"margin" => "Length of margin for sequence names (-margin)",
	"html" => "Use HTML formatting (-html)",
	"highlight" => "Regions to colour in HTML (eg: 4-57 red 78-94 green) (-highlight)",
	"plurality" => "Plurality check % for consensus (-plurality)",
	"setcase" => "Threshold above which the consensus is given in uppercase (-setcase)",
	"identity" => "Required % of identities at a position fro consensus (-identity)",
	"consensus" => "Display the consensus line (-consensus)",
	"output" => "output Section",
	"outfile" => "Output sequence details to a file (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"refseq" => 0,
	"bottom" => 0,
	"show" => 0,
	"order" => 0,
	"similarcase" => 0,
	"matrix" => 0,
	"uppercase" => 0,
	"number" => 0,
	"ruler" => 0,
	"width" => 0,
	"margin" => 0,
	"html" => 0,
	"highlight" => 0,
	"plurality" => 0,
	"setcase" => 0,
	"identity" => 0,
	"consensus" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['refseq','bottom','show','order','similarcase','matrix','uppercase','number','ruler','width','margin','html','highlight','plurality','setcase','identity','consensus',],
	"show" => ['A','All of the sequences','I','Identities between the sequences','N','Non-identities between the sequences','S','Similarities between the sequences','D','Dissimilarities between the sequences',],
	"order" => ['I','Input order - no change','A','Alphabetical order of the names','S','Similarity to the reference sequence',],
	"matrix" => ['I','','A','','S','',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"refseq" => '0',
	"bottom" => '1',
	"show" => 'N',
	"order" => 'I',
	"similarcase" => '1',
	"number" => '1',
	"ruler" => '1',
	"width" => '60',
	"margin" => '-1',
	"html" => '0',
	"plurality" => '50.0',
	"setcase" => '0',
	"identity" => '0.0',
	"consensus" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"refseq" => { "perl" => '1' },
	"bottom" => { "perl" => '1' },
	"show" => { "perl" => '1' },
	"order" => { "perl" => '1' },
	"similarcase" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"uppercase" => { "perl" => '1' },
	"number" => { "perl" => '1' },
	"ruler" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"margin" => { "perl" => '1' },
	"html" => { "perl" => '1' },
	"highlight" => { "perl" => '1' },
	"plurality" => { "perl" => '1' },
	"setcase" => { "perl" => '1' },
	"identity" => { "perl" => '1' },
	"consensus" => { "perl" => '1' },
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
	"refseq" => 0,
	"bottom" => 0,
	"show" => 0,
	"order" => 0,
	"similarcase" => 0,
	"matrix" => 0,
	"uppercase" => 0,
	"number" => 0,
	"ruler" => 0,
	"width" => 0,
	"margin" => 0,
	"html" => 0,
	"highlight" => 0,
	"plurality" => 0,
	"setcase" => 0,
	"identity" => 0,
	"consensus" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"refseq" => 0,
	"bottom" => 0,
	"show" => 1,
	"order" => 1,
	"similarcase" => 0,
	"matrix" => 0,
	"uppercase" => 0,
	"number" => 0,
	"ruler" => 0,
	"width" => 0,
	"margin" => 0,
	"html" => 0,
	"highlight" => 0,
	"plurality" => 0,
	"setcase" => 0,
	"identity" => 0,
	"consensus" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"sequence" => [
		"The sequence alignment to be displayed.",
	],
	"refseq" => [
		"If you give the number in the alignment or the name of a sequence, it will be taken to be the reference sequence. The reference sequence is always show in full and is the one against which all the other sequences are compared. If this is set to 0 then the consensus sequence will be used as the reference sequence. By default the consensus sequence is used as the reference sequence.",
	],
	"bottom" => [
		"If this is true then the refernce sequence is displayed at the bottom of the alignment as well as at the top.",
	],
	"similarcase" => [
		"If this is set True, then when -show is set to \'Similarities\' or \'Non-identities\' and a residue is similar but not identical to the reference sequence residue, it will be changed to lower-case. If -show is set to \'All\' then non-identical, non-similar residues will be changed to lower-case. If this is False then no change to the case of the residues is made on the basis of their similarity to the reference sequence.",
	],
	"matrix" => [
		"This is the scoring matrix file used when comparing sequences.  By default it is the file \'EBLOSUM62\' (for proteins) or the file \'EDNAFULL\' (for nucleic sequences).  These files are found in the \'data\' directory of the EMBOSS installation.",
	],
	"uppercase" => [
		"Regions to put in uppercase. <BR> If this is left blank, then the sequence case is left alone. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are separated by any non-digit, non-alpha character. <BR> Examples of region specifications are: <BR> 24-45, 56-78 <BR> 1:45, 67=99;765..888 <BR> 1,5,8,10,23,45,57,99",
	],
	"number" => [
		"If this option is true then a line giving the positions in the alignment is displayed every 10 characters above the alignment.",
	],
	"ruler" => [
		"If this option is true then a ruler line marking every 5th and 10th character in the alignment is displayed.",
	],
	"margin" => [
		"This sets the length of the left-hand margin for sequence names. If the margin is set at 0 then no margin and no names are displayed. If the margin is set to a value that is less than the length of a sequence name then the sequence name is displayed truncated to the length of the margin. If the margin is set to -1 then the minimum margin width that will allow all the sequence names to be displayed in full plus a space at the end of the name will automatically be selected.",
	],
	"highlight" => [
		"Regions to colour if formatting for HTML. <BR> If this is left blank, then the sequence is left alone. <BR> A set of regions is specified by a set of pairs of positions. <BR> The positions are integers. <BR> They are followed by any valid HTML font colour. <BR> Examples of region specifications are: <BR> 24-45 blue 56-78 orange <BR> 1-100 green 120-156 red <BR> A file of ranges to colour (one range per line) can be specified as \'\@filename\'.",
	],
	"plurality" => [
		"Set a cut-off for the % of positive scoring matches below which there is no consensus. The default plurality is taken as 50% of the total weight of all the sequences in the alignment.",
	],
	"setcase" => [
		"Sets the threshold for the scores of the positive matches above which the consensus is is upper-case and below which the consensus is in lower-case.",
	],
	"identity" => [
		"Provides the facility of setting the required number of identities at a position for it to give a consensus. Therefore, if this is set to 100% only columns of identities contribute to the consensus.",
	],
	"consensus" => [
		"If this is true then the consensus line is displayed at the bottom.",
	],
	"outfile" => [
		"If you enter the name of a file here then this program will write the sequence details into that file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/showalign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

