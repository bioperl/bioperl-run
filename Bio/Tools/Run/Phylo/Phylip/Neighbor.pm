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

=head1 SYNOPSIS

  #Create a SimpleAlign object
  @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
  $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
  $inputfilename = 't/data/cysprot.fa';
  $aln = $factory->align($inputfilename); # $aln is a SimpleAlign object.

  # Create the Distance Matrix
  # using a default PAM matrix and id name lengths limit of 30 note to
  # use id name length greater than the standard 10 in neighbor, you
  # will need to modify the neighbor source code

  $protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
  my $matrix  = $protdist_factory->create_distance_matrix($aln);

  #Create the tree passing in the distance matrix
  @params = ('type'=>'NJ','outgroup'=>2,'lowtri'=>1,
             'upptri'=>1,'subrep'=>1,'subrep'=>1);

  my $neighbor_factory = 
     Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);
  my $tree = $neighbor_factory->create_tree($matrix);

  # Alternatively, one can create the tree by passing in a file name 
  # containing a phylip formatted distance matrix(using protdist)
  my $neighbor_factory = 
     Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);
  my $tree = $neighbor_factory->create_tree('/home/shawnh/prot.dist');

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

  bioperl-l@bioperl.org                     - General discussion
  http://bio.perl.org/MailList.html         - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
 the bugs and their resolution.  Bug reports can be submitted via
 email or the web:

  bioperl-bugs@bio.perl.org
  http://bio.perl.org/bioperl-bugs/

=head1 AUTHOR - Shawn Hoon 

Email shawnh@fugu-sg.org 

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

#'

	
package Bio::Tools::Run::Phylo::Phylip::Neighbor;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    $TMPDIR $TMPOUTFILE @NEIGHBOR_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Root::IO;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

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
	@NEIGHBOR_PARAMS = qw(TYPE OUTGROUP LOWTRI UPPTRI SUBREP JUMBLE);
	@OTHER_SWITCHES = qw(QUIET);
	foreach my $attr(@NEIGHBOR_PARAMS,@OTHER_SWITCHES) {
		$OK_FIELD{$attr}++;
	}
}

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    # to facilitiate tempfile cleanup
    $self->io->_initialize_io();

    my ($attr, $value);
    ($TMPDIR) = $self->io->tempdir(CLEANUP=>1);
    (undef,$TMPOUTFILE) = $self->io->tempfile(-dir => $TMPDIR);
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


=head2 create_tree 

 Title   : create_tree 
 Usage   :
	$inputfilename = 't/data/prot.dist';
	$tree = $neighborfactory->create_tree($inputfilename);
or
	$protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
	$matrix  = $protdist_factory->create_distance_matrix($aln);
	$tree= $neighborfactory->create_tree($matrix);

 Function: a Bio:Tree from a protein distance matrix created by protidst 
 Example :
 Returns : Bio::Tree 
 Args    : Name of a file containing a protein distance matrix in Phylip format
           or a hash ref to a matrix 

 Throws an exception if argument is not either a string (eg a
 filename) or a Hash. If argument is string, throws exception 
 if file corresponding to string name can not be found. 

=cut

sub create_tree{

    my ($self,$input) = @_;
    my ($temp,$infilename, $seq);
    my ($attr, $value, $switch);
# Create input file pointer
    $infilename = $self->_setinput($input);
    if (!$infilename) {$self->throw("Problems setting up for neighbor. Probably bad input data in $input !");}

# Create parameter string to pass to neighbor program
    my $param_string = $self->_setparams();

# run neighbor
    my $tree = $self->_run($infilename,$param_string);
    return $tree;
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
    $instring =  $infile."\n$param_string";
    $self->debug( "Program ".$self->executable."\n");

	#open a pipe to run neighbor to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
	open(NEIGHBOR,"|".$self->executable.">/dev/null");
    }
    else {
	open(NEIGHBOR,"|".$self->executable);
    }
    print NEIGHBOR $instring;
    close(NEIGHBOR);	

	#get the results
    my $path = `pwd`;
    chomp($path);
    my $outfile = $path."/outfile";
    my $treefile = $path."/treefile";
    
    $self->throw("neighbor did not create tree correctly (expected $treefile) ") unless (-e $treefile);
    my $in  = Bio::TreeIO->new(-file => $treefile, '-format' => 'newick');
    my $tree = $in->next_tree();

    # Clean up the temporary files created along the way...
    unlink $outfile;
    unlink $treefile;
    return $tree; 
}

=head2 executable

 Title   : executable
 Usage   : my $exe = $neighbor->executable();
 Function: Finds the full path to the 'genscan' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to
           [optional] boolean flag whether or not warn when exe is not found


=cut

sub executable{
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

    #  $input may be a hash ref to a distance matrix
    if (ref($input) eq "HASH") {
        #  Open temporary file for both reading & writing of distance matrix
	($tfh,$alnfilename) = $self->io->tempfile(-dir=>$TMPDIR);
	my $num_species = scalar(keys %{$input});
	print $tfh "   $num_species\n";
	foreach my $key (keys %{$input}){
		print $tfh $key.(" " x int($self->idlength/2));#neighbor requires at least this amount of space 
	        foreach my $k (keys %{$input->{$key}}){
			print $tfh $input->{$key}{$k}."  ";
       		}
		print $tfh "\n";
	}
	return $alnfilename;		
    }
    return 0;
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
	foreach  my $attr ( @NEIGHBOR_PARAMS) {
        	$value = $self->$attr();
	        next unless (defined $value);
      		if ($attr =~/TYPE/i){
			if ($value=~/UPGMA/i){
				$type = "UPGMA";
				$param_string .= "N\n";
			}
		}
		elsif($attr =~ /OUTGROUP/i){
			if ($type ne "UPGMA"){
				$self->throw("Unallowed value for outgroup") unless ($value =~ /\d+/);
				$param_string .= "O\n$value\n";
			}
			else {
				$self->throw("Can't set outgroup using UPGMA. Use Neighbor-Joining instead");
			}
		}
		elsif ($attr =~ /LOWTRI/i){
			$param_string .="L\n";
		}
		elsif ($attr =~ /UPPTRI/i){
			$param_string .="R\n";
		}
		elsif ($attr =~ /SUBREP/i){
			$param_string .="S\n";
		}
		elsif ($attr =~ /JUMBLE/i){
			$self->throw("Unallowed value for random seed") unless ($value =~ /\d+/);
			$param_string .="J\n$value\n";
		}
		else{}
	} 
    $param_string .="Y\n";

    return $param_string;
}

1; # Needed to keep compiler happy
