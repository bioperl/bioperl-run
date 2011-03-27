# $Id$
#
# BioPerl module for Bio::Tools::Run::ERPIN
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Chris Fields
#
# Copyright Chris Fields
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::ERPIN - Wrapper for local execution of the ERPIN suite of
programs.

=head1 SYNOPSIS

  #run 

  my @params = (
              trset => 'BL.erpin',
              region => [1, 10], 
              # Set up search strategy this way...
              strategy => [ 'umask'   => [1, 2],
                            'umask'   => [1, 2, 3, 4],
                            'umask'   => [1, 2, 3, 4, 5, 6],
                            'nomask',
                            'cutoff'  => [0, 10, 15, 20]
                            ]
              # or use a simple string...
              #strategy => 'Ðumask 4 Ðadd 5 -nomask -cutoff 0 10 15',
              pcw => 100
             );

  my $factory = Bio::Tools::Run::ERPIN->new(-program =>'erpin',
                                                @params);

  # Pass the factory a Bio::Seq object or a file name
  # Returns a Bio::SearchIO object

  #my $search = $factory->run("B_sub.fas");
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

=head1 DESCRIPTION

=cut

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

package Bio::Tools::Run::ERPIN;

use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::SearchIO;
use Bio::AlignIO;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

# will move parameters to each program, use this for _set_params
my %ERPIN_PROGS = (
    cfgs        => 1,
    erpin       => 1,
    frandseq    => 1,
    mstat       => 1,
    sview       => 1,
    tstrip      => 1,
    epnstat     => 1,
    ev          => 1,
    mhistview   => 1,
    pview       => 1,
    tstat       => 1,
    tview       => 1,
    );

my %ERPIN_SWITCHES = map {$_ => 1} qw(dmp smp fwd rev fwd+rev long short mute
    warnings globstat locstat unifstat Eon Eoff hist chrono);

# order is important here
my @ERPIN_PARAMS=qw(program model file strategy dmp smp fwd rev fwd+rev long
    short mute warnings globstat locstat unifstat Eon Eoff hist seq1 nseq bgn
    len logzero tablen chrono pcw hpcw spcw sumf tset);

=head2 new

 Title   : new
 Usage   : my $wrapper = Bio::Tools::Run::RNAMotif->new(@params)
 Function: creates a new RNAMotif factory
 Returns:  Bio::Tools::Run::RNAMotif
 Args    : list of parameters
           -tempfile        => set tempfile flag (default 0)
           -outfile_name    => set file to send output to (default none)

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($out, $tf) = $self->_rearrange([qw(OUTFILE_NAME TEMPFILE)], @args);
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
                          -methods => [@ERPIN_PARAMS],
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
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{ERPINDIR}) if $ENV{ERPINDIR};
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
    my $string = `erpin -h 2>&1`;
    my $v;
    if ($string =~ m{Version\s([\d.]+)}) {
        $v = $1;
    }
    return $self->{'_progversion'} = $v || $string;
}

=head2 run

 Title   :  run
 Usage   :  $obj->run($seqFile)
 Function:  Runs ERPIN programs and returns Bio::SearchIO
 Returns :  
 Args    :  Must pass Bio::PrimarySeqI's or file names

=cut

sub run {
    my ($self,@seq) = @_;
    $self->throw ("Must define 'db', pass a file name, or a list of Bio::PrimarySeqI objects")
        if (!@seq);
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head2 tempfile

 Title   : tempfile
 Usage   : $obj->tempfile(1)
 Function: Set tempfile flag.  When set, writes output to a tempfile; this
           is overridden by outfile_name() if set
 Returns : Boolean setting (or undef if not set)
 Args    : [OPTIONAL] Boolean

=cut

sub tempfile {
    my $self = shift;
    return $self->{'_tempfile'} = shift if @_;
    return $self->{'_tempfile'};
}

=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal(not to be used directly)
 Returns :   
 Args    :

=cut

sub _run {
    my ($self,$file,$prog) = @_;
    return unless $self->executable;
    $self->io->_io_cleanup();
    my ($str, $progname, $outfile) =
       ($prog || $self->executable, $self->program_name, $self->outfile_name);
    my $param_str = $self->_setparams($file);
    $str .= " $param_str";
    $self->debug("ERPIN command: $str\n");
    
    # rnamotif => SearchIO object
    # rmfmt -a => AlignIO object
    # all others sent to outfile, tempfile, or STDERR (upon verbose = 1)
    
    my $obj = ($progname eq 'erpin') ?
       Bio::SearchIO->new(-verbose => $self->verbose,
                          -format  => "erpin",
                          -version => $self->version,
                          -database => $file
                          ) :
       undef;
    
    my @args;
    # file-based
    if ($outfile) {
        local $SIG{CHLD} = 'DEFAULT';
        my $status = system($str);
        if($status || !-e $outfile || -z $outfile ) {
            my $error = ($!) ? "$! Status: $status" : "Status: $status";
            $self->throw( "ERPIN call crashed: $error \n[command $str]\n");
            return undef;
        }
        if ($obj && ref($obj)) {
            $obj->file($outfile);
            @args = (-file => $outfile);
        }
    # fh-based
    } else {
        open(my $fh,"$str |") || $self->throw("ERPIN call ($str) crashed: $?\n");
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
    # initialize SearchIO/AlignIO...um...IO
    # (since file/fh set post obj construction)
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

sub _setparams {
    my ($self, $file) = @_;
    my $progname = $self->program_name;
    # small sanity check
    $self->throw("Unknown program: $progname") if
        (!exists $ERPIN_PROGS{$progname} );
    my $param_string;
    
    my $outfile = ($self->outfile_name) ? ' > '.$self->outfile_name : '';
    my ($tset, $st) = ($self->tset, $self->strategy);
    
    $param_string = join " ", ($tset, $file, $st);
    $self->debug("String : $param_string\n");
    
    $self->throw("Must have both a training set and search strategy defined!")
        if (!defined($tset) || !defined ($st));
    
    my @params;
    foreach my $attr (@ERPIN_PARAMS) {
        next if $attr eq 'program' || $attr eq 'tset' || $attr eq 'strategy';
        my $value = $self->$attr();
        next unless ($attr eq 'file' || defined $value);
        my $attr_key = '-'.$attr;
        if (exists $ERPIN_SWITCHES{$attr}) {
            push @params, $attr_key;
        } else {
            if ($attr eq 'file') {
                push @params, $file;
            } else {
                push @params, $attr_key.' '.$value;
            }
        }
    }
    
    $param_string .= ' '.join ' ', @params;
    $param_string .= $outfile if $outfile;
    
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
