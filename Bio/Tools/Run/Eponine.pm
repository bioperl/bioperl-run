# $Id$
#
# Cared for by Tania Oh 
#
# Copyright Tania Oh 
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Eponine- 
Object for execution  of the Eponine which is a mammalian TSS predictor 

=head1 SYNOPSIS

  use Bio::Tools::Run::Eponine;
  use strict;
  my $seq = "/data/seq.fa";
  my $threshold  = "0.999";
  my @params = ( '-seq' => $seq,
  		 '-threshold' => $threshold, 
	         '-epojar'  => '/usr/local/bin/eponine-scan.jar',
	          '-java'  => '/usr/local/bin/java');

  my $factory = Bio::Tools::Run::Eponine->new(@params);
  # run eponine against fasta 
  my $r = $factory->run_eponine();
  my $parser = Bio::Tools::Eponine->new($r);
  
  while (my $feat = $parser->next_prediction){
	  #$feat contains array of SeqFeature
	  foreach my $orf($feat){
		  print $orf->seqname. "\n";
	  }
  }
 
  


Various additional options and input formats are available.  See the
DESCRIPTION section for details.

=head1 DESCRIPTION

wrapper for eponine.. a mammalian TSS predictor

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org               - General discussion
  http://bio.perl.org/MailList.html   - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via email
or the web:

  bioperl-bugs@bio.perl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR  

Email gisoht@nus.edu.sg 

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Eponine;



#tgot to take inmore parameters

use vars qw($AUTOLOAD @ISA @EPONINE_PARAMS  %EPONINE_PARAMS  $EPOJAR $JAVA $PROGRAMDIR 
            $TMPDIR $TMPOUTFILE 
            %OK_FIELD);
use strict;

use Bio::Tools::Eponine;
use Bio::Root::Root;
use Bio::Root::IO;

BEGIN {      


  if (defined $ENV{EPONINEDIR}) {
       $PROGRAMDIR = $ENV{EPONINEDIR} || '';
        $EPOJAR = Bio::Root::IO->catfile($PROGRAMDIR, 'eponine-scan.jar'.($^O =~ /mswin/i ?'.exe':''));
	# $JAVA = Bio::Root::IO->catfile($PROGRAMDIR, 'java'.($^O =~ /mswin/i ?'.exe':''));
   
  }
  else {                                                                 
      $EPOJAR= 'eponine-scan.jar';
      #$JAVA = 'java';
  }

  %EPONINE_PARAMS = ('SEQ'      => '/tmp/test.fa',
                     'THRESHOLD' => '0.999',
		     'EPOJAR'   => '/usr/local/bin/eponine-scan.jar',
		     'JAVA'     => '/usr/java/jre1.3.1_02/bin/java');
 
  @EPONINE_PARAMS=qw(SEQ THRESHOLD JAVA EPOJAR);

 foreach my $attr ( @EPONINE_PARAMS)
                  { $OK_FIELD{$attr}++; }



}

@ISA = qw(Bio::Root::Root Bio::Root::IO);
sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    print "************ attr:  $attr\n";
    $attr =~ s/.*:://;
    $attr = uc $attr;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr} = shift if @_;
    return $self->{$attr};
}



sub new {
    my ($caller, @args) = @_;
    # chained new
    my $self = $caller->SUPER::new(@args);
    # so that tempfiles are cleaned up
    $self->_initialize_io();

    my $java;
    my $seq;
    my $threshold;
    my $epojar;


    my ($attr, $value);
    (undef,$TMPDIR) = $self->tempdir(CLEANUP=>1);
    (undef,$TMPOUTFILE) = $self->tempfile(-dir => $TMPDIR);
    while (@args)  {
       $attr =   shift @args;
       $value =  shift @args;
       next if( $attr =~ /^-/ ); # don't want named parameters
       if ($attr =~/JAVA/i) {
	     $java = $value;
	    next;
	}
	if ($attr =~ /EPOJAR/i){
	    $epojar = $value;
	   next;
	}
	if ($attr =~ /THRESHOLD/i){
	    $threshold = $value;
	   next;
	}
	if ($attr =~ /SEQ/i){
	    $seq = $value;
	   next;
	}
	$self->$attr($value);
    }

    $self->{'_java'}      = undef; # location of java vm
    $self->{'_epojar'}    = undef; # location of eponine-scan.jar executable JAR file.
    $self->{'_threshold'} = 0.999; # minimum posterior for filtering predictions 
    $self->{'_filename'} = undef; #location of seq 
    $seq = $EPONINE_PARAMS{'seq'}     unless defined $seq;
    $threshold = $EPONINE_PARAMS{'threshold'}     unless defined $threshold;
    $java = $EPONINE_PARAMS{'JAVA'} unless defined $java; 
    $epojar = $EPONINE_PARAMS{'epojar'} unless defined $epojar; 
    $self->filename($seq) if ($seq);       


    if (-x $java) {
        # full path assumed
        $self->java($java);
    }
=head
    else {
        # search shell $PATH
	     eval {
	       $self->java($self->exist_java('java'));
          };
        if ($@) {
           $self->throw("Can't find executable java");

         }
    }
=cut
						     
    if (-e $epojar) {
	 $self->epojar($epojar);
    } else {
        $self->throw("Can't find eponine-scan.jar");
    }

    if (defined $threshold && $threshold >=0 ){
        $self->threshold($threshold);
    } else {
        $self->threshold(50); 
    }
				  
    return $self;
}


=head2 exist_java 

 Title   : exist_java 
 Usage   : my $exist = $self->exist_java()
 Function: Determine whether genscan program can be found on current host
 Returns :  1 if genscan program found at expected location, 0 otherwise. 
 Args    : 

=cut

sub exists_java{
    my $self = shift;
    if( my $f = Bio::Root::IO->exists_exe($JAVA) ) {
        $JAVA= $f if( -e $f );
        return 1;
   }
}

=head2 filename 

 Title   : filename 
 Usage   : my $filename= $self->filename
 Function: Get/Set the method to submit the seq 
 Returns : string
 Args    : 

=cut

sub filename{
    my ($self, $val) = @_;
    if( defined $val ) {
	$self->{'_filename'} = $val;
    }
    return $self->{'_filename'};
}

=head2 java

    Title   :   java
    Usage   :   $obj->java('/usr/opt/java130/bin/java');
    Function:   Get/set method for the location of java VM
    Args    :   File path (optional)

=cut

sub java {
    my ($self, $location) = @_;
    if ($location)
    {
      $self->throw("java not found at $location: $!\n")
        unless (-e $location);
        $self->{'_java'} = $location ;
      $self->throw("java not executable: $!\n")
        unless (-x $location);
    }
    return $self->{'_java'};
}


=head2 epojar

    Title   :   epojar
    Usage   :   $obj->epojar('/some/path/to/eponine-scan.jar');
    Function:   Get/set method for the location of the eponine-scan executable JAR
    Args    :   Path (optional)

=cut

sub epojar {
    my ($self, $location) = @_;
    if ($location)
    {
      $self->throw("eponine-scan.jar not found at $location: $!\n")
          unless (-e $location);
      $self->{'_epojar'} = $location ;
    }
    return $self->{'_epojar'};
}



=head2 threshold 

 Title   : threshold 
 Usage   : my $threshold = $self->threshold
 Function: Get/Set the threshold for Eponine 
 Returns : string
 Args    : b/w 0.9 and  1.0

=cut

sub threshold{
  my ($self, $threshold) = @_;
  if (defined $threshold) {
      $self->{'_threshold'} = $threshold ;
   }
    return $self->{'_threshold'};

}


=head2 predict_TSS

 Title   : predict_TSS
 Usage   : my @genes = $self->predict_TSS($seq)
 Function: runs Eponine and creates an array of genes 
 Returns : An Array of SeqFeatures
 Args    : A Bio::PrimarySeqI
 
=cut

sub predict_TSS{
    my ($self,$seq) = @_;
    my $infile = $self->_setinput($seq);
    my @tss = $self->_run_eponine();
    return @tss;
    
}


=head2  _setinput()

 Title   : _setinput
 Usage   : Internal function, not to be called directly
 Function: writes input sequence to file and return the file name
 Example :
 Returns : string 
 Args    : 

=cut

sub _setinput {
    my ($self,$seq) = @_;
    my ($tfh1,$inputfile) = $self->tempfile(-dir=>$TMPDIR);
    my $in = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'Fasta');
    $in->write_seq($seq);
    return ($inputfile);
}

=head2 _run_eponine

    Title   :  run_eponine
    Usage   :   $obj->_run_eponine()
    Function:   execs the Java VM to run eponine
    Returns :   none
    Args    :   none

=cut
sub run_eponine {
    my ($self) = @_;
    my $result = $TMPOUTFILE;
    my @tss;
    #run eponine
    print "Running eponine-scan\n";
    my $cmd  =   $self->java.' -jar '.$self->epojar.' -seq '.$self->filename.' -threshold '.$self->threshold." > ".$result;
    $self->throw("Error running eponine-scan on ".$self->filename." \n Eponine crashed ($cmd) crashed: $? \n")
         if (system ($cmd));

   #parse results even though it's wierd.. thought parser and wrapper should be separate
   my $epoParser =  Bio::Tools::Eponine->new(-file =>$result);

   while (my $tss = $epoParser->next_prediction()){
        push (@tss, $tss);
   }
    return @tss;
}




1;
__END__
