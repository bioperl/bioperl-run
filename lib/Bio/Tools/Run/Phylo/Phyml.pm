#
# BioPerl module for Bio::Tools::Run::Phylo::Phyml
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Heikki Lehvaslaiho
#
# Copyright Heikki Lehvaslaiho
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Phyml - Wrapper for rapid reconstruction of phylogenies using Phyml

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Phyml;

  #  Make a Phyml factory
  $factory = Bio::Tools::Run::Phylo::Phyml->new(-verbose => 2);
  # it defaults to protein alignment
  # change parameters
  $factory->model('Dayhoff');
  #  Pass the factory an alignment and run
  $inputfilename = 't/data/protpars.phy';
  $tree = $factory->run($inputfilename); # $tree is a Bio::Tree::Tree object.


  # or set parameters at object creation
  my %args = (
      -data_type => 'dna',
      -model => 'HKY',
      -kappa => 4,
      -invar => 'e',
      -category_number => 4,
      -alpha => 'e',
      -tree => 'BIONJ',
      -opt_topology => '0',
      -opt_lengths => '1',
      );
  $factory = Bio::Tools::Run::Phylo::Phyml->new(%args);
  # if you need the output files do
  $factory->save_tempfiles(1);
  $factory->tempdir($workdir);

  # and get a Bio::Align::AlignI (SimpleAlign) object from somewhere
  $tree = $factory->run($aln);

=head1 DESCRIPTION

This is a wrapper for running the phyml application by Stephane
Guindon and Olivier Gascuel. You can download it from:
http://atgc.lirmm.fr/phyml/

=head2 Installing

After downloading, you need to rename a the copy of the program that
runs under your operating system. I.e. C<phyml_linux> into C<phyml>.

You will need to help this Phyml wrapper to find the C<phyml> program.
This can be done in (at least) three ways:

=over

=item 1.

Make sure the Phyml executable is in your path. Copy it to, or create
a symbolic link from a directory that is in your path.

=item 2.

Define an environmental variable PHYMLDIR which is a
directory which contains the 'phyml' application: In bash:

  export PHYMLDIR=/home/username/phyml_v2.4.4/exe

In csh/tcsh:

  setenv PHYMLDIR /home/username/phyml_v2.4.4/exe

=item 3.

Include a definition of an environmental variable PHYMLDIR in
every script that will use this Phyml wrapper module, e.g.:

  BEGIN { $ENV{PHYMLDIR} = '/home/username/phyml_v2.4.4/exe' }
  use Bio::Tools::Run::Phylo::Phyml;

=back

=head2 Running

This wrapper has been tested with PHYML v2.4.4 and v.3.0

In its current state, the wrapper supports only input of one MSA and
output of one tree. It can easily be extended to support more advanced
capabilities of C<phyml>.

Two convienience methods have been added on top of the standard
BioPerl WrapperBase ones: stats() and tree_string(). You can call them
to after running the phyml program to retrieve into a string the statistics
and the tree in Newick format.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Heikki Lehvaslaiho

heikki at bioperl dot org

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phylo::Phyml;
use strict;

use Bio::AlignIO;
use File::Copy;
use File::Spec;

use Bio::TreeIO;

use base qw(Bio::Tools::Run::WrapperBase);

our $PROGRAM_NAME = 'phyml';
our $PROGRAM_DIR = $ENV{'PHYMLDIR'};



# valid substitution model names
our $models;
# DNA
map { $models->{0}->{$_} = 1 } qw(JC69 K2P F81 HKY F84 TN93 GTR);
# protein
map { $models->{1}->{$_} = 1 } qw(JTT MtREV Dayhoff WAG);

our $models3;
# DNA
map { $models3->{'nt'}->{$_} = 1 } qw(HKY85 JC69 K80 F81 F84 TN93 GTR );
# protein
map { $models3->{'aa'}->{$_} = 1 }
    qw(WAG JTT MtREV Dayhoff DCMut RtREV CpREV VT Blosum62 MtMam MtArt HIVw  HIVb );

=head2 new

 Title   : new
 Usage   : $factory = Bio::Tools::Run::Phylo::Phyml->new(@params)
 Function: creates a new Phyml factory
 Returns : Bio::Tools::Run::Phylo::Phyml
 Args    : Optionally, provide any of the following (default in []):
           -data_type       => 'dna' or 'protein',   [protein]
           -dataset_count   => 'integer,             [1]
           -model           => 'HKY'... ,            [HKY|JTT]
           -kappa           => 'e' or float,         [e]
           -invar           => 'e' or float,         [e]
           -category_number => integer,              [1]
           -alpha           => 'e' or float (int v3),[e]
           -tree            => 'BIONJ' or your own,  [BION]
           -opt_topology    => boolean               [y]
           -opt_lengths     => boolean               [y]

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);

    # for consistency with other run modules, allow params to be dashless
    my %args = @args;
    while (my ($key, $val) = each %args) {
        if ($key !~ /^-/) {
            delete $args{$key};
            $args{'-'.$key} = $val;
        }
    }

    my ($data_type, $data_format, $dataset_count, $model, $freq, $kappa, $invar,
	$category_number, $alpha, $tree, $opt_topology,
	$opt_lengths, $opt, $search, $rand_start, $rand_starts, $rand_seed)
        = $self->_rearrange([qw( DATA_TYPE
				 DATA_FORMAT
				 DATASET_COUNT
				 MODEL
				 FREQ
				 KAPPA
				 INVAR
				 CATEGORY_NUMBER
				 ALPHA
				 TREE
				 OPT_TOPOLOGY
				 OPT_LENGTHS
				 OPT
				 SEARCH
				 RAND_START
				 RAND_STARTS
				 RAND_SEED
			      )], %args);

    $self->data_type($data_type) if $data_type;
    $self->data_format($data_format) if $data_format;
    $self->dataset_count($dataset_count) if $dataset_count;
    $self->model($model) if $model;
    $self->freq($freq) if $freq;
    $self->kappa($kappa) if $kappa;
    $self->invar($invar) if $invar;
    $self->category_number($category_number) if $category_number;
    $self->alpha($alpha) if $alpha;
    $self->tree($tree) if $tree;
    $self->opt_topology($opt_topology) if $opt_topology;
    $self->opt_lengths($opt_lengths) if $opt_lengths;
    $self->opt($opt) if $opt;
    $self->search($search) if $search;
    $self->rand_start($rand_start) if $rand_start;
    $self->rand_starts($rand_starts) if $rand_starts;
    $self->rand_seed($rand_seed) if $rand_seed;


    return $self;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns : string
 Args    : None

=cut

sub program_name {
    return $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns : string
 Args    : None

=cut

sub program_dir {
    return $PROGRAM_DIR;
}

=head2  version

 Title   : version
 Usage   : exit if $prog->version < 1.8
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

Phyml before 3.0 did not display the version. Assume 2.44 when can not
determine it.

=cut

sub version {
    my $self = shift;

    return $self->{'_version'} if defined $self->{'_version'};
    my $exe = $self->executable || return;
    my $string = substr `$exe --help`, 0, 40 ;
    my ($version) = $string =~ /PhyML v([\d+\.]+)/;
    $self->{'_version'} = $version;
    $version ? (return $version) : return '2.44'
}


=head2 run

 Title   : run
 Usage   : $factory->run($aln_file);
           $factory->run($align_object);
 Function: Runs Phyml to generate a tree 
 Returns : Bio::Tree::Tree object
 Args    : file name for your input alignment in a format 
           recognised by AlignIO, OR  Bio::Align::AlignI
           complient object (eg. Bio::SimpleAlign).

=cut

sub run {
    my ($self, $in) = @_;

    if (ref $in && $in->isa("Bio::Align::AlignI")) {
        $in = $self->_write_phylip_align_file($in);
    }
    elsif (! -e $in) {
        $self->throw("When not supplying a Bio::Align::AlignI object, ".
		     "you must supply a readable filename");
    }
    elsif (-e $in) {
	copy ($in, $self->tempdir);
	my $name = File::Spec->splitpath($in); # name is the last item in the array
	$in = File::Spec->catfile($self->tempdir, $name);
    }

    return $self->_run($in);
}

=head2 stats

 Title   : stats
 Usage   : $factory->stats;
 Function: Returns the contents of the phyml '_phyml_stat.txt' output file
 Returns : string with statistics about the run, undef before run()
 Args    : none

=cut

sub stats {
    my $self = shift;;
    return $self->{_stats};
}

=head2 tree_string

 Title   : tree_string
 Usage   : $factory->tree_string;
           $factory->run($align_object);
 Function: Returns the contents of the phyml '_phyml_tree.txt' ouput file
 Returns : string with tree in Newick format, undef before run()
 Args    : none

=cut

sub tree_string {
    my $self = shift;;
    return $self->{_tree};
}

=head2 Getsetters

These methods are used to set and get program parameters before running.

=head2 data_type

 Title   : data_type
 Usage   : $phyml->data_type('nt');
 Function: Sets sequence alphabet to 'dna' (nt in v3) or 'aa'
           If leaved unset, will be set automatically
 Returns : set value, defaults to  'protein'
 Args    : None to get, 'dna' ('nt') or 'aa' to set.

=cut

sub data_type {
    my ($self, $value) = @_;
    if ($self->version && $self->version >= 3 ) {
	if (defined $value) {
	    if ($value eq 'nt') {
		$self->{_data_type} = 'nt';
	    } else {
		$self->{_data_type} = 'aa';
	    }
	}
	return 'aa' unless defined $self->{_data_type};
    } else {
	if (defined $value) {
	    if ($value eq 'dna') {
		$self->{_data_type} = '0';
	    } else {
		$self->{_data_type} = '1';
	    }
	}
	return '1' unless defined $self->{_data_type};
    }
    return $self->{_data_type};
}


=head2 data_format

 Title   : data_format
 Usage   : $phyml->data_format('s');
 Function: Sets PHYLIP format to 'i' interleaved or
           's' sequential
 Returns : set value, defaults to  'i'
 Args    : None to get, 'i' or 's' to set.

=cut

sub data_format {
    my ($self, $value) = @_;
    if (defined $value) {
	$self->throw("PHYLIP format must be 'i' or 's'")
	    unless $value eq 'i' or $value eq 's';
	$self->{_data_format} = $value;
    }
    return $self->{_data_format} || 'i';
}

=head2 dataset_count

 Title   : dataset_count
 Usage   : $phyml->dataset_count(3);
 Function: Sets dataset number to deal with
 Returns : set value, defaults to 1
 Args    : None to get, positive integer to set.

=cut

sub dataset_count {
    my ($self, $value) = @_;
    if (defined $value) {
	die "Invalid positive integer [$value]"
	    unless $value =~ /^[-+]?\d*$/ and $value > 0;
	$self->{_dataset_count} = $value;
    }
    return $self->{_dataset_count} || 1;
}



=head2 model

 Title   : model
 Usage   : $phyml->model('HKY');
 Function: Choose the substitution model to use. One of

           JC69 | K2P | F81 | HKY | F84 | TN93 | GTR (DNA)
           JTT | MtREV | Dayhoff | WAG (amino acids)

           v3.0:
           HKY85 (default) | JC69 | K80 | F81 | F84 |
           TN93 | GTR (DNA)
           WAG (default) | JTT | MtREV | Dayhoff | DCMut |
           RtREV | CpREV | VT | Blosum62 | MtMam | MtArt |
           HIVw |  HIVb (amino acids)

 Returns : Name of the model, defaults to {HKY|JTT}
 Args    : None to get, string to set.

=cut

sub model {
    my ($self, $value) = @_;
    if (defined ($value)) {
	if ($self->version && $self->version >= 3 ) {
	    unless ($value =~ /\d{6}/) {
		$self->throw("Not a valid model name [$value] for current data type (alphabet)")
		unless $models3->{$self->data_type}->{$value};
	    }
	} else {
	    $self->throw("Not a valid model name [$value] for current data type (alphabet)")
	    unless $models->{$self->data_type}->{$value};
	}
	$self->{_model} = $value;
    }


    if ($self->{_model}) {
	return $self->{_model};
    }

    if ($self->version && $self->version >= 3 ) {
	if ($self->data_type eq 'aa') {
	    return 'WAG'; # protein
	} else {
	    return 'HKY85'; # DNA
	}
    } else {
	if ($self->data_type) {
	    return 'JTT'; # protein
	} else {
	    return 'HKY'; # DNA
	}
    }
}


=head2 kappa

 Title   : kappa
 Usage   : $phyml->kappa(4);
 Function: Sets transition/transversion ratio, leave unset to estimate
 Returns : set value, defaults to 'e'
 Args    : None to get, float or integer to set.

=cut

sub kappa {
    my ($self, $value) = @_;
    if (defined $value) {
	die "Invalid number [$value]" 
	    unless $value =~ /^[-+]?\d*\.?\d*$/ or $value eq 'e';
	$self->{_kappa} = $value;
    }
    return 'e' unless defined $self->{_kappa};
    return 'e' if $self->{_kappa} eq 'e';
    return sprintf("%.1f", $self->{_kappa});
}


=head2 invar

 Title   : invar
 Usage   : $phyml->invar(.3);
 Function: Sets proportion of invariable sites, leave unset to estimate
 Returns : set value, defaults to 'e'
 Args    : None to get, float or integer to set.

=cut

sub invar {
    my ($self, $value) = @_;
    if (defined $value) {
	die "Invalid number [$value]" 
	    unless $value =~ /^[-+]?\d*\.\d*$/ or $value eq 'e';
	$self->{_invar} = $value;
    }
    return 'e' unless defined $self->{_invar};
    return 'e' if $self->{_invar} eq 'e';
    return sprintf("%.1f", $self->{_invar});
}


=head2 category_number

 Title   : category_number
 Usage   : $phyml->category_number(4);
 Function: Sets number of relative substitution rate categories
 Returns : set value, defaults to 1
 Args    : None to get, integer to set.

=cut

sub category_number {
    my ($self, $value) = @_;
    if (defined $value) {
	die "Invalid postive integer [$value]" 
	    unless $value =~ /^[+]?\d*$/ and $value > 0;
	$self->{_category_number} = $value;
    }
    return $self->{_category_number} || 1;
}



=head2 alpha

 Title   : alpha
 Usage   : $phyml->alpha(1.0);
 Function: Sets  gamma distribution parameter, leave unset to estimate
 Returns : set value, defaults to 'e'
 Args    : None to get, float or integer to set.

=cut

sub alpha {
    my ($self, $value) = @_;
    if (defined $value) {
	die "Invalid number [$value]"
	    unless $value =~ /^[-+]?\d*\.?\d*$/ or $value eq 'e';
	$self->{_alpha} = $value;
    }
    return 'e' unless defined $self->{_alpha};
    return 'e' if $self->{_alpha} eq 'e';
    return sprintf("%.1f", $self->{_alpha}) || 'e';
}

=head2 tree

 Title   : tree
 Usage   : $phyml->tree('/tmp/tree.nwk');
 Function: Sets starting tree, leave unset to estimate a distance tree
 Returns : set value, defaults to 'BIONJ'
 Args    : None to get, newick tree file name to set.

=cut


sub tree {
    my ($self, $value) = @_;
    if (defined $value) {
	die "Invalid number [$value]" 
	    unless -e $value or $value eq 'BIONJ';
	$self->{_tree} = $value;
    }
    return $self->{_tree} || 'BIONJ';
}

=head2 v2 options

These methods can be used with PhyML v2* only.

=head2 opt_topology

 Title   : opt_topology
 Usage   : $factory->opt_topology(1);
 Function: Choose to optimise the tree topology
 Returns : {y|n} (default y)
 Args    : None to get, boolean to set.

v2.* only

=cut

sub opt_topology {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [opt_topology] for to PhyML v3") if $self->version && $self->version >= 3;
    if (defined ($value)) {
        if ($value) {
	    $self->{_opt_topology} = 'y';
	} else {
	    $self->{_opt_topology} = 'n';
	}
    }
    return $self->{_opt_topology} || 'y';
}

=head2 opt_lengths

 Title   : opt_lengths
 Usage   : $factory->opt_lengths(0);
 Function: Choose to  optimise branch lengths and rate parameters 
 Returns : {y|n} (default y)
 Args    : None to get, boolean to set.


v2.* only

=cut

sub opt_lengths {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [opt_lengths] for PhyML v3") if $self->version && $self->version >= 3;
    if (defined ($value)) {
        if ($value) {
	    $self->{_opt_lengths} = 'y';
	} else {
	    $self->{_opt_lengths} = 'n';
	}
    }
    return $self->{_opt_lengths} || 'y';
}

=head2 v3 options

These methods can be used with PhyML v3* only.

=head2 freq

 Title   : freq
 Usage   : $phyml->freq(e); $phyml->freq("0.2, 0.6, 0.6, 0.2");
 Function: Sets nucleotide frequences or asks residue to be estimated
            according to two models: e or d
 Returns : set value,
 Args    : None to get, string to set.

v3 only.

=cut

sub freq {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [freq] prior to PhyML v3") if $self->version < 3;
    if (defined $value) {
	die "Invalid value [$value]"
	    unless $value =~ /^[\d\. ]$/ or $value eq 'e' or $value eq 'd';
	$self->{_freq} = $value;
    }
    return $self->{_freq};
}

=head2 opt

 Title   : opt
 Usage   : $factory->opt(1);
 Function: Optimise tree parameters: tlr|tl|tr|l|n
 Returns : {value|n} (default n)
 Args    : None to get, string to set.

v3.* only

=cut

sub opt {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [opt] prior to PhyML v3") if $self->version < 3;
    if (defined ($value)) {
	$self->{_opt} = $value if $value =~ /tlr|tl|tr|l|n/;
    }
    return $self->{_opt} || 'n';
}

=head2 search

 Title   : search
 Usage   : $factory->search(SPR);
 Function: Tree topology search operation algorithm: NNI|SPR|BEST
 Returns : string (defaults to NNI)
 Args    : None to get, string to set.

v3.* only

=cut

sub search {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [search] prior to PhyML v3") if $self->version < 3;
    if (defined ($value)) {
	$self->{_search} = $value if $value =~ /NNI|SPR|BEST/;
    }
    return $self->{_search} || 'NNI';
}

=head2 rand_start

 Title   : rand_start
 Usage   : $factory->rand_start(1);
 Function: Sets the initial SPR tree to random.
 Returns : boolean (defaults to false)
 Args    : None to get, boolean to set.

v3.* only; only meaningful if $prog-E<gt>search is 'SPR'

=cut


sub rand_start {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [rand_start] prior to PhyML v3") if $self->version < 3;
    if (defined ($value)) {
        if ($value) {
	    $self->{_rand_start} = 1;
	} else {
	    $self->{_rand_start} = 0;
	}
    }
    return $self->{_rand_start} || 0;
}


=head2 rand_starts

 Title   : rand_starts
 Usage   : $factory->rand_starts(10);
 Function: Sets the number of initial random SPR trees
 Returns : integer (defaults to 1)
 Args    : None to get, integer to set.

v3.* only; only valid if $prog-E<gt>search is 'SPR'

=cut

sub rand_starts {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [rand_starts] prior to PhyML v3") if $self->version < 3;
    if (defined $value) {
	die "Invalid number [$value]"
	    unless $value =~ /^[-+]?\d+$/;
	$self->{_rand_starts} = $value;
    }
    return $self->{_rand_starts} || 1;
}


=head2 rand_seed

 Title   : rand_seed
 Usage   : $factory->rand_seed(1769876);
 Function: Seeds the random number generator
 Returns : random integer
 Args    : None to get, integer to set.

v3.* only; only valid if $prog-E<gt>search is 'SPR'

Uses perl rand() to initialize if not explicitely set.

=cut

sub rand_seed {
    my ($self, $value) = @_;
    $self->throw("Not a valid parameter [rand_seed] prior to PhyML v3") if $self->version < 3;
    if (defined $value) {
	die "Invalid number [$value]"
	    unless $value =~ /^[-+]?\d+$/;
	$self->{_rand_seed} = $value;
    }
    return $self->{_rand_seed} || int rand 1000000;
}


=head2 Internal methods

These methods are private and should not be called outside this class.

=cut

sub _run {
    my ($self, $file)= @_;

    my $exe = $self->executable || return;
    my $command;
    my $output_stat_file;
    if ($self->version >= 3 ) {
	$command = $exe. " -i $file". $self->_setparams;
	$output_stat_file = '_phyml_stats.txt';
    } else {
	$command = $exe. " $file ". $self->arguments. $self->_setparams;
	$output_stat_file = '_phyml_stat.txt';
    }

    $self->debug("Phyml command = $command\n");
    `$command`;

    # stats
    {
	my $stat_file =  $file. $output_stat_file;
	open(my $FH_STAT, "<", $stat_file)
	    || $self->throw("Phyml call ($command) did not give an output [$stat_file]: $?");
	local $/;
	$self->{_stats} .= <$FH_STAT>;
    }
    #print $self->{stats};

    # tree
    my $tree_file =  $file. '_phyml_tree.txt';
    {
	open(my $FH_TREE, "<", $tree_file)
	    || $self->throw("Phyml call ($command) did not give an output: $?");
	local $/;
	$self->{_tree} .= <$FH_TREE>;
    }

    open(my $FH_TREE, "<", $tree_file)
	|| $self->throw("Phyml call ($command) did not give an output: $?");

    my $treeio = Bio::TreeIO->new(-format => 'nhx', -fh => $FH_TREE);
    my $tree = $treeio->next_tree;

    # could be faster to parse the tree only if needed?

    return $tree;
}


=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : none 

=cut

sub _setparams {
    my $self = shift;
    my $param_string;

    if ($self->version >= 3 ) {

	$param_string = ' -d '.  $self->data_type;
	$param_string .= ' -q' if $self->data_format eq 's';
	$param_string .= ' -n '. $self->dataset_count if $self->dataset_count > 1;

	#$param_string .= ' 0';	# no bootstap sets

	$param_string .= ' -m '. $self->model;
	$param_string .= ' -f '. $self->freq if $self->freq;

	if ($self->data_type eq 'dna') {
	    $param_string .= ' -t '. $self->kappa;
	}

	$param_string .= ' -v '. $self->invar;
	$param_string .= ' -c '. $self->category_number;
	$param_string .= ' -a '. $self->alpha;
	$param_string .= ' -u '. $self->tree if $self->tree ne 'BIONJ';
	$param_string .= ' -o '. $self->opt if $self->opt;
	$param_string .= ' -s '. $self->search;

	if ($self->search eq 'SPR' ) {
	    $param_string .= ' --rand_start ' if $self->rand_start;
	    $param_string .= ' --n_rand_starts '. $self->rand_starts
	        if $self->rand_starts;
	    $param_string .= ' --r_seed '. $self->rand_seed;
	}

    } else {

	$param_string = ' ' .  $self->data_type;

	$param_string .= ' '. $self->data_format;
	$param_string .= ' '. $self->dataset_count;

	$param_string .= ' 0';	# no bootstap sets

	$param_string .= ' '. $self->model;

	unless ($self->data_type) { # only for DNA
	    $param_string .= ' '. $self->kappa;
	}

	$param_string .= ' '. $self->invar;
	$param_string .= ' '. $self->category_number;
	$param_string .= ' '. $self->alpha;
	$param_string .= ' '. $self->tree;
	$param_string .= ' '. $self->opt_topology;
	$param_string .= ' '. $self->opt_lengths;

    }
    return $param_string;
}

=head2 _write_phylip_align_file

 Title   : _write_phylip_align_file
 Usage   : obj->__write_phylip_align_file($aln)
 Function: Internal (not to be used directly)

           Writes the alignment into the tmp directory 
           in PHYLIP interlieved format

 Returns : filename
 Args    : Bio::Align::AlignI

=cut

sub _write_phylip_align_file {
    my ($self, $align) = @_;
    
    my $tempfile = File::Spec->catfile($self->tempdir, "aln$$.phylip");
    $self->data_format('i');
    my $out = Bio::AlignIO->new('-file'     => ">$tempfile", 
				'-format' => 'phylip',
				'-interleaved' => 0,
				'-longid' => 1 );
    $out->write_aln($align);
    $out->close();
    $out = undef;
    return $tempfile;
}

1;
