package Bio::Tools::Run::Tmhmm;

use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR
            $TMPDIR $PROGRAMNAME @TMHMM_PARAMS
                         %OK_FIELD);
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Tmhmm;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);




BEGIN {
       $PROGRAMNAME = 'tmhmm'  . ($^O =~ /mswin/i ?'.exe':'');

       if (defined $ENV{TMHMMDIR}) {
          $PROGRAMDIR = $ENV{TMHMMDIR} || '';
          $PROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,
                                           'tmhmm'.($^O =~ /mswin/i ?'.exe':''));
       }
       else {
          $PROGRAM = 'tmhmm';
       }
       $TMPDIR=Bio::Root::IO->catfile("","/scratch/bala");
       @TMHMM_PARAMS=qw(PROGRAM VERBOSE);
       foreach my $attr ( @TMHMM_PARAMS)
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

sub predict_protein_features{
    my ($self,$seq) = @_;
    my @feats;
    eval {
       $seq->isa ("Bio::PrimarySeqI") || $seq->isa ("Bio::SeqI")
    };


    if (!$@) {
    
        my $infile1 = $self->_writeSeqFile($seq);
        
        $self->_set_input($infile1);
        
         @feats = $self->_run();
          my $file_no = unlink $infile1;
       
    }
    else {
        #The clone object is not a seq object but a file.
        #Perhaps should check here or before if this file is fasta format...if not die
        #Here the file does not need to be created or deleted. Its already written and may be used by other runnables.

        $self->_set_input($seq);

         @feats = $self->_run();
        
    }
   
    return @feats;

}

sub _set_input() {
     my ($self,$infile1) = @_;
     $self->{'input'}=$infile1;
}

sub _run {
     my ($self)= @_;
     
     my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$TMPDIR);
     #my $str ="perl ".$self->program." ".$self->{'input'}." > ".$outfile;
      my $str ="perl ".$self->{'_pathtoexe'}." ".$self->{'input'}." > ".$outfile;
     print STDERR "$str\n";
     my $status = system($str);
     $self->throw( "Tmhmm call ($str) crashed: $? \n") unless $status==0;
     
    #  my $tmhmm_parser = Bio::Tools::Tmhmm->new();
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
     
     $self->cleanup();
     my $file_no = unlink $outfile;
     
     return @tmhmm_feat;

}


sub _writeSeqFile{
    my ($self,$seq) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$TMPDIR);
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'Fasta');
    $in->write_seq($seq);

    return $inputfile;

}
1;
