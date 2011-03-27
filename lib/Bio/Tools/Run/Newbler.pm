# BioPerl module for Bio::Tools::Run::Newbler
#
# Copyright Florent E Angly <florent-dot-angly-at-gmail-dot-com>
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

  Bio::Tools::Run::Newbler - Wrapper for local execution of Newbler

=head1 SYNOPSIS

  use Bio::Tools::Run::Newbler;
  # Run Minmo using an input FASTA file
  my $factory = Bio::Tools::Run::Newbler->new( -minimum_overlap_length => 35 );
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

  # Run Newbler using input sequence objects and returning an assembly file
  my $asm_file = 'results.ace';
  $factory->out_type($asm_file);
  $factory->run(\@seqs);

=head1 DESCRIPTION

  Wrapper module for the local execution of the proprietary DNA assembly
  program GS De Novo Assembler (Newbler) from Roche/454 v2.0.00.20:
    http://www.454.com/products-solutions/analysis-tools/gs-de-novo-assembler.asp

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


package Bio::Tools::Run::Newbler;

use strict;
use IPC::Run;
use File::Copy;
use File::Path;
use File::Spec;
use File::Basename;

use base qw( Bio::Root::Root Bio::Tools::Run::AssemblerBase );

our $program_name = 'runAssembly'; # name of the executable
our @program_params = (qw( expected_depth mid_conf_file vector_trim vector_screen
  aln_identity_score aln_difference_score min_ovl_identity min_ovl_length
  seed_count seed_length seed_step out_dir ));
our @program_switches = (qw( large ace ace_raw ace_trimmed no_trim in_memory
  no_auto_rescore no_duplicates ));
our %param_translation = (
  'large'               => 'large',
  'ace'                 => 'ace',
  'ace_raw'             => 'ar',
  'ace_trimmed'         => 'at',
  'expected_depth'      => 'e',
  'mid_conf_file'       => 'mcf',
  'no_trim'             => 'notrim',
  'vector_trim'         => 'vt',
  'vector_screen'       => 'vs',
  'aln_identity_score'  => 'ais',
  'aln_difference_score'=> 'ads',
  'in_memory'           => 'm',
  'min_ovl_identity'    => 'mi',
  'min_ovl_length'      => 'ml',
  'no_auto_rescore'     => 'nor',
  'seed_count'          => 'sc',
  'seed_length'         => 'sl',
  'seed_step'           => 'ss',
  'no_duplicates'       => 'ud',
  'out_dir'             => 'o'
);

our $qual_param;
our $use_dash = 1;
our $join = ' ';
our $asm_format = 'ace';
our $asm_variant = '454';


=head2 new

 Title   : new
 Usage   : $assembler->new( -min_len   => 50,
                            -min_ident => 95 );
 Function: Creates a Newbler factory
 Returns : A Bio::Tools::Run::Newbler object
 Args    : Newbler options available in this module (from the Newbler manual):

 large                Shortcut some of the computationally expensive algorithms
                        to save some time. Useful for large or complex datasets
                        (default: off).
 ace_raw              Output the full "raw" read sequence (default: off).
 ace_trimmed          Output only the "trimmed" sequences (after low quality,
                        vector and key trimming) (default: on).
 expected_depth       Expected depth of the assembly. Filters out random-chance
                        level events at bigger depths. 0 means to not use the
                        expected depth information (default: 0).
 mid_conf_file        MID configuration file for decoding the multiplex data.
 no_trim              Disable the quality and primer trimming of the input
                        sequences (default: off).
 vector_trim          Specify a vector trimming database (in FASTA format) to
                        trim the ends of input sequences.
 vector_screen        Specify a vector screening database (in FASTA format) to
                        remove contaminants, i.e. input reads that align
                        against a sequence in the database.
 aln_identity_score   Set the alignment identity score. When multiple alignments
                        are found, it is the per-overlap column identity score
                        used to sort the overlaps for use in the progressive
                        alignment (default: 2).
 aln_difference_score Set the alignment difference score. For multiple alignments
                        this is the per-overlap difference score used to sort the
                        overlaps for use in the progressive multi-alignment
                        (default: -3).
 in_memory            Keep all sequence data in memory throughout the computation.
                        Can speed up the computation but requires more computer
                        memory (default: off).
 min_ovl_identity / minimum_overlap_similarity
                      Minimum overlap identity, i.e. the minimum percent identity
                        of overlaps used by the assembler (default: 40).
 min_ovl_length / minimum_overlap_length
                      Minimum overlap length, i.e. the minimum length of overlaps
                        considered by the assembler (default: 90). Warning: It
                        seems like this parameter is not respected by the program
                        in the current version
 no_auto_rescore      Do not use the quality score re-scoring algorithm (default:
                        off).
 seed_count           Set the seed count parameter, the number of seeds required
                        in a window before an extension is made (default: 1).
 seed_length          Set the seed length parameter, i.e. the number of bases
                        between seed generation locations used in the exact
                        k-mer matching part of the overlap detection (between 6
                        16) (default: 16).
 seed_step            Set the seed step parameter, i.e. the number of bases used
                        for each seed in the exact k-mer matching part of the
                        overlap detection (i.e. the "k" value) (default: 12).
 no_duplicates        Treat each read as a separate read and do not group them
                        into duplicates for assembly or consensus calling
                       (default: off).

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->_set_program_options(\@args, \@program_params, \@program_switches,
    \%param_translation, $qual_param, $use_dash, $join);
  *minimum_overlap_length = \&min_ovl_length;
  *minimum_overlap_similarity = \&min_ovl_identity;
  $self->program_name($program_name) if not defined $self->program_name();
  $self->_assembly_format($asm_format);
  $self->_assembly_variant($asm_variant);
  return $self;
}

=head2 _check_sequence_input

 Title   : _check_sequence_input
 Usage   : $assembler->_check_sequence_input($seqs)
 Function: Check that the sequence input is arrayref of sequence objects or
           a FASTA file, or a MIDinfo + dir, or a MIDinfo + file. If not, an
           error is thrown.
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
      # [midinfo@]sffile|[midinfo@]projectdir|fastafile
      my ($mid, $file_or_dir) = ($seqs =~ m/^(.+@)?(.+)$/);
      if (not defined $file_or_dir) {
        $self->throw("Input string $seqs does not seem valid.");
      } else {
        if (not -e $file_or_dir) {
          $self->throw("Input file or directory '$file_or_dir' does not seem to exist.");
        }
      }
    }
  }
  return 1;
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
 Args    :   Sequence input can be:
               * a sequence object arrayref
               * a FASTA file
               * a SFF file and optional MID information. Example:
                   mid2@/home/xxx/myreads.sff
               * the path to an run analysis directory and MID information
             The reads must be between 50 and 2000 bp. Newbler does not support
               for input quality files. See the Newbler manual for details.

=cut


=head2 _run

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Make a system call and run TIGR Assembler
 Returns :   An assembly file
 Args    :   - FASTA file, SFF file and MID, or analysis dir and MID
             - optional QUAL file

=cut


sub _run {
  my ($self, $fasta_file, $qual_file) = @_;

  # fasta_file: [midinfo@]sffile|[midinfo@]projectdir|fastafile
  # qual_file: not supported by newbler

  # Specify that we want a single ACE output file containing all contigs
  $self->ace(1);

  # Setup needed files and filehandles first
  my ($output_fh, $output_file) = $self->_prepare_output_file( );

  # Set the output directory based on the the output file name
  my $output_dir = dirname($output_file);
  $self->out_dir($output_dir);

  # Set a log file
  my $log_file = File::Spec->catfile($output_dir, '454Log.txt');

  # Get program executable
  my $exe = $self->executable;

  # Get command-line options
  my $options = $self->_translate_params();

  # Usage: runAssembly [options] (sfffile | [regionlist:]analysisDir | readfastafile)...
  # where options is: [-o projdir] [-nrm] [-p (sfffile | [regionlist:]analysisDir)]...
  my @program_args = ( $exe, @$options, $fasta_file);
  my @ipc_args = ( \@program_args, '>', $log_file );

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
    IPC::Run::run(@ipc_args) || die("There was a problem running $exe. The ".
      "error message is: $!.");
  };
  if ($@) {
    $self->throw("$exe call crashed: $@");
  }

  # Close filehandles
  close($output_fh);

  # Result files
  my $ace_file              = File::Spec->catfile($output_dir, '454Contigs.ace');
  my $aln_file              = File::Spec->catfile($output_dir, '454AlignmentInfo.tsv');
  my $all_cont_fasta_file   = File::Spec->catfile($output_dir, '454AllContigs.fna');
  my $all_cont_qual_file    = File::Spec->catfile($output_dir, '454AllContigs.qual');
  my $large_cont_fasta_file = File::Spec->catfile($output_dir, '454LargeContigs.fna');
  my $large_cont_qual_file  = File::Spec->catfile($output_dir, '454LargeContigs.qual');
  my $metrics_file          = File::Spec->catfile($output_dir, '454NewblerMetrics.txt');
  my $status_file           = File::Spec->catfile($output_dir, '454ReadStatus.txt');
  my $progress_file         = File::Spec->catfile($output_dir, '454NewblerProgress.txt');
  my $trim_file             = File::Spec->catfile($output_dir, '454TrimStatus.txt');
  my $sff_dir               = File::Spec->catfile($output_dir, 'sff');

  # Remove all files except for the ACE file
  for my $file ($aln_file, $all_cont_fasta_file, $all_cont_qual_file,
    $large_cont_fasta_file, $large_cont_qual_file, $metrics_file, $status_file,
    $progress_file, $trim_file, $log_file ) {
    unlink $file;
  }
  rmtree( $sff_dir );

  # Move output file to proper location/name
  move ($ace_file, $output_file) or $self->throw("Could not move file ".
    "'$ace_file' to '$output_file': $!");

  return $output_file;
}

1;
