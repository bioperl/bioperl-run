#!/usr/bin/perl -w

# This is a Module::Build script for bioperl-run installation.
# See http://search.cpan.org/~kwilliams/Module-Build/lib/Module/Build.pm

# Uses a custom subclass of Module::Build called ModuleBuildBioperl that
# doesn't get installed

use strict;
use ModuleBuildBioperl;

# Set up the ModuleBuildBioperl object
my $build = ModuleBuildBioperl->new(
    module_name         => 'Bio',
    dist_name           => 'bioperl-run',
    dist_version        => 1.005002100,
    dist_author         => 'Bioperl Team <bioperl-l@bioperl.org>',
    dist_abstract       => 'bioperl-run - wrapper toolkit',
    license             => 'artistic',
    requires            => {
                            'perl'                      => '5.6.1',
                            'Bio::Root::Version'        => '1.5.2'
                           },
    recommends          => {
                            'Algorithm::Diff'           => '0/generating consensus protein family descriptions/Bio::Tools::Run::TribeMCL',
                            'XML::Parser::PerlSAX'      => '0/Pise Applications/Bio::Tools::Run::PiseJob',
                            'HTML::Parser'				=> '0/Pise Applications/Bio::Tools::Run::PiseJob',
                           },
    dynamic_config      => 1
    
    #pm_files           => {} # modules in Bio are treated as if they were in lib and auto-installed
    #script_files       => [] # scripts in scripts directory are installed on-demand
);

# Ask questions
pise_email();
$build->choose_scripts;

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
