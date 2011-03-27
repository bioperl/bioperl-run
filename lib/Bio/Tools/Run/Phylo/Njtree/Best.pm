# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Njtree::Best
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Albert Vilella <avilella-at-gmail-dot-com>
#
# Copyright Albert Vilella
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Njtree::Best - Wrapper around the Njtree (Njtree/phyml) best program.

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Njtree::Best;
  use Bio::AlignIO;
  use Bio::TreeIO;

  my $alignio = Bio::AlignIO->new(-format => 'fasta',
  			         -file   => 't/data/njtree_aln2.nucl.mfa');

  my $aln = $alignio->next_aln;

  my $treeio = Bio::TreeIO->new(
      -format => 'nhx', -file => 't/data/species_tree_njtree.nh');

  my $tree = $treeio->next_tree;

  my $njtree_best = Bio::Tools::Run::Phylo::Njtree::Best->new();
  $njtree_best->alignment($aln);
  $njtree_best->tree($tree);
  my $nhx_tree = $njtree_best->run();

=head1 DESCRIPTION

This is a wrapper around the best program of Njtree by Li Heng.  See
http://treesoft.sourceforge.net/njtree.shtml for more information.

Wrapper for the calculation of a reconciled phylogenetic tree with
inferred duplication tags from amultiple sequence alignment and a
species tree using NJTREE.

=head2 Helping the module find your executable 

You will need to enable NJTREEDIR to find the njtree program. This can be
done in (at least) three ways:

  1. Make sure the njtree executable is in your path (i.e. 
     'which njtree' returns a valid program
  2. define an environmental variable NJTREEDIR which points to a 
     directory containing the 'njtree' app:
   In bash 
	export NJTREEDIR=/home/progs/treesoft/njtree   or
   In csh/tcsh
        setenv NJTREEDIR /home/progs/treesoft/njtree

  3. include a definition of an environmental variable NJTREEDIR 
      in every script that will
     BEGIN {$ENV{NJTREEDIR} = '/home/progs/treesoft/njtree'; }
     use Bio::Tools::Run::Phylo::Njtree::Best;

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
the bugs and their resolution.  Bug reports can be submitted via the web:

 http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR -  Albert Vilella

Email avilella-at-gmail-dot-com

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phylo::Njtree::Best;

use vars qw($AUTOLOAD @ISA $PROGRAMNAME $PROGRAM 
            @NJTREE_BEST_PARAMS @NJTREE_BEST_SWITCHES %OK_FIELD);

use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

BEGIN { 
    
    @NJTREE_BEST_PARAMS = qw(C p F c k a d l L b);
    @NJTREE_BEST_SWITCHES = qw(P S A r D s g N);
# Authorize attribute fields
    foreach my $attr ( @NJTREE_BEST_PARAMS, @NJTREE_BEST_SWITCHES ) {
	$OK_FIELD{$attr}++; }

}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'njtree';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{NJTREEDIR}) if $ENV{NJTREEDIR};
}


=head2 new

 Title   : new
 Usage   : my $njtree_best = Bio::Tools::Run::Phylo::Njtree::Best->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Njtree::Best
 Returns : Bio::Tools::Run::Phylo::Njtree::Best
 Args    : -alignment => the Bio::Align::AlignI object
           -tree => the Bio::Tree::TreeI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -executable => where the njtree executable resides

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>

=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
  my ($aln, $tree, $st, $exe, 
      $ubl) = $self->_rearrange([qw(ALIGNMENT TREE SAVE_TEMPFILES 
				    EXECUTABLE)],
				    @args);
  defined $aln && $self->alignment($aln);
  defined $tree && $self->tree($tree);
  defined $st  && $self->save_tempfiles($st);
  defined $exe && $self->executable($exe);

  return $self;
}

=head2 prepare

 Title   : prepare
 Usage   : my $rundir = $njtree_best->prepare();
 Function: prepare the njtree_best analysis using the default or updated parameters
           the alignment parameter and species tree must have been set
 Returns : value of rundir
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object [optional]

=cut

sub prepare {
   my ($self,$aln,$tree) = @_;

   unless ( $self->save_tempfiles ) {
       # brush so we don't get plaque buildup ;)
       $self->cleanup();
   }
   $tree = $self->tree unless $tree;
   $aln  = $self->alignment unless $aln;
   if( ! $aln ) { 
       $self->warn("Must have supplied a valid alignment file in order to run njtree_best");
       return 0;
   }
   if( ! $tree ) { 
       $self->warn("Must have supplied a valid species tree file in order to run njtree_best");
       return 0;
   }
   my ($tempdir) = $self->tempdir();
   my $tempalnFH;
   if( ! ref($aln) && -e $aln ) { 
       $self->{_tempalnfile} = $aln;
   } else { 
       ($tempalnFH,$self->{_tempalnfile}) = $self->io->tempfile
	   ('-dir' => $tempdir, 
	    UNLINK => ($self->save_tempfiles ? 0 : 1));
       my $alnout = Bio::AlignIO->new('-format'      => 'fasta',
				     '-fh'          => $tempalnFH);
       $aln->set_displayname_flat(1);
       $alnout->write_aln($aln);
       $alnout->close();
       undef $alnout;
       close($tempalnFH);
   }

   my ($temptreeFH);
   if( ! ref($tree) && -e $tree ) {
       $self->{_temptreefile} = $tree;
   } else { 
       ($temptreeFH,$self->{_temptreefile}) = $self->io->tempfile
	   ('-dir' => $tempdir, 
	    UNLINK => ($self->save_tempfiles ? 0 : 1));

       my $treeout = Bio::TreeIO->new('-format' => 'newick',
				     '-fh'     => $temptreeFH);
       $treeout->write_tree($tree);
       $treeout->close();
       close($temptreeFH);
   }
   $self->{_prepared} = 1;
   $self->{_njtree_best_params} = $self->_setparams();

   return $tempdir;
}


=head2 run

 Title   : run
 Usage   : my $nhx_tree = $njtree_best->run();
 Function: run the njtree_best analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : L<Bio::Tree::TreeI> object [optional]
 Args    : L<Bio::Align::AlignI> object
	   L<Bio::Tree::TreeI> object


=cut

sub run {
   my ($self,$aln,$tree) = @_;

   $self->prepare($aln,$tree) unless (defined($self->{_prepared}));
   my ($rc,$nhx_tree) = (1);
   my ($tmpdir) = $self->tempdir();
   my $outfile = $self->outfile_name;
   {
       my $commandstring;
       my $exit_status;
       #./njtree best [other_params] -f species_file.nh -p tree -o inputfile.best.nhx inputfile.nucl.mfa
       my $njtree_executable = $self->executable;
       $commandstring = $njtree_executable." best ";
       $commandstring .= $self->{_njtree_best_params};
       $commandstring .= " -f $self->{_temptreefile} -p tree -o ";
       unless ($self->outfile_name ) {
           my ($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir());
           close($tfh);
           undef $tfh;
           $self->outfile_name($outfile);
       }
       $commandstring .= $self->outfile_name;
       $commandstring .= " $self->{_tempalnfile} ";

       $self->throw("unable to find or run executable for 'njtree'") 
           unless $njtree_executable && -e $njtree_executable && -x _;

       open(RUN, "$commandstring |") 
           or $self->throw("Cannot run $commandstring");

       my @output = <RUN>;
       $exit_status = close(RUN);
       $self->error_string(join('',@output));
       if( (grep { /^\[ /io } @output)  || !$exit_status) {
	   $self->warn("There was an error - see error_string for the program output");
	   $rc = 0;
       }
       eval {
	   $nhx_tree = Bio::TreeIO->new(-file => "$tmpdir/$outfile", 
                                       -format => 'nhx');
       };
       if( $@ ) {
	   $self->warn($self->error_string);
       }
   }
   unless ( $self->save_tempfiles ) {
       $self->cleanup();
   }
   return ($rc,$nhx_tree);
}


sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $attr = $attr;
    # aliasing
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};

    $self->{$attr} = shift if @_;
    return $self->{$attr};
}

=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysus run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)


=cut

sub error_string {
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'error_string'} = $value;
    }
    return $self->{'error_string'};

}


=head2  version

 Title   : version
 Usage   : exit if $prog->version() < 1.8
 Function: Determine the version number of the program
 Example :
 Returns : float or undef
 Args    : none

=cut

sub version {
    my ($self) = @_;
    my $exe;
    return undef unless $exe = $self->executable;
    my $string = `$exe 2>&1` ;

    $string =~ /Version\:\s+(\d+.\d+.\d+)/m;
    return $1 || undef;
}


=head2 alignment

 Title   : alignment
 Usage   : $njtree_best->align($aln);
 Function: Get/Set the L<Bio::Align::AlignI> object
 Returns : L<Bio::Align::AlignI> object
 Args    : [optional] L<Bio::Align::AlignI>
 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
 See also: L<Bio::SimpleAlign>

=cut

sub alignment {
   my ($self,$aln) = @_;

   if( defined $aln ) { 
       if( -e $aln ) { 
	   $self->{'_alignment'} = $aln;
       } elsif( !ref($aln) || ! $aln->isa('Bio::Align::AlignI') ) { 
	   $self->warn("Must specify a valid Bio::Align::AlignI object to the alignment function not $aln");
	   return undef;
       } else {
	   $self->{'_alignment'} = $aln;
       }
   }
   return  $self->{'_alignment'};
}

=head2 tree

 Title   : tree
 Usage   : $njtree_best->tree($tree, %params);
 Function: Get/Set the L<Bio::Tree::TreeI> object
 Returns : L<Bio::Tree::TreeI> 
 Args    : [optional] $tree => L<Bio::Tree::TreeI>,
           [optional] %parameters => hash of tree-specific parameters

 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
 See also: L<Bio::Tree::Tree>

=cut

sub tree {
   my ($self, $tree, %params) = @_;
   if( defined $tree ) { 
       if( ! ref($tree) || ! $tree->isa('Bio::Tree::TreeI') ) { 
	   $self->warn("Must specify a valid Bio::Tree::TreeI object to the alignment function");
       }
       $self->{'_tree'} = $tree;
   }
   return $self->{'_tree'};
}

=head2 check_names

 Title   : check_names
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub check_names {
   my $self = shift;

   my $tree = $self->tree;
   my $aln  = $self->alignment;
   if( ! $aln ) { 
       $self->warn("must have supplied a valid alignment file in order to run njtree_best");
       return 0;
   }
   if( ! $tree ) { 
       $self->warn("must have supplied a valid species tree file in order to run njtree_best");
       return 0;
   }
   foreach my $leaf ($tree->get_leaf_nodes) {
       my $id = $leaf->id;
       $id =~ s/\-\*.+//; # njtree does not consider anything after a \-\*
       $self->{_treeids}{$id} = 1;
   }
   foreach my $seq ($aln->each_seq) {
       my $id = $seq->id;
       $id =~ s/.+\_//; # njtree only looks at the right side of the \_
       $self->{_alnids}{$id} = 1;
   }
   foreach my $alnid (keys %{$self->{_alnids}}) {
       $self->{_unmappedids}{$alnid} = 1 unless (defined($self->{_treeids}{$alnid}));
   }
   if (defined($self->{_unmappedids})) {
       my $count = scalar(keys%{$self->{_unmappedids}});
       my $unmapped = join(",",keys %{$self->{_unmappedids}});
       $self->warn("$count unmapped ids between the aln and the tree $unmapped");
   }
}



=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly
 Function:  Create parameter inputs for njtree_best program
 Example :
 Returns : parameter string to be passed to njtree_best
           during align or profile_align
 Args    : name of calling object

=cut

sub _setparams {
    my ($self) = @_;
    my ($attr, $value,$param_string);
    $param_string = '';
    my $laststr;
    for  $attr ( @NJTREE_BEST_PARAMS ) {
	$value = $self->$attr();
	next unless (defined $value);
	my $attr_key = $attr;
        $attr_key = ' -'.$attr_key;
        $param_string .= $attr_key .' '.$value;

    }
    for  $attr ( @NJTREE_BEST_SWITCHES) {
 	$value = $self->$attr();
 	next unless ($value);
 	my $attr_key = $attr;
 	$attr_key = ' -'.$attr_key;
 	$param_string .= $attr_key ;
    }

    return $param_string;
}


=head1 Bio::Tools::Run::BaseWrapper methods

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
 Usage   : my $outfile = $njtree_best->outfile_name();
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
 Usage   : $njtree_best->cleanup();
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

sub DESTROY {
    my $self= shift;
    unless ( $self->save_tempfiles ) {
	$self->cleanup();
    }
    $self->SUPER::DESTROY();
}

1; # Needed to keep compiler happy
