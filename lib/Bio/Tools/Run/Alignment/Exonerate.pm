# $Id$
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Shawn Hoon
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Exonerate

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::Exonerate;
  use Bio::SeqIO;

  my $qio = Bio::SeqIO->new(-file=>$ARGV[0],-format=>'fasta');
  my $query = $qio->next_seq();
  my $tio = Bio::SeqIO->new(-file=>$ARGV[1],-format=>'fasta');
  my $target = $sio->next_seq();

  #exonerate parameters can all be passed via arguments parameter.
  #parameters passed are not checked for validity

  my $run = Bio::Tools::Run::Alignment::Exonerate->
      new(arguments=>'--model est2genome --bestn 10');
  my $searchio_obj = $run->run($query,$target);

  while(my $result = $searchio->next_result){
    while( my $hit = $result->next_hit ) {
      while( my $hsp = $hit->next_hsp ) {
        print $hsp->start."\t".$hsp->end."\n";
      }
    }
  }

=head1 DESCRIPTION

Wrapper for Exonerate alignment program. You can get exonerate at
http://www.ebi.ac.uk/~guy/exonerate/.  This wrapper is written without
parameter checking. All parameters are passed via the arugment
parameter that is passed in the constructor. See SYNOPSIS.  For
exonerate parameters, run exonerate --help for more details.

=head1 PROGRAM VERSIONS

The tests have been shown to pass with exonorate versions 2.0 - 2.2.

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

  Email shawnh-at-stanford.edu

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::Exonerate;

use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR
            $PROGRAMNAME @EXONERATE_PARAMS %OK_FIELD);
use strict;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Run::WrapperBase;
use Bio::SearchIO;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase 
	  Bio::Factory::ApplicationFactoryI);

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
    return 'exonerate';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return Bio::Root::IO->catfile($ENV{EXONERATEDIR}) if $ENV{EXONERATEDIR};
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
    my $exe;
    return undef unless $exe = $self->executable;
    my $string = `$exe -v` ;
    #exonerate from exonerate version 2.0.0\n...
    my ($version) = $string =~ /exonerate version ([\d+\.]+)/m;
    $version =~ s/\.(\d+)$/$1/;
    return $version || undef;
}


=head2 run

 Title   :   run()
 Usage   :   my $feats = $factory->run($seq)
 Function:   Runs Phrap 
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run {
    my ($self,$query,$target) = @_;
    my @feats;
    my ($file1) = $self->_writeInput($query);
    my ($file2) = $self->_writeInput($target);
    my $assembly = $self->_run($file1,$file2);
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
     my ($self,$query,$target)= @_;

     my ($tfh,$outfile) = $self->io->tempfile(-dir=>$self->tempdir);
     my $param_str = $self->_setparams." ".$self->arguments;
     my $str = $self->executable." $param_str $query $target "." > $outfile";
     $self->debug( "$str\n");
     my $status = system($str);
     $self->throw( "Exonerate call ($str) crashed: $? \n") unless $status==0;
     my $filehandle;
     my $exonerate_obj = Bio::SearchIO->new(-file=>"$outfile",-format=>'exonerate');

     close($tfh);
     undef $tfh;
     unlink $outfile;

     return $exonerate_obj;
}


=head2 _writeInput

 Title   :   _writeInput
 Usage   :   $factory->_writeInput($query,$target)
 Function:   Creates a file from the given seq object
 Returns :   A string(filename)
 Args    :   Bio::PrimarySeqI

=cut

sub _writeInput{
    my ($self,$query) = @_;
    my ($fh,$infile1);
    if (ref($query) =~ /ARRAY/i) {
      my @infilearr;
      ($fh, $infile1) = $self->io->tempfile();
      my $temp = Bio::SeqIO->new( -file => ">$infile1",
                                  -format => 'Fasta' );
      foreach my $seq1 (@$query) {
        unless ($seq1->isa("Bio::PrimarySeqI")) {
          return 0;
        }
        $temp->write_seq($seq1);
        push @infilearr, $infile1;
      }
    }
    elsif($query->isa("Bio::PrimarySeqI")) {
      ($fh, $infile1) = $self->io->tempfile();
      my $temp = Bio::SeqIO->new( -file => ">$infile1",
                                  -format => 'Fasta' );
      $temp->write_seq($query);
    }
    else {
      $infile1 = $query;
    }
    return $infile1;
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
    my $param_string = '';
    foreach my $attr(@EXONERATE_PARAMS){
        next if($attr=~/PROGRAM/);
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .= $attr_key.' '.$value;
    }
    return $param_string;
}

1;
