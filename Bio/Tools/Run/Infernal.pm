# $Id$
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code
#
# _history
#
# March 2007 - first full implementation; needs some file IO tweaking between
#              runs but works for now
# April 2008 - add 0.81 parameters (may be removed in the 1.0 release)

=head1 NAME

Bio::Tools::Run::Infernal - Wrapper for local execution of cmalign, cmbuild,
cmsearch, cmscore

=head1 SYNOPSIS
  
  # parameters which are switches are set with any value that evals TRUE,
  # others are set to a specific value
  
  my @params = (hmmfb => 1,
                thresh => 20);
  
  my $factory = Bio::Tools::Run::Infernal->new(@params);
                                                
  # run cmalign|cmbuild|cmsearch|cmscore|cmemit directly as a wrapper method
  # this resets the program flag if previously set
  
  $factory->cmsearch(@seqs); # searches Bio::PrimarySeqI's based on set cov. model
                             # saves output to outfile()/tempfile

  # only values which are allowed for a program are set, so one can use the same
  # wrapper for the following...
  
  $factory->cmalign(@seqs); # aligns Bio::PrimarySeqI's to a set cov. model
                            # saves output to outfile()/tempfile
  $factory->cmscore(@seqs); # scores set cov. model against Bio::PrimarySeqI's,
                            # saves output to outfile()/tempfile/STDERR.
  $factory->cmbuild($aln); # builds covariance model based on alignment
                           # saves CM to model(), output to outfile()/tempfile/STDERR.
  $factory->cmemit($file); # emits sequence from specified cov. model;
                           # set one if no file specified

  # run based on the setting of the program parameter
  
  my $factory = Bio::Tools::Run::Infernal->new(-program => 'cmsearch',
                                                @params);
  my $search = $factory->run($seq);
  
  # using cmsearch returns a Bio::SearchIO object
  
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
  
=head1 DESCRIPTION

Wrapper module for Sean Eddy's Infernal suite of programs. The current
implementation runs cmsearch, cmalign, cmemit, cmbuild, and cmscore. The only
current BioPerl object returned is for cmsearch (as shown in the SYNOPSIS); all
others are sent to either the designated outfile, a tempfile, or STDOUT.

Since the Infernal suite is under constant development, consider this wrapper as
highly experimental. It will only actively support the latest Infernal release
(now at v. 0.81, used to build Rfam 8.0) until a 1.0 Infernal release is made.

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

our @PARAMS = qw(A F W X a banddump bandp bdfile begin beta bfile binary c cfile
checkcp9 checkpost cmtbl cp9 dlev dumptrees effent effnone elself elsilent emap
end etarget fsub full gapthresh gtbl gtree h hbanded hbandp hmmfb hmmonly hmmpad
hmmweinberg hthresh ignorant informat inside l learninserts local n noalign
nobalance nodetach noexpand noqdb nosmall null null2 outside post priorfile q
qdb qdbfile regress rf scan2bands scoreonly seed smallonly stringent sub sums
tfile thresh time toponly treeforce wgiven wgsc wnone);

our %INFERNAL_PROGRAM = (
    cmalign =>  [qw(h l q informat nosmall regress full tfile banddump dlev
                time inside outside post checkpost sub fsub elsilent hbanded
                hbandp sums checkcp9 qdb beta noexpand W), # pre-0.81
                qw(zeroinserts enfstart enfseq tau hsafe hmmonly withali
                rf gapthresh)], # added in 0.81
    
    cmbuild =>  [qw(h n A F binary rf gapthresh informat bandp elself nodetach
                wgiven wnone wgsc effent etarget effnone cfile cmtbl emap gtree
                gtbl tfile bfile local bdfile nobalance regress treeforce
                ignorant dlev null priorfile), # pre-0.81
                qw(beta window rsearch rsw ctarget cmindiff call corig cdump)], # added in 0.81
    
    cmscore  => [qw(h informat local regress scoreonly smallonly stringent qdb
                beta), # pre-0.81
                qw(i sub trees std qdbsmall qdbboth hbanded tau hsafe hmmonly
                betas betae taus taue)], # added in 0.81
    
    cmsearch => [qw(h W informat toponly local noalign dumptrees thresh X inside
                null2 learninserts hmmfb hmmweinberg hmmpad hmmonly hthresh beta
                noqdb qdbfile hbanded hbandp banddump sums scan2bands), # pre-0.81
                qw(T E window nsamples partition negsc enfstart enfseq enfnohmm
                time rtrans greedy gcfile hmmfilter hmmE hmmT hmmnegsc)], # added in 0.81
    
    cmemit   => [qw(a c h n q seed full begin end cp9)], # up to 0.81
    );

our %INFERNAL_SWITCHES = map {$_ => 1} (qw(h l a A F c q X banddump binary
    checkcp9 checkpost cp9 dumptrees effent effnone elsilent fsub full hbanded
    hmmfb hmmonly hmmweinberg ignorant inside learninserts local noalign
    nobalance nodetach noexpand noqdb nosmall null2 outside post qdb rf
    scan2bands scoreonly smallonly stringent sub sums time toponly treeforce
    wgiven wgsc wnone),
    # new in 0.81
    qw(zeroinserts hsafe hmmonly rf),
    qw(i sub trees std qdbsmall qdbboth hbanded hsafe hmmonly),
    qw(enfnohmm time rtrans greedy hmmfilter),
    qw(rsw call corig),
    );

our %INFERNAL_DOUBLE = map {$_ => 1} (qw(X banddump bandp bdfile begin beta bfile
    binary cfile checkcp9 checkpost cmtbl cp9 dlev dumptrees effent effnone
    elself elsilent emap end etarget fsub full gapthresh gtbl gtree hbanded
    hbandp hmmfb hmmonly hmmpad hmmweinberg hthresh ignorant informat inside
    learninserts local noalign nobalance nodetach noexpand noqdb nosmall null
    null2 outside post priorfile qdb qdbfile regress rf scan2bands scoreonly
    seed smallonly stringent sub sums tfile thresh time toponly treeforce wgiven
    wgsc wnone),
    # new in 0.81
    qw(enfstart enfseq tau withali gapthresh),
    qw(tau betas betae taus taue),
    qw(T E window nsamples partition negsc enfstart enfseq hmmE hmmT hmmnegsc),
    qw(beta window rsearch ctarget cmindiff cdump),
);

=head2 new

 Title   : new
 Usage   : my $wrapper = Bio::Tools::Run::Infernal->new(@params)
 Function: creates a new Infernal factory
 Returns:  Bio::Tools::Run::Infernal wrapper
 Args    : list of parameters

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($program, $model, $out, $tf) =
        $self->_rearrange([qw(PROGRAM
                            MODEL
                            OUTFILE_NAME 
                            TEMPFILE)], @args);
    $self->throw("Program '$program' not supported") if $program &&
        !exists $INFERNAL_PROGRAM{$program};
    $program ||='';
    $self->io->_initialize_io();
    # defining outfile specifically overrides the tempfile flag
    # all programs but cmbuild  : outfile is optional (default to STDOUT)
    if (($tf && !$out) || ($program eq 'cmbuild' && !$out)) {
        my ($tfh, $outfile) = $self->io->tempfile(-dir=> $self->io->tempdir());
        close($tfh);
        undef $tfh;
        $self->outfile_name($outfile);
    } else {
        $out ||= '';
        $self->outfile_name($out);
    }
    $tf        && $self->tempfile($tf);
    $program   && $self->program($program);
    $model     && $self->model($model);
    $self->_set_from_args(\@args,
            -methods => [@PARAMS],
            -create => 1
           );
    return $self;
}

=head2 program

 Title   :  program
 Usage   :  $obj->program()
 Function:  Set the program called when run() is used.  Synonym of
            program_name()
 Returns :  String (program name)
 Args    :  String (program name)

=cut

sub program {
    my $self = shift;
    if (@_) {
        $self->{'_program'} = shift @_;
        $self->executable( $self->{'_program'} );
    }
    return $self->{'_program'};
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

=head2 model

 Title   :  model
 Usage   :  $obj->model()
 Function:  Set the model used when run() is called.
 Returns :  String (file location of covariance model)
 Args    :  String (file location of covariance model)

=cut

sub model {
    my $self = shift;
    return $self->{'_model'} = shift if @_;
    return $self->{'_model'};
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{INFERNALDIR}) if $ENV{INFERNALDIR};
}

=head2  version

 Title   : version
 Usage   : $v = $prog->version();
 Function: Determine the version number of the program (uses cmsearch)
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    return unless $self->executable;
    my $string = `cmsearch -h 2>&1`;
    my $v;
    if ($string =~ m{Infernal\s([\d.]+)}) {
        $v = $1;
    }
    return $self->{'_progversion'} = $v || undef;
}

=head2 run

 Title   :   run
 Usage   :   $obj->run($seqFile)
 Function:   Runs Infernal and returns Bio::SearchIO
 Returns :   A Bio::SearchIO
 Args    :   A Bio::PrimarySeqI or file name

=cut

sub run {
    my ($self,@seq) = @_;
    # will need to add _writeAlignFile for alignment data
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } elsif  (ref $seq[0] && $seq[0]->isa("Bio::Align::AlignI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head1 Specific program interface methods

=head2 cmsearch

 Title   :   cmsearch
 Usage   :   $obj->cmsearch($seqFile)
 Function:   Runs Infernal cmsearch and returns Bio::SearchIO
 Returns :   A Bio::SearchIO
 Args    :   Bio::PrimarySeqI or file name

=cut

sub cmsearch {
    my ($self,@seq) = @_;
    $self->program('cmsearch');
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head2 cmalign

 Title   :   cmalign
 Usage   :   $obj->cmalign($seqFile)
 Function:   Runs Infernal cmalign and returns Bio::AlignIO
 Returns :   A Bio::AlignIO
 Args    :   Bio::PrimarySeqI or file name

=cut

sub cmalign {
    my ($self,@seq) = @_;
    $self->program('cmalign');
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head2 cmemit

 Title   :   cmemit
 Usage   :   $obj->cmemit($modelfile)
 Function:   Runs Infernal cmemit and returns Bio::AlignIO
 Returns :   A Bio::AlignIO
 Args    :   [optional] File name containing covariance model
             (will use model() if not passed)

=cut

sub cmemit {
    my ($self,@seq) = @_;
    $self->program('cmemit');
    if  (ref $seq[0]){# it is an object
        $self->throw("Arg must be covariance model file name");
    } else {
        return  $self->_run(@seq);
    }
}

=head2 cmbuild

 Title   :   cmbuild
 Usage   :   $obj->cmbuild($alignment)
 Function:   Runs Infernal cmbuild and saves covariance model
 Returns :   1 on success (no object for covariance models)
 Args    :   Bio::AlignIO with structural information (such as from Stockholm
             format source) or alignment file

=cut

sub cmbuild {
    my ($self,@seq) = @_;
    $self->program('cmbuild');
    if  (ref $seq[0] && $seq[0]->isa("Bio::Align::AlignI") ){# it is an object
        my $infile1 = $self->_writeAlignFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head2 cmscore

 Title   :   cmscore
 Usage   :   $obj->cmscore($seq)
 Function:   Runs Infernal cmscore and saves output
 Returns :   None
 Args    :   Bio::PrimarySeqI or file

=cut

sub cmscore {
    my ($self,@seq) = @_;
    $self->program('cmscore');
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
 Returns :   
 Args    :

=cut

sub _run {
    my ($self,$file)= @_;
    my ($prog, $model, $out, $version) = ($self->program,
                                          $self->model,
                                          $self->outfile_name,
                                          $self->version);
    # a model and a file must be defined for all but cmemit; cmemit must have a
    # file or model defined (using $file if both are defined)
    if ($prog eq 'cmemit' && (!$file && !$model) ) {
        $self->throw("Must supply file/Bio::PrimarySeqI/Bio::AlignI or a model");
    } elsif (!$file && !$model) {
        $self->throw("Must supply file/Bio::PrimarySeqI/Bio::AlignI and a model");
    }
    $file ||= '';
    # for cmsearch, cmscore, cmalign, cmbuild, $file should point to a sequence or alignment file
    # for cmemit, the file is technically optional (falls back to using the model() if set)
    # format : cmsearch [-options] <cmfile> <sequence file>
    #          cmbuild [-options] <cmfile output> <alignment file>
    #          cmalign [-options] <cmfile> <sequence file>
    #          cmscore [-options] <cmfile> <sequence file>
    #          cmemit  [-options] <cmfile>
    # the output file (if set) : cmalign, cmemit : added in _setparams (-o option)
    #                            cmscore, cmsearch, cmbuild: redirect STDOUT to file
    my $str = $self->executable;
    my $param_str = $self->_setparams;
    $str .= $param_str ? " $param_str $model $file" : " $model $file";
    if ($out && ($prog ne 'cmalign' || $prog ne 'cmemit')) {
        $str .= " > $out";
    }
    $self->debug("Infernal command: $str\n");
    # cmsearch returns SearchIO
    # cmbuild does not return anything (outfile = STDOUT, cmfile is written to model() )
    # cmscore does not return anything (outfile = STDOUT or outfile/tempfile)
    # cmemit - AlignIO or SeqIO (based on parameter settings)
    # cmalign - AlignIO
    my $obj =
        ($prog eq 'cmsearch') ? Bio::SearchIO->new(-format => 'infernal',
                                                -database => $file,
                                                -version => $version,
                                                -model => $model) :
        ($prog eq 'cmalign' ) ? Bio::AlignIO->new(-format => 'stockholm') :
        ($prog eq 'cmemit' && $self->a) ? Bio::AlignIO->new(-format => 'stockholm') :
        ($prog eq 'cmemit') ? Bio::SeqIO->new(-format => 'fasta') :
              undef;
    # outfile or tempfile-based
    
    # only supports cmsearch for now, adding support for the others very soon...
    #return 1 unless $prog eq 'cmsearch' || $prog eq 'cmalign';
    my @args;
    # file output
    if ($out) {
        local $SIG{CHLD} = 'DEFAULT';
        my $status = system($str);
        if($status || !-e $out || -z $out ) {
            my $error = ($!) ? "$! Status: $status" : "Status: $status";
            $self->throw( "Infernal call crashed: $error \n[command $str]\n");
            return undef;
        }
        if ($obj && ref($obj)) {
            $obj->file($out);
            @args = (-file => $out);
        }
    # fh-based (no outfile)
    } else {
        open(my $fh,"$str |") || $self->throw("Infernal call ($str) crashed: $?\n");
        if ($obj && ref($obj)) {
            $obj->fh($fh);
            @args = (-fh => $fh);
        } else {
            # dump to debugging
            my $io;
            while(<$fh>) {$io .= $_;}
            close($fh);
            $self->debug($io);
            return 1;
        }
    }
    $obj->_initialize_io(@args) if $obj && ref($obj);
    return $obj || 1;
}

=head2 _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly
 Function:  creates a string of params to be used in the command string
 Example :
 Returns :  string of params
 Args    :  

=cut

# this only sets parameters which legitimately can be used for a program (listed
# in $INFERNAL_PROGRAM)

sub _setparams {
    my ($self) = @_;
    my $param_string;
    my ($program, $model, $outfile) = ($self->program,
                                       $self->model,
                                       $self->outfile_name);
    $self->throw("No valid program defined!")
        if !$program || !exists $INFERNAL_PROGRAM{$program};
        
    # verbosity of cmemit must be turned off to get data into Bio* objects
    $self->q(1) if $program eq 'cmemit' || $program eq 'cmalign';
    
    my @valid_params = @{ $INFERNAL_PROGRAM{$program} };
    my @params;
    foreach my $attr (@valid_params) {
        my $value = ($self->can($attr)) ? $self->$attr() : undef;
        next unless (defined $value);
        my $attr_key = (exists $INFERNAL_DOUBLE{$attr}) ? '--'.$attr : '-'.$attr;
        if (exists $INFERNAL_SWITCHES{$attr}) {
            push @params, $attr_key;
        } else {
            push @params, ($attr_key, $value);
        }
    }
    # output to optional outfile
    if (($program eq 'cmemit' || $program eq 'cmalign') && $outfile) {
        push @params, ('-o', $outfile);
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
                '-format' => 'stockholm');
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
