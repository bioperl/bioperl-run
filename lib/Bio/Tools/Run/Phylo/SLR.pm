# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::SLR
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

Bio::Tools::Run::Phylo::SLR - Wrapper around the SLR program

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::SLR;
  use Bio::AlignIO;
  use Bio::TreeIO;
  use Bio::SimpleAlign;

  my $alignio = Bio::AlignIO->new
      (-format => 'fasta',
       -file   => 't/data/219877.cdna.fasta');

  my $aln = $alignio->next_aln;

  my $treeio = Bio::TreeIO->new
      (-format => 'newick', -file => 't/data/219877.tree');

  my $tree = $treeio->next_tree;

  my $slr = Bio::Tools::Run::Phylo::SLR->new();
  $slr->alignment($aln);
  $slr->tree($tree);
  # $rc = 1 for success, 0 for errors
  my ($rc,$results) = $slr->run();

  my $positive_sites = $results->{'positive'};

  print "# Site\tNeutral\tOptimal\tOmega\t",
        "lower\tupper\tLRT_Stat\tPval\tAdj.Pval\tResult\tNote\n";
  foreach my $positive_site (@$positive_sites) {
      print 
          $positive_site->[0], "\t",
          $positive_site->[1], "\t",
          $positive_site->[2], "\t",
          $positive_site->[3], "\t",
          $positive_site->[4], "\t",
          $positive_site->[5], "\t",
          $positive_site->[6], "\t",
          $positive_site->[7], "\t",
          $positive_site->[8], "\t",
          "positive\n";
  }

=head1 DESCRIPTION

This is a wrapper around the SLR program. See
http://www.ebi.ac.uk/goldman/SLR/ for more information.

This module is more about generating the proper ctl file and
will run the program in a separate temporary directory to avoid
creating temp files all over the place.

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


#' keep my emacs happy
# Let the code begin...


package Bio::Tools::Run::Phylo::SLR;
use vars qw(@ISA %VALIDVALUES $MINNAMELEN $PROGRAMNAME $PROGRAM);
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::SimpleAlign;
use Bio::Tools::Run::WrapperBase;
use Cwd;
use File::Spec;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

=head2 Default Values

INCOMPLETE DOCUMENTATION OF ALL METHODS

seqfile [incodon]
  File from which to read alignment of codon sequences. The file
  should be in PAML format.

treefile [intree]
  File from which tree should be read. The tree should be in Nexus
  format

outfile [slr.res]
  File to which results are written. If the file already exists, it will
  be overwritten.

reoptimise [1]
  Should the branch lengths, omega and kappa be reoptimized?
  0 - no
  1 - yes.

kappa [2.0]
  Value for kappa. If 'reoptimise' is specified, the value
  given will be used as am initial estimate,

omega [0.1]
  Value for omega (dN/dS). If 'reoptimise' is specified, the value
  given will be used as an initial estimate.

codonf [0]
  How codon frequencies are estimated:
    0: F61/F60  Estimates used are the empirical frequencies from the
  data.
    1: F3x4     The frequencies of nucleotides at each codon position
  are estimated from the data and then multiplied together to get the
  frequency of observing a given codon. The frequency of stop codons is
  set to zero, and all other frequencies scaled appropriately.
    2: F1x4     Nucleotide frequencies are estimated from the data
  (not taking into account at which position in the codon it occurs).
  The nucleotide frequencies are multiplied together to get the frequency 
  of observing and then corrected for stop codons.

freqtype [0]
  How codon frequencies are incorporated into the substitution matrix.
  0: q_{ij} = pi_{j} s_{ij}
  1: q_{ij} = \sqrt(pi_j/pi_i) s_{ij}
  2: q_{ij} = \pi_{n} s_{ij}, where n is the nucleotide that the 
  subsitution is to.
  3: q_{ij} = s_{ij} / pi_i
  Option 0 is the tradition method of incorporating equilibrium frequencies
  into subsitution matrices (Felsenstein 1981; Goldman and Yang, 1994)
  Option 1 is described by Goldman and Whelan (2002), in this case with the
  additional parameter set to 0.5.
  Option 2 was suggested by Muse and Gaut (1994).
  Option 3 is included as an experiment, originally suggested by Bret Larget.
  it does not appear to describe evolution very successfully and should not
  be used for analyses.

  Kosakovsky-Pond has repeatedly stated that he finds incorporating codon
  frequencies in the manner of option 2 to be superior to option 0. We find
  that option 1 tends to perform better than either of these options.

positive_only [0]
  If only positively selected sites are of interest, set this to "1".
  Calculation will be slightly faster, but information about sites under
  purifying selection is lost. 

gencode [universal]
  Which genetic code to use when determining whether a given mutation
  is synonymous or nonsynonymous. Currently only "universal" and
  "mammalian" mitochondrial are supported.

nucleof [0]
  Allow for empirical exchangabilities for nucleotide substitution.
  0: No adjustment. All nucleotides treated the same, modulo 
  transition / transversion.
  1: The rate at which a substitution caused a mutation from nucleotide
  a to nucleotide b is adjust by a constant N_{ab}. This adjustment is 
  in addition to other adjustments (e.g. transition / transversion or
  base frequencies).

aminof [0]
  Incorporate amino acid similarity parameters into substitution matrix,
  adjusting omega for a change between amino acid i and amino acid j.
  A_{ij} is a symmetric matrix of constants representing amino acid
  similarities.
  0: Constant omega for all amino acid changes
  1: omega_{ij} = omega^{A_{ij}}
  2: omega_{ij} = a_{ij} log(omega) / [ 1 - exp(-a_{ij} log(omega)) ]
  Option 1 has the same form as the original codon subsitution model 
  proposed by Goldman and Yang (but with potentially different 
  constants).
  Option 2 has a more population genetic derivtion, with omega being
  interpreted as the ratio of fixation probabilities.

nucfile [nuc.dat]
  If nucleof is non-zero, read nucleotide substitution constants from
  nucfile. If this file does not exist, hard coded constants are used.

aminofile [amino.dat]
  If aminof is non-zero, read amino acid similarity constants from
  aminofile. If this file does not exist, hard coded constants are used.

timemem [0]
  Print summary of real time and CPU time used. Will eventually print
  summary of memory use as well.

ldiff [3.841459]
  Twice log-likelihood difference used as a threshold for calculating 
  support (confidence) intervals for sitewise omega estimates. This 
  value should be the quantile from a chi-square distribution with one
  degree of freedom corresponding to the support required. 
  E.g. qchisq(0.95,1) = 3.841459
     0.4549364 = 50% support
     1.323304  = 75% support
     2.705543  = 90% support
     3.841459  = 95% support
     6.634897  = 99% support
     7.879439  = 99.5% support
    10.82757   = 99.9% support

paramin []
  If not blank, read in parameters from file given by the argument.

paramout []
  If not blank, write out parameter estimates to file given.

skipsitewise [0]
  Skip sitewise estimation of omega. Depending on other options given, 
  either calculate maximum likelihood or likelihood fixed at parameter
  values given.

seed [0]
  Seed for random number generator. If seed is 0, then previously 
  produced seed file (~/.rng64) is used. If this does not exist, the
  random number generator is initialised using the clock.

saveseed [1]
  If non-zero, save finial seed in file (~/.rng64) to be used as initial
  seed in future runs of program.

=head2 Results Format

Results file (default: slr.res)
------------
Results are presented in nine columns

Site
  Number of sites in alignment

Neutral
  (minus) Log-probability of observing site given that it was 
  evolving neutrally (omega=1)

Optimal
  (minus) Log-probability of observing site given that it was 
  evolving at the optimal value of omega.

Omega
  The value of omega which maximizes the log-probability of observing 

LRT_Stat
  Log-likelihood ratio statistic for non-neutral selection (or
  positive selection if the positive_only option is set to 1).
  LRT_Stat = 2 * (Neutral-Optimal)

Pval
  P-value for non-neutral (or positive) selection at a site,
  unadjusted for multiple comparisons.

Adj. Pval 
  P-value for non-neutral (or positive) selection at a site, after
  adjusting for multiple comparisons using the Hochberg procedure 
  (see the file "MultipleComparisons.txt" in the doc directory).

Result
  A simple visual guide to the result. Sites detected as having been
  under positive selection are marked with a '+', sites under 
  purifying selection are marked with '-'. The number of symbols
    Number symbols      Threshold
          1             95%
          2             99%
          3             95% after adjustment
          4             99% after adjustment

  Occasionally the result may also contain an exclamation mark. This
  indicates that the observation at a site is not significantly
  different from random (equivalent to infinitely strong positive
  selection). This may indicate that the alignment at that site is bad

Note

  The following events are flagged:
  Synonymous            All codons at a site code for the same amino 
                        acid.
  Single character      Only one sequence at the site is ungapped,
                        the result of a recent insertion for example.
  All gaps              All sequences at a site contain a gap
                        character.

  Sites marked "Single character" or "All gaps" are not counted
  towards the number of sites for the purposes of correcting for
  multiple comparisons since it is not possible to detect selection
  from none or one observation under the assumptions made by the
  sitewise likelihood ratio test.

=cut


#' keep my emacs happy

BEGIN { 

    $MINNAMELEN = 25;
    $PROGRAMNAME = 'Slr_Linux_static';
    if ($^O =~ /darwin/i) {
        $PROGRAMNAME = 'Slr_osx';
    } elsif ($^O =~ /mswin/i) {
        $PROGRAMNAME = 'Slr_windows.exe';
    }
    if( defined $ENV{'SLRDIR'} ) {
	$PROGRAM = Bio::Root::IO->catfile($ENV{'SLRDIR'},$PROGRAMNAME). ($^O =~ /mswin/i ?'_windows.exe':'');;
    }
   
    # valid values for parameters, the default one is always
    # the first one in the array
    # example file provided with the package
    %VALIDVALUES = (
                    'outfile' => 'slr.res',
                    'reoptimise'   => [ 1,0],
                    'kappa'    => '2.0',
                    'omega'    => '0.1',
                    'codonf' => [ 0, 1,2],
                    'freqtype' => [ 0, 1,2,3],
                    'positive_only' => [ 0, 1],
                    'gencode' => [ "universal", "mammalian"],
                    'nucleof' => [ 0, 1],
                    'aminof' => [ 0, 1,2],
                    'nucfile' => '',
                    'aminofile' => '',
                    'timemem' => [ 0, 1],
                    'ldiff' => [ 3.841459, 0.4549364,1.323304,2.705543,6.634897,7.879439,10.82757],
                    'paramin' => '',
                    'paramout' => '',
                    'skipsitewise' => [ 0, 1],
                    'seed' => [0],
                    'saveseed' => [ 1, 0]
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
        return Bio::Root::IO->catfile($ENV{SLRDIR}) if $ENV{SLRDIR};
}


=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::SLR->new();
 Function: Builds a new Bio::Tools::Run::Phylo::SLR object 
 Returns : Bio::Tools::Run::Phylo::SLR
 Args    : -alignment => the Bio::Align::AlignI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -tree => the Bio::Tree::TreeI object
           -params => a hashref of SLR parameters (all passed to set_parameter)
           -executable => where the SLR executable resides

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>

=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
  my ($aln, $tree, $st, $params, $exe, 
      $ubl) = $self->_rearrange([qw(ALIGNMENT TREE SAVE_TEMPFILES 
				    PARAMS EXECUTABLE)],
				    @args);
  defined $aln && $self->alignment($aln);
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
 Usage   : my $rundir = $slr->prepare($aln);
 Function: prepare the SLR analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : value of rundir
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object

=cut

sub prepare{
   my ($self,$aln,$tree) = @_;
   unless ( $self->save_tempfiles ) {
       # brush so we don't get plaque buildup ;)
       $self->cleanup();
   }
   $tree = $self->tree unless $tree;
   $aln  = $self->alignment unless $aln;
   if( ! $aln ) { 
       $self->warn("must have supplied a valid alignment file in order to run SLR");
       return 0;
   }
   if( ! $tree ) { 
       $self->warn("must have supplied a valid tree file in order to run SLR");
       return 0;
   }
   my ($tempdir) = $self->tempdir();
   my ($tempseqFH,$tempseqfile);

   # Reorder the alignment according to the tree
   my $ct = 1;
   my %order;
   foreach my $node ($tree->get_leaf_nodes) {
       $order{$node->id_output} = $ct++;
   }
   my @seq; my @ids;
   foreach my $seq ( $aln->each_seq() ) {
       push @seq, $seq;
       push @ids, $seq->display_id;
   }
   # use the map-sort-map idiom:
   my @sorted = map { $_->[1] } sort { $a->[0] <=> $b->[0] } map { [$order{$_->id()}, $_] } @seq;
   my $sorted_aln = Bio::SimpleAlign->new();
   foreach (@sorted) {
       $sorted_aln->add_seq($_);
   }

   # Rename the leaf nodes in the tree from 1 to n
   $ct = 1;
   foreach my $node ($tree->get_leaf_nodes) {
       $node->id($ct++);
   }

   ($tempseqFH,$tempseqfile) = $self->io->tempfile
       ('-dir' => $tempdir, 
        UNLINK => ($self->save_tempfiles ? 0 : 1));
   my $alnout = Bio::AlignIO->new('-format'      => 'phylip',
                                  '-fh'          => $tempseqFH,
                                  '-interleaved' => 0,
                                  '-idlinebreak' => 1,
                                  '-idlength'    => $MINNAMELEN > $aln->maxdisplayname_length() ? $MINNAMELEN : $aln->maxdisplayname_length() +1);

   $alnout->write_aln($sorted_aln);
   $alnout->close();
   undef $alnout;
   close($tempseqFH);

   my ($temptreeFH,$temptreefile);
   ($temptreeFH,$temptreefile) = $self->io->tempfile
       ('-dir' => $tempdir, 
        UNLINK => ($self->save_tempfiles ? 0 : 1));

   my $treeout = Bio::TreeIO->new('-format' => 'newick',
                                  '-fh'     => $temptreeFH);

   # We need to add a line with the num of leaves ($ct-1) and the
   # num of trees (1)
   $treeout->_print(sprintf("%d 1\n",($ct-1)));
   $treeout->write_tree($tree);
   $treeout->close();
   close($temptreeFH);

   # now let's print the ctl file.
   # many of the these programs are finicky about what the filename is 
   # and won't even run without the properly named file.

   my ($treevolume,$treedirectories,$treefile) = File::Spec->splitpath( $temptreefile );
   my ($alnvolume,$alndirectories,$alnfile) = File::Spec->splitpath( $tempseqfile );
   my $slr_ctl = "$tempdir/slr.ctl";
   open(SLR, ">$slr_ctl") or $self->throw("cannot open $slr_ctl for writing");
   print SLR "seqfile\: $alnfile\n";
   print SLR "treefile\: $treefile\n";
   my $outfile = $self->outfile_name;
   print SLR "outfile\: $outfile\n";

   my %params = $self->get_parameters;
   while( my ($param,$val) = each %params ) {
       next if $param eq 'outfile';
       print SLR "$param\: $val\n";
   }
   close(SLR);
   return $tempdir;
}



=head2 run

 Title   : run
 Usage   : my ($rc,$parser) = $slr->run($aln,$tree);
 Function: run the SLR analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : Return code, L<Bio::Tools::Phylo::SLR>
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object


=cut

sub run {
   my ($self) = shift;;
   my $outfile = $self->outfile_name;
   my $tmpdir = $self->prepare(@_);

   #my ($rc,$parser) = (1);
   my ($rc,$results) = (1);
   {
       my $cwd = cwd();
       my $exit_status;
       chdir($tmpdir);
       my $slrexe = $self->executable();
       $self->throw("unable to find or run executable for SLR") unless $slrexe && -e $slrexe && -x _;
       my $run;
       open($run, "$slrexe |") or $self->throw("Cannot open exe $slrexe");
       my @output = <$run>;
       $exit_status = close($run);
       $self->error_string(join('',@output));
       if( (grep { /\berr(or)?: /io } @output)  || !$exit_status) {
	   $self->warn("There was an error - see error_string for the program output");
	   $rc = 0;
       }
       eval {
           open RESULTS, "$tmpdir/$outfile" or die "couldnt open results file: $!\n";
           my $okay = 0;
           my $sites;
           my $type = 'default';
           while (<RESULTS>) {
               chomp $_;
               if ( /^\#/ ) {next;}
               if ( /\!/ ) {$type = 'random';} # random is last
               elsif ( /\+/ ) {$type = 'positive';}
               elsif ( /\-\s+/ ) {$type = 'negative';}
               elsif ( /Constant/ ) {$type = 'constant';}
               elsif ( /All gaps/ ) {$type = 'all_gaps';}
               elsif ( /Single character/ ) {$type = 'single_character';}
               elsif ( /Synonymous/ ) {$type = 'synonymous';}
               else  {$type = 'default'}
               if ( /^\s+(\d+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/ ) {
                   push @{$sites->{$type}}, [$1,$2,$3,$4,$5,$6,$7,$8,$9];
               } else {
                   $DB::single=1;1;
               }
           }
           $results = $sites;
           close RESULTS;
           # TODO: we could have a proper parser object
           # 	   $parser = Bio::Tools::Phylo::SLR->new(-file => "$tmpdir/$outfile",
           # 						 -dir => "$tmpdir");
       };
       if( $@ ) {
	   $self->warn($self->error_string);
       }
       chdir($cwd);
   }
   #   return ($rc,$parser);
   return ($rc,$results);
}

=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysus run is stored.
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
 Usage   : $slr->align($aln);
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
 Usage   : $slr->tree($tree, %params);
 Function: Get/Set the L<Bio::Tree::TreeI> object
 Returns : L<Bio::Tree::TreeI> 
 Args    : [optional] $tree => L<Bio::Tree::TreeI>,

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

sub get_parameters{
   my ($self) = @_;
   # we're returning a copy of this
   return %{ $self->{'_slrparams'} };
}


=head2 set_parameter

 Title   : set_parameter
 Usage   : $slr->set_parameter($param,$val);
 Function: Sets a SLR parameter, will be validated against
           the valid values as set in the %VALIDVALUES class variable.  
           The checks can be ignored if one turns off param checks like this:
             $slr->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $param => name of the parameter
           $value => value to set the parameter to
 See also: L<no_param_checks()>

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
   $self->{'_slrparams'}->{$param} = $value;
   return 1;
}

=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $slr->set_default_parameters(0);
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
       next if( defined $self->{'_slrparams'}->{$param} && $keepold);
       if(ref($val)=~/ARRAY/i ) {
	   $self->{'_slrparams'}->{$param} = $val->[0];
       }  else { 
	   $self->{'_slrparams'}->{$param} = $val;
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


=head2 save_tempfiles

 Title   : save_tempfiles
 Usage   : $obj->save_tempfiles($newval)
 Function: 
 Returns : value of save_tempfiles
 Args    : newvalue (optional)


=cut

=head2 outfile_name

 Title   : outfile_name
 Usage   : my $outfile = $slr->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to


=cut

sub outfile_name {
    my $self = shift;
    if( @_ ) {
	return $self->{'_slrparams'}->{'outfile'} = shift @_;
    }
    unless (defined $self->{'_slrparams'}->{'outfile'}) {
        $self->{'_slrparams'}->{'outfile'} = 'out.res';
    }
    return $self->{'_slrparams'}->{'outfile'};
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
 Usage   : $slr->cleanup();
 Function: Will cleanup the tempdir directory after an SLR run
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
