#!/usr/local/bin/perl
# BioPerl script for Bio::Installer
#
# Cared for by Albert Vilella <avilella@ebi.ac.uk, avilella@ub.edu>
#
#	based on the CPAN::FirstTime module
#
# Copyright Albert Vilella
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

installer - downloads and installs runnables

=head1 SYNOPSIS

installer

=head1 DESCRIPTION

This script will ask the user which programs wants to install and
where. It will download the packages, decompress them (if necessary)
and compile/install them in the specified directory.

=head1 AUTHOR

Albert Vilella, avilella-AT-ebi-DOT-ac-DOT-uk,avilella-AT-ub-DOT-edu

=head1 TODO

Check if the programs are already installed in the computer and prompt
it so that the user is at least aware of it.

Check for the available installers, instead of hard-coding
$INSTALLERLIST in this script.

=cut

use strict;
use ExtUtils::MakeMaker;
use Data::Dumper;
use Bio::Factory::ObjectFactory;

use vars qw($DEFAULT $CONFIG $INSTALLERLIST);

BEGIN {
    $DEFAULT = 'bioperl-runnables';
    $INSTALLERLIST = [
                      'Clustalw',
                      'EMBOSS',
                      'TCoffee',
                      'PAML',
                     ];
}

my $dir = shift @ARGV || $DEFAULT;
init($dir);

1;


################################################################################

sub init {
    my($configpm) = @_;
    use Config;
    local($/) = "\n";
    local($\) = "";
    local($|) = 1;

    my($ans,$default);

    #
    # Files, directories
    #

    print qq[

This script will install the runnable programs associated with
bioperl-run.

Bioperl-run contain modules that provides a PERL interface to various
bioinformatics applications. This allows various applications to be
used with common bioperl objects.

If you do not want to enter a dialog now, you can answer 'no' to this
question.

];

    my $manual_conf =
	ExtUtils::MakeMaker::prompt("Are you ready for manual configuration?",
				    "yes");
    my $fastread;
    {
        local $^W;
        if ($manual_conf =~ /^\s*y/i) {
            $fastread = 0;
            *prompt = \&ExtUtils::MakeMaker::prompt;
        } else {
            print "Done.\n\n";
            exit;
        }
    }
    print qq{

The following questions are intended to help you with the
installation. 

};

    $default = File::Spec->catdir( $ENV{'HOME'}, $configpm);
    while ($ans = prompt("Where do you want to install the runnables in your computer?",$default)) {
        unless (File::Spec->file_name_is_absolute($ans)) {
            require Cwd;
            my $cwd = Cwd::cwd();
            my $absans = File::Spec->catdir($cwd,$ans);
            warn "The path '$ans' is not an absolute path. Please specify an absolute path\n";
            $default = $absans;
            next;
        }
        eval { File::Path::mkpath($ans); }; # dies if it can't
        if ($@) {
            warn "Couldn't create directory $ans.
Please retry.\n";
            next;
        }
        if (-d $ans && -w _) {
            print qq{
Directory $ans successfully created.

};

            last;
        } else {
            warn "Couldn't find directory $ans
  or directory is not writable. Please retry.\n";
        }
    }

    print qq{

The script will need a few external programs to work properly.
Please correct me, if I guess the wrong path for a program. Don\'t
panic if you do not have some of them, just press ENTER for those.

};

    my $old_warn = $^W;
    local $^W if $^O eq 'MacOS';
    my(@path) = split /$Config{'path_sep'}/, $ENV{'PATH'};
    local $^W = $old_warn;
    my $progname;
    for $progname (qw/gzip tar unzip make links wget ncftpget ncftp ftp gpg/) {
        if ($^O eq 'MacOS') {
            $CONFIG->{$progname} = 'not_here';
            next;
        }
        my $progcall = $progname;
        # we don't need ncftp if we have ncftpget
        next if $progname eq "ncftp" && $CONFIG->{ncftpget} gt " ";
        my $path = $CONFIG->{$progname} 
            || $Config::Config{$progname}
                || "";
        if (File::Spec->file_name_is_absolute($path)) {
            # testing existence is not good enough, some have these exe
            # extensions

            # warn "Warning: configured $path does not exist\n" unless -e $path;
            # $path = "";
        } else {
            $path = '';
        }
        unless ($path) {
            # e.g. make -> nmake
            $progcall = $Config::Config{$progname} if $Config::Config{$progname};
        }

        $path ||= find_exe($progcall,[@path]);
        warn "Warning: $progcall not found in PATH\n" unless
            $path; # not -e $path, because find_exe already checked that
        $ans = prompt("Where is your $progname program?",$path) || $path;
        $CONFIG->{$progname} = $ans;
    }
    my $path = $CONFIG->{'pager'} || 
	$ENV{PAGER} || find_exe("less",[@path]) || 
	    find_exe("more",[@path]) || ($^O eq 'MacOS' ? $ENV{EDITOR} : 0 )
                || "more";
    $ans = prompt("What is your favorite pager program?",$path);
    $CONFIG->{'pager'} = $ans;
    $path = $CONFIG->{'shell'};
    if (File::Spec->file_name_is_absolute($path)) {
	warn "Warning: configured $path does not exist\n" unless -e $path;
	$path = "";
    }
    $path ||= $ENV{SHELL};
    if ($^O eq 'MacOS') {
        $CONFIG->{'shell'} = 'not_here';
    } else {
        $path =~ s,\\,/,g if $^O eq 'os2'; # Cosmetic only
        $ans = prompt("What is your favorite shell?",$path);
        $CONFIG->{'shell'} = $ans;
    }

    print qq{

Which programs would you like to install?

};
    my @selected_programs;
    my $prompt = "Select the programs you would like to install (by number),
put them on one line, separated by blanks, e.g. '1 2 4'";

    push (@selected_programs, @$INSTALLERLIST);
    @selected_programs = picklist (\@selected_programs, $prompt);
    push @{$CONFIG->{selected_programs_list}}, @selected_programs;

    print qq{

The selected programs will now be installed

};

# TODO: Check for the available installers, instead of hard-coding
# $INSTALLERLIST in this script.
#     my @l; 
#     for my $i (@INC) { 
#         next unless (-e $i."/My/Stuff/"); 
#         opendir(X,$i."/My/Stuff")|| warn "$!"; 
#         push @l,readdir(X); 
#     }

#     find sub { push(@l, $File::Find::name) if -f && /\.pm$/ }, 
#         map { "$_/My/Module" } @INC;

    foreach my $program (@selected_programs) {
        my $type = 'Bio::Installer::' . $program;
        my $factory = new Bio::Factory::ObjectFactory(-type => $type);
        my $instance = $factory->create_object();
        $instance->destination_install_dir($default);
        $instance->download();
        $instance->install();
    }


}

sub picklist {
    my($items,$prompt,$default,$require_nonempty,$empty_warning)=@_;
    $default ||= '';

    my $pos = 0;

    my @nums;
    while (1) {

        # display, at most, 15 items at a time
        my $limit = $#{ $items } - $pos;
        $limit = 15 if $limit > 15;

        # show the next $limit items, get the new position
        $pos = display_some($items, $limit, $pos);
        $pos = 0 if $pos >= @$items;

        my $num = prompt($prompt,$default);

        @nums = split (' ', $num);
        my $i = scalar @$items;
        (warn "invalid items entered, try again\n"), next
            if grep (/\D/ || $_ < 1 || $_ > $i, @nums);
        if ($require_nonempty) {
            (warn "$empty_warning\n");
        }
        print "\n";

        # a blank line continues...
        next unless @nums;
        last;
    }
    for (@nums) { $_-- }
    @{$items}[@nums];
}


sub display_some {
	my ($items, $limit, $pos) = @_;
	$pos ||= 0;

	my @displayable = @$items[$pos .. ($pos + $limit)];
    for my $item (@displayable) {
		printf "(%d) %s\n", ++$pos, $item;
    }
	printf("%d more items, hit SPACE RETURN to show them\n",
               (@$items - $pos)
              )
            if $pos < @$items;
	return $pos;
}


sub find_exe {
    my($exe,$path) = @_;
    my($dir);
    #warn "in find_exe exe[$exe] path[@$path]";
    for $dir (@$path) {
	my $abs = File::Spec->catfile($dir,$exe);
	if (($abs = MM->maybe_command($abs))) {
	    return $abs;
	}
    }
}

