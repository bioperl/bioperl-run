#-*-perl-*-
#$Id$

use strict;
use warnings;
no warnings qw(once);
our $home;
BEGIN {
    $home = '..'; # set to '.' for Build use, 
                      # '..' for debugging from .t file
    unshift @INC, $home;
    use Bio::Root::Test;
    test_begin(-tests => 25,
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
is( join(' ', @{$maqfac->_translate_params}),
    "assemble -m 4 -r 0.005 -s", "translate params" );

# test run_maq filearg parsing
# a pipeline...

SKIP : {
    test_skip( -requires_executable => $maqfac,
	       -tests => 19 );
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
    like($maqfac->stderr, qr/1000 sequences were loaded/, "maq success");
    ok $maqfac->run_maq( -faq => $rd2,
			 -bfq => $r2f ), "convert r2.fq to bfa";
    like($maqfac->stderr, qr/1000 sequences were loaded/, "maq success");
    
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
}
1;

# sub test_input_file {
#     return "./data/".shift;
# }
