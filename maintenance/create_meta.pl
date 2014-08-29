#!/usr/bin/perl
# $Id: dependencies.pl 10084 2006-07-04 22:23:29Z cjfields $
#

use strict;
use warnings;
use File::Find;
use File::Spec;
use Getopt::Long;
use JSON;
use Module::CoreList;
use CPAN::Meta::Prereqs;
#use CPANPLUS::Backend;
#use CPAN::Meta::Requirements;


#
# command line options
#

my ($perl,$dir) = ("5.006001",undef);
GetOptions(
        'dir:s' => \$dir,
        'p|perl:s' => \$perl,
        'h|help|?' => sub{ exec('perldoc',$0); exit(0) }
	   );

$dir ||= File::Spec->catdir(qw/.. lib Bio/);
my @dirs = qw(lib);

#
# run
#

my $features_meta = {};
my %dependencies;
my %bp_packages;
my %core = %{$Module::CoreList::version{$perl}};

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
  next unless $mod =~ /^Bio::Tools::Run::[^:]+$/; # get meta only for Run
  my $mod_info = $dependencies{$mod};
  if (my $tag = $$mod_info{tag}) {
    $features_meta->{$tag} = {
      description => $$mod_info{desc},
      prereqs => $$mod_info{prereqs}->as_string_hash
     }
  }
  1;
}

print encode_json $features_meta;

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
  my $nm = $File::Find::name;
  $nm =~ s{.*(Bio.*)\.pm}{$1};
  $nm =~ s{[\\\/]}{::}g;
  my $prereqs = $dependencies{$nm}{prereqs} ||= CPAN::Meta::Prereqs->new();
  ($dependencies{$nm}{tag}) = $nm =~ m/.*::(.*)$/;
  my $pod = '';
  my $desc='';
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
      }
      elsif ($pod =~ /head/) {
	my @a = split(/\s+/,$line);
	if ($a[1] && ($a[1] eq 'NAME')) {
	  while ($line = <$F>) {
	    last if $line =~ /^=\w+/;
	    chomp $line;
	    $desc .= " $line";
	  }
	  $desc =~ s/\s+/ /g;
	  $desc =~ s/^\s*(?:[A-Za-z0-9_]+::)*[A-Za-z0-9_]+
		     \s+-*\s*//x;
	  $desc =~ s/\.?\s+$//;
	  $dependencies{$nm}{desc} = $desc;
	}
      }
      else {
	next MODULE_LOOP;
      }
    }
    # strip off end comments
    $line =~ s/\#[^\n]+//;
    if ($line =~ /^\bpackage\s+(\S+)\s*;/) {
      $bp_packages{$1}++;
    }
    elsif ($line =~ /(?:['"])?\b(use|require)
		     \s+([A-Za-z0-9:_\.\(\)]+)
		     \s*([^;'"]+)?(?:['"])?\s*;/x) {
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
      $prereqs->requirements_for(runtime => 'requires')->
	add_minimum( $mod => $ver );
      1;
    }
  }
  close $F;
}

