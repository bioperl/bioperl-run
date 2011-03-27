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
#
# July  2009 - updated for v1.0. No longer supporting pre-1.0 Infernal

=head1 NAME

Bio::Tools::Run::Infernal - Wrapper for local execution of cmalign, cmbuild,
cmsearch, cmscore

=head1 SYNOPSIS

  # parameters which are switches are set with any value that evals TRUE,
  # others are set to a specific value

  my $factory = Bio::Tools::Run::Infernal->new(@params);

  # run cmalign|cmbuild|cmsearch|cmscore|cmemit directly as a wrapper method
  # this resets the program flag if previously set

  $factory->cmsearch(@seqs); # searches Bio::PrimarySeqI's based on set cov. model
                             # saves output to optional outfile_name, returns
                             # Bio::SearchIO

  # only values which are allowed for a program are set, so one can use the same
  # wrapper for the following...

  $factory->cmalign(@seqs); # aligns Bio::PrimarySeqI's to a set cov. model,
                            # --merge option allows two alignments generated
                            #     from the same CM to be merged.
                            # output to outfile_name, returns Bio::AlignIO
  $factory->cmscore();      # scores set cov. model against Bio::PrimarySeqI,
                            # output to outfile_name/STDOUT.
  $factory->cmbuild($aln); # builds covariance model based on alignment
                           # CM to outfile_name or model_file (one is required
                           # here), output to STDOUT.
  $factory->cmemit();      # emits sequence from specified cov. model;
                           # set one if no file specified. output to
                           # outfile_name, returns Bio::SeqIO or (if -a is set)
                           # Bio::AlignIO
  $factory->cmcalibrate($file); # calibrates specified cov. model; output to
                                # STDOUT
  $factory->cmstat($file); # summary stats for cov. model; set one if no file
                           # specified; output to STDOUT

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
implementation runs cmsearch, cmcalibrate, cmalign, cmemit, cmbuild, cmscore,
and cmstat. cmsearch will return a Bio::SearchIO, cmemit a Bio::SeqIO/AlignIO,
and cmalign a Bio::AlignIO.  All others send output to STDOUT.  Optionally,
any program's output can be redirected to outfile_name.

We HIGHLY suggest upgrading to Infernal 1.0.  In that spirit, this wrapper now
supports parameters for Infernal 1.0 only; for wrapping older versions of
Infernal we suggest using the version of Bio::Tools::Run::Infernal that came
with previous versions of BioPerl-run.

NOTE: Due to conflicts in the way Infernal parameters are now formatted vs.
subroutine naming in Perl (specifically the inclusion of hyphens) and due to the
very large number of parameters available, setting and resetting parameters via
set_parameters() and reset_parameters() is required. All valid parameters can
be set, but only ones valid for the executable set via program()/program_name()
are used for calling the executables, the others are silently ignored.

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
use warnings;
use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase Bio::ParameterBaseI);

use Bio::SeqIO;
use Bio::SearchIO;
use Bio::AlignIO;
use Data::Dumper;

# yes, these are the current parameters
our %INFERNAL_PARAMS = (
  'A'               => ['switch', '-',      qw(cmbuild)],
  'E'               => ['param',  '-',      qw(cmsearch cmstat)],
  'F'               => ['switch', '-',      qw(cmbuild)],
  'Lmax'            => ['param',  '--',     qw(cmscore)],
  'Lmin'            => ['param',  '--',     qw(cmscore)],
  'T'               => ['param',  '-',      qw(cmsearch cmstat)],
  'Wbeta'           => ['param',  '--',     qw(cmbuild)],
  'Z'               => ['param',  '-',      qw(cmsearch cmstat)],
  'a'               => ['switch', '-',      qw(cmbuild cmemit cmscore)],
  'afile'           => ['param',  '--',     qw(cmstat)],
  'ahmm'            => ['param',  '--',     qw(cmemit)],
  'all'             => ['switch', '--',     qw(cmstat)],
  'aln-hbanded'     => ['switch', '--',     qw(cmsearch)],
  'aln-optacc'      => ['switch', '--',     qw(cmsearch)],
  'aln2bands'       => ['switch', '--',     qw(cmscore cmsearch)],
  'banddump'        => ['param',  '--',     qw(cmalign)],
  'begin'           => ['param',  '--',     qw(cmemit)],
  'beta'            => ['param',  '--',     qw(cmalign cmscore cmsearch cmstat)],
  'betae'           => ['param',  '--',     qw(cmscore)],
  'betas'           => ['param',  '--',     qw(cmscore)],
  'bfile'           => ['param',  '--',     qw(cmstat)],
  'binary'          => ['switch', '--',     qw(cmbuild)],
  'bits'            => ['switch', '--',     qw(cmstat)],
  'bottomonly'      => ['switch', '--',     qw(cmsearch)],
  'c'               => ['switch', '-',      qw(cmemit)],
  'call'            => ['switch', '--',     qw(cmbuild)],
  'cdump'           => ['param',  '--',     qw(cmbuild)],
  'cfile'           => ['param',  '--',     qw(cmbuild)],
  'checkfb'         => ['switch', '--',     qw(cmalign)],
  'checkpost'       => ['switch', '--',     qw(cmalign)],
  'cmL'             => ['param',  '--',     qw(cmstat)],
  'cmaxid'          => ['param',  '--',     qw(cmbuild)],
  'cmtbl'           => ['param',  '--',     qw(cmbuild)],
  'corig'           => ['switch', '--',     qw(cmbuild)],
  'ctarget'         => ['param',  '--',     qw(cmbuild)],
  'cyk'             => ['switch', '--',     qw(cmalign cmbuild cmsearch)],
  'devhelp'         => ['switch', '--',     qw(cmalign cmbuild cmcalibrate cmemit cmscore cmsearch)],
  'dlev'            => ['param',  '--',     qw(cmalign)],
  'dna'             => ['switch', '--',     qw(cmalign cmemit cmsearch)],
  'eX'              => ['param',  '--',     qw(cmbuild)],
  'eent'            => ['switch', '--',     qw(cmbuild)],
  'efile'           => ['param',  '--',     qw(cmstat)],
  'ehmmre'          => ['param',  '--',     qw(cmbuild)],
  'elself'          => ['param',  '--',     qw(cmbuild)],
  'emap'            => ['param',  '--',     qw(cmbuild)],
  'emit'            => ['switch', '--',     qw(cmscore)],
  'end'             => ['param',  '--',     qw(cmemit)],
  'enone'           => ['switch', '--',     qw(cmbuild)],
  'ere'             => ['param',  '--',     qw(cmbuild)],
  'exp'             => ['param',  '--',     qw(cmemit)],
  'exp-T'           => ['param',  '--',     qw(cmcalibrate)],
  'exp-beta'        => ['param',  '--',     qw(cmcalibrate)],
  'exp-cmL-glc'     => ['param',  '--',     qw(cmcalibrate)],
  'exp-cmL-loc'     => ['param',  '--',     qw(cmcalibrate)],
  'exp-ffile'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-fract'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-gc'          => ['param',  '--',     qw(cmcalibrate)],
  'exp-hfile'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-hmmLn-glc'   => ['param',  '--',     qw(cmcalibrate)],
  'exp-hmmLn-loc'   => ['param',  '--',     qw(cmcalibrate)],
  'exp-hmmLx'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-no-qdb'      => ['switch', '--',     qw(cmcalibrate)],
  'exp-pfile'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-qqfile'      => ['param',  '--',     qw(cmcalibrate)],
  'exp-random'      => ['switch', '--',     qw(cmcalibrate)],
  'exp-sfile'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-tailn-cglc'  => ['param',  '--',     qw(cmcalibrate)],
  'exp-tailn-cloc'  => ['param',  '--',     qw(cmcalibrate)],
  'exp-tailn-hglc'  => ['param',  '--',     qw(cmcalibrate)],
  'exp-tailn-hloc'  => ['param',  '--',     qw(cmcalibrate)],
  'exp-tailp'       => ['param',  '--',     qw(cmcalibrate)],
  'exp-tailxn'      => ['param',  '--',     qw(cmcalibrate)],
  'fil-E-hmm'       => ['param',  '--',     qw(cmsearch)],
  'fil-E-qdb'       => ['param',  '--',     qw(cmsearch)],
  'fil-F'           => ['param',  '--',     qw(cmcalibrate)],
  'fil-N'           => ['param',  '--',     qw(cmcalibrate)],
  'fil-Smax-hmm'    => ['param',  '--',     qw(cmsearch)],
  'fil-T-hmm'       => ['param',  '--',     qw(cmsearch)],
  'fil-T-qdb'       => ['param',  '--',     qw(cmsearch)],
  'fil-aln2bands'   => ['switch', '--',     qw(cmcalibrate)],
  'fil-beta'        => ['param',  '--',     qw(cmsearch)],
  'fil-dfile'       => ['param',  '--',     qw(cmcalibrate)],
  'fil-gemit'       => ['switch', '--',     qw(cmcalibrate)],
  'fil-no-hmm'      => ['switch', '--',     qw(cmsearch)],
  'fil-no-qdb'      => ['switch', '--',     qw(cmsearch)],
  'fil-nonbanded'   => ['switch', '--',     qw(cmcalibrate)],
  'fil-tau'         => ['param',  '--',     qw(cmcalibrate)],
  'fil-xhmm'        => ['param',  '--',     qw(cmcalibrate)],
  'fins'            => ['switch', '--',     qw(cmalign cmbuild)],
  'forecast'        => ['param',  '--',     qw(cmcalibrate cmsearch)],
  'forward'         => ['switch', '--',     qw(cmscore cmsearch)],
  'g'               => ['switch', '-',      qw(cmsearch cmstat)],
  'ga'              => ['switch', '--',     qw(cmsearch cmstat)],
  'gapthresh'       => ['param',  '--',     qw(cmalign cmbuild)],
  'gcfile'          => ['param',  '--',     qw(cmsearch)],
  'ge'              => ['switch', '--',     qw(cmstat)],
  'gfc'             => ['switch', '--',     qw(cmstat)],
  'gfi'             => ['switch', '--',     qw(cmstat)],
  'gibbs'           => ['switch', '--',     qw(cmbuild)],
  'gtbl'            => ['param',  '--',     qw(cmbuild)],
  'gtree'           => ['param',  '--',     qw(cmbuild)],
  'h'               => ['switch', '-',      qw(cmalign cmbuild cmcalibrate cmemit cmscore cmsearch cmstat)],
  'hbanded'         => ['switch', '--',     qw(cmalign cmscore cmsearch)],
  'hmm-W'           => ['param',  '--',     qw(cmsearch)],
  'hmm-cW'          => ['param',  '--',     qw(cmsearch)],
  'hmmL'            => ['param',  '--',     qw(cmstat)],
  'hsafe'           => ['switch', '--',     qw(cmalign cmscore)],
  'ignorant'        => ['switch', '--',     qw(cmbuild)],
  'iins'            => ['switch', '--',     qw(cmbuild)],
  'infile'          => ['param',  '--',     qw(cmscore)],
  'informat'        => ['param',  '--',     qw(cmalign cmbuild cmsearch)],
  'inside'          => ['switch', '--',     qw(cmalign cmscore cmsearch)],
  'l'               => ['switch', '-',      qw(cmalign cmbuild cmemit cmscore)],
  'lambda'          => ['param',  '--',     qw(cmsearch)],
  'le'              => ['switch', '--',     qw(cmstat)],
  'lfc'             => ['switch', '--',     qw(cmstat)],
  'lfi'             => ['switch', '--',     qw(cmstat)],
  'm'               => ['switch', '-',      qw(cmstat)],
  'matchonly'       => ['switch', '--',     qw(cmalign)],
  'merge'           => ['switch', '--',     qw(cmalign)],
  'mpi'             => ['switch', '--',     qw(cmalign cmcalibrate cmscore cmsearch)],
  'mxsize'          => ['param',  '--',     qw(cmalign cmbuild cmcalibrate cmscore cmsearch)],
  'n'               => ['param',  '-',      qw(cmbuild cmemit cmscore)],
  'nc'              => ['switch', '--',     qw(cmsearch cmstat)],
  'no-null3'        => ['switch', '--',     qw(cmalign cmcalibrate cmscore cmsearch)],
  'no-qdb'          => ['switch', '--',     qw(cmsearch)],
  'noalign'         => ['switch', '--',     qw(cmsearch)],
  'nobalance'       => ['switch', '--',     qw(cmbuild)],
  'nodetach'        => ['switch', '--',     qw(cmbuild)],
  'nonbanded'       => ['switch', '--',     qw(cmalign cmbuild cmscore)],
  'null'            => ['param',  '--',     qw(cmbuild)],
  'null2'           => ['switch', '--',     qw(cmsearch)],
  'o'               => ['param',  '-',      qw(cmalign cmsearch)],
  'old'             => ['switch', '--',     qw(cmscore)],
  'onepost'         => ['switch', '--',     qw(cmalign)],
  'optacc'          => ['switch', '--',     qw(cmalign)],
  'outfile'         => ['param',  '--',     qw(cmscore)],
  'p'               => ['switch', '-',      qw(cmalign cmsearch)],
  'pad'             => ['switch', '--',     qw(cmscore)],
  'pbegin'          => ['param',  '--',     qw(cmalign cmcalibrate cmemit cmscore cmsearch)],
  'pbswitch'        => ['param',  '--',     qw(cmbuild)],
  'pebegin'         => ['switch', '--',     qw(cmalign cmcalibrate cmemit cmscore cmsearch)],
  'pend'            => ['param',  '--',     qw(cmalign cmcalibrate cmemit cmscore cmsearch)],
  'pfend'           => ['param',  '--',     qw(cmalign cmcalibrate cmemit cmscore cmsearch)],
  'prior'           => ['param',  '--',     qw(cmbuild)],
  'q'               => ['switch', '-',      qw(cmalign)],
  'qdb'             => ['switch', '--',     qw(cmalign cmscore)],
  'qdbboth'         => ['switch', '--',     qw(cmscore)],
  'qdbfile'         => ['param',  '--',     qw(cmstat)],
  'qdbsmall'        => ['switch', '--',     qw(cmscore)],
  'random'          => ['switch', '--',     qw(cmscore)],
  'rdump'           => ['param',  '--',     qw(cmbuild)],
  'refine'          => ['param',  '--',     qw(cmbuild)],
  'regress'         => ['param',  '--',     qw(cmalign cmbuild cmscore)],
  'resonly'         => ['switch', '--',     qw(cmalign)],
  'rf'              => ['switch', '--',     qw(cmalign cmbuild)],
  'rna'             => ['switch', '--',     qw(cmalign cmemit cmsearch)],
  'rsearch'         => ['param',  '--',     qw(cmbuild)],
  'rtrans'          => ['switch', '--',     qw(cmsearch)],
  's'               => ['param',  '-',      qw(cmalign cmbuild cmcalibrate cmemit cmscore)],
  'sample'          => ['switch', '--',     qw(cmalign)],
  'scoreonly'       => ['switch', '--',     qw(cmscore)],
  'search'          => ['switch', '--',     qw(cmscore cmstat)],
  'seqfile'         => ['param',  '--',     qw(cmstat)],
  'sfile'           => ['param',  '--',     qw(cmstat)],
  'shmm'            => ['param',  '--',     qw(cmemit)],
  'small'           => ['switch', '--',     qw(cmalign)],
  'stall'           => ['switch', '--',     qw(cmalign cmscore cmsearch)],
  'sub'             => ['switch', '--',     qw(cmalign cmbuild cmscore)],
  'sums'            => ['switch', '--',     qw(cmalign cmsearch)],
  'tabfile'         => ['param',  '--',     qw(cmsearch)],
  'tau'             => ['param',  '--',     qw(cmalign cmbuild cmscore cmsearch)],
  'taue'            => ['param',  '--',     qw(cmscore)],
  'taus'            => ['param',  '--',     qw(cmscore)],
  'tc'              => ['switch', '--',     qw(cmsearch cmstat)],
  'tfile'           => ['param',  '--',     qw(cmalign cmbuild cmemit cmscore)],
  'toponly'         => ['switch', '--',     qw(cmsearch cmstat)],
  'u'               => ['switch', '-',      qw(cmemit)],
  'v'               => ['switch', '-',      qw(cmbuild cmcalibrate)],
  'viterbi'         => ['switch', '--',     qw(cmalign cmscore cmsearch)],
  'wblosum'         => ['switch', '--',     qw(cmbuild)],
  'wgiven'          => ['switch', '--',     qw(cmbuild)],
  'wgsc'            => ['switch', '--',     qw(cmbuild)],
  'wid'             => ['param',  '--',     qw(cmbuild)],
  'withali'         => ['param',  '--',     qw(cmalign)],
  'withpknots'      => ['switch', '--',     qw(cmalign)],
  'wnone'           => ['switch', '--',     qw(cmbuild)],
  'wpb'             => ['switch', '--',     qw(cmbuild)],
  'x'               => ['switch', '-',      qw(cmsearch)],
  'xfile'           => ['param',  '--',     qw(cmstat)],
);

our %INFERNAL_PROGRAM = (
  'cmalign'         => "cmalign [-options] <cmfile> <sequence file>\n".
                       'cmalign [-options] --merge <cmfile> <msafile1> <msafile2>',
  'cmbuild'         => 'cmbuild [-options] <cmfile output> <alignment file>',
  'cmcalibrate'     => 'cmcalibrate [-options] <cmfile>',
  'cmemit'          => 'cmemit [-options] <cmfile> <sequence output file>',
  'cmscore'         => 'cmscore [-options] <cmfile>',
  'cmsearch'        => 'cmsearch [-options] <cmfile> <sequence file>',
  'cmstat'          => 'cmstat [-options] <cmfile>',
);

# this is a simple lookup for easy validation for passed methods
our %LOCAL_PARAMS = map {$_ => 1} qw(program outfile tempfile model);

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
    
    # these are specific parameters we do not want passed on to set_parameters
    my ($program, $model, $validate, $q, $o1, $o2) =
        $self->_rearrange([qw(PROGRAM
                           MODEL_FILE
                           VALIDATE_PARAMETERS
                           QUIET
                           OUTFILE_NAME
                           O)], @args);
    
    if ($o1 && $o2) {
        $self->warn("Only assign to either -outfile_name or -o, not both;");
    }
    my $out = $o1 || $o2;
    $self->validate_parameters($validate);
    $q          && $self->quiet($q);
    $program    && $self->program($program);
    $model      && $self->model_file($model);
    $out ||= '';
    $self->outfile_name($out);
    $self->io->_initialize_io();    
    $self->set_parameters(@args);
    return $self;
}

=head2 program

 Title   :  program
 Usage   :  $obj->program()
 Function:  Set the program called when run() is used.  Synonym of
            program_name()
 Returns :  String (program name)
 Args    :  String (program name)
 Status  :  Unstable (may delegate to program_name, which is the interface method)

=cut

sub program {
    my $self = shift;
    return $self->program_name(@_);
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
    if (@_) {
        my $p = shift;
        $self->throw("Program '$p' not supported")
            if !exists $INFERNAL_PROGRAM{lc $p};
        $self->{'_program'} = lc $p;
        # set up cache of valid parameters
        while (my ($p, $data) = each %INFERNAL_PARAMS) {
            my %in_exe = map {$_ => 1} @$data[2..$#{$data}];
            $self->{valid_params}->{$p} = 1 if exists $in_exe{$self->{'_program'}};
        }
    }
    return $self->{'_program'};    
}

=head2 model_file

 Title   :  model_file
 Usage   :  $obj->model_file()
 Function:  Set the model file used when run() is called.
 Returns :  String (file location of covariance model)
 Args    :  String (file location of covariance model)

=cut

sub model_file {
    my $self = shift;
    return $self->{'_model_file'} = shift if @_;
    return $self->{'_model_file'};
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    my ($self, $dir) = @_;
    if ($dir) {
        $self->{_program_dir} = $dir;
    }
    return Bio::Root::IO->catfile($ENV{INFERNALDIR}) || '';
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
    my $exe = $self->executable;
    my $string = `$exe -h 2>&1`;
    my $v;
    if ($string =~ m{Infernal\s([\d.]+)}) {
        $v = $1;
        $self->deprecated(-message => "Only Infernal 1.0 and above is supported.",
                          -version => 1.006001) if $v < 1;
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

# TODO: update to accept multiple seqs, alignments
sub run {
    my ($self,@seq) = @_;
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return $self->_run($infile1);
    } elsif (ref $seq[0] && $seq[0]->isa("Bio::Align::AlignI") ){ # it is an object
        my $infile1 = $self->_writeAlignFile(@seq);
        return $self->_run($infile1);
    } else {
        return $self->_run(@seq);
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
        return  $self->_run(-seq_files => [$infile1]);
    } else {
        return  $self->_run(-seq_files => \@seq);
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
    if (ref $seq[0]) { # it is an object
        if ($seq[0]->isa("Bio::PrimarySeqI") ){
            my $infile1 = $self->_writeSeqFile(@seq);
            return  $self->_run(-seq_files => [$infile1]);
        } elsif ( $seq[0]->isa("Bio::Align::AlignI") ) {
            if (scalar(@seq) != 2) {
                $self->throw("")
            }
            my $infile1 = $self->_writeAlignFile($seq[0]);
            my $infile2 = $self->_writeAlignFile($seq[1]);
            return  $self->_run(-align_files => [$infile1, $infile2]);
        }
    } else {
        # we can maybe add a check for the file extension and try to DTRT
        my %params = $self->get_parameters('valid');
        $params{merge} ? return $self->_run(-align_files => \@seq):
            return $self->_run(-seq_files => \@seq);
        return $self->_run(-seq_files => \@seq);
    }
}

=head2 cmemit

 Title   :   cmemit
 Usage   :   $obj->cmemit($modelfile)
 Function:   Runs Infernal cmemit and returns Bio::AlignIO
 Returns :   A Bio::AlignIO
 Args    :   None; set model_file() to use a specific model

=cut

sub cmemit {
    my ($self) = shift;
    $self->program('cmemit');
    return $self->_run(@_);
}

=head2 cmbuild

 Title   :   cmbuild
 Usage   :   $obj->cmbuild($alignment)
 Function:   Runs Infernal cmbuild and saves covariance model
 Returns :   1 on success (no object for covariance models)
 Args    :   Bio::AlignIO with structural information (such as from Stockholm
             format source) or alignment file name

=cut

sub cmbuild {
    my ($self,@seq) = @_;
    $self->program('cmbuild');
    if  (ref $seq[0] && $seq[0]->isa("Bio::Align::AlignI") ){# it is an object
        my $infile1 = $self->_writeAlignFile(@seq);
        return  $self->_run(-align_files => [$infile1]);
    } else {
        return  $self->_run(-align_files => \@seq);
    }
}

=head2 cmscore

 Title   :   cmscore
 Usage   :   $obj->cmscore($seq)
 Function:   Runs Infernal cmscore and saves output
 Returns :   None
 Args    :   None; set model_file() to use a specific model

=cut

sub cmscore {
    my ($self,@seq) = @_;
    $self->program('cmscore');
    return  $self->_run();
}

=head2 cmcalibrate

 Title   :   cmcalibrate
 Usage   :   $obj->cmcalibrate('file')
 Function:   Runs Infernal calibrate on specified CM
 Returns :   None
 Args    :   None; set model_file() to use a specific model

=cut

sub cmcalibrate {
    my ($self,@seq) = @_;
    $self->program('cmcalibrate');
    return  $self->_run();
}

=head2 cmstat

 Title   :   cmstat
 Usage   :   $obj->cmstat($seq)
 Function:   Runs Infernal cmstat and saves output
 Returns :   None
 Args    :   None; set model_file() to use a specific model

=cut

sub cmstat {
    my ($self,@seq) = @_;
    $self->program('cmstat');
    return  $self->_run();
}

=head1 Bio::ParameterBaseI-specific methods

These methods are part of the Bio::ParameterBaseI interface

=cut

=head2 set_parameters

 Title   : set_parameters
 Usage   : $pobj->set_parameters(%params);
 Function: sets the parameters listed in the hash or array
 Returns : None
 Args    : [optional] hash or array of parameter/values.  These can optionally
           be hash or array references
 Note    : This only sets parameters; to set methods use the method name
=cut

sub set_parameters {
    my $self = shift;
    # circumvent any issues arising from passing in refs
    my %args = (ref($_[0]) eq 'HASH')  ? %{$_[0]} :
               (ref($_[0]) eq 'ARRAY') ? @{$_[0]} :
               @_;
    # set the parameters passed in, but only ones supported for the program
    my ($prog, $validate) = ($self->program, $self->validate_parameters);

    # parameter cleanup
    %args = map { my $a = $_;
              $a =~ s{^-}{};
              lc $a => $args{$_}
                 } sort keys %args;
    
    while (my ($key, $val) = each %args) {
        if (exists $INFERNAL_PARAMS{$key}) {
            my ($type, $prefix) = @{$INFERNAL_PARAMS{$key}}[0..1];
            @{$self->{parameters}->{$key}} = ($type, $prefix);
            unshift @{$self->{parameters}->{$key}}, 
                $type eq 'param'          ? $val :
                $type eq 'switch' && $val ? 1 : 0;
            if ($validate) {
                my %in_exe = map {$_ => 1} @{$INFERNAL_PARAMS{$key}}[2..$#{$INFERNAL_PARAMS{$key}}];
                $self->warn("Parameter $key not used for $prog") if !exists $in_exe{$key};
            }
        } else {
            $self->warn("Parameter $key does not exist") if ($validate);
        }
    }
}

=head2 reset_parameters

 Title   : reset_parameters
 Usage   : resets values
 Function: resets parameters to either undef or value in passed hash
 Returns : none
 Args    : [optional] hash of parameter-value pairs

=cut

sub reset_parameters {
    my $self = shift;
    delete $self->{parameters};
    if (@_) {
        $self->set_parameters(@_);
    }
}

=head2 validate_parameters

 Title   : validate_parameters
 Usage   : $pobj->validate_parameters(1);
 Function: sets a flag indicating whether to validate parameters via
           set_parameters() or reset_parameters()
 Returns : Bool
 Args    : [optional] value evaluating to True/False
 Note    : Optionally implemented method; up to the implementation on whether
           to automatically validate parameters or optionally do so

=cut

sub validate_parameters {
    my ($self) = shift;
    if (@_) {
        $self->{validate_params} = defined $_[0] ? 1 : 0;
    }
    return $self->{validate_params};
}

=head2 parameters_changed

 Title   : parameters_changed
 Usage   : if ($pobj->parameters_changed) {...}
 Function: Returns boolean true (1) if parameters have changed
 Returns : Boolean (0 or 1)
 Args    : None
 Note    : This module does not run state checks, so this always returns True

=cut

sub parameters_changed { 1 }

=head2 available_parameters

 Title   : available_parameters
 Usage   : @params = $pobj->available_parameters()
 Function: Returns a list of the available parameters
 Returns : Array of parameters
 Args    : [optional] name of executable being used; defaults to returning all
           available parameters

=cut

sub available_parameters {
    my ($self, $exec) = @_;
    my @params;
    if ($exec) {
        $self->throw("$exec is not part of the Infernal package") if !exists($INFERNAL_PROGRAM{$exec});
        for my $p (sort keys %INFERNAL_PARAMS) {
            if (grep { $exec eq $_ }
                @{$INFERNAL_PARAMS{$p}}[2..$#{$INFERNAL_PARAMS{$p}}])
            {
                push @params, $p;
            }
        }
    } else {
        @params = (sort keys %INFERNAL_PARAMS, sort keys %LOCAL_PARAMS);
    }
    return @params;
}

=head2 get_parameters

 Title   : get_parameters
 Usage   : %params = $pobj->get_parameters;
 Function: Returns list of set key-value pairs, parameter => value
 Returns : List of key-value pairs
 Args    : [optional]
           'full' - this option returns everything associated with the parameter
                    as an array ref value; that is, not just the value but also
                    the value, type, and prefix. Default is value only.
           'valid'- same a 'full', but only returns the grouping valid for the
                    currently set executable

=cut

sub get_parameters {
    my ($self, $option) = @_;
    $option ||= ''; # no option
    my %params;
    if (exists $self->{parameters}) {
        %params = (ref $option eq 'ARRAY') ? (
                    map {$_ => $self->{parameters}{$_}[0]}
                    grep { exists $self->{parameters}{$_} } @$option) :
                (lc $option eq 'full')     ?
                    (%{$self->{parameters}}) :
                (lc $option eq 'valid')    ?
                    (map {$_ => $self->{parameters}{$_}}
                    grep { exists $self->{valid_params}->{$_} } keys %{$self->{parameters}}) :
                (map {$_ => $self->{parameters}{$_}[0]} keys %{$self->{parameters}});
    } else {
        %params = ();
    }
    return %params;
}

=head1 to_* methods

All to_* methods are implementation-specific

=cut

=head2 to_exe_string

 Title   : to_exe_string
 Usage   : $string = $pobj->to_exe_string;
 Function: Returns string (command line string in this case)
 Returns : String 
 Args    : 

=cut

sub to_exe_string {
    my ($self, @passed) = @_;
    my ($seqs, $aligns) = $self->_rearrange([qw(SEQ_FILES ALIGN_FILES)], @passed);
    if ($seqs || $aligns) {
        $self->throw("Seqs or alignments must be an array reference") unless
            ($seqs && ref($seqs) eq 'ARRAY') || ($aligns && ref($aligns) eq 'ARRAY' );
    }
    
    my %args = map {$_ => []} qw(switch param input redirect);
    my %params = $self->get_parameters('valid');
    
    my ($exe, $prog, $model, $outfile) = ($self->executable,
                                   $self->program_name,
                                   $self->model_file,
                                   $self->outfile_name);
    
    $self->throw("Executable not found") unless defined($exe);
    
    delete $params{o} if exists $params{o};

    if (!defined($model) && $prog ne 'cmbuild') {
        $self->throw("model_file() not defined")
    }
    
    $outfile ||= '';
    
    for my $p (sort keys %params) {
        if ($params{$p}[0]) {
            my $val = $params{$p}[1] eq 'param' ? ' '.$params{$p}[0] : '';
            push @{$args{$params{$p}[1]}}, $params{$p}[2].$p.$val;
        }
    }
    
    # TODO: not sure what happens when we pass in multiple seq or alignment
    # filenames, may need checking 
    if ($prog eq 'cmscore' || $prog eq 'cmstat' || $prog eq 'cmcalibrate') {
        push @{$args{'redirect'}}, "> $outfile" if $outfile;
        push @{$args{'input'}}, $model;
    } elsif ($prog eq 'cmsearch') {
        if (!defined $seqs) {
            $self->throw('cmsearch requires a sequence file name');
        }
        push @{$args{'param'}}, "-o $outfile" if $outfile;
        push @{$args{'input'}}, ($model, @$seqs);
    } elsif ($prog eq 'cmalign') {
        if ($params{'merge'}) {
            $self->throw('cmalign with --merge option requires two alignment files') if
                !defined($aligns) || @$aligns < 2;
            push @{$args{'input'}}, ($model, @$aligns);
        } else {
            $self->throw('cmalign requires a sequence file') if
                !defined $seqs;
            push @{$args{'input'}}, ($model, @$seqs);
        }
        push @{$args{'param'}}, "-o $outfile" if $outfile;
    } elsif ($prog eq 'cmbuild') {
        $self->throw('cmbuild requires one alignment file') if
            !defined($aligns);
        if ($model) {
            push @{$args{'input'}}, ($model, @$aligns);
            push @{$args{'redirect'}}, "> $outfile" if $outfile;
        } else {
            push @{$args{'input'}}, ($outfile, @$aligns);
        }
    } elsif ($prog eq 'cmemit') {
        if (!$outfile) {
            $self->throw('cmemit requires an outfile_name; tempfile support not implemented yet');
        } else {
            push @{$args{'input'}}, ($model, ,$outfile);
        }
    }
    
    # quiet!
    if ($self->quiet && $prog ne 'cmsearch') {
        if ($prog eq 'cmalign') {
            push @{$args{switch}}, '-q' if !exists $params{q};
        } else {
            push @{$args{redirect}}, '> /dev/null';
        }
    }
    
    my $string = "$exe ".join(' ',(@{$args{switch}},
                                   @{$args{param}},
                                   @{$args{input}},
                                   @{$args{redirect}}));

    $string;
}

############### PRIVATE ###############

#=head2 _run
#
# Title   :   _run
# Usage   :   $obj->_run()
# Function:   Internal(not to be used directly)
# Returns :   
# Args    :
#
#=cut

{
    my %ALLOWED = map {$_ => 1} qw(run cmsearch cmalign cmemit cmbuild
    cmcalibrate cmstat cmscore);

sub _run {
    my ($self)= shift;
    
    my ($prog, $model, $out, $version) = ($self->program,
                                          $self->model_file,
                                          $self->outfile_name,
                                          $self->version);
    
    if (my $caller = (caller(1))[3]) {
        $caller =~ s{.*::(\w+)$}{$1};
        $self->throw("Calling _run() from disallowed method") unless exists $ALLOWED{$caller};
    } else {
        $self->throw("Can't call _run directly");
    }
    
    # a model and a file must be defined for all but cmemit; cmemit must have a
    # file or model defined (using $file if both are defined)
    
    # relevant files are passed on to the string builder
    my $str = $self->to_exe_string(@_);
    $self->debug("Infernal command: $str\n");
    
    my %has = $self->get_parameters('valid');
    
    my $obj =
        ($prog eq 'cmsearch') ? Bio::SearchIO->new(-format => 'infernal',
                                                -version => $version,
                                                -model => $model) :
        ($prog eq 'cmalign' )                              ? Bio::AlignIO->new(-format => 'stockholm') :
        ($prog eq 'cmemit' && $has{a}) ? Bio::AlignIO->new(-format => 'stockholm') :
        ($prog eq 'cmemit') ? Bio::SeqIO->new(-format => 'fasta') :
              undef;
    my @args;
    # file output
    if ($out) {
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
            $self->debug($io) if $io;
            return 1;
        }
    }
    $obj->_initialize_io(@args) if $obj && ref($obj);
    return $obj || 1;
}

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

# this is a private sub used to regenerate the class data structures,
# dumped to STDOUT

# could probably add in a description field if needed...

sub _dump_params {
    my %params;
    my %usage;
    for my $exec (qw(cmalign cmbuild cmcalibrate cmemit cmscore cmsearch cmstat)) {
        my $output = `$exec --devhelp`;
        if ($?) {
            $output = `$exec -h`;
        }
        my @lines = split("\n",$output);
        
        for my $line (@lines) {
            next if $line =~ /^#/;
            if ($line =~ /^\s*(-{1,2})(\S+)\s+(<\S+>)?/) {
                my %data;
                ($data{prefix}, my $p, $data{arg}) = ($1, $2, $3 ? 'param' : 'switch');
                if (exists $params{$p}) {
                    if ($data{prefix} ne $params{$p}{prefix}) {
                        warn("$data{prefix} for $p in $exec doesn't match prefix for same parameter in ".$params{$p}{exec}[-1].":".$params{$p}{prefix});
                    }
                    if ($data{arg} ne $params{$p}{arg}) {
                        warn("$data{arg} for $p in $exec doesn't match arg for same parameter in ".$params{$p}{exec}[-1].":".$params{$p}{arg});
                    }
                }
                
                while (my ($key, $val) = each %data) {
                    $params{$p}->{$key} = $val;
                }
                push @{$params{$p}->{exec}}, $exec;
            } elsif ($line =~ /Usage:\s*(.+)$/) {
                push @{$usage{$exec}}, $1;
            } else {
                #print "$line\n";
            }
        }
    }

    # generate  data structure
    print "our %INFERNAL_PARAMS = (\n";
    for my $k (sort keys %params) {
        printf("  %-17s => [","'$k'");
        for my $sub (qw(arg prefix exec)) {
            my $str = (ref($params{$k}{$sub}) eq 'ARRAY') ?
                  "qw(".join(' ', @{$params{$k}{$sub}}).")" :
                  "'".$params{$k}{$sub}."',";
            printf("%-10s", $str);
        }
        print "],\n";
    }
    print ");\n\n";
    
    # generate usage data structure
    print "our %INFERNAL_PROGRAM = (\n";
    for my $k (sort keys %usage) {
        printf("  %-17s => [\n","'$k'");
        print '   '.join(",\n   ", map {"'$_'"} @{$usage{$k}})."\n";
        print "  ],\n";
    }
    print ");\n";

}

1;
