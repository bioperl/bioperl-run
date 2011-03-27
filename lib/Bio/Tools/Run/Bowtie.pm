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

 # create an index
 $bowtie_build = Bio::Tools::Run::Bowtie->new();
 $index = $bowtie_fac->run( 'reference.fasta', 'index_base' );

 # or with named args...

 $index = $bowtie_fac->run( -ref => 'reference.fasta', -ind => 'index_base' );

 # get the base name of the last index from an index builder
 $index = $bowtie_fac->result;
 
 # create an assembly
 $bowtie_fac = Bio::Tools::Run::Bowtie->new();
 $bowtie_fac->want('Bio::Assembly::Scaffold');
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base' );
 
 # if IO::Uncompress::Gunzip is available and with named args...
 $bowtie_assy = $bowtie_fac->run( -seq => 'reads.fastq.gz', -ind => 'index_base' );
 
 # paired-end
 $bowtie_fac = Bio::Tools::Run::Bowtie->new(-command => 'paired',
                                            -want => 'Bio::Assembly::Scaffold');
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base', 'paired-reads.fastq' );
 
 # be more strict
 $bowtie_fac->set_parameters( -max_qual_mismatch => 50 );
 
 # create a Bio::Assembly::Scaffold object
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base', 'paired-reads.fastq'  );
 
 # print consensus sequences from assembly object
 for $contig ($bowtie_assy->all_contigs) {
    print $contig->get_consensus_sequence->seq,"\n";
 }
 
 # get the file object of the last assembly
 $io = $bowtie_fac->result( -want => 'Bio::Root::IO' );
 
 # get a merged SeqFeature::Collection of all hits
 #  - currently only available with SAM format 
 $io = $bowtie_fac->result( -want => 'Bio::SeqFeature::Collection' );
 
 #... or the file name directly
 $filename = $bowtie_fac->result( -want => 'raw' );
 
=head1 DESCRIPTION

This module provides a wrapper interface for Ben Langmead and Col
Trapnell's ultrafast memory-efficient short read aligner C<bowtie>
(see L<http://bowtie-bio.sourceforge.net/> for manuals and downloads).


=head1 OPTIONS

C<bowtie> is complex, with many command-line options. This module attempts to 
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

When a command requires filenames, these are provided to the C<run> method, not
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
these in the C<run> call like so:

 $bowtiefac->run( -ind => 'index_base', -seq => 'seq-a.fq',
                  -seq2 => 'seq-b.fq', -out => 'align.out' );

Note that named parameters in this form allow you to specify the location of the outfile;
without named parameters, the outfile is located in a tempdir and does not persist beyond
the life of the object - with the exception of index creation.

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

  http://redmine.open-bio.org/projects/bioperl/

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
use Bio::Tools::Run::Bowtie::Config;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Run::WrapperBase::CommandExts;
use Bio::Tools::GuessSeqFormat;
use Bio::Tools::Run::Samtools;
use Bio::Seq;
use File::Basename;

use base qw( Bio::Tools::Run::WrapperBase Bio::Tools::Run::AssemblerBase );

## bowtie
our $program_name = '*bowtie';
our $default_cmd = 'single';

our $asm_format; # this is determined dynamically

# Note:
#  other globals required by Bio::Tools::Run::AssemblerBase are
#  imported from Bio::Tools::Run::Bowtie::Config

our $qual_param = undef;
our $use_dash = 'mixed';
our $join = ' ';

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
	#default to SAM output if no other format specified and we are running an alignment
	my %args=@args;
	if ($args{'-command'} =~ m/(?:single|paired|crossbow)/) {
		unless (grep /(?:sam_format|concise|quiet|refout|refidx)/, @args) {
			push @args, ('-sam_format', 1);
		}
	}
	my $self = $class->SUPER::new(@args);
	foreach (keys %command_executables) {
		$self->executables($_, $self->_find_executable($command_executables{$_}));
	}
	my ($want) = $self->_rearrange([qw(WANT)],@args);
	$self->want($want);
	$asm_format = $self->_assembly_format;
	$self->parameters_changed(1); # set on instantiation, per Bio::ParameterBaseI
	return $self;
}

=head2 run()

 Title   : run
 Usage   : $assembly = $bowtie_assembler->run($read1_fastq_file,
                                           $index_location,
                                           $read2_fastq_file);
           $assembly = $bowtie_assembler->run(%params);
 Function: Run the bowtie assembly pipeline.
 Returns : Assembly results (file, IO object or Assembly object)
 Args    : - fastq file containing single-end reads
           - name of the base of the bowtie index
           - [optional] fastq file containing paired-end reads
           Named params are also available with args:
           -seq, -seq2, -ind (bowtie index), -ref (fasta reference) and -out
 Note    : gzipped inputs are allowed if IO::Uncompress::Gunzip
           is available
           The behaviour for locating indexes follows the definition in
           the bowtie manual - you may use the environment variable
           BOWTIE_INDEXES to specify the index path or use an 'indexes'
           directory under the directory where the bowtie executable
           is located

=cut

sub run {
	my $self = shift;

	my ($arg1, $arg2, $arg3);                # these are useless names because the different
	                                         # programs take very different arguments
	my ($index, $seq, $seq2, $ref, $out); # these are the meaningful names that are used
	                                         # with named args

	if (!(@_ % 2)) {
		my %args = @_;
		if ((grep /^-\w+/, keys %args) == keys %args) {
			($index, $seq, $seq2, $ref, $out) =
				$self->_rearrange([qw( IND SEQ SEQ2 REF OUT )], @_);
		} elsif (grep /^-\w+/, keys %args) {
			$self->throw("Badly formed named args: ".join(' ',@_));
		} else {
			($arg1, $arg2) = @_;
		}
	} else {
		if (grep /^-\w+/, @_) {
			$self->throw("Badly formed named args: ".join(' ',@_));
		} else {
			($arg1, $arg2, $arg3) = @_;
		}
	}

	# Sanity checks
	$self->_check_executable();
	my $cmd = $self->command if $self->can('command');

	for ($cmd) {
		m/(?:single|paired|crossbow)/ && do {
			$seq ||= $arg1;
			$index ||= $arg2;
			$seq2 ||= $arg3;
			$seq or $self->throw("Fasta/fastq/raw read(s) file/Bio::Seq required at arg 1/-seq");
			$index or $self->throw("Bowtie index base required at arg 2/-index");

			# expand gzipped files as nec.
			for ($seq, $seq2) {
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
			$self->_validate_file_input( -ind => $index ) or
			($self->_validate_file_input( -ind => $self->io->catfile(dirname($self->executable),'indexes',$index)) and 
				$index = $self->io->catfile(dirname($self->executable),'indexes',$index)) or
			($self->_validate_file_input( -ind => $self->io->catfile($ENV{BOWTIE_INDEXES},$index)) and
			        $index = $self->io->catfile($ENV{BOWTIE_INDEXES},$index)) or
					$self->throw("Incorrect filetype (expecting bowtie index) or absent file arg 2/-index");
		
			# bowtie prepare the multiple input types
			$seq = $self->_prepare_input_sequences($seq);
			if ($cmd =~ m/^p/) {
				$seq2 && ($seq2 = $self->_prepare_input_sequences($seq2));				
			} else {
				$seq2 && $self->throw("Second sequence input not wanted for command: $cmd");
			}
			
			# Assemble
			my $format = $self->_assembly_format;
			my $suffix = '.'.$format;
			
			if ($out) {
				$out .= $suffix;
			} else {
				my ($bowtieh, $bowtief) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => $suffix );
				$bowtieh->close;
				$out = $bowtief;
			}

			my %params = ( -ind => $index, -seq => $seq, -seq2 => $seq2, -out => $out );
			map {
				delete $params{$_} unless defined $params{$_}
			} keys %params;
			$self->_run(%params);
			
			$self->{'_result'}->{'index'} = $index;
			$self->{'_result'}->{'file_name'} = $out;
			$self->{'_result'}->{'format'} = $format;
			$self->{'_result'}->{'file'} = Bio::Root::IO->new( -file => $out );
			
			return $self->result;
		};
		
		m/build/ && do {
			$ref ||= $arg1;
			$index ||= $arg2;
			$ref or $self->throw("Fasta read(s) file/Bio::Seq required at arg 1/-ref");
			$index ||= $self->io->tempdir(CLEANUP => 1).'/index'; # we want a new one each time
			$arg3 && $self->throw("Second sequence input not wanted for command: $cmd");

			my $format = $self->_assembly_format;
			
			# expand gzipped file as nec.
			if ($ref =~ (m/\.gz[^.]*$/)) {
				unless ($HAVE_IO_UNCOMPRESS) {
					croak( "IO::Uncompress::Gunzip not available, can't expand '$_'" );
				}
				my ($tfh, $tf) = $self->io->tempfile;
				my $z = IO::Uncompress::Gunzip->new($_);
				while (<$z>) { print $tfh $_ }
				close $tfh;
				$ref = $tf;
			}

			# bowtie prepare the two input types for the first argument
			$ref = $self->_prepare_input_sequences($ref);
		
			# Build index
			$self->_run( -ref => $ref, -out => $index );
			$self->{'_result'}->{'format'} = $format;
			$self->{'_result'}->{'file_name'} = $index;
			
			return $index;
		};
		
		m/inspect/ && do {
			$index ||= $arg1;
			$out ||= $arg2;
			$index or $self->throw("Bowtie index required at arg 1");

			$self->_validate_file_input( -ind => $index ) or
			($self->_validate_file_input( -ind => $self->io->catfile(dirname($self->executable),'indexes',$index)) and 
				$index = $self->io->catfile(dirname($self->executable),'indexes',$index)) or
			($self->_validate_file_input( -ind => $self->io->catfile($ENV{BOWTIE_INDEXES},$index)) and
			        $index = $self->io->catfile($ENV{BOWTIE_INDEXES},$index)) or
					$self->throw("'$index' doesn't look like a bowtie index or index component is missing at arg 1/-ind");
			$arg3 && $self->throw("Second sequence input not wanted for command: $cmd");

			# Inspect index
			my $format = $self->_assembly_format;
			my $suffix = '.'.$format;

			if ($out) {
				$out .= $suffix;
			} else {
				my ($desch, $descf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => $suffix );
				$desch->close;
				$out = $descf;
			}

			$self->_run( -ind => $index, -out => $out );
			
			$self->{'_result'}->{'file_name'} = $out;
			$self->{'_result'}->{'format'} = $format;
			$self->{'_result'}->{'file'} = Bio::Root::IO->new( -file => $out );
			
			return $self->result;
		}
	}
}

=head2 want()

 Title   : want
 Usage   : $bowtiefac->want( $class )
 Function: make factory return $class, or raw (scalar) results in file
 Returns : return wanted type
 Args    : [optional] string indicating class or raw of wanted result

=cut

sub want {
	my $self = shift;
	return $self->{'_want'} = shift if @_;
	return $self->{'_want'};
}

=head2 result()

 Title   : result
 Usage   : $bowtiefac->result( [-want => $type|$format] )
 Function: return result in wanted format
 Returns : results
 Args    : [optional] hashref of wanted type

=cut

sub result {
	my ($self, @args) = @_;
	
	my $want = $self->want ? $self->want : $self->want($self->_rearrange([qw(WANT)],@args));
	my $cmd = $self->command if $self->can('command');
	my $format = $self->{'_result'}->{'format'};

	return $self->{'_result'}->{'format'} if (defined $want && $want eq 'format');
	return $self->{'_result'}->{'file_name'} if (!$want || $want eq 'raw' || $cmd eq 'build');
	return $self->{'_result'}->{'file'} if ($want =~ m/^Bio::Root::IO/);
	
	for ($cmd) {
		m/(?:single|paired|crossbow)/ && do {
			my $scaffold;
			for ($format) {
				m/^bowtie/i && $want =~ m/^Bio::Assembly::Scaffold/ && do {
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::Assembly::Scaffold/) {
							$self->{'_result'}->{'object'} =
								$self->_export_results( $self->{'_result'}->{'file_name'},
								                       -index => $self->{'_result'}->{'index'},
								                       -keep_asm => 1 );
					}
					last;
				};
				m/^bowtie/i && $want =~ m/^Bio::SeqFeature::Collection/ && do {
					$self->warn("Don't know how to create a $want object for $cmd with bowtie format - try SAM format.");
					last;
				};
				m/^sam/i && $want =~ m/^Bio::Assembly::Scaffold/ && do {
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::Assembly::Scaffold/) {
							my $bamf = $self->_make_bam($self->{'_result'}->{'file_name'}, 1);
							my $inspector = Bio::Tools::Run::Bowtie->new( -command => 'inspect' );
							my $refdb = $inspector->run($self->{'_result'}->{'index'});
							$self->{'_result'}->{'object'} =
								$self->_export_results($bamf, -refdb => $refdb, -keep_asm => 1 );
					}
					last;
				};
				m/^sam/i && $want =~ m/^Bio::SeqFeature::Collection/ && do {
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::Assembly::Scaffold/) {
							my $bamf = $self->_make_bam($self->{'_result'}->{'file_name'}, 0);
							my $convert = Bio::Tools::Run::BEDTools->new( -command => 'bam_to_bed' );
							my $bedf = $convert->run( -bed => $bamf );
							my $merge = Bio::Tools::Run::BEDTools->new( -command => 'merge' );
							$merge->run($self->{'_result'}->{'index'});
							$self->{'_result'}->{'object'} = $merge->result( -want => $want );
					}
					last;
				};
				do {
					$self->warn("Don't know how to create a $want object for $cmd.");
					return;
				}
			};
			last;
		};
		m/inspect/ && do {
			for ($want) {
				m/^Bio::SeqIO/ && $format eq 'fasta' && do {
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::SeqIO/) {
							$self->{'_result'}->{'object'} =
								Bio::SeqIO->new(-file => $self->{'_result'}->{'file'},
								                -format => 'fasta');
					}
					last;
				};
				m/^Bio::SeqIO/ && $format ne 'fasta' && do {
					$self->warn("Don't know how to create a $want object for names only - try -want => 'Bio::Root::IO'.");
					return;
				};
				do {
					$self->warn("Don't know how to create a $want object for $cmd.");
					return;
				}
			}
		}
	}
	
	return $self->{'_result'}->{'object'};
}

=head2 _determine_format()

 Title   : _determine_format
 Usage   : $bowtiefac->_determine_format
 Function: determine the format of output for current options
 Returns : format of bowtie output
 Args    :

=cut

sub _determine_format {
        my ($self) = shift;

	my $cmd = $self->command if $self->can('command');
	for ($cmd) {
		m/build/ && do {
			return 'ebwt';
		};
		m/inspect/ && do {
			$self->{'_summary'} && return 'text';
			return $self->{'_names_only'} ? 'text' : 'fasta';
		};
		m/(?:single|paired|crossbow)/ && do {
			my $format = 'bowtie'; # this is our default position
			for (keys %format_lookup) {
				$format = $format_lookup{$_} if $self->{'_'.$_};
			}
			return $format;
		}
	}
}

=head2 _make_bam()

 Title   : _make_bam
 Usage   : $bowtiefac->_make_bam( $file, $sort )
 Function: make a sorted BAM format file from SAM file
 Returns : sorted BAM file name
 Args    : SAM file name and boolean flag to select sorted BAM format

=cut

sub _make_bam {
        my ($self, $file, $sort) = @_;
        
        $self->throw("'$file' does not exist or is not readable")
                unless ( -e $file && -r _ );

        # make a sorted bam file from a sam file input
        my ($bamh, $bamf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.bam' );
	$bamh->close;
        
        my $samt = Bio::Tools::Run::Samtools->new( -command => 'view',
                                                   -sam_input => 1,
                                                   -bam_output => 1 );

        $samt->run( -bam => $file, -out => $bamf );

	if ($sort) {
		my ($srth, $srtf) = $self->io->tempfile( -dir => $self->io->tempdir(CLEANUP=>1), -suffix => '.srt' ); 
			# shared tempdir, so make new - otherwise it is scrubbed during Bio::DB::Sam
		$srth->close;
		
		$samt = Bio::Tools::Run::Samtools->new( -command => 'sort' );
		$samt->run( -bam => $bamf, -pfx => $srtf);
		
		return $srtf.'.bam';
	} else {
		return $bamf;
	}
}

=head2 _validate_file_input()

 Title   : _validate_file_input
 Usage   : $bowtiefac->_validate_file_input( -type => $file )
 Function: validate file type for file spec
 Returns : file type if valid type for file spec
 Args    : hash of filespec => file_name

=cut

sub _validate_file_input {
	my ($self, @args) = @_;
	my (%args);
	if (grep (/^-/, @args)) { # named parms
		$self->throw("Wrong number of args - requires one named arg") if (@args > 2);
		s/^-// for @args;
		%args = @args;
	} else {
		$self->throw("Must provide named filespec");
	}
	
	for (keys %args) {
		m/^seq|seq2|ref$/ && do {
			return unless ( -e $args{$_} && -r _ );
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

=head2 _assembly_format()

 Title   : _assembly_format
 Usage   : $bowtiefac->_determine_format
 Function: set the format of output for current options
 Returns : format of bowtie output
 Args    :

=cut

sub _assembly_format {
	my $self = shift;

	my $format = $self->_determine_format;
	return $self->SUPER::_assembly_format($format);
}
	

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
		if (UNIVERSAL::isa($read,'can') && $read->isa("Bio::PrimarySeqI")) { # we have a Bio::*Seq*
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
				$self->throw("bowtie requires at least one sequence read") unless (@ts);
				if (@ts>1) {
					$read="'".join(',',@ts)."'";
				} else {
					($read)=@ts;
				} 
			} else { #must be a string... fail if non-alpha
				$self->throw("bowtie requires at least one valid sequence read") if $read=~m/[[^:alpha:]]/;
			}
		}    	    
	} else { # expect file(s) - so test whether it's/they're appropriate
	         # and make a comma-separated list of filenames
		my @ts = (ref($read) =~ /ARRAY/i) ? @$read : ($read);
		for my $file (@ts) {
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
					m/^tab$/ && do {
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
		if (@ts>1) {
			$read="'".join(',',@ts)."'";
		} else {
			($read)=@ts;
		} 
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
 Note    : This will unset conflicts and set required options,
           but will not prevent non-sane requests in the arguments

=cut

sub set_parameters {
	my ($self, @args) = @_;

	# Mutually exclusive switches/params prevented from being set to
	# avoid confusion resulting from setting incompatible switches.

	$self->throw("Input args not an even number") if (@args % 2);
	my %args = @args;


	foreach (keys %args) {
		my @added;
		my @removed;
		s/^-//;
		foreach my $conflict (@{$incompat_params{$_}}) {
			return if grep /$conflict/, @added;
			delete $args{'-'.$conflict};
			$args{'-'.$conflict} = undef if $self->{'_'.$conflict};
			push @removed, $conflict;
		}
		foreach my $requirement (@{$corequisite_switches{$_}}) {
			return if grep /$requirement/, @removed;
			$args{'-'.$requirement}=1 if $args{$_};
			push @added, $requirement;
		}
	}

	return $self->SUPER::set_parameters(%args);
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
