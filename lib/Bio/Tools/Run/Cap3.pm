# $Id$
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Cap3 - wrapper for CAP3

=head1 SYNOPSIS

  use Bio::Tools::Run::Cap3;
  # Run Cap3 using an input FASTA file
  my $factory = Bio::Tools::Run::Cap3->new( -clipping_range => 150 );
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

  # Run Cap3 using input sequence objects and returning an assembly file
  my $asm_file = 'results.ace';
  $factory->out_type($asm_file);
  $factory->run(\@seqs);


=head1 DESCRIPTION

  Wrapper module for CAP3 program

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

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

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHORS

Marc Logghe

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Cap3;

use strict;
use File::Copy;

use base qw(Bio::Root::Root Bio::Tools::Run::AssemblerBase);

our $program_name = 'cap3';
our @program_params = (qw( band_expansion_size differences_quality_cutoff
  clipping_quality_cutoff max_qscore_sum extra_nof_differences max_gap_length
  gap_penalty_factor max_overhang_percent match_score_factor mismatch_score_factor
  overlap_length_cutoff overlap_identity_cutoff reverse_orientation_value
  overlap_score_cutoff max_word_occurrences min_correction_constraints
  min_linking_constraints clipping_info_file output_prefix_string clipping_range
  min_clip_good_reads ));
our @program_switches;
our %param_translation = (
  'band_expansion_size'        => 'a',
  'differences_quality_cutoff' => 'b',
  'clipping_quality_cutoff'    => 'c',
  'max_qscore_sum'             => 'd',
  'extra_nof_differences'      => 'e',
  'max_gap_length'             => 'f',
  'gap_penalty_factor'         => 'g',
  'max_overhang_percent'       => 'h',
  'match_score_factor'         => 'm',
  'mismatch_score_factor'      => 'n',
  'overlap_length_cutoff'      => 'o',
  'overlap_identity_cutoff'    => 'p',
  'reverse_orientation_value'  => 'r',
  'overlap_score_cutoff'       => 's',
  'max_word_occurrences'       => 't',
  'min_correction_constraints' => 'u',
  'min_linking_constraints'    => 'v',
  'clipping_info_file'         => 'w',
  'output_prefix_string'       => 'x',
  'clipping_range'             => 'y',
  'min_clip_good_reads'        => 'z'
);
our $qual_param;
our $use_dash = 1;
our $join = ' ';
our $asm_format = 'ace';

=head2 new

 Title   : new
 Usage   : $factory->new(
             -overlap_length_cutoff   => 35,
             -overlap_identity_cutoff => 98 # %
           }
 Function: Create a new Cap3 factory
 Returns : A Bio::Tools::Run::Cap3 object
 Args    : Cap3 options available in this module:
  band_expansion_size        specify band expansion size N > 10 (20)
  differences_quality_cutoff specify base quality cutoff for differences N > 15 (20)
  clipping_quality_cutoff    specify base quality cutoff for clipping N > 5 (12)
  max_qscore_sum             specify max qscore sum at differences N > 20 (200)
  extra_nof_differences      specify clearance between no. of diff N > 10 (30)
  max_gap_length             specify max gap length in any overlap N > 1 (20)
  gap_penalty_factor         specify gap penalty factor N > 0 (6)
  max_overhang_percent       specify max overhang percent length N > 2 (20)
  match_score_factor         specify match score factor N > 0 (2)
  mismatch_score_factor      specify mismatch score factor N < 0 (-5)
  overlap_length_cutoff / minimum_overlap_length
                             specify overlap length cutoff > 20 (40)
  overlap_identity_cutoff / minimum_overlap_similarity
                             specify overlap percent identity cutoff N > 65 (80)
  reverse_orientation_value  specify reverse orientation value N >= 0 (1)
  overlap_score_cutoff       specify overlap similarity score cutoff N > 400 (900)
  max_word_occurrences       specify max number of word matches N > 30 (300)
  min_correction_constraints specify min number of constraints for correction N > 0 (3)
  min_linking_constraints    specify min number of constraints for linking N > 0 (2)
  clipping_info_file         specify file name for clipping information (none)
  output_prefix_string       specify prefix string for output file names (cap)
  clipping_range             specify clipping range N > 5 (250)
  min_clip_good_reads        specify min no. of good reads at clip pos N > 0 (3)

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->_set_program_options(\@args, \@program_params, \@program_switches, \%param_translation,
    $qual_param, $use_dash, $join);
  *minimum_overlap_length = \&overlap_length_cutoff;
  *minimum_overlap_similarity = \&overlap_identity_cutoff;
  $self->program_name($program_name) if not defined $self->program_name();
  $self->_assembly_format($asm_format);
  return $self;
}


=head2 out_type

 Title   : out_type
 Usage   : $assembler->out_type('Bio::Assembly::ScaffoldI')
 Function: Get/set the desired type of output
 Returns : The type of results to return
 Args    : Desired type of results to return (optional):
                 'Bio::Assembly::IO' object
                 'Bio::Assembly::ScaffoldI' object (default)
                 The name of a file to save the results in

=cut


=head2 run

 Title   :   run
 Usage   :   $asm = $factory->run($fasta_file);
 Function:   Run CAP3
 Returns :   Assembly results (file, IO object or assembly object)
 Args    :   - sequence input (FASTA file or sequence object arrayref)
             - optional quality score input (QUAL file or quality score object
               arrayref)
=cut


=head2 _run

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Make a system call and run Cap3
 Returns :   An assembly file
 Args    :   - FASTA file
             - optional QUAL file

=cut

sub _run {
  my ($self, $fasta_file, $qual_file) = @_;

  # Move quality file to proper place
  my $tmp_qual_file = "$fasta_file.qual";
  if ($qual_file && not $qual_file eq $tmp_qual_file) {
    $tmp_qual_file = "$fasta_file.qual"; # by Cap3 convention
    link ($qual_file, $tmp_qual_file) or copy ($qual_file, $tmp_qual_file) or
      $self->throw("Could not copy file '$qual_file' to '$tmp_qual_file': $!");
  }

  # Setup needed files and filehandles
  my ($output_fh, $output_file)   = $self->_prepare_output_file( );

  # Get program executable
  my $exe = $self->executable;

  # Get command-line options
  my $options = join ' ', @{$self->_translate_params()};

  # Usage: cap3 File_of_reads [options]
  my $commandstring = "$exe $fasta_file $options";

  if ($self->verbose() >= 0) {
    $self->debug( "$exe command = $commandstring\n" );
  }

  open(CAP3, "$commandstring |") ||
    $self->throw(sprintf("%s call crashed: %s %s\n", $self->program_name, $!, $commandstring));
  local $/ = undef;
  #my ($result) = <CAP3>; # standard output of the program
  <CAP3>;
  close CAP3;
  close $output_fh;

  # Result files
  my $prefix       = $self->output_prefix_string() || 'cap';
  my $ace_file     = "$fasta_file.$prefix.ace";
  my $contigs_file = "$fasta_file.$prefix.contigs";
  $qual_file    = "$fasta_file.$prefix.contigs.links";
  my $links_file   = "$fasta_file.$prefix.contigs.qual";
  my $info_file    = "$fasta_file.$prefix.info";
  my $singlet_file = "$fasta_file.$prefix.singlets";

  # Remove all files except for the ACE file
  for my $file ($contigs_file, $qual_file, $links_file, $info_file, $singlet_file, $tmp_qual_file) {
    unlink $file;
  }

  # Move the ACE file to its final destination
  move ($ace_file, $output_file) or $self->throw("Could not move file '$ace_file' to '$output_file': $!");

  return $output_file;
}

1;