# $Id: Config.pm kortsch $
#
# BioPerl module for Bio::Tools::Run::Bowtie::Config
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Dan Kortschak <dan.kortschak@adelaide.edu.au>
#
# Copyright Dan Kortschak and Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Bowtie::Config - Configuration data for bowtie commands

=head1 SYNOPSIS

Used internally by L<Bio::Tools::Run::Bowtie>.

=head1 DESCRIPTION

This package exports information describing bowtie commands, parameters,
switches, and input and output filetypes for individual bowtie commands.

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

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::Bowtie::Config;
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
             %incompat_params
             %corequisite_switches
             %param_translation
             %command_files
             %accepted_types
            );

@EXPORT_OK = qw();



our @program_commands = qw(
    single
    paired
    crossbow
    build
    inspect
);


our %command_executables = (
    'single'     => 'bowtie',
    'paired'     => 'bowtie',
    'crossbow'   => 'bowtie',
    'build'      => 'bowtie-build',
    'inspect'    => 'bowtie-inspect'
    );

# These should be in clobbering order - more delicate formats first
our %format_lookup = (
    'sam_format'       => 'sam',
    'refidx'           => 'bowtie',
    'concise'          => undef,
    'suppress_columns' => undef,
    'refout'           => undef
    );


# composite commands: pseudo-commands that run a 
# sequence of commands
# composite command prefix => list of prefixes of commands this
#  composite command runs
#

our %composite_commands = (
    );

# prefixes only for commands that take params/switches...
our %command_prefixes = (
    'single'     => 'one',
    'paired'     => 'par',
    'crossbow'   => 'crb',
    'build'      => 'bld',
    'inspect'    => 'ins'
    );

our @program_params = qw(
    command
    one|qualities
    one|skip
    one|upto
    one|trim5
    one|trim3
    one|max_seed_mismatches
    one|max_qual_mismatch
    one|max_quality_sum
    one|snp_penalty
    one|snp_frac
    one|seed_length
    one|max_mismatches
    one|max_backtracks
    one|max_search_ram
    one|report_n_alignments
    one|supress
    one|supress_random
    one|offset_base
    one|defaul_mapq
    one|sam_rg
    one|suppress_columns
    one|alignmed_file
    one|unaligned_file
    one|excess_file
    one|threads
    one|offrate
    one|random_seed

    par|qualities1
    par|qualities2
    par|min_insert_size
    par|max_insert_size
    par|max_mate_attempts

    bld|max_bucket_block
    bld|max_bucket_div
    bld|diff_cover
    bld|off_rate
    bld|ftabchars

    bld|seed
    bld|cutoff

    ins|seq_width
);

our @program_switches = qw(
    one|fastq
    one|fasta
    one|raw
    one|inline
    one|color_space
    one|phred33
    one|phred64
    one|solexa
    one|solexa1_3
    one|integer_qual
    one|no_maq_rounding
    one|no_forward_alignment
    one|no_reverse_alignment
    one|try_hard
    one|all
    one|best
    one|strata
    one|fix_strand_bias
    one|print_color
    one|color_quals
    one|color_keep_ends
    one|sam_format
    one|sam_no_head
    one|sam_no_sq
    one|concise
    one|time
    one|be_quiet
    one|ref_map
    one|ref_index
    one|full_ref_name
    one|memory_mapped_io
    one|shared_memory

    par|forward_reverse
    par|reverse_reverse
    par|forward_forward

    bld|fasta
    bld|inline
    bld|color_space
    bld|both
    bld|no_auto
    bld|packed
    bld|no_diff_cover
    bld|no_ref
    bld|just_ref
    bld|NtoA
    bld|big_endian
    bld|little_endian

    ins|names_only
    ins|summary
    ins|reconstruct
);

# be careful of collisions here - this could do with command specification
our %incompat_params = (
    qualities                => [qw( qualities1 qualities2 )],
    qualities1               => [qw( qualities )],
    qualities2               => [qw( qualities )],
    max_seed_mismatches      => [qw( max_mismatches )],
    max_mismatches           => [qw( max_seed_mismatches )],
    fastq                    => [qw( fasta raw inline )],
    fasta                    => [qw( fastq raw inline )],
    raw                      => [qw( fastq fasta inline )],
    inline                   => [qw( fastq fasta raw )],
    phred33                  => [qw( phred64 solexa solexa1_3 integer_qual )],
    phred64                  => [qw( phred33 solexa solexa1_3 integer_qual )],
    solexa                   => [qw( phred33 phred64 solexa1_3 integer_qual )],
    solexa1_3                => [qw( phred33 phred64 solexa integer_qual )],
    integer_qual             => [qw( phred33 phred64 solexa solexa1_3 )],
    no_forward_alignment     => [qw( no_reverse_alignment )],
    no_reverse_alignment     => [qw( no_forward_alignment )],
    all                      => [qw( report_n_alignments )],
    report_n_alignments      => [qw( all )],
    forward_reverse          => [qw( reverse_reverse forward_forward )],
    reverse_reverse          => [qw( forward_reverse forward_forward )],
    forward_forward          => [qw( reverse_reverse forward_forward )],
    color_space              => [qw( both )],
    both                     => [qw( color_space)]
);

our %corequisite_switches = (
    qualities1               => [qw( qualities2 )],
    qualities2               => [qw( qualities1 )],
    strata                   => [qw( best )],
    suppress_random          => [qw( best )],
    snp_penalty              => [qw( color_space )],
    snp_frac                 => [qw( color_space )],
    print_color              => [qw( color_space )],
    color_quals              => [qw( color_space )],
    color_keep_ends          => [qw( color_space )],
    defaul_mapq              => [qw( sam_format )],
    sam_no_head              => [qw( sam_format )],
    sam_no_sq                => [qw( sam_format )],
    sam_rg                   => [qw( sam_format )]
);



our %param_translation = (
    'one|fastq'                    => 'q',
    'one|fasta'                    => 'f',
    'one|raw'                      => 'r',
    'one|inline'                   => 'c',
    'one|color_space'              => 'C',
    'one|qualities'                => 'Q',
    'one|skip'                     => 's',
    'one|upto'                     => 'u',
    'one|trim5'                    => '5',
    'one|trim3'                    => '3',
    'one|phred33'                  => 'phred33-quals',
    'one|phred64'                  => 'phred64-quals',
    'one|solexa'                   => 'solexa-quals',
    'one|solexa1_3'                => 'solexa1.3-quals',
    'one|integer_qual'             => 'integer-quals',
    'one|max_seed_mismatches'      => 'n',
    'one|max_qual_mismatch'        => 'e',
    'one|seed_length'              => 'l',
    'one|no_maq_rounding'          => 'nomaqround',
    'one|max_mismatches'           => 'v',
    'one|no_forward_alignment'     => 'nofw',
    'one|no_reverse_alignment'     => 'norc',
    'one|max_backtracks'           => 'maxbts',
    'one|try_hard'                 => 'y',
    'one|max_search_ram'           => 'chunkmbs',
    'one|report_n_alignments'      => 'k',
    'one|all'                      => 'a',
    'one|supress'                  => 'm',
    'one|supress_random'           => 'M',
    'one|best'                     => 'best',
    'one|strata'                   => 'strata',
    'one|snp_penalty'              => 'snpphred',
    'one|snp_frac'                 => 'snpfrac',
    'one|print_color'              => 'col-cseq',
    'one|color_quals'              => 'colc-cqual',
    'one|color_keep_ends'          => 'col-keepends',
    'one|sam_format'               => 'S',
    'one|defaul_mapq'              => 'mapq',
    'one|sam_no_head'              => 'sam_nohead',
    'one|sam_no_sq'                => 'sam_nosq',
    'one|sam_rg'                   => 'sam-RG',
    'one|suppress_columns'         => 'suppress',
    'one|time'                     => 't',
    'one|offset_base'              => 'B',
    'one|be_quiet'                 => 'quiet',
    'one|ref_map'                  => 'refout',
    'one|ref_index'                => 'refidx',
    'one|alignmed_file'            => 'al',
    'one|unaligned_file'           => 'un',
    'one|excess_file'              => 'max',
    'one|full_ref_name'            => 'fullref',
    'one|threads'                  => 'p',
    'one|offrate'                  => 'o',
    'one|memory_mapped_io'         => 'mm',
    'one|shared_memory'            => 'shmem',
    'one|random_seed'              => 'seed',
    'one|version'                  => 'version',

    'par|fastq'                    => 'q',
    'par|fasta'                    => 'f',
    'par|raw'                      => 'r',
    'par|inline'                   => 'c',
    'par|color_space'              => 'C',
    'par|qualities'                => 'Q', # Don't know if bowtie will accept this - won't break if left in
    'par|qualities1'               => 'Q1',
    'par|qualities2'               => 'Q2',
    'par|skip'                     => 's',
    'par|upto'                     => 'u',
    'par|trim5'                    => '5',
    'par|trim3'                    => '3',
    'par|phred33'                  => 'phred33-quals',
    'par|phred64'                  => 'phred64-quals',
    'par|solexa'                   => 'solexa-quals',
    'par|solexa1_3'                => 'solexa1.3-quals',
    'par|integer_qual'             => 'integer-quals',
    'par|max_seed_mismatches'      => 'n',
    'par|max_qual_mismatch'        => 'e',
    'par|seed_length'              => 'l',
    'par|no_maq_rounding'          => 'nomaqround',
    'par|max_mismatches'           => 'v',
    'par|min_insert_size'          => 'I',
    'par|max_insert_size'          => 'X',
    'par|forward_reverse'          => 'fr',
    'par|reverse_forward'          => 'rf',
    'par|forward_forward'          => 'ff',
    'par|no_forward_alignment'     => 'nofw',
    'par|no_reverse_alignment'     => 'norc',
    'par|max_backtracks'           => 'maxbts',
    'par|max_mate_attempts'        => 'pairtries',
    'par|try_hard'                 => 'y',
    'par|max_search_ram'           => 'chunkmbs',
    'par|report_n_alignments'      => 'k',
    'par|all'                      => 'a',
    'par|suppress'                 => 'm',
    'par|suppress_random'          => 'M',
    'par|best'                     => 'best',
    'par|strata'                   => 'strata',
    'par|snp_penalty'              => 'snpphred',
    'par|snp_frac'                 => 'snpfrac',
    'par|print_color'              => 'col-cseq',
    'par|color_quals'              => 'colc-cqual',
    'par|color_keep_ends'          => 'col-keepends',
    'par|sam_format'               => 'S',
    'par|defaul_mapq'              => 'mapq',
    'par|sam_no_head'              => 'sam_nohead',
    'par|sam_no_sq'                => 'sam_nosq',
    'par|sam_rg'                   => 'sam-RG',
    'par|suppress_columns'         => 'suppress',
    'par|time'                     => 't',
    'par|offset_base'              => 'B',
    'par|be_quiet'                 => 'quiet',
    'par|ref_map'                  => 'refout',
    'par|ref_index'                => 'refidx',
    'par|alignmed_file'            => 'al',
    'par|unaligned_file'           => 'un',
    'par|excess_file'              => 'max',
    'par|full_ref_name'            => 'fullref',
    'par|threads'                  => 'p',
    'par|offrate'                  => 'o',
    'par|memory_mapped_io'         => 'mm',
    'par|shared_memory'            => 'shmem',
    'par|random_seed'              => 'seed',
    'par|version'                  => 'version',

    'crb|fastq'                    => 'q',
    'crb|fasta'                    => 'f',
    'crb|raw'                      => 'r',
    'crb|inline'                   => 'c',
    'crb|color_space'              => 'C',
    'crb|qualities'                => 'Q',
    'crb|skip'                     => 's',
    'crb|upto'                     => 'u',
    'crb|trim5'                    => '5',
    'crb|trim3'                    => '3',
    'crb|phred33'                  => 'phred33-quals',
    'crb|phred64'                  => 'phred64-quals',
    'crb|solexa'                   => 'solexa-quals',
    'crb|solexa1_3'                => 'solexa1.3-quals',
    'crb|integer_qual'             => 'integer-quals',
    'crb|max_seed_mismatches'      => 'n',
    'crb|max_qual_mismatch'        => 'e',
    'crb|seed_length'              => 'l',
    'crb|no_maq_rounding'          => 'nomaqround',
    'crb|max_mismatches'           => 'v',
    'crb|min_insert_size'          => 'I',
    'crb|max_insert_size'          => 'X',
    'crb|forward_reverse'          => 'fr',
    'crb|reverse_forward'          => 'rf',
    'crb|forward_forward'          => 'ff',
    'crb|no_forward_alignment'     => 'nofw',
    'crb|no_reverse_alignment'     => 'norc',
    'crb|max_backtracks'           => 'maxbts',
    'crb|max_mate_attempts'        => 'pairtries',
    'crb|try_hard'                 => 'y',
    'crb|max_search_ram'           => 'chunkmbs',
    'crb|report_n_alignments'      => 'k',
    'crb|all'                      => 'a',
    'crb|suppress'                 => 'm',
    'crb|suppress_random'          => 'M',
    'crb|best'                     => 'best',
    'crb|strata'                   => 'strata',
    'crb|snp_penalty'              => 'snpphred',
    'crb|snp_frac'                 => 'snpfrac',
    'crb|print_color'              => 'col-cseq',
    'crb|color_quals'              => 'colc-cqual',
    'crb|color_keep_ends'          => 'col-keepends',
    'crb|sam_format'               => 'S',
    'crb|defaul_mapq'              => 'mapq',
    'crb|sam_no_head'              => 'sam_nohead',
    'crb|sam_no_sq'                => 'sam_nosq',
    'crb|sam_rg'                   => 'sam-RG',
    'crb|suppress_columns'         => 'suppress',
    'crb|time'                     => 't',
    'crb|offset_base'              => 'B',
    'crb|be_quiet'                 => 'quiet',
    'crb|ref_map'                  => 'refout',
    'crb|ref_index'                => 'refidx',
    'crb|alignmed_file'            => 'al',
    'crb|unaligned_file'           => 'un',
    'crb|excess_file'              => 'max',
    'crb|full_ref_name'            => 'fullref',
    'crb|threads'                  => 'p',
    'crb|offrate'                  => 'o',
    'crb|memory_mapped_io'         => 'mm',
    'crb|shared_memory'            => 'shmem',
    'crb|random_seed'              => 'seed',
    'crb|version'                  => 'version',

    'bld|fasta'                    => 'f',
    'bld|inline'                   => 'c',
    'bld|color_space'              => 'C',
    'bld|both'                     => 'B',
    'bld|no_auto'                  => 'a',
    'bld|packed'                   => 'p',
    'bld|max_bucket_block'         => 'bmax',
    'bld|max_bucket_div'           => 'bmaxdivn',
    'bld|diff_cover'               => 'dcv',
    'bld|no_diff_cover'            => 'nodc',
    'bld|no_ref'                   => 'r',
    'bld|just_ref'                 => '3',
    'bld|off_rate'                 => 'o',
    'bld|ftabchars'                => 't',
    'bld|NtoA'                     => 'ntoa',
    'bld|big_endian'               => 'big',
    'bld|little_endian'            => 'little',
    'bld|seed'                     => 'seed',
    'bld|cutoff'                   => 'cutoff',
    'bld|version'                  => 'version',

    'ins|seq_width'                => 'a',
    'ins|names_only'               => 'n',
    'ins|summary'                  => 's',
    'ins|reconstruct'              => 'e',
    'ins|version'                  => 'version'
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
    'single'     => [qw( ind seq #out )],
    'paired'     => [qw( ind -1|seq -2|seq2 #out )],
    'crossbow'   => [qw( ind -12|seq #out )],
    'build'      => [qw( ref #out )],
    'inspect'    => [qw( ind >#out )]
    );

our %accepted_types = ( # ind is not a single file, so not included here
    'seq'        => [qw( fasta fastq raw crossbow )],
    'seq2'       => [qw( fasta fastq raw )],
    'ref'        => [qw( fasta )]
    );

foreach (@program_params) {
        push @program_params, "par\|".$1 if (m/^one\|(.*)/);
        push @program_params, "crb\|".$1 if (m/^par\|(.*)/) && !(m/^par\|(?:fasta|fastq|raw|qualities[12])/);
}
foreach (@program_switches) {
        push @program_switches, "par\|".$1 if (m/^one\|(.*)/);
        push @program_switches, "crb\|".$1 if (m/^par\|(.*)/) && !(m/^par\|(?:fasta|fastq|raw)/);
}

1;
