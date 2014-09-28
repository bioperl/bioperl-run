package Bio::Tools::Run::Build;
use strict;
use warnings;
use base 'Module::Build';
use JSON;
use CPAN::Meta;
use CPAN::Meta::Merge;
use File::Spec;
use File::Find;
use IO::Handle;
use Term::ReadKey;
use Term::ReadLine;

my $PAGESZ = 10;
END {
  ReadMode 0;
}

my @always_install = qw/
Bio::Tools::Run::AnalysisFactory
Bio::Tools::Run::AnalysisFactory::soap
Bio::Tools::Run::Analysis
Bio::Tools::Run::Analysis::soap
Bio::Tools::Run::AssemblerBase
Bio::Tools::Run::Build
Bio::Tools::Run::Build::Test
Bio::Tools::Run::WrapperBase
Bio::Tools::Run::WrapperBase::CommandExts
/;


sub ACTION_code {
  my $self = shift;
  $self->SUPER::ACTION_code(@_);
}

sub ACTION_docs {
  my $self = shift;
  $self->SUPER::ACTION_docs(@_);
  $self->depends_on('deselect');
}

sub ACTION_deselect {
  my $self = shift;
  $self->depends_on('code');
  $self->depends_on('docs');
  my (%keep_mods,%remove_paths);
  @keep_mods{@always_install} = (1) x @always_install;
  my $meta = $self->notes('merged_meta') or die "metadata not loaded";
  my $provides = $meta->provides; # contains rel. location of modules in distro
  my $blib = File::Spec->catdir($self->base_dir, 'blib');
  my $libdoc = File::Spec->catdir($blib, 'libdoc');
  opendir my($d), $libdoc;
  my @docs = grep !/^\.+$/, readdir $d;
  foreach my $feature ($meta->features) {
    next unless $self->feature($feature->identifier); # selected
    my $prereqs = $feature->prereqs->as_string_hash;
    foreach my $mod (keys %{$prereqs->{runtime}{requires}},
		     keys %{$prereqs->{runtime}{recommends}}) {
      $keep_mods{$mod}++ if $provides->{$mod};
    }
  }
  for my $mod (keys %$provides) {
    unless (grep /^$mod$/,keys %keep_mods) {
      $remove_paths{File::Spec->catfile($blib,$provides->{$mod}->{file})}++;
      my ($doc) = grep /^$mod\./,@docs;
      $remove_paths{File::Spec->catfile($libdoc,$doc)}++ if $doc;
    }
  }
  # workaround for mixin
  if (!$self->feature('StandAloneBlastPlus')) {
    $remove_paths{File::Spec->catfile($blib,
				      qw/lib Bio Tools Run StandAloneBlastPlus/,
				      'BlastMethods.pm'
				     )}++;
    $remove_paths{File::Spec->catfile(
      $libdoc, 'Bio::Tools::Run::StandAloneBlastPlus::BlastMethods.3'
     )}++;
  }
  $DB::single=1;
  foreach (keys %remove_paths) {
    chmod 0666, $_;
    unlink $_ or warn "Could not unlink $_: $!";
  }
  # remove dirs now empty
  find(
     {wanted => sub {1},
      postprocess => sub { rmdir $File::Find::dir }}
      ,$blib);
  1;
}

sub interactive_select {
    my ($build, $meta) = @_;
    unless ($meta && ref $meta eq 'CPAN::Meta') {
      die "Need CPAN::Meta object";
    }
    my @selected_tools;
    my ($nummod,$options);
    do {
	$nummod = 0;
	$options = $build->select_tools($meta);
	my ($subdist) = $meta->name =~ /.*-([^-]+)/;
	print "Selected from $subdist:\n", join("\n", map { $options->{$_} ? $_ : () } sort keys %$options),"\n";
	$nummod += $_ for values %$options;
    } until $build->y_n(
	sprintf("Install %s tool module%s? y/n",
		($nummod ? ($nummod == 1 ? "this" : "these $nummod") : 'no'),
		($nummod==1 ? '' : 's')),'y');
    if ($nummod) {
	while (my ($k,$v) = each %$options) {
	    if ($v) {
		$build->feature($k => 1);
		push @selected_tools, $k;
	    }
	}
    }
    return @selected_tools;
}

sub select_tools {
    my $self = shift;
    my ($meta) = @_;
    unless ($meta && ref $meta eq 'CPAN::Meta') {
      die "Need CPAN::Meta object";
    }
    my ($options, $descs);
    for ($meta->features) {
	$$options{$_->identifier} = 0;
	$$descs{$_->identifier} =  $_->description;
    }
    picker($options, $descs);
}

sub add_tool_deps {
  my $self = shift;
  my ($meta,@features) = @_;
  ref $meta && $meta->isa('CPAN::Meta') or  die "Need metadata object";
  foreach my $feature (@features) {
    next if grep /^$feature$/i, @{$self->notes('dists')};
    next unless $meta->feature($feature);
    $self->feature($feature => 1); # register feature
    my $prereqs = $meta->feature($feature)->prereqs;
    my $reqs_h = $prereqs->merged_requirements([qw/runtime build test/],
					       [qw/requires/])->as_string_hash;
    while (my ($module, $version) = each %$reqs_h) {
      $self->_add_prereq('requires', $module, $version);
    }
  }
  return 1;
}

sub load_subdist_meta {
  my $self = shift;
  my ($subdist) = @_;
  $subdist = lc $subdist;
  $self->notes("meta_$subdist") && return $self->notes("meta_$subdist");
  my $meta = $self->notes('meta');
  die "No metadata at notes('meta')" unless $meta;
  die "Need subdistro name" unless $subdist;
  my $merger = CPAN::Meta::Merge->new(default_version => '2');
  local $/;
  open my $fm, File::Spec->catfile('meta',"feature_meta_$subdist.json") or
    die "Problem with meta/feature_meta_$subdist.json : ".$!;
  my $j = JSON->new;
  my $jtext = <$fm>;
  my $feat_h = { optional_features => $j->decode($jtext)};
  $self->notes(
    merged_meta => CPAN::Meta->new($merger->merge( $self->notes('merged_meta'), $feat_h ))
   );
  my $meta_h = $merger->merge($meta, $feat_h);
  $meta_h->{name} .= "-$subdist";
  $self->notes(
    "meta_$subdist" => CPAN::Meta->new($meta_h)
   );
}

sub picker {
  local $|=1;
  my ($options, $descs) = @_;
  my $term = Term::ReadLine->new('picker');
  $term->ornaments(0);
  return unless ($options);
  my $pg_prompt = 'Browse (p%d/%d) [(n)ext (p)rev (s)elect (q)uit]: ';
  my $sel_prompt = 'Toggle item install [enter item numbers or "all"]: ';
  my @options = sort keys %$options;
  my %idx;
  @idx{1..@options} = @options;
  my $display = sub {
    my ($start, $end) = @_;
    $start ||= 0;
    $end ||= @options-1;
    my $i = $start;
    print "\n\n";
    for (@options[$start..$end]) {
      $i++;
      printf "[%s] $i. $_", $$options{$_} ? 'X' : ' ';
      printf " - %s", $$descs{$_} if $descs && $$descs{$_};
      print "\n";
    }
  };
  my @pages;
  for (my $i = 0; $i < @options ; $i+=$PAGESZ) {
    my $end = $i+$PAGESZ-1;
    push @pages, [$i, $end > @options-1 ? @options-1 : $end];
  }
  $display->(@{$pages[0]});
  my $curpg = 0;
  printf $pg_prompt, $curpg+1, scalar @pages;
  my $c=0;
  ReadMode 3;
  while ($c !~ /q/i) {
    while ( not defined ($c = ReadKey(0)) ) {}
    if ($c =~ /^[n ]$/i) {
      if ($curpg < @pages-1) {
	$display->(@{$pages[++$curpg]});
	print "\n";
	printf $pg_prompt, $curpg+1,scalar @pages;
      }
      else { next }
    }
    elsif ($c =~ /^[pb]$/i) {
      if ($curpg) {
	$display->(@{$pages[--$curpg]});
	print "\n";
	printf $pg_prompt, $curpg+1, scalar @pages;
      }
      else { next }
    }
    elsif ($c =~ /^s$/) {
      ReadMode 0;
      print "\n";
      $_ = $term->readline($sel_prompt);
      my @a; 
      if (/^all/) {
	@a = (0..$#options);
      }
      else { 
	@a = split /\s+|[,;]\s*/;
	@a = grep { (1 <= $_) && ($_ <= @options) } grep /^[0-9]+$/, @a;
	$_-- for @a;
      }
      $options->{$_} ^= 1 for @options[@a];
      ReadMode 3;
      $display->(@{$pages[$curpg]});
      printf $pg_prompt, $curpg+1, scalar @pages;
    }
    elsif ($c =~ /^q$/i) {
      print "\n";
      last;
    }
    elsif ($c =~ /^$/) {
      next;
    }
  }

  ReadMode 0;
  return $options;
}

=head1 NAME

Bio::Tools::Run::Build - Instrument build with features

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=over

=item interactive_select()

=item select_tools()

=item add_tool_deps()

=item load_subdist_meta()

=back

=head1 FUNCTION

=over

=item picker()

=back

=head1 AUTHOR

 Mark A. Jensen
 CPAN ID: MAJENSEN
 majensen -at- cpan -dot- org

=head1 LICENSE

This program is free software. It may be used, modified and
distributed under the same terms as Perl itself.

=cut

1;
