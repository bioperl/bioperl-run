
=head1 NAME

Bio::Tools::Run::PiseApplication::cons

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::cons

      Bioperl class for:

	CONS	Creates a consensus from multiple alignments (EMBOSS)

      Parameters:


		cons (String)
			

		init (String)
			

		input (Paragraph)
			input Section

		msf (Sequence)
			msf -- gapany [set of sequences] (-msf)
			pipe: seqsfile

		advanced (Paragraph)
			advanced Section

		datafile (Excl)
			Scoring matrix (-datafile)

		plurality (Float)
			Plurality check value (-plurality)

		identity (Integer)
			Required number of identities at a position (-identity)

		output (Paragraph)
			output Section

		outseq (OutFile)
			outseq (-outseq)
			pipe: seqfile

		outseq_sformat (Excl)
			Output format for: outseq

		name (String)
			Name of the consensus sequence (-name)

		setcase (Float)
			Define a threshold above which the consensus is given in uppercase (-setcase)

		auto (String)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::cons;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $cons = Bio::Tools::Run::PiseApplication::cons->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::cons object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $cons = $factory->program('cons');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::cons.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cons.pm

    $self->{COMMAND}   = "cons";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CONS";

    $self->{DESCRIPTION}   = "Creates a consensus from multiple alignments (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "alignment:consensus",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/cons.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"cons",
	"init",
	"input",
	"advanced",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"cons",
	"init",
	"input", 	# input Section
	"msf", 	# msf -- gapany [set of sequences] (-msf)
	"advanced", 	# advanced Section
	"datafile", 	# Scoring matrix (-datafile)
	"plurality", 	# Plurality check value (-plurality)
	"identity", 	# Required number of identities at a position (-identity)
	"output", 	# output Section
	"outseq", 	# outseq (-outseq)
	"outseq_sformat", 	# Output format for: outseq
	"name", 	# Name of the consensus sequence (-name)
	"setcase", 	# Define a threshold above which the consensus is given in uppercase (-setcase)
	"auto",

    ];

    $self->{TYPE}  = {
	"cons" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"msf" => 'Sequence',
	"advanced" => 'Paragraph',
	"datafile" => 'Excl',
	"plurality" => 'Float',
	"identity" => 'Integer',
	"output" => 'Paragraph',
	"outseq" => 'OutFile',
	"outseq_sformat" => 'Excl',
	"name" => 'String',
	"setcase" => 'Float',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"msf" => {
		"perl" => '" -msf=$value -sformat=fasta"',
	},
	"advanced" => {
	},
	"datafile" => {
		"perl" => '($value)? " -datafile=$value" : ""',
	},
	"plurality" => {
		"perl" => '(defined $value && $value != $vdef)? " -plurality=$value" : ""',
	},
	"identity" => {
		"perl" => '(defined $value && $value != $vdef)? " -identity=$value" : ""',
	},
	"output" => {
	},
	"outseq" => {
		"perl" => '" -outseq=$value"',
	},
	"outseq_sformat" => {
		"perl" => '" -osformat=$value"',
	},
	"name" => {
		"perl" => '($value)? " -name=$value" : ""',
	},
	"setcase" => {
		"perl" => '(defined $value && $value != $vdef)? " -setcase=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"cons" => {
		"perl" => '"cons"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"msf" => [8],

    };

    $self->{GROUP}  = {
	"init" => -10,
	"msf" => 1,
	"datafile" => 2,
	"plurality" => 3,
	"identity" => 4,
	"outseq" => 5,
	"outseq_sformat" => 6,
	"name" => 7,
	"setcase" => 8,
	"auto" => 9,
	"cons" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"advanced",
	"output",
	"cons",
	"msf",
	"datafile",
	"plurality",
	"identity",
	"outseq",
	"outseq_sformat",
	"name",
	"setcase",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"name" => 0,
	"setcase" => 0,
	"auto" => 1,
	"cons" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"name" => 0,
	"setcase" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 0,
	"name" => 0,
	"setcase" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"msf" => "msf -- gapany [set of sequences] (-msf)",
	"advanced" => "advanced Section",
	"datafile" => "Scoring matrix (-datafile)",
	"plurality" => "Plurality check value (-plurality)",
	"identity" => "Required number of identities at a position (-identity)",
	"output" => "output Section",
	"outseq" => "outseq (-outseq)",
	"outseq_sformat" => "Output format for: outseq",
	"name" => "Name of the consensus sequence (-name)",
	"setcase" => "Define a threshold above which the consensus is given in uppercase (-setcase)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"name" => 0,
	"setcase" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['msf',],
	"advanced" => ['datafile','plurality','identity',],
	"datafile" => ['EPAM60','EPAM60','EPAM290','EPAM290','EPAM470','EPAM470','EPAM110','EPAM110','EBLOSUM50','EBLOSUM50','EPAM220','EPAM220','EBLOSUM62-12','EBLOSUM62-12','EPAM400','EPAM400','EPAM150','EPAM150','EPAM330','EPAM330','EBLOSUM55','EBLOSUM55','EPAM30','EPAM30','EPAM260','EPAM260','EBLOSUM90','EBLOSUM90','EPAM440','EPAM440','EPAM190','EPAM190','EPAM370','EPAM370','EPAM70','EPAM70','EPAM480','EPAM480','EPAM120','EPAM120','EDNAMAT','EDNAMAT','EPAM300','EPAM300','EBLOSUM60','EBLOSUM60','EPAM230','EPAM230','EBLOSUM62','EBLOSUM62','EPAM410','EPAM410','EPAM160','EPAM160','EPAM340','EPAM340','EBLOSUM65','EBLOSUM65','EPAM40','EPAM40','EPAM270','EPAM270','EPAM450','EPAM450','EPAM380','EPAM380','EPAM80','EPAM80','EPAM490','EPAM490','EBLOSUM30','EBLOSUM30','EBLOSUMN','EBLOSUMN','EPAM200','EPAM200','EPAM130','EPAM130','EBLOSUM35','EBLOSUM35','EPAM310','EPAM310','EBLOSUM70','EBLOSUM70','EPAM10','EPAM10','EPAM240','EPAM240','EPAM420','EPAM420','EPAM170','EPAM170','EBLOSUM75','EBLOSUM75','EPAM350','EPAM350','EPAM280','EPAM280','EPAM50','EPAM50','EPAM460','EPAM460','EPAM390','EPAM390','EPAM90','EPAM90','EPAM100','EPAM100','EBLOSUM40','EBLOSUM40','EPAM210','EPAM210','EPAM140','EPAM140','EBLOSUM45','EBLOSUM45','EPAM320','EPAM320','EBLOSUM80','EBLOSUM80','EPAM500','EPAM500','EPAM20','EPAM20','EPAM250','EPAM250','EPAM430','EPAM430','EPAM180','EPAM180','EBLOSUM85','EBLOSUM85','EPAM360','EPAM360',],
	"output" => ['outseq','outseq_sformat','name','setcase',],
	"outseq_sformat" => ['fasta','fasta','gcg','gcg','phylip','phylip','embl','embl','swiss','swiss','ncbi','ncbi','nbrf','nbrf','genbank','genbank','ig','ig','codata','codata','strider','strider','acedb','acedb','staden','staden','text','text','fitch','fitch','msf','msf','clustal','clustal','phylip','phylip','phylip3','phylip3','asn1','asn1',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"identity" => '0',
	"outseq" => 'outseq.out',
	"outseq_sformat" => 'fasta',
	"setcase" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"msf" => { "perl" => '1' },
	"advanced" => { "perl" => '1' },
	"datafile" => { "perl" => '1' },
	"plurality" => { "perl" => '1' },
	"identity" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"outseq" => { "perl" => '1' },
	"outseq_sformat" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"setcase" => { "perl" => '1' },
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
	"msf" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 0,
	"advanced" => 0,
	"datafile" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outseq" => 0,
	"outseq_sformat" => 0,
	"name" => 0,
	"setcase" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"msf" => 1,
	"advanced" => 0,
	"datafile" => 0,
	"plurality" => 0,
	"identity" => 0,
	"output" => 0,
	"outseq" => 1,
	"outseq_sformat" => 1,
	"name" => 0,
	"setcase" => 0,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"msf" => [
		"File containing a sequence alignment.",
	],
	"plurality" => [
		"Set a cut-off for the number of positive matches below which there is no consensus. The default plurality is taken as half the total weight of all the sequences in the alignment.",
	],
	"identity" => [
		"Provides the facility of setting the required number of identities at a site for it to give a consensus at that position. Therefore, if this is set to the number of sequences in the alignment only columns of identities contribute to the consensus.",
	],
	"setcase" => [
		"Sets the threshold for the positive matches above which the consensus is is upper-case and below which the consensus is in lower-case.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/cons.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

