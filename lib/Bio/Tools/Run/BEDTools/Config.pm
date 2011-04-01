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
    annotate         fasta_from_bed       overlap              
    bam_to_bed       genome_coverage      pair_to_pair         
    bed_to_bam       graph_union          pair_to_bed          
    bed_to_IGV       group_by             shuffle              
    b12_to_b6        intersect            slop                 
    closest          links                sort                 
    complement       mask_fasta_from_bed  subtract             
    coverage         merge                window               
);


our %command_executables = (
    'annotate'             => 'annotateBed',
    'bam_to_bed'           => 'bamToBed',
    'bed_to_bam'           => 'bedToBam',
    'bed_to_IGV'           => 'bedToIgv',
    'b12_to_b6'            => 'bed12ToBed6',
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
    'subtract'             => 'subtractBed',
    'overlap'              => 'overlap',
    'group_by'             => 'groupBy',
    'graph_union'          => 'unionBedGraphs'
    );

our %format_lookup = (
    'annotate'             => 'bed',
    'bam_to_bed'           => 'bed',
    'bed_to_bam'           => 'bam',
    'bed_to_IGV'           => 'igv',
    'b12_to_b6'            => 'bed',
    'closest'              => 'bedpe',
    'complement'           => 'bed',
    'coverage'             => 'bed',
    'fasta_from_bed'       => 'fasta',
    'genome_coverage'      => 'tab',
    'graph_union'          => 'bg',
    'group_by'             => 'bed',
    'intersect'            => 'bed|bam',
    'links'                => 'html',
    'mask_fasta_from_bed'  => 'fasta',
    'merge'                => 'bed',
    'overlap'              => 'bed',
    'pair_to_bed'          => 'bedpe|bam',
    'pair_to_pair'         => 'bedpe',
    'slop'                 => 'bed',
    'shuffle'              => 'bed',
    'sort'                 => 'bed',
    'subtract'             => 'bed',
    'window'               => 'bedpe'
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
    'annotate'             => 'ann',
    'bam_to_bed'           => 'ate',
    'bed_to_bam'           => 'eta',
    'bed_to_IGV'           => 'eti',
    'b12_to_b6'            => '126',
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
    'subtract'             => 'sub',
    'overlap'              => 'ove',
    'group_by'             => 'grp',
    'graph_union'          => 'ubg'
    );

our @program_params = qw(
    command
    
    ate|tag
    ate|color
    
    eta|quality
    
    eti|path
    eti|session
    eti|sort
    eti|slop
    eti|image
    
    shb|exclude
    shb|seed
    
    wib|window_size
    wib|left_window_size
    wib|right_window_size
    
    clb|ties_policy
    
    gcb|max_depth
    gcb|strand
    
    meb|max_distance
    
    slb|add_bidirectional
    slb|add_to_left
    slb|add_to_right
    
    inb|minimum_overlap
    
    ptb|minimum_overlap
    ptb|type
    
    ptp|minimum_overlap
    ptp|type
    ptp|slop
    
    sub|minimum_overlap
    
    lib|basename
    lib|organism
    lib|genome_build
    
    ove|columns
    
    grp|group
    grp|columns
    grp|operations
    
    ubg|names
    ubg|filler
    );

our @program_switches = qw(
    ann|names
    ann|count
    ann|both
    ann|strandedness
    
    ate|write_bedpe
    ate|use_edit_distance
    ate|bam12
    ate|split
    ate|use_edit_distance
    ate|cigar
    
    eta|uncompressed
    eta|bed12
    
    eti|collapse
    eti|name
    
    ffb|use_bed_name
    ffb|output_tab_format
    ffb|strandedness
    
    gcb|bedgraph
    gcb|bedgraph_all
    gcb|split
    
    mfb|soft_mask
    
    shb|keep_chromosome
    
    wib|define_by_strand
    wib|same_strand
    wib|report_once_only
    wib|report_hits
    wib|invert
    
    clb|strandedness
    clb|report_distance
    
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
    inb|write_overlap
    inb|write_overlap_all
    inb|split
    
    ptb|write_bedpe
    ptb|strandedness
    ptb|use_edit_distance
    ptb|write_uncompressed
    
    sob|size_asc
    sob|size_desc
    sob|chr_size_asc
    sob|chr_size_desc
    sob|chr_score_asc
    sob|chr_score_desc
    
    cvb|strandedness
    cvb|histogram
    cvb|depth
    cvb|split
    
    ptp|ignore_strand
    ptp|slop_strandedness
    ptp|no_self_hits
    
    sub|strandedness
    
    ubg|header
    ubg|empty
    );

our %param_translation = (
    'ann|names'                    => 'names',
    'ann|counts'                   => 'counts',
    'ann|both'                     => 'both',
    'ann|strandedness'             => 's',
    
    'ate|write_bedpe'              => 'bedpe',
    'ate|use_edit_distance'        => 'ed',
    'ate|bam12'                    => 'bam12',
    'ate|split'                    => 'split',
    'ate|use_edit_distance'        => 'ed',
    'ate|tag'                      => 'tag',
    'ate|color'                    => 'color',
    'ate|cigar'                    => 'cigar',
    
    'eta|quality'                  => 'maqp',
    'eta|uncompressed'             => 'ubam',
    'eta|bed12'                    => 'bed12',
    
    'eti|path'                     => 'path',
    'eti|session'                  => 'sess',
    'eti|sort'                     => 'sort',
    'eti|collapse'                 => 'clps',
    'eti|name'                     => 'name',
    'eti|slop'                     => 'slop',
    'eti|image'                    => 'img',
    
    'ffb|use_bed_name'             => 'names',
    'ffb|output_tab_format'        => 'tab',
    'ffb|strandedness'             => 's',
    
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
    'clb|report_distance'          => 'd',
    'clb|ties_policy'              => 't',
    
    'gcb|report_pos_depth'         => 'd',
    'gcb|max_depth'                => 'max',
    'gcb|bedgraph'                 => 'bg',
    'gcb|bedgraph_all'             => 'bga',
    'gcb|split'                    => 'split',
    'gcb|strand'                   => 'strand',
    
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
    'inb|write_overlap'            => 'wo',
    'inb|write_overlap_all'        => 'woa',
    'inb|report_once_only'         => 'u',
    'inb|report_n_hits'            => 'c',
    'inb|invert_match'             => 'v',
    'inb|reciprocal'               => 'r',
    'inb|strandedness'             => 's',
    'inb|minimum_overlap'          => 'f',
    'inb|split'                    => 'split',
    
    'ptb|write_bedpe'              => 'bedpe',
    'ptb|strandedness'             => 's',
    'ptb|minimum_overlap'          => 'f',
    'ptb|type'                     => 'type',
    'ptb|use_edit_distance'        => 'ed',
    'ptb|write_uncompressed'       => 'ubam',
    
    'sob|size_asc'                 => 'sizeA',
    'sob|size_desc'                => 'sizeD',
    'sob|chr_size_asc'             => 'chrThenSizeA',
    'sob|chr_size_desc'            => 'chrThenSizeD',
    'sob|chr_score_asc'            => 'chrThenScoreA',
    'sob|chr_score_desc'           => 'chrThenScoreD',
    
    'cvb|strandedness'             => 's',
    'cvb|histogram'                => 'hist',
    'cvb|depth'                    => 'd',
    'cvb|split'                    => 'split',
    
    'ptp|ignore_strand'            => 'is',
    'ptp|slop_strandedness'        => 'ss',
    'ptp|minimum_overlap'          => 'f',
    'ptp|type'                     => 'type',
    'ptp|slop'                     => 'slop',
    'ptp|no_self_hits'             => 'rdn',
    
    'sub|strandedness'             => 's',
    'sub|minimum_overlap'          => 'f',

    'lib|basename'                 => 'base',
    'lib|organism'                 => 'org',
    'lib|genome_build'             => 'db',
    
    'ove|columns'                  => 'cols',
    
    'grp|group'                    => 'grp',
    'grp|columns'                  => 'opCols',
    'grp|operations'               => 'ops',
    
    'ubg|header'                   => 'header',
    'ubg|names'                    => 'names',
    'ubg|empty'                    => 'empty',
    'ubg|filler'                   => 'filler'
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
    'annotate'             => [qw( -i|bgv -files|*ann >#out )],
    'bam_to_bed'           => [qw( -i|bam >#out )],
    'bed_to_bam'           => [qw( -i|bgv -g|genome >#out )],
    'bed_to_IGV'           => [qw( -i|bgv >#out )],
    'b12_to_b6'            => [qw( -i|bed >#out )],
    'fasta_from_bed'       => [qw( -fi|seq -bed|bgv -fo|#out )],
    'mask_fasta_from_bed'  => [qw( -fi|seq -bed|bgv -fo|#out )],
    'shuffle'              => [qw( -i|bgv -g|genome >#out )],
    'window'               => [qw( -a|bgv1 -b|bgv2 >#out )],
    'closest'              => [qw( -a|bgv1 -b|bgv2 >#out )],
    'genome_coverage'      => [qw( -i|bed -g|genome >#out )],
    'merge'                => [qw( -i|bgv >#out )],
    'slop'                 => [qw( -i|bgv -g|genome >#out )],
    'complement'           => [qw( -i|bgv -g|genome >#out )],
    'intersect'            => [qw( -a|#bgv1 -abam|#bam -b|bgv2 >#out )], # (bgv1|bam) required
    'pair_to_bed'          => [qw( -a|#bedpe -abam|#bam -b|bgv >#out )], # (bedpe|bam) required
    'sort'                 => [qw( -i|bgv >#out )],
    'coverage'             => [qw( -a|bgv1 -b|bgv2 >#out )],
    'links'                => [qw( -i|bgv >#out )],
    'pair_to_pair'         => [qw( -a|bedpe1 -b|bedpe2 >#out )],
    'subtract'             => [qw( -a|bgv1 -b|bgv2 >#out )],
    'group_by'             => [qw( -i|bed >#out )],
    'graph_union'          => [qw( -i|*bg -g|#genome >#out )],
    'overlap'              => [qw( -i|bed >#out )]
    );

our %accepted_types = (
    'ann'        => [qw( tab vcf gff )], # BEDTools now has multiple accepted input formats: bed/gff/vcf
    'bam'        => [qw()],              # we need a test for this
    'bed'        => [qw( tab )],
    'bgv'        => [qw( tab vcf gff )], # BEDTools now has multiple accepted input formats: bed/gff/vcf
    'bgv1'       => [qw( tab vcf gff )], # BEDTools now has multiple accepted input formats: bed/gff/vcf
    'bgv2'       => [qw( tab vcf gff )], # BEDTools now has multiple accepted input formats: bed/gff/vcf
    'bedpe'      => [qw( tab )],
    'bedpe1'     => [qw( tab )],
    'bedpe2'     => [qw( tab )],
    'seq'        => [qw( fasta )],
    'genome'     => [qw( tab )],
    'bg'         => [qw( tab )]
    );

1;
