
=head1 NAME

Bio::Tools::Run::PiseApplication::stretcher

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::stretcher

      Bioperl class for:

	STRETCHER	Finds the best global alignment between two sequences (EMBOSS)

      Parameters:


		stretcher (String)


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
			datafile (-datafile)

		gappenalty (Integer)
			gappenalty -- enter a number (-gappenalty)

		gaplength (Integer)
			gaplength -- enter a number (-gaplength)

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
package Bio::Tools::Run::PiseApplication::stretcher;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $stretcher = Bio::Tools::Run::PiseApplication::stretcher->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::stretcher object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $stretcher = $factory->program('stretcher');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::stretcher.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/stretcher.pm

    $self->{COMMAND}   = "stretcher";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "STRETCHER";

    $self->{DESCRIPTION}   = "Finds the best global alignment between two sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:global",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/stretcher.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"stretcher",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"stretcher",
	"init",
	"input", 	# input Section
	"sequencea", 	# sequencea -- any [single sequence] (-sequencea)
	"sequenceb", 	# sequenceb [single sequence] (-sequenceb)
	"advanced", 	# advanced Section
	"datafile", 	# datafile (-datafile)
	"gappenalty", 	# gappenalty -- enter a number (-gappenalty)
	"gaplength", 	# gaplength -- enter a number (-gaplength)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"outfile_aformat", 	# Alignment output format (-aformat)
	"auto",

    ];

    $self->{TYPE}  = {
	"stretcher" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequencea" => 'Sequence',
	"sequenceb" => 'Sequence',
	"advanced" => 'Paragraph',
	"datafile" => 'Excl',
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
	"stretcher" => {
		"perl" => '"stretcher"',
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
	"gappenalty" => 4,
	"gaplength" => 5,
	"outfile" => 6,
	"outfile_aformat" => 6,
	"auto" => 7,
	"stretcher" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"stretcher",
	"sequencea",
	"sequenceb",
	"datafile",
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
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 1,
	"stretcher" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequencea" => 0,
	"sequenceb" => 0,
	"advanced" => 0,
	"datafile" => 0,
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
	"datafile" => "datafile (-datafile)",
	"gappenalty" => "gappenalty -- enter a number (-gappenalty)",
	"gaplength" => "gaplength -- enter a number (-gaplength)",
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
	"gappenalty" => 0,
	"gaplength" => 0,
	"output" => 0,
	"outfile" => 0,
	"outfile_aformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequencea','sequenceb',],
	"advanced" => ['datafile','gappenalty','gaplength',],
	"datafile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['outfile','outfile_aformat',],
	"outfile_aformat" => ['','default','fasta','fasta','MSF','MSF',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
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
	"datafile" => [
		"Matrix file",
	],
	"gappenalty" => [
		"gappenalty Allowed values: Positive integer",
	],
	"gaplength" => [
		"gap length penalty Allowed values: Positive integer",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/stretcher.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

