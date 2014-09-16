#!/usr/bin/perl -w

# This is a Module::Build script for BioPerl-Run installation.
# See http://metacpan.org/pod/Module::Build

use strict;
use warnings;
use lib 'lib';
use File::Spec;
use Bio::Tools::Run::Build;

my $build = Bio::Tools::Run::Build->new(
    dist_name           => 'BioPerl-Run',
    dist_version        => '1.006900',
    module_name         => 'Bio::Run',
    dist_author         => 'BioPerl Team <bioperl-l@bioperl.org>',
    dist_abstract       => 'BioPerl-Run - wrapper toolkit',
    license             => 'perl',
    config_requires     => {
 	                    'Module::Build' => 0,
			    'Term::ReadLine' => 0
			   },
    build_requires      => {
                            'JSON' => '2.0',
                            'Bio::Root::Version' => '1.006900',
	                    'Bio::Root::Test' => 0,
			    'Term::ReadKey' => 0,
			    'Term::ReadLine' => 0,
			    'IO::Handle' => 0
			   },
    requires            => {
                            'perl'               => '5.6.1',
                            'Bio::Root::Version' => '1.006900',
			    'Bio::Root::Root'    => 0,
                           },
    # recommends          => {
    #                         'Algorithm::Diff' => 0,     # generating consensus protein family descriptions: Bio::Tools::Run::TribeMCL
    #                         'IPC::Run'        => 0,     # Glimmer and Genemark application wrappers: Bio::Tools::Run::Glimmer Bio::Tools::Run::Genemark
    #                         'IO::String'      => 0,     # generating Bio::Tree::Tree from strings: Bio::Tools::Run::Phylo::Phylip::Consense
    #                         'XML::Twig'       => 0,     # processing XML data: Bio::Tools::Run::EMBOSSacd
    #                         'File::Sort'      => 0,     # BEDTools
    #                         'Config::Any'     => 0,     # MCS, Match
    #                         'SOAP::Lite'      => 0.716, # A bug that affects SoapEU-unit.t tests was fixed in this version (many levels deep object throws error)
    #                        },
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
if (eval "require JSON; 1") {
    my $j = JSON->new;
    local $/;
    open my $fm, File::Spec->catfile('meta','feature_meta.json');
    my $jtext = <$fm>;
    $build->meta_merge( 
      {
      optional_features => $j->decode($jtext),
      'meta-spec' => { version => '2',
		       url => 'http://search.cpan.org/perldoc?CPAN::Meta::Spec' 
		      }
      } 
     );
}
$build->dispatch('distmeta');
my $accept = $build->args->{accept};

# Select tools modules to install
my ($options, $nummod, @selected_tools);
do {
  $nummod = 0;
  $options = $build->select_tools();
  print "Selected :\n", join("\n", map { $options->{$_} ? $_ : () } sort keys %$options),"\n";
  $nummod += $_ for values %$options;
} until $build->y_n(
    sprintf("Install %s tool module%s? y/n",
	    ($nummod ? ($nummod == 1 ? "this" : "these $nummod") : 'no'),
	    ($nummod==1 ? '' : 's')),'y');

$DB::single=1;
if ($nummod) {
  while (my ($k,$v) = each %$options) {
    if ($v) {
      $build->feature($k => 1);
      push @selected_tools, $k;
    }
  }
}

$build->add_tool_deps($_) for (@selected_tools);

# now check with $build->check_prereq() - this will add check and
# add failures that should then be recorded for install with installdeps
# (returns false if any failures; true if all good

unless ($build->check_prereq) {
    $DB::single=1;
    1;
}

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
