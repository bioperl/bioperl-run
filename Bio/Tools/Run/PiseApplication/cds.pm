
=head1 NAME

Bio::Tools::Run::PiseApplication::cds

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cds

      Bioperl class for:

	CDS	Search Coding Regions (F. Chauveau)

      Parameters:


		cds (String)


		seq (Sequence)
			Sequence File

		search (Paragraph)
			Search parameters

		minaa (Integer)
			Minimum number of amino acids in CDS

		frame (Excl)
			Frame

		starts (String)
			START codons (separated by commas)

		maxf (Switch)
			longest CDS in each frame

		max (Switch)
			longest CDS

		all (Switch)
			all CDS, including CDS inside CDS

		output (Paragraph)
			Output parameters

		nucl (Switch)
			nucleotids output

		print_adn (Switch)
			Print ADN as well as Amino-acids

		left_adn (Integer)
			How many base pairs on the left (if print ADN)

		print_frame (Switch)
			print frame before search

		print_pos (Switch)
			print only position(s)

		xml (Switch)
			XML output (-x)

		xmldtdcopy (String)


		xmldtd (Results)


		others (Paragraph)
			Other parameters

		end_stop (Switch)
			CDS ends at STOP

		genetic (Excl)
			Genetic Code

=cut

#'
package Bio::Tools::Run::PiseApplication::cds;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cds = Bio::Tools::Run::PiseApplication::cds->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cds object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $cds = $factory->program('cds');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::cds.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cds.pm

    $self->{COMMAND}   = "cds";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CDS";

    $self->{DESCRIPTION}   = "Search Coding Regions";

    $self->{AUTHORS}   = "F. Chauveau";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cds",
	"seq",
	"search",
	"output",
	"xmldtdcopy",
	"xmldtd",
	"others",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cds",
	"seq", 	# Sequence File
	"search", 	# Search parameters
	"minaa", 	# Minimum number of amino acids in CDS
	"frame", 	# Frame
	"starts", 	# START codons (separated by commas)
	"maxf", 	# longest CDS in each frame
	"max", 	# longest CDS
	"all", 	# all CDS, including CDS inside CDS
	"output", 	# Output parameters
	"nucl", 	# nucleotids output
	"print_adn", 	# Print ADN as well as Amino-acids
	"left_adn", 	# How many base pairs on the left (if print ADN)
	"print_frame", 	# print frame before search
	"print_pos", 	# print only position(s)
	"xml", 	# XML output (-x)
	"xmldtdcopy",
	"xmldtd",
	"others", 	# Other parameters
	"end_stop", 	# CDS ends at STOP
	"genetic", 	# Genetic Code

    ];

    $self->{TYPE}  = {
	"cds" => 'String',
	"seq" => 'Sequence',
	"search" => 'Paragraph',
	"minaa" => 'Integer',
	"frame" => 'Excl',
	"starts" => 'String',
	"maxf" => 'Switch',
	"max" => 'Switch',
	"all" => 'Switch',
	"output" => 'Paragraph',
	"nucl" => 'Switch',
	"print_adn" => 'Switch',
	"left_adn" => 'Integer',
	"print_frame" => 'Switch',
	"print_pos" => 'Switch',
	"xml" => 'Switch',
	"xmldtdcopy" => 'String',
	"xmldtd" => 'Results',
	"others" => 'Paragraph',
	"end_stop" => 'Switch',
	"genetic" => 'Excl',

    };

    $self->{FORMAT}  = {
	"cds" => {
		"seqlab" => 'cds',
		"perl" => '"cds"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"search" => {
	},
	"minaa" => {
		"perl" => ' ($value)? " -l $value" : "" ',
	},
	"frame" => {
		"perl" => '($value)? " -f $value" : "" ',
	},
	"starts" => {
		"perl" => '($value && ($value !~ /,/ || $value =~ s/,/ /g) )? " -c \\"$value\\" " : "" ',
	},
	"maxf" => {
		"perl" => ' ($value)? " -m":""',
	},
	"max" => {
		"perl" => ' ($value)? " -M":""',
	},
	"all" => {
		"perl" => ' ($value)? " -a":""',
	},
	"output" => {
	},
	"nucl" => {
		"perl" => ' ($value)? " -n":""',
	},
	"print_adn" => {
		"perl" => '($print_adn || defined $left_adn)? " -v $left_adn" : "" ',
	},
	"left_adn" => {
		"perl" => '""',
	},
	"print_frame" => {
		"perl" => ' ($value)? " -s":""',
	},
	"print_pos" => {
		"perl" => ' ($value)? " -p":""',
	},
	"xml" => {
		"perl" => ' ($value)? " -x":""',
	},
	"xmldtdcopy" => {
		"perl" => '"; cp /local/gensoft/lib/pasteur/cds.dtd ."',
	},
	"xmldtd" => {
	},
	"others" => {
	},
	"end_stop" => {
		"perl" => ' ($value)? " -e":""',
	},
	"genetic" => {
		"perl" => ' ($value && $value ne $vdef)? " -g $value" : "" ',
	},

    };

    $self->{FILENAMES}  = {
	"xmldtd" => 'cds.dtd',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"cds" => 0,
	"seq" => 10,
	"minaa" => 1,
	"frame" => 1,
	"starts" => 1,
	"maxf" => 1,
	"max" => 1,
	"all" => 1,
	"nucl" => 1,
	"print_adn" => 1,
	"left_adn" => 1,
	"print_frame" => 1,
	"print_pos" => 1,
	"xml" => 1,
	"xmldtdcopy" => 100,
	"end_stop" => 1,
	"genetic" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"cds",
	"xmldtd",
	"search",
	"output",
	"others",
	"frame",
	"starts",
	"maxf",
	"max",
	"all",
	"nucl",
	"print_adn",
	"left_adn",
	"print_frame",
	"print_pos",
	"xml",
	"minaa",
	"end_stop",
	"genetic",
	"seq",
	"xmldtdcopy",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"cds" => 1,
	"seq" => 0,
	"search" => 0,
	"minaa" => 0,
	"frame" => 0,
	"starts" => 0,
	"maxf" => 0,
	"max" => 0,
	"all" => 0,
	"output" => 0,
	"nucl" => 0,
	"print_adn" => 0,
	"left_adn" => 0,
	"print_frame" => 0,
	"print_pos" => 0,
	"xml" => 0,
	"xmldtdcopy" => 1,
	"xmldtd" => 0,
	"others" => 0,
	"end_stop" => 0,
	"genetic" => 0,

    };

    $self->{ISCOMMAND}  = {
	"cds" => 1,
	"seq" => 0,
	"search" => 0,
	"minaa" => 0,
	"frame" => 0,
	"starts" => 0,
	"maxf" => 0,
	"max" => 0,
	"all" => 0,
	"output" => 0,
	"nucl" => 0,
	"print_adn" => 0,
	"left_adn" => 0,
	"print_frame" => 0,
	"print_pos" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"xmldtd" => 0,
	"others" => 0,
	"end_stop" => 0,
	"genetic" => 0,

    };

    $self->{ISMANDATORY}  = {
	"cds" => 0,
	"seq" => 1,
	"search" => 0,
	"minaa" => 0,
	"frame" => 0,
	"starts" => 0,
	"maxf" => 0,
	"max" => 0,
	"all" => 0,
	"output" => 0,
	"nucl" => 0,
	"print_adn" => 0,
	"left_adn" => 0,
	"print_frame" => 0,
	"print_pos" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"xmldtd" => 0,
	"others" => 0,
	"end_stop" => 0,
	"genetic" => 0,

    };

    $self->{PROMPT}  = {
	"cds" => "",
	"seq" => "Sequence File",
	"search" => "Search parameters",
	"minaa" => "Minimum number of amino acids in CDS",
	"frame" => "Frame",
	"starts" => "START codons (separated by commas)",
	"maxf" => "longest CDS in each frame",
	"max" => "longest CDS",
	"all" => "all CDS, including CDS inside CDS",
	"output" => "Output parameters",
	"nucl" => "nucleotids output",
	"print_adn" => "Print ADN as well as Amino-acids",
	"left_adn" => "How many base pairs on the left (if print ADN)",
	"print_frame" => "print frame before search",
	"print_pos" => "print only position(s)",
	"xml" => "XML output (-x)",
	"xmldtdcopy" => "",
	"xmldtd" => "",
	"others" => "Other parameters",
	"end_stop" => "CDS ends at STOP",
	"genetic" => "Genetic Code",

    };

    $self->{ISSTANDOUT}  = {
	"cds" => 0,
	"seq" => 0,
	"search" => 0,
	"minaa" => 0,
	"frame" => 0,
	"starts" => 0,
	"maxf" => 0,
	"max" => 0,
	"all" => 0,
	"output" => 0,
	"nucl" => 0,
	"print_adn" => 0,
	"left_adn" => 0,
	"print_frame" => 0,
	"print_pos" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"xmldtd" => 0,
	"others" => 0,
	"end_stop" => 0,
	"genetic" => 0,

    };

    $self->{VLIST}  = {

	"search" => ['minaa','frame','starts','maxf','max','all',],
	"frame" => ['1','1','2','2','3','3','-1','1 (opposite strand)','-2','2 (opposite strand)','-3','3 (opposite strand)',],
	"output" => ['nucl','print_adn','left_adn','print_frame','print_pos','xml',],
	"others" => ['end_stop','genetic',],
	"genetic" => ['1','Standard','2','Vertebrate Mitochondrial','3','Yeast Mitochondrial','4','Mold, Protozoan, Coelenterate Mitochondrial and Mycoplasma/Spiroplasma','5','Invertebrate Mitochondrial','6','Ciliate Macronuclear and Dasycladacean','9','Echinoderm Mitochondrial','10','Euplotid Nuclear','11','Bacterial','12','Alternative Yeast Nuclear','13','Ascidian Mitochondrial','14','Flatworm Mitochondrial','15','Blepharisma Macronuclear',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"maxf" => '0',
	"max" => '0',
	"all" => '0',
	"nucl" => '0',
	"print_adn" => '0',
	"print_frame" => '0',
	"print_pos" => '0',
	"xml" => '0',
	"end_stop" => '0',
	"genetic" => '1',

    };

    $self->{PRECOND}  = {
	"cds" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"search" => { "perl" => '1' },
	"minaa" => { "perl" => '1' },
	"frame" => { "perl" => '1' },
	"starts" => { "perl" => '1' },
	"maxf" => { "perl" => '1' },
	"max" => { "perl" => '1' },
	"all" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"nucl" => { "perl" => '1' },
	"print_adn" => { "perl" => '1' },
	"left_adn" => { "perl" => '1' },
	"print_frame" => { "perl" => '1' },
	"print_pos" => { "perl" => '1' },
	"xml" => { "perl" => '1' },
	"xmldtdcopy" => {
		"perl" => '$xml',
	},
	"xmldtd" => {
		"perl" => '$xml',
	},
	"others" => { "perl" => '1' },
	"end_stop" => { "perl" => '1' },
	"genetic" => { "perl" => '1' },

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
	"cds" => 0,
	"seq" => 0,
	"search" => 0,
	"minaa" => 0,
	"frame" => 0,
	"starts" => 0,
	"maxf" => 0,
	"max" => 0,
	"all" => 0,
	"output" => 0,
	"nucl" => 0,
	"print_adn" => 0,
	"left_adn" => 0,
	"print_frame" => 0,
	"print_pos" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"xmldtd" => 0,
	"others" => 0,
	"end_stop" => 0,
	"genetic" => 0,

    };

    $self->{ISSIMPLE}  = {
	"cds" => 1,
	"seq" => 1,
	"search" => 0,
	"minaa" => 0,
	"frame" => 0,
	"starts" => 0,
	"maxf" => 0,
	"max" => 0,
	"all" => 0,
	"output" => 0,
	"nucl" => 0,
	"print_adn" => 0,
	"left_adn" => 0,
	"print_frame" => 0,
	"print_pos" => 0,
	"xml" => 0,
	"xmldtdcopy" => 0,
	"xmldtd" => 0,
	"others" => 0,
	"end_stop" => 0,
	"genetic" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cds.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

