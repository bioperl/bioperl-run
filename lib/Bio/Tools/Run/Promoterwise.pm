# $Id: Promoterwise.pm,
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Shawn Hoon
#
# Copyright  Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Promoterwise - Wrapper for aligning two sequences using
promoterwise

=head1 SYNOPSIS

  # Build a Promoterwise alignment factory
  my @params = ('-s'=>1,'-query_start'=>10,'-dymem'=>1);
  my  $factory = Bio::Tools::Run::Promoterwise->new(@params);

  my (@fp)= $factory->run($seq1,$seq2);

  # each feature pair is a group of hsps
  foreach my $fp(@fp){
    print "Hit Length: ".$fp->feature1->length."\n";
    print "Hit Start: ".$fp->feature1->start."\n";
    print "Hit End: ".$fp->feature1->end."\n";
    print "Hsps: \n";
    my @first_hsp = $fp->feature1->sub_SeqFeature;
    my @second_hsp = $fp->feature2->sub_SeqFeature;
    for ($i..$#first_hsp){
      print $first_hsp[$i]->seq." ".$second_hsp[$i]->seq."\n";
    }
  }
  print "end: ". $fp->feature2->start."\t".$fp->feature2->end."\n";

  #Available parameters include:
  #( S T U V QUERY_START QUERY_END TARGET_START
  #TARGET_END LHWINDOW LHSEED LHALN LHSCORE LHREJECT
  #LHREJECT LHMAX DYMEM KBYTE DYCACHE)
  #For an explanation of these parameters, please see documentation
  #from the Wise package.

=head1 DESCRIPTION

Promoterwise is an alignment algorithm that relaxes the constraint
that local alignments have to be co-linear. Otherwise it provides a
similar model to DBA, which is designed for promoter sequence
alignments by Ewan Birney.  It is part of the wise2 package available
at: http://www.sanger.ac.uk/software/wise2.

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
 the bugs and their resolution.  Bug reports can be submitted via
 the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Shawn Hoon

Email: shawnh@fugu-sg.org


=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Promoterwise;
use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            @PROMOTERWISE_SWITCHES @PROMOTERWISE_PARAMS
            @OTHER_SWITCHES %OK_FIELD);
use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Promoterwise;
use strict;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase );

# Two ways to run the program .....
# 1. define an environmental variable WISEDIR
# export WISEDIR =/usr/local/share/wise2.2.0
# where the wise2.2.20 package is installed
#
# 2. include a definition of an environmental variable WISEDIR in
# every script that will use DBA.pm
# $ENV{WISEDIR} = '/usr/local/share/wise2.2.20';

BEGIN {
    @PROMOTERWISE_PARAMS = qw( S T U V QUERY_START QUERY_END TARGET_START
                           TARGET_END LHWINDOW LHSEED LHALN LHSCORE LHREJECT
                           LHREJECT LHMAX DYMEM KBYTE DYCACHE);
			   

    @OTHER_SWITCHES = qw(SILENT QUIET ERROROFFSTD);

    # Authorize attribute fields
    foreach my $attr ( @PROMOTERWISE_PARAMS, @PROMOTERWISE_SWITCHES,
                       @OTHER_SWITCHES) { $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
    return 'promoterwise';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return Bio::Root::IO->catfile($ENV{WISEDIR},"/src/bin/") if $ENV{WISEDIR};
}

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);

  my ($attr, $value);
  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
    next if( $attr =~ /^-/ ); # don't want named parameters
    $self->$attr($value);
  }
  return $self;
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

    return undef unless $self->executable;
    my $prog = $self->executable;
    my $string = `$prog -version`;
    $string =~ /(Version *)/i;
    return $1 || undef;

}


=head2 run 

 Title   : run 
 Usage   : 2 sequence objects
           @fp = $factory->run($seq1, $seq2);
 Function: run 
 Returns : An array of <Bio::SeqFeature::FeaturePair> 
 Args    : Name of a file containing a set of 2 fasta sequences 
           or else 2  Bio::Seq objects.

Throws an exception if argument is not either a string (eg a filename)
or 2 Bio::Seq objects.  If arguments are strings, throws exception if
file corresponding to string name can not be found.

=cut

sub run{
    my ($self, $seq1, $seq2)=@_;
    my ($attr, $value, $switch);
    $self->io->_io_cleanup();
# Create input file pointer
    my ($infile1,$infile2)= $self->_setinput($seq1, $seq2);
    if (!($infile1 && $infile2))
        {$self->throw("Bad input data (sequences need an id ) ");}


# run promoterwise 
    my @fp = $self->_run($infile1,$infile2);
    return @fp;
}


=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly
 Function:   makes actual system call to a promoterwise program
 Example :
 Returns : L<Bio::SeqFeature::FeaturePair>
 Args    : Name of a files containing 2 sequences in the order of peptide and genomic

=cut

sub _run {
    my ($self,$infile1,$infile2) = @_;
    my $instring;
    $self->debug( "Program ".$self->executable."\n");
    unless ( $self->executable ) {
	$self->throw("Cannot run Promoterwise unless the executable is found.".
                     " Check your environment variables or make sure ". 
                     "promoterwise is in your path.");
    }
    my $paramstring = $self->_setparams;
    
    my $commandstring = $self->executable." $infile1 $infile2 $paramstring";
    # this is to capture STDERR messages which leak out when you run programs
    # with open(FH, "... |");
    if( ( $self->silent && $self->quiet) &&
	($^O !~ /os2|dos|MSWin32|amigaos/) ) {
	# yeah, like promoterwise is really going to run on Windows...
	$commandstring .= ' -quiet -silent -erroroffstd  2> /dev/null';
    }
    $self->debug( "promoterwise command = $commandstring");
    open(PW, "$commandstring |") || 
        $self->throw( "Promoterwise call ($commandstring) crashed: $? \n");
    my $pw_parser = Bio::Tools::Promoterwise->new(-fh=>\*PW,
                                                  -query1_seq=>$self->_query1_seq,
                                                  -query2_seq=>$self->_query2_seq);
    my @fp;
    while (my $fp = $pw_parser->next_result){
        push @fp,$fp;
    }

    return @fp;
}

sub _setinput {
    my ($self, $seq1, $seq2) = @_;
    my ($tfh1,$tfh2,$outfile1,$outfile2);

    $self->throw("calling with not enough arguments") unless $seq1 && $seq2;

    # Not going to set _query_pep/_subject_dna_seq 
    # if you pass in a filename

    unless( ref($seq1) ) {
	unless( -e $seq1 ) {
	    $self->throw("Sequence1 is not a Bio::PrimarySeqI object nor file\n");
	}
    	$outfile1 = $seq1;
    } 
    else { 
	($tfh1,$outfile1) = $self->io->tempfile(-dir=>$self->tempdir);
	my $out1 = Bio::SeqIO->new('-fh'     => $tfh1,
				   '-format' => 'fasta');
	$out1->write_seq($seq1);
	$self->_query1_seq($seq1);
	# Make sure you close things - this is what creates
	# Out of filehandle errors 
	close($tfh1);
	undef $tfh1;
    }
    unless( ref($seq2) ) {
    	unless( -e $seq2 ) { 
	    $self->throw("Sequence2 is not a Bio::PrimarySeqI object nor file\n");    
	}
	$outfile2 = $seq2;	
    } 
    else { 
    	($tfh2,$outfile2) = $self->io->tempfile(-dir=>$self->tempdir);
	my $out2 = Bio::SeqIO->new('-fh'     => $tfh2, 
				   '-format' => 'fasta');
    	$out2->write_seq($seq2);

	$self->_query2_seq($seq2);
	# Make sure you close things - this is what creates
	# Out of filehandle errors 
	close($tfh2);
	undef $tfh2;
    }
    return ($outfile1,$outfile2);
}

=head2 _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly
 Function:  creates a string of params to be used in the command string
 Example :
 Returns :  string of params
 Args    :  

=cut

sub _setparams {
    my ($self) = @_;
    my $param_string;
    foreach my $attr(@PROMOTERWISE_PARAMS){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .= $attr_key.' '.$value;
    }
    foreach my $attr(@PROMOTERWISE_SWITCHES){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .=$attr_key;
    }

    $param_string = $param_string." -hitoutput tab"; #specify the output option
    return $param_string;
}

=head2 _query_pep_seq

 Title   :  _query_pep_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the query sequence
 Example :
 Returns :  
 Args    :

=cut

sub _query1_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_query1_seq'} = $seq;
  }
  return $self->{'_query1_seq'};
}

=head2 _subject_dna_seq

 Title   :  _subject_dna_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the subject sequence
 Example :
 Returns :

 Args    :

=cut

sub _query2_seq{
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_query2_seq'} = $seq;
  }
  return $self->{'_query2_seq'};
}
1; 


