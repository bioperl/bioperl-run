# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Hyphy::SLAC
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

Bio::Tools::Run::Phylo::Hyphy::SLAC - Wrapper around the Hyphy SLAC analysis

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Hyphy::SLAC;
  use Bio::AlignIO;
  use Bio::TreeIO;

  my $alignio = Bio::AlignIO->new(-format => 'fasta',
  			         -file   => 't/data/hyphy1.fasta');

  my $aln = $alignio->next_aln;

  my $treeio = Bio::TreeIO->new(
      -format => 'newick', -file => 't/data/hyphy1.tree');

  my $slac = Bio::Tools::Run::Phylo::Hyphy::SLAC->new();
  $slac->alignment($aln);
  $slac->tree($tree);
  my ($rc,$results) = $slac->run();


=head1 DESCRIPTION

This is a wrapper around the SLAC analysis of HyPhy ([Hy]pothesis
Testing Using [Phy]logenies) package of Sergei Kosakowsky Pond,
Spencer V. Muse, Simon D.W. Frost and Art Poon.  See
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


package Bio::Tools::Run::Phylo::Hyphy::SLAC;
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Hyphy::Base;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::Phylo::Hyphy::Base);

=head2 Default Values

Valid and default values for SLAC are listed below.  The default
values are always the first one listed.  These descriptions are
essentially lifted from the python wrapper or provided by the author.

INCOMPLETE DOCUMENTATION OF ALL METHODS

=cut

=head2 valid_values

 Title   : valid_values
 Usage   : $factory->valid_values()
 Function: returns the possible parameters
 Returns:  an array holding all possible parameters. The default
values are always the first one listed.  These descriptions are
essentially lifted from the python wrapper or provided by the author.
 Args    : None

=cut



sub valid_values {
    my $null = ($^O =~ m/mswin/i) ? 'NUL' : '/dev/null';
    return
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
         {'Model Fit Results' => [ $null] }, # Windows have NUL instead of /dev/null
         {'dN/dS bias parameter' => [ { "Estimate dN/dS only" => undef },
                                      { "Neutral" => undef },
                                      { "Estimate" => undef },
                                      { "Estimate + CI" => undef },
                                      { "User" => '3' } ] },
         {'Ancestor Counting' => [ 'Single Ancestor Counting','Weighted Ancestor Counting',
                                  'Sample Ancestal States','Process Sampled Ancestal States',
                                  'One rate FEL','Two rate FEL','Rate Distribution',
                                  'Full site-by-site LRT','Multirate FEL'] },
         {'SLAC Options' => ['Full tree','Tips vs Internals'] },
         {'Treatment of Ambiguities' => ['Resolved','Averaged'] },
         {'Test Statistic' => ['Approximate','Simulated Null'] },
         {'Significance level' => '0.05' },
         {'Output options' => 'Export to File' }, #we force a tsv file here
         {'outfile' => undef }, # outfile goes here
         {'Rate class estimator' => [ 'Skip','Count'] },
        );
}


=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Hyphy::SLAC->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Hyphy::SLAC object
 Returns : Bio::Tools::Run::Phylo::Hyphy::SLAC
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
 Usage   : my ($rc,$results) = $slac->run($aln);
 Function: run the slac analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : Return code, hash
 Args    : L<Bio::Align::AlignI> object,
	   L<Bio::Tree::TreeI> object [optional]


=cut

sub run {
    my $self = shift;
    my $results = {};
    my ($rc, $run_output) = $self->SUPER::run();
    my $outfile = $self->outfile_name();
    open(OUTFILE, "$outfile") or $self->throw("cannot open $outfile for reading");
    my $readed_header = 0;
    my @elems;
    while (my $line = <OUTFILE>) {
       if ($readed_header) {
           # SLAC results are tsv
           my @values = split("\t",$line);
           for my $i (0 .. (scalar(@values)-1)) {
               $elems[$i] =~ s/\n//g;
               push @{$results->{$elems[$i]}}, $values[$i];
           }
       } else {
           @elems = split("\t",$line);
           $readed_header = 1;
       }
    }
    return ($rc, $results);
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

   my $batchfile = "QuickSelectionDetection.bf";
   $self->SUPER::create_wrapper($batchfile);
}

1;
