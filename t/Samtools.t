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
    test_begin(-tests => 1000,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::Samtools)]);
}

use File::Temp qw(tempfile tempdir);
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




