# BioPerl module for Bio::Tools::Run::Phylo::Phylip::Consense
#
# Created by
#
# Shawn Hoon 
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME 

Bio::Tools::Run::Phylo::Phylip::Consense - Wrapper for the phylip
program Consense

=head1 SYNOPSIS


  use Bio::Tools::Run::Phylo::Phylip::Consense;
  use Bio::Tools::Run::Phylo::Phylip::SeqBoot;
  use Bio::Tools::Run::Phylo::Phylip::ProtDist;
  use Bio::Tools::Run::Phylo::Phylip::Neighbor;
  use Bio::Tools::Run::Phylo::Phylip::DrawTree;


  #first get an alignment
  my $aio= Bio::AlignIO->new(-file=>$ARGV[0],-format=>"clustalw");
  my $aln = $aio->next_aln;

  # To prevent truncation of sequence names by PHYLIP runs, use set_displayname_safe
  my ($aln_safe, $ref_name)=$aln->set_displayname_safe();

  #next use seqboot to generate multiple aligments
  my @params = ('datatype'=>'SEQUENCE','replicates'=>10);
  my $seqboot_factory = Bio::Tools::Run::Phylo::Phylip::SeqBoot->new(@params);

  my $aln_ref= $seqboot_factory->run($aln);

  Or, for long sequence names:

  my $aln_ref= $seqboot_factory->run($aln_safe);

  #next build distance matrices and construct trees
  my $pd_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new();
  my $ne_factory = Bio::Tools::Run::Phylo::Phylip::Neighbor->new();

  foreach my $a (@{$aln_ref}){
    my $mat = $pd_factory->create_distance_matrix($a);
    push @tree, $ne_factory->create_tree($mat);
  }

  #now use consense to get a final tree
  my $con_factory = Bio::Tools::Run::Phylo::Phylip::Consense->new();

  #you may set outgroup either by the number representing the order in
  #which species are entered or by the name of the species

  $con_factory->outgroup(1);
  $con_factory->outgroup('HUMAN');

  my $tree = $con_factory->run(\@tree);

  # Restore original sequence names, after ALL phylip runs:
  my @nodes = $tree->get_nodes();
  foreach my $nd (@nodes){
     $nd->id($ref_name->{$nd->id_output}) if $nd->is_Leaf;
  }

  #now draw the tree
  my $draw_factory = Bio::Tools::Run::Phylo::Phylip::DrawTree->new();
  my $image_filename = $draw_factory->draw_tree($tree);

=head1 DESCRIPTION

Wrapper for phylip consense program

Taken from phylip documentation...

CONSENSE reads a file of computer-readable trees and prints out 
(and may also write out onto a file) a consensus tree. At the moment
it carries out a family of consensus tree methods called the M[l] methods 
(Margush and McMorris, 1981). These include strict consensus
and majority rule consensus. Basically the consensus tree consists of monophyletic 
groups that occur as often as possible in the data.

More documentation on using Consense and setting parameters may be found
in the phylip package.

VERSION Support

This wrapper currently supports v3.5 of phylip. There is also support for v3.6 although
this is still experimental as v3.6 is still under alpha release and not all functionalities maybe supported.

=head1 PARAMETERS FOR Consense 

=head2 TYPE 

Title		: TYPE 
Description	: (optional)
             Only avaliable in phylip v3.6

                  This program supports 3 types of consensus generation 

                  MRe   : Majority Rule (extended) Any set of species that
                          appears in more than 50% of the trees is included. 
                          The program then considers the other sets of species 
                          in order of the frequency with which they have appeared, 
                          adding to the consensus tree any which are compatible 
                          with it until

                  STRICT: A set of species must appear in all input trees to be 
                          included in the strict consensus tree. 

                  MR    :  A set of species is included in the consensus tree 
                          if it is present in more than half of the input trees. 

                  Ml    : The user is asked for a fraction between 0.5 and 1, and 
                          the program then includes in the consensus tree any set 
                          of species that occurs among the input trees more than 
                          that fraction of then time. The Strict consensus and the 
                          Majority Rule consensus are extreme cases of the M[l] consensus,
                          being for fractions of 1 and 0.5 respectively

                  usage: my $factory = Bio::Tools::Run::Phylo::Phylip::Consense->new(-type=>"Ml 0.7");


             Defaults to MRe 

=head2 ROOTED 

  Title: ROOTED 
  Description: (optional)

             toggles between the default assumption that the input trees are unrooted trees and 
             the selection that specifies that the tree is to be treated as a rooted tree and not 
             re-rooted. Otherwise the tree will be treated as outgroup-rooted and will be
             re-rooted automatically at the first species encountered on the first tree 
             (or at a species designated by the Outgroup option)

             usage: my $factory = Bio::Tools::Run::Phylo::Phylip::Consense->new(-rooted=>1);

             Defaults to unrooted 

=head2 OUTGROUP 

  Title		: OUTGROUP
  Description	: (optional)

                It is in effect only if the Rooted option selection is not in effect.
                The trees will be re-rooted with a species of your choosing.

                usage  my $factory = Bio::Tools::Run::Phylo::Phylip::Consense->new(-outgroup=>2);

                Defaults to first species encountered. 

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

	
package Bio::Tools::Run::Phylo::Phylip::Consense;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    @CONSENSE_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Phylip::Base;
use Bio::Tools::Run::Phylo::Phylip::PhylipConf qw(%Menu);
use IO::String;
use Cwd;


# inherit from Phylip::Base which has some methods for dealing with
# Phylip specifics
@ISA = qw(Bio::Tools::Run::Phylo::Phylip::Base);

# You will need to enable the Consense program. This
# can be done in (at least) 3 ways:
#
# 1. define an environmental variable PHYLIPDIR:
# export PHYLIPDIR=/home/shawnh/PHYLIP/bin
#
# 2. include a definition of an environmental variable PHYLIPDIR in
# every script that will use Consense.pm.
# $ENV{PHYLIPDIR} = '/home/shawnh/PHYLIP/bin';
#
# 3. You can set the path to the program through doing:
# my @params('executable'=>'/usr/local/bin/consense');
# my $Consense_factory = Bio::Tools::Run::Phylo::Phylip::Consense->new(@params);
# 


BEGIN {
	@CONSENSE_PARAMS = qw(TYPE OUTGROUP ROOTED);
	@OTHER_SWITCHES = qw(QUIET);
	foreach my $attr(@CONSENSE_PARAMS,@OTHER_SWITCHES) {
	    $OK_FIELD{$attr}++;
	}
}

=head2 program_name

 Title   : program_name
 Usage   : $obj->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'consense';
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
	$inputfilename = 't/data/prot.treefile';
	$tree= $Consense_factory->run($inputfilename);
or

	$tree= $consense_factory->run(\@tree);

 Function: Create bootstrap sets of alignments
 Example :
 Returns : a L<Bio::Tree::Tree>
 Args    : either a file containing trees in newick format
           or an array ref of L<Bio::Tree::Tree>

 Throws an exception if argument is not either a string (eg a
 filename) or a Bio::Tree::TreeI object. If
 argument is string, throws exception if file corresponding to string
 name can not be found. 

=cut

sub run{

    my ($self,$input) = @_;
    my ($infilename);

    # Create input file pointer
    $infilename = $self->_setinput($input);
    if (!$infilename) {
	$self->throw("Problems setting up for Consense. Probably bad input data in $input !");
    }
    
# Create parameter string to pass to Consense program
    my $param_string = $self->_setparams();
# run Consense
    my $aln = $self->_run($infilename,$param_string);
}

#################################################

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to Consense program
 Example :
 Returns : an array ref of <Bio::Tree::Tree> 
 Args    : Name of a file containing a set of tree in newick format 
           and a parameter string to be passed to Consense


=cut

sub _run {
    my ($self,$infile,$param_string) = @_;
    my $instring;
    my $curpath = cwd; 
    unless( File::Spec->file_name_is_absolute($infile) ) {
    	$infile = $self->io->catfile($curpath,$infile);
    }
    my $tmpdir = $self->tempdir;
    chdir($self->tempdir);
    # open a pipe to run Consense to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
   	open(Consense,"| ".$self->executable .">/dev/null");
    }
    else {
    	open(Consense,"| ".$self->executable);
    }
    $instring = $infile."\n".$param_string;
    $self->debug( "Program ".$self->executable." $instring\n");
    print Consense $instring;
    close(Consense);	
    
    # get the results
    my $outfile = $self->io->catfile($self->tempdir,$self->treefile);
    chdir($curpath);    
    
    $self->throw("Consense did not create files correctly ($outfile)")
  	unless (-e $outfile);

    #parse the alignments
    
    my @aln;
    my $tio = Bio::TreeIO->new(-file=>$outfile,-format=>"newick");
    my $tree = $tio->next_tree;

    # Clean up the temporary files created along the way...
    unlink $outfile unless $self->save_tempfiles;
	
    return $tree;
}

sub _set_names_from_tree {
  my ($self,$tree) = @_;
  my $newick;
  my $ios = IO::String->new($newick);
  my $tio = Bio::TreeIO->new(-fh=>$ios,-format=>'newick');
  $tio->write_tree($tree);
  my @names = $newick=~/(\w+):\d+/g;
  my %names;
  for(my $i=0; $i < $#names; $i++){
      $names{$names[$i]} = $i+1;
  }
  $self->names(\%names);

  return;
}


=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:   Create input file for Consense program
 Example :
 Returns : name of file containing a trees in newick format
 Args    : an array ref of Bio::Tree::Tree object or input file name


=cut

sub _setinput {
    my ($self, $input) = @_;
    my ($alnfilename,$tfh);

    #  a phy formatted alignment file 
    unless (ref $input) {
        # check that file exists or throw
        $alnfilename= $input;
	unless (-e $input) {return 0;}
	my $tio = Bio::TreeIO->new(-file=>$alnfilename,-format=>'newick');
	my $tree = $tio->next_tree;
	$self->_set_names_from_tree($tree);
	return $alnfilename;
    }

    #  $input may be a SimpleAlign Object
    my @input = ref($input) eq "ARRAY" ? @{$input} : ($input);
    ($tfh,$alnfilename) = $self->io->tempfile(-dir=>$self->tempdir);
    my $treeIO = Bio::TreeIO->new(-fh => $tfh, 
				  -format=>'newick');

    foreach my $tree(@input){
	$tree->isa('Bio::Tree::TreeI') || $self->throw('Expected a Bio::TreeI object');
	$treeIO->write_tree($tree);
    }
    #get the species names in order, using the first one
    $self->_set_names_from_tree($input[0]);
    $treeIO->close();
    close($tfh);
    undef $tfh;
    return $alnfilename;		
}

=head2  names()

 Title   :  names
 Usage   :  $tree->names(\%names)
 Function:  get/set for a hash ref for storing names in matrix
            with rank as values.
 Example :
 Returns : hash reference
 Args    : hash reference

=cut

sub names {
    my ($self,$name) = @_;
    if($name){
        $self->{'_names'} = $name;
    }
    return $self->{'_names'};
}

=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:   Create parameter inputs for Consense program
 Example :
 Returns : parameter string to be passed to Consense
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    #do nothing for now
    $self = shift;
    my $param_string = "";
    my $rooted = 0;

    #for case where type is Ml
    my $Ml = 0;
    my $frac = 0.5;
    my %menu = %{$Menu{$self->version}->{'CONSENSE'}};

    foreach  my $attr ( @CONSENSE_PARAMS) {
    	$value = $self->$attr();
    	next unless (defined $value);
    	if ($attr =~/ROOTED/i){
        $rooted = 1;
        $param_string .= $menu{'ROOTED'};
      }
      elsif($attr =~/OUTGROUP/i){
          if($rooted == 1){
              $self->warn("Outgroup option cannot be used with a rooted tree");
              next;
          }
          if($value !~/^\d+$/){ # is a name
              my %names = %{$self->names};
              $names{$value} || $self->throw("Outgroup $value not found");
              $value = $names{$value};
          }
          $param_string .=$menu{'OUTGROUP'}."$value\n";
      }
      elsif($attr=~/TYPE/i){
          if($value=~/Ml/i){
              ($value,$frac) = split(/\s+/,$value);
              #default if not given
              $frac ||= 0.5;
              if($frac <= 0.5 || $frac > 1){
                  $self->warn("fraction given is out of range 0.5<frac<1, setting to 0.5");
                  $frac = 0.5;
              }
              $Ml=1;
          }
          $param_string.=$menu{'TYPE'}{uc $value};
      }
      else {
          $param_string.=$menu{uc $attr};
      }
	  }
    $param_string .= $menu{'SUBMIT'};
    if($Ml){
        $param_string.=$frac."\n";
    }

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
 Usage   : my $outfile = $Consense->outfile_name();
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
 Function: Will cleanup the tempdir directory after a Consense run
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
