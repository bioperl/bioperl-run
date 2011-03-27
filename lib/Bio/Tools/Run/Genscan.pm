# BioPerl module for Bio::Tools::Run::Genscan
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
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
  my @genes = $factory->run($seq);

=head1 DESCRIPTION

Genscan is a gene identifying program developed by Christopher Burge
http://genes.mit.edu/burgelab/

By default it looks for an executable called I<genscan> and data/parameter files
in the directory specified by the I<GENSCANDIR> environmental variable.

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

=head1 AUTHOR - Bala

Email savikalpa@fugu-sg.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Genscan;
 
use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR                
            $PROGRAMNAME @GENSCAN_PARAMS %OK_FIELD);
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
     @GENSCAN_PARAMS=qw(MATRIX VERBOSE QUIET);
      foreach my $attr ( @GENSCAN_PARAMS)
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
  return 'genscan';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{GENSCANDIR});
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
    my ($attr, $value);
    while (@args)  {
        $attr =   shift @args;
        $value =  shift @args;
        next if( $attr =~ /^-/ ); # don't want named parameters
        $self->$attr($value);
    }
    return $self;
}

=head2 predict_genes()

    Title   :   predict_genes()
    Usage   :   DEPRECATED: use $obj->run($seq) instead 
    Function:   Runs genscan and creates an array of Genes
    Returns :   An array of Bio::Tools::Prediction::Gene objects
    Args    :   A Bio::PrimarySeqI    

=cut

sub predict_genes{
	return shift->run(@_);
}

=head2 run

    Title   :   run
    Usage   :   $obj->run($seq)
    Function:   Runs genscan and creates an array of Genes
    Returns :   An array of Bio::Tools::Prediction::Gene objects
    Args    :   A Bio::PrimarySeqI    

=cut

sub run {
    my ($self,$seq) = @_;
    my $infile1 = $self->_writeSeqFile($seq);  
    $self->_set_input($infile1);  
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
    if($self->quiet){
        open(STDERR,">/dev/null");
    }
    unless (open(GENSCAN, "$str |")){
	    $self->warn("Cannot run $str");
    }
    close(STDERR);
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
  my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
  my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
  $in->write_seq($seq);
  $in->close();
  close($tfh);
  undef $tfh;
  return $inputfile;
}

1;
