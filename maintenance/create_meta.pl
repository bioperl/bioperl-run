#!/usr/bin/env perl
#

use strict;
use warnings;
use File::Find;
use File::Spec;
use Pod::Usage;
use Getopt::Long;
use JSON;
use Module::CoreList;
use CPAN::Meta::Prereqs;

#use CPANPLUS::Backend;
#use CPAN::Meta::Requirements;

my @parse_paths = qw{
Bio/DB
Bio/Installer
Bio/Factory
Bio/Tools/Run
};

my $j = JSON->new->pretty(1);
my ($perl,$dir) = ("5.006001",undef);
my $help;
GetOptions(
        'dir:s' => \$dir,
        'p|perl:s' => \$perl,
        'h|help|?' => \$help
	   );

pod2usage(2) if ($help);

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
Bio::Tools::Run::WrapperBase
Bio::Tools::Run::WrapperBase::CommandExts
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
#  next unless $mod =~ /^${ns}::[^:]+$/; # get meta only for Run
  next if $mod =~ /WrapperBase/; # WrapperBase is not optional
  my $mod_info = $dependencies{$mod};
  if (my $tag = $$mod_info{tag}) {
    $features_meta->{$tag} = {
      description => $$mod_info{desc},
      prereqs => $$mod_info{prereqs}->as_string_hash
     }
  }
  1;
}

print $j->encode($features_meta);

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
  # filter for modules occurring only at defined paths
  return unless grep { $File::Find::dir =~ m|$_/?$| } @parse_paths;
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
	    if ($line =~ /^=(\w+)/) {
	      $pod = $1;
	      last;
	    }
	    chomp $line;
	    $desc .= " $line";
	  }
	  $desc =~ s/\s+/ /g;
	  $desc =~ s/^\s*(?:[A-Za-z0-9_]+::)*[A-Za-z0-9_]+
		     \s+-*\s*//x;
	  $desc =~ s/\.?\s+$//;
	  $dependencies{$nm}{desc} = $desc;
	  next MODULE_LOOP;
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
      if ($mod =~ /[0-9._]+/) { # looks like a perl version string
	next MODULE_LOOP;
      }
      # if ( $nm =~ /$mod/) { # if $mod is a parent to the current package
      # 	next MODULE_LOOP;
      # }
      # if ( $mod =~ /$nm/) { # if $mod is a within-namespace requirement
      # 	                    # (which should be part of this install)
      # 	next MODULE_LOOP;
      # }
      $prereqs->requirements_for(runtime => 'requires')->
	add_minimum( $mod => $ver );
      1;
    }
  }
  close $F;
}

=head1 NAME

create_meta.pl - Build CPAN metadata for optional modules

=head1 USAGE

 create_meta.pl [--dir SEARCHDIR] [--perl VERSION] [--namespace NS] \
   > feature_meta.json

 SEARCHDIR defaults to '../lib/Bio'
 VERSION defaults to '5.006001' (determines Perl core modules to ignore)
 NS defaults to 'Bio::Tools::Run' (create meta only for matching modules)

=head1 DESCRIPTION

create_meta.pl traverses the given directory, identifying module
dependencies and pulling the abstract from each module. These are cast
into optional_features objects as described in L<CPAN::Meta::Spec>.
JSON that may be merged into CPAN metadata is output to stdout.

=head1 AUTHOR

 Mark A. Jensen <maj -at- fortinbras -dot- us>
 
=head1 LICENSE

This program is free software. It may be used and distributed under
the same terms as Perl itself.

=cut
