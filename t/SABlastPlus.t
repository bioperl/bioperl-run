#-*-perl-*-
#$Id$
# testing StandAloneBlastPlus.pm

use strict;
use warnings;
our $home;
BEGIN {
    use Bio::Root::Test;
    $home = '.'; # set to '.' for Build use,
                     # '../lib' for debugging from .t file
#    $home = '../lib';
    unshift @INC, $home;
    test_begin(-tests => 57,
	       -requires_modules => [qw( 
                                      Bio::Tools::Run::BlastPlus
                                      )]);
}

use_ok( 'Bio::Tools::Run::StandAloneBlastPlus' );
use_ok( 'Bio::Tools::Run::WrapperBase' );
use_ok( 'Bio::Tools::Run::WrapperBase::CommandExts' );
use Bio::SeqIO;
use Bio::AlignIO;

## for testing; remove following line for production....
#$ENV{BLASTPLUSDIR} = "C:\\Program\ Files\\NCBI\\blast-2.2.22+\\bin";

ok my $bpfac = Bio::Tools::Run::BlastPlus->new(-command => 'makeblastdb'), 
    "BlastPlus factory";

SKIP : {
    test_skip( -tests => 53,
	       -requires_env => 'BLASTPLUSDIR',
	       -requires_executable => $bpfac);
    diag('DB and mask make tests');
# exceptions/warnings

# testing using fasta files as input...
    ok my $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa.fas'),
	-create => 1
	), "make factory";
    ok $fac->make_db, "test db made with fasta";
    like $fac->db, qr/DB.{5}/, "temp db";
    is ($fac->db_type, 'nucl', "right type");
    $fac->cleanup;

    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_name => 'test', 
	-db_data => test_input_file('test-spa.fas'),
	-create => 1
	);
    
    ok $fac->make_db, "named db made";
    ok $fac->check_db, "check_db";
    is $fac->db, 'test', "correct name";
    is ref $fac->db_info, 'HASH', "dbinfo hash returned";
    is $fac->db_type, 'nucl', "correct type";
    
    ok $fac->make_mask(
	-data=>test_input_file('test-spa.fas'), 
	-masker=>'windowmasker'), "windowmasker mask made";
    ok $fac->make_mask(
	-data=>test_input_file('test-spa.fas'), 
	-masker=>'dustmasker'), "dustmasker mask made";

    $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa-p.fas'),
	-create => 1
	);
    ok $fac->check_db('test'), "check_db with arg";
    is $fac->db_info('test')->{_db_type}, 'nucl', "db_info with arg";
    ok $fac->make_db, "protein db made";
    is $fac->db_type, 'prot', "correct type";
    ok $fac->make_mask(-data=>$fac->db, -masker=>'segmasker'), "segmasker mask made";
    ok $fac->make_mask(
	-data=>$fac->db, 
	-masker=>'segmasker'), "segmasker mask made; blastdb as data";
    
    $fac->cleanup;
    
    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa-p.fas'),
	-mask_file => test_input_file('segmask_data.asn'),
	-create => 1
	);
    ok $fac->make_db, "protein db made with pre-built mask";
    is $fac->db_filter_algorithms->[0]{algorithm_name}, 'seg', "db_info records mask info";
    $fac->cleanup;
    

    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa.fas'),
	-masker=>'windowmasker',
	-mask_data => test_input_file('test-spa.fas'),
	-create => 1
	);
    $fac->no_throw_on_crash(1);

    ok $fac->make_db, "mask built and db made on construction (windowmasker)";
    $fac->cleanup;
    
    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa-p.fas'),
	-masker=>'segmasker',
	-mask_data => test_input_file('test-spa-p.fas'),
	-create => 1
	);
    $fac->no_throw_on_crash(1);
    ok $fac->make_db, "mask built and db made on construction (segmasker)";
    $fac->cleanup;
    
    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa.fas'),
	-masker=>'dustmasker',
	-mask_data => test_input_file('test-spa.fas'),
	-create => 1
	);
    $fac->no_throw_on_crash(1);
    ok $fac->make_db, "mask built and db made on construction (dustmasker)";
    $fac->_register_temp_for_cleanup('test');
    $fac->cleanup;
    # tests with Bio:: objects as input

    ok my $sio = Bio::SeqIO->new(-file => test_input_file('test-spa.fas'));
    ok my $aio = Bio::AlignIO->new(-file => test_input_file('test-spa-p.fas'));

    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_name => 'siodb',
	-db_data => $sio,
	-create => 1
	);
    ok $fac->make_db, "make db from Bio::SeqIO";
    $fac->cleanup;
    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_name => 'aiodb',
	-db_data => $aio,
	-create => 1
	);
    ok $fac->make_db, "make db from Bio::AlignIO";
    $fac->cleanup;

    $aio = Bio::AlignIO->new(-file=>test_input_file('test-aln.msf'));
    my @seqs = $aio->next_aln->each_seq;
    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_name => 'aiodb',
	-db_data => \@seqs,
	-create => 1
	);
    ok $fac->make_db, 'make db from \@seqs';

    $fac->_register_temp_for_cleanup( 'aiodb', 'siodb' );
    $fac->cleanup;

    # exception tests here someday.

    # blast method tests
    diag("run BLAST methods");

    $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa.fas');
	-create => 1);

    ok my $result = $fac->run( -method => 'blastn', -query => test_input_file('test-query.fas')), "run blastn";
    is $result->num_hits, 500, "default hit limit";
    ok $result = $fac->blastn( -query => test_input_file('test-query.fas'),
			       -method_args => [ -num_alignments => 1000 ] ), "return more alignments (arg spec)";
    is $result->num_hits, 764, "got more hits";
    $fac->cleanup;
    my $ntseq = Bio::Seq->new( -seq => 'GACGATCCTTCGGTGAGCAAAGAAATTTTAGCAGAAGCTAAAAAGCTAAACGATGCTCAAGCACCAAAAG', -id => 'SA009');
    my $aaseq = $ntseq->translate;

    ok $result = $fac->blastn( -query => $ntseq  ), "run blastn with Bio::Seq query";
    $fac->no_throw_on_crash(1);
    ok $result = $fac->tblastn( -query => $aaseq ), "run tblastn";
    is $result->num_hits, 471, "tblastn hits";
    ok $result = $fac->tblastx( -query => $ntseq ), "run tblastx";
    is $result->num_hits, 500, "tblastx hits";
    $fac->cleanup;

    ok $fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_data => test_input_file('test-spa-p.fas'),
	-create => 1);
    ok $result = $fac->blastp( -query => $aaseq ), "run blastp";
    is $result->num_hits, 485, "blastp hits";
    $fac->cleanup;

    $sio = Bio::SeqIO->new(-file=>test_input_file('test-spa.fas'));    
    $sio->next_seq;
    my $seq1 = $sio->next_seq;
    my $seq2 = $sio->next_seq;

    ok $result = $fac->bl2seq( -method => 'blastn',
			       -query => $seq1,
			       -subject => $seq2 ), "bl2seq (blastn)";
    is $result->num_hits, 1, "got hit";
    ok $result = $fac->bl2seq( -method => 'blastx',
			       -query => $seq1,
			       -subject => $seq2 ), "bl2seq (blastx)";
    is $result->num_hits, 1, "got hit";
    $seq1 = $seq1->translate;
    $seq2 = $seq2->translate;
    ok $result = $fac->bl2seq( -method => 'blastp',
			       -query => $seq1, 
			       -subject => $seq2 ), "bl2seq (blastp)";
    is $result->num_hits, 1, "got hit";
    $fac->cleanup;
    
    
} # SKIP to here

# sub test_input_file { "data/".shift }
1;
