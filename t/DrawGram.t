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

my @params = ('-verbose' => 0,
	      'quiet'    => 1);
my $treedraw = Bio::Tools::Run::Phylo::Phylip::DrawGram->new(@params);
unless($treedraw->executable){
    warn("drawgram program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

if( ! $treedraw->executable ) {
    
}
$treedraw->fontfile(Bio::Root::IO->catfile(qw(t data fontfile)));
my $file = $treedraw->draw_tree(Bio::Root::IO->catfile(qw(t data treefile.example)));
ok($file);
ok(-e $file);

if( $DEBUG ) {
    `gv $file`;
} else { 
    unlink($file);
}

my $intree = new Bio::TreeIO(-file => Bio::Root::IO->catfile(qw(t data treefile.example)));

$file = $treedraw->draw_tree(Bio::Root::IO->catfile(qw(t data 
						       treefile.example)));
ok($file);
ok(-e $file);

if( $DEBUG ) {
    `gv $file`;
} else { 
    unlink($file);
}
