# $Id: Bowtie.pm kortsch $
#
# BioPerl module for Bio::Tools::Run::Bowtie
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Dan Kortschak <dan.kortschak@adelaide.edu.au>
#
# Copyright Dan Kortschak and Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Bowtie - Run wrapper for the Bowtie short-read assembler *BETA*

=head1 SYNOPSIS

 # create an assembly
 $bowtie_fac = Bio::Tools::Run::Bowtie->new();
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'refseq.fas' );
 # if IO::Uncompress::Gunzip is available...
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq.gz', 'refseq.gz');
 # paired-end
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'refseq.fas', 'paired-reads.fastq');
 # be more strict
 $bowtie_fac->set_parameters( -c2q_min_map_quality => 60 );
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'refseq.fas', 'paired-reads.fastq');

 # run bowtie commands separately
 $bowtie_fac = Bio::Tools::Run::Bowtie->new(
    -command => 'pileup',
    -single_end_quality => 1 );
 $bowtie_fac->run_bowtie( -bfa => 'refseq.bfa',
                    -map => 'bowtie_assy.map',
                    -txt => 'bowtie_assy.pup.txt' );

=head1 DESCRIPTION

This module provides a wrapper interface for Ben Langmead and Col
Trapnell's ultrafast memory-efficient short read aligner C<bowtie>
(see L<http://bowtie-bio.sourceforge.net/> for manuals and downloads).


=head1 OPTIONS

C<bowtie> is complex, with many subprograms (commands) and command-line
options and file specs for each. This module attempts to provide
commands and options comprehensively. You can browse the choices like so:

 $bowtiefac = Bio::Tools::Run::Bowtie->new( -command => 'assemble' );
 # all bowtie commands
 @all_commands = $bowtiefac->available_parameters('commands');
 @all_commands = $bowtiefac->available_commands; # alias
 # just for assemble
 @assemble_params = $bowtiefac->available_parameters('params');
 @assemble_switches = $bowtiefac->available_parameters('switches');
 @assemble_all_options = $bowtiefac->available_parameters();

Reasonably mnemonic names have been assigned to the single-letter
command line options. These are the names returned by
C<available_parameters>, and can be used in the factory constructor
like typical BioPerl named parameters.

See L<http://bowtie.sourceforge.net/bowtie-manpage.shtml> for the gory details.

=head1 FILES

When a command requires filenames, these are provided to the C<run_bowtie> method, not
the constructor (C<new()>). To see the set of files required by a command, use
C<available_parameters('filespec')> or the alias C<filespec()>:

  $bowtiefac = Bio::Tools::Run::Bowtie->new( -command => 'map' );
  @filespec = $bowtiefac->filespec;

This example returns the following array:

 map
 bfa
 bfq1
 #bfq2
 2>#log

This indicates that map (C<bowtie> binary mapfile), bfa (C<bowtie> binary
fasta), and bfq (C<bowtie> binary fastq) files MUST be specified, another
bfq file MAY be specified, and a log file receiving STDERR also MAY be
specified. Use these in the C<run_bowtie> call like so:

 $bowtiefac->run_bowtie( -map => 'my.map', -bfa => 'myrefseq.bfa',
                   -bfq1 => 'reads1.bfq', -bfq2 => 'reads2.bfq' );

Here, the C<log> parameter was unspecified. Therefore, the object will store
the programs STDERR output for you in the C<stderr()> attribute:

 handle_map_warning($bowtiefac) if ($bowtiefac->stderr =~ /warning/);

STDOUT for a run is also saved, in C<stdout()>, unless a file is specified
to slurp it according to the filespec. C<bowtie> STDOUT usually contains useful
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

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Dan Kortschak (based heavily on code by Mark A. Jensen)

 Email dan.kortschak adelaide.edu.au

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::Bowtie;
use strict;
our $HAVE_IO_UNCOMPRESS;

BEGIN {
    eval "require IO::Uncompress::Gunzip; $HAVE_IO_UNCOMPRESS = 1";
}

use IPC::Run;

# Object preamble - inherits from Bio::Root::Root

use lib '../../..';
use Bio::Root::Root;
use Bio::Seq;
use Bio::Tools::Run::Bowtie::Config;
use Bio::Tools::GuessSeqFormat;
use File::Basename qw(fileparse);

use base qw(Bio::Root::Root Bio::Tools::Run::AssemblerBase );

## bowtie
our $program_name = 'bowtie'; # name of the executable

# Note:
#  other globals required by Bio::Tools::Run::AssemblerBase are
#  imported from Bio::Tools::Run::Bowtie::Config

our $qual_param = 'quality_file';
our $use_dash = 'mixed';
our $join = ' ';

our $asm_format = 'sam';

=head2 new()

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::Bowtie();
 Function: Builds a new Bio::Tools::Run::Bowtie object
 Returns : an instance of Bio::Tools::Run::Bowtie
 Args    :

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->parameters_changed(1);
  $self->_register_program_commands( \@program_commands, \%command_prefixes );
  unless (grep /command/, @args) {
      push @args, '-command', 'bowtie';
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
 Usage   : $assembly = $bowtie_assembler->run($read1_fastq_file,
                                           $refseq_fasta_file,
                                           $read2_fastq_file);
 Function: Run the bowtie assembly pipeline.
 Returns : Assembly results (file, IO object or Assembly object)
 Args    : - fastq file containing single-end reads
           - fasta file containing the reference sequence
           - [optional] fastq file containing paired-end reads
 Note    : gzipped inputs are allowed if IO::Uncompress::Gunzip
           is available

=cut

sub run {
	my ($self, $rd1, $ref_file, $rd2_file) = @_;

	# Sanity checks
	$self->_check_executable();
	$rd1 or $self->throw("Fasta/q reads file/Bio::Seq required at arg 1");
	$ref_file or $self->throw("Bowtie index required at arg 2");
	# expand gzipped files as nec.
	for ($rd1, $rd2_file) {
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
	# confirm non-converted files exist
	(-e $ref_file.'.1.ebwt' && -e $ref_file.'.2.ebwt' && -e $ref_file.'.3.ebwt' &&
	-e $ref_file.'.4.ebwt' && -e $ref_file.'.rev.1.ebwt' && -e $ref_file.'.rev.2.ebwt') or
		$self->throw("Index doesn't look like a bowtie index or index component is missing at arg 2");
	if ($rd2_file) {
		my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$rd2_file);
		$guesser->guess =~ m/^fast[qa]$/ or $self->throw("Reads file doesn't look like fasta/q at arg 3");
	}

	# bowtie prepare the multiple input types for the first argument
	$rd1 = $self->_prepare_input_sequences($rd1);

	# Assemble
	my $bowtie_file = $self->_run($rd1, $ref_file, $rd2_file);

	# Export results in desired object type
	return $self->_export_results($bowtie_file);
}

=head2 run_bowtie()

 Title   : run_bowtie
 Usage   : $obj->run_bowtie( @file_args )
 Function: Run a bowtie command as specified during object contruction
 Returns :
 Args    : a specification of the files to operate on:

=cut

sub run_bowtie {
    my ($self, @args) = @_;
    # _translate_params will provide an array of command/parameters/switches
    # -- these are set at object construction
    # to set up the run, need to add the files to the call
    # -- provide these as arguments to this function
    
    
    ######## MUST use SAM output for this, as Bio::Assembly::IO already handles this.


    my $cmd = $self->command if $self->can('command');
    $self->throw("No bowtie command specified for the object") unless $cmd;
    # setup files necessary for this command
    my $filespec = $command_files{$cmd};
    $self->throw("No command-line file specification is defined for command '$cmd'; check Bio::Tools::Run::Bowtie:
:Config") unless $filespec;

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
           if no file specified in run_bowtie()
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
           if no file is specified in run_bowtie()
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

 Convert input fastq and fasta to bowtie format.

=cut

sub _prepare_input_sequences {

	my ($self, @args) = @_;
	my (%args, $read1);
	if (grep (/^-/, @args)) { # named parms
		$self->throw("Input args not an even number") unless !(@args % 2);
		%args = @args;
		($read1) = @args{qw( -read1 )};
	} else {
		($read1) = @args;
	}

	# Could use the AssemblerBase routine for this, except that would not permit
	# an array of strings - not decided at this stage.
	if (-e $read1) {
		my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$read1);
		$guesser->guess =~ m/^fast[qa]$/ or $self->throw("Reads file doesn't look like fasta/q at arg 1");
	} elsif (!$read1->isa("Bio::PrimarySeqI")) {
		if (ref($read1) =~ /ARRAY/i) {
			my @ts;
			foreach my $seq (@$read1) {
				unless ($seq->isa("Bio::PrimarySeqI")) {
					next if $read1=~m/[[^:alpha:]]/;
					push @ts,Bio::Seq->new(-seq => $read1);
				}
			}
			@$read1=@ts;
			$self->throw("bowtie requires at least one sequence read") unless (@$read1);
		} else { #must be a string - > convert to Bio::Seq object or...
			$self->throw("bowtie requires at least one sequence read") if $read1=~m/[[^:alpha:]]/;
			$read1=Bio::Seq->new(-seq => $read1, -alphabet => 'dna');
		}
	}
	
	return $read1;
}

=head2 _run()

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Run a bowtie assembly pipeline
 Returns :   depends on call (An assembly file)
 Args    :   - single end read file in bowtie bfq format
             - reference seq file in bowtie bfa format
             - [optional] paired end read file in bowtie bfq format

=cut

sub _run {
	my ($self, $rd1, $ref_file, $rd2_file) = @_;
	my ($cmd, $filespec, @ipc_args);
	# Get program executable
	my $exe = $self->executable;

	# treat run() as a separate command and duplicate the component-specific
	# parameters in the config globals

	# Setup needed files and filehandles first
	my ($bowtieh, $bowtief) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.sam' );
	my ($nm,$dr,$suf) = fileparse($bowtief,'.sam');

	$bowtieh->close;

	$self->run_bowtie( -ref_seq => $ref_file, -rd1 => $rd1, -rd2 => $rd2_file, -out => $bowtief );
  
	return $bowtief;
}

=head2 available_parameters()

 Title   : available_parameters
 Usage   : @cmds = $fac->available_commands('commands');
 Function: Use to browse available commands, params, or switches
 Returns : array of scalar strings
 Args    : 'commands' : all bowtie commands
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
