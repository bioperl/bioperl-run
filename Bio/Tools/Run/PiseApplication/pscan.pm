
=head1 NAME

Bio::Tools::Run::PiseApplication::pscan

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::pscan

      Bioperl class for:

	PSCAN	Scans proteins using PRINTS (EMBOSS)

      Parameters:


		pscan (String)


		init (String)


		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- Protein [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		emin (Integer)
			Minimum number of elements per fingerprint (-emin)

		emax (Integer)
			Maximum number of elements per fingerprint (-emax)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::pscan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $pscan = Bio::Tools::Run::PiseApplication::pscan->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::pscan object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $pscan = $factory->program('pscan');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::pscan.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pscan.pm

    $self->{COMMAND}   = "pscan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PSCAN";

    $self->{DESCRIPTION}   = "Scans proteins using PRINTS (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/pscan.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"pscan",
	"init",
	"input",
	"required",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"pscan",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- Protein [sequences] (-sequence)
	"required", 	# required Section
	"emin", 	# Minimum number of elements per fingerprint (-emin)
	"emax", 	# Maximum number of elements per fingerprint (-emax)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"pscan" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"emin" => 'Integer',
	"emax" => 'Integer',
	"output" => 'Paragraph',
	"outfile" => 'OutFile',
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
	"required" => {
	},
	"emin" => {
		"perl" => '" -emin=$value"',
	},
	"emax" => {
		"perl" => '" -emax=$value"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"pscan" => {
		"perl" => '"pscan"',
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
	"emin" => 2,
	"emax" => 3,
	"outfile" => 4,
	"auto" => 5,
	"pscan" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"output",
	"pscan",
	"sequence",
	"emin",
	"emax",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"emin" => 0,
	"emax" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"pscan" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"emin" => 0,
	"emax" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"emin" => 1,
	"emax" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- Protein [sequences] (-sequence)",
	"required" => "required Section",
	"emin" => "Minimum number of elements per fingerprint (-emin)",
	"emax" => "Maximum number of elements per fingerprint (-emax)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"emin" => 0,
	"emax" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['emin','emax',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"emin" => '2',
	"emax" => '20',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"emin" => { "perl" => '1' },
	"emax" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
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
	"required" => 0,
	"emin" => 0,
	"emax" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"emin" => 1,
	"emax" => 1,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/pscan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

