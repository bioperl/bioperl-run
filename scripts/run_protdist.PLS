#!/usr/bin/perl
use strict;
use warnings;

=head1 NAME

run_neighbor - run Phylip's 'protdist' program through Bioperl 

=head1 SYNOPSIS

run_protdist [-i inputfile] [-o outfilename]

=head1 DESCRIPTION

Provide an alignment file to run protdist on.  File should be named
either .aln or .phy.  This is required so that we can determine if we
need to convert a clustalw alignment into phylip.  You are welcome to
extend the script to work on other MSA formats which bioperl supports.
This is intended to be used in very simple manual pipelines.

The input file should be named in the form of file.phy or file.aln 
the program expects a file in the form of (\S+)\.(\S+).

This will run the application 'protdist' using the 'KIMURA' formula to
build a a protein distance matrix.  Those with phylip3.6 will want to
make some changes if they want to use JTT.  I'm happy to help add this
in as a cmd-line argument if it is requested.

=head1 AUTHOR

Jason Stajich, jason-AT-open-bio-DOT-org

=cut

use Bio::AlignIO;
use Bio::Tools::Run::Phylo::Phylip::ProtDist;
use Getopt::Long;

my @params = ( 'MODEL' => 'KIMURA',
	       'quiet' => 1,
	       );

my ($out,$file);

GetOptions(
	   'o|out:s'   => \$out,
	   'i|in:s'    =>  \$file,
	   'h|help'    => sub { exec('perldoc',$0); exit(0) }
	   );

($file) ||= shift @ARGV;

my ($stem,$ext) = ($file =~ /(\S+)\.(\S+)$/);
$stem ||= $file;

my $outfh;
if( $out ) {
    open($outfh, ">$out") || die($!);
} else { 
    open($outfh, ">$stem.matrix") || die($!);
}

if( $ext eq 'aln' ) {
    my $inaln = new Bio::AlignIO(-file => $file,
				-format => 'clustalw');
    $file = "$stem.phy";
    
    my $outreformat = new Bio::AlignIO(-file => ">$file",
				       -interleaved => 1,
				       -format => 'phylip');
    while( my $aln = $inaln->next_aln ) {
	$outreformat->write_aln($aln);
    }
    $outreformat->close();
    $outreformat = undef;
    $inaln       = undef;
}

my $factory = new Bio::Tools::Run::Phylo::Phylip::ProtDist(@params);
my (@matrix) = $factory->create_distance_matrix($file);

foreach my $mat ( @matrix ) {
    print $outfh $mat->print_matrix;
}

