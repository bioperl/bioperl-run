
use Bio::Tools::Run::AnalysisFactory::Pise;

#my $email = $ENV{USER} . "\@pasteur.fr";  # put your email

my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);

my $needle = $factory->program('needle');

my $job = $needle->run(-sequencea => $ARGV[0],
		       -seqall => $ARGV[1],
		       -gapopen => 5,
		       -gapextend => 1);

if ($job->error) {
    print ".............error: ",$job->error_message,".............\n";
    exit;
}

print STDERR "jobid: ", $job->jobid, "\n";
print $job->content('outfile.align');


