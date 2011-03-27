# $Id $
#
# BioPerl module for Bio::Tools::Run::Phylo::Phylip::DrawGram
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Jason Stajich <jason-AT-bioperl_DOT_org>
#
# Copyright Jason Stajich
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Phylip::DrawGram - use Phylip DrawTree program to draw phylograms or phenograms

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Phylip::DrawGram;

  my $drawfact = Bio::Tools::Run::Phylo::Phylip::DrawGram->new();
  my $treeimage = $drawfact->run($tree);

=head1 DESCRIPTION

This is a module for automating drawing of trees through Joe
Felsenstein's Phylip suite.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

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
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Jason Stajich

Email jason-at-bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::Phylip::DrawGram;
use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    $FONTFILE @DRAW_PARAMS @OTHER_SWITCHES
	    %OK_FIELD %DEFAULT);
use strict;
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
# every script that will use DrawGram.pm.
# $ENV{PHYLIPDIR} = '/home/shawnh/PHYLIP/bin';
#
# 3. You can set the path to the program through doing:
# my @params('program'=>'/usr/local/bin/drawgram');
# my $neighbor_factory = Bio::Tools::Run::Phylo::Phylip::DrawGram->new(@params)

BEGIN {
    %DEFAULT = ('PLOTTER' => 'P',
		'SCREEN'  => 'N');
    $DEFAULT{'FONTFILE'} = Bio::Root::IO->catfile($ENV{'PHYLIPDIR'},"font1") if $ENV{'PHYLIPDIR'};
    $PROGRAMNAME = 'drawgram';

    @DRAW_PARAMS = qw(PLOTTER SCREEN TREESTYLE USEBRANCHLENS
		      LABEL_ANGLE HORIZMARGINS VERTICALMARGINS
		      SCALE TREEDEPTH STEMLEN TIPSPACE ANCESTRALNODES
		      FONT);
    @OTHER_SWITCHES = qw(QUIET);
    foreach my $attr(@DRAW_PARAMS,@OTHER_SWITCHES) {
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
  return $PROGRAMNAME;
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

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Phylip::DrawGram->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Phylip::DrawGram object 
 Returns : an instance of Bio::Tools::Run::Phylo::Phylip::DrawGram
 Args    : The available DrawGram parameters


=cut

sub new {
  my($class,@args) = @_;

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
      $self->$attr($value);
  }
  $self->plotter($DEFAULT{'PLOTTER'}) unless $self->plotter;
  $self->screen($DEFAULT{'SCREEN'}) unless $self->screen;  
  $self->fontfile($DEFAULT{'FONTFILE'}) unless $self->fontfile;
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

=head2 run

 Title   : run
 Usage   : my $file = $app->run($treefile);
 Function: Draw a tree
 Returns : File containing the rendered tree 
 Args    : either a Bio::Tree::TreeI 
            OR
           filename of a tree in newick format

=cut

sub run{
   my ($self,$input) = @_;
   
   # Create input file pointer
   my ($infilename) = $self->_setinput($input);
    if (!$infilename) {
	$self->throw("Problems setting up for drawgram. Probably bad input data in $input !");
    }

    # Create parameter string to pass to neighbor program
    my $param_string = $self->_setparams();

    # run drawgram
    my $plotfile = $self->_run($infilename,$param_string);
    return $plotfile;
}

=head2 draw_tree

 Title   : draw_tree
 Usage   : my $file = $app->draw_tree($treefile);
 Function: This method is deprecated. Please use run instead. 
 Returns : File containing the rendered tree 
 Args    : either a Bio::Tree::TreeI 
            OR
           filename of a tree in newick format

=cut

sub draw_tree{
  return shift->run(@_);
}

=head2  _run

 Title   :  _run
 Usage   :  Internal function, not to be called directly	
 Function:  makes actual system call to drawgram program
 Example :
 Returns : Bio::Tree object
 Args    : Name of a file the tree to draw in newick format 
           and a parameter string to be passed to drawgram


=cut

sub _run {
    my ($self,$infile,$param_string) = @_;    
    my $instring;
    my $curpath = cwd;
    unless( File::Spec->file_name_is_absolute($infile) ) {
	$infile = $self->io->catfile($curpath,$infile);
    }
    $instring = $infile . "\n";
    if( ! defined $self->fontfile ) { 
	$self->throw("You must have defined a fontfile");
    }

    if( -e $self->io->catfile($curpath,'fontfile') ) {
	$instring .= $self->io->catfile($curpath,'fontfile')."\n";
    } elsif( File::Spec->file_name_is_absolute($self->fontfile) ) {	 
	$instring .= $self->io->catfile($self->fontfile)."\n";
    } else {
	$instring .= $self->io->catfile($curpath,$self->fontfile)."\n";
    }    
    
    chdir($self->tempdir);
    $instring .= $param_string;
    $self->debug( "Program ".$self->executable." $param_string\n");
    # open a pipe to run drawgram to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
	open(DRAW,"|".$self->executable.">/dev/null");
    }
    else {
	open(DRAW,"|".$self->executable);
    }
    print DRAW $instring;
    close(DRAW);	
    chdir($curpath);
    #get the results
    my $plotfile = $self->io->catfile($self->tempdir,$self->plotfile);
    
    $self->throw("drawgram did not create plotfile correctly ($plotfile)")
	unless (-e $plotfile);    		
    return $plotfile;
}

=head2  _setinput()

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:  Create input file for drawing program
 Example :
 Returns : filename containing tree in newick format
 Args    : Bio::Tree::TreeI object


=cut

sub _setinput {
    my ($self, $input) = @_;
    my $treefile;
    unless (ref $input) {
        # check that file exists or throw
        $treefile = $input;
        unless (-e $input) {return 0;}
	
    } elsif ($input->isa("Bio::Tree::TreeI")) {
        #  Open temporary file for both reading & writing of BioSeq array
	my $tfh;
	($tfh,$treefile) = $self->io->tempfile(-dir=>$self->tempdir);
	my $treeIO = Bio::TreeIO->new(-fh    => $tfh, 
				      -format=>'newick');
	$treeIO->write_tree($input);
	$treeIO->close();
	close($tfh);
	$tfh = undef;
    }
    return $treefile;
}

=head2  _setparams()

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:   Create parameter inputs for drawgram program
 Example :
 Returns : parameter string to be passed to drawgram
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    #do nothing for now
    $self = shift;
    my $param_string = "";
    my $cat = 0;
    my ($hmargin,$vmargin);
    my %menu = %{$Menu{$self->version}->{'DRAWGRAM'}};
    foreach  my $attr ( @DRAW_PARAMS) {	
	$value = $self->$attr();
	next unless defined $value;
	my @vals;
	if( ref($value) ) {
	    ($value,@vals) = @$value;
	}
	$attr = uc($attr);
	if( ! exists $menu{$attr} ) {
	    $self->warn("unknown parameter $attr, known params are ". 
			join(",",keys %menu). "\n");
	}	
	if( ref ($menu{$attr}) !~ /HASH/i ) {
	    unless( @vals ) {
		$param_string .= $menu{$attr};
	    } else { 
		$param_string .= sprintf($menu{$attr},$value,@vals);
	    }
	    next;
	}
	my $seen = 0;
	for my $stype ( keys %{$menu{$attr}} ) {	    
	    if( $value =~ /$stype/i ) {		
		$param_string .= sprintf($menu{$attr}->{$stype},@vals);	    
		$seen = 1;
		last;
	    }		
	}
	unless( $seen ) {
	    $self->warn("Unknown requested attribute $attr, $value is not known\n");
	}
    }
    $param_string .="Y\n";	
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
 Usage   : my $outfile = $dragram->outfile_name();
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
 Function: Will cleanup the tempdir directory after a DrawGram run
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
