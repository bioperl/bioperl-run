# $Id$
#
# BioPerl module for Bio::Tools::Run::Alignment::MSAProbs
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by ???
#
# Copyright ???
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::MSAProbs - Object for the calculation of a
multiple sequence alignment (MSA) from a set of unaligned sequences using 
the MSAProbs program

=head1 SYNOPSIS

  # Build a msaprobs alignment factory
  $factory = Bio::Tools::Run::Alignment::MSAProbs->new(@params);

  # Pass the factory a list of sequences to be aligned.
  $inputfilename = 't/cysprot.fa';
  # $aln is a SimpleAlign object.
  $aln = $factory->align($inputfilename);

  # or where @seq_array is an array of Bio::Seq objects
  $seq_array_ref = \@seq_array;
  $aln = $factory->align($seq_array_ref);

  #There are various additional options and input formats available.
  #See the DESCRIPTION section that follows for additional details.

=head1 DESCRIPTION

MSAProbs is Liu, Schmidt, and Maskell's (2010) alignment program using HMM 
and partition function posterior probabilities.  For more a more in-depth 
description see the original publication:

    Liu, Y., Schmidt, B., and Maskell, D. L. (2010) MSAProbs: multiple
    sequence alignment based on pair hidden Markov models and partition 
    function posterior probabilities. I<Bioinformatics> 26(16): 1958-1964
    doi:10.1093/bioinformatics/btq338
    
                                -OR-

    http://bioinformatics.oxfordjournals.org/content/26/16/1958.abstract

You can download the source code from
http://sourceforge.net/projects/msaprobs/

It is recommended you use at least version 0.9; behaviour with earlier 
versions is questionable.

=head2 Helping the module find your executable 

You will need to help MSAProbs to find the 'msaprobs' executable. This can 
be done in (at least) three ways:

  1. Make sure the msaprobs executable is in your path (i.e. 
     'which msaprobs' returns a valid program)
  2. define an environmental variable MSAPROBSDIR which points to a 
     directory containing the 'msaprobs' app:
   In bash 
	export MSAPROBSDIR=/home/progs/msaprobs   or
   In csh/tcsh
        setenv MSAPROBSDIR /home/progs/msaprobs

  3. include a definition of an environmental variable MSAPROBSDIR 
      in every script that will
     BEGIN {$ENV{MSAPROBSDIR} = '/home/progs/msaprobs'; }
     use Bio::Tools::Run::Alignment::MSAProbs;

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

 http://bugzilla.open-bio.org/

=head1 AUTHOR - Jessen Bredeson

Email jessenbredeson@berkeley.edu

=head1 CONTRIBUTIONS

This MSAProbs module was adapted from the Bio::Tools::Run::Alignment::Muscle 
module, written by Jason Stajich and almost all of the credit should be given
to him.

Email jason-at-bioperl-dot-org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::MSAProbs;

use vars qw($AUTOLOAD @ISA $PROGRAMNAME $PROGRAM %DEFAULTS %MSAPROBS_PARAMS 
            %MSAPROBS_SWITCHES %OK_FIELD
            );
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::GuessSeqFormat;
use Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase 
          Bio::Factory::ApplicationFactoryI);


BEGIN {
    %DEFAULTS          = ( 'QUIET'        => 1, 
                           '_AFORMAT'     => 'fasta',
                           '_CONSISTENCY' => 2,
                           '_ITERATIONS'  => 10,
                           '_CLUSTALW'    => 0,
                           '_ALIGNMENT_ORDER' => 0
                         );
    %MSAPROBS_PARAMS   = ( 'NUM_THREADS'  => 'NUM_THREADS',
                           'CONSISTENCY'  => 'C',
                           'ITERATIONS'   => 'IR',
                           'ANNOT_FILE'   => 'ANNOT'
                         );
    %MSAPROBS_SWITCHES = ( 'CLUSTALW'     => 'CLUSTALW',
                           'ALIGNMENT_ORDER'  => 'A'
                         );
    
# Authorize attribute fields
    %OK_FIELD = map{ uc($_) => 1 } qw(INFILE OUTFILE VERBOSE QUIET VERSION),
                                   keys %MSAPROBS_PARAMS, 
                                   keys %MSAPROBS_SWITCHES;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'msaprobs';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{MSAPROBSDIR}) if $ENV{MSAPROBSDIR};
}

=head2  version

 Title   : version
 Usage   : exit if $prog->version() < 0.9.4
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

 
=cut

sub version {
    my ($self) = @_;
    my( $exe,$version );
    return unless $exe = $self->executable;
    my $string = `$exe -version 2>&1` ;

    $string =~ /MSAPROBS\s+VERSION\s+([\d\.]+)/i;
    $version =~ s/\.(\d+)$/$1/ if ($version = $1);
    
    return $version || undef;
}

=head2 new

 Title   : new
 Usage   : my $msaprobs = Bio::Tools::Run::Alignment::MSAProbs->new();
 Function: Constructor
 Returns : Bio::Tools::Run::Alignment::MSAProbs
 Args    : -outfile => $outname


=cut

sub new {
    my ($class,@args) = @_;
    
    my $self = $class->SUPER::new(@args);
    
    my( @msap_args, @obj_args, $field );
    while( my $arg = shift @args ) {
	    $field = uc $arg;
        $field =~ s/^-//;
        $arg = '-'.$arg if $arg !~ /^-/;
        $self->throw("Invalid argument: $field") 
            unless $OK_FIELD{$field};
        push @msap_args, lc($arg),shift @args;
    }  
    map{ $self->{lc($_)} = $DEFAULTS{$_} } keys %DEFAULTS;
    
    $self->_set_from_args(\@msap_args, 
        -create         => 1,
        -case_sensitive => 1,
        -methods => [map{lc($_);} keys %OK_FIELD]);
    
	
    return $self;
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
    my( $self,$input ) = @_;
    $input ||= $self->infile;
    return $self->align($input);
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
    if( defined($input) ) {
	$infilename = $self->_setinput($input);
    } elsif( defined($self->infile) ) {
	$infilename = $self->_setinput($self->infile);
    } else {
	$self->throw("No inputdata provided\n");
    }
    unless( $infilename ) {
	$self->throw("Bad input data or less than 2 sequences in $infilename !");
    }
    
    my $param_string = $self->_setparams();

    # run msaprobs
    return &_run($self, $infilename, $param_string);
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

=head2  infile

 Title   : infile
 Usage   : $prog->infile($filename)
 Function: get/set the fasta (and only a fasta) file to run on
           or the array reference containing the Bio::SeqI objects
 Returns : name of input sequence file or object array ref
 Args    : name of input sequence file or object array ref

 
=cut

=head2  outfile

 Title   : outfile
 Usage   : $prog->outfile($filename)
 Function: get/set the file to save output to
 Returns : outfile name if set
 Args    : newvalue (optional)

 
=cut

=head2  annot_file

 Title   : annot_file
 Usage   : $prog->annot_file($filename)
 Function: get/set the file name to write the MSA annotation to
 Returns : filename or undef
 Args    : filename (optional)

 
=cut

=head2  num_threads

 Title   : num_threads
 Usage   : $prog->num_threads($cores)
 Function: get/set number of cores on your machine
 Returns : integer
 Args    : integer (optional; executable auto-detects)

 
=cut

=head2  consistency

 Title   : consistency
 Usage   : $prog->consistency($passes)
 Function: get/set the number of consistency transformation passes
 Returns : integer
 Args    : integer 0..5, [default 2] (optional)

 
=cut

=head2  iterations

 Title   : iterations
 Usage   : $prog->iterations($passes)
 Function: get/set the number of iterative-refinement passes
 Returns : integer
 Args    : integer 0..1000, [default 10] (optional)

 
=cut

=head2  alignment_order

 Title   : alignment_order
 Usage   : $prog->alignment_order($bool)
 Function: specify whether or not to output aligned sequences in
           alignment order, not input order
 Returns : boolean
 Args    : boolean [default: off] (optional)

 
=cut

=head2  clustalw

 Title   : clustalw
 Usage   : $prog->clustalw($bool)
 Function: write output in clustalw format; makes no sense unless
           outfile() is also specified
 Returns : boolean
 Args    : boolean [default: off] (optional)

 
=cut

=head1 Bio::Tools::Run::WrapperBase methods

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
 Usage   : my $outfile = $msaprobs->outfile_name();
 Function: Get the name of the output file from a run
           (if you wanted to do something special)
 Returns : string
 Args    : none


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
 Usage   : $msaprobs->cleanup();
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

=head1 Private Methods

=cut

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to msaprobs program
 Example :
 Returns : nothing; msaprobs output is written to a
           temporary file OR specified output file
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to msaprobs


=cut

sub _run {
    my ($self,$infilename,$params) = @_;
    my $commandstring = $self->executable.' '.$infilename.$params;
    $self->debug( "msaprobs command = $commandstring \n");

    my $status  = system($commandstring);
    my $outfile = $self->outfile_name; 
    if( !-s $outfile ) {
	$self->warn( "MSAProbs call crashed: $? [command $commandstring]\n");
	return undef;
    }
    
    if( $self->clustalw ){
    $outfile = $self->_clustalize($outfile);
    $self->aformat('clustalw');
    }
    my $in  = Bio::AlignIO->new(
        '-file'   => $outfile, 
        '-format' => $self->aformat,
        '-displayname_flat' => 1 
        );
    my $aln = $in->next_aln();
    undef $in;
    
    return $aln;
}
    
=head2  _setinput

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:  Create input file for msaprobs program
 Example :
 Returns : name of file containing msaprobs data input AND
 Args    : Arrayref of Seqs or input file name


=cut

sub _setinput {
    my( $self,$input ) = @_;
    my( $infilename,$outtemp,$tfh,@sequences );
    if (! ref $input) {
        # check that file exists or throw
        return unless (-s $input && -r $input);
        # let's peek and guess
        $infilename = $input;
        open(IN,$input) || $self->throw("Cannot open $input");
        my $header;
        while( defined ($header = <IN>) ) {
            last if $header !~ /^\s+$/;  }
        close(IN);
        $header =~ /^>\s*\S+/ ||
        $self->throw("Need to provide a FASTA-formatted file to msaprobs!");
	    my $inseqio = Bio::SeqIO->new(
	        -file   => $input,
	        -format => 'fasta' );
        while( my $seq = $inseqio->next_seq ){
            push @sequences, $seq;  }
        undef $inseqio;
        # have to check each seq for terminal '*', so
        # continue below and write clean output to temp file
    }elsif( ref($input) =~ /ARRAY/i ){ #  $input may be an
        #  array of BioSeq objects...
        #  Open temporary file for both reading & writing of array
        if( ! ref($input->[0]) ) {
            $self->warn("passed an array ref which did not contain objects to _setinput");
            return;
        }elsif( $input->[0]->isa('Bio::PrimarySeqI') ){		
            @sequences = @$input;
        }else{ 
            $self->warn( "got an array ref with 1st entry ".
                $input->[0].
                " and don't know what to do with it\n");
            return;
        }
    }else{ 
        $self->warn("Got $input and don't know what to do with it\n");
        return;
    }
    
    ($tfh,$infilename) = $self->io->tempfile();
    $outtemp =  Bio::SeqIO->new('-fh'     => $tfh,
			    	            '-format' => 'fasta');
    my( @out,$string );
	my $ct = 1;
    while( my $seq = shift @sequences){
        return unless ( ref($seq) && 
            $seq->isa("Bio::PrimarySeqI") );
        if( ! defined $seq->display_id ||
            $seq->display_id =~ /^\s+$/){
            $seq->display_id( "Seq".$ct++ ); } 
        $string = $seq->seq;
        $string =~ s/\*$//;
        $seq->seq($string);
        if( $string =~ tr/~.-/~.-/ ){
        $self->warn("These sequences may have already been aligned!");
        }
        push @out, $seq;
    }
    $outtemp->write_seq(@out);
    
    $outtemp->close();
    undef $outtemp;
    close($tfh);
    $tfh = undef;
    return $infilename;
}


=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:  Create parameter inputs for msaprobs program
 Example :
 Returns : parameter string to be passed to msaprobs
           during align
 Args    : name of calling object

 
=cut

sub _setparams {
    my ($self) = @_;
    my ($attr,$method,$value,$param_string);
    $param_string = '';
    
    unless( defined $self->outfile ){
        $self->aformat($DEFAULTS{'AFORMAT'});
        $self->clustalw(0);
    }
    
    #put switches/params in format expected by MSAProbs
    for $attr ( keys %MSAPROBS_PARAMS ){
	$method = lc $attr;
    $value  = $self->$method();
	next unless (defined $value);	
	my  $attr_key = lc $MSAPROBS_PARAMS{$attr};
        $attr_key = ' -'.$attr_key;
        $param_string .= $attr_key.' '.$value;
    }
    
    for $attr ( keys %MSAPROBS_SWITCHES ){
 	$method = lc $attr;
    $value  = $self->$method();
 	next unless $value;
 	my  $attr_key = lc $MSAPROBS_SWITCHES{$attr};
        $attr_key = ' -'.$attr_key;
        $param_string .= $attr_key;
    }

    # Set default output file if no explicit file specified
    # or if a clustalw-formatted file is desired...
    if( $self->clustalw || ! $self->outfile ) {	
	my ($tfh, $outfile) = $self->io->tempfile(-dir => $self->tempdir);
	close($tfh);
	undef $tfh;
	$self->outfile_name($outfile);
    }else{
    $self->outfile_name($self->outfile);
    }
	$param_string .= ' -v' if $self->verbose > 0;
    $param_string .= ' >'.$self->outfile_name;
    $param_string .= ' 2>/dev/null' if $self->quiet && 
                                       $self->verbose < 1;
    $self->arguments($param_string);
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


sub _clustalize {
    my $self    = shift;
    my $infile  = shift;
    my $outfile = $self->outfile;
    
    local $/ = "\n";
    my( $in,$out,$firstline,$line );
    $in  = Bio::Root::IO->new(-file => $infile);
    $out = Bio::Root::IO->new(-file => '>'.$outfile);
    
    while( defined( $firstline = $in->_readline )) {
    last if $firstline !~ /^\s*$/;  }
    $in->_pushback('CLUSTALW format, '.$firstline);
    
    while( defined( $line = $in->_readline )) {
    $out->_print( $line ); }
    
    $out->close();
    $in->close();
    undef $out;
    undef $in;
    $self->debug($outfile);
    return $outfile if -s $outfile;
}



1; # Needed to keep compiler happy
