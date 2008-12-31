#!/usr/bin/perl -w

# This is a Module::Build script for bioperl-run installation.
# See http://search.cpan.org/~kwilliams/Module-Build/lib/Module/Build.pm

# Uses a custom subclass of Module::Build called Bio::Root::Build

use strict;
use Bio::Root::Build;

# Set up the Bio::Root::Build object
my $build = Bio::Root::Build->new(
    module_name         => 'Bio',
    dist_name           => 'BioPerl-run',
    dist_version        => '1.007000',
    dist_author         => 'BioPerl Team <bioperl-l@bioperl.org>',
    dist_abstract       => 'BioPerl-run - wrapper toolkit',
    license             => 'perl',
    requires            => {
                            'perl'                      => '5.6.1',
                            'Bio::Root::Version'        => '1.7.0'
                           },
    recommends          => {
                            'Algorithm::Diff'           => '0/generating consensus protein family descriptions/Bio::Tools::Run::TribeMCL',
                            'XML::Parser::PerlSAX'      => '0/Pise Applications/Bio::Tools::Run::PiseJob',
                            'HTML::Parser'              => '0/Pise Applications/Bio::Tools::Run::PiseJob',
                            'IPC::Run'                  => '0/Glimmer and Genemark application wrappers'.
                                                           '/Bio::Tools::Run::Glimmer,Bio::Tools::Run::Genemark',
                           },
    get_options         => {
                            network => { } # say 'perl Build.PL --network' to manually request network tests
                           },
    auto_features       => {
                            Network               => {
                                                        description => "Enable tests that need an internet connection",
                                                        requires    => { 'LWP::UserAgent' => 0 },
                                                        test        => \&Bio::Root::Build::test_internet
                                                     }
                           },
    dynamic_config      => 1,
    create_makefile_pl  => 'passthrough'
    
    #pm_files           => {} # modules in Bio are treated as if they were in lib and auto-installed
    #script_files       => [] # scripts in scripts directory are installed on-demand
);

my $accept = $build->args->{accept};

# Ask questions
pise_email($accept);
$build->choose_scripts;
{
    if ($build->args('network')) {
        if ($build->feature('Network')) {
            $build->notes(network => 1);
            $build->log_info("  - will run internet-requiring tests\n");
        }
        else {
            $build->notes(network => 0);
            $build->log_info("  - will not run network tests since I seem to be missing essential network functionality\n");
        }
    }
    else {
        $build->prompt_for_network($accept) if $build->feature('Network');
    }
}

# Create the build script and exit
$build->create_build_script;

exit;


sub pise_email {
    my $proceed = $build->y_n("Do you want to run the Pise tests with a valid email address? y/n",'n');
    
    my $path = File::Spec->catfile('t', 'pise-email.test');
    $build->add_to_cleanup($path);
    $build->add_to_manifest_skip($path);
    
    if ($proceed) {
        my $address = $build->prompt("Enter your email address", '');
        if ($address && open(T,">t/pise-email.test")) {
            print T "$address\n";
            close T;
        }
        else {
            $build->log_warn("Cannot open file t/pise-email.test for writing, or no email supplied - Pise tests will be run without an email address");
        }
    }
    else {
        if (-e $path) {
            unlink $path;
        }
    }
}
