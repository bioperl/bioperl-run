
=head1 NAME

Bio::Tools::Run::PiseApplication::treealign

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::treealign

      Bioperl class for:

	treealign	phylogenetic alignment of homologous sequences (J. Hein)

	References:

		Hein, J.: Unified approach to alignment and phylogenies. Meth. Enzymol. 183:626-645 (1990).

		Hein, J.: A new method that simultaneously aligns and reconstruct ancestral sequences for any number of homologous sequences, when the phylogeny is given. Mol. Biol. Evol. 6:649-668 (1989). 

		Hein, J.: A tree reconstruction method that is economical in the number of pairwise comparisons used. Mol. Biol. Evol. 6:669-684 (1989). 


      Parameters:


		treealign (String)


		param (Results)


		results (Results)


		fileseq (Sequence)
			Sequences File
			pipe: seqsfile

		seqtype (Excl)
			Sequence type

		nuseq (Integer)
			Number of sequences

		gap_open (Integer)
			Gap open penalty

		gap_ext (Integer)
			Gap extension penalty

		other_options (Paragraph)
			Other options

		ancesterout (Switch)
			Present ancestral sequences

		usertree (Switch)
			User tree

		usertreefile (InFile)
			Your tree file

		filetree (OutFile)


		fileali (OutFile)


=cut

#'
package Bio::Tools::Run::PiseApplication::treealign;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $treealign = Bio::Tools::Run::PiseApplication::treealign->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::treealign object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $treealign = $factory->program('treealign');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::treealign.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/treealign.pm

    $self->{COMMAND}   = "treealign";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "treealign";

    $self->{DESCRIPTION}   = "phylogenetic alignment of homologous sequences";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{AUTHORS}   = "J. Hein";

    $self->{REFERENCE}   = [

         "Hein, J.: Unified approach to alignment and phylogenies. Meth. Enzymol. 183:626-645 (1990).",

         "Hein, J.: A new method that simultaneously aligns and reconstruct ancestral sequences for any number of homologous sequences, when the phylogeny is given. Mol. Biol. Evol. 6:649-668 (1989). ",

         "Hein, J.: A tree reconstruction method that is economical in the number of pairwise comparisons used. Mol. Biol. Evol. 6:669-684 (1989). ",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"treealign",
	"param",
	"results",
	"fileseq",
	"seqtype",
	"nuseq",
	"gap_open",
	"gap_ext",
	"other_options",
	"filetree",
	"fileali",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"treealign",
	"param",
	"results",
	"fileseq", 	# Sequences File
	"seqtype", 	# Sequence type
	"nuseq", 	# Number of sequences
	"gap_open", 	# Gap open penalty
	"gap_ext", 	# Gap extension penalty
	"other_options", 	# Other options
	"ancesterout", 	# Present ancestral sequences
	"usertree", 	# User tree
	"usertreefile", 	# Your tree file
	"filetree",
	"fileali",

    ];

    $self->{TYPE}  = {
	"treealign" => 'String',
	"param" => 'Results',
	"results" => 'Results',
	"fileseq" => 'Sequence',
	"seqtype" => 'Excl',
	"nuseq" => 'Integer',
	"gap_open" => 'Integer',
	"gap_ext" => 'Integer',
	"other_options" => 'Paragraph',
	"ancesterout" => 'Switch',
	"usertree" => 'Switch',
	"usertreefile" => 'InFile',
	"filetree" => 'OutFile',
	"fileali" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"treealign" => {
		"seqlab" => 'treealign',
		"perl" => '"treealign"',
	},
	"param" => {
	},
	"results" => {
	},
	"fileseq" => {
		"perl" => '"$value\\n"',
	},
	"seqtype" => {
		"perl" => '"$value"',
	},
	"nuseq" => {
		"perl" => '" $value"',
	},
	"gap_open" => {
		"perl" => '" $value"',
	},
	"gap_ext" => {
		"perl" => '" $value\\n"',
	},
	"other_options" => {
	},
	"ancesterout" => {
		"perl" => '($value)? "1" : "0" ',
	},
	"usertree" => {
		"perl" => '($value)? " 1\\n" : " 0\\n" ',
	},
	"usertreefile" => {
		"perl" => '"$value\\n" ',
	},
	"filetree" => {
		"perl" => '"$fileseq.tree\\n" ',
	},
	"fileali" => {
		"perl" => '"$fileseq.ali\\n" ',
	},

    };

    $self->{FILENAMES}  = {
	"param" => 'par.dat',
	"results" => '*.ali *.tree',

    };

    $self->{SEQFMT}  = {
	"fileseq" => [3],

    };

    $self->{GROUP}  = {
	"treealign" => 0,
	"fileseq" => 30,
	"seqtype" => 11,
	"nuseq" => 12,
	"gap_open" => 13,
	"gap_ext" => 14,
	"ancesterout" => 21,
	"usertree" => 22,
	"usertreefile" => 60,
	"filetree" => 40,
	"fileali" => 50,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"treealign",
	"param",
	"results",
	"other_options",
	"seqtype",
	"nuseq",
	"gap_open",
	"gap_ext",
	"ancesterout",
	"usertree",
	"fileseq",
	"filetree",
	"fileali",
	"usertreefile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"treealign" => 1,
	"param" => 0,
	"results" => 0,
	"fileseq" => 0,
	"seqtype" => 0,
	"nuseq" => 0,
	"gap_open" => 0,
	"gap_ext" => 0,
	"other_options" => 0,
	"ancesterout" => 0,
	"usertree" => 0,
	"usertreefile" => 0,
	"filetree" => 1,
	"fileali" => 1,

    };

    $self->{ISCOMMAND}  = {
	"treealign" => 1,
	"param" => 0,
	"results" => 0,
	"fileseq" => 0,
	"seqtype" => 0,
	"nuseq" => 0,
	"gap_open" => 0,
	"gap_ext" => 0,
	"other_options" => 0,
	"ancesterout" => 0,
	"usertree" => 0,
	"usertreefile" => 0,
	"filetree" => 0,
	"fileali" => 0,

    };

    $self->{ISMANDATORY}  = {
	"treealign" => 0,
	"param" => 0,
	"results" => 0,
	"fileseq" => 1,
	"seqtype" => 1,
	"nuseq" => 1,
	"gap_open" => 1,
	"gap_ext" => 1,
	"other_options" => 0,
	"ancesterout" => 0,
	"usertree" => 0,
	"usertreefile" => 0,
	"filetree" => 0,
	"fileali" => 0,

    };

    $self->{PROMPT}  = {
	"treealign" => "",
	"param" => "",
	"results" => "",
	"fileseq" => "Sequences File",
	"seqtype" => "Sequence type",
	"nuseq" => "Number of sequences",
	"gap_open" => "Gap open penalty",
	"gap_ext" => "Gap extension penalty",
	"other_options" => "Other options",
	"ancesterout" => "Present ancestral sequences",
	"usertree" => "User tree",
	"usertreefile" => "Your tree file",
	"filetree" => "",
	"fileali" => "",

    };

    $self->{ISSTANDOUT}  = {
	"treealign" => 0,
	"param" => 0,
	"results" => 0,
	"fileseq" => 0,
	"seqtype" => 0,
	"nuseq" => 0,
	"gap_open" => 0,
	"gap_ext" => 0,
	"other_options" => 0,
	"ancesterout" => 0,
	"usertree" => 0,
	"usertreefile" => 0,
	"filetree" => 0,
	"fileali" => 0,

    };

    $self->{VLIST}  = {

	"seqtype" => ['1','1: protein','0','0: DNA',],
	"other_options" => ['ancesterout','usertree','usertreefile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"ancesterout" => '0',
	"usertree" => '0',

    };

    $self->{PRECOND}  = {
	"treealign" => { "perl" => '1' },
	"param" => { "perl" => '1' },
	"results" => { "perl" => '1' },
	"fileseq" => { "perl" => '1' },
	"seqtype" => { "perl" => '1' },
	"nuseq" => { "perl" => '1' },
	"gap_open" => { "perl" => '1' },
	"gap_ext" => { "perl" => '1' },
	"other_options" => { "perl" => '1' },
	"ancesterout" => { "perl" => '1' },
	"usertree" => { "perl" => '1' },
	"usertreefile" => {
		"perl" => '$usertree',
	},
	"filetree" => { "perl" => '1' },
	"fileali" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"gap_open" => {
		"perl" => {
			'$value < 0' => "Enter a non-negative value",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"fileseq" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"treealign" => 0,
	"param" => 0,
	"results" => 0,
	"fileseq" => 0,
	"seqtype" => 0,
	"nuseq" => 0,
	"gap_open" => 0,
	"gap_ext" => 0,
	"other_options" => 0,
	"ancesterout" => 0,
	"usertree" => 0,
	"usertreefile" => 0,
	"filetree" => 0,
	"fileali" => 0,

    };

    $self->{ISSIMPLE}  = {
	"treealign" => 1,
	"param" => 0,
	"results" => 0,
	"fileseq" => 1,
	"seqtype" => 1,
	"nuseq" => 1,
	"gap_open" => 1,
	"gap_ext" => 1,
	"other_options" => 0,
	"ancesterout" => 0,
	"usertree" => 0,
	"usertreefile" => 0,
	"filetree" => 0,
	"fileali" => 0,

    };

    $self->{PARAMFILE}  = {
	"fileseq" => "par.dat",
	"seqtype" => "par.dat",
	"nuseq" => "par.dat",
	"gap_open" => "par.dat",
	"gap_ext" => "par.dat",
	"ancesterout" => "par.dat",
	"usertree" => "par.dat",
	"usertreefile" => "par.dat",
	"filetree" => "par.dat",
	"fileali" => "par.dat",

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/treealign.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

