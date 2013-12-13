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
    test_begin(-tests => 40,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::Samtools)]);
}

use File::Copy;
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

TODO: {
    local $TODO ='Determine whether the order of the parameters should be set somehow; this sporadically breaks hash randomization introduced in perl 5.17+';
    is( join(' ', @{$samt->_translate_params}),
	"pileup -T 0.05 -f my.fas", "translate params" );
}

SKIP : {
    test_skip( -requires_executable => $samt,
	       -tests => 16 );

    my $new_bam = Bio::Tools::Run::Samtools->new(
                           -command => 'merge',
                           )->run(
                           -obm => 'output_file.bam',
                           -ibm => ['t/data/Ft.bam', 't/data/Ft.bam'],
                           );
    # test run
    ok($new_bam, 'merge bam factory instantiated');
    ok(-f 'output_file.bam', 'merged bam file created');
    unlink('output_file.bam');
	       
    my %tmpfiles;
    for (qw(refseq bamfile samfile rtbamfile sorted_bamfile fai bai)) {
        $tmpfiles{$_} = test_output_file();
    }
    copy(test_input_file('Ft.bam'), $tmpfiles{bamfile}) or die "copy failed (1)";
    copy(test_input_file('Ft.frag.fas'), $tmpfiles{refseq}) or die "copy failed (2)";
    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'faidx' ), "fasta index factory";
    ok $samt->run( -fas => $tmpfiles{refseq}, -out => $tmpfiles{fai}), "make fasta index";
    ok -e $tmpfiles{fai}, "fai file present";
    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'view' ), "bam -> sam cvt factory";

    ok $samt->run( -bam => $tmpfiles{bamfile}, -out => $tmpfiles{samfile} ), "convert bam -> sam";
    ok -T $tmpfiles{samfile}, "sam file present and text";
    ok $samt->set_parameters( -sam_input => 1, -bam_output => 1, -refseq => $tmpfiles{refseq} ), "sam -> bam cvt factory";
    ok $samt->run( -bam => $tmpfiles{samfile}, -out => $tmpfiles{rtbamfile} ), "convert sam -> bam";
    ok -B $tmpfiles{rtbamfile}, "bam file present and binary";
    
    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'sort' ), 'bam sort factory';
    ok $samt->run( -bam => $tmpfiles{rtbamfile}, -pfx => 'sorted_bam'), 'sort bam file';

    ok $samt = Bio::Tools::Run::Samtools->new( -command => 'index' ), 'bam index factory';
    ok $samt->run( -bam => 'sorted_bam', -out => $tmpfiles{bai}), 'make bam index';
    ok -B $tmpfiles{bai}, 'bai file present and binary';
    
    unlink('sorted_bam');
}
