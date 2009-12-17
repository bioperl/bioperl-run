#-*-perl-*-
#$Id: Bowtie.t 16367 2009-11-13 15:25:18Z maj $

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
    -command            => 'single',
    -try_hard           => 1,
    -suppress           => 1000,
    -max_mismatches     => 4
    );
ok $bowtiefac->parameters_changed, "parameters changed";

is( scalar $bowtiefac->available_parameters, 48, "all available options");
is( scalar $bowtiefac->available_parameters('params'), 21, "available parameters" );
is( scalar $bowtiefac->available_parameters('switches'), 27, "available switches" );
#back to beginning
$bowtiefac->set_parameters(
    -command            => 'paired',
    -try_hard           => 1,
    -min_insert_size    => 300,
    -solexa             => 1,
    -max_mismatches     => 4
    );
ok $bowtiefac->parameters_changed, "parameters changed";

is( scalar $bowtiefac->available_parameters, 54, "all available options");
is( scalar $bowtiefac->available_parameters('params'), 24, "available parameters" );
is( scalar $bowtiefac->available_parameters('switches'), 30, "available switches" );
my %pms = $bowtiefac->get_parameters;
is_deeply( \%pms, 
		{ command            => 'paired',
		  min_insert_size    => 300,
		  max_mismatches     => 4,
		  solexa             => 1,
		  try_hard           => 1}, "get_parameters correct");
is( $bowtiefac->command, 'paired', "command attribute set");

is_deeply( $bowtiefac->{_options}->{_commands}, 
	   [@Bio::Tools::Run::Bowtie::program_commands], 
	   "internal command array set" );

is_deeply( $bowtiefac->{_options}->{_prefixes},
	   {%Bio::Tools::Run::Bowtie::command_prefixes}, 
	   "internal prefix hash set");

is_deeply( $bowtiefac->{_options}->{_params}, 
	   [qw( command error_dep_coeff het_fraction max_mismatches max_quality_sum min_map_quality num_haplotypes)], 
	   "commands filtered by prefix");
is( join(' ', @{$bowtiefac->_translate_params}),
    "paired -I 300 -v 4 --solexa-quals -y", "translate params" );

# test run_bowtie filearg parsing
# a pipeline...

SKIP : {
    test_skip( -requires_executable => $bowtiefac,
	       -tests => 27 );
    my $rd1 = test_input_file('r1.fq');
    my $rd2 = test_input_file('r2.fq');
    my $refseq = test_input_file('campycoli.fas');
    
    my $tdir = tempdir( "bowtieXXXX", CLEANUP => 1);
    my ($r1h, $r1f) = tempfile( "rd1XXXX", DIR => $tdir );
    $r1h->close;
    my ($r2h, $r2f) = tempfile( "rd2XXXX", DIR => $tdir );
    $r2h->close;
    my ($refh, $reff) = tempfile( "refXXXX", DIR => $tdir );
    $refh->close;
    my ($map1h, $map1f) = tempfile( "mapXXXX", DIR => $tdir );
    $map1h->close;
    my ($map2h, $map2f) = tempfile( "mapXXXX", DIR => $tdir );
    $map2h->close;
    my ($mmaph, $mmapf) = tempfile( "mapXXXX", DIR => $tdir );
    $mmaph->close;
    my ($cnsh, $cnsf) = tempfile( "cnsXXXX", DIR => $tdir );
    $cnsh->close;
    my ($bowtieh, $bowtief) = tempfile( "bowtieXXXX", DIR => $tdir );
    $bowtieh->close;
    my ($fqh, $fqf) = tempfile( "faqXXXX", DIR => $tdir );
    $fqh->close;
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'fasta2bfa'
	), "make fasta2bfa conversion factory";
    
    ok $bowtiefac->run_bowtie( -fas => $refseq,
			 -bfa => $reff ), "convert refseq to bfa";
    
    like($bowtiefac->stderr, qr/1 sequence/, "bowtie success");
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'fastq2bfq'
	), "make fastq2bfq conversion factory";
    
    ok $bowtiefac->run_bowtie( -faq => $rd1,
			 -bfq => $r1f ), "convert r1.fq to bfa";
    like($bowtiefac->stderr, qr/125 sequences were loaded/, "bowtie success");
    ok $bowtiefac->run_bowtie( -faq => $rd2,
			 -bfq => $r2f ), "convert r2.fq to bfa";
    like($bowtiefac->stderr, qr/125 sequences were loaded/, "bowtie success");
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'map',
	), "make map factory";
    
    ok $bowtiefac->run_bowtie( -map => $map1f,
			 -bfa => $reff,
			 -bfq1 => $r1f ), "map single-end reads";
    ok $bowtiefac->run_bowtie( -map => $map2f,
			 -bfa => $reff,
			 -bfq2 => $r2f,
			 -bfq1 => $r1f ), "map paired-end reads";
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'mapmerge'
	), "make mapmerge factory";
    
    ok $bowtiefac->run_bowtie( -out_map => $mmapf,
			 -in_map => [$map1f, $map2f] ), "merge maps";
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'paired'
	), "make paired factory";
    
    ok $bowtiefac->run_bowtie( -cns => $cnsf,
			 -bfa => $reff,
			 -map => $mmapf ), "paired consensus";
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'mapview'
	), "make mapview converter";
    
    
    ok $bowtiefac->run_bowtie( -map => $mmapf,
			 -txt => $bowtief ), "convert mmap";
    
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-command            => 'cns2fq'
	), "make consensus->fastq converter";
    ok $bowtiefac->run_bowtie( -cns => $cnsf,
			 -faq => $fqf ), "convert consensus -> fastq";

    # test run (assembly pipeline) 
    # these parms are the bowtie defaults for the respective programs
    ok $bowtiefac = Bio::Tools::Run::Bowtie->new(
	-map_max_mismatches => 2,
	-asm_max_mismatches => 7,
	-c2q_min_map_quality => 40
	), "make an assembly factory";
    
    is( $bowtiefac->command, 'run', "command attribute set");
    is( $bowtiefac->map_max_mismatches, 2, "map param set");
    is( $bowtiefac->asm_max_mismatches, 7, "asm param set");
    is( $bowtiefac->c2q_min_map_quality, 40, "c2q param set");
    ok my $assy = $bowtiefac->run($rd1,$refseq,$rd2), "make full assy";
    #some fuzziness in these: sometimes bowtie gives 41+4, sometimes 42+6.
    cmp_ok( $assy->get_nof_contigs, '>=', 41, "number of contigs");
    cmp_ok( $assy->get_nof_singlets,'>=',4, "number of singlets");

}
1;

#  sub test_input_file {
#      return "./data/".shift;
#  }

