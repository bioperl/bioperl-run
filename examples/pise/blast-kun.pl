#
# This example runs a blast2 on genpept and parse the results.
# (and shows how to save results)

use Bio::Tools::Run::AnalysisFactory::Pise;
use Bio::SeqIO;
use Bio::SearchIO;

$_in_seq = Bio::SeqIO->newFh (-file => $ARGV[0],
                              -format => "fasta");
my $seq = <$_in_seq>; 

$factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
my $blast2 = $factory->program('blast2', 
			       -location => 'http://kun.homelinux.com/cgi-bin/Pise/5.a/blast2.pl');

$blast2->blast2('blastp');
$blast2->protein_db('genpept');

my $job = $blast2->run( -query => $seq);
print STDERR "Job id: (",$job->jobid,")\n";

# You can save the blast output in a file:
#my $parser_file = $job->save('blast2.txt');
#print STDERR "Blast result saved in: $parser_file\n";

my $blast_report = new Bio::SearchIO ('-format' => 'blast',
                                      '-fh'   => $job->fh('blast2.txt'));
my $result = $blast_report->next_result;
while( my $hit = $result->next_hit()) {
    print "hit name: ", $hit->name(), "\n";
    while( my $hsp = $hit->next_hsp()) { 
        print "\tE: ", $hsp->evalue(), " frac_identical: ", 
        $hsp->frac_identical(), "\n";
    }
}
