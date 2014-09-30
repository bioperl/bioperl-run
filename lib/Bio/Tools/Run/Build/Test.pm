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

=head1 NAME

Bio::Tools::Run::Build::Test - Helper to integrate tests with features

=head1 SYNOPSIS

 # my_test_for_feature_goob.t
 ...
 use Bio::Tools::Run::Build::Test;
 skipall_unless_feature('goob');
 # tests...

=head1 DESCRIPTION

Exports one function, C<skipall_unless_feature()>. When 

 $ ./Build test

is executed, 

 skipall_unless_feature($feature);

will cause all tests in the file to be skipped iff 

 $build->feature($feature)

is false.

=head1 SEE ALSO

L<Bio::Tools::Run::Build>.

=head1 AUTHOR

 Mark A. Jensen
 CPAN ID: MAJENSEN
 majensen -at- cpan -dot- org

=head1 LICENSE

This program is free software. It may be used, modified and
distributed under the same terms as Perl itself.

=cut

1;
