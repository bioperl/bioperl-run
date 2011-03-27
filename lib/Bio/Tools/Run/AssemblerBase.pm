# $Id$
#
# BioPerl module for Bio::Tools::Run::AssemblerBase
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Florent Angly <florent dot angly at gmail dot com>
#
# Copyright Florent Angly
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::AssemblerBase - base class for wrapping external assemblers

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

Describe the object here
# use of globals for configuration...
# I've created the separate Config.pm module, and 'use'd it in the 
# main module, for instance...
# other configuration globals:
# $use_dash = [1|single|double|mixed]

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

=head1 AUTHOR - Florent Angly

Email florent dot angly at gmail dot com

=head1 CONTRIBUTORS

Mark A. Jensen - maj -at- fortinbras -dot- us

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::AssemblerBase;

use strict;
use Bio::SeqIO;
use Bio::Assembly::IO;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase Bio::ParameterBaseI);

our $default_out_type = 'Bio::Assembly::ScaffoldI';

=head2 program_name

 Title   : program_name
 Usage   : $assembler>program_name()
 Function: get/set the executable name
 Returns:  string
 Args    : string

=cut

sub program_name {
    my ($self, $val) = @_;
    $self->{'_program_name'} = $val if $val;
    return $self->{'_program_name'};
}


=head2 program_dir

 Title   : program_dir
 Usage   : $assembler->program_dir()
 Function: get/set the program dir
 Returns:  string
 Args    : string

=cut

sub program_dir {
    my ($self, $val) = @_;
    $self->{'_program_dir'} = $val if $val;
    return $self->{'_program_dir'};
}


=head2 out_type

 Title   : out_type
 Usage   : $assembler->out_type('Bio::Assembly::ScaffoldI')
 Function: get/set the desired type of output
 Returns : The type of results to return
 Args    : Type of results to return (optional):
                 'Bio::Assembly::IO' object
                 'Bio::Assembly::ScaffoldI' object (default)
                 The name of a file to save the results in

=cut

sub out_type {
  my ($self, $val) = @_;
  if (defined $val) {
    $self->{'_out_type'} = $val;
  } else {
    if (not defined $self->{'_out_type'}) {
      $self->{'_out_type'} = $default_out_type;
    }
  }
  return $self->{'_out_type'};
}


=head2 _assembly_format

 Title   : _assembly_format
 Usage   : $assembler->_assembly_format('ace')
 Function: get/set the driver to use to parse the assembly results
 Returns : the driver to use to parse the assembly results
 Args    : the driver to use to parse the assembly results (optional)

=cut

sub _assembly_format {
  my ($self, $asm_format) = @_;
  if (defined $asm_format) {
    $self->{'_assembly_format'} = $asm_format;
  }
  return $self->{'_assembly_format'};
}


=head2 _assembly_variant

 Title   : _assembly_variant
 Usage   : $assembler->_assembly_variant('454')
 Function: get/set the driver variant to use to parse the assembly results. For
           example, the ACE format has the ACE-454 and the ACE-consed variants
 Returns : the driver variant to use to parse the assembly results
 Args    : the driver variant to use to parse the assembly results (optional)

=cut

sub _assembly_variant {
  my ($self, $asm_variant) = @_;
  if (defined $asm_variant) {
    $self->{'_assembly_variant'} = $asm_variant;
  }
  return $self->{'_assembly_variant'};
}


=head2 _check_executable

 Title   : _check_executable
 Usage   : $assembler->_check_executable()
 Function: Verifies that the program executable can be found, or throw an error.
 Returns:  1 for success
 Args    : -

=cut

sub _check_executable {
  my ($self) = @_;
  if (not defined $self->executable()) {
    $self->throw("Could not find the executable '".$self->program_name()."'. ".
     'You can use $self->program_dir() and $self->program_name() to '.
     "specify the location of the program.");
  }
  return 1;
}

=head2 _check_sequence_input

 Title   : _check_sequence_input
 Usage   : $assembler->_check_sequence_input($seqs)
 Function: Check that the sequence input is a valid file, or an arrayref of
             sequence objects (Bio::PrimarySeqI or Bio::SeqI). If not, an
             exception is thrown.
 Returns : 1 if the check passed
 Args    : sequence input

=cut

sub _check_sequence_input {
  my ($self, $seqs) = @_;
  if (not $seqs) {
    $self->throw("Must supply sequences as a FASTA filename or a sequence object".
      " (Bio::PrimarySeqI or Bio::SeqI) array reference");
  } else {
    if (ref($seqs) =~ m/ARRAY/i ) {
      for my $seq (@$seqs) {
        unless ($seq->isa('Bio::PrimarySeqI') || $seq->isa('Bio::SeqI')) {
          $self->throw("Not a valid Bio::PrimarySeqI or Bio::SeqI object");
        }
      }
    } else {
      if (not -f $seqs) {
        $self->throw("Input file '$seqs' does not seem to exist.");
      }
    }
  }
  return 1;
}

=head2 _check_optional_quality_input

 Title   : _check_optional_quality_input
 Usage   : $assembler->_check_optional_quality_input($quals)
 Function: If a quality score input is provided, check that it is either a
             valid file or an arrayref of quality score objects (Bio::Seq::
             QualI or Bio::Seq::Quality). If not, an exception is thrown.
 Returns : 1 if the check passed (or quality score input was provided)
 Args    : quality score input

=cut

sub _check_optional_quality_input {
  my ($self, $quals) = @_;
  if (defined $quals) {
    if (ref($quals) =~ m/ARRAY/i) {
      for my $qual (@$quals) {
        unless ($qual->isa('Bio::Seq::QualI') || $qual->isa('Bio::Seq::Quality')) {
          $self->throw("Not a valid Bio::Seq::QualI or Bio::Seq::Quality object");
        }
      }
    } else {
      if (not -f $quals) {
        $self->throw("Input file '$quals' does not seem to exist.");
      }
    }
  }
  return 1;
}


=head2 _prepare_input_file

 Title   : _prepare_input_file
 Usage   : ($fasta_file, $qual_file) =  $assembler->_prepare_input_file(\@seqs, \@quals);
 Function: Create the input FASTA and QUAL files as needed. If the input
           sequences are provided in a (FASTA) file, the optional input quality
           scores are also expected to be in a (QUAL) file. If the input
           sequences are an arrayref of bioperl sequence objects, the optional
           input quality scores are expected to be an arrayref of bioperl
           quality score objects, in the same order as the sequence objects.
 Returns : - input filehandle
           - input filename
 Args    : - sequence input (FASTA file or sequence object arrayref)
           - optional quality score input (QUAL file or quality score object
               arrayref)

=cut

sub _prepare_input_files {
  my ($self, $seqs, $quals) = @_;
  # Set up input FASTA and QUAL files
  $self->io->_initialize_io();
  #$self->tempdir();
  my $fasta_file;
  my $qual_file;
  if ( ref($seqs) =~ m/ARRAY/i ) {
    # Input sequences are an arrayref of Bioperl sequence objects
    if (defined $quals && not ref($quals) =~ m/ARRAY/i) {
      $self->throw("The input sequences are an arrayref of sequence objects. ".
        "Expecting the quality scores as an arrayref of quality score objects");
    } else {
      # The input qualities are not defined or are an arrayref of quality objects
      # Write temp FASTA and QUAL input files
      ($fasta_file, $qual_file) = $self->_write_seq_file($seqs, $quals);
    }
  } else {
    # Sequence input is a FASTA file
    $fasta_file = $seqs;
    if (defined $quals && ref($quals) =~ m/ARRAY/i) {
      # Quality input is defined and is an arrayref of quality objects
      $self->throw("The input sequences are in a FASTA file. Expecting the ".
        "quality scores in a QUAL file.");
    } else {
      # Input quality scores is either not defined or is a QUAL file
      $qual_file = $quals;
    }
  }
  return $fasta_file, $qual_file;
}


=head2 _write_seq_file

 Title   :   _write_seq_file
 Usage   :   ($fasta_file, $qual_file) = $assembler->_write_seq_file(\@seqs, \@quals)
 Function:   Write temporary FASTA and QUAL files on disk
 Returns :   name of FASTA file
             name of QUAL file (undef if no quality scoress)
 Args    :   - arrayref of sequence objects
             - optional arrayref of quality score objects

=cut

sub _write_seq_file {
  my ($self, $seqs, $quals) = @_;
  # Store the sequences in temporary FASTA files
  my $tmpdir = $self->tempdir();
  my ($fasta_h, $fasta_file) = $self->io->tempfile( -dir => $tmpdir );
  my ($qual_h,  $qual_file ) = $self->io->tempfile( -dir => $tmpdir );
  my $fasta_out = Bio::SeqIO->new( -fh => $fasta_h , -format => 'fasta');
  my $qual_out  = Bio::SeqIO->new( -fh => $qual_h  , -format => 'qual' );
  my $use_qual_file = 0;
  my $size = scalar @$seqs;
  for ( my $i = 0 ; $i < $size ; $i++ ) {
    my $seq = $$seqs[$i];
    # Make sure that all sequences have an ID (to prevent TIGR Assembler crash)
    if (not defined $seq->id) {
      my $newid = 'tmp'.$i;
      print $newid."\n";
      $seq->id($newid);
      $self->warn("A sequence had no ID. Its ID is now $newid");
    }
    my $seqid = $seq->id;
    # Write the FASTA entries in files (and QUAL if appropriate)
    $fasta_out->write_seq($seq);
    if ($seq->isa('Bio::Seq::Quality')) {
      # Quality scores embedded in seq object
      if (scalar @{$seq->qual} > 0) {
        $qual_out->write_seq($seq);
        $use_qual_file = 1;
      }
    } else {
      # Quality score in a different object from the sequence object
      my $qual = $$quals[$i];
      if (defined $qual) {
        my $qualid = $qual->id;
        if ($qualid eq $seqid) {
          # valid quality score information
          $qual_out->write_seq($qual);
          $use_qual_file = 1;
        } else {
          # ID mismatch between sequence and quality score
          $self->warn("Sequence object with ID $seqid does not match quality ".
            "score object with ID $qualid");
        }
      }
    }
  }
  close($fasta_h);
  close($qual_h);
  $fasta_out->close();
  $qual_out->close();
  return undef if scalar @$seqs <= 0;
  $qual_file = undef if $use_qual_file == 0;
  return $fasta_file, $qual_file;
}


=head2 _prepare_output_file

 Title   : _prepare_output_file
 Usage   : ($out_fh, $out_file) =  $assembler->_prepare_output_file( );
 Function: Prepare the output file
 Returns : - output filehandle
           - output filename
 Args    : none

=cut

sub _prepare_output_file {
  my ($self) = @_;
  my ($output_fh, $output_file);
  my $out_type = $self->out_type();
  if ( (not $out_type eq 'Bio::Assembly::ScaffoldI') &&
       (not $out_type eq 'Bio::Assembly::IO'       )  ) {
    # Output is a file with specified name
    $output_file = $out_type;
    open $output_fh, '>', $output_file or $self->throw("Could not write file ".
      "'$output_file': $!");
  } else {
    ( $output_fh, $output_file ) = $self->io->tempfile( -dir => $self->tempdir() );
  }
  $self->outfile_name($output_file);
  return $output_fh, $output_file;
}

=head2 _export_results

 Title   : _export_results
 Usage   : $results = $assembler->_export_results($asm_file);
 Function: Export the assembly results
 Returns : Exported assembly (file or IO object or assembly object)
 Args    : -Name of the file containing an assembly
           - -keep_asm => boolean (if true, do not unlink $asm_file)
           -[optional] additional named args required by the B:A:IO object

=cut

sub _export_results {
  my ($self, $asm_file, @named_args) = @_;
  my $results;
  my $asm_io;
  my $asm;
  my %args = @named_args;
  my $keep_asm = $args{'-keep_asm'};
  delete $args{'-keep_asm'};
  my $out_type = $self->out_type();
  if ( (not $out_type eq 'Bio::Assembly::ScaffoldI') &&
       (not $out_type eq 'Bio::Assembly::IO'       )  ) {
    # Results are the assembler output file
    $results = $asm_file;
  } else {
    $asm_io = Bio::Assembly::IO->new(
      -file    => "<$asm_file",
      -format  => $self->_assembly_format(),
      -variant => $self->_assembly_variant(),
	@named_args );
    # this unlink is a problem for Bio::DB::Sam (in B:A:I:sam), which needs
    # the original bam file around. 
    unlink $asm_file unless $keep_asm;
    if ($out_type eq 'Bio::Assembly::IO') {
      # Results are a Bio::Assembly::IO object
      $results = $asm_io;
    } else {
      $asm = $asm_io->next_assembly();
      $asm_io->close;
      if ($out_type eq 'Bio::Assembly::ScaffoldI') {
        # Results are a Bio::Assembly::Scaffold object
        $results = $asm;
      } else {
        $self->throw("The return type has to be 'Bio::Assembly::IO', 'Bio::".
          "Assembly::ScaffoldI' or a file name.");
      }
    }
  }
  $self->cleanup();
  return $results;
}


=head2 _register_program_commands()

 Title   : _register_program_commands
 Usage   : $assembler->_register_program_commands( \@commands, \%prefixes )
 Function: Register the commands a program accepts (for programs that act
           as frontends for a set of commands, each command having its own
           set of params/switches)
 Returns : true on success
 Args    : arrayref to a list of commands (scalar strings),
           hashref to a translation table of the form
           { $prefix1 => $command1, ... } [optional]
 Note    : To implement a program with this kind of calling structure, 
           include a parameter called 'command' in the 
           @program_params global
 Note    : The translation table is used to associate parameters and 
           switches specified in _set_program_options with the correct
           program command. In the globals @program_params and
           @program_switches, specify elements as 'prefix1|param' and 
           'prefix1|switch', etc.

=cut

sub _register_program_commands {
    my ($self, $commands, $prefixes) = @_;
    $self->{'_options'}->{'_commands'}      = $commands;
    $self->{'_options'}->{'_prefixes'}      = $prefixes;
    return 1;
}

=head2 _set_program_options

 Title   : _set_program_options
 Usage   : $assembler->_set_program_options( \@ args );
 Function: Register the parameters and flags that an assembler takes.
 Returns : 1 for success
 Args    : - arguments passed by the user
           - parameters that the program accepts, optional (default: none)
           - switches that the program accepts, optional (default: none)
           - parameter translation, optional (default: no translation occurs)
           - dash option for the program parameters, [1|single|double|mixed],
             optional (default: yes, use single dashes only)
           - join, optional (default: ' ')

=cut

sub _set_program_options {
  my ($self, $args, $params, $switches, $translation, $qual_param, $use_dash, $join) = @_;
  # I think we need to filter on the basis of -command here...
  my %args = @$args;
  my $cmd = $args{'-command'} || $args{'command'};
  if ($cmd) {
      my (@p,@s, %x);
      $self->warn('Command found, but no commands registered; invoke _register_program_commands') unless $self->{'_options'}->{'_commands'};
      $self->throw("Command '$cmd' not registered") unless grep /^$cmd$/, @{$self->{'_options'}->{'_commands'}};
      if ($self->{'_options'}->{'_prefixes'}) {
	  $cmd = $self->{'_options'}->{'_prefixes'}->{$cmd};
      } # else, the command is its own prefix

      # problem here: if a param/switch does not have a prefix (pfx|), then
      # should probably allow it to pass thru...
      @p = (grep(!/^.*?\|/, @$params), $cmd ? grep(/^${cmd}\|/, @$params) : ());
      @s = (grep(!/^.*?\|/, @$switches), $cmd ? grep(/^${cmd}\|/, @$switches) : ());
      s/.*?\|// for @p;
      s/.*?\|// for @s;
      @x{@p, @s} = @{$translation}{
	  grep( !/^.*?\|/, @$params, @$switches),
	  $cmd ? grep(/^${cmd}\|/, @$params, @$switches) : () };
      $translation = \%x;
      $params = \@p;
      $switches = \@s;
  }
  $self->{'_options'}->{'_params'}      = $params;
  $self->{'_options'}->{'_switches'}    = $switches;
  $self->{'_options'}->{'_translation'} = $translation;
  $self->{'_options'}->{'_qual_param'}  = $qual_param;
  if (not defined $use_dash) {
    $self->{'_options'}->{'_dash'}      = 1;
  } else {
    $self->{'_options'}->{'_dash'}      = $use_dash;
  }
  if (not defined $join) {
    $self->{'_options'}->{'_join'}      = ' ';
  } else {
    $self->{'_options'}->{'_join'}      = $join;
  }
  # if there is a parameter 'command' in @program_params, and
  # new is called with new( -command => $cmd, ... ), then 
  # _set_from_args will create an accessor $self->command containing 
  # the value $cmd...
  $self->_set_from_args(
    $args,
    -methods => [ @$params, @$switches, 'program_name', 'program_dir', 'out_type' ],
    -create =>  1,
      # when our parms are accessed, signal parameters are unchanged for
      # future reads (until set_parameters is called)
    -code => 
      'my $self = shift; 
       $self->parameters_changed(0);
       return $self->{\'_\'.$method} = shift if @_;
       return $self->{\'_\'.$method};'
  );
  return 1;
}


=head2 _translate_params

 Title   : _translate_params
 Usage   : @options = $assembler->_translate_params( );
 Function: Translate the Bioperl arguments into the arguments to pass to the
             assembler on the command line
 Returns : Arrayref of arguments
 Args    : none

=cut

sub _translate_params {
  my ($self)   = @_;

  # Get option string
  my $params   = $self->{'_options'}->{'_params'};
  my $switches = $self->{'_options'}->{'_switches'};
  my $join     = $self->{'_options'}->{'_join'};
  my $dash     = $self->{'_options'}->{'_dash'};
  my $translat = $self->{'_options'}->{'_translation'};
  # patch to access the multiple dash choices of _setparams...
  my @dash_args;
  $dash ||= 1; # default as advertised
  for ($dash) {
      $_ == 1 && do {
	  @dash_args = ( -dash => 1 );
	  last;
      };
      /^s/ && do { #single dash only
	  @dash_args = ( -dash => 1);
	  last;
      };
      /^d/ && do { # double dash only
	  @dash_args = ( -double_dash => 1);
	  last;
      };
      /^m/ && do { # mixed dash: one-letter opts get -,
                  # long opts get --
	  @dash_args = ( -mixed_dash => 1);
	  last;
      };
      do { 
	  $self->warn( "Dash spec '$dash' not recognized; using 'single'" );
	  @dash_args = ( -dash => 1 );
      };
  }
  my $options  = $self->_setparams(
    -params    => $params,
    -switches  => $switches,
    -join      => $join,
    @dash_args
  );

  # Translate options
  my @options  = split(/(\s|$join)/, $options);
  for (my $i = 0; $i < scalar @options; $i++) {
    my ($prefix, $name) = ( $options[$i] =~ m/^(-{0,2})(.+)$/ );
    if (defined $name) {
	if ($name =~ /command/i) {
	    $name = $options[$i+2]; # get the command
	    splice @options, $i, 4;
	    unshift @options, $name; # put it first
	}
	elsif (defined $$translat{$name}) {
	    $options[$i] = $prefix.$$translat{$name};
	}
    } 
    else {
	splice @options, $i, 1;
	$i--;
    }
  }
  $options = join('', @options);

  # this is a kludge for mixed options: the reason mixed doesn't 
  # work right on the pass through _setparams is that the 
  # *aliases* and not the actual params are passed to it. 
  # here we just rejigger the dashes
  if ($dash =~ /^m/) {
      $options =~ s/--([a-z0-9](?:\s|$))/-$1/gi;
  }

  # Now arrayify the options
  @options = split(' ', $options);

  return \@options;
}


=head2 _prepare_input_sequences

 Title   : _prepare_input_sequences
 Usage   : ($seqs, $quals) = $assembler->_prepare_input_sequences(\@seqs, \@quals);
 Function: Do something to the input sequence and qual objects. By default,
           nothing happens. Overload this method in the specific assembly module
           if processing of the sequences is needed (e.g. as in the
           TigrAssembler module).
 Returns : - sequence input
           - optional quality score input
 Args    : - sequence input (FASTA file or sequence object arrayref)
           - optional quality score input (QUAL file or quality score object
               arrayref)

=cut

sub _prepare_input_sequences {
  my ($self, $seqs, $quals) = @_;
  return $seqs, $quals;
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
    my @subcmds = @{$self->{'_options'}->{'_composite_commands'}->{$cmd}};
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

=head2 run

 Title   : run
 Usage   : $assembly = $assembler->run(\@seqs, \@quals);
             or
           $assembly = $assembler->run($fasta_file, $qual_file);
 Function: Run the assembler. The specific assembler wrapper needs to provide
             the $assembler->_run() method.
 Returns : Assembly results (file, IO object or Assembly object)
 Args    : - sequence input (FASTA file or sequence object arrayref)
           - optional quality score input (QUAL file or quality score object
               arrayref)

=cut

sub run {
  my ($self, $seqs, $quals) = @_;

  # Sanity checks
  $self->_check_executable();
  $self->_check_sequence_input($seqs);
  $self->_check_optional_quality_input($quals);

  # Process objects if needed
  $self->_prepare_input_sequences($seqs, $quals);

  # Write input files
  my ($fasta_file, $qual_file) = $self->_prepare_input_files($seqs,$quals);

  # If needed, set the program argument for a QUAL file
  my $qual_param = $self->{'_options'}->{'_qual_param'};
  if (defined $qual_param) {
    if ($qual_file) {
      # Set the quality input parameter
      $quals = $self->$qual_param($qual_file);
    } else {
      # Remove the quality input parameter
      $quals = $self->$qual_param(undef);
    }
  }

  # Assemble
  my $output_file = $self->_run($fasta_file, $qual_file);

  # Export results in desired object type
  my $asm = $self->_export_results($output_file);
  return $asm;
}

=head1 Bio:ParameterBaseI compliance

=head2 set_parameters()

 Title   : set_parameters
 Usage   : $pobj->set_parameters(%params);
 Function: sets the parameters listed in the hash or array
 Returns : true on success
 Args    : [optional] hash or array of parameter/values.  

=cut

sub set_parameters {
    my ($self, @args) = @_;

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

=head2 reset_parameters()

 Title   : reset_parameters
 Usage   : resets values
 Function: resets parameters to either undef or value in passed hash
 Returns : none
 Args    : [optional] hash of parameter-value pairs

=cut

sub reset_parameters {
    my ($self, @args) = @_;

    my @reset_args;
    # currently stored stuff
    my $opts = $self->{'_options'};
    my $params = $opts->{'_params'};
    my $switches = $opts->{'_switches'};
    my $translation = $opts->{'_translation'};
    my $qual_param = $opts->{'_qual_param'};
    my $use_dash = $opts->{'_dash'};
    my $join = $opts->{'_join'};

    # don't like this, b/c _set_program_args will create a bunch of
    # accessors with undef values, but oh well for now /maj

    for my $p (@$params) {
	push(@reset_args, $p => undef) unless grep /^$p$/, @args;
    }
    for my $s (@$switches) {
	push(@reset_args, $s => undef) unless grep /^$s$/, @args;
    }
    push @args, @reset_args;

    $self->_set_program_options(\@args, $params, $switches, $translation,
				$qual_param, $use_dash, $join);
    $self->parameters_changed(1);
}

=head2 parameters_changed()

 Title   : parameters_changed
 Usage   : if ($pobj->parameters_changed) {...}
 Function: Returns boolean true (1) if parameters have changed
 Returns : Boolean (0 or 1)
 Args    : [optional] Boolean

=cut

sub parameters_changed {
    my $self = shift;
    return $self->{'_parameters_changed'} = shift if @_;
    return $self->{'_parameters_changed'};
}

=head2 available_parameters()

 Title   : available_parameters
 Usage   : @params = $pobj->available_parameters()
 Function: Returns a list of the available parameters
 Returns : Array of parameters
 Args    : 'params' for settable program paramters
           'switches' for boolean program switches
           default: all 

=cut

sub available_parameters {
    my $self = shift;
    my $subset = shift;
    my $opts = $self->{'_options'};
    my @ret;
    for ($subset) {
	(!defined || /^a/) && do {
	    @ret = (@{$opts->{'_params'}}, @{$opts->{'_switches'}});
	    last;
	};
	m/^p/i && do {
	    @ret = @{$opts->{'_params'}};
	    last;
	};
	m/^s/i && do {
	    @ret = @{$opts->{'_switches'}};
	    last;
	};
	do { #fail
	    $self->throw("available_parameters: unrecognized subset");
	};
    }
    return @ret;
}

=head2 get_parameters()

 Title   : get_parameters
 Usage   : %params = $pobj->get_parameters;
 Function: Returns list of key-value pairs of parameter => value
 Returns : List of key-value pairs
 Args    : [optional] A string is allowed if subsets are wanted or (if a
           parameter subset is default) 'all' to return all parameters

=cut

sub get_parameters {
    my $self = shift;
    my $subset = shift;
    $subset ||= 'all';
    my @ret;
    my $opts = $self->{'_options'};
    for ($subset) {
	m/^p/i && do { #params only
	    for (@{$opts->{'_params'}}) {
		push(@ret, $_, $self->$_) if $self->can($_) && defined $self->$_;
	    }
	    last;
	};
	m/^s/i && do { #switches only
	    for (@{$opts->{'_switches'}}) {
		push(@ret, $_, $self->$_) if $self->can($_) && defined $self->$_;
	    }
	    last;
	};
	m/^a/i && do { # all
	    for (@{$opts->{'_params'}},@{$opts->{'_switches'}}) {
		push(@ret, $_, $self->$_) if $self->can($_) && defined $self->$_;
	    }
	    last;
	};
	do {
	    $self->throw("get_parameters: unrecognized subset");
	};
    }
    return @ret;
}

1;
