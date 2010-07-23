# $Id$
#
# Copyright Balamurugan Kumarasamy
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Blat  

=head1 SYNOPSIS

Build a Blat factory.

  use Bio::Tools::Run::Alignment::Blat;

  my $factory = Bio::Tools::Run::Alignment::Blat->new();

  # Pass the factory a Bio::Seq object
  # @feats is an array of Bio::SeqFeature::Generic objects
  my @feats = $factory->run($seq,$DB);

=head1 DESCRIPTION

Wrapper module for Blat program

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

=head1 AUTHOR - Bala

 Email bala@tll.org.sg

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::Blat;

use vars qw($AUTOLOAD @ISA $PROGRAM  $PROGRAMDIR
            $PROGRAMNAME @BLAT_PARAMS @OTHER_SWITCHES 
				%OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Factory::ApplicationFactoryI;
use Bio::SearchIO;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN {
       @BLAT_PARAMS=qw(DB PROGRAM OOC DB_TYPE QUERY_TYPE TILESIZE 
							  ONEOFF MINMATCH MINSCORE MINIDENTITY MAXGAP 
							  MAKEOOC REPMATCH MASK QMASK DOTS
                       MINREPDIV TRIMT NOTRIMA VERBOSE);
       @OTHER_SWITCHES = qw(QUIET);
       foreach my $attr ( @BLAT_PARAMS, @OTHER_SWITCHES)
			{ $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns : string
 Args    : None

=cut

sub program_name {
  return 'blat';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns : string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{BLATDIR}) if $ENV{BLATDIR};
}

sub AUTOLOAD {
	my $self = shift;
	my $attr = $AUTOLOAD;
	$attr =~ s/.*:://;
	$attr = uc $attr;
	$self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
	$self->{$attr} = shift if @_;
	return $self->{$attr};
}

=head2 new

 Title   : new
 Usage   : $blat->new(@params)
 Function: creates a new Blat factory
 Returns : Bio::Tools::Run::Alignment::Blat
 Args    :

=cut

sub new {
	my ($class,@args) = @_;
	my $self = $class->SUPER::new(@args);
	my ($attr, $value);
	while (@args)  {
		$attr =   shift @args;
		$value =  shift @args;
		next if ( $attr =~ /^-/ ); # don't want named parameters
		if ($attr =~/PROGRAM/i) {
			$self->executable(Bio::Root::IO->catfile($value,$self->program_name));
			next;
		}
		$self->$attr($value);
	}
	return $self;
}

=head2 run

 Title   :   run()
 Usage   :   $obj->run($query)
 Function:   Runs Blat and creates an array of featrues
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :   A Bio::PrimarySeqI

=cut

sub run {
	my ($self,$query) = @_;
	my @feats;

	if  (ref($query) ) {	# it is an object
    	if (ref($query) =~ /GLOB/) {
	      $self->throw("Cannot use filehandle as argument to run()");
    	}
    	my $infile1 = $self->_writeSeqFile($query);
    	$self->_input($infile1);
      return  $self->_run();
	} else {
		$self->_input($query);
		return $self->_run();
	}
}

=head2 align

 Title   :   align
 Usage   :   $obj->align($query)
 Function:   Alias to run()

=cut

sub align {
  return shift->run(@_);
}

=head2 _input

 Title   :   _input
 Usage   :   obj->_input($seqFile)
 Function:   Internal (not to be used directly)
 Returns :
 Args    :

=cut

sub _input() {
    my ($self,$infile1) = @_;
    if(defined $infile1){
        $self->{'input'}=$infile1;
     }   
     return $self->{'input'};
}

=head2 _database

 Title   :   _database
 Usage   :   obj->_database($seqFile)
 Function:   Internal (not to be used directly)
 Returns :
 Args    :

=cut

sub _database() {
    my ($self,$infile1) = @_;
    $self->{'db'} = $infile1 if(defined $infile1);
    return $self->{'db'};
}


=head2 _run

 Title   :   _run
 Usage   :   $obj->_run()
 Function:   Internal (not to be used directly)
 Returns :   An array of Bio::SeqFeature::Generic objects
 Args    :

=cut

sub _run {
	my ($self)= @_;
	my ($tfh,$outfile) = $self->io->tempfile(-dir=>$Bio::Root::IO::TEMPDIR);
	# this is because we only want a unique filename
	close($tfh);
	undef $tfh;

	my $str= $self->executable;

	$str .= ' -out=psl '.$self->DB .' '.$self->_input.' '.$outfile;

#this is shell specific, please fix
#     if ($self->quiet() || $self->verbose() < 0) { 
#	 $str .= '  >/dev/null 2>/dev/null';
#     }

	$self->debug($str ."\n") if( $self->verbose > 0 );

	my $status = system($str);
	$self->throw( "Blat call ($str) crashed: $? \n") unless $status==0;

	my $blat_obj;
	if (ref ($outfile) !~ /GLOB/) {
		$blat_obj = Bio::SearchIO->new(-format  => 'psl',
												 -file    => $outfile);
	} else {
		$blat_obj = Bio::SearchIO->new(-format  => 'psl',
												 -fh    => $outfile);
	}
	system('cp',$outfile,'/tmp/blat.out');
	$self->cleanup();
	return $blat_obj;
}


=head2 _writeSeqFile

 Title   :   _writeSeqFile
 Usage   :   obj->_writeSeqFile($seq)
 Function:   Internal (not to be used directly)
 Returns :
 Args    :

=cut

sub _writeSeqFile {
    my ($self,$seq) = @_;
    #my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$self->tempdir());
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$Bio::Root::IO::TEMPDIR);
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
    $in->write_seq($seq);
    $in->close();
    undef $in;
    close($tfh);
    undef $tfh;
    return $inputfile;
}
1;
