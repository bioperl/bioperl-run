# BioPerl module for Bio::Tools::Run::Genscan
#
# Cared for by
#
# Copyright Balamurugan Kumarasamy
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Genscan - Object for identifying genes in a
given sequence given a matrix(for appropriate organisms).

=head1 SYNOPSIS

  # Build a Genscan factory
  my $param = ('MATRIX'=>HumanIso.smat);
  my  $factory = Bio::Tools::Run::Genscan->new($param);

  # Pass the factory a Bio::Seq object
  #@genes is an array of Bio::Tools::Predictions::Gene objects
  my @genes = $factory->predict_genes($seq);

=head1 DESCRIPTION

 Genscan is a gene identifying program developed by Christopher Burge
http://genes.mit.edu/burgelab/

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

  bioperl-bugs@bio.perl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR - Bala

Email savikalpa@fugu-sg.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Genscan;
 
use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR                
            $TMPDIR $PROGRAMNAME @GENSCAN_PARAMS
             %OK_FIELD);
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Genscan;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);



BEGIN {
   $PROGRAMNAME = 'genscan'  . ($^O =~ /mswin/i ?'.exe':'');

   if (defined $ENV{GENSCANDIR}) {
        $PROGRAMDIR = $ENV{GENSCANDIR} || '';
        $PROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,
                                          'genscan'.($^O =~ /mswin/i ?'.exe':''));
    }
    else {                                                                 
        $PROGRAM = 'genscan';
    }
              
     @GENSCAN_PARAMS=qw(MATRIX VERBOSE);
      foreach my $attr ( @GENSCAN_PARAMS)
                        { $OK_FIELD{$attr}++; }
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

sub new {                                                       
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    # to facilitiate tempfile cleanup
    $self->io->_initialize_io();

    my ($attr, $value);
    while (@args)  {
        $attr =   shift @args;
        $value =  shift @args;
        next if( $attr =~ /^-/ ); # don't want named parameters
        if ($attr =~/'PROGRAM'/i) {
            $self->executable($value);
            next;
        }
        $self->$attr($value);
    }
    return $self;
}


=head2 executable

 Title   : executable
 Usage   : my $exe = $genscan->executable();
 Function: Finds the full path to the 'genscan' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to
           [optional] boolean flag whether or not warn when exe is not found


=cut

sub executable{
   my ($self, $exe,$warn) = @_;

   if( defined $exe ) {
     $self->{'_pathtoexe'} = $exe;
   }

   unless( defined $self->{'_pathtoexe'} ) {
       if( $PROGRAM && -e $PROGRAM && -x $PROGRAM ) {
           $self->{'_pathtoexe'} = $PROGRAM;
       } else {
           my $exe;
           if( ( $exe = $self->io->exists_exe($PROGRAMNAME) ) &&
               -x $exe ) {
               $self->{'_pathtoexe'} = $exe;
           } else {
               $self->warn("Cannot find executable for $PROGRAMNAME") if $warn;
               $self->{'_pathtoexe'} = undef;
           }
       }
   }
   $self->{'_pathtoexe'};
}



=head2 predict_genes()

    Title   :   predict_genes()
    Usage   :   $obj->predictgenes($matrixFile,$seqFile)
    Function:   Runs genscan and creates an array of Genes
    Returns :   An array of Bio::Tools::Prediction::Gene objects
    Args    :   A Bio::PrimarySeqI    

=cut

sub predict_genes() {
    my ($self,$seq) = @_;
    my $infile1 = $self->_writeSeqFile($seq);  
    $self->_set_input($infile1);  
    print"matrix". $self->MATRIX;
    my @feat = $self->_run();
    return @feat;
}

=head2 _run

    Title   :   _run
    Usage   :   $obj->_run()
    Function:   Internal(not to be used directly)
    Returns :   An array of Bio::Tools::Prediction::Gene objects
    Args    :   

=cut

sub _run {                                                           

    my ($self) = @_;
    my @genes;
    my $gene;

    my $str = $self->executable.' '.$self->MATRIX.' '.$self->{'input'};
    if($self->verbose){
       $str.=" -v ";
    }
    print STDERR "$str\n";
    unless (open(GENSCAN, "$str |")){
	    $self->warn("Cannot run $str");
    }
    my $genScanParser = Bio::Tools::Genscan->new(-fh=> \*GENSCAN);

    
    while( $gene = $genScanParser->next_prediction()){
       push(@genes, $gene);
    }     
   $self->cleanup();
   return @genes;
}

=head2 _set_input()

    Title   :   _set_input
    Usage   :   obj->_set_input($matrixFile,$seqFile)
    Function:   Internal(not to be used directly)
    Returns :  
    Args    :

=cut

sub _set_input() {
   my ($self,$infile1) = @_;
   $self->{'input'}=$infile1;
}

=head2 _writeSeqFile()

    Title   :   _writeSeqFile
    Usage   :   obj->_writeSeqFile($seq)
    Function:   Internal(not to be used directly)
    Returns :   
    Args    : 

=cut


sub _writeSeqFile(){
  my ($self,$seq) = @_;
  my $tmpdir = $self->io->tempdir(CLEANUP=>1);
  my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$tmpdir);
  my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'Fasta');
  $in->write_seq($seq);
 
  return $inputfile;
}

1;
