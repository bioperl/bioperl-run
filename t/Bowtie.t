#-*-perl-*-
#$Id: Bowtie.t kortsch $

use strict;
use warnings;
no warnings qw(once);
our $home;
BEGIN {
    $home = '.';	# set to '.' for Build use, 
						# '..' for debugging from .t file
    unshift @INC, $home;
    use Bio::Root::Test;
    test_begin(-tests => 55,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::Bowtie)]);
}

use File::Temp qw(tempfile tempdir);
use Bio::Tools::Run::WrapperBase;
use Bio::SeqIO;

# test command functionality

ok my $bowtiefac = Bio::Tools::Run::Bowtie->new(
    -command            => 'paired',
    -try_hard           => 1,
    -min_insert_size    => 300,
    -solexa             => 1,
    -max_mismatches     => 4
    ), "make a factory using command 'assemble'";
# ParameterBaseI compliance : really AssemblerBase tests...
ok $bowtiefac->parameters_changed, "parameters changed on construction";
ok $bowtiefac->min_insert_size, "access parameter";
ok !$bowtiefac->parameters_changed, "parameters_changed cleared on read";
ok $bowtiefac->set_parameters( -trim5 => 10 ), "set a param not set in constructor";
ok $bowtiefac->parameters_changed, "parameters_changed set";
is ($bowtiefac->trim5, 10, "parameter really set");
is ($bowtiefac->min_insert_size, 300, "original parameter unchanged");
ok !$bowtiefac->parameters_changed, "parameters_changed cleared on read";
ok $bowtiefac->set_parameters( -min_insert_size => 100 ), "change an original parameter";
is ($bowtiefac->min_insert_size, 100, "parameter really changed");
ok $bowtiefac->reset_parameters( -min_insert_size => 200 ), "reset parameters with arg";
ok !$bowtiefac->max_mismatches, "original parameters undefined";
is ($bowtiefac->min_insert_size, 200, "parameter really reset via arg");

$bowtiefac->set_parameters(
    -command            => 'paired',
    -try_hard           => 1,
    -suppress           => 1000,
    -max_mismatches     => 4
    );
ok $bowtiefac->parameters_changed, "parameters changed";

is( scalar $bowtiefac->available_parameters, 54, "all available options");
is( scalar $bowtiefac->available_parameters('params'), 24, "available parameters" );
is( scalar $bowtiefac->available_parameters('switches'), 30, "available switches" );
#back to beginning - but with single
$bowtiefac->set_parameters(
    -command            => 'single',
    -try_hard           => 1,
    -min_insert_size    => 300,
    -solexa             => 1,
    -max_mismatches     => 4
    );
ok $bowtiefac->parameters_changed, "parameters changed";

is( scalar $bowtiefac->available_parameters, 48, "all available options");
is( scalar $bowtiefac->available_parameters('params'), 21, "available parameters" );
is( scalar $bowtiefac->available_parameters('switches'), 27, "available switches" );
my %pms = $bowtiefac->get_parameters;
is_deeply( \%pms, 
		{ command            => 'single',
		  min_insert_size    => 300,
		  max_mismatches     => 4,
		  solexa             => 1,
		  try_hard           => 1}, "get_parameters correct");
is( $bowtiefac->command, 'single', "command attribute set");

is_deeply( $bowtiefac->{_options}->{_commands}, 
	   [@Bio::Tools::Run::Bowtie::program_commands], 
	   "internal command array set" );

is_deeply( $bowtiefac->{_options}->{_prefixes},
	   {%Bio::Tools::Run::Bowtie::command_prefixes}, 
	   "internal prefix hash set");

is_deeply( $bowtiefac->{_options}->{_params}, 
	   [qw( command skip upto trim5 trim3 max_seed_mismatches max_qual_mismatch
	        max_quality_sum seed_length max_mismatches max_backtracks max_search_ram
	        report_n_alignments supress offset_base alignmed_file unaligned_file
	        excess_file threads offrate random_seed)], 
	   "commands filtered by prefix");
is( join(' ', @{$bowtiefac->_translate_params}),
    "single -I 300 -v 4 --solexa-quals -y", "translate params" );

# test run_bowtie filearg parsing

SKIP : {
    test_skip( -requires_executable => $bowtiefac,
	       -tests => 27 ); #not sure yet on numbers
    my $rdr = test_input_file('bowtie', 'reads', 'e_coli_1000.raw');
    my $rda = test_input_file('bowtie', 'reads', 'e_coli_1000.fa');
    my $rdq = test_input_file('bowtie', 'reads', 'e_coli_1000.fq');
    my $rda1 = test_input_file('bowtie', 'reads', 'e_coli_1000_1.fa');
    my $rda2 = test_input_file('bowtie', 'reads', 'e_coli_1000_2.fa');
    my $rdq1 = test_input_file('bowtie', 'reads', 'e_coli_1000_1.fq');
    my $rdq2 = test_input_file('bowtie', 'reads', 'e_coli_1000_2.fq');
    my $refseq = test_input_file('bowtie', 'indexes', 'e_coli');
    my $inlstr;
    my $inlobj;
    my $in = Bio::SeqIO->new( -file => $rda, -forma => 'Fasta' );
    while ( my $seq = $in->next_seq() ) {
        push @$inlobj,$seq;
        push @$inlstr,$seq->seq();
    }

    # unpaired reads
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'single'
	), "make unpaired reads bowtie factory";
    
    $bowtiefac->set_parameters( -inline => 1 );
    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq => $inlstr ), "read sequence as strings in memory";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq => $inlobj ), "read sequence as seq objects";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -inline );
    $bowtiefac->set_parameters( -raw => 1 );
    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq => $rdr ), "read raw sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -raw );
    $bowtiefac->set_parameters( -fasta => 1 );
    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq => $rda ), "read fasta sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -fasta );
    $bowtiefac->set_parameters( -fastq => 1 );
    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq => $rda ), "read fastq sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");
    

    # paired reads
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'paired'
	), "make paired reads bowtie factory";
    
    $bowtiefac->set_parameters( -fasta => 1 );
    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq1 => $rda1,  -seq2 => $rda2 ), "read paired fasta sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -fasta );
    $bowtiefac->set_parameters( -fastq => 1 );
    ok $bowtiefac->run_bowtie( -ind => $refseq,
			 -seq1 => $rdq1,  -seq2 => $rdq2 ), "read paired fastq sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");
    

    # test single
    # these parms are the bowtie defaults
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command             => 'single',
	-max_seed_mismatches => 2,
	-seed_length         => 28,
	-max_qual_mismatch   => 70
	), "make an alignment factory";
    
    is( $bowtiefac->command, 'single', "command attribute set");
    is( $bowtiefac->max_seed_mismatches, 2, "seed mismatch param set");
    is( $bowtiefac->seed_length, 28, "seed length param set");
    is( $bowtiefac->max_qual_mismatch, 70, "quality mismatch param set");
    ok my $assy = $bowtiefac->run($rdq, $refseq), "make alignment";
    #some fuzziness in these: bowtie gives ?+?
    cmp_ok( $assy->get_nof_contigs, '>=', 10000, "number of contigs"); # these aren't yet known
    cmp_ok( $assy->get_nof_singlets,'>=',10000, "number of singlets"); # these aren't yet known

}

1;