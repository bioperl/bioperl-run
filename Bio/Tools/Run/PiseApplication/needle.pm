
=head1 NAME

Bio::Tools::Run::PiseApplication::needle

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::needle

      Bioperl class for:

	NEEDLE	Needleman-Wunsch global alignment. (EMBOSS)

      Parameters:


		needle (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequencea (Sequence)
			sequencea -- any [single sequence] (-sequencea)
			pipe: seqfile

		seqall (Sequence)
			seqall [sequences] (-seqall)
			pipe: seqsfile

		required (Paragraph)
			required Section

		gapopen (Float)
			Gap opening penalty (-gapopen)

		gapextend (Float)
			Gap extension penalty (-gapextend)

		advanced (Paragraph)
			advanced Section

		datafile (Excl)
			Matrix file (-datafile)

		output (Paragraph)
			output Section

		similarity (Switch)
			Display percent identity and similarity (-similarity)

		outfile (OutFile)
			outfile (-outfile)
			pipe: readseq_ok_alig

		outfile_aformat (Excl)
			Alignment output format (-aformat)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::needle;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $needle = Bio::Tools::Run::PiseApplication::needle->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::needle object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $needle = $factory->program('needle');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::needle.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/needle.pm

    $self->{COMMAND}   = "needle";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "NEEDLE";

    $self->{DESCRIPTION}   = "Needleman-Wunsch global alignment. (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:global",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/needle.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"needle",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"needle",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- any [single sequence] (-sequencea)
	"seqall", 	# seqall [sequences] (-seqall)
	"required", 	# required Section
	"gapopen", 	# Gap opening penalty (-gapopen)
	"gapextend", 	# Gap extension penalty (-gapextend)
	"advanced", 	# advanced Section
	"datafile", 	# Matrix file (-datafile)
	"output", 	# output Section
	"similarity", 	# Display percent identity and similarity (-similarity)
	"outfile", 	# outfile (-outfile)
	"outfile_aformat", 	# Alignment output format (-aformat)
	"auto",

    ];

    $self->{TYPE}  = {
	"needle" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"seqall" => 'Sequence',
	"required" => 'Paragraph',
	"gapopen" => 'Float',
	"gapextend" => 'Float',
	"advanced" => 'Paragraph',
	"datafile" => 'Excl',
	"output" => 'Paragraph',
	"similarity" => 'Switch',
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
	"seqall" => {
		"perl" => '" -seqall=$value -sformat=fasta"',
	},
	"required" => {
	},
	"gapopen" => {
		"perl" => '" -gapopen=$value"',
	},
	"gapextend" => {
		"perl" => '" -gapextend=$value"',
	},
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value)? " -datafile=$value" : ""',
	},
	"output" => {
	},
	"similarity" => {
		"perl" => '($value)? "" : " -nosimilarity"',
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
	"needle" => {
		"perl" => '"needle"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequencea" => [8],
	"seqall" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequencea" => 1,
	"seqall" => 2,
	"gapopen" => 3,
	"gapextend" => 4,
	"datafile" => 5,
	"similarity" => 6,
	"outfile" => 7,
	"outfile_aformat" => 7,
	"auto" => 8,
	"needle" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"required",
	"output",
	"needle",
	"sequencea",
	"seqall",
	"gapopen",
	"gapextend",
	"datafile",
	"similarity",
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
	"seqall" => 0,
	"required" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"similarity" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 1,
	"needle" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"seqall" => 0,
	"required" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"similarity" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"seqall" => 1,
	"required" => 0,
	"gapopen" => 1,
	"gapextend" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"similarity" => 0,
	"outfile" => 1,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequencea" => "sequencea -- any [single sequence] (-sequencea)",
	"seqall" => "seqall [sequences] (-seqall)",
	"required" => "required Section",
	"gapopen" => "Gap opening penalty (-gapopen)",
	"gapextend" => "Gap extension penalty (-gapextend)",
	"advanced" => "advanced Section",
	"datafile" => "Matrix file (-datafile)",
	"output" => "output Section",
	"similarity" => "Display percent identity and similarity (-similarity)",
	"outfile" => "outfile (-outfile)",
	"outfile_aformat" => "Alignment output format (-aformat)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"seqall" => 0,
	"required" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"similarity" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea','seqall',],
	"required" => ['gapopen','gapextend',],
	"advanced" => ['datafile',],
	"datafile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['similarity','outfile','outfile_aformat',],
	"outfile_aformat" => ['','default','fasta','fasta','MSF','MSF',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gapextend" => '',
	"similarity" => '1',
	"outfile" => 'outfile.align',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequencea" => { "perl" => '1' },
	"seqall" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"gapopen" => { "perl" => '1' },
	"gapextend" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"similarity" => { "perl" => '1' },
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
	"seqall" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"seqall" => 0,
	"required" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"similarity" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 1,
	"seqall" => 1,
	"required" => 0,
	"gapopen" => 1,
	"gapextend" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"output" => 0,
	"similarity" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"gapopen" => [
		"The gap open penalty is the score taken away when a gap is created. The best value depends on the choice of comparison matrix. The default value assumes you are using the EBLOSUM62 matrix for protein sequences, and the EDNAFULL matrix for nucleotide sequences. Allowed values: Floating point number from 1.0 to 100.0",
	],
	"gapextend" => [
		"The gap extension, penalty is added to the standard gap penalty for each base or residue in the gap. This is how long gaps are penalized. Usually you will expect a few long gaps rather than many short gaps, so the gap extension penalty should be lower than the gap penalty. An exception is where one or both sequences are single reads with possible sequencing errors in which case you would expect many single base gaps. You can get this result by setting the gap open penalty to zero (or very low) and using the gap extension penalty to control gap scoring. Allowed values: Floating point number from 0.0 to 10.0",
	],
	"similarity" => [
		"Display percent identity and similarity",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/needle.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

