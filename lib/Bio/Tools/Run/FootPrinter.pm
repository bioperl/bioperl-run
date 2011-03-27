# $Id$
# BioPerl module for FootPrinter
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::FootPrinter - wrapper for the FootPrinter program

=head1 SYNOPSIS

  use Bio::Tools::Run::FootPrinter;

  my @params = (size => 10,
                 max_mutations_per_branch => 4,
                 sequence_type => 'upstream',
                 subregion_size => 30,
                 position_change_cost => 5,
                 triplet_filtering => 1,
                 pair_filtering => 1,
                 post_filtering => 1,
                 inversion_cost => 1,
                 max_mutations => 4,
                 tree => "~/software/FootPrinter2.0/tree_of_life" );

  my $fp = Bio::Tools::Run::FootPrinter->new(@params, -verbose => 1);

  my $sio = Bio::SeqIO->new(-file => "seq.fa", -format => "fasta");

  while (my $seq = $sio->next_seq){
    push @seq, $seq;
  }
  my @fp = $fp->run(@seq);

  foreach my $result(@fp){
    print "***************\n".$result->seq_id."\n";
    foreach my $feat($result->sub_SeqFeature){
      print $feat->start."\t".$feat->end."\t".$feat->seq->seq."\n";
    }
  }

=head1 DESCRIPTION

From the FootPrinter manual:

FootPrinter is a program that performs phylogenetic footprinting. 
It takes as input a set of unaligned orthologous sequences from various 
species, together with a phylogenetic tree relating these species. 
It then searches for short regions of the sequences that are highly conserved, 
according to a parsimony criterion. 

The regions identified are good candidates for regulatory elements. 
By default, the program searches for regions that are well conserved across 
all of the input sequences, but this can be relaxed to 
find regions conserved in only a subset of the species

=head2 About Footprinter

Written by Mathieu Blanchette and Martin Tompa. Available here:

  http://www.mcb.mcgill.ca/~blanchem/FootPrinter2.1.tar.gz 


=head2 Running Footprinter

To run FootPrinter, you will need to set the enviroment variable
FOOTPRINTER_DIR to where the binary is located (even if the executable
is in your path). For example:

  setenv FOOTPRINTER_DIR /usr/local/bin/FootPrinter2.0/


=head2 Available Parameters

  PARAM         VALUES        DESCRIPTION
  ------------------------------------------------------------------------
  tree                      <file>     REQUIRED, Tree in Newick Format
                                       to evaluate parsimony score 
                                       REQUIRED unless tree_of_life
                                       exists in FOOTPRINTER_DIR
  sequence_type             upstream   Default upstream
                            downstream
                            other
  size                      4-16       Specifies the size of the motifs sought
  max_mutations             0-20       maximum parsimony score allowed for the motifs
  max_mutations_per_branch  0-20       Allows at most a fixed number of mutations per 
                                       branch of the tree
  losses                    <file>     files give span constraints so that the motifs
                                       reported are statistically significant
                                       Example files
                                       universal([6-9]|1[0-2])(loose|tight)?.config
                                       come with FootPrinter2.0.
                                       Install these in FOOTPRINTER_DIR and use by
                                       setting "losses" to "somewhat significant",
                                       "significant", or "very significant". Do not
                                       set loss_cost.
  loss_cost                 0-20       a cost associated with losing a motif along some 
                                       branch of the tre
  subregion_size            1-infinity penalize motifs whose position in the sequences 
                                       varies too much
  position_change_cost      0-20       Cost for changing subregion
  triplet_filtering         1/0        pre-filtering step that removes from consideration 
                                       any substring that does not have a sufficiently good 
                                       pair of matching substrings in some pair of the other 
                                       input sequences
  pair_filtering            1/0        Same as triplet filtering, but looks only for one match 
                                       per other sequence
  post_filtering            1/0        when used in conjunction with the triplet filtering 
                                       option, this often significantly speeds up the program, 
                                       while still garanteeing optimal results
  indel_cost                1-5        insertions and deletions will be allowed in the motifs 
                                       sought, at the given cost
  inversion_cost            1-5        This option allows for motifs to undergo inversions, 
                                       at the given cost. An inversion reverse-complements 
                                       the motif.
  details                   1/0        Shows some of the details about the progress of the 
                                       computation
  html                      1/0        produce html output (never deleted)
  ps                        1/0        produce postscript output (never deleted)

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

package Bio::Tools::Run::FootPrinter;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
            @FP_SWITCHES @FP_PARAMS @OTHER_SWITCHES %OK_FIELD);

use strict;
use Cwd;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::FootPrinter;
use Bio::SeqIO;

# Let the code begin...

@ISA = qw(Bio::Tools::Run::WrapperBase);

BEGIN {
    @FP_PARAMS = qw(SEQUENCE_TYPE SIZE MAX_MUTATIONS MAX_MUTATIONS_PER_BRANCH
                    LOSSES LOSS_COST TREE PROGRAM SUBREGION_SIZE POSITION_CHANGE_COST
                    INDEL_COST INVERSION_COST );
    @FP_SWITCHES = qw(TRIPLET_FILTERING PAIR_FILTERING POST_FILTERING DETAILS);
    @OTHER_SWITCHES = qw(QUIET HTML PS);

    # Authorize attribute fields
    foreach my $attr ( @FP_PARAMS, @FP_SWITCHES,
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
  return 'FootPrinter';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
  return Bio::Root::IO->catfile($ENV{FOOTPRINTER_DIR}) if $ENV{FOOTPRINTER_DIR};
}

=head2 executable

 Title   : executable
 Usage   : my $exe = $footprinter->executable('FootPrinter');
 Function: Finds the full path to the 'FootPrinter' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to
           [optional] boolean flag whether or not warn when exe is not found

=cut

sub executable {
    my $self = shift;
    my $exe = $self->SUPER::executable(@_) || return;
    
    # even if its executable, we still need the environment variable to have
    # been set
    if (! $ENV{FOOTPRINTER_DIR}) {
        $self->warn("Environment variable FOOTPRINTER_DIR must be set, even if the FootPrinter executable is in your path");
        return;
    }
    
    return $exe;
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
 Returns:  Bio::Tools::Run::FootPrinter
 Args    : self

=cut

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

  if(!$self->tree && -e $ENV{FOOTPRINTER_DIR}."/tree_of_life"){
    $self->tree($ENV{FOOTPRINTER_DIR}."/tree_of_life");
  }

  unless($self->tree){
     $self->debug("Phylogenetic tree not provided. FootPrinter won't be able to run without it. use \$fp->tree to set the tree file");
  }

  return $self;
}

=head2  run

 Title   : run
 Usage   : $fp->run(@seq)
 Function: carry out FootPrinter 
 Example :
 Returns : An array of SeqFeatures 
 Args    : An array of Bio::PrimarySeqI compliant object
           At least 2 are needed.

=cut

sub run {
  my ($self,@seq) = @_;

  #need at least 2 for comparative genomics duh.
  $#seq > 0 || $self->throw("Need at least two sequences");
  $self->tree || $self->throw("Need to specify a phylogenetic tree using -tree option");

  my $infile = $self->_setinput(@seq);

  my $param_string = $self->_setparams();
  my @footprint_feats = $self->_run($infile,$self->tree,$param_string);
  return @footprint_feats;

}

=head2  _run

 Title   : _run
 Usage   : $fp->_run ($filename,$param_string)
 Function: internal function that runs FootPrinter 
 Example :
 Returns : an array of features
 Args    : the filename to the input sequence, filename to phylo tree
           and the parameter string

=cut

sub _run {
  my ($self,$infile,$tree,$param_string) = @_;
  my $instring;
  my $exe = $self->executable || return;
  $self->debug( "Program ".$self->executable."\n");

  my $outfile = $infile.".seq.txt";
  my $cmd_str = $self->executable. " $infile $tree $param_string"; 
  $self->debug("FootPrinter command = $cmd_str");

  if ($self->verbose <=0){
      $cmd_str.=" >&/dev/null > /dev/null";
  }
  
  # will do brute-force clean up of junk files generated by FootPrinter
    my $cwd = cwd();
    opendir(my $cwd_dir, $cwd) || $self->throw("Could not open the current directory '$cwd'!");
    my %ok_files;
    foreach my $thing (readdir($cwd_dir)) {
        if ($thing =~ /^mlc\./) {
            $ok_files{$thing} = 1;
        }
    }
    closedir($cwd_dir);
  
  my $status = system($cmd_str);
  $self->throw("FootPrinter Call($cmd_str) crashed: $?\n") 
      unless $status == 0 || $status==256;
      
  unless (open (FP, $outfile)) {
      $self->throw("Cannot open FootPrinter outfile for parsing");
  }
  
  my $fp_parser = Bio::Tools::FootPrinter->new(-fh=>\*FP);
  my @fp_feat;
  while(my $fp_feat = $fp_parser->next_feature){
      push @fp_feat, $fp_feat;
  }

  unless( $self->save_tempfiles ) {
      unlink $outfile;
      unlink $infile;             # is this dangerous??
      unlink "$infile.order.txt"; # is this dangerous??
      
      opendir($cwd_dir, $cwd) || $self->throw("Could not open the current directory '$cwd'!");
        foreach my $thing (readdir($cwd_dir)) {
            if ($thing =~ /^mlc\./) {
                unlink($thing) unless $ok_files{$thing};
            }
        }
        closedir($cwd_dir);
      
      $self->cleanup();
  }

  return @fp_feat;
}

=head2  _setparams()

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function:  Create parameter inputs for FootPrinter program
 Example :
 Returns : parameter string to be passed to FootPrinter
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;

    my $param_string = "";
    for  $attr ( @FP_PARAMS ) {
      $value = $self->$attr();
      next if $attr=~/TREE/i;
      next unless (defined $value);

      my $attr_key = lc $attr; #put params in format expected by dba
      if ($attr_key eq 'losses' && $value =~ /^\s*(somewhat|very)?\s*significant\s*$/) {
        $value = "$ENV{FOOTPRINTER_DIR}/universal".$self->size();
	if (defined $1) {
          if ($1 eq 'somewhat') {
            $value .= 'loose';
          } else { # $1 eq 'very'
            $value .= 'tight';
          }
        }
        $value .= '.config';
        -f $value or $self->throw("universal losses file $value does not exist");
      }
      $attr_key = ' -'.$attr_key;
      $param_string .= $attr_key.' '.$value;
    }

    for  $attr ( @FP_SWITCHES) {
      $value = $self->$attr();
      next unless ($value);
      my $attr_key = lc $attr; #put switches in format expected by dba
      $attr_key = ' -'.$attr_key;
      $param_string .= $attr_key ;
    }

    $self->html() or $param_string .= " -no_html";
    $self->ps()   or $param_string .= " -no_ps";

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
    my ($self,@seq) = @_;
    my ($tfh1,$outfile1);
    $outfile1 = $self->outfile_name();
    if (defined $outfile1) {
	open($tfh1,">$outfile1");
    } else {
	($tfh1,$outfile1) = $self->io->tempfile(-dir=>$self->tempdir);
    }
    my $out1 = Bio::SeqIO->new('-fh'      => $tfh1, 
			       '-format' => 'Fasta');
    foreach my $seq(@seq){
	$seq->isa("Bio::PrimarySeqI") || $self->throw("Need a Bio::PrimarySeq compliant object for FootPrinter");
	$out1->write_seq($seq);
    }  
    $out1->close(); # close the SeqIO object
    close($tfh1);   # close the fh explicitly (just in case)
    undef($tfh1);   # really get rid of it (just in case)
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


