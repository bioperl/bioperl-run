# $Id$
# BioPerl module for RepeatMasker
#
# Cared for by Shawn Hoon <shawnh@fugu-sg.org>
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::RepeatMasker -
Wrapper for RepeatMasker Program

=head1 SYNOPSIS

  use Bio::Tools::Run::RepeatMasker;

  my @params=("mam" => 1,"noint"=>1);
  my $factory = Bio::Tools::Run::RepeatMasker->new(@params);
  $in  = Bio::SeqIO->new(-file => "contig1.fa",
                         -format => 'fasta');
  my $seq = $in->next_seq();

  #return an array of Bio::SeqFeature::FeaturePair objects
  my @feats = $factory->mask($seq); 

or

  $factory->mask($seq);
  my @feats = $factory->repeat_features;

  #return the masked sequence, a Bio::SeqI object
  my $masked_seq = $factory->masked_seq;

=head1 DESCRIPTION

RepeatMasker is a program that screens DNA sequences for interspersed
repeats known to exist in mammalian genomes as well as for low
complexity DNA sequences. For more information, on the program and its
usage, please refer to http://repeatmasker.genome.washington.edu/.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists. Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bio.perl.org/MailList.html  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via email
or the web:

  bioperl-bugs@bioperl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR - Shawn Hoon


Email shawnh@fugu-sg.org


=head1 APPENDIX


The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a "_".

=cut


package Bio::Tools::Run::RepeatMasker;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            $TMPDIR $TMPOUTFILE @RM_SWITCHES @RM_PARAMS
            @OTHER_SWITCHES %OK_FIELD);

use strict;
use Bio::SeqFeature::Generic;
use Bio::SeqFeature::FeaturePair;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;

# Let the code begin...

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase );

BEGIN {
    $PROGRAMNAME = "RepeatMasker" . ($^O =~ /mswin/i ?'.exe':'');
    if (defined $ENV{'REPEATMASKERDIR'}) {
        $PROGRAMDIR = $ENV{REPEATMASKERDIR} || '';
        $PROGRAM = Bio::Root::IO->
	    catfile($PROGRAMDIR."/src/bin/",
		    'RepeatMasker'.($^O =~ /mswin/i ?'.exe':''));
    }

    @RM_PARAMS = qw(DIV LIB CUTOFF PARALLEL GC FRAG );

    @RM_SWITCHES = qw(NOLOW LOW L NOINT INT NORNA ALU M MUS ROD RODENT MAM MAMMAL COW AR 
                       ARABIDOPSIS DR DROSOPHILA EL ELEGANS IS_ONLY IS_CLIP NO_IS RODSPEC
		       PRIMSPEC W WUBLAST S Q QQ GCCALC NOCUT NOISY QUIET); 

    # Authorize attribute fields
    foreach my $attr ( @RM_PARAMS, @RM_SWITCHES,
                       @OTHER_SWITCHES) { $OK_FIELD{$attr}++; }
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
  # to facilitiate tempfile cleanup

  my ($attr, $value);
  ($TMPDIR) = $self->io->tempdir(CLEANUP=>1);
  (undef,$TMPOUTFILE) = $self->io->tempfile(-dir => $TMPDIR);
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

  unless ($self->executable()) {
    if( $self->verbose >= 0 ) {
      warn "RepeatMasker program not found as ".$self->executable.
	  " or not executable. \n"; 
    }
  }

  return $self;
}

=head2  executable()

 Title   : executable
 Usage   : $exe = Bio::Tools::Run::RepeatMasker->executable()
 Function: Finds the full path to the 'protdist' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to 
           [optional] boolean flag whether or not warn when exe is not found

=cut

sub executable {
   my ($self, $exe,$warn) = @_;

   if( defined $exe ) {
     $self->{'_pathtoexe'} = $exe;
   }

   unless( defined $self->{'_pathtoexe'} ) {
       if( $PROGRAM && -e $PROGRAM && -x $PROGRAM ) {
	   $self->{'_pathtoexe'} = $PROGRAM;
       } else { 
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($PROGRAMNAME) ) &&
	       -x $exe ) {
	       $self->{'_pathtoexe'} = $exe;
	   } else { 
	       $self->warn("Cannot find executable for $PROGRAMNAME") if $warn;
	       $self->{'_pathtoexe'} = undef;
	   }
       }
   }
   $self->{'_pathtoexe'};    
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
    $string =~ /\(([\d.]+)\)/;
    return $self->{'_version'} = $1 || undef;
}

=head2  mask

 Title   : mask
 Usage   : $rm->mask($seq)
 Function: carry out repeat mask
 Example :
 Returns : an array of repeat features that are
           Bio::SeqFeature::FeaturePairs
 Args    : Bio::PrimarySeqI compliant object

=cut

sub mask {
  my ($self,$seq) = @_;
  my ($infile);
  $infile = $self->_setinput($seq);

  my $param_string = $self->_setparams();
  my @repeat_feats = $self->_run($infile,$param_string);

  return @repeat_feats;

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
      $cmd_str.=" >&/dev/null";
  }
  my $status = system($cmd_str);
  $self->throw("Repeat Masker Call($cmd_str) crashed: $?\n") 
      unless $status == 0;
  my $rpt_feat = $self->_parse_results($outfile);
  $self->repeat_features($rpt_feat);

  #get masked sequence
  my $masked = $infile.".masked";
  my $seqio = Bio::SeqIO->new(-file=>$masked,-format=>'FASTA');
  $self->masked_seq($seqio->next_seq);

  return @{$rpt_feat};
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

=head2  _parse_results()

 Title   : _parse_results
 Usage   : Internal function, not to be called directly
 Function: parses the results from RepeatMasker output 
           (largely copied from Ensembl RepeatMasker Runnable)
 Example :
 Returns : array of repeat features 
 Args    : the name of the output file

=cut

sub _parse_results {
  my ($self,$outfile) = @_;
  $outfile || $self->throw("No outfile specified");
  open(REPOUT,"<$outfile") || $self->throw("Error opening $outfile\n");
  my $filehandle = \*REPOUT;
  my @repeat_features;
  #check if no repeats found
    if (<$filehandle> =~ /no repetitive sequences detected/)
    {
        print STDERR "RepeatMasker didn't find any repetitive sequences\n";
        close $filehandle;
        return;
    }
    #extract values
     while (<$filehandle>) {  
       if (/\d+/) { #ignore introductory lines
            my @element = split;
            # ignore features with negatives 
            next if ($element[11-13] =~ /-/); 
            my (%feat1, %feat2);
            my ($score, $query_name, $query_start, $query_end, $strand,
		$repeat_name, $repeat_class ) = (split)[0, 4, 5, 6, 8, 9, 10];
            my ($hit_start,$hit_end);
	    if ($strand eq '+') {
            ($hit_start, $hit_end) = (split)[11, 12];
            $strand = 1;
	    }
       elsif ($strand eq 'C') {
	        ($hit_start, $hit_end) = (split)[12, 13];
          $strand = -1;
	    }
     #my $rc = $self->_get_consensus($repeat_name, $repeat_class);
      
	    my $rf = Bio::SeqFeature::Generic->new;
	    $rf->seqname          ($query_name);
	    $rf->score            ($score);
	    $rf->start            ($query_start);
	    $rf->end              ($query_end);
	    $rf->strand           ($strand);
      $rf->source_tag       ($PROGRAMNAME);
      $rf->primary_tag      ($repeat_class);

      my $rf2 = Bio::SeqFeature::Generic->new;
      $rf2->seqname         ($repeat_name);
      $rf2->score           ($score);
      $rf2->start           ($hit_start);
      $rf2->end             ($hit_end);
      $rf2->strand          ($strand);
      $rf2->source_tag      ($PROGRAMNAME);
      $rf->primary_tag      ($repeat_class);

      my $fp = Bio::SeqFeature::FeaturePair->new(-feature1=>$rf,
                                            -feature2=>$rf2);


	    #$rf->repeat_consensus ($rc);

	    push @repeat_features, $fp;
        }
    }
    close $filehandle;

    return \@repeat_features;
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
  my ($tfh1,$outfile1) = $self->io->tempfile(-dir=>$TMPDIR);
  my $out1 = Bio::SeqIO->new(-fh=> $tfh1 , '-format' => 'Fasta');
  $out1->write_seq($seq);

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
 Function: Will cleanup the tempdir directory after a PAML run
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


