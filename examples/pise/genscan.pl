
use Bio::Tools::Run::AnalysisFactory::Pise;
use Bio::SeqIO;
use Bio::Tools::Genscan;

$_in_seq = Bio::SeqIO->newFh (-file => $ARGV[0],
			      -format => "fasta");
my $seq = <$_in_seq>; 

# email is optional (although useful)
# my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);
my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();

my $genscan = $factory->program('genscan',
				# other values: Arabidopsis.smat, Maize.smat
				-parameter_file => "HumanIso.smat"
				);
$genscan->seq($seq);	# see t/data/Genscan.FastA
my $job = $genscan->run();

if ($job->error) {
    print ".............error: ",$job->error_message,".............\n";
    exit;
}

#print STDERR $job->content('genscan.out');

my $parser_file = $job->save('genscan.out');
$parser = Bio::Tools::Genscan->new(-file => $parser_file);
while(my $gene = $parser->next_prediction()) {
    my $prot = $gene->predicted_protein;
    print "protein (", ref($prot), ") :\n", $prot->seq, "\n\n";
}

print STDERR "jobid: ", $job->jobid, "\n";

