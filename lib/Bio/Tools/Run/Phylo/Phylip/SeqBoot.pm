# BioPerl module for Bio::Tools::Run::Phylo::Phylip::SeqBoot
#
# Created by
#
# Shawn Hoon 
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME 

Bio::Tools::Run::Phylo::Phylip::SeqBoot - Wrapper for the phylip
program SeqBoot

=head1 SYNOPSIS

  #Create a SimpleAlign object
  @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
  $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
  $inputfilename = 't/data/cysprot.fa';
  $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.

  # Use seqboot to generate bootstap alignments
  my @params = ('datatype'=>'SEQUENCE','replicates'=>100);
  my $seq = Bio::Tools::Run::Phylo::Phylip::SeqBoot->new(@params);

  my $aln_ref = $seq->run($aln);

  my $aio = Bio::AlignIO->new(-file=>">alignment.bootstrap",-format=>"phylip");
  foreach my $ai(@{$aln_ref}){
         $aio->write_aln($ai);
  }

  # To prevent PHYLIP from truncating sequence names:
  # Step 1. Shelf the original names:
  my ($aln_safe, $ref_name)=                  #  $aln_safe has serial names
             $aln->set_displayname_safe();    #  $ref_name holds orginal names 
  # Step 2. Run PHYLIP programs:
  $aln_ref = $seq->run($aln_safe);            #  Use $aln_safe instead of $aln
  # Step 3. Retrieve orgininal names
  $aio = Bio::AlignIO->new(
             -file=>">alignment.bootstrap",
             -format=>"fasta");               #  FASTA output to view full names
  foreach my $ai(@{$aln_ref}){
         my $new_aln=$ai->restore_displayname($ref_name); #  Restore names
         $aio->write_aln($new_aln);
  }

=head1 DESCRIPTION

Wrapper for seqboot from the phylip package by Joseph Felsentein.

Taken from phylip doc...

"SEQBOOT is a general boostrapping tool.  It is intended to  allow  you  to
generate  multiple data sets that are resampled versions of the input data set.
SEQBOOT  can  handle  molecular   sequences,   binary   characters, 
restriction sites, or gene frequencies."

More documentation on using seqboot and setting parameters may be found
in the phylip package.

VERSION Support
This wrapper currently supports v3.5 of phylip. There is also support for v3.6 although
this is still experimental as v3.6 is still under alpha release and not all functionalities maybe supported.

=head1 PARAMETERS FOR SEQBOOT 

=head2 MODEL

Title		: DATATYPE
Description	: (optional)

                  This program supports 3 different datatypes
                  SEQUENCE: Molecular Sequences
                  MORPH   : Discrete  Morphological  Characters
                  REST    : Restriction Sites
                  GENEFREQ: Gene  Frequencies

             Defaults to SEQUENCE

=head2 PERMUTE

Title: PERMUTE
Description: (optional)

             3 different resampling methods are available:

             BOOTSTRAP : creating a new data set by sampling N
                         characters randomly with replacement The
                         resulting data set has the same size as the
                         original, but some characters have been left
                         out and others are duplicated

             JACKKNIFE : Delete-half-jackknifing. It involves sampling
                         a random half of the characters, and
                         including them in the data but dropping the
                         others The resulting data sets are half the
                         size of the original, and no characters are
                         duplicated.

             PERMUTE : Permuting species within characters. It
                       involves permuting the columns of the data
                       matrix separately.  This produces data matrices
                       that have the same number and kinds of
                       characters but no taxonomic structure.

             Defaults to BOOTSTRAP

=head2 REPLICATES 

  Title		: REPLICATES
  Description	: (optional)

                This options allows the user to set the number of
                replicate data sets. Most statisticians would be
                happiest with 1000 to 10,000 replicates in a
                bootstrap, but 100 gives a good rough picture

                Defaults to 100

=head2 ALLELES 

Title		:  ALLELES
Description : (optional)

            This option is to be used with gene frequencies datatype
            option to specify that all alleles at each locus are in
            the input file.

		  Defaults to NULL 

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

#'

	
package Bio::Tools::Run::Phylo::Phylip::SeqBoot;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    @SEQBOOT_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Phylip::Base;
use Bio::Tools::Run::Phylo::Phylip::PhylipConf qw(%Menu);
use Bio::Matrix::PhylipDist;
use Cwd;


# inherit from Phylip::Base which has some methods for dealing with
# Phylip specifics
@ISA = qw(Bio::Tools::Run::Phylo::Phylip::Base);

# You will need to enable the SeqBoot program. This
# can be done in (at least) 3 ways:
#
# 1. define an environmental variable PHYLIPDIR:
# export PHYLIPDIR=/home/shawnh/PHYLIP/bin
#
# 2. include a definition of an environmental variable CLUSTALDIR in
# every script that will use Clustal.pm.
# $ENV{PHYLIPDIR} = '/home/shawnh/PHYLIP/bin';
#
# 3. You can set the path to the program through doing:
# my @params('executable'=>'/usr/local/bin/seqboot');
# my $SeqBoot_factory = Bio::Tools::Run::Phylo::Phylip::SeqBoot->new(@params);
# 


BEGIN {
	@SEQBOOT_PARAMS = qw(DATATYPE PERMUTE BLOCKSIZE REPLICATES READWEIGHTS READCAT);
	@OTHER_SWITCHES = qw(QUIET);
	foreach my $attr(@SEQBOOT_PARAMS,@OTHER_SWITCHES) {
		$OK_FIELD{$attr}++;
	}
}

=head2 program_name

 Title   : program_name
 Usage   : >program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
  return 'seqboot';
}

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{PHYLIPDIR}) if $ENV{PHYLIPDIR};
}

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    
    my ($attr, $value);
    while (@args)  {
	$attr =   shift @args;
	$value =  shift @args;
	next if( $attr =~ /^-/ ); # don't want named parameters
	if ($attr =~/PROGRAM/i) {
	    $self->executable($value);
	    next;
	}
	if ($attr =~ /IDLENGTH/i){
	    $self->idlength($value);
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

=head2 idlength 

 Title   : idlength 
 Usage   : $obj->idlength ($newval)
 Function: 
 Returns : value of idlength 
 Args    : newvalue (optional)


=cut

sub idlength{
   my $self = shift;
   if( @_ ) {
      my $value = shift;
      $self->{'idlength'} = $value;
    }
    return $self->{'idlength'};

}


=head2  run 

 Title   : run 
 Usage   :
	$inputfilename = 't/data/prot.phy';
	$matrix= $seqboot_factory->run($inputfilename);
or
	$seq_array_ref = \@seq_array; @seq_array is array of Seq objs
	$aln = $clustalw_factory->align($seq_array_ref);
	$aln_ref = $SeqBootfactory->run($aln);

 Function: Create bootstrap sets of alignments
 Example :
 Returns : an array ref of L<Bio::SimpleAlign>
 Args    : Name of a file containing a multiple alignment in Phylip format
           or an SimpleAlign object 

 Throws an exception if argument is not either a string (eg a
 filename) or a Bio::SimpleAlign object. If
 argument is string, throws exception if file corresponding to string
 name can not be found. 

=cut

sub run{

    my ($self,$input) = @_;
    my ($infilename);

# Create input file pointer
  	$infilename = $self->_setinput($input);
    if (!$infilename) {$self->throw("Problems setting up for seqboot. Probably bad input data in $input !");}

# Create parameter string to pass to SeqBoot program
    my $param_string = $self->_setparams();
# run SeqBoot
    my $aln = $self->_run($infilename,$param_string);
    return $aln;
}

#################################################

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to SeqBoot program
 Example :
 Returns : an array ref of <Bio::SimpleAlign> 
 Args    : Name of a file containing a set of multiple alignments in Phylip format 
           and a parameter string to be passed to SeqBoot


=cut

sub _run {
    my ($self,$infile,$param_string) = @_;
    my $instring;
    my $curpath = cwd;    
    unless( File::Spec->file_name_is_absolute($infile) ) {
	$infile = $self->io->catfile($curpath,$infile);
    }
    #odd random seed
    my $rand = (2 * int(rand(10000)) + 1);
    if ($self->version == 3.5){
      $instring =  $infile."\n$rand\n$param_string";
    }
    else {
      $instring =  $infile."\n$param_string$rand\n";
    }
    $self->debug( "Program ".$self->executable." $instring\n");
    
    chdir($self->tempdir);
    #open a pipe to run SeqBoot to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
    	open(SeqBoot,"|".$self->executable .">/dev/null");
    }
    else {
    	open(SeqBoot,"|".$self->executable);
    }
    print SeqBoot $instring;
    close(SeqBoot);	
    
    # get the results
    my $outfile = $self->io->catfile($self->tempdir,$self->outfile);
    chdir($curpath);
    $self->throw("SeqBoot did not create files correctly ($outfile)")
  	unless (-e $outfile);
    
    #parse the alignments
    my @aln;
    my @parse_params;

    push @parse_params, ('-interleaved' => 1) if $self->version == 3.6;
    my $aio = Bio::AlignIO->new(-file=>$outfile,-format=>"phylip",
				@parse_params);
    while (my $aln = $aio->next_aln){
        push @aln, $aln;
    }

    # Clean up the temporary files created along the way...
    unlink $outfile unless $self->save_tempfiles;
	
    return \@aln;
}


=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:   Create input file for SeqBoot program
 Example :
 Returns : name of file containing a multiple alignment in Phylip format 
 Args    : SimpleAlign object reference or input file name


=cut

sub _setinput {
    my ($self, $input) = @_;
    my ($alnfilename,$tfh);
  
    #  a phy formatted alignment file 
  	unless (ref $input) {
        # check that file exists or throw
        $alnfilename= $input;
        unless (-e $input) {return 0;}
		   return $alnfilename;
    }
    my @input = ref($input) eq 'ARRAY' ? @{$input}: ($input);

    ($tfh,$alnfilename) = $self->io->tempfile(-dir=>$self->tempdir);
    my $alnIO = Bio::AlignIO->new(-fh => $tfh, 
	                      			      -format=>'phylip',
                      				      -idlength=>$self->idlength());
    foreach my $input(@input){
    #  $input should be a Bio::Align::AlignI 
      $input->isa("Bio::Align::AlignI") || $self->throw("Expecting a Bio::Align::AlignI object");
      #  Open temporary file for both reading & writing of BioSeq array
    	$alnIO->write_aln($input);
    }
    $alnIO->close();
    close($tfh);
    return $alnfilename;		
}

=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:   Create parameter inputs for SeqBoot program
 Example :
 Returns : parameter string to be passed to SeqBoot
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    #do nothing for now
    $self = shift;
    my $param_string = "";
    my $cat = 0;
    my $gene_freq = 0;
    my %menu = %{$Menu{$self->version}->{'SEQBOOT'}};

    foreach  my $attr ( @SEQBOOT_PARAMS) {
    	$value = $self->$attr();
    	next unless (defined $value);
    	if ($attr =~/REPLICATES/i){
        if( $value !~ /(\d+(\.\d+)?)/ ) {
            $self->warn("Expected a number in  $attr\n");
            next;
        }
		   $param_string .= $menu{'REPLICATES'}."$value\n";
      }
      elsif($attr=~/DATATYPE/i){
          $gene_freq = 1 if $value =~/GENEFREQ/i;
          $param_string .= $menu{'DATATYPE'}{uc $value};
      }
      else {
       if($attr =~/ALLELES/i){
           if(!$gene_freq){
             $self->warn("Alleles options only be used with alleles option");
             return;
           }
           $param_string .=$menu{uc $attr};
       }
      }
	  }
    $param_string .= $menu{'SUBMIT'};

    return $param_string;
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
 Usage   : my $outfile = $SeqBoot->outfile_name();
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
 Function: Will cleanup the tempdir directory after a SeqBoot run
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
