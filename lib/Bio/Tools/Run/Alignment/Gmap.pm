# $Id$
#
# BioPerl module for Bio::Tools::Run::Alignment::Gmap
#
# Cared for by George Hartzell <hartzell@alerce.com>
#
# Copyright George Hartzell
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Gmap - Wrapper for running gmap.

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::Gmap;
  use Bio::SeqIO;

  my $sio = Bio::SeqIO->new(-file=>$filename ,-format=>'fasta');
  my @seq;
  while(my $seq = $sio->next_seq()){
    push @seq,$seq;
  }
  my $mapper =Bio::Tools::Run::Gmap->new();
  my $result = $mapper->run(\@seq);


=head1 DESCRIPTION

Bioperl-run wrapper around gmap.  See
L<http://www.gene.com/share/gmap/> for information about gmap.

It requires a reference to an array of bioperl SeqI objects and
returns a reference to a filehandle from which the gmap output can be
read.

One can explicitly set the name of the genome database (defaults to
NHGD_R36) using the 'genome_db()' method.  One can also explicitly set
the flags that are passed to gmap (defaults to '-f 9 -5 -e') using the
'flags()' method.

The name of the gmap executable can be overridden using the
program_name() method and the directory in which to find that
executable can be overridden using the program_dir() method.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - George Hartzell

Email hartzell@alerce.com

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...

# TODO handle stderr output from gmap.

package Bio::Tools::Run::Alignment::Gmap;
use strict;
use warnings;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
use Bio::SeqIO;


use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase
            Bio::Factory::ApplicationFactoryI);

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::Alignment::Gmap();
 Function: Builds a new Bio::Tools::Run::Alignment::Gmap object
 Returns : an instance of Bio::Tools::Run::Alignment::Gmap
 Args    :


=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
  $self->{_program_name} = 'gmap';
  return $self;
}

=head2 version

 Title   : version
 Usage   : print "gmap version: " . $mapper->version() . "\n";
 Function: retrieves and returns the version of the gmap package.
 Example :
 Returns : scalar string containing the version number.  Probably looks
           like YYYY-MM-DD.
 Args    : none.


=cut

sub version {
   my ($self,@args) = @_;
   my $version;

   my $str = $self->executable;
   $str .= ' --version';
   $self->debug("gmap version command = $str\n");

   open(GMAPRUN, "$str |") || $self->throw($@);

   {
       local $/ = undef;
       my $result = <GMAPRUN>;
       ($version) = ($result =~ m|.*Part of GMAP package, version (.*).*|);
   }

   return($version);

}

=head2 program_name

 Title   : program_name
 Usage   : $mapper->program_name('gmap-dev');
           my $pname = $mapper->program_name();
 Function: sets/gets the name of the program to run.
 Returns : string representing the name of the executable.
 Args    : [optional] string representing the name of the executable
           to set.

=cut

sub program_name {
   my $self = shift;

   $self->{_program_name} = shift if @_;
   return $self->{_program_name};
}

=head2 program_dir

 Title   : program_dir
 Usage   : $mapper->program_dir('/usr/local/sandbox/gmap/bin');
           my $pdir = $mapper->program_dir();
 Function: sets/gets the directory path in which
           to find the gmap executable.
 Returns : string representing the path to the directory.
 Args    : [optional] string representing the directory path to set.

=cut

sub program_dir {
  my $self = shift;

  $self->{_program_dir} = shift if @_;
  return $self->{_program_dir};
}

=head2 input_file

 Title   : input_file
 Usage   : $mapper->input_file('/tmp/moose.fasta');
           my $filename = $mapper->input_file();
 Function: sets/gets the name of a file containing sequences
           to be mapped.
 Returns : string containing the name of the query sequence.
 Args    : [optional] string representing the directory path to set.

=cut

sub input_file {
  my $self = shift;

  $self->{_input_file} = shift if @_;
  return $self->{_input_file};
}

=head2 genome_db

 Title   : genome_db
 Usage   : $mapper->genome_db('NHGD_R36');
           my $genome_db = $mapper->genome_db();
 Function: sets/gets the name of the genome database, this will be
           passed to gmap using its '-d' flag.
 Returns : name of the genome database.
 Args    : [optional] string representing the genome db to set.

=cut

sub genome_db {
  my $self = shift;

  $self->{_genome_db} = shift if @_;
  return $self->{_genome_db};
}

=head2 flags

 Title   : flags
 Usage   : $mapper->flags('-A -e -5');
           my $flags = $mapper->flags();
 Function: sets/gets the flags that will be passed to gmap.
 Returns : the current value of the flags that will be passed to gmap.
 Args    : [optional] the flags to set.

=cut

sub flags {
  my $self = shift;

  $self->{_flags} = shift if @_;
  return $self->{_flags};
}

=head2 run

 Title   : run
 Usage   : $mapper->run()
 Function: runs gmap
 Example :
 Returns : a file handle, opened for reading, for gmap's output.
 Args    : An array of references query sequences (as Bio::Seq objects)


=cut

sub run {
  my $self = shift;

  $self->input_file( $self->_build_fasta_input_file(@_) ) if(@_);

  my $result = $self->_run();

  return $result;
}

=head2 _build_fasta_input_file

 Title   : _build_fasta_input_file
 Usage   : my $seq_file = $self->_build_fasta_input_file(@_);
 Function:
 Example :
 Returns : The name of the temporary file that contains the sequence.
 Args    : A reference to an array of Bio::Seq objects.

=cut

use File::Temp;

sub _build_fasta_input_file {
  my $self = shift;
  my $seqs = shift;
  my $seq_count = 0;

  # the object returned by File::Temp->new() is magic.  Used normally
  # it behaves as a filehandle opened onto the temporary file.  Used
  # as a string it behaves as a string that is the name of the
  # temporary file.
  # It is up to the user to remove the when finished with it.
  my $file_tmp = File::Temp->new( TEMPLATE => 'mvp-gmap-tempfile-XXXXXX',
				  TMPDIR => 1,
				  UNLINK => 0,
				);
  my $seqio = Bio::SeqIO->new( -fh => $file_tmp, -format => 'Fasta' );

  if (ref($seqs) =~ /ARRAY/i) {
    foreach my $seq (@$seqs) {
      throw
	Bio::Root::BadParameter(-text =>
				"sequence args must be a Bio::SeqI subclass.",
			       )
	    unless ($seq->isa("Bio::PrimarySeqI"));

      $seqio->write_seq($seq);
      $seq_count++;
    }
  }
  if ($seq_count == 0) {
    throw
      Bio::Root::BadParameter(-text => <<EOM
You must supply a reference to an array of Bio::SeqI objects.
EOM
			     );
  }

  # pass back the filename of the temporary file (see above)
  return ("$file_tmp");
}


sub _run {
  my $self = shift;

  my $str = $self->executable;
  $str .= ' -d' . ($self->genome_db() || 'NHGD_R36');
  $str .= ' ' . ($self->flags() || '-f 9 -5 -e');
  $str .= ' ' . $self->input_file();
  $str .= ' 2> /dev/null';
  $str .= '; rm -f ' . $self->input_file();
  $self->debug("gmap command = $str\n");

  open(GMAPRUN, "$str |") || $self->throw("Can't open gmap (command = \"$str\"): $!");

  return (\*GMAPRUN);
}

1;
