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

This package exports information describing maq commands, parameters,
switches, and input and output filetypes for individual maq commands.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org <mailto:bioperl-l@bioperl.org>                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org <mailto:bioperl-l@bioperl.org>>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Mark A. Jensen

Email maj@fortinbras.us <mailto:maj@fortinbras.us>

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
use base qw(Bio::Root::Root );

our (@ISA, @EXPORT, @EXPORT_OK);
push @ISA, 'Exporter';
@EXPORT = qw(
             @program_commands
             %command_prefixes
             %composite_commands
             @program_params
             @program_switches
             %param_translation
             %command_files
            );

@EXPORT_OK = qw();



our @program_commands = qw(
    single
    paired
); #crossbow format not implemented yet - will attempt when I see what it looks like

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
    'paired'     => 'par'
    );

our @program_params = qw(
    command
    one|skip
    one|upto
    one|trim5
    one|trim3
    one|max_seed_mismatches
    one|max_qual_mismatch
    one|max_quality_sum
    one|seed_length
    one|max_mismatches
    one|max_backtracks
    one|max_search_ram
    one|report_n_alignments
    one|supress
    one|offset_base
    one|alignmed_file
    one|unaligned_file
    one|excess_file
    one|threads
    one|offrate
    one|random_seed
    par|min_insert_size
    par|max_insert_size
    par|max_mate_attempts
    );

our @program_switches = qw(
    one|fastq
    one|fasta
    one|raw
    one|inline
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
    one|sam_format
    one|concise
    one|time
    one|quiet
    one|ref_map
    one|ref_index
    one|full_ref_name
    one|memory_mapped_io
    one|shared_memory
    par|forward_reverse
    par|reverse_reverse
    par|forward_forward
);

our %param_translation = (
    'one|fastq'                    => 'q',
    'one|fasta'                    => 'f',
    'one|raw'                      => 'r',
    'one|inline'                   => 'c',
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
    'one|max_quality_sum'          => 'Q',
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
    'one|best'                     => 'best',
    'one|strata'                   => 'strata',
    'one|fix_strand_bias'          => 'strandfix',
    'one|sam_format'               => 'S',
    'one|concise'                  => 'concise',
    'one|time'                     => 't',
    'one|offset_base'              => 'B',
    'one|quiet'                    => 'quiet',
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

    'par|fastq'                    => 'q',
    'par|fasta'                    => 'f',
    'par|raw'                      => 'r',
    'par|inline'                   => 'c',
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
    'par|max_quality_sum'          => 'Q',
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
    'par|supress'                  => 'm',
    'par|best'                     => 'best',
    'par|strata'                   => 'strata',
    'par|fix_strand_bias'          => 'strandfix',
    'par|sam_format'               => 'S',
    'par|concise'                  => 'concise',
    'par|time'                     => 't',
    'par|offset_base'              => 'B',
    'par|quiet'                    => 'quiet',
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
    'par|random_seed'              => 'seed'
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
    'single'     => [qw( ind seq out )],
    'paired'     => [qw( ind seq seq2 out )]
    ); #crossbow format not implemented yet - will attempt when I see what it looks like

INIT {
	# bowtie doesn't really have subprograms so we do it this way
	foreach (@program_params) {
		push @program_params, "par\|".$1 if (m/^one\|(.*)/);
	}
	foreach (@program_switches) {
		push @program_switches, "par\|".$1 if (m/^one\|(.*)/);
	}
	
#	# add subcommand params and switches for
#	# composite commands
#	my @sub_params;
#	my @sub_switches;
#	foreach my $cmd (keys %composite_commands) {
#		foreach my $subcmd ( @{$composite_commands{$cmd}} ) {
#			my @sub_program_params = grep /^$subcmd\|/, @program_params;
#			my @sub_program_switches = grep /^$subcmd\|/, @program_switches;
#			for (@sub_program_params) {
#				m/^$subcmd\|(.*)/;
#				push @sub_params, "$cmd\|${subcmd}_".$1;
#			}
#			for (@sub_program_switches) {
#				m/^$subcmd\|(.*)/;
#				push @sub_switches, "$cmd\|${subcmd}_".$1;
#			}
#		}
#	}
#	push @program_params, @sub_params;
#	push @program_switches, @sub_switches;
#	# translations for subcmd params/switches not necessary
}

1;