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
    
    $NUMTESTS = 2;
    plan tests => $NUMTESTS;
}

use Bio::Tools::Run::Mdust;
use Bio::SeqIO;

END {
  for($Test::ntest..$NUMTESTS){
      skip("Mdust not found. Skpping.",1);
  }
}


my $input = Bio::SeqIO->new( -file 	=> 't/data/NM_002254.gb',
			     -format 	=> 'Genbank' );

my $seq = $input->next_seq;

my $mdust = Bio::Tools::Run::Mdust->new(-coords 	=> 1, 
					-target		=> $seq,
					);
ok $mdust->isa("Bio::Tools::Run::Mdust");
unless($mdust->executable){
  warn("Mdust not installed Skipping tests $Text::ntest to $NUMTESTS.\n") ;
  exit(0);
}

$mdust->run;    

my @excluded = grep { $_->primary_tag eq 'Excluded' } $seq->top_SeqFeatures;

ok (scalar(@excluded),3);

