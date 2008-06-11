use strict;
use vars qw($NUMTESTS);
BEGIN { 
    # to handle systems with no installed Test module
    # we include the t dir (where a copy of Test.pm is located)
    # as a fallback
    eval { require Test; };
    if( $@ ) {
        use lib 't';
    }
    use Test;
    
    $NUMTESTS = 3;
    plan tests => $NUMTESTS;
}

use Bio::Tools::Run::Mdust;
use Bio::SeqIO;

END {
  for($Test::ntest..$NUMTESTS){
      skip("Mdust not found. Skipping.",1);
  }
}


my $input = Bio::SeqIO->new( -file 	=> 't/data/NM_002254.gb',
			     -format 	=> 'Genbank' );

my $seq = $input->next_seq;

my $mdust = Bio::Tools::Run::Mdust->new(
					-target		=> $seq,
					);
ok $mdust->isa("Bio::Tools::Run::Mdust");
unless($mdust->executable){
  warn("Mdust not installed Skipping tests $Test::ntest to $NUMTESTS.\n") ;
  exit(0);
}

$mdust->run;    

my @excluded = grep { $_->primary_tag eq 'Excluded' } $seq->top_SeqFeatures;

ok (scalar(@excluded),3);

my $input2 = Bio::SeqIO->new( -file	=> 't/data/NM_002254.tfa',
			      -format	=> 'Fasta');

my $seq2 = $input2->next_seq;

$mdust->coords(0);
my $masked = $mdust->run($seq2);

ok $masked->seq =~ /N+/;






