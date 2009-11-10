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

Bio::Tools::Run::Maq - Run wrapper for Heng Li's maq short-read assembler *Pre-ALPHA!*

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

This module provides two modes of action. The first is a simple
pipeline through the C<maq> commands, taking your read data in and
squirting an assembly out. The pipeline is based on the one performed
by C<maq.pl easyrun>.

The second mode is direct access to C<maq> commands, by specifying the
C<-command =E<gt> $maq_command> argument and providing the input and
output files as described at L<http://maq.sourceforge.net/maq-manpage.shtml>.

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

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Mark A. Jensen

 Email maj -at- fortinbras -dot- us

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::Maq;
use strict;

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

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::Maq();
 Function: Builds a new Bio::Tools::Run::Maq object
 Returns : an instance of Bio::Tools::Run::Maq
 Args    :

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->_register_program_commands( \@program_commands, \%command_prefixes );
  $self->_set_program_options(\@args, \@program_params, \@program_switches,
    \%param_translation, $qual_param, $use_dash, $join);
  $self->program_name($program_name) if not defined $self->program_name();
  if ($^O =~ /cygwin/) {
      my @kludge = `PATH=\$PATH:/usr/bin:/usr/local/bin which $program_name`;
      chomp $kludge[0];
      $self->program_name($kludge[0]);
  }
  $self->_assembly_format($asm_format);
  return $self;
}


# maq requires a reference sequence; this should be a required run parameter

# easyrun pipeline:
# (puts intermediate files in a specified directory)
# - guess format, and convert to bfa or bfq (running fasta2bfa/fastq2bfq)
# - allows single or paired reads on option spec...
# - runs maq map, creating logfile from stderr (hack default options...)
#   * branches for paired or unpaired reads
#   * maq map $mapopt aln$tag.map ref.bfa $bfqs 2> aln$tab.map.log
# - if more than one map file, mapmerge executed
#   * maq mapmerge all.map @map_files
#   * otherwise, cp mapfile to all.map
# - runs maq mapcheck ref.bfa $map_file > mapcheck.txt
# - runs maq assemble (-N -Q options) consensus.cns ref.bfa $map_file 2> logfile
# - creates various reports
#   * parses consensus.cns to various formats: cns.fq cns.snp cns.win
#   * performs indel analyses

# pipeline for Bio::Assembly::IO::maq compat--
# need to produce mapview rendering of map file, fastq rendering of consensus
#
# required input: single-end reads in fastq, refseq in fasta
# optional : paired-end reads in two fastq files
#     
# allow manipulation of parameters relating to the tools used
#
# run the canned pipeline with new instances of this module!
#   - check reads, ref
#   - convert reads, ref to bfq, bfa
#   - run map
#   - run mapmerge, if nec.
#   - run assemble
#   - run mapview on map
#   - run cns2fq on consensus
#   - acquire the assembly with Bio::Assembly::IO::maq
#   - return the scaffold object

=head2 _run

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
  # Get command-line options
  my $options = $self->_translate_params();

  # Setup needed files and filehandles first
  my $tdir = $self->tempdir();
  my ($maph, $mapf) = $self->io->tempfile( -template => 'mapXXXX', -dir => $tdir ); #map
  my ($cnsh, $cnsf) = $self->io->tempfile( -template => 'cnsXXXX', -dir => $tdir ); #consensus
  my ($maqh, $maqf) = $self->_prepare_output_file();
  my ($nm,$dr,$suf) = fileparse($maqf,".maq");
  my $faqf = $dr.$nm.".cns.fastq";

  $_->close for ($maph, $cnsh, $maqh);

  # map reads to ref seq
  my $maq = Bio::Tools::Run::Maq->new( 
      -command => 'map'
      );
  $maq->run_maq( -map => $mapf, -bfa => $ref_file, -bfq1 => $rd1_file
		 -bfq2 => $rd2_file );
  # assemble reads into consensus
  $maq = Bio::Tools::Run::Maq->new(
      -command => 'assemble'
      );
  $maq->run_maq( -cns => $cnsf, -bfa => $ref_file, -map => $mapf );
  # convert map into plain text
  $maq = Bio::Tools::Run::Maq->new(
      -command => 'mapview'
      );
  $maq->run_maq( -map => $mapf, -txt => $maqf );
  # convert consensus into plain text fastq
  $maq = Bio::Tools::Run::Maq->new(
      -command => 'cns2fq'
      );
  $maq->run_maq( -cns => $cnsf, -faq => $faqf );
  
  return ($maqf, $cnsf);

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
	    open($out,">", $args{$1}) or $self->throw("Open for write error : $!");
	    next;
	};
	m/^2>#?(.*)/ && do {
	    open($err, ">", $args{$1}) or $self->throw("Open for write error : $!");
	    next;
	};
	m/^<#?(.*)/ && do {
	    open($in, "<", $args{$1}) or $self->throw("Open for read error : $!");
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
    my $exe = $self->executable;
    eval {
	IPC::Run::run( [$exe, 'fasta2bfa', $refseq, $ref_file] ) ||
	    die("There was a problem running $exe fasta2bfa : $!");
    };
    if ($@) {
	$self->throw( "$exe call crashed : $@" );
    }
    eval {
	IPC::Run::run( [$exe, 'fastq2bfq', $read1, $rd1_file] ) ||
	    die("There was a problem running $exe fastq2bfq : $!");
    };
    if ($@) {
	$self->throw( "$exe call crashed : $@" );
    }
    if (defined $read2) {
	($rd2_h, $rd2_file) = $self->io->tempfile( -dir => $self->tempdir() );
	$rd2_h->close;
	eval {
	    IPC::Run::run( [$exe, 'fastq2bfq', $read2, $rd2_file] ) ||
		die("There was a problem running $exe fastq2bfq : $!");
	};
	if ($@) {
	    $self->throw( "$exe call crashed : $@" );
	}
    }
    return ($rd1_file, $ref_file, $rd2_file);
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
             
=cut

sub run {
  my ($self, $rd1_file, $ref_file, $rd2_file) = @_;

  # Sanity checks
  $self->_check_executable();
#  $self->_check_sequence_input($seqs);
#  $self->_check_optional_quality_input($quals);
  $rd1_file or $self->throw("Fastq reads file required at arg 1");
  $ref_file or $self->throw("Fasta refseq file required at arg 2");
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
  return $asm
}

=head2 stdout

 Title   : stdout
 Usage   : $obj->stdout($newval)
 Function: retrieve the stdout dribble from last run
 Example : 
 Returns : value of stdout (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub stdout {
    my $self = shift;
    
    return $self->{'stdout'} = shift if @_;
    return $self->{'stdout'};
}

=head2 stderr

 Title   : stderr
 Usage   : $obj->stderr($newval)
 Function: retrieve the stderr dribble from last run
 Example : 
 Returns : value of stderr (a scalar)
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub stderr {
    my $self = shift;
    
    return $self->{'stderr'} = shift if @_;
    return $self->{'stderr'};
}



1;
