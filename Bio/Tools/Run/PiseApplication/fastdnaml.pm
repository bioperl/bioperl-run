# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::fastdnaml
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::fastdnaml

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fastdnaml

      Bioperl class for:

	fastDNAml	construction of phylogenetic trees of DNA sequences using maximum likelihood (Olsen, Matsuda, Hagstrom, Overbeek)

	References:

		Olsen, G. J., Matsuda, H., Hagstrom, R., and Overbeek, R.  1994.  fastDNAml: A tool for construction of phylogenetic trees of DNA sequences using maximum likelihood.  Comput. Appl. Biosci. 10: 41-48.

		Felsenstein, J.  1981.  Evolutionary trees from DNA sequences:   A maximum likelihood approach.  J. Mol. Evol. 17: 368-376.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/fastdnaml.html 
         for available values):


		fastdnaml (String)

		clean_tmp (String)

		alignment (Sequence)
			Sequence Alignment File
			pipe: readseq_ok_alig

		frequencies (Switch)
			Instructs the program to use empirical base frequencies derived from the sequence data

		fA (Float)
			frequency of A (instead of empirical frequencies)

		fC (Float)
			frequency of C (instead of empirical frequencies)

		fG (Float)
			frequency of G (instead of empirical frequencies)

		fT (Float)
			frequency of T (instead of empirical frequencies)

		outgroup (Integer)
			Use the specified sequence number for the outgroup

		transition (Integer)
			ratio of transition to transversion type substitutions

		jumble (Switch)
			Randomize the sequence addition order (jumble)

		non_interleaved (Switch)
			Interleaved format

		bootstrap (Switch)
			generates a re-sample of the input data (bootstrap)

		nboots (Integer)
			how many samples

		bootstrap_seed (Integer)
			random number seed for bootstrap

		nbest (Integer)
			nbest: input order is jumbled (up to maxjumble times) until same tree is found n_best times

		maxjumble (Integer)
			maximum attempts at replicating inferred tree (max jumble)

		concat (String)

		in_file (String)

		outfile (OutFile)
			Output File

		treefile (Switch)
			Save tree in treefile

		printdata (Switch)
			Echo of the data in addition to the usual output (printdata)

		quickadd (Switch)
			Decreases the time in initially placing a new sequence in the growing tree (quickadd)

		global (Switch)
			global rearrangements

		final_arrgt (Integer)
			number of branches to cross in rearrangements of the completed tree

		partial_arrgt (Integer)
			number of branches to cross in testing rearrangements during the sequential addition phase of tree inference

		categories (InFile)
			categories file

		weights (InFile)
			weights file (user-specified column weighting information)

		weights_categories (InFile)
			Adds both the userweights and categories from a file

		user_tree (InFile)
			User tree - tree(s) file

		user_lengths (Switch)
			user trees to be read with branch lengths

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

http://bioweb.pasteur.fr/seqanal/interfaces/fastdnaml.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::fastdnaml;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fastdnaml = Bio::Tools::Run::PiseApplication::fastdnaml->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fastdnaml object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $fastdnaml = $factory->program('fastdnaml');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::fastdnaml.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fastdnaml.pm

    $self->{COMMAND}   = "fastdnaml";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "fastDNAml";

    $self->{DESCRIPTION}   = "construction of phylogenetic trees of DNA sequences using maximum likelihood";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Olsen, Matsuda, Hagstrom, Overbeek";

    $self->{REFERENCE}   = [

         "Olsen, G. J., Matsuda, H., Hagstrom, R., and Overbeek, R.  1994.  fastDNAml: A tool for construction of phylogenetic trees of DNA sequences using maximum likelihood.  Comput. Appl. Biosci. 10: 41-48.",

         "Felsenstein, J.  1981.  Evolutionary trees from DNA sequences:   A maximum likelihood approach.  J. Mol. Evol. 17: 368-376.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fastdnaml",
	"clean_tmp",
	"alignment",
	"inputopt",
	"bootopt",
	"concat",
	"in_file",
	"bootfiles",
	"outputopt",
	"tmpfiles",
	"tmpaligfiles",
	"arrgtopt",
	"categopt",
	"treeopt",
	"tree",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fastdnaml",
	"clean_tmp",
	"alignment", 	# Sequence Alignment File
	"inputopt", 	# Input Options
	"frequencies", 	# Instructs the program to use empirical base frequencies derived from the sequence data
	"fA", 	# frequency of A (instead of empirical frequencies)
	"fC", 	# frequency of C (instead of empirical frequencies)
	"fG", 	# frequency of G (instead of empirical frequencies)
	"fT", 	# frequency of T (instead of empirical frequencies)
	"outgroup", 	# Use the specified sequence number for the outgroup
	"transition", 	# ratio of transition to transversion type substitutions
	"jumble", 	# Randomize the sequence addition order (jumble)
	"non_interleaved", 	# Interleaved format
	"bootopt", 	# Bootstrap Options
	"bootstrap", 	# generates a re-sample of the input data (bootstrap)
	"nboots", 	# how many samples
	"bootstrap_seed", 	# random number seed for bootstrap
	"nbest", 	# nbest: input order is jumbled (up to maxjumble times) until same tree is found n_best times
	"maxjumble", 	# maximum attempts at replicating inferred tree (max jumble)
	"concat",
	"in_file",
	"bootfiles",
	"outputopt", 	# Output and Results Options
	"outfile", 	# Output File
	"treefile", 	# Save tree in treefile
	"printdata", 	# Echo of the data in addition to the usual output (printdata)
	"tmpfiles",
	"tmpaligfiles",
	"arrgtopt", 	# Rearrangements Options
	"quickadd", 	# Decreases the time in initially placing a new sequence in the growing tree (quickadd)
	"global", 	# global rearrangements
	"final_arrgt", 	# number of branches to cross in rearrangements of the completed tree
	"partial_arrgt", 	# number of branches to cross in testing rearrangements during the sequential addition phase of tree inference
	"categopt", 	# Categories and Weights Options
	"categories", 	# categories file
	"weights", 	# weights file (user-specified column weighting information)
	"weights_categories", 	# Adds both the userweights and categories from a file
	"treeopt", 	# User input Tree Options
	"user_tree", 	# User tree - tree(s) file
	"user_lengths", 	# user trees to be read with branch lengths
	"tree",

    ];

    $self->{TYPE}  = {
	"fastdnaml" => 'String',
	"clean_tmp" => 'String',
	"alignment" => 'Sequence',
	"inputopt" => 'Paragraph',
	"frequencies" => 'Switch',
	"fA" => 'Float',
	"fC" => 'Float',
	"fG" => 'Float',
	"fT" => 'Float',
	"outgroup" => 'Integer',
	"transition" => 'Integer',
	"jumble" => 'Switch',
	"non_interleaved" => 'Switch',
	"bootopt" => 'Paragraph',
	"bootstrap" => 'Switch',
	"nboots" => 'Integer',
	"bootstrap_seed" => 'Integer',
	"nbest" => 'Integer',
	"maxjumble" => 'Integer',
	"concat" => 'String',
	"in_file" => 'String',
	"bootfiles" => 'Results',
	"outputopt" => 'Paragraph',
	"outfile" => 'OutFile',
	"treefile" => 'Switch',
	"printdata" => 'Switch',
	"tmpfiles" => 'Results',
	"tmpaligfiles" => 'Results',
	"arrgtopt" => 'Paragraph',
	"quickadd" => 'Switch',
	"global" => 'Switch',
	"final_arrgt" => 'Integer',
	"partial_arrgt" => 'Integer',
	"categopt" => 'Paragraph',
	"categories" => 'InFile',
	"weights" => 'InFile',
	"weights_categories" => 'InFile',
	"treeopt" => 'Paragraph',
	"user_tree" => 'InFile',
	"user_lengths" => 'Switch',
	"tree" => 'Results',

    };

    $self->{FORMAT}  = {
	"fastdnaml" => {
		"perl" => '($bootstrap)? "cat > $alignment.tmp;" : "fastDNAml"',
	},
	"clean_tmp" => {
		"perl" => '"; clean_checkpoints"',
	},
	"alignment" => {
		"perl" => ' "cat $value | "',
	},
	"inputopt" => {
	},
	"frequencies" => {
		"perl" => '(! $value)? "frequencies $fA $fC $fG $fT | " : "" ',
	},
	"fA" => {
		"perl" => '""',
	},
	"fC" => {
		"perl" => '""',
	},
	"fG" => {
		"perl" => '""',
	},
	"fT" => {
		"perl" => '""',
	},
	"outgroup" => {
		"perl" => '($value)? "outgroup $value | " : "" ',
	},
	"transition" => {
		"perl" => '($value && $value!=$vdef)? "transition $value | " : "" ',
	},
	"jumble" => {
		"perl" => '($value)? "jumble | " : "" ',
	},
	"non_interleaved" => {
		"perl" => '($value)? "" : "non_interleaved | " ',
	},
	"bootopt" => {
	},
	"bootstrap" => {
		"perl" => '($value)? "fastDNAml_boot_web -out " : "" ',
	},
	"nboots" => {
		"perl" => '($value && $value != $vdef)? " -boots $value" : "" ',
	},
	"bootstrap_seed" => {
		"perl" => '($value)? " -seed $value" : ""',
	},
	"nbest" => {
		"perl" => '" $value"',
	},
	"maxjumble" => {
		"perl" => '($value)? " -max $value" : "" ',
	},
	"concat" => {
		"perl" => '" && (concattree $alignment.tree.tmp $alignment.out.tmp ; mv $alignment.tree.tmp $alignment.tree; mv $alignment.out.tmp $alignment.out) " ',
	},
	"in_file" => {
		"perl" => '" $alignment.tmp"',
	},
	"bootfiles" => {
	},
	"outputopt" => {
	},
	"outfile" => {
		"perl" => '($value && $value ne $vdef) ? " > $outfile" : ""',
	},
	"treefile" => {
		"perl" => '(!$value)? "treefile | " : "" ',
	},
	"printdata" => {
		"perl" => '($value)? "printdata | " : "" ',
	},
	"tmpfiles" => {
	},
	"tmpaligfiles" => {
	},
	"arrgtopt" => {
	},
	"quickadd" => {
		"perl" => '(! $value)? "quickadd | " : "" ',
	},
	"global" => {
		"perl" => '($value && (((defined $final_arrgt || defined $partial_arrgt) && ($trans_cmd = "transition $transition |")) || 1))? "$trans_cmd global $final_arrgt $partial_arrgt | " : "" ',
	},
	"final_arrgt" => {
		"perl" => '""',
	},
	"partial_arrgt" => {
		"perl" => '""',
	},
	"categopt" => {
	},
	"categories" => {
		"perl" => '($value)? "categories $value |" : "" ',
	},
	"weights" => {
		"perl" => '($value)? "weights $value |" : "" ',
	},
	"weights_categories" => {
		"perl" => '($value)? "weights_categories $value |" : "" ',
	},
	"treeopt" => {
	},
	"user_tree" => {
		"perl" => '($value && (! $user_lengths|| ($L="L") ))? "usertree $value $L|" : ""',
	},
	"user_lengths" => {
		"perl" => '""',
	},
	"tree" => {
	},

    };

    $self->{FILENAMES}  = {
	"bootfiles" => '*.tree *.out *.tmp',
	"tmpfiles" => 'treefile.*',
	"tmpaligfiles" => '"$alignment.tmp_*"',
	"tree" => '*tree*',

    };

    $self->{SEQFMT}  = {
	"alignment" => [12],

    };

    $self->{GROUP}  = {
	"fastdnaml" => 1000,
	"clean_tmp" => 1100,
	"alignment" => 1,
	"frequencies" => 2,
	"fA" => 1,
	"fC" => 1,
	"fG" => 1,
	"fT" => 1,
	"outgroup" => 2,
	"transition" => 2,
	"jumble" => 2,
	"non_interleaved" => 2,
	"bootstrap" => 1001,
	"nboots" => 1002,
	"bootstrap_seed" => 1002,
	"nbest" => 1004,
	"maxjumble" => 1002,
	"concat" => 1010,
	"in_file" => 1003,
	"outfile" => 1010,
	"treefile" => 2,
	"printdata" => 2,
	"quickadd" => 2,
	"global" => 3,
	"final_arrgt" => 2,
	"partial_arrgt" => 2,
	"categories" => 2,
	"weights" => 2,
	"weights_categories" => 2,
	"user_tree" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treeopt",
	"user_lengths",
	"bootopt",
	"inputopt",
	"tree",
	"outputopt",
	"bootfiles",
	"tmpfiles",
	"tmpaligfiles",
	"arrgtopt",
	"categopt",
	"fC",
	"fG",
	"alignment",
	"fT",
	"fA",
	"final_arrgt",
	"treefile",
	"frequencies",
	"outgroup",
	"transition",
	"jumble",
	"non_interleaved",
	"partial_arrgt",
	"printdata",
	"categories",
	"weights",
	"weights_categories",
	"quickadd",
	"user_tree",
	"global",
	"fastdnaml",
	"bootstrap",
	"maxjumble",
	"nboots",
	"bootstrap_seed",
	"in_file",
	"nbest",
	"concat",
	"outfile",
	"clean_tmp",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"fastdnaml" => 1,
	"clean_tmp" => 1,
	"alignment" => 0,
	"inputopt" => 0,
	"frequencies" => 0,
	"fA" => 0,
	"fC" => 0,
	"fG" => 0,
	"fT" => 0,
	"outgroup" => 0,
	"transition" => 0,
	"jumble" => 0,
	"non_interleaved" => 0,
	"bootopt" => 0,
	"bootstrap" => 0,
	"nboots" => 0,
	"bootstrap_seed" => 0,
	"nbest" => 0,
	"maxjumble" => 0,
	"concat" => 1,
	"in_file" => 1,
	"bootfiles" => 0,
	"outputopt" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"printdata" => 0,
	"tmpfiles" => 0,
	"tmpaligfiles" => 0,
	"arrgtopt" => 0,
	"quickadd" => 0,
	"global" => 0,
	"final_arrgt" => 0,
	"partial_arrgt" => 0,
	"categopt" => 0,
	"categories" => 0,
	"weights" => 0,
	"weights_categories" => 0,
	"treeopt" => 0,
	"user_tree" => 0,
	"user_lengths" => 0,
	"tree" => 0,

    };

    $self->{ISCOMMAND}  = {
	"fastdnaml" => 1,
	"clean_tmp" => 0,
	"alignment" => 0,
	"inputopt" => 0,
	"frequencies" => 0,
	"fA" => 0,
	"fC" => 0,
	"fG" => 0,
	"fT" => 0,
	"outgroup" => 0,
	"transition" => 0,
	"jumble" => 0,
	"non_interleaved" => 0,
	"bootopt" => 0,
	"bootstrap" => 0,
	"nboots" => 0,
	"bootstrap_seed" => 0,
	"nbest" => 0,
	"maxjumble" => 0,
	"concat" => 0,
	"in_file" => 0,
	"bootfiles" => 0,
	"outputopt" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"printdata" => 0,
	"tmpfiles" => 0,
	"tmpaligfiles" => 0,
	"arrgtopt" => 0,
	"quickadd" => 0,
	"global" => 0,
	"final_arrgt" => 0,
	"partial_arrgt" => 0,
	"categopt" => 0,
	"categories" => 0,
	"weights" => 0,
	"weights_categories" => 0,
	"treeopt" => 0,
	"user_tree" => 0,
	"user_lengths" => 0,
	"tree" => 0,

    };

    $self->{ISMANDATORY}  = {
	"fastdnaml" => 0,
	"clean_tmp" => 0,
	"alignment" => 1,
	"inputopt" => 0,
	"frequencies" => 0,
	"fA" => 1,
	"fC" => 1,
	"fG" => 1,
	"fT" => 1,
	"outgroup" => 0,
	"transition" => 0,
	"jumble" => 0,
	"non_interleaved" => 0,
	"bootopt" => 0,
	"bootstrap" => 0,
	"nboots" => 0,
	"bootstrap_seed" => 1,
	"nbest" => 1,
	"maxjumble" => 0,
	"concat" => 0,
	"in_file" => 0,
	"bootfiles" => 0,
	"outputopt" => 0,
	"outfile" => 1,
	"treefile" => 0,
	"printdata" => 0,
	"tmpfiles" => 0,
	"tmpaligfiles" => 0,
	"arrgtopt" => 0,
	"quickadd" => 0,
	"global" => 0,
	"final_arrgt" => 0,
	"partial_arrgt" => 0,
	"categopt" => 0,
	"categories" => 0,
	"weights" => 0,
	"weights_categories" => 0,
	"treeopt" => 0,
	"user_tree" => 0,
	"user_lengths" => 0,
	"tree" => 0,

    };

    $self->{PROMPT}  = {
	"fastdnaml" => "",
	"clean_tmp" => "",
	"alignment" => "Sequence Alignment File",
	"inputopt" => "Input Options",
	"frequencies" => "Instructs the program to use empirical base frequencies derived from the sequence data",
	"fA" => "frequency of A (instead of empirical frequencies)",
	"fC" => "frequency of C (instead of empirical frequencies)",
	"fG" => "frequency of G (instead of empirical frequencies)",
	"fT" => "frequency of T (instead of empirical frequencies)",
	"outgroup" => "Use the specified sequence number for the outgroup",
	"transition" => "ratio of transition to transversion type substitutions",
	"jumble" => "Randomize the sequence addition order (jumble)",
	"non_interleaved" => "Interleaved format",
	"bootopt" => "Bootstrap Options",
	"bootstrap" => "generates a re-sample of the input data (bootstrap)",
	"nboots" => "how many samples",
	"bootstrap_seed" => "random number seed for bootstrap",
	"nbest" => "nbest: input order is jumbled (up to maxjumble times) until same tree is found n_best times",
	"maxjumble" => "maximum attempts at replicating inferred tree (max jumble)",
	"concat" => "",
	"in_file" => "",
	"bootfiles" => "",
	"outputopt" => "Output and Results Options",
	"outfile" => "Output File",
	"treefile" => "Save tree in treefile",
	"printdata" => "Echo of the data in addition to the usual output (printdata)",
	"tmpfiles" => "",
	"tmpaligfiles" => "",
	"arrgtopt" => "Rearrangements Options",
	"quickadd" => "Decreases the time in initially placing a new sequence in the growing tree (quickadd)",
	"global" => "global rearrangements",
	"final_arrgt" => "number of branches to cross in rearrangements of the completed tree",
	"partial_arrgt" => "number of branches to cross in testing rearrangements during the sequential addition phase of tree inference",
	"categopt" => "Categories and Weights Options",
	"categories" => "categories file",
	"weights" => "weights file (user-specified column weighting information)",
	"weights_categories" => "Adds both the userweights and categories from a file",
	"treeopt" => "User input Tree Options",
	"user_tree" => "User tree - tree(s) file",
	"user_lengths" => "user trees to be read with branch lengths",
	"tree" => "",

    };

    $self->{ISSTANDOUT}  = {
	"fastdnaml" => 0,
	"clean_tmp" => 0,
	"alignment" => 0,
	"inputopt" => 0,
	"frequencies" => 0,
	"fA" => 0,
	"fC" => 0,
	"fG" => 0,
	"fT" => 0,
	"outgroup" => 0,
	"transition" => 0,
	"jumble" => 0,
	"non_interleaved" => 0,
	"bootopt" => 0,
	"bootstrap" => 0,
	"nboots" => 0,
	"bootstrap_seed" => 0,
	"nbest" => 0,
	"maxjumble" => 0,
	"concat" => 0,
	"in_file" => 0,
	"bootfiles" => 0,
	"outputopt" => 0,
	"outfile" => 1,
	"treefile" => 0,
	"printdata" => 0,
	"tmpfiles" => 0,
	"tmpaligfiles" => 0,
	"arrgtopt" => 0,
	"quickadd" => 0,
	"global" => 0,
	"final_arrgt" => 0,
	"partial_arrgt" => 0,
	"categopt" => 0,
	"categories" => 0,
	"weights" => 0,
	"weights_categories" => 0,
	"treeopt" => 0,
	"user_tree" => 0,
	"user_lengths" => 0,
	"tree" => 0,

    };

    $self->{VLIST}  = {

	"inputopt" => ['frequencies','fA','fC','fG','fT','outgroup','transition','jumble','non_interleaved',],
	"bootopt" => ['bootstrap','nboots','bootstrap_seed','nbest','maxjumble',],
	"outputopt" => ['outfile','treefile','printdata',],
	"arrgtopt" => ['quickadd','global','final_arrgt','partial_arrgt',],
	"categopt" => ['categories','weights','weights_categories',],
	"treeopt" => ['user_tree','user_lengths',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"frequencies" => '1',
	"fA" => '0.25',
	"fC" => '0.25',
	"fG" => '0.25',
	"fT" => '0.25',
	"transition" => '2.0',
	"non_interleaved" => '1',
	"nboots" => '1',
	"nbest" => '2',
	"maxjumble" => '10',
	"outfile" => 'fastdnaml.out',
	"treefile" => '1',
	"printdata" => '1',
	"quickadd" => '1',

    };

    $self->{PRECOND}  = {
	"fastdnaml" => { "perl" => '1' },
	"clean_tmp" => { "perl" => '1' },
	"alignment" => { "perl" => '1' },
	"inputopt" => { "perl" => '1' },
	"frequencies" => { "perl" => '1' },
	"fA" => {
		"perl" => '! $frequencies',
	},
	"fC" => {
		"perl" => '! $frequencies',
	},
	"fG" => {
		"perl" => '! $frequencies',
	},
	"fT" => {
		"perl" => '! $frequencies',
	},
	"outgroup" => { "perl" => '1' },
	"transition" => {
		"perl" => '! ($global && ($final_arrgt||$partial_arrgt))',
	},
	"jumble" => {
		"perl" => '! $bootstrap',
	},
	"non_interleaved" => { "perl" => '1' },
	"bootopt" => { "perl" => '1' },
	"bootstrap" => { "perl" => '1' },
	"nboots" => {
		"perl" => '$bootstrap',
	},
	"bootstrap_seed" => {
		"perl" => '$bootstrap',
	},
	"nbest" => {
		"perl" => '$bootstrap',
	},
	"maxjumble" => {
		"perl" => '$bootstrap',
	},
	"concat" => {
		"perl" => '$bootstrap',
	},
	"in_file" => {
		"perl" => '$bootstrap',
	},
	"bootfiles" => {
		"perl" => '$bootstrap',
	},
	"outputopt" => { "perl" => '1' },
	"outfile" => {
		"perl" => '! $bootstrap',
	},
	"treefile" => {
		"perl" => '! $bootstrap',
	},
	"printdata" => { "perl" => '1' },
	"tmpfiles" => { "perl" => '1' },
	"tmpaligfiles" => { "perl" => '1' },
	"arrgtopt" => { "perl" => '1' },
	"quickadd" => { "perl" => '1' },
	"global" => { "perl" => '1' },
	"final_arrgt" => { "perl" => '1' },
	"partial_arrgt" => { "perl" => '1' },
	"categopt" => { "perl" => '1' },
	"categories" => { "perl" => '1' },
	"weights" => { "perl" => '1' },
	"weights_categories" => { "perl" => '1' },
	"treeopt" => {
		"perl" => ' ! $bootstrap',
	},
	"user_tree" => {
		"perl" => ' ! $bootstrap',
	},
	"user_lengths" => {
		"perl" => ' ! $bootstrap',
	},
	"tree" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"nboots" => {
		"perl" => {
			'$value > 1000' => "more than 1000 samples is not possible on this server",
		},
	},
	"global" => {
		"perl" => {
			'	((defined $final_arrgt||defined $partial_arrgt) && !($transition||$bootstrap||$jumble)) ' => "If a rearrangement distance is specified, the input must contain a bootstrap, a jumble or a transition option.",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"tree" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"alignment" => {
		 "readseq_ok_alig" => 'fastDNAml',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"fastdnaml" => 0,
	"clean_tmp" => 0,
	"alignment" => 0,
	"inputopt" => 0,
	"frequencies" => 0,
	"fA" => 0,
	"fC" => 0,
	"fG" => 0,
	"fT" => 0,
	"outgroup" => 0,
	"transition" => 0,
	"jumble" => 0,
	"non_interleaved" => 0,
	"bootopt" => 0,
	"bootstrap" => 0,
	"nboots" => 0,
	"bootstrap_seed" => 0,
	"nbest" => 0,
	"maxjumble" => 0,
	"concat" => 0,
	"in_file" => 0,
	"bootfiles" => 0,
	"outputopt" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"printdata" => 0,
	"tmpfiles" => 0,
	"tmpaligfiles" => 0,
	"arrgtopt" => 0,
	"quickadd" => 0,
	"global" => 0,
	"final_arrgt" => 0,
	"partial_arrgt" => 0,
	"categopt" => 0,
	"categories" => 0,
	"weights" => 0,
	"weights_categories" => 0,
	"treeopt" => 0,
	"user_tree" => 0,
	"user_lengths" => 0,
	"tree" => 0,

    };

    $self->{ISSIMPLE}  = {
	"fastdnaml" => 0,
	"clean_tmp" => 0,
	"alignment" => 1,
	"inputopt" => 0,
	"frequencies" => 0,
	"fA" => 0,
	"fC" => 0,
	"fG" => 0,
	"fT" => 0,
	"outgroup" => 0,
	"transition" => 0,
	"jumble" => 0,
	"non_interleaved" => 0,
	"bootopt" => 0,
	"bootstrap" => 1,
	"nboots" => 1,
	"bootstrap_seed" => 1,
	"nbest" => 0,
	"maxjumble" => 0,
	"concat" => 0,
	"in_file" => 0,
	"bootfiles" => 0,
	"outputopt" => 0,
	"outfile" => 0,
	"treefile" => 0,
	"printdata" => 0,
	"tmpfiles" => 0,
	"tmpaligfiles" => 0,
	"arrgtopt" => 0,
	"quickadd" => 0,
	"global" => 0,
	"final_arrgt" => 0,
	"partial_arrgt" => 0,
	"categopt" => 0,
	"categories" => 0,
	"weights" => 0,
	"weights_categories" => 0,
	"treeopt" => 0,
	"user_tree" => 0,
	"user_lengths" => 0,
	"tree" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"alignment" => [
		"The input to fastDNAml is similar to that used by DNAML (and the other PHYLIP programs).",
	],
	"transition" => [
		"This option with a value of 2.0 (the program\'s default value) can be used before a global or treefile option with auxiliary data.",
	],
	"jumble" => [
		"Note that fastDNAml explores a very small number of alternative tree topologies relative to a typical parsimony program. There is a very real chance that the search procedure will not find the tree topology with the highest likelihood. Altering the order of taxon addition and comparing the trees found is a fairly efficient method for testing convergence. Typically, it would be nice to find the same best tree at least twice (if not three times), as opposed to simply performing some fixed number of jumbles and hoping that at least one of them will be the optimum.",
	],
	"bootstrap" => [
		"tree files will be summarized in one \'.tree\' file as well as output files in one \'.out\' file",
	],
	"bootstrap_seed" => [
		"Warning: For a given random number seed, the sample will always be the same.",
	],
	"quickadd" => [
		"This option greatly decreases the time in initially placing a new sequence in the growing tree (but does not change the time required to subsequently test rearrangements). The overall time savings seems to be about 30%, based on a very limited number of test cases. Its downside, if any, is unknown. This will probably become default program behavior in the near future.",
		"If the analysis is run with a global option of \'G 0 0\', so that no rearrangements are permitted, the tree is build very approximately, but very quickly. This may be of greatest interest if the question is, \'Where does this one new sequence fit into this known tree?\' The known tree is provided with the restart option, below.",
		"PHYLIP DNAML does not include anything comparable to the quickadd option.",
	],
	"global" => [
		"The G (global) option has been generalized to permit crossing any number of branches during tree rearrangements. In addition, it is possible to modify the extent of rearrangement explored during the sequential addition phase of tree building.",
		"The G U (global and user tree) option combination instructs the program to find the best of the user trees, and then look for rearrangements that are better still.",
		"If a rearrangement distance is specified, the input must contain a transition option.",
		"The Global option can be used to force branch swapping on user trees, (combination of Global and User Tree(s) options).",
	],
	"categories" => [
		"The data must have the format specified for PHYLIP dnaml 3.3. The first line must be the letter C, followed by the number of categories (a number in the range 1 through 35), and then a blank-separated list of the rates for each category. (The list can take more than one line; the program reads until it finds the specified number of rate values.) The next line should be the word Categories followed by one rate category character per sequence position. The categories 1 - 35 are represented by the series 1, 2, 3, ..., 8, 9, A, B, C, ..., Y, Z. These latter data can be on one or more lines. For example:",
		"C 12 0.0625 0.125 0.25 0.5 1 2 4 8 16 32 64 128",
		"Categories 5111136343678975AAA8949995566778888889AAAAAA9239898629AAAAA9",
		"Category \'numbers\' are ordered: 1, 2, 3, ..., 9, A, B, ..., Y, Z. Category zero (undefined rate) is permitted at sites with a zero in a user-supplied weighting mask.",
	],
	"weights" => [
		"example:",
		"Weights 111111111111001100000100011111100000000000000110000110000000",
		"In case of bootstrap, only positions that have nonzero weights are used in computing the bootstrap sample.",
	],
	"treeopt" => [
		"This options allows you to enter your own trees and instructs the program to evaluate them.",
	],
	"user_tree" => [
		"The trees must be in Newick format, and terminated with a semicolon. (The program also accepts a pseudo_newick format, which is a valid prolog fact.)",
		"The tree reader in this program is more powerful than that in PHYLIP 3.3. In particular, material enclosed in square brackets, [ like this ], is ignored as comments; taxa names can be wrapped in single quotation marks to support the inclusion of characters that would otherwise end the name (i.e., \'(\', \')\', \':\', \';\', \'[\', \']\', \',\' and \' \'); names of internal nodes are properly ignored; and exponential notation (such as 1.0E-6) for branch lengths is supported.",
	],
	"user_lengths" => [
		"Causes user trees to be read with branch lengths (and it is an error to omit any of them). Without the L option, branch lengths in user trees are not required, and are ignored if present.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fastdnaml.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

