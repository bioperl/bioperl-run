package Bio::Tools::Run::Build;
use strict;
use warnings;
use base 'Module::Build';
use CPAN::Meta;
use File::Spec;
use File::Find;
use IO::Handle;
use Term::ReadKey;
use Term::ReadLine;

my $PAGESZ = 10;
END {
  ReadMode 0;
}

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
  my %remove_paths;
  my $meta = $self->notes('meta') or die "metadata not loaded";
  my $provides = $meta->provides; # contains rel. location of modules in distro
  my $blib = File::Spec->catdir($self->base_dir, 'blib');
  my $libdoc = File::Spec->catdir($blib, 'libdoc');
  opendir my($d), $libdoc;
  my @docs = grep !/^\.+$/, readdir $d;
  foreach my $feature ($meta->features) {
    next if $self->feature($feature->identifier); # selected, do not remove
    # remove unwanted modules and manpages from blib:
    my $prereqs = $feature->prereqs->as_string_hash;
    foreach my $mod (keys %{$prereqs->{runtime}{requires}},
		     keys %{$prereqs->{runtime}{recommends}}) {
      if ($provides->{$mod}) {
	$remove_paths{File::Spec->catfile($blib,$provides->{$mod}->{file})}++;
	foreach (grep /$mod/,@docs) {
	  $remove_paths{File::Spec->catfile($libdoc,$_)}++;
	}
      }
    }
  }
  # workaround for mixin
  if (!$self->feature('StandAloneBlastPlus')) {
    $remove_paths{File::Spec->catfile($blib,
				      qw/lib Bio Tools Run StandAloneBlastPlus/,
				      'BlastMethods.pm'
				     )}++;
  }
  $DB::single=1;
  foreach (keys %remove_paths) {
    chmod 0666, $_;
    unlink $_ or warn "Could not unlink $_: $!";
  }
  # TODO : remove empty blib subdirs
  find(
     {wanted => sub {1},
      postprocess => sub { rmdir $File::Find::dir }}
      ,$blib);
  1;
}

sub interactive_select {
    my ($build, $subdist) = @_;
    my @selected_tools;
    my ($nummod,$options);
    do {
	$nummod = 0;
	$options = $build->select_tools();
	print "Selected :\n", join("\n", map { $options->{$_} ? $_ : () } sort keys %$options),"\n";
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
    my $meta = $self->notes('meta') or die "metadata not loaded";
    my ($options, $descs);
    for ($meta->features) {
	$$options{$_->identifier} = 0;
	$$descs{$_->identifier} =  $_->description;
    }
    picker($options, $descs);
}

sub add_tool_deps {
  my $self = shift;
  my (@features) = @_;
  my $meta = $self->notes('meta') or die "metadata not loaded";
  foreach my $feature (@features) {
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

sub picker {
  local $|=1;
  my ($options, $descs) = @_;
  my $term = Term::ReadLine->new('picker');
  $term->ornaments(0);
  return unless ($options);
  my $prompt = 'Select (%d/%d) [Enter number, (n)ext (p)rev (q)uit]: ';
  my @options = sort keys %$options;
  my %idx;
  @idx{1..@options} = @options;
  my $display = sub {
    my ($start, $end) = @_;
    $start ||= 0;
    $end ||= @options-1;
    my $i = $start;
    print "\n";
    for (@options[$start..$end]) {
      $i++;
      printf "[%s] $i. $_", $$options{$_} ? 'X' : ' ';
      printf " - %s", $$descs{$_} if $descs && $$descs{$_};
      print "\n";
    }
  };
  my $select = 'x';
  my @pages;
  for (my $i = 0; $i < @options ; $i+=$PAGESZ) {
    my $end = $i+$PAGESZ-1;
    push @pages, [$i, $end > @options-1 ? @options-1 : $end];
  }
  $display->(@{$pages[0]});
  my $curpg = 0;
  printf $prompt, $curpg+1, scalar @pages;
  my $c=0;
  ReadMode 3;
  while ($c !~ /q/i) {
    while ( not defined ($c = ReadKey(0)) ) {}
    if ($c =~ /^[n ]$/i) {
      unless ($curpg == @pages-1) {
	$curpg++;
	print "\n";
	printf $prompt, $curpg+1,scalar @pages;
      }
    }
    elsif ($c =~ /^[pb]$/i) {
      if ($curpg) {
	$curpg--;
	print "\n";
	printf $prompt, $curpg+1, scalar @pages;
      }
    }
    elsif ($c =~ /^q$/i) {
      print "\n";
      last;
    }
    elsif ($c =~ /^$/) {
      next;
    }
    else {
      ReadMode 0;
      print $c;
      $_ = $c.$term->readline('');
      my @a = split /\s+|[,;]\s*/;
      @a = grep { (1 <= $_) && ($_ <= @options) } grep /^[0-9]+$/, @a;
      $_-- for @a;
      $options->{$_} ^= 1 for @options[@a];
      ReadMode 3;
    }
    $display->(@{$pages[$curpg]});
    printf $prompt, $curpg+1, scalar @pages;
  }
  ReadMode 0;
  return $options;
}

1;
