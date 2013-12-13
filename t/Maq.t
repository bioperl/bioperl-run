#-*-perl-*-
#$Id$

use strict;
use warnings;
no warnings qw(once);
our $home;
BEGIN {
    $home = '.'; # set to '.' for Build use, 
                      # '..' for debugging from .t file
    unshift @INC, $home;
    use Bio::Root::Test;
    test_begin(-tests => 51,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::Maq)]);
}

use File::Temp qw(tempfile tempdir);
use Bio::Tools::Run::WrapperBase;

# test command functionality

ok my $maqfac = Bio::Tools::Run::Maq->new(
    -command            => 'assemble',
    -single_end_quality => 1,
    -het_fraction       => 0.005,
    -max_mismatches     => 4
    ), "make a factory using command 'assemble'";
# ParameterBaseI compliance : really AssemblerBase tests...
ok $maqfac->parameters_changed, "parameters changed on construction";
ok $maqfac->het_fraction, "access parameter";
ok !$maqfac->parameters_changed, "parameters_changed cleared on read";
ok $maqfac->set_parameters( -error_dep_coeff => 0.5 ), "set a param not set in constructor";
ok $maqfac->parameters_changed, "parameters_changed set";
is ($maqfac->error_dep_coeff, 0.5, "parameter really set");
is ($maqfac->het_fraction, 0.005, "original parameter unchanged");
ok !$maqfac->parameters_changed, "parameters_changed cleared on read";
ok $maqfac->set_parameters( -het_fraction => 0.01 ), "change an original parameter";
is ($maqfac->het_fraction, 0.01, "parameter really changed");
ok $maqfac->reset_parameters( -het_fraction => 0.05 ), "reset parameters with arg";
ok !$maqfac->max_mismatches, "original parameters undefined";
is ($maqfac->het_fraction, 0.05, "parameter really reset via arg");
#back to beginning
$maqfac->set_parameters(
    -command            => 'assemble',
    -single_end_quality => 1,
    -het_fraction       => 0.005,
    -max_mismatches     => 4
    );
ok $maqfac->parameters_changed, "parameters changed";

is( scalar $maqfac->available_parameters, 9, "all available options");
is( scalar $maqfac->available_parameters('params'), 7, "available parameters" );
is( scalar $maqfac->available_parameters('switches'), 2, "available switches" );
my %pms = $maqfac->get_parameters;
is_deeply( \%pms, 
	   { command            => 'assemble',
             het_fraction       => 0.005,
             max_mismatches     => 4,
             single_end_quality => 1}, "get_parameters correct");
is( $maqfac->command, 'assemble', "command attribute set");

is_deeply( $maqfac->{_options}->{_commands}, 
	   [@Bio::Tools::Run::Maq::program_commands], 
	   "internal command array set" );

is_deeply( $maqfac->{_options}->{_prefixes},
	   {%Bio::Tools::Run::Maq::command_prefixes}, 
	   "internal prefix hash set");

is_deeply( $maqfac->{_options}->{_params}, 
	   [qw( command error_dep_coeff het_fraction max_mismatches max_quality_sum min_map_quality num_haplotypes)], 
	   "commands filtered by prefix");

TODO: {
    local $TODO ='Determine whether the order of the parameters should be set somehow; this sporadically breaks hash randomization introduced in perl 5.17+';
    is( join(' ', @{$maqfac->_translate_params}),
	"assemble -m 4 -r 0.005 -s", "translate params" );
}

# test run_maq filearg parsing
# a pipeline...

SKIP : {
    test_skip( -requires_executable => $maqfac,
	       -tests => 27 );
    my $rd1 = test_input_file('r1.fq');
    my $rd2 = test_input_file('r2.fq');
    my $refseq = test_input_file('campycoli.fas');
    
    my $tdir = tempdir( "maqXXXX", CLEANUP => 1);
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
    my ($maqh, $maqf) = tempfile( "maqXXXX", DIR => $tdir );
    $maqh->close;
    my ($fqh, $fqf) = tempfile( "faqXXXX", DIR => $tdir );
    $fqh->close;
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'fasta2bfa'
	), "make fasta2bfa conversion factory";
    
    ok $maqfac->run_maq( -fas => $refseq,
			 -bfa => $reff ), "convert refseq to bfa";
    
    like($maqfac->stderr, qr/1 sequence/, "maq success");
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'fastq2bfq'
	), "make fastq2bfq conversion factory";
    
    ok $maqfac->run_maq( -faq => $rd1,
			 -bfq => $r1f ), "convert r1.fq to bfa";
    like($maqfac->stderr, qr/125 sequences were loaded/, "maq success");
    ok $maqfac->run_maq( -faq => $rd2,
			 -bfq => $r2f ), "convert r2.fq to bfa";
    like($maqfac->stderr, qr/125 sequences were loaded/, "maq success");
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'map',
	), "make map factory";
    
    ok $maqfac->run_maq( -map => $map1f,
			 -bfa => $reff,
			 -bfq1 => $r1f ), "map single-end reads";
    ok $maqfac->run_maq( -map => $map2f,
			 -bfa => $reff,
			 -bfq2 => $r2f,
			 -bfq1 => $r1f ), "map paired-end reads";
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'mapmerge'
	), "make mapmerge factory";
    
    ok $maqfac->run_maq( -out_map => $mmapf,
			 -in_map => [$map1f, $map2f] ), "merge maps";
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'assemble'
	), "make assemble factory";
    
    ok $maqfac->run_maq( -cns => $cnsf,
			 -bfa => $reff,
			 -map => $mmapf ), "assemble consensus";
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'mapview'
	), "make mapview converter";
    
    
    ok $maqfac->run_maq( -map => $mmapf,
			 -txt => $maqf ), "convert mmap";
    
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-command            => 'cns2fq'
	), "make consensus->fastq converter";
    ok $maqfac->run_maq( -cns => $cnsf,
			 -faq => $fqf ), "convert consensus -> fastq";

    # test run (assembly pipeline) 
    # these parms are the maq defaults for the respective programs
    ok $maqfac = Bio::Tools::Run::Maq->new(
	-map_max_mismatches => 2,
	-asm_max_mismatches => 7,
	-c2q_min_map_quality => 40
	), "make an assembly factory";
    
    is( $maqfac->command, 'run', "command attribute set");
    is( $maqfac->map_max_mismatches, 2, "map param set");
    is( $maqfac->asm_max_mismatches, 7, "asm param set");
    is( $maqfac->c2q_min_map_quality, 40, "c2q param set");
    ok my $assy = $maqfac->run($rd1,$refseq,$rd2), "make full assy";
    #some fuzziness in these: sometimes maq gives 41+4, sometimes 42+6.
    cmp_ok( $assy->get_nof_contigs, '>=', 37, "number of contigs");
    cmp_ok( $assy->get_nof_singlets,'>=',4, "number of singlets");

}
1;

#  sub test_input_file {
#      return "./data/".shift;
#  }
