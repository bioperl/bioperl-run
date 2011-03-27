# $Id$
#
# BioPerl module for Bio::Tools::Run::Alignment::Clustalw
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Clustalw - Object for the calculation of a
multiple sequence alignment from a set of unaligned sequences or
alignments using the Clustalw program

=head1 SYNOPSIS

  #  Build a clustalw alignment factory
  @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
  $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);

  #  Pass the factory a list of sequences to be aligned.	
  $inputfilename = 't/data/cysprot.fa';
  $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.
  # or
  $seq_array_ref = \@seq_array;
  # where @seq_array is an array of Bio::Seq objects
  $aln = $factory->align($seq_array_ref);

  # Or one can pass the factory a pair of (sub)alignments
  #to be aligned against each other, e.g.:
  $aln = $factory->profile_align($aln1,$aln2);
  # where $aln1 and $aln2 are Bio::SimpleAlign objects.

  # Or one can pass the factory an alignment and one or more unaligned
  # sequences to be added to the alignment. For example: 	
  $aln = $factory->profile_align($aln1,$seq); # $seq is a Bio::Seq object.

  # Get a tree of the sequences
  $tree = $factory->tree(\@seq_array);

  # Get both an alignment and a tree
  ($aln, $tree) = $factory->run(\@seq_array);

  # Do a footprinting analysis on the supplied sequences, getting back the
  # most conserved sub-alignments
  my @results = $factory->footprint(\@seq_array);
  foreach my $result (@results) {
    print $result->consensus_string, "\n";
  }

  # There are various additional options and input formats available.
  # See the DESCRIPTION section that follows for additional details.

=head1 DESCRIPTION

Note: this DESCRIPTION only documents the Bioperl interface to
Clustalw.  Clustalw, itself, is a large & complex program - for more
information regarding clustalw, please see the clustalw documentation
which accompanies the clustalw distribution. Clustalw is available
from (among others) ftp://ftp.ebi.ac.uk/pub/software/. Clustalw.pm has 
only been tested using version 1.8 of clustalw.  Compatibility with 
earlier versions of the clustalw program is currently unknown. Before 
running Clustalw successfully it will be necessary: to install clustalw 
on your system, and to ensure that users have execute privileges for 
the clustalw program.

=head2 Helping the module find your executable 

You will need to enable Clustalw to find the clustalw program. This
can be done in (at least) three ways:

 1. Make sure the clustalw executable is in your path so that
    which clustalw
    returns a clustalw executable on your system.

 2. Define an environmental variable CLUSTALDIR which is a 
    directory which contains the 'clustalw' application:
    In bash:

    export CLUSTALDIR=/home/username/clustalw1.8

    In csh/tcsh:

    setenv CLUSTALDIR /home/username/clustalw1.8

 3. Include a definition of an environmental variable CLUSTALDIR in
    every script that will use this Clustalw wrapper module, e.g.:

    BEGIN { $ENV{CLUSTALDIR} = '/home/username/clustalw1.8/' }
    use Bio::Tools::Run::Alignment::Clustalw;

If you are running an application on a webserver make sure the
webserver environment has the proper PATH set or use the options 2 or
3 to set the variables.

=head2 How it works

Bio::Tools::Run::Alignment::Clustalw is an object for performing a
multiple sequence alignment from a set of unaligned sequences and/or
sub-alignments by means of the clustalw program.

Initially, a clustalw "factory object" is created. Optionally, the
factory may be passed most of the parameters or switches of the
clustalw program, e.g.:

	@params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
	$factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);

Any parameters not explicitly set will remain as the defaults of the
clustalw program.  Additional parameters and switches (not available
in clustalw) may also be set.  Currently, the only such parameter is
"quiet", which when set to a non-zero value, suppresses clustalw
terminal output. Not all clustalw parameters are supported at this
stage.

By default, Clustalw output is returned solely in a the form of a
Bio::SimpleAlign object which can then be printed and/or saved
in multiple formats using the AlignIO.pm module. Optionally the raw
clustalw output file can be saved if the calling script specifies an
output file (with the clustalw parameter OUTFILE).  Currently only the
GCG-MSF output file formats is supported.

Not all parameters and features have been implemented yet in Perl format.

Alignment parameters can be changed and/or examined at any time after
the factory has been created.  The program checks that any
parameter/switch being set/read is valid.  However, currently no
additional checks are included to check that parameters are of the
proper type (eg string or numeric) or that their values are within the
proper range.  As an example, to change the value of the clustalw
parameter ktuple to 3 and subsequently to check its value one would
write:

	$ktuple = 3;
	$factory->ktuple($ktuple);
 	$get_ktuple = $factory->ktuple();

Once the factory has been created and the appropriate parameters set,
one can call the method align() to align a set of unaligned sequences,
or call profile_align() to add one or more sequences or a second
alignment to an initial alignment.

Input to align() may consist of a set of unaligned sequences in the
form of the name of file containing the sequences. For example,

  $inputfilename = 't/data/cysprot.fa'; 
  $aln = $factory-E<gt>align($inputfilename);

Alternately one can create an array of Bio::Seq objects somehow

	$str = Bio::SeqIO->new(-file=> 't/data/cysprot.fa', -format => 'Fasta');
	@seq_array =();
	while ( my $seq = $str->next_seq() ) {push (@seq_array, $seq) ;}

and pass the factory a reference to that array

	$seq_array_ref = \@seq_array;
	$aln = $factory->align($seq_array_ref);

In either case, align() returns a reference to a SimpleAlign object
which can then used (see L<Bio::SimpleAlign>).

Once an initial alignment exists, one can pass the factory additional
sequence(s) to be added (ie aligned) to the original alignment.  The
alignment can be passed as either an alignment file or a
Bio:SimpleAlign object.  The unaligned sequence(s) can be passed as a
filename or as an array of BioPerl sequence objects or as a single
BioPerl Seq object.  For example (to add a single sequence to an
alignment),

	$str = Bio::AlignIO->new(-file=> 't/data/cysprot1a.msf');
	$aln = $str->next_aln();
	$str1 = Bio::SeqIO->new(-file=> 't/data/cysprot1b.fa');
	$seq = $str1->next_seq();
	$aln = $factory->profile_align($aln,$seq);

In either case, profile_align() returns a reference to a SimpleAlign
object containing a new SimpleAlign object of the alignment with the
additional sequence(s) added in.

Finally one can pass the factory a pair of (sub)alignments to be
aligned against each other.  The alignments can be passed in the form
of either a pair of alignment files or a pair of Bio:SimpleAlign
objects. For example,

	$profile1 = 't/data/cysprot1a.msf';
	$profile2 = 't/data/cysprot1b.msf';
	$aln = $factory->profile_align($profile1,$profile2);

or

	$str1 = Bio::AlignIO->new(-file=> 't/data/cysprot1a.msf');
	$aln1 = $str1->next_aln();
	$str2 = Bio::AlignIO->new(-file=> 't/data/cysprot1b.msf');
	$aln2 = $str2->next_aln();
	$aln = $factory->profile_align($aln1,$aln2);

In either case, profile_align() returns a reference to a SimpleAlign
object containing an (super)alignment of the two input alignments.

For more examples of syntax and use of Clustalw, the user is
encouraged to look at the script Clustalw.t in the t/ directory.

Note: Clustalw is still under development. Various features of the
clustalw program have not yet been implemented.  If you would like
that a specific clustalw feature be added to this perl contact
bioperl-l@bioperl.org.

These can be specified as paramters when instantiating a new Clustalw
object, or through get/set methods of the same name (lowercase).

=head1 PARAMETER FOR ALIGNMENT COMPUTATION

=head2 KTUPLE

 Title       : KTUPLE
 Description : (optional) set the word size to be used in the alignment
               This is the size of exactly matching fragment that is used.
               INCREASE for speed (max= 2 for proteins; 4 for DNA),
               DECREASE for sensitivity.
               For longer sequences (e.g. >1000 residues) you may
               need to increase the default

=head2 TOPDIAGS

 Title       : TOPDIAGS
 Description : (optional) number of best diagonals to use
               The number of k-tuple matches on each diagonal
               (in an imaginary dot-matrix plot) is calculated.
               Only the best ones (with most matches) are used in
               the alignment.  This parameter specifies how many.
               Decrease for speed; increase for sensitivity.

=head2 WINDOW

 Title       : WINDOW
 Description : (optional) window size
               This is the number of diagonals around each of the 'best'
               diagonals that will be used.  Decrease for speed;
               increase for sensitivity.

=head2 PAIRGAP

 Title       : PAIRGAP
 Description : (optional) gap penalty for pairwise alignments
               This is a penalty for each gap in the fast alignments.
               It has little affect on the speed or sensitivity except
               for extreme values.

=head2 FIXEDGAP

 Title       : FIXEDGAP
 Description : (optional) fixed length gap penalty

=head2 FLOATGAP

 Title       : FLOATGAP
 Description : (optional) variable length gap penalty

=head2 MATRIX

 Title       : MATRIX
 Default     : PAM100 for DNA - PAM250 for protein alignment
 Description : (optional) substitution matrix used in the multiple
               alignments. Depends on the version of clustalw as to
               what default matrix will be used

               PROTEIN WEIGHT MATRIX leads to a new menu where you are
               offered a choice of weight matrices. The default for
               proteins in version 1.8 is the PAM series derived by
               Gonnet and colleagues. Note, a series is used! The
               actual matrix that is used depends on how similar the
               sequences to be aligned at this alignment step
               are. Different matrices work differently at each
               evolutionary distance.

               DNA WEIGHT MATRIX leads to a new menu where a single
               matrix (not a series) can be selected. The default is
               the matrix used by BESTFIT for comparison of nucleic
               acid sequences.

=head2 TYPE

 Title       : TYPE
 Description : (optional) sequence type: protein or DNA. This allows
	            you to explicitly overide the programs attempt at
	            guessing the type of the sequence.  It is only useful
	            if you are using sequences with a VERY strange
	            composition.

=head2 OUTPUT

 Title       : OUTPUT
 Description : (optional) clustalw supports GCG or PHYLIP or PIR or
                Clustal format.  See the Bio::AlignIO modules for
                which formats are supported by bioperl.

=head2 OUTFILE

 Title       : OUTFILE
 Description : (optional) Name of clustalw output file. If not set
	            module will erase output file.  In any case alignment will
	            be returned in the form of SimpleAlign objects

=head2 TRANSMIT

 Title       : TRANSMIT
 Description : (optional) transitions not weighted.  The default is to
	            weight transitions as more favourable than other
	            mismatches in DNA alignments.  This switch makes all
	            nucleotide mismatches equally weighted.

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

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR -  Peter Schattner

Email schattner@alum.mit.edu

=head1 CONTRIBUTORS

Jason Stajich jason-AT-bioperl_DOT_org
Sendu Bala    bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

#'

package Bio::Tools::Run::Alignment::Clustalw;

use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::IO;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

our @CLUSTALW_PARAMS = qw(output ktuple topdiags window pairgap fixedgap
                   floatgap matrix type	transit dnamatrix outfile
                   gapopen gapext maxdiv gapdist hgapresidues pwmatrix
                   pwdnamatrix pwgapopen pwgapext score transweight
                   seed helixgap outorder strandgap loopgap terminalgap
                   helixendin helixendout strandendin strandendout program
                   reps outputtree seed bootlabels bootstrap);

our @CLUSTALW_SWITCHES = qw(help check options negative noweights endgaps
                        nopgap nohgap novgap kimura tossgaps
                        kimura tossgaps njtree);
our @OTHER_SWITCHES = qw(quiet);
our $PROGRAM_NAME = 'clustalw';
our $PROGRAM_DIR = $ENV{'CLUSTALDIR'} || $ENV{'CLUSTALWDIR'};


=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  return $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return $PROGRAM_DIR;
}

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);

    $self->_set_from_args(\@args, -methods => [@CLUSTALW_PARAMS,
                                               @CLUSTALW_SWITCHES,
                                               @OTHER_SWITCHES],
                                  -create => 1);
    
    return $self;
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

    return undef unless $self->executable;
    my $prog = $self->executable;
    my $string = `$prog -- 2>&1` ;
    $string =~ /\(?([\d.]+)\)?/xms;
    return $1 || undef;
}

=head2  run

 Title   : run
 Usage   : ($aln, $tree) = $factory->run($inputfilename);
           ($aln, $tree) = $factory->run($seq_array_ref);
 Function: Perform a multiple sequence alignment, generating a tree at the same
           time. (Like align() and tree() combined.)
 Returns : A SimpleAlign object containing the sequence alignment and a
           Bio::Tree::Tree object with the tree relating the sequences.
 Args    : Name of a file containing a set of unaligned fasta sequences
           or else an array of references to Bio::Seq objects.

=cut

sub run {
    my ($self,$input) = @_;
    my ($temp,$infilename, $seq);
    my ($attr, $value, $switch);
    
    $self->io->_io_cleanup();
    # Create input file pointer
    $infilename = $self->_setinput($input);
    $self->throw("Bad input data (sequences need an id) or less than 2 sequences in $input!") unless $infilename;
    
    # Create parameter string to pass to clustalw program
    my $param_string = $self->_setparams();
    
    # run clustalw
    return $self->_run('both', $infilename, $param_string);
}

=head2  align

 Title   : align
 Usage   : $inputfilename = 't/data/cysprot.fa';
           $aln = $factory->align($inputfilename);
           or
           $seq_array_ref = \@seq_array; # @seq_array is array of Seq objs
           $aln = $factory->align($seq_array_ref);
 Function: Perform a multiple sequence alignment
 Returns : Reference to a SimpleAlign object containing the
           sequence alignment.
 Args    : Name of a file containing a set of unaligned fasta sequences
           or else an array of references to Bio::Seq objects.

 Throws an exception if argument is not either a string (eg a
 filename) or a reference to an array of Bio::Seq objects.  If
 argument is string, throws exception if file corresponding to string
 name can not be found. If argument is Bio::Seq array, throws
 exception if less than two sequence objects are in array.

=cut

sub align {
    my ($self,$input) = @_;
    
    $self->io->_io_cleanup();
    
    # Create input file pointer
    my $infilename = $self->_setinput($input);
    $self->throw("Bad input data (sequences need an id ) or less than 2 sequences in $input !") unless $infilename;
    
    # Create parameter string to pass to clustalw program
    my $param_string = $self->_setparams();
    
    # run clustalw
    my $aln = $self->_run('align', $infilename, $param_string);
}


=head2  profile_align

 Title   : profile_align
 Usage   : $aln = $factory->profile_align(@simple_aligns);
           or
           $aln = $factory->profile_align(@subalignment_filenames);
 Function: Perform an alignment of 2 (sub)alignments
 Returns : Reference to a SimpleAlign object containing the (super)alignment.
 Args    : Names of 2 files containing the subalignments
           or references to 2 Bio::SimpleAlign objects.

Throws an exception if arguments are not either strings (eg filenames)
or references to SimpleAlign objects.

=cut

sub profile_align {
    my ($self,$input1,$input2) = @_;
    
    $self->io->_io_cleanup();
    
    # Create input file pointer
    my $infilename1 = $self->_setinput($input1, 1);
    my $infilename2 = $self->_setinput($input2, 2);
    if (!$infilename1 || !$infilename2) {$self->throw("Bad input data: $input1 or $input2 !");}
    unless ( -e $infilename1 and -e  $infilename2) {$self->throw("Bad input file: $input1 or $input2 !");}
    
    # Create parameter string to pass to clustalw program
    my $param_string = $self->_setparams();
    
    # run clustalw
    my $aln = $self->_run('profile-aln', $infilename1, $infilename2, $param_string);
}

=head2  add_sequences

 Title   : add_sequences
 Usage   :
 Function: Align and add sequences into an alignment
 Example :
 Returns : Reference to a SimpleAlign object containing the (super)alignment.
 Args    : Names of 2 files, the first one containing an alignment and the second one containing sequences to be added
         or references to 2 Bio::SimpleAlign objects.

Throws an exception if arguments are not either strings (eg filenames)
or references to SimpleAlign objects.


=cut

sub add_sequences {

    my ($self,$input1,$input2) = @_;
    my ($temp,$infilename1,$infilename2,$input,$seq);
    
    $self->io->_io_cleanup();
    # Create input file pointer
    $infilename1 = $self->_setinput($input1,1);
    $infilename2 = $self->_setinput($input2,2);
    if (!$infilename1 || !$infilename2) {$self->throw("Bad input data: $input1 or $input2 !");}
    unless ( -e $infilename1 and -e  $infilename2) {$self->throw("Bad input file: $input1 or $input2 !");}
    
    
    # Create parameter string to pass to clustalw program
    my $param_string = $self->_setparams();
    # run clustalw
    my $aln = $self->_run('add_sequences', $infilename1,
    $infilename2, $param_string);

}

=head2  tree

 Title   : tree
 Usage   : @params = ('bootstrap' => 1000, 
	                    'tossgaps'  => 1, 
	                    'kimura'    => 1, 
	                    'seed'      => 121, 
	                    'bootlabels'=> 'nodes', 
	                    'quiet'     => 1);
           $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
           $tree_obj = $factory->tree($aln_obj);
           or
           $tree_obj = $factory->tree($treefilename);
 Function: Retrieve a tree corresponding to the input
 Returns : Bio::TreeIO object
 Args    : Bio::SimpleAlign or filename of a tree

=cut

sub tree {
    my ($self,$input) = @_;
    
    $self->io->_io_cleanup();
    
    # Create input file pointer
    my $infilename = $self->_setinput($input);
    
    if (!$infilename) {$self->throw("Bad input data (sequences need an id ) or less than 2 sequences in $input !");}
    
    # Create parameter string to pass to clustalw program
    my $param_string = $self->_setparams();

    # run clustalw
    my $tree = $self->_run('tree', $infilename, $param_string);
}

=head2  footprint

 Title   : footprint
 Usage   : @alns = $factory->footprint($treefilename, $window_size, $diff);
           @alns = $factory->footprint($seqs_array_ref);
 Function: Aligns all the supplied sequences and slices out of the alignment
           those regions along a sliding window who's tree length differs
           significantly from the total average tree length.
 Returns : list of Bio::SimpleAlign objects
 Args    : first argument as per run(), optional second argument to specify
           the size of the sliding window (default 5 bp) and optional third
           argument to specify the % difference from the total tree length
           needed for a window to be considered a footprint (default 33%).

=cut

sub footprint {
    my ($self, $in, $slice_size, $deviate) = @_;
    
    my ($simplealn, $tree) = $self->run($in);
    
    # total tree length?
    my $total_length = $tree->total_branch_length;
    
    # tree length along sliding window, picking regions that significantly
    # deviate from the average tree length
    $slice_size ||= 5;
    $deviate ||= 33;
    my $threshold = $total_length - (($total_length / 100) * $deviate);
    my $length = $simplealn->length;
    my $below = 0;
    my $found_minima = 0;
    my $minima = [$threshold, ''];
    my @results;
    for my $i (1..($length - $slice_size + 1)) {
        my $slice = $simplealn->slice($i, ($i + $slice_size - 1), 1);
        my $tree = $self->tree($slice);
        $self->throw("No tree returned") unless defined $tree;
        my $slice_length = $tree->total_branch_length;
        
        $slice_length <= $threshold ? ($below = 1) : ($below = 0);
        if ($below) {
            unless ($found_minima) {
                if ($slice_length < ${$minima}[0]) {
                    $minima = [$slice_length, $slice];
                }
                else {
                    push(@results, ${$minima}[1]);
                    $minima = [$threshold, ''];
                    $found_minima = 1;
                }
            }
        }
        else {
            $found_minima = 0;
        }
    }
    
    return @results;
}

=head2  _run

 Title   : _run
 Usage   : Internal function, not to be called directly	
 Function: makes actual system call to clustalw program
 Returns : nothing; clustalw output is written to a
           temporary file 
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to clustalw

=cut

sub _run {
    my ($self, $command, $infile1, $infile2, $param_string) = @_;
    
    my ($instring, $tree);
    my $quiet = $self->quiet() || $self->verbose() < 0;
    
    if ($command =~ /align|both/) {
        if ($^O eq 'dec_osf') {
            $instring = $infile1;
            $command = '';
        }
        else { 
            $instring = " -infile=". '"' . $infile1 . '"';
        }
        $param_string .= " $infile2";
    }
    
    if ($command =~ /profile/) {
        $instring =  "-profile1=$infile1  -profile2=$infile2";
    	chmod 0777, $infile1, $infile2;
    	$command = '-profile';
    }
    
    if ($command =~ /add_sequences/) {
      $instring =  "-profile1=$infile1  -profile2=$infile2";
      chmod 0777, $infile1,$infile2;
      $command = '-sequences';
    }

    if ($command =~ /tree/) {
    	if( $^O eq 'dec_osf' ) {
            $instring =  $infile1;
            $command = '';
        }
        else { 
            $instring = " -infile=". '"' . $infile1 . '"';
        }
    	$param_string .= " $infile2";
        
    	$self->debug( "Program ".$self->executable."\n");
    	my $commandstring = $self->executable."$instring"."$param_string";
        $commandstring .= ' 1>/dev/null' if $quiet;
        $self->debug( "clustal command = $commandstring");
        
        my $status = system($commandstring);
        unless( $status == 0 ) {
            $self->warn( "Clustalw call ($commandstring) crashed: $? \n");
            return undef;
        }
        
    	return $self->_get_tree($infile1, $param_string);
    }
    
    my $output = $self->output || 'gcg';
    $self->debug( "Program ".$self->executable."\n");
    my $commandstring = $self->executable." $command"." $instring"." -output=$output". " $param_string";
    $self->debug( "clustal command = $commandstring\n");
    
    open(my $pipe, "$commandstring |") || $self->throw("ClustalW call ($commandstring) failed to start: $? | $!");
    my $score;
    while (<$pipe>) {
        print unless $quiet;
        # Kevin Brown suggested the following regex, though it matches multiple
        # times: we pick up the last one
        $score = $1 if ($_ =~ /Score:(\d+)/);
        # This one is printed at the end and seems the most appropriate to pick
        # up; we include the above regex incase 'Alignment Score' isn't given
        $score = $1 if ($_ =~ /Alignment Score (-?\d+)/);
    }
    close($pipe) || ($self->throw("ClustalW call ($commandstring) crashed: $?"));
    
    my $outfile = $self->outfile();
    
    # retrieve alignment (Note: MSF format for AlignIO = GCG format of clustalw)
    my $format = $output =~ /gcg/i ? 'msf' : $output;
    if ($format =~ /clustal/i) { 
        $format = 'clustalw'; # force clustalw incase 'clustal' is requested
    }
    my $in  = Bio::AlignIO->new(-file  => $outfile, -format=> $format);
    my $aln = $in->next_aln();
    $in->close;
    $aln->score($score);
    
    if ($command eq 'both') {
        $tree = $self->_get_tree($infile1, $param_string);
    }
    
    # Clean up the temporary files created along the way...
    # Replace file suffix with dnd to find name of dendrogram file(s) to delete
    unless ( $self->save_tempfiles ) {
        foreach my $f ($infile1, $infile2) {
            $f =~ s/\.[^\.]*$// ;
            unlink $f .'.dnd' if ($f ne '');
        }
    }
    
    if ($command eq 'both') {
        return ($aln, $tree);
    }
    return $aln;
}

sub _get_tree {
    my ($self, $treefile, $param_string) = @_;
    
    $treefile =~ s/\.[^\.]*$// ;
    
    if ($param_string =~ /-bootstrap/) {
        $treefile .= '.phb';
    }
    elsif ($param_string =~ /-tree/) {
        $treefile .= '.ph';
    }
    else {
        $treefile .= '.dnd';
    }
    
    my $in = Bio::TreeIO->new('-file'  => $treefile,
                             '-format'=> 'newick');
    
    my $tree = $in->next_tree;
    unless ( $self->save_tempfiles ) {
        foreach my $f ( $treefile ) {
            unlink $f if( $f ne '' );
        }
    }
    
    return $tree;
}

=head2  _setinput()

 Title   : _setinput
 Usage   : Internal function, not to be called directly	
 Function: Create input file for clustalw program
 Returns : name of file containing clustalw data input
 Args    : Seq or Align object reference or input file name

=cut

sub _setinput {
    my ($self, $input, $suffix) = @_;
    my ($infilename, $seq, $temp, $tfh);
    
    # suffix is used to distinguish alignment files If $input is not a
    # reference it better be the name of a file with the sequence/
    
    # alignment data...
    unless (ref $input) {
        # check that file exists or throw
        $infilename = $input;
        return unless -e $input;
        return $infilename;
    }
    
    # $input may be an array of BioSeq objects...
    if (ref($input) eq "ARRAY") {
        #  Open temporary file for both reading & writing of BioSeq array
        ($tfh,$infilename) = $self->io->tempfile(-dir=>$self->tempdir);
        $temp = Bio::SeqIO->new('-fh'=>$tfh, '-format' =>'Fasta');
        
        # Need at least 2 seqs for alignment
        return unless (scalar(@$input) > 1);
        
        foreach $seq (@$input) {
            return unless (defined $seq && $seq->isa("Bio::PrimarySeqI") and $seq->id());
            $temp->write_seq($seq);
        }
        $temp->close();
        close($tfh);
        undef $tfh;
        return $infilename;
    }
    
    # $input may be a SimpleAlign object.
    elsif (ref($input) eq "Bio::SimpleAlign") {
        # Open temporary file for both reading & writing of SimpleAlign object
        ($tfh,$infilename) = $self->io->tempfile(-dir=>$self->tempdir);
        $temp = Bio::AlignIO->new('-fh'=> $tfh, '-format' => 'fasta');
        $temp->write_aln($input);
        close($tfh);
        undef $tfh;
        return $infilename;
    }
    
    # or $input may be a single BioSeq object (to be added to a previous alignment)
    elsif (ref($input) && $input->isa("Bio::PrimarySeqI") && $suffix==2) {
        # Open temporary file for both reading & writing of BioSeq object
        ($tfh,$infilename) = $self->io->tempfile();
        $temp = Bio::SeqIO->new(-fh=> $tfh, '-format' =>'Fasta');
        $temp->write_seq($input);
        close($tfh);
        undef $tfh;
        return $infilename;
    }
    
    return;
}

=head2  _setparams()

 Title   : _setparams
 Usage   : Internal function, not to be called directly	
 Function: Create parameter inputs for clustalw program
 Returns : parameter string to be passed to clustalw
           during align or profile_align
 Args    : name of calling object

=cut

sub _setparams {
    my $self = shift;
    
    my $param_string = $self->SUPER::_setparams(-params => \@CLUSTALW_PARAMS,
                                                -switches => \@CLUSTALW_SWITCHES,
                                                -dash => 1,
                                                -lc => 1,
                                                -join => '=');
    
    # Set default output file if no explicit output file selected
    unless ($param_string =~ /outfile/) {
        my ($tfh, $outfile) = $self->io->tempfile(-dir => $self->tempdir());
        close($tfh);
        undef $tfh;
        $self->outfile($outfile);
        $param_string .= " -outfile=\"$outfile\"" ;
    }
    
    $param_string .= ' 2>&1';
    
    return $param_string;
}

1;
