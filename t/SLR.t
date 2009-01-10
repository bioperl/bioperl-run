# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules
##
# $Id$

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;

BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 7,
			   -requires_module => 'IO::String');
	use_ok('Bio::Root::IO');
	use_ok('Bio::Tools::Run::Phylo::SLR');
	use_ok('Bio::AlignIO');
	use_ok('Bio::TreeIO');
}

ok my $slr = Bio::Tools::Run::Phylo::SLR->new();

SKIP: {
	test_skip(-requires_executable => $slr,
		  -tests => 2);

        # first set
	my $alignio1 = Bio::AlignIO->new
            (-format => 'fasta',
             -file   => test_input_file('219877.cdna.fasta'));

	my $treeio1 = Bio::TreeIO->new
            (-format => 'newick',
             -file   => test_input_file('219877.tree'));

	my $aln1 = $alignio1->next_aln;
	my $tree1 = $treeio1->next_tree;

	$slr->alignment($aln1);
	$slr->tree($tree1);
	my ($rc,$results1) = $slr->run();
	ok defined($results1);

        # second set
    $slr = Bio::Tools::Run::Phylo::SLR->new();
	my $alignio2 = Bio::AlignIO->new
            (-format => 'fasta',
             -file   => test_input_file('277523.cdna.fasta'));

	my $treeio2 = Bio::TreeIO->new
            (-format => 'newick',
             -file   => test_input_file('277523.tree'));

	my $aln2 = $alignio2->next_aln;
	my $tree2 = $treeio2->next_tree;

	$slr->alignment($aln2);
	$slr->tree($tree2);
	my($rc2,$results2) = $slr->run();
	ok defined($results2);
#         my $positive_sites = $results2->{'constant'};
#         print "Site,Omega\n";
#         foreach my $site (@{$positive_sites}) {
#             # print "# Site  Neutral  Optimal   Omega    lower    upper LRT_Stat    Pval     Adj.Pval  Result Note\n";
#             print $site->[0], ",", $site->[3], "\n";
#         }

#         # third set
#         $slr = Bio::Tools::Run::Phylo::SLR->new();
# 	my $alignio3 = Bio::AlignIO->new
#             (-format => 'fasta',
#              -file   => 't/data/799906.cdna.fasta');

# 	my $treeio3 = Bio::TreeIO->new
#             (-format => 'newick',
#              -file   => 't/data/799906.tree');

# 	my $aln3 = $alignio3->next_aln;
# 	my $tree3 = $treeio3->next_tree;

# 	$slr->alignment($aln3);
# 	$slr->tree($tree3);
# 	my ($rc,$results3) = $slr->run();
#         my $sites = $results3->{'constant'};
# 	ok defined($results3);
#         print "Site,Omega\n";
#         foreach my $site (@{$sites}) {
#             # print "# Site  Neutral  Optimal   Omega    lower    upper LRT_Stat    Pval     Adj.Pval  Result Note\n";
#             print $site->[0], ",", $site->[3], "\n";
#         }

}
