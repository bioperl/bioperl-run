# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);

$DEBUG = $ENV{'BIOPERLDEBUG'} || 0;
BEGIN {
    eval { require Test; };
    if( $@ ) { 
	use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 4;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::Phylo::Phylip::DrawGram;
use Bio::TreeIO;

END {     
    for ( $Test::ntest..$NTESTS ) {
	skip("drawgram not found. Skipping.",1);
    }
}

my @params = ('-verbose' => $DEBUG,
	      'quiet'    => 1);
my $treedraw = Bio::Tools::Run::Phylo::Phylip::DrawGram->new(@params);
unless($treedraw->executable){
    warn("drawgram program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

if( ! $treedraw->executable ) {
    
}
$treedraw->fontfile(Bio::Root::IO->catfile(qw(t data fontfile)));

my $file = $treedraw->draw_tree(Bio::Root::IO->catfile(qw(t data 
							  treefile.example)));
ok($file);
ok(-e $file);

if( $DEBUG ) {
    `gs $file`;
}
unlink($file);


my $intree = new Bio::TreeIO(-file => 
			     Bio::Root::IO->catfile(qw(t data
						       treefile.example)));

$treedraw->HORIZMARGINS(['2.00','2.5']);
$treedraw->ANCESTRALNODES('C');
$treedraw->TREESTYLE('PHEN');
$treedraw->USEBRANCHLENS('N');

$file = $treedraw->draw_tree(Bio::Root::IO->catfile(qw(t data 
						       treefile.example)));

ok($file);
ok(-e $file);

if( $DEBUG ) {
    `gs $file`;
}
unlink($file);
