# $Id$
#
# BioPerl module for Bio::Tools::Run::Simprot
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

Bio::Tools::Run::Simprot - Wrapper around the Simprot program. Wrapper for the calculation of a multiple sequence alignment from a phylogenetic tree

=head1 SYNOPSIS

  use Bio::Tools::Run::Simprot;
  use Bio::TreeIO;

  my $treeio = Bio::TreeIO->new(
      -format => 'nh', -file => 't/data/tree.nh');

  my $tree = $treeio->next_tree;

  my $simprot = Bio::Tools::Run::Simprot->new();
  $simprot->tree($tree);
  my ($rc,$aln,$seq) = $simprot->run();

=head1 DESCRIPTION

This is a wrapper around the Simprot program by Andy Pang, Andrew D
Smith, Paulo AS Nuin and Elisabeth RM Tillier.

Simprot allows for several models of amino acid substitution (PAM, JTT
and PMB), allows for gamma distributed sites rates according to Yang's
model, and implements a parameterised Qian and Goldstein distribution
model for insertion and deletion.

See http://www.uhnres.utoronto.ca/labs/tillier/software.htm for more
information.


=head2 Helping the module find your executable 

You will need to enable SIMPROTDIR to find the simprot program. This can be
done in (at least) three ways:

  1. Make sure the simprot executable is in your path (i.e. 
     'which simprot' returns a valid program
  2. define an environmental variable SIMPROTDIR which points to a 
     directory containing the 'simprot' app:
   In bash 
	export SIMPROTDIR=/home/progs/simprot   or
   In csh/tcsh
        setenv SIMPROTDIR /home/progs/simprot

  3. include a definition of an environmental variable SIMPROTDIR 
      in every script that will
     BEGIN {$ENV{SIMPROTDIR} = '/home/progs/simprot'; }
     use Bio::Tools::Run::Simprot;

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

package Bio::Tools::Run::Simprot;

use vars qw(@ISA %VALIDVALUES $PROGRAMNAME $PROGRAM);

use strict;
use Bio::SimpleAlign;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::TreeIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;
@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

# valid values for parameters, the default one is always
# the first one in the array
BEGIN {
    %VALIDVALUES = ( 
                    'branch'   => '1',
                    'eFactor'  => '3',
                    'indelFrequncy'   => '0.03',
                    'maxIndel'   => '2048',
                    'subModel' => [ 2,0,1], # 0:PAM, 1:JTT, 2:PMB
                    'rootLength'   => '50',
                    'alpha'   => '1',
                    'Benner'   => '0',
                    'interleaved'   => '1',
                    'variablegamma'   => '0',
                    'bennerk'   => '-2',
                   );
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'simprot';
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{SIMPROTDIR}) if $ENV{SIMPROTDIR};
}


=head2 new

 Title   : new
 Usage   : my $simprot = Bio::Tools::Run::Simprot->new();
 Function: Builds a new Bio::Tools::Run::Simprot
 Returns : Bio::Tools::Run::Simprot
 Args    : -alignment => the Bio::Align::AlignI object
           -tree => the Bio::Tree::TreeI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -executable => where the simprot executable resides
					 -params => A reference to a hash where keys are parameter names
					            and hash values are the associated parameter values

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>

=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
  my ($aln, $tree, $st, $params, $exe, 
      $ubl) = $self->_rearrange([qw(TREE SAVE_TEMPFILES PARAMS EXECUTABLE)],
				    @args);
  defined $tree && $self->tree($tree);
  defined $st  && $self->save_tempfiles($st);
  defined $exe && $self->executable($exe);

  $self->set_default_parameters();
  if( defined $params ) {
      if( ref($params) !~ /HASH/i ) { 
	  $self->warn("Must provide a valid hash ref for parameter -FLAGS");
      } else {
	  map { $self->set_parameter($_, $$params{$_}) } keys %$params;
      }
  }
  return $self;
}

=head2 set_parameters

 Title   : set_parameters
 Usage   : $codeml->set_parameters($parameter, $value);
 Function: (Re)set the SimProt parameters
 Returns : none
 Args    : First argument is the parameter name
           Second argument is the parameter value

=cut

sub set_parameter{
   my ($self,$param,$value) = @_;
   unless (defined $self->{'no_param_checks'} && $self->{'no_param_checks'} == 1) {
       if ( ! defined $VALIDVALUES{$param} ) { 
           $self->warn("unknown parameter $param will not be set unless you force by setting no_param_checks to true");
           return 0;
       } 
       if ( ref( $VALIDVALUES{$param}) =~ /ARRAY/i &&
            scalar @{$VALIDVALUES{$param}} > 0 ) {
       
           unless ( grep { $value eq $_ } @{ $VALIDVALUES{$param} } ) {
               $self->warn("parameter $param specified value $value is not recognized, please see the documentation and the code for this module or set the no_param_checks to a true value");
               return 0;
           }
       }
   }
   $self->{'_simprotparams'}->{$param} = $value;
   return 1;
}



=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $codeml->set_default_parameters(0);
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the 
	    %VALIDVALUES class variable)
 Returns : none
 Args    : boolean: keep existing parameter values


=cut

sub set_default_parameters{
   my ($self,$keepold) = @_;
   $keepold = 0 unless defined $keepold;
   
   while( my ($param,$val) = each %VALIDVALUES ) {
       # skip if we want to keep old values and it is already set
       next if( defined $self->{'_simprotparams'}->{$param} && $keepold);
       if(ref($val)=~/ARRAY/i ) {
	   $self->{'_simprotparams'}->{$param} = $val->[0];
       }  else { 
	   $self->{'_simprotparams'}->{$param} = $val;
       }
   }
}


=head2 get_parameters

 Title   : get_parameters
 Usage   : my %params = $self->get_parameters();
 Function: returns the list of parameters as a hash
 Returns : associative array keyed on parameter names
 Args    : none


=cut

sub get_parameters{
   my ($self) = @_;
   # we're returning a copy of this
   return %{ $self->{'_simprotparams'} };
}



=head2 prepare

 Title   : prepare
 Usage   : my $rundir = $simprot->prepare();
 Function: prepare the simprot analysis using the default or updated parameters
           the alignment parameter and species tree must have been set
 Returns : value of rundir
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object [optional]

=cut

sub prepare {
   my ($self,$tree) = @_;

   unless ( $self->save_tempfiles ) {
       # brush so we don't get plaque buildup ;)
       $self->cleanup();
   }
   $tree = $self->tree unless $tree;
   if( ! $tree ) { 
       $self->warn("must have supplied a valid species tree file in order to run simprot");
       return 0;
   }
   my ($tempdir) = $self->tempdir();

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

   my %params = $self->get_parameters;
   while( my ($param,$val) = each %params ) {
       $self->{_simprot_params} .=" \-\-$param\=$val";
   }

   return $tempdir;
}


=head2 run

 Title   : run
 Usage   : my $nhx_tree = $simprot->run();
 Function: run the simprot analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : L<Bio::Tree::TreeI> object [optional]
 Args    : L<Bio::Align::AlignI> object
	   L<Bio::Tree::TreeI> object


=cut

sub run {
   my ($self,$tree) = @_;

   $self->prepare($tree) unless (defined($self->{_prepared}));
   my ($rc,$aln,$seq) = (1);
   my ($tmpdir) = $self->tempdir();
   my $outfile;
   {
       my $commandstring;
       my $exit_status;
       my $simprot_executable = $self->executable;
       $commandstring .= $simprot_executable;
       $commandstring .= $self->{_simprot_params};
       $commandstring .= " --tree=". $self->{_temptreefile} . " ";
       my ($tfh, $outfile) = $self->io->tempfile(-dir=>$self->tempdir());
       close($tfh);
       undef $tfh;
       $self->outfile_name($outfile);
       my $seqfile;
       ($tfh, $seqfile) = $self->io->tempfile(-dir=>$self->tempdir());
       close($tfh);
       undef $tfh;

       $commandstring .= "--alignment=". $self->outfile_name . " ";
       $commandstring .= "--sequence=". $seqfile . " ";

       $self->throw("unable to find or run executable for 'simprot'") 
           unless $simprot_executable && -e $simprot_executable && -x _;

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
	   $aln = Bio::AlignIO->new(-file => "$outfile",-format => 'fasta');
	   $seq = Bio::SeqIO->new(-file => "$seqfile", -format => 'fasta');
       };
       if( $@ ) {
	   $self->warn($self->error_string);
       }
   }
   unless ( $self->save_tempfiles ) {
       $self->cleanup();
   }
   return ($rc,$aln,$seq);
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
 Usage   : $simprot->align($aln);
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
 Usage   : $simprot->tree($tree, %params);
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
 Usage   : my $outfile = $simprot->outfile_name();
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
 Usage   : $simprot->cleanup();
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
