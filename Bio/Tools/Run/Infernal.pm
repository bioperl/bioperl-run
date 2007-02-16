# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Infernal - Wrapper for local execution of cmalign, cmbuild,
cmsearch, cmscore

=head1 SYNOPSIS

  #run cmalign|cmbuild|cmsearch|cmscore|cmedit
  
  my @params = ();
  
  my $factory = Bio::Tools::Run::Infernal->new('program' =>'cmsearch',
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
  
  my $factory =  Bio::Tools::Run::Infernal->new('program'=>'cmalign');
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

package Bio::Tools::Run::Infernal;

use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::SearchIO;
use Bio::AlignIO;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

# will move parameters to each program, use this for _set_params
my %INFERNAL_PROGRAM = (
    cmalign  => [qw(h l o q informat nosmall regress full tfile banddump dlev
                time inside outside post checkpost sub fsub elsilent hbanded hbandp sums
                checkcp9 qdb beta noexpand W)], 
    cmbuild  => [qw(h n A F binary rf gapthresh informat bandp elself nodetach
                wgiven wnone wgsc effent etarget effnone cfile cmtbl emap gtree gtbl tfile
                bfile local bdfile nobalance regress treeforce ignorant dlev null
                priorfile)],
    cmscore  => [qw(h informat local regress scoreonly smallonly stringent qdb
                beta)],
    cmsearch => [qw(h W informat toponly local noalign dumptrees thresh X inside
                null2 learninserts hmmfb hmmweinberg hmmpad hmmonly hthresh beta noqdb
                qdbfile hbanded hbandp banddump sums scan2bands)],
    cmemit   => [qw(a c h n o q seed full begin end cp9)],
    );

my %INFERNAL_SWITCHES = map {$_ => 1} qw(X banddump binary checkcp9 checkpost
    cp9 dumptrees effent effnone elsilent fsub full hbanded hmmfb hmmonly
    hmmweinberg ignorant inside learninserts local noalign nobalance nodetach
    noexpand noqdb nosmall null2 outside post qdb rf scan2bands scoreonly
    smallonly stringent sub sums time toponly treeforce wgiven wgsc wnone);

my %INFERNAL_DOUBLE = map {$_ => 1} qw(X banddump bandp bdfile begin beta bfile
    binary cfile checkcp9 checkpost cmtbl cp9 dlev dumptrees effent effnone
    elself elsilent emap end etarget fsub full gapthresh gtbl gtree hbanded
    hbandp hmmfb hmmonly hmmpad hmmweinberg hthresh ignorant informat inside
    learninserts local noalign nobalance nodetach noexpand noqdb nosmall null
    null2 outside post priorfile qdb qdbfile regress rf scan2bands scoreonly
    seed smallonly stringent sub sums tfile thresh time toponly treeforce wgiven
    wgsc wnone);

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
    my ($program, $out, $tf) = $self->_rearrange([qw(PROGRAM
                                                  OUTFILE_NAME
                                                  TEMPFILE)], @args);
    $self->throw("No program defined") if !$program;
    $self->throw("Program '$program' not supported") if !exists $INFERNAL_PROGRAM{$program};
    $self->io->_initialize_io();
    if ($tf && !$out) {
        my ($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir());
        close($tfh);
        undef $tfh;
        $self->outfile_name($outfile);
    } else {
        $out ||= '';
        $self->outfile_name($out);
    }
    $tf   && $self->tempfile($tf);
    $self->_set_from_args(\@args,
                          -methods => [@{ $INFERNAL_PROGRAM{$program} }, 'program', 'model'],
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
  return Bio::Root::IO->catfile($ENV{INFERNALDIR}) if $ENV{INFERNALDIR};
}

=head2 run

 Title   :   run
 Usage   :   $obj->run($seqFile)
 Function:   Runs HMMER and returns Bio::SearchIO
 Returns :   A Bio::SearchIO
 Args    :   A Bio::PrimarySeqI or file name

=cut

sub run {
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
    my $param_str = $self->arguments." ".$self->_setparams;
    $str .= "$param_str ".$file;
    my $progname = $self->program_name;
    $self->debug("Infernal command: $str\n");
    # small sanity check
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
    my ($program, $model) = ($self->program, $self->model);
    $self->throw("No valid program defined!") if !$program || !exists $INFERNAL_PROGRAM{$program};
    my @valid_params = @{ $INFERNAL_PROGRAM{$program} };
    my @params;
    my %p;
    foreach my $attr (@valid_params) {
        $p{$attr}++;
        my $val = ($self->can($attr)) ? 1 : 0;
        my $value = ($self->can($attr)) ? $self->$attr() : undef;
        next unless (defined $value);
        my $attr_key = (exists $INFERNAL_DOUBLE{$attr}) ? '--'.$attr : '-'.$attr;
        if (exists $INFERNAL_SWITCHES{$attr}) {
            push @params, $attr_key;
        } else {
            push @params, ($attr_key, $value);
        }
    }
    $param_string = join ' ', @params;
    return $param_string;
}

=head2 _writeSeqFile

 Title   :   _writeSeqFile
 Usage   :   obj->_writeSeqFile($seq)
 Function:   Internal(not to be used directly)
 Returns :
 Args    :

=cut

sub _writeSeqFile {
    my ($self,@seq) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'Fasta');
    foreach my $s(@seq){
    $in->write_seq($s);
    }
    $in->close();
    $in = undef;
    close($tfh);
    undef $tfh;
    return $inputfile;
}

=head2 _writeAlignFile

 Title   :   _writeAlignFile
 Usage   :   obj->_writeAlignFile($seq)
 Function:   Internal(not to be used directly)
 Returns :
 Args    :

=cut

sub _writeAlignFile{
    my ($self,@align) = @_;
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
    my $in  = Bio::AlignIO->new('-fh'     => $tfh , 
                '-format' => 'msf');
    foreach my $s(@align){
      $in->write_aln($s);
    }
    $in->close();
    $in = undef;
    close($tfh);
    undef $tfh;
    return $inputfile;
}

1;
