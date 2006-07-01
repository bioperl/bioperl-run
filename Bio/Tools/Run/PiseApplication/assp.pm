# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::assp
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::assp

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::assp

      Bioperl class for:

	ASSP	Accuracy of Secondary Structure Prediction (Russell, Barton)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/assp.html 
         for available values):


		assp (String)

		aligfile (InFile)
			Alignement File (in BLOCK format)

		clus2blc (Switch)
			Convert CLUSTAL NBRF-PIR format to AMPS Blockfile format

		nbrf_file (String)

		showpar (Switch)
			show all the parameters for the current run.

		quiet (Switch)
			avoid all output in the program except for errors and a final lower limit for Q3

		matrix (InFile)
			-m property type matrix file name

		subsize (Integer)
			-s length of sequence used to determine poor alignment

		maxalig (Integer)
			-l maximum number of sub-alignments to be considered

		minprop (Integer)
			-p minimum number or properties shared to define conservation

		window (Integer)
			-w window length for conservation definition

		ignseq (Integer)
			-i fraction of sequences that may be ignored

		mingap (Integer)
			-g minimum number of gaps allowed

		seqomit (String)
			-o Seq. to be omitted 1 Seq. to be omitted 2 ...

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

http://bioweb.pasteur.fr/seqanal/interfaces/assp.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::assp;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $assp = Bio::Tools::Run::PiseApplication::assp->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::assp object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $assp = $factory->program('assp');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::assp.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/assp.pm

    $self->{COMMAND}   = "assp";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ASSP";

    $self->{DESCRIPTION}   = "Accuracy of Secondary Structure Prediction";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Russell, Barton";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"assp",
	"aligfile",
	"clus2blc",
	"nbrf_file",
	"output",
	"others",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"assp",
	"aligfile", 	# Alignement File (in BLOCK format)
	"clus2blc", 	# Convert CLUSTAL NBRF-PIR format to AMPS Blockfile format
	"nbrf_file",
	"output", 	# Output parameters
	"showpar", 	# show all the parameters for the current run.
	"quiet", 	# avoid all output in the program except for errors and a final lower limit for Q3
	"others", 	# Others parameters
	"matrix", 	# -m property type matrix file name
	"subsize", 	# -s length of sequence used to determine poor alignment
	"maxalig", 	# -l maximum number of sub-alignments to be considered
	"minprop", 	# -p minimum number or properties shared to define conservation
	"window", 	# -w window length for conservation definition
	"ignseq", 	# -i fraction of sequences that may be ignored
	"mingap", 	# -g minimum number of gaps allowed
	"seqomit", 	# -o Seq. to be omitted 1 Seq. to be omitted 2 ...

    ];

    $self->{TYPE}  = {
	"assp" => 'String',
	"aligfile" => 'InFile',
	"clus2blc" => 'Switch',
	"nbrf_file" => 'String',
	"output" => 'Paragraph',
	"showpar" => 'Switch',
	"quiet" => 'Switch',
	"others" => 'Paragraph',
	"matrix" => 'InFile',
	"subsize" => 'Integer',
	"maxalig" => 'Integer',
	"minprop" => 'Integer',
	"window" => 'Integer',
	"ignseq" => 'Integer',
	"mingap" => 'Integer',
	"seqomit" => 'String',

    };

    $self->{FORMAT}  = {
	"assp" => {
		"seqlab" => 'assp',
		"perl" => '"assp"',
	},
	"aligfile" => {
		"perl" => '($clus2blc)? " -f $value.blc" : " -f $value"',
	},
	"clus2blc" => {
		"perl" => '($value)? "clus2blc < clus2blc.params ; " : "" ',
	},
	"nbrf_file" => {
		"perl" => '"$aligfile\\n$aligfile.blc\\n"',
	},
	"output" => {
	},
	"showpar" => {
		"perl" => '($value)? " -P":""',
	},
	"quiet" => {
		"perl" => '($value)? " -q":""',
	},
	"others" => {
	},
	"matrix" => {
		"perl" => '($value)? " -m $value" : ""',
	},
	"subsize" => {
		"perl" => '(defined $value && $value != $vdef)? " -s $value":""',
	},
	"maxalig" => {
		"perl" => '(defined $value && $value != $vdef)? " -l $value":""',
	},
	"minprop" => {
		"perl" => '(defined $value && $value != $vdef)? " -p $value":""',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -w $value":""',
	},
	"ignseq" => {
		"perl" => '(defined $value && $value != $vdef)? " -i $value":""',
	},
	"mingap" => {
		"perl" => '(defined $value && $value != $vdef)? " -g $value":""',
	},
	"seqomit" => {
		"perl" => '($value)? " -o $value" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"assp" => 0,
	"aligfile" => 1,
	"clus2blc" => -1,
	"showpar" => 1,
	"quiet" => 1,
	"matrix" => 1,
	"subsize" => 1,
	"maxalig" => 1,
	"minprop" => 1,
	"window" => 1,
	"ignseq" => 1,
	"mingap" => 1,
	"seqomit" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"clus2blc",
	"assp",
	"others",
	"nbrf_file",
	"output",
	"aligfile",
	"showpar",
	"quiet",
	"matrix",
	"subsize",
	"maxalig",
	"minprop",
	"window",
	"ignseq",
	"mingap",
	"seqomit",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"assp" => 1,
	"aligfile" => 0,
	"clus2blc" => 0,
	"nbrf_file" => 1,
	"output" => 0,
	"showpar" => 0,
	"quiet" => 0,
	"others" => 0,
	"matrix" => 0,
	"subsize" => 0,
	"maxalig" => 0,
	"minprop" => 0,
	"window" => 0,
	"ignseq" => 0,
	"mingap" => 0,
	"seqomit" => 0,

    };

    $self->{ISCOMMAND}  = {
	"assp" => 1,
	"aligfile" => 0,
	"clus2blc" => 0,
	"nbrf_file" => 0,
	"output" => 0,
	"showpar" => 0,
	"quiet" => 0,
	"others" => 0,
	"matrix" => 0,
	"subsize" => 0,
	"maxalig" => 0,
	"minprop" => 0,
	"window" => 0,
	"ignseq" => 0,
	"mingap" => 0,
	"seqomit" => 0,

    };

    $self->{ISMANDATORY}  = {
	"assp" => 0,
	"aligfile" => 1,
	"clus2blc" => 0,
	"nbrf_file" => 0,
	"output" => 0,
	"showpar" => 0,
	"quiet" => 0,
	"others" => 0,
	"matrix" => 0,
	"subsize" => 0,
	"maxalig" => 0,
	"minprop" => 0,
	"window" => 0,
	"ignseq" => 0,
	"mingap" => 0,
	"seqomit" => 0,

    };

    $self->{PROMPT}  = {
	"assp" => "",
	"aligfile" => "Alignement File (in BLOCK format)",
	"clus2blc" => "Convert CLUSTAL NBRF-PIR format to AMPS Blockfile format",
	"nbrf_file" => "",
	"output" => "Output parameters",
	"showpar" => "show all the parameters for the current run.",
	"quiet" => "avoid all output in the program except for errors and a final lower limit for Q3",
	"others" => "Others parameters",
	"matrix" => "-m property type matrix file name",
	"subsize" => "-s length of sequence used to determine poor alignment",
	"maxalig" => "-l maximum number of sub-alignments to be considered",
	"minprop" => "-p minimum number or properties shared to define conservation",
	"window" => "-w window length for conservation definition",
	"ignseq" => "-i fraction of sequences that may be ignored",
	"mingap" => "-g minimum number of gaps allowed",
	"seqomit" => "-o Seq. to be omitted 1 Seq. to be omitted 2 ...",

    };

    $self->{ISSTANDOUT}  = {
	"assp" => 0,
	"aligfile" => 0,
	"clus2blc" => 0,
	"nbrf_file" => 0,
	"output" => 0,
	"showpar" => 0,
	"quiet" => 0,
	"others" => 0,
	"matrix" => 0,
	"subsize" => 0,
	"maxalig" => 0,
	"minprop" => 0,
	"window" => 0,
	"ignseq" => 0,
	"mingap" => 0,
	"seqomit" => 0,

    };

    $self->{VLIST}  = {

	"output" => ['showpar','quiet',],
	"others" => ['matrix','subsize','maxalig','minprop','window','ignseq','mingap','seqomit',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"clus2blc" => '0',
	"showpar" => '0',
	"quiet" => '1',
	"subsize" => '5',
	"maxalig" => '400',
	"minprop" => '7',
	"window" => '1',
	"ignseq" => '0',
	"mingap" => '0',

    };

    $self->{PRECOND}  = {
	"assp" => { "perl" => '1' },
	"aligfile" => { "perl" => '1' },
	"clus2blc" => { "perl" => '1' },
	"nbrf_file" => {
		"perl" => '$clus2blc',
	},
	"output" => { "perl" => '1' },
	"showpar" => { "perl" => '1' },
	"quiet" => { "perl" => '1' },
	"others" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"subsize" => { "perl" => '1' },
	"maxalig" => { "perl" => '1' },
	"minprop" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"ignseq" => { "perl" => '1' },
	"mingap" => { "perl" => '1' },
	"seqomit" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

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
	"assp" => 0,
	"aligfile" => 0,
	"clus2blc" => 0,
	"nbrf_file" => 0,
	"output" => 0,
	"showpar" => 0,
	"quiet" => 0,
	"others" => 0,
	"matrix" => 0,
	"subsize" => 0,
	"maxalig" => 0,
	"minprop" => 0,
	"window" => 0,
	"ignseq" => 0,
	"mingap" => 0,
	"seqomit" => 0,

    };

    $self->{ISSIMPLE}  = {
	"assp" => 1,
	"aligfile" => 0,
	"clus2blc" => 0,
	"nbrf_file" => 0,
	"output" => 0,
	"showpar" => 0,
	"quiet" => 0,
	"others" => 0,
	"matrix" => 0,
	"subsize" => 0,
	"maxalig" => 0,
	"minprop" => 0,
	"window" => 0,
	"ignseq" => 0,
	"mingap" => 0,
	"seqomit" => 0,

    };

    $self->{PARAMFILE}  = {
	"nbrf_file" => "clus2blc.params",

    };

    $self->{COMMENT}  = {
	"aligfile" => [
		"You can use a CLUSTAL NBRF-PIR format file and convert it to Blockfile format (see next options).",
	],
	"matrix" => [
		"This specifies the property matrix to be used for the definition of conservation. The format of this matrix is:",
		"! *ILVCAGMFYWHKREQDNSTP BZX**",
		"! ",
		"1 111111111111000000101001 Hydrophobic :",
		"2 000000001111111111101111 Polar :",
		"3 001111000000000111111001 Small :",
		"4 000000000000000000011001 Proline :",
		"5 000000000011100000001001 Positive :",
		"6 000000000000010100001001 Negative : Comments here!",
		"7 000000000011110100001001 Charged :",
		"8 000011000000000001001001 Tiny :",
		"9 111000000000000000001001 Aliphatic :",
		"10 000000011110000000001001 Aromatic :",
		"The string between the asterix is the order in which amino acids are to be considered (\' \' denotes gap). The matrix of rows 1-10 contains 1s and 0s corresponding to whether each amino acid has a particular property. For example, Cysteine has the properties \'Hydrophobic\' and \'Small\'. It also has the \'anti-properties\' \'not-Polar\',\'not-Proline\', \'not-Positive\', etc.",
	],
	"maxalig" => [
		"This specifies the number of sub-alignments to be considered when calculating %C. If the possible number of sub-alignments (of the size specified with -s <N>) is less than or equal to this value, then all possible sub-alignments will be generated and considered for the calculation of %C. If the number of possible sub-alignments is greater than this number, than a random sample of alignments (i.e., this number) will be generated.",
	],
	"minprop" => [
		"This is the minimum number of properties to be shared at all positions within a sub-alignment to define a position as conserved. If you don\'t understand this, see the above paper, and references therein.",
	],
	"window" => [
		"It is sometimes desirable to consider only *runs* of conserved positions within an alignment (ie. runs of 3 or more). -w specifies the minimum run of conserved positions to be allowed. The default is 1 (ie. all conserved positions are used)",
	],
	"ignseq" => [
		"Errors in sequencing, and other problems sometimes make it desirable to ignore a certain fraction of residues. -f allows a user defined fraction of amino acids to be ignore in the calculation of %C. The default is 0. (ie. no amino acids are ignored)",
	],
	"mingap" => [
		"It is sometimes desirable to allow for gaps at conserved positions because of missing sequences, etc. This specifies the number of gaps tolerated at a position during the definition of conservation. The default is 0. (ie. no gaps are allowed)",
	],
	"seqomit" => [
		"Sometimes it is necessary to ignore particular sequences in the alignment. This option allows the user to specify sequences to be ignored by simply typing in their position in the block file (ie. all sequences considered to be numbered starting at 1). By default, no sequences are ignored, except for those sequences having identifiers ending in \'dssp\', \'define\', \'rk\', or \'str\', these being standard names for secondary structure strings (often showed beside alignments). Identifiers called \'space\' are also ignored.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/assp.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

