
=head1 NAME

Bio::Tools::Run::PiseApplication::nrscope

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::nrscope

      Bioperl class for:

	NRSCOPE	Converts redundant EMBL-format SCOP file to non-redundant one (EMBOSS)

      Parameters:


		nrscope (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		scopin (InFile)
			Name of scop file for input (embl-like format) (-scopin)

		dpdb (String)
			Location of clean domain coordinate files for input (embl-like format) (-dpdb)

		extn (String)
			File extension of clean domain coordinate files (-extn)

		required (Paragraph)
			required Section

		thresh (Float)
			The % sequence identity redundancy threshold (-thresh)

		datafile (Excl)
			Residue substitution matrix (-datafile)

		gapopen (Float)
			Gap insertion penalty (-gapopen)

		gapextend (Float)
			Gap extension penalty (-gapextend)

		output (Paragraph)
			output Section

		scopout (OutFile)
			Name of non-redundant scop file for output (embl-like format) (-scopout)

		errf (OutFile)
			Name of log file for the build (-errf)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::nrscope;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $nrscope = Bio::Tools::Run::PiseApplication::nrscope->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::nrscope object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $nrscope = $factory->program('nrscope');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::nrscope.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/nrscope.pm

    $self->{COMMAND}   = "nrscope";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "NRSCOPE";

    $self->{DESCRIPTION}   = "Converts redundant EMBL-format SCOP file to non-redundant one (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "utils:database creation",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/nrscope.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"nrscope",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"nrscope",
	"init",
	"input", 	# input Section
	"scopin", 	# Name of scop file for input (embl-like format) (-scopin)
	"dpdb", 	# Location of clean domain coordinate files for input (embl-like format) (-dpdb)
	"extn", 	# File extension of clean domain coordinate files (-extn)
	"required", 	# required Section
	"thresh", 	# The % sequence identity redundancy threshold (-thresh)
	"datafile", 	# Residue substitution matrix (-datafile)
	"gapopen", 	# Gap insertion penalty (-gapopen)
	"gapextend", 	# Gap extension penalty (-gapextend)
	"output", 	# output Section
	"scopout", 	# Name of non-redundant scop file for output (embl-like format) (-scopout)
	"errf", 	# Name of log file for the build (-errf)
	"auto",

    ];

    $self->{TYPE}  = {
	"nrscope" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"scopin" => 'InFile',
	"dpdb" => 'String',
	"extn" => 'String',
	"required" => 'Paragraph',
	"thresh" => 'Float',
	"datafile" => 'Excl',
	"gapopen" => 'Float',
	"gapextend" => 'Float',
	"output" => 'Paragraph',
	"scopout" => 'OutFile',
	"errf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"scopin" => {
		"perl" => '" -scopin=$value"',
	},
	"dpdb" => {
		"perl" => '" -dpdb=$value"',
	},
	"extn" => {
		"perl" => '" -extn=$value"',
	},
	"required" => {
	},
	"thresh" => {
		"perl" => '" -thresh=$value"',
	},
	"datafile" => {
		"perl" => '" -datafile=$value"',
	},
	"gapopen" => {
		"perl" => '" -gapopen=$value"',
	},
	"gapextend" => {
		"perl" => '" -gapextend=$value"',
	},
	"output" => {
	},
	"scopout" => {
		"perl" => '" -scopout=$value"',
	},
	"errf" => {
		"perl" => '" -errf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"nrscope" => {
		"perl" => '"nrscope"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"scopin" => 1,
	"dpdb" => 2,
	"extn" => 3,
	"thresh" => 4,
	"datafile" => 5,
	"gapopen" => 6,
	"gapextend" => 7,
	"scopout" => 8,
	"errf" => 9,
	"auto" => 10,
	"nrscope" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"nrscope",
	"scopin",
	"dpdb",
	"extn",
	"thresh",
	"datafile",
	"gapopen",
	"gapextend",
	"scopout",
	"errf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"scopin" => 0,
	"dpdb" => 0,
	"extn" => 0,
	"required" => 0,
	"thresh" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"scopout" => 0,
	"errf" => 0,
	"auto" => 1,
	"nrscope" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"scopin" => 0,
	"dpdb" => 0,
	"extn" => 0,
	"required" => 0,
	"thresh" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"scopout" => 0,
	"errf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"scopin" => 1,
	"dpdb" => 1,
	"extn" => 1,
	"required" => 0,
	"thresh" => 1,
	"datafile" => 1,
	"gapopen" => 1,
	"gapextend" => 1,
	"output" => 0,
	"scopout" => 1,
	"errf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"scopin" => "Name of scop file for input (embl-like format) (-scopin)",
	"dpdb" => "Location of clean domain coordinate files for input (embl-like format) (-dpdb)",
	"extn" => "File extension of clean domain coordinate files (-extn)",
	"required" => "required Section",
	"thresh" => "The % sequence identity redundancy threshold (-thresh)",
	"datafile" => "Residue substitution matrix (-datafile)",
	"gapopen" => "Gap insertion penalty (-gapopen)",
	"gapextend" => "Gap extension penalty (-gapextend)",
	"output" => "output Section",
	"scopout" => "Name of non-redundant scop file for output (embl-like format) (-scopout)",
	"errf" => "Name of log file for the build (-errf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"scopin" => 0,
	"dpdb" => 0,
	"extn" => 0,
	"required" => 0,
	"thresh" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"scopout" => 0,
	"errf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['scopin','dpdb','extn',],
	"required" => ['thresh','datafile','gapopen','gapextend',],
	"datafile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['scopout','errf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"dpdb" => './',
	"extn" => '.pxyz',
	"thresh" => '95.0',
	"datafile" => 'EBLOSUM62',
	"gapopen" => '10',
	"gapextend" => '0.5',
	"scopout" => 'EscopNR.dat',
	"errf" => 'nrscope.log',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"scopin" => { "perl" => '1' },
	"dpdb" => { "perl" => '1' },
	"extn" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"thresh" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"gapopen" => { "perl" => '1' },
	"gapextend" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"scopout" => { "perl" => '1' },
	"errf" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

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
	"init" => 0,
	"input" => 0,
	"scopin" => 0,
	"dpdb" => 0,
	"extn" => 0,
	"required" => 0,
	"thresh" => 0,
	"datafile" => 0,
	"gapopen" => 0,
	"gapextend" => 0,
	"output" => 0,
	"scopout" => 0,
	"errf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"scopin" => 1,
	"dpdb" => 1,
	"extn" => 1,
	"required" => 0,
	"thresh" => 1,
	"datafile" => 1,
	"gapopen" => 1,
	"gapextend" => 1,
	"output" => 0,
	"scopout" => 1,
	"errf" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"gapopen" => [
		"The gap insertion penalty is the score taken away when a gap is created. The best value depends on the choice of comparison matrix. The default value assumes you are using the EBLOSUM62 matrix for protein sequences, and the EDNAFULL matrix for nucleotide sequences. Allowed values: Floating point number from 1.0 to 100.0",
	],
	"gapextend" => [
		"The gap extension, penalty is added to the standard gap penalty for each base or residue in the gap. This is how long gaps are penalized. Usually you will expect a few long gaps rather than many short gaps, so the gap extension penalty should be lower than the gap penalty. An exception is where one or both sequences are single reads with possible sequencing errors in which case you would expect many single base gaps. You can get this result by setting the gap open penalty to zero (or very low) and using the gap extension penalty to control gap scoring. Allowed values: Floating point number from 0.0 to 10.0",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/nrscope.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

