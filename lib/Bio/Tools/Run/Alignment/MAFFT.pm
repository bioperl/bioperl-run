# $Id$
#
# BioPerl module for Bio::Tools::Run::Alignment::MAFFT
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Jason Stajich
#
# Copyright Jason Stajich
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::MAFFT - run the MAFFT alignment tools

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::MAFFT;

=head1 DESCRIPTION

You can get MAFFT from 
L<http://www.biophys.kyoto-u.ac.jp/~katoh/programs/align/mafft4/>.
"fftnsi" is the default in this implementation.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/MailList.html - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR -  Jason Stajich

Email jason-at-bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::MAFFT;

use vars qw($AUTOLOAD @ISA $PROGRAMNAME $PROGRAM %DEFAULTS
            @MAFFT_PARAMS @MAFFT_SWITCHES @OTHER_SWITCHES %OK_FIELD
	    @MAFFT_ALN_METHODS
            );
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Bio::SimpleAlign;
use Bio::AlignIO;

use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase 
          Bio::Factory::ApplicationFactoryI);

BEGIN {
    %DEFAULTS = ( 'OUTPUT' => 'fasta',
		  'METHOD' => 'fftnsi',
		  'CYCLES' => 2);
    @MAFFT_PARAMS =qw( METHOD CYCLES );
    @MAFFT_SWITCHES = qw( NJ ALL_POSITIVE);
    @OTHER_SWITCHES = qw(QUIET ALIGN OUTPUT OUTFILE);
    @MAFFT_ALN_METHODS = qw(fftnsi fftns nwnsi nwns fftnsrough nwnsrough);
    # Authorize attribute fields
    foreach my $attr ( @MAFFT_SWITCHES,@MAFFT_PARAMS,@OTHER_SWITCHES ) {
	$OK_FIELD{$attr}++; 
    }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
    return 'mafft';
}

=head2 executable

 Title   : executable
 Usage   : my $exe = $blastfactory->executable('blastall');
 Function: Finds the full path to the 'codeml' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to 
           [optional] boolean flag whether or not warn when exe is not found


=cut

sub executable {
    my ($self, $exename, $exe,$warn) = @_;
    $exename = $self->program_name unless (defined $exename );
 
    if( defined $exe && -x $exe ) {
        $self->{'_pathtoexe'}->{$exename} = $exe;
    }
    unless( defined $self->{'_pathtoexe'}->{$exename} ) {
        my $f = $self->program_path($exename);	    
        $exe = $self->{'_pathtoexe'}->{$exename} = $f if(-e $f && -x $f );
         
        #  This is how I meant to split up these conditionals --jason
        # if exe is null we will execute this (handle the case where
        # PROGRAMDIR pointed to something invalid)
        unless( $exe )  {  # we didn't find it in that last conditional
        if( ($exe = $self->io->exists_exe($exename)) && -x $exe ) {
            $self->{'_pathtoexe'}->{$exename} = $exe;
        } else { 
            $self->warn("Cannot find executable for $exename") if $warn;
            $self->{'_pathtoexe'}->{$exename} = undef;
        }
        }
    }
    return $self->{'_pathtoexe'}->{$exename};
}


=head2 program_path

 Title   : program_path
 Usage   : my $path = $factory->program_path();
 Function: Builds path for executable 
 Returns : string representing the full path to the exe
 Args    : none

=cut

sub program_path {
    my ($self,$program_name) = @_;
    my @path;
    push @path, $self->program_dir if $self->program_dir;
    push @path, $program_name .($^O =~ /mswin/i ?'.exe':'');

    return Bio::Root::IO->catfile(@path);
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return File::Spec->rel2abs($ENV{MAFFTDIR}) if $ENV{MAFFTDIR};
}

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($attr, $value);    
    
    while (@args)  {
	$attr =   shift @args;
	$value =  shift @args;
	next if( $attr =~ /^-/); # don't want named parameters
	$self->$attr($value);	
    }

    $self->output($DEFAULTS{'OUTPUT'}) unless( $self->output );
    $self->method($DEFAULTS{'METHOD'}) unless( $self->method );
    return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $attr = uc $attr;
    # aliasing
    $attr = 'OUTFILE' if $attr eq 'OUTFILE_NAME';
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};

    $self->{$attr} = shift if @_;
    return $self->{$attr};
}

=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysis run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)


=cut

sub error_string{
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'error_string'} = $value;
    }
    return $self->{'error_string'};

}

=head2  version

 Title   : version
 Usage   : exit if $prog->version() < 1.8
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    my $exe;
    return unless $exe = $self->executable;
    # this is a bit of a hack, but MAFFT is just a gawk script
    # so we are actually grepping the scriptfile
    # UPDATE (Torsten Seemann)
    # it now seems to be a 'sh' script and the format has changed
    # slightly. i've tried to make the change compatible with both...
    # version="v5.860 (2006/06/12)"; export version
    
    if( open(my $NAME, "grep 'export version' $exe | ") ) {
		while(<$NAME>) {
			if( /version.*?([\d.a-z]+)\s+/ ) {
				return $1;
			}
		}
		$self->warn("No version found");
		close($NAME);
    } else {
		$self->warn("$!");
    }
    return;
}

=head2 run

 Title   : run
 Usage   : my $output = $application->run(\@seqs);
 Function: Generic run of an application
 Returns : Bio::SimpleAlign object
 Args    : array ref of Bio::PrimarySeqI objects OR
           filename of sequences to run with

=cut

sub run {
   my ($self,$seqs) = @_;
   return $self->align($seqs);
}

=head2  align

 Title   : align
 Usage   :
	$inputfilename = 't/data/cysprot.fa';
	$aln = $factory->align($inputfilename);
or
	$seq_array_ref = \@seq_array; 
        # @seq_array is an array of Seq objs
	$aln = $factory->align($seq_array_ref);
 Function: Perform a multiple sequence alignment
 Returns : Reference to a SimpleAlign object containing the
           sequence alignment.
 Args    : Name of a file containing a set of unaligned fasta sequences
           or else an array of references to Bio::Seq objects.

 Throws an exception if argument is not either a string (eg a
 filename) or a reference to an array of Bio::Seq objects.  If
 argument is string, throws exception if file corresponding to string
 name can not be found. If argument is Bio::Seq array, throws
 exception if less than two sequence objects are in array.

=cut

sub align {
    my ($self,$input) = @_;
    # Create input file pointer
    $self->io->_io_cleanup();
    my ($infilename,$type) = $self->_setinput($input);
    if (! $infilename) {
	$self->throw("Bad input data or less than 2 sequences in $input !");
    }

    my ($param_string,$outstr) = $self->_setparams();

    # run mafft
    return $self->_run($infilename, $param_string,$outstr);
}

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to tcoffee program
 Example :
 Returns : nothing; tcoffee output is written to a
           temporary file OR specified output file
 Args    : Name of a file containing a set of unaligned fasta sequences
           and hash of parameters to be passed to tcoffee


=cut

sub _run {
    my ($self,$infilename,$paramstr,$outstr) = @_;
     my $commandstring = $self->executable()." $paramstr $infilename $outstr";
    
    $self->debug( "mafft command = $commandstring \n");

    my $status = system($commandstring);
    my $outfile = $self->outfile(); 
    if( !-e $outfile || -z $outfile ) {
        $self->warn( "MAFFT call crashed: $? [command $commandstring]\n");
        return;
    }
    
    my $in  = Bio::AlignIO->new('-file' => $outfile, 
				'-format' => $self->output);
    my $aln = $in->next_aln();
    return $aln;
}


=head2  _setinput

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly
 Function:  Create input file for mafft programs
 Example :
 Returns : name of file containing mafft data input 
 Args    : Seq or Align object reference or input file name


=cut

sub _setinput {
    my ($self,$input) = @_;
    my ($infilename, $seq, $temp, $tfh);
    if (! ref $input) {
	# check that file exists or throw
	$infilename = $input;
	unless (-e $input) {return 0;}	
	return ($infilename);
    } elsif (ref($input) =~ /ARRAY/i ) { #  $input may be an
	                                 #  array of BioSeq objects...
        #  Open temporary file for both reading & writing of array
	($tfh,$infilename) = $self->io->tempfile();
	if( ! ref($input->[0]) ) {
	    $self->warn("passed an array ref which did not contain objects to _setinput");
	    return;
	} elsif( $input->[0]->isa('Bio::PrimarySeqI') ) {		
	    $temp =  Bio::SeqIO->new('-fh' => $tfh,
				     '-format' => 'fasta');
	    my $ct = 1;
	    foreach $seq (@$input) {
		return 0 unless ( ref($seq) && 
				  $seq->isa("Bio::PrimarySeqI") );
		if( ! defined $seq->display_id ||
		    $seq->display_id =~ /^\s+$/) {
		    $seq->display_id( "Seq".$ct++);
		}
		$temp->write_seq($seq);
	    }
	    $temp->close();
	    undef $temp;
	    close($tfh);
	    $tfh = undef;
	}  else { 
	    $self->warn( "got an array ref with 1st entry ".
			 $input->[0].
			 " and don't know what to do with it\n");
	}

	return ($infilename);
    } else {
	$self->warn("Got $input and don't know what to do with it\n");
    }
    return 0;
}


=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:  Create parameter inputs for mafft program
 Example :
 Returns : parameter string to be passed to mafft program
 Args    : name of calling object

=cut

sub _setparams {
    my ($self) = @_;
    my ($outfile,$param_string) = ('','');

    # Set default output file if no explicit output file selected
    unless (defined($outfile = $self->outfile) ) {	
	my $tfh;
	($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir());
	close($tfh);
	undef $tfh;
	$self->outfile($outfile);
    } 
    my ($attr,$value);
    
    for  $attr ( @MAFFT_SWITCHES) {
	$value = $self->$attr();
	next unless ($value);
	my $attr_key = lc $attr; #put switches in format expected by mafft
	$attr_key = ' --'.$attr_key;
	$param_string .= $attr_key ;
    }
    my $method = $self->method;
    $self->throw("no method ") unless defined $method;
    if( $method !~ /(rough|nsi)$/ && 
	defined $self->cycles) {
	$param_string .= " ".$self->cycles;
    }
    my $outputstr = " 1>$outfile" ;

    if ($self->quiet() || $self->verbose < 0) { 
	$param_string .= " --quiet";
	$outputstr .= ' 2> /dev/null';
    }
    return ($param_string, $outputstr);
}

=head2 methods

 Title   : methods
 Usage   : my @methods = $self->methods()
 Function: Get/Set Alignment methods - NOT VALIDATED
 Returns : array of strings
 Args    : arrayref of strings


=cut

sub methods {
   my ($self) = shift;
   return @MAFFT_ALN_METHODS;
}


=head1 Bio::Tools::Run::BaseWrapper methods

=cut

=head2 no_param_checks

 Title   : no_param_checks
 Usage   : $obj->no_param_checks($newval)
 Function: Boolean flag as to whether or not we should
           trust the sanity checks for parameter values  
 Returns : value of no_param_checks
 Args    : newvalue (optional)


=cut

=head2 save_tempfiles

 Title   : save_tempfiles
 Usage   : $obj->save_tempfiles($newval)
 Function: 
 Returns : value of save_tempfiles
 Args    : newvalue (optional)


=cut

=head2 outfile_name

 Title   : outfile_name
 Usage   : my $outfile = $mafft->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to


=cut


=head2 tempdir

 Title   : tempdir
 Usage   : my $tmpdir = $self->tempdir();
 Function: Retrieve a temporary directory name (which is created)
 Returns : string which is the name of the temporary directory
 Args    : none


=cut

=head2 cleanup

 Title   : cleanup
 Usage   : $mafft->cleanup();
 Function: Will cleanup the tempdir directory
 Returns : none
 Args    : none


=cut

=head2 io

 Title   : io
 Usage   : $obj->io($newval)
 Function:  Gets a L<Bio::Root::IO> object
 Returns : L<Bio::Root::IO>
 Args    : none


=cut

1; # Needed to keep compiler happy

