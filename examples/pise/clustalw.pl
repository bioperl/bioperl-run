
use Bio::Tools::Run::AnalysisFactory::Pise;
use Bio::AlignIO;

$in = Bio::AlignIO->new('-file' => $ARGV[0]);
$aln = $in->next_aln();

#my $email = $ENV{USER} . "\@pasteur.fr";  # your email
$factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);
my $clustalw = $factory->program('clustalw');

my $job = $clustalw->run( -infile => $aln);
if ($job->error) {
	print $job->error_message, "\n";
}

print STDERR "jobid: ", $job->jobid, "\n";



