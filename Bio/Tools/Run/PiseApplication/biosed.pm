
=head1 NAME

Bio::Tools::Run::PiseApplication::biosed

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::biosed

      Bioperl class for:

	BIOSED	Replace or delete sequence sections (EMBOSS)

      Parameters:


		biosed (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence [sequences] (-sequence)
			pipe: seqsfile

		required (Paragraph)
			required Section

		target (String)
			Sequence section to match (-target)

		advanced (Paragraph)
			advanced Section

		delete (Switch)
			Delete the target sequence sections (-delete)

		replace (String)
			Replacement sequence section (-replace)

		output (Paragraph)
			output Section

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::biosed;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $biosed = Bio::Tools::Run::PiseApplication::biosed->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::biosed object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $biosed = $factory->program('biosed');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::biosed.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/biosed.pm

    $self->{COMMAND}   = "biosed";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BIOSED";

    $self->{DESCRIPTION}   = "Replace or delete sequence sections (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "edit",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/biosed.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"biosed",
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"biosed",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence [sequences] (-sequence)
	"required", 	# required Section
	"target", 	# Sequence section to match (-target)
	"advanced", 	# advanced Section
	"delete", 	# Delete the target sequence sections (-delete)
	"replace", 	# Replacement sequence section (-replace)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"auto",

    ];

    $self->{TYPE}  = {
	"biosed" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"required" => 'Paragraph',
	"target" => 'String',
	"advanced" => 'Paragraph',
	"delete" => 'Switch',
	"replace" => 'String',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
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
	"target" => {
		"perl" => '" -target=$value"',
	},
	"advanced" => {
	},
	"delete" => {
		"perl" => '($value)? " -delete" : ""',
	},
	"replace" => {
		"perl" => '($value && $value ne $vdef)? " -replace=$value" : ""',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"biosed" => {
		"perl" => '"biosed"',
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
	"target" => 2,
	"delete" => 3,
	"replace" => 4,
	"outseq" => 5,
	"outseq_sformat" => 6,
	"auto" => 7,
	"biosed" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"required",
	"advanced",
	"output",
	"biosed",
	"sequence",
	"target",
	"delete",
	"replace",
	"outseq",
	"outseq_sformat",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"target" => 0,
	"advanced" => 0,
	"delete" => 0,
	"replace" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 1,
	"biosed" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"target" => 0,
	"advanced" => 0,
	"delete" => 0,
	"replace" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"target" => 1,
	"advanced" => 0,
	"delete" => 0,
	"replace" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence [sequences] (-sequence)",
	"required" => "required Section",
	"target" => "Sequence section to match (-target)",
	"advanced" => "advanced Section",
	"delete" => "Delete the target sequence sections (-delete)",
	"replace" => "Replacement sequence section (-replace)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"required" => 0,
	"target" => 0,
	"advanced" => 0,
	"delete" => 0,
	"replace" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"required" => ['target',],
	"advanced" => ['delete','replace',],
	"output" => ['outseq','outseq_sformat',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"target" => 'N',
	"delete" => '0',
	"replace" => 'A',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"required" => { "perl" => '1' },
	"target" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"delete" => { "perl" => '1' },
	"replace" => {
		"acd" => '@(!$(delete))',
	},
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outseq" => {
		 '1' => "seqfile",
	},

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
	"target" => 0,
	"advanced" => 0,
	"delete" => 0,
	"replace" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"required" => 0,
	"target" => 1,
	"advanced" => 0,
	"delete" => 0,
	"replace" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/biosed.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

