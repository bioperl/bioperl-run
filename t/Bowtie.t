#-*-perl-*-
#$Id: Bowtie.t kortsch $

use strict;
use warnings;
no warnings qw(once);
our $home;
our $ulimit;
BEGIN {
    $home = '.';	# set to '.' for Build use, 
						# '..' for debugging from .t file
    unshift @INC, $home;
    use Bio::Root::Test;
    eval { $ulimit = `ulimit -n` };
    if ($@ || !defined($ulimit)) {
        # skip all run tests, we can't ensure the ulimit is high enough for
        # these tests (needs ulimit -n of ~1000)
        $ulimit = 0;
    } else {
        chomp $ulimit
    }
    print STDERR $ulimit;
    
    test_begin(-tests => 73,
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
ok $bowtiefac->set_parameters( -sam_format => 1 ), "set an exclusive group parameter";
ok $bowtiefac->sam_format, "parameter really set";
ok $bowtiefac->set_parameters( -concise => 1 ), "set an incompatible parameter";
ok $bowtiefac->concise, "parameter really set";
ok !$bowtiefac->sam_format, "original exclusive parameter really unset";

$bowtiefac->set_parameters(
    -command            => 'paired',
    -try_hard           => 1,
    -suppress           => 1000,
    -max_mismatches     => 4
    );
ok $bowtiefac->parameters_changed, "parameters changed";

is( scalar $bowtiefac->available_parameters, 65, "all available options");
is( scalar $bowtiefac->available_parameters('params'), 30, "available parameters" );
is( scalar $bowtiefac->available_parameters('switches'), 35, "available switches" );
#back to beginning - but with single
$bowtiefac = Bio::Tools::Run::Bowtie->new(
    -command            => 'single',
    -try_hard           => 1,
    -min_insert_size    => 300,
    -solexa             => 1,
    -max_mismatches     => 4
    );
ok $bowtiefac->parameters_changed, "parameters changed";

is( scalar $bowtiefac->available_parameters, 59, "all available options");
is( scalar $bowtiefac->available_parameters('params'), 27, "available parameters" );
is( scalar $bowtiefac->available_parameters('switches'), 32, "available switches" );
my %pms = $bowtiefac->get_parameters;
is_deeply( \%pms, 
		{ command            => 'single',
		  max_mismatches     => 4,
		  solexa             => 1,
		  try_hard           => 1,
		  sam_format         => 1}, "get_parameters correct"); # we are single so filter 300 out
		                                                       # and again, we default to SAM
is( $bowtiefac->command, 'single', "command attribute set");

is_deeply( $bowtiefac->{_options}->{_commands}, 
	   [@Bio::Tools::Run::Bowtie::program_commands], 
	   "internal command array set" );

is_deeply( $bowtiefac->{_options}->{_prefixes},
	   {%Bio::Tools::Run::Bowtie::command_prefixes}, 
	   "internal prefix hash set");

is_deeply( $bowtiefac->{_options}->{_params}, 
	   [qw( command skip upto trim5 trim3 max_seed_mismatches
	        max_qual_mismatch max_quality_sum snp_penalty snp_frac
	        seed_length max_mismatches max_backtracks max_search_ram
	        report_n_alignments supress supress_random offset_base
	        defaul_mapq sam_rg suppress_columns alignmed_file
	        unaligned_file excess_file threads offrate random_seed )],
	   "commands filtered by prefix");
is( join(' ', @{$bowtiefac->_translate_params}),
    "-v 4 --solexa-quals -y -S", "translate params" ); # we default to SAM so '-S' appears

# test run_bowtie filearg parsing

SKIP : {
    test_skip( -requires_executable => $bowtiefac,
	       -tests => 40 ); # three tests not included due to absence of SAM functionality at this stage
    skip("; set 'ulimit -n' to 1000 for bowtie tests", 40) unless $ulimit >= 1000;
    my $rdr = test_input_file('bowtie', 'reads', 'e_coli_1000.raw');
    my $rda = test_input_file('bowtie', 'reads', 'e_coli_1000.fa');
    my $rdq = test_input_file('bowtie', 'reads', 'e_coli_1000.fq');
    my $rdc = test_input_file('bowtie', 'reads', 'e_coli.cb');
    my $rda1 = test_input_file('bowtie', 'reads', 'e_coli_1000_1.fa');
    my $rda2 = test_input_file('bowtie', 'reads', 'e_coli_1000_2.fa');
    my $rdq1 = test_input_file('bowtie', 'reads', 'e_coli_1000_1.fq');
    my $rdq2 = test_input_file('bowtie', 'reads', 'e_coli_1000_2.fq');
    my $refseq = test_input_file('bowtie', 'indexes', 'e_coli');
    my @inlstr;
    my @inlobj;
    my $in = Bio::SeqIO->new( -file => $rda, -format => 'Fasta' );
    while ( my $seq = $in->next_seq() ) {
        push @inlstr,$seq->seq();
        push @inlobj,$seq;
    }
    my $inlstr = "'".join(',',@inlstr)."'";

    # unpaired reads
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'single'
	), "make unpaired reads bowtie factory";
    
    $bowtiefac->set_parameters( -raw => 1 );
    ok $bowtiefac->_run( -ind => $refseq,
                         -seq => $rdr ), "read raw sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -raw => 0 );
    $bowtiefac->set_parameters( -fasta => 1 );
    ok $bowtiefac->_run( -ind => $refseq,
                         -seq => $rda ), "read fasta sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -fasta => 0 );
    $bowtiefac->set_parameters( -fastq => 1 );
    ok $bowtiefac->_run( -ind => $refseq,
                         -seq => $rdq ), "read fastq sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");
    

    # paired reads
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'paired'
	), "make paired reads bowtie factory";
    
    $bowtiefac->set_parameters( -fasta => 1 );
    ok $bowtiefac->_run( -ind => $refseq,
                         -seq => $rda1,  -seq2 => $rda2 ), "read paired fasta sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->reset_parameters( -fasta => 0 );
    $bowtiefac->set_parameters( -fastq => 1 );
    ok $bowtiefac->_run( -ind => $refseq,
                         -seq => $rdq1,  -seq2 => $rdq2 ), "read paired fastq sequence";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");
    

    # test single
    # these parms are the bowtie defaults - getting raw is not default for module
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command             => 'single',
	-max_seed_mismatches => 2,
	-seed_length         => 28,
	-max_qual_mismatch   => 70,
	-want                => 'raw'
	), "make a single alignment factory";
    
    is( $bowtiefac->command, 'single', "command attribute set");
    is( $bowtiefac->max_seed_mismatches, 2, "seed mismatch param set");
    is( $bowtiefac->seed_length, 28, "seed length param set");
    is( $bowtiefac->max_qual_mismatch, 70, "quality mismatch param set");
    is( $bowtiefac->want, 'raw', "return type set");
    my $sam;
    $bowtiefac->set_parameters( -fastq => 1 );
    ok $sam = $bowtiefac->run($rdq, $refseq), "make file based alignment";
    ok eval { (-e $sam)&&(-r _) }, "make readable output";
    open (FILE, $sam);
    my $lines =()= <FILE>;
    close FILE;    	
    is( $lines, 1003, "number of alignments");
    is($bowtiefac->want( 'Bio::Assembly::Scaffold' ), 'Bio::Assembly::Scaffold', "change mode");
    ok my $assy = $bowtiefac->run($rdq, $refseq), "make alignment";
    is( $assy->get_nof_contigs, 4, "number of contigs");
    is( $assy->get_nof_singlets, 691, "number of singlets");

    # tests from here may fail due to insufficient memory - works with >=2GB
    # test crossbow
    # these parms are again the bowtie defaults - getting raw is not default for module
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command             => 'crossbow',
	-max_seed_mismatches => 2,
	-seed_length         => 28,
	-max_qual_mismatch   => 70
	), "make a crossbow alignment factory";
    
    is( $bowtiefac->command, 'crossbow', "command attribute set");
    ok $sam = $bowtiefac->run($rdc, $refseq), "make file based alignment";
    ok eval { (-e $sam)&&(-r _) }, "make readable output";
    open (FILE, $sam);
    $lines =()= <FILE>;
    close FILE;    	
    is( $lines, 6, "number of alignments"); # 3 alignments and 3 SAM header lines

    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command             => 'single',
	-max_seed_mismatches => 2,
	-seed_length         => 28,
	-max_qual_mismatch   => 70
	), "make a single alignment factory";
    

    ok $bowtiefac->set_parameters( -inline => 1 );
    ok $bowtiefac->_run( -ind => $refseq,
                         -seq => $inlstr ), "read sequence as strings in memory";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    ok $bowtiefac->run( \@inlstr, $refseq ), "read sequence as seq objects";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    ok $bowtiefac->run( \@inlobj, $refseq ), "read sequence as seq objects";
    
    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

    $bowtiefac->set_parameters( -inline => 0 );
    ok $sam = $bowtiefac->run($rdr,$refseq), "make variable based alignment";

    like($bowtiefac->stderr, qr/reads processed: 1000/, "bowtie success");

}

1;
