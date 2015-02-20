#
# BioPerl module for Bio::Tools::Run::Phylo::Raxml
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Copyright Brian Osborne
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Raxml

=head1 SYNOPSIS

  # Build a Raxml factory
  $factory = Bio::Tools::Run::Phylo::Raxml->new(-p  => 100);

  # Get an alignment
  my $alignio = Bio::AlignIO->new(
        -format => 'fasta',
        -file   => '219877.cdna.fasta');
  my $alnobj = $alignio->next_aln;

  # Analyze the aligment and get a Tree
  my $tree = $factory->run($alnobj);

=head1 DESCRIPTION

Get a Bio::Tree object using raxml given a protein or DNA alignment.

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

package Bio::Tools::Run::Phylo::Raxml;

use strict;
use File::Basename qw(basename);
use File::Spec qw(catfile);
use Bio::Seq;
use Bio::SeqIO;
use Bio::TreeIO;
use Bio::AlignIO;
use Bio::Root::IO;
use Cwd;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

our @Raxml_PARAMS =
  qw(s n m a A b B c e E f g G i I J o p P q r R S t T w W x z N);
our @Raxml_SWITCHES =
  qw(SSE3 PTHREADS PTHREADS-SSE3 HYBRID HYBRID-SSE3 F h k K M j U v X y C d D);
our $PROGRAM_NAME = 'raxml';

# Specify some model if none is specified
my $DEFAULTAAMODEL = 'PROTCATDAYHOFF';
my $DEFAULTNTMODEL = 'GTRCAT';

=head2 new

 Title   : new
 Usage   : my $treebuilder = Bio::Tools::Run::Phylo::Raxml->new();
 Function: Constructor
 Returns : Bio::Tools::Run::Phylo::Raxml
 Args    : Same as those used to run raxml. For example:

 $factory = Bio::Tools::Run::Phylo::Raxml->new(-p  => 100, -SSE3 => 1) 

=cut

sub new {
    my ( $class, @args ) = @_;
    my $self = $class->SUPER::new(@args);

    $self->_set_from_args(
        \@args,
        -case_sensitive => 1,
        -methods => [ @Raxml_PARAMS, @Raxml_SWITCHES ],
        -create  => 1
    );

    my ($out,$quiet) = $self->SUPER::_rearrange( [qw(OUTFILE_NAME QUIET)], @args );

    $self->outfile_name( $out || '' );
    $self->quiet( $quiet ) if $quiet;

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
    my $string = `$exe -v 2>&1`;

    $string =~ /raxml\s+version\s+([\d\.]+)/i;
    return $1 || undef;
}

=head2  quiet

 Title   : quiet
 Usage   : 
 Function: get or set value for 'quiet'
 Example :
 Returns : 
 Args    : the value

=cut

sub quiet {
    my ( $self, $value ) = @_;
    
    $self->{'_quiet'} = $value if ( defined $value );
    $self->{'_quiet'};
}

=head2 run

 Title   : run
 Usage   : $factory->run($stockholm_file) OR
           $factory->run($align_object)
 Function: Runs Raxml to generate a tree 
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

    my $exe       = $self->executable || return;
    my $param_str = $self->arguments . " " . $self->_setparams($file);
    my $command   = "$exe $param_str";
    $self->debug("Raxml command = $command");

    my $status  = system($command);
	
    # raxml creates tree files with names like "RAxML_bestTree.ABDBxjjdfg3"
    my $outfile = 'RAxML_bestTree.' . $self->outfile_name;
    $outfile = File::Spec->catfile( ($self->w), $outfile ) if $self->w;

    if ( !-e $outfile || -z $outfile ) {
        $self->warn("Raxml call had status of $status: $? [command $command] \n");
        return undef;
    }

    my $treeio = Bio::TreeIO->new( -file => $outfile );
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

    my ( $tfh, $tempfile ) = $self->io->tempfile( -dir => '.' );

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
    my ( $self, $file ) = @_;

    if ($file) {
        if ( -e $file ) {
            my $in = Bio::AlignIO->new( -file => $file );
            my $aln = $in->next_aln;

            # arbitrary, the first one
            my $seq      = $aln->get_seq_by_pos(1);
            my $alphabet = $seq->alphabet;
            $self->{_alphabet} = $alphabet;
        }
        else {
            die "File $file can not be found";
        }
    }

    # default is 'dna'
    return $self->{'_alphabet'} || 'dna';
}

=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly    
 Function:  Create parameter inputs for Raxml program
 Example :
 Returns : parameter string to be passed to Raxml
 Args    : name of calling object

=cut

sub _setparams {
    my ( $self, $infile ) = @_;
    my $param_string = '';

    # If 'model' is not set with '-m' check the alphabet of the input,
    # then specify the default model
    if ( !$self->m ) {
        my $model =
          ( $self->_alphabet($infile) eq 'dna' )
          ? $DEFAULTNTMODEL
          : $DEFAULTAAMODEL;
        $self->m($model);
    }

    # Set default output file if no explicit output file has been given.
    # Raxml insists that the output file name not contain '/' and its
    # output directory is set using the '-w' argument.
    if ( !$self->outfile_name ) {
        my $dir = getcwd();
        $self->w($dir);

        my ( $tfh, $outfile ) = $self->io->tempfile( -dir => $dir );
        close($tfh);
        undef $tfh;
        $outfile = basename($outfile);
        $self->outfile_name($outfile);
    }

    for my $attr (@Raxml_PARAMS) {
        my $value = $self->$attr();
        next unless ( defined $value );
        $param_string .= ' -' . $attr . ' ' . $value . ' ';
    }

    for my $attr (@Raxml_SWITCHES) {
        my $value = $self->$attr();
        next unless ($value);
        $param_string .= ' -' . $attr . ' ';
    }

    $param_string .= "-s $infile -n " . $self->outfile_name;

    my $null = ($^O =~ m/mswin/i) ? 'NUL' : '/dev/null';
    $param_string .= " > $null 2> $null"
      if ( $self->quiet() || $self->verbose < 0 );

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
Usage   : my $outfile = $Raxml->outfile_name();
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
Usage   : $Raxml->cleanup();
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
