# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::PAML::Baseml
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

Bio::Tools::Run::Phylo::PAML::Baseml - Wrapper aroud the PAML program baseml

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::PAML::Baseml;
  use Bio::AlignIO;
  my $alignio = Bio::AlignIO->new(-format => 'phylip',
  	 		         -file   => 't/data/gf-s85.phylip');
  my $aln = $alignio->next_aln;

  my $bml = Bio::Tools::Run::Phylo::PAML::Baseml->new();
  $bml->alignment($aln);
  my ($rc,$parser) = $bml->run();
  while( my $result = $parser->next_result ) {
    my @otus = $result->get_seqs();
    my $MLmatrix = $result->get_MLmatrix();
    # 0 and 1 correspond to the 1st and 2nd entry in the @otus array
  }

=head1 DESCRIPTION

This is a wrapper around the baseml program of PAML (Phylogenetic
Analysis by Maximum Likelihood) package of Ziheng Yang.  See
http://abacus.gene.ucl.ac.uk/software/paml.html for more information.

This module will generate a proper baseml.ctl file and will run the
program in a separate temporary directory to avoid creating temp files
all over the place and will cleanup after itself..

The values you can feed to the configuration file are documented here.

    'noisy'   => [ 0..3,9],
    'verbose' => [ 0,1,2], # 0:concise, 1:detailed, 2:too much
    'runmode' => [0..5], 
    # for runmode
    # 0: use the provided tree structure(s) in treefile
    # 1,2: mean heuristic search by star-decomposition alg
    # 2: starts from star tree while 1 reads a multifurcating 
    # tree from treefile and ties to estimate the best 
    # bifurcating tree
    # 3: stepwise addition
    # 4: NNI perturbation with the starting tree
    # Tree search DOES NOT WORK WELL so estimate a tree
    # using other programs first
    'model'   => '0', 
    # for model
    # 0: JC69 (uncorrected)
    # 1: K80  (transitions/transversion weighted differently)
    # 2: F81
    # 3: F84
    # 4: HKY85
    # 5: T92 (Tamura 92) 
    # 6: TN93 (Tajima-Nei) correct for multiple substitutions
    # 7: REV (aka GTR)
    # 8: UNREST 
    # 9: REVu
    #10: UNRESTu
    # See Yang 1994 JME 39:105-111

    # model 8 special case of the REV model
    # model 9 is special case of unrestricted model
    # can also supply special rate parameters
    # so for example (from pamlDOC.pdf
    # $model  = '8 [2 (CT) (AG)]'; # TN93 
    # $model  = '8 [2 (TA AT TG CA CG) (AG)]'; # TN93
    # $model  = '9 [1 (TC CT AG GA)]; # K80
    # $model  = '9 [0]'; # JC69
    # $model  = '9 [11 (TA) (TG) (CT) (CA) (CG) (AT) (AC) (AG) (GT) (GC) (GA)],

    'outfile' => 'mlb',
    'fix_kappa'=> [0,1], # 0:estimate kappa, 1:fix kappa
    'kappa'    => '2.5', # initial or fixed kappa
    'fix_alpha'=> [1,0], # 0: estimate gamma shape param
    # 1: fix it at alpha
    'alpha'    => '0', # initial of fixed alpha
    # 0: infinity (constant rate)
    'Malpha'   => [0,1], # different alphas for genes

    'fix_rho'=> [1,0], # 0: estimate gamma shape param
		                          # 1: fix it at alpha
    'rho'    => '0', # initial of fixed alpha
    # 0: infinity (constant rate)

    'ncatG'    => '5', # number of categories in the dD,AdG, or nparkK models of rates
    'nparK'    => [0..4], # rate-class models 
    # 1:rk 2:rk&fK 
    # 3:rK&MK(1/K) 4:rK&MK
    'nhomo'    => [0..4], # 0 & 1: homogeneous,
    # 2: kappa for brances
    # 3:N1 4:N2
    'getSE'    => [0,1],
    'RateAncestor' => [1,0,2], # rates (alpha > 0) or
    # ancestral states
    'cleandata' => [1,0], # remove sites with 
    # ambiguity data (1:yes or 0:no)

    'fix_blength' => [-1,0,1,2], # 0: ignore, -1: random,
    # 1: initial, 2: fixed

    # 'icode'    => [ 0..10], # (with RateAncestor=1.
    #try "GC" in data,model=4,Mgene=4)
    'ndata'    => [5,1..10],
    'clock'    => [0..3], # 0: no clock, 1: clock, 2: local clock, 3: CombinedAnalysis
    'Small_Diff' => '1e-6', #underflow issues?

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

=head1 CONTRIBUTORS

Sendu Bala - bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::PAML::Baseml;
use vars qw(@ISA %VALIDVALUES $MINNAMELEN $PROGRAMNAME $PROGRAM);
use strict;
use Cwd;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Phylo::PAML;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);


BEGIN { 
    $MINNAMELEN = 25;
    $PROGRAMNAME = 'baseml'  . ($^O =~ /mswin/i ?'.exe':'');
    if( defined $ENV{'PAMLDIR'} ) {
	$PROGRAM = Bio::Root::IO->catfile($ENV{'PAMLDIR'},$PROGRAMNAME);
    }
    # valid values for parameters, the default one is always
    # the first one in the array
    # much of the documentation here is lifted directly from the baseml.ctl
    # example file provided with the package
    %VALIDVALUES = ( 
		     'noisy'   => [ 0..3,9],
		     'verbose' => [ 0,1,2], # 0:concise, 1:detailed, 2:too much
		     'runmode' => [0..5], 
		     # for runmode
		     # 0: use the provided tree structure(s) in treefile
		     # 1,2: mean heuristic search by star-decomposition alg
		     # 2: starts from star tree while 1 reads a multifurcating 
		     # tree from treefile and ties to estimate the best 
		     # bifurcating tree
		     # 3: stepwise addition
		     # 4: NNI perturbation with the starting tree
		     # Tree search DOES NOT WORK WELL so estimate a tree
		     # using other programs first
		     'model'   => [5, 0..8], 
		     # for model
		     # 0: JC69 (uncorrected)
		     # 1: K80  (transitions/transversion weighted differently)
		     # 2: F81
		     # 3: F84
		     # 4: HKY85
		     # 5: T92 (Tamura 92) 
		     # 6: TN93 (Tajima-Nei) correct for multiple substitutions
		     # 7: REV (aka GTR)
		     # 8: UNREST 
		     # See Yang 1994 JME 39:105-111
		     
		     # model 8 special case of the REV model
		     # model 9 is special case of unrestricted model
		     # can also supply special rate parameters
		     # so for example (from pamlDOC.pdf
		     # $model  = '8 [2 (CT) (AG)]'; # TN93 
		     # $model  = '8 [2 (TA AT TG CA CG) (AG)]'; # TN93
		     # $model  = '9 [1 (TC CT AG GA)]; # K80
		     # $model  = '9 [0]'; # JC69
		     # $model  = '9 [11 (TA) (TG) (CT) (CA) (CG) (AT) (AC) (AG) (GT) (GC) (GA)],
		     
		     'outfile' => 'mlb',
		     'fix_kappa'=> [0,1], # 0:estimate kappa, 1:fix kappa
		     'kappa'    => '2.5', # initial or fixed kappa
		     'fix_alpha'=> [1,0], # 0: estimate gamma shape param
		                          # 1: fix it at alpha
		     'alpha'    => '0', # initial of fixed alpha
		                          # 0: infinity (constant rate)
		     'Malpha'   => [0,1], # different alphas for genes
		     
		     'fix_rho'=> [1,0], # 0: estimate gamma shape param
		                          # 1: fix it at alpha
		     'rho'    => '0', # initial of fixed alpha
		                          # 0: infinity (constant rate)
		     
		     'ncatG'    => '5', # number of categories in the dD,AdG, or nparkK models of rates
		     'nparK'    => [0..4], # rate-class models 
		                           # 1:rk 2:rk&fK 
                                           # 3:rK&MK(1/K) 4:rK&MK
		     'nhomo'    => [0..4], # 0 & 1: homogeneous, 
		                           # 2: kappa for brances
		                           # 3:N1 4:N2
		     'getSE'    => [0,1],
		     'RateAncestor' => [0,1,2], # rates (alpha > 0) or 
		                                # ancestral states
		     'cleandata' => [1,0], # remove sites with 
		                           # ambiguity data (1:yes or 0:no)
		     
		     'fix_blength' => [0,-1,1,2], # 0: ignore, -1: random, 
		                                  # 1: initial, 2: fixed
		     
		     'icode'    => [ 0..10], # (with RateAncestor=1. 
		                             #try "GC" in data,model=4,Mgene=4)
		     'ndata'    => [1..10],
		     'clock'    => [0..3], # 0: no clock, 1: clock, 2: local clock, 3: CombinedAnalysis
		     'Small_Diff' => '1e-6', #underflow issues?
		     'Mgene' => [0..4], # 0:rates, 1:separate; 2:diff pi, 3:diff kapa, 4:all diff
		     );
}


=head2 program_name

 Title   : program_name
 Usage   : $obj->program_name()
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
            return Bio::Root::IO->catfile($ENV{PAMLDIR}) if $ENV{PAMLDIR};
}

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::PAML::Baseml->new();
 Function: Builds a new Bio::Tools::Run::Phylo::PAML::Baseml object 
 Returns : Bio::Tools::Run::Phylo::PAML::Baseml
 Args    : -alignment => the L<Bio::Align::AlignI> object
           -tree => the L<Bio::Tree::TreeI> object if you want to use runmode
                    0 or 1
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)

=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
  my ($aln,$tree,$st) = $self->_rearrange([qw(ALIGNMENT TREE SAVE_TEMPFILES)],
				    @args);
  defined $aln && $self->alignment($aln);
  defined $tree && $self->tree($tree);
  defined $st  && $self->save_tempfiles($st);
  
  return $self;
}

=head2 run

 Title   : run
 Usage   : $yn->run();
 Function: run the Baseml analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : 3 values, 
           $rc = 1 for success, 0 for errors
           hash reference of the Yang calculated Ka/Ks values
                    this is a set of pairwise observations keyed as
                    sequencenameA->sequencenameB->datatype
           hash reference same as the previous one except it for the 
           Nei and Gojobori calculated Ka,Ks,omega values
 Args    : optionally, a value appropriate for alignment() and one for tree()
 NB      : Since Baseml doesn't handle spaces in tree node ids, if a tree is
           in use spaces will be converted to underscores in both the tree node
           ids and alignment sequence ids.

=cut

sub run {
   my ($self, $aln, $tree) = @_;
   $aln = $self->alignment($aln) if $aln;
   $tree = $self->tree($tree) if $tree;
   $aln ||= $self->alignment();
   $tree ||= $self->tree();
   
   my %params = $self->get_parameters;
   if( ! $aln ) { 
       $self->warn("must have supplied a valid aligment file in order to run baseml");
       return 0;
   }
   if ((defined $params{runmode} && ($params{runmode} == 0 || $params{runmode} == 1)) && ! $tree) {
        $self->warn("must have supplied a tree in order to run baseml in runmode 0 or 1");
        return 0;
   }
   
    # replace spaces with underscores in ids, since baseml really doesn't like
    # spaces (actually, the resulting double quotes) in tree ids
    if ($tree) {
        my $changed = 0;
        foreach my $thing ($aln->each_seq, $tree ? $tree->get_leaf_nodes : ()) {
            my $id = $thing->id;
            if ($id =~ / /) {
                $id =~ s/\s+/_/g;
                $thing->id($id);
                $changed = 1;
            }
        }
        if ($changed) {
            my $new_aln = $aln->new;
            foreach my $seq ($aln->each_seq) {
                $new_aln->add_seq($seq);
            }
            $aln = $new_aln;
            $aln = $self->alignment($aln);
            $tree = $self->tree($tree);
        }
        
        # check node and seq names match
        $self->_check_names;
    }
   
   # output the alignment and tree to tempfiles
   my $tempseqfile = $self->_write_alignment('phylip',
                                             -interleaved => 0,
                                             -idlinebreak => 1,
                                             -line_length => 60,
                                             -wrap_sequential => 1,
                                             -idlength    => $MINNAMELEN > $aln->maxdisplayname_length() ? $MINNAMELEN : $aln->maxdisplayname_length() +1);
   $tree = $self->_write_tree() if $tree;
   
   # now let's print the baseml.ctl file.
   # many of the these programs are finicky about what the filename is 
   # and won't even run without the properly named file.  Ack
   my $tmpdir = $self->tempdir();
   my $baseml_ctl = "$tmpdir/baseml.ctl";
   open(my $mlfh, ">$baseml_ctl") or $self->throw("cannot open $baseml_ctl for writing");
   print $mlfh "seqfile = $tempseqfile\n";
   print $mlfh "treefile = $tree\n" if $tree;

   my $outfile = $self->outfile_name;

   print $mlfh "outfile = $outfile\n";
   while( my ($param,$val) = each %params ) {
       next if $param eq 'outfile';
       print $mlfh "$param = $val\n";
   }
   close($mlfh);
   
   my ($rc,$parser) = (1);
   {
       my $cwd = cwd();
       my $exit_status;
       chdir($tmpdir);
       my $ynexe = $self->executable();
       $self->throw("unable to find executable for 'baseml'") unless $ynexe;
       open(my $run, "$ynexe |");
       my @output = <$run>;
       $exit_status = close($run);
       $self->error_string(join('', grep { /\berr(or)?: /io } @output));
       if ($self->error_string || !$exit_status) {
        $self->warn("There was an error - see error_string for the program output");
        $rc = 0;
       }
       eval {
	   $parser = Bio::Tools::Phylo::PAML->new(-file => "$tmpdir/mlb", 
						 -dir => "$tmpdir");

       };
       if( $@ ) {
	   $self->warn($self->error_string);
       }
       
       chdir($cwd);
   }
   if( $self->verbose > 0 ) {
       open(my $in, "$tmpdir/mlb");
       while(<$in>) {
       $self->debug($_);
       }
       close($in);
   }
    
   return ($rc,$parser);
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
     chomp($value);
      $self->{'error_string'} = $value;
    }
    return $self->{'error_string'};

}

=head2 alignment

 Title   : alignment
 Usage   : $baseml->alignment($aln);
 Function: Get/Set the L<Bio::Align::AlignI> object
 Returns : L<Bio::Align::AlignI> object
 Args    : [optional] L<Bio::Align::AlignI>
 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
 See also: L<Bio::SimpleAlign>

=cut

sub alignment{
   my $self = shift;
   return $self->_alignment(@_);
}

sub tree {
    my $self = shift;
    return $self->_tree(@_);
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
   return %{ $self->{'_basemlparams'} };
}


=head2 set_parameter

 Title   : set_parameter
 Usage   : $baseml->set_parameter($param,$val);
 Function: Sets a baseml parameter, will be validated against
           the valid values as set in the %VALIDVALUES class variable.  
           The checks can be ignored if on turns of param checks like this:
             $baseml->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $paramname => name of the parameter
           $value     => value to set the parameter to
 See also: L<no_param_checks()>

=cut

sub set_parameter{
   my ($self,$param,$value) = @_;
   
   if( ! defined $VALIDVALUES{$param} ) { 
       $self->warn("unknown parameter $param will not set unless you force by setting no_param_checks to true");
       return 0;
   } 
   if( ref( $VALIDVALUES{$param}) =~ /ARRAY/i &&
       scalar @{$VALIDVALUES{$param}} > 0 ) {
       
       my %allowed = map { $_ => 1 } @{ $VALIDVALUES{$param} };
       unless ( exists $allowed{$value} ) {
	   $self->warn("parameter $param specified value $value is not recognized, please see the documentation and the code for this module or set the no_param_checks to a true value");
	   return 0;
       }
   }
   $self->{'_basemlparams'}->{$param} = $value;
   return 1;
}

=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $baseml->set_default_parameters(0);
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the 
	    %VALIDVALUES class variable)
 Returns : none
 Args    : boolean: keep existing parameter values
 NB      : using this isn't an especially good idea! You don't need to do
           anything to end up using default paramters: hence 'default'!

=cut

sub set_default_parameters{
   my ($self,$keepold) = @_;
   $keepold = 0 unless defined $keepold;
   
   while( my ($param,$val) = each %VALIDVALUES ) {
       # skip if we want to keep old values and it is already set
       next if( defined $self->{'_basemlparams'}->{$param} && $keepold);
       if(ref($val)=~/ARRAY/i ) {
	   $self->{'_basemlparams'}->{$param} = $val->[0];
       }  else { 
	   $self->{'_basemlparams'}->{$param} = $val;
       }
   }
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
 Usage   : my $outfile = $baseml->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to


=cut

sub outfile_name {
    my $self = shift;
    if( @_ ) {
	return $self->{'_basemlparams'}->{'outfile'} = shift @_;
    }
    unless (defined $self->{'_basemlparams'}->{'outfile'}) {
        $self->{'_basemlparams'}->{'outfile'} = 'mlb';
    }
    return $self->{'_basemlparams'}->{'outfile'};    
}

=head2 tempdir

 Title   : tempdir
 Usage   : my $tmpdir = $self->tempdir();
 Function: Retrieve a temporary directory name (which is created)
 Returns : string which is the name of the temporary directory
 Args    : none


=cut

=head2 cleanup

 Title   : cleanup
 Usage   : $baseml->cleanup();
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

1;
