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
    test_begin(-tests => 36,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::Samtools)]);
}

use File::Temp qw(tempfile tempdir);
use File::Copy;
use File::Spec;
use Bio::Tools::Run::WrapperBase;

ok my $samt = Bio::Tools::Run::Samtools->new(
    -command            => 'pileup',
    -refseq             => 'my.fas',
    -theta              => 0.05
    ), "make a factory using command 'pileup'";
# ParameterBaseI compliance : really AssemblerBase tests...
ok $samt->parameters_changed, "parameters changed on construction";
ok $samt->refseq, "access parameter";
ok !$samt->parameters_changed, "parameters_changed cleared on read";
ok $samt->set_parameters( -n_haplos => 4 ), "set a param not set in constructor";
ok $samt->parameters_changed, "parameters_changed set";
is ($samt->n_haplos, 4, "parameter really set");
is ($samt->refseq, 'my.fas', "original parameter unchanged");
ok !$samt->parameters_changed, "parameters_changed cleared on read";
ok $samt->set_parameters( -refseq => 'their.fas' ), "change an original parameter";
is ($samt->refseq, 'their.fas', "parameter really changed");
ok $samt->reset_parameters( -refseq => 'our.fas' ), "reset parameters with arg";
ok !$samt->theta, "original parameters undefined";
is ($samt->refseq, 'our.fas', "parameter really reset via arg");
#back to beginning
$samt->set_parameters(
    -command            => 'pileup',
    -refseq             => 'my.fas',
    -theta              => 0.05
    );
ok $samt->parameters_changed, "parameters changed";

is( scalar $samt->available_parameters, 14, "all available options");
is( scalar $samt->available_parameters('params'), 9, "available parameters" );
is( scalar $samt->available_parameters('switches'), 5, "available switches" );
my %pms = $samt->get_parameters;
is_deeply( \%pms, 
	   {   command      => 'pileup',
	       refseq       => 'my.fas',
             theta        => 0.05 }, "get_parameters correct");
is( $samt->command, 'pileup', "command attribute set");

is_deeply( $samt->{_options}->{_commands}, 
	   [@Bio::Tools::Run::Samtools::program_commands], 
	   "internal command array set" );

is_deeply( $samt->{_options}->{_prefixes},
	   {%Bio::Tools::Run::Samtools::command_prefixes}, 
	   "internal prefix hash set");

is_deeply( $samt->{_options}->{_params}, 
	   [qw( command refseq map_qcap ref_list site_list theta n_haplos exp_hap_diff indel_prob )],
	   "commands filtered by prefix");
is( join(' ', @{$samt->_translate_params}),
    "pileup -T 0.05 -f my.fas", "translate params" );

# test run

SKIP : {
    test_skip( -requires_executable => $samt,
	       -tests => 12 );
    my $tdir = tempdir( "smtXXXX", CLEANUP => 1);
    copy(test_input_file('Ft.bam'), File::Spec->catfile($tdir, 'Ft.bam')) or die "copy failed (1)";
    copy(test_input_file('Ft.frag.fas'), File::Spec->catfile($tdir, 'ref.fas')) or die "copy failed (2)";
    chdir $tdir;
    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'faidx' ), "fasta index factory";
    ok $samt->run( -fas => 'ref.fas' ), "make fasta index";
    ok -e 'ref.fas.fai', "fai file present";
    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'view' ), "bam -> sam cvt factory";

    ok $samt->run( -bam => 'Ft.bam', -out => 'Ft.sam' ), "convert bam -> sam";
    ok -T 'Ft.sam', "sam file present and text";
    ok $samt->set_parameters( -sam_input => 1, -bam_output => 1, -refseq => 'ref.fas' ), "sam -> bam cvt factory";
    ok $samt->run( -bam => 'Ft.sam', -out => 'Ft.rt.bam' ), "convert sam -> bam";
    ok -B 'Ft.rt.bam', "bam file present and binary";
    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'index' ), 'bam index factory';
    ok $samt->run( -bam => 'Ft.rt.bam'), 'make bam index';
    ok -B 'Ft.rt.bam.bai', 'bai file present and binary';
}

#  sub test_input_file {
#       return "./data/".shift;
#   }


