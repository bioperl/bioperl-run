# -*-Perl-*-
## Bioperl Test Harness Script for Modules

use strict;
use vars qw($NUMTESTS);
BEGIN { 
    eval { require Test; };
    if( $@ ) {
	use lib 't';
    }
    use Test;

    $NUMTESTS = 9; 
    plan tests => $NUMTESTS; 
}

END { unlink qw(cysprot.dnd cysprot1a.dnd) }

use Bio::Tools::Run::Alignment::Probcons;
use Bio::AlignIO;
use Bio::SeqIO;
use Bio::Root::IO;

END {     
    for ( $Test::ntest..$NUMTESTS ) {
	skip("Probcons program not found. Skipping.\n",1);
    }
}

ok(1);

my @params = ();
my $factory = Bio::Tools::Run::Alignment::Probcons->new(@params);
my $inputfilename = Bio::Root::IO->catfile("t","data","cysprot.fa");
my $aln;

my $present = $factory->executable();
unless ($present && -e $present	) {
    warn "probcons program not found. Skipping tests $Test::ntest to $NUMTESTS.\n";
    exit(0);
}
my $version = $factory->version;
ok ($version >= 1.09, 1, "Code tested only on probcons versions > 1.09" );
$aln = $factory->align($inputfilename);
ok($aln);
ok( $aln->no_sequences, 7);

my $str = Bio::SeqIO->new('-file' => 
			  Bio::Root::IO->catfile("t","data","cysprot.fa"), 
			  '-format' => 'Fasta');
my @seq_array =();

while ( my $seq = $str->next_seq() ) {
    push (@seq_array, $seq) ;
}

my $seq_array_ref = \@seq_array;

$aln = $factory->align($seq_array_ref);
ok $aln->no_sequences, 7;
my $s1_avg_perid = $aln->average_percentage_identity;
ok(int($s1_avg_perid), 43);
my $s1_ovl_perid = $aln->overall_percentage_identity;
ok(int($s1_ovl_perid), 15);

my ($tfhparams,$paramsfilename) = $factory->io->tempfile(-dir=>$factory->tempdir);
my ($tfhannot,$annotfilename) = $factory->io->tempfile(-dir=>$factory->tempdir);
my ($tfhdummy,$dummyfilename) = $factory->io->tempfile(-dir=>$factory->tempdir);
my $factory2 = new Bio::Tools::Run::Alignment::Probcons
    (
     'iterative-refinement'  => '1000',
     'consistency'   => '5',
     'emissions' => '',
     'verbose' => '',
     'train'   => $paramsfilename,
    );
$factory2->outfile_name($paramsfilename);

my $probcons_present = $factory->executable();
unless ($probcons_present) {
    warn "probcons program not found.\n";
    exit(0);
}

my $aln2 = $factory2->align($seq_array_ref);
$aln2 = '';
$factory2 = '';

$factory2 = new Bio::Tools::Run::Alignment::Probcons
    (
     'iterative-refinement'  => '1000',
     'consistency'   => '5',
     'verbose' => '',
     'annot'   => $annotfilename,
     'paramfile'   => $paramsfilename,
    );
$factory->outfile_name($dummyfilename);
$aln2 = $factory2->align($seq_array_ref);
my $s2_avg_perid = $aln2->average_percentage_identity;
my $s2_ovl_perid = $aln2->overall_percentage_identity;
ok(int($s2_avg_perid), 42);
ok(int($s2_ovl_perid), 16);
close($tfhparams);
undef $tfhparams;
close($tfhannot);
undef $tfhannot;
close($tfhdummy);
undef $tfhdummy;
