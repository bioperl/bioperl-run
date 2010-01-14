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

When a command requires filenames, these are provided to the C<_run> method, not
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
these in the C<_run> call like so:

 $bowtiefac->_run( -ind => 'index_base', -seq => 'seq-a.fq',
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

=head1 AUTHOR - Dan Kortschak

 Email dan.kortschak adelaide.edu.au

=head1 CONTRIBUTORS

 Mark A. Jensen (maj -at- fortinbras -dot- us)

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::Bowtie;
use strict;
our $HAVE_IO_UNCOMPRESS;

BEGIN {
    eval 'require IO::Uncompress::Gunzip; $HAVE_IO_UNCOMPRESS = 1';
}

use IPC::Run;

# Object preamble - inherits from Bio::Root::Root

use lib '../../..';
use Bio::Root::Root;
use Bio::Seq;
use Bio::Tools::Run::Bowtie::Config;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Run::WrapperBase::CommandExts;
use Bio::Tools::GuessSeqFormat;
use Bio::Tools::Run::Samtools;
use File::Basename qw(fileparse);

use base qw( Bio::Tools::Run::WrapperBase Bio::Tools::Run::AssemblerBase Bio::Root::Root );

## bowtie
our $program_name = '*bowtie';
our $default_cmd = 'single';

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
	unless (grep /command/, @args) {
		push @args, '-command', $default_cmd;
	}
	#default to SAM output if no other format specified - will then default to object creation
	unless (grep /(?:sam_format|concise|quiet|refout|refidx)/, @args) {
		push @args, '-sam_format', 1;
		$asm_format = 'sam';
	}
	my $self = $class->SUPER::new(@args);
	foreach (keys %command_executables) {
		my $executable = `which $command_executables{$_}`;
		chomp $executable;
		$self->executables($_, $executable);
	}
	$self->_assembly_format($asm_format);
	$self->parameters_changed(1); # set on instantiation, per Bio::ParameterBaseI
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
			
			my ($bowtieh, $bowtief) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => $suffix );
			$bowtieh->close;
		
			my %params = ( -ind => $arg2, -seq => $arg1, -seq2 => $arg3, -out => $bowtief );
			map {
				delete $params{$_} unless defined $params{$_}
			} keys %params;
			$self->_run(%params);
		
### This will be refactored into a Bio::Assembly::IO::bowtie module
#
#   Essentially just a wrapper around B:A:IO:sam - will lose SAM re/setting

			if ($self->sam_format && !$self->want_raw) {

				# we don't have the type
				my $format_tmp;
				unless	($format_tmp = $self->_assembly_format =~ /sam/i) {
					$self->_assembly_format('sam');
					$self->warn("Assembly format not appropriately set to - temporarily setting to SAM.");
				}

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

#
##
				
				# Export results in desired object type
				my $scaffold = $self->_export_results($srtf.'.bam', -refdb => $refdb, -keep_asm => 1 );

##
# This deleted during refactor

				# ... restore this because they presumably know what they are doing
				$self->_assembly_format($format_tmp);

#
#
###

				return $scaffold;
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
			$self->_run( -ref => $arg1, -out => $arg2 );
			
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

			$self->_run( -ind => $arg1, -out => $descf );
			
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
	# an array of strings
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
		my @added;
		my @removed;
		s/^-//;
		foreach my $conflict (@{$incompat_params{$_}}) {
			return if grep /$conflict/, @added;
			delete $args{'-'.$conflict};
			push @removed, $conflict;
		}
		foreach my $requirement (@{$corequisite_switches{$_}}) {
			return if grep /$requirement/, @removed;
			$args{'-'.$requirement}=1;
			push @added, $requirement;
		}
	}

	# check for asm_format change requirements
	return unless $self->_check_format_modifiers(%args);

	return $self->SUPER::set_parameters(%args);
}

=head2 reset_parameters()

 Title   : reset_parameters
 Usage   : $bowtiefac->reset_parameters(%params);
 Function: resets the parameters listed in the hash or array,
           maintaining sane options.
 Returns : none
 Args    : [optional] hash or array of parameter/values.  

=cut

sub reset_parameters {
	my ($self, @args) = @_;

	# Mutually exclusive switches/params prevented from being reset to
	# avoid confusion resulting from resetting corequireed switches.

	$self->throw("Input args not an even number") unless !(@args % 2);
	my %args = @args;

	foreach (keys %args) {
		s/^-//;
		foreach my $requirement (@{$corequisite_switches{$_}}) {
			delete $args{'-'.$requirement};
		}
	}

	# check for asm_format change requirements
	return unless $self->_check_format_modifiers(%args);

	$self->SUPER::reset_parameters(%args);
}

=head2 _check_format_modifiers()

 Title   : _check_format_modifiers
 Usage   : $bowtiefac->_check_format_modifiers(%params);
 Function: sets _assembly_format appropriately for chosen switches
 Returns : boolean success or failure
 Args    : hash or array of parameter/values.  

=cut

sub _check_format_modifiers {
	my ($self, @args) = @_;
	s/^-// for @args;
	my %args = @args;

	my %formats;
	my @format_modifiers = keys %format_lookup;
	@formats{@format_modifiers} = @args{@format_modifiers};
	foreach (keys %formats) {
		$self->_assembly_format(undef) if !$formats{$_} and
		                                  $self->_assembly_format() =~ m/$format_lookup{$_}/;
		delete $formats{$_} unless $formats{$_};
	}
	if (!keys %formats) {
		$self->_assembly_format('bowtie') unless $self->_assembly_format();
	} elsif (keys %formats == 1) {
		my ($format) = (keys %formats);
		$self->_assembly_format($format_lookup{$format});
	} else {
		return;
	}

	return 1;
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

	defined $cmd or $self->throw("No command defined - cannot determine program executable");

	my ($in, $out, $err);
	my $dum;
	$in = \$dum;
	$out = \$self->{'stdout'};
	$err = \$self->{'stderr'};

	# Get program executable
	my $exe = $self->executable;
	# Get version switch from switches, translate and dash it
	my $version_switch = $param_translation{"$command_prefixes{$cmd}|version"};
	$version_switch = $self->_dash_switch( $version_switch );

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
