#!/usr/bin/perl -w

# This is a Module::Build script for BioPerl-Run installation.
# See http://search.cpan.org/~kwilliams/Module-Build/lib/Module/Build.pm

use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    dist_name           => 'BioPerl-Run',
    dist_version        => '1.006900',
    module_name         => 'Bio::Run',
    dist_author         => 'BioPerl Team <bioperl-l@bioperl.org>',
    dist_abstract       => 'BioPerl-Run - wrapper toolkit',
    license             => 'perl',
    requires            => {
                            'perl'               => '5.6.1',
                            'Bio::Root::Version' => '1.006900'
                           },
    recommends          => {
                            'Algorithm::Diff' => 0,     # generating consensus protein family descriptions: Bio::Tools::Run::TribeMCL
                            'IPC::Run'        => 0,     # Glimmer and Genemark application wrappers: Bio::Tools::Run::Glimmer Bio::Tools::Run::Genemark
                            'IO::String'      => 0,     # generating Bio::Tree::Tree from strings: Bio::Tools::Run::Phylo::Phylip::Consense
                            'XML::Twig'       => 0,     # processing XML data: Bio::Tools::Run::EMBOSSacd
                            'File::Sort'      => 0,     # BEDTools
                            'Config::Any'     => 0,     # MCS, Match
                            'SOAP::Lite'      => 0.716, # A bug that affects SoapEU-unit.t tests was fixed in this version (many levels deep object throws error)
                           },
    get_options         => {
                            accept  => { },
                            network => { },
                            install_scripts => { }
                           },
    auto_features       => {
                            Network => {
                                        description => "Enable tests that need an internet connection",
                                        requires    => { 'LWP::UserAgent' => 0 }
                                       }
                           },
    dynamic_config      => 1,
    #create_makefile_pl  => 'passthrough'
);

my $accept = $build->args->{accept};

# Optionally have script files installed.
if ($build->args('install_scripts') or $accept ? 0 : $build->y_n("Install scripts? y/n", 'n')) {
    my $files = $build->_find_file_by_type('PLS', 'scripts');

    my $script_build = File::Spec->catdir($build->blib, 'script');

    my @tobp;
    while (my ($file, $dest) = each %$files) {
        $dest = 'bp_'.File::Basename::basename($dest);
        $dest =~ s/PLS$/pl/;
        $dest = File::Spec->catfile($script_build, $dest);
        $build->copy_if_modified(from => $file, to => $dest);
        push @tobp, $dest;
    }

    $build->script_files(\@tobp);
}

# Do network tests?
my $do_network_tests = 0;
if ($build->args('network')) {
    $do_network_tests = $build->feature('Network');
}
elsif ($build->feature('Network')) {
    $do_network_tests = $accept ? 0 : $build->y_n("Do you want to run tests that require connection to servers across the internet\n(likely to cause some failures)? y/n", 'n');
}

if ($do_network_tests) {
    $build->notes(network => 1);
    $build->log_info("  - will run internet-requiring tests\n");
    my $use_email = $build->y_n("Do you want to run tests requiring a valid email address? y/n",'n');
    if ($use_email) {
        my $address = $build->prompt("Enter email address:");
        $build->notes(email => $address);
    }
}
else {
    $build->notes(network => 0);
    $build->log_info("  - will not run internet-requiring tests\n");
}

# Create the build script and exit
$build->create_build_script;

exit;
