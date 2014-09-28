## Bioperl Test Harness Script for Modules

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.t'

use strict;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('Primate');
    test_begin(-tests => 8);
	use_ok('Bio::Tools::Run::Primate'); 
	use_ok('Bio::SeqIO');
}

my $verbose = 0;

my $query = test_input_file('primate_query.fa');
my $target= test_input_file('primate_target.fa');

my @params = ("query" => $query,"target" => $target,"m"=>0,"b"=>"TRUE");
my $fact = Bio::Tools::Run::Primate->new(@params);

SKIP: {
    test_skip(-requires_executable => $fact,
              -tests => 6);
	
	isa_ok($fact,"Bio::Tools::Run::Primate");
	my @feat = $fact->search;
	
	isa_ok ($feat[0],"Bio::SeqFeature::Generic");
	
	is ($feat[2]->start,11);
	is ($feat[5]->end,33);
	is ($feat[6]->seq->seq,"TATTTCTAC");
	is ($feat[12]->strand,-1);

}
