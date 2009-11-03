# $Id$
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Cap3 - wrapper for CAP3

=head1 SYNOPSIS

  # Build a Cap3 factory with an (optional) parameter list
  my @params = ('y', '150');
  my $factory = Bio::Tools::Run::Cap3->new(@params);

  # Specify where CAP3 is installed, if not the default directory (/usr/local/bin):
  $factory->program_dir('/opt/bio/bin');

  # Pass the factory an input file name...
  my $result = $factory->run($filename);

  # or an arrayref of Sequence objects
  my $result = $factory->run(\@seqs);

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

  http://bugzilla.open-bio.org/

=head1 AUTHORS

Marc Logghe

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Cap3;

use strict;
use File::Copy;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Assembly::IO;
use Bio::Tools::Run::WrapperBase;
use Bio::Factory::ApplicationFactoryI;

use base qw(Bio::Root::Root
            Bio::Tools::Run::WrapperBase
            Bio::Factory::ApplicationFactoryI);

our $program_name = 'cap3';
our @cap3_params = (qw(a b c d e f g h m n o p r s t u v w x y z));
our %tasm_options = (
  'band_expansion_size'        => 'a',
  'differences_quality_cutoff' => 'b',
  'clipping_quality_cutoff'    => 'c',
  'max_qscore_sum'             => 'd',
  'extra_nof_differences'      => 'e',
  'max_gap_length'             => 'f',
  'gap_penalty_factor'         => 'g',
  'max_overhand_percent'       => 'h',
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

=head2 program_name

 Title   : program_name
 Usage   : $assembler>program_name()
 Function: get/set the program name
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

=head2 new

 Title   : new
 Usage   : $assembler->new(
             -overlap_length_cutoff   => 35,
             -overlap_identity_cutoff => 98 # %
           }
 Returns : Bio::Tools::Run::Cap3 object
 Args    : CAP3 options available in this module:
  'band_expansion_size'        specify band expansion size N > 10 (20)
  'differences_quality_cutoff' specify base quality cutoff for differences N > 15 (20)
  'clipping_quality_cutoff'    specify base quality cutoff for clipping N > 5 (12)
  'max_qscore_sum'             specify max qscore sum at differences N > 20 (200)
  'extra_nof_differences'      specify clearance between no. of diff N > 10 (30)
  'max_gap_length'             specify max gap length in any overlap N > 1 (20)
  'gap_penalty_factor'         specify gap penalty factor N > 0 (6)
  'max_overhand_percent'       specify max overhang percent length N > 2 (20)
  'match_score_factor'         specify match score factor N > 0 (2)
  'mismatch_score_factor'      specify mismatch score factor N < 0 (-5)
  'overlap_length_cutoff'      specify overlap length cutoff > 20 (40)
  'overlap_identity_cutoff'    specify overlap percent identity cutoff N > 65 (80)
  'reverse_orientation_value'  specify reverse orientation value N >= 0 (1)
  'overlap_score_cutoff'       specify overlap similarity score cutoff N > 400 (900)
  'max_word_occurrences'       specify max number of word matches N > 30 (300)
  'min_correction_constraints' specify min number of constraints for correction N > 0 (3)
  'min_linking_constraints'    specify min number of constraints for linking N > 0 (2)
  'clipping_info_file'         specify file name for clipping information (none)
  'output_prefix_string'       specify prefix string for output file names (cap)
  'clipping_range'             specify clipping range N > 5 (250)
  'min_clip_good_reads'        specify min no. of good reads at clip pos N > 0 (3)

=cut

sub new {
  my ( $caller, @args ) = @_;
  my $self = $caller->SUPER::new(@args);

  #####
  # to facilitiate tempfile cleanup
  my ( undef, $tempfile ) = $self->io->tempfile();
  $self->outfile_name($tempfile);
  #####

  $self->_set_from_args(
    \@args,
    -methods => [ @cap3_params ],
    -create =>  1,
  );
  $self->program_name($program_name) if not defined $self->program_name();
  return $self;
}

=head2 run

 Title   :   run
 Usage   :   $obj->run($input, $return_type);
 Function:   Runs CAP3
 Returns :   - a Bio::Assembly::ScaffoldI object, a Bio::Assembly::IO
               object, a filename, or undef if all sequences were too small to
               be usable
 Args    :   - arrayred of sequences (Bio::PrimarySeqI or Bio::SeqI objects),
                or FASTA file
             - type of results to return [optional]:
                'Bio::Assembly::IO' for the results as an IO object
                'Bio::Assembly::ScaffoldI' for a Scaffold object [default]
                Any other value saves the results in an ACE-formatted file with
                 the specified name
=cut

sub run {
  my ($self, $input, $return_type) = @_;
  my $exe = $self->executable();
  if (!defined($exe)) {
    $self->throw("Could not find executable for '" . $self->program_name() . "'");
  }
  if (not defined $return_type) {
    $return_type = 'Bio::Assembly::ScaffoldI';
  }

  # Create input file
  my $infilename1 = $self->_setinput($input);
  if (! $infilename1) {
    $self->throw(" $input ($infilename1) not array of Bio::Seq objects or file name!");
  }

  # Execute CAP3
  my $param_string = $self->_setparams(
    -params   => \@cap3_params,
    -join     => ' ',
    -dash     => 1
  );
  my $commandstring = "$exe $infilename1 $param_string";
  open(CAP3, "$commandstring |") ||
    $self->throw(sprintf("%s call crashed: %s %s\n", $self->program_name, $!, $commandstring));
  local $/ = undef;
  #my ($result) = <CAP3>;
  <CAP3>;
  close CAP3;

  # Result files
  my $prefix = $self->x() || 'cap';
  my $ace_file     = "$infilename1.$prefix.ace";
  my $contigs_file = "$infilename1.$prefix.contigs";
  my $qual_file    = "$infilename1.$prefix.contigs.links";
  my $links_file   = "$infilename1.$prefix.contigs.qual";
  my $info_file    = "$infilename1.$prefix.info";
  my $singlet_file = "$infilename1.$prefix.singlets";

  # Remove all files except for the ACE file
  for my $file ($contigs_file, $qual_file, $links_file, $info_file, $singlet_file) {
    unlink $file;
  }

  # Process results
  my $results;
  my $asm_io;
  my $asm;
  if ( (not $return_type eq 'Bio::Assembly::ScaffoldI') &&
       (not $return_type eq 'Bio::Assembly::IO'       )  ) {
    # Move the ACE file to its final destination
    move $ace_file, $return_type or $self->throw("Error: could not move ".
      "filename '$ace_file' to '$return_type': $!");
    $results = $return_type;
  } else {
    $asm_io = Bio::Assembly::IO->new(
      -file   => "<$ace_file",
      -format => 'ace' );
    unlink $ace_file;
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

sub _setinput {
  my ($self, $input1) = @_;
  my ($seq, $temp, $infilename1, $fh ) ;

  # If $input1 is not a reference it better be the name of a file
  # with the sequence data...
  $self->io->_io_cleanup();

  SWITCH:  {
    unless (ref $input1) {
      $infilename1 = (-e $input1) ? $input1 : 0 ;
      # Check for line feeds \r :
      if ($infilename1) {
        open my $fh, '<', $infilename1 or $self->throw("Could not read file ".
          "'$infilename1': $!");
        while ( my $line = <$fh> ) {
          if ($line =~ m/\r/) {
            $self->throw("Found a linefeed (\\r) in FASTA file '$infilename1'.".
              " Aborting because CAP3 misbehaves with linefeeds. Try removing".
              " them from your FASTA file or inputting sequence  objects to ".
              "the run() function.");
            last;
          }
        }
        close $fh;
      }
      last SWITCH;
    }
    # $input may be an arrayref of BioSeq objects...
    if (ref($input1) =~ /ARRAY/i ) {
      ($fh,$infilename1) = $self->io->tempfile();
      $temp =  Bio::SeqIO->new(-fh=> $fh, '-format' => 'Fasta');
      for $seq (@$input1) {
        unless ($seq->isa("Bio::PrimarySeqI") || $seq->isa('Bio::SeqI')) {
          return 0;
        }
         $temp->write_seq($seq);
      }
      close $fh;
      last SWITCH;
    }
    $infilename1 = 0;		# Set error flag if you get here
  } # End SWITCH
  return ($infilename1);
}

1;