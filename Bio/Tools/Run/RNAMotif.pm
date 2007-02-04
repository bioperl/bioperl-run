# $Id$
#
# BioPerl module for Bio::Tools::Run::RNAMotif
#
# Cared for by Chris Fields
#
# Copyright Chris Fields
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::RNAMotif - Wrapper for local execution of rnamotif, rm2ct,
rmfmt, rmprune

=head1 SYNOPSIS

  #run rnamotif|rmfmt|rm2ct
  
  my @params = (
              descr => 'pyrR.descr',
              fmt   => 'gb',
              setvar => 'ctx_maxlen=20',
              context => 1,
              sh    => 1,
             );
  
  my $factory = Bio::Tools::Run::RNAMotif->new('program' =>'rnamotif',
                                                'prune'  => 1,
                                                @params);

  # Pass the factory a Bio::Seq object or a file name
  # Returns a Bio::SearchIO object
  
  my $search = $factory->run($seq);
  my @feat;
  while (my $result = $searchio->next_result){
   while(my $hit = $result->next_hit){
    while (my $hsp = $hit->next_hsp){
            print join("\t", ( $r->query_name,
                               $hit->name,
                               $hsp->hit->start,
                               $hsp->hit->end,
                               $hsp->meta,
                               $hsp->score,
                               )), "\n";
    }
   }
  }

  # Pass a finished report through rmfmt (-a format only)
  # Returns Bio::AlignIO object
  
  my $aio = Bio::AlignIO->new(-file=>"rna.msf",-format=>'msf');
  my $factory =  Bio::Tools::Run::RNAMotif->new('program'=>'rmfmt',
                                                'a' => 1);
  my $alnin = $factory->run('trna.rnamotif');
  
  my $aln = $alnin->next_aln;
  
  $aio->write_aln($aln);

=head1 DESCRIPTION

Wrapper module for Tom Macke and David Cases's RNAMotif suite of programs.  This
allows running of rnamotif, rmprune, rm2ct, and rmfmt. Binaries are available
at http://www.scripps.edu/mb/case/casegr-sh-3.5.html

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Chris Fields

 Email: cjfields-at-uiuc-dot-edu

=head1 CONTRIBUTORS 

 cjfields-at-uiuc-dot-edu

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::RNAMotif;

use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::SearchIO;
use Bio::AlignIO;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

my %RNAMOTIF_PROGS = map {$_ => 1} qw(rnamotif rm2ct rmfmt rmprune);

my %RNAMOTIF_SWITCHES = map {$_ => 1} qw(c d h p s v l a la context sh);

# order is important here
my @RNAMOTIF_PARAMS=qw(c sh N d h p s v context setvar On I xdfname pre post
                        descr xdescr fmt fmap l a la program db prune);

=head2 new

 Title   : new
 Usage   : my $wrapper = Bio::Tools::Run::RNAMotif->new(@params)
 Function: creates a new RNAMotif factory
 Returns:  Bio::Tools::Run::RNAMotif
 Args    : list of parameters

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($outfile) = $self->_rearrange([qw(OUTFILE_NAME)], @args);
    $outfile    && $self->outfile_name($outfile);
    $self->io->_initialize_io();
    $self->_set_from_args(\@args,
                          -methods => [@RNAMOTIF_PARAMS],
                          -create => 1
                         );
    
    return $self;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  my ($self) = shift;
  return $self->program(@_);
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtiained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{RNAMOTIFDIR}) if $ENV{RNAMOTIFDIR};
}

=head2  version

 Title   : version
 Usage   : $v = $prog->version();
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    return undef unless $self->executable;
    my $string = `rnamotif -v`;
    my $v;
    if ($string =~ m{(\d+)}) {
        $v = $1;
    }
    return $v || $string;
}

=head2 run

 Title   :   run
 Usage   :   $obj->run($seqFile)
 Function:   Runs HMMER and returns Bio::SearchIO
 Returns :   A Bio::SearchIO
 Args    :   A Bio::PrimarySeqI or file name

=cut

sub run{
    my ($self,@seq) = @_;
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal(not to be used directly)
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :

=cut

sub _run {
    my ($self,$file)= @_;
    my $str = $self->executable;
    my $outfile = $self->outfile_name;
    #$self->debug("Params:",$self->_setparams,"\n");
    my $param_str = $self->arguments." ".$self->_setparams;
    $str .= "$param_str ".$file;
    
    my $progname = $self->program_name;
    if ($self->prune && $progname eq 'rnamotif') {
        $str .= ' | rmprune';
    }
    $self->debug("RNAMotif command: $str\n");
    # small sanity check
    $self->throw("Unknown program: $progname") if (!exists $RNAMOTIF_PROGS{$progname} );
    if($progname eq 'rnamotif' || $progname eq 'rmprune' ){
        my $fh;
        open($fh,"$str |") || $self->throw("RNAMotif call ($str) crashed: $?\n");
        return Bio::SearchIO->new(-fh      => $fh, 
                      -verbose => $self->verbose,
                      -format  => "rnamotif");
    } elsif ($progname eq 'rmfmt' && $self->can('a') && $self->a) {
        my $fh;
        open($fh,"$str |") || $self->throw("RNAMotif call ($str) crashed: $?\n");
        return Bio::AlignIO->new(-fh      => $fh,
                        -verbose => $self->verbose,
                        -format  =>'fasta');
    } else {
        # for rm2ct, possibly SeqIO-based?
        my $status = open(my $OUT,"$str | ");
        my $io;
        while(<$OUT>) {
            $io .= $_;
        }
        close($OUT);
        $self->debug($io) if $self->verbose > 0;
        unless( $status ) {
            $self->throw("RNAMotif call ($str) crashed: $?\n") unless $status==1;
        }
        return 1;
    }
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
    my @params;
    foreach my $attr (@RNAMOTIF_PARAMS){
        next if ($attr =~/PROGRAM|DB|PRUNE/i);
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = '-'.$attr;
        if (exists $RNAMOTIF_SWITCHES{$attr}) {
            push @params, $attr_key;
        } else {
            if ($attr eq 'setvar') {
                push @params, '-D'.$value;
            } else {
                push @params, $attr_key.' '.$value;
            }
        }
    }
    $param_string = join ' ', @params;
    return $param_string;
}

=head2 _writeSeqFile

 Title   : _writeSeqFile
 Usage   : obj->_writeSeqFile($seq)
 Function: Internal(not to be used directly)
 Returns : writes passed Seq objects to tempfile, to be used as input
           for program
 Args    : 

=cut

sub _writeSeqFile {
    my ($self,@seq) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
    foreach my $s(@seq){
    $in->write_seq($s);
    }
    $in->close();
    $in = undef;
    close($tfh);
    undef $tfh;
    return $inputfile;
}

1;
