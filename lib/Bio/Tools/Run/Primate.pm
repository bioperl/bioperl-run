# BioPerl module for Bio::Tools::Run::Primate
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself
# POD documentation - main docs before the code

=head1 NAME

Wrapper for Primate,  Guy Slater's near exact match finder for short sequence
tags.

=head1 SYNOPSIS

  use Bio::Tools::Run::Primate;
  use Bio::SeqIO;

  my $query = "primer.fa";
  my $target = "contig.fa";

  my @params = ("query" => $query,"target" => $target,"m"=>0);
  my $fact = Bio::Tools::Run::Primate->new(@params);

  my @feat = $fact->run;
  foreach my $feat(@feat) {
      print $feat->seqname."\t".$feat->primary_tag."\t".$feat->start.
      "\t".$feat->end."\t".$feat->strand."\t".$feat->seq->seq."\n";
  }

=head1 DESCRIPTION

Primate is available under to ensembl-nci package at
http://cvsweb.sanger.ac.uk/cgi-bin/cvsweb.cgi/ensembl-nci/?cvsroot=Ensembl

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

=head1 AUTHOR - Shawn Hoon

Email shawnh@fugu-sg.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut


package Bio::Tools::Run::Primate;
use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR @PRIMATE_PARAMS $PROGRAMNAME
            @OTHER_SWITCHES %OK_FIELD);
use strict;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Factory::ApplicationFactoryI;
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use Bio::Tools::Run::WrapperBase;


@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);


BEGIN {

    @PRIMATE_PARAMS = qw(V Q T M B QUERY TARGET OUTFILE PROGRAM EXECUTABLE);
    @OTHER_SWITCHES = qw(QUIET VERBOSE);

    # Authorize attribute fields
    foreach my $attr ( @PRIMATE_PARAMS,@OTHER_SWITCHES) { $OK_FIELD{$attr}++; }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  return 'primate';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{PRIMATEDIR}) if $ENV{PRIMATEDIR};
}

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Primate->new()
 Function: Builds a new Bio::Tools::Run::Primate objet
 Returns : Bio::Tools::Run::Primate
 Args    : query => the L<Bio::PrimarySeqI> object or a file path
           target => the L<Bio::PrimarySeqI> object or a file path
           m  => the number of mismatches allowed, default 1(integer)
           b  => [TRUE|FALSE] find best match, default FALSE
           executable=>where the program sits

=cut

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);
  
  my ($attr, $value);

  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
    next if( $attr =~ /^-/ ); # don't want named parameters
    if($attr =~/^q$/i){
      $self->query($value);
    }
    if($attr =~/^t$/i){
      $self->target($value);
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
 Usage   : $primate->version
 Function: Determine the version number of the program
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;

    my $exe = $self->executable();
    return undef unless defined $exe;
    my $string = `$exe -v ` ;
    $string =~ /\(([\d.]+)\)/;
    return $1 || undef;
}

=head2 search

 Title   : search
 Usage   : DEPRECATED. Use $factory->run() instead
 Function: Perform a primate search
 Returns : Array of L<Bio::SeqFeature::Generic>
 Args    : 

=cut

sub search {
	return shift->run(@_);
}


=head2 run 

 Title   : run
 Usage   : @feat = $factory->run();
 Function: Perform a primate search
 Returns : Array of L<Bio::SeqFeature::Generic>
 Args    : 

=cut

sub run{
    my ($self,$target) = @_;
    $target = $target ||$self->target;
    $target || $self->throw("Need a target sequence");
    $self->query || $self->throw("Need a query sequence");

# Create input file pointer
    my ($query_file,$target_file)= $self->_setinput($self->query,$target);
    if (!($query_file && $target_file)) {$self->throw("Unable to create temp files for query and target !");}

# Create parameter string to pass to primate program
    my $param_string = $self->_setparams();

# run primate
    my @feats= $self->_run($query_file,$target_file,$param_string);
    return @feats;
}

#################################################
#INTERNAL METHODS

=head2  _run

 Title   :  _run
 Usage   : Internal function, not to be called directly
 Function: makes actual system call to dba program
 Returns : array of L<Bio::SeqFeature::Generic>
 Args    : path to query and target file and parameter string

=cut

sub _run {
    my ($self,$query_file,$target_file,$param_string) = @_;
    my $instring;
    $self->debug( "Program ".$self->executable."\n");
    my ($tfh,$outfile) = $self->io->tempfile(-dir=>$self->tempdir);
    close($tfh); # this is to make sure we don't have 
                 # open filehandles
    undef $tfh;
    my $commandstring = $self->executable.
        " $param_string -q $query_file -t $target_file > $outfile";
    $self->debug( "primate command = $commandstring");
    my $status = system($commandstring);
    $self->throw( "primate call ($commandstring) crashed: $? \n") unless $status==0;

    #parse pff format and return a Bio::Search::HSP::GenericHSP array
    my @feats   = $self->_parse_results($outfile);

    return @feats;
}

=head2  _parse_results

 Title   :  _parse_results
 Usage   :  Internal function, not to be called directly
 Function:  Passes primate output
 Returns : array of L<Bio::SeqFeature::Generic>
 Args    : the name of the output file

=cut

sub _parse_results {
    my ($self,$outfile) = @_;
    $outfile||$self->throw("No outfile specified");
    my @feats;
    my %query = $self->_query_seq();

    open(OUT,$outfile);
    while(my $entry = <OUT>){
        chomp($entry);
      if($entry =~ /primate/ ) {
        my ($dummy,$tagname, $seqname, $strand,$seq_end,$mismatch) = split(" " , $entry );
        #map primate coordinates to Seq coordinates
        my $seq_start = $seq_end- length($query{$tagname})+2;
        $seq_end++;
        my $feature = Bio::SeqFeature::Generic->new( -seq_id       => $seqname,
                                                      -strand      => $strand,
                                                      -score       => $mismatch,
                                                      -start       => $seq_start,
                                                      -end         => $seq_end,
                                                      -frame       => 1,
                                                      -source      => 'primate',
                                                      -primary     => $tagname);
      $feature->attach_seq($self->_target_seq);
      push @feats,$feature;
      }
  }

   return @feats;
}


=head2  _setinput()

 Title   : _setinput
 Usage   : Internal function, not to be called directly
 Function: Create input files for primate
 Returns : name of file containing query and target
 Args    : query and target (either a filename or a L<Bio::PrimarySeqI>

=cut

sub _setinput {
    my ($self, $query,$target) = @_;
    my ($query_file,$target_file,$tfh1,$tfh2);

    my @query = ref ($query) eq "ARRAY" ? @{$query} : ($query);
    foreach my $query(@query){

	if(ref($query)&& $query->isa("Bio::PrimarySeqI")){
	    ($tfh1,$query_file) = $self->io->tempfile(-dir=>$self->tempdir);
	    my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'fasta');
	    my %query;
	    $query{$query->primary_id} = $query->seq;
	    $self->_query_seq(\%query);
	    $out1->write_seq($query) || return 0;
	    close ($tfh1);
	    undef $tfh1;
	}
	elsif (-e $query){
	    my $in  = Bio::SeqIO->new(-file => $query , '-format' => 'fasta');
	    ($tfh1,$query_file) = $self->io->tempfile(-dir=>$self->tempdir);
	    my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'fasta');
	    my %query;
	    while(my $seq1 = $in->next_seq()){
		$out1->write_seq($seq1) || return 0;
		$query{$seq1->primary_id} = $seq1->seq;
	    }
	    close($tfh1);
	    undef $tfh1;
	    $self->_query_seq(\%query);    
	}
	else {
	    return 0;
	}
    }
    if(ref($target) && $target->isa("Bio::PrimarySeqI")){
	($tfh2,$target_file) = $self->io->tempfile(-dir=>$self->tempdir);
	my $out1 = Bio::SeqIO->new(-fh=> $tfh2 , '-format' => 'Fasta');
	$out1->write_seq($target)|| return 0;
   	$self->_target_seq($target);
  	close($tfh2);
  	undef $tfh2;
    }  
    elsif (-e $target){
	my  $in  = Bio::SeqIO->new(-file => $target , '-format' => 'fasta');
	($tfh2,$target_file) = $self->io->tempfile(-dir=>$self->tempdir);
  	my $out = Bio::SeqIO->new(-fh=> $tfh2 , '-format' => 'fasta');
	my $seq1 = $in->next_seq() || return 0;
  	$out->write_seq($seq1);
  	close($tfh2);
  	undef $tfh2;
  	$self->_target_seq($seq1);
    }
    else {
  	return 0;
    }

    return $query_file,$target_file;
}

=head2  _setparams()

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Create parameter inputs for primate program
 Returns : parameter string to be passed to primate
 Args    : the param array

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;

    my $param_string = "";
    for  $attr ( @PRIMATE_PARAMS ) {
      $value = $self->$attr();
      next unless (defined $value);

      my $attr_key = lc $attr; #put params in format expected by dba
      $attr_key = ' -'.$attr_key;
      if(($attr_key !~/QUERY/i) && ($attr_key !~/TARGET/i)){
      $param_string .= $attr_key.' '.$value;
      }
    }

    if ($self->quiet() || $self->verbose() < 0) {
      $param_string .= '  >/dev/null ';
    }
    return $param_string;
}

=head2  _query_seq()

 Title   :  _query_seq
 Usage   :  Internal function, not to be called directly
 Function:  get/set for the query sequence
 Returns :  a hash of seq with key the query tag
 Args    :  optional

=cut

sub _query_seq {
  my ($self,$seq) = @_;
  if(defined $seq){
    $self->{'_query_seq'} = $seq;
  }
  return %{$self->{'_query_seq'}};
}

=head2  _target_seq()

 Title   : _target_seq
 Usage   : Internal function, not to be called directly
 Function: get/set for the target sequence
 Returns : L<Bio::PrimarySeqI>
 Args    : optional

=cut

sub _target_seq {
    my ($self,$seq) = @_;
    if(defined $seq){
        $self->{'_target_seq'} = $seq;
    }
    return $self->{'_target_seq'};
}

1; # Needed to keep compiler happy

