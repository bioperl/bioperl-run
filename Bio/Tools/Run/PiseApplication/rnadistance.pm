
=head1 NAME

Bio::Tools::Run::PiseApplication::rnadistance

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::rnadistance

      Bioperl class for:

	VIENNARNA	RNAdistance - calculate distances of RNA secondary structures (Fontana, Hofacker, Stadler)

	References:

		Shapiro B A, (1988) An algorithm for comparing multiple RNA secondary structures, CABIOS 4, 381-393 Shapiro B A, Zhang K (1990) Comparing multiple RNA secondary structures using tree comparison, CABIOS 6, 309-318

		Fontana W, Konings D A M, Stadler P F, Schuster P, (1993) Statistics of RNA secondary structures, Biopolymers 33, 1389-1404 I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125, 167-188


      Parameters:


		rnadistance (String)


		struct (InFile)
			Structures File

		others_options (Paragraph)
			Other options

		distance (Excl)
			Representation for distance calculation (-D)

		compare (Excl)
			Which comparisons (-X)

		matrix_options (Paragraph)
			Analyse the distance matrix

		do_analyse (Switch)
			Do this analysis (with AnalyseDists program) (-Xm only)?

		method (Excl)
			Analysis methods to be used (-X)

		psfiles (Results)


		shapiro (Switch)
			Use the Bruce Shapiro's cost matrix for comparing coarse structures (-S)

		alignment_file (OutFile)
			Alignment file (-B)

=cut

#'
package Bio::Tools::Run::PiseApplication::rnadistance;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $rnadistance = Bio::Tools::Run::PiseApplication::rnadistance->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::rnadistance object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $rnadistance = $factory->program('rnadistance');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::rnadistance.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnadistance.pm

    $self->{COMMAND}   = "rnadistance";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "VIENNARNA";

    $self->{DESCRIPTION}   = "RNAdistance - calculate distances of RNA secondary structures";

    $self->{AUTHORS}   = "Fontana, Hofacker, Stadler";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-na.html#VIENNARNA";

    $self->{REFERENCE}   = [

         "Shapiro B A, (1988) An algorithm for comparing multiple RNA secondary structures, CABIOS 4, 381-393 Shapiro B A, Zhang K (1990) Comparing multiple RNA secondary structures using tree comparison, CABIOS 6, 309-318",

         "Fontana W, Konings D A M, Stadler P F, Schuster P, (1993) Statistics of RNA secondary structures, Biopolymers 33, 1389-1404 I.L. Hofacker, W. Fontana, P.F. Stadler, S. Bonhoeffer, M. Tacker, P. Schuster (1994) Fast Folding and Comparison of RNA Secondary Structures. Monatshefte f. Chemie 125, 167-188",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"rnadistance",
	"struct",
	"others_options",
	"shapiro",
	"alignment_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"rnadistance",
	"struct", 	# Structures File
	"others_options", 	# Other options
	"distance", 	# Representation for distance calculation (-D)
	"compare", 	# Which comparisons (-X)
	"matrix_options", 	# Analyse the distance matrix
	"do_analyse", 	# Do this analysis (with AnalyseDists program) (-Xm only)?
	"method", 	# Analysis methods to be used (-X)
	"psfiles",
	"shapiro", 	# Use the Bruce Shapiro's cost matrix for comparing coarse structures (-S)
	"alignment_file", 	# Alignment file (-B)

    ];

    $self->{TYPE}  = {
	"rnadistance" => 'String',
	"struct" => 'InFile',
	"others_options" => 'Paragraph',
	"distance" => 'Excl',
	"compare" => 'Excl',
	"matrix_options" => 'Paragraph',
	"do_analyse" => 'Switch',
	"method" => 'Excl',
	"psfiles" => 'Results',
	"shapiro" => 'Switch',
	"alignment_file" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"rnadistance" => {
		"perl" => '"RNAdistance"',
	},
	"struct" => {
		"perl" => '" < $value" ',
	},
	"others_options" => {
	},
	"distance" => {
		"perl" => '($value && $value ne $vdef)? " -D$value" : ""',
	},
	"compare" => {
		"perl" => '($value && $value ne $vdef)? " -X$value" : ""',
	},
	"matrix_options" => {
	},
	"do_analyse" => {
		"perl" => '($value)? " | AnalyseDists" : ""',
	},
	"method" => {
		"perl" => '($value && $value ne $vdef)? " -X$value" : "" ',
	},
	"psfiles" => {
	},
	"shapiro" => {
		"perl" => '($value)? " -S" : ""',
	},
	"alignment_file" => {
		"perl" => '($value)? " -B $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"psfiles" => '*.ps',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"rnadistance" => 0,
	"struct" => 1000,
	"others_options" => 2,
	"distance" => 2,
	"compare" => 2,
	"matrix_options" => 2000,
	"do_analyse" => 2000,
	"method" => 2001,
	"psfiles" => 2000,
	"shapiro" => 2,
	"alignment_file" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"rnadistance",
	"alignment_file",
	"others_options",
	"distance",
	"compare",
	"shapiro",
	"struct",
	"psfiles",
	"matrix_options",
	"do_analyse",
	"method",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"rnadistance" => 1,
	"struct" => 0,
	"others_options" => 0,
	"distance" => 0,
	"compare" => 0,
	"matrix_options" => 0,
	"do_analyse" => 0,
	"method" => 0,
	"psfiles" => 0,
	"shapiro" => 0,
	"alignment_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"rnadistance" => 1,
	"struct" => 0,
	"others_options" => 0,
	"distance" => 0,
	"compare" => 0,
	"matrix_options" => 0,
	"do_analyse" => 0,
	"method" => 0,
	"psfiles" => 0,
	"shapiro" => 0,
	"alignment_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"rnadistance" => 0,
	"struct" => 1,
	"others_options" => 0,
	"distance" => 0,
	"compare" => 0,
	"matrix_options" => 0,
	"do_analyse" => 0,
	"method" => 0,
	"psfiles" => 0,
	"shapiro" => 0,
	"alignment_file" => 0,

    };

    $self->{PROMPT}  = {
	"rnadistance" => "",
	"struct" => "Structures File",
	"others_options" => "Other options",
	"distance" => "Representation for distance calculation (-D)",
	"compare" => "Which comparisons (-X)",
	"matrix_options" => "Analyse the distance matrix",
	"do_analyse" => "Do this analysis (with AnalyseDists program) (-Xm only)?",
	"method" => "Analysis methods to be used (-X)",
	"psfiles" => "",
	"shapiro" => "Use the Bruce Shapiro's cost matrix for comparing coarse structures (-S)",
	"alignment_file" => "Alignment file (-B)",

    };

    $self->{ISSTANDOUT}  = {
	"rnadistance" => 0,
	"struct" => 0,
	"others_options" => 0,
	"distance" => 0,
	"compare" => 0,
	"matrix_options" => 0,
	"do_analyse" => 0,
	"method" => 0,
	"psfiles" => 0,
	"shapiro" => 0,
	"alignment_file" => 0,

    };

    $self->{VLIST}  = {

	"others_options" => ['distance','compare','matrix_options',],
	"distance" => ['f','f: full (tree editing)','F','F: full (string alignment)','h','h: HIT (tree editing)','H','H: HIT (string alignment)','w','w: weighted coarse (tree editing)','W','W: weighted coarse (string alignment)','c','c: coarse (tree editing)','C','C: coarse (string alignment)','P','P: selects the base pair distance',],
	"compare" => ['p','p: pairwise (1st/2nd, 3rd/4th etc)','m','m: distance matrix between all structures','f','f: each structure to the first one','c','c: continuously, that is i-th with (i+1)th structure',],
	"matrix_options" => ['do_analyse','method','psfiles',],
	"method" => ['s','s: split decomposition','w','w: cluster analysis using Ward\'s method','n','n: Cluster analysis using Saitou\'s neighbour joining method',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"distance" => 'f',
	"compare" => 'p',
	"do_analyse" => '0',
	"method" => 's',
	"shapiro" => '0',

    };

    $self->{PRECOND}  = {
	"rnadistance" => { "perl" => '1' },
	"struct" => { "perl" => '1' },
	"others_options" => { "perl" => '1' },
	"distance" => { "perl" => '1' },
	"compare" => { "perl" => '1' },
	"matrix_options" => {
		"perl" => '$compare eq "m"',
	},
	"do_analyse" => {
		"perl" => '$compare eq "m"',
	},
	"method" => {
		"perl" => '$compare eq "m"',
	},
	"psfiles" => {
		"perl" => '$compare eq "m" && $method eq "w" || $method eq "n"',
	},
	"shapiro" => { "perl" => '1' },
	"alignment_file" => { "perl" => '1' },

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
	"rnadistance" => 0,
	"struct" => 0,
	"others_options" => 0,
	"distance" => 0,
	"compare" => 0,
	"matrix_options" => 0,
	"do_analyse" => 0,
	"method" => 0,
	"psfiles" => 0,
	"shapiro" => 0,
	"alignment_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"rnadistance" => 0,
	"struct" => 1,
	"others_options" => 0,
	"distance" => 0,
	"compare" => 0,
	"matrix_options" => 0,
	"do_analyse" => 0,
	"method" => 0,
	"psfiles" => 0,
	"shapiro" => 0,
	"alignment_file" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"struct" => [
		"The program accepts structures in bracket format, where matching brackets symbolize base pairs and unpaired bases are represented by a dot \'.\', or coarse grained representations where hairpins, interior loops, bulges, multiloops, stacks and external bases are represented by (H), (I), (B), (M), (S), and (E), respectively. These can be optionally weighted. Full structures can be represented in the same fashion using the identifiers (U) and (P) for unpaired and paired bases, respectively. Examples:",
		".((..(((...)))..((..)))). full structure (usual format);",
		"(U)((U2)((U3)P3)(U2)((U2)P2)P2) HIT structure;",
		"((H)(H)M) or ((((H)S)((H)S)M)S) coarse grained structure;",
		"(((((H3)S3)((H2)S2)M4)S2)E2) weighted coarse grained.",
	],
	"matrix_options" => [
		"Only when comparison between all structures is requested (-Xm)",
		"This uses the beta test version of AnalyseDists distributed with the Vienna package.",
	],
	"alignment_file" => [
		"Print an \'alignment\' with gaps of the structures, to show matching substructures. The aligned structures are written to file, if specified. Otherwise output is written to stdout, unless the -Xm option is set in which case \'backtrack.file\' is used.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/rnadistance.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

