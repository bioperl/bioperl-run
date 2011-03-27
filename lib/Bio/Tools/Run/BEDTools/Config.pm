# $Id: Config.pm kortsch $
#
# BioPerl module for Bio::Tools::Run::BEDTools::Config
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Dan Kortschak <dan.kortschak@adelaide.edu.au>
#
# Copyright Dan Kortschak
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::BEDTools::Config - Configuration data for bowtie commands

=head1 SYNOPSIS

Used internally by L<Bio::Tools::Run::BEDTools>.

=head1 DESCRIPTION

This package exports information describing BEDTools commands, parameters,
switches, and input and output filetypes for individual BEDTools commands.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

bioperl-l@bioperl.org                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Dan Kortschak

Email dan.kortschak adelaide.edu.au

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::BEDTools::Config;
use strict;
use warnings;
no warnings qw(qw);
use Bio::Root::Root;
use Exporter;
use base qw(Bio::Root::Root);

our (@ISA, @EXPORT, @EXPORT_OK);
push @ISA, 'Exporter';
@EXPORT = qw(
             @program_commands
             %command_executables
             %format_lookup
             %command_prefixes
             %composite_commands
             @program_params
             @program_switches
             %param_translation
             %command_files
             %accepted_types
            );

@EXPORT_OK = qw();



our @program_commands = qw(
    bam_to_bed       fasta_from_bed       mask_fasta_from_bed  shuffle              window
    closest          genome_coverage      merge                slop
    complement       intersect            pair_to_bed          sort
    coverage         links                pair_to_pair         subtract
);


our %command_executables = (
    'bam_to_bed'           => 'bamToBed',
    'fasta_from_bed'       => 'fastaFromBed',
    'mask_fasta_from_bed'  => 'maskFastaFromBed',
    'shuffle'              => 'shuffleBed',
    'window'               => 'windowBed',
    'closest'              => 'closestBed',
    'genome_coverage'      => 'genomeCoverageBed',
    'merge'                => 'mergeBed',
    'slop'                 => 'slopBed',
    'complement'           => 'complementBed',
    'intersect'            => 'intersectBed',
    'pair_to_bed'          => 'pairToBed',
    'sort'                 => 'sortBed',
    'coverage'             => 'coverageBed',
    'links'                => 'linksBed',
    'pair_to_pair'         => 'pairToPair',
    'subtract'             => 'subtractBed'
    );

our %format_lookup = (
    'bam_to_bed'           => 'bed',
    'fasta_from_bed'       => 'fasta',
    'mask_fasta_from_bed'  => 'fasta',
    'shuffle'              => 'bed',
    'window'               => 'bedpe',
    'closest'              => 'bedpe',
    'genome_coverage'      => 'tab',
    'merge'                => 'bed',
    'slop'                 => 'bed',
    'complement'           => 'bed',
    'intersect'            => 'bed|bam',
    'pair_to_bed'          => 'bedpe|bam',
    'sort'                 => 'bed',
    'coverage'             => 'bed',
    'links'                => 'html',
    'pair_to_pair'         => 'bedpe',
    'subtract'             => 'bed'
    );


# composite commands: pseudo-commands that run a 
# sequence of commands
# composite command prefix => list of prefixes of commands this
# composite command runs
#

our %composite_commands = (
    );

# prefixes only for commands that take params/switches...
our %command_prefixes = (
    'bam_to_bed'           => 'btb',
    'fasta_from_bed'       => 'ffb',
    'mask_fasta_from_bed'  => 'mfb',
    'shuffle'              => 'shb',
    'window'               => 'wib',
    'closest'              => 'clb',
    'genome_coverage'      => 'gcb',
    'merge'                => 'meb',
    'slop'                 => 'slb',
    'complement'           => 'cob',
    'intersect'            => 'inb',
    'pair_to_bed'          => 'ptb',
    'sort'                 => 'sob',
    'coverage'             => 'cvb',
    'links'                => 'lib',
    'pair_to_pair'         => 'ptp',
    'subtract'             => 'sub'
    );

our @program_params = qw(
    command
    
    shb|exclude
    shb|seed
    
    wib|window_size
    wib|left_window_size
    wib|right_window_size
    
    clb|ties_policy
    
    gcb|max_depth
    
    meb|max_distance
    
    slb|add_bidirectional
    slb|add_to_left
    slb|add_to_right
    
    inb|minimum_overlap
    
    ptb|minimum_overlap
    ptb|type
    
    ptp|minimum_overlap
    ptp|type
    
    sub|minimum_overlap

    lib|basename
    lib|organism
    lib|genome_build
    );

our @program_switches = qw(
    btb|write_bedpe
    btb|use_edit_distance
    
    ffb|use_bed_name
    ffb|output_tab_format
    
    mfb|soft_mask
    
    shb|keep_chromosome
    
    wib|define_by_strand
    wib|same_strand
    wib|report_once_only
    wib|report_hits
    wib|invert
    
    clb|strandedness
    
    gcb|report_pos_depth
    
    meb|strandedness
    meb|report_n_merged
    meb|report_names_merged
    
    slb|define_by_strand
    
    inb|write_bed
    inb|write_entry_1
    inb|write_entry_2
    inb|report_once_only
    inb|report_n_hits
    inb|invert_match
    inb|reciprocal
    inb|strandedness
    
    ptb|write_bedpe
    ptb|strandedness
    
    sob|size_asc
    sob|size_desc
    sob|chr_size_asc
    sob|chr_size_desc
    sob|chr_score_asc
    sob|chr_score_desc
    
    cvb|strandedness
    
    ptp|ignore_strand
    
    sub|strandedness
    );

our %param_translation = (
    'btb|write_bedpe'              => 'bedpe',
    'btb|use_edit_distance'        => 'ed',
    
    'ffb|use_bed_name'             => 'names',
    'ffb|output_tab_format'        => 'tab',
    
    'mfb|soft_mask'                => 'soft',
    
    'shb|keep_chromosome'          => 'chrom',
    'shb|exclude'                  => 'excl',
    'shb|seed'                     => 'seed',
    
    'wib|define_by_strand'         => 'sw',
    'wib|same_strand'              => 'sm',
    'wib|report_once_only'         => 'u',
    'wib|report_hits'              => 'c',
    'wib|invert'                   => 'v',
    'wib|window_size'              => 'w',
    'wib|left_window_size'         => 'l',
    'wib|right_window_size'        => 'r',
    
    'clb|strandedness'             => 's',
    'clb|ties_policy'              => 't',
    
    'gcb|report_pos_depth'         => 'd',
    'gcb|max_depth'                => 'max',
    
    'meb|strandedness'             => 's',
    'meb|report_n_merged'          => 'n',
    'meb|report_names_merged'      => 'nms',
    'meb|max_distance'             => 'd',
    
    'slb|define_by_strand'         => 's',
    'slb|add_bidirectional'        => 'b',
    'slb|add_to_left'              => 'l',
    'slb|add_to_right'             => 'r',
    
    'inb|write_bed'                => 'bed',
    'inb|write_entry_1'            => 'wa',
    'inb|write_entry_2'            => 'wb',
    'inb|report_once_only'         => 'u',
    'inb|report_n_hits'            => 'c',
    'inb|invert_match'             => 'v',
    'inb|reciprocal'               => 'r',
    'inb|strandedness'             => 's',
    'inb|minimum_overlap'          => 'f',
    
    'ptb|write_bedpe'              => 'bedpe',
    'ptb|strandedness'             => 's',
    'ptb|minimum_overlap'          => 'f',
    'ptb|type'                     => 'type',
    
    'sob|size_asc'                 => 'sizeA',
    'sob|size_desc'                => 'sizeD',
    'sob|chr_size_asc'             => 'chrThenSizeA',
    'sob|chr_size_desc'            => 'chrThenSizeD',
    'sob|chr_score_asc'            => 'chrThenScoreA',
    'sob|chr_score_desc'           => 'chrThenScoreD',
    
    'cvb|strandedness'             => 's',
    
    'ptp|ignore_strand'            => 'is',
    'ptp|minimum_overlap'          => 'f',
    'ptp|type'                     => 'type',
    
    'sub|strandedness'             => 's',
    'sub|minimum_overlap'          => 'f',

    'lib|basename'                 => 'base',
    'lib|organism'                 => 'org',
    'lib|genome_build'             => 'db'
    );

#
# the order in the arrayrefs is the order required
# on the command line
#
# the strings in the arrayrefs (less special chars)
# become the keys for named parameters to run_bowtie
# 
# special chars:
#
# '#' implies optional
# '*' implies variable number of this type
# <|> implies stdin/stdout redirect
#

our %command_files = (
    'bam_to_bed'           => [qw( -i|bam >#out )],
    'fasta_from_bed'       => [qw( -fi|seq -bed|bed -fo|#out )],
    'mask_fasta_from_bed'  => [qw( -fi|seq -bed|bed -fo|#out )],
    'shuffle'              => [qw( -i|bed -g|genome >#out )],
    'window'               => [qw( -a|bed1 -b|bed2 >#out )],
    'closest'              => [qw( -a|bed1 -b|bed2 >#out )],
    'genome_coverage'      => [qw( -i|bed -g|genome >#out )],
    'merge'                => [qw( -i|bed >#out )],
    'slop'                 => [qw( -i|bed -g|genome >#out )],
    'complement'           => [qw( -i|bed -g|genome >#out )],
    'intersect'            => [qw( -a|#bed1 -abam|#bam -b|bed2 >#out )], # (bed1|bam) required
    'pair_to_bed'          => [qw( -a|#bedpe -abam|#bam -b|bed >#out )], # (bedpe|bam) required
    'sort'                 => [qw( -i|bed >#out )],
    'coverage'             => [qw( -a|bed1 -b|bed2 >#out )],
    'links'                => [qw( -i|bed >#out )],
    'pair_to_pair'         => [qw( -a|bedpe1 -b|bedpe2 >#out )],
    'subtract'             => [qw( -a|bed1 -b|bed2 >#out )]
    );

our %accepted_types = (
    'bam'        => [qw()],       # we need a test for this
    'bed'        => [qw( tab )],
    'bed1'       => [qw( tab )],
    'bed2'       => [qw( tab )],
    'bedpe'      => [qw( tab )],
    'bedpe1'     => [qw( tab )],
    'bedpe2'     => [qw( tab )],
    'seq'        => [qw( fasta )],
    'genome'     => [qw( tab )]
    );

1;
