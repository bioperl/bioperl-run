# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::extractfeat
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::extractfeat

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::extractfeat

      Bioperl class for:

	EXTRACTFEAT	Extract features from a sequence (EMBOSS)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/extractfeat.html 
         for available values):


		extractfeat (String)

		init (String)

		sequence (Sequence)
			sequence -- any [sequences] (-sequence)
			pipe: seqsfile

		before (Integer)
			Amount of sequence before feature to extract (-before)

		after (Integer)
			Amount of sequence after feature to extract (-after)

		source (String)
			Source of feature to display (-source)

		type (String)
			Type of feature to extract (-type)

		sense (Integer)
			Sense of feature to extract (-sense)

		minscore (Float)
			Minimum score of feature to extract (-minscore)

		maxscore (Float)
			Maximum score of feature to extract (-maxscore)

		tag (String)
			Tag of feature to extract (-tag)

		value (String)
			Value of feature tags to extract (-value)

		join (Switch)
			Output introns etc. as one sequence (-join)

		featinname (Switch)
			Append type of feature to output sequence name (-featinname)

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

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

http://bioweb.pasteur.fr/seqanal/interfaces/extractfeat.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::extractfeat;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $extractfeat = Bio::Tools::Run::PiseApplication::extractfeat->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::extractfeat object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $extractfeat = $factory->program('extractfeat');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::extractfeat.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/extractfeat.pm

    $self->{COMMAND}   = "extractfeat";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "EXTRACTFEAT";

    $self->{DESCRIPTION}   = "Extract features from a sequence (EMBOSS)";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "edit",

         "feature tables",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/extractfeat.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"extractfeat",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"extractfeat",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- any [sequences] (-sequence)
	"advanced", 	# advanced Section
	"before", 	# Amount of sequence before feature to extract (-before)
	"after", 	# Amount of sequence after feature to extract (-after)
	"source", 	# Source of feature to display (-source)
	"type", 	# Type of feature to extract (-type)
	"sense", 	# Sense of feature to extract (-sense)
	"minscore", 	# Minimum score of feature to extract (-minscore)
	"maxscore", 	# Maximum score of feature to extract (-maxscore)
	"tag", 	# Tag of feature to extract (-tag)
	"value", 	# Value of feature tags to extract (-value)
	"output", 	# output Section
	"join", 	# Output introns etc. as one sequence (-join)
	"featinname", 	# Append type of feature to output sequence name (-featinname)
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"extractfeat" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"before" => 'Integer',
	"after" => 'Integer',
	"source" => 'String',
	"type" => 'String',
	"sense" => 'Integer',
	"minscore" => 'Float',
	"maxscore" => 'Float',
	"tag" => 'String',
	"value" => 'String',
	"output" => 'Paragraph',
	"join" => 'Switch',
	"featinname" => 'Switch',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value"',
	},
	"advanced" => {
	},
	"before" => {
		"perl" => '(defined $value && $value != $vdef)? " -before=$value" : ""',
	},
	"after" => {
		"perl" => '(defined $value && $value != $vdef)? " -after=$value" : ""',
	},
	"source" => {
		"perl" => '($value && $value =~ s/all/*/)? " -source=$value" : ""',
	},
	"type" => {
		"perl" => '($value && $value =~ s/all/*/)? " -type=$value" : ""',
	},
	"sense" => {
		"perl" => '(defined $value && $value != $vdef)? " -sense=$value" : ""',
	},
	"minscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -minscore=$value" : ""',
	},
	"maxscore" => {
		"perl" => '(defined $value && $value != $vdef)? " -maxscore=$value" : ""',
	},
	"tag" => {
		"perl" => '($value && $value =~ s/all/*/)? " -tag=$value" : ""',
	},
	"value" => {
		"perl" => '($value && $value =~ s/all/*/)? " -value=$value" : ""',
	},
	"output" => {
	},
	"join" => {
		"perl" => '($value)? " -join" : ""',
	},
	"featinname" => {
		"perl" => '($value)? " -featinname" : ""',
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"extractfeat" => {
		"perl" => '"extractfeat"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [2,4,14],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"before" => 2,
	"after" => 3,
	"source" => 4,
	"type" => 5,
	"sense" => 6,
	"minscore" => 7,
	"maxscore" => 8,
	"tag" => 9,
	"value" => 10,
	"join" => 11,
	"featinname" => 12,
	"outseq" => 13,
	"outseq_sformat" => 14,
	"auto" => 15,
	"extractfeat" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"extractfeat",
	"sequence",
	"before",
	"after",
	"source",
	"type",
	"sense",
	"minscore",
	"maxscore",
	"tag",
	"value",
	"join",
	"featinname",
	"outseq",
	"outseq_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"before" => 0,
	"after" => 0,
	"source" => 0,
	"type" => 0,
	"sense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"tag" => 0,
	"value" => 0,
	"output" => 0,
	"join" => 0,
	"featinname" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"extractfeat" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"before" => 0,
	"after" => 0,
	"source" => 0,
	"type" => 0,
	"sense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"tag" => 0,
	"value" => 0,
	"output" => 0,
	"join" => 0,
	"featinname" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"before" => 0,
	"after" => 0,
	"source" => 0,
	"type" => 0,
	"sense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"tag" => 0,
	"value" => 0,
	"output" => 0,
	"join" => 0,
	"featinname" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- any [sequences] (-sequence)",
	"advanced" => "advanced Section",
	"before" => "Amount of sequence before feature to extract (-before)",
	"after" => "Amount of sequence after feature to extract (-after)",
	"source" => "Source of feature to display (-source)",
	"type" => "Type of feature to extract (-type)",
	"sense" => "Sense of feature to extract (-sense)",
	"minscore" => "Minimum score of feature to extract (-minscore)",
	"maxscore" => "Maximum score of feature to extract (-maxscore)",
	"tag" => "Tag of feature to extract (-tag)",
	"value" => "Value of feature tags to extract (-value)",
	"output" => "output Section",
	"join" => "Output introns etc. as one sequence (-join)",
	"featinname" => "Append type of feature to output sequence name (-featinname)",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"before" => 0,
	"after" => 0,
	"source" => 0,
	"type" => 0,
	"sense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"tag" => 0,
	"value" => 0,
	"output" => 0,
	"join" => 0,
	"featinname" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['before','after','source','type','sense','minscore','maxscore','tag','value',],
	"output" => ['join','featinname','outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"before" => '0',
	"after" => '0',
	"source" => 'all',
	"type" => 'all',
	"sense" => '0',
	"minscore" => '0.0',
	"maxscore" => '0.0',
	"tag" => 'all',
	"value" => 'all',
	"join" => '0',
	"featinname" => '0',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"before" => { "perl" => '1' },
	"after" => { "perl" => '1' },
	"source" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"sense" => { "perl" => '1' },
	"minscore" => { "perl" => '1' },
	"maxscore" => { "perl" => '1' },
	"tag" => { "perl" => '1' },
	"value" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"join" => { "perl" => '1' },
	"featinname" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqfile",
	},

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
	"before" => 0,
	"after" => 0,
	"source" => 0,
	"type" => 0,
	"sense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"tag" => 0,
	"value" => 0,
	"output" => 0,
	"join" => 0,
	"featinname" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"before" => 0,
	"after" => 0,
	"source" => 0,
	"type" => 0,
	"sense" => 0,
	"minscore" => 0,
	"maxscore" => 0,
	"tag" => 0,
	"value" => 0,
	"output" => 0,
	"join" => 0,
	"featinname" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"before" => [
		"If this value is greater than 0 then that number of bases or residues before the feature are included in the extracted sequence. This allows you to get the context of the feature. If this value is negative then the start of the extracted sequence will be this number of bases/residues before the end of the feature. So a value of \'10\' will start the extraction 10 bases/residues before the start of the sequence, and a value of \'-10\' will start the extraction 10 bases/residues before the end of the feature. The output sequence will be padded with \'N\' or \'X\' characters if the sequence starts after the required start of the extraction.",
	],
	"after" => [
		"If this value is greater than 0 then that number of bases or residues after the feature are included in the extracted sequence. This allows you to get the context of the feature. If this value is negative then the end of the extracted sequence will be this number of bases/residues after the start of the feature. So a value of \'10\' will end the extraction 10 bases/residues after the end of the sequence, and a value of \'-10\' will end the extraction 10 bases/residues after the start of the feature. The output sequence will be padded with \'N\' or \'X\' characters if the sequence ends before the required end of the extraction.",
	],
	"source" => [
		"By default any feature source in the feature table is shown. You can se t this to match any feature source you wish to show. <BR> The source name is usuall y either the name of the program that detected the feature or it is the feature table (eg: EMBL) that the feature came from. <BR> The source may be wildcarded by u sing \'*\'. <BR> If you wish to show more than one source, separate their names with the character \'|\', eg: <BR> gene* | embl",
	],
	"type" => [
		"By default every feature in the feature table is extracted. You can set this to be any feature type you wish to extract. <BR> See http://www3.ebi.ac.uk/Services/WebFeat/ for a list of the EMBL feature types and see Appendix A of the Swissprot user manual in http://www.expasy.ch/txt/userman.txt for a list of the Swissprot feature types. <BR> The type may be wildcarded by using \'*\'. <BR> If you wish to extract more than one type, separate their names with the character \'|\', eg: <BR> *UTR | intron",
	],
	"sense" => [
		"By default any feature type in the feature table is extracted. You can set this to match any feature sense you wish. 0 - any sense, 1 - forward sense, -1 - reverse sense",
	],
	"minscore" => [
		"If this is greater than or equal to the maximum score, then any score is permitted",
	],
	"maxscore" => [
		"If this is less than or equal to the maximum score, then any score is permitted",
	],
	"tag" => [
		"Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Some of these tags also have values, for example \'/gene\' can have the value of the gene name. <BR> By default any feature tag in the feature table is extracted. You can set this to match any feature tag you wish to show. <BR> The tag may be wildcarded by using \'*\'. <BR> If you wish to extract more than one tag, separate their names with the character \'|\', eg: <BR> gene | label",
	],
	"value" => [
		"Tag values are the values associated with a feature tag. Tags are the types of extra values that a feature may have. For example in the EMBL feature table, a \'CDS\' type of feature may have the tags \'/codon\', \'/codon_start\', \'/db_xref\', \'/EC_number\', \'/evidence\', \'/exception\', \'/function\', \'/gene\', \'/label\', \'/map\', \'/note\', \'/number\', \'/partial\', \'/product\', \'/protein_id\', \'/pseudo\', \'/standard_name\', \'/translation\', \'/transl_except\', \'/transl_table\', or \'/usedin\'. Only some of these tags can have values, for example \'/gene\' can have the value of the gene name. By default any feature tag value in the feature table is shown. You can set this to match any feature tag valueyou wish to show. <BR> The tag value may be wildcarded by using \'*\'. <BR> If you wish to show more than one tag value, separate their names with a space or the character \'|\', eg: <BR> pax* | 10",
	],
	"join" => [
		"Some features, such as CDS (coding sequence) and mRNA are composed of introns concatenated together.  There may be other forms of \'joined\' sequence, depending on the feature table.  If this option is set TRUE, then any group of these features will be output as a single sequence.  If the \'before\' and \'after\' qualifiers have been set, then only the sequence before the first feature and after the last feature are added.",
	],
	"featinname" => [
		"To aid you in identifying the type of feature that has been output, the type of feature is added to the start of the description of the output sequence.  Sometimes the description of a sequence is lost in subsequent processing of the sequences file, so it is useful for the type to be a part of the sequence ID name.  If you set this to be TRUE then the name is added to the ID name of the output sequence.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/extractfeat.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

