# Wrapper  module for SignalP Bio::Tools::Run::Signalp
#
# Based on the EnsEMBL module Bio::EnsEMBL::Pipeline::Runnable::Protein::Signalp
# originally written by Marc Sohrmann (ms2@sanger.ac.uk)
# Written in BioPipe by Balamurugan Kumarasamy <savikalpa@fugu-sg.org>
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by the Fugu Informatics team (fuguteam@fugu-sg.org)

=head1 NAME

Bio::Tools::Run::Signalp

=head1 SYNOPSIS

  Build a Signalp factory

  my $factory = Bio::Tools::Run::Signalp->new();
  # Pass the factory a Bio::Seq object
  # @feats is an array of Bio::SeqFeature::Generic objects
  my @feats = $factory->run($seq);

=head1 DESCRIPTION

  wrapper module for Signalp program

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

 Based on the EnsEMBL module Bio::EnsEMBL::Pipeline::Runnable::Protein::Signalp
 originally written by Marc Sohrmann (ms2@sanger.ac.uk)
 Written in BioPipe by Balamurugan Kumarasamy <savikalpa@fugu-sg.org>
 Contributions by David Vilanova (david.vilanova@urbanet.ch)
                  Shawn Hoon (shawnh@fugu-sg.org)
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
 Cared for by the Fugu Informatics team (fuguteam@fugu-sg.org)

=head1 APPENDIX

 The rest of the documentation details each of the object
 methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Signalp;

use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR
            $PROGRAMNAME @SIGNALP_PARAMS %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Signalp;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
       @SIGNALP_PARAMS=qw(PROGRAM VERBOSE);
       foreach my $attr ( @SIGNALP_PARAMS)
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
    return 'signalp';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return Bio::Root::IO->catfile($ENV{SIGNALPDIR}) if $ENV{SIGNALPDIR};
}

sub AUTOLOAD {
       my $self = shift;
       my $attr = $AUTOLOAD;
       return $self->$attr if $self->$attr;
       $attr =~ s/.*:://;
       $attr = uc $attr;
       $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
       $self->{$attr} = shift if @_;
       return $self->{$attr};
}

=head2 new

 Title   : new
 Usage   : my $factory= Bio::Tools::Run::Signalp->new();
 Function: creates a new Signalp factory
 Returns:  Bio::Tools::Run::Signalp
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

=head2 predict_protein_features

 Title   :   predict_protein_features()
 Usage   :   DEPRECATED. Use $factory->run($seq) instead
 Function:   Runs Signalp and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub predict_protein_features{
    return shift->run(@_);
}

=head2 run

 Title   :   run()
 Usage   :   my $feats = $factory->run($seq)
 Function:   Runs Signalp 
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run {
    my ($self,$seq) = @_;
    my @feats;

    if (ref($seq) ) {

        if (ref($seq) =~ /GLOB/) {
            $self->throw("cannot use filehandle");
        } 

	my $infile1 = $self->_writeSeqFile($seq);

	$self->_input($infile1);

	@feats = $self->_run();
	unlink $infile1;

    }
    else {
	my $in  = Bio::SeqIO->new(-file => $seq, '-format' =>'fasta');
	my $infile1;  

	while ( my $tmpseq = $in->next_seq() ) {
	    $infile1 = $self->_writeSeqFile($tmpseq);  
	}

	$self->_input($infile1);

	@feats = $self->_run();
    }

    return @feats;
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
 Function:   Makes a system call and runs signalp
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :

=cut

sub _run {
     my ($self)= @_;

     my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$self->tempdir());
     my $str =$self->executable." -t euk -trunc 50 ".$self->{'input'}." > ".$outfile;
     my $status = system($str);
     $self->throw( "Signalp call ($str) crashed: $? \n") unless $status==0;
     
     my $filehandle;
     if (ref ($outfile) !~ /GLOB/) {
        open (SIGNALP, "<".$outfile) or $self->throw ("Couldn't open file ".$outfile.": $!\n");
        $filehandle = \*SIGNALP;
     }
     else {
        $filehandle = $outfile;
     }

     my $signalp_parser = Bio::Tools::Signalp->new(-fh=>$filehandle);

     my @signalp_feat;

    while(my $signalp_feat = $signalp_parser->next_result){

        push @signalp_feat, $signalp_feat;
    }
     
     $self->cleanup();
     close($tfh1);
     undef $tfh1;    
     unlink $outfile;
     
     return @signalp_feat;
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
1;
