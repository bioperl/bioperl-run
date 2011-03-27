# BioPerl module for Bio::Tools::Run::Pseudowise
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by
#
# Copyright Kiran 
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Pseudowise - Object for prediting pseudogenes in a
given sequence given a protein and a cdna sequence

=head1 SYNOPSIS

  # Build a pseudowise alignment factory
  my $factory = Bio::Tools::Run::Pseudowise->new();

  # Pass the factory 3 Bio:SeqI objects (in the order of query
  # peptide and cdna and target_genomic)
  # @genes is an array of GenericSeqFeature objects
  my @genes = $factory->run($seq1, $seq2, $seq3);

=head1 DESCRIPTION

Pseudowise is a pseudogene predition program developed by Ewan Birney
http://www.sanger.ac.uk/software/wise2.

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

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Kiran 

Email kiran@fugu-sg.org 

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut


package Bio::Tools::Run::Pseudowise;
use vars qw($AUTOLOAD @ISA $PROGRAM_NAME $PROGRAM_DIR
            @PSEUDOWISE_SWITCHES @PSEUDOWISE_PARAMS 
            @OTHER_SWITCHES %OK_FIELD);
use strict;
use Bio::SeqIO;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Pseudowise;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

# You will need to enable pseudowise to find the pseudowise program. This
# can be done in (at least) two ways:
#
# 1. define an environmental variable WISEDIR 
# export WISEDIR =/usr/local/share/wise2.2.0
# where the wise2.2.20 package is installed
#
# 2. include a definition of an environmental variable WISEDIR in
# every script that will use DBA.pm
# $ENV{WISEDIR} = '/usr/local/share/wise2.2.20';

BEGIN {
    $PROGRAM_NAME = 'pseudowise';
    $PROGRAM_DIR = Bio::Root::IO->catfile($ENV{WISEDIR},"src","bin") if $ENV{WISEDIR};
    @PSEUDOWISE_PARAMS = qw(SPLICE_MAX_COLLAR SPLICE_MIN_COLLAR 
			    SPLICE_SCORE_OFFSET
			    GENESTATS NOMATCHN PARAMS KBYTE 
			    DYMEM DYDEBUG PALDEBUG 
			    ERRORLOG);

    @PSEUDOWISE_SWITCHES = qw(HELP SILENT QUIET ERROROFFSTD);
    
    # Authorize attribute fields
    foreach my $attr ( @PSEUDOWISE_PARAMS, @PSEUDOWISE_SWITCHES,
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
  return $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return $PROGRAM_DIR;
}

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);
  
  my ($attr, $value);
  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
    next if( $attr =~ /^-/ ); # don't want named parameters
    if ($attr =~/'PROGRAM'/i) {
      $self->executable($value);
      next;
    }
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
    my $string = `pseudowise -- ` ;
    $string =~ /\(([\d.]+)\)/;
    return $1 || undef;

}

=head2 predict_genes 

 Title   : predict_genes 
 Usage   : DEPRECATED. Use $factory->run instead 
 Function: Predict pseudogenes
 Returns : An array of Bio::Seqfeature::Generic objects 
 Args    : Name of a file containing a set of 3 fasta sequences in the order of 
           peptide, cdna and genomic sequences
           or else 3  Bio::Seq objects.

Throws an exception if argument is not either a string (eg a filename)
or 3 Bio::Seq objects.  If arguments are strings, throws exception if
file corresponding to string name can not be found.

=cut

sub predict_genes {
    return shift->run(@_);
}

=head2 run

 Title   : run
 Usage   : my @feats = $factory->run($seq1, $seq2, $seq3);
 Function: Executes pseudogene binary
 Returns : An array of Bio::Seqfeature::Generic objects 
 Args    : Name of a file containing a set of 3 fasta sequences in the order of 
           peptide, cdna and genomic sequences
           or else 3  Bio::Seq objects.

Throws an exception if argument is not either a string (eg a filename)
or 3 Bio::Seq objects.  If arguments are strings, throws exception if
file corresponding to string name can not be found.

=cut

sub run {
    my ($self,@args)=@_; 
    my ($attr, $value, $switch);
 
    # Create input file pointer
    my @files = $self->_setinput(@args);
    if( @files !=3 || grep { !defined } @files ) { 
	$self->throw("Bad input data (sequences need an id ) ");
    }
    
    my $prot_name = $args[0]->display_id;
    return $self->_run($prot_name, @files);
}


=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly
 Function:   makes actual system call to a pseudowise program
 Example :
 Returns : nothing; pseudowise  output is written to a
           temporary file $TMPOUTFILE
 Args    : Name of a files containing 3 sequences in the order of peptide, cdna and genomic 

=cut

sub _run {
    my ($self,$prot_name, @files) = @_;
    my $instring;
    $self->debug( "Program ".$self->executable."\n");
    my ($tfh1,$outfile) = $self->io->tempfile(-dir=>$self->tempdir);
    my $paramstring = $self->_setparams;
    my $commandstring = sprintf("%s %s %s > %s",
				$self->executable, 
				$paramstring,
				join(" ", @files),
				$outfile);
  
    if($self->silent || $self->quiet || ($self->verbose < 1)){
	$commandstring .= ' 2> /dev/null';
    }
    $self->debug( "pseudowise command = $commandstring\n");
#    my $status = system($commandstring);
    `$commandstring`;
#    $self->throw( "Pseudowise call ($commandstring) crashed: $? \n") 
#	unless $status == 0;
    #parse the outpur and return a Bio::Seqfeature array
    my $genes   = $self->_parse_results($prot_name,$outfile);
    close($tfh1);
    undef $tfh1;
    if( $self->verbose > 0 ) {
	open($tfh1,$outfile) || die $!;
	while(<$tfh1>) {
	    $self->debug ($_);
	}
    }
    return @{$genes};
}

=head2  _parse_results

 Title   :  __parse_results
 Usage   :  Internal function, not to be called directly
 Function:  Parses pseudowise output 
 Example :
 Returns : an reference to an array of Seqfeatures 
 Args    : the name of the output file 

=cut

sub _parse_results {
    my ($self,$prot_name,$outfile) = @_;
    $outfile||$self->throw("No outfile specified");
    my $filehandle;
    if (ref ($outfile) !~ /GLOB/i ) {
        open ($filehandle, "<".$outfile)
            or $self->throw ("Couldn't open file ".$outfile.": $!\n");
    } else {
        $filehandle = $outfile;
    }
    
    my @genes;
    #The big parsing loop - parses exons and predicted peptides
    my $parser = Bio::Tools::Pseudowise->new(-verbose => $self->verbose,
					     -fh      => $filehandle);
    while( my $f = $parser->next_feature ) {
	push @genes, $f;
    }
    return \@genes;
}

=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly
 Function:   Create input files for pseudowise program
 Example :
 Returns : name of file containing dba data input
 Args    : Seq objects in the order of query protein and cdna and target genomic sequence 

=cut

sub _setinput {
  my ($self, $seq1, $seq2, $seq3) = @_;
  my ($tfh1,$tfh2,$tfh3,$outfile1,$outfile2,$outfile3);

    if(!($seq1->isa("Bio::PrimarySeqI") && $seq2->isa("Bio::PrimarySeqI") &&
         $seq2->isa("Bio::PrimarySeqI")))
    { $self->throw("One or more of the sequences are nor Bio::PrimarySeqI objects\n"); }
  my $tempdir = $self->tempdir();
  ($tfh1,$outfile1) = $self->io->tempfile(-dir=>$tempdir);
  ($tfh2,$outfile2) = $self->io->tempfile(-dir=>$tempdir);
  ($tfh3,$outfile3) = $self->io->tempfile(-dir=>$tempdir);

  my $out1 = Bio::SeqIO->new(-fh => $tfh1 ,'-format' => 'Fasta');
  my $out2 = Bio::SeqIO->new(-fh => $tfh2, '-format' => 'Fasta');
  my $out3 = Bio::SeqIO->new(-fh => $tfh3, '-format' => 'Fasta');
  
  $out1->write_seq($seq1);
  $out2->write_seq($seq2);
  $out3->write_seq($seq3);
  $self->_query_pep_seq($seq1);
  $self->_query_cdna_seq($seq2);
  $self->_subject_dna_seq($seq3);

  close($tfh1);
  close($tfh2);
  close($tfh3);
  undef ($tfh1);
  undef ($tfh2);
  undef ($tfh3);
  return ($outfile1,$outfile2,$outfile3);  
}

sub _setparams {
    my ($self) = @_;
    my $param_string;
    foreach my $attr(@PSEUDOWISE_PARAMS){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .=$attr_key.' '.$value;
    }

    foreach my $attr(@PSEUDOWISE_SWITCHES){
        my $value = $self->$attr();
        next unless (defined $value);
        my $attr_key = ' -'.(lc $attr);
        $param_string .=$attr_key;
    }

    return $param_string;
}
    


=head2  _query_pep_seq()

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

=head2  _query_cdna_seq()

 Title   :  _query_cdna_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the query sequence
 Example :
 Returns :
 Args    :

=cut

sub _query_cdna_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_query_cdna_seq'} = $seq;
  }
  return $self->{'_query_cdna_seq'};
}

=head2  _subject_dna_seq()

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

1; # Needed to keep compiler happy
