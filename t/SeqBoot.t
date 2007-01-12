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
    $NTESTS = 8;
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
my @params = ('-verbose'  => $verbose,
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


my $bequiet = $verbose > 0 ? 0 : 1;

$sb_factory->quiet($bequiet);  # Suppress protpars messages to terminal 

my $inputfilename = Bio::Root::IO->catfile("t","data","protpars.phy");

my $aln_ref = $sb_factory->run($inputfilename);

ok scalar(@{$aln_ref}), 2;

my $aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>"phylip")->next_aln;

$aln_ref = $sb_factory->run($aln);

ok scalar(@{$aln_ref}), 2;

# Test name preservation and restoration:
$inputfilename = Bio::Root::IO->catfile("t","data","longnames.aln");
$aln = Bio::AlignIO->new(-file=>$inputfilename, -format=>'clustalw')->next_aln;
my ($aln_safe, $ref_name) =$aln->set_displayname_safe();
$aln_ref = $sb_factory->run($aln_safe);
my $first=shift @{$aln_ref};
ok $first->get_seq_by_pos(3)->id(), "S000000003", "ailed to  assign serial names";
my $aln_restored=$first->restore_displayname($ref_name);
ok $aln_restored->get_seq_by_pos(3)->id(), "Smik_Contig1103.1", "fail to restore original names";

