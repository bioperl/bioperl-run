# $Id$
#
# Cared for by
#
# Copyright to a FUGU Student Intern
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Genewise - Object for predicting genes in a
given sequence given a protein

=head1 SYNOPSIS

  # Build a Genewise alignment factory
  my  $factory = Bio::Tools::Run::Genewise->new();

  # Pass the factory 2 Bio:SeqI objects (in the order of query peptide and
     target_genomic)
  # $genes is a Bio::SeqFeature::Gene::GeneStructure object  
  my $genes = $factory->predict_genes($protein_seq, $genomic_seq);

  Available Params
  Model    [-codon,-gene,-cfreq,-splice,-subs,-indel,-intron,-null]
  Alg      [-kbyte,-alg]
  ..cont  [-gff,-gener,-alb,-pal,-block,-divide]
  Standard [-help,-version,-silent,-quiet,-errorlog]

=head1 DESCRIPTION

Genewise is a gene prediction program developed by Ewan Birney
http://www.sanger.ac.uk/software/wise2.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org          - General discussion
  http://bio.perl.org/MailList.html             - About the mailing lists
d2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
 the bugs and their resolution.  Bug reports can be submitted via
 the web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR - FUGU Student Intern

Email: fugui@worf.fugu-sg.org

=head1 CONTRIBUTORS

Jason Stajich jason@bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Genewise;
use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            @GENEWISE_SWITCHES @GENEWISE_PARAMS
            @OTHER_SWITCHES %OK_FIELD);
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use Bio::SeqFeature::Gene::Exon; 
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::SeqFeature::FeaturePair; 
use Bio::SeqFeature::Gene::Transcript;
use Bio::SeqFeature::Gene::GeneStructure;
use Bio::Tools::Genewise;
use Bio::Tools::AnalysisResult;
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
    @GENEWISE_PARAMS = qw( DYMEM CODON GENE CFREQ SPLICE 
			   SUBS INDEL INTRON NULL INSERT 
			   KBYTE HNAME ALG BLOCK DIVIDE GENER U V S T G E M);

    @GENEWISE_SWITCHES = qw(HELP SILENT QUIET ERROROFFSTD TREV 
			    TFOR TABS BOTH HMMER );

    # Authorize attribute fields
    foreach my $attr ( @GENEWISE_PARAMS, @GENEWISE_SWITCHES,
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
    return 'genewise';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtiained from ENV variable.
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


=head2 predict_genes

 Title   : predict_genes
 Usage   : 2 sequence objects
           $genes = $factory->predict_genes($seq1, $seq2);
 Function: Predict genes
 Returns : A Bio::Seqfeature::Gene:GeneStructure object
 Args    : Name of a file containing a set of 2 fasta sequences in the order of
           peptide and genomic sequences
           or else 2  Bio::Seq objects.

 Throws an exception if argument is not either a string (eg a
 filename) or 2 Bio::Seq objects.  If
 arguments are strings, throws exception if file corresponding to string
 name can not be found.

=cut

sub predict_genes {
    my ($self, $seq1, $seq2)=@_;
    my ($attr, $value, $switch);
    $self->io->_io_cleanup();
# Create input file pointer
    my ($infile1,$infile2)= $self->_setinput($seq1, $seq2);
    if (!($infile1 && $infile2)) {$self->throw("Bad input data (sequences need an id ) ");}


# run genewise
    my @genes = $self->_run($infile1,$infile2);
    return @genes;
}


=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly
 Function:   makes actual system call to a genewise program
 Example :
 Returns : L<Bio::SeqFeature::Gene::GeneStructure> 
 Args    : Name of a files containing 2 sequences in the order of peptide and genomic

=cut

sub _run {
    my ($self,$infile1,$infile2) = @_;
    my $instring;
    $self->debug( "Program ".$self->executable."\n");
    unless ( $self->executable ) {
	$self->throw("Cannot run Genewise unless the executable is found.  Check your environment variables or make sure genewise is in your path.");
    }
    my $paramstring = $self->_setparams;
    
    my $commandstring = $self->executable." $paramstring $infile1 $infile2";
    # this is to capture STDERR messages which leak out when you run programs
    # with open(FH, "... |");
    if( ( $self->silent && $self->quiet) &&
	($^O !~ /os2|dos|MSWin32|amigaos/) ) {
	# yeah, like genewise is really going to run on Windows...
	$commandstring .= ' 2> /dev/null';
    }
    $self->debug( "genewise command = $commandstring");
    open(GW, "$commandstring |") || $self->throw( "Genewise call ($commandstring) crashed: $? \n");
        
    my $genewiseParser = Bio::Tools::Genewise->new(-fh=> \*GW);
    my @genes;
    while ( my $gene = $genewiseParser->next_prediction()){
        push @genes, $gene;
    }
    close(GW);
    return @genes;
}

sub get_strand {
  my ($self,$start,$end) = @_;
  $start || $self->throw("Need a start");
  $end   || $self->throw("Need an end");
  my $strand;
  if ($start > $end) {
    my $tmp = $start;
    $start = $end;
    $end = $tmp;
    $strand = -1;
  }
  else {
    $strand = 1;
  }
  return ($start,$end,$strand);
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
    	$self->_query_pep_seq($seq1);
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
	
	$self->_subject_dna_seq($seq2);
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
    foreach my $attr(@GENEWISE_PARAMS){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .= $attr_key.' '.$value;
    }
    foreach my $attr(@GENEWISE_SWITCHES){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .=$attr_key;
    }

    $param_string = $param_string." -genesf"; #specify the output option
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

sub _query_pep_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_query_pep_seq'} = $seq;
  }
  return $self->{'_query_pep_seq'};
}

=head2 _subject_dna_seq

 Title   :  _subject_dna_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the subject sequence
 Example :
 Returns :

 Args    :

=cut

sub _subject_dna_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_subject_dna_seq'} = $seq;
  }
  return $self->{'_subject_dna_seq'};
}
1; 


