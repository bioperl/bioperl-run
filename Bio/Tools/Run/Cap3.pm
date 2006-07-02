# $Id$
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code
=head1 NAME

Bio::Tools::Run::Cap3 - wrapper for Cap3

=head1 SYNOPSIS

  # Build a Cap3 factory
  my $factory = Bio::Tools::Run::Coil->new($params);

  # Pass the factory an input file name...
  my $result = $factory->run($filename);

  # or an array of Sequence objects
  my $result = $factory->run(@seqs);

=head1 DESCRIPTION

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

 http://bugzilla.bioperl.org/

=head1 AUTHORS

Marc Logghe

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Cap3;
use vars qw(@ISA %OK_FIELD @PARAMS *AUTOLOAD $PROGRAMDIR);

use strict;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Tools::Run::WrapperBase;
use Bio::Factory::ApplicationFactoryI;

BEGIN {
    @PARAMS     = qw(a b c d e f g m n o p s u v x);
    $PROGRAMDIR = '/usr/local/bin';

    # Authorize attribute fields
    foreach my $attr (@PARAMS) { $OK_FIELD{$attr}++; }
}

@ISA = qw(Bio::Root::Root
			 Bio::Tools::Run::WrapperBase
			 Bio::Factory::ApplicationFactoryI);

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
    return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    my $attr_letter = substr( $attr, 0, 1 );

    # actual key is first letter of $attr unless first attribute
    # letter is underscore (as in _READMETHOD), the $attr is a BLAST
    # parameter and should be truncated to its first letter only
    $attr = ( $attr_letter eq '_' ) ? $attr : $attr_letter;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr_letter} = shift if @_;
    return $self->{$attr_letter};
}

sub program_dir {
    $PROGRAMDIR;
}

sub program_name {
    'cap3';
}

sub run {
	my ($self, $input) = @_;
	my $param_string = $self->_setparams;
	my $exe = $self->executable;
	# Create input file pointer
	my $infilename1 = $self->_setinput($input);
	if (! $infilename1) {
		$self->throw(" $input ($infilename1) not array of Bio::Seq objects or file name!");
	}

	my $commandstring = $exe . $param_string . " $infilename1";

	open(CAP3, "$commandstring |") || 
	  $self->throw(sprintf("%s call crashed: %s %s\n", $self->program_name, $!, $commandstring));
	local $/ = undef;
	my ($result) = <CAP3>;
	close CAP3;
	return $result;
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

        # put params in format expected by cap3
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
			last SWITCH; 
      }
		#  $input may be an array of BioSeq objects...
      if (ref($input1) =~ /ARRAY/i ) {
			($fh,$infilename1) = $self->io->tempfile();
			$temp =  Bio::SeqIO->new(-fh=> $fh, '-format' => 'Fasta');
			foreach $seq (@$input1) {
				unless ($seq->isa("Bio::PrimarySeqI")) {return 0;}
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
