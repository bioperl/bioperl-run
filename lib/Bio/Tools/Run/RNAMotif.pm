# $Id$
#
# BioPerl module for Bio::Tools::Run::RNAMotif
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

  my $factory = Bio::Tools::Run::RNAMotif->new(-program =>'rnamotif',
                                               -prune  => 1,
                                                @params);

  # Pass the factory a Bio::Seq object or a file name
  # Returns a Bio::SearchIO object

  #my $searchio = $factory->run("B_sub.gb");
  my $searchio = $factory->run($seq);
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

Wrapper module for Tom Macke and David Cases's RNAMotif suite of programs. This
allows running of rnamotif, rmprune, rm2ct, and rmfmt. Binaries are available at
http://www.scripps.edu/mb/case/casegr-sh-3.5.html.

This wrapper allows for one to save output to an optional named file or tempfile
using the '-outfile_name' or '-tempfile' parameters; this is primarily for
saving output from the rm2ct program, which currently does not have a parser
available. If both a named output file and tempfile flag are set, the output
file name is used. The default setting is piping output into a filehandle for
parsing (or output to STDERR, for rm2ct which requires '-verbose' set to 1).

WARNING: At this time, there is very little checking of parameter settings, so
one could have an error if setting the worng parameter for a program. Future
versions will likely add some error checking.

=head1 NOTES ON PROGRAM PARAMETERS

All program parameters are currently supported. Of note, the 'D' parameter, used
for setting the value of a variable to a value, is changed to 'set_var' to avoid
name collisions with 'd' (used for dumping internal data structures).

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

package Bio::Tools::Run::RNAMotif;

use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::SearchIO;
use Bio::AlignIO;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

# will move parameters to each program, use this for _set_params
my %RNAMOTIF_PROGS =(
    rnamotif    => [qw(c d h N O p s v context sh setvar I xdfname pre post
                    descr xdescr fmt fmap )],
    rm2ct       => [qw(t)],
    rmfmt       => [qw(a l la smax td)],
    rmprune     => [] # no params
    );

my %RNAMOTIF_SWITCHES = map {$_ => 1} qw(c d h p s v l a la context sh);

# order is important here
my @RNAMOTIF_PARAMS=qw(program prune c sh N d h p s v context setvar O I
    xdfname pre post descr xdescr fmt fmap l a la t);

=head2 new

 Title   : new
 Usage   : my $wrapper = Bio::Tools::Run::RNAMotif->new(@params)
 Function: creates a new RNAMotif factory
 Returns:  Bio::Tools::Run::RNAMotif
 Args    : list of parameters
           -tempfile        => set tempfile flag (default 0)
           -outfile_name    => set file to send output to (default none)
           -prune           => set rmprune postprocess flag (default 0)

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
 Function: returns the program directory, obtained from ENV variable.
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
    return $self->{'_progversion'} if $self->{'_progversion'};
    my $string = `rnamotif -v 2>&1`;
    my $v;
    if ($string =~ m{([\d.]+)}) {
        $v = $1;
    }
    return $self->{'_progversion'} = $v || $string;
}

=head2 run

 Title   :  run
 Usage   :  $obj->run($seqFile)
 Function:  Runs RNAMotif programs, returns Bio::SearchIO/Bio::AlignIO
 Returns :  Depends on program:
            'rnamotif' - returns Bio::SearchIO
            'rmfmt -a' - returns Bio::AlignIO
            all others - sends output to outfile, tempfile, STDERR

            Use search() (for Bio::SearchIO stream) or get_AlignIO() (for
            Bio::AlignIO stream) for a uniform Bioperl object interface.

 Args    :  A Bio::PrimarySeqI or file name
 Note    :  This runs any RNAMotif program set via program()

=cut

sub run {
    my ($self,@seq) = @_;
    $self->throw ("Must pass a file name or a list of Bio::PrimarySeqI objects")
        if (!@seq);
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq);
    }
}

=head2 search

 Title   :  search
 Usage   :  $searchio = $obj->search($seqFile)
 Function:  Runs 'rnamotif' on seqs, returns Bio::SearchIO
 Returns :  A Bio::SearchIO
 Args    :  A Bio::PrimarySeqI or file name
 Note    :  Runs 'rnamotif' only, regardless of program setting; all other
            parameters loaded

=cut

sub search {
    my ($self,@seq) = @_;
    $self->throw ("Must pass a file name or a list of Bio::PrimarySeqI objects")
        if (!@seq);
    if  (ref $seq[0] && $seq[0]->isa("Bio::PrimarySeqI") ){# it is an object
        my $infile1 = $self->_writeSeqFile(@seq);
        return  $self->_run($infile1);
    } else {
        return  $self->_run(@seq); 
    }
}

=head2 get_AlignIO

 Title   :  get_AlignIO
 Usage   :  $aln = $obj->get_AlignIO($seqFile)
 Function:  Runs 'rmfmt -a' on file, returns Bio::AlignIO
 Returns :  A Bio::AlignIO
 Args    :  File name
 Note    :  Runs 'rmfmt -a' only, regardless of program setting; only file
            name and outfile (if any) are set

=cut

sub get_AlignIO {
    my ($self,@seq) = @_;
    $self->throw ("Must pass a file name")
        if (!@seq && ref($seq[0]));
    return  $self->_run(@seq);
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

=head2 prune

 Title   : prune
 Usage   : $obj->prune(1)
 Function: Set rmprune flag.  When set, follows any searches with a call to
           rmprune (this deletes some redundant sequence hits)
 Returns : Boolean setting (or undef if not set)
 Args    : [OPTIONAL] Boolean

=cut

sub prune {
    my $self = shift;
    return $self->{'_prune'} = shift if @_;
    return $self->{'_prune'};
}

=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal(not to be used directly)
 Returns :   
 Args    :

=cut

sub _run {
    my ($self,$file,$prog)= @_;
    return unless $self->executable;
    $self->io->_io_cleanup();
    my ($str, $progname, $outfile) =
       ($prog || $self->executable, $self->program_name, $self->outfile_name);
    my $param_str = $self->_setparams($file);
    my $descr = ($self->can('descr')) ? $self->descr :
                ($self->can('xdescr')) ? $self->xdescr :
                $self->throw("Must have a descriptor present!");
    $str .= " $param_str";
    $self->debug("RNAMotif command: $str\n");
    
    # rnamotif => SearchIO object
    # rmfmt -a => AlignIO object
    # all others sent to outfile, tempfile, or STDERR (upon verbose = 1)
    
    my $obj = ($progname eq 'rnamotif' || $progname eq 'rmprune' ) ?
       Bio::SearchIO->new(-verbose => $self->verbose,
                          -format  => "rnamotif",
                          -version => $self->version,
                          -database => $file,
                          -model => $descr) :
       ($progname eq 'rmfmt' && $self->can('a') && $self->a) ?
       Bio::AlignIO->new(-verbose => $self->verbose, -format  =>'fasta') :
       undef;
    
    my @args;
    # file-based
    if ($outfile) {
        local $SIG{CHLD} = 'DEFAULT';
        my $status = system($str);
        if($status || !-e $outfile ) {
            my $error = ($!) ? "$! Status: $status" : "Status: $status";
            $self->throw( "RNAMotif call crashed: $error \n[command $str]\n");
            return undef;
        }
        if ($obj && ref($obj)) {
            $obj->file($outfile);
            @args = (-file => $outfile);
        }
    # fh-based
    } else {
        open(my $fh,"$str |") || $self->throw("RNAMotif call ($str) crashed: $?\n");
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
        (!exists $RNAMOTIF_PROGS{$progname} );

    my $param_string;
    my $outfile = ($self->outfile_name) ? ' > '.$self->outfile_name : '';
    
    my @params;
    foreach my $attr (@RNAMOTIF_PARAMS) {
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
    $param_string .= ' '.$file;

    if ($self->prune && $self->program_name eq 'rnamotif') {
        $param_string .= ' | rmprune';
    }

    $param_string .= $outfile;
    
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
