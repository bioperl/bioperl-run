# BioPerl module for Bio::Tools::Run::Alignment::Sim4
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Sim4 - Wrapper for Sim4 program that allows
for alignment of cdna to genomic sequences

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::Sim4;

  my @params = (W=>15,K=>17,D=>10,N=>10,cdna_seq=>"mouse_cdna.fa",genomic_seq=>"mouse_genomic.fa");
  my $sim4 = Bio::Tools::Run::Alignment::Sim4->new(@params);

  my @exon_sets = $sim4->align;

  foreach my $set(@exon_sets){
    foreach my $exon($set->sub_SeqFeature){
        print $exon->start."\t".$exon->end."\t".$exon->strand."\n";
        print "\tMatched ".$exon->est_hit->seq_id."\t".$exon->est_hit->start."\t".$exon->est_hit->end."\n";
    }
  }

  One can also provide a est database

 $sio = Bio::SeqIO->new(-file=>"est.fa",-format=>"fasta");
 @est_seq=();
 while(my $seq = $sio->next_seq){
         push @est_seq,$seq;
 }

 my @exon_sets = $factory->align(\@est_seq,$genomic);

=head1 DESCRIPTION

Sim4 program is developed by Florea et al. for aligning cdna/est
sequence to genomic sequences

Florea L, Hartzell G, Zhang Z, Rubin GM, Miller W.
A computer program for aligning a cDNA sequence with a genomic DNA sequence.
Genome Res 1998 Sep;8(9):967-74

The program is available for download here:
http://globin.cse.psu.edu/

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

=head1 AUTHOR - Shawn Hoon 

Email shawnh@fugu-sg.org 

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut


package Bio::Tools::Run::Alignment::Sim4;
use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            @SIM4_PARAMS @OTHER_PARAMS @OTHER_SWITCHES %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Sim4::Results;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase); 

# You will need to enable Sim4 to find the Sim4 program. This
# can be done in (at least) two ways:
#
# 1. define an environmental variable SIM4DIR 
# export SIM4DIR =/usr/local/share/sim4
# where the sim4 package is installed
#
# 2. include a definition of an environmental variable SIM4 in
# every script that will use Sim4.pm
# $ENV{SIMR4DIR} = '/usr/local/share/sim4';

BEGIN {

    @SIM4_PARAMS= qw(A W X K C R D H P N B); 
    @OTHER_PARAMS= qw(CDNA_SEQ GENOMIC_SEQ OUTFILE);
    @OTHER_SWITCHES = qw(SILENT QUIET VERBOSE); 

    # Authorize attribute fields
    foreach my $attr ( @SIM4_PARAMS, @OTHER_PARAMS,
                       @OTHER_SWITCHES) { $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  return 'sim4';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{SIM4DIR}) if $ENV{SIM4DIR};
}

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);
  # to facilitiate tempfile cleanup
  $self->io->_initialize_io();
  $self->A(0); # default
  my ($attr, $value);
  
  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
    if ($attr =~/est_first/i )  {      #NEW
       $self->{est_first} = $value;    #NEW
       next;                           #NEW
    }                                  #NEW
    next if( $attr =~ /^-/ ); # don't want named parameters
    if ($attr =~/'PROGRAM'/i )  {
      $self->executable($value);
      next;
    }
    $self->$attr($value);
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

=head2  version

 Title   : version
 Usage   : not supported 
 Function: Cannot determine from program 
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    return undef;
}

=head2  align

 Title   : align
 Usage   :
            $cdna = 't/data/cdna.fa';
            $genomic = 't/data/cdna.fa';
            @exon_set = $factory->align($cdna,$genomic);
          or
            #@seq_array is array of Seq objs
            $cdna = \@seq_array; 
            @exon_set = $factory->align($cdna,$genomic);
          of
            @exon_set = $factory->align($cdna->[0],$genomic)

 Function: Perform a Sim4  alignment
 Returns : An array of Bio::SeqFeature::Generic objects which has
           exons as sub seqfeatures.
 Args    : Name of two files containing fasta sequences, 
           or 2 Bio::SeqI objects
           or a combination of both
           first is assumed to be cdna
           second is assumed to be genomic
           More than one cdna may be provided. If an object,
           assume that its an array ref.

=cut

sub align {

    my ($self,$cdna,$genomic) = @_;

    $self->cdna_seq($cdna) if $cdna;
    $self->throw("Need to provide a cdna sequence") unless $self->cdna_seq;

    $self->genomic_seq($genomic) if $genomic;
    $self->throw("Need to provide a genomic sequence") unless $self->genomic_seq;
    
    my ($temp,$infile1, $infile2, $est_first,$seq);
    my ($attr, $value, $switch);

# Create input file pointer
    ($est_first,$infile1,$infile2)= $self->_setinput($self->cdna_seq,$self->genomic_seq);
    if (!($infile1 && $infile2)) {$self->throw("Bad input data (sequences need an id ) or less than 2 sequences in align!");}

# Create parameter string to pass to Sim4 program
    my $param_string = $self->_setparams();

# run Sim4 
    my @exon_sets = $self->_run($est_first,$infile1,$infile2,$param_string);
    return @exon_sets;
}

#################################################
#internal methods

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly
 Function:   makes actual system call to Sim4 program
 Example :
 Returns : nothing; Sim4  output is written to a temp file
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to Sim4

=cut

sub _run {
    my ($self,$estfirst,$infile1,$infile2,$param_string) = @_;
    my $instring;
    $self->debug( "Program ".$self->executable."\n");
    if(! $self->outfile){
        my ($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir);
	close($tfh);
	undef $tfh;
        $self->outfile($outfile);
    }
    my $outfile = $self->outfile(); 
    my $commandstring = $self->executable." $infile1 $infile2 $param_string > $outfile";
    if($self->quiet || $self->silent || ($self->verbose < 0)){
      $commandstring .= " 2>/dev/null";
    }
    $self->debug( "Sim4 command = $commandstring");
    my $status = system($commandstring);
    $self->throw( "Sim4 call ($commandstring) crashed: $? \n") unless $status==0;

    #use Sim4 parser
    my $sim4_parser = Bio::Tools::Sim4::Results->new(-file=>$outfile,-estfirst=>$estfirst);
    my @out;
    while(my $exonset = $sim4_parser->next_exonset){
        push @out, $exonset;
    }
    return @out;
}

=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly
 Function:   Create input file for Sim4 program
 Example :
 Returns : name of file containing Sim4 data input
 Args    : Seq or Align object reference or input file name

=cut

sub _setinput {
  my ($self, $cdna,$genomic) = @_;
  my ($infilename, $seq, $temp, $tfh1,$tfh2,$outfile1,$outfile2);
  #my $estfirst=1;
  my $estfirst= defined($self->{est_first}) ? $self->{_est_first} : 1;
  my ($cdna_file,$genomic_file);
  #a sequence obj
  if(ref($cdna)) {
      my @cdna = ref $cdna eq "ARRAY" ? @{$cdna} : ($cdna);
      ($tfh1,$cdna_file) = $self->io->tempfile(-dir=>$self->tempdir);
      my $seqio = Bio::SeqIO->new(-fh=>$tfh1,-format=>'fasta');
      foreach my $c (@cdna){
	  $seqio->write_seq($c);
      }
      close $tfh1;
      undef $tfh1;

      #if we have a est database, then input will  go second
      if($#cdna > 0){
	  $estfirst=0;
      }
  }
  else {
     my $sio = Bio::SeqIO->new(-file=>$cdna,-format=>"fasta");
     my $count = 0;
     while(my $seq = $sio->next_seq){
         $count++;
     }
     $estfirst = $count > 1 ? 0:1;
     $cdna_file = $cdna;
  }
  if( ref($genomic) ) {
      ($tfh1,$genomic_file) = $self->io->tempfile(-dir=>$self->tempdir);
      my $seqio = Bio::SeqIO->new(-fh=>$tfh1,-format=>'fasta');
      $seqio->write_seq($genomic);
      close $tfh1;
      undef $tfh1;
  }
  else {
      $genomic_file = $genomic;
  }
  return ($estfirst,$cdna_file,$genomic_file) if $estfirst;
  return ($estfirst,$genomic_file,$cdna_file);
}


=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly
 Function:   Create parameter inputs for Sim4 program
 Example :
 Returns : parameter string to be passed to Sim4 
           during align or profile_align
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;

    my $param_string = "";
    for  $attr ( @SIM4_PARAMS ) {
      $value = $self->$attr();
      next unless (defined $value);
      my $attr_key = uc $attr; #put params in format expected by Sim4 
      $attr_key = ' '.$attr_key;
      $param_string .= $attr_key.'='.$value;
    }

    return $param_string;
}

1; # Needed to keep compiler happy
  
