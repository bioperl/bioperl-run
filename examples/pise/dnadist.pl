
use Bio::Tools::Run::AnalysisFactory::Pise;

# email is optional (although useful)
#my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);
my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();

my $dnadist = $factory->program('dnadist');
my $job = $dnadist->run(-infile => $ARGV[0]);   # see dnadist.data

if ($job->error) {
    print ".............error: ",$job->error_message,".............\n";
    exit;
}

print STDERR "jobid: ", $job->jobid, "\n";
print $job->content('outfile');

my $neighbor = $factory->program('neighbor',
				 -infile => $job->fh('outfile'));
my $job = $neighbor->run;
if ($job->error) {
    print ".............error: ",$job->error_message,".............\n";
    exit;
}

print $job->content('outtree');


