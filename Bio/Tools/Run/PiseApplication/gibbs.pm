
=head1 NAME

Bio::Tools::Run::PiseApplication::gibbs

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::gibbs

      Bioperl class for:

	GIBBS	motif sampling (Neuwald & Lawrence)

	References:

		Neuwald, Liu, and Lawrence (1995). Gibbs motif sampling: detection of bacterial outer membrane protein repeats.  Protein Science 4, 1618-1632. (for Gibbs site sampling, Gibbs motif sampling, purge, and scan programs)

		Lawrence, Altschul, Boguski, Liu, Neuwald and Wootton (1993) Detecting Subtle Sequence Signals: A Gibbs Sampling Strategy for Multiple Alignment, Science 262:208-214.  (for Gibbs site sampling program)


      Parameters:


		gibbs (String)
			

		sequence (Sequence)
			Sequences file

		lengths (String)
			Lengths of elements for each type (eg: e1,e2)

		expected (String)
			Expected number of elements for each type (eg: l1,l2) (motif sampler)

		purge (Switch)
			Run purge to remove closely related sequences

		output_options (Paragraph)
			Output options

		scan (Switch)
			Create a scan output file (file.sn) (-f)

		control_options (Paragraph)
			Control options

		sites_options (Paragraph)
			Sites sampler options

		sites_cycles (Integer)
			Maximum number of cycles in each run (-m)

		element_order (Switch)
			Use element order in probabilities (-o)

		sites_pseudo_counts (Float)
			Pseudo counts for ordering model (-q)

		readings (Integer)
			Number of near-optimum readings taken (-R)

		motif_options (Paragraph)
			Motif sampler options

		wilcoxon (Switch)
			Output wilcoxon rank test information (-w)

		fractional_weight (Float)
			Fractional weight (0 to 1.0) on priors (-W)

		cycles (Integer)
			Number of cycles between shifts (sites sampler) or maximum number of cycles per run  (motif sampler) (-c)

		cutoff (Float)
			Prob. cutoff for near optimum sampling (-C)

		fragmentation (Switch)
			Use fragmentation (-d)

		convergence (Integer)
			Rapid convergence limit (higher = longer to converge) (-L)

		nucleic (Switch)
			Use nucleic acid alphabet (-n)

		pseudo_counts (Float)
			Number of pseudo counts for product multinomial model (-p)

		shuffle (Switch)
			Randomly shuffle input sequences (-r)

		seed (Integer)
			Seed for random number generator (-s)

		sampling_runs (Integer)
			Maximum number of sampling runs (-t)

		low_complexity (Switch)
			Remove protein low complexity regions (-x)

		purge_options (Paragraph)
			purge options

		score (Integer)
			Score threshold

		method (Excl)
			Heuristic method

		keep (Switch)
			Keep first sequence in the set (-q)

		mask (Switch)
			Use xnu to mask low complexity regions (-x)

		purge_sep (String)
			

		purged_sequence (Results)
			

		scan_file (OutFile)
			
			pipe: gibbs_motif

=cut

#'
package Bio::Tools::Run::PiseApplication::gibbs;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $gibbs = Bio::Tools::Run::PiseApplication::gibbs->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::gibbs object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $gibbs = $factory->program('gibbs');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::gibbs.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gibbs.pm

    $self->{COMMAND}   = "gibbs";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "GIBBS";

    $self->{DESCRIPTION}   = "motif sampling";

    $self->{AUTHORS}   = "Neuwald & Lawrence";

    $self->{REFERENCE}   = [

         "Neuwald, Liu, and Lawrence (1995). Gibbs motif sampling: detection of bacterial outer membrane protein repeats.  Protein Science 4, 1618-1632. (for Gibbs site sampling, Gibbs motif sampling, purge, and scan programs)",

         "Lawrence, Altschul, Boguski, Liu, Neuwald and Wootton (1993) Detecting Subtle Sequence Signals: A Gibbs Sampling Strategy for Multiple Alignment, Science 262:208-214.  (for Gibbs site sampling program)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"gibbs",
	"sequence",
	"lengths",
	"expected",
	"purge",
	"output_options",
	"control_options",
	"cycles",
	"cutoff",
	"fragmentation",
	"convergence",
	"nucleic",
	"pseudo_counts",
	"shuffle",
	"seed",
	"sampling_runs",
	"low_complexity",
	"purge_options",
	"scan_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"gibbs",
	"sequence", 	# Sequences file
	"lengths", 	# Lengths of elements for each type (eg: e1,e2)
	"expected", 	# Expected number of elements for each type (eg: l1,l2) (motif sampler)
	"purge", 	# Run purge to remove closely related sequences
	"output_options", 	# Output options
	"scan", 	# Create a scan output file (file.sn) (-f)
	"control_options", 	# Control options
	"sites_options", 	# Sites sampler options
	"sites_cycles", 	# Maximum number of cycles in each run (-m)
	"element_order", 	# Use element order in probabilities (-o)
	"sites_pseudo_counts", 	# Pseudo counts for ordering model (-q)
	"readings", 	# Number of near-optimum readings taken (-R)
	"motif_options", 	# Motif sampler options
	"wilcoxon", 	# Output wilcoxon rank test information (-w)
	"fractional_weight", 	# Fractional weight (0 to 1.0) on priors (-W)
	"cycles", 	# Number of cycles between shifts (sites sampler) or maximum number of cycles per run  (motif sampler) (-c)
	"cutoff", 	# Prob. cutoff for near optimum sampling (-C)
	"fragmentation", 	# Use fragmentation (-d)
	"convergence", 	# Rapid convergence limit (higher = longer to converge) (-L)
	"nucleic", 	# Use nucleic acid alphabet (-n)
	"pseudo_counts", 	# Number of pseudo counts for product multinomial model (-p)
	"shuffle", 	# Randomly shuffle input sequences (-r)
	"seed", 	# Seed for random number generator (-s)
	"sampling_runs", 	# Maximum number of sampling runs (-t)
	"low_complexity", 	# Remove protein low complexity regions (-x)
	"purge_options", 	# purge options
	"score", 	# Score threshold
	"method", 	# Heuristic method
	"keep", 	# Keep first sequence in the set (-q)
	"mask", 	# Use xnu to mask low complexity regions (-x)
	"purge_sep",
	"purged_sequence",
	"scan_file",

    ];

    $self->{TYPE}  = {
	"gibbs" => 'String',
	"sequence" => 'Sequence',
	"lengths" => 'String',
	"expected" => 'String',
	"purge" => 'Switch',
	"output_options" => 'Paragraph',
	"scan" => 'Switch',
	"control_options" => 'Paragraph',
	"sites_options" => 'Paragraph',
	"sites_cycles" => 'Integer',
	"element_order" => 'Switch',
	"sites_pseudo_counts" => 'Float',
	"readings" => 'Integer',
	"motif_options" => 'Paragraph',
	"wilcoxon" => 'Switch',
	"fractional_weight" => 'Float',
	"cycles" => 'Integer',
	"cutoff" => 'Float',
	"fragmentation" => 'Switch',
	"convergence" => 'Integer',
	"nucleic" => 'Switch',
	"pseudo_counts" => 'Float',
	"shuffle" => 'Switch',
	"seed" => 'Integer',
	"sampling_runs" => 'Integer',
	"low_complexity" => 'Switch',
	"purge_options" => 'Paragraph',
	"score" => 'Integer',
	"method" => 'Excl',
	"keep" => 'Switch',
	"mask" => 'Switch',
	"purge_sep" => 'String',
	"purged_sequence" => 'Results',
	"scan_file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"gibbs" => {
		"perl" => '"gibbs "',
	},
	"sequence" => {
		"perl" => '($purge)? " $sequence.b$score" : " $sequence"',
	},
	"lengths" => {
		"perl" => '" $value"',
	},
	"expected" => {
		"perl" => '" $value"',
	},
	"purge" => {
		"perl" => '($value)? "purge $sequence" : ""',
	},
	"output_options" => {
	},
	"scan" => {
		"perl" => '($value)? " -f" : ""',
	},
	"control_options" => {
	},
	"sites_options" => {
	},
	"sites_cycles" => {
		"perl" => '(defined $value)? " -m$value" : ""',
	},
	"element_order" => {
		"perl" => '($value)? " -o" : ""',
	},
	"sites_pseudo_counts" => {
		"perl" => '(defined $value)? " -q$value" : ""',
	},
	"readings" => {
		"perl" => '(defined $value)? " -R$value" : ""',
	},
	"motif_options" => {
	},
	"wilcoxon" => {
		"perl" => '($value)? " -w" : ""',
	},
	"fractional_weight" => {
		"perl" => '(defined $value)? " -W$value" : ""',
	},
	"cycles" => {
		"perl" => '(defined $value)? " -c$value" : ""',
	},
	"cutoff" => {
		"perl" => '(defined $value)? " -C$value" : ""',
	},
	"fragmentation" => {
		"perl" => '($value)? "" : " -d"',
	},
	"convergence" => {
		"perl" => '(defined $value)? " -L$value" : ""',
	},
	"nucleic" => {
		"perl" => '($value)? " -n" : ""',
	},
	"pseudo_counts" => {
		"perl" => '(defined $value)? " -p$value" : ""',
	},
	"shuffle" => {
		"perl" => '($value)? " -r" : ""',
	},
	"seed" => {
		"perl" => '(defined $value)? " -s$value" : ""',
	},
	"sampling_runs" => {
		"perl" => '(defined $value)? " -t$value" : ""',
	},
	"low_complexity" => {
		"perl" => '($value)? "" : " -x"',
	},
	"purge_options" => {
	},
	"score" => {
		"perl" => '" $value"',
	},
	"method" => {
		"perl" => '($value && $value ne $vdef)? " $value" : ""',
	},
	"keep" => {
		"perl" => '($value)? " -q" : ""',
	},
	"mask" => {
		"perl" => '($value)? "" : " -x"',
	},
	"purge_sep" => {
		"perl" => '";"',
	},
	"purged_sequence" => {
	},
	"scan_file" => {
		"perl" => '""',
	},

    };

    $self->{FILENAMES}  = {
	"purged_sequence" => '$sequence.b$score',

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"gibbs" => 0,
	"sequence" => 1,
	"lengths" => 2,
	"expected" => 3,
	"purge" => -10,
	"output_options" => 4,
	"scan" => 4,
	"control_options" => 4,
	"sites_options" => 4,
	"sites_cycles" => 4,
	"element_order" => 4,
	"sites_pseudo_counts" => 4,
	"readings" => 4,
	"motif_options" => 4,
	"wilcoxon" => 4,
	"fractional_weight" => 4,
	"cycles" => 4,
	"cutoff" => 4,
	"fragmentation" => 4,
	"convergence" => 4,
	"nucleic" => 4,
	"pseudo_counts" => 4,
	"shuffle" => 4,
	"seed" => 4,
	"sampling_runs" => 4,
	"low_complexity" => 4,
	"score" => -9,
	"method" => -8,
	"keep" => -8,
	"mask" => -8,
	"purge_sep" => -1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"purge",
	"score",
	"mask",
	"method",
	"keep",
	"purge_sep",
	"gibbs",
	"purge_options",
	"purged_sequence",
	"scan_file",
	"sequence",
	"lengths",
	"expected",
	"motif_options",
	"wilcoxon",
	"fractional_weight",
	"cycles",
	"cutoff",
	"fragmentation",
	"convergence",
	"nucleic",
	"pseudo_counts",
	"shuffle",
	"seed",
	"sampling_runs",
	"low_complexity",
	"output_options",
	"scan",
	"control_options",
	"sites_options",
	"sites_cycles",
	"element_order",
	"sites_pseudo_counts",
	"readings",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"gibbs" => 1,
	"sequence" => 0,
	"lengths" => 0,
	"expected" => 0,
	"purge" => 0,
	"output_options" => 0,
	"scan" => 0,
	"control_options" => 0,
	"sites_options" => 0,
	"sites_cycles" => 0,
	"element_order" => 0,
	"sites_pseudo_counts" => 0,
	"readings" => 0,
	"motif_options" => 0,
	"wilcoxon" => 0,
	"fractional_weight" => 0,
	"cycles" => 0,
	"cutoff" => 0,
	"fragmentation" => 0,
	"convergence" => 0,
	"nucleic" => 0,
	"pseudo_counts" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"sampling_runs" => 0,
	"low_complexity" => 0,
	"purge_options" => 0,
	"score" => 0,
	"method" => 0,
	"keep" => 0,
	"mask" => 0,
	"purge_sep" => 1,
	"purged_sequence" => 0,
	"scan_file" => 1,

    };

    $self->{ISCOMMAND}  = {
	"gibbs" => 1,
	"sequence" => 0,
	"lengths" => 0,
	"expected" => 0,
	"purge" => 0,
	"output_options" => 0,
	"scan" => 0,
	"control_options" => 0,
	"sites_options" => 0,
	"sites_cycles" => 0,
	"element_order" => 0,
	"sites_pseudo_counts" => 0,
	"readings" => 0,
	"motif_options" => 0,
	"wilcoxon" => 0,
	"fractional_weight" => 0,
	"cycles" => 0,
	"cutoff" => 0,
	"fragmentation" => 0,
	"convergence" => 0,
	"nucleic" => 0,
	"pseudo_counts" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"sampling_runs" => 0,
	"low_complexity" => 0,
	"purge_options" => 0,
	"score" => 0,
	"method" => 0,
	"keep" => 0,
	"mask" => 0,
	"purge_sep" => 0,
	"purged_sequence" => 0,
	"scan_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"gibbs" => 0,
	"sequence" => 1,
	"lengths" => 1,
	"expected" => 0,
	"purge" => 0,
	"output_options" => 0,
	"scan" => 0,
	"control_options" => 0,
	"sites_options" => 0,
	"sites_cycles" => 0,
	"element_order" => 0,
	"sites_pseudo_counts" => 0,
	"readings" => 0,
	"motif_options" => 0,
	"wilcoxon" => 0,
	"fractional_weight" => 0,
	"cycles" => 0,
	"cutoff" => 0,
	"fragmentation" => 0,
	"convergence" => 0,
	"nucleic" => 0,
	"pseudo_counts" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"sampling_runs" => 0,
	"low_complexity" => 0,
	"purge_options" => 0,
	"score" => 1,
	"method" => 0,
	"keep" => 0,
	"mask" => 0,
	"purge_sep" => 0,
	"purged_sequence" => 0,
	"scan_file" => 0,

    };

    $self->{PROMPT}  = {
	"gibbs" => "",
	"sequence" => "Sequences file",
	"lengths" => "Lengths of elements for each type (eg: e1,e2)",
	"expected" => "Expected number of elements for each type (eg: l1,l2) (motif sampler)",
	"purge" => "Run purge to remove closely related sequences",
	"output_options" => "Output options",
	"scan" => "Create a scan output file (file.sn) (-f)",
	"control_options" => "Control options",
	"sites_options" => "Sites sampler options",
	"sites_cycles" => "Maximum number of cycles in each run (-m)",
	"element_order" => "Use element order in probabilities (-o)",
	"sites_pseudo_counts" => "Pseudo counts for ordering model (-q)",
	"readings" => "Number of near-optimum readings taken (-R)",
	"motif_options" => "Motif sampler options",
	"wilcoxon" => "Output wilcoxon rank test information (-w)",
	"fractional_weight" => "Fractional weight (0 to 1.0) on priors (-W)",
	"cycles" => "Number of cycles between shifts (sites sampler) or maximum number of cycles per run  (motif sampler) (-c)",
	"cutoff" => "Prob. cutoff for near optimum sampling (-C)",
	"fragmentation" => "Use fragmentation (-d)",
	"convergence" => "Rapid convergence limit (higher = longer to converge) (-L)",
	"nucleic" => "Use nucleic acid alphabet (-n)",
	"pseudo_counts" => "Number of pseudo counts for product multinomial model (-p)",
	"shuffle" => "Randomly shuffle input sequences (-r)",
	"seed" => "Seed for random number generator (-s)",
	"sampling_runs" => "Maximum number of sampling runs (-t)",
	"low_complexity" => "Remove protein low complexity regions (-x)",
	"purge_options" => "purge options",
	"score" => "Score threshold",
	"method" => "Heuristic method",
	"keep" => "Keep first sequence in the set (-q)",
	"mask" => "Use xnu to mask low complexity regions (-x)",
	"purge_sep" => "",
	"purged_sequence" => "",
	"scan_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"gibbs" => 0,
	"sequence" => 0,
	"lengths" => 0,
	"expected" => 0,
	"purge" => 0,
	"output_options" => 0,
	"scan" => 0,
	"control_options" => 0,
	"sites_options" => 0,
	"sites_cycles" => 0,
	"element_order" => 0,
	"sites_pseudo_counts" => 0,
	"readings" => 0,
	"motif_options" => 0,
	"wilcoxon" => 0,
	"fractional_weight" => 0,
	"cycles" => 0,
	"cutoff" => 0,
	"fragmentation" => 0,
	"convergence" => 0,
	"nucleic" => 0,
	"pseudo_counts" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"sampling_runs" => 0,
	"low_complexity" => 0,
	"purge_options" => 0,
	"score" => 0,
	"method" => 0,
	"keep" => 0,
	"mask" => 0,
	"purge_sep" => 0,
	"purged_sequence" => 0,
	"scan_file" => 0,

    };

    $self->{VLIST}  = {

	"output_options" => ['scan',],
	"control_options" => ['sites_options','motif_options',],
	"sites_options" => ['sites_cycles','element_order','sites_pseudo_counts','readings',],
	"motif_options" => ['wilcoxon','fractional_weight',],
	"purge_options" => ['score','method','keep','mask','purge_sep','purged_sequence',],
	"method" => ['-b','-b: blast','-e','-e: exhaustive',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"purge" => '0',
	"scan" => '0',
	"element_order" => '0',
	"wilcoxon" => '0',
	"fragmentation" => '1',
	"nucleic" => '0',
	"shuffle" => '0',
	"low_complexity" => '1',
	"method" => '-b',
	"keep" => '0',
	"mask" => '1',
	"scan_file" => '"$sequence.sn"',

    };

    $self->{PRECOND}  = {
	"gibbs" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"lengths" => { "perl" => '1' },
	"expected" => { "perl" => '1' },
	"purge" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"scan" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"sites_options" => { "perl" => '1' },
	"sites_cycles" => { "perl" => '1' },
	"element_order" => { "perl" => '1' },
	"sites_pseudo_counts" => { "perl" => '1' },
	"readings" => { "perl" => '1' },
	"motif_options" => { "perl" => '1' },
	"wilcoxon" => { "perl" => '1' },
	"fractional_weight" => { "perl" => '1' },
	"cycles" => { "perl" => '1' },
	"cutoff" => { "perl" => '1' },
	"fragmentation" => { "perl" => '1' },
	"convergence" => { "perl" => '1' },
	"nucleic" => { "perl" => '1' },
	"pseudo_counts" => { "perl" => '1' },
	"shuffle" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"sampling_runs" => { "perl" => '1' },
	"low_complexity" => { "perl" => '1' },
	"purge_options" => {
		"perl" => '$purge',
	},
	"score" => {
		"perl" => '$purge',
	},
	"method" => {
		"perl" => '$purge',
	},
	"keep" => {
		"perl" => '$purge',
	},
	"mask" => {
		"perl" => '$purge',
	},
	"purge_sep" => {
		"perl" => '$purge',
	},
	"purged_sequence" => {
		"perl" => '$purge',
	},
	"scan_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"fractional_weight" => {
		"perl" => {
			'$value < 0 || $value > 1.0' => "The value must be between 0 to 1.0",
		},
	},
	"cutoff" => {
		"perl" => {
			'$value < 0 || $value > 1' => "(0 < Cutoff <= 1)",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"scan_file" => {
		 '$scan' => "gibbs_motif",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"gibbs" => 0,
	"sequence" => 0,
	"lengths" => 0,
	"expected" => 0,
	"purge" => 0,
	"output_options" => 0,
	"scan" => 0,
	"control_options" => 0,
	"sites_options" => 0,
	"sites_cycles" => 0,
	"element_order" => 0,
	"sites_pseudo_counts" => 0,
	"readings" => 0,
	"motif_options" => 0,
	"wilcoxon" => 0,
	"fractional_weight" => 0,
	"cycles" => 0,
	"cutoff" => 0,
	"fragmentation" => 0,
	"convergence" => 0,
	"nucleic" => 0,
	"pseudo_counts" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"sampling_runs" => 0,
	"low_complexity" => 0,
	"purge_options" => 0,
	"score" => 0,
	"method" => 0,
	"keep" => 0,
	"mask" => 0,
	"purge_sep" => 0,
	"purged_sequence" => 0,
	"scan_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"gibbs" => 0,
	"sequence" => 1,
	"lengths" => 1,
	"expected" => 1,
	"purge" => 0,
	"output_options" => 0,
	"scan" => 0,
	"control_options" => 0,
	"sites_options" => 0,
	"sites_cycles" => 0,
	"element_order" => 0,
	"sites_pseudo_counts" => 0,
	"readings" => 0,
	"motif_options" => 0,
	"wilcoxon" => 0,
	"fractional_weight" => 0,
	"cycles" => 0,
	"cutoff" => 0,
	"fragmentation" => 0,
	"convergence" => 0,
	"nucleic" => 0,
	"pseudo_counts" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"sampling_runs" => 0,
	"low_complexity" => 0,
	"purge_options" => 0,
	"score" => 0,
	"method" => 0,
	"keep" => 0,
	"mask" => 0,
	"purge_sep" => 0,
	"purged_sequence" => 0,
	"scan_file" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"lengths" => [
		"format:",
		"long[,long]",
		"example:",
		"18,18,18",
	],
	"expected" => [
		"format:",
		"long[,long]",
		"example:",
		"18,18,18",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gibbs.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

