# $Id$
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Tania Oh
#
# Copyright Tania Oh
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Eponine - Object for execution of the Eponine which
is a mammalian TSS predictor

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
  my $r = $factory->run($seq);
  my $parser = Bio::Tools::Eponine->new($r);

  while (my $feat = $parser->next_prediction){
	  #$feat contains array of SeqFeature
	  foreach my $orf($feat){
		  print $orf->seqname. "\n";
	  }
  }

 # Various additional options and input formats are available.  See
 # the DESCRIPTION section for details.

=head1 DESCRIPTION

wrapper for eponine, a mammalian TSS predictor.

The environment variable EPONINEDIR must be set to point at either the
directory which contains eponine-scan.jar or directly at the jar which
eponine-scan classfiles. NOTE: EPONINEDIR must point at the real file
not a symlink.

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

=head1 AUTHOR

Email gisoht@nus.edu.sg

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Eponine;

#tgot to take inmore parameters

use vars qw($AUTOLOAD @ISA @EPONINE_PARAMS  %EPONINE_PARAMS
	    $EPOJAR $JAVA $PROGRAMDIR $PROGRAMNAME $PROGRAM
            $TMPDIR $TMPOUTFILE  $DEFAULT_THRESHOLD
            %OK_FIELD);
use strict;

use Bio::Tools::Eponine;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
    $DEFAULT_THRESHOLD = 50;
    $PROGRAMNAME = 'java';
    $EPOJAR = 'eponine-scan.jar';

    if( ! defined $PROGRAMDIR ) {
	$PROGRAMDIR = $ENV{'JAVA_HOME'} || $ENV{'JAVA_DIR'};
    }
    if (defined $PROGRAMDIR) {
	foreach my $progname ( [qw(java)],[qw(bin java)] ) {
	    my $f = Bio::Root::IO->catfile($PROGRAMDIR, @$progname);
	    if( -e $f && -x $f ) {
		$PROGRAM = $f;
		last;
	    }
	}
    }

    if( $ENV{'EPONINEDIR'} ) {
    	if ( -d $ENV{'EPONINEDIR'} ) {
	   $EPOJAR = Bio::Root::IO->catfile($ENV{'EPONINEDIR'}, $EPOJAR)
	} elsif(-e $ENV{'EPONINEDIR'}) {
	   $EPOJAR = $ENV{'EPONINEDIR'};
	}
        if ( ! -e $EPOJAR) {
	   $EPOJAR =undef;
	}
    }

    %EPONINE_PARAMS = ('SEQ'      => '/tmp/test.fa',
		       'THRESHOLD' => '0.999',
		       'EPOJAR'   => '/usr/local/bin/eponine-scan.jar',
		       'JAVA'     => '/usr/java/jre1.3.1_02/bin/java');

    @EPONINE_PARAMS=qw(SEQ THRESHOLD JAVA EPOJAR);

    foreach my $attr ( @EPONINE_PARAMS)
    { $OK_FIELD{$attr}++; }
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $self->debug( "************ attr:  $attr\n");
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

    my $java;
    my $seq;
    my $threshold;
    my $epojar;

    my ($attr, $value);
    ($TMPDIR) = $self->tempdir(CLEANUP=>1);
    my $tfh;
    ($tfh,$TMPOUTFILE) = $self->io->tempfile(-dir => $TMPDIR);
    close($tfh);
    undef $tfh;
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
    if  (! defined $epojar && defined $EPOJAR) {
	    $epojar = $EPOJAR;
    }
    else {
	$epojar = $EPONINE_PARAMS{'epojar'} unless defined $epojar;
    }
    if (! defined $java && defined $PROGRAM) {
	    $java = $PROGRAM;
    }
    else {
       $java = $EPONINE_PARAMS{'JAVA'} unless defined $java;
    }
    $self->filename($seq) if ($seq);

    if (-x $java) {
      # full path assumed
      $self->java($java);
    }
    
    $self->epojar($epojar) if (defined $epojar);
    
    if (defined $threshold && $threshold >=0 ){
        $self->threshold($threshold);
    } else {
        $self->threshold($DEFAULT_THRESHOLD);
    }
    
    return $self;
}

=head2 java

    Title   :   java
    Usage   :   $obj->java('/usr/opt/java130/bin/java');
    Function:   Get/set method for the location of java VM
    Args    :   File path (optional)

=cut

sub executable { shift->java(@_); }

sub java {
   my ($self, $exe,$warn) = @_;

   if( defined $exe ) {
     $self->{'_pathtojava'} = $exe;
   }

   unless( defined $self->{'_pathtojava'} ) {
       if( $PROGRAM && -e $PROGRAM && -x $PROGRAM ) {
	   $self->{'_pathtojava'} = $PROGRAM;
       } else {
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($PROGRAMNAME) ) &&
	       -x $exe ) {
	       $self->{'_pathtojava'} = $exe;
	   } else {
	       $self->warn("Cannot find executable for $PROGRAMNAME") if $warn;
	       $self->{'_pathtojava'} = undef;
	   }
       }
   }
   $self->{'_pathtojava'};
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
	unless( $location ) {
	    $self->warn("eponine-scan.jar not found at $location: $!\n");
	    return;
	}
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


=head2 run

 Title   : run
 Usage   : my @genes = $self->run($seq)
 Function: runs Eponine and creates an array of features
 Returns : An Array of SeqFeatures
 Args    : A Bio::PrimarySeqI

=cut

sub run{
    my ($self,$seq) = @_;
    my $infile = $self->_setinput($seq);
    my @tss = $self->_run_eponine($infile);
    return @tss;

}

=head2 predict_TSS

 Title   : predict_TSS
 Usage   : Alias for run()

=cut

sub predict_TSS {
  return shift->run(@_);
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
    #better be a file
    if(!ref $seq){
      return $seq;
    }
    my ($tfh1,$inputfile) = $self->tempfile(-dir=>$TMPDIR);
    my $in = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'Fasta');
    $in->write_seq($seq);
    close($tfh1);
    undef $tfh1;
    return ($inputfile);
}

=head2 _run_eponine

    Title   :  run_eponine
    Usage   :   $obj->_run_eponine()
    Function:   execs the Java VM to run eponine
    Returns :   none
    Args    :   none

=cut

sub _run_eponine {
    my ($self,$infile) = @_;
    my $result = $TMPOUTFILE;
    my @tss;
    #run eponine
    $self->debug( "Running eponine-scan\n");
    my ($java,$epojar) = ( $self->java,
			   $self->epojar);
    unless( defined $java && -e $java && -x $java ) {
	$self->warn("Cannot find java");
	return;
    }
    if (! defined $epojar) { $self->warn("Don't know the name of the Eponine jar file"); return; }
    if (! -e $epojar) {
	$self->warn("Cannot find Eponine jar: $epojar - either you specified an incorrect path in\nEPONINEDIR or it was not in the current working directory");
	return;
    }
    my $cmd  =   $self->java.' -jar '.$self->epojar.' -seq '.$infile.' -threshold '.$self->threshold." > ".$result;
    $self->throw("Error running eponine-scan on ".$self->filename.
		 " \n Check your java version, it has to be version 1.2 or later. Eponine crashed ($cmd) crashed: $? \n")
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
