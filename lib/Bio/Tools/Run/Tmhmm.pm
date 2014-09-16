#
#
#  Copyright Balamurugan Kumarasamy
#
#  You may distribute this module under the same terms as perl itself
#  POD documentation - main docs before the code
#

=head1 NAME

Bio::Tools::Run::Tmhmm - Object for identifying transmembrane helixes
  in a given protein seequence.

=head1 SYNOPSIS

  # Build a Tmhmm  factory

  # $paramfile is the full path to the seg binary file

  my @params = ('PROGRAM',$paramfile);
  my $factory = Bio::Tools::Run::Tmhmm->new($param);

  # Pass the factory a Bio::Seq object
  # @feats is an array of Bio::SeqFeature::Generic objects

  my @feats = $factory->run($seq);

=head1 DESCRIPTION

Tmhmm is a program for identifying transmembrane helices in proteins.

You must have the environmental variable TMHMMDIR set to the base
directory where I<tmhmm> and it's associated data/option files reside
(NOT the bin directory where the actual executable resides)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

head2 Reporting Bugs

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

package Bio::Tools::Run::Tmhmm;

use vars qw($AUTOLOAD @ISA $PROGRAMNAME @TMHMM_PARAMS %OK_FIELD);
use strict;
use Cwd;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Tmhmm;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Tools::Run::WrapperBase);

BEGIN {
    $PROGRAMNAME = 'tmhmm'  . ($^O =~ /mswin/i ?'.exe':'');       
    @TMHMM_PARAMS=qw(PROGRAM VERBOSE NOPLOT);
    foreach my $attr ( @TMHMM_PARAMS)
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
    return $PROGRAMNAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable, in this
           case it is the tmhmm installation directory, not the location of
           the executable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return $ENV{TMHMMDIR} || '';
}

=head2 program_path

 Title   : program_path
 Usage   : my $path = $factory->program_path();
 Function: Builds path for executable 
 Returns : string representing the full path to the exe
 Args    : none

=cut

sub program_path {
    my ($self) = @_;
    my @path;
    if ($self->program_dir) {
        my $program_dir = $self->program_dir;
        $program_dir =~ s/\/bin//;
        push @path, $program_dir;
    }
    push @path, 'bin';
    push @path, $self->program_name.($^O =~ /mswin/i ?'.exe':'');

    return File::Spec->catfile(@path);
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
 Function: creates a new Tmhmm factory
 Returns:  Bio::Tools::Run::Tmhmm
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
           $self->$attr($value);
       }
       return $self;
}

=head2 predict_protein_features

 Title   :   predict_protein_features()
 Usage   :   DEPRECATED Use $obj->run($seq) instead
 Function:   Runs Tmhmm and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub predict_protein_features{
	return shift->run(@_);
}

=head2 executable

 Title   : executable
 Usage   : my $exe = $tmhmm->executable('tmhmm');
 Function: Finds the full path to the 'tmhmm' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to
           [optional] boolean flag whether or not warn when exe is not found

=cut

sub executable {
    my $self = shift;
    my $exe = $self->SUPER::executable(@_) || return;
    
    # even if its executable, we still need the environment variable to have
    # been set
    if (! $ENV{TMHMMDIR}) {
        $self->warn("Environment variable TMHMMDIR must be set, even if the tmhmm executable is in your path");
        return undef;
    }
    
    return $exe;
}

=head2 run

 Title   :   run()
 Usage   :   $obj->run($seq)
 Function:   Runs Tmhmm and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run {
    my ($self,$seq) = @_;
    my @feats;

    if (ref($seq) ) {		# it is an object
        if (ref($seq) =~ /GLOB/) {
            $self->throw("cannot use filehandle");
        }

        my $infile1 = $self->_writeSeqFile($seq);

        $self->_input($infile1);

	@feats = $self->_run();
	unlink $infile1;

    }
    else {
        # The clone object is not a seq object but a file.  Perhaps
        # should check here or before if this file is fasta format...if
        # not die Here the file does not need to be created or
        # deleted. Its already written and may be used by other
        # runnables.

        $self->_input($seq);
	@feats = $self->_run();
    }
    return @feats;
}


=head2 _input

 Title   :   _input
 Usage   :   obj->_input($seqFile)
 Function:   Internal(not to be used directly)
 Returns :
 Args    :

=cut

sub _input() {
     my ($self,$infile1) = @_;
     if (defined $infile1){

         $self->{'input'}=$infile1;
     }
      return $self->{'input'};
}

=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal(not to be used directly)
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :

=cut

sub _run {
     my ($self)= @_;

     my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$self->tempdir());
     my $str = $self->executable || return;
     
     if( $self->NOPLOT ) {
	 $str .= " --noplot";
     }
     $str .= " -basedir=".$self->program_dir." -workdir=".$self->tempdir()." ".$self->_input." > ".$outfile;
     
     my $status = system($str);
     $self->throw( "Tmhmm call ($str) crashed: $? \n") unless $status==0;
    
     my $filehandle;
     if (ref ($outfile) !~ /GLOB/) {
        open (TMHMM, "<".$outfile) or $self->throw ("Couldn't open file ".$outfile.": $!\n");
        $filehandle = \*TMHMM;
     }
     else {
        $filehandle = $outfile;
     }

     my $tmhmm_parser = Bio::Tools::Tmhmm->new(-fh=>$filehandle);

     my @tmhmm_feat;

     while(my $tmhmm_feat = $tmhmm_parser->next_result){

           push @tmhmm_feat, $tmhmm_feat;
     }
     # free resources
     $self->cleanup();
     unlink $outfile;
     close($tfh1);
     undef $tfh1;
     
     return @tmhmm_feat;
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
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir());
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'Fasta');
    $in->write_seq($seq);
    close($tfh);
    undef $tfh;
    return $inputfile;

}
1;
