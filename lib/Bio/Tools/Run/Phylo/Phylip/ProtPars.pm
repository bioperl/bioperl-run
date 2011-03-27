# $Id$
# BioPerl module for Bio::Tools::Run::Phylo::Phylip::ProtPars
#
# Created by Shawn Hoon 
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME 

Bio::Tools::Run::Phylo::Phylip::ProtPars - Object for creating a L<Bio::Tree> object from a multiple alignment file or a SimpleAlign object

14 Nov 2002 Shawn
Works with Phylip version 3.6

=head1 SYNOPSIS

  #Create a SimpleAlign object
  @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
  $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
  $inputfilename = 't/data/cysprot.fa';
  $aln = $factory->run($inputfilename); # $aln is a SimpleAlign object.

  #Create the Tree
  #using a threshold value of 30 and id name lengths limit of 30
  #note to use id name length greater than the standard 10 in protpars, 
  # you will need to modify the protpars source code
  $tree_factory = Bio::Tools::Run::Phylo::Phylip::ProtPars->
     new(idlength=>30,threshold=>10,jumble=>"17,10",outgroup=>2);
  $tree = $tree_factory->run($aln);

  #Or one can pass in a file name containing a multiple alignment 
  #in phylip format:

  $tree_factory =
    Bio::Tools::Run::Phylo::Phylip::ProtPars->new(idlength=>30,threshold=>10);
  $tree = $tree_factory->run("/usr/users/shawnh/COMPARA/prot.phy");

  # To prevent PHYLIP from truncating sequence names:
  # Step 1. Shelf the original names:
     my ($aln_safe, $ref_name)=                    #   $aln_safe has serial names
                $aln->set_displayname_safe();      #   $ref_name holds original names
  # Step 2. Run ProtPars:
     $tree = $protpars_factory->run($aln_safe);    #  Use $aln_safe instead of $aln
  # Step 3. Retrieve orgininal OTU names:
     use Bio::Tree::Tree;
     my @nodes=$tree->get_nodes();
         foreach my $nd (@nodes){
            $nd->id($ref_name->{$nd->id_output}) if $nd->is_Leaf;
         }

=head1 PARAMTERS FOR PROTPARS COMPUTATION

=head2 THRESHOLD

Title 		: THRESHOLD
Description	: (optional)
                  This sets a threshold such that if the number of
                  steps counted in a character is higher than the
                  threshold, it will be taken to be the threshold
                  value rather than the actual number of steps.  You
                  should use a positive real number greater than 1.
                  Please see the documetation from the phylip package
                  for more information.

=head2 OUTGROUP

Title		: OUTGROUP
Description	: (optional)

                  This specifies which species is to be used to root
                  the tree by having it become the outgroup.  Input
                  values are integers specifying which species to use.
                  Defaults to 1

=head2 JUMBLE

Title		: JUMBLE
Description     : (optional)
                  This enables you to tell the program to use a random
                  number generator to choose the input order of
                  species.  Input values is of the format:
                  seed,iterations eg 17,10 seed: an integer between 1
                  and 32767 and of the form 4n+1 which means that it
                  must give a remainder of 1 when divided by 4.  Each
                  different seed leads to a different sequence of
                  addition of species.  By simply changing the random
                  number seed and re-running programs one can look for
                  other, and better trees.  iterations: For a value of
                  10, this will tell the program to try ten different
                  orders of species in constructing the trees, and the
                  results printed out will reflect this entire search
                  process (that is, the best trees found among all 10
                  runs will be printed out, not the best trees from
                  each individual run).

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

Email jason-AT-bioperl_DOT_org


=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut


	
package Bio::Tools::Run::Phylo::Phylip::ProtPars;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    @PROTPARS_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Cwd;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::Phylo::Phylip::Base;
use Bio::Tools::Run::Phylo::Phylip::PhylipConf qw(%Menu);

@ISA = qw(Bio::Tools::Run::Phylo::Phylip::Base);

# You will need to enable the protpars program. This
# can be done in (at least) two ways:
#
# 1. define an environmental variable PHYLIPDIR:
# export PHYLIPDIR=/home/shawnh/PHYLIP/bin
#
# 2. include a definition of an environmental variable CLUSTALDIR in
# every script that will use Clustal.pm.
# $ENV{PHYLIPDIR} = '/home/shawnh/PHYLIP/bin';
#
# 3. You can set the path to the program through doing:
# my @params('program'=>'/usr/local/bin/protdist');
# my $protpars_factory = Bio::Tools::Run::Phylo::Phylip::ProtPars->new(@params);
# 


BEGIN {
    @PROTPARS_PARAMS = qw(THRESHOLD JUMBLE OUTGROUP);
    @OTHER_SWITCHES = qw(QUIET);
    foreach my $attr(@PROTPARS_PARAMS,@OTHER_SWITCHES) {
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
            return 'protpars';
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
	$tree = $factory->run($inputfilename);
or
	$seq_array_ref = \@seq_array; @seq_array is array of Seq objs
	$aln = $factory->run($seq_array_ref);
	$tree = $treefactory->run($aln);
 Function: Create a protpars tree from a SimpleAlign object 
 Example :
 Returns : L<Bio::Tree> object 
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
    if (!$infilename) {$self->throw("Problems setting up for protpars. Probably bad input data in $input !");}

# Create parameter string to pass to protpars program
    my $param_string = $self->_setparams();

# run protpars
    my $aln = $self->_run($infilename,$param_string);
}

=head2  create_tree 

 Title   : create_tree 
 Usage   :
  $inputfilename = 't/data/prot.phy';
  $tree = $factory->create_tree($inputfilename);
or
  $seq_array_ref = \@seq_array; @seq_array is array of Seq objs
  $aln = $factory->align($seq_array_ref);
  $tree = $treefactory->create_tree($aln);
 Function: Create a protpars tree from a SimpleAlign object 
 Example :
 Returns : L<Bio::Tree> object 
 Args    : Name of a file containing a multiple alignment in Phylip format
           or an SimpleAlign object 

 Throws an exception if argument is not either a string (eg a
 filename) or a Bio::SimpleAlign object. If
 argument is string, throws exception if file corresponding to string
 name can not be found. 

=cut

sub create_tree{
  return shift->run(@_);
}

#################################################

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:   makes actual system call to protpars program
 Example :
 Returns : Bio::Tree object
 Args    : Name of a file containing a set of multiple alignments 
           in Phylip format and a parameter string to be passed to protpars


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
    #open a pipe to run protpars to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
    	open(PROTPARS,"|".$self->executable.">/dev/null");
    }
    else {
    	open(PROTPARS,"|".$self->executable);
    }
    print PROTPARS $instring;
    close(PROTPARS);	
    chdir($curpath);
    #get the results
    my $outfile = $self->io->catfile($self->tempdir,$self->outfile);
    my $treefile = $self->io->catfile($self->tempdir,$self->treefile);
    
    $self->throw("Protpars did not create treefile correctly") 
  	unless (-e $treefile);

    #create the tree
    my $in  = Bio::TreeIO->new(-file => $treefile, '-format' => 'newick');
    my $tree = $in->next_tree();

    unless ( $self->save_tempfiles ) {
	# Clean up the temporary files created along the way...	
	unlink $treefile;
	unlink $outfile;
    }	
    return $tree;
}


=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:   Create input file for protpars program
 Example :
 Returns : name of file containing a multiple alignment in Phylip format 
 Args    : SimpleAlign object reference or input file name


=cut

sub _setinput {
    my ($self, $input, $suffix) = @_;
    my ($alnfilename,$infilename, $temp, $tfh,$input_tmp,$input_fh);

    # If $input is not a  reference it better be the name of a
    # file with the sequence/

    #  a phy formatted alignment file 
    unless (ref $input) {
        # check that file exists or throw
        $alnfilename= $input;
        unless (-e $input) {return 0;}
	return $alnfilename;
    }

    #  $input may be a SimpleAlign Object
    if ($input->isa("Bio::Align::AlignI")) {
        #  Open temporary file for both reading & writing of BioSeq array
	($tfh,$alnfilename) = $self->io->tempfile(-dir=>$self->tempdir);
	my $alnIO = Bio::AlignIO->new(-fh => $tfh, -format=>'phylip',idlength=>$self->idlength());
	$alnIO->write_aln($input);
	$alnIO->close();
	close($tfh);
	$tfh = undef;
	return $alnfilename;		
    }
    return 0;
}

=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:   Create parameter inputs for protpars program
 Example :
 Returns : parameter string to be passed to protpars
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;
    my $param_string = "";
    
    my %menu = %{$Menu{$self->version}->{'PROTPARS'}};

    for $attr ( @PROTPARS_PARAMS) {
        $value = $self->$attr();
        next unless (defined $value);
	      if ($attr =~/JUMBLE/i){
      		my ($seed,$itr) = split(",",$value);
      		$param_string .=$menu{'JUMBLE'}."$seed\n$itr\n";
      	}
        else {
          $param_string .= $menu{uc $attr}."$value\n";
        }
    } 
    $param_string .="Y\n";

    return $param_string;
}

1; # Needed to keep compiler happy
