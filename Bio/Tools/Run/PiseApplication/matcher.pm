
=head1 NAME

Bio::Tools::Run::PiseApplication::matcher

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::matcher

      Bioperl class for:

	MATCHER	Finds the best local alignments between two sequences (EMBOSS)

      Parameters:


		matcher (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequencea (Sequence)
			sequencea -- any [single sequence] (-sequencea)
			pipe: seqfile

		sequenceb (Sequence)
			sequenceb [single sequence] (-sequenceb)

		advanced (Paragraph)
			advanced Section

		datafile (Excl)
			Matrix file (-datafile)

		alternatives (Integer)
			Number of alternative matches (-alternatives)

		gappenalty (Integer)
			Gap penalty (-gappenalty)

		gaplength (Integer)
			Gap length penalty (-gaplength)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)
			pipe: readseq_ok_alig

		outfile_aformat (Excl)
			Alignment output format (-aformat)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::matcher;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $matcher = Bio::Tools::Run::PiseApplication::matcher->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::matcher object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $matcher = $factory->program('matcher');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::matcher.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/matcher.pm

    $self->{COMMAND}   = "matcher";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MATCHER";

    $self->{DESCRIPTION}   = "Finds the best local alignments between two sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:local",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/matcher.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"matcher",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"matcher",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- any [single sequence] (-sequencea)
	"sequenceb", 	# sequenceb [single sequence] (-sequenceb)
	"advanced", 	# advanced Section
	"datafile", 	# Matrix file (-datafile)
	"alternatives", 	# Number of alternative matches (-alternatives)
	"gappenalty", 	# Gap penalty (-gappenalty)
	"gaplength", 	# Gap length penalty (-gaplength)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"outfile_aformat", 	# Alignment output format (-aformat)
	"auto",

    ];

    $self->{TYPE}  = {
	"matcher" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"sequenceb" => 'Sequence',
	"advanced" => 'Paragraph',
	"datafile" => 'Excl',
	"alternatives" => 'Integer',
	"gappenalty" => 'Integer',
	"gaplength" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
	"outfile_aformat" => 'Excl',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequencea" => {
		"perl" => '" -sequencea=$value -sformat=fasta"',
	},
	"sequenceb" => {
		"perl" => '" -sequenceb=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value)? " -datafile=$value" : ""',
	},
	"alternatives" => {
		"perl" => '(defined $value && $value != $vdef)? " -alternatives=$value" : ""',
	},
	"gappenalty" => {
		"perl" => '(defined $value && $value != $vdef)? " -gappenalty=$value" : ""',
	},
	"gaplength" => {
		"perl" => '(defined $value && $value != $vdef)? " -gaplength=$value" : ""',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"outfile_aformat" => {
		"perl" => '($value)? " -aformat=$value" : "" ',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"matcher" => {
		"perl" => '"matcher"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],
	"sequenceb" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"sequenceb" => 2,
	"datafile" => 3,
	"alternatives" => 4,
	"gappenalty" => 5,
	"gaplength" => 6,
	"outfile" => 7,
	"outfile_aformat" => 7,
	"auto" => 8,
	"matcher" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"matcher",
	"sequencea",
	"sequenceb",
	"datafile",
	"alternatives",
	"gappenalty",
	"gaplength",
	"outfile",
	"outfile_aformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"alternatives" => 0,
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 1,
	"matcher" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"alternatives" => 0,
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"sequenceb" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"alternatives" => 0,
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 1,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequencea" => "sequencea -- any [single sequence] (-sequencea)",
	"sequenceb" => "sequenceb [single sequence] (-sequenceb)",
	"advanced" => "advanced Section",
	"datafile" => "Matrix file (-datafile)",
	"alternatives" => "Number of alternative matches (-alternatives)",
	"gappenalty" => "Gap penalty (-gappenalty)",
	"gaplength" => "Gap length penalty (-gaplength)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"outfile_aformat" => "Alignment output format (-aformat)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"alternatives" => 0,
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea','sequenceb',],
	"advanced" => ['datafile','alternatives','gappenalty','gaplength',],
	"datafile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['outfile','outfile_aformat',],
	"outfile_aformat" => ['','default','fasta','fasta','MSF','MSF',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"alternatives" => '1',
	"gappenalty" => '',
	"gaplength" => '',
	"outfile" => 'outfile.align',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"sequenceb" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"alternatives" => { "perl" => '1' },
	"gappenalty" => { "perl" => '1' },
	"gaplength" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"outfile_aformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '$outfile_aformat ne ""' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequencea" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"alternatives" => 0,
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"sequenceb" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"alternatives" => 0,
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"alternatives" => [
		"This sets the number of alternative matches output. By default only the highest scoring alignment is shown. A value of 2 gves you other reasonable alignments. In some cases, for example multidomain proteins of cDNA and gemomic DNA comparisons, there may be other interesting and significant alignments.",
	],
	"gappenalty" => [
		"The gap penalty is the score taken away when a gap is created. The best value depends on the choice of comparison matrix. The default value of 14 assumes you are using the EBLOSUM62 matrix for protein sequences, or a value of 16 and the EDNAFULL matrix for nucleotide sequences. Allowed values: Positive integer",
	],
	"gaplength" => [
		"The gap length, or gap extension, penalty is added to the standard gap penalty for each base or residue in the gap. This is how long gaps are penalized. Usually you will expect a few long gaps rather than many short gaps, so the gap extension penalty should be lower than the gap penalty. An exception is where one or both sequences are single reads with possible sequencing errors in which case you would expect many single base gaps. You can get this result by setting the gap penalty to zero (or very low) and using the gap extension penalty to control gap scoring. Allowed values: Positive integer",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/matcher.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

