#!/usr/bin/perl
# $Id: dependencies.pl 10084 2006-07-04 22:23:29Z cjfields $
#


use strict;
use warnings;
use File::Find;
use Getopt::Long;
use Module::CoreList;
use CPANPLUS::Backend;
use CPAN::Meta::Requirements;
use CPAN::Meta::Prereqs;

#
# command line options
#

my ($verbose, $dir, $depfile, $help, $version) = (0, '.', "../DEPENDENCIES.NEW", undef, "5.006001");
GetOptions(
        'v|verbose' => \$verbose,
        'dir:s' => \$dir,
        'depfile:s' => \$depfile,
        'p|perl:s' => \$version,
        'h|help|?' => sub{ exec('perldoc',$0); exit(0) }
	   );

# Directories to check
my @dirs = qw(lib);

#
# run
#

my %dependencies;
my %bp_packages;
my %core = %{$Module::CoreList::version{$version}};

# pragmas to skip
my %SKIP = map {$_ => 1} qw(base
vars
warnings
strict
constant
overload
);

if ($dir) {
    find {wanted => \&parse_core, no_chdir => 1}, $dir;
} else {
    find {wanted => \&parse_core, no_chdir => 1}, @dirs;    
}

#
# process results
#

for my $mod (sort keys %dependencies) {
  my $req = $dependencies{$mod};
  1;
}


# for my $k (keys %dependencies) {
#     if (exists $core{$k}) {
#         delete $dependencies{$k};
#     }
# }


# my $b = CPANPLUS::Backend->new();

# # sort by distribution into a hash, keep track of modules

# my %distrib;

# for my $mod (sort keys %dependencies) {
#     MODULE:
#     for my $m ($b->module_tree($mod)) {
#         if (!$m) {
#             warn "$key not found, skipping";
#             next MODULE;
#         }
#         push @{$distrib{$m->package_name}}, [$m, @{$dependencies{$m->module}}]
#     }
# }


# for my $d (sort keys %distrib) {
#     my $min_ver = 0;
#     for my $moddata (@{$distrib{$d}}) {
#         my ($mod, @bp) = @$moddata;
#         for my $bp (@bp) {
#             $min_ver = $bp->{ver} if $bp->{ver} >  $min_ver;
#         }
#     }
# }


#
##
### end main
##
#

# shamelessly lifted from Chris F's dependencies.pl
#
# this is where the action is
#

# create CPAN::Meta::Requirements object for
# each module file

sub parse_core {
    my $file = $_;
    return unless $file =~ /\.PLS$/ || $file =~ /\.p[ml]$/ ;
    return unless -e $file;
    open my $F, '<', $file or die "Could not read file '$file': $!\n";
    my $pod = '';
    MODULE_LOOP:
    while (my $line = <$F>) {
        # skip POD, starting comments
        next if $line =~ /^\s*\#/xms;
        if ($line =~ /^=(\w+)/) {
            $pod = $1;
        }
        if ($pod) {
            if ($pod eq 'cut') {
                $pod = '';
            } else {
                next MODULE_LOOP;
            }
        }
        # strip off end comments
        $line =~ s/\#[^\n]+//;
        if ($line =~ /^\bpackage\s+(\S+)\s*;/) {
            $bp_packages{$1}++;
        } elsif ($line =~ /(?:['"])?\b(use|require)\s+([A-Za-z0-9:_\.\(\)]+)\s*([^;'"]+)?(?:['"])?\s*;/) {
            my ($use, $mod, $ver) = ($1, $2, $3);
            if ($mod eq 'one') {
                print "$File::Find::name: $. $line";
            }
            if (exists $SKIP{$mod} || exists $core{$mod}) {
	      # skip if in core
                next MODULE_LOOP;
            }            
            if ($ver && $ver !~ /^v?[\d\.]+$/) {
                next MODULE_LOOP;
            }
            my $nm = $File::Find::name;
            $nm =~ s{.*(Bio.*)\.pm}{$1};
            $nm =~ s{[\\\/]}{::}g;
	    my $prereqs = $dependencies{$nm} ||= CPAN::Meta::Prereqs->new();
	    my $reqs = $prereqs->requirements_for(runtime => 'requires');
	    $reqs->add_minimum( $mod => $ver );
	    1;
        }
    }
    close $F;
}

