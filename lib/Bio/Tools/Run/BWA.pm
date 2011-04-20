# $Id$
package Bio::Tools::Run::BWA;
use strict;
#
# BioPerl module for Bio::Tools::Run::BWA
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Mark A. Jensen <maj@fortinbras.us>
#
# Copyright Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::BWA - Run wrapper for the BWA short-read assembler *BETA*

=head1 SYNOPSIS

 # create an assembly

 # run BWA commands separately

=head1 DESCRIPTION

This module provides a wrapper interface for Heng Li's
reference-directed short read assembly suite C<bwa> (see
L<http://bio-bwa.sourceforge.net/bwa.shtml> for manuals and
downloads).

Manipulating the alignments requires C<samtools>
(L<http://sourceforge.net/projects/samtools/>) and Lincoln Stein's package
C<Bio-SamTools> (L<http://search.cpan.org/perldoc?Bio::DB::Sam>).

There are two modes of action. 

=over 

=item * Easy assembly

The first is a simple pipeline through the C<maq> commands, taking
your read data in and squirting out an assembly object of type
L<Bio::Assembly::IO::maq>. The pipeline is based on the one performed
by C<maq.pl easyrun>:

 Action                  maq commands
 ------                  ------------
 data conversion to      fasta2bfa, fastq2bfq
 maq binary formats

 map sequence reads      map
 to reference seq

 assemble, creating      assemble
 consensus

 convert map & cns       mapview, cns2fq
 files to plaintext
 (for B:A:IO:maq)

Command-line options can be directed to the C<map>, C<assemble>, and
C<cns2fq> steps. See L</OPTIONS> below.

=item * BWA command mode

The second mode is direct access to C<bwa> commands. To run a C<bwa>
command, construct a run factory, specifying the desired command using
the C<-command> argument in the factory constructor, along with
options specific to that command (see L</OPTIONS>):

 $bwafac = Bio::Tools::Run::BWA->new( -command => 'fasta2bfa' );

To execute, use the C<run_bwa> methods. Input and output files are
specified in the arguments of C<run_bwa> (see L</FILES>):

 $bwafac->run_bwa( -fas => "myref.fas", -bfa => "myref.bfa" );

=back

=head1 OPTIONS

C<bwa> is complex, with many subprograms (commands) and command-line
options and file specs for each. This module attempts to provide
commands and options comprehensively. You can browse the choices like so:

 $bwafac = Bio::Tools::Run::BWA->new( -command => 'aln' );
 # all maq commands
 @all_commands = $bwafac->available_parameters('commands'); 
 @all_commands = $bwafac->available_commands; # alias
 # just for aln
 @aln_params = $bwafac->available_parameters('params');
 @aln_switches = $bwafac->available_parameters('switches');
 @aln_all_options = $bwafac->available_parameters();

Reasonably mnemonic names have been assigned to the single-letter
command line options. These are the names returned by
C<available_parameters>, and can be used in the factory constructor
like typical BioPerl named parameters.

See L<http://bio-bwa.sourceforge.net/bwa.shtml> for the gory details.

=head1 FILES

When a command requires filenames, these are provided to the C<run_bwa> method, not
the constructor (C<new()>). To see the set of files required by a command, use
C<available_parameters('filespec')> or the alias C<filespec()>:

  $bwafac = Bio::Tools::Run::BWA->new( -command => 'aln' );
  @filespec = $bwafac->filespec;

This example returns the following array:

 fas
 faq 
 >sai

This indicates that the FASTA database (faq) and the FASTQ reads (faq)
MUST be specified, and the STDOUT of this program (SA coordinates) MAY be
slurped into a file specified in the C<run_bwa> argument list:

 $bwafac->run_bwa( -fas => 'my.db.fas', -faq => 'reads.faq',
                   -sai => 'out.sai' );

If files are not specified per the filespec, text sent to STDOUT and
STDERR is saved and is accessible with C<$bwafac->stdout()> and
C<$bwafac->stderr()>.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Mark A. Jensen

 Email maj -at- fortinbras -dot- us

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


use IPC::Run;
our $HAVE_IO_UNCOMPRESS;
our $HAVE_SAMTOOLS;
BEGIN {
    eval "require IO::Uncompress::Gunzip; \$HAVE_IO_UNCOMPRESS = 1";
    eval "require Bio::Tools::Run::Samtools; \$HAVE_SAMTOOLS = 1";
}

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
use Bio::Tools::Run::BWA::Config;
use Bio::Tools::GuessSeqFormat;
use File::Basename qw(fileparse);
use File::Copy;
use Cwd;

use base qw(Bio::Root::Root Bio::Tools::Run::AssemblerBase );

our $program_name = 'bwa'; # name of the executable

# Note:
#  other globals required by Bio::Tools::Run::AssemblerBase are
#  imported from Bio::Tools::Run::BWA::Config

our $qual_param = 'quality_file';
our $use_dash = 1;
our $join = ' ';

# Bio::Assembly::IO::sam now workable!
our $asm_format = 'sam'; 

=head2 new()

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::BWA();
 Function: Builds a new Bio::Tools::Run::BWA object
 Returns : an instance of Bio::Tools::Run::BWA
 Args    :

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->parameters_changed(1); 
  $self->_register_program_commands( \@program_commands, \%command_prefixes );
  unless (grep /command/, @args) {
      push @args, '-command', 'run';
  }
  $self->_set_program_options(\@args, \@program_params, \@program_switches,
    \%param_translation, $qual_param, $use_dash, $join);
  $self->program_name($program_name) if not defined $self->program_name();
  $self->parameters_changed(1); # set on instantiation, per Bio::ParameterBaseI
  $self->_assembly_format($asm_format);
  return $self;
}

=head2 run

 Title   : run
 Usage   : $assembly = $bwafac->run( @args );
 Function: Run the bwa assembly pipeline. 
 Returns : Assembly results (file, IO object or Assembly object)
 Args    : - fastq file containing single-end reads
           - fasta file containing the reference sequence
           - [optional] fastq file containing paired-end reads 
             
=cut

sub run {
  my ($self, $rd1_file, $ref_file, $rd2_file) = @_;

  # Sanity checks
  $self->_check_executable();
  unless ($HAVE_SAMTOOLS) {
      cluck( "Bio::Tools::Run::Samtools is not available. A .sam output alignment will be created, but must be converted to binary SAM (.bam) before it can be passed to Bio::Assembly::IO, as follows: \n\t\$ samtools view -Sb out.sam > out.bam" );
  }
  $rd1_file or $self->throw("Fastq reads file required at arg 1");
  $ref_file or $self->throw("Fasta refseq file required at arg 2");
  for ($rd1_file, $ref_file, $rd2_file) {
      next unless $_;
      if (/\.gz[^.]*$/) {
	  unless ($HAVE_IO_UNCOMPRESS) {
	      croak( "IO::Uncompress::Gunzip not available, can't expand '$_'" );
	  }
	  my ($tfh, $tf) = $self->io->tempfile;
	  my $z = IO::Uncompress::Gunzip->new($_);
	  while (<$z>) { print $tfh $_ }
	  close $tfh;
	  $_ = $tf;
      }
  }

  my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$rd1_file);

  $guesser->guess eq 'fastq' or $self->throw("Reads file doesn't look like fastq at arg 1");
  $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$ref_file);
  $guesser->guess eq 'fasta' or $self->throw("Refseq file doesn't look like fasta at arg 2");
  if ($rd2_file) {
      $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$rd2_file);
      $guesser->guess eq 'fastq' or $self->throw("Reads file doesn't look like fastq at arg 3");
  }

  #Assemble
  my ($sam_file) = $self->_run($rd1_file, $ref_file, $rd2_file);

  if ($HAVE_SAMTOOLS) {
      my ($nm,$dr,$suf) = fileparse($sam_file, ".sam");
      # goofy kludge for samtools...
      my $pwd = getcwd;
      chdir($dr);
      my $samt = Bio::Tools::Run::Samtools->new( -command => 'view', 
						 -sam_input => 1,
						 -bam_output => 1,
	                                         -refseq => $ref_file);
      my $bam_file = $nm.'.bam';
      $samt->run( -bam => $nm.$suf, -out => $bam_file ) or croak( "Problem converting .sam file");
      $samt = Bio::Tools::Run::Samtools->new( -command => 'sort' );
      $samt->run( -bam => $bam_file, -pfx => $nm.'.srt' ) or croak( "Problem sorting .bam file");
      move( $nm.'.srt.bam', $bam_file );
      $samt = Bio::Tools::Run::Samtools->new( -command => 'index' );
      $samt->run( -bam => $bam_file );
      $bam_file = File::Spec->catfile($dr, $bam_file);
      $sam_file = $bam_file;
      chdir($pwd);
  }
  
  # Export results in desired object type
  my $asm = $self->_export_results($sam_file, -refdb => $ref_file, -keep_asm => 1);
  return $asm;

}

=head2 run_bwa()

 Title   : run_bwa
 Usage   : $obj->run_bwa( @file_args )
 Function: Run a bwa command as specified during object contruction
 Returns : 
 Args    : a specification of the files to operate on:

=cut

sub run_bwa {
    my ($self, @args) = @_;
    # _translate_params will provide an array of command/parameters/switches
    # -- these are set at object construction
    # to set up the run, need to add the files to the call
    # -- provide these as arguments to this function

    my $cmd = $self->command if $self->can('command');
    $self->throw("No maq command specified for the object") unless $cmd;
    # setup files necessary for this command
    my $filespec = $command_files{$cmd};
    $self->throw("No command-line file specification is defined for command '$cmd'; check Bio::Tools::Run::Maq::Config") unless $filespec;

    # parse args based on filespec
    # require named args
    $self->throw("Named args are required") unless !(@args % 2);
    s/^-// for @args;
    my %args = @args; 
    # validate
    my @req = map { 
	my $s = $_; 
	$s =~ s/^[012]?[<>]//;
	$s =~ s/[^a-zA-Z0-9_]//g; 
	$s
    } grep !/[#]/, @$filespec;
    !defined($args{$_}) && $self->throw("Required filearg '$_' not specified") for @req;
    # set up redirects
    my ($in, $out, $err);
    for (@$filespec) {
	m/^1?>(.*)/ && do {
	    defined($args{$1}) && ( open($out,">", $args{$1}) or $self->throw("Open for write error : $!"));
	    next;
	};
	m/^2>#?(.*)/ && do {
	    defined($args{$1}) && (open($err, ">", $args{$1}) or $self->throw("Open for write error : $!"));
	    next;
	};
	m/^<#?(.*)/ && do {
	    defined($args{$1}) && (open($in, "<", $args{$1}) or $self->throw("Open for read error : $!"));
	    next;
	}
    }
    my $dum;
    $in || ($in = \$dum);
    $out || ($out = \$self->{'stdout'});
    $err || ($err = \$self->{'stderr'});
    
    # Get program executable
    my $exe = $self->executable;
    # Get command-line options
    my $options = $self->_translate_params();
    # Get file specs sans redirects in correct order
    my @specs = map { 
	my $s = $_; 
	$s =~ s/[^a-zA-Z0-9_]//g; 
	$s
    } grep !/[<>]/, @$filespec;
    my @files = @args{@specs};
    # expand arrayrefs
    my $l = $#files;
    for (0..$l) {
	splice(@files, $_, 1, @{$files[$_]}) if (ref($files[$_]) eq 'ARRAY');
    }
    @files = map { defined $_ ? $_ : () } @files; # squish undefs
    my @ipc_args = ( $exe, @$options, @files );

    eval {
	IPC::Run::run(\@ipc_args, $in, $out, $err) or
	    die ("There was a problem running $exe : $!");
    };
    if ($@) {
	$self->throw("$exe call crashed: $@");
    }

    # return arguments as specified on call
    return @args;
}

=head2 stdout()

 Title   : stdout
 Usage   : $fac->stdout()
 Function: store the output from STDOUT for the run, 
           if no file specified in run_maq()
 Example : 
 Returns : scalar string
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub stdout {
    my $self = shift;
    
    return $self->{'stdout'} = shift if @_;
    return $self->{'stdout'};
}

=head2 stderr()

 Title   : stderr
 Usage   : $fac->stderr()
 Function: store the output from STDERR for the run, 
           if no file is specified in run_maq()
 Example : 
 Returns : scalar string
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub stderr {
    my $self = shift;
    
    return $self->{'stderr'} = shift if @_;
    return $self->{'stderr'};
}

=head1 Bio::Tools::Run::AssemblerBase overrides

=head2 _check_sequence_input()

 No-op.

=cut

sub _check_sequence_input {
    return 1;
}

=head2 _check_optional_quality_input()

 No-op.

=cut

sub _check_optional_quality_input {
    return 1;
}

=head2 _prepare_input_sequences

 Convert input fastq and fasta to maq format.

=cut

sub _prepare_input_sequences {
    shift->throw_not_implemented;
}

=head2 _collate_subcmd_args()

 Title   : _collate_subcmd_args
 Usage   : $args_hash = $self->_collate_subcmd_args
 Function: collate parameters and switches into command-specific
           arg lists for passing to new()
 Returns : hash of named argument lists
 Args    : [optional] composite cmd prefix (scalar string) 
           [default is 'run']

=cut

sub _collate_subcmd_args {
    my $self = shift;
    my $cmd = shift;
    my %ret;
    # default command is 'run'
    $cmd ||= 'run';
    my @subcmds = @{$composite_commands{$cmd}};
    my %subcmds;
    my $cur_options = $self->{'_options'};

    # collate
    foreach my $subcmd (@subcmds) {
	# find the composite cmd form of the argument in 
	# the current params and switches
	# e.g., map_max_mismatches
	my @params = grep /^${subcmd}_/, @{$$cur_options{'_params'}};
	my @switches = grep /^${subcmd}_/, @{$$cur_options{'_switches'}};
	$ret{$subcmd} = [];
	# create an argument list suitable for passing to new() of
	# the subcommand factory...
	foreach my $opt (@params, @switches) {
	    my $subopt = $opt; 
	    $subopt =~ s/^${subcmd}_//; 
	    push(@{$ret{$subcmd}}, '-'.$subopt => $self->$opt) if defined $self->$opt;
	}
    }
    return \%ret;
}

=head2 _run()

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Run a bwa assembly pipeline
 Returns :   a text-formatted sam alignment
 Args    :   - single end read file in maq bfq format
             - reference seq file in maq bfa format
             - [optional] paired end read file in maq bfq format

=cut

sub _run {
  my ($self, $rd1_file, $ref_file, $rd2_file) = @_;
  my ($cmd, $filespec, @ipc_args);
  # Get program executable
  my $exe = $self->executable;
  my $paired = $rd1_file && $rd2_file;
  
  my $tdir = $self->tempdir();
  my ($saih, $saif) = $self->io->tempfile(-template => 'saiXXXX', -dir=>$tdir);
  my ($sai2h, $sai2f) = $self->io->tempfile(-template => 'saiXXXX', -dir=>$tdir)
      if $paired;
  my ($samh, $samf) = $self->io->tempfile(-template => 'saiXXXX', -dir=>$tdir);
  $_->close for ($saih, $samh);
  $sai2h->close if $paired;

  my $subcmd_args = $self->_collate_subcmd_args();
  # index the fasta file (bwa's, not samtools', index...)
  my $bwa = Bio::Tools::Run::BWA->new(
      -command => 'index',
      @{$subcmd_args->{idx}}
      );
  $bwa->run_bwa( -fas => $ref_file );
  # map reads to reference seqs
  $bwa = Bio::Tools::Run::BWA->new(
      -command => 'aln',
      @{$subcmd_args->{aln}}
      );

  $bwa->run_bwa( -fas => $ref_file, -faq => $rd1_file, -sai => $saif );
  # do paired run if nec
  $bwa->run_bwa( -fas => $ref_file, -faq => $rd2_file, -sai => $sai2f ) 
      if $paired;
  # assemble reads
  $bwa = Bio::Tools::Run::BWA->new(
      -command => ($paired ? 'sampe' : 'samse'),
      @{$subcmd_args->{ ($paired ? 'smp' : 'sms' ) }}
      );
  if ($paired) {
      $bwa->run_bwa( -fas => $ref_file, -sai1 => $saif, -faq1 => $rd1_file,
		     -sai2 => $sai2f, -faq2 => $rd2_file, -sam => $samf );
  }
  else {
      $bwa->run_bwa( -fas => $ref_file, -sai => $saif, -faq => $rd1_file,
		     -sam => $samf );
  }
  # note this returns a text-sam file-- needs conversion for B:A:IO::sam...
  # conversion done in run(), if Bio::Tools::Run::Samtools available.
  return $samf;

}

=head2 available_parameters()

 Title   : available_parameters
 Usage   : @cmds = $fac->available_commands('commands');
 Function: Use to browse available commands, params, or switches
 Returns : array of scalar strings
 Args    : 'commands' : all bwa commands
           'params'   : parameters for this object's command
           'switches' : boolean switches for this object's command
           'filespec' : the filename spec for this object's command
 4Geeks  : Overrides Bio::ParameterBaseI via 
           Bio::Tools::Run::AssemblerBase

=cut

sub available_parameters {
    my $self = shift;
    my $subset = shift;
    for ($subset) { # get commands
	!defined && do { # delegate
	    return $self->SUPER::available_parameters($subset);
	};	    
	m/^c/i && do {
	    return grep !/^run$/, @program_commands;
	};
	m/^f/i && do { # get file spec
	    return @{$command_files{$self->command}};
	};
	do { #else delegate...
	    return $self->SUPER::available_parameters($subset);
	};
    }
}

sub available_commands { shift->available_parameters('commands') };

sub filespec { shift->available_parameters('filespec') };
	
1;
