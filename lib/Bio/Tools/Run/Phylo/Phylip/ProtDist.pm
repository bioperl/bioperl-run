# BioPerl module for Bio::Tools::Run::Phylo::Phylip::ProtDist
#
# Created by
#
# Shawn Hoon 
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME 

Bio::Tools::Run::Phylo::Phylip::ProtDist - Wrapper for the phylip
program protdist

=head1 SYNOPSIS

  #Create a SimpleAlign object
  @params = ('ktuple' => 2, 'matrix' => 'BLOSUM');
  $factory = Bio::Tools::Run::Alignment::Clustalw->new(@params);
  $inputfilename = 't/data/cysprot.fa';
  $aln = $factory->run($inputfilename); # $aln is a SimpleAlign object.


  # Create the Distance Matrix using a default PAM matrix and id name
  # lengths limit of 30 note to use id name length greater than the
  # standard 10 in protdist, you will need to modify the protdist source
  # code

  @params = ('MODEL' => 'PAM');
  $protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);

  my ($matrix)  = $protdist_factory->run($aln); # an array of Bio::Matrix::PhylipDist matrix

  #finding the distance between two sequences
  my $distance = $matrix->get_entry('protein_name_1','protein_name_2');
  my @column   = $matrix->get_column('protein_name_1');
  my @row      = $martrix->get_row('protein_name_1');
  my @diag     = $matrix->get_diagonal();
  print $matrix->print_matrix;


  #Alternatively, one can create the matrix by passing in a file 
  #name containing a multiple alignment in phylip format
  $protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
  my ($matrix)  = $protdist_factory->run('/home/shawnh/prot.phy');

  # To prevent PHYLIP from truncating sequence names:
  # Step 1. Shelf the original names:
    my ($aln_safe, $ref_name)=                    #   $aln_safe has serial names
               $aln->set_displayname_safe();      #   $ref_name holds original names
  # Step 2. Run ProtDist and Neighbor:
    ($matrix) = $protdist_factory->
               create_distance_matrix($aln_safe); #  Use $aln_safe instead of $aln
    ($tree) = $neighbor_factory->run($matrix);
  # Step 3. Retrieve orgininal OTU names:
    use Bio::Tree::Tree;
    my @nodes=$tree->get_nodes();
    foreach my $nd (@nodes){
       $nd->id($ref_name->{$nd->id_output}) if $nd->is_Leaf;
    }

=head1 DESCRIPTION

Wrapper for protdist Joseph Felsentein for creating a distance matrix
comparing protein sequences from a multiple alignment file or a
L<Bio::SimpleAlign> object and returns a L<Bio::Matrix::PhylipDist> object;

VERSION Support

This wrapper currently supports v3.5 of phylip. There is also support
for v3.6.

=head1 PARAMETERS FOR PROTDIST COMPUTATION

=head2 MODEL

Title		: MODEL
Description	: (optional)

                  This sets the model of amino acid substitution used
 		  in the calculation of the distances.  3 different
 		  models are supported: 
                  PAM     Dayhoff PAM Matrix(default) 
                  KIMURA  Kimura's Distance CAT

                  Categories Distance Usage: @params =
 		  ('model'=>'X');#where X is one of the values above

                  Defaults to PAM For more information on the usage of
 		  the different models, please refer to the
 		  documentation 
                  defaults to Equal
 		  (0.25,0.25,0.25,0.25) found in the phylip package.

                  Additional models in PHYLIP 3.6
                  PMB - Henikoff/Tillier PMB matrix
	          JTT - Jones/Taylor/Thornton

=head2 MULTIPLE

Title    : MULTIPLE
Description: (optional)

          This allows multiple distance matrices to be generated from multiple
          MSA.

          Usage: @params = ('MULTIPLE'=>100) where the value specifyies the 
          number of aligments given.

=head2 ALL SUBSEQUENT PARAMETERS WILL ONLY WORK IN CONJUNCTION WITH

THE Categories Distance MODEL*

=head2 GENCODE

  Title		: GENCODE 
  Description	: (optional)

                  This option allows the user to select among various
                  nuclear and mitochondrial genetic codes.

		  Acceptable Values:
		  U           Universal
   		  M           Mitochondrial
		  V           Vertebrate mitochondrial
		  F           Fly mitochondrial
		  Y           Yeast mitochondrial
  Usage         : @params = ('gencode'=>'X'); 
                  where X is one of the letters above
		  Defaults to U

=head2 CATEGORY

Title		: CATEGORY 
Description     : (optional)

                  This option sets the categorization of amino acids
		  all have groups: (Glu Gln Asp Asn), (Lys Arg His),
                  (Phe Tyr Trp)  plus:
		  G   George/Hunt/Barker:
                          (Cys), (Met   Val  Leu  Ileu), 
                          (Gly  Ala  Ser  Thr  Pro)
		  C   Chemical:
                          (Cys   Met), (Val  Leu  Ileu  Gly  Ala  Ser  Thr),
                          (Pro)
		  H   Hall:
                        (Cys), (Met   Val  Leu  Ileu), (Gly  Ala  Ser  Thr),
                        (Pro)

  Usage         : @params = ('category'=>'X'); 
                  where X is one of the letters above
		  Defaults to G

=head2 PROBCHANGE

  Title       : PROBCHANGE
  Description : (optional)
                 This option sets the ease of changing category of amino
                 acid.  (1.0 if no difficulty of changing,less if less
                 easy. Can't be negative)

  Usage       : @params = ('probchange'=>X) where 0<=X<=1
	        Defaults to 0.4570

=head2 TRANS 

  Title       : TRANS
  Description : (optional)
                This option sets transition/transversion ratio can be
                any positive number

  Usage        : @params = ('trans'=>X) where X >= 0
                 Defaults to 2

=head2 FREQ

  Title       : FREQ 
  Description : (optional)
                This option sets the frequency of each base (A,C,G,T)
		The sum of the frequency must sum to 1.
		For example A,C,G,T = (0.25,0.5,0.125,0.125) 

  Usage       : @params = ('freq'=>('W','X','Y','Z')
                where W + X + Y + Z = 1
		Defaults to Equal (0.25,0.25,0.25,0.25)


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

	
package Bio::Tools::Run::Phylo::Phylip::ProtDist;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    @PROTDIST_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Phylip::Base;
use Bio::Tools::Run::Phylo::Phylip::PhylipConf qw(%Menu);
use Bio::Tools::Phylo::Phylip::ProtDist;
use Cwd;


# inherit from Phylip::Base which has some methods for dealing with
# Phylip specifics
@ISA = qw(Bio::Tools::Run::Phylo::Phylip::Base);

# You will need to enable the protdist program. This
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
# my @params('program'=>'/usr/local/bin/protdist');
# my $protdist_factory = Bio::Tools::Run::Phylo::Phylip::ProtDist->new(@params);
# 


BEGIN {
	@PROTDIST_PARAMS = qw(MODEL GENCODE CATEGORY PROBCHANGE TRANS WEIGHTS FREQ MULTIPLE);
	@OTHER_SWITCHES = qw(QUIET);
	foreach my $attr(@PROTDIST_PARAMS,@OTHER_SWITCHES) {
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
  return 'protdist';
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
        $matrix= $prodistfactory->run($inputfilename);
or
        $seq_array_ref = \@seq_array; @seq_array is array of Seq objs
        $aln = $protdistfactory->align($seq_array_ref);
        $matrix = $protdistfactory->run($aln);

 Function: Create a distance matrix from a SimpleAlign object or a multiple alignment file 
 Example :
 Returns : L<Bio::Matrix::PhylipDist>
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
   if (!$infilename) {$self->throw("Problems setting up for protdist. Probably bad input data in $input !");}
    # Create parameter string to pass to protdist program
    my $param_string = $self->_setparams();
   # run protdist
    my @mat = $self->_run($infilename,$param_string);
    return  wantarray ? @mat:\@mat;
}

#################################################

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to protdist program
 Example :
 Returns : Bio::Tree object
 Args    : Name of a file containing a set of multiple alignments in Phylip format 
           and a parameter string to be passed to protdist


=cut

sub _run {
    my ($self,$infile,$param_string) = @_;
    my $instring;
    my $curpath = cwd;    
    unless( File::Spec->file_name_is_absolute($infile) ) {
	$infile = $self->io->catfile($curpath,$infile);
    }
    $instring =  $infile."\n$param_string";
    $self->debug( "Program ".$self->executable." $instring\n");
    
    chdir($self->tempdir);
    #open a pipe to run protdist to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
	open(PROTDIST,"|".$self->executable .">/dev/null");
    }
    else {
	open(PROTDIST,"|".$self->executable);
    }
    print PROTDIST $instring;
    close(PROTDIST);	
    
    # get the results
    my $outfile = $self->io->catfile($self->tempdir,$self->outfile);
    chdir($curpath);
    $self->throw("protdist did not create matrix correctly ($outfile)")
	unless (-e $outfile);

	#Create the distance matrix here
    my $parser = Bio::Tools::Phylo::Phylip::ProtDist->new(-file=>$outfile);
    my @matrix;
    while (my $mat = $parser->next_matrix){
        push @matrix, $mat;
    }

    # Clean up the temporary files created along the way...
    unlink $outfile unless $self->save_tempfiles;
	
    return @matrix;
}

=head2 create_distance_matrix

 Title   : create_distance_matrix
 Usage   : my $file = $app->create_distance_matrix($treefile);
 Function: This method is deprecated. Please use run method. 
 Returns : L<Bio::Matrix::PhylipDist>
 Args    : Name of a file containing a multiple alignment in Phylip format
           or an SimpleAlign object 

 Throws an exception if argument is not either a string (eg a
 filename) or a Bio::SimpleAlign object. If
 argument is string, throws exception if file corresponding to string
 name can not be found. 

=cut 

sub create_distance_matrix{
  return shift->run(@_);
}

=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:   Create input file for protdist program
 Example :
 Returns : name of file containing a multiple alignment in Phylip format 
 Args    : SimpleAlign object reference or input file name


=cut

sub _setinput {
    my ($self, $input) = @_;
    my ($alnfilename,$tfh);

    # suffix is used to distinguish alignment files  from an align obkect
	#If $input is not a  reference it better be the name of a file with the sequence/

    #  a phy formatted alignment file 
  	unless (ref $input) {
        # check that file exists or throw
        $alnfilename= $input;
        unless (-e $input) {return 0;}
		return $alnfilename;
    }
    my @input = ref $input eq 'ARRAY' ? @{$input} : ($input);

    #  $input may be a SimpleAlign Object
   ($tfh,$alnfilename) = $self->io->tempfile(-dir=>$self->tempdir);
    my $alnIO = Bio::AlignIO->new(-fh => $tfh, 
				  -format=>'phylip',
				  -idlength=>$self->idlength());
    my $input_count = 0;
    foreach my $input(@input){
	if ($input->isa("Bio::SimpleAlign")){
	    #  Open temporary file for both reading & writing of BioSeq array
	    $alnIO->write_aln($input);
	}
	$input_count++;
    }
    $alnIO->close();
    close($tfh);
    $tfh = undef;
    $self->_input_nbr($input_count); 
    return $alnfilename;		
}

sub _input_nbr {
    my ($self,$val) = @_;
    if($val){
        $self->{'_input_nbr'} = $val;
    }
    return $self->{'_input_nbr'};
}

=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:   Create parameter inputs for protdist program
 Example :
 Returns : parameter string to be passed to protdist
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    #do nothing for now
    $self = shift;
    my $param_string = "";
    my $cat = 0;
    my %menu = %{$Menu{$self->version}->{'PROTDIST'}};

    foreach  my $attr ( @PROTDIST_PARAMS) {
    	$value = $self->$attr();
    	next unless (defined $value);
    	if ($attr =~/MODEL/i){
	    if ($value=~/CAT/i){
		$cat = 1;
	    }
	    $param_string .= $menu{'MODEL'}{$value};
	}
	if($attr=~/MULTIPLE/i){
	    $param_string.=$menu{'MULTIPLE'}."$value\n";
	}
  	if ($cat == 1){
	    if($attr =~ /GENCODE/i){		
		my $allowed = $menu{'GENCODE'}{'ALLOWED'};
    		$self->throw("Unallowed value for genetic code") unless ($value =~ /[$allowed]/);
		$param_string .= $menu{'GENCODE'}{'OPTION'}."$value\n";
	    }
	    if ($attr =~/CATEGORY/i){
		my $allowed = $menu{'CATEGORY'}{'ALLOWED'};
    		$self->throw("Unallowed value for categorization of amino acids") unless ($value =~/[$allowed]/);
	    	$param_string .= $menu{'CATEGORY'}{'OPTION'}."$value\n";
	    }
	    if ($attr =~/PROBCHANGE/i){
    		if (($value =~ /\d+/)&&($value >= 0) && ($value < 1)){
		    $param_string .= $menu{'PROBCHANGE'}."$value\n";
		}
    		else {
	  	    $self->throw("Unallowed value for probability change category");  
		}
	    }
	    if ($attr =~/TRANS/i){
    		if (($value=~/\d+/) && ($value >=0)){
	  	    $param_string .=$menu{'TRANS'}."$value\n";
	    	}
	    }
	    if ($attr =~ /FREQ/i){
    		my @freq = split(",",$value);	
    		if ($freq[0] !~ /\d+/){	#a letter provided (sets frequencies equally to 0.25)
		    $param_string .=$menu{'FREQ'}.$freq[0]."\n";
	    	}
    		elsif ($#freq ==  3) {#must have 4 digits for each base
					  $param_string .=$menu{'FREQ'};
					  foreach my $f (@freq){
					      $param_string.="$f\n";
					  }
				      }
		else {
		    $self->throw("Unallowed value for base frequencies");
		}
	    }
	}
    } 
    #set multiple option is not set and there are more than one sequence
    if (($param_string !~ $menu{'MULTIPLE'}) && (defined ($self->_input_nbr) &&($self->_input_nbr > 1))){
	$param_string.=$menu{'MULTIPLE'}.$self->_input_nbr."\n";
    }
    $param_string .=$menu{'SUBMIT'};

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
 Usage   : my $outfile = $protdist->outfile_name();
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
 Function: Will cleanup the tempdir directory after a ProtDist run
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
