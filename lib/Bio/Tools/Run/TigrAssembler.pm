# BioPerl module for Bio::Tools::Run::TigrAssembler
#
# Copyright Florent E Angly <florent-dot-angly-at-gmail-dot-com>
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::TigrAssembler - Wrapper for local execution of TIGR Assembler
 v2

=head1 SYNOPSIS

  use Bio::Tools::Run::TigrAssembler;
  # Run TIGR Assembler using an input FASTA file
  my $factory = Bio::Tools::Run::TigrAssembler->new( -minimum_overlap_length => 35 );
  my $asm_obj = $factory->run($fasta_file, $qual_file);
  # An assembly object is returned by default
  for my $contig ($assembly->all_contigs) {
    ... do something ...
  }

  # Read some sequences
  use Bio::SeqIO;
  my $sio = Bio::SeqIO->new(-file => $fasta_file, -format => 'fasta');
  my @seqs;
  while (my $seq = $sio->next_seq()) {
    push @seqs,$seq;
  }

  # Run TIGR Assembler with input sequence objects and return an assembly file
  my $asm_file = 'results.tigr';
  $factory->out_type($asm_file);
  $factory->run(\@seqs);

  # Use LIGR Assembler instead
  my $ligr = Bio::Tools::Run::TigrAssembler->new(
    -program_name => 'LIGR_Assembler',
    -trimmed_seq  => 1
  );
  $ligr->run(\@seqs);

=head1 DESCRIPTION

  Wrapper module for the local execution of the DNA assembly program TIGR
  Assembler v2.0. TIGR Assembler is open source software under The Artistic
  License and available at: http://www.tigr.org/software/assembler/

  This module runs TIGR Assembler by feeding it a FASTA file or sequence objects
  and returning an assembly file or assembly and IO objects. When the input is
  Bioperl object, sequences less than 39 bp long are filtered out since they are
  not supported by TIGR Assembler.

  If provided in the following way, TIGR Assembler will use additional
  information present in the sequence descriptions for assembly:
    >seq_name minimum_clone_length maximum_clone_length median_clone_length
     clear_end5 clear_end3
    or
    >db|seq_name minimum_clone_length maximum_clone_length median_clone_length
     clear_end5 clear_end3
    e.g.
    >GHIBF57F 500 3000 1750 33 587

  This module also supports LIGR Assembler, a variant of TIGR Assembler:
    http://sourceforge.net/projects/ligr-assembler/

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other Bioperl
modules. Send your comments and suggestions preferably to one of the Bioperl
mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track the bugs
and their resolution.  Bug reports can be submitted via the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Florent E Angly

 Email: florent-dot-angly-at-gmail-dot-com

=head1 APPENDIX

The rest of the documentation details each of the object methods. Internal
methods are usually preceded with a _

=cut


package Bio::Tools::Run::TigrAssembler;

use strict;
use IPC::Run;

use base qw( Bio::Root::Root Bio::Tools::Run::AssemblerBase );

our $program_name = 'TIGR_Assembler'; # name of the executable
our @program_params = (qw( minimum_percent minimum_length max_err_32 quality_file
  maximum_end resort_after ));
our @program_switches = (qw( include_singlets consider_low_scores safe_merging_stop
  ignore_tandem_32mers use_tandem_32mers not_random incl_bad_seq trimmed_seq ));
our %param_translation = (
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
  'resort_after'         => 'r',
  'incl_bad_seq'         => 'b',
  'trimmed_seq'          => 'i'
);
our $qual_param = 'quality_file';
our $use_dash = 1;
our $join = ' ';
our $asm_format = 'tigr';
our $min_len = 39;


=head2 new

 Title   : new
 Usage   : $factory->new( -minimum_percent  => 95,
                          -minimum_length   => 50,
                          -include_singlets => 1  );
 Function: Create a TIGR Assembler factory
 Returns : A Bio::Tools::Run::TigrAssembler object
 Args    :

TIGR Assembler options available in this module:

  minimum_percent / minimum_overlap_similarity: the minimum percent identity
    that two DNA fragments must achieve over their entire region of overlap in
    order to be considered as a possible assembly. Adjustments are made by the
    program to take into account that the ends of sequences are lower quality
    and doubled base calls are the most frequent sequencing error.
  minimum_length / minimum_overlap_length: the minimum length two DNA fragments
    must overlap to be considered as a possible assembly (warning: this option
    is not strictly respected by TIGR Assembler...)
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
    clone length constraints.
  not_random: a flag which indicates that the DNA fragments in the input_file
    should not be treated as random genomic fragments for the purpose of
    determining repeat regions.
  resort_after: specifies how many sequences should be merged before resorting
    the possible merges based on clone constraints.

LIGR Assembler has the same options as TIGR Assembler, and the following:

  incl_bad_seq: keep all sequences including potential chimeras and splice variants
  trimmed_seq: indicates that the sequences are trimmed. High quality scores will be
    given on the whole sequence length instead of just in the middle)

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->_set_program_options(\@args, \@program_params, \@program_switches,
    \%param_translation, $qual_param, $use_dash, $join);
  *minimum_overlap_length = \&minimum_length;
  *minimum_overlap_similarity = \&minimum_percent;
  $self->program_name($program_name) if not defined $self->program_name();
  $self->_assembly_format($asm_format);
  return $self;
}


=head2 out_type

 Title   : out_type
 Usage   : $factory->out_type('Bio::Assembly::ScaffoldI')
 Function: Get/set the desired type of output
 Returns : The type of results to return
 Args    : Desired type of results to return (optional):
                 'Bio::Assembly::IO' object
                 'Bio::Assembly::ScaffoldI' object (default)
                 The name of a file to save the results in

=cut


=head2 run

 Title   :   run
 Usage   :   $factory->run($fasta_file);
 Function:   Run TIGR Assembler
 Returns :   - a Bio::Assembly::ScaffoldI object, a Bio::Assembly::IO
               object, a filename, or undef if all sequences were too small to
               be usable
 Returns :   Assembly results (file, IO object or assembly object)
 Args    :   - sequence input (FASTA file or sequence object arrayref)
             - optional quality score input (QUAL file or quality score object
               arrayref)
=cut


=head2 _run

 Title   :   _run
 Usage   :   $assembler->_run()
 Function:   Make a system call and run Newbler
 Returns :   An assembly file
 Args    :   - FASTA file, SFF file and MID, or analysis dir and MID
             - optional QUAL file

=cut

sub _run {
  my ($self, $fasta_file, $qual_file) = @_;

  # Setup needed files and filehandles first
  my ($output_fh,  $output_file ) = $self->_prepare_output_file( );
  my ($scratch_fh, $scratch_file) = $self->io->tempfile( -dir => $self->tempdir() );
  my ($stderr_fh,  $stderr_file ) = $self->io->tempfile( -dir => $self->tempdir() );

  # Get program executable
  my $exe = $self->executable;

  # Get command-line options
  my $options = $self->_translate_params();

  # Usage: TIGR_Assembler [options] scratch_file < input_file > output_file
  my @program_args = ( $exe, @$options, $scratch_file );
  my $stdin  = $fasta_file;
  my $stdout = $output_file;
  my $stderr = $stderr_file;

  my @ipc_args = ( \@program_args,
                   '<',  $fasta_file,
                   '>',  $output_file,
                   '2>', $stderr_file  );

  # Print command for debugging
  if ($self->verbose() >= 0) {
    my $cmd = '';
    $cmd .= join ( ' ', @program_args );
    for ( my $i = 1 ; $i < scalar @ipc_args ; $i++ ) {
      my $element = $ipc_args[$i];
      my $ref = ref($element);
      my $value;
      if ( $ref && $ref eq 'SCALAR') {
        $value = $$element;
      } else {
        $value = $element;
      }
      $cmd .= " $value";
    }
    $self->debug( "$exe command = $cmd\n" );
  }

  # Execute command
  eval {
    IPC::Run::run(@ipc_args) || die("There was a problem running $exe: $!");
  };
  if ($@) {
    $self->throw("$exe call crashed: $@");
  }
  $self->debug(join("\n", "$exe STDERR", $stderr_file)) if $stderr_file;
    # TIGR Assembler's stderr reports a lot more than just errors
 
  # Close filehandles
  close($scratch_fh);
  close($output_fh);
  close($stderr_fh);
 
  # Import assembly
  return $output_file;
}


=head2 _remove_small_sequences

 Title   :   _remove_small_sequences
 Usage   :   $assembler->_remove_small_sequences(\@seqs, \@quals)
 Function:   Remove sequences below a threshold length
 Returns :   a new sequence object array reference
             a new quality score object array reference
 Args    :   sequence object array reference
             quality score object array reference (optional)

=cut

# Aliasing function _prepare_input_sequences to _remove_small_sequences
*_prepare_input_sequences = \&_remove_small_sequences;

sub _remove_small_sequences {
  my ($self, $seqs, $quals) = @_;
  # The threshold length, $min_len, has been registered as a global variable
  my @new_seqs;
  my @new_quals;

  if (ref($seqs) =~ m/ARRAY/i) {
    my @removed;
    my $nof_seqs = scalar @$seqs;
    for my $i (1 .. $nof_seqs) {
      my $seq = $$seqs[$i-1];
      if ($seq->length >= $min_len) {
        push @new_seqs, $seq;
        if ($quals) {
          my $qual = $$quals[$i-1];
          push @new_quals, $qual;
        }
      } else {
        push @removed, $seq->id;
      }
    }
    if (scalar @removed > 0) {
      $self->warn("The following sequences were removed because they are smaller".
        " than $min_len bp: @removed\n");
    }
  }
  return \@new_seqs, \@new_quals;
}

1;
