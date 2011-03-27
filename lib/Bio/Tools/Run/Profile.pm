# $Id$
# BioPerl module for Profile
# Copyright Balamurugan Kumarasamy
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Profile

=head1 SYNOPSIS

 Build a Profile factory
 # $paramfile is the full path to the seg binary file

 my @params = ('DB',$dbfile,'PROGRAM',$paramfile);
 my $factory = Bio::Tools::Run::Profile->new($param);

 # Pass the factory a Bio::PrimarySeqI object
 # @feats is an array of Bio::SeqFeature::Generic objects
 my @feats = $factory->run($seq);

=head1 DESCRIPTION

 Wrapper module for the pfscan program

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

=head1 AUTHOR - Balamurugan Kumarasamy

 Email: fugui@worf.fugu-sg.org

=head1 APPENDIX

 The rest of the documentation details each of the object
 methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Profile;

use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR
             $PROGRAMNAME @PROFILE_PARAMS
                         %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Profile;
use Bio::Tools::Run::WrapperBase;


@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
    @PROFILE_PARAMS=qw(DB PROGRAM VERBOSE);
    foreach my $attr ( @PROFILE_PARAMS)
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
    return 'pfscan';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return Bio::Root::IO->catfile($ENV{PROFILEDIR}) if $ENV{PROFILEDIR};
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
 Usage   : my $factory= Bio::Tools::Run::Profile->new($param);
 Function: creates a new Profile factory
 Returns:  Bio::Tools::Run::Profile
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
           $self->$attr($value);
       }
       return $self;
}

=head2 predict_protein_features

 Title   :   predict_protein_features
 Usage   :   DEPRECATED. Use $factory->run($seq) instead.
 Function:   Runs Profile and creates an array of featrues
 Returns :   An array of L<Bio::SeqFeature::FeaturePair> objects
 Args    :   A Bio::PrimarySeqI

=cut

sub predict_protein_features{
	return shift->run(@_);	
}

=head2 run

 Title   :   run
 Usage   :   my @feats = $factory->run($seq)
 Function:   Runs Profile 
 Returns :   An array of L<Bio::SeqFeature::FeaturePair> objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run{
    my ($self,$seq) = @_;
    my @feats;

     if (ref($seq) ) {
         
         if (ref($seq) =~ /GLOB/) {
             $self->throw("cannot use filehandle");
         }
         
        my $display_id = $seq->display_id;
        
        my $infile1 = $self->_writeSeqFile($seq);
        
        $self->_input($infile1);
        
         @feats = $self->_run($display_id);
         unlink $infile1;
       
    }
    else {
        #The clone object is not a seq object but a file.
        #Perhaps should check here or before if this file is fasta format...if not die
        #Here the file does not need to be created or deleted. Its already written and may be used by other runnables.

        $self->_input($seq);

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
     if(defined $infile1){
        $self->{'input'}=$infile1;
     }
      return $self->{'input'};
}

=head2 _run

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Makes a system call and runs pfscan
 Returns :   An array of L<Bio::SeqFeature::FeaturePair> objects
 Args    :

=cut

sub _run {
     my ($self,$display_id)= @_;
     my ($tfh,$outfile) = $self->io->tempfile(-dir=>$self->tempdir());
     close($tfh);
     undef $tfh;
     my $str =$self->executable.' -fz '.$self->_input." ".$self->DB." > ".$outfile;
     my $status = system($str);
     $self->throw( "Profile call ($str) crashed: $? \n") unless $status==0;
     
     my $filehandle;
     if (ref ($outfile) !~ /GLOB/) {
        open (PROFILE, "<".$outfile) or $self->throw ("Couldn't open file ".$outfile.": $!\n");
        $filehandle = \*PROFILE;
     }
     else {
        $filehandle = $outfile;
     }
     my $profile_parser = Bio::Tools::Profile->new(-fh=>$filehandle);

     my @profile_feat;

     while(my $profile_feat = $profile_parser->next_result){

        $profile_feat->seq_id($display_id); 
         push @profile_feat, $profile_feat;
     }
     
     $self->cleanup();
     
     unlink $outfile;
     return @profile_feat;

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
    undef $in;
    close($tfh);
    undef $tfh;
    return $inputfile;

}
1;
