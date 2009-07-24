# BioPerl module for Bio::Tools::Run::TigrAssembler
#
# Copyright Florent E Angly <florent-dot-angly-at-gmail-dot-com>
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::TigrAssembler - Wrapper for local execution of TIGR Assembler
 v2.0

=head1 SYNOPSIS

  use Bio::Tools::Run::TigrAssembler;
  my $assembler = Bio::Tools::Run::TigrAssembler->new();

  # Pass the factory a Bio::Seq object array reference
  # Returns a Bio::Assembly::Scaffold object array reference
  my $asms = $assembler->run(\@seqs);

  for my $asm (@$asms) {
    # do something with assembled sequences
  }

  # Look at what command was run and what the intermediary files were using:
  $assembler->verbose(2);
  $assembler->save_tempfiles(1);

=head1 DESCRIPTION

  Wrapper module for the local execution of the DNA assembly program TIGR
  Assembler v2.0. TIGR Assembler is open source software under The Artistic
  License and available at: http://www.tigr.org/software/assembler/

  The description enables to runs TIGR Assembler by feeding it sequence objects
  and returning assembly objects. The input could be an array of Bio::PrimarySeq
  or maybe Bio::Seq::Quality, in which case, the quality scores will
  automatically be used during assembly. Sequences less than 39 bp long are
  filtered out since they are not supported by TIGR Assembler. The
  amount of memory in your machine may prevent you to assemble large sequence
  datasets, but this module offers a way to split your dataset in smaller
  datasets to be assembled _independently_. An array of Bio::Assembly::Scaffold
  objects is returned.

  If provided in the following way, TIGR Assembler will use additional
  information present in the sequence descriptions for assembly:
    >seq_name minimum_clone_length maximum_clone_length median_clone_length
     clear_end5 clear_end3
    or
    >db|seq_name minimum_clone_length maximum_clone_length median_clone_length
     clear_end5 clear_end3
    e.g.
    >GHIBF57F 500 3000 1750 33 587

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other Bioperl
modules. Send your comments and suggestions preferably to one of the Bioperl
mailing lists.  Your participation is much appreciated.

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

Report bugs to the Bioperl bug tracking system to help us keep track the bugs
and their resolution.  Bug reports can be submitted via the web:

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Florent E Angly

 Email: florent-dot-angly-at-gmail-dot-com

=head1 APPENDIX

The rest of the documentation details each of the object methods. Internal
methods are usually preceded with a _

=cut


package Bio::Tools::Run::TigrAssembler;

use strict;
use IPC::Run;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Assembly::IO;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

our $program = 'TIGR_Assembler';
our $program_name = 'TIGR_Assembler';
our @params = (qw( program max_nof_seqs ));
our @tasm_params = (qw( minimum_percent minimum_length max_err_32 quality_file
  maximum_end resort_after ));
our @tasm_switches = (qw( include_singlets consider_low_scores safe_merging_stop
  ignore_tandem_32mers use_tandem_32mers not_random ));
our %tasm_options = (
  'quality_file'         => 'q',
  'minimum_percent'      => 'p',
  'minimum_length'       => 'l',
  'include_singlets'     => 's',
  'max_err_32'           => 'g',
  'consider_low_scores'  => 'L',
  'maximum_end'          => 'e',
  'ignore_tandem_32mers' => 't',
  'use_tandem_32mers'    => 'u',
  'safe_merging_stop'    => 'X',
  'not_random'           => 'N',
  'resort_after'         => 'r'
);


=head2 program_name

 Title   : program_name
 Usage   : $assembler>program_name()
 Function: get/set the program name
 Returns:  string
 Args    : string

=cut

sub program_name {
    my ($self, $val) = @_;
    $self->program($val) if $val;
    return $self->program();
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


=head2 max_nof_seqs

 Title   : max_nof_seqs
 Usage   : $assembler->max_nof_seqs()
 Function: get/set the maximum number number of sequences to assemble at once
 Returns:  string
 Args    : string

=cut

sub max_nof_seqs {
  my ($self, $val) = @_;
  $self->{'_max_nof_seq'} = $val if $val;
  return $self->{'_max_nof_seq'};
}


=head2 new

 Title   : new
 Usage   : $assembler->new( -minimum_percent  => 95,
                            -minimum_length   => 50,
                            -include_singlets => 1);
 Function: Creates a TIGR Assembler factory
 Returns : Bio::Tools::Run::TigrAssembler object
 Args    : TIGR Assembler options available in this module:
  minimum_percent: the minimum percent identity that two DNA fragments must
    achieve over their entire region of overlap in order to be considered as a
    possible assembly. Adjustments are made by the program to take into account
    that the ends of sequences are lower quality and doubled base calls are the
    most frequent sequencing error.
  minimum_length: the minimum length two DNA fragments must overlap to be
    considered as a possible assembly (warning: in tests I did, this option
    did not work as expected...)
  include_singlets: a flag which indicates that singletons (assemblies made up
    of a single DNA fragment) should be included in the lassie output_file - the
    default is to not include singletons.
  max_err_32: the maximum number + 1 of alignment errors (mismatches or gaps)
    allowed within any contiguous 32 base pairs in the overlap region between
    two DNA fragments in the same assembly. This is meant to split apart splice
    variants which have short splice differences and would not be disqualified
    by the -p minimum_percent parameter.
  consider_low_scores: a flag which causes even very LOW pairwise scores to be
    considered - caution using this flag may cause longer run time and a worse
    assembly.
  maximum_end: the maximum length at the end of a DNA fragment that does not
    match another overlapping DNA fragment (sometimes referred to as overhang)
    that will not disqualify a DNA fragment from becoming part of an assembly.
  ignore_tandem_32mers: a flag which causes tandem 32mers (a tandem 32mer is a
    32mer which occurs more than once in at least one sequence read) to be
    ignored (this is now the default behavior and this flag is for backward
    compatability)
  use_tandem_32mers: a flag which causes tandem 32mers to be used for pairwise
    comparison opposite of the -t flag which is now the default).
  safe_merging_stop: a flag which causes merging to stop when only sequences
    which appear to be repeats are left and these cannot be merged based on
    clone length constraints. not_random: a flag which indicates the DNA
    fragments in the input_file should not be treated as random genomic
    fragments for the purpose of determining repeat regions.
  resort_after: specifies how many sequences should be merged before resorting
    the possible merges based on clone constraints.

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->io->_initialize_io();
  $self->_set_from_args(
    \@args,
    -methods => [
      @params,
      @tasm_params,
      @tasm_switches,
    ],
    -create =>  1,
  );
  $self->program($program_name) if not defined $self->program();  
  $self->program_name($program_name) if not defined $self->program_name();
  return $self;
}


=head2 run

 Title   :   run
 Usage   :   $obj->run(\@seqs, \@quals);
 Function:   Runs TIGR Assembler
 Returns :   a Bio::Assembly::ScaffoldI object array reference, or undef if all
             sequences were too small to be usable
 Args    :   - sequences as a Bio::PrimarySeqI or Bio::SeqI arrayref (e.g. can
               be Bio::Seq::Quality for sequences and quality scores in a same
               object)
             - optional Bio::Seq::PrimaryQual arrayref of quality scores if
               you have your scores in different objects from your sequences.
               Must have same ID as sequences and same order

=cut

sub run {
  my ($self, $seqs, $quals) = @_;
  # Sanity check
  unless ($seqs) {
    $self->throw("Must supply a Bio::PrimarySeqI or Bio::SeqI object array reference");
  }
  for my $seq (@$seqs) {
    unless ($seq->isa('Bio::PrimarySeqI') || $seq->isa('Bio::SeqI')) {
      $self->throw("Not a valid Bio::PrimarySeqI or Bio::SeqI object");
    }
  }
  if ($quals) {
    for my $qual (@$quals) {
      unless ($qual->isa('Bio::Seq::QualI')) {
        $self->throw("Not a valid Bio::Seq::QualI object");
      }
    }
  }
  # Assemble
  my @asms;
  my $tot_nof_seqs = scalar @$seqs;
  my $max_nof_seqs = $self->max_nof_seqs || $tot_nof_seqs;
  for (my $i = 0 ; $i < $tot_nof_seqs ; $i += $max_nof_seqs) {
    my $first = $i;
    my $last = $i+$max_nof_seqs-1;
    $last = $tot_nof_seqs-1 if $last > $tot_nof_seqs-1;
    my @seq_subset = @$seqs[$first..$last];
    my @qual_subset = @$quals[$first..$last] if $quals;
    # Write temp FASTA and QUAL input files, removing sequences less than 39bp
    my ($fasta_file, $qual_file) = $self->_write_seq_file(\@seq_subset, \@qual_subset);
    # Assemble
    if (defined $fasta_file) {
      my ($asm_obj, $asm_file) = $self->_run($fasta_file, $qual_file);
      push @asms, $asm_obj
    }
  }
  return \@asms;
}


=head2 _write_seq_file

 Title   :   _write_seq_file
 Usage   :   $assembler->_write_seq_file(\@seqs, \@quals)
 Function:   Write temporary FASTA and QUAL files on disk
 Returns :   name of FASTA file
             name of QUAL file (undef if no quality scoress)
 Args    :   Bio::PrimarySeq object array reference
             optional quality objects array reference

=cut

sub _write_seq_file {
  my ($self, $seqs, $quals) = @_;
  my ($fasta_h, $fasta_file) = $self->io->tempfile( -dir => $self->tempdir() );
  my ($qual_h, $qual_file) = $self->io->tempfile( -dir => $self->tempdir() );
  my $fasta_out = Bio::SeqIO->new( -fh => $fasta_h , -format => 'fasta');
  my $qual_out = Bio::SeqIO->new( -fh => $qual_h , -format => 'qual');
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
    # Remove sequences less than 39bp because they make TIGR_Assembler crash.
    # To reproduce this bug, take 2 identical sequences, trim one below 39bp,
    # run TIGR_Assembler with its default parameters, and watch the backtrace
    my $min_length = 39;
    if ($seq->length < $min_length) {
      splice @$seqs, $i, 1;
      $i--;
      $size--;
      $self->warn("Sequence $seqid skipped: can not be assembled because its ".
        "size is less than $min_length bp");
      next;
    }
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


=head2 _run

 Title   :   _run
 Usage   :   $assembler->_run()
 Function:   Assembly step
 Returns :   Bio::Assembly::Scaffold object
             assembly file location
 Args    :   FASTA file location
             QUAL file location [optional]

=cut

sub _run {
  my ($self, $fasta_file, $qual_file) = @_;
  
  # Usage: TIGR_Assembler [options] scratch_file < input_file > output_file

  $self->throw("Need a FASTA file as input") if not defined $fasta_file;

  # Setup needed files and filehandles first
  my ($scratch_fh, $scratch_file) =
    $self->io->tempfile( -dir => $self->tempdir() );
  my ($output_fh, $output_file) =
    $self->io->tempfile( -dir => $self->tempdir() );
  my ($stderr_fh, $stderr_file) =
    $self->io->tempfile( -dir => $self->tempdir() );
  
  # Use quality files if possible
  $self->quality_file($qual_file) if defined $qual_file;
  
  # Get command-line options
  my @options = split(/\s+/, $self->_setparams(
    -params   => \@tasm_params,
    -switches => \@tasm_switches,
    -join     => ' ',
    -dash     => 1
  ));
  for ( my $i = 0 ; $i < scalar @options ; $i++) {
    splice @options, $i, 1 if $options[$i] =~ m/^\s*$/;
    $options[$i] =~ s/-(.+)/-$tasm_options{$1}/x;
  }
  
  # Build command to run
  my $exe = $self->executable();
  $self->throw("Could not find TIGR Assembler executable") if not defined $exe;
  my @tasm_args;
  if ( scalar @params > 0 ) {
    @tasm_args = ( $exe, @options, $scratch_file );
  } else {
    @tasm_args = ( $exe, $scratch_file);
  }
  my @ipc_args = (
    \@tasm_args,
    '<',  $fasta_file,
    '>',  $output_file,
    '2>', $stderr_file
  );
  
  # Print command for debugging
  if ($self->verbose() >= 0) {
    my $cmd = '';
    $cmd .= join ( ' ', @tasm_args );
    for ( my $i = 1 ; $i < scalar @ipc_args ; $i++ ) {
      my $element = $ipc_args[$i];
      my $ref = ref $element;
      my $value;
      if ( $ref && $ref eq 'SCALAR') {
        $value = $$element;
      } else {
        $value = $element;
      }
      $cmd .= " $value";
    }
    $self->debug( "TIGR Assembler command = $cmd" );
  }
  
  # Execute command
  eval {
    IPC::Run::run(@ipc_args) || die("problem: $!");
  };
  if ($@) {
    $self->throw("TIGR Assembler call crashed: $@");
  }
  $self->debug(join("\n", 'TIGR Assembler STDERR:', $stderr_file))
    if $stderr_file;
    # TIGR Assembler's stderr reports a lot more than just errors
 
  # Close filehandles
  close($scratch_fh);
  close($output_fh);
  close($stderr_fh);
 
  # Import assembly
  my $asm_io = Bio::Assembly::IO->new(
    -file   => "<$output_file",
    -format => 'tigr' );
  my $asm = $asm_io->next_assembly();
  
  return $asm, $output_file;
}


1;
