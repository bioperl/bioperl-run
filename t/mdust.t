
use Test;

BEGIN { plan tests => 2 };

use Bio::Tools::Run::Mdust;
use Bio::SeqIO;

# modules compile
print "ok 1\n";

my $input = Bio::SeqIO->new( -file 	=> 't/data/NM_002254.gb',
			     -format 	=> 'Genbank' );

my $seq = $input->next_seq;

my $mdust = Bio::Tools::Run::Mdust->new(-coords 	=> 1, 
					-target		=> $seq,
					);
$mdust->run;    

my @excluded = grep { $_->primary_tag eq 'Excluded' } $seq->top_SeqFeatures;

if( scalar(@excluded) == 3 ) {
    print "ok 2\n";
} else {
    print "not ok 2\n";
}
