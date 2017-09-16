# -*-Perl-*-
## Bioperl Test Harness Script for Modules


use strict;
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 12);
	use_ok('Bio::Tools::Run::RepeatMasker');
	use_ok('Bio::SeqIO');
}

my $inputfilename= test_input_file('repeatmasker.fa');
my $createdfile = test_output_file();

my $verbose = test_debug();
my @params=("species" => "mammal", 'noint' => 1, 'qq' => 1, '-verbose' => $verbose);
my $fact = Bio::Tools::Run::RepeatMasker->new(@params);
$fact->quiet(1);

SKIP: {
    test_skip(-requires_executable => $fact,
              -tests => 10);
	
	is ($fact->species, 'mammal');
	is ($fact->noint,1);
	
	my $in  = Bio::SeqIO->new(-file => $inputfilename , '-format' => 'fasta');
	my $seq = $in->next_seq();
	my @feats = $fact->mask($seq);
	
	my $version = $fact->version;
	
	is ($feats[0]->feature1->primary_tag, "Simple_repeat");
	is ($feats[0]->feature1->source_tag, "RepeatMasker");
	is ($feats[0]->feature2->seq_id, "(TTAGGG)n");
	
	if( $version =~ /open-(\S+)/) {
		my $num = $1;
		if( $num ge '3.1.0' ) {
		is ($feats[0]->feature1->start, 1337);
		is ($feats[0]->feature1->end, 1411);
		is ($feats[0]->feature1->strand, 1);
		is ($feats[1]->feature1->start, 1710);
		is ($feats[1]->feature1->end, 2052);
		} elsif( $num ge  '3.0.8' ) {
		is ($feats[0]->feature1->start, 1337);
		is ($feats[0]->feature1->end, 1407);
		is ($feats[0]->feature1->strand, 1);
		is ($feats[1]->feature1->start, 1712);
		is ($feats[1]->feature1->end, 2225);    
		} else {
		skip("unknown RepeatMasker Version, cannot test",1) for ( 1..3);
		}
	} else {
		is ($feats[0]->feature1->start, 1337);
		is ($feats[0]->feature1->end, 1407);
		is ($feats[0]->feature1->strand, 1);
	}

}