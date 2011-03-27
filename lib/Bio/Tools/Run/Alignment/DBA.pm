# $Id$
#
# BioPerl module for Bio::Tools::Run::Alignment::DBA
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::DBA - Object for the alignment of two
sequences using the DNA Block Aligner program.

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::DBA;

  #  Build a dba alignment factory
  my @params = ('matchA' => 0.75, 
                 'matchB' => '0.55',
                 'dymem' =>'linear');
  my $factory = Bio::Tools::Run::Alignment::DBA->new(@params);

  #  Pass the factory a filename with 2 sequences to be aligned.
  $inputfilename = 't/data/dbaseq.fa';
  # @hsps is an array of GenericHSP objects
  my @hsps = $factory->align($inputfilename); 

  # or
  my @files = ('t/data/dbaseq1.fa','t/data/dbaseq2.fa');
  my @hsps = $factory->align(\@files);

  # or where @seq_array is an array of Bio::Seq objects
  $seq_array_ref = \@seq_array;
  my @hsps = $factory->align($seq_array_ref);

=head1 DESCRIPTION

DNA Block Aligner program (DBA) was developed by Ewan Birney. DBA
is part of the Wise package available at
L<http://www.sanger.ac.uk/software/wise2>.

You will need to enable dba to find the dba program. This can 
be done in a few different ways:

1. Define an environmental variable WISEDIR:

  export WISEDIR =/usr/local/share/wise2.2.0

2. Include a definition of an environmental variable WISEDIR in
every script that will use DBA.pm:

  $ENV{WISEDIR} = '/usr/local/share/wise2.2.20';

3. Make sure that the dba application is in your PATH.

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

package Bio::Tools::Run::Alignment::DBA;
use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            @DBA_SWITCHES @DBA_PARAMS @OTHER_SWITCHES %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Search::HSP::GenericHSP;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase); 

BEGIN {

    @DBA_PARAMS = qw(MATCHA MATCHB MATCHC MATCHD GAP BLOCKOPEN UMATCH SINGLE 
                     NOMATCHN PARAMS KBYTE DYMEM DYDEBUG ERRORLOG);
    @OTHER_SWITCHES = qw(OUTFILE);
    @DBA_SWITCHES = qw(HELP SILENT QUIET ERROROFFSTD ALIGN LABEL); 

    # Authorize attribute fields
    foreach my $attr ( @DBA_PARAMS, @DBA_SWITCHES,
                       @OTHER_SWITCHES) { $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  return 'dba';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{WISEDIR},"/src/bin") if $ENV{WISEDIR};
}

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);

  my ($attr, $value);

  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
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
 Usage   : exit if $prog->version() < 1.8
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;

    my $exe = $self->executable();
    return undef unless defined $exe;
    my $string = `$exe -- ` ;
    $string =~ /\(([\d.]+)\)/;
    return $1 || undef;
}

=head2  align

 Title   : align
 Usage   :
            $inputfilename = 't/data/seq.fa';
            @hsps = $factory->align($inputfilename);
          or
            #@seq_array is array of Seq objs
            $seq_array_ref = \@seq_array; 
            @hsps = $factory->align($seq_array_ref);
          or
            my @files = ('t/data/seq1.fa','t/data/seq2.fa');
            @hsps = $factory->align(\@files);
 Function: Perform a DBA  alignment


 Returns : An array of Bio::Search::HSP::GenericHSP objects 
 Args    : Name of a file containing a set of 2 fasta sequences
           or else a reference to an array  to 2  Bio::Seq objects.
           or else a reference to an array of 2 file
              names containing 1 fasta sequence each

 Throws an exception if argument is not either a string (eg a
 filename) or a reference to an array of 2 Bio::Seq objects.  If
 argument is string, throws exception if file corresponding to string
 name can not be found. If argument is Bio::Seq array, throws
 exception if less than two sequence objects are in array.

=cut

sub align {

    my ($self,$input) = @_;
    my ($temp,$infile1, $infile2, $seq);
    my ($attr, $value, $switch);

# Create input file pointer
    ($infile1,$infile2)= $self->_setinput($input);
    if (!($infile1 && $infile2)) {$self->throw("Bad input data (sequences need an id ) or less than 2 sequences in $input !");}

# Create parameter string to pass to dba program
    my $param_string = $self->_setparams();

# run dba 
    my @hsps = $self->_run($infile1,$infile2,$param_string);
    return @hsps;
}

#################################################

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly
 Function:   makes actual system call to dba program
 Example :
 Returns : nothing; dba  output is written to a temp file
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to dba

=cut

sub _run {
    my ($self,$infile1,$infile2,$param_string) = @_;
    my $instring;
    $self->debug( "Program ".$self->executable."\n");
    unless( $self->outfile){
	  my ($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir);
    close($tfh);
  	undef $tfh;
  	$self->outfile($outfile);
    }
    my $outfile = $self->outfile(); 
    my $commandstring = $self->executable." $param_string -pff $infile1 $infile2 > $outfile";
    $self->debug( "dba command = $commandstring");
    my $status = system($commandstring);
    $self->throw( "DBA call ($commandstring) crashed: $? \n") unless $status==0;
    #parse pff format and return a Bio::Search::HSP::GenericHSP array
    my $hsps   = $self->_parse_results($outfile);

    return @{$hsps};
}

=head2  _parse_results

 Title   :  __parse_results
 Usage   :  Internal function, not to be called directly
 Function:  Parses dba output 
 Example :
 Returns : an reference to an array of GenericHSPs
 Args    : the name of the output file 

=cut

sub _parse_results {
    my ($self,$outfile) = @_;
    $outfile||$self->throw("No outfile specified");
    my ($start,$end,$name,$seqname,$seq,$seqchar,$tempname,%align);
    my $count = 0;
    my @hsps;
    open(OUT,$outfile);
    my (%query,%subject);
    while(my $entry = <OUT>){
      if($entry =~ /^>(.+)/ ) {
        $tempname = $1;
        if( defined $name ) {
          if($count == 0){
            my @parse = split("\t",$name);
            $query{seqname}  = $parse[0];
            $query{start}    = $parse[3];
            $query{end}      = $parse[4];
            $query{score}    = $parse[5];
            $query{strand}   = ($parse[6] eq '+') ? 1 : -1;
            my @tags         = split(";",$parse[8]);
            foreach my $tag(@tags){
              $tag =~/(\S+)\s+(\S+)/;
              $query{$1} = $2;
            }
            $query{seq}      = $seqchar;
            $count++;
          }
          elsif ($count == 1){
            my @parse = split("\t",$name);
            $subject{seqname}  = $parse[0];
            $subject{start}    = $parse[3];
            $subject{end}      = $parse[4];
            $subject{score}    = $parse[5];
            $subject{strand}   = ($parse[6] eq '+') ? 1:-1;
            my @tags         = split(";",$parse[8]);
            foreach my $tag(@tags){
              $tag =~/(\S+)\s+(\S+)/;
              $subject{$1} = $2;
            }
            $subject{seq}   = $seqchar;
            #create homology string
            my $xor = $query{seq}^$subject{seq};
            my $identical = $xor=~tr/\c@/*/;
            $xor=~tr/*/ /c;
            my $hsp= Bio::Search::HSP::GenericHSP->new(-algorithm     =>'DBA',
                                                       -score         =>$query{score},
                                                       -hsp_length    =>length($query{seq}),
                                                       -query_gaps    =>$query{gaps},
                                                       -hit_gaps      =>$subject{gaps}, 
                                                       -query_name    =>$query{seqname},
                                                       -query_start   =>$query{start}, 
                                                       -query_end     =>$query{end},
                                                       -hit_name      =>$subject{seqname},
                                                       -hit_start     =>$subject{start}, 
                                                       -hit_end       =>$subject{end},
                                                       -hit_length    =>length($self->_subject_seq->seq),
                                                       -query_length  =>length($self->_query_seq->seq),
                                                       -query_seq     =>$query{seq},
                                                       -hit_seq       =>$subject{seq},
                                                       -conserved     =>$identical,
                                                       -identical   =>$identical,
                                                       -homology_seq  =>$xor);
            push @hsps, $hsp; 
            $count  = 0;
          }
      }
          $name = $tempname;
          $seqchar  = "";
          next;
      }
      $entry =~ s/[^A-Za-z\.\-]//g;
      $seqchar .= $entry;
  }
  #do for the last entry
  if($count == 1){
    my @parse = split("\t",$name);
    $subject{seqname}  = $parse[1];
    $subject{start}    = $parse[3];
    $subject{end}      = $parse[4];
    $subject{score}    = $parse[5];
    $subject{strand}   = ($parse[6] eq '+') ? 1:-1;
    my @tags         = split(";",$parse[8]);
    foreach my $tag(@tags){
      $tag =~/(\S+)\s+(\S+)/;
      $subject{$1} = $2;
    }
    $subject{seq}   = $seqchar;

    #create homology string
    
    my $xor = $query{seq}^$subject{seq};
    my $identical = $xor=~tr/\c@/*/;
    $xor=~tr/*/ /c;
    my $hsp= Bio::Search::HSP::GenericHSP->new(-algorithm     =>'DBA',
                                               -score         =>$query{score},
                                               -hsp_length    =>length($query{seq}),
                                               -query_gaps    =>$query{gaps},
                                               -hit_gaps      =>$subject{gaps},
                                               -query_name    =>$query{seqname},
                                               -query_start   =>$query{start},
                                               -query_end     =>$query{end},
                                               -hit_name      =>$subject{seqname},
                                               -hit_start     =>$subject{start},
                                               -hit_end       =>$subject{end},
                                               -hit_length    =>length($self->_subject_seq->seq),
                                               -query_length  =>length($self->_query_seq->seq),
                                               -query_seq     =>$query{seq},
                                               -hit_seq       =>$subject{seq},
                                               -conserved     =>$identical,
                                               -identical     =>$identical,
                                               -homology_seq  =>$xor);
     push @hsps, $hsp;
  }


  return \@hsps;
}

=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly
 Function:   Create input file for dba program
 Example :
 Returns : name of file containing dba data input
 Args    : Seq or Align object reference or input file name

=cut

sub _setinput {
  my ($self, $input, $suffix) = @_;
  my ($infilename, $seq, $temp, $tfh1,$tfh2,$outfile1,$outfile2);

  #there is gotta be some repetition here...need to clean up

  if (ref($input) ne "ARRAY"){ #a single file containg 2 seqeunces
    $infilename = $input;
    unless(-e $input){return 0;}
    my  $in  = Bio::SeqIO->new(-file => $infilename , '-format' => 'Fasta');
    ($tfh1,$outfile1) = $self->io->tempfile(-dir=>$self->tempdir);
    ($tfh2,$outfile2) = $self->io->tempfile(-dir=>$self->tempdir);
    
    my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'Fasta','-flush'=>1);
    my $out2 = Bio::SeqIO->new(-fh=> $tfh2 , '-format' => 'Fasta','-flush'=>1);

    my $seq1 = $in->next_seq() || return 0; 
    my $seq2 = $in->next_seq() || return 0; 
    $out1->write_seq($seq1);
    $out2->write_seq($seq2);
    $self->_query_seq($seq1);
    $self->_subject_seq($seq2);
    $out1->close();
    $out2->close();
    close($tfh1);
    close($tfh2);
    undef $tfh1;
    undef $tfh2;
    return $outfile1,$outfile2;
  }
  else {
    scalar(@{$input}) == 2 || $self->throw("dba alignment can only be run  on 2 sequences not.");
    if(ref($input->[0]) eq ""){#passing in two file names
      my $in1  = Bio::SeqIO->new(-file => $input->[0], '-format' => 'fasta');
      my $in2  = Bio::SeqIO->new(-file => $input->[1], '-format' => 'fasta');

      ($tfh1,$outfile1) = $self->io->tempfile(-dir=>$self->tempdir);
      ($tfh2,$outfile2) = $self->io->tempfile(-dir=>$self->tempdir);

      my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'fasta');
      my $out2 = Bio::SeqIO->new(-fh=> $tfh2 , '-format' => 'fasta');

      my $seq1 = $in1->next_seq() || return 0; 
      my $seq2 = $in2->next_seq() || return 0; 
      $out1->write_seq($seq1);
      $out2->write_seq($seq2);
      $self->_query_seq($seq1);
      $self->_subject_seq($seq2);
      close($tfh1);
      close($tfh2);
      undef $tfh1;
      undef $tfh2;
      return $outfile1,$outfile2;
    }
    elsif($input->[0]->isa("Bio::PrimarySeqI") && $input->[1]->isa("Bio::PrimarySeqI")) {
      ($tfh1,$outfile1) = $self->io->tempfile(-dir=>$self->tempdir);
      ($tfh2,$outfile2) = $self->io->tempfile(-dir=>$self->tempdir);

      my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'fasta');
      my $out2 = Bio::SeqIO->new(-fh=> $tfh2 , '-format' => 'fasta');

      $out1->write_seq($input->[0]);
      $out2->write_seq($input->[1]);
      $self->_query_seq($input->[0]);
      $self->_subject_seq($input->[1]);

      close($tfh1);
      close($tfh2);
      undef $tfh1;
      undef $tfh2;
      return $outfile1,$outfile2;
    }  
    else {
       return 0;
    }
  }
  return 0;
}

=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly
 Function:   Create parameter inputs for dba program
 Example :
 Returns : parameter string to be passed to dba 
           during align or profile_align
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;

    my $param_string = "";
    for  $attr ( @DBA_PARAMS ) {
	$value = $self->$attr();
	next unless (defined $value);
#      next if $attr =~/outfile/i;

	my $attr_key = lc $attr; #put params in format expected by dba 
	if($attr_key =~ /match([ABCDabcd])/i){
	    $attr_key = "match".uc($1);
	}
	$attr_key = ' -'.$attr_key;
	$param_string .= $attr_key.' '.$value;
    }
    for  $attr ( @DBA_SWITCHES) {
	$value = $self->$attr();
	next unless ($value);
	my $attr_key = lc $attr; #put switches in format expected by dba 
	$attr_key = ' -'.$attr_key;
	$param_string .= $attr_key ;
    }
    return $param_string;
}

=head2  _query_seq()

 Title   :  _query_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the query sequence 
 Example :
 Returns : 
 Args    : 

=cut

sub _query_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_query_seq'} = $seq;
  }
  return $self->{'_query_seq'};
}

=head2  _subject_seq()

 Title   :  _subject_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the subject sequence
 Example :
 Returns :

 Args    :

=cut

sub _subject_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_subject_seq'} = $seq;
  }
  return $self->{'_subject_seq'};
}
1; # Needed to keep compiler happy
  
