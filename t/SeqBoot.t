# -*-Perl-*-
## Bioperl Test Harness Script for Modules
## $Id$

use strict;
use vars qw($DEBUG);
$DEBUG = $ENV{'BIOPERLDEBUG'} || -1;

BEGIN {
    eval { require Test; };
    if( $@ ) { 
	use lib 't';
    }
    use Test;
    use vars qw($NTESTS);
    $NTESTS = 6;
    plan tests => $NTESTS;
}

use Bio::Tools::Run::Phylo::Phylip::SeqBoot;
use Bio::AlignIO;

END {     
    for ( $Test::ntest..$NTESTS ) {
	skip("SeqBoot not found. Skipping.",1);
    }
}

ok(1);
my $verbose = $DEBUG;
my @params = (
	      'idlength'  =>30,
	      'datatype'  =>'GENEFREQ',
	      'REPLICATES'=>50);

my $sb_factory = Bio::Tools::Run::Phylo::Phylip::SeqBoot->new(@params);
unless($sb_factory->executable){
    warn("SeqBoot program not found. Skipping tests $Test::ntest to $NTESTS.\n");
    exit 0;
}

ok $sb_factory->isa('Bio::Tools::Run::Phylo::Phylip::SeqBoot');

my $dt= 'SEQUENCE';
$sb_factory->datatype($dt);

ok $sb_factory->datatype, "SEQUENCE", "couldn't set datatype parameter";

$sb_factory->replicates(2);

ok $sb_factory->replicates, 2, "coludn't set number of replicates";


my $bequiet = 1;
$sb_factory->quiet($bequiet);  # Suppress protpars messages to terminal 

my $inputfilename = Bio::Root::IO->catfile("t","data","protpars.phy");

my $aln_ref = $sb_factory->run($inputfilename);

ok scalar(@{$aln_ref}), 2;

my $aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>"phylip")->next_aln;

$aln_ref = $sb_factory->run($aln);

ok scalar(@{$aln_ref}), 2;

