# $Id$
# Copyright Balamurugan Kumarasamy
# You may distribute this module under the same terms as perl itself
#  POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Seg - Object for identifying low complexity
  regions in a given protein seequence.

=head1 SYNOPSIS

  # Build a Seg factory
  # $paramfile is the full path to the seg binary file
  my @params = ('PROGRAM',$paramfile);
  my $factory = Bio::Tools::Run::Seg->new($param);

  # Pass the factory a Bio::Seq object
  # @feats is an array of Bio::SeqFeature::Generic objects
  my @feats = $factory->run($seq);

=head1 DESCRIPTION

Seg is a program which identifies low complexity regions in proteins.
It was developed by Wootton and Federhen at NCBI.

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

package Bio::Tools::Run::Seg;

use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR
            $PROGRAMNAME @SEG_PARAMS %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Seg;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
       @SEG_PARAMS=qw(PROGRAM VERBOSE);
       foreach my $attr ( @SEG_PARAMS)
                        { $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'seg';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns : string, or undef if $SEGDIR not in ENV
 Args    : None

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{SEGDIR}) if $ENV{SEGDIR};
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
 Usage   : $rm->new(@params)
 Function: creates a new Seg factory
 Returns:  Bio::Tools::Run::Seg
 Args    :

=cut

sub new {
       my ($class,@args) = @_;
       my $self = $class->SUPER::new(@args);

       my ($attr, $value);
       while (@args)  {
           $attr =   shift @args;
           $value =  shift @args;
           next if( $attr =~ /^-/ );
           $self->$attr($value);
       }
       return $self;
}

=head2 predict_protein_features

 Title   :   predict_protein_features()
 Usage   :   DEPRECATED Use $obj->run($seq) instead
 Function:   Runs Seg and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub predict_protein_features{
	return shift->run(@_);
}

=head2 run

 Title   :   run
 Usage   :   $obj->run($seq)
 Function:   Runs Seg and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run{
    my ($self,$seq) = @_;
    my @feats;

    if (ref($seq) ) { # it is an object
        if (ref($seq) =~ /GLOB/) {
            $self->throw("cannot use filehandle");
        }

        my $infile1 = $self->_writeSeqFile($seq);

        $self->_input($infile1);

        @feats = $self->_run();
        unlink $infile1;
    }
    else {
        #The seq object is not a seq object but a file.
        #Here the file does not need to be created.

        $self->_input($seq);

        @feats = $self->_run();

    }

    return @feats;

}

=head2 _input

 Title   :   _input
 Usage   :   obj->_input($seqFile)
 Function:   Internal (not to be used directly)
 Returns :
 Args    :

=cut

sub _input {
     my ($self,$infile1) = @_;
     if(defined $infile1){

         $self->{'input'}=$infile1;
     }
     return $self->{'input'};
}

=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal (not to be used directly)
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   None

=cut

sub _run {
     my ($self)= @_;

     my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$self->tempdir());
     my $str =$self->executable." ".$self->_input." -l > ".$outfile;
     my $status = system($str);
     $self->throw( "Seg call ($str) crashed: $? \n") unless $status==0;
     
     my $filehandle;
     if (ref ($outfile) !~ /GLOB/) {
        open (SEG, "<".$outfile) or $self->throw ("Couldn't open file ".$outfile.": $!\n");
        $filehandle = \*SEG;
     }
     else {
        $filehandle = $outfile;
     }
     my $seg_parser = Bio::Tools::Seg->new(-fh=>$filehandle);

     my @seg_feat;

     while(my $seg_feat = $seg_parser->next_result){

          push @seg_feat, $seg_feat;
     }
     # free resources
     $self->cleanup();
     unlink $outfile;
     close($tfh1);
     undef $tfh1;
     return @seg_feat;

}

=head2 _writeSeqFile

 Title   :   _writeSeqFile
 Usage   :   obj->_writeSeqFile($seq)
 Function:   Internal (not to be used directly)
 Returns :   string - Fasta filename to which $seq was written
 Args    :   Bio::Seq object

=cut

sub _writeSeqFile{
    my ($self,$seq) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir());
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'Fasta');
    $in->write_seq($seq);
    $in->close();
    close($tfh);
    undef $tfh;
    return $inputfile;

}
1;
