# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
BEGIN {
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 5;
    plan tests => $NTESTS;
}

use vars qw( $reason);
$reason = 'Unable to run Eponine, java may not be installed';

END {
   foreach ( $Test::ntest..$NTESTS ) {
       skip($reason,1);
   }
}

use Bio::Tools::Run::Eponine;
use Bio::SeqIO;

#Java and java version check
my $v;
if (-d "java") {
    print STDERR "You must have java to run eponine\n";
    $reason = "Skipping because no java present to run eponine";
    exit(0);
}
my $output = `java -version 2>&1`;
open(PIPE,"java -version 2>&1 |");

while (<PIPE>) { 
    if (/Java\sVersion\:\s(\d+\.\d+)/) {
	$v = $1;
	last;
    }
    elsif (/java version\s.(\d+\.\d+)/) {
	$v = $1;
	last;
    }
    elsif (/java version\s\"(\d\.\d)/) {
	 $v = $1;
        last;
    }
}
if ($v < 1.2) {
    print STDERR "You need at least version 1.2 of JDK to run eponine\n";
    $reason = "Skipping due to old java version";
    exit(0);   
}   

if( ! $ENV{'EPONINEDIR'}  ) {
    $reason = "You must have defined EPONINEDIR to run these tests";
    exit(0);
}
my $inputfilename= Bio::Root::IO->catfile("t","data","eponine.fa");
my $fact = Bio::Tools::Run::Eponine->new("threshold" => 0.999,
					 "seq" =>$inputfilename);

ok ($fact->threshold, 0.999);
my @feats = $fact->run_eponine();
ok ($feats[0]->start, 69);
ok ($feats[0]->end, 69);
ok ($feats[0]->strand, 1);
ok ($feats[1]->start,178 );

