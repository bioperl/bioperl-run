# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Hyphy::REL
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

Bio::Tools::Run::Phylo::Hyphy::REL - Wrapper around the Hyphy REL analysis

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Hyphy::REL;
  use Bio::AlignIO;
  use Bio::TreeIO;

  my $alignio = Bio::AlignIO->new(-format => 'fasta',
                                  -file   => 't/data/hyphy1.fasta');

  my $aln = $alignio->next_aln;

  my $treeio = Bio::TreeIO->new(
      -format => 'newick', -file => 't/data/hyphy1.tree');

  my $rel = Bio::Tools::Run::Phylo::Hyphy::REL->new();
  $rel->alignment($aln);
  $rel->tree($tree);
  my ($rc,$results) = $rel->run();

=head1 DESCRIPTION

This is a wrapper around the REL analysis of HyPhy ([Hy]pothesis
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


package Bio::Tools::Run::Phylo::Hyphy::REL;
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Hyphy::Base;
use Bio::Tools::Run::WrapperBase;

use base qw(Bio::Root::Root Bio::Tools::Run::Phylo::Hyphy::Base);


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
    return
        (
         {'geneticCode' => [ "Universal","VertebratemtDNA","YeastmtDNA","Mold/ProtozoanmtDNA",
                             "InvertebratemtDNA","CiliateNuclear","EchinodermmtDNA","EuplotidNuclear",
                             "Alt.YeastNuclear","AscidianmtDNA","FlatwormmtDNA","BlepharismaNuclear"]},
         {'tempalnfile' => undef }, # aln file goes here
         {'temptreefile' => undef }, # tree file goes here
         {'Model' => [ "Null for Test 1", "Null for Test 2", "Alternative"]},
         {'outfile' => undef } # site-by-site conditional probabilities go to this file
        );
}

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Hyphy::REL->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Hyphy::REL object
 Returns : Bio::Tools::Run::Phylo::Hyphy::REL
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
   $ubl) = $self->_rearrange([qw(ALIGNMENT TREE SAVE_TEMPFILES PARAMS EXECUTABLE)], @args);
   defined $aln && $self->alignment($aln);
   defined $tree && $self->tree($tree);
   defined $st  && $self->save_tempfiles($st);
   defined $exe && $self->executable($exe);

   #my $tsvfile = $self->tempdir() . "/results.tsv";

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
 Usage   : my ($rc,$results) = $rel->run($aln);
 Function: run the rel analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : Return code, Hash
 Args    : L<Bio::Align::AlignI> object,
         L<Bio::Tree::TreeI> object [optional]


=cut

sub run {
    my $self = shift;
    my ($rc,$run_results) = $self->SUPER::run();
    my $results = {};
    my $outfile = $self->outfile_name();
    open(OUTFILE, "$outfile") or $self->throw("cannot open $outfile for reading");
    my $readed_header = 0;
    my @elems;
    while (<OUTFILE>) {
        if ($readed_header) {
           # REL results are csv
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

   my $batchfile = "YangNielsenBranchSite2005.bf";
   $self->SUPER::create_wrapper($batchfile);
}


1;
