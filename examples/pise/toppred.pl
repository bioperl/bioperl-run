#
# This example needs the Toppred parser developped by K. Schuerer
# for the XML output of the Toppred2 implementation by E. Deveaud
# and K. Schuerer (ftp://ftp.pasteur.fr/pub/GenSoft/unix/protein/toppred/)
#

use Bio::Tools::Run::AnalysisFactory::Pise;
use Bio::SeqIO;
use Toppred;

#my $email = $ENV{USER} . "\@pasteur.fr";
my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new(-email => $email);

my $toppred = $factory->program('toppred',
				-query => $ARGV[0],
				-outformat => "xml");
my $job = $toppred->run();
print STDERR "jobid: ", $job->jobid, "\n";

my $xml_file = $job->save('toppred.out');
my $top = new Toppred ( -file => $xml_file);
my $out = newFh Bio::SeqIO ( -fh => \*STDOUT, 
			     -format => 'swiss');
while(my $pred = $top->next_prediction()) {
    print $out $pred;
}


