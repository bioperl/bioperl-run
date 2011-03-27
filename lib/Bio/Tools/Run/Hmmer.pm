# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Hmmer - Wrapper for local execution of hmmalign, hmmbuild,
hmmcalibrate, hmmemit, hmmpfam, hmmsearch

=head1 SYNOPSIS

  # run hmmsearch (similar for hmmpfam)
  my $factory = Bio::Tools::Run::Hmmer->new(-hmm => 'model.hmm');

  # Pass the factory a Bio::Seq object or a file name, returns a Bio::SearchIO
  my $searchio = $factory->hmmsearch($seq);

  while (my $result = $searchio->next_result){
   while(my $hit = $result->next_hit){
    while (my $hsp = $hit->next_hsp){
            print join("\t", ( $result->query_name,
                               $hsp->query->start,
                               $hsp->query->end,
                               $hit->name,
                               $hsp->hit->start,
                               $hsp->hit->end,
                               $hsp->score,
                               $hsp->evalue,
                               $hsp->seq_str,
                               )), "\n";
    }
   }
  }

  # build a hmm using hmmbuild
  my $aio = Bio::AlignIO->new(-file => "protein.msf", -format => 'msf');
  my $aln = $aio->next_aln;
  my $factory =  Bio::Tools::Run::Hmmer->new(-hmm => 'model.hmm');
  $factory->hmmbuild($aln);

  # calibrate the hmm
  $factory->calibrate();

  # emit a sequence stream from the hmm
  my $seqio = $factory->hmmemit();

  # align sequences to the hmm
  my $alnio = $factory->hmmalign(@seqs);

=head1 DESCRIPTION

Wrapper module for Sean Eddy's HMMER suite of program to allow running of
hmmalign, hmmbuild, hmmcalibrate, hmmemit, hmmpfam and hmmsearch. Binaries are
available at http://hmmer.janelia.org/

You can pass most options understood by the command-line programs to new(), or
set the options by calling methods with the same name as the argument. In both
instances, case sensitivity matters.

Additional methods are hmm() to specifiy the hmm file (needed for all HMMER
programs) which you would normally set in the call to new().

The HMMER programs must either be in your path, or you must set the environment
variable HMMERDIR to point to their location.

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

 Email: shawnh-at-gmx.net

=head1 CONTRIBUTORS 

 Shawn Hoon shawnh-at-gmx.net
 Jason Stajich jason -at- bioperl -dot- org
 Scott Markel scott -at- scitegic -dot com
 Sendu Bala bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Hmmer;

use strict;

use Bio::SeqIO;
use Bio::SearchIO;
use Bio::AlignIO;

use base qw(Bio::Tools::Run::WrapperBase);

our $DefaultFormat      = 'msf';
our $DefaultReadMethod  = 'hmmer';
our %ALL                = (quiet => 'q', o => 'outfile');
our @ALIGN_PARAMS       = qw(mapali outformat withali o);
our @ALIGN_SWITCHES     = qw(m oneline q);
our @BUILD_PARAMS       = qw(n archpri cfile gapmax idlevel null pam pamwgt
                             pbswitch prior swentry swexit o);
our @BUILD_SWITCHES     = qw(f g s A F amino binary fast hand noeff nucleic
                             wblosum wgsc wme wnone wpb wvoronoi);
our @CALIBRATE_PARAMS   = qw(fixed histfile mean num sd seed cpu);
our @CALIBRATE_SWITCHES = qw();
our @EMIT_PARAMS        = qw(n seed o);
our @EMIT_SWITCHES      = qw(c q);
our @PFAM_PARAMS        = qw(A E T Z domE domT informat cpu);
our @PFAM_SWITCHES      = qw(n acc cut_ga cut_gc cut_nc forward null2 xnu);
our @SEARCH_PARAMS      = @PFAM_PARAMS;
our @SEARCH_SWITCHES    = @PFAM_SWITCHES;
our %OTHER              = (_READMETHOD => '_readmethod',
                           program_name => [qw(PROGRAM program)],
                           hmm => [qw(HMM db DB)]);

# just to be explicit
our @UNSUPPORTED        = qw(h verbose a compat pvm);


=head2 new

 Title   : new
 Usage   : $HMMER->new(@params)
 Function: Creates a new HMMER factory
 Returns : Bio::Tools::Run::HMMER
 Args    : -hmm => filename # the hmm, used by all program types; if not set
                            # here, must be set with hmm() method prior to
                            # running anything
           -_READMETHOD => 'hmmer' (default) || 'hmmer_pull' # the parsing
                                                             # module to use for
                                                             # hmmpfam/hmmsearch

           Any option supported by a Hmmer program, where switches are given
           a true value, eg. -q => 1, EXCEPT for the following which are handled
           internally/ incompatible: h verbose a compat pvm

           WARNING: the default sequence format passed to hmmpfam is msf. If
           you are using a different format, you need to pass it with informat.
           e.g.
           my $factory = Bio::Tools::Run::Hmmer->new(-hmm => 'model.hmm',
                                                     -informat => 'fasta');

           -q is synonymous with -quiet
           -o is synonymous with -outfile

           # may be specified here, allowing run() to be used, or
           # it can be ommitted and the corresponding method (eg.
           # hmmalign()) used later.
           -program => hmmalign|hmmbuild|hmmcalibrate|hmmemit|hmmpfam|hmmsearch

=cut

sub new {
    my($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => {(map { $_ => $ALL{$_} } keys %ALL),
                                               (map { $_ => $OTHER{$_} } keys %OTHER),
                                               (map { $_ => $_ } 
                                                 (@ALIGN_PARAMS,
                                                  @ALIGN_SWITCHES,
                                                  @BUILD_PARAMS,
                                                  @BUILD_SWITCHES,
                                                  @CALIBRATE_PARAMS,
                                                  @CALIBRATE_SWITCHES,
                                                  @EMIT_PARAMS,
                                                  @EMIT_SWITCHES,
                                                  @PFAM_PARAMS,
                                                  @PFAM_SWITCHES,
                                                  @SEARCH_PARAMS,
                                                  @SEARCH_SWITCHES))},
                                  -create => 1,
                                  -case_sensitive => 1);
    
    $self->informat || $self->informat($DefaultFormat);
    $self->_READMETHOD || $self->_READMETHOD($DefaultReadMethod);
    
    return $self;
}

=head2 run

 Title   : run
 Usage   : $obj->run($seqFile)
 Function: Runs one of the Hmmer programs, according to the current setting of
           program() (as typically set during new(-program => 'name')).
 Returns : A Bio::SearchIO, Bio::AlignIO, Bio::SeqIO or boolean depending on
           the program being run (see method corresponding to program name for
           details).
 Args    : A Bio::PrimarySeqI, Bio::Align::AlignI or filename

=cut

sub run {
    my $self = shift;
    my $program = lc($self->program_name || $self->throw("The program must already be specified"));
    $self->can($program) || $self->throw("'$program' wasn't a valid program");
    return $self->$program(@_);
}

=head2 hmmalign

 Title   : hmmalign
 Usage   : $obj->hmmalign()
 Function: Runs hmmalign
 Returns : A Bio::AlignIO
 Args    : list of Bio::SeqI OR Bio::Align::AlignI OR filename of file with
           sequences or an alignment

=cut

sub hmmalign {
    my $self = shift;
    $self->program_name('hmmalign');
    my $input = $self->_setinput(@_);
    
    unless (defined $self->o()) { 
        $self->q(1);
    }
    if (! $self->outformat) {
        $self->outformat($DefaultFormat);
    }
    
    return $self->_run($input);
}

=head2 hmmbuild

 Title   : hmmbuild
 Usage   : $obj->hmmbuild()
 Function: Runs hmmbuild, outputting an hmm to the file currently set by method
           hmm() or db(), or failing that, o() or outfile(), or failing that, to
           a temp location.
 Returns : true on success
 Args    : Bio::Align::AlignI OR filename of file with an alignment

=cut

sub hmmbuild {
    my $self = shift;
    $self->program_name('hmmbuild');
    my $input = $self->_setinput(@_);
    
    unless (defined $self->hmm()) {
        $self->hmm($self->o() || $self->io->tempfile(-dir => $self->tempdir));
    }
    
    return $self->_run($input);
}

=head2 hmmcalibrate

 Title   : hmmcalibrate
 Usage   : $obj->hmmcalibrate()
 Function: Runs hmmcalibrate
 Returns : true on success
 Args    : none (hmm() must be set, most likely by the -hmm option of new()), OR
           optionally supply an hmm filename to set hmm() and run

=cut

sub hmmcalibrate {
    my ($self, $hmm) = @_;
    $self->program_name('hmmcalibrate');
    $self->hmm($hmm) if $hmm;
    $self->hmm || $self->throw("hmm() must be set first");
    return $self->_run();
}

=head2 hmmemit

 Title   : hmmemit
 Usage   : $obj->hmmemit()
 Function: Runs hmmemit
 Returns : A Bio::SeqIO
 Args    : none (hmm() must be set, most likely by the -hmm option of new()), OR
           optionally supply an hmm filename to set hmm() and run

=cut

sub hmmemit {
    my ($self, $hmm) = @_;
    $self->program_name('hmmemit');
    $self->hmm($hmm) if $hmm;
    $self->hmm || $self->throw("hmm() must be set first");
    
    unless (defined $self->o()) { 
        $self->q(1);
    }
    
    return $self->_run();
}

=head2 hmmpfam

 Title   : hmmpfam
 Usage   : $obj->hmmpfam()
 Function: Runs hmmpfam
 Returns : A Bio::SearchIO
 Args    : A Bio::PrimarySeqI, Bio::Align::AlignI or filename

=cut

sub hmmpfam {
    my $self = shift;
    $self->program_name('hmmpfam');
    my $input = $self->_setinput(@_);
    return $self->_run($input);
}

=head2 hmmsearch

 Title   : hmmsearch
 Usage   : $obj->hmmsearch()
 Function: Runs hmmsearch
 Returns : A Bio::SearchIO
 Args    : A Bio::PrimarySeqI, Bio::Align::AlignI or filename

=cut

sub hmmsearch {
    my $self = shift;
    $self->program_name('hmmsearch');
    my $input = $self->_setinput(@_);
    return $self->_run($input);
}

=head2 _setinput

 Title   : _setinput
 Usage   : $obj->_setinput()
 Function: Internal(not to be used directly)
 Returns : filename
 Args    : A Bio::PrimarySeqI, Bio::Align::AlignI or filename

=cut

sub _setinput {
    my ($self, @things) = @_;
    @things || $self->throw("At least one input is required");
    
    my $infile;
    if  (ref $things[0] && $things[0]->isa("Bio::PrimarySeqI") ){# it is an object
        $infile = $self->_writeSeqFile(@things);
    }
    elsif(ref $things[0] && $things[0]->isa("Bio::Align::AlignI")){
        $infile = $self->_writeAlignFile(@things);
    }
    elsif (-e $things[0]) {
        $infile = $things[0];
    }
    else {
        $self->throw("Unknown kind of input '@things'");
    }
    
    return $infile;
}

=head2 _run

 Title   : _run
 Usage   : $obj->_run()
 Function: Internal(not to be used directly)
 Returns : Bio::SearchIO
 Args    : file name

=cut

sub _run {
    my ($self, $file) = @_;
    
    my $str = $self->executable;
    $str .= $self->_setparams;
    $str .= ' '.$file if $file;
    $self->debug("HMMER command = $str");
    
    my $progname = $self->program_name;
    
    my @in;
    my @verbose = (-verbose => $self->verbose);
    if ($progname =~ /align|build|emit/) {
        my $outfile = $self->o;
        if ($outfile || $progname eq 'hmmbuild') {
            $str .= " > /dev/null" if $self->quiet;
            
            if ($progname eq 'hmmbuild') {
                my $status = system($str);
                return $status ? 0 : 1;
            }
            else {
                system($str) && $self->throw("HMMER call ($str) crashed: $?\n");
                @in = (-file => $outfile);
            }
        }
        else {
            open(my $fh, "$str |") || $self->throw("HMMER call ($str) crashed: $?\n");
            @in = (-fh => $fh);
        }
    }
    elsif ($progname =~ /pfam|search/i) {
        open(my $fh, "$str |") || $self->throw("HMMER call ($str) crashed: $?\n");
        
        return Bio::SearchIO->new(-fh      => $fh, 
                                  @verbose,
                                  -format  => $self->_READMETHOD);
    }
    
    if ($progname eq 'hmmalign') {
        return Bio::AlignIO->new(@in,
                                 @verbose,
                                 -format => $self->outformat);
    }
    elsif ($progname eq 'hmmemit') {
        return Bio::SeqIO->new(@in,
                               @verbose,
                               -format => 'fasta');
    }
    elsif ($progname =~ /calibrate/) {
        $str .= " > /dev/null 2> /dev/null" if $self->quiet;
        my $status = system($str);
        return $status ? 0 : 1;
    }
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: creates a string of params to be used in the command string
 Returns : string of params
 Args    : none

=cut

sub _setparams {
    my $self = shift;
    
    my @execparams;
    my @execswitches;
    SWITCH: for ($self->program_name) {
        /align/     && do { @execparams   = @ALIGN_PARAMS;
                            @execswitches = @ALIGN_SWITCHES;
                            last SWITCH; };
        /build/     && do { @execparams   = @BUILD_PARAMS;
                            @execswitches = @BUILD_SWITCHES;
                            last SWITCH; };
        /calibrate/ && do { @execparams   = @CALIBRATE_PARAMS;
                            @execswitches = @CALIBRATE_SWITCHES;
                            last SWITCH; };
        /emit/      && do { @execparams   = @EMIT_PARAMS;
                            @execswitches = @EMIT_SWITCHES;
                            last SWITCH; };
        /pfam/      && do { @execparams   = @PFAM_PARAMS;
                            @execswitches = @PFAM_SWITCHES;
                            last SWITCH; };
        /search/    && do { @execparams   = @SEARCH_PARAMS;
                            @execswitches = @SEARCH_SWITCHES;
                            last SWITCH; };
    }
    
    my $param_string = $self->SUPER::_setparams(-params     => \@execparams,
                                                -switches   => \@execswitches,
                                                -mixed_dash => 1);
    
    my $hmm = $self->hmm || $self->throw("Need to specify either HMM file or Database");
    $param_string .= ' '.$hmm;
    
    return $param_string;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns : string
 Args    : none

=cut

sub program_name {
    my $self = shift;
    if (@_) {
        $self->{program_name} = shift;
        
        # hack so that when program_name changes, so does executable()
        delete $self->{'_pathtoexe'};
    }
    return $self->{program_name} || '';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns : string
 Args    : none

=cut

sub program_dir {
    return $ENV{HMMERDIR} if $ENV{HMMERDIR};
}

=head2 _writeSeqFile

 Title   : _writeSeqFile
 Usage   : obj->_writeSeqFile($seq)
 Function: Internal(not to be used directly)
 Returns : filename
 Args    : list of Bio::SeqI

=cut

sub _writeSeqFile {
    my ($self, @seq) = @_;
    my ($tfh, $inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
    $self->informat('fasta');
    my $out = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
    foreach my $s (@seq) {
        $out->write_seq($s);
    }
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    return $inputfile;
}

=head2 _writeAlignFile

 Title   : _writeAlignFile
 Usage   : obj->_writeAlignFile($seq)
 Function: Internal(not to be used directly)
 Returns : filename
 Args    : list of Bio::Align::AlignI

=cut

sub _writeAlignFile{
    my ($self, @align) = @_;
    my ($tfh, $inputfile) = $self->io->tempfile(-dir=>$self->tempdir);
    my $out = Bio::AlignIO->new('-fh' => $tfh, '-format' => $self->informat);
    foreach my $a (@align) {
        $out->write_aln($a);
    }
    $out->close();
    $out = undef;
    close($tfh);
    undef $tfh;
    return $inputfile;
}

1;
