#
# BioPerl module for Bio::Tools::Run::Phylo::FastTree
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Copyright Brian Osborne
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::FastTree

=head1 SYNOPSIS

  # Build a FastTree factory
  $factory = Bio::Tools::Run::Phylo::FastTree->new(-quiet => 1,
                                                   -fastest => 1);
  # Get an alignment
  my $alignio = Bio::AlignIO->new(
        -format => 'fasta',
        -file   => '219877.cdna.fasta');
  my $alnobj = $alignio->next_aln;

  # Analyze the aligment and get a Tree
  my $tree = $factory->run($alnobj);

=head1 DESCRIPTION

Get a Bio::Tree object given a protein or DNA alignment.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

Do not contact the module maintainer directly. Many experienced experts 
at bioperl-l will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the web:

 http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR -  Brian Osborne

Email briano@bioteam.net

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phylo::FastTree;

use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::TreeIO;
use Bio::AlignIO;
use Bio::Root::IO;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

our @FastTree_PARAMS = qw(log cat n intree intree1 constraints sprlength topm close 
    refresh constraintWeight);
our @FastTree_SWITCHES = qw(quiet nopr nt fastest slow nosupport pseudo gtr wag quote noml 
    nome mllen gamma spr nni sprlength mlnni mllen slownni nocat notoo 2nd no2nd nj bionj
);
our $PROGRAM_NAME = 'FastTree';
#our $PROGRAM_DIR = Bio::Root::IO->catfile($ENV{FastTreeDIR}) if $ENV{FastTreeDIR};

=head2 new

 Title   : new
 Usage   : my $treebuilder = Bio::Tools::Run::Phylo::FastTree->new();
 Function: Constructor
 Returns : Bio::Tools::Run::Phylo::FastTree
 Args    : -outfile_name => $outname

=cut

sub new {
    my ( $class, @args ) = @_;
    my $self = $class->SUPER::new(@args);

    $self->_set_from_args(
        \@args,
        -methods => [ @FastTree_PARAMS, @FastTree_SWITCHES ],
        -create  => 1
    );

    my ($out) = $self->SUPER::_rearrange( [qw(OUTFILE_NAME)], @args );

    $self->outfile_name( $out || '' );

    $self;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
    $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory
 Returns:  string
 Args    :

=cut

sub program_dir {
    undef;
}

=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysus run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)

=cut

sub error_string {
    my ( $self, $value ) = @_;
    
    $self->{'error_string'} = $value if ( defined $value );
    $self->{'error_string'};
}

=head2  version

 Title   : version
 Usage   : exit if $prog->version() < 1.8
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    my $exe;

    return undef unless $exe = $self->executable;
    my $string = `$exe 2>&1`;

    $string =~ /FastTree\s+version\s+([\d\.]+)/;
    return $1 || undef;
}

=head2 run

 Title   : run
 Usage   : $factory->run($stockholm_file) OR
           $factory->run($align_object)
 Function: Runs FastTree to generate a tree 
 Returns : Bio::Tree::Tree object
 Args    : File name for your input alignment in stockholm format, OR
           Bio::Align::AlignI compliant object (eg. Bio::SimpleAlign).

=cut

sub run {
    my ($self, $in) = @_;

    if (ref $in && $in->isa("Bio::Align::AlignI")) {
        $in = $self->_write_alignfile($in);
    }
    elsif (! -e $in) {
        $self->throw("When not supplying a Bio::Align::AlignI object, you must supply a readable filename");
    }
    
    $self->_run($in); 
}

=head2 _run

 Title   : _run
 Usage   : Internal function, not to be called directly
 Function: Runs the application
 Returns : Tree object
 Args    : Alignment file name

=cut

sub _run {
    my ( $self, $file ) = @_;

    # If -nt is not set check the alphabet of the input
    $self->_alphabet($file) if ( ! $self->nt );

    my $exe       = $self->executable || return;
    my $param_str = $self->arguments . " " . $self->_setparams($file);
    my $command   = "$exe $param_str";
    $self->debug("FastTree command = $command");

    my $status  = system($command);
    my $outfile = $self->outfile_name();

    if ( !-e $outfile || -z $outfile ) {
        $self->warn("FastTree call had status of $status: $? [command $command]\n");
        return undef;
    }

    my $treeio = Bio::TreeIO->new( -format => 'newick', -file => $outfile );
    my $tree = $treeio->next_tree;

# if bootstraps were enabled, the bootstraps are the ids; convert to
# bootstrap and no id
# if ($self->boot) {
#     my @nodes = $tree->get_nodes;
#     my %non_internal = map { $_ => 1 } ($tree->get_leaf_nodes, $tree->get_root_node);
#     foreach my $node (@nodes) {
#         next if exists $non_internal{$node};
#         $node->bootstrap && next; # protect ourselves incase the parser improves
#         $node->bootstrap($node->id);
#         $node->id('');
#     }
# }

    $tree;
}

=head2 _write_alignfile

 Title   : _write_alignfile
 Usage   : Internal function, not to be called directly
 Function: Create an alignment file
 Returns : filename
 Args    : Bio::Align::AlignI

=cut

sub _write_alignfile {
    my ( $self, $align ) = @_;

    my ( $tfh, $tempfile ) = $self->io->tempfile( -dir => $self->tempdir );

    my $out = Bio::AlignIO->new(
        -file   => ">$tempfile",
        -format => 'phylip'
    );
    $out->write_aln($align);
    $out->close();
    undef($out);
    close($tfh);
    undef($tfh);

    die "Alignment file $tempfile was not created" if ( ! -e $tempfile );

    $tempfile;
}
    
=head2 _alphabet

 Title   : _alphabet
 Usage   : my $alphabet = $self->_alphabet;
 Function: Get the alphabet of the input alignment, defaults to 'dna'
 Returns : 'dna' or 'protein'
 Args    : Alignment file

=cut

sub _alphabet {
    my ($self,$file) = @_;
    
    if ( $file ) {
	if ( -e $file ) {
	    my $in = Bio::AlignIO->new(-file => $file);
	    my $aln = $in->next_aln;
	    # arbitrary, the first one
	    my $seq = $aln->get_seq_by_pos(1);
	    my $alphabet = $seq->alphabet;
	    $self->{_alphabet} = $alphabet;

	    $self->nt(1) if ( $alphabet eq 'dna' );
	} else {
	    die "File $file can not be found";
	}
    }

    # default is 'dna'    
    return $self->{'_alphabet'} || 'dna';
}

=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly    
 Function:  Create parameter inputs for FastTree program
 Example :
 Returns : parameter string to be passed to FastTree
 Args    : name of calling object

=cut

sub _setparams {
    my ($self,$infile) = @_;
    my ( $attr, $value, $param_string );
    $param_string = '';
    my $laststr;

    for $attr (@FastTree_PARAMS) {
        $value = $self->$attr();
        next unless ( defined $value );
        my $attr_key = lc $attr;
        $attr_key = ' -' . $attr_key;
        $param_string .= $attr_key . ' ' . $value;
    }
    for $attr (@FastTree_SWITCHES) {
        $value = $self->$attr();
        next unless ($value);
        my $attr_key = lc $attr;
        $attr_key = ' -' . $attr_key;
        $param_string .= $attr_key;
    }

    # Set default output file if no explicit output file has been given
    if ( ! $self->outfile_name ) {
        my ( $tfh, $outfile ) = $self->io->tempfile( -dir => $self->tempdir() );
        close($tfh);
        undef $tfh;
        $self->outfile_name($outfile);
    }
    $param_string .= " $infile > " . $self->outfile_name;

    $param_string .= ' 2> /dev/null' if ( $self->quiet() || $self->verbose < 0 );

    $param_string;
}

=head1 Bio::Tools::Run::BaseWrapper methods

=cut

=head2 no_param_checks

 Title   : no_param_checks
 Usage   : $obj->no_param_checks($newval)
 Function: Boolean flag as to whether or not we should
           trust the sanity checks for parameter values  
 Returns : value of no_param_checks
 Args    : newvalue (optional)

=cut

=head2 save_tempfiles

 Title   : save_tempfiles
 Usage   : $obj->save_tempfiles($newval)
 Function: 
 Returns : value of save_tempfiles
 Args    : newvalue (optional)

=cut

=head2 outfile_name

 Title   : outfile_name
 Usage   : my $outfile = $FastTree->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to

=cut

=head2 tempdir

 Title   : tempdir
 Usage   : my $tmpdir = $self->tempdir();
 Function: Retrieve a temporary directory name (which is created)
 Returns : string which is the name of the temporary directory
 Args    : none

=cut

=head2 cleanup

 Title   : cleanup
 Usage   : $FastTree->cleanup();
 Function: Will cleanup the tempdir directory
 Returns : none
 Args    : none

=cut

=head2 io

 Title   : io
 Usage   : $obj->io($newval)
 Function:  Gets a L<Bio::Root::IO> object
 Returns : L<Bio::Root::IO>
 Args    : none

=cut

1;    # Needed to keep compiler happy

__END__
