# BioPerl module for Bio::Tools::Run::Alignment::Amap
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Albert Vilella
#
#
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Amap - Object for the calculation of an
iterative multiple sequence alignment from a set of unaligned
sequences or alignments using the Amap (2.0) program

=head1 SYNOPSIS

  # Build a muscle alignment factory
  $factory = Bio::Tools::Run::Alignment::Amap->new(@params);

  # Pass the factory a list of sequences to be aligned.
  $inputfilename = 't/cysprot.fa';
  # $aln is a SimpleAlign object.
  $aln = $factory->align($inputfilename);

  # or where @seq_array is an array of Bio::Seq objects
  $seq_array_ref = \@seq_array;
  $aln = $factory->align($seq_array_ref);

  # Or one can pass the factory a pair of (sub)alignments
  #to be aligned against each other, e.g.:

  #There are various additional options and input formats available.
  #See the DESCRIPTION section that follows for additional details.

  #To run amap with training, try something like:

  #First round to generate train.params
  $factory = Bio::Tools::Run::Alignment::Amap->new
      (
       'iterative-refinement'  => '1000',
       'consistency'   => '5',
       'pre-training' => '20',
       'emissions' => '',
       'verbose' => '',
       'train'   => "$dir/$subdir/$outdir/train.params",
      );
  $factory->outfile_name("$dir/$subdir/$outdir/train.params");

  #Second round to use train.params to get a high qual alignment

  $seq_array_ref = \@seq_array;
  $aln = $factory->align($seq_array_ref);
  $aln = '';
  $factory = '';

  $factory = Bio::Tools::Run::Alignment::Amap->new
      (
       'iterative-refinement'  => '1000',
       'consistency'   => '5',
       'pre-training' => '20',
       'verbose' => '',
       'paramfile'   => "$dir/$subdir/$outdir/train.params",
      );
  $factory->outfile_name("$dir/$subdir/$outdir/outfile.afa");
  $aln = $factory->align($seq_array_ref);

=head1 DESCRIPTION

Amap uses a Sequence Annealing algorithm which is an incremental
method for building multiple alignments. You can get it and see
information about it at this URL http://bio.math.berkeley.edu/amap/


=head2 Helping the module find your executable 

FIXME: Amap uses the same parameters as Probcons, plus a few others. I
haven't had time to check all the changes from the Probcons.pm
runnable. Feel free to do it.

You will need to enable Amap to find the amap program. This can be
done in (at least) three ways:

  1. Make sure the amap executable is in your path (i.e. 
     'which amap' returns a valid program
  2. define an environmental variable AMAPDIR which points to a 
     directory containing the 'amap' app:
   In bash 
	export AMAPDIR=/home/progs/amap   or
   In csh/tcsh
        setenv AMAPDIR /home/progs/amap

  3. include a definition of an environmental variable AMAPDIR 
      in every script that will
     BEGIN {$ENV{AMAPDIR} = '/home/progs/amap'; }
     use Bio::Tools::Run::Alignment::Amap;

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
the bugs and their resolution.  Bug reports can be submitted via the web:

 http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR -  Albert Vilella

Email foo@bar.com

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::Amap;

use vars qw($AUTOLOAD @ISA $PROGRAMNAME $PROGRAM %DEFAULTS
            @AMAP_PARAMS @AMAP_SWITCHES @OTHER_SWITCHES 
            %OK_FIELD
            );
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use  Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase 
          Bio::Factory::ApplicationFactoryI);


BEGIN {
    %DEFAULTS = ( 'AFORMAT' => 'fasta' );
    @AMAP_PARAMS = qw (CONSISTENCY ITERATIVE-REFINEMENT 
                           PRE-TRAINING ANNOT TRAIN PARAMFILE MATRIXFILE
                           CLUSTALW PAIRS VITERBI VERBOSE EMISSIONS EDGE-WEIGHT-THRESHOLD GAP-FACTOR); 
                           #FIXME: Last line are switches, dunno how to set them, 
                           #gave as params
    @AMAP_SWITCHES = qw();
    @OTHER_SWITCHES = qw(PROGRESSIVE NOREORDER ALIGNMENT-ORDER MAXSTEP PRINT-POSTERIORS);

# Authorize attribute fields
    foreach my $attr ( @AMAP_PARAMS, @OTHER_SWITCHES ) {
	$OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'amap';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{AMAPDIR}) if $ENV{AMAPDIR};
}

=head2 new

 Title   : new
 Usage   : my $amap = Bio::Tools::Run::Alignment::Amap->new();
 Function: Constructor
 Returns : Bio::Tools::Run::Alignment::Amap
 Args    : -outfile_name => $outname


=cut

sub new{
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($on) = $self->SUPER::_rearrange([qw(OUTFILE_NAME)], @args);
    $self->outfile_name($on) if $on;
    my ($attr, $value);    
    $self->aformat($DEFAULTS{'AFORMAT'});
    
    while ( @args)  {
	$attr =   shift @args;
	$value =  shift @args;
	next if( $attr =~ /^-/); # don't want named parameters
	$self->$attr($value);
    }
    return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $attr = uc $attr;
    # aliasing
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};

    $self->{$attr} = shift if @_;
    return $self->{$attr};
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
    my $string = `$exe 2>&1` ;
    #AMAP version 1.09 - align multiple protein sequences and print to standard output
    $string =~ /AMAP\s+version.+(\d+\.\d+)/m;
    return $1 || undef;
}

=head2 run

 Title   : run
 Usage   : my $output = $application->run(\@seqs);
 Function: Generic run of an application
 Returns : Bio::SimpleAlign object
 Args    : Arrayref of Bio::PrimarySeqI objects or
           a filename to run on

=cut

sub run {
    my $self = shift;
    return $self->align(shift);
}

=head2  align

 Title   : align
 Usage   :
	$inputfilename = 't/data/cysprot.fa';
	$aln = $factory->align($inputfilename);
or
	$seq_array_ref = \@seq_array; 
        # @seq_array is array of Seq objs
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
    # Create input file pointer
    $self->io->_io_cleanup();
    my ($infilename) = $self->_setinput($input);
    if (! $infilename) {
	$self->throw("Bad input data or less than 2 sequences in $input !");
    }

    my $param_string = $self->_setparams();

    # run amap
    return &_run($self, $infilename, $param_string);
}

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to amap program
 Example :
 Returns : nothing; amap output is written to a
           temporary file OR specified output file
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to amap


=cut

sub _run {
    my ($self,$infilename,$params) = @_;
    my $commandstring = $self->executable." $infilename $params";
    
    $self->debug( "amap command = $commandstring \n");

    my $status = system($commandstring);
    my $outfile = $self->outfile_name(); 

    if( !-e $outfile || -z $outfile ) {
	$self->warn( "Amap call crashed: $? [command $commandstring]\n");
	return undef;
    }

    my $in  = Bio::AlignIO->new('-file'   => $outfile, 
				'-format' => $self->aformat);
    my $aln = $in->next_aln();
    return $aln;
}


=head2  _setinput

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:  Create input file for amap program
 Example :
 Returns : name of file containing amap data input AND
 Args    : Arrayref of Seqs or input file name


=cut

sub _setinput {
    my ($self,$input) = @_;
    my ($infilename, $seq, $temp, $tfh);
    if (! ref $input) {
	# check that file exists or throw
	$infilename = $input;
	unless (-e $input) {return 0;}
	# let's peek and guess
	open(IN,$infilename) || $self->throw("Cannot open $infilename");
	my $header;
	while( defined ($header = <IN>) ) {
	    last if $header !~ /^\s+$/;
	}
	close(IN);
	if ( $header !~ /^>\s*\S+/ ){
	    $self->throw("Need to provide a FASTA format file to amap!");
	} 
	return ($infilename);
    } elsif (ref($input) =~ /ARRAY/i ) { #  $input may be an
	#  array of BioSeq objects...
        #  Open temporary file for both reading & writing of array
	($tfh,$infilename) = $self->io->tempfile();
	if( ! ref($input->[0]) ) {
	    $self->warn("passed an array ref which did not contain objects to _setinput");
	    return undef;
	} elsif( $input->[0]->isa('Bio::PrimarySeqI') ) {
	    $temp =  Bio::SeqIO->new('-fh' => $tfh,
				     '-format' => 'fasta');
	    my $ct = 1;
	    foreach $seq (@$input) {
		return 0 unless ( ref($seq) && 
				  $seq->isa("Bio::PrimarySeqI") );
		if( ! defined $seq->display_id ||
		    $seq->display_id =~ /^\s+$/) {
		    $seq->display_id( "Seq".$ct++);
		} 
		$temp->write_seq($seq);
	    }
	    $temp->close();
	    undef $temp;
	    close($tfh);
	    $tfh = undef;
	} else { 
	    $self->warn( "got an array ref with 1st entry ".
			 $input->[0].
			 " and don't know what to do with it\n");
	}
	return ($infilename);
    } else { 
	$self->warn("Got $input and don't know what to do with it\n");
    }
    return 0;
}


=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:  Create parameter inputs for amap program
 Example :
 Returns : parameter string to be passed to amap
           during align or profile_align
 Args    : name of calling object

=cut

sub _setparams {
    my ($self) = @_;
    my ($attr, $value,$param_string);
    $param_string = '';
    my $laststr;
    for  $attr ( @AMAP_PARAMS ) {
	$value = $self->$attr();
	next unless (defined $value);	
	my $attr_key = lc $attr;
        $attr_key = ' --'.$attr_key unless ($attr eq 'ANNOT');
        $attr_key = ' -'.$attr_key if ($attr eq 'ANNOT');
        $param_string .= $attr_key .' '.$value;

    }
    for  $attr ( @AMAP_SWITCHES) {
	$value = $self->$attr();
	next unless ($value);
	my $attr_key = lc $attr; #put switches in format expected by Amap
	$attr_key = ' -'.$attr_key;
	$param_string .= $attr_key ;
    }
    # Set default output file if no explicit output file selected
    unless ($self->outfile_name ) {	
	my ($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir());
	close($tfh);
	undef $tfh;
	$self->outfile_name($outfile);
    }
    #FIXME: This may be only for *nixes. Double check in other OSes
    $param_string .= " > ".$self->outfile_name;
    
    if ($self->verbose < 0) { 
	$param_string .= ' 2> /dev/null';
    }
    return $param_string;
}

=head2 aformat

 Title   : aformat
 Usage   : my $alignmentformat = $self->aformat();
 Function: Get/Set alignment format
 Returns : string
 Args    : string


=cut

sub aformat{
    my $self = shift;
    $self->{'_aformat'} = shift if @_;
    return $self->{'_aformat'};
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
 Usage   : my $outfile = $amap->outfile_name();
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
 Usage   : $amap->cleanup();
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

1; # Needed to keep compiler happy
