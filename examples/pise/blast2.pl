
use Bio::Tools::Run::AnalysisFactory::Pise;
use Bio::SeqIO;
use Bio::SearchIO;

$_in_seq = Bio::SeqIO->newFh (-file => $ARGV[0],
                              -format => "fasta");
my $seq = <$_in_seq>; 

# email is optional (although useful)
#$factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);
$factory = Bio::Tools::Run::AnalysisFactory::Pise->new();

my $blast2 = $factory->program('blast2');

$blast2->blast2('blastp');
$blast2->protein_db('swissprot');

my $job = $blast2->run( -query => $seq);
sleep 5;

my $parser_file = $job->save('blast2.txt');
print STDERR "Blast result saved in: $parser_file (",$job->jobid,")\n";

my $blast_report = new Bio::SearchIO ('-format' => 'blast',
				      '-fh'   => $job->fh('blast2.txt'));
my $result = $blast_report->next_result;
while( my $hit = $result->next_hit()) {
    print "\thit name: ", $hit->name(), "\n";
    while( my $hsp = $hit->next_hsp()) { 
	print "E: ", $hsp->evalue(), "frac_identical: ", 
	$hsp->frac_identical(), "\n";
    }
}

