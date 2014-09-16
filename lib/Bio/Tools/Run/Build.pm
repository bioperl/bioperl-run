package Bio::Tools::Run::Build;
use strict;
use warnings;
use base 'Module::Build';
use CPAN::Meta;
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
  print "HEY I made it\n";
}

sub select_tools {
    my $self = shift;
    my $meta = CPAN::Meta->load_file($self->metafile);
    my ($options, $descs);
    for ($meta->features) {
	$$options{$_->identifier} = 0;
	$$descs{$_->identifier} =  $_->description;
    }
    picker($options, $descs);
}

sub add_tool_deps {
  my $self = shift;
  my ($feature) = @_;
  my $meta = CPAN::Meta->load_file($self->metafile);
  my $prereqs = $meta->feature($feature)->prereqs;
  my $reqs_h = $prereqs->merged_requirements([qw/runtime build test/],
					     [qw/requires/])->as_string_hash;
  for (my ($module, $version) = each %$reqs_h) {
    $self->_add_prereq('requires', $module, $version);
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
