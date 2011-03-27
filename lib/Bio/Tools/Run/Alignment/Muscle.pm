# $Id$
#
# BioPerl module for Bio::Tools::Run::Alignment::Muscle
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Jason Stajich
#
# Copyright Jason Stajich <jason-at-bioperl-dot-org>
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Muscle - Object for the calculation of an
iterative multiple sequence alignment from a set of unaligned
sequences or alignments using the MUSCLE program

=head1 SYNOPSIS

  # Build a muscle alignment factory
  $factory = Bio::Tools::Run::Alignment::Muscle->new(@params);

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

=head1 DESCRIPTION

Muscle is Robert Edgar's progressive alignment program.  You can get
it and see information about it at this URL
http://www.drive5.com/muscle

It is recommended you use at least version 3.6. Behaviour with earlier versions
is questionable.

=head2 Helping the module find your executable 

You will need to enable Muscle to find the muscle program. This can be
done in (at least) three ways:

  1. Make sure the muscle executable is in your path (i.e. 
     'which muscle' returns a valid program
  2. define an environmental variable MUSCLEDIR which points to a 
     directory containing the 'muscle' app:
   In bash 
	export MUSCLEDIR=/home/progs/muscle   or
   In csh/tcsh
        setenv MUSCLEDIR /home/progs/muscle

  3. include a definition of an environmental variable MUSCLEDIR 
      in every script that will
     BEGIN {$ENV{MUSCLEDIR} = '/home/progs/muscle'; }
     use Bio::Tools::Run::Alignment::Muscle;

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

=head1 AUTHOR -  Jason Stajich

Email jason-at-bioperl-dot-org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::Muscle;

use vars qw($AUTOLOAD @ISA $PROGRAMNAME $PROGRAM %DEFAULTS
            @MUSCLE_PARAMS @MUSCLE_SWITCHES %OK_FIELD
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
    @MUSCLE_PARAMS = qw(IN OUT TREE1 LOG LOGA SCOREFILE GAPOPEN 
			MAXMB MAXHOURS MAXITERS KBAND IN1 IN2);
    @MUSCLE_SWITCHES = qw(QUIET DIAGS REFINE STABLE GROUP 
			  CLW CLWSTRICT MSF);

# Authorize attribute fields
    foreach my $attr ( @MUSCLE_PARAMS, @MUSCLE_SWITCHES ) {
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
        return 'muscle';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{MUSCLEDIR}) if $ENV{MUSCLEDIR};
}

=head2 new

 Title   : new
 Usage   : my $muscle = Bio::Tools::Run::Alignment::Muscle->new();
 Function: Constructor
 Returns : Bio::Tools::Run::Alignment::Muscle
 Args    : -outfile_name => $outname


=cut

sub new {
    my ($class,@args) = @_;
    my( @muscle_args, @obj_args);
    while( my $arg = shift @args ) {
	if( $arg =~ /^-/ ) {
	    push @obj_args, $arg, shift @args;
	} else {
	    push @muscle_args,$arg, shift @args;
	}
    }
    my $self = $class->SUPER::new(@obj_args);
    
    my ($on) = $self->_rearrange([qw(OUTFILE_NAME)],@obj_args);
    
    $self->outfile_name($on || '');
    my ($attr, $value);    
    $self->aformat($DEFAULTS{'AFORMAT'});

    while ( @muscle_args)  {
	$attr =   shift @muscle_args;
	$value =  shift @muscle_args;
	next if( $attr =~ /^-/); # don't want named parameters
	$self->$attr($value);
    }
    $self->aformat('msf') if $self->msf;
    $self->aformat('clustalw') if $self->clw || $self->clwstrict;
    
    if( defined $self->out ) {
	$self->outfile_name($self->out);
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

=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysus run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)


=cut

sub error_string{
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'error_string'} = $value;
    }
    return $self->{'error_string'};

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

    $string =~ /MUSCLE\s+v(\d+\.\d+)/m;
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
    my $infilename;
    if( defined $input ) {
	$infilename = $self->_setinput($input);
    } elsif( defined $self->in ) {
	$infilename = $self->_setinput($self->in);
    } else {
	$self->throw("No inputdata provided\n");
    }
    if (! $infilename) {
	$self->throw("Bad input data or less than 2 sequences in $input !");
    }

    my $param_string = $self->_setparams();

    # run muscle
    return &_run($self, $infilename, $param_string);
}

=head2  profile

 Title   : profile
 Usage   :
        $alnfilename = /t/data/cysprot.msa';
	$seqsfilename = 't/data/cysprot.fa';
	$aln = $factory->profile($alnfilename,$seqsfilename);

 Function: Perform a profile alignment on a MSA to include more seqs
 Returns : Reference to a SimpleAlign object containing the
           sequence alignment.
 Args : Name of a file containing the fasta MSA and name of a file
        containing a set of unaligned fasta sequences
 Comments : This only works for muscle version 3.52.
            Some early versions of the 3.6 sources had a bug that
            caused a segfault with -profile. The attached should fix
            it, if not let Bob Edgar know.

=cut

sub profile {
    my ($self,$alnfilename,$seqsfilename) = @_;
    # Create input file pointer
    $self->io->_io_cleanup();
    if ($self->version ne '3.52') {
	$self->throw("profile does not work for this version of muscle\n");
    }
    my $infilename;
    if( defined $alnfilename ) {
        if (! ref $alnfilename) {
            # check that file exists or throw
            $infilename = $alnfilename;
            unless (-e $infilename) {return 0;}
            # let's peek and guess
            open(IN,$infilename) || $self->throw("Cannot open $infilename");
            my $header;
            while( defined ($header = <IN>) ) {
                last if $header !~ /^\s+$/;
            }
            close(IN);
            if ( $header !~ /^>\s*\S+/ ){
                $self->throw("Need to provide a FASTA format file to muscle profile!");
            } 
        }
    } else {
	$self->throw("No inputdata provided\n");
    }
    if (! $infilename) {
	$self->throw("Bad input data or less than 2 sequences in $infilename !");
    }
    if( defined $seqsfilename ) {
        if (! ref $seqsfilename) {
            # check that file exists or throw
            $infilename = $seqsfilename;
            unless (-e $infilename) {return 0;}
            # let's peek and guess
            open(IN,$infilename) || $self->throw("Cannot open $infilename");
            my $header;
            while( defined ($header = <IN>) ) {
                last if $header !~ /^\s+$/;
            }
            close(IN);
            if ( $header !~ /^>\s*\S+/ ){
                $self->throw("Need to provide a FASTA format file to muscle profile!");
            } 
        }
    } else {
	$self->throw("No inputdata provided\n");
    }
    if (! $infilename) {
	$self->throw("Bad input data or less than 2 sequences in $infilename !");
    }

    my $param_string = $self->_setparams();

    # run muscle
    $self->{_profile} = 1;
    return &_run($self, "$alnfilename -in2 $seqsfilename", $param_string);
}

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to muscle program
 Example :
 Returns : nothing; muscle output is written to a
           temporary file OR specified output file
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to muscle


=cut

sub _run {
    my ($self,$infilename,$params) = @_;
    my $commandstring;
    if ($self->{_profile}) {
        $commandstring = $self->executable." -profile -in1 $infilename $params";
        $self->{_profile} = 0;
    } else {
        $commandstring = $self->executable." -in $infilename $params";
    }

    $self->debug( "muscle command = $commandstring \n");

    my $status = system($commandstring);
    my $outfile = $self->outfile_name(); 
    if( !-e $outfile || -z $outfile ) {
	$self->warn( "Muscle call crashed: $? [command $commandstring]\n");
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
 Function:  Create input file for muscle program
 Example :
 Returns : name of file containing muscle data input AND
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
	    $self->throw("Need to provide a FASTA format file to muscle!");
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
 Function:  Create parameter inputs for muscle program
 Example :
 Returns : parameter string to be passed to muscle
           during align or profile_align
 Args    : name of calling object

=cut

sub _setparams {
    my ($self) = @_;
    my ($attr, $value,$param_string);
    $param_string = '';
    my $laststr;
    for  $attr ( @MUSCLE_PARAMS ) {
	$value = $self->$attr();
	next unless (defined $value);	
	my $attr_key = lc $attr;
        $attr_key = ' -'.$attr_key;
        $param_string .= $attr_key .' '.$value;

    }
    for  $attr ( @MUSCLE_SWITCHES) {
 	$value = $self->$attr();
 	next unless ($value);
 	my $attr_key = lc $attr; #put switches in format expected by tcoffee
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
    $param_string .= " -out ".$self->outfile_name;
    
    if ($self->quiet() || $self->verbose < 0) { 
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
 Usage   : my $outfile = $muscle->outfile_name();
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
 Usage   : $muscle->cleanup();
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
