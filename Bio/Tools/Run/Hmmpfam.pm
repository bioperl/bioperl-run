# Copyright Balamurugan Kumarasamy
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Hmmpfam 

=head1 SYNOPSIS

  Build a Hmmpfam factory

  my @params = ('DB'=>$dbfile,'E'=>0.0001);
  my $factory = Bio::Tools::Run::Hmmpfam->new($params);

  # Pass the factory a Bio::Seq object or a file name

  # returns a Bio::SearchIO object
  my $search = $factory->run($seq);


  my @feat;
  while (my $result = $searchio->next_result){
   while(my $hit = $result->next_hit){
    while (my $hsp = $hit->next_hsp){
      push @feat, $hsp;
    }
   }
  }

  Available params:
   n        : nucleic acid models/sequence (default protein)
   E <x>    : sets E value cutoff (globE) to <x>; default 10
   T <x>    : sets T bit threshold (globT) to <x>; no threshold by default
   Z <n>    : sets Z (# models) for E-value calculation



=head1 DESCRIPTION

  Wrapper module for Hmmpfam program that allows one to search a sequence against
  an HMM database. Binary is available at http://hmmer.wustl.edu/

=head1 FEEDBACK

=head2 Mailing Lists

 User feedback is an integral part of the evolution of this and other
 Bioperl modules. Send your comments and suggestions preferably to one
 of the Bioperl mailing lists.  Your participation is much appreciated.

 bioperl-l@bioperl.org          - General discussion
 http://bio.perl.org/MailList.html             - About the mailing lists

=head2 Reporting Bugs

 Report bugs to the Bioperl bug tracking system to help us keep track
 the bugs and their resolution.  Bug reports can be submitted via
 email or the web:

 bioperl-bugs@bioperl.org
 http://bugzilla.bioperl.org/

=head1 AUTHOR - Bala

 Email: bala@tll.org.sg

=head1 CONTRIBUTORS 

 Shawn Hoon shawnh@fugu-sg.org

=head1 APPENDIX

 The rest of the documentation details each of the object
 methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Hmmpfam;

use vars qw($AUTOLOAD @ISA @HMMPFAM_PARAMS @HMMPFAM_SWITCHES %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::SearchIO;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
       @HMMPFAM_PARAMS=qw(DB PROGRAM E T Z);
       @HMMPFAM_SWITCHES=qw(N);
       foreach my $attr ( @HMMPFAM_PARAMS,@HMMPFAM_SWITCHES)
                        { $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  return 'hmmpfam';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtiained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{HMMPFAMDIR}) if $ENV{HMMPFAMDIR};
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

=head2 new

 Title   : new
 Usage   : $hmmpfam->new(@params)
 Function: creates a new Hmmpfam factory
 Returns:  Bio::Tools::Run::Hmmpfam
 Args    :

=cut

sub new {
       my ($class,@args) = @_;
       my $self = $class->SUPER::new(@args);
       $self->io->_initialize_io();
       my ($attr, $value);
       while (@args)  {
           $attr =   shift @args;
           $value =  shift @args;
           next if( $attr =~ /^-/ ); # don't want named parameters
           if ($attr =~/PROGRAM/i) {
              $self->executable($value);
              next;
           }
           $self->$attr($value);
       }
       return $self;
}

=head2 predict_protein_features

 Title   :   predict_protein_features
 Usage   :   DEPRECATED. Use obj->run($seqFile)
 Function:   Runs Hmmpfam and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub predict_protein_features{
	return shift->run(@_);
}

=head2 run

 Title   :   run
 Usage   :   $obj->run($seqFile)
 Function:   Runs Hmmpfam and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run{
    my ($self,$seq) = @_;
    my @feats;

    if  (ref $seq && $seq->isa("Bio::PrimarySeqI") ){# it is an object
        
        my $infile1 = $self->_writeSeqFile($seq);
        
        return  $self->_run($infile1);
    }
    else {
        return  $self->_run($seq);
    }
   
}

=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal(not to be used directly)
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :

=cut

sub _run {
     my ($self,$file)= @_;

     my $str = $self->executable;
     my $param_str = $self->_setparams;
     $str.=" $param_str ".$file;
   
    $self->debug("hmmpfam command = $str"); 

    open(HMM,"$str |") || $self->throw("Hmmpfam call ($str) crashed: $?\n");

     my $searchio= Bio::SearchIO->new(-fh=>\*HMM,-format=>"hmmer");
     
     return $searchio; 
     
}

=head2 _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly
 Function:  creates a string of params to be used in the command string
 Example :
 Returns :  string of params
 Args    :  

=cut

sub _setparams {
    my ($self) = @_;
    my $param_string;
    foreach my $attr(@HMMPFAM_PARAMS){
        next if $attr=~/DB/i;
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(uc $attr);
        $param_string .= $attr_key.' '.$value;
    }
    foreach my $attr(@HMMPFAM_SWITCHES){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.($attr);
        $param_string .=$attr_key;
    }
    $param_string.=' '.$self->DB; 

    return $param_string;
}


=head2 _writeSeqFile

 Title   :   _writeSeqFile
 Usage   :   obj->_writeSeqFile($seq)
 Function:   Internal(not to be used directly)
 Returns :
 Args    :

=cut

sub _writeSeqFile{
    my ($self,$seq) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'Fasta');
    $in->write_seq($seq);
    $in->close();
    $in = undef;
    close($tfh);
    undef $tfh;
    return $inputfile;

}
1;
