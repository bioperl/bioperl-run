#!/usr/bin/perl -w
use strict;

=head1 NAME

run_neighbor - run Phylip's 'neighbor' program through Bioperl 

=head1 SYNOPSIS

run_neighbor [-i inputfile] [-o outfilename]

=head1 DESCRIPTION

Provide an matrix file to run neighbor on.  File should be named of
the forma file.matrix or file.protdist (the ending doesn't matter, but
the program expects a file in the form of (\S+)\.(\S+).

This will run the application 'neighbor' to build a 
Neighbor-Joining tree from a protein distance matrix.

=head1 AUTHOR

Jason Stajich, jason-AT-open-bio-DOT-org

=cut

use Bio::TreeIO;
use Bio::Tools::Run::Phylo::Phylip::Neighbor;
use Getopt::Long;

my @params = ('type'=>'NJ', 'quiet' => 1);

my $matrixfile;
my $out;
GetOptions(
	   'i|input:s' => \$matrixfile,
	   'o|out:s'   => \$out,
	   'h|help'    => sub { exec('perldoc',$0); exit(0) }
	   );
($matrixfile) ||= shift @ARGV;

my ($stem,$ext) = ($matrixfile =~ /(\S+)\.(\S+)$/) ;
$stem ||= $matrixfile;

my $outfh;
if( $out ) {
    open($outfh, ">$out") || die($!);
} else { 
    open($outfh, ">$stem.tree") || die($!);
}

my $tree_factory = Bio::Tools::Run::Phylo::Phylip::Neighbor->new(@params);
my (@trees) = $tree_factory->create_tree($matrixfile);

my $outtree = new Bio::TreeIO(-fh => $outfh);
foreach my $tree ( @trees ){
    $outtree->write_tree($tree);
}
