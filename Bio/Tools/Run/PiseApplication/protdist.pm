
=head1 NAME

Bio::Tools::Run::PiseApplication::protdist

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::protdist

      Bioperl class for:

	Phylip	protdist - Program to compute distance matrix from protein sequences (Felsenstein)

	References:

		Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.

		Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.


      Parameters:


		protdist (String)
			

		infile (Sequence)
			Alignement File
			pipe: readseq_ok_alig

		method (Excl)
			Distance model (P)

		gamma_dist (Excl)
			Gamma distribution of rates among positions (G)

		bootstrap (Paragraph)
			Bootstrap options

		seqboot (Switch)
			Perform a bootstrap before analysis

		resamp_method (Excl)
			Resampling methods

		seqboot_seed (Integer)
			Random number seed (must be odd)

		replicates (Integer)
			How many replicates

		weight_opt (Paragraph)
			Weight options

		weights (Switch)
			Use weights for sites (W)

		weights_file (InFile)
			Weights file

		multiple_dataset (String)
			

		bootconfirm (String)
			

		bootterminal_type (String)
			

		output (Paragraph)
			Output options

		printdata (Switch)
			Print out the data at start of run (1)

		categ_opt (Paragraph)
			Categories model options

		code (Excl)
			Genetic code (U)

		categorization (Excl)
			Categorization of amino acids (A)

		change_prob (Integer)
			Prob change category (1.0=easy) (E)

		ratio (Integer)
			Transition/transversion ratio (T)

		base_frequencies (Integer)
			Base frequencies for A, C, G, T/U (separated by commas)

		outfile (Results)
			
			pipe: phylip_dist

		params (Results)
			

		confirm (String)
			

		terminal_type (String)
			

		tmp_params (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::protdist;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $protdist = Bio::Tools::Run::PiseApplication::protdist->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::protdist object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $protdist = $factory->program('protdist');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::protdist.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/protdist.pm

    $self->{COMMAND}   = "protdist";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Phylip";

    $self->{DESCRIPTION}   = "protdist - Program to compute distance matrix from protein sequences";

    $self->{AUTHORS}   = "Felsenstein";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-evol.html#PHYLIP";

    $self->{REFERENCE}   = [

         "Felsenstein, J.  1993.  PHYLIP (Phylogeny Inference Package) version 3.5c. Distributed by the author.  Department of Genetics, University of Washington, Seattle.",

         "Felsenstein, J.  1989.  PHYLIP -- Phylogeny Inference Package (Version 3.2). Cladistics  5: 164-166.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"protdist",
	"infile",
	"method",
	"gamma_dist",
	"bootstrap",
	"weight_opt",
	"multiple_dataset",
	"bootconfirm",
	"bootterminal_type",
	"output",
	"categ_opt",
	"outfile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"protdist",
	"infile", 	# Alignement File
	"method", 	# Distance model (P)
	"gamma_dist", 	# Gamma distribution of rates among positions (G)
	"bootstrap", 	# Bootstrap options
	"seqboot", 	# Perform a bootstrap before analysis
	"resamp_method", 	# Resampling methods
	"seqboot_seed", 	# Random number seed (must be odd)
	"replicates", 	# How many replicates
	"weight_opt", 	# Weight options
	"weights", 	# Use weights for sites (W)
	"weights_file", 	# Weights file
	"multiple_dataset",
	"bootconfirm",
	"bootterminal_type",
	"output", 	# Output options
	"printdata", 	# Print out the data at start of run (1)
	"categ_opt", 	# Categories model options
	"code", 	# Genetic code (U)
	"categorization", 	# Categorization of amino acids (A)
	"change_prob", 	# Prob change category (1.0=easy) (E)
	"ratio", 	# Transition/transversion ratio (T)
	"base_frequencies", 	# Base frequencies for A, C, G, T/U (separated by commas)
	"outfile",
	"params",
	"confirm",
	"terminal_type",
	"tmp_params",

    ];

    $self->{TYPE}  = {
	"protdist" => 'String',
	"infile" => 'Sequence',
	"method" => 'Excl',
	"gamma_dist" => 'Excl',
	"bootstrap" => 'Paragraph',
	"seqboot" => 'Switch',
	"resamp_method" => 'Excl',
	"seqboot_seed" => 'Integer',
	"replicates" => 'Integer',
	"weight_opt" => 'Paragraph',
	"weights" => 'Switch',
	"weights_file" => 'InFile',
	"multiple_dataset" => 'String',
	"bootconfirm" => 'String',
	"bootterminal_type" => 'String',
	"output" => 'Paragraph',
	"printdata" => 'Switch',
	"categ_opt" => 'Paragraph',
	"code" => 'Excl',
	"categorization" => 'Excl',
	"change_prob" => 'Integer',
	"ratio" => 'Integer',
	"base_frequencies" => 'Integer',
	"outfile" => 'Results',
	"params" => 'Results',
	"confirm" => 'String',
	"terminal_type" => 'String',
	"tmp_params" => 'Results',

    };

    $self->{FORMAT}  = {
	"protdist" => {
		"perl" => '"protdist < params"',
	},
	"infile" => {
		"perl" => '"ln -sf $infile infile; "',
	},
	"method" => {
	},
	"gamma_dist" => {
	},
	"bootstrap" => {
	},
	"seqboot" => {
		"perl" => '($value) ? "seqboot < seqboot.params && mv outfile infile && " : ""',
	},
	"resamp_method" => {
	},
	"seqboot_seed" => {
		"perl" => '"$value\\n"',
	},
	"replicates" => {
		"perl" => '($value && $value != $vdef)? "R\\n$value\\n" : ""',
	},
	"weight_opt" => {
	},
	"weights" => {
		"perl" => '($value)? "W\\n" : ""',
	},
	"weights_file" => {
		"perl" => '($value)? "ln -s $weights_file weights; " : ""',
	},
	"multiple_dataset" => {
		"perl" => '"M\\nD\\n$replicates\\n"',
	},
	"bootconfirm" => {
		"perl" => '"Y\\n"',
	},
	"bootterminal_type" => {
		"perl" => '"0\\n"',
	},
	"output" => {
	},
	"printdata" => {
		"perl" => '($value) ? "1\\n" : ""',
	},
	"categ_opt" => {
	},
	"code" => {
		"perl" => '($value and $value ne $vdef)? "U\\n$code\\n" : "" ',
	},
	"categorization" => {
		"perl" => '($value and $value ne $vdef) ? "A\\n$categorization\\n" : ""',
	},
	"change_prob" => {
		"perl" => '($value and $value != $vdef) ? "E\\n$value\\n" : ""',
	},
	"ratio" => {
		"perl" => '($value && $value != $vdef)? "T\\n$value\\n" : ""',
	},
	"base_frequencies" => {
		"perl" => '($value) ? "F\\n$base_frequencies\\n" : "" ',
	},
	"outfile" => {
	},
	"params" => {
	},
	"confirm" => {
		"perl" => '"Y\\n"',
	},
	"terminal_type" => {
		"perl" => '"0\\n"',
	},
	"tmp_params" => {
	},

    };

    $self->{FILENAMES}  = {
	"outfile" => 'outfile',
	"params" => 'params',
	"tmp_params" => '*.params',

    };

    $self->{SEQFMT}  = {
	"infile" => [12],

    };

    $self->{GROUP}  = {
	"protdist" => 0,
	"infile" => -10,
	"method" => 2,
	"gamma_dist" => 2,
	"seqboot" => -5,
	"resamp_method" => 1,
	"seqboot_seed" => 10000,
	"replicates" => 1,
	"weights" => 1,
	"weights_file" => -1,
	"multiple_dataset" => 1,
	"bootconfirm" => 1000,
	"bootterminal_type" => -1,
	"printdata" => 1,
	"categ_opt" => 3,
	"code" => 3,
	"categorization" => 10,
	"change_prob" => 3,
	"ratio" => 3,
	"base_frequencies" => 3,
	"confirm" => 1000,
	"terminal_type" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"infile",
	"seqboot",
	"bootterminal_type",
	"weights_file",
	"terminal_type",
	"protdist",
	"params",
	"outfile",
	"bootstrap",
	"weight_opt",
	"output",
	"tmp_params",
	"weights",
	"multiple_dataset",
	"printdata",
	"resamp_method",
	"replicates",
	"method",
	"gamma_dist",
	"categ_opt",
	"code",
	"change_prob",
	"base_frequencies",
	"ratio",
	"categorization",
	"confirm",
	"bootconfirm",
	"seqboot_seed",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"protdist" => 1,
	"infile" => 0,
	"method" => 0,
	"gamma_dist" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"resamp_method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"multiple_dataset" => 1,
	"bootconfirm" => 1,
	"bootterminal_type" => 1,
	"output" => 0,
	"printdata" => 0,
	"categ_opt" => 0,
	"code" => 0,
	"categorization" => 0,
	"change_prob" => 0,
	"ratio" => 0,
	"base_frequencies" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 1,
	"terminal_type" => 1,
	"tmp_params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"protdist" => 1,
	"infile" => 0,
	"method" => 0,
	"gamma_dist" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"resamp_method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"output" => 0,
	"printdata" => 0,
	"categ_opt" => 0,
	"code" => 0,
	"categorization" => 0,
	"change_prob" => 0,
	"ratio" => 0,
	"base_frequencies" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"protdist" => 0,
	"infile" => 1,
	"method" => 0,
	"gamma_dist" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"resamp_method" => 1,
	"seqboot_seed" => 1,
	"replicates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"output" => 0,
	"printdata" => 0,
	"categ_opt" => 0,
	"code" => 0,
	"categorization" => 0,
	"change_prob" => 0,
	"ratio" => 0,
	"base_frequencies" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PROMPT}  = {
	"protdist" => "",
	"infile" => "Alignement File",
	"method" => "Distance model (P)",
	"gamma_dist" => "Gamma distribution of rates among positions (G)",
	"bootstrap" => "Bootstrap options",
	"seqboot" => "Perform a bootstrap before analysis",
	"resamp_method" => "Resampling methods",
	"seqboot_seed" => "Random number seed (must be odd)",
	"replicates" => "How many replicates",
	"weight_opt" => "Weight options",
	"weights" => "Use weights for sites (W)",
	"weights_file" => "Weights file",
	"multiple_dataset" => "",
	"bootconfirm" => "",
	"bootterminal_type" => "",
	"output" => "Output options",
	"printdata" => "Print out the data at start of run (1)",
	"categ_opt" => "Categories model options",
	"code" => "Genetic code (U)",
	"categorization" => "Categorization of amino acids (A)",
	"change_prob" => "Prob change category (1.0=easy) (E)",
	"ratio" => "Transition/transversion ratio (T)",
	"base_frequencies" => "Base frequencies for A, C, G, T/U (separated by commas)",
	"outfile" => "",
	"params" => "",
	"confirm" => "",
	"terminal_type" => "",
	"tmp_params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"protdist" => 0,
	"infile" => 0,
	"method" => 0,
	"gamma_dist" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"resamp_method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"output" => 0,
	"printdata" => 0,
	"categ_opt" => 0,
	"code" => 0,
	"categorization" => 0,
	"change_prob" => 0,
	"ratio" => 0,
	"base_frequencies" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{VLIST}  = {

	"method" => ['J','Jones-Taylor-Thornton matrix','D','Dayhoff PAM matrix','K','Kimura formula','S','Similarity table','C','Categories model',],
	"gamma_dist" => ['N','No','Y','Yes','G','Gamma+Invariant',],
	"bootstrap" => ['seqboot','resamp_method','seqboot_seed','replicates',],
	"resamp_method" => ['bootstrap','Bootstrap','jackknife','Delete-half jackknife','permute','Permute species for each character',],
	"weight_opt" => ['weights','weights_file',],
	"output" => ['printdata',],
	"categ_opt" => ['code','categorization','change_prob','ratio','base_frequencies',],
	"code" => ['U','U: Universal','M','M: Mitochondrial','V','V: Vertebrate mitochondrial','F','F: Fly mitochondrial','Y','Y: Yeast mitochondrial',],
	"categorization" => ['G','G: George/Hunt/Barker','C','C: Chemical','H','H: Hall',],
    };

    $self->{FLIST}  = {

	"method" => {
		'J' => '""',
		'C' => '"P\\nP\\nP\\nP\\n"',
		'S' => '"P\\nP\\nP\\n"',
		'K' => '"P\\nP\\n"',
		'D' => '"P\\n"',

	},
	"gamma_dist" => {
		'N' => '""',
		'G' => '"G\\nG\\n"',
		'Y' => '"G\\n"',

	},
	"resamp_method" => {
		'bootstrap' => '""',
		'permute' => '"J\\nJ\\n"',
		'jackknife' => '"J\\n"',

	},
    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"method" => 'J',
	"seqboot" => '0',
	"resamp_method" => 'bootstrap',
	"replicates" => '100',
	"printdata" => '0',
	"code" => 'U',
	"categorization" => 'G',
	"change_prob" => '0.4570',
	"ratio" => '2.000',

    };

    $self->{PRECOND}  = {
	"protdist" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"method" => { "perl" => '1' },
	"gamma_dist" => {
		"perl" => '$method eq "J" or $method eq "D" or $method eq "C"',
	},
	"bootstrap" => { "perl" => '1' },
	"seqboot" => { "perl" => '1' },
	"resamp_method" => {
		"perl" => '$seqboot',
	},
	"seqboot_seed" => {
		"perl" => '$seqboot',
	},
	"replicates" => {
		"perl" => '$seqboot',
	},
	"weight_opt" => { "perl" => '1' },
	"weights" => { "perl" => '1' },
	"weights_file" => {
		"perl" => '$weights',
	},
	"multiple_dataset" => {
		"perl" => '$seqboot',
	},
	"bootconfirm" => {
		"perl" => '$seqboot',
	},
	"bootterminal_type" => {
		"perl" => '$seqboot',
	},
	"output" => { "perl" => '1' },
	"printdata" => { "perl" => '1' },
	"categ_opt" => {
		"perl" => '$method eq "C"',
	},
	"code" => {
		"perl" => '$method eq "C"',
	},
	"categorization" => {
		"perl" => '$method eq "C"',
	},
	"change_prob" => {
		"perl" => '$method eq "C"',
	},
	"ratio" => {
		"perl" => '$method eq "C"',
	},
	"base_frequencies" => {
		"perl" => '$method eq "C"',
	},
	"outfile" => { "perl" => '1' },
	"params" => { "perl" => '1' },
	"confirm" => { "perl" => '1' },
	"terminal_type" => { "perl" => '1' },
	"tmp_params" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"seqboot_seed" => {
		"perl" => {
			'$value <= 0 || (($value % 2) == 0)' => "Random number seed must be odd",
		},
	},
	"replicates" => {
		"perl" => {
			'$replicates > 1000' => "this server allows no more than 1000 replicates",
		},
	},
	"change_prob" => {
		"perl" => {
			'$change_prob < 0.0 || $change_prob > 1.0' => "Enter a value between 0.0 and 1.0",
		},
	},
	"base_frequencies" => {
		"perl" => {
			'($base_frequencies =~ s/,/ /g) && 0' => "",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "phylip_dist",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"protdist" => 0,
	"infile" => 0,
	"method" => 0,
	"gamma_dist" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"resamp_method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"output" => 0,
	"printdata" => 0,
	"categ_opt" => 0,
	"code" => 0,
	"categorization" => 0,
	"change_prob" => 0,
	"ratio" => 0,
	"base_frequencies" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"protdist" => 0,
	"infile" => 1,
	"method" => 0,
	"gamma_dist" => 0,
	"bootstrap" => 0,
	"seqboot" => 0,
	"resamp_method" => 0,
	"seqboot_seed" => 0,
	"replicates" => 0,
	"weight_opt" => 0,
	"weights" => 0,
	"weights_file" => 0,
	"multiple_dataset" => 0,
	"bootconfirm" => 0,
	"bootterminal_type" => 0,
	"output" => 0,
	"printdata" => 0,
	"categ_opt" => 0,
	"code" => 0,
	"categorization" => 0,
	"change_prob" => 0,
	"ratio" => 0,
	"base_frequencies" => 0,
	"outfile" => 0,
	"params" => 0,
	"confirm" => 0,
	"terminal_type" => 0,
	"tmp_params" => 0,

    };

    $self->{PARAMFILE}  = {
	"method" => "params",
	"gamma_dist" => "params",
	"resamp_method" => "seqboot.params",
	"seqboot_seed" => "seqboot.params",
	"replicates" => "seqboot.params",
	"weights" => "params",
	"multiple_dataset" => "params",
	"bootconfirm" => "seqboot.params",
	"bootterminal_type" => "seqboot.params",
	"printdata" => "params",
	"code" => "params",
	"categorization" => "params",
	"change_prob" => "params",
	"ratio" => "params",
	"base_frequencies" => "params",
	"confirm" => "params",
	"terminal_type" => "params",

    };

    $self->{COMMENT}  = {
	"seqboot" => [
		"By selecting this option, the bootstrap will be performed on your sequence file. So you don\'t need to perform a separated seqboot before.",
		"Don\'t give an already bootstrapped file to the program, this won\'t work!",
	],
	"resamp_method" => [
		"1. The bootstrap. Bootstrapping was invented by Bradley Efron in 1979, and its use in phylogeny estimation was introduced by me (Felsenstein, 1985b). It involves creating a new data set by sampling N characters randomly with replacement, so that the resulting data set has the same size as the original, but some characters have been left out and others are duplicated. The random variation of the results from analyzing these bootstrapped data sets can be shown statistically to be typical of the variation that you would get from collecting new data sets. The method assumes that the characters evolve independently, an assumption that may not be realistic for many kinds of data.",
		"2. Delete-half-jackknifing. This alternative to the bootstrap involves sampling a random half of the characters, and including them in the data but dropping the others. The resulting data sets are half the size of the original, and no characters are duplicated. The random variation from doing this should be very similar to that obtained from the bootstrap. The method is advocated by Wu (1986).",
		"3. Permuting species within characters. This method of resampling (well, OK, it may not be best to call it resampling) was introduced by Archie (1989) and Faith (1990; see also Faith and Cranston, 1991). It involves permuting the columns of the data matrix separately. This produces data matrices that have the same number and kinds of characters but no taxonomic structure. It is used for different purposes than the bootstrap, as it tests not the variation around an estimated tree but the hypothesis that there is no taxonomic structure in the data: if a statistic such as number of steps is significantly smaller in the actual data than it is in replicates that are permuted, then we can argue that there is some taxonomic structure in the data (though perhaps it might be just a pair of sibling species).",
	],
	"categorization" => [
		"All have groups: (Glu Gln Asp Asn), (Lys Arg His), (Phe Tyr Trp) plus:",
		"George/Hunt/Barker: (Cys), (Met Val Leu Ileu), (Gly Ala Ser Thr Pro)",
		"Chemical: (Cys Met), (Val Leu Ileu Gly Ala Ser Thr), (Pro)",
		"Hall: (Cys), (Met Val Leu Ileu), (Gly Ala Ser Thr), (Pro)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/protdist.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

