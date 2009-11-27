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
    unshift @INC, '../..';
    use Bio::Root::Test;
    test_begin(-tests => 36,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::BWA Bio::Tools::Run::Samtools)]);
}

use File::Temp qw(tempfile tempdir);
use File::Copy;

use Bio::Tools::Run::WrapperBase;
use Bio::Assembly::IO::sam;

# test command functionality

ok my $bwafac = Bio::Tools::Run::BWA->new(
    -command              => 'aln',
    -n_threads            => 1,
    -subopt_hit_threshold => 35
    ), "make a factory using command 'aln'";

# ParameterBaseI compliance : really AssemblerBase tests...
ok $bwafac->parameters_changed, "parameters changed on construction";
ok $bwafac->subopt_hit_threshold, "access parameter";
ok !$bwafac->parameters_changed, "parameters_changed cleared on read";
ok $bwafac->set_parameters( -reverse_no_comp => 1 ), "set a param not set in constructor";
ok $bwafac->parameters_changed, "parameters_changed set";
ok ($bwafac->reverse_no_comp, "parameter really set");
is ($bwafac->subopt_hit_threshold, 35, "original parameter unchanged");
ok !$bwafac->parameters_changed, "parameters_changed cleared on read";
ok $bwafac->set_parameters( -subopt_hit_threshold => 33 ), "change an original parameter";
is ($bwafac->subopt_hit_threshold, 33, "parameter really changed");
ok $bwafac->reset_parameters( -subopt_hit_threshold => 34 ), "reset parameters with arg";
ok !$bwafac->n_threads, "original parameters undefined";
is ($bwafac->subopt_hit_threshold, 34, "parameter really reset via arg");
#back to beginning
$bwafac->set_parameters(
    -command            => 'aln',
    -n_threads          => 1,
    -subopt_hit_threshold => 35
    );
ok $bwafac->parameters_changed, "parameters changed";

is( scalar $bwafac->available_parameters, 16, "all available options");
is( scalar $bwafac->available_parameters('params'), 14, "available parameters" );
is( scalar $bwafac->available_parameters('switches'), 2, "available switches" );
my %pms = $bwafac->get_parameters;
is_deeply( \%pms, 
	   { command            => 'aln',
             subopt_hit_threshold => 35,
             n_threads     => 1}, "get_parameters correct");
is( $bwafac->command, 'aln', "command attribute set");

is_deeply( $bwafac->{_options}->{_commands}, 
	   [@Bio::Tools::Run::BWA::program_commands], 
	   "internal command array set" );

is_deeply( $bwafac->{_options}->{_prefixes},
	   {%Bio::Tools::Run::BWA::command_prefixes}, 
	   "internal prefix hash set");

is_deeply( $bwafac->{_options}->{_params}, 
	   [qw( command max_edit_dist max_gap_opens max_gap_extns deln_protect_3p deln_protect_ends subseq_seed max_edit_dist_seed n_threads mm_penalty gap_open_penalty gap_extn_penalty subopt_hit_threshold trim_parameter )],
	   "commands filtered by prefix");
is( join(' ', @{$bwafac->_translate_params}),
    "aln -R 35 -t 1", "translate params" );

# test run_bwa filearg parsing
# a pipeline...

SKIP : { 
    test_skip( -requires_executable => $bwafac,
	       -tests => 12 ); 
    my $tdir = tempdir( "bwaXXXX", CLEANUP => 1);
    copy(test_input_file('r1bwa.fq'), File::Spec->catfile($tdir, 'r1.fq')) or die "copy failed (1)";
    copy(test_input_file('r2bwa.fq'), File::Spec->catfile($tdir, 'r2.fq')) or die "copy failed (2)";
    copy(test_input_file('Ft.frag.fas'), File::Spec->catfile($tdir, 'ref.fas')) or die "copy failed (3)";
    my ($rd1, $rd2, $refseq) = qw( r1.fq r2.fq ref.fas );
    my ($sai1f, $sai2f, $samf, $bamf) = ('sai1.sai', 'sai2.sai', 'out.sam', 'out.bam');

    chdir($tdir); # make indices in the tempdir

    ok my $bwa = Bio::Tools::Run::BWA->new( -command => 'index' ), "make refseq index factory";   
    ok $bwa->run_bwa( -fas => $refseq ), "index refseq"; 
    ok $bwa = Bio::Tools::Run::BWA->new( -command => 'aln' ), "make aln factory";
    ok $bwa->run_bwa( -fas => $refseq, -faq => $rd1, -sai => $sai1f ), "map read1 to refseq";
    ok $bwa->run_bwa( -fas => $refseq, -faq => $rd2, -sai => $sai2f), "map read 2 to refseq";
    ok $bwa = Bio::Tools::Run::BWA->new( -command => 'sampe' ), "paired read assembly factory";
    ok $bwa->run_bwa( -fas => $refseq, -sai1 => $sai1f, -faq1 => $rd1,
		      -sai2 => $sai2f, -faq2 => $rd2, -sam => $samf ), "assemble paired reads";

    #test run (assembly pipeline)
    ok $bwa = Bio::Tools::Run::BWA->new(), "make a full assembly factory";
    is ($bwa->command, 'run', "command attribute set");

    ok my $assy = $bwa->run($rd1, $refseq, $rd2), "make full assy";
    is ($assy->get_nof_contigs, 204, "number of contigs");
    is ($assy->get_nof_singlets, 220, "number of singlets");
    
}
    
#  sub test_input_file {
#       return "./data/".shift;
#   }
