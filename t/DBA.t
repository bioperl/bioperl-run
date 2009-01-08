# -*-Perl-*-
## Bioperl Test Harness Script for Modules


use strict;
BEGIN {
    use lib '.';
    use Bio::Root::Test;
    test_begin(-tests => 18);
    use_ok('Bio::Tools::Run::Alignment::DBA');
    use_ok('Bio::SimpleAlign');
    use_ok('Bio::AlignIO');
    use_ok('Bio::SeqIO');
} 

my $verbose = -1;
my @params = ('matchA' => 0.75, 'matchB' => '0.55','dymem'=>'linear');
my  $factory = Bio::Tools::Run::Alignment::DBA->new(@params);

SKIP: {
    test_skip(-requires_executable => $factory,
              -tests => 14);

    isa_ok $factory,'Bio::Tools::Run::Alignment::DBA';
    my $bequiet = 1;
    $factory->quiet($bequiet);  # Suppress clustal messages to terminal

    #test with one file with 2 sequences
    my $inputfilename_1a = test_input_file("dba1a.fa");
    my $inputfilename_1b = test_input_file("dba1b.fa");
    my $inputfilename2 = test_input_file("dba2.fa");
    my $aln;
    my @hsps = $factory->align($inputfilename2);
    isa_ok($hsps[0],"Bio::Search::HSP::GenericHSP");
    is($hsps[0]->query->start,4);
    is($hsps[0]->query->end,209);
    is($hsps[0]->gaps,6);
    
    #test with 2 files of 1 sequence each
    my @files = ($inputfilename_1a,$inputfilename_1b);
    @hsps = $factory->align(\@files);
    is($hsps[0]->query->start,3);
    is($hsps[0]->query->end,88);
    is($hsps[0]->gaps,0);
    is($hsps[1]->hit->start,90);
    is($hsps[1]->hit->end,195);
    is($hsps[1]->gaps,0);
    
    #test with an array of 2 PrimarySeqI objects
    
    my $str = Bio::SeqIO->new(-file=> test_input_file("dba2.fa"), '-format' => 'Fasta');
    my @seq_array =();
    
    while ( my $seq = $str->next_seq() ) {
      push (@seq_array, $seq) ;
    }
    @hsps = $factory->align(\@seq_array);
    is($hsps[0]->query->start,4);
    is($hsps[0]->query->end,209);
    is($hsps[0]->gaps,6);
}
