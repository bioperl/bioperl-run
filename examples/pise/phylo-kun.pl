#
# This example will run a dnadist on an alignment, save the
# matrix in a file dnadist.outfile, the run a neighbor-joining
# on this distance matrix and print the tree file on standard output.
#

use Bio::Tools::Run::AnalysisFactory::Pise;
use Bio::AlignIO;

$in = Bio::AlignIO->new('-file' => $ARGV[0]);
$aln = $in->next_aln();

$factory = Bio::Tools::Run::AnalysisFactory::Pise->new(
	     -location => 'http://kun.homelinux.com/cgi-bin/Pise/5.a/');
my $dnadist = $factory->program('dnadist');
my $job = $dnadist->run(-infile => $aln);
if ($job->error) {
    print ".............error: ",$job->error_message,".............\n";
    exit;
}
print STDERR "Job id: (",$job->jobid,")\n";

my $matrix = $job->lookup_piped_file('phylip_dist');
my $matrixfile = $job->save($matrix, 'dnadist.outfile');

my $neighbor = $factory->program('neighbor');
my $job = $neighbor->run(-infile => $matrixfile);
if ($job->error) {
    print ".............error: ",$job->error_message,".............\n";
    exit;
}
print $job->content('outtree');

