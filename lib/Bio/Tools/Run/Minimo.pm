# BioPerl module for Bio::Tools::Run::Minimo
#
# Copyright Florent E Angly <florent-dot-angly-at-gmail-dot-com>
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

  Bio::Tools::Run::Minimo - Wrapper for local execution of the Minimo assembler

=head1 SYNOPSIS

  use Bio::Tools::Run::Minimo;
  # Run Minmo using an input FASTA file
  my $factory = Bio::Tools::Run::Minimo->new( -minimum_overlap_length => 35 );
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

  # Run Minimo using input sequence objects and returning an assembly file
  my $asm_file = 'results.ace';
  $factory->out_type($asm_file);
  $factory->run(\@seqs);

=head1 DESCRIPTION

  Wrapper module for the local execution of the DNA assembly program Minimo.
  Minimo is based on AMOS (http://sourceforge.net/apps/mediawiki/amos/) and
  implements the same conservative assembly algorithm as Minimus
  (http://sourceforge.net/apps/mediawiki/amos/index.php?title=Minimus).

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


package Bio::Tools::Run::Minimo;

use strict;
use IPC::Run;
use File::Copy;
use File::Spec;
use File::Basename;

use base qw( Bio::Root::Root Bio::Tools::Run::AssemblerBase );

our $program_name = 'Minimo'; # name of the executable
our @program_params = (qw( qual_in good_qual bad_qual min_len min_ident aln_wiggle out_prefix ace_exp ));
our @program_switches;
our %param_translation = (
  'qual_in'    => 'D QUAL_IN',
  'good_qual'  => 'D GOOD_QUAL',
  'bad_qual'   => 'D BAD_QUAL',
  'min_len'    => 'D MIN_LEN',
  'min_ident'  => 'D MIN_IDENT',
  'aln_wiggle' => 'D ALN_WIGGLE',
  'out_prefix' => 'D OUT_PREFIX',
  'ace_exp'    => 'D ACE_EXP'
);

our $qual_param = 'qual_in';
our $use_dash = 1;
our $join = '=';
our $asm_format = 'ace';


=head2 new

 Title   : new
 Usage   : $assembler->new( -min_len   => 50,
                            -min_ident => 95 );
 Function: Creates a Minimo factory
 Returns : A Bio::Tools::Run::Minimo object
 Args    : Minimo options available in this module:
     qual_in      Input quality score file
     good_qual    Quality score to set for bases within the clear
                    range if no quality file was given (default: 30)
     bad_qual     Quality score to set for bases outside clear range
                    if no quality file was given (default: 10). If your
                    sequences are trimmed, try the same value as GOOD_QUAL.
     min_len / minimum_overlap_length
                  Minimum contig overlap length (between 20 and 100 bp,
                    default: 35)
     min_ident / minimum_overlap_similarity
                  Minimum contig overlap identity percentage (between 0
                    and 100 %, default: 98)
     aln_wiggle   Alignment wiggle value when determining the consensus
                    sequence (default: 2 bp)
     out_prefix   Prefix to use for the output file path and name

=cut

sub new {
  my ($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
  $self->_set_program_options(\@args, \@program_params, \@program_switches,
    \%param_translation, $qual_param, $use_dash, $join);
  *minimum_overlap_length = \&min_len;
  *minimum_overlap_similarity = \&min_ident;
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
 Usage   :   $factory->_run()
 Function:   Make a system call and run TIGR Assembler
 Returns :   An assembly file
 Args    :   - FASTA file
             - optional QUAL file

=cut


sub _run {
  my ($self, $fasta_file, $qual_file) = @_;

  #   qual_in      Input quality score file
  #   fasta_exp    Export results in FASTA format (0:no 1:yes, default: 1)
  #   ace_exp      Export results in ACE format (0:no 1:yes, default: 1)

  # Specify that we want an ACE output file
  $self->ace_exp(1);

  # Setup needed files and filehandles first
  my ($output_fh, $output_file) = $self->_prepare_output_file( );
  my ($stdout_fh, $stdout_file) = $self->io->tempfile( -dir => $self->tempdir() );

  # Get program executable
  my $exe = $self->executable;

  # Get command-line options
  my $options = $self->_translate_params();

  # Usage: Minimo FASTA_IN [options]
  # Options are of the style: -D PARAM=VAL
  my @program_args = ( $exe, $fasta_file, @$options);
  my @ipc_args = ( \@program_args, '>', $stdout_file);

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
  my $log_file = "$fasta_file.runAmos.log";
  eval {
    IPC::Run::run(@ipc_args) || die("There was a problem running $exe. The ".
      "error message is: $!. Check the log file $log_file for possible causes.");
  };
  if ($@) {
    $self->throw("$exe call crashed: $@");
  }

  # Close filehandles
  close($output_fh);
  close($stdout_fh);

  # Result files
  my $base = $self->out_prefix();
  if (not defined $base) {
    my $dirname  = dirname($fasta_file);
    my $basename = basename($fasta_file);
    $basename    =~ s/^(.+)\..+$/$1/;
    $base        = File::Spec->catfile($dirname, $basename);
  }
  my $ace_file   = "$base-contigs.ace";
  my $amos_file  = "$base-contigs.afg";

  # Remove all files except for the ACE file
  for my $file ($log_file, $stdout_file, $amos_file) {
    unlink $file;
  }

  # Clean the ACE file
  $self->_clean_file($ace_file);

  # Move the ACE file to its final destination
  move ($ace_file, $output_file) or $self->throw("Could not move file ".
    "'$ace_file' to '$output_file': $!");

  return $output_file;
}

=head2 _clean_file

 Title   :   _clean_file
 Usage   :   $factory->_clean_file($file)
 Function:   Clean file in place by removing NULL characters. NULL characters
             can be present in the output files of AMOS 2.0.8 but they do not
             validate as proper sequence characters in Bioperl.
 Returns :   1 for success
 Args    :   Filename

=cut

sub _clean_file {
  my ($self, $file) = @_;
  # Set in-place file editing mode
  local $^I = "~";
  local @ARGV = ( $file );
  # Replace lines in file
  while (<>) {
    s/\x0//g;
    print;
  }
  return 1;
}

1;
