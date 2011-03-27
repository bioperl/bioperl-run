# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Hyphy::Base
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

Bio::Tools::Run::Phylo::Hyphy::Base - Hyphy wrapping base methods

=head1 SYNOPSIS

FIXME

=head1 DESCRIPTION

HyPhy ([Hy]pothesis Testing Using [Phy]logenies) package of Sergei
Kosakowsky Pond, Spencer V. Muse, Simon D.W. Frost and Art Poon.  See
http://www.hyphy.org for more information.

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

=head1 AUTHOR - Albert Vilella

Email avilella-at-gmail-dot-com

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::Hyphy::Base;
use vars qw(@ISA @VALIDVALUES $PROGRAMNAME $PROGRAM);
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

=head2 Default Values

Valid and default values are listed below.  The default
values are always the first one listed.  These descriptions are
essentially lifted from the python wrapper or provided by the author.

INCOMPLETE DOCUMENTATION OF ALL METHODS

=cut

BEGIN { 
    $PROGRAMNAME = 'HYPHYMP' . ($^O =~ /mswin/i ?'.exe':'');
    if( defined $ENV{'HYPHYDIR'} ) {
	$PROGRAM = Bio::Root::IO->catfile($ENV{'HYPHYDIR'},$PROGRAMNAME). ($^O =~ /mswin/i ?'.exe':'');;
    }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'HYPHYMP';
}

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{HYPHYDIR}) if $ENV{HYPHYDIR};
}


=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Hyphy->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Hyphy object 
 Returns : Bio::Tools::Run::Phylo::Hyphy
 Args    : -alignment => the Bio::Align::AlignI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -tree => the Bio::Tree::TreeI object
           -params => a hashref of parameters (all passed to set_parameter)
           -executable => where the hyphy executable resides

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>

=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);

  return $self;
}


=head2 prepare

 Title   : prepare
 Usage   : my $rundir = $hyphy->prepare($aln);
 Function: prepare the analysis using the default or updated parameters
           the alignment parameter must have been set
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
       $self->warn("must have supplied a valid alignment file in order to run hyphy");
       return 0;
   }
   my ($tempdir) = $self->tempdir();
   my ($tempseqFH,$tempalnfile);
   if( ! ref($aln) && -e $aln ) { 
       $tempalnfile = $aln;
   } else { 
       ($tempseqFH,$tempalnfile) = $self->io->tempfile
	   ('-dir' => $tempdir, 
	    UNLINK => ($self->save_tempfiles ? 0 : 1));
       $aln->set_displayname_flat(1);
       my $alnout = Bio::AlignIO->new('-format'      => 'fasta',
				     '-fh'          => $tempseqFH);

       $alnout->write_aln($aln);
       $alnout->close();
       undef $alnout;
       close($tempseqFH);
   }
   $self->{'_params'}{'tempalnfile'} = $tempalnfile;
   my $outfile = $self->outfile_name || "$tempdir/results.tsv";
   $self->{'_params'}{'outfile'} = $outfile;

   my ($temptreeFH,$temptreefile);
   if( ! ref($tree) && -e $tree ) { 
       $temptreefile = $tree;
   } else { 
       ($temptreeFH,$temptreefile) = $self->io->tempfile
	   ('-dir' => $tempdir, 
	    UNLINK => ($self->save_tempfiles ? 0 : 1));

       my $treeout = Bio::TreeIO->new('-format' => 'newick',
				     '-fh'     => $temptreeFH);
       $treeout->write_tree($tree);
       $treeout->close();
       close($temptreeFH);
   }
   $self->{'_params'}{'temptreefile'} = $temptreefile;
   $self->create_wrapper;
   $self->{_prepared} = 1;
   return $tempdir;
}


=head2 create_wrapper

 Title   : create_wrapper
 Usage   : $self->create_wrapper
 Function: It will create the wrapper file that interfaces with the analysis bf file
 Example :
 Returns : 
 Args    :


=cut

sub create_wrapper {
   my ($self,$batchfile) = @_;

   my $tempdir = $self->tempdir;
   $self->update_ordered_parameters;
   my $wrapper = "$tempdir/wrapper.bf";
   open(WRAPPER, ">$wrapper") or $self->throw("cannot open $wrapper for writing");

   print WRAPPER "stdinRedirect"," = ", "\{", "\};", "\n\n";
   my $counter = sprintf("%02d", 0);
   foreach my $elem (@{ $self->{'_updatedorderedparams'} }) {
       my ($param,$val) = each %$elem;
       print WRAPPER 'stdinRedirect ["';
       print WRAPPER "$counter";
       print WRAPPER '"] = "';
       print WRAPPER "$val";
       print WRAPPER '"',";\n";
       $counter = sprintf("%02d",$counter+1);
   }
   print WRAPPER "\n",'ExecuteAFile (HYPHY_BASE_DIRECTORY + "TemplateBatchFiles" + DIRECTORY_SEPARATOR  + "', $batchfile ,'", stdinRedirect);', "\n";

   close(WRAPPER);
   $self->{'_wrapper'} = $wrapper;
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

=head2 alignment

 Title   : alignment
 Usage   : $hyphy->align($aln);
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
 Usage   : $hyphy->tree($tree, %params);
 Function: Get/Set the L<Bio::Tree::TreeI> object
 Returns : L<Bio::Tree::TreeI> 
 Args    : [optional] $tree => L<Bio::Tree::TreeI>,
           [optional] %parameters => hash of tree-specific parameters:

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

=head2 get_parameters

 Title   : get_parameters
 Usage   : my %params = $self->get_parameters();
 Function: returns the list of parameters as a hash
 Returns : associative array keyed on parameter names
 Args    : none


=cut

sub get_parameters {
   my ($self) = @_;
   # we're returning a copy of this
   return @{ $self->{'_hyphyparams'} };
}


=head2 set_parameter

 Title   : set_parameter
 Usage   : $hyphy->set_parameter($param,$val);
 Function: Sets a hyphy parameter, will be validated against
           the valid values as set in the %VALIDVALUES class variable.  
           The checks can be ignored if one turns off param checks like this:
             $hyphy->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $param => name of the parameter
           $value => value to set the parameter to
 See also: L<no_param_checks()>

=cut



sub set_parameter {
   my ($self,$param,$value) = @_;

   # FIXME - add validparams checking
   $self->{'_hyphyparams'}{$param} = $value;
   return 1;
}

=head2 update_ordered_parameters

 Title   : update_ordered_parameters
 Usage   : $hyphy->update_ordered_parameters(0);
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the 
	    %VALIDVALUES class variable)
 Returns : none
 Args    : boolean: keep existing parameter values


=cut

sub update_ordered_parameters {
   my ($self,$keepold) = @_;
   $keepold = 0 unless defined $keepold;
   foreach my $elem (@{$self->{'_orderedparams'}}) {
       my ($param,$val) = each %$elem;
       my $composite_param = $param;
       # skip if we want to keep old values and it is already set
       if (ref($param) =~ /ARRAY/i ) {
           push @{ $self->{'_updatedorderedsparams'} }, {$param, $self->{_params}{$param} || $val};
       } elsif ( ref($val) =~ /HASH/i ) { 
           while (defined($val)) {
               last unless (ref($val) =~ /HASH/i);
               my ($param,$val) = each %{$val};
               $composite_param .= $param;
           }
           push @{ $self->{'_updatedorderedparams'} }, {$param, $self->{_params}{$composite_param} || $val};
       } else { 
           push @{ $self->{'_updatedorderedparams'} }, {$param, $self->{_params}{$param} || $val};
       }
   }
}


=head1 Bio::Tools::Run::WrapperBase methods

=cut

=head2 no_param_checks

 Title   : no_param_checks
 Usage   : $obj->no_param_checks($newval)
 Function: Boolean flag as to whether or not we should
           trust the sanity checks for parameter values  
 Returns : value of no_param_checks
 Args    : newvalue (optional)


=cut

sub no_param_checks {
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'no_param_checks'} = $value;
    }
    return $self->{'no_param_checks'};
}


=head2 save_tempfiles

 Title   : save_tempfiles
 Usage   : $obj->save_tempfiles($newval)
 Function: 
 Returns : value of save_tempfiles
 Args    : newvalue (optional)


=cut

=head2 outfile_name

 Title   : outfile_name
 Usage   : my $outfile = $hyphy->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to


=cut

sub outfile_name {
    my $self = shift;
    if( @_ ) {
	return $self->{'_params'}->{'outfile'} = shift @_;
    }
    return $self->{'_params'}->{'outfile'};
}

=head2 no_param_checks

 Title   : no_param_checks
 Usage   : $obj->no_param_checks($newval)
 Function: Boolean flag as to whether or not we should
           trust the sanity checks for parameter values  
 Returns : value of no_param_checks
 Args    : newvalue (optional)


=cut

# sub no_param_checks {
#    my ($self,$value) = @_;
#    if( defined $value) {
#       $self->{'no_param_checks'} = $value;
#     }
#     return $self->{'no_param_checks'};
# }

=head2 tempdir

 Title   : tempdir
 Usage   : my $tmpdir = $self->tempdir();
 Function: Retrieve a temporary directory name (which is created)
 Returns : string which is the name of the temporary directory
 Args    : none


=cut

=head2 cleanup

 Title   : cleanup
 Usage   : $hyphy->cleanup();
 Function: Will cleanup the tempdir directory after a run
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

1;
