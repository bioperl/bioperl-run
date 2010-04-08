# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::PAML::Evolver
#
#       based on the Bio::Tools::Run::Phylo::PAML::Codeml
#       by Jason Stajich <jason-at-bioperl.org>
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Albert Vilella <avilella-AT-gmail-DOT-com>
#
# Copyright Albert Vilella
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::PAML::Evolver - Wrapper aroud the PAML program evolver

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::PAML::Evolver;

  my $evolver = Bio::Tools::Run::Phylo::PAML::Evolver->new();

  # Get a $tree object somehow
  $evolver->tree($tree);

  # FIXME: evolver generates a tree (first run with option 1 or 2)?

  # One or more alns are created
  my @alns = $evolver->run();

  ####

  # Or with all the data coming from a previous PAML run
  my $parser = Bio::Tools::Phylo::PAML->new
    (
     -file => "$inputfile",
    );
  my $result = $parser->next_result();
  my $tree = $result->next_tree;
  $evolver->tree($tree);
  my @codon_freqs = $result->get_CodonFreqs();
  $evolver->set_CodonFreqs(\@codon_freqs);

  my $val = $evolver->prepare();

  # FIXME: something similar for nucleotide frequencies:
  # Option (5) Simulate nucleotide data sets (use MCbase.dat)?

  # FIXME: something similar for aa parameters:
  # Option (7) Simulate amino acid data sets (use MCaa.dat)?

  # FIXME: With an initial RootSeq.txt

=head1 DESCRIPTION

This is a wrapper around the evolver program of PAML (Phylogenetic
Analysis by Maximum Likelihood) package of Ziheng Yang.  See
http://abacus.gene.ucl.ac.uk/software/paml.html for more information.

This module is more about generating the properl MCmodel.ctl file and
will run the program in a separate temporary directory to avoid
creating temp files all over the place.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

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

  http://bioperl.org/bioperl-bugs/

=head1 AUTHOR - Albert Vilella

Email avilella-AT-gmail-DOT-com

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::PAML::Evolver;
use vars qw(@ISA %VALIDVALUES $MINNAMELEN $PROGRAMNAME $PROGRAM);
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::TreeIO;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Phylo::PAML;
use Cwd;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

=head2 Default Values

Valid and default values for evolver programs are listed below.  The
default values are always the first one listed.  These descriptions
are essentially lifted from the example MCcodon.dat file and pamlDOC
documentation provided by the author.

Stub:

B<option1> specifies something.

B<option2> specifies something else.


INCOMPLETE DOCUMENTATION OF ALL METHODS

=cut

BEGIN { 

    $MINNAMELEN = 25;
    $PROGRAMNAME = 'evolver' . ($^O =~ /mswin/i ?'.exe':'');
    if( defined $ENV{'PAMLDIR'} ) {
	$PROGRAM = Bio::Root::IO->catfile($ENV{'PAMLDIR'},$PROGRAMNAME). ($^O =~ /mswin/i ?'.exe':'');;
    }
   
    # valid values for parameters, the default one is always
    # the first one in the array
    # much of the documentation here is lifted directly from the MCcodon.dat
    # example file provided with the package

    # Evolver calls time for seed: SetSeed(i==-1?(int)time(NULL):i);
    my $rand = int(time);
    #     my $rand = int(rand(999999));
    %VALIDVALUES = 
        ( 

         # FIXME: there should be a 6-7-8 option that fits MCcodon or MCbase or MCaa
         'outfmt'    => [0,1], 
         #     0           * 0:paml format (mc.paml); 1:paup format (mc.paup)
         # random number seed (odd number)
         # FIXME: set seed to null here and ask for it later?
         'seed' => "$rand",
         # numseq can actually be calculated from the tree external nodes
         # nucleotide sites
         'nuclsites' => '1000',
         # replicates
         'replicates' => '1',
         # tree length; use -1 if tree has absolute branch lengths
         # Note that tree length and branch lengths under the codon model are
         # measured by the expected number of nucleotide substitutions per codon
         # (see Goldman & Yang 1994).  For amino acid models, they are defined as
         # the expected number of amino acid changes per amino acid site.
         'tree_length' => '1.5',
         # omega
         # FIXME: if one wants to call for different omegas (NSsites),
         # right now it has to be done like:
         # $evolver->set_parameter(omega,"3\n0.2\t0.3\t0.5\n0.5\t0.9\t3.2\n");
         # 3            * number of site classes, followed by frequencies and omega's.
         #   0.6    0.3   0.1 # Freqs
         #   0.1    0.8   3.2 # Omegas
         'omega' => '0.3',
         # kappa
         'kappa' => '5',
         # FIXME: this only for MCbase.dat ?
         # model: 0:JC69, 1:K80, 2:F81, 3:F84, 4:HKY85, 5:T92, 6:TN93, 7:REV
         # FIXME: this applies to only some models?
         # 10 5 1 2 3 * kappa or rate parameters in model
         # FIXME: this applies to only MCbase.dat ?
         # 0.5  4     * <alpha>  <#categories for discrete gamma>
        ); # end of validvalues
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'evolver';
}

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{PAMLDIR}) if $ENV{PAMLDIR};
}


=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::PAML::Evolver->new();
 Function: Builds a new Bio::Tools::Run::Phylo::PAML::Evolver object 
 Returns : Bio::Tools::Run::Phylo::PAML::Evolver
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -tree => the Bio::Tree::TreeI object (FIXME: optional if this is done in a first run)
           -params => a hashref of PAML parameters (all passed to set_parameter)
           -executable => where the evolver executable resides

See also: L<Bio::Tree::TreeI>

=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
#   $self->{'_branchLengths'} = 0;
  my ($tree, $st, $params, $exe)
      = $self->_rearrange([qw(TREE SAVE_TEMPFILES PARAMS EXECUTABLE)],
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


=head2 prepare

 Title   : prepare
 Usage   : my $rundir = $evolver->prepare($aln);
 Function: prepare the evolver analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : value of rundir
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object [optional]

=cut

sub prepare {
   my ($self,$aln,$tree) = @_;
   # FIXME: To consider: to have save_tempfiles always TRUE by default
   # or simply never delete
   unless ( $self->save_tempfiles ) {
       # brush so we don't get plaque buildup ;)
       $self->cleanup();
   }
   $tree = $self->tree unless $tree;
   my ($tempdir) = $self->tempdir();

   # FIXME:
   # If multiple replicates, evolver gives:
   # A file with a concatenation of sequential phylips separated by a
   # double return which gets correctly parsed by AlignIO next_aln

   # Or a concatenation of paup entries with tags separating them which
   # wont get correctly parsed with current AlignIO (failed with
   # nexus)

   # FIXME: To consider: force phylip outfmt and split the files if
   # replicates > 1

   #    if( ! ref($aln) && -e $aln ) { 
   #        $tempseqfile = $aln;
   #    } else { 
   #        ($tempseqFH,$tempseqfile) = $self->io->tempfile
   # 	   ('-dir' => $tempdir, 
   # 	    UNLINK => ($self->save_tempfiles ? 0 : 1));
   #        my $alnout = Bio::AlignIO->new('-format'      => 'phylip',
   # 				     '-fh'          => $tempseqFH,
   #                                      '-interleaved' => 0,
   #                                      '-idlength'    => $MINNAMELEN > $aln->maxdisplayname_length() ? $MINNAMELEN : $aln->maxdisplayname_length() +1);
   #        $alnout->write_aln($aln);
   #        $alnout->close();
   #        undef $alnout;   
   #        close($tempseqFH);
   #    }
   # now let's print the MCcodon.dat file.
   # many of the these programs are finicky about what the filename is 
   # and won't even run without the properly named file.  Ack
   
   # FIXME: we should do the appropriate here if we are simulating codons, nts o aa.
   my $evolver_ctl = "$tempdir/MCcodon.dat";
   my $evolverfh;
   open($evolverfh, ">$evolver_ctl") or $self->throw("cannot open $evolver_ctl for writing");
   # FIXME: params follow an order in the control file, they are not a hash. Do we have an
   # clean example of this in bioperl-run?
   my %params = $self->get_parameters;
   print $evolverfh "$params{outfmt}\n";
   print $evolverfh "$params{seed}\n";
   # FIXME: call get_leaf_nodes to count only leafs - relates to newick onlyleafids bug
   # my $numseq = scalar($tree->get_nodes);
   my $numseq = scalar($tree->get_leaf_nodes);
   print $evolverfh "$numseq ";
   print $evolverfh "$params{nuclsites} ";
   print $evolverfh "$params{replicates}\n\n";
   print $evolverfh "$params{tree_length}\n";
   # FIXME: do #1:#n branch tagging magic here
   # FIXME: this pre flush stuff is for appending mode
   my $treeout = Bio::TreeIO->new
       ('-format' => 'newick',
        '-fh'     => $evolverfh,
        -PRE =>'>>',
        '-flush',
       );
#    $treeout->bootstrap_style('nointernalids');
   $treeout->write_tree($tree);
   # Appending mode to add more control file contents here
   open($evolverfh, ">>$evolver_ctl") or $self->throw("cannot open $evolver_ctl for writing");
   print $evolverfh "\n$params{omega}\n";
   print $evolverfh "$params{kappa}\n";
   # Print codon freqs here or defaults (below)
   my @codon_freqs = $self->get_CodonFreqs();
   foreach my $firstbase (@codon_freqs) {
       foreach my $element (@$firstbase) {
           print $evolverfh "  $element";
       }
       print $evolverfh "\n";
   }

   # FIXME: codon freqs or nt freqs should always come from an object?
   # Silly printing the default codonfreqs in the default
   # MCcodon.dat provided by PAML
   unless (@codon_freqs) {
       print $evolverfh 
       "0.00983798  0.01745548  0.00222048  0.01443315\n",
       "0.00844604  0.01498576  0.00190632  0.01239105\n",
       "0.01064012  0.01887870  0           0\n",
       "0.00469486  0.00833007  0           0.00688776\n",
       "0.01592816  0.02826125  0.00359507  0.02336796\n",
       "0.01367453  0.02426265  0.00308642  0.02006170\n",
       "0.01722686  0.03056552  0.00388819  0.02527326\n",
       "0.00760121  0.01348678  0.00171563  0.01115161\n",
       "0.01574077  0.02792876  0.00355278  0.02309304\n",
       "0.01351366  0.02397721  0.00305010  0.01982568\n",
       "0.01702419  0.03020593  0.00384245  0.02497593\n",
       "0.00751178  0.01332811  0.00169545  0.01102042\n",
       "0.02525082  0.04480239  0.00569924  0.03704508\n",
       "0.02167816  0.03846344  0.00489288  0.03180369\n",
       "0.02730964  0.04845534  0.00616393  0.04006555\n",
       "0.01205015  0.02138052  0.00271978  0.01767859\n";
   }
   print $evolverfh "\n// end of file.\n";
   close($evolverfh);
   # FIXME: what do we return in prepare?
   # return
}


=head2 run

 Title   : run
 Usage   : my ($rc,$parser) = $evolver->run();
 Function: run the evolver analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : Return code, L<Bio::Tools::Phylo::PAML>
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object [optional]

=cut


sub run {

    my $self = shift;
    # FIXME: We should look for the stuff we prepared in the prepare method here
    my $rc = (1);
    {
        my $exit_status;
        my ($tmpdir) = $self->tempdir();
        chdir($tmpdir);
        my $evolverexe = $self->executable();
        $self->throw("unable to find or run executable for 'evolver'") unless $evolverexe && -e $evolverexe && -x _;
        open(RUN, "$evolverexe 6 MCcodon.dat |") or $self->throw("Cannot open exe $evolverexe");
        my @output = <RUN>;
        $exit_status = close(RUN);
        $self->error_string(join('',@output));
        if ( (grep { /\berr(or)?: /io } @output)  || !$exit_status) {
            $self->warn("There was an error - see error_string for the program output");
            $rc = 0;
        }
        # FIXME - hardcoded mc.paml
        unless ($self->indel) {
            my $in  = Bio::AlignIO->new('-file'   => "$tmpdir/mc.paml", 
                                        '-format' => 'phylip');
            my $aln = $in->next_aln();
            $self->alignment($aln);
        }
    }
    return $rc;
}

=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysis run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)


=cut

sub error_string{
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'error_string'} = $value;
    }
    return $self->{'error_string'};

}

=head2 alignment

 Title   : alignment
 Usage   : $evolver->align($aln);
 Function: Get/Set the L<Bio::Align::AlignI> object
 Returns : L<Bio::Align::AlignI> object
 Args    : [optional] L<Bio::Align::AlignI>
 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
 See also: L<Bio::SimpleAlign>

=cut

sub alignment{
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
 Usage   : $evolver->tree($tree, %params);
 Function: Get/Set the L<Bio::Tree::TreeI> object
 Returns : L<Bio::Tree::TreeI> 
 Args    : [optional] $tree => L<Bio::Tree::TreeI>,
           [optional] %parameters => hash of tree-specific parameters:
                  branchLengths: 0, 1 or 2
                  out

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
       # FIXME: I think we dont need this in Evolver
#        if ( defined $params{'_branchLengths'} ) {
# 	 my $ubl = $params{'_branchLengths'};
# 	 if ($ubl !~ m/^(0|1|2)$/) {
# 	   $self->throw("The branchLengths parameter to tree() must be 0 (ignore), 1 (initial values) or 2 (fixed values) only");
# 	 }
# 	 $self->{'_branchLengths'} = $ubl;
#        }
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

sub get_parameters{
   my ($self) = @_;
   # we're returning a copy of this
   return %{ $self->{'_evolverparams'} };
}


=head2 set_parameter

 Title   : set_parameter
 Usage   : $evolver->set_parameter($param,$val);
 Function: Sets a evolver parameter, will be validated against
           the valid values as set in the %VALIDVALUES class variable.  
           The checks can be ignored if one turns off param checks like this:
             $evolver->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $param => name of the parameter
           $value => value to set the parameter to
 See also: L<no_param_checks()>

=cut

sub set_parameter{
   my ($self,$param,$value) = @_;
   unless ($self->{'no_param_checks'} == 1) {
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
   $self->{'_evolverparams'}->{$param} = $value;
   return 1;
}

=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $evolver->set_default_parameters(0);
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
       next if( defined $self->{'_evolverparams'}->{$param} && $keepold);
       if(ref($val)=~/ARRAY/i ) {
	   $self->{'_evolverparams'}->{$param} = $val->[0];
       }  else { 
	   $self->{'_evolverparams'}->{$param} = $val;
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

sub no_param_checks{
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'no_param_checks'} = $value;
    }
    return $self->{'no_param_checks'};
}

=head2 set_CodonFreqs

 Title   : set_CodonFreqs
 Usage   : $obj->set_CodonFreqs($newval)
 Function: Get/Set the Codon Frequence table
 Returns : value of set_CodonFreqs (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub set_CodonFreqs{
    my $self = shift;

    return $self->{'_codonfreqs'} = shift if @_;
    return $self->{'_codonfreqs'};
}

=head2 get_CodonFreqs

 Title   : get_CodonFreqs
 Usage   : my @codon_freqs = $evolver->get_CodonFreqs() 
 Function: Get the Codon freqs
 Returns : Array
 Args    : none


=cut

sub get_CodonFreqs{
   my ($self) = @_;
   return @{$self->{'_codonfreqs'} || []};
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
 Usage   : my $outfile = $evolver->outfile_name();
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
 Usage   : $evolver->cleanup();
 Function: Will cleanup the tempdir directory after a PAML run
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


=head2 indel

 Title   : indel
 Usage   : $obj->indel($newval)
 Function: this is only useful if using evolver_indel instead of main
           evolver package:
           Exploring the Relationship between Sequence Similarity and
           Accurate Phylogenetic Trees Brandi L. Cantarel, Hilary
           G. Morrison and William Pearson
 Example : 
 Returns : value of indel (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub indel{
    my $self = shift;

    return $self->{'indel'} = shift if @_;
    return $self->{'indel'};
}


1;
