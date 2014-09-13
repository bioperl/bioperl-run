package Bio::Tools::Run::Build;
use strict;
use warnings;
use base 'Module::Build';
use CPAN::Meta;
use IO::Handle;
use Term::ReadKey;
use Term::ReadLine;
END {
  ReadMode 0;
}

sub select_tools {
    my $self = shift;
    $DB::single=1;
    my $meta = CPAN::Meta->load_file($self->mymetafile);
    my ($options, $descs);
    for ($meta->features) {
	$$options{$_->identifier} = 0;
	$$descs{$_->identifier} =  $_->description;
    }
    picker($options, $descs);
    1;
}


sub picker {
  local $|=1;
  my ($options, $descs) = @_;
  my $term = Term::ReadLine->new('picker');
  $term->ornaments(0);
  return unless ($options);
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
  print "Select :";
  my $curpg = 0;
  my $c=0;
  ReadMode 3;
  while ($c !~ /q/i) {
    while ( not defined ($c = ReadKey(0)) ) {}
    if ($c =~ /^[n ]$/i) {
      unless ($curpg == @pages-1) {
	$curpg++;
	print "\n";
	print "Select :";
      }
    }
    elsif ($c =~ /^[pb]$/i) {
      if ($curpg) {
	$curpg--;
	print "\n";
	print "Select :";
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
    print "Select :";
  }
  return $options;
}

1;
