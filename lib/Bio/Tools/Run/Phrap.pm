# $Id$
#
# Phrap wraper module
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Shawn Hoon
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phrap - a wrapper for running Phrap

=head1 SYNOPSIS

  use Bio::Tools::Run::Phrap;
  use Bio::SeqIO;

  # Read some sequences
  my $sio = Bio::SeqIO->new(-file=>$ARGV[0],-format=>'fasta');
  my @seqs;
  while(my $seq = $sio->next_seq()){
    push @seqs,$seq;
  }
  # Run Phrap
  my $prun =Bio::Tools::Run::Phrap->new( -penalty => -2, -raw => 1 );
  my $assembly = $prun->run(\@seqs);
  # Input can also be a FASTA file
  foreach my $contig($assembly->all_contigs){
    my $collection = $contig->get_features_collection;
    foreach my $sf($collection->get_all_features){
      print $sf->primary_id."\t".$sf->start."\t".$sf->end."\n";
    }
  }

=head1 DESCRIPTION

  Wrapper module for the Phrap assembly program
  Phrap is available at: http://www.phrap.org/

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

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Shawn Hoon

  Email shawnh-at-stanford.edu

=head1 APPENDIX

 The rest of the documentation details each of the object
 methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phrap;

use strict;
use Bio::Assembly::IO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root
            Bio::Tools::Run::WrapperBase
            Bio::Factory::ApplicationFactoryI);

our $program_name   = 'phrap';
our @phrap_params   = (qw(penalty gap_init gap_ext ins_gap_ext del_gap_ext
  matrix minmatch maxmatch max_group_size bandwidth minscore vector_bound masklevel
  default_qual subclone_delim n_delim group_delim trim_start forcelevel
  bypasslevel maxgap repeat_stringency node_seg node_space max_subclone_size
  trim_penalty trim_score trim_qual confirm_length confirm_trim confirm_penalty
  confirm_score indexwordsize));
our @phrap_switches = (qw(raw word_raw revise_greedy shatter_greedy preassemble
  force_high retain_duplicates));

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: get/set the name of the program to execute
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
 Usage   : $factory->program_dir()
 Function: get/set the program dir
 Returns : string
 Args    : string

=cut

sub program_dir {
  my ($self, $val) = @_;
  $self->{'_program_dir'} = $val if $val;
  return $self->{'_program_dir'};
}

=head2 new

 Title   : new
 Usage   : my $factory= Bio::Tools::Run::Phrap->new(
             -penalty => -2, # parameter option and value
             -raw     =>  1  # flag (1=yes, 0=no)
           );
 Function: creates a new Phrap factory
 Returns:  Bio::Tools::Run::Phrap
 Args    :

Option names & default values taken from the PHRAP manual:

1. Scoring of pairwise alignments

 -penalty -2
Mismatch (substitution) penalty for SWAT comparisons.

 -gap_init penalty-2
Gap initiation penalty for SWAT comparisons.

 -gap_ext  penalty-1
Gap extension penalty for SWAT comparisons.

 -ins_gap_ext gap_ext
 Insertion gap extension penalty for SWAT comparisons (insertion in
subject relative to query).

 -del_gap_ext gap_ext
 Deletion gap extension penalty for SWAT comparisons (deletion in
subject relative to query).

 -matrix [None]
 Score matrix for SWAT comparisons (if present, supersedes -penalty)

 -raw *
 Use raw rather than complexity-adjusted Smith-Waterman scores.

2. Banded search

 -maxmatch 30
 Maximum length of matching word. For cross_match, the default value
is equal to minmatch, instead of 30.

 -max_group_size 20
 Group size (query file, forward strand words)

 -word_raw *
 Use raw rather than complexity-adjusted word length, in testing
against minmatch (N.B. maxmatch always refer to raw lengths).  (The
default is to adjust word length to reflect complexity of matching
sequence).

 -bandwidth 14
 1/2 band width for banded SWAT searches (full width is 2 times
bandwidth + 1). Decreasing bandwidth also decreases running time at
the expense of sensitivity. Phrap assemblies of clones containing long
tandem repeats of a short repeat unit (< 30 bp) may be more accurately
assembled by decreasing -bandwidth; -bandwidth should be set such that
2 bandwidth + 1 is less than the length of a repeat unit. -bandwidth 0
can be used to find gap-free alignments.

3. Filtering of matches

 -minscore 30
 Minimum alignment score.

 -vector_bound 80
 Number of potential vector bases at beginning of each read.  Matches
that lie entirely within this region are assumed to represent vector
matches and are ignored.  For cross_match, the default value is 0
instead of 80.

 -masklevel 80
 (cross_match only). A match is reported only if at least (100 -
masklevel)% of the bases in its "domain" (the part of the query that
is aligned) are not contained within the domain of any higher-scoring
match.
 Special cases:
    -masklevel 0     report only the single highest scoring match for each query
    -masklevel 100   report any match whose domain is not completely contained
                         within a higher scoring match
    -masklevel 101   report all matches

4. Input data interpretation

 -default_qual 15
 Quality value to be used for each base, when no input .qual file is
provided. Note that a quality value of 15 corresponds to an error rate
of approximately 1 in 30 bases, i.e. relatively accurate sequence. If
you are using sequence that is substantially less accurate than this
and do not have phred-generated quality values you should be sure to
decrease the value of this parameter.

 -subclone_delim .
 (phrap only). Subclone name delimiter: Character used to indicate end
of that part of the read name that corresponds to the subclone name

 -n_delim 1
 (phrap only). Indicates which occurrence of the subclone delimiter
character denotes the end of the subclone name (so for example
     -subclone_delim _ -n_delim 2
means that the end of the subclone name occurs at the
second occurrence of the character '_'). Must be the same for all
reads!

 -group_delim _
 (phrap only). Group name delimiter: Character used to indicate end of
that part of the read name that corresponds to the group name
(relevant only if option -preassemble is used); this character must
occur before the subclone delimiter (else it has no effect, and the
read is not assigned to a group).

 -trim_start 0
 (phrap only). No. of bases to be removed at beginning of each read.

5. Assembly

 -forcelevel 0
 (phrap only). Relaxes stringency to varying degree during final
contig merge pass.  Allowed values are integers from 0 (most
stringent) to 10 (least stringent), inclusive.

 -bypasslevel 1
 (phrap only). Controls treatment of inconsistent reads in merge.
Currently allowed values are 0 (no bypasses allowed; most stringent)
and 1 (a single conflicting read may be bypassed).

 -maxgap 30
 (phrap only). Maximum permitted size of an unmatched region in
merging contigs, during first (most stringent) merging pass.

 -repeat_stringency .95
 (phrap only). Controls stringency of match required for joins.  Must
be less than 1 (highest stringency), and greater than 0 (lowest
stringency).

 -revise_greedy *
 (phrap only). Splits initial greedy assembly into pieces at "weak
joins", and then tries to reattach them to give higher overall score.
Use of this option should correct some types of missassembly.

 -shatter_greedy *
 (phrap only). Breaks assembly at weak joins (as with -revise_greedy)
but does not try to reattach pieces.

 -preassemble *
 (phrap only). Preassemble reads within groups, prior to merging with
other groups. This is useful for example when the input data set
consists of reads from two distinct but overlapping clones, and it is
desired to assemble the reads from each clone separately before
merging in order to reduce the risk of incorrect joins due to
repeats. The preassemble merging pass is relatively stringent and not
guaranteed to merge all of the reads from a group.
 Groups are indicated by the first part of the read name, up to the
character specified by -group_delim.

 -force_high *
 (phrap only). Causes edited high-quality discrepancies to be ignored
during final contig merge pass.  This option may be useful when it is
suspected that incorrect edits are causing a misassembly.

6. Consensus sequence construction

 -node_seg 8
 (phrap only). Minimum segment size (for purposes of traversing
weighted directed graph).

 -node_space 4
 (phrap only). Spacing between nodes (in weighted directed graph).

7. Output

 Not implemented in this Perl module.

8. Miscellaneous

 -retain_duplicates *
 (phrap only). Retain exact duplicate reads, rather than eliminating
them.

 -max_subclone_size 5000
 (phrap only). Maximum subclone size -- for forward-reverse read pair
consistency checks.

 -trim_penalty -2
 (phrap only). Penalty used for identifying degenerate sequence at
beginning & end of read.

 -trim_score 20
 (phrap only). Minimum score for identifying degenerate sequence at
beginning & end of read.

 -trim_qual 13
 (phrap only). Quality value used in to define the "high-quality" part
of a read, (the part which should overlap; this is used to adjust
qualities at ends of reads.

 -confirm_length 8
 (phrap only). Minimum size of confirming segment (segment starts at
3d distinct nuc following discrepancy).

 -confirm_trim 1
 (phrap only). Amount by which confirming segments are trimmed at
edges.

 -confirm_penalty -5
 (phrap only). Penalty used in aligning against "confirming" reads.

 -confirm_score 30
 (phrap only). Minimum alignment score for a read to be allowed to
"confirm" part of another read.

 -indexwordsize 10
 Size of indexing (hashing) words, used in finding word matches
between sequences.  The value of this parameter has a generally minor
effect on run time and memory usage.

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  # Register methods
  $self->_set_from_args(
    \@args,
    -methods => [
      @phrap_params,
      @phrap_switches,
    ],
    -create =>  1,
  );
  $self->program_name($program_name) if not defined $self->program_name();
  return $self;
}

=head2 run

 Title   :   run()
 Usage   :   my $asm = $factory->run($fasta)
 Function:   Runs Phrap
 Returns :   assembly file location, Bio::Assembly::IO object, or
               Bio::Assembly::ScaffoldI object
 Args    :   - FASTA file name or reference to an array of sequence objects,
               Bio::PrimarySeqI or Bio::SeqI arrayref
             - Type of results to return [optional]:
                'Bio::Assembly::IO' for the results as an IO object
                'Bio::Assembly::ScaffoldI' for a Scaffold object [default]
                Any other value saves the results in a TIGR-formatted file with
                  the specified name
=cut

sub run {
  my ($self, $seqs, $return_type) = @_;
  my @feats;
  # Sanity checks
  if (not defined $seqs) {
    $self->throw("Need to provide a FASTA file or sequence objects as input");
  }
  my ($fh,$infile1);
  if (ref($seqs) =~ /ARRAY/i) {
    # Input is an array of sequence objects
    my @infilearr;
    ($fh, $infile1) = $self->io->tempfile();
    my $temp = Bio::SeqIO->new( -file => ">$infile1",
                                -format => 'fasta' );
    for my $seq1 (@$seqs) {
      unless ($seq1->isa('Bio::PrimarySeqI') || $seq1->isa('Bio::SeqI')) {
        $self->throw("Not a valid Bio::PrimarySeqI or Bio::SeqI object");
      }
      $temp->write_seq($seq1);
      push @infilearr, $infile1;
    }
  } else {
    # Input is a FASTA file
    if (not -f $seqs) {
      $self->throw("Input file '$seqs' does not seem to exist.");
    }
    $infile1 = $seqs;
  }
  if (not defined $return_type) {
    $return_type = 'Bio::Assembly::ScaffoldI';
  }

  $self->_input($infile1);
  my $assembly = $self->_run($return_type);

  return $assembly;
}

=head2 _input

 Title   :   _input
 Usage   :   $factory->_input($seqFile)
 Function:   get/set for input file
 Returns :
 Args    :

=cut

sub _input() {
   my ($self,$infile1) = @_;
   $self->{'input'} = $infile1 if(defined $infile1);
   return $self->{'input'};
}

=head2 _run

 Title   :   _run
 Usage   :   $factory->_run()
 Function:   Makes a system call and runs Phrap
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   

=cut

sub _run {
  my ($self, $return_type)= @_;

  my $tmpdir = $self->tempdir();
  my ($output_fh,$output_file);
  if ( (not $return_type eq 'Bio::Assembly::ScaffoldI') &&
       (not $return_type eq 'Bio::Assembly::IO'       )  ) {
    # Output is a file with specified name
    $output_file = $return_type;
    open $output_fh, '>', $output_file or $self->throw("Could not write file ".
      "'$output_file': $!");
  } else {
    ($output_fh,  $output_file ) = $self->io->tempfile( -dir => $tmpdir );
  }

  # PHRAP usage:
  # > phrap seq_file1 [seq_file2 ...] [-option value] [-option value] ..
  my $param_str = $self->_setparams(
    -params   => \@phrap_params,
    -switches => \@phrap_switches,
    -join     => ' ',
    -dash     => 1
  );
  my $exe = $self->executable();
  if (!defined($exe)) {
    $self->throw("Could not find executable for '" . $self->program_name() . "'");
  }
  my $input_file = $self->_input();
  my $str = "$exe $param_str $input_file 1> $output_file 2> /dev/null";
  $self->debug($str. "\n");
  my $status = system($str);
  $self->throw( "Phrap call ($str) crashed: $? \n") unless $status==0;
  close($output_fh);

  # Result files
  my $log_file = "$input_file.log";
  my $contigs_file = "$input_file.contigs";
  my $problems_file = "$input_file.problems";
  my $problems_qual_file = "$input_file.problems.qual";
  my $contigs_qual_file = "$input_file.contigs.qual";
  my $singlets_file = "$input_file.singlets";

  # Remove all files except for the PHRAP file
  for my $file ($log_file, $contigs_file, $problems_file, $problems_qual_file,
    $contigs_qual_file, $singlets_file) {
    unlink $file;
  }

  # Import assembly
  my $results;
  my $asm_io;
  my $asm;
  if ( (not $return_type eq 'Bio::Assembly::ScaffoldI') &&
       (not $return_type eq 'Bio::Assembly::IO'       )  ) {
    $results = $output_file;
  } else {
    $asm_io = Bio::Assembly::IO->new(
      -file   => "<$output_file",
      -format => 'phrap' );
    unlink $output_file;
    if ($return_type eq 'Bio::Assembly::IO') {
      $results = $asm_io;
    } else {
      $asm = $asm_io->next_assembly();
      $asm_io->close;
      if ($return_type eq 'Bio::Assembly::ScaffoldI') {
        $results = $asm;
      } else {
        $self->throw("The return type has to be 'Bio::Assembly::IO', 'Bio::".
          "Assembly::ScaffoldI' or a file name.");
      }
    }
  }
  return $results;
}


=head2 _writeSeqFile

 Title   :   _writeSeqFile
 Usage   :   $factory->_writeSeqFile($seq)
 Function:   Creates a file from the given seq object
 Returns :   A string(filename)
 Args    :   Bio::PrimarySeqI

=cut

sub _writeSeqFile{
  my ($self,$seq) = @_;
  my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir());
  my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
  $in->write_seq($seq);
  $in->close();
  close($tfh);
  undef $tfh;
  return $inputfile;
}

1;
