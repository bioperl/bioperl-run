# $Id$
# BioPerl module for RepeatMasker
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Shawn Hoon <shawnh@fugu-sg.org>
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::RepeatMasker - Wrapper for RepeatMasker Program

=head1 SYNOPSIS

  use Bio::Tools::Run::RepeatMasker;

  my @params=("mam" => 1,"noint"=>1);
  my $factory = Bio::Tools::Run::RepeatMasker->new(@params);
  $in  = Bio::SeqIO->new(-file => "contig1.fa",
                         -format => 'fasta');
  my $seq = $in->next_seq();

  #return an array of Bio::SeqFeature::FeaturePair objects
  my @feats = $factory->run($seq); 

  # or

  $factory->run($seq);
  my @feats = $factory->repeat_features;

  #return the masked sequence, a Bio::SeqI object
  my $masked_seq = $factory->run;

=head1 DESCRIPTION

To use this module, the RepeatMasker program (and probably database) must be
installed. RepeatMasker is a program that screens DNA sequences for interspersed
repeats known to exist in mammalian genomes as well as for low
complexity DNA sequences. For more information, on the program and its
usage, please refer to http://www.repeatmasker.org/.

Having installed RepeatMasker, you must let Bioperl know where it is.
This can be done in (at least) three ways:

 1. Make sure the RepeatMasker executable is in your path.
 2. Define an environmental variable REPEATMASKERDIR which is a 
    directory which contains the RepeatMasker executable:
    In bash:

    export REPEATMASKERDIR=/home/username/RepeatMasker/

    In csh/tcsh:

    setenv REPEATMASKERDIR /home/username/RepeatMasker/

 3. Include a definition of an environmental variable REPEATMASKERDIR in
    every script that will use this RepeatMasker wrapper module, e.g.:

    BEGIN { $ENV{REPEATMASKERDIR} = '/home/username/RepeatMasker/' }
    use Bio::Tools::Run::RepeatMasker;

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists. Your participation is much appreciated.

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
methods. Internal methods are usually preceded with a "_".

=cut


package Bio::Tools::Run::RepeatMasker;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            @RM_SWITCHES @RM_PARAMS @OTHER_SWITCHES %OK_FIELD);

use strict;
use Bio::SeqFeature::Generic;
use Bio::SeqFeature::FeaturePair;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::RepeatMasker;


# Let the code begin...

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase );

BEGIN {
    @RM_PARAMS = qw(DIR DIV LIB CUTOFF PARALLEL GC FRAG SPECIES MAXSIZE );

    @RM_SWITCHES = qw(NOLOW LOW L NOINT INT NORNA ALU M MUS ROD 
		      RODENT MAM MAMMAL COW AR 
		      ARABIDOPSIS DR DROSOPHILA EL ELEGANS 
		      IS_ONLY IS_CLIP NO_IS RODSPEC E EXCLN 
                      NO_ID FIXED XM U GFF ACE POLY X XSMALL SMALL
                      INV A ALIGNMENTS 
		      PRIMSPEC W WUBLAST S Q QQ GCCALC NOCUT); 
    @OTHER_SWITCHES = qw(NOISY QUIET SILENT);

    # Authorize attribute fields
    foreach my $attr ( @RM_PARAMS, @RM_SWITCHES,
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
  return 'RepeatMasker';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{REPEATMASKERDIR}) if $ENV{REPEATMASKERDIR};
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
 Usage   : $rm->new($seq)
 Function: creates a new wrapper
 Returns:  Bio::Tools::Run::RepeatMasker
 Args    : self

=cut

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);

  my ($attr, $value);
  # Need to check that filehandle is not left open here...
  while (@args) { 
    $attr =   shift @args;
    $value =  shift @args;
    next if( $attr =~ /^-/ ); # don't want named parameters
    $self->$attr($value);
  }
  unless ($self->executable()) {
    if( $self->verbose >= 0 ) {
      warn "RepeatMasker program not found as ".($self->executable||'').
	  " or not executable. \n"; 
    }
  }  
  return $self;
}

=head2  version

 Title   : version
 Usage   : 
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    return $self->{'_version'} if( defined $self->{'_version'} );
    my $exe = $self->executable;
    return undef unless $exe;
    my $string = `$exe -- ` ;    
    if( $string =~ /\(([\d.]+)\)/ ||
	$string =~ /RepeatMasker\s+version\s+(\S+)/ ) { 
	return $self->{'_version'} = $1;
    } else {
	return $self->{'_version'} = undef;
    }
    
}

=head2 run

 Title   : run
 Usage   : $rm->run($seq);
 Function: Run Repeatmasker on the sequence set as
           the argument
 Returns : an array of repeat features that are
           Bio::SeqFeature::FeaturePairs
 Args    : Bio::PrimarySeqI compliant object

=cut

sub run {
  my ($self,$seq) = @_;
  my ($infile);
  $infile = $self->_setinput($seq);

  my $param_string = $self->_setparams();
  my @repeat_feats = $self->_run($infile,$param_string);

  return @repeat_feats;
}


=head2  mask

 Title   : mask
 Usage   : $rm->mask($seq)
 Function: This method is deprecated. Call run() instead
 Example :
 Returns : an array of repeat features that are
           Bio::SeqFeature::FeaturePairs
 Args    : Bio::PrimarySeqI compliant object

=cut

sub mask{
	return shift->run(@_);
}


=head2  _run

 Title   : _run
 Usage   : $rm->_run ($filename,$param_string)
 Function: internal function that runs the repeat masker
 Example :
 Returns : an array of repeat features
 Args    : the filename to the input sequence and the parameter string

=cut

sub _run {
  my ($self,$infile,$param_string) = @_;
  my $instring;
  $self->debug( "Program ".$self->executable."\n");

  my $outfile = $infile.".out";
  my $cmd_str = $self->executable." $param_string ". $infile;
  $self->debug("repeat masker command = $cmd_str");
  if ($self->quiet || $self->verbose <=0){
      $cmd_str.=" 2> /dev/null 1>/dev/null";
  }
  my $status = system($cmd_str);
  $self->throw("Repeat Masker Call($cmd_str) crashed: $?\n") 
      unless $status == 0;
  unless (open (RM, $outfile)) {
      $self->throw("Cannot open RepeatMasker outfile for parsing");
  }
  my $rpt_parser = Bio::Tools::RepeatMasker->new(-fh=>\*RM);
  my @rpt_feat;
  while(my $rpt_feat = $rpt_parser->next_result){
      push @rpt_feat, $rpt_feat;
  }
  $self->repeat_features(\@rpt_feat);

  #get masked sequence
  my $masked = $infile.".masked";
  my $seqio = Bio::SeqIO->new(-file=>$masked,-format=>'FASTA');
  $self->masked_seq($seqio->next_seq);

  return @rpt_feat;
}

=head2  masked_seq

 Title   : masked_seq
 Usage   : $rm->masked_seq($seq)
 Function: get/set for masked sequence
 Example :
 Returns : the masked sequence
 Args    : Bio::Seq object

=cut

sub masked_seq {
  my ($self,$seq) = @_;
  if($seq){
    $self->{'_masked_seq'} = $seq;
  }
  return $self->{'_masked_seq'};
}

=head2  repeat_features

 Title   : repeat_features
 Usage   : $rm->repeat_features(\@rf)
 Function: get/set for repeat features array
 Example :
 Returns : the array of repeat features
 Args    : 

=cut

sub repeat_features {
  my ($self,$rf) = @_;
  if($rf) {
    $self->{'_rf'} = $rf;
  }
  return @{$self->{'_rf'}};
}

=head2  _setparams()

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function:  Create parameter inputs for repeatmasker program
 Example :
 Returns : parameter string to be passed to repeatmasker
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;

    my $param_string = "";
    for  $attr ( @RM_PARAMS ) {
      $value = $self->$attr();
      next unless (defined $value);

      my $attr_key = lc $attr; #put params in format expected by dba

      $attr_key = ' -'.$attr_key;
      $param_string .= $attr_key.' '.$value;
    }

    for  $attr ( @RM_SWITCHES) {
      $value = $self->$attr();
      next unless ($value);
      my $attr_key = lc $attr; #put switches in format expected by dba
      $attr_key = ' -'.$attr_key;
      $param_string .= $attr_key ;
    }


    return $param_string;
}


=head2  _setinput()

 Title   : _setinput
 Usage   : Internal function, not to be called directly
 Function: writes input sequence to file and return the file name
 Example :
 Returns : string 
 Args    : a Bio::PrimarySeqI compliant object

=cut

sub _setinput {
  my ($self,$seq) = @_;
  $seq->isa("Bio::PrimarySeqI") || 
      $self->throw("Need a Bio::PrimarySeq compliant object for RepeatMasker");
#  my  $in  = Bio::SeqIO->new(-file => $infilename , '-format' => 'Fasta');
  my ($tfh1,$outfile1) = $self->io->tempfile(-dir=>$self->tempdir);
  my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'fasta');
  $out1->write_seq($seq);
  close($tfh1);
  undef $tfh1;
  return ($outfile1);
}



=head1 Bio::Tools::Run::Wrapper methods

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
 Usage   : my $outfile = $codeml->outfile_name();
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
 Usage   : $codeml->cleanup();
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

1;


