package Bio::Tools::Run::Build::Test;
use Module::Build;
use Test::More;
use base Exporter;
use strict;
use warnings;

our @EXPORT = qw/skipall_unless_feature/;

sub skipall_unless_feature {
  my ($feature) = @_;
  my $build;
  eval {
    $build = Module::Build->current();
  };
  if ($build) {
    unless( $build->feature($feature) ) {
      plan skip_all => "$feature not selected for install";
    }
  }
}

1;
