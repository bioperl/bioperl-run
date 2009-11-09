package Bio::Tools::Run::AssemblerBase;

use strict;
use Bio::SeqIO;
use Bio::Assembly::IO;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

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
 Usage   : $assembler->_assembly_format('tigr')
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

=cut

sub _export_results {
  my ($self, $asm_file) = @_;
  my $results;
  my $asm_io;
  my $asm;
  my $out_type = $self->out_type();
  if ( (not $out_type eq 'Bio::Assembly::ScaffoldI') &&
       (not $out_type eq 'Bio::Assembly::IO'       )  ) {
    # Results are the assembler output file
    $results = $asm_file;
  } else {
    $asm_io = Bio::Assembly::IO->new(
      -file   => "<$asm_file",
      -format => $self->_assembly_format() );
    unlink $asm_file;
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

=head2 _set_program_options

 Title   : _set_program_options
 Usage   : $assembler->_set_program_options( \@ args );
 Function: Register the parameters and flags that an assembler takes.
 Returns : 1 for success
 Args    : - arguments passed by the user
           - parameters that the program accepts, optional (default: none)
           - switches that the program accepts, optional (default: none)
           - parameter translation, optional (default: no translation occurs)
           - use dash for the program parameters, optional (default: yes, use dash)
           - join, optional (default: ' ')

=cut

sub _set_program_options {
  my ($self, $args, $params, $switches, $translation, $qual_param, $use_dash, $join) = @_;
  $self->{'_options'}->{'_params'}      = $params;
  $self->{'_options'}->{'_switches'}    = $switches;
  $self->{'_options'}->{'_translation'} = $translation;
  $self->{'_options'}->{'_qual_param'}  = $qual_param;
  if (not defined $use_dash) {
    $self->{'_options'}->{'_dash'}      = 1;
  } else {
    $self->{'_options'}->{'_dash'}      = $use_dash;
  }
  if (not defined $use_dash) {
    $self->{'_options'}->{'_join'}      = ' ';
  } else {
    $self->{'_options'}->{'_join'}      = $join;
  }
  $self->_set_from_args(
    $args,
    -methods => [ @$params, @$switches, 'program_name', 'program_dir', 'out_type' ],
    -create =>  1,
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
  my $options  = $self->_setparams(
    -params    => $params,
    -switches  => $switches,
    -join      => $join,
    -dash      => $dash
  );

  # Translate options
  my @options  = split(/(\s|$join)/, $options);
  for (my $i = 0; $i < scalar @options; $i++) {
    my ($prefix, $name) = ( $options[$i] =~ m/^(-?)(.+)$/ );
    if (defined $name) {
      if (defined $$translat{$name}) {
        $options[$i] = $prefix.$$translat{$name};
      }
    } else {
      splice @options, $i, 1;
      $i--;
    }
  }
  $options = join('', @options);

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

1;
