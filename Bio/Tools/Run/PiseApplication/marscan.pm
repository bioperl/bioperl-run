
=head1 NAME

Bio::Tools::Run::PiseApplication::marscan

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::marscan

      Bioperl class for:

	MARSCAN	Finds MAR/SAR sites in nucleic sequences (EMBOSS)

      Parameters:


		marscan (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- dna [sequences] (-sequence)
			pipe: seqsfile

		output (Paragraph)
			output Section

		outf (OutFile)
			Output feature file (-outf)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::marscan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $marscan = Bio::Tools::Run::PiseApplication::marscan->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::marscan object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $marscan = $factory->program('marscan');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::marscan.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/marscan.pm

    $self->{COMMAND}   = "marscan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "MARSCAN";

    $self->{DESCRIPTION}   = "Finds MAR/SAR sites in nucleic sequences (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:gene finding",

         "nucleic:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/marscan.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"marscan",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"marscan",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- dna [sequences] (-sequence)
	"output", 	# output Section
	"outf", 	# Output feature file (-outf)
	"auto",

    ];

    $self->{TYPE}  = {
	"marscan" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"output" => 'Paragraph',
	"outf" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"sequence" => {
		"perl" => '" -sequence=$value -sformat=fasta"',
	},
	"output" => {
	},
	"outf" => {
		"perl" => '" -outf=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"marscan" => {
		"perl" => '"marscan"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"sequence" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"sequence" => 1,
	"outf" => 2,
	"auto" => 3,
	"marscan" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"marscan",
	"sequence",
	"outf",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 1,
	"marscan" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"output" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- dna [sequences] (-sequence)",
	"output" => "output Section",
	"outf" => "Output feature file (-outf)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"output" => ['outf',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outf" => 'outf.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outf" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"output" => 0,
	"outf" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"output" => 0,
	"outf" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"outf" => [
		"File for output of MAR/SAR recognition signature (MRS) regions. This contains details of the MRS in normal GFF format. The MRS consists of two recognition sites, one of 8 bp and one of 16 bp on either sense strand of the genomic DNA, within 200 bp of each other.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/marscan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

