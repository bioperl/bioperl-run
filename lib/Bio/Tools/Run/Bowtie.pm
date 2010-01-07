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

Bio::Tools::Run::Bowtie - Run wrapper for the Bowtie short-read assembler *ALPHA*

=head1 SYNOPSIS

 # create an assembly
 $bowtie_fac = Bio::Tools::Run::Bowtie->new();
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base' );
 
 # if IO::Uncompress::Gunzip is available...
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq.gz', 'index_base' );
 
 # paired-end
 $bowtie_fac = Bio::Tools::Run::Bowtie->new(-command => 'paired' );
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base', 'paired-reads.fastq' );
 
 # be more strict
 $bowtie_fac->set_parameters( -max_qual_mismatch => 50 );
 
 # create a Bio::Assembly::Scaffold object
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base', 'paired-reads.fastq'  );
 
 # print consensus sequences from assembly object
 for $contig ($bowtie_assy->all_contigs) {
    print $contig->get_consensus_sequence->seq,"\n";
 }
 

=head1 DESCRIPTION

This module provides a wrapper interface for Ben Langmead and Col
Trapnell's ultrafast memory-efficient short read aligner C<bowtie>
(see L<http://bowtie-bio.sourceforge.net/> for manuals and downloads).


=head1 OPTIONS

C<bowtie> is complex, with command-line options. This module attempts to 
provide and options comprehensively. You can browse the choices like so:

 $bowtiefac = Bio::Tools::Run::Bowtie->new( -command => 'single' );
 # all bowtie commands
 @all_commands = $bowtiefac->available_parameters('commands');
 @all_commands = $bowtiefac->available_commands; # alias
 # just for single
 @assemble_params = $bowtiefac->available_parameters('params');
 @assemble_switches = $bowtiefac->available_parameters('switches');
 @assemble_all_options = $bowtiefac->available_parameters();

Reasonably mnemonic names have been assigned to the single-letter
command line options. These are the names returned by
C<available_parameters>, and can be used in the factory constructor
like typical BioPerl named parameters.

As a number of options are mutually exclusive, and the interpretation of
intent is based on last-pass option reaching bowtie with potentially unpredicted
results. This module will prevent inconsistent switches and parameters
from being passed.

See L<http://bowtie.sourceforge.net/bowtie-manpage.shtml> for details of bowtie
options.

=head1 FILES

When a command requires filenames, these are provided to the C<run_bowtie> method, not
the constructor (C<new()>). To see the set of files required by a command, use
C<available_parameters('filespec')> or the alias C<filespec()>:

  $bowtiefac = Bio::Tools::Run::Bowtie->new( -command => 'paired' );
  @filespec = $bowtiefac->filespec;

This example returns the following array:

 ind
 seq
 seq2
 #out

This indicates that ind (C<bowtie> index file base name), seq (fasta/fastq),and seq2
(fasta/fastq) files MUST be specified, and that the out file MAY be specified. Use
these in the C<run_bowtie> call like so:

 $bowtiefac->run_bowtie( -ind => 'index_base', -seq => 'seq-a.fq',
                   -seq2 => 'seq-b.fq', -out => 'align.out' );

The object will store the programs STDOUT and STDERR output for you in the C<stdout()>
and C<stderr()> attributes:

 handle_map_warning($bowtiefac) if ($bowtiefac->stderr =~ /warning/);

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

Rather than to the module maintainer directly. Many experienced and
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
use Bio::Tools::Run::Samtools;
use File::Basename qw(fileparse);

use base qw(Bio::Root::Root Bio::Tools::Run::AssemblerBase );

## bowtie
our @program_names = qw( bowtie
                         bowtie-build
                         bowtie-inspect
                       ); # names of the executables

our $default_cmd = 'single';
our $program_name = $command_executables{$default_cmd};

# Note:
#  other globals required by Bio::Tools::Run::AssemblerBase are
#  imported from Bio::Tools::Run::Bowtie::Config

our $qual_param = undef;
our $use_dash = 'mixed';
our $join = ' ';

our $asm_format = 'bowtie';

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
		push @args, '-command', $default_cmd;
	}
	#default to SAM output if no other format specified - will then default to object creation
	unless (grep /(?:sam_format|concise|quiet|refout|refidx)/, @args) {
		push @args, '-sam_format', 1;
	}
	$self->_set_program_options(\@args, \@program_params, \@program_switches,
	                            \%param_translation, $qual_param, $use_dash, $join);
	my $cmd = $self->command if $self->can('command');
	my $program_name=$command_executables{$cmd};
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

=head2 run()

 Title   : run
 Usage   : $assembly = $bowtie_assembler->run($read1_fastq_file,
                                           $index_location,
                                           $read2_fastq_file);
 Function: Run the bowtie assembly pipeline.
 Returns : Assembly results (file, IO object or Assembly object)
 Args    : - fastq file containing single-end reads
           - name of the base of the bowtie index
           - [optional] fastq file containing paired-end reads
 Note    : gzipped inputs are allowed if IO::Uncompress::Gunzip
           is available
           
           While the intention is to return a Bio::AssemblyIO object
           this functionality has not yet been fully implemented.

=cut

sub run {
	my ($self, $arg1, $arg2, $arg3) = @_; # these are useless names because the different
	                                      # programs take very different arguments

	# Sanity checks
	$self->_check_executable();
	my $cmd = $self->command if $self->can('command');

	for ($cmd) {
		m/(?:single|paired|crossbow)/ && do {
			$arg1 or $self->throw("Fasta/fastq/raw read(s) file/Bio::Seq required at arg 1");
			$arg2 or $self->throw("Bowtie index base required at arg 2");

			# expand gzipped files as nec.
			for ($arg1, $arg3) {
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

			# confirm index files exist
			$self->_validate_file_input( -ind => $arg2 ) or
				$self->throw("Incorrect filetype (expecting bowtie index) or absent file arg 2");
		
			# bowtie prepare the multiple input types
			$arg1 = $self->_prepare_input_sequences($arg1);
			if ($cmd =~ m/^p/) {
				$arg3 && ($arg3 = $self->_prepare_input_sequences($arg3));				
			} else {
				$arg3 && $self->throw("Second sequence input not wanted for command: $cmd");
			}
			
			# Assemble
			my $suffix = $self->sam_format ? '.sam' : '.bowtie';
			$self->_assembly_format($self->sam_format ? 'sam' : 'bowtie');
			
			my ($bowtieh, $bowtief) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => $suffix );
			$bowtieh->close;
		
			$self->run_bowtie( -ind => $arg2, -seq => $arg1, -seq2 => $arg3, -out => $bowtief );
		
			if ($self->sam_format && !$self->want_raw) {
				my ($bamh, $bamf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.bam' );
				my ($srth, $srtf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.srt' );
				$_->close for ($bamh, $srth);
				
				my $samt = Bio::Tools::Run::Samtools->new( -command => 'view',
				                                           -sam_input => 1,
				                                           -bam_output => 1 );
		
				$samt->run( -bam => $bowtief, -out => $bamf);
		
				$samt = Bio::Tools::Run::Samtools->new( -command => 'sort' );
		
				$samt->run( -bam => $bamf, -pfx => $srtf);
				
				# get the sequence so samtools can work with it
				my $inspection = Bio::Tools::Run::Bowtie->new( -command => 'inspect' );
				my $refdb = $inspection->run( $arg2 );
				
				# Export results in desired object type
				return $self->_export_results($srtf.'.bam', -refdb => $refdb, -keep_asm => 1 );
			}

			return $bowtief;
		};
		
		m/build/ && do {
			$arg1 or $self->throw("Fasta read(s) file/Bio::Seq required at arg 1");
			$arg2 ||= $self->tempdir().'/index';

			# expand gzipped file as nec.
			if ($arg1 =~ (m/\.gz[^.]*$/)) {
				unless ($HAVE_IO_UNCOMPRESS) {
					croak( "IO::Uncompress::Gunzip not available, can't expand '$_'" );
				}
				my ($tfh, $tf) = $self->io->tempfile;
				my $z = IO::Uncompress::Gunzip->new($_);
				while (<$z>) { print $tfh $_ }
				close $tfh;
				$arg1 = $tf;
			}

			# bowtie prepare the two input types for the first argument
			$arg1 = $self->_prepare_input_sequences($arg1);
			$arg3 && $self->throw("Second sequence input not wanted for command: $cmd");
		
			# Build index
			my $index = $arg2; # bowtie indexes are 6 files - the return value is meaningless
			$self->run_bowtie( -ref => $arg1, -out => $arg2 );
			
			return $index;
		};
		
		m/inspect/ && do {
			$arg1 or $self->throw("Bowtie index required at arg 1");
			$self->_validate_file_input( -ind => $arg1 ) or
				$self->throw("'$arg1' doesn't look like a bowtie index or index component is missing at arg 1");
			
			# Inspect index
			my $suffix = $self->names_only ? '.text' : '.fasta';
			my ($desch, $descf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => $suffix );
			$desch->close;

			$self->run_bowtie( -ind => $arg1, -out => $descf );
			
			return $descf;
		}
	}
}

=head2 want_raw()

 Title   : want_raw
 Usage   : $bowtiefac->want_raw( $arg )
 Function: make factory return raw results in file
 Returns : boolean want_object state
 Args    : [optional] boolean

=cut

sub want_raw {
	my $self = shift;
	return $self->{'_want_raw'} = shift if @_;
	return $self->{'_want_raw'};
}

=head2 run_bowtie()

 Title   : run_bowtie
 Usage   : $obj->run_bowtie( @file_args )
 Function: Run a bowtie command as specified during object construction
 Returns :
 Args    : a specification of the files to operate on:

=cut

sub run_bowtie {
	my ($self, @args) = @_;
	# _translate_params will provide an array of command/parameters/switches
	# -- these are set at object construction
	# to set up the run, need to add the files to the call
	# -- provide these as arguments to this function

	my $cmd = $self->command if $self->can('command');
	$self->throw("No bowtie command specified for the object") unless $cmd;
	# setup files necessary for this command
	my $filespec = $command_files{$cmd};
	$self->throw("No command-line file specification is defined for command '$cmd'; check Bio::Tools::Run::Bowtie::Config") unless $filespec;

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
		m/^1?>#?(.*)/ && do {
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
	my $index=shift @files;
	for ($cmd) {
		/^p/ && do {
			@files = map { ($_, shift @files) } ('-1', '-2', undef);
			last;
		};
		/^c/ && do {
			@files = map { ($_, shift @files) } ('--12', undef, undef);
			last;
		}
	}
	@files = map { defined $_ ? $_ : () } @files; # squish undefs
	shift @$options; # dump program name

	my @ipc_args = ( $exe, @$options, $index, @files );

	eval {
		IPC::Run::run(\@ipc_args, $in, $out, $err) or
			die ("There was a problem running $exe : $!");
	};
	if ($@) {
		$self->throw("$exe call crashed: $@") unless $self->no_throw_on_crash;
		return 0;
	}

	# return arguments as specified on call
	return @args;
}

=head2 no_throw_on_crash()

 Title   : no_throw_on_crash
 Usage   : 
 Function: prevent throw on execution error
 Returns : 
 Args    : [optional] boolean

=cut

sub no_throw_on_crash {
	my $self = shift;
	return $self->{'_no_throw'} = shift if @_;
	return $self->{'_no_throw'};
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

=head2 _validate_file_input()

 Validate input file for bowtie executables.

=cut

sub _validate_file_input {
	my ($self, @args) = @_;
	my (%args);
	if (grep (/^-/, @args)) { # named parms
		$self->throw("Wrong number of args - requires one named arg") unless !(@args == 3);
		s/^-// for @args;
		%args = @args;
	} else {
		$self->throw("Must provide named filespec");
	}
	
	for (keys %args) {
		m/^seq|seq2|ref$/ && do {
			return unless ( -e $args{$_} && -r $args{$_} );
			my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$args{$_});
			return $guesser->guess if grep {$guesser->guess =~ m/$_/} @{$accepted_types{$_}};
		};
		m/^ind$/ && do {
			return 'ebwt' if
				(-e $args{$_}.'.1.ebwt' && -e $args{$_}.'.2.ebwt' && -e $args{$_}.'.3.ebwt' &&
				-e $args{$_}.'.4.ebwt' && -e $args{$_}.'.rev.1.ebwt' && -e $args{$_}.'.rev.2.ebwt');
		}
	}
	return;
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

=head2 _prepare_input_sequences()

 Prepare and check input sequences for bowtie.

=cut

sub _prepare_input_sequences {

	my ($self, @args) = @_;
	my (%args, $read);
	if (grep (/^-/, @args)) { # named parms
		$self->throw("Input args not an even number") unless !(@args % 2);
		%args = @args;
		($read) = @args{qw( -sequence )};
	} else {
		($read) = @args;
	}

	# Could use the AssemblerBase routine for this, except that would not permit
	# an array of strings - not decided at this stage.
	if ($self->inline) { # expect inline data
		if ($read->isa("Bio::PrimarySeqI")) { # we have a Bio::*Seq*
			$read=$read->seq();
		} else { # we have something else
			if (ref($read) =~ /ARRAY/i) {
				my @ts;
					foreach my $seq (@$read) {
						if ($seq->isa("Bio::PrimarySeqI")) {
							$seq=$seq->seq();
						} else {
							next if $read=~m/[[^:alpha:]]/;
						}
						push @ts,$seq;
					}
					$read=join(',',@ts);
					$self->throw("bowtie requires at least one sequence read") unless (@ts);
			} else { #must be a string... fail if non-alpha
				$self->throw("bowtie requires at least one valid sequence read") if $read=~m/[[^:alpha:]]/;
			}
		}    	    
	} else { # expect file(s) - so test whether it's/they're appropriate
	         # and make a comma-separated list of filenames
		my @t = (ref($read) =~ /ARRAY/i) ? @$read : ($read);
		for my $file (@t) {
			if ( -e $file ) {
				my $cmd = $self->command if $self->can('command');
				my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$file);
				for ($guesser->guess) {
					m/^fasta$/ && do {
						$cmd =~ m/^b/ && last;
						($cmd =~ m/^c/ or $self->fastq or $self->raw) and $self->throw("Fasta reads file '$file' inappropriate");
						$self->fasta(1);
						last;
					};
					m/^fastq$/ && do {
						($cmd =~ m/^[cb]/ or $self->fasta or $self->raw) and $self->throw("Fastq reads file '$file' inappropriate");
						$self->fastq(1);
						last;
					};
					m/^crossbow$/ && do {
						$cmd =~ m/^c/ or $self->throw("Crossbow reads file '$file' inappropriate"); # this is unrecoverable since the object has default program defined
						last;
					};
					m/^raw$/ && do {
						($cmd =~ m/^[cb]/ or $self->fasta or $self->fastq) and $self->throw("Raw reads file '$file' inappropriate");
						$self->raw(1);
						last;
					};
					do {
						$self->throw("File '$file' not a recognised bowtie input filetype");
					}
				}
			} else {
				$self->throw("Sequence read file '$file' does not exist");
			}
		}
		$read = join(',',@t);	
	}

	return $read;
}

=head2 set_parameters()

 Title   : set_parameters
 Usage   : $bowtiefac->set_parameters(%params);
 Function: sets the parameters listed in the hash or array,
           maintaining sane options.
 Returns : true on success
 Args    : [optional] hash or array of parameter/values.  

=cut

sub set_parameters {
	my ($self, @args) = @_;

	# Mutually exclusive switches/params prevented from being set to
	# avoid confusion resulting from setting incompatible switches.

	$self->throw("Input args not an even number") unless !(@args % 2);
	my %args = @args;

	foreach (keys %args) {
		s/^-//;
		foreach my $conflict (@{$incompat_params{$_}}) {
			$self->reset_parameters( '-'.$conflict => 0 );
		}
		foreach my $requirement (@{$corequisite_switches{$_}}) {
			# There is only one case and it is not a true corequisite,
			# but if it were, calling ourself would be bad, so delegate this.
			push @args, ('-'.$requirement,1);
		}
	}

	# currently stored stuff
	my $opts = $self->{'_options'};
	my $params = $opts->{'_params'};
	my $switches = $opts->{'_switches'};
	my $translation = $opts->{'_translation'};
	my $qual_param = $opts->{'_qual_param'};
	my $use_dash = $opts->{'_dash'};
	my $join = $opts->{'_join'};

	$self->_set_program_options(\@args, $params, $switches, $translation,
	                            $qual_param, $use_dash, $join);
	# the question is, are previously-set parameters left alone when
	# not specified in @args?
	$self->parameters_changed(1);

	return 1;
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

=head2 version()

 Title   : version
 Usage   : $version = $bowtiefac->version()
 Function: Returns the program version (if available)
 Returns : string representing location and version of the program

=cut

sub version{
	my ($self) = @_;

	my $cmd = $self->command if $self->can('command');

	defined $cmd or $self->throw("No command defined - cannot determine program_dir");

	my ($in, $out, $err);
	my $dum;
	$in = \$dum;
	$out = \$self->{'stdout'};
	$err = \$self->{'stderr'};

	# Get program executable
	my $exe = $self->executable;
	# Get '--version' - yes this is overkill, but want to keep this general in case the situation changes
	my $version_switch = $param_translation{"$command_prefixes{$cmd}|version"};
	my $dash = $self->{'_options'}->{'_dash'};
	for ($dash) {
		$_ == 1 && do {
			$version_switch = '-'.$version_switch;
			last;
		};
		/^s/ && do { #single dash only
			$version_switch = '-'.$version_switch;
			last;
		};
		/^d/ && do { # double dash only
			$version_switch = '--'.$version_switch;
			last;
		};
		/^m/ && do { # mixed dash: one-letter opts get -,
			$version_switch = '--'.$version_switch;
			$version_switch =~ s/--([a-z0-9](?:\s|$))/-$1/gi;
			last;
		};
		do { 
			$self->warn( "Dash spec '$dash' not recognized; using 'single'" );
			$version_switch = '-'.$version_switch;
		};
	}

	my @ipc_args = ( $exe, $version_switch );

	eval {
		IPC::Run::run(\@ipc_args, $in, $out, $err) or
			die ("There was a problem running $exe : $!");
	};
	if ($@) {
		$self->throw("$exe call crashed: $@");
	}

	my @details = split("\n",$self->stdout);
	(my $version) = grep /$exe version [[:graph:]]*$/, @details;
	$version =~ s/version //;
	(my $addressing) = grep /-bit$/, @details;

	return $version.' '.$addressing;
}

sub available_commands { shift->available_parameters('commands') };

sub filespec { shift->available_parameters('filespec') };

1;
