
=head1 NAME

Bio::Tools::Run::PiseApplication::patmatmotifs

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::patmatmotifs

      Bioperl class for:

	PATMATMOTIFS	Search a PROSITE motif database with a protein sequence (EMBOSS)

      Parameters:


		patmatmotifs (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		sequence (Sequence)
			sequence -- Protein [single sequence] (-sequence)
			pipe: seqfile

		advanced (Paragraph)
			advanced Section

		full (Switch)
			Provide full documentation for matching patterns (-full)

		prune (Switch)
			Ignore simple patterns (-prune)

		output (Paragraph)
			output Section

		outfile (OutFile)
			outfile (-outfile)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::patmatmotifs;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $patmatmotifs = Bio::Tools::Run::PiseApplication::patmatmotifs->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::patmatmotifs object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $patmatmotifs = $factory->program('patmatmotifs');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::patmatmotifs.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/patmatmotifs.pm

    $self->{COMMAND}   = "patmatmotifs";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PATMATMOTIFS";

    $self->{DESCRIPTION}   = "Search a PROSITE motif database with a protein sequence (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/patmatmotifs.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"patmatmotifs",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"patmatmotifs",
	"init",
	"input", 	# input Section
	"sequence", 	# sequence -- Protein [single sequence] (-sequence)
	"advanced", 	# advanced Section
	"full", 	# Provide full documentation for matching patterns (-full)
	"prune", 	# Ignore simple patterns (-prune)
	"output", 	# output Section
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"patmatmotifs" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"sequence" => 'Sequence',
	"advanced" => 'Paragraph',
	"full" => 'Switch',
	"prune" => 'Switch',
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
	"advanced" => {
	},
	"full" => {
		"perl" => '($value)? " -full" : ""',
	},
	"prune" => {
		"perl" => '($value)? "" : " -noprune"',
	},
	"output" => {
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"patmatmotifs" => {
		"perl" => '"patmatmotifs"',
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
	"full" => 2,
	"prune" => 3,
	"outfile" => 4,
	"auto" => 5,
	"patmatmotifs" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"patmatmotifs",
	"sequence",
	"full",
	"prune",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"full" => 0,
	"prune" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 1,
	"patmatmotifs" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"full" => 0,
	"prune" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"full" => 0,
	"prune" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"sequence" => "sequence -- Protein [single sequence] (-sequence)",
	"advanced" => "advanced Section",
	"full" => "Provide full documentation for matching patterns (-full)",
	"prune" => "Ignore simple patterns (-prune)",
	"output" => "output Section",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"full" => 0,
	"prune" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['sequence',],
	"advanced" => ['full','prune',],
	"output" => ['outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"full" => '0',
	"prune" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"full" => { "perl" => '1' },
	"prune" => { "perl" => '1' },
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
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 0,
	"advanced" => 0,
	"full" => 0,
	"prune" => 0,
	"output" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"sequence" => 1,
	"advanced" => 0,
	"full" => 0,
	"prune" => 0,
	"output" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"prune" => [
		"Ignore simple patterns. If this is true then these simple post-translational modification sites are not reported: myristyl, asn_glycosylation, camp_phospho_site, pkc_phospho_site, ck2_phospho_site, and tyr_phospho_site.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/patmatmotifs.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

