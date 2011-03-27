# BioPerl module for Bio::Tools::Run::Phylo::Phylip::Neighbor
#
# Created by
#
# Shawn Hoon 
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Phylip::Neighbor - Wrapper for the phylip
program neighbor by Joseph Felsenstein for creating a phylogenetic
tree(either through Neighbor or UPGMA) based on protein distances
based on amino substitution rate.

14 Nov 2002 Shawn
Works with Phylip version 3.6

=head1 SYNOPSIS

  #Create a SimpleAlign object
  @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
  $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
  $inputfilename = 't/data/cysprot.fa';
  $aln = $factory->run($inputfilename); # $aln is a SimpleAlign object.

  # Create the Distance Matrix
  # using a default PAM matrix and id name lengths limit of 30 note to
  # use id name length greater than the standard 10 in neighbor, you
  # will need to modify the neighbor source code

  $protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
  my $matrix  = $protdist_factory->run($aln);

  #Create the tree passing in the distance matrix
  @params = ('type'=>'NJ','outgroup'=>2,'lowtri'=>1,
             'upptri'=>1,'subrep'=>1);

  my $neighbor_factory = 
     Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);

  #you can set your outgroup using either a number specifying
  #the rank in the matrix or you can just use the name of the
  #species

  $neighbor_factory->outgroup('ENSP00001');
  #or
  $neighbor_factory->outgroup(1);

  my ($tree) = $neighbor_factory->run($matrix);

  # Alternatively, one can create the tree by passing in a file name 
  # containing a phylip formatted distance matrix(using protdist)
  my $neighbor_factory = 
    Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);
  my ($tree) = $neighbor_factory->run('/home/shawnh/prot.dist');

  # To prevent PHYLIP from truncating sequence names:
  # Step 1. Shelf the original names:
    my ($aln_safe, $ref_name)=                    #   $aln_safe has serial names
               $aln->set_displayname_safe();      #   $ref_name holds original names
  # Step 2. Run ProtDist and Neighbor:
    $matrix  = $protdist_factory->
                creat_distance_matrix($aln_safe); #  Use $aln_safe instead of $aln
    $tree = $neighbor_factory->run($matrix);
  # Step 3. Retrieve orgininal OTU names:
    use Bio::Tree::Tree;
    my @nodes=$tree->get_nodes();
    foreach my $nd (@nodes){
       $nd->id($ref_name->{$nd->id_output}) if $nd->is_Leaf;
    }


=head1 PARAMTERS FOR NEIGHBOR COMPUTATION

=cut

=head2 TYPE

  Title 	: TYPE
  Description	: (optional)
                  This sets the type of tree to construct, using
                  neighbor joining or UPGMA.

		  NJ	Neighbor Joining
		  UPGMA	UPGMA

  Usage         : @params = ('type'=>'X');#where X is one of the values above
		  Defaults to NJ 

 		  For more information on the usage of the different
                  models, please refer to the documentation found in
                  the phylip package.

=head2 OUTGROUP (*ONLY AVAILABLE FOR NEIGHBOR JOINING)

  Title		: OUTGROUP 
  Description	: (optional)
                  This option selects the species to be used as the outgroup
  Acceptable Values: integer 
  Usage         : @params = ('outgroup'=>'X'); 
                  where X is an positive integer not more than the 
                  number of sequences 
		  Defaults to 1

=head2 LOWTRI

  Title		: LOWTRI
  Description   : (optional)
                  This indicates that the distance matrix is 
                  input  in  Lower-triangular form  (the  lower-left 
		  half of the distance matrix only, without the zero 
		  diagonal elements)
  Usage         : @params = ('lowtri'=>'X'); where X is either 1 or 0 
		  Defaults to 0 

=head2 UPPTRI

  Title         : UPPTRI 
  Description   : (optional)
                  This indicates that the distance matrix is input  in  
                  upper-triangular form  (the  upper-right half of the 
		  distance matrix only, without the zero diagonal elements.)
Usage           : @params = ('upptri'=>'X'); where X is either 1 or 0 
                  Defaults to 0 

=head2 SUBREP

  Title         : SUBREP 
  Description   : (optional)
                  This is the Subreplication option.  

		  It informs the program that after each distance will
		  be provided an integer indicating that the distance
		  is a mean of that many replicates.

  Usage         : @params = ('subrep'=>'X'); where X is either 1 or 0 
                  Defaults to 0 

=head2 JUMBLE

  Title        : JUMBLE 
  Description  : (optional)

                 This enables you to tell the program to use a random
                 number generator to choose the input order of
                 species.  seed: an integer between 1 and 32767 and of
                 the form 4n+1 which means that it must give a
                 remainder of 1 when divided by 4.  Each different
                 seed leads to a different sequence of addition of
                 species.  By simply changing the random number seed
                 and re-running programs one can look for other, and
                 better trees.  iterations:

  Usage        : @params = ('jumble'=>'17); where 17 is the random seed
                 Defaults to no jumble

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

=head1 CONTRIBUTORS

Email:jason-at-bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

#'

	
package Bio::Tools::Run::Phylo::Phylip::Neighbor;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    @NEIGHBOR_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::Phylo::Phylip::Base;
use Bio::Tools::Run::Phylo::Phylip::PhylipConf qw(%Menu);

use Cwd;
			    
# inherit from Phylip::Base which has some methods for dealing with
# Phylip specifics
@ISA = qw(Bio::Tools::Run::Phylo::Phylip::Base);

# You will need to enable the neighbor program. This
# can be done in (at least) 3 ways:
#
# 1. define an environmental variable PHYLIPDIR:
# export PHYLIPDIR=/home/shawnh/PHYLIP/bin
#
# 2. include a definition of an environmental variable PHYLIPDIR in
# every script that will use Neighbor.pm.
# $ENV{PHYLIPDIR} = '/home/shawnh/PHYLIP/bin';
#
# 3. You can set the path to the program through doing:
# my @params('program'=>'/usr/local/bin/neighbor');
# my $neighbor_factory = Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);
# 


BEGIN {

    $PROGRAMNAME="neighbor";
    if (defined $ENV{PHYLIPDIR}) {
	$PROGRAMDIR = $ENV{PHYLIPDIR} || '';
	$PROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,
					  $PROGRAMNAME.($^O =~ /mswin/i ?'.exe':''));
    }
    else {
	$PROGRAM = $PROGRAMNAME;
    }
	@NEIGHBOR_PARAMS = qw(TYPE OUTGROUP LOWTRI UPPTRI SUBREP JUMBLE MULTIPLE);
	@OTHER_SWITCHES = qw(QUIET);
	foreach my $attr(@NEIGHBOR_PARAMS,@OTHER_SWITCHES) {
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
  return 'neighbor';
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
	if ($attr =~ /IDLENGTH/i){
		$self->idlength($value);
		next;
	}
	$self->$attr($value);	
    }
    if (! defined $self->idlength){
	$self->idlength(10);
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


=head2 run 

 Title   : run 
 Usage   :
	$inputfilename = 't/data/prot.dist';
	$tree = $neighborfactory->run($inputfilename);
 or
	$protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
	$matrix  = $protdist_factory->create_distance_matrix($aln);
	$tree= $neighborfactory->run($matrix);

 Function: a Bio:Tree from a protein distance matrix created by protidst 
 Example :
 Returns : Bio::Tree 
 Args    : Name of a file containing a protein distance matrix in Phylip format
           or a hash ref to a matrix 

 Throws an exception if argument is not either a string (eg a
 filename) or a Hash. If argument is string, throws exception 
 if file corresponding to string name can not be found. 

=cut

sub run{

    my ($self,$input) = @_;
    my ($temp,$infilename, $seq);
    my ($attr, $value, $switch);
# Create input file pointer
    $infilename = $self->_setinput($input);
    if (!$infilename) {$self->throw("Problems setting up for neighbor. Probably bad input data in $input !");}

# Create parameter string to pass to neighbor program
    my $param_string = $self->_setparams();

# run neighbor
    my @tree = $self->_run($infilename,$param_string);
    return wantarray ? @tree: \@tree;
}

=head2 create_tree

 Title   : create_tree
 Usage   : my $file = $app->create_tree($treefile);
 Function: This method is deprecated. Please use run method. 
 Returns : File containing the rendered tree 
 Args    : either a Bio::Tree::TreeI 
            OR
           filename of a tree in newick format

=cut 

sub create_tree{
  return shift->run(@_);
}


#################################################

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:   makes actual system call to neighbor program
 Example :
 Returns : Bio::Tree object
 Args    : Name of a file containing protein distances in Phylip format 
           and a parameter string to be passed to neighbor

=cut

sub _run {
    my ($self,$infile,$param_string) = @_;
    my $instring;
    my $curpath = cwd;    
    unless( File::Spec->file_name_is_absolute($infile) ) {
	$infile = $self->io->catfile($curpath,$infile);
    }
    $instring =  $infile."\n$param_string";
    $self->debug( "Program ".$self->executable."\n");
    chdir($self->tempdir);
	#open a pipe to run neighbor to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
	open(NEIGHBOR,"|".$self->executable.">/dev/null");
    }
    else {
	open(NEIGHBOR,"|".$self->executable);
    }
    print NEIGHBOR $instring;
    close(NEIGHBOR);	
    chdir($curpath);
    #get the results
    my $outfile = $self->io->catfile($self->tempdir,$self->outfile);
    my $treefile = $self->io->catfile($self->tempdir,$self->treefile);
    
    $self->throw("neighbor did not create tree correctly (expected $treefile) ") unless (-e $treefile);
    my $in  = Bio::TreeIO->new(-file => $treefile, '-format' => 'newick');
    my @tree;
    while (my $tree = $in->next_tree){
        push @tree, $tree;
    }

    # Clean up the temporary files created along the way...
    unless ( $self->save_tempfiles ) { 
	unlink $outfile;
	unlink $treefile;
    }
    return @tree; 
}

=head2  _setinput()

 Title   : _setinput
 Usage   : Internal function, not to be called directly	
 Function: Create input file for neighbor program
 Example :
 Returns : name of file containing the protein distance matrix in Phylip format 
 Args    : name of file created by protdist or ref to hash created by 
           Bio::Tools:Run::Phylo::Phylip::ProtDist 


=cut

sub _setinput {
    my ($self, $input) = @_;
    my ($alnfilename,$infilename, $temp, $tfh,$input_tmp,$input_fh);

    #If $input is not a  filename it better be a HASF reference 

    #  a phy formatted alignment file created by protdist 
    unless (ref $input) {
	# check that file exists or throw
  	$alnfilename= $input;
   	unless (-e $input) {return 0;}
    	return $alnfilename;
    }

    my @input = ref($input) eq "ARRAY" ? @{$input} : ($input);
    ($tfh,$alnfilename) = $self->io->tempfile(-dir=>$self->tempdir);
    my $input_count = 0;
    foreach my $input(@input){
    	if ($input->isa("Bio::Matrix::PhylipDist")){
	     #  Open temporary file for both reading & writing of distance matrix
	     print $tfh $input->print_matrix;
       $input_count++;
	    }
    }
    $self->_input_nbr($input_count);
    close($tfh);
    #get names from the first matrix, to be used in outgroup ordering
    my %names;
    $input = shift @input;
    #set the species names
    my @names = @{$input->names};
    for(my $i=0; $i<= $#names; $i++){
	$names{$names[$i]} = $i+1;
    }
    $self->names(\%names);
    return $alnfilename;		
}

sub _input_nbr {
    my ($self,$val) = @_;
    if($val){
        $self->{'_input_nbr'} = $val;
    }    return $self->{'_input_nbr'};
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
 Function:   Create parameter inputs for neighbor program
 Example :
 Returns : parameter string to be passed to neighbor
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    #do nothing for now
    $self = shift;
    my $param_string = "";
    my $type ="";
    my $version = $self->version;
    my %menu = %{$Menu{$version}->{'NEIGHBOR'}};

    foreach  my $attr ( @NEIGHBOR_PARAMS) {
    	$value = $self->$attr();
    	next unless (defined $value && $value);
  	  if ($attr =~/TYPE/i){
	     if ($value=~/UPGMA/i){
    		$type = "UPGMA";
    		$param_string .= $menu{'TYPE'}{'UPGMA'};
       }
	    }
    	elsif($attr =~ /OUTGROUP/i){
	      if ($type ne "UPGMA"){
          if($value !~/^\d+$/){ # is a name so find the rank 
              my %names = %{$self->names};
              $names{$value} || $self->throw("Outgroup $value not found");
              $value = $names{$value};
          }
      		$param_string .= $menu{'OUTGROUP'}."$value\n";
	      }
	       else {
        		$self->throw("Can't set outgroup using UPGMA. Use Neighbor-Joining instead");
	       }
    	}
	    elsif ($attr =~ /JUMBLE/i){
	     $self->throw("Unallowed value for random seed, need odd number") unless ($value =~ /\d+/ && ($value % 2 == 1));
	     $param_string .=$menu{'JUMBLE'}."$value\n";
	    }
      elsif($attr=~/MULTIPLE/i){
        $param_string.=$menu{'MULTIPLE'}."$value\n";
        #version 3.6 needs a random seed
        if($version eq "3.6"){
            $param_string .= (2 * int(rand(10000)) + 1)."\n";
        }
      }
    	else{
       $param_string .= $menu{uc $attr};
	    }
    } 
   if (($param_string !~ $menu{'MULTIPLE'}) && (defined ($self->_input_nbr) &&($self->_input_nbr > 1))){
  $param_string.=$menu{'MULTIPLE'}.$self->_input_nbr."\n";
    }
 
    $param_string .=$menu{'SUBMIT'};

    return $param_string;
}

=head2 outfile

 Title   : outfile
 Usage   : $obj->outfile($newval)
 Function: Get/Set default PHYLIP outfile name ('outfile' usually)
 Returns : value of outfile
 Args    : newvalue (optional)


=cut


=head2 treefile

 Title   : treefile
 Usage   : $obj->treefile($newval)
 Function: Get/Set the default PHYLIP treefile name ('treefile' usually)
 Returns : value of treefile
 Args    : newvalue (optional)


=cut


1; # Needed to keep compiler happy
