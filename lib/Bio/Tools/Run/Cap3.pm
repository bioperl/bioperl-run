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
use vars qw(@ISA %OK_FIELD @PARAMS *AUTOLOAD);

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

BEGIN {
    @PARAMS      = qw(a b c d e f g h i j k m n o p r s t u v w x y z);
    # What are -i, -j and -k???
    # Authorize attribute fields
    foreach my $attr (@PARAMS) { $OK_FIELD{$attr}++; }
}

=head2 new

 Title   : new
 Usage   : $assembler->new()

Options (default values):
  -a  N  specify band expansion size N > 10 (20)
  -b  N  specify base quality cutoff for differences N > 15 (20)
  -c  N  specify base quality cutoff for clipping N > 5 (12)
  -d  N  specify max qscore sum at differences N > 20 (200)
  -e  N  specify clearance between no. of diff N > 10 (30)
  -f  N  specify max gap length in any overlap N > 1 (20)
  -g  N  specify gap penalty factor N > 0 (6)
  -h  N  specify max overhang percent length N > 2 (20)
  -m  N  specify match score factor N > 0 (2)
  -n  N  specify mismatch score factor N < 0 (-5)
  -o  N  specify overlap length cutoff > 20 (40)
  -p  N  specify overlap percent identity cutoff N > 65 (80)
  -r  N  specify reverse orientation value N >= 0 (1)
  -s  N  specify overlap similarity score cutoff N > 400 (900)
  -t  N  specify max number of word matches N > 30 (300)
  -u  N  specify min number of constraints for correction N > 0 (3)
  -v  N  specify min number of constraints for linking N > 0 (2)
  -w  N  specify file name for clipping information (none)
  -x  N  specify prefix string for output file names (cap)
  -y  N  specify clipping range N > 5 (250)
  -z  N  specify min no. of good reads at clip pos N > 0 (3)

=cut

sub new {
    my ( $caller, @args ) = @_;

    # chained new
    my $self = $caller->SUPER::new(@args);

    # to facilitiate tempfile cleanup
    my ( undef, $tempfile ) = $self->io->tempfile();
    $self->outfile_name($tempfile);
    while (@args) {
        my $attr  = shift @args;
        my $value = shift @args;
        $self->$attr($value);
    }

    $self->program_name($program_name) if not defined $self->program_name();

    return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    my $attr_letter = substr( $attr, 0, 1 );
    # actual key is first letter of $attr unless first attribute
    # letter is underscore (as in _READMETHOD), the $attr is a CAP3
    # parameter and should be truncated to its first letter only
    $attr = ( $attr_letter eq '_' ) ? $attr : $attr_letter;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr_letter} = shift if @_;
    return $self->{$attr_letter};
}

sub program_dir {
    my($self, $val) = @_;
    $self->{'_program_dir'} = $val if $val;
    return $self->{'_program_dir'};
}

sub program_name {
    my($self, $val) = @_;
    $self->{'_program_name'} = $val if $val;
    return $self->{'_program_name'};
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
	my $exe = $self->executable(undef);
   if (!defined($exe)) {
     $self->throw("Could not find executable for '" . $self->program_name() . "' in '" . $self->program_dir() . "'");
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
	my $param_string = $self->_setparams;
	my $commandstring = $exe . " $infilename1 " . $param_string;
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

sub _setparams {
    my $self = shift;
    my ( $attr, $value, @execparams );

    @execparams = @PARAMS;

    my $param_string = "";
    for $attr (@execparams)
    {
        $value = $self->$attr();
        next unless ( defined $value );

        # put params in format expected by CAP3
        $attr = '-' . $attr;
        $param_string .= " $attr  $value ";
    }
    return $param_string;
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
			foreach $seq (@$input1) {
				unless ($seq->isa("Bio::PrimarySeqI") || $seq->isa('Bio::SeqI')) {
              return 0;
            }
				$temp->write_seq($seq);
			}
			close $fh;
			$fh = undef;
			last SWITCH;
      }
      $infilename1 = 0;		# Set error flag if you get here
	}				# End SWITCH
	return ($infilename1);
}

1;
