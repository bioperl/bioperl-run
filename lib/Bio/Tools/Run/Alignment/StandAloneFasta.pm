# $Id$
#StandAloneFasta.pm v1.00 2002/11/01 
#
#Bioperl module for Bio::Tools::Run::Alignment::StandAloneFasta
#
# Written by Tiequan Zhang
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Shawn Hoon
# Copyright Tiequan Zhang
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::StandAloneFasta - Object for the local
execution of the Fasta3 programs ((t)fasta3, (t)fastx3, (t)fasty3
ssearch3)

=head1 SYNOPSIS

  #!/usr/bin/perl
  use Bio::Tools::Run::Alignment::StandAloneFasta;
  use Bio::SeqIO;
  use strict;
  my @arg=(
  'b' =>'15',
  'O' =>'resultfile',
  'H'=>'',
  'program'=>'fasta34'
  );

  my $factory=Bio::Tools::Run::Alignment::StandAloneFasta->new(@arg);
  $factory->ktup(1);

  $factory->library('p');

  #print result file name
  print $factory->O;


  my @fastreport=$factory->run($ARGV[0]);

  foreach  (@fastreport) {
        print "Parsed fasta report:\n";
    my $result = $_->next_result;
    while( my $hit = $result->next_hit()) {
       print "\thit name: ", $hit->name(), "\n";
         while( my $hsp = $hit->next_hsp()) {
         print "E: ", $hsp->evalue(), "frac_identical: ",
        $hsp->frac_identical(), "\n";
         }
      }
    }

   #pass in seq objects
   my $sio = Bio::SeqIO->new(-file=>$ARGV[0],-format=>"fasta");
   my $seq = $sio->next_seq;
   my @fastreport=$factory->run($ARGV[0]);

=head1 DESCRIPTION

This wrapper works with version 3 of the FASTA program package (see
W. R. Pearson and D. J. Lipman (1988), "Improved Tools for Biological
Sequence Analysis", PNAS 85:2444-2448 (Pearson and Lipman, 1988);
W. R.  Pearson (1996) "Effective protein sequence comparison"
Meth. Enzymol.  266:227-258 (Pearson, 1996); Pearson et. al. (1997)
Genomics 46:24-36 (Zhang et al., 1997); Pearson, (1999) Meth. in
Molecular Biology 132:185-219 (Pearson, 1999).  Version 3 of the FASTA
packages contains many programs for searching DNA and protein
databases and one program (prss3) for evaluating statistical
significance from randomly shuffled sequences.

Fasta is available at ftp://ftp.virginia.edu/pub/fasta

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

=head1 AUTHOR -  Tiequan Zhang

       Adapted for bioperl by Shawn Hoon
       Enhanced by Jason Stajich

Email tqzhang1973@yahoo.com
      shawnh@fugu-sg.org
      jason-at-bioperl.org

=head1 Appendix

The rest of the documendation details each of the object
methods. Internal methods are preceeded with a underscore

=cut

package Bio::Tools::Run::Alignment::StandAloneFasta;

use vars qw ($AUTOLOAD @ISA $library %parameters 
	     $ktup @FASTA_PARAMS %OK_FIELD @OTHER_PARAMS);
use strict;

use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Seq;
use Bio::SeqIO;
use Bio::SearchIO;
use Bio::Tools::Run::WrapperBase;

BEGIN {
  @FASTA_PARAMS=qw(a A b c E d f g h H i j l L M m n O o p Q q r R s S w x y z);
  @OTHER_PARAMS =qw(program output database);
  foreach my $att (@FASTA_PARAMS, @OTHER_PARAMS) {$OK_FIELD{$att}++;}
  $ktup=2; 
  %parameters=('H' => '',
	       'q' => '', 
	       'm' =>'1', 'O' =>'');
    
}

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

sub new {
  my ($caller,@args)=@_;
  #chained new
  my $self = $caller->SUPER::new(@args);
  while(@args){
        my $attr = shift @args;
        my $value = shift @args;
        next if ($attr=~/^-/ || ! $attr);
        $self->$attr($value); 
  }
  return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr} = shift if @_;
    return $self->{$attr};
}


=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string     
 Args    : None

=cut

sub program_name {
  my ($self) = shift;
  return $self->program(@_);
}

=head2 executable

 Title   : executable
 Usage   : my $exe = $blastfactory->executable('blastall');
 Function: Finds the full path to the 'codeml' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to 
           [optional] boolean flag whether or not warn when exe is not found


=cut

sub executable {
   my ($self, $exename, $exe,$warn) = @_;
   $exename = 'fasta34' unless defined $exename;

   if( defined $exe && -x $exe ) {
     $self->{'_pathtoexe'}->{$exename} = $exe;
   }
   unless( defined $self->{'_pathtoexe'}->{$exename} ) {
       my $f = $self->program_path($exename);	    
       $exe = $self->{'_pathtoexe'}->{$exename} = $f if(-e $f && -x $f );
        
       #  This is how I meant to split up these conditionals --jason
       # if exe is null we will execute this (handle the case where
       # PROGRAMDIR pointed to something invalid)
       unless( $exe )  {  # we didn't find it in that last conditional
	   if( ($exe = $self->io->exists_exe($exename)) && -x $exe ) {
	       $self->{'_pathtoexe'}->{$exename} = $exe;
	   } else { 
	       $self->warn("Cannot find executable for $exename") if $warn;
	       $self->{'_pathtoexe'}->{$exename} = undef;
	   }
       }
   }
   return $self->{'_pathtoexe'}->{$exename};
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{FASTADIR}) if $ENV{FASTADIR};
}

=head2 run

 Title   : run

 Usage   : my @fasta_object = $factory->($input,$onefile);
           where $factory is the name of executable FASTA program;
           $input is file name containing the sequences in the format 
           of fasta  or Bio::Seq object or array of Bio::Seq object;
           $onefile is 0 if you want to save the outputs to different files 
           default: outputs are saved in one file

 Function: Attempts to run an executable FASTA program  
           and return array of  fasta objects containing the fasta report 
 Returns : aray of fasta report object
           If the user specify the output file(s), 
           the raw fasta report will be saved
 Args    : sequence object OR array reference of sequence objects
           filename of file containing fasta formatted sequences

=cut


sub run {
    my ($self,$input,$onefile)=@_;
    local * FASTARUN;

    $self->io->_io_cleanup;
    my $program = $self->executable($self->program_name) ||  
	$self->throw("FASTA program not found or not executable.\n");
    # You should specify a library file
    $self->throw("You didn't choose library.\n") unless ( $library);
    
    my @seqs = $self->_setinput($input);
    return 0 unless (@seqs);

    my @fastobj; 
    my ($fhout, $tempoutfile)=$self->io->tempfile(-dir=>$self->tempdir);

    my $outfile=$self->O();

   # The outputs from executable FASTA program will
   # be saved into different files if $onefile is 0,
   # else will be concatenated into one file
    my $onfile = (!defined $onefile || $onefile =~ /^0$/);

    unless( $onfile ) {
	my $count=0;

	# do some fancy stuff here to test if we are running fasta34 
	# with mlib so we just pass in a single file rather than
	# running fasta N times
	# (not implemented yet)
	
	foreach my $seq (@seqs){
	    $count++; 
            # Decide if the output will be saved into a temporary file   
	    if( $outfile ) { 
		$self->O(sprintf("%s_%d",$outfile,$count));
	    }
	    
	    my ($fhinput,$teminputfile)=
		$self->io->tempfile(-dir=>$self->tempdir);

	    my $temp = Bio::SeqIO->new(-fh=>$fhinput, '-format'=>'Fasta');
	    $temp->write_seq($seq);
	    $temp->close();
	    close $fhinput;
	    undef $fhinput;
	    my $para= $self->_setparams;

	    $para .=" $teminputfile $library $ktup";
	    $para ="$program $para";
	    my $object;
	    unless( $outfile ) {
		open(FASTARUN, "$para |") || $self->throw($@);
		$object = Bio::SearchIO->new(-fh=>\*FASTARUN, 
					     -format=>"fasta");
	    } else {
		if ( $self->verbose() < 0) { 
		    $para .= '  >/dev/null 2>/dev/null';
		} else { 
		    $self->debug("Going to execute: $para");
		}
		my $status = system($para);
		$self->throw("$para crashed:  $?\n" )unless ($status==0);
		$object = Bio::SearchIO->new(-file=>$self->O, 
					     -format=>"fasta");
	    }	    
	    push @fastobj, $object;
	}
    } else {
	if ($outfile){
	    open (FILE, ">$outfile") or $self->throw("can't use $outfile:$!");
	    close(FILE);
	}
	
	foreach my $seq (@seqs){
	    my ($fhinput,$teminputfile)=$self->io->tempfile(-dir=>$self->tempdir);
	    my $temp=Bio::SeqIO->new(-fh=>$fhinput, '-format'=>'fasta');
	    $temp->write_seq($seq);
	    $temp->close();
	    close $fhinput;
	    undef $fhinput;
	    
	    $self->O($tempoutfile) if( $outfile );
	    my $para= $self->_setparams;
	    $para .= "  $teminputfile $library $ktup";
	    $para ="$program $para";
	    my $object;
	    unless( $outfile ) {		
		open(FASTARUN, "$para |") || $self->throw($@);
		$object=Bio::SearchIO->new(-fh=>\*FASTARUN, 
					   -format=>"fasta");
	    } else {		
		if ( $self->verbose() < 0) { 
		    $para .= '  >/dev/null 2>/dev/null';
		} else { 
		    $self->debug("Going to execute: $para");
		}
		my $status = system($para);
		$self->throw("$para crashed:  $?\n" )unless ($status==0);
		$object = Bio::SearchIO->new(-file=>$self->O, 
					     -format=>"fasta");		
	    }
	    push @fastobj, $object;
	    
             # The output in the temporary file
	     # will be saved at the end of $outfile
	    if($outfile){
		open (FHOUT, $tempoutfile) or die("can't  open the $tempoutfile file");
		open (FH, ">>$outfile") or die("can't  use the $outfile file");
		print FH (<FHOUT>);
		close (FHOUT);  
		close (FH);
	    }   
	}
    }
    return @fastobj;
}

=head2 library

 Title   : library
 Usage   : my $lb = $self->library
 Function: Fetch or set the name of the library to search against
 Returns : The name of the library 
 Args    : No argument if user wants to fetch the name of library file; 
           A letter or a string of letter preceded by %; 
           (e.g. P or %pn, the letter is  the character in the third field  
           of any line of fastlibs file  ) or the name of library file 
           (if environmental variable FASTLIBS is not set); 
            if user wants to set the name of library file to search against

=cut

sub library {
    my($self,$lb)=@_;
    return $library if (!defined($lb));

    if ( ($lb =~ /^%[a-zA-Z]+$/)||($lb=~ /^[a-zA-Z]$/)){
	if(! defined $ENV{'FASTLIBS'} ){
	    $self->throw("abbrv. list request but FASTLIBS undefined, cannot use $lb");
	}
    } else {
	unless ( -e $lb){
	    $self->throw("cannot open $lb library");
	}
    }

    return $library=$lb;
}

*database = \&library;

=head2 output

 Title   : output
 Usage   : $obj->output($newval)
 Function: The output directory if we want to use this
 Example : 
 Returns : value of output (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub output{
    my $self = shift;

    return $self->{'output'} = shift if @_;
    return $self->{'output'};
}

=head2  ktup

 Title   :  ktup
 Usage   :  my $ktup = $self->ktup 
 Function:  Fetch or set the ktup value for executable FASTA programs
 Example :
 Returns :  The value of ktup  if defined, else undef is returned 
 Args    :  No argument if user want to fetch ktup value; A integer value between 1-6 if user want to set the
           ktup value

=cut

sub ktup {
  my($self,$k)=@_;
  if(!defined($k)){return $ktup;}
  if ($k =~ /^[1-6]$/){
    $ktup=$k;
    return $ktup
  } else {
    $self->warn("You should set the ktup value between 1-6. The FASTA program will decide your default ktup value.");
    return $ktup= undef;
  }
}

=head2  _setinput

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly  
 Function:   Create input file(s) for Blast executable
 Example :
 Returns : array of Bio::Seq object reference
 Args    : Seq object reference or input file name

=cut

sub _setinput  {

    my ($self, $input) = @_;

    if( ! defined $input ) { 
	$self->throw("Calling fasta program with no input");  
    } 

    my @seqs;
    if( ! ref $input ) {
	if( -e $input ) {
	    my $seqio = Bio::SeqIO->new(-format => 'fasta', -file => $input);
	    while( my $seq = $seqio->next_seq ) {
		push @seqs, $seq;
	    }
	} else {
	    $self->throw("Input $input was not a valid filename");
	}
    } elsif( ref($input) =~ /ARRAY/i ) {
	foreach ( @$input ) {
	    if( ref($_) && $_->isa('Bio::PrimarySeqI') ) {
		push @seqs, $_;
	    } else {
		$self->warn("Trying to add a " . ref($_) ." but expected a Bio::PrimarySeqI");
	    }
	}
	if( ! @seqs) {
	    $self->throw("Did not pass in valid input -- no sequence objects found");
	}
    } elsif( $input->isa('Bio::PrimarySeqI') ) {
	push @seqs, $input;
    }
    return @seqs;
}

=head2  _exist

 Title   : _exist
 Usage   : Internal function, not to be called directly
 Function: Determine whether a executable FASTA program can be found 
           Cf. the DESCRIPTION section of this POD for how to make sure
           for your FASTA installation to be found. This method checks for
           existence of the blastall executable in the path.
 Returns : 1 if FASTA program found at expected location, 0 otherwise.
 Args    :  none

=cut

sub _exist {
  my  $exe = shift @_;

  return 0 unless($exe =~ /fast|ssearch/);

  $exe .='.exe' if ($^O =~ /mswin/i);

  my $f;
  
  return ($f=Bio::Root::IO->exists_exe($exe))&&(-x $f);
}

=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly  
 Function:  Create parameter inputs for FASTA executable
 Returns : part of parameter string to be passed to FASTA program
 Args    : none

=cut

sub _setparams {
    my ($self,$attr,$value);
    $self = shift;
    my $para = "";
    foreach my $attr(@FASTA_PARAMS) {
	$value = $self->$attr();
	next unless (defined $value);
	$para .=" -$attr $value";
    }
    $para .= " -q ";
    return $para;
}

1;
__END__

