# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Hyphy::FEL
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

Bio::Tools::Run::Phylo::Hyphy::FEL - Wrapper around the Hyphy FEL analysis

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Hyphy::FEL;
  use Bio::AlignIO;
  use Bio::TreeIO;

  my $alignio = Bio::AlignIO->new(-format => 'fasta',
  			         -file   => 't/data/hyphy1.fasta');

  my $aln = $alignio->next_aln;

  my $treeio = Bio::TreeIO->new(
      -format => 'newick', -file => 't/data/hyphy1.tree');

  my $fel = Bio::Tools::Run::Phylo::Hyphy::FEL->new();
  $fel->alignment($aln);
  $fel->tree($tree);
  my ($rc,$results) = $fel->run();

=head1 DESCRIPTION

This is a wrapper around the FEL analysis of HyPhy ([Hy]pothesis
Testing Using [Phy]logenies) package of Sergei Kosakowsky Pond,
Spencer V. Muse, Simon D.W. Frost and Art Poon.  See
http://www.hyphy.org for more information.

This module will generate the correct list of options for interfacing
with TemplateBatchFiles/Ghostrides/Wrapper.bf.

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


package Bio::Tools::Run::Phylo::Hyphy::FEL;
use vars qw(@ISA @VALIDVALUES $PROGRAMNAME $PROGRAM);
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Hyphy::Base;
use Bio::Tools::Run::WrapperBase;

@ISA = qw(Bio::Tools::Run::Phylo::Hyphy::Base);

=head2 Default Values

Valid and default values for FEL are listed below.  The default
values are always the first one listed.  These descriptions are
essentially lifted from the python wrapper or provided by the author.

INCOMPLETE DOCUMENTATION OF ALL METHODS

=cut

BEGIN { 
    @VALIDVALUES = 
        (
         {'geneticCode' => [ "Universal","VertebratemtDNA","YeastmtDNA","Mold/ProtozoanmtDNA",
                             "InvertebratemtDNA","CiliateNuclear","EchinodermmtDNA","EuplotidNuclear",
                             "Alt.YeastNuclear","AscidianmtDNA","FlatwormmtDNA","BlepharismaNuclear"]},
         {'New/Restore' => [ "New Analysis", "Restore"]},
         {'tempalnfile' => undef }, # aln file goes here
         {'Model Options' => [ { "Custom" => '010010' },
                               { "Default" => undef } ] 
         },
         {'temptreefile' => undef }, # tree file goes here
         {'Model Fit Results' => [ '/dev/null'] }, # this will not work under Windows
         {'dN/dS bias parameter' => [ { "Estimate dN/dS only" => undef },
                                      { "Neutral" => undef },
                                      { "Estimate" => undef },
                                      { "Estimate + CI" => undef },
                                      { "User" => '3' } ] },
         {'Ancestor Counting' => [ 'Two rate FEL','Single Ancestor Counting','Weighted Ancestor Counting',
                                  'Sample Ancestal States','Process Sampled Ancestal States',
                                  'One rate FEL','Rate Distribution',
                                  'Full site-by-site LRT','Multirate FEL'] },
         {'Significance level' => '0.05' },
         {'Branch Options' => ['Internal Only','All','A Subtree only','Custom subset'] },
         {'outfile' => undef }, # outfile goes here
        );
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Hyphy::FEL->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Hyphy::FEL object 
 Returns : Bio::Tools::Run::Phylo::Hyphy::FEL
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


=head2 run

 Title   : run
 Usage   : my ($rc,$results) = $fel->run($aln);
 Function: run the fel analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : Return code, Hash
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object [optional]


=cut

sub run {
   my ($self,$aln,$tree) = @_;

   $self->prepare($aln,$tree) unless (defined($self->{'_prepared'}));
   my ($rc,$results) = (1);
   {
       my $commandstring;
       my $exit_status;
       my $tempdir = $self->tempdir;
       my $felexe = $self->executable();
       $self->throw("unable to find or run executable for 'HYPHY'") unless $felexe && -e $felexe && -x _;
       $commandstring = $felexe . " BASEPATH=" . $self->program_dir . " " . $self->{'_wrapper'};
       open(RUN, "$commandstring |") or $self->throw("Cannot open exe $felexe");
       my @output = <RUN>;
       $exit_status = close(RUN);
       $self->error_string(join('',@output));
       if( (grep { /\berr(or)?: /io } @output)  || !$exit_status) {
	   $self->warn("There was an error - see error_string for the program output");
	   $rc = 0;
       }
       my $outfile = $self->outfile_name;
       eval {
	   open(OUTFILE, "$outfile") or $self->throw("cannot open $outfile for reading");
           my $readed_header = 0;
           my @elems;
           while (<OUTFILE>) {
               if ($readed_header) {
                   # FEL results are csv
                   my @values = split("\,",$_);
                   for my $i (0 .. (scalar(@values)-1)) {
                       $elems[$i] =~ s/\n//g;
                       push @{$results->{$elems[$i]}}, $values[$i];
                   }
               } else {
                   @elems = split("\,",$_);
                   $readed_header = 1;
               }
           }
       };
       if( $@ ) {
	   $self->warn($self->error_string);
       }
   }
   unless ( $self->save_tempfiles ) {
       unlink($self->{'_wrapper'});
      $self->cleanup();
   }
   return ($rc,$results);
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
   my $self = shift;

   my $batchfile = 'QuickSelectionDetection.bf';
   $self->SUPER::create_wrapper($batchfile);
}


=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysus run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)


=cut

=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $fel->set_default_parameters(0);
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the 
	    %VALIDVALUES class variable)
 Returns : none
 Args    : boolean: keep existing parameter values


=cut

sub set_default_parameters {
   my ($self,$keepold) = @_;
   $keepold = 0 unless defined $keepold;
   foreach my $elem (@VALIDVALUES) {
       my ($param,$val) = each %$elem;
       # skip if we want to keep old values and it is already set
       if (ref($val)=~/ARRAY/i ) {
           unless (ref($val->[0])=~/HASH/i) {
               push @{ $self->{'_orderedparams'} }, {$param, $val->[0]};
           } else {
               $val = $val->[0];
           }
       } 
       if ( ref($val) =~ /HASH/i ) { 
           my $prevparam;
           while (defined($val)) {
               last unless (ref($val) =~ /HASH/i);
               last unless (defined($param));
               $prevparam = $param;
               ($param,$val) = each %{$val};
               push @{ $self->{'_orderedparams'} }, {$prevparam, $param};
               push @{ $self->{'_orderedparams'} }, {$param, $val} if (defined($val));
           }
       } elsif (ref($val) !~ /HASH/i && ref($val) !~ /ARRAY/i) { 
           push @{ $self->{'_orderedparams'} }, {$param, $val};
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


=head2 save_tempfiles

 Title   : save_tempfiles
 Usage   : $obj->save_tempfiles($newval)
 Function: 
 Returns : value of save_tempfiles
 Args    : newvalue (optional)


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
 Usage   : $fel->cleanup();
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
