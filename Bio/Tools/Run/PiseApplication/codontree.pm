
=head1 NAME

Bio::Tools::Run::PiseApplication::codontree

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::codontree

      Bioperl class for:

	codontree	codon usage table, distance matrix and bases composition (Pesole, Attimonelli and Liuni)

	References:

		Graziano Pesole, Marcella Attimonelli and Sabino Liuni (CNR-Bari). NAR (16):5:1988 pp. 1715-1728


      Parameters:


		codontree (String)
			

		seqfile (Sequence)
			Sequences File

		files (Results)
			

		tabfile (String)
			

		control_options (Paragraph)
			Control options

		ntable (Excl)
			Translation  table to be used for the computation of distance and codon usage (-NTAble)

		output_options (Paragraph)
			Output options

		bc (List)
			Bases composition to be computed (-BC)

		eachseq (Switch)
			Allows the printout of a distinct codon usage table for each sequence  of  the input file (-EACHseq)

		dist (Switch)
			Allows the computation and the printout of the  distances matrix (-DISTance)

		verbose (Switch)
			Prints on the screen some useful information (-VERbose)

		bcfile (String)
			

		matfile (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::codontree;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $codontree = Bio::Tools::Run::PiseApplication::codontree->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::codontree object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $codontree = $factory->program('codontree');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::codontree.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codontree.pm

    $self->{COMMAND}   = "codontree";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "codontree";

    $self->{DESCRIPTION}   = "codon usage table, distance matrix and bases composition";

    $self->{AUTHORS}   = "Pesole, Attimonelli and Liuni";

    $self->{REFERENCE}   = [

         "Graziano Pesole, Marcella Attimonelli and Sabino Liuni (CNR-Bari). NAR (16):5:1988 pp. 1715-1728",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"codontree",
	"seqfile",
	"files",
	"tabfile",
	"control_options",
	"output_options",
	"bcfile",
	"matfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"codontree",
	"seqfile", 	# Sequences File
	"files",
	"tabfile",
	"control_options", 	# Control options
	"ntable", 	# Translation  table to be used for the computation of distance and codon usage (-NTAble)
	"output_options", 	# Output options
	"bc", 	# Bases composition to be computed (-BC)
	"eachseq", 	# Allows the printout of a distinct codon usage table for each sequence  of  the input file (-EACHseq)
	"dist", 	# Allows the computation and the printout of the  distances matrix (-DISTance)
	"verbose", 	# Prints on the screen some useful information (-VERbose)
	"bcfile",
	"matfile",

    ];

    $self->{TYPE}  = {
	"codontree" => 'String',
	"seqfile" => 'Sequence',
	"files" => 'Results',
	"tabfile" => 'String',
	"control_options" => 'Paragraph',
	"ntable" => 'Excl',
	"output_options" => 'Paragraph',
	"bc" => 'List',
	"eachseq" => 'Switch',
	"dist" => 'Switch',
	"verbose" => 'Switch',
	"bcfile" => 'String',
	"matfile" => 'String',

    };

    $self->{FORMAT}  = {
	"codontree" => {
		"seqlab" => 'codontree',
		"perl" => '"codontree"',
	},
	"seqfile" => {
		"perl" => '  " $value"',
	},
	"files" => {
	},
	"tabfile" => {
		"perl" => '" -TABfile=$seqfile.tab"',
	},
	"control_options" => {
	},
	"ntable" => {
		"perl" => '($value && $value ne $vdef)? " -NTAble=$value" : "" ',
	},
	"output_options" => {
	},
	"bc" => {
		"perl" => '($value)? " -BC=$value" : ""',
	},
	"eachseq" => {
		"perl" => '($value)? " -EACHseq" : ""',
	},
	"dist" => {
		"perl" => '($value)? " -DISTance" : ""',
	},
	"verbose" => {
		"perl" => '($value)? " -VERbose" : ""',
	},
	"bcfile" => {
		"perl" => '" -BCFILE=$seqfile.bc"',
	},
	"matfile" => {
		"perl" => '" -MATFILE=$seqfile.mat"',
	},

    };

    $self->{FILENAMES}  = {
	"files" => '*.tab *.bc *.mat',

    };

    $self->{SEQFMT}  = {
	"seqfile" => [8],

    };

    $self->{GROUP}  = {
	"codontree" => 0,
	"seqfile" => 1,
	"tabfile" => 3,
	"control_options" => 2,
	"ntable" => 2,
	"output_options" => 2,
	"bc" => 2,
	"eachseq" => 2,
	"dist" => 2,
	"verbose" => 2,
	"bcfile" => 3,
	"matfile" => 3,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"codontree",
	"files",
	"seqfile",
	"verbose",
	"control_options",
	"ntable",
	"output_options",
	"bc",
	"eachseq",
	"dist",
	"tabfile",
	"bcfile",
	"matfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"codontree" => 1,
	"seqfile" => 0,
	"files" => 0,
	"tabfile" => 1,
	"control_options" => 0,
	"ntable" => 0,
	"output_options" => 0,
	"bc" => 0,
	"eachseq" => 0,
	"dist" => 0,
	"verbose" => 0,
	"bcfile" => 1,
	"matfile" => 1,

    };

    $self->{ISCOMMAND}  = {
	"codontree" => 1,
	"seqfile" => 0,
	"files" => 0,
	"tabfile" => 0,
	"control_options" => 0,
	"ntable" => 0,
	"output_options" => 0,
	"bc" => 0,
	"eachseq" => 0,
	"dist" => 0,
	"verbose" => 0,
	"bcfile" => 0,
	"matfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"codontree" => 0,
	"seqfile" => 1,
	"files" => 0,
	"tabfile" => 0,
	"control_options" => 0,
	"ntable" => 0,
	"output_options" => 0,
	"bc" => 0,
	"eachseq" => 0,
	"dist" => 0,
	"verbose" => 0,
	"bcfile" => 0,
	"matfile" => 0,

    };

    $self->{PROMPT}  = {
	"codontree" => "",
	"seqfile" => "Sequences File",
	"files" => "",
	"tabfile" => "",
	"control_options" => "Control options",
	"ntable" => "Translation  table to be used for the computation of distance and codon usage (-NTAble)",
	"output_options" => "Output options",
	"bc" => "Bases composition to be computed (-BC)",
	"eachseq" => "Allows the printout of a distinct codon usage table for each sequence  of  the input file (-EACHseq)",
	"dist" => "Allows the computation and the printout of the  distances matrix (-DISTance)",
	"verbose" => "Prints on the screen some useful information (-VERbose)",
	"bcfile" => "",
	"matfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"codontree" => 0,
	"seqfile" => 0,
	"files" => 0,
	"tabfile" => 0,
	"control_options" => 0,
	"ntable" => 0,
	"output_options" => 0,
	"bc" => 0,
	"eachseq" => 0,
	"dist" => 0,
	"verbose" => 0,
	"bcfile" => 0,
	"matfile" => 0,

    };

    $self->{VLIST}  = {

	"control_options" => ['ntable',],
	"ntable" => ['0','UNIVERSAL','1','CILIATED PROTOZOA','2','DROSOPHILA MITOCHONDRIAL','3','MAMMALIAN MITOCHONDRIAL','4','YEAST MITOCHONDRIAL',],
	"output_options" => ['bc','eachseq','dist','verbose',],
	"bc" => ['1','-BC=1 prints the bases composition values of the first position of codons','2','-BC=2 prints the bases composition values of the second position','3','-BC=2 prints the bases composition values of the third position','A','-BC=A prints the bases composition values of all the three','Q','-BC=Q prints the bases composition values of quartets',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"bc" => "''",

    };

    $self->{VDEF}  = {
	"ntable" => '0',

    };

    $self->{PRECOND}  = {
	"codontree" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },
	"files" => { "perl" => '1' },
	"tabfile" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"ntable" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"bc" => { "perl" => '1' },
	"eachseq" => { "perl" => '1' },
	"dist" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"bcfile" => {
		"perl" => '$bc',
	},
	"matfile" => {
		"perl" => '$dist',
	},

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
	"codontree" => 0,
	"seqfile" => 0,
	"files" => 0,
	"tabfile" => 0,
	"control_options" => 0,
	"ntable" => 0,
	"output_options" => 0,
	"bc" => 0,
	"eachseq" => 0,
	"dist" => 0,
	"verbose" => 0,
	"bcfile" => 0,
	"matfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"codontree" => 1,
	"seqfile" => 1,
	"files" => 0,
	"tabfile" => 0,
	"control_options" => 0,
	"ntable" => 0,
	"output_options" => 0,
	"bc" => 0,
	"eachseq" => 0,
	"dist" => 0,
	"verbose" => 0,
	"bcfile" => 0,
	"matfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"eachseq" => [
		"If the switch is not on the command line, the codon usage table refers to all sequences in the input file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/codontree.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

