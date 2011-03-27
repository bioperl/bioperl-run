# $Id$
#
# BioPerl module for Bio::Tools::Run::Maq
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

Bio::Tools::Run::Maq - Run wrapper for the Maq short-read assembler *BETA*

=head1 SYNOPSIS

 # create an assembly
 $maq_fac = Bio::Tools::Run::Maq->new();
 $maq_assy = $maq_fac->run( 'reads.fastq', 'refseq.fas' );
 # if IO::Uncompress::Gunzip is available...
 $maq_assy = $maq_fac->run( 'reads.fastq.gz', 'refseq.gz');
 # paired-end 
 $maq_assy = $maq_fac->run( 'reads.fastq', 'refseq.fas', 'paired-reads.fastq');
 # be more strict
 $maq_fac->set_parameters( -c2q_min_map_quality => 60 );
 $maq_assy = $maq_fac->run( 'reads.fastq', 'refseq.fas', 'paired-reads.fastq');

 # run maq commands separately
 $maq_fac = Bio::Tools::Run::Maq->new(
    -command => 'pileup',
    -single_end_quality => 1 );
 $maq_fac->run_maq( -bfa => 'refseq.bfa',
                    -map => 'maq_assy.map',
                    -txt => 'maq_assy.pup.txt' );

=head1 DESCRIPTION

This module provides a wrapper interface for Heng Li's
reference-directed short read assembly suite C<maq> (see
L<http://maq.sourceforge.net/maq-man.shtml> for manuals and
downloads).

There are two modes of action. 

=over 

=item * EasyMaq

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

=item * BigMaq

The second mode is direct access to C<maq> commands. To run a C<maq>
command, construct a run factory, specifying the desired command using
the C<-command> argument in the factory constructor, along with
options specific to that command (see L</OPTIONS>):

 $maqfac->Bio::Tools::Run::Maq->new( -command => 'fasta2bfa' );

To execute, use the C<run_maq> methods. Input and output files are
specified in the arguments of C<run_maq> (see L</FILES>):

 $maqfac->run_maq( -fas => "myref.fas", -bfa => "myref.bfa" );

=back

=head1 OPTIONS

C<maq> is complex, with many subprograms (commands) and command-line
options and file specs for each. This module attempts to provide
commands and options comprehensively. You can browse the choices like so:

 $maqfac = Bio::Tools::Run::Maq->new( -command => 'assemble' );
 # all maq commands
 @all_commands = $maqfac->available_parameters('commands'); 
 @all_commands = $maqfac->available_commands; # alias
 # just for assemble
 @assemble_params = $maqfac->available_parameters('params');
 @assemble_switches = $maqfac->available_parameters('switches');
 @assemble_all_options = $maqfac->available_parameters();

Reasonably mnemonic names have been assigned to the single-letter
command line options. These are the names returned by
C<available_parameters>, and can be used in the factory constructor
like typical BioPerl named parameters.

See L<http://maq.sourceforge.net/maq-manpage.shtml> for the gory details.

=head1 FILES

When a command requires filenames, these are provided to the C<run_maq> method, not
the constructor (C<new()>). To see the set of files required by a command, use
C<available_parameters('filespec')> or the alias C<filespec()>:

  $maqfac = Bio::Tools::Run::Maq->new( -command => 'map' );
  @filespec = $maqfac->filespec;

This example returns the following array:

 map
 bfa 
 bfq1 
 #bfq2 
 2>#log

This indicates that map (C<maq> binary mapfile), bfa (C<maq> binary
fasta), and bfq (C<maq> binary fastq) files MUST be specified, another
bfq file MAY be specified, and a log file receiving STDERR also MAY be
specified. Use these in the C<run_maq> call like so:

 $maqfac->run_maq( -map => 'my.map', -bfa => 'myrefseq.bfa',
                   -bfq1 => 'reads1.bfq', -bfq2 => 'reads2.bfq' );

Here, the C<log> parameter was unspecified. Therefore, the object will store
the programs STDERR output for you in the C<stderr()> attribute:

 handle_map_warning($maqfac) if ($maqfac->stderr =~ /warning/);

STDOUT for a run is also saved, in C<stdout()>, unless a file is specified
to slurp it according to the filespec. C<maq> STDOUT usually contains useful
information on the run. 

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


package Bio::Tools::Run::Maq;
use strict;
our $HAVE_IO_UNCOMPRESS;

BEGIN {
    eval {require IO::Uncompress::Gunzip; $HAVE_IO_UNCOMPRESS = 1};
}

use IPC::Run;

# Object preamble - inherits from Bio::Root::Root

use lib '../../..';
use Bio::Root::Root;
use Bio::Tools::Run::Maq::Config;
use Bio::Tools::GuessSeqFormat;
use File::Basename qw(fileparse);

use base qw(Bio::Root::Root Bio::Tools::Run::AssemblerBase );

## maq ( from tigr )
our $program_name = 'maq'; # name of the executable

# Note:
#  other globals required by Bio::Tools::Run::AssemblerBase are
#  imported from Bio::Tools::Run::Maq::Config

our $qual_param = 'quality_file';
our $use_dash = 1;
our $join = ' ';

our $asm_format = 'maq';

=head2 new()

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::Maq();
 Function: Builds a new Bio::Tools::Run::Maq object
 Returns : an instance of Bio::Tools::Run::Maq
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
  if ($^O =~ /cygwin/) {
      my @kludge = `PATH=\$PATH:/usr/bin:/usr/local/bin which $program_name`;
      chomp $kludge[0];
      $self->program_name($kludge[0]);
  }
  $self->parameters_changed(1); # set on instantiation, per Bio::ParameterBaseI
  $self->_assembly_format($asm_format);
  return $self;
}

=head2 run

 Title   : run
 Usage   : $assembly = $maq_assembler->run($read1_fastq_file, 
                                           $refseq_fasta_file,
                                           $read2_fastq_file);
 Function: Run the maq assembly pipeline. 
 Returns : Assembly results (file, IO object or Assembly object)
 Args    : - fastq file containing single-end reads
           - fasta file containing the reference sequence
           - [optional] fastq file containing paired-end reads 
 Note    : gzipped inputs are allowed if IO::Uncompress::Gunzip
           is available
             
=cut

sub run {
  my ($self, $rd1_file, $ref_file, $rd2_file) = @_;

  # Sanity checks
  $self->_check_executable();
  $rd1_file or $self->throw("Fastq reads file required at arg 1");
  $ref_file or $self->throw("Fasta refseq file required at arg 2");
  # expand gzipped files as nec.
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

  # maq format conversion
  ($rd1_file, $ref_file, $rd2_file) = $self->_prepare_input_sequences($rd1_file, $ref_file, $rd2_file);

  # Assemble
  my ($maq_file, $faq_file) = $self->_run($rd1_file, $ref_file, $rd2_file);

  # Export results in desired object type
  my $asm  = $self->_export_results($maq_file);
  return $asm;
}

=head2 run_maq()

 Title   : run_maq
 Usage   : $obj->run_maq( @file_args )
 Function: Run a maq command as specified during object contruction
 Returns : 
 Args    : a specification of the files to operate on:

=cut

sub run_maq {
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

    my ($self, @args) = @_;
    my (%args, $read1, $read2, $refseq);
    if (grep /^-/, @args) { # named parms
	$self->throw("Input args not an even number") unless !(@args % 2);
	%args = @args;
	($read1, $refseq, $read2) = @args{qw( -read1 -refseq -read2 )};
    }
    else {
	($read1, $refseq, $read2) = @args;
    }
    # just handle file input for now...
    $self->throw("maq requires at least one FASTQ read file and one FASTA reference sequence") 
	unless (defined $read1 && defined $refseq);
    $self->throw("File cannot be found")
	unless ( -e $read1 && -e $refseq && (!defined $read2 || -e $read2) );

    # maq needs its own fasta/fastq format. Use its own converters to 
    # create tempfiles in bfa, bfq format.
    my ($ref_h, $ref_file, $rd1_h, $rd1_file, $rd2_h, $rd2_file);
    ($ref_h, $ref_file) = $self->io->tempfile( -dir => $self->tempdir() );
    ($rd1_h, $rd1_file) = $self->io->tempfile( -dir => $self->tempdir() );
    $ref_h->close;
    $rd1_h->close;
    my $fac = Bio::Tools::Run::Maq->new( -command => 'fasta2bfa' );
    $fac->run_maq( -bfa => $ref_file, -fas => $refseq );
    $fac->set_parameters( -command => 'fastq2bfq' );
    $fac->run_maq( -bfq => $rd1_file, -faq => $read1 );
    if (defined $read2) {
	($rd2_h, $rd2_file) = $self->io->tempfile( -dir => $self->tempdir() );
	$rd2_h->close;
	$fac->run_maq( -bfq => $rd2_file, -faq => $read2);
    }
    return ($rd1_file, $ref_file, $rd2_file);
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
 Function:   Run a maq assembly pipeline
 Returns :   depends on call (An assembly file)
 Args    :   - single end read file in maq bfq format
             - reference seq file in maq bfa format
             - [optional] paired end read file in maq bfq format

=cut

sub _run {
  my ($self, $rd1_file, $ref_file, $rd2_file) = @_;
  my ($cmd, $filespec, @ipc_args);
  # Get program executable
  my $exe = $self->executable;

  # treat run() as a separate command and duplicate the component-specific
  # parameters in the config globals

  # Setup needed files and filehandles first
  my $tdir = $self->tempdir();
  my ($maph, $mapf) = $self->io->tempfile( -template => 'mapXXXX', -dir => $tdir ); #map
  my ($cnsh, $cnsf) = $self->io->tempfile( -template => 'cnsXXXX', -dir => $tdir ); #consensus
  my ($maqh, $maqf) = $self->_prepare_output_file();
  my ($nm,$dr,$suf) = fileparse($maqf,".maq");
  my $faqf = $dr.$nm.".cns.fastq";

  $_->close for ($maph, $cnsh, $maqh);

  # Get command-line options for the component commands:
  my $subcmd_args = $self->_collate_subcmd_args();
  # map reads to ref seq
  # set up subcommand options
  
  my $maq = Bio::Tools::Run::Maq->new( 
      -command => 'map',
      @{$subcmd_args->{map}}
      );
  $maq->run_maq( -map => $mapf, -bfa => $ref_file, -bfq1 => $rd1_file,
		 -bfq2 => $rd2_file );
  # assemble reads into consensus
  $maq = Bio::Tools::Run::Maq->new(
      -command => 'assemble',
      @{$subcmd_args->{asm}}
      );
  $maq->run_maq( -cns => $cnsf, -bfa => $ref_file, -map => $mapf );
  # convert map into plain text
  $maq = Bio::Tools::Run::Maq->new(
      -command => 'mapview'
      );
  $maq->run_maq( -map => $mapf, -txt => $maqf );

  # convert consensus into plain text fastq
  $maq = Bio::Tools::Run::Maq->new(
      -command => 'cns2fq',
      @{$subcmd_args->{c2q}}
      );
  $maq->run_maq( -cns => $cnsf, -faq => $faqf );
  
  return ($maqf, $faqf);

}

=head2 available_parameters()

 Title   : available_parameters
 Usage   : @cmds = $fac->available_commands('commands');
 Function: Use to browse available commands, params, or switches
 Returns : array of scalar strings
 Args    : 'commands' : all maq commands
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
