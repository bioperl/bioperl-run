# BioPerl module for TribeMCL f
#
# Cared for by Shawn Hoon <shawnh@fugu-sg.org>
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::TribeMCL

=head1 SYNOPSIS

  use Bio::Tools::Run::TribeMCL;
  use Bio::SearchIO;

  #3 methods to input the blast results

  #straight forward raw blast output (NCBI or WU-BLAST)
  my @params = ('inputtype'=>'blastfile');

  OR

  #markov program format 
  #protein_id1 protein_id2 evalue_magnitude evalue_factor
  #for example: 
  #proteins ENSP00000257547  and ENSP00000261659
  #with a blast score evalue of 1e-50
  #and proteins O42187 and ENSP00000257547
  #with a blast score evalue of 1e-119
  #entry would be 

  my @array  = [[qw(ENSP00000257547 ENSP00000261659 1 50)],
		[qw(O42187 ENSP00000257547 1 119)]];
  my @params = ('pairs'=>\@array,I=>'2.0');

  OR

  #pass in a searchio object 
  #slowest of the 3 methods as it does more rigourous parsing
  #than required for us here

  my $sio = Bio::SearchIO->new(-format=>'blast',
                               -file=>'blast.out');
  my @params=('inputtype'=>'searchio',I=>'2.0');


  #you can specify the path to the executable manually in the following way
  my @params=('inputtype'=>'blastfile',I=>'2.0',
	      'mcl'=>'/home/shawn/software/mcl-02-150/src/shmcl/mcl',
	      'matrix'=>'/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
  my $fact = Bio::Tools::Run::TribeMCL->new(@params);

  OR

  $fact->matrix_executable('/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
  $fact->mcl_executable('/home/shawn/software/mcl-02-150/src/shmcl/mcl');

  #to run

  my $fact = Bio::Tools::Run::TribeMCL->new(@params);

  #Run the program
  #returns an array reference to clusters where members are
  # the ids
  #for example :2 clusters with 3 members per cluster:
  # $fam = [ [mem1 mem2 mem3],[mem1 mem2 mem3]]

  #pass in either the blastfile path/searchio obj/the array ref to scores
  my $fam = $fact->run($sio); 

  #print out your clusters
  
  for (my $i = 0; $i <scalar(@{$fam}); $i++){
    print "Cluster $i \t ".scalar(@{$fam->[$i]})." members\n";
    foreach my $member (@{$fam->[$i]}){
      print "\t$member\n";
    }
  }

=head1 DESCRIPTION

  TribeMCL is a method for clustering proteins into related groups, which are
  termed 'protein families'. This clustering is achieved by analysing similarity
  patterns between proteins in a given dataset, and using these patterns to assign
  proteins into related groups. In many cases, proteins in the same protein family
  will have similar functional properties.
  TribeMCL uses a novel clustering method (Markov Clustering or MCL)
  which solves problems which normally hinder protein sequence clustering.

  References: 
  Enright A.J., Van Dongen S., Ouzounis C.A; Nucleic Acids Res. 30(7):1575-1584 (2002)

  You will need tribe-matrix (the program used to generate the matrix for input
  into mcl) and mcl (the clustering software) available at:

  http://www.ebi.ac.uk/research/cgg/tribe/ 
  or 
  http://micans.org/mcl/

  Future Work in this module:
  Port the tribe-matrix program into perl so that we can enable have a SearchIO
  kinda module for reading and writing mcl data format

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists. Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bio.perl.org/MailList.html  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via email
or the web:

  bioperl-bugs@bioperl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR - Shawn Hoon

Email shawnh@fugu-sg.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a "_".

=cut


# Let the code begin...
package Bio::Tools::Run::TribeMCL;
use vars qw($AUTOLOAD @ISA  $PROGRAMDIR
            $TMPDIR $TMPOUTFILE @TRIBEMCL_PARAMS
            @OTHER_SWITCHES %OK_FIELD
	    $MATRIXPROGRAM_NAME $MCLPROGRAM_NAME
	    $MCLPROGRAM $MATRIXPROGRAM
	    );
use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;

@ISA = qw(Bio::Root::Root);

# You will need to enable mcl and tribe-matrix to use this wrapper. This
# can be done in (at least) two ways:
#
# 1. define an environmental variable TRIBEDIR 
# export TRIBEDIR =/usr/local/share/mclbin/
# where the tribe-matrix and mcl programs are located.
#you probably need to copy them individually to the same directory
#if the installation puts them in different directories. or simply put them in
#your standard /usr/local/bin
#
# 2. include a definition of an environmental variable TRIBEDIR in
# every script that will use TRIBEMCL.pm
# $ENV{WISEDIR} = '/usr/local/share/mclbin/;
#
#3. Manually set the path to the executabes in your code:
#

#my @params=('inputtype'=>'blastfile',I=>'2.0','
#                       mcl'=>'/home/shawn/software/mcl-02-150/src/shmcl/mcl','
#                       matrix'=>'/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
#my $fact = Bio::Tools::Run::TribeMCL->new(@params);

#or
#$fact->matrix_executable('/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
#$fact->mcl_executable('/home/shawn/software/mcl-02-150/src/shmcl/mcl');


BEGIN {
    $MATRIXPROGRAM_NAME = 'tribe-matrix';
    $MCLPROGRAM_NAME    = 'mcl';
    if (defined $ENV{TRIBEDIR}) {
        $PROGRAMDIR = $ENV{TRIBEDIR} || '';
        $MCLPROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,$MCLPROGRAM_NAME.($^O =~ /mswin/i ?'.exe':''));
        $MATRIXPROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,$MATRIXPROGRAM_NAME.($^O =~ /mswin/i ?'.exe':''));
    }

    @TRIBEMCL_PARAMS = qw(I INPUTTYPE HSP BLASTFILE SEARCHIO 
			  PAIRS MCL MATRIX WEIGHT);
    @OTHER_SWITCHES = qw(VERBOSE QUIET); 

    # Authorize attribute fields
    foreach my $attr ( @TRIBEMCL_PARAMS, @OTHER_SWITCHES) {
      $OK_FIELD{$attr}++;
    }
}

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);
  
  my ($attr, $value);
  (undef,$TMPDIR) = $self->io->tempdir(CLEANUP=>1);
  (undef,$TMPOUTFILE) = $self->io->tempfile(-dir => $TMPDIR);
  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
    next if( $attr =~ /^-/ ); # don't want named parameters
    if ($attr =~/MCL/i) {
      $self->mcl_executable($value);
      next;
    }
    if ($attr =~ /MATRIX/i){
      $self->matrix_executable($value);
      next;
    }
    $self->$attr($value);
  }
  defined($self->weight) || $self->weight(200);
  defined($self->I) || $self->I(3.0);
  unless ($self->mcl_executable) {
    if( $self->verbose >= 0 ) {
      warn "mcl program not found as ".$self->mcl_executable." or not executable. \n"; 
    }
  }
  unless ($self->matrix_executable) {
    if( $self->verbose >= 0 ) {
      warn "tribe-matrix program not found as ".$self->matrix_executable." or not executable. \n"; 
    }
  }

  return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $attr = uc $attr;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr} = shift if @_;
    return $self->{$attr};
}

=head2 mcl_executable

 Title   : mcl_executable
 Usage   : $self->mcl_executable()
 Function: get set for path to mcl executable
 Returns : String or undef if not installed
 Args    : [optional] string of path to executable
           [optional] boolean to warn on missing executable status

=cut

sub mcl_executable{
   my ($self,$exe,$warn) = @_;
   
   if( defined $exe ) {
       $self->{'_mcl_exe'} = $exe;
   }
   unless( defined $self->{'_mcl_exe'} ) {
       # this would be the name set in the BEGIN block
       if( $MCLPROGRAM && -e $MCLPROGRAM && -x $MCLPROGRAM ) {
	   $self->{'_mcl_exe'} = $MCLPROGRAM;
       } else { 
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($MCLPROGRAM_NAME) ) &&
	       -x $exe ) {
	       $self->{'_mcl_exe'} = $exe;
	   } else { 
	       $self->warn("Cannot find executable for $MCLPROGRAM_NAME") 
		   if $warn;
	       $self->{'_mcl_exe'} = undef;
	   }
       }
   }
   $self->{'_mcl_exe'};
}

=head2 matrix_executable

 Title   : matrix_executable
 Usage   : $self->matrix_executable()
 Function: get set for path to tribe-matrix executable
 Returns : String or undef if not installed
 Args    : [optional] string of path to executable
           [optional] boolean to warn on missing executable status

=cut

sub matrix_executable{
   my ($self,$exe,$warn) = @_;
   
   if( defined $exe ) {
       $self->{'_matrix_exe'} = $exe;
   }
   unless( defined $self->{'_matrix_exe'} ) {
       # this would be the name set in the BEGIN block
       if( $MATRIXPROGRAM && -e $MATRIXPROGRAM && -x $MATRIXPROGRAM ) {
	   $self->{'_matrix_exe'} = $MATRIXPROGRAM;
       } else { 
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($MATRIXPROGRAM_NAME) ) &&
	       -x $exe ) {
	       $self->{'_matrix_exe'} = $exe;
	   } else { 
	       $self->warn("Cannot find executable for $MATRIXPROGRAM_NAME") 
		   if $warn;
	       $self->{'_matrix_exe'} = undef;
	   }
       }
   }
   $self->{'_matrix_exe'};
}

=head2 run

 Title   : run
 Usage   : $self->run()
 Function: runs the clustering
 Returns : Array Ref of clustered Ids 
 Args    : 

=cut

sub run {
  my ($self,$input) = @_;
  my $file = $self->_setup_input($input);
  defined($file) || $self->throw("Error setting up input ");
  #run tribe-matrix to generate matrix for mcl
  my ($index_file, $mcl_infile) = $self->_run_matrix($file);
  $self->throw("tribe-matrix not run properly as index file is missing") unless (-e $index_file);
  $self->throw("tribe-matrix not run properly as matrix file is missing") unless (-e $mcl_infile);
  #run mcl
  my $families = $self->_run_mcl($index_file,$mcl_infile);
  return $families;
}

=head2 _run_mcl

 Title   : _run_mcl
 Usage   : $self->_run_mcl()
 Function: internal function for running the mcl program
 Returns : Array Ref of clustered Ids
 Args    : Index_file name, matrix input file name

=cut

sub _run_mcl {
  my ($self, $ind_file,$infile) = @_;
  my $inflation = $self->I;
  my $exe = $self->mcl_executable;
  my ($tfh1,$mclout) = $self->io->tempfile(-dir=>$TMPDIR);
  my $cmd = "$exe $infile -I $inflation -o $mclout";
  if($self->quiet || 
     ($self->verbose < 0)){
      $cmd .= " -V all";
      if( $^O !~ /Mac/ && $^O !~ /Win/ ) {
	  $cmd .= ' 2> /dev/null';
      }
  }
  my $status = system($cmd);
  $self->throw( "mcl  call ($cmd) crashed: $? \n") unless $status==0;
  my $families = $self->_parse_mcl($ind_file,$mclout);
  return $families;
}
  
=head2 _run_matrix

 Title   : _run_matrix
 Usage   : $self->_run_matrix()
 Function: internal function for running the tribe-matrix program
 Returns : index filepath and matrix file path
 Args    : filepath of parsed ids and scores

=cut

sub _run_matrix {
  my ($self,$parse_file) = @_;
  my ($tfh1,$indexfile) = $self->io->tempfile(-dir=>$TMPDIR);
  my ($tfh2,$matrixfile) = $self->io->tempfile(-dir=>$TMPDIR);
  my $exe = $self->matrix_executable || $self->throw("tribe-matrix not found.");
  my $cmd = $exe. " $parse_file -ind $indexfile -out $matrixfile > /dev/null ";
  my $status = system($cmd);
  $self->throw( "tribe-matrix call ($cmd) crashed: $? \n") unless $status==0;
  
  return ($indexfile,$matrixfile);
}

=head2 _setup_input

 Title   : _setup_input
 Usage   : $self->_setup_input()
 Function: internal function for running setting up the inputs needed for running mcl
 Returns : filepath of parsed ids and scores
 Args    : 

=cut

sub _setup_input {
    my ($self,$input) = @_;
    my ($type,$rc);

    my ($tfh,$outfile) = $self->io->tempfile(-dir=>$TMPDIR);

    $type = $self->inputtype();

    if($type =~/blastfile/i){
	$self->blastfile($input);
	$rc = $self->_parse_blastfile($self->blastfile,$tfh);
    } elsif($type=~/searchio/i){
	$self->searchio($input);
	$rc = $self->_get_from_searchio($self->searchio,$tfh);
    } elsif($type=~/pairs/i) {
	$self->pairs($input);
	for my $line (@{ $self->pairs }){
	    print $tfh join("\t",@{$line}), "\n"; 
	    $rc++;
	}
    } elsif($type =~/hsp/i) {
	$self->hsp($input);
	$rc = $self->_get_from_hsp($self->hsp,$tfh);
    } else {
	$self->throw("Must set inputtype to either blastfile,searchio or paris using \$fact->blastfile |\$fact->searchio| \$fact->pairs");
    }
    unless ( $rc ) {
	$self->throw("Need inputs for running tribe mcl, nothing provided"); 
    }
    close($tfh);
    return $outfile;
}

=head2 _get_from_hsp

 Title   : _get_from_hsp
 Usage   : $self->_get_from_hsp()
 Function: internal function for getting blast scores from hsp 
 Returns : array ref to ids and score [protein1 protein2 magnitude factor]
 Args    :  L<Bio::Search::HSP::GenericHSP>

=cut

sub _get_from_hsp {
    my ($self,$hsp,$tfh) = @_;
    my @array;
    my $count;
    foreach my $pair (@{$hsp}){
        my $sig = $pair->score;
        $sig =~ s/^e-/1e-/g;
        my $expect=sprintf("%e",$sig);
        if ($expect==0){
          my $wt = $self->weight;
          $expect=sprintf("%e","1e-$wt");
        }
        my $first=(split("e-",$expect))[0];
        my $second=(split("e-",$expect))[1];

	print $tfh join("\t", $pair->feature1->seqname,
			$pair->feature2->seqname,int($first),
			int($second) ), "\n";
	$count++;
    }
    return $count;
}
    

=head2 _get_from_searchio

 Title   : _get_from_searchio
 Usage   : $self->_get_from_searchio()
 Function: internal function for parsing blast scores from searchio object
 Returns : array ref to ids and score [protein1 protein2 magnitude factor]
 Args    :  L<Bio::Tools::SearchIO>

=cut

sub _get_from_searchio {
  my ($self,$sio,$tfh) = @_;
  my @array;
  my $count;
  while( my $result = $sio->next_result ) {
    while( my $hit = $result->next_hit ) {
      while( my $hsp = $hit->next_hsp ) {
        my $sig = $hsp->evalue;
        $sig =~ s/^e-/1e-/g;
        my $expect=sprintf("%e",$sig);
        if ($expect==0){
          my $wt = $self->weight;
          $expect=sprintf("%e","1e-$wt");
        }
        my $first=(split("e-",$expect))[0];
        my $second=(split("e-",$expect))[1];
        print $tfh join("\t",
			$hsp->feature1->seqname, 
			$hsp->feature2->seqname,
			int($first),
			int($second) ), "\n";
        
	$count++;
      }
    }
  }
  return $count;
}

=head2 _parse_blastfile

 Title   : _parse_blastfile
 Usage   : $self->_parse_blastfile()
 Function: internal function for quickly parsing blast evalue scores from raw blast output file
 Returns : array ref to ids and score [protein1 protein2 magnitude factor]
 Args    :  file path

=cut

sub _parse_blastfile {
  my ($self, $file,$tfh) = @_;
  open(FILE,$file) || $self->throw("Cannot open Blast Output File");
  my ($query,$reference,$first,$second);
  my @array;
  my $count;
  my $weight = $self->weight;
  while(<FILE>){
    if(/Query=\s+(\S+)/){
      $query = $1;
    }
    if(/^>(\S+)/){
      $reference = $1;
    }
    if (/Expect = (\S+)/){
      my $raw=$1;
      $raw=~s/^e-/1e-/g;
      my $expect=sprintf("%e",$raw);
      if ($expect==0){
        $expect=sprintf("%e","1e-$weight");	
			}
      $first=(split("e-",$expect))[0];
      $second=(split("e-",$expect))[1];
      print $tfh join("\t", $query, 
		      $reference,
		      int($first),
		      int($second)), "\n";
      $count++;
    }
  }
  return $count;
}

=head2 _parse_mcl

 Title   : _parse_mcl
 Usage   : $self->_parse_mcl()
 Function: internal function for quickly parsing mcl output and 
           generating the array of clusters
 Returns : Array Ref of clustered Ids
 Args    :  index file path, mcl output file path

=cut

sub _parse_mcl {
  my ($self,$ind,$mcl) = @_;
  open (MCL,$mcl) || $self->throw("Error, cannot open $mcl for parsing");
  my $i =-1;
  my $start;
  my (@cluster,@out);
  while(<MCL>){
    if ($start) {
      chomp($_);
      $cluster[$i] = join(" ",$cluster[$i],"$_");
    }
    if(/^\d+/){
      $start = 1;
      $i++;
      $cluster[$i] = join(" ",$cluster[$i] || '',"$_");
    }
    if (/\$$/){
      $start = 0;
    }
  }
  open (IND,$ind) || $self->throw("Cannot open $ind for parsing");
  my %hash;
  while(<IND>){
      /^(\S+)\s+(\S+)/;
      $hash{$1}=$2;
  }
  
  for (my $j=0;$j<$i+1;$j++)	{
      my @array=split(" ",$cluster[$j]);
      for (my $p=1;$p<$#array;$p++){
	  push @{$out[$array[0]]}, $hash{$array[$p]};
      }
  }    
  return \@out;
}


=head2 io

 Title   : io
 Usage   : $obj->io($newval)
 Function: Gets a L<Bio::Root::IO> object
 Returns : L<Bio::Root::IO> object
 Args    : none


=cut

sub io{
   my ($self) = @_;
   unless( defined $self->{'io'} ) {
       $self->{'io'} = new Bio::Root::IO(-verbose => $self->verbose());
   }
    return $self->{'io'};
}

1;


