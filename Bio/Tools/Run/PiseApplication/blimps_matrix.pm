# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::blimps_matrix
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::blimps_matrix

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::blimps_matrix

      Bioperl class for:

	BLIMPS	score a block or matrix against a database of sequences (Wallace & Henikoff)

	References:

		J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).

		Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/blimps_matrix.html 
         for available values):


		blimps_matrix (String)

		action (String)

		sequence_db (Excl)
			Sequences database

		block_file (InFile)
			Block file

		conversion (Excl)
			Conversion method for converting a block to a matrix

		matrix_file (InFile)
			A precomputed site specific scoring matrix file (instead of block file)

		genetic_code (Excl)
			The Genetic code to use (if DNA sequence or database)

		strands (Integer)
			The number of strands to search (if DNA sequence or database)

		outfile (OutFile)
			Output file filename

		error (Excl)
			Error level to report at

		export_matrix (OutFile)
			Export matrix (matricies) to this filename

		histogram (Switch)
			Print the histogram values in the output file

		scores (Integer)
			The number of scores to report.

		repeats (Switch)
			Repeats are allowed in the scoring list

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

http://bioweb.pasteur.fr/seqanal/interfaces/blimps_matrix.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::blimps_matrix;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $blimps_matrix = Bio::Tools::Run::PiseApplication::blimps_matrix->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::blimps_matrix object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $blimps_matrix = $factory->program('blimps_matrix');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::blimps_matrix.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blimps_matrix.pm

    $self->{COMMAND}   = "blimps_matrix";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLIMPS";

    $self->{DESCRIPTION}   = "score a block or matrix against a database of sequences";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Wallace & Henikoff";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-aa.html#BLIMPS";

    $self->{REFERENCE}   = [

         "J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).",

         "Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"blimps_matrix",
	"action",
	"sequence_db",
	"block_file",
	"control_parameters",
	"output_parameters",
	"config_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"blimps_matrix",
	"action",
	"sequence_db", 	# Sequences database
	"block_file", 	# Block file
	"control_parameters", 	# Blimps parameters
	"conversion", 	# Conversion method for converting a block to a matrix
	"matrix_file", 	# A precomputed site specific scoring matrix file (instead of block file)
	"genetic_code", 	# The Genetic code to use (if DNA sequence or database)
	"strands", 	# The number of strands to search (if DNA sequence or database)
	"output_parameters", 	# Output parameters
	"outfile", 	# Output file filename
	"error", 	# Error level to report at
	"export_matrix", 	# Export matrix (matricies) to this filename
	"histogram", 	# Print the histogram values in the output file
	"scores", 	# The number of scores to report.
	"repeats", 	# Repeats are allowed in the scoring list
	"config_file",

    ];

    $self->{TYPE}  = {
	"blimps_matrix" => 'String',
	"action" => 'String',
	"sequence_db" => 'Excl',
	"block_file" => 'InFile',
	"control_parameters" => 'Paragraph',
	"conversion" => 'Excl',
	"matrix_file" => 'InFile',
	"genetic_code" => 'Excl',
	"strands" => 'Integer',
	"output_parameters" => 'Paragraph',
	"outfile" => 'OutFile',
	"error" => 'Excl',
	"export_matrix" => 'OutFile',
	"histogram" => 'Switch',
	"scores" => 'Integer',
	"repeats" => 'Switch',
	"config_file" => 'Results',

    };

    $self->{FORMAT}  = {
	"blimps_matrix" => {
		"perl" => '"blimps blimps.cs"',
	},
	"action" => {
		"perl" => ' "SE	matrix\\n" ',
	},
	"sequence_db" => {
		"perl" => ' "DB	/local/gensoft/lib/blimps/db/fasta/$value\\n" ',
	},
	"block_file" => {
		"perl" => ' ($value eq "")? "" : "BL	$value\\n" ',
	},
	"control_parameters" => {
	},
	"conversion" => {
		"perl" => ' "CO	$value\\n" ',
	},
	"matrix_file" => {
		"perl" => '($value eq "")? "" : "MA	$value\\n" ',
	},
	"genetic_code" => {
		"perl" => '($value)? "GE	$value\\n" : "" ',
	},
	"strands" => {
		"perl" => '($value && $value != $vdef)? "ST	$value\\n" : ""',
	},
	"output_parameters" => {
	},
	"outfile" => {
		"perl" => '"OU	$value\\n" ',
	},
	"error" => {
		"perl" => '"ER	$value\\n"',
	},
	"export_matrix" => {
		"perl" => '($value eq "")? "" : "EX	$value\\n" ',
	},
	"histogram" => {
		"perl" => '(! $value)? "" : "HI	yes\\n" ',
	},
	"scores" => {
		"perl" => '(defined $value)? "NU	$value\\n" : "\\n" ',
	},
	"repeats" => {
		"perl" => '(! $value)? "RE	0\\n" : "" ',
	},
	"config_file" => {
	},

    };

    $self->{FILENAMES}  = {
	"config_file" => 'blimps.cs',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"blimps_matrix" => 0,
	"action" => 2,
	"control_parameters" => 4,
	"conversion" => 4,
	"matrix_file" => 4,
	"genetic_code" => 4,
	"strands" => 4,
	"output_parameters" => 5,
	"outfile" => 5,
	"error" => 1,
	"export_matrix" => 5,
	"histogram" => 5,
	"scores" => 5,
	"repeats" => 5,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"blimps_matrix",
	"sequence_db",
	"block_file",
	"config_file",
	"error",
	"action",
	"matrix_file",
	"genetic_code",
	"strands",
	"control_parameters",
	"conversion",
	"output_parameters",
	"export_matrix",
	"histogram",
	"scores",
	"repeats",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"blimps_matrix" => 1,
	"action" => 1,
	"sequence_db" => 0,
	"block_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"matrix_file" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"blimps_matrix" => 1,
	"action" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"matrix_file" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"blimps_matrix" => 0,
	"action" => 0,
	"sequence_db" => 1,
	"block_file" => 0,
	"control_parameters" => 0,
	"conversion" => 1,
	"matrix_file" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 1,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{PROMPT}  = {
	"blimps_matrix" => "",
	"action" => "",
	"sequence_db" => "Sequences database",
	"block_file" => "Block file",
	"control_parameters" => "Blimps parameters",
	"conversion" => "Conversion method for converting a block to a matrix",
	"matrix_file" => "A precomputed site specific scoring matrix file (instead of block file)",
	"genetic_code" => "The Genetic code to use (if DNA sequence or database)",
	"strands" => "The number of strands to search (if DNA sequence or database)",
	"output_parameters" => "Output parameters",
	"outfile" => "Output file filename",
	"error" => "Error level to report at",
	"export_matrix" => "Export matrix (matricies) to this filename",
	"histogram" => "Print the histogram values in the output file",
	"scores" => "The number of scores to report.",
	"repeats" => "Repeats are allowed in the scoring list",
	"config_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"blimps_matrix" => 0,
	"action" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"matrix_file" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{VLIST}  = {

	"sequence_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','sbase','sbase: annotated domains sequences','embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"control_parameters" => ['conversion','matrix_file','genetic_code','strands',],
	"conversion" => ['0','Clustering','1','patmat\'s method','2','Sequence weighing',],
	"genetic_code" => ['0','0 - Standard (default)','1','1 - Vertebrate Mitochondrial','2','2 - Yeast Mitochondrial','3','3 - Mold Mitochondrial and Mycoplasma','4','4 - Invertebrate Mitochondrial','5','5 - Ciliate Macronuclear','6','6 - Protozoan Mitochondrial','7','7 - Plant Mitochondrial','8','8 - Echinodermate Mitochondrial',],
	"output_parameters" => ['outfile','error','export_matrix','histogram','scores','repeats',],
	"error" => ['1','1 - info ','2','2 - warning','3','3 - serious','4','4 - program error','5','5 - fatal error',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"sequence_db" => 'swissprot',
	"conversion" => '2',
	"genetic_code" => '0',
	"strands" => '2',
	"outfile" => 'blimps.results',
	"error" => '2',
	"histogram" => '0',
	"scores" => '0',
	"repeats" => '1',

    };

    $self->{PRECOND}  = {
	"blimps_matrix" => { "perl" => '1' },
	"action" => { "perl" => '1' },
	"sequence_db" => { "perl" => '1' },
	"block_file" => { "perl" => '1' },
	"control_parameters" => { "perl" => '1' },
	"conversion" => {
		"perl" => '$block_file && (! $matrix_file)',
	},
	"matrix_file" => {
		"perl" => '( ! $block_file)',
	},
	"genetic_code" => { "perl" => '1' },
	"strands" => { "perl" => '1' },
	"output_parameters" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"error" => { "perl" => '1' },
	"export_matrix" => { "perl" => '1' },
	"histogram" => { "perl" => '1' },
	"scores" => { "perl" => '1' },
	"repeats" => { "perl" => '1' },
	"config_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"block_file" => {
		"perl" => {
			'$matrix_file && $block_file' => "only one of the block or the matrix files is required",
		},
	},
	"matrix_file" => {
		"perl" => {
			'$matrix_file && $block_file' => "only one of the block or the matrix files is required",
		},
	},
	"strands" => {
		"perl" => {
			'$value != 1 && $value != 2' => "values allowed: 1 or 2",
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
	"blimps_matrix" => 0,
	"action" => 0,
	"sequence_db" => 0,
	"block_file" => 0,
	"control_parameters" => 0,
	"conversion" => 0,
	"matrix_file" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"blimps_matrix" => 0,
	"action" => 0,
	"sequence_db" => 1,
	"block_file" => 1,
	"control_parameters" => 0,
	"conversion" => 0,
	"matrix_file" => 0,
	"genetic_code" => 0,
	"strands" => 0,
	"output_parameters" => 0,
	"outfile" => 0,
	"error" => 0,
	"export_matrix" => 0,
	"histogram" => 0,
	"scores" => 0,
	"repeats" => 0,
	"config_file" => 0,

    };

    $self->{PARAMFILE}  = {
	"action" => "blimps.cs",
	"sequence_db" => "blimps.cs",
	"block_file" => "blimps.cs",
	"conversion" => "blimps.cs",
	"matrix_file" => "blimps.cs",
	"genetic_code" => "blimps.cs",
	"strands" => "blimps.cs",
	"outfile" => "blimps.cs",
	"error" => "blimps.cs",
	"export_matrix" => "blimps.cs",
	"histogram" => "blimps.cs",
	"scores" => "blimps.cs",
	"repeats" => "blimps.cs",

    };

    $self->{COMMENT}  = {
	"block_file" => [
		"To score a block query against a database of sequences, specify the block file name and the sequence database name. The sequence database can be either a protein or DNA database. BLIMPS converts the query block to a position-specific scoring matrix and scores every possible alignment between it and every sequence in the database. If the database is DNA, alignments can be scored in all six translation frames or just the reading frames of the given strand.",
	],
	"conversion" => [
		"The field value is a number. The possible values so far are:",
		"0 - Clustering. Same as the original method, but cleaner and without the negative fields in the frequency file. It also does a weighted average of D & N to get B and of E & Q to get Z. If a B or Z is encountered, it is split between D & N or E & Q.",
		"1 - uses patmat\'s method, needs -1 and -2 in the frequency file - gets weird numbers due to division by zero if there are zeros in the frequency file.",
		"2 - Sequence weighing. The default. The same as clustering except that the weights of the sequences are taken explicitly from the given weights, rather than implicitly from the clustering.",
	],
	"matrix_file" => [
		"If you give a block file, Blimps converts it to a position-specific scoring matrix; but you can directly give a matrix file you have one (see conversion parameter).",
		"You can produce a matrix file by asking to export matricies to a file, only when action is to score a block query against a database of sequences (matrix).",
	],
	"strands" => [
		"If the query is DNA, alignments can be scored in all six translation frames or just the reading frames of the given strand.",
	],
	"error" => [
		"Errors of lesser value than the error level are not reported. The program will always handle a fatal error regardless of the error level setting.",
	],
	"scores" => [
		"A number less than zero means to report all the scores. A number of zero means to judge the number to report based on the query block or sequence. A number greater than zero is the number to actually report. The default value is zero.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/blimps_matrix.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

