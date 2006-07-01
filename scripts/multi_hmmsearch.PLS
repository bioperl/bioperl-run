#!/usr/bin/perl -w
# $Id: multi_hmmsearch.PLS,v 1.2 2006-07-01 15:34:54 mauricio Exp $

use strict;

=head1 NAME

multi_hmmsearch - perform a hmmsearch into multiple FASTA files using
                  an INDEX file

=head1 SYNOPSIS

multi_hmmsearch -p hmm_file [-i] -f index_file

=head1 DESCRIPTION

Not technically a Bio::Tools::Run script as this doesn't use any
Bioperl or Bioperl-run components but it's useful.

=head2 Mandatory Options:

  -p  HMM profile to use for the search.
  -f  INDEX file that contains a list of FASTA files for the multiple
      search.

=head2 Special Options:

  -i  Create a new index file with the resulting hmms files. This is
      useful if you want to pass this list as input arguments into
      another programs.
  -h  Show this documentation.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to the
Bioperl mailing list. Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR

  Mauricio Herrera Cuadra <arareko-at-campus.iztacala.unam.mx>

=cut

# Modules, pragmas and variables to use
use Getopt::Long;
use vars qw($opt_p $opt_i $opt_f $opt_h $index_file);

# Gets options from the command line
GetOptions qw(-p=s -i -f=s -h);

# Print documentation if help switch was given
exec('perldoc', $0) and exit() if $opt_h;

# If no mandatory options are given prints an error and exits
if (!$opt_p) {
    print "ERROR: No HMM profile has been specified.\n       Use '-h' switch
for documentation.\n" and exit();
} elsif (!$opt_f) {
    print "ERROR: No INDEX file has been specified.\n       Use '-h' switch for
documentation.\n" and exit();
}

# Locates hmmsearch in the filesystem
my $hmmsearch = `which hmmsearch`;
chomp $hmmsearch;

# Creates a directory for writing the resulting files
mkdir("multi", 0755) unless -e "multi" and -d "multi";

# Creates a new INDEX file if the option was given
if ($opt_i) {
    my $prefix = $opt_f;
    $prefix =~ s/\.INDEX$//;
    $index_file = "$prefix.hmms.INDEX";
    open(HMMSINDEX, ">", $index_file) or die("Unable to create file:
$index_file ($!)");
}

# Opens the INDEX file sent as input
open(FH, "<", $opt_f) or die("Unable to open INDEX file: $opt_f ($!)");
print "==> Opening INDEX file:\t\t\t\t$opt_f\n";
print "==> HMM profile file is:\t\t\t$opt_p\n";

# Cycle that extracts one line for every loop until finding the end of
# file
while (my $line = <FH>) {

    # Deletes the new line characters from the line
    chomp $line;

    # Gets the name for the result file
    my $out = $line;
    $out =~ s/^split\///;
    $out =~ s/\.faa$//;

    # Performs the hmmsearch for the FASTA file in turn
    print "--> Performing hmmsearch in file:\t\t$line\n";
    system("$hmmsearch $opt_p $line > multi/$out.hmms");
    print "==> hmmsearch results stored in file:\t\tmulti/$out.hmms\n";

    # Prints the result file name into the new INDEX file if the
    # option was given
    print HMMSINDEX "multi/$out.hmms\n" if $opt_i;
}

# Closes INDEX files
close(FH);
if ($opt_i) {
    print "==> New INDEX stored in file:\t\t\t$index_file\n";
    close(HMMSINDEX);
}

# Exits the program
exit();
