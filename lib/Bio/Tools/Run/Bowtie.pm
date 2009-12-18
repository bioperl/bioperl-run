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
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base', 'paired-reads.fastq' );
 # be more strict
 $bowtie_fac->set_parameters( -max_qual_mismatch => 50 );
 $bowtie_assy = $bowtie_fac->run( 'reads.fastq', 'index_base', 'paired-reads.fastq' );

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
 out

This indicates that ind (C<bowtie> index file base name), seq (fasta/fastq),and seq2
(fasta/fastq) files MUST be specified. Use these in the C<run_bowtie> call like so:

 $bowtiefac->run_bowtie( -ind => 'index_base', -seq => 'seq-a.fq',
                   -seq2 => 'seq-b.fq', -out => 'align.out' );

The object will store the programs STDERR output for you in the C<stderr()> attribute:

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
      push @args, '-command', 'single';
  }
  $self->_set_program_options(\@args, \@program_params, \@program_switches,
    \%param_translation, $qual_param, $use_dash, $join);
  $self->program_name($program_name) if not defined $self->program_name();
  if ($^O =~ /cygwin/) {
      my @kludge = `PATH=\$PATH:/usr/bin:/usr/local/bin which $program_name`;
      chomp $kludge[0];
      $self->program_name($kludge[0]);
  }

    ######## Should use SAM output for this, as Bio::Assembly::IO already handles this.
#    $self->set_parameters( -sam_format => 1 ) if not defined $self->sam_format;
    ######## Currently cannot deal with absence of a fasta db, which bowtie does not
    ######## need and may not be present. How to fix this?
    ######## So in future should default to SAM though this may change.
    
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
	my ($self, $rd1, $ref_file, $rd2_file) = @_;

	# Sanity checks
	$self->_check_executable();
	my $cmd = $self->command if $self->can('command');
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

	if ($self->sam_format) {
		my ($bamh, $bamf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.bam' );
		my ($srth, $srtf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.srt' );
		$_->close for ($bamh, $srth);
		
		my $samt = Bio::Tools::Run::Samtools->new( -command => 'view',
		                                           -sam_input => 1,
		                                           -bam_output => 1 );

		$samt->run( -bam => $bowtie_file, -out => $bamf);

		$samt = Bio::Tools::Run::Samtools->new( -command => 'sort' );

		$samt->run( -bam => $bamf, -pfx => $srtf);
		
		
		# Export results in desired object type
		return $self->_export_results($srtf.'.bam');
	} 
	
	return $bowtie_file;
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
    my $index=shift @files;
    for ($cmd) {
    	/^p/ && do {
    		@files = map { ( $_ , shift @files ) } ('-1','-2',undef);
    		last;
    	};
    	/^c/ && do {
    		@files = map { ( $_ , shift @files ) } ('--12',undef,undef);
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

=head2 _prepare_input_sequences()

 Prepare and check input sequences for bowtie.

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
        if ($self->inline) { # expect inline data
		        if ($read1->isa("Bio::PrimarySeqI")) { # we have a Bio::*Seq*
		                $read1=$read1->seq();
		        } else { # we have something else
		                if (ref($read1) =~ /ARRAY/i) {
		                        my @ts;
		                        foreach my $seq (@$read1) {
		                                if ($seq->isa("Bio::PrimarySeqI")) {
		                                        $seq=$seq->seq();
		                                } else {
		                                        next if $read1=~m/[[^:alpha:]]/;
		                                }
		                                push @ts,$seq;
		                        }
		                        $read1=join(',',@ts);
		                        $self->throw("bowtie requires at least one sequence read") unless (@ts);
		                } else { #must be a string... fail if non-alpha
		                        $self->throw("bowtie requires at least one valid sequence read") if $read1=~m/[[^:alpha:]]/;
		                }
		        }
		        	    
        } elsif ( -e $read1 ) { # expect a file - so test whether its appropriate
              my $cmd = $self->command if $self->can('command');
              my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$read1);
              for ($guesser->guess) {
                       m/^fasta$/ && do { 
                            ($self->fastq or $self->raw or $cmd =~ m/^c/) and $self->throw("Fasta reads file inappropriate at arg 1");
                            $self->fasta(1);
                            last;
                       };
                       m/^fastq$/ && do { 
                            ($self->fasta or $self->raw or $cmd =~ m/^c/) and $self->throw("Fastq reads file inappropriate at arg 1");
                            $self->fastq(1);
                            last;
                       };
                       m/^crossbow$/ && do { 
                            $cmd =~ m/^c/ or $self->throw("Crossbow reads file inappropriate at arg 1"); # this is unrecoverable since the object has default program defined
                            last;
                       };
                       m/^raw$/ && do { 
                            ($self->fasta or $self->fastq or $cmd =~ m/^c/) and $self->throw("Raw reads file inappropriate at arg 1");
                            $self->raw(1);
                            last;
                       }
              }
        } else {
        	     $self->throw("bowtie sequence read file does not exist");
        }
        
        return $read1;
}

=head2 _run()

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Run a bowtie alignment
 Returns :   depends on output switches (An alignment file)
 Args    :   - single end read file in fasta/fastq format
             - index base of bowtie index collection 
             - [optional] paired end read file in fasta/fastq format

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

	$bowtieh->close;

	$self->run_bowtie( -ind => $ref_file, -seq => $rd1, -seq2 => $rd2_file, -out => $bowtief );
  
	return $bowtief;
}

=head2 set_parameters()

 Title   : set_parameters
 Usage   : $pobj->set_parameters(%params);
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


sub available_commands { shift->available_parameters('commands') };

sub filespec { shift->available_parameters('filespec') };

1;
