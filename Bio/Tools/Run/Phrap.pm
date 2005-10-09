# $Id$
#
# Phrap wraper module
#
# Cared for by Shawn Hoon
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phrap - a wrapper for running Phrap

=head1 SYNOPSIS

  use Bio::Tools::Run::Phrap;
  use Bio::SeqIO;

  my $sio = Bio::SeqIO->new(-file=>$ARGV[0],-format=>'fasta');
  my @seq;
  while(my $seq = $sio->next_seq()){
    push @seq,$seq;
  }
  my $prun =Bio::Tools::Run::Phrap->new(arguments=>'-penalty -3 -minmatch 10');
  my $assembly = $prun->run(\@seq);
  foreach my $contig($assembly->all_contigs){
    my $collection = $contig->get_features_collection;
    foreach my $sf($collection->get_all_features){
      print $sf->primary_id."\t".$sf->start."\t".$sf->end."\n";
    }
  }

=head1 DESCRIPTION

  Wrapper module for Phrap program
  Phrap available at: http://www.phrap.org/

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

 bioperl-l@bioperl.org               - General discussion
 http://bio.perl.org/MailList.html   - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

 http://bugzilla.bioperl.org/

=head1 AUTHOR - Shawn Hoon

  Email shawnh-at-stanford.edu

=head1 APPENDIX

 The rest of the documentation details each of the object
 methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phrap;

use vars qw($AUTOLOAD @ISA $PROGRAMDIR
            $PROGRAMNAME @PHRAP_PARAMS %OK_FIELD);
use strict;
use Bio::Assembly::IO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase 
	  Bio::Factory::ApplicationFactoryI);

BEGIN { 
    $PROGRAMNAME= 'phrap';
    @PHRAP_PARAMS=qw(PENALTY GAP_INIT GAP_EXT INS_GAP_EXT
		     DEL_GAP_EXT MATRIX RAW MINMATCH MAX_GROUP_SIZE 
		     WORD_RAW BANDWIDTH MINSCORE VECTOR_BOUND MASKLEVEL 
		     DEFAULT_QUAL SUBCLONE_DELIM N_DELIM GROUP_DELIM TRIM_START
		     FORCELEVEL BYPASSLEVEL MAXGAP REPEAT_STRINGENCY
		     REVISE_GREEDYSHATTER_GREEDY PREASSEMBLE 
		     FORCE_HIGH NODE_SEG NODE_SPACE RETAIN_DUPLICATES 
		     MAX_SUBCLONE_SIZE TRIM_PENALTY TRIM_SCORE
		     TRIM_QUAL CONFIRM_LENGTH CONFIRM_TRIM CONFIRM_SCORE
		     INDEXWORDSIZE); 
    
    foreach my $attr ( @PHRAP_PARAMS) {
	$OK_FIELD{$attr}++; 
    } 
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
    return $PROGRAMNAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtiained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return Bio::Root::IO->catfile($ENV{'PhrapDIR'}) if $ENV{'PhrapDIR'};
    return $PROGRAMDIR; # you can then define this if you don't use env var
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
 Usage   : my $factory= Bio::Tools::Run::Phrap->new();
 Function: creates a new Phrap factory
 Returns:  Bio::Tools::Run::Phrap
 Args    :

=cut

sub new {
       my ($class,@args) = @_;
       my $self = $class->SUPER::new(@args);
 
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

=head2 run

 Title   :   run()
 Usage   :   my $feats = $factory->run($seq)
 Function:   Runs Phrap 
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run {
    my ($self,$seq) = @_;
    my @feats;

    my ($fh,$infile1);
    if (ref($seq) =~ /ARRAY/i) {
      my @infilearr;
      ($fh, $infile1) = $self->io->tempfile();
      my $temp = Bio::SeqIO->new( -file => ">$infile1",
                                  -format => 'Fasta' );
      foreach my $seq1 (@$seq) {
        unless ($seq1->isa("Bio::PrimarySeqI")) {
          return 0;
        }
        $temp->write_seq($seq1);
        push @infilearr, $infile1;
      }
    }
    else {
      $infile1 = $seq;
    }
	  $self->_input($infile1);
	  my $assembly = $self->_run();

    return $assembly;
}

=head2 _input

 Title   :   _input
 Usage   :   $factory->_input($seqFile)
 Function:   get/set for input file
 Returns :
 Args    :

=cut

sub _input() {
     my ($self,$infile1) = @_;
     $self->{'input'} = $infile1 if(defined $infile1);
     return $self->{'input'};
 }

=head2 _run

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Makes a system call and runs Phrap
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :

=cut

sub _run {
     my ($self)= @_;

     my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$self->tempdir());
     my $param_str = ($self->_setparams || '')." ".($self->arguments || '');
     my $str =$self->executable." $param_str ".$self->_input()." 1> ".$outfile. " 2> /dev/null";
     $self->debug($str. "\n");
     my $status = system($str);
     $self->throw( "Phrap call ($str) crashed: $? \n") unless $status==0;
     my $filehandle;
     my $parser = Bio::Assembly::IO->new(-file=>"$outfile",-format=>"phrap");
     my $assembly =  $parser->next_assembly;
     close($tfh1);
     undef $tfh1;    
     unlink $outfile;
     
     return $assembly;
}


=head2 _writeSeqFile

 Title   :   _writeSeqFile
 Usage   :   $factory->_writeSeqFile($seq)
 Function:   Creates a file from the given seq object
 Returns :   A string(filename)
 Args    :   Bio::PrimarySeqI

=cut

sub _writeSeqFile{
    my ($self,$seq) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir());
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
    $in->write_seq($seq);
    $in->close();
    close($tfh);
    undef $tfh;
    return $inputfile;

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
    foreach my $attr(@PHRAP_PARAMS){
        next if($attr=~/PROGRAM/);
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .= $attr_key.' '.$value;
    }
    return $param_string;
}

1;
