# Cared for by Shawn Hoon
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Vista

Wrapper for Vista

=head1 SYNOPSIS

  use Bio::Tools::Run::Vista;
  use Bio::Tools::Run::Alignment::Lagan;
  use Bio::AlignIO;

  my $sio = Bio::SeqIO->new(-file=>$ARGV[0],-format=>'fasta');
  my @seq;
  my $reference = $sio->next_seq;
  push @seq, $reference;
  while(my $seq = $sio->next_seq){
    push @seq,$seq;
  }
  my @features = grep{$_->primary_tag eq 'CDS'} $reference->get_SeqFeatures;

  my $lagan = Bio::Tools::Run::Alignment::Lagan->new;

  my $aln = $lagan->mlagan(\@seq,'(fugu (mouse human))');


  my $vis = Bio::Tools::Run::Vista->new('outfile'=>'tmp.pdf',
                                        'annotation'=>\@features,
                                        'regmin'=>75,
                                        'regmax'=>100,
                                        'min'   => 50,
                                        'tickdist' => 2000,
                                        'window'=>40,
                                        'numwindows'=>4,
                                        'quiet'=>1);

  my $reference_index = 1;
  $vis->run($aln,$reference_index); 

=head1 DESCRIPTION

Pls see Vista documentation for parameter explanations

Wrapper for Vista :

C. Mayor, M. Brudno, J. R. Schwartz, A. Poliakov, E. M. Rubin, K. A.  Frazer, 
L. S. Pachter, I. Dubchak. 
VISTA: Visualizing global DNA  sequence alignments of arbitrary length.
Bioinformatics, 2000  Nov;16(11):1046-1047.
Get it here:
http://www-gsd.lbl.gov/vista/VISTAdownload2.html

On the command line, it is assumed that this can be executed:

java Vista plotfile

Some of the code was adapted from MLAGAN toolkit

M. Brudno,  C.B. Do,  G. Cooper,  M.F. Kim,  E. Davydov,  NISC Sequencing Consortium, 
E.D. Green,  A. Sidow and S. Batzoglou 
LAGAN and Multi-LAGAN: Efficient Tools for Large-Scale Multiple  Alignment of Genomic 
DNA, Genome Research, in press

get lagan here:

http://lagan.stanford.edu/

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org               - General discussion
  http://bio.perl.org/MailList.html   - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via email
or the web:

  bioperl-bugs@bio.perl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR

Shawn Hoon
Email shawnh@fugu-sg.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Vista;

use vars qw($AUTOLOAD @ISA %DEFAULT_VALUES %EPONINE_PARAMS
       	   @VISTA_PARAMS  $EPOJAR $JAVA $PROGRAMDIR $PROGRAMNAME $PROGRAM
            %OK_FIELD);
use strict;

use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
    $PROGRAMNAME = 'java';

    if( ! defined $PROGRAMDIR ) {
    	$PROGRAMDIR = $ENV{'JAVA_HOME'} || $ENV{'JAVA_DIR'};
    }
    if (defined $PROGRAMDIR) {
    	foreach my $progname ( [qw(java)],[qw(bin java)] ) {
  	    my $f = Bio::Root::IO->catfile($PROGRAMDIR, @$progname);
  	    if( -e $f && -x $f ) {
      		$PROGRAM = $f;
      		last;
  	    }
    	}
    }

    %DEFAULT_VALUES= ('java'     => 'java',
                      'regmin'   => 75,
                      'regmax'   => 100,
                      'min'      => 50,
                      'bases'    => 10000,
                      'tickdist' => 2000,
                      'resolution'=> 25,
                      'window'  => 40,
                      'numwindows'=>4);

    @VISTA_PARAMS=qw(JAVA OUTFILE REGMIN QUIET VERBOSE ANNOTATION_FORMAT
                     REGMAX MIN ANNOTATION BASES TICKDIST RESOLUTION 
                     WINDOW NUMWINDOWS);

    foreach my $attr ( @VISTA_PARAMS)
    { $OK_FIELD{$attr}++; }
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $self->debug( "************ attr:  $attr\n");
    $attr =~ s/.*:://;
    $attr = uc $attr;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr} = shift if @_;
    return $self->{$attr};
}

sub new {
    my ($caller, @args) = @_;
    # chained new
    my $self = $caller->SUPER::new(@args);
    # so that tempfiles are cleaned up
    foreach my $key(keys %DEFAULT_VALUES){
      $self->$key($DEFAULT_VALUES{$key});
    }
    while (@args)  {
       my $attr =   shift @args;
       my $value =  shift @args;
       next if( $attr =~ /^-/ ); # don't want named parameters
	    $self->$attr($value);
    }

    return $self;
}

=head2 java

    Title   :   java
    Usage   :   $obj->java('/usr/opt/java130/bin/java');
    Function:   Get/set method for the location of java VM
    Args    :   File path (optional)

=cut

sub executable { shift->java(@_); }

sub java {
   my ($self, $exe,$warn) = @_;

   if( defined $exe ) {
     $self->{'_pathtojava'} = $exe;
   }

   unless( defined $self->{'_pathtojava'} ) {
       if( $PROGRAM && -e $PROGRAM && -x $PROGRAM ) {
	   $self->{'_pathtojava'} = $PROGRAM;
       } else {
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($PROGRAMNAME) ) &&
	       -x $exe ) {
	       $self->{'_pathtojava'} = $exe;
	   } else {
	       $self->warn("Cannot find executable for $PROGRAMNAME") if $warn;
	       $self->{'_pathtojava'} = undef;
	   }
       }
   }
   $self->{'_pathtojava'};
}


=head2 run

 Title   : run
 Usage   : my @genes = $self->run($seq)
 Function: runs Vista and creates an array of features
 Returns : An Array of SeqFeatures
 Args    : A Bio::PrimarySeqI

=cut

sub run{
    my ($self,$seq,$ref) = @_;
    $ref ||=1;
    my $infile = $self->_setinput($seq,$ref);
    my @tss = $self->_run_Vista($infile);
    return @tss;

}

=head2 _setinput

 Title   : _setinput
 Usage   : Internal function, not to be called directly
 Function: writes input sequence to file and return the file name
 Example :
 Returns : string
 Args    :

=cut

sub _setinput {
    my ($self,$sim_aln,$ref) = @_;
    #better be a file
    $sim_aln->isa("Bio::Align::AlignI") || $self->throw("Expecting a Bio::Align::AlignI");
    my($pairs,$files) = $self->_mf2bin($sim_aln,$ref);
    my $plotfile = $self->_make_plotfile($sim_aln,$pairs,$files);
    return $plotfile;
}

#adapted from mlagan utils  mf2bin.pl 
sub _mf2bin {
  my ($self,$sim,$ref)= @_;
  my @seq = $sim->each_seq;
  my $reference = $seq[$ref-1];
  splice @seq,($ref-1),1;
  
  # pack bin
  # format from Alex Poliakov's glass2bin.pl script
  my %base_code = ('-' => 0, 'A' => 1, 'C' => 2, 'T' => 3, 'G' => 4, 'N' => 5,
                'a' => 1, 'c' => 2, 't' => 3, 'g' => 4, 'n' => 5);

  my @files;

  my @ref= reverse(split ('',$reference->seq));
  my @pairs;
  foreach my $seq2(@seq){
      my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$self->tempdir);
      my @seq2= reverse (split('', $seq2->seq)); 
      foreach my $index(0..$#ref){
        print $tfh1 pack("H2",$base_code{$ref[$index]}.$base_code{$seq2[$index]});
      }
      close ($tfh1);
      undef ($tfh1);
      push @files, $outfile;
      push @pairs,[$reference->id,$seq2->id];
  }
  return \@pairs,\@files;
}

sub _make_plotfile {
  my ($self,$sim_aln,$pairs,$files) = @_;
  my ($tfh1,$plotfile) = $self->io->tempfile(-dir=>$self->tempdir);
  my @ids = map{$_->id}$sim_aln->each_seq;

  print $tfh1 "TITLE VISTA PLOT\n\n";
  print $tfh1 "OUTPUT ".$self->outfile."\n\n" ;
  print $tfh1 "SEQUENCES ";
  print $tfh1 join(" ",@ids)."\n\n";

  foreach my $index(0..$#$pairs){
    print $tfh1 "ALIGN ".$files->[$index]." BINARY\n";
    print $tfh1 " SEQUENCES ".$pairs->[$index]->[0]." ".$pairs->[$index]->[1]."\n";
    print $tfh1 " REGIONS ".$self->regmin." ".$self->regmax."\n";
    print $tfh1 " MIN ".$self->min."\n";
    print $tfh1 "END\n\n";
  }
  my $annotation_file;
  if((ref $self->annotation eq 'ARRAY')&& $self->annotation->[0]->isa("Bio::SeqFeatureI")){
    $annotation_file = $self->_dump2gff($self->annotation);
    $self->annotation_format('GFF');
  }
  elsif($self->annotation){
    $annotation_file = $self->annotation;
  }
  $annotation_file .= " GFF" if $self->annotation_format=~/GFF/i;
  print $tfh1 "GENES ".$annotation_file." \n\n" if $annotation_file;
  print $tfh1 "LEGEND on\n\n";
  print $tfh1 "COORDINATE ".$pairs->[0]->[0]."\n\n";
  print $tfh1 "PAPER letter\n\n";
  print $tfh1 "BASES ".$self->bases."\n\n";
  print $tfh1 "TICK_DIST ".$self->tickdist."\n\n";
  print $tfh1 "RESOLUTION ".$self->resolution."\n\n";
  print $tfh1 "WINDOW ".$self->window."\n\n";
  print $tfh1 "NUM_WINDOWS ".$self->numwindows."\n\n";

  close ($tfh1);
  undef $tfh1;
 
  return $plotfile;
}     

sub _dump2gff {
  my ($self,$feat) = @_;
  my ($tfh1,$file) = $self->io->tempfile(-dir=>$self->tempdir);
  my @CDS = grep {$_->primary_tag eq 'CDS'}@$feat;
  foreach my $cds(@CDS){
    print $tfh1 $cds->gff_string."\n";
  }
  close ($tfh1);
  undef $tfh1;
  return $file;
}

sub _run_Vista {
    my ($self,$infile) = @_;

    #run Vista
    $self->debug( "Running Vista\n");
    my $java = $self->java;
    
    my $cmd  =   $self->java.' Vista ';
    $cmd .= " -q " if $self->quiet || $self->verbose < 0;
    $cmd .= " -d " if $self->debug;
    $cmd .= $infile;
	 my $status = system ($cmd);

   $self->throw("Problem running Vista: $? \n") if $status != 0;
   
   return 1;

}

=head2 regmin

    Title   :   regmin
    Usage   :   $obj->regmin()
    Function:   Get/set method regmin
    Args    :   a number 1-100

=cut

=head2 regmax

    Title   :   regmax
    Usage   :   $obj->regmax()
    Function:   Get/set method regmax
    Args    :   a number 1-100

=cut

=head2 outfile

    Title   :   outfile
    Usage   :   $obj->outfile()
    Function:   Get/set method for the pdf file 
    Args    :   a string

=cut

=head2 min 

    Title   :   min 
    Usage   :   $obj->min()
    Function:   Get/set method minimum percent identity 
    Args    :   an integer 1-100 

=cut

=head2 annotation_format 

    Title   :   annotation_format 
    Usage   :   $obj->annotation_format()
    Function:   Get/set for annotation format GFF | SIMPLE (default)
    Args    :   a string

=cut

=head2 annotation 

    Title   :   annotation 
    Usage   :   $obj->annotation()
    Function:   Get/set for annotation file
    Args    :   a string

=cut

=head2 bases 

    Title   :   bases 
    Usage   :   $obj->bases()
    Function:   Get/set for bases 
    Args    :   a number 

=cut

=head2 tickdist 

    Title   :   tickdist 
    Usage   :   $obj->tickdist()
    Function:   Get/set for tickdist 
    Args    :   a number 

=cut

=head2 resolution 

    Title   :   resolution 
    Usage   :   $obj->resolution()
    Function:   Get/set for resolution 
    Args    :   a number 

=cut


=head2 window 

    Title   :   window 
    Usage   :   $obj->window()
    Function:   Get/set for window 
    Args    :   a number 

=cut


=head2 numwindows 

    Title   :   numwindows 
    Usage   :   $obj->numwindows()
    Function:   Get/set for numwindows 
    Args    :   a number 

=cut

1;
__END__
