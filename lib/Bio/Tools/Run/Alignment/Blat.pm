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

use strict;
use warnings;
use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Factory::ApplicationFactoryI;
use Bio::SearchIO;
use Bio::Tools::Run::WrapperBase;

our ($PROGRAM, $PROGRAMDIR, $PROGRAMNAME);

our %BLAT_PARAMS = map {$_ => 1} qw(ooc t q tileSize stepSize oneOff
    minMatch minScore minIdentity maxGap makeOoc repmatch mask qMask repeats
    minRepeatsDivergence dots out maxIntron);
our %BLAT_SWITCHES = map {$_ => 1} qw(prot noHead trimT noTrimA trimHardA
                                    fastMap fine extendThroughN);

our %LOCAL_ATTRIBUTES = map {$_ => 1} qw(db segment outfile_name searchio);

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
    $self->io->_initialize_io();
    $self->set_parameters(@args);
    return $self;
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
    	my $infile = $self->_writeSeqFile($query);
        return  $self->_run($infile);
	} else {
		return $self->_run($query);
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

=head2 db

=cut

sub db {
    my $self = shift;
    return $self->{blat_db} = shift if @_;
    return $self->{blat_db};
}

sub segment {
    my $self = shift;
    return $self->{blat_segment} = shift if @_;
    return $self->{blat_segment};
}

# override this, otherwise one gets a default of 'mlc'
sub outfile_name {
    my $self = shift;
    return $self->{blat_outfile} = shift if @_;
    return $self->{blat_outfile};
}

sub searchio {
    my $self = shift;
    $self->{blat_searchio} = shift if @_;
    
    # TODO: This needs to check for
    return $self->{blat_searchio} || 'psl';
}

=head1 Bio::ParameterBaseI-specific methods

These methods are part of the Bio::ParameterBaseI interface

=cut

=head2 set_parameters

 Title   : set_parameters
 Usage   : $pobj->set_parameters(%params);
 Function: sets the parameters listed in the hash or array
 Returns : None
 Args    : [optional] hash or array of parameter/values.  These can optionally
           be hash or array references
 Note    : This only sets parameters; to set methods use the method name
=cut

sub set_parameters {
    my $self = shift;
    # circumvent any issues arising from passing in refs
    my %args = (ref($_[0]) eq 'HASH')  ? %{$_[0]} :
               (ref($_[0]) eq 'ARRAY') ? @{$_[0]} :
               @_;
    # set the parameters passed in, but only ones supported for the program
    %args = map { my $a = $_;
              $a =~ s{^-}{};
              $a => $args{$_};
                 } sort keys %args;
    
    while (my ($key, $val) = each %args) {
        if (exists $BLAT_PARAMS{$key}) {
            $self->{parameters}->{$key} = $val;
        } elsif (exists $BLAT_SWITCHES{$key}) {
            $self->{parameters}->{$key} = $BLAT_SWITCHES{$key} ? 1 : 0;
        } elsif ($self->can($key)) {
            $self->$key($val);
        } 
    }
}

=head2 reset_parameters

 Title   : reset_parameters
 Usage   : resets values
 Function: resets parameters to either undef or value in passed hash
 Returns : none
 Args    : [optional] hash of parameter-value pairs

=cut

sub reset_parameters {
    my $self = shift;
    delete $self->{parameters};
    if (@_) {
        $self->set_parameters(@_);
    }
}

=head2 validate_parameters

 Title   : validate_parameters
 Usage   : $pobj->validate_parameters(1);
 Function: sets a flag indicating whether to validate parameters via
           set_parameters() or reset_parameters()
 Returns : Bool
 Args    : [optional] value evaluating to True/False
 Note    : NYI

=cut

sub validate_parameters { 0 }

=head2 parameters_changed

 Title   : parameters_changed
 Usage   : if ($pobj->parameters_changed) {...}
 Function: Returns boolean true (1) if parameters have changed
 Returns : Boolean (0 or 1)
 Args    : None
 Note    : This module does not run state checks, so this always returns True

=cut

sub parameters_changed { 1 }

=head2 available_parameters

 Title   : available_parameters
 Usage   : @params = $pobj->available_parameters()
 Function: Returns a list of the available parameters
 Returns : Array of parameters
 Args    : [optional] name of executable being used; defaults to returning all
           available parameters

=cut

sub available_parameters {
    my ($self, $exec) = @_;
    my @params = (sort keys %BLAT_PARAMS, sort keys %BLAT_SWITCHES);
    return @params;
}

=head2 get_parameters

 Title   : get_parameters
 Usage   : %params = $pobj->get_parameters;
 Function: Returns list of set key-value pairs, parameter => value
 Returns : List of key-value pairs
 Args    : none

=cut

sub get_parameters {
    my ($self, $option) = @_;
    $option ||= ''; # no option
    my %params;
    if (exists $self->{parameters}) {
        %params = map {$_ => $self->{parameters}->{$_}} sort keys %{$self->{parameters}};
    } else {
        %params = ();
    }
    return %params;
}

=head1 to_* methods

All to_* methods are implementation-specific

=cut

=head2 to_exe_string

 Title   : to_exe_string
 Usage   : $string = $pobj->to_exe_string;
 Function: Returns string (command line string in this case)
 Returns : String 
 Args    : 

=cut

sub to_exe_string {
    my ($self, @passed) = @_;
    my ($seq) = $self->_rearrange([qw(SEQ_FILE)], @passed);
    $self->throw("Must provide a seq_file") unless defined $seq;
    my %params = $self->get_parameters();
    
    my ($exe, $prog, $db, $segment) = ($self->executable,
                                   $self->program_name,
                                   $self->db,
                                   $self->segment);
    
    $self->throw("Executable not found") unless defined($exe);

    if ($segment) {
        $db .= ":$segment";
    }
    
    my @params;
    
    for my $p (sort keys %BLAT_SWITCHES) {
        if (exists $params{$p}) {
            push @params, "-$p"
        }
    }

    for my $p (sort keys %BLAT_PARAMS) {
        if (exists $params{$p}) {
            push @params, "-$p=$params{$p}"
        }
    }
    
    # this only passes in the first seq file (no globs are allow AFAIK)
    
    push @params, ($db, $seq);

    # quiet! Unfortunately, it is NYI
    
    my $string = "$exe ".join(' ',@params);

    $string;
}

#=head2 _input
#
# Title   :   _input
# Usage   :   obj->_input($seqFile)
# Function:   Internal (not to be used directly)
# Returns :
# Args    :
#
#=cut

sub _input() {
    my ($self,$infile1) = @_;
    if(defined $infile1){
        $self->{'input'}=$infile1;
     }   
     return $self->{'input'};
}

#=head2 _database
#
# Title   :   _database
# Usage   :   obj->_database($seqFile)
# Function:   Internal (not to be used directly)
# Returns :
# Args    :
#
#=cut

sub _database() {
    my ($self,$infile1) = @_;
    $self->{'db'} = $infile1 if(defined $infile1);
    return $self->{'db'};
}


#=head2 _run
#
# Title   :   _run
# Usage   :   $obj->_run()
# Function:   Internal (not to be used directly)
# Returns :   An array of Bio::SeqFeature::Generic objects
# Args    :
#
#=cut

sub _run {
	my ($self)= shift;
	my $str = $self->to_exe_string(-seq_file => shift);
    
    my $out = $self->outfile_name || $self->_tempfile;
    
    $str .= " $out".$self->_quiet;
	$self->debug($str."\n") if( $self->verbose > 0 );

	my $status = system($str);
	$self->throw( "Blat call ($str) crashed: $? \n") unless $status==0;
	
	my $blat_obj;
	if (ref ($out) !~ /GLOB/) {
		$blat_obj = Bio::SearchIO->new(-format  => $self->searchio,
                                        -file    => $out);
	} else {
		$blat_obj = Bio::SearchIO->new(-format  => $self->searchio,
									   -fh    => $out);
	}
	return $blat_obj;
}


#=head2 _writeSeqFile
#
# Title   :   _writeSeqFile
# Usage   :   obj->_writeSeqFile($seq)
# Function:   Internal (not to be used directly)
# Returns :
# Args    :
#
#=cut

sub _writeSeqFile {
    my ($self,$seq) = @_;
    #my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$Bio::Root::IO::TEMPDIR);
    my ($tfh,$inputfile) = $self->io->tempfile(-dir=>$Bio::Root::IO::TEMPDIR);
    my $in  = Bio::SeqIO->new(-fh => $tfh , '-format' => 'fasta');
    $in->write_seq($seq);
    $in->close();
    return $inputfile;
}

sub _tempfile {
    my $self = shift;
    my ($tfh,$outfile) = $self->io->tempfile(-dir=>$Bio::Root::IO::TEMPDIR);
	# this is because we only want a unique filename
	close($tfh);
    return $outfile;
}

sub _quiet {
    my $self = shift;
    my $q = '';
    # BLAT output goes to a file, all other output is STDOUT
    if ($self->quiet) {
        $q =  $^O =~ /Win/i ? ' 2>&1 NUL' : ' > /dev/null 2>&1';
    }
    $q;
}

1;
