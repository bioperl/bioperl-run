
=head1 NAME

Bio::Tools::Run::PiseApplication::quicktree

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::quicktree

      Bioperl class for:

	QuickTree	Rapid reconstruction of phylogenies by the Neighbor-Joining method (Kevin Howe, Alex Bateman, Richard Durbin)

	References:

		Kevin Howe, Alex Bateman and Richard Durbin  (2002). QuickTree: building huge Neighbour-Joining trees of protein sequences. Bioinformatics 18(11):1546-1547.


      Parameters:


		quicktree (String)

		distfile (InFile)
			Distance matrix (-in m)
			pipe: phylip_dist

		out (Excl)
			Output (-out)

		treeopt (Paragraph)
			Tree output options

		upgma (Switch)
			Use the UPGMA method to construct the tree (-upgma)

		aligopt (Paragraph)
			Alignment options

		aligfile (InFile)
			Protein alignment file (instead of distance matrix) (-in a)
			pipe: readseq_ok_alig

		boot (Integer)
			Calculate bootstrap values with n iterations (-boot)

		kimura (Switch)
			Use the kimura translation for pairwise distances (-kimura)

		fastdnaml (String)

		treefile (Results)
			pipe: phylip_tree

		distoutfile (Results)
			pipe: phylip_dist

		stockholmfile (Results)

=cut

#'
package Bio::Tools::Run::PiseApplication::quicktree;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $quicktree = Bio::Tools::Run::PiseApplication::quicktree->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::quicktree object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $quicktree = $factory->program('quicktree');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::quicktree.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/quicktree.pm

    $self->{COMMAND}   = "quicktree";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "QuickTree";

    $self->{DESCRIPTION}   = "Rapid reconstruction of phylogenies by the Neighbor-Joining method";

    $self->{OPT_EMAIL}   = 0;

    $self->{CATEGORIES}   =  [  

         "phylogeny",
  ];

    $self->{AUTHORS}   = "Kevin Howe, Alex Bateman, Richard Durbin";

    $self->{REFERENCE}   = [

         "Kevin Howe, Alex Bateman and Richard Durbin  (2002). QuickTree: building huge Neighbour-Joining trees of protein sequences. Bioinformatics 18(11):1546-1547.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"quicktree",
	"distfile",
	"out",
	"treeopt",
	"aligopt",
	"treefile",
	"distoutfile",
	"stockholmfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"quicktree",
	"distfile", 	# Distance matrix (-in m)
	"out", 	# Output (-out)
	"treeopt", 	# Tree output options
	"upgma", 	# Use the UPGMA method to construct the tree (-upgma)
	"aligopt", 	# Alignment options
	"aligfile", 	# Protein alignment file (instead of distance matrix) (-in a)
	"boot", 	# Calculate bootstrap values with n iterations (-boot)
	"kimura", 	# Use the kimura translation for pairwise distances (-kimura)
	"fastdnaml",
	"treefile",
	"distoutfile",
	"stockholmfile",

    ];

    $self->{TYPE}  = {
	"quicktree" => 'String',
	"distfile" => 'InFile',
	"out" => 'Excl',
	"treeopt" => 'Paragraph',
	"upgma" => 'Switch',
	"aligopt" => 'Paragraph',
	"aligfile" => 'InFile',
	"boot" => 'Integer',
	"kimura" => 'Switch',
	"fastdnaml" => 'String',
	"treefile" => 'Results',
	"distoutfile" => 'Results',
	"stockholmfile" => 'Results',

    };

    $self->{FORMAT}  = {
	"quicktree" => {
		"perl" => '($distfile)? "quicktree -in m" : "quicktree -in a" ',
	},
	"distfile" => {
		"perl" => '" $value"',
	},
	"out" => {
		"perl" => '(defined $value && $value ne $vdef) ? " -out $value" : ""',
	},
	"treeopt" => {
	},
	"upgma" => {
		"perl" => '($value) ? " -upgma" : ""',
	},
	"aligopt" => {
	},
	"aligfile" => {
		"perl" => '($value)? " $value.stockholm" : ""',
	},
	"boot" => {
		"perl" => '(defined $value) ? " -boot $value" : ""',
	},
	"kimura" => {
		"perl" => '($value) ? " -kimura" : ""',
	},
	"fastdnaml" => {
		"perl" => '($aligfile)? "readseq -p -f8 $aligfile > $aligfile.fasta ; sreformat stockholm $aligfile.fasta > $aligfile.stockholm; rm $aligfile.fasta ; " :"" ',
	},
	"treefile" => {
	},
	"distoutfile" => {
	},
	"stockholmfile" => {
	},

    };

    $self->{FILENAMES}  = {
	"treefile" => 'quicktree.out',
	"distoutfile" => 'quicktree.out',
	"stockholmfile" => '"$aligfile.stockholm"',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"quicktree" => 0,
	"distfile" => 10,
	"out" => 3,
	"upgma" => 3,
	"aligfile" => 10,
	"boot" => 3,
	"kimura" => 3,
	"fastdnaml" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"fastdnaml",
	"quicktree",
	"aligopt",
	"treeopt",
	"treefile",
	"distoutfile",
	"stockholmfile",
	"kimura",
	"out",
	"upgma",
	"boot",
	"distfile",
	"aligfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"quicktree" => 1,
	"distfile" => 0,
	"out" => 0,
	"treeopt" => 0,
	"upgma" => 0,
	"aligopt" => 0,
	"aligfile" => 0,
	"boot" => 0,
	"kimura" => 0,
	"fastdnaml" => 1,
	"treefile" => 0,
	"distoutfile" => 0,
	"stockholmfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"quicktree" => 1,
	"distfile" => 0,
	"out" => 0,
	"treeopt" => 0,
	"upgma" => 0,
	"aligopt" => 0,
	"aligfile" => 0,
	"boot" => 0,
	"kimura" => 0,
	"fastdnaml" => 1,
	"treefile" => 0,
	"distoutfile" => 0,
	"stockholmfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"quicktree" => 0,
	"distfile" => 0,
	"out" => 0,
	"treeopt" => 0,
	"upgma" => 0,
	"aligopt" => 0,
	"aligfile" => 0,
	"boot" => 0,
	"kimura" => 0,
	"fastdnaml" => 0,
	"treefile" => 0,
	"distoutfile" => 0,
	"stockholmfile" => 0,

    };

    $self->{PROMPT}  = {
	"quicktree" => "",
	"distfile" => "Distance matrix (-in m)",
	"out" => "Output (-out)",
	"treeopt" => "Tree output options",
	"upgma" => "Use the UPGMA method to construct the tree (-upgma)",
	"aligopt" => "Alignment options",
	"aligfile" => "Protein alignment file (instead of distance matrix) (-in a)",
	"boot" => "Calculate bootstrap values with n iterations (-boot)",
	"kimura" => "Use the kimura translation for pairwise distances (-kimura)",
	"fastdnaml" => "",
	"treefile" => "",
	"distoutfile" => "",
	"stockholmfile" => "",

    };

    $self->{ISSTANDOUT}  = {
	"quicktree" => 0,
	"distfile" => 0,
	"out" => 0,
	"treeopt" => 0,
	"upgma" => 0,
	"aligopt" => 0,
	"aligfile" => 0,
	"boot" => 0,
	"kimura" => 0,
	"fastdnaml" => 0,
	"treefile" => 0,
	"distoutfile" => 0,
	"stockholmfile" => 0,

    };

    $self->{VLIST}  = {

	"out" => ['m','distance matrix in Phylip format(m)','t','tree in New Hampshire format (t)',],
	"treeopt" => ['upgma',],
	"aligopt" => ['aligfile','boot','kimura','fastdnaml',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"out" => 't',
	"upgma" => '0',
	"kimura" => '0',

    };

    $self->{PRECOND}  = {
	"quicktree" => { "perl" => '1' },
	"distfile" => { "perl" => '1' },
	"out" => { "perl" => '1' },
	"treeopt" => { "perl" => '1' },
	"upgma" => {
		"perl" => '$out ne "m"',
	},
	"aligopt" => { "perl" => '1' },
	"aligfile" => { "perl" => '1' },
	"boot" => { "perl" => '1' },
	"kimura" => {
		"perl" => '$aligfile ne ""',
	},
	"fastdnaml" => { "perl" => '1' },
	"treefile" => {
		"perl" => '$out ne "m"',
	},
	"distoutfile" => {
		"perl" => '$out eq "m"',
	},
	"stockholmfile" => {
		"perl" => '$aligfile',
	},

    };

    $self->{CTRL}  = {
	"distfile" => {
		"perl" => {
			'! $distfile && ! $aligfile' => "You must enter either a distance matrix or a  protein alignment",
		},
	},
	"boot" => {
		"perl" => {
			'$value && $out eq "m"' => "Bootstrapping is not available for a matrix output",
			'$value && $distfile && (!$aligfile) ' => "Bootstrapping is not available for a matrix input",
		},
	},

    };

    $self->{PIPEOUT}  = {
	"treefile" => {
		 '1' => "phylip_tree",
	},
	"distoutfile" => {
		 '1' => "phylip_dist",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"distfile" => {
		 "phylip_dist" => '1',
	},
	"aligfile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"quicktree" => 0,
	"distfile" => 0,
	"out" => 0,
	"treeopt" => 0,
	"upgma" => 0,
	"aligopt" => 0,
	"aligfile" => 0,
	"boot" => 0,
	"kimura" => 0,
	"fastdnaml" => 0,
	"treefile" => 0,
	"distoutfile" => 0,
	"stockholmfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"quicktree" => 0,
	"distfile" => 1,
	"out" => 0,
	"treeopt" => 0,
	"upgma" => 0,
	"aligopt" => 0,
	"aligfile" => 0,
	"boot" => 0,
	"kimura" => 0,
	"fastdnaml" => 0,
	"treefile" => 0,
	"distoutfile" => 0,
	"stockholmfile" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/quicktree.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

