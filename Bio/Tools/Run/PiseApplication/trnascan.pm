# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::trnascan
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::trnascan

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::trnascan

      Bioperl class for:

	tRNAscan-SE	detection of transfer RNA genes (T. Lowe, S. Eddy)

	References:

		Fichant, G.A. and Burks, C. (1991) Identifying potential tRNA genes in genomic DNA sequences, J. Mol. Biol., 220, 659-671.

		Eddy, S.R. and Durbin, R. (1994) RNA sequence analysis using covariance models, Nucl. Acids Res., 22, 2079-2088.

		Pavesi, A., Conterio, F., Bolchi, A., Dieci, G., Ottonello, S. (1994) Identification of new eukaryotic tRNA genes in genomic DNA databases by a multistep weight matrix analysis of trnascriptional control regions, Nucl. Acids Res., 22, 1247-1256.

		Lowe, T.M. and Eddy, S.R. (1997) tRNAscan-SE: A program for improved detection of transfer RNA genes in genomic sequence, Nucl. Acids Res., 25, 955-964.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/trnascan.html 
         for available values):


		trnascan (String)

		sequence (Sequence)
			Sequence File

		prokaryotic (Switch)
			Improve detection of prokaryotic tRNAs (-P)

		archeal (Switch)
			Select archeal-specific covariance model (-A)

		organellar (Switch)
			Bypasses the fast first-pass scanners that are poor at detecting organellar tRNAs (-O)

		general (Switch)
			general covariance model trained on all three phylogenetic domains (-G)

		cove_only (Switch)
			Analyze sequences using Cove only (-C)

		trnascan_only (Switch)
			Use tRNAscan only to analyze sequences (-T)

		eufindtrna_only (Switch)
			Use EufindtRNA only to search for tRNAs (-E)

		trnascan_mode (Excl)
			Strict or relaxed tRNAscan mode (-t)

		eufindtrna_mode (Excl)
			EufindtRNA mode (-e)

		matching (String)
			Search only sequences with names matching this string (-n)

		start (String)
			Start search at first sequence with name matching this string (-s)

		genetic (Excl)
			Genetic code (-g)

		disable_checking (Switch)
			Manually disable checking tRNAs for poor primary or secondary structure scores often indicative of eukaryotic pseudogenes (-D)

		add_to_both_ends (Integer)
			Number of nucleotids to add to both ends during first-pass (-B

		cutoff (Integer)
			Cove cutoff score for reporting tRNAs (-X)

		length (Integer)
			Max length of tRNA intron+variable region (-L)

		previous_first_pass_result (InFile)
			Use a previous first pass result tabular file (-u)

		statistics (Switch)
			Save statistics summary for run (-m)

		secondary_structure (Switch)
			Save secondary structure results file (-f)

		save_first_pass (Switch)
			Save first pass results (-r)

		false_positives (Switch)
			Save false positives (-F)

		progress (Switch)
			Display program progress (-d)

		brief (Switch)
			Use brief output format (-b)

		quiet (Switch)
			Quiet mode (-q)

		acedb (Switch)
			Output final results in ACeDB format instead of the default tabular format (-a)

		trna_codon (Switch)
			Output a tRNA's corresponding codon in place of its anticodon (-N)

		scanners (Switch)
			Displays which of the first-pass scanners detected the tRNA being output (-y)

		unfinished_sequences (Switch)
			skip over N's in unfinished sequence (-i)

		breakdown (Switch)
			Display the breakdown of the two components of the bit score (-H)

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

http://bioweb.pasteur.fr/seqanal/interfaces/trnascan.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::trnascan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $trnascan = Bio::Tools::Run::PiseApplication::trnascan->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::trnascan object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $trnascan = $factory->program('trnascan');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::trnascan.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/trnascan.pm

    $self->{COMMAND}   = "trnascan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "tRNAscan-SE";

    $self->{DESCRIPTION}   = "detection of transfer RNA genes";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "T. Lowe, S. Eddy";

    $self->{REFERENCE}   = [

         "Fichant, G.A. and Burks, C. (1991) Identifying potential tRNA genes in genomic DNA sequences, J. Mol. Biol., 220, 659-671.",

         "Eddy, S.R. and Durbin, R. (1994) RNA sequence analysis using covariance models, Nucl. Acids Res., 22, 2079-2088.",

         "Pavesi, A., Conterio, F., Bolchi, A., Dieci, G., Ottonello, S. (1994) Identification of new eukaryotic tRNA genes in genomic DNA databases by a multistep weight matrix analysis of trnascriptional control regions, Nucl. Acids Res., 22, 1247-1256.",

         "Lowe, T.M. and Eddy, S.R. (1997) tRNAscan-SE: A program for improved detection of transfer RNA genes in genomic sequence, Nucl. Acids Res., 25, 955-964.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"trnascan",
	"sequence",
	"control_options",
	"output_options",
	"results",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"trnascan",
	"sequence", 	# Sequence File
	"control_options", 	# Control options
	"prokaryotic", 	# Improve detection of prokaryotic tRNAs (-P)
	"archeal", 	# Select archeal-specific covariance model (-A)
	"organellar", 	# Bypasses the fast first-pass scanners that are poor at detecting organellar tRNAs (-O)
	"general", 	# general covariance model trained on all three phylogenetic domains (-G)
	"cove_only", 	# Analyze sequences using Cove only (-C)
	"trnascan_only", 	# Use tRNAscan only to analyze sequences (-T)
	"eufindtrna_only", 	# Use EufindtRNA only to search for tRNAs (-E)
	"trnascan_mode", 	# Strict or relaxed tRNAscan mode (-t)
	"eufindtrna_mode", 	# EufindtRNA mode (-e)
	"matching", 	# Search only sequences with names matching this string (-n)
	"start", 	# Start search at first sequence with name matching this string (-s)
	"genetic", 	# Genetic code (-g)
	"disable_checking", 	# Manually disable checking tRNAs for poor primary or secondary structure scores often indicative of eukaryotic pseudogenes (-D)
	"add_to_both_ends", 	# Number of nucleotids to add to both ends during first-pass (-B
	"cutoff", 	# Cove cutoff score for reporting tRNAs (-X)
	"length", 	# Max length of tRNA intron+variable region (-L)
	"previous_first_pass_result", 	# Use a previous first pass result tabular file (-u)
	"output_options", 	# Output options
	"statistics", 	# Save statistics summary for run (-m)
	"secondary_structure", 	# Save secondary structure results file (-f)
	"save_first_pass", 	# Save first pass results (-r)
	"false_positives", 	# Save false positives (-F)
	"progress", 	# Display program progress (-d)
	"brief", 	# Use brief output format (-b)
	"quiet", 	# Quiet mode (-q)
	"acedb", 	# Output final results in ACeDB format instead of the default tabular format (-a)
	"trna_codon", 	# Output a tRNA's corresponding codon in place of its anticodon (-N)
	"scanners", 	# Displays which of the first-pass scanners detected the tRNA being output (-y)
	"unfinished_sequences", 	# skip over N's in unfinished sequence (-i)
	"breakdown", 	# Display the breakdown of the two components of the bit score (-H)
	"results",

    ];

    $self->{TYPE}  = {
	"trnascan" => 'String',
	"sequence" => 'Sequence',
	"control_options" => 'Paragraph',
	"prokaryotic" => 'Switch',
	"archeal" => 'Switch',
	"organellar" => 'Switch',
	"general" => 'Switch',
	"cove_only" => 'Switch',
	"trnascan_only" => 'Switch',
	"eufindtrna_only" => 'Switch',
	"trnascan_mode" => 'Excl',
	"eufindtrna_mode" => 'Excl',
	"matching" => 'String',
	"start" => 'String',
	"genetic" => 'Excl',
	"disable_checking" => 'Switch',
	"add_to_both_ends" => 'Integer',
	"cutoff" => 'Integer',
	"length" => 'Integer',
	"previous_first_pass_result" => 'InFile',
	"output_options" => 'Paragraph',
	"statistics" => 'Switch',
	"secondary_structure" => 'Switch',
	"save_first_pass" => 'Switch',
	"false_positives" => 'Switch',
	"progress" => 'Switch',
	"brief" => 'Switch',
	"quiet" => 'Switch',
	"acedb" => 'Switch',
	"trna_codon" => 'Switch',
	"scanners" => 'Switch',
	"unfinished_sequences" => 'Switch',
	"breakdown" => 'Switch',
	"results" => 'Results',

    };

    $self->{FORMAT}  = {
	"trnascan" => {
		"perl" => '"tRNAscan-SE"',
	},
	"sequence" => {
		"perl" => '" $value"',
	},
	"control_options" => {
	},
	"prokaryotic" => {
		"perl" => ' ($value)? " -P":""',
	},
	"archeal" => {
		"perl" => '($value) ? " -A" : ""',
	},
	"organellar" => {
		"perl" => ' ($value)? " -O":""',
	},
	"general" => {
		"perl" => '($value) ? " -G" : ""',
	},
	"cove_only" => {
		"perl" => ' ($value)? " -C":""',
	},
	"trnascan_only" => {
		"perl" => '($value)? " -T":""',
	},
	"eufindtrna_only" => {
		"perl" => '($value)? " -E":""',
	},
	"trnascan_mode" => {
		"perl" => '($value && $value ne $vdef)? " -t $value":""',
	},
	"eufindtrna_mode" => {
		"perl" => '($value)? " -e $value":""',
	},
	"matching" => {
		"perl" => ' ($value)? " -n $value":""',
	},
	"start" => {
		"perl" => ' ($value)?" -s $value":""',
	},
	"genetic" => {
		"perl" => '($value ne $vdef)? " -g /local/gensoft/lib/tRNAscan-SE/$value":""',
	},
	"disable_checking" => {
		"perl" => ' ($value)? " -D":""',
	},
	"add_to_both_ends" => {
		"perl" => '(defined $value && $value != $vdef) ? " -B $value" : ""',
	},
	"cutoff" => {
		"perl" => '(defined $value && $value != $vdef)? " -X $value":""',
	},
	"length" => {
		"perl" => '($value)? " -L $value":""',
	},
	"previous_first_pass_result" => {
		"perl" => ' ($value)? " -u $value":""',
	},
	"output_options" => {
	},
	"statistics" => {
		"perl" => ' ($value)? " -m\\#":""',
	},
	"secondary_structure" => {
		"perl" => ' ($value)? " -f\\#":""',
	},
	"save_first_pass" => {
		"perl" => ' ($value)? " -r\\#":""',
	},
	"false_positives" => {
		"perl" => ' ($value)? " -F\\#":""',
	},
	"progress" => {
		"perl" => ' ($value)? " -d":""',
	},
	"brief" => {
		"perl" => ' ($value)? " -b":""',
	},
	"quiet" => {
		"perl" => ' ($value)? " -q":""',
	},
	"acedb" => {
		"perl" => ' ($value)? " -a":""',
	},
	"trna_codon" => {
		"perl" => ' ($value)? " -N":""',
	},
	"scanners" => {
		"perl" => '($value)? " -y":""',
	},
	"unfinished_sequences" => {
		"perl" => '($value) ? " -i" : ""',
	},
	"breakdown" => {
		"perl" => '($value) ? " -H" : ""',
	},
	"results" => {
	},

    };

    $self->{FILENAMES}  = {
	"results" => '*.stats *.log *.ss *.fpass.out *.fpos',

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"trnascan" => 0,
	"sequence" => 2,
	"control_options" => 1,
	"prokaryotic" => 1,
	"archeal" => 1,
	"organellar" => 1,
	"general" => 1,
	"cove_only" => 1,
	"trnascan_only" => 1,
	"eufindtrna_only" => 1,
	"trnascan_mode" => 1,
	"eufindtrna_mode" => 1,
	"matching" => 1,
	"start" => 1,
	"genetic" => 1,
	"disable_checking" => 1,
	"add_to_both_ends" => 1,
	"cutoff" => 1,
	"length" => 1,
	"previous_first_pass_result" => 1,
	"output_options" => 1,
	"statistics" => 1,
	"secondary_structure" => 1,
	"save_first_pass" => 1,
	"false_positives" => 1,
	"progress" => 1,
	"brief" => 1,
	"quiet" => 1,
	"acedb" => 1,
	"trna_codon" => 1,
	"scanners" => 1,
	"unfinished_sequences" => 1,
	"breakdown" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"trnascan",
	"results",
	"control_options",
	"prokaryotic",
	"archeal",
	"organellar",
	"general",
	"cove_only",
	"trnascan_only",
	"eufindtrna_only",
	"trnascan_mode",
	"eufindtrna_mode",
	"matching",
	"start",
	"genetic",
	"disable_checking",
	"add_to_both_ends",
	"cutoff",
	"length",
	"previous_first_pass_result",
	"output_options",
	"statistics",
	"secondary_structure",
	"save_first_pass",
	"false_positives",
	"progress",
	"brief",
	"quiet",
	"acedb",
	"trna_codon",
	"scanners",
	"unfinished_sequences",
	"breakdown",
	"sequence",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"trnascan" => 1,
	"sequence" => 0,
	"control_options" => 0,
	"prokaryotic" => 0,
	"archeal" => 0,
	"organellar" => 0,
	"general" => 0,
	"cove_only" => 0,
	"trnascan_only" => 0,
	"eufindtrna_only" => 0,
	"trnascan_mode" => 0,
	"eufindtrna_mode" => 0,
	"matching" => 0,
	"start" => 0,
	"genetic" => 0,
	"disable_checking" => 0,
	"add_to_both_ends" => 0,
	"cutoff" => 0,
	"length" => 0,
	"previous_first_pass_result" => 0,
	"output_options" => 0,
	"statistics" => 0,
	"secondary_structure" => 0,
	"save_first_pass" => 0,
	"false_positives" => 0,
	"progress" => 0,
	"brief" => 0,
	"quiet" => 0,
	"acedb" => 0,
	"trna_codon" => 0,
	"scanners" => 0,
	"unfinished_sequences" => 0,
	"breakdown" => 0,
	"results" => 0,

    };

    $self->{ISCOMMAND}  = {
	"trnascan" => 1,
	"sequence" => 0,
	"control_options" => 0,
	"prokaryotic" => 0,
	"archeal" => 0,
	"organellar" => 0,
	"general" => 0,
	"cove_only" => 0,
	"trnascan_only" => 0,
	"eufindtrna_only" => 0,
	"trnascan_mode" => 0,
	"eufindtrna_mode" => 0,
	"matching" => 0,
	"start" => 0,
	"genetic" => 0,
	"disable_checking" => 0,
	"add_to_both_ends" => 0,
	"cutoff" => 0,
	"length" => 0,
	"previous_first_pass_result" => 0,
	"output_options" => 0,
	"statistics" => 0,
	"secondary_structure" => 0,
	"save_first_pass" => 0,
	"false_positives" => 0,
	"progress" => 0,
	"brief" => 0,
	"quiet" => 0,
	"acedb" => 0,
	"trna_codon" => 0,
	"scanners" => 0,
	"unfinished_sequences" => 0,
	"breakdown" => 0,
	"results" => 0,

    };

    $self->{ISMANDATORY}  = {
	"trnascan" => 0,
	"sequence" => 1,
	"control_options" => 0,
	"prokaryotic" => 0,
	"archeal" => 0,
	"organellar" => 0,
	"general" => 0,
	"cove_only" => 0,
	"trnascan_only" => 0,
	"eufindtrna_only" => 0,
	"trnascan_mode" => 0,
	"eufindtrna_mode" => 0,
	"matching" => 0,
	"start" => 0,
	"genetic" => 0,
	"disable_checking" => 0,
	"add_to_both_ends" => 0,
	"cutoff" => 0,
	"length" => 0,
	"previous_first_pass_result" => 0,
	"output_options" => 0,
	"statistics" => 0,
	"secondary_structure" => 0,
	"save_first_pass" => 0,
	"false_positives" => 0,
	"progress" => 0,
	"brief" => 0,
	"quiet" => 0,
	"acedb" => 0,
	"trna_codon" => 0,
	"scanners" => 0,
	"unfinished_sequences" => 0,
	"breakdown" => 0,
	"results" => 0,

    };

    $self->{PROMPT}  = {
	"trnascan" => "",
	"sequence" => "Sequence File",
	"control_options" => "Control options",
	"prokaryotic" => "Improve detection of prokaryotic tRNAs (-P)",
	"archeal" => "Select archeal-specific covariance model (-A)",
	"organellar" => "Bypasses the fast first-pass scanners that are poor at detecting organellar tRNAs (-O)",
	"general" => "general covariance model trained on all three phylogenetic domains (-G)",
	"cove_only" => "Analyze sequences using Cove only (-C)",
	"trnascan_only" => "Use tRNAscan only to analyze sequences (-T)",
	"eufindtrna_only" => "Use EufindtRNA only to search for tRNAs (-E)",
	"trnascan_mode" => "Strict or relaxed tRNAscan mode (-t)",
	"eufindtrna_mode" => "EufindtRNA mode (-e)",
	"matching" => "Search only sequences with names matching this string (-n)",
	"start" => "Start search at first sequence with name matching this string (-s)",
	"genetic" => "Genetic code (-g)",
	"disable_checking" => "Manually disable checking tRNAs for poor primary or secondary structure scores often indicative of eukaryotic pseudogenes (-D)",
	"add_to_both_ends" => "Number of nucleotids to add to both ends during first-pass (-B",
	"cutoff" => "Cove cutoff score for reporting tRNAs (-X)",
	"length" => "Max length of tRNA intron+variable region (-L)",
	"previous_first_pass_result" => "Use a previous first pass result tabular file (-u)",
	"output_options" => "Output options",
	"statistics" => "Save statistics summary for run (-m)",
	"secondary_structure" => "Save secondary structure results file (-f)",
	"save_first_pass" => "Save first pass results (-r)",
	"false_positives" => "Save false positives (-F)",
	"progress" => "Display program progress (-d)",
	"brief" => "Use brief output format (-b)",
	"quiet" => "Quiet mode (-q)",
	"acedb" => "Output final results in ACeDB format instead of the default tabular format (-a)",
	"trna_codon" => "Output a tRNA's corresponding codon in place of its anticodon (-N)",
	"scanners" => "Displays which of the first-pass scanners detected the tRNA being output (-y)",
	"unfinished_sequences" => "skip over N's in unfinished sequence (-i)",
	"breakdown" => "Display the breakdown of the two components of the bit score (-H)",
	"results" => "",

    };

    $self->{ISSTANDOUT}  = {
	"trnascan" => 0,
	"sequence" => 0,
	"control_options" => 0,
	"prokaryotic" => 0,
	"archeal" => 0,
	"organellar" => 0,
	"general" => 0,
	"cove_only" => 0,
	"trnascan_only" => 0,
	"eufindtrna_only" => 0,
	"trnascan_mode" => 0,
	"eufindtrna_mode" => 0,
	"matching" => 0,
	"start" => 0,
	"genetic" => 0,
	"disable_checking" => 0,
	"add_to_both_ends" => 0,
	"cutoff" => 0,
	"length" => 0,
	"previous_first_pass_result" => 0,
	"output_options" => 0,
	"statistics" => 0,
	"secondary_structure" => 0,
	"save_first_pass" => 0,
	"false_positives" => 0,
	"progress" => 0,
	"brief" => 0,
	"quiet" => 0,
	"acedb" => 0,
	"trna_codon" => 0,
	"scanners" => 0,
	"unfinished_sequences" => 0,
	"breakdown" => 0,
	"results" => 0,

    };

    $self->{VLIST}  = {

	"control_options" => ['prokaryotic','archeal','organellar','general','cove_only','trnascan_only','eufindtrna_only','trnascan_mode','eufindtrna_mode','matching','start','genetic','disable_checking','add_to_both_ends','cutoff','length','previous_first_pass_result',],
	"trnascan_mode" => ['S','S: strict','R','R: relaxed',],
	"eufindtrna_mode" => ['S','S: strict','R','R: relaxed','N','N: normal',],
	"genetic" => ['Standard','Standard','gcode.cilnuc','Ciliate, Dasycladacean, & Hexamita Nuclear','gcode.echdmito','Echinoderm mitochondrial','gcode.invmito','Invertebrate mitochondrial','gcode.othmito','Mold, Protozoan, & Coelenterate mitochondrial','gcode.vertmito','Vertebrate mitochondrial','gcode.ystmito','Yeast mitochondrial',],
	"output_options" => ['statistics','secondary_structure','save_first_pass','false_positives','progress','brief','quiet','acedb','trna_codon','scanners','unfinished_sequences','breakdown',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"prokaryotic" => '0',
	"archeal" => '0',
	"organellar" => '0',
	"general" => '0',
	"cove_only" => '0',
	"trnascan_only" => '0',
	"eufindtrna_only" => '0',
	"trnascan_mode" => 'S',
	"genetic" => 'Standard',
	"disable_checking" => '0',
	"add_to_both_ends" => '7',
	"cutoff" => '20',
	"progress" => '0',
	"brief" => '0',
	"quiet" => '0',
	"acedb" => '0',
	"trna_codon" => '0',
	"scanners" => '0',
	"breakdown" => '0',

    };

    $self->{PRECOND}  = {
	"trnascan" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"prokaryotic" => { "perl" => '1' },
	"archeal" => { "perl" => '1' },
	"organellar" => { "perl" => '1' },
	"general" => { "perl" => '1' },
	"cove_only" => { "perl" => '1' },
	"trnascan_only" => { "perl" => '1' },
	"eufindtrna_only" => { "perl" => '1' },
	"trnascan_mode" => { "perl" => '1' },
	"eufindtrna_mode" => { "perl" => '1' },
	"matching" => { "perl" => '1' },
	"start" => { "perl" => '1' },
	"genetic" => {
		"perl" => ' (! ($trnascan_only || $eufindtrna_only)) ',
	},
	"disable_checking" => { "perl" => '1' },
	"add_to_both_ends" => { "perl" => '1' },
	"cutoff" => { "perl" => '1' },
	"length" => { "perl" => '1' },
	"previous_first_pass_result" => {
		"perl" => '! ($matching || $start)',
	},
	"output_options" => { "perl" => '1' },
	"statistics" => { "perl" => '1' },
	"secondary_structure" => { "perl" => '1' },
	"save_first_pass" => { "perl" => '1' },
	"false_positives" => { "perl" => '1' },
	"progress" => { "perl" => '1' },
	"brief" => { "perl" => '1' },
	"quiet" => { "perl" => '1' },
	"acedb" => { "perl" => '1' },
	"trna_codon" => { "perl" => '1' },
	"scanners" => { "perl" => '1' },
	"unfinished_sequences" => { "perl" => '1' },
	"breakdown" => { "perl" => '1' },
	"results" => { "perl" => '1' },

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
	"trnascan" => 0,
	"sequence" => 0,
	"control_options" => 0,
	"prokaryotic" => 0,
	"archeal" => 0,
	"organellar" => 0,
	"general" => 0,
	"cove_only" => 0,
	"trnascan_only" => 0,
	"eufindtrna_only" => 0,
	"trnascan_mode" => 0,
	"eufindtrna_mode" => 0,
	"matching" => 0,
	"start" => 0,
	"genetic" => 0,
	"disable_checking" => 0,
	"add_to_both_ends" => 0,
	"cutoff" => 0,
	"length" => 0,
	"previous_first_pass_result" => 0,
	"output_options" => 0,
	"statistics" => 0,
	"secondary_structure" => 0,
	"save_first_pass" => 0,
	"false_positives" => 0,
	"progress" => 0,
	"brief" => 0,
	"quiet" => 0,
	"acedb" => 0,
	"trna_codon" => 0,
	"scanners" => 0,
	"unfinished_sequences" => 0,
	"breakdown" => 0,
	"results" => 0,

    };

    $self->{ISSIMPLE}  = {
	"trnascan" => 0,
	"sequence" => 1,
	"control_options" => 0,
	"prokaryotic" => 0,
	"archeal" => 0,
	"organellar" => 0,
	"general" => 0,
	"cove_only" => 0,
	"trnascan_only" => 0,
	"eufindtrna_only" => 0,
	"trnascan_mode" => 0,
	"eufindtrna_mode" => 0,
	"matching" => 0,
	"start" => 0,
	"genetic" => 0,
	"disable_checking" => 0,
	"add_to_both_ends" => 0,
	"cutoff" => 0,
	"length" => 0,
	"previous_first_pass_result" => 0,
	"output_options" => 0,
	"statistics" => 0,
	"secondary_structure" => 0,
	"save_first_pass" => 0,
	"false_positives" => 0,
	"progress" => 0,
	"brief" => 0,
	"quiet" => 0,
	"acedb" => 0,
	"trna_codon" => 0,
	"scanners" => 0,
	"unfinished_sequences" => 0,
	"breakdown" => 0,
	"results" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"prokaryotic" => [
		"This parameter loosens the search parameters for EufindtRNA to improve detection of prokaryotic tRNAs. Use this option when scanning prokaryotic sequences or both eukaryotic and prokaryotic sequences in the same sequence file. This option also disables pseudogene checking automatically since criteria for pseudogene checking were developed for eukaryotic pseudogenes.",
		"Use of this mode with prokaryotic sequences will also improve bounds prediction of the 3\' end (the terminal CAA triplet).",
	],
	"archeal" => [
		"This option selects an archaeal-specific covariance model for tRNA analysis, as well as slightly loosening the EufindtRNA search cutoffs.",
	],
	"organellar" => [
		"This parameter bypasses the fast first-pass scanners that are poor at detecting organellar tRNAs and runs Cove analysis only. Since true organellar tRNAs have been found to have Cove scores between 15 and 20 bits, the search cutoff is lowered from 20 to 15 bits. Also, pseudogene checking is disabled since it is only applicable to eukaryotic cytoplasmic tRNA pseudogenes. Since Cove-only mode is used, searches will be very slow (see -C option below) relative to the default mode.",
	],
	"general" => [
		"This option selects the general tRNA covariance model that was trained on tRNAs from all three phylogenetic domains (archaea, bacteria, & eukarya). This mode can be used when analyzing a mixed collection of sequences from more than one phylogenetic domain, with only slight loss of sensitivity and selectivity.",
		"The original publication describing this program and tRNAscan-SE version 1.0 used this general tRNA model exclusively.  If you wish to compare scores to those found in the paper or scans using v1.0, use this option.  Use of this option is compatible with all other search mode options described in this section.",
	],
	"cove_only" => [
		"Directs tRNAscan-SE to analyze sequences using Cove analysis only. This option allows a slightly more sensitive search than the default tRNAscan + EufindtRNA -> Cove mode, but is much slower (by approx. 250 to 3,000 fold). Output format and other program defaults are otherwise identical to the normal analysis.",
	],
	"trnascan_only" => [
		"Directs tRNAscan-SE to use only tRNAscan to analyze sequences. This mode will default to using \'strict\' parameters with tRNAscan analysis (similar to tRNAscan version 1.3 operation). This mode of operation is faster (3-5 times faster than default mode analysis), but will result in approximately 0.2 to 0.6 false positive tRNAs per Mbp, decreased sensitivity, and less reliable prediction of anticodons, tRNA isotype, and introns.",
	],
	"eufindtrna_only" => [
		"Since Cove is not being used as a secondary filter to remove false positives, this run mode defaults to \'Normal\' parameters which more closely approximates the sensitivity and selectivity of the original algorithm describe by Pavesi and colleagues (see the option -e for a description of the various run modes).",
	],
	"trnascan_mode" => [
		"Relaxed parameters may give very slightly increased search sensitivity, but increase search time by 20-40 fold.",
	],
	"eufindtrna_mode" => [
		"Explicitly set EufindtRNA params, where <mode>= R, N, or S (relaxed, normal, or strict). The \'relaxed\' mode is used for EufindtRNA when using tRNAscan-SE in default mode. With relaxed parameters, tRNAs that lack pol III poly-T terminators are not penalized, increasing search sensitivity, but decreasing selectivity. When Cove analysis is being used as a secondary filter for false positives (as in tRNAscan-SE\'s default mode), overall selectivity is not decreased.",
		"Using \'normal\' parameters with EufindtRNA does incorporate a log odds score for the distance between the B box and the first poly-T terminator, but does not disqualify tRNAs that do not have a terminator signal within 60 nucleotides. This mode is used by default when Cove analysis is not being used as a secondary false positive filter.",
		"Using \'strict\' parameters with EufindtRNA also incorporates a log odds score for the distance between the B box and the first poly-T terminator, but _rejects_ tRNAs that do not have such a signal within 60 nucleotides of the end of the B box. This mode most closely approximates the originally published search algorithm (3); sensitivity is reduced relative to using \'relaxed\' and \'normal\' modes, but selectivity is increased which is important if no secondary filter, such as Cove analysis, is being used to remove false positives. This mode will miss most prokaryotic tRNAs since the poly-T terminator signal is a feature specific to eukaryotic tRNAs genes (always use \'relaxed\' mode for scanning prokaryotic sequences for tRNAs).",
	],
	"matching" => [
		"Search only sequences with names matching this string. Only those sequences with names (first non-white space word after \'>\' symbol on FASTA name/description line) matching this string are analyzed for tRNAs.",
	],
	"start" => [
		"Start search at first sequence with name matching <EXPR> string and continue to end of input sequence file(s). This may be useful for re-starting crashed/aborted runs at the point where the previous run stopped. (If same names for output file(s) are used, program will ask if files should be over-written or appended to -- choose append and run will successfully be restarted where it left off).",
	],
	"genetic" => [
		"This option does not have any effect when using the -T or -E options -- you must be running in default or Cove only analysis mode.",
	],
	"disable_checking" => [
		"This will slightly speed the program and may be necessary for non-eukaryotic sequences that are flagged as possible pseudogenes but are known to be functional tRNAs.",
	],
	"add_to_both_ends" => [
		"By default, tRNAscan-SE adds 7 nucleotides to both ends of tRNA predictions when first-pass tRNA predictions are passed to covariance model (CM) analysis.  CM analysis generally trims these bounds back down, but on occassion, allows prediction of an otherwise truncated first-pass tRNA prediction.",
	],
	"cutoff" => [
		"This option allows the user to specify a different Cove score threshold for reporting tRNAs. It is not recommended that novice users change this cutoff, as a lower cutoff score will increase the number of pseudogenes and other false positives found by tRNAscan-SE (especially when used with the \'Cove only\' scan mode). Conversely, a higher cutoff than 20.0 bits will likely cause true tRNAs to be missed by tRNAscan (numerous \'real\' tRNAs have been found just above the 20.0 cutoff). Knowledgable users may wish to experiment with this parameter to find very unusual tRNAs or pseudogenes beyond the normal range of detection with the preceding caveats in mind.",
	],
	"length" => [
		"Set max length of tRNA intron+variable region (default=116bp). The default maximum tRNA length for tRNAscan-SE is 192 bp, but this limit can be increased with this option to allow searches with no practical limit on tRNA length. In the first phase of tRNAscan-SE, EufindtRNA searches for A and B boxes of <length> maximum distance apart, and passes only the 5\' and 3\' tRNA ends to covariance model analysis for confirmation (removing the bulk of long intervening sequences). tRNAs containing group I and II introns have been detected by setting this parameter to over 800 bp. Caution: group I or II introns in tRNAs tend to occur in positions other than the canonical position of protein-spliced introns, so tRNAscan-SE mispredicts the intron bounds and anticodon sequence for these cases. tRNA bound predictions, however, have been found to be reliable in these same tRNAs.",
	],
	"previous_first_pass_result" => [
		"This option allows the user to re-generate results from regions identified to have tRNAs by a previous tRNAscan-SE run. Either a regular tabular result file, or output saved with the -r option may be used as the specified <file>. This option is particularly useful for generating either secondary structure output (-f option) or ACeDB output (-a option) without having to re-scan entire sequences. Alternatively, if the -r option is used to generate the previous results file, tRNAscan-SE will pick up at the stage of Cove-confirmation of tRNAs and output final tRNA predicitons as with a normal run.",
	],
	"statistics" => [
		"This option directs tRNAscan-SE to write a brief summary to a file which contains the run options selected as well as statistics on the number of tRNAs detected at each phase of the search, search speed, and other bits of information. See Manual documentation for explanation of each statistic.",
	],
	"secondary_structure" => [
		"Save final results and Cove tRNA secondary structure predictions. This output format makes visual inspection of individual tRNA predictions easier since the tRNA sequence is displayed along with the predicted tRNA base pairings.",
	],
	"save_first_pass" => [
		"Save tabular, formatted output results from tRNAscan and/or EufindtRNA first pass scans. The format is similar to the final tabular output format, except no Cove score is available at this point in the search (if EufindtRNA has detected the tRNA, the negative log likelihood score is given). Also, the sequence ID number and source sequence length appear in the columns where intron bounds are shown in final output. This option may be useful for examining false positive tRNAs predicted by first-pass scans that have been filtered out by Cove analysis.",
	],
	"false_positives" => [
		"Save first-pass candidate tRNAs that were then found to be false positives by Cove analysis. This option saves candidate tRNAs found by either tRNAscan and/or EufindtRNA that were then rejected by Cove analysis as being false positives. tRNAs are saved in the FASTA sequence format.",
	],
	"progress" => [
		"Messages indicating which phase of the tRNA search are printed to standard output. If final results are also being sent to standard output, some of these messages will be suppressed so as to not interrupt display of the results.",
	],
	"brief" => [
		"This eliminates column headers that appear by default when writing results in tabular output format. Useful if results are to be parsed or piped to another program.",
	],
	"quiet" => [
		"The credits & run option selections normally printed to standard error at the beginning of each run are suppressed.",
	],
	"scanners" => [
		"\'Ts\', \'Eu\', or \'Bo\' will appear in the last column of Tabular output, indicating that either tRNAscan 1.4, EufindtRNA, or both scanners detected the tRNA, respectively.",
	],
	"breakdown" => [
		"Since tRNA pseudogenes often have one very low component (good secondary structure but poor primary sequence similarity to the tRNA model, or vice versa), this information may be useful in deciding whether a low-scoring tRNA is likely to be a pseudogene.  The heuristic pseudogene detection filter uses this information to flag possible pseudogenes -- use this option to see why a hit is marked as a possible pseudogene.  The user may wish to examine score breakdowns from known tRNAs in the organism of interest to get a frame of reference.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/trnascan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

