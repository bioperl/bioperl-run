use strict;
use vars qw($NUMTESTS);
BEGIN {
    use Bio::Root::Test;
    test_begin(-tests => 5);
	use_ok('Bio::Tools::Run::Mdust');
	use_ok('Bio::SeqIO');
}

my $input = Bio::SeqIO->new( -file 	=> test_input_file('NM_002254.gb'),
			     -format 	=> 'Genbank' );

my $seq = $input->next_seq;

my $mdust = Bio::Tools::Run::Mdust->new(
					-target		=> $seq,
					);
isa_ok $mdust, "Bio::Tools::Run::Mdust";

SKIP: {
	test_skip(-requires_executable => $mdust,
			  -tests => 2);
	
	$mdust->run;    
	
	my @excluded = grep { $_->primary_tag eq 'Excluded' } $seq->top_SeqFeatures;
	
	is (scalar(@excluded),3);
	
	my $input2 = Bio::SeqIO->new( -file	=> test_input_file('NM_002254.tfa'),
					  -format	=> 'Fasta');
	
	my $seq2 = $input2->next_seq;
	
	$mdust->coords(0);
	my $masked = $mdust->run($seq2);
	
	like $masked->seq, qr/N+/;
}
